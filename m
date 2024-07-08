Return-Path: <linux-rdma+bounces-3727-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E0292A1E9
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5893AB211EB
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1AA137756;
	Mon,  8 Jul 2024 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FOoTnw0V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B232137757;
	Mon,  8 Jul 2024 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440125; cv=fail; b=OkciuMgzfm3JuwuxmIiOVcigXsbrR0PqdG45gkHErPQ+rH1porb5te4/AcLDPpeI28DJdQm/+iR2eqU10QxHoDQKoXK+in0YgmcTUgrgJ6qV6QtulR/8w2IU+Tkxjm9cOH5/hG9rMWm2B3kPOJGo3tp43eKDYNoqtBu5su80wPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440125; c=relaxed/simple;
	bh=8ApW7OmELEMo0ain9rf9IjXR5AkLDNuT5HIwCyqy1sQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NQiUlgrJfvOKMkcyutJvKWaOHz+k4jYLiwR6MisebJ8oraWgsQjrZ9BsaheeY0P0cv1JrikI80Gq6VCc5e0UPy3y4wbWCfrrw1YJzZ3iirsKu6G4hFiRp5ljGMAQusC4X5Tq/lO5PLgao2KdPeqyrn0+tyS+C+07gMUhttaTSFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FOoTnw0V; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3aDq6WQw3XD6ddrNW0qzS+9n3XqoLHYkuCUJzyOlw52j2siwKE9g8BIJsqtBg2sf7sH42m0dDcBqhKiYrX+M7jQr+UoY9Z6uFRJo9bChrplyCi3GsKQsorlXHvi6u2yqecJNUyx3uhbsQl0lxrn+kEap1lzAQCf0PMFgQDCWPE1gaDGT9MKH+XD8EfAjbOXrmegs6u8dA0Df4KPs49gIkauH8bFxc6MXexxxuM5WxhOfhzX6gw7c0EC3veRZzLqz7M5iCowhfSmwco8zwZyecQix7kJD+KTMKS7VI/ePhrWolcCZbpy2IlW7yBJt9A6WKTkSTzkKSX/1Lf+At03Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CouM1YReqN2302FiAFOOXi8BwoSBAwgDUI3sFbbK/Nc=;
 b=ez1ByrwVzFoi8KCwkjVmnN/yK+l/MVtwBH0cAtv01Xsg6rfhTnLvPpiqNlCXnKVL1C94/Z3S1wkyvzzMcwGPcAs0Mz+eSi5TObZlaRYnkKR/Pl8EpCO7f9cXNzu9tkHBqXgk6vx+kMMjOiyZyVpOLP1cG82M45kGodwyfOqccLvptIiQpY191A4GNPoJx/FaR4G54r0/up+jGBLWrR/l2UloyKDybfIPDfEEnaxyKXymWViWBAvHEP7dtHjcutwQwagFnmiK0WkEwnzR1XaEJljubJhKKPKaNkji5ld+i6uuMx+mtBoItyinEXAnSVF5hALcH+mUWcLZVwrnj16cgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CouM1YReqN2302FiAFOOXi8BwoSBAwgDUI3sFbbK/Nc=;
 b=FOoTnw0VuXxpaxGRNrYwwotSlmf/H9H8krmWL7TpKo1q07H+mZ31icQxZaLKn3hAOmJueVoozHabEykMhquhoBqh/ODZzjuMXvq80zqoc00GzPy8OnCMxqPTFndiXoH0P7z9ii7s/PyQeQ4woUv5vyQGkR/n6FTPTTu59dTC9rRpKuKVYHYX3vhJd0cz0f9UbDusrY4xC+43Sy1iw7yMSQQ2lNn2Op0cU8kTQJR9xYlKWeSifq6rw13yZxt4IE92twc7gHcrPx0OTymrYhoolqEu9wMQVaWFzlhOCiMdrL1LstNktM/7z9rPEq4ICRWpgfqCmURCke1MdYKT/JJbkQ==
