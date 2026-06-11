Return-Path: <linux-rdma+bounces-22109-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q1a1I4GvKmrJuwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22109-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 14:52:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3F56720AE
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 14:52:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=LRo4vixR;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22109-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22109-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3701C3039898
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 12:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075893FADE7;
	Thu, 11 Jun 2026 12:51:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429503F88BE;
	Thu, 11 Jun 2026 12:51:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182281; cv=fail; b=KbRmFEJCj+MaW6ybs4EaxWrY8XbS99IIvaXCZUGsZ7IWIv+I3b3Sdye8JLz1cLBtZHGRiPCNVYuIgF2zaSMZTxLl2Uy7JnFeo4sDYVk+CTE53GHI8dz9+Ap7YkT50dvzBXXul/3CNBBYgWR623qey08dldFJeNcPq8FB7RVKs+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182281; c=relaxed/simple;
	bh=ql41oUBFmpgqkg6n9ok0Lx6DAxzSReouCanQXpFFzH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PE8NR/CUZ6brIfB6EYPZS76mPeftTzkkuOUSRB1xhtADUxtH1c6WTq2FgHOBsQKy3gaM0yOyelIlVZP6odfnmz/PrX4C6qbqenlgoT7oRK2XA4BfqXPsMvTNdWEvhNp3HL1iJCA7TORt0F8WfDAG85A6aPl5ZHVa1ha+TLrvi0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LRo4vixR; arc=fail smtp.client-ip=52.101.57.38
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdIFKSTIYAWzoVuJ0dme2MN0EzeZKZw46UDgAqghNJEhr0cJjlA+YHJV+BPxTeqScvBA8LM5YA2r9i5K6CiL3m4y3hIC8ky7EUAWH1Dke/swJtJ3KwsVdYupwOGLHUxmvBZauKDnsM+CxtCTel7GnfDeHRIoTw7iYtpfueSi0D4g5z+6YDkRr1uoDYrr2rvf8D2Sr+1Ggu+48PAc99JbBRajQnlKBBN0C6hx4vrMDwx5ZmamFJyEq7ScGQdmK3gtYxD/6vxvN8/cv9zsnT0bQLMFxL5N5SXkJAqQ1BefMLXgus0/jYyfGEbMdAReqHCNxxAIK+Zdy+PqPZT0q5WhVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTiOCKli6FT+BpKyMB0T1LPnEaxbfNUcQK67MnzFqdQ=;
 b=ptFk4y/4ik80cpVb0IEBVxQ6ruIPT9CE5OwF0YbxAfrOlEEPpj3AheuiMtf8weLmSFu8YpMuzo56L8ntwwMFJRaii/9qpTXbW3ReVUJNisL0gab74ttCUHyFP6q+HdhTkHfsf0dVsRIPrX/45Rcp4D1oLRDaHSjl2PKhLj6PJ7aoSowIWOKbQe+Gjh1D6jU/xJwVsPh1+6Jz2ib+UV9Lwb0Mdc2DWev80deLYOYIBdWtrQOVjStH2CodeBtG4J5o5aFX19RosNRhb9bglqPh7SpG/vsewEADs3oZFfDMukrtagxLon6kXxeRGhPG7t0wIeraBn8YwzAwx55GcJFOIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTiOCKli6FT+BpKyMB0T1LPnEaxbfNUcQK67MnzFqdQ=;
 b=LRo4vixRTmR1lFS9bW0irR0TJBU8omhO3KnPy4NRi8kD6ca+7LDJJnOkaBqGADLwq/t0tKEavMb21HEVwPQhUWdCnNDGkIzm695AW+xZfoLDuL7RJ+5819C6YuekMcq7OjglPYcvKBnNIcDp3QXp256ImJtXMpd5Bk+Qyu0aD63wAhmasSNjMsaLphYI76s3M9+MYGGBjPN3FG+6iLXZdvB0GuUYxfKOYY8rStT55GHK/N2pzhBuRMRQobHrfVpzOJ8iAz1Y2QChQI6D0LuaxNKwHWfHULSUhMDACUkR+AtdNhDxMlPeWTrX6F43vJAUxzIq14MeEE6Rbw7W4sikcg==
