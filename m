Return-Path: <linux-rdma+bounces-19811-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLnOCh3w82n38wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19811-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 02:13:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0E34A92E1
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 02:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD69A3086698
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 00:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D65F63CB;
	Fri,  1 May 2026 00:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DXakp2Dk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377E22770A;
	Fri,  1 May 2026 00:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777594145; cv=fail; b=j/+PxNSl7iqaq+JF/lRH18pw4+wradStqvcXWQo9He5YnJfFx8Zvz0ya4dQMMnl3rPaorEtC+ZZvE7dysHcfUUtWxJCUlqxvK7csBkiARupOjl/+l6vlxu2FLaT0Jaz5l47I7kDSDKtub1k5EMHZlYmtmDvhlH8k4L9j6hgXwqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777594145; c=relaxed/simple;
	bh=FbSzKnpi+TdlR0r3Ggm/ja+2dwvUEWP8OKKcrjoph9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iRmJ8dpGB04Skf9KmHn4SsJ/QEHdMwfLhy5J6n3JdOK3cBc2nGlkc/ryWth2nqfWjjUzkTzeuWGatjT4p/zAvmrXGgo4Q+kLVZ7XJzhrmlBsCAIDX9wkYYR5Mm9DjgI6UzSxPa2l5z46iuHY7jiLL0W6XULEiINI2QrXbRaE0xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DXakp2Dk; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atLyoQwTy+SRcohjiX+VmMe4Mrby/OUTIzTDXqIS9iECXMcvWOxs+0/iNnpKE0tapVbmG/CwMnNm8JQrfqSkI2SOfIx5J9Gs4Rn8lKZT+r7451yK/2Z26HFK/beUKTwIlQL3z59CXPV6w7pND6s9AEBLYtrqtRueMleVxVj68Gk2dxpJqgnw+l1Srcscss9C1msrLr2Kp2pM07SmoiwIFDt3Ed+r42pF1j3O07hB/57Okp3bxN+g1GbKoVJW+L2Zg5I7Ts5QGqCJFBpjoM2r+zMVwvd41xxBAgP41EdRVLrqK19HV3LEhaFE+7BZxcstLPwrfM6ajcVfux+y5x4qmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFMhLJAAKsIY+u0VB9k519kGqhUfXzAngIEAp0ZGujw=;
 b=WcXiBflEFvFdMRHViYKT7bL3ZvMjopCx7Ru0gqcA0h8Sv52nlu+QKKo+Nly/wKwJjep/NalXWcFNYDMkTX3rnNDc3BBNKQijn0IxH3KLGMtKl4u4q5/QRMST1j3bA3vYceQAnRtOAEinZZA0Sq4CXWCh63Ws5m8wG0V0Nbe3tuj9huhRlGy3OnJ1shYdrXqbVaxSMbO6btjrZUIvHYuDuWYv7vRAKucxnJt+OBbOKP9vwQHFuLHNUBjPAYcMCh/BJzHMRswB7GJgmwMDHNTIv9QrugRBU+H60WQNSqrHuhSt3TMH6EaE6NL0BMc6vfp5hztIN73qOHgzr1ov5cvrSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFMhLJAAKsIY+u0VB9k519kGqhUfXzAngIEAp0ZGujw=;
 b=DXakp2DkaU7ZrQsDY4Wv6UzMfW1s9Qv/fIrp4kncYqbsttH5uckluM0rRdJ17dP9wa+s8UwJKS4XfAMI2RC+O/fy9dKkhkh93HQ+eUfJepXlMe4Nsh2B6L9Z2+V/O48iEraeMWDcbsh9S47FeCr1177YB4+keZSEfIDVxEzvjCLTW9eVDqJqnncQVnzcbkAW7s6dJvXDIwqTMWR5JNnCpGEtZS3axw62xt3lyDqp4Ml0TFE+oWYrxQwyz9JsHMbn4OPoNEoLoj+JMyut8hY65O3C6X+jlQBKtb3b4+9g14y7CfV1q533oxCQjrODkY50OwSEyK7hUe7t73+vPYQCMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SAVPR12MB999167.namprd12.prod.outlook.com (2603:10b6:806:4e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Fri, 1 May
 2026 00:08:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Fri, 1 May 2026
 00:08:40 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: patches@lists.linux.dev
Subject: [PATCH 10/11] vfio: selftests: Add mlx5 driver - data path and memcpy ops
Date: Thu, 30 Apr 2026 21:08:36 -0300
Message-ID: <10-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
In-Reply-To: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0156.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SAVPR12MB999167:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f6e38e-6ca5-4ed1-5199-08dea715cc2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+mo2i7VelEjyDL+8o8ka9+Q0QPxVduhGRsjChN3bvvD7VFb8xOTFUWkITA9GDKKD21u/urOZWjdDFIn/GbsS5AMVkDZI5CiVgn8mwqb5Oc7RbTQq9OsqYnD0a//muBkjbTA1VMZns+qMreVlUvkRW/U6HI7RE8FX5V6vVGjECbSD1eu1PVwZVymiB8qWL4lMU0gIIwOI0YbxlfN3pzoguUfrgWdS5QakMAe2LPzA0abXd8Zb07x/jEHo0vh1+d4FThhCHew3bi5peP6X5QPUHVEckKa0Ghv4txzJrEcwpTirtTs0UkCxB4t4GA2LIU7KNVn1oEZzc23hJj83fcvv9LWlhH/6H+NW0hd27KojG+3XkISZVasvgCA1mTj1GaZxB8/st2utgmuccR0u5PP3kkWBJxdbx4cy79mPM43Zfi0uSIcQmH3LP295suzFTgTwXmii8rM//pLZ8hJL0+0jq5aBWY7TuOmBWHomW9ZWj0I+eKbIxGga6wYfjV/RaIAtE39wbkTx+2VSOPcDM/+xQLw2kLzREYEo/y1Q/cdppl2WPTxRRrBEpYZSYNjSJNVmM3Xr8UifRU5derTqN8hJ3Gu3NId3Puwa9u0Hg/Ffy16tpjq37M2YXsfxZN+Z/cTZjHhctHfm1jl5UARC33lCi49wHYnaXM2c+DWepcQozsJToueuzksB/TxZyJHW/JmbUETTpL6LDlncYF6Y8WeT/7DwybqWebJXuBIXFsaIjLA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pS/nIQzLKyQzpXvtret+KNcq2yrO8Pk/bseJRjiS+XaXtAtMLlVuvDowrGCA?=
 =?us-ascii?Q?A9nPn4AOmKj/PGhgvdjOu/TFyjp7q3HHU2JvO7bPrQe7nIWdLG1Svf6oHc3g?=
 =?us-ascii?Q?V1fK0a4F85tM3SvTFBlkD3Aj6VKJn9JytHqfKTELOt0OEBv762R1OTfHRu/2?=
 =?us-ascii?Q?xIr3V9Gmc6TpXLGKKonh0qjPyEkz0AWTYX8G4ksFpo19RNiNNKY91V0hZPFH?=
 =?us-ascii?Q?sqf3i7xXk3UJX7m9znW6CEzFxZ89wxlS7bPZ0jLhw/cMwreUC4jPZyO2Yuqs?=
 =?us-ascii?Q?hJNuXFeRPb72ZGuyAD9yO+MdzI4QZPR+xEKUFCGy1GUtChtO7gVTLd6uizXx?=
 =?us-ascii?Q?sYMbITW7HB3tGk2i0JXrrs0ffLhfXcNkta2sjr0ZihZ8dEV8albUjkdwftJR?=
 =?us-ascii?Q?y+KMQqbCwWVh4tojXmqiRfKyAJK8sEZuSmG8WEUEzIrlj8LZKFOYlx+BvgPr?=
 =?us-ascii?Q?RDGI4JIrT9PhinFyl4eAucoRj61XD5t0a8InSI29N8q47i2RJmrkz/bsI7SX?=
 =?us-ascii?Q?mn+nvhegclc7Dk9VyZr68ENeEfESh+OAvPRPCuJxx+dxuhuzGjgcyNjPPhEE?=
 =?us-ascii?Q?R/9lkLkumGhuWCq3u3jAUBwV64oc8FXCxC8Xw//72WjpGRGCBhMY+uRIG32L?=
 =?us-ascii?Q?OUZ4OUHXVAYbYgNf5KzpcDjL+C2Ckg8b4xP7SP1Xt1o9lNedWyCDQXB/+IW0?=
 =?us-ascii?Q?pF7McyQlao1xPfCGCQxckPVUhE2inwIilCRGbrIlsVZ1nizS4/ZbUaVhTAnJ?=
 =?us-ascii?Q?ptkmaPs62+dedokw650qlRq5jR4BGue0GTJQZb3CnrdzOOdyGBMHRny7s/9V?=
 =?us-ascii?Q?VaNXhyfxUBVl0qo2qAIu1ZxD6pKNZOSEa99ClvnoVZM3myB22Oq6pZ/JjaiX?=
 =?us-ascii?Q?F5SOIByJUPdW9xpp6chAPhu5teKTiwMrQGcCU57LN+xkkwYOTBZEH8di0UlH?=
 =?us-ascii?Q?qnQfE9edg5MB7co0SYgK0Ge6yFaHfLk/Oejd7OwdUoe+t72DcN+RYyHyv6fI?=
 =?us-ascii?Q?Z1Xclc0JoKzeK71PPkVnDfJNIXLzX2CvWCTNJbaFpftCAo9TZ2WEo4SCGZGQ?=
 =?us-ascii?Q?WVTYUoTdCXO1dLrJQ3zCoZYvaV0q9ddRwEO/08CH3bhSr7KxtbM+iPHsUCSD?=
 =?us-ascii?Q?ZPdir4MaS5TsVxbihAI/lSqBpgeo8Gtp9SBAbw2DSUKwUZWCcnGNNwiW0nKx?=
 =?us-ascii?Q?XzH0dmI98u/hU2VOipP8jr8cm4fyNvrW6LxiCnqYwT7FI+r5w4xdElfYgqSz?=
 =?us-ascii?Q?PsPq73Fjxtl7bQHkrg06D8GSIv0nkZMSPgn3WeD3Zoq3Zc1NgLveh1WTA9lm?=
 =?us-ascii?Q?mBEifvsHXBuRyd4E6bglOrgfPRJqyVN6yertXO2QA0ECgmWCt5UzGH4uVj8u?=
 =?us-ascii?Q?sqRP9E7gh6AwU/NPbYF5VgqVgGoL4nQ29BgUsO1eFOBMpyJfEGfLsr7fRUiz?=
 =?us-ascii?Q?QFfNXQDikjKzNG/pz2AnHVtwjeM6rt0S3vZHoYFkVPQuLB3ahCRhCd01yPrt?=
 =?us-ascii?Q?LGBv0WtFqYcCBnxfbfVVyP7hZt1UBM/zrW22wMoPbKAyWwNDmQk9FiCDWw1Y?=
 =?us-ascii?Q?1eZ4I3Ejb1rkBJNT0nuxRNImxdVZm1ZyQIkpvSFPpokdg3oHHBgVTcqaE/gI?=
 =?us-ascii?Q?J3m/o/U2p6yufxj+az4Q5OERnTxTkpwy6QKen9v2AWe9SqWWv3y7bZcTmwsI?=
 =?us-ascii?Q?jQxby2hsGl4C9WRBfXgUKzGlx4aoJ6sLub8HsDEQXwkp2IS2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f6e38e-6ca5-4ed1-5199-08dea715cc2b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 00:08:39.7673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /YyZYGzRliaSvKyI7vV+/D0sAy+efa3Ny0yn6py4RkjIzqbNSlWrUznoJWlJm8Dj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999167
X-Rspamd-Queue-Id: BE0E34A92E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19811-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]