Received: from BLAPR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:32b::13)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:01:59 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::97) by BLAPR03CA0008.outlook.office365.com
 (2603:10b6:208:32b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 12:01:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:01:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:16 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:15 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:01:12 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:28 +0300
Subject: [PATCH vhost v3 04/24] vdpa/mlx5: Drop redundant check in
 teardown_virtqueues()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-4-afe3c766e393@nvidia.com>
References: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
In-Reply-To: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu
	<si-wei.liu@oracle.com>
CC: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
X-Mailer: b4 0.13.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|PH8PR12MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e1ba43-65f6-4810-fd2b-08dc9f45c53c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0dNZlhsVTFHdjdwR3licnpJUXNjajRtdzZyU2t1aCtIcEtwdkV1OFRkbjlU?=
 =?utf-8?B?MktJTGpkUHd0YW1KR3k3Wmt0RzFLSDRVSFRFOGVwclVYMmgwWXFwbWVtZnZa?=
 =?utf-8?B?U0tGekszNHQ1d1lSR0VxWG9MWEpZdERCS1JISTNaclNOQXo5VWJNWEZ6b3JS?=
 =?utf-8?B?Q2pSemN6L05kTEZmOWtGQnJDTTZiRHlYOWpwSzBzZjVQNk44Sk1YblJNTkpF?=
 =?utf-8?B?aUVOb09HU3VHMCtvUWlDS09DUkpNbTdycjlMM1phcHkxT05DREtsWXJUZUQ5?=
 =?utf-8?B?UHlKOE96STJ6M1ZNbnViY3pXNUQxZXRCdnpaVjk3YWx1c1F4Q2daK1hNdlBG?=
 =?utf-8?B?Ujc2MFV6eVdSK2ZmbWRFUkpieUdORU40aVFWMi9KbUk2ODh4ZSs4dkxMNnht?=
 =?utf-8?B?V2VpYkNXbG1MZVQxY253dndFa0FDeG8zK3lkYktydk9paW1yTitQNUNtajFv?=
 =?utf-8?B?V3RuSTdtTzZET2g3TUZRS25xelZiaEdoUGs5c2JsN1IxUFo3R1llR3Fnajhi?=
 =?utf-8?B?aGF0enRPaGhld2VyVTA0K2d1dmlkeCtEays3R1BoQ25tM09QSXo5ODF6T3I4?=
 =?utf-8?B?U1FQZ0ZaTXhPRGgybWkzSkZIOFE0RG5jM3kxd25Yc0FJME82YWkyeGtXb3h1?=
 =?utf-8?B?Yk1NWjN3ZlhsdWp5czBhUkpqbFNRZE9aeGZidEFuN0ZDV2hqMWdCaU1kTUQ2?=
 =?utf-8?B?SmJkelZUUGJFZ251SDZwWkZaUjBmZ1o0czhEVDZKVi9DbVBlajBsTG81dTRM?=
 =?utf-8?B?OHptZWxneS9uVVZMQUo0Q2FhY2ZIUUhDTE54YXhoR20xL1d0Y01zbWNMcStr?=
 =?utf-8?B?NnhwN2NBZkh0bWY5bVozelhHY25OOUpQekM4RVdUVlRxL2VEaDJ6VWhwaUg3?=
 =?utf-8?B?R0R2RXdFNDBDcUxUZ2FvRU1zVG5ONTlFaUlEbkJlblY0V3ptaksrSDc0ZEdQ?=
 =?utf-8?B?OE5ESkNLU1NYSVIwcURMMU82b0ZVc3hjU0IybGhXMGhYeFVzNDBhTXRmNVp5?=
 =?utf-8?B?K2hiQ21HMHVOV3czM1dCd1hkcnBISk5McW9La2F2VnBja1NaanJMRURHMlQz?=
 =?utf-8?B?QzNEc2xKYWlVZGNsU0gvZ2FsWVk3d3lWcDYvN2lycm5meUVjOVZaNUtIZkZO?=
 =?utf-8?B?djQ2VWxQZmxRZXRGaGVDRk1VN3N2d1dTd1AwTHdLQWZ6VnIwZjAxZVlVZVZX?=
 =?utf-8?B?NzUxVTFsandXRGczbjR6SXd0dGpsV25OeHRYZ0pVSU1FM0p0aDZyZy9CR01j?=
 =?utf-8?B?RU9UMHJyNklKaUV3cnNMazFpOUJpbnVnaC9jR2FYa2F6clpJVWNFRkYydzlh?=
 =?utf-8?B?aFc0azFtbStHQXgycUdjazFWaWRiTEZtY3MwRksxdTRjcWczNGxtdFR3ejFK?=
 =?utf-8?B?QnZEcmtMdWpnVGk4UG9ydlltQnQ3dndZMERvNEt6KzA0dkI5bVdPTjJBeUNv?=
 =?utf-8?B?TmVCV3lOY3VuVHlGZlQ2RUJVZ1JrS1lsMzJNdVAvZEFNNkdqVVdOb0gvM3dq?=
 =?utf-8?B?MnBzbkY5dS9GZ0xWeU1qdG02S1ZBU0djSWR3Nm53T3BOY1JaZDJpNjFtRTRo?=
 =?utf-8?B?RFF3RjBYOERwYzFuUm5hKzcyeXBmYXNPLzdrRjU2enNGbFppMjhXU09NamVQ?=
 =?utf-8?B?SWNiS0NJTWpiWlRqT0hMQTByU2Z2YUZ4UWhRd0lFWXdZcmE4L09NRzM0UTNs?=
 =?utf-8?B?cGY1V0FOWkdpVlk2ZXdsQjNsUjBqeVErTWpJcUd0STl5OWNvSWRaNk5zT0Jt?=
 =?utf-8?B?N0ZscjREQ0JpNFZQelluWE9UQ0VWSVBiZktsK0FvZkdNOUhGM21abGRrSlhG?=
 =?utf-8?B?TWR2RXVMTUFTV1UyUHhjWm9OamhkdWNDT2FpbDJJM1libCt5VHdKVUlpbGJr?=
 =?utf-8?B?TldNa0NtNENDWDNYUzJjMVNyY1FKL3loMW83cEthNjNsRzArOWRZS01yUFhP?=
 =?utf-8?Q?w9iV/Sxc9eYk8OG+oBa8q26nM5dkOPa/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:01:58.8404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e1ba43-65f6-4810-fd2b-08dc9f45c53c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793

The check is done inside teardown_vq().

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index b4d9ef4f66c8..96782b34e2b2 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2559,16 +2559,10 @@ static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev)
 
 static void teardown_virtqueues(struct mlx5_vdpa_net *ndev)
 {
-	struct mlx5_vdpa_virtqueue *mvq;
 	int i;
 
-	for (i = ndev->mvdev.max_vqs - 1; i >= 0; i--) {
-		mvq = &ndev->vqs[i];
-		if (!mvq->initialized)
-			continue;
-
-		teardown_vq(ndev, mvq);
-	}
+	for (i = ndev->mvdev.max_vqs - 1; i >= 0; i--)
+		teardown_vq(ndev, &ndev->vqs[i]);
 }
 
 static void update_cvq_info(struct mlx5_vdpa_dev *mvdev)

-- 
2.45.2