Received: from BN9PR03CA0542.namprd03.prod.outlook.com (2603:10b6:408:138::7)
 by IA1PR12MB7757.namprd12.prod.outlook.com (2603:10b6:208:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 12:51:15 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:138:cafe::76) by BN9PR03CA0542.outlook.office365.com
 (2603:10b6:408:138::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Thu,
 11 Jun 2026 12:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 12:51:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Jun
 2026 05:50:59 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Jun
 2026 05:50:58 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 11
 Jun 2026 05:50:55 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Thu, 11 Jun 2026 15:50:42 +0300
Subject: [PATCH rdma-next 1/2] RDMA/mlx5: Fix undefined shift of user RQ
 WQE size
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260611-maher-sec-fixes-v1-1-cd8eb2542869@nvidia.com>
References: <20260611-maher-sec-fixes-v1-0-cd8eb2542869@nvidia.com>
In-Reply-To: <20260611-maher-sec-fixes-v1-0-cd8eb2542869@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Or
 Gerlitz" <ogerlitz@mellanox.com>, Jack Morgenstein
	<jackm@dev.mellanox.co.il>, Roland Dreier <roland@purestorage.com>, Eli Cohen
	<eli@mellanox.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781182252; l=1684;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=0+Wq5W/J7bQTLkf3J6nDLTe5WuSyIdk0Jbs3E8do5zI=;
 b=RO5j+651+mx+eV0FBhT4V35L/T/0A1D5fZHF0bFS85xujXCxn0u6FGlR2lBdZ4ynpBUSkKLyB
 OEenyPMzDzfCxSS7z5NkZmE8HEl8a9xur1/aJo5r5nrJ5I7VTNbY/tl
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|IA1PR12MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b49695a-1b34-4425-191f-08dec7b81fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aF2tKqRME76iSeBv4VyTATfX40IhEdrTq6K5Dyed8jK+3PYjepx3sPRhdpBiWF6X1TkDv25iC8mb/UBLe8MZk/L3xgBDrCjrtMO3O8VEJoVpXKAP9XQdLQxs92+r7ILtPtGZRdX1pKh3PXoty+IVebgWfvokZlw4mfGB/qNPm1YSALMi9SOEhtRaw614UsHzIpFinuGkiyb0lMheOJhWWaGrskMcpzCIDfG+yv3V7Twh0fN/tNKt9bXb2OIeqPwD9ku+MoCd0etDiNqYCgYShOcg9G0xINNSG4oLXsuNBFfZk1O+DHSiu8gZ4I+OJdPUhU9txF/VMWKJnQtfNu1LTIU5G+sgnvk3ADI371HPxb8t4oyYS89ly4SBg8zvOp5EEh9neYlAUTgbGJAt+VSO+4MgkVogP5mKAHeaLICEyD/Z/DXuWR2ABJp91Kmy1KpeyqZLpHpwtSO4j1kS0N4LiMt1kBH55DOgcTaxWXWGL00otLnikZy/F2SFXhgmZK+3sApPf8hFtCBLBEqOyckAjrmTNDENcE+0UD8D73EDWklaW2QkGJCCPaqvkajrXcmunJHdEYyg/AVHX9LtFQId/fIxazrGhKGQgo1ElT9DIny9PWSp+o6W+Fy4zNPlSFSiu+CoBiHsLb/trpwbNofF+aNUwS6Lqs5A6gHNWz9KELth40kBjq70UW4Z0seLfX90nNNYTwtJZa/lGE1l9otODgDl8XEAs4bJvNIBuVnD6AA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4diBuNFDOMS/I84DsaRBzLTiowXiFihvBKytDfpiqt8JexOG+v80Oa2vwDnCfeXJ24uWOzgGILyJrp4l9TShA31Q6UBZnSeRn6DpXMz4IwYyb4WyKl1kjb1AJcrJeEKbcwvaqqYbr+F7TjJTPzVe4B2yq4ZXLAGVaQjA5B0+F1lshEUUu48jfXP01NnIVkvaabkuEKv2wSA0PhLYrEpguBLyoAyux1qwgl5TnlPs2WhRgWDQuH++8EOiH6jyekAU20K9Nd+D94R8pO/BAaQdj6BEdnIULWS2jR+hz1Kr0BoBOF3v24yFjbhb8fosbKZNTejYtOKzJt34/setl4n1hiSA3sLrQOW7gPhHin5q5dGpeo3hKiXdTlgFTI+HCiCq1On1rYsuF7oiF7bod9tJfGWLPDXEDvTUT2WydnhdtxJNgAzczzShwpqyNdiXrE4o
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 12:51:15.3805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b49695a-1b34-4425-191f-08dec7b81fdd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7757
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22109-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:ogerlitz@mellanox.com,m:jackm@dev.mellanox.co.il,m:roland@purestorage.com,m:eli@mellanox.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edwards@nvidia.com,m:msanalla@nvidia.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F3F56720AE

From: Maher Sanalla <msanalla@nvidia.com>

set_rq_size() computes the RQ WQE size as "1 << rq_wqe_shift" based on
the user-provided rq_wqe_shift, which is only checked to be greater than
32, so shifts of 32 are still accepted. A shift of 31 also overflows a
signed integer, leading to undefined behavior.

Use check_shl_overflow() to compute the RQ WQE size and reject any
invalid values.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index e8d34d54b43527e0595ec9e2fb93dc7e9bedba92..7674290d0afaf466a6b98cbed86d247ee550bd8d 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -454,16 +454,13 @@ static int set_rq_size(struct mlx5_ib_dev *dev, struct ib_qp_cap *cap,
 
 		if (ucmd) {
 			qp->rq.wqe_cnt = ucmd->rq_wqe_count;
-			if (ucmd->rq_wqe_shift > BITS_PER_BYTE * sizeof(ucmd->rq_wqe_shift))
-				return -EINVAL;
 			qp->rq.wqe_shift = ucmd->rq_wqe_shift;
-			if ((1 << qp->rq.wqe_shift) /
-				    sizeof(struct mlx5_wqe_data_seg) <
-			    wq_sig)
+			if (check_shl_overflow(1, qp->rq.wqe_shift, &wqe_size))
+				return -EINVAL;
+			if (wqe_size / sizeof(struct mlx5_wqe_data_seg) < wq_sig)
 				return -EINVAL;
 			qp->rq.max_gs =
-				(1 << qp->rq.wqe_shift) /
-					sizeof(struct mlx5_wqe_data_seg) -
+				wqe_size / sizeof(struct mlx5_wqe_data_seg) -
 				wq_sig;
 			qp->rq.max_post = qp->rq.wqe_cnt;
 		} else {

-- 
2.49.0


