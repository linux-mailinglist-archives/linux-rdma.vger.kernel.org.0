Return-Path: <linux-rdma+bounces-3228-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BAA90B49D
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17EF61C22BCD
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2FB14EC74;
	Mon, 17 Jun 2024 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UGvoSd9A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB2014D2B4;
	Mon, 17 Jun 2024 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636947; cv=fail; b=MGils4JwUiy7j+l7quUUJJqhqe9nZf9In3MYjGHSETh01b/bhnQp3s25ldTQq5eTXo/sbG4DKehGa/uwpLjG1rkpjEA84eic3zjMQL0sEbg4xatLdqzq1YfoPUiIbezKEuSFxA0C7LtT1XX3w07xnq9U8pNbjDmorK3L2HS/vJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636947; c=relaxed/simple;
	bh=FtsotHAA5lLceyZuQEQ3YvMUsF62ghgO/lGhjb+y9SY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nCzq9EwBDpZLyBFOBiCGXyQC+4YO/ibsurP1MRZ38mP21GiBsAGTF6FJtHAUVYI9y8ArvF12m+RfA6Wc+ifAab/QFhvrUGiGeKr5kG68NPv2Bw19/czANt1tGYyQ9A7Qs8KXMrnFVQMynN0blX0uPH8/wj+XTd2V+Se3surd+Uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UGvoSd9A; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPEkiIsQhr7nEwX9aMvHSVOR5s6NWjnf7tCve+AKPKuIu1qP6M6qe2xqOCfqXlUZXPearTkPeXNVFAnWfOW7bDmK7ULrQbXKU6nxMhcYeURhEcvHaIlHdAaC7rJvG0wEHkK4r/iLwnVI9zZ56cY2ia4yoLZIaXuBGq+OuddtQUKqvlIOmBedPu5HtxARj2ipIw36x5qwxHT8YHdtkIBgfPEwZCBw40l8bEh6nSQFrF/n2x+a8rdPGx778/iGhsEsb7hTxgfi5EjCQksz6sw5H8n7q/K4atusUb1zrdxGENZKJylM8V93hhPqoCwUbBi+gQvztXldwa9+5ycezryOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMCMg/Kh9NkfVaGIWd1l1ejw1IymRROnaMM+828dieE=;
 b=bcMbY5MHsV1T+8mQms6urN99cGM/KfjEuwY5YmcoH3dO6Q6GOfqR1bcJvjnQAB5yl+SrOaT8QF+aN1wYEUQfSg1W7x2PB1AC5P1HJDyS2qn8+uThzSfmasLusq6wmfR0XjKkd0AmDTJ5/nNqLtY4UsXmrmSnzYL+54qcZYVHVGG1HPfSHBFBKSU+i2ca264WE7CFm9015KscbaVKUYkUipnpe71I5zl1haUPLMFmMjns3Y+lyArQxg/DrFZYI736s/eT+A8VF2pGZxnLGZZytMtLuGN7WaUeZTms/MuPF5BaN7PPbET2b4Ttq06T3CK2LZZStvVxaBJ5nzZ1+XXy8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMCMg/Kh9NkfVaGIWd1l1ejw1IymRROnaMM+828dieE=;
 b=UGvoSd9AtfAQ8zM2b1CcrAYKkb8rVmfhwTZQOUIZulL0ARQ9AL4XjNirpk2MKpWnYUIg5qcAsTJbDNbvvmN5w3xxkVyMfBPjti9WSZLo/RGUqqyumYWEl6gM4X1QA/xjKuF+FmI9cKZHGQ9qt2GQhVmwP41VGxTr5OxN9pnYnCqChlxEPZWG/3FH0mgtg9RfE8nQT1SelKCy5dtmrfzNuT+W3cYmieCYA1gPRmtB/ZRwxC7AmWutBl1CwsHgtn5Whnl/PdFbBmHcUKbx37F+fUDEUrxAWU3bEh5i27VzNBbwB2N8vfrLf21bP22FWSWzbPyL7GsdQrYWdmtJEXAYPA==
