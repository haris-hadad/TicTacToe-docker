<?php
$file = __DIR__ . '/results.json';

$data = json_decode(file_get_contents('php://input'), true);

if ($data) {
    $results = file_exists($file) ? json_decode(file_get_contents($file), true) : [];
    $results[] = $data;
    file_put_contents($file, json_encode($results, JSON_PRETTY_PRINT));
    echo json_encode(["status" => "success"]);
} else {
    http_response_code(400);
    echo json_encode(["status" => "error", "message" => "Données invalides"]);
}
?>