Complete the mlx5 driver by adding CQ/QP creation, QP state
transitions, WQE posting, CQ polling, and the
memcpy_start/memcpy_wait callbacks. After this patch the driver is
functional for DMA tests.

The data path implements RDMA Write self-loopback via an RC QP with
force-loopback.  WQEs are posted to a 16-entry send queue with an
NC doorbell, and completions are polled from a 16-entry CQ.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../selftests/vfio/lib/drivers/mlx5/mlx5.c    | 359 +++++++++++++++++-
 1 file changed, 357 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
index 0ab941bad7a66c..39c5414e2c743c 100644
--- a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
+++ b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
@@ -1340,6 +1340,354 @@ static void mlx5st_destroy_mkey(struct mlx5st_device *dev)
 	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
 }
 
+/*
+ * CQ create/destroy
+ */
+
+static void mlx5st_create_cq(struct mlx5st_device *dev)
+{
+	struct vfio_pci_device *device = dev->device;
+	u64 in[MLX5_ST_SZ_QW(create_cq_in) + 1] = {};
+	u32 out[MLX5_ST_SZ_DW(create_cq_out)] = {};
+	struct mlx5_ifc_cqc_bits *cqc;
+	unsigned int i;
+	__be64 *pas;
+
+	/* Initialize CQEs before CREATE_CQ: opcode=0xF, owner=1 */
+	for (i = 0; i < CQ_CQE_CNT; i++) {
+		struct mlx5st_cqe64 *cqe = &dev->cq_buf[i];
+
+		MLX5_SET(cqe64, cqe, opcode, 0xF);
+		MLX5_SET_ONCE(cqe64, cqe, owner, 1);
+	}
+
+	MLX5_SET(create_cq_in, in, opcode, MLX5_CMD_OP_CREATE_CQ);
+
+	cqc = MLX5_ADDR_OF(create_cq_in, in, cq_context);
+	MLX5_SET(cqc, cqc, log_cq_size, LOG_CQ_SIZE);
+	MLX5_SET(cqc, cqc, uar_page, dev->uar_page);
+	MLX5_SET(cqc, cqc, c_eqn_or_apu_element, dev->eqn);
+	MLX5_SET(cqc, cqc, cqe_sz, 0);
+	pas = MLX5_ADDR_OF(create_cq_in, in, pas);
+	MLX5_SET(cqc, cqc, page_offset, mlx5st_fill_pas(device, dev->cq_buf, pas));
+	MLX5_SET(cqc, cqc, log_page_size, 0);
+	MLX5_SET64(cqc, cqc, dbr_addr, to_iova(device, &dev->cq_dbrec));
+
+	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+
+	dev->cqn = MLX5_GET(create_cq_out, out, cqn);
+	dev->cq_ci = 0;
+	dev_dbg(device, "Created CQ: cqn=%u, %d entries\n", dev->cqn,
+		 CQ_CQE_CNT);
+}
+
+static void mlx5st_destroy_cq(struct mlx5st_device *dev)
+{
+	u32 out[MLX5_ST_SZ_DW(destroy_cq_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(destroy_cq_in)] = {};
+
+	MLX5_SET(destroy_cq_in, in, opcode, MLX5_CMD_OP_DESTROY_CQ);
+	MLX5_SET(destroy_cq_in, in, cqn, dev->cqn);
+	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+}
+
+/*
+ * QP create/destroy
+ */
+
+static void mlx5st_create_qp(struct mlx5st_device *dev)
+{
+	struct vfio_pci_device *device = dev->device;
+	u64 in[MLX5_ST_SZ_QW(create_qp_in) + 1] = {};
+	u32 out[MLX5_ST_SZ_DW(create_qp_out)] = {};
+	struct mlx5_ifc_qpc_bits *qpc;
+	__be64 *pas;
+
+	MLX5_SET(create_qp_in, in, opcode, MLX5_CMD_OP_CREATE_QP);
+
+	qpc = MLX5_ADDR_OF(create_qp_in, in, qpc);
+	MLX5_SET(qpc, qpc, st, MLX5_QPC_ST_RC);
+	MLX5_SET(qpc, qpc, pm_state, MLX5_QPC_PM_STATE_MIGRATED);
+	MLX5_SET(qpc, qpc, pd, dev->pdn);
+	MLX5_SET(qpc, qpc, uar_page, dev->uar_page);
+	MLX5_SET(qpc, qpc, cqn_snd, dev->cqn);
+	MLX5_SET(qpc, qpc, cqn_rcv, dev->cqn);
+	MLX5_SET(qpc, qpc, log_sq_size, LOG_SQ_SIZE);
+	MLX5_SET(qpc, qpc, log_msg_max, 20);
+	MLX5_SET(qpc, qpc, rq_type, 0x3);
+	MLX5_SET(qpc, qpc, ts_format, 1);
+	pas = MLX5_ADDR_OF(create_qp_in, in, pas);
+	MLX5_SET(qpc, qpc, page_offset,
+		 mlx5st_fill_pas(device, dev->sq_buf, pas));
+	MLX5_SET(qpc, qpc, log_page_size, 0);
+	MLX5_SET64(qpc, qpc, dbr_addr, to_iova(device, &dev->qp_dbrec));
+
+	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+
+	dev->qpn = MLX5_GET(create_qp_out, out, qpn);
+	dev->sq_pi = 0;
+	dev_dbg(device, "Created QP: qpn=%u, RC, sq=%d wqes\n", dev->qpn,
+		 SQ_WQE_CNT);
+}
+
+static void mlx5st_destroy_qp(struct mlx5st_device *dev)
+{
+	u32 out[MLX5_ST_SZ_DW(destroy_qp_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(destroy_qp_in)] = {};
+
+	MLX5_SET(destroy_qp_in, in, opcode, MLX5_CMD_OP_DESTROY_QP);
+	MLX5_SET(destroy_qp_in, in, qpn, dev->qpn);
+	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+}
+
+/*
+ * QP state transitions
+ */
+
+static void mlx5st_qp_rst2init(struct mlx5st_device *dev)
+{
+	u32 out[MLX5_ST_SZ_DW(rst2init_qp_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(rst2init_qp_in)] = {};
+	struct mlx5_ifc_qpc_bits *qpc = MLX5_ADDR_OF(rst2init_qp_in, in, qpc);
+
+	MLX5_SET(rst2init_qp_in, in, opcode, MLX5_CMD_OP_RST2INIT_QP);
+	MLX5_SET(rst2init_qp_in, in, qpn, dev->qpn);
+
+	MLX5_SET(qpc, qpc, primary_address_path.vhca_port_num, 1);
+	MLX5_SET(qpc, qpc, pm_state, MLX5_QPC_PM_STATE_MIGRATED);
+	MLX5_SET(qpc, qpc, rre, 1);
+	MLX5_SET(qpc, qpc, rwe, 1);
+
+	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	dev_dbg(dev->device, "QP RST->INIT\n");
+}
+
+static void mlx5st_qp_init2rtr(struct mlx5st_device *dev)
+{
+	u32 out[MLX5_ST_SZ_DW(init2rtr_qp_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(init2rtr_qp_in)] = {};
+	struct mlx5_ifc_qpc_bits *qpc = MLX5_ADDR_OF(init2rtr_qp_in, in, qpc);
+
+	MLX5_SET(init2rtr_qp_in, in, opcode, MLX5_CMD_OP_INIT2RTR_QP);
+	MLX5_SET(init2rtr_qp_in, in, qpn, dev->qpn);
+
+	MLX5_SET(qpc, qpc, mtu, 3);
+	MLX5_SET(qpc, qpc, log_msg_max, 20);
+	MLX5_SET(qpc, qpc, remote_qpn, dev->qpn);
+	MLX5_SET(qpc, qpc, min_rnr_nak, 12);
+	MLX5_SET(qpc, qpc, primary_address_path.vhca_port_num, 1);
+	MLX5_SET(qpc, qpc, primary_address_path.fl, 1);
+
+	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	dev_dbg(dev->device, "QP INIT->RTR (fl=1)\n");
+}
+
+static void mlx5st_qp_rtr2rts(struct mlx5st_device *dev)
+{
+	u32 out[MLX5_ST_SZ_DW(rtr2rts_qp_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(rtr2rts_qp_in)] = {};
+	struct mlx5_ifc_qpc_bits *qpc = MLX5_ADDR_OF(rtr2rts_qp_in, in, qpc);
+
+	MLX5_SET(rtr2rts_qp_in, in, opcode, MLX5_CMD_OP_RTR2RTS_QP);
+	MLX5_SET(rtr2rts_qp_in, in, qpn, dev->qpn);
+
+	MLX5_SET(qpc, qpc, log_ack_req_freq, 0);
+	MLX5_SET(qpc, qpc, retry_count, 7);
+	MLX5_SET(qpc, qpc, rnr_retry, 7);
+	MLX5_SET(qpc, qpc, primary_address_path.ack_timeout, 14);
+
+	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	dev_dbg(dev->device, "QP RTR->RTS\n");
+}
+
+/*
+ * Post RDMA Write WQE
+ */
+static void mlx5st_post_rdma_write(struct mlx5st_device *dev, u64 src_addr,
+				    u32 src_lkey, u64 dst_addr, u32 dst_rkey,
+				    u32 length, bool signaled)
+{
+	struct mlx5st_send_wqe *wqe;
+	unsigned int idx;
+
+	idx = dev->sq_pi % SQ_WQE_CNT;
+	wqe = &dev->sq_buf[idx];
+
+	memset(wqe, 0, sizeof(*wqe));
+	MLX5_SET(wqe_ctrl_seg, &wqe->ctrl, opcode, MLX5_OPCODE_RDMA_WRITE);
+	MLX5_SET(wqe_ctrl_seg, &wqe->ctrl, wqe_index, dev->sq_pi);
+	MLX5_SET(wqe_ctrl_seg, &wqe->ctrl, qp_or_sq, dev->qpn);
+	MLX5_SET(wqe_ctrl_seg, &wqe->ctrl, ds, MLX5_RDMA_WRITE_DS);
+	if (signaled)
+		MLX5_SET(wqe_ctrl_seg, &wqe->ctrl, ce, MLX5_WQE_CE_CQE_ALWAYS);
+
+	MLX5_SET64(wqe_raddr_seg, &wqe->raddr, raddr, dst_addr);
+	MLX5_SET(wqe_raddr_seg, &wqe->raddr, rkey, dst_rkey);
+
+	MLX5_SET(wqe_data_seg, &wqe->data, byte_count, length);
+	MLX5_SET(wqe_data_seg, &wqe->data, lkey, src_lkey);
+	MLX5_SET64(wqe_data_seg, &wqe->data, addr, src_addr);
+
+	dev->sq_pi++;
+
+	/* Ensure WQE is visible to device before doorbell record */
+	dma_wmb();
+
+	WRITE_ONCE(dev->qp_dbrec.send_counter,
+		   cpu_to_be32(dev->sq_pi & 0xffff));
+
+	/*
+	 * Ring doorbell: write first 8 bytes of ctrl to UAR BF register,
+	 * iowrite has an internal dma_wmb() so the doorbell record will be
+	 * visible.
+	 */
+	iowrite64be(be64_to_cpu(*(__be64 *)wqe),
+		    (u8 __iomem *)dev->uar_base + dev->uar_bf_offset);
+	dev->uar_bf_offset ^= MLX5_BF_SIZE;
+}
+
+/*
+ * Poll CQ
+ */
+static int mlx5st_poll_cq_batch(struct mlx5st_device *dev,
+				unsigned int max_cqe)
+{
+	unsigned int polled = 0;
+
+	while (polled < max_cqe) {
+		unsigned int idx = dev->cq_ci % CQ_CQE_CNT;
+		struct mlx5st_cqe64 *cqe = &dev->cq_buf[idx];
+		u8 owner, opcode;
+
+		owner = MLX5_GET_ONCE(cqe64, cqe, owner);
+		if (owner != ((dev->cq_ci >> LOG_CQ_SIZE) & 1))
+			break;
+
+		dma_rmb();
+
+		opcode = MLX5_GET(cqe64, cqe, opcode);
+
+		dev->cq_ci++;
+		WRITE_ONCE(dev->cq_dbrec.recv_counter,
+			   cpu_to_be32(dev->cq_ci & 0xffffff));
+
+		if (opcode == MLX5_CQE_REQ) {
+			dev->sq_ci =
+				(u16)(MLX5_GET(cqe64, cqe, wqe_counter) + 1);
+			polled++;
+			continue;
+		}
+		if (opcode == MLX5_CQE_REQ_ERR ||
+		    opcode == MLX5_CQE_RESP_ERR) {
+			dev_dbg(dev->device,
+				"CQE error: opcode=0x%x syndrome=0x%x vendor=0x%x\n",
+				opcode,
+				MLX5_GET(cqe64, cqe, error_syndrome.syndrome),
+				MLX5_GET(cqe64, cqe,
+					 error_syndrome.vendor_error_syndrome));
+			return -1;
+		}
+		dev_err(dev->device, "CQE unexpected opcode=0x%x\n", opcode);
+		return -1;
+	}
+
+	return polled;
+}
+
+static int mlx5st_poll_cq(struct mlx5st_device *dev, unsigned int timeout_ms)
+{
+	struct timespec start, now;
+	unsigned int elapsed;
+	int ret;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	for (;;) {
+		ret = mlx5st_poll_cq_batch(dev, 1);
+		if (ret < 0)
+			return -1;
+		if (ret > 0)
+			return 0;
+
+		if (dev->have_eq)
+			mlx5st_process_events(dev);
+
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		elapsed = (now.tv_sec - start.tv_sec) * 1000 +
+			  (now.tv_nsec - start.tv_nsec) / 1000000;
+		if (elapsed > timeout_ms) {
+			dev_err(dev->device, "CQ poll timeout after %u ms\n",
+				timeout_ms);
+			return -1;
+		}
+	}
+}
+
+/*
+ * Data path setup/teardown helpers
+ */
+
+static void mlx5st_setup_datapath(struct mlx5st_device *dev)
+{
+	mlx5st_create_cq(dev);
+	mlx5st_create_qp(dev);
+	mlx5st_qp_rst2init(dev);
+	mlx5st_qp_init2rtr(dev);
+	mlx5st_qp_rtr2rts(dev);
+}
+
+static void mlx5st_teardown_datapath(struct mlx5st_device *dev)
+{
+	if (dev->qpn) {
+		mlx5st_destroy_qp(dev);
+		dev->qpn = 0;
+	}
+	if (dev->cqn) {
+		mlx5st_destroy_cq(dev);
+		dev->cqn = 0;
+	}
+	dev->sq_pi = 0;
+	dev->sq_ci = 0;
+	memset(&dev->qp_dbrec, 0, sizeof(dev->qp_dbrec));
+	memset(&dev->cq_dbrec, 0, sizeof(dev->cq_dbrec));
+}
+
+/*
+ * memcpy callbacks
+ */
+
+#define MLX5ST_MEMCPY_TIMEOUT_MS 60000
+
+static void mlx5st_memcpy_start(struct vfio_pci_device *device,
+				 iova_t src, iova_t dst, u64 size, u64 count)
+{
+	struct mlx5st_device *dev = to_mlx5st(device);
+	u64 i;
+
+	for (i = 0; i < count; i++) {
+		bool signaled = (i == count - 1);
+
+		mlx5st_post_rdma_write(dev, src, dev->global_lkey, dst,
+				       dev->global_rkey, size, signaled);
+	}
+}
+
+static int mlx5st_memcpy_wait(struct vfio_pci_device *device)
+{
+	struct mlx5st_device *dev = to_mlx5st(device);
+	int ret;
+
+	ret = mlx5st_poll_cq(dev, MLX5ST_MEMCPY_TIMEOUT_MS);
+	if (ret) {
+		/*
+		 * CQE error puts the QP in error state.  Rebuild the data path
+		 * so subsequent operations can succeed.
+		 */
+		mlx5st_teardown_datapath(dev);
+		mlx5st_setup_datapath(dev);
+	}
+	return ret;
+}
+
 /*
  * Driver ops callbacks
  */
@@ -1368,6 +1716,11 @@ static void mlx5st_init(struct vfio_pci_device *device)
 	mlx5st_alloc_pd(dev);
 	mlx5st_create_mkey(dev);
 
+	mlx5st_setup_datapath(dev);
+
+	device->driver.max_memcpy_size = 1 << 20;
+	device->driver.max_memcpy_count = SQ_WQE_CNT - 1;
+
 	dev_dbg(device, "mlx5 driver initialized\n");
 }
 
@@ -1375,6 +1728,8 @@ static void mlx5st_remove(struct vfio_pci_device *device)
 {
 	struct mlx5st_device *dev = to_mlx5st(device);
 
+	mlx5st_teardown_datapath(dev);
+
 	dev_dbg(device, "teardown: destroy_mkey\n");
 	if (dev->mkey_index) {
 		mlx5st_destroy_mkey(dev);
@@ -1400,7 +1755,7 @@ struct vfio_pci_driver_ops mlx5st_ops = {
 	.probe = mlx5st_probe,
 	.init = mlx5st_init,
 	.remove = mlx5st_remove,
-	.memcpy_start = NULL,
-	.memcpy_wait = NULL,
+	.memcpy_start = mlx5st_memcpy_start,
+	.memcpy_wait = mlx5st_memcpy_wait,
 	.send_msi = NULL,
 };
-- 
2.43.0