Received: from SN7PR04CA0089.namprd04.prod.outlook.com (2603:10b6:806:121::34)
 by PH7PR12MB8016.namprd12.prod.outlook.com (2603:10b6:510:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.28; Mon, 17 Jun
 2024 15:09:01 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::62) by SN7PR04CA0089.outlook.office365.com
 (2603:10b6:806:121::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 15:09:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:09:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:08:47 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:08:46 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:08:43 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:49 +0300
Subject: [PATCH vhost 15/23] vdpa/mlx5: Accept Init -> Ready VQ transition
 in resume_vq()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-15-8c0483f0ca2a@nvidia.com>
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu
	<si-wei.liu@oracle.com>
CC: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
X-Mailer: b4 0.13.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|PH7PR12MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de57bcc-8219-4fd4-7fac-08dc8edf6b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|7416011|376011|36860700010|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXEwYTM5VG1CKzdhbnVOTkZKS3llZlRXYytlZmVDbzNZUzF2R0E3bWN3cjBH?=
 =?utf-8?B?bHNZMmpCcTVhRGtxN1pEekttMXp4bHprM2YxbFVJTVZYMmFPNG1Bb1o4MThr?=
 =?utf-8?B?TkJPR2tXNHVZdWwxdEFYNzF4aG4rRGtvbjVrSXlkMVhxdjJEWXBEU1Z5a1I5?=
 =?utf-8?B?eDNPd3ZxbmNCYXdWUDFUMDMxN3FHbU8xVm1zZHVyL0ZGUmh4UFVCcjBlcWRQ?=
 =?utf-8?B?LzRrRTRYNGRRMmJLZVhsbzVsSUdIVXdqUzhyRitJM3RqMk1lR2k5M09nTHdU?=
 =?utf-8?B?NlVoNlJPSC80bEl6bGtNOGF0MStMODM3d3EvVGE0R2M0bFlvMTU4NXhSV1N2?=
 =?utf-8?B?NE93UG9BSVBCVmVGbHNQek1LRkpnV0RLOUpZTG9PK0YxRGhlU0w0V2oybkFP?=
 =?utf-8?B?TVAwZXBhUnpBMzZrc01vZW0wVS9KNHFzWGxEMVkxQ1VTSWdYV1BlMjBXZU4y?=
 =?utf-8?B?SWtXNkRPVnJLbXRVaHBTZHR5Y0xob0s5SGVJSEFreGh5dEhHOG51emE5Tzhv?=
 =?utf-8?B?WCtyUkFtL2taMDlvUTlZWnlvNzFuTkFFMUpUTzk0TkpzcUtnckpNM2tMaG9t?=
 =?utf-8?B?WkpwdEU2YVlyYXZPbit5UDZkS3A1L3ZCamlNWFFRRDNaZTlxV0NHbko4aUhJ?=
 =?utf-8?B?bURZWWdBbGtTbFczdHJWMytIZnVCcm1CVEQ0SlZSeDlsWVByVC9raG9MWTRq?=
 =?utf-8?B?bUFiYWNGcW82OHhjSG5LczMvaEhmUjNwUzJpbFI2YXJQdEw1RTlWVUQ0TElH?=
 =?utf-8?B?SFYzalBpRmhybWJrSnBMOWpEOFN3cnVHSERKZm9IMlVrQldEUitPUCtkdzR0?=
 =?utf-8?B?OWtnN1VBbXRYNGJhSTQ3R1BZUzM0Z1FIbXUweTlleENWVHVHTFBDMnk0akx1?=
 =?utf-8?B?VEVYcmtsTHFqSzBkSGNDaGpBdW1ycFk3Nkt1Mk5pVE5CTEZ2NHlnOXYzdVZB?=
 =?utf-8?B?bGxIc0UvaVBPcXFML25oSVdrZVVFdlNIR2ovRERMRjJmMlVEdERDZ29kRSt4?=
 =?utf-8?B?WU5keUthRlZDRFZlQzludTZXSDM5UGs3c28vL3pPQmVFV3lkbkUySkRMTit3?=
 =?utf-8?B?UHpTTGxXZnRjcjlOSFRYeVVteE1UaEUvUnlVZHhhN2RpUlhIbTRDZHlCdS9z?=
 =?utf-8?B?ZFRaZVpKZU9tTEdBK0JZdmRkYW9FeEdNN1Y0dG9tQVFLOVVDdGRmeEVCQ2t4?=
 =?utf-8?B?Y1dUeTZ2NVNZdjVVNk5wNnRxNys3L1NNWlNrUDhoeUppanpXcHR2MFJlYWZm?=
 =?utf-8?B?dEhrMVRBTkhzRzhydHRlVVVlVWZkeGZFOUZYazhCU3dmS0Rqa2lvWHp5UlRX?=
 =?utf-8?B?ajhmb1hEdDU0NmRnTTJmeXowMktsU3Z6Qm9XdkNiRUdUY1ZYcUN5bGQrSlQz?=
 =?utf-8?B?Wk9hamVhMlRCM3dXSE5FUUQrYjZ0YWlyM0Y5RUtJZVJKS2RHVVBhWU1rYkxX?=
 =?utf-8?B?NVJzUEZ1RDVVWHZ3U0FMaVRGRzRONWRtbExEWExPemFUVjZRdGZTVnJveFox?=
 =?utf-8?B?RVB6d2IrYXVaWTU5aE5YZjcya2w2dWdiN2NuOFd5dWF1dVhjVHpnSThJMVJR?=
 =?utf-8?B?SWdjY3NwSElpQ2s0blN4Q0R5TGc0SFliQWl0WE1TbnFBS29CdHJjbHJ2ZW44?=
 =?utf-8?B?NGxnYm1JSVZZTWU3SlMrcEJMRmtHclFhbVRhSDJxTFJSNG1WRzA3QTI3cTky?=
 =?utf-8?B?NVJOTEJpbm1kODJ5QWJuNXBUb2Z5TXhEaHoxTGRDdVJCRWV2WWt1V2dLR2tO?=
 =?utf-8?B?RVhGTk1EaEtyczNJVUs4YUs2K0ViSElqdys0czhRVlZ5L0NERDByZ1VEUzdJ?=
 =?utf-8?B?cERsRlE5cmwrcHVOU2ZVNnA0b3ZEcFVxNWFucTB3K2N0OWpWVTZzL1BFaGRw?=
 =?utf-8?B?MllkMHNIZ0htQklabVFhUDhadldCczA1WjUydHQwaFBSQ2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(376011)(36860700010)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:09:00.9747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de57bcc-8219-4fd4-7fac-08dc8edf6b70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8016

Until now resume_vq() was used only for the suspend/resume scenario.
This change also allows calling resume_vq() to bring it from Init to
Ready state (VQ initialization).

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index a2dd8fd58afa..e4d68d2d0bb4 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1557,11 +1557,31 @@ static void suspend_vqs(struct mlx5_vdpa_net *ndev)
 
 static void resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 {
-	if (!mvq->initialized || !is_resumable(ndev))
+	if (!mvq->initialized)
 		return;
 
-	if (mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND)
+	switch (mvq->fw_state) {
+	case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
+		/* Due to a FW quirk we need to modify the VQ fields first then change state.
+		 * This should be fixed soon. After that, a single command can be used.
+		 */
+		if (modify_virtqueue(ndev, mvq, 0))
+			mlx5_vdpa_warn(&ndev->mvdev,
+				"modify vq properties failed for vq %u\n", mvq->index);
+		break;
+	case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
+		if (!is_resumable(ndev)) {
+			mlx5_vdpa_warn(&ndev->mvdev, "vq %d is not resumable\n", mvq->index);
+			return;
+		}
+		break;
+	case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
 		return;
+	default:
+		mlx5_vdpa_warn(&ndev->mvdev, "resume vq %u called from bad state %d\n",
+			       mvq->index, mvq->fw_state);
+		return;
+	}
 
 	if (modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY))
 		mlx5_vdpa_warn(&ndev->mvdev, "modify to resume failed for vq %u\n", mvq->index);

-- 
2.45.1


