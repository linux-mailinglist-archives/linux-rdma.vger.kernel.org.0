Return-Path: <linux-rdma+bounces-17433-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GkYM8g7p2mofwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17433-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:51:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9FF1F6645
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88751304B996
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 19:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7264238425D;
	Tue,  3 Mar 2026 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c5AgiFsX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D2B37C932
	for <linux-rdma@vger.kernel.org>; Tue,  3 Mar 2026 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567425; cv=fail; b=NggMM1271czl3NSapb2f5HvfCkCgRSEJ0GCxvEEUxUadaiRoWcDKtbLVxQbvlSjj9b+BBUtvNCSgFIz2XYEYi1QhphYAL3rvmA4qETQNO1PZFfLw2r8rZXWMnc4bKDuju1EWKHRedUVoyXaE3Iisaba7vAbXS6Hw0eZKKEDG4Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567425; c=relaxed/simple;
	bh=lB4kH6sYMZ3W5qTvQs6PJJ5RDlDSS8NSukbb+WSqRUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wgc6ZTDzoFjMsVzh0nh0UxQk8I7/GM0KdXaMia8B/eEHeFEHiaHks1s7pgEBGKDgtDofHlkaRCHw/Iwx0mWES67XlHyNNWlqxyffRf48tm7bCHGDFv8AHX4wBMMDz6iq5dcxTHcSNphu0bXkQ9Fbu1fkc4hX11KaauQsky3cOvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c5AgiFsX; arc=fail smtp.client-ip=52.101.85.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vE37zg2eO9q7/j8Qa0NxlLnyVMaOwcMOpuLbks8KVKt+D+KkfNmZfQCgMqCYmp+ipkDPJF/fjsXizL5+61WDVveDsAbAk2OyGxe6w2l5a+C/iewZGQcEyRjtavn+BjZldqIoTN8WU6XTjxjER9achnrDEnrzB5NpS0oB/tk84vnJ/3js9+NilIeejrysXWkVVqUqp859t1qOrdaQQ1SSdrPRPZQAjxUcVhEJ58ZEHvdKz7CWBGJ8zcNHvL/73/IW1OhsbWrSV50GoYvnrRayA85MJgAmetAH7TI4+/SITw8jwGb6qGl6jk7S1oj1b/Xc9hSEjL6FslU3d2MmTbqbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXmT9aYIfZwBd5de8hOOcguNZSjIvcZXCCOJPzq6u9U=;
 b=QNgjczq2T8j4NkZBLqj3b0b4yP/xl0AGWrMi6gRtB5BkyLivbHLwkrVUG1Pnc1C7bBifeEYFsDFGNu0UsSvHUZksoLT0aBxLFzHjba7+4NdEYt6GCQXLqYDbrJnye5DgrnM4iW0F8nAKKtf2cipp7Cc9hQYLKxUWcfWOHt51Z1/Wxly7JYWVvBu6zVHhOeMeu+t3otGDVcB7l78NkogrYeAdFo4iRO7YFLT9FO1pEhc2cFYl3MLOLeFmZnWZUbD1zRZ7R7V3rkguaJHndYb1BaRO/neqDZJHLxyE3kvC7NSReNo4qJEkJsU0F+zH02PQZsNbe9ztMnRnHC5J5iun9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXmT9aYIfZwBd5de8hOOcguNZSjIvcZXCCOJPzq6u9U=;
 b=c5AgiFsXjfgMY13jLJMnzS3nbpUhUmd2Dg0AVEBO2AHfwQq9G+NqAfr8Va9qM+lQty6DL0kSZP6m3Otm66MBJ/nDVyRpPB7TwkMF+8j407nXooQrV9lpLJPpjaXDlQ5YK1pLaakhYS5TlBOUQxJjJM9FItYANalFiVYLPqaqBPfWorRK7HqCOPykblyZ1EBmxKPtmissftyO7YbdtI4rDUaXmR8QHl9AQDaE6/UZpLE8ThPXnP0Uxxv6BdEuz8oHraDABHcAjfnzE8ks+21ta4XWz+Nf/BrpGEhKiDRIZwntlGQnIj81QuKw5Ff2G7WY8NLNHulDsHbnOQ2fzlkS4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 19:50:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 19:50:16 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v3 09/13] RDMA/bnxt_re: Add compatibility checks to the uapi path for no data
Date: Tue,  3 Mar 2026 15:50:06 -0400
Message-ID: <9-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2aa2af-a6c3-49c8-ac39-08de795e1527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	AKBnbrt88XI9PUmMGdeXlY0XU4i9ydRStQt1wmTmnz8JO74OEzK1gifiIlKd0WU2AWNsBF2y3XpO1WwgOnOhHc3M/HASApsyuNRqKNiHqyyVwqkOvsdKT1aq1x6y0iKvQ9NHPrwW1+72aCdlmyHrYWHPQ0AuQDiGACUL8viHdr/qEoDbE5MJ2k7YCu9lFaGvbt3HpXdpI4hG5LK2MMHTuWmDync9NcBNdrlEVGzAWVoYickeTj463h+ZovUmVlEudRrkGY9OtxJDL5q/wvZv+Sdmm+g/mWrqXHHMoEBvXenak7lOwo9yaPtTADVBY5pOexGBIi3Hvws2NSk/HVhJHpgpkpF6ozpwfW5pVqYSRuWB5E8O4tq4c7b2xgtt6ryP9WwgGEJ708GVs22rQ+OxStkg/48TnCdbzfGHQPMmOQdeEqvMnyZutgEFbWDmrUSVlIexXbT9HYVP5yMrvy+vpiamn9KYMCZPLHorUhxmbPPto8aGAazA1AuBd8RfleXSzyDElAvd99GjMMmHFhR5RAXYc1uZul344jXIBqU6kLkKujQpgG0O3lyFvhM5NJjy8RqB97N8fsH7HAL/Z4TX3XBhUN4Rwjp6prBzQRXc8zFQd9xYP9p+CZdwvuSz/4Rv96laryy87csXFYKR/+wCqV14FuBTxfMj2DjyC7OuordiF401rY9o6WBI2gFecANpaguYPl7xn1uqbNdZ+f4i2xLKHro6dat16/4gxmPptXk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1GZqGjSBSWnaP0gORJcWvWhysL/SaQEvPNx9w+lUs5fwC3WBSXNIXyk63vUZ?=
 =?us-ascii?Q?Oqk1tjdT5uy3KDnlo0FRNmJisW0ZmPWjD7dd6uQYNAKz480XsZBztfpX03Gy?=
 =?us-ascii?Q?Ao75z0qYl94w96QXaVoZ6sw7cTSPbnLREPBj4CEl0H4KgtZhEaD+HSvBDLGm?=
 =?us-ascii?Q?yB+M4SIycKmeWtUpLsIaod3yFA9T6GuFRVZ4JcbRL56pXpZB79jufQzac3mD?=
 =?us-ascii?Q?I/X0sDUfGhG/4VfcMAzLPUGtfe76YzPxYAbjBvoHSaQUXkHS8pvuaVYuDV6F?=
 =?us-ascii?Q?qy9ir34CiexaOmzthwWmOrCbbEgS3qnghHnQZTpdkHG7rbQHp29BSZd/eMMQ?=
 =?us-ascii?Q?vKI8OwKDZLsiCa13RoCmUHB+6vSj5s3/pugYB350S7fGSSiMskq3wBZhq9fh?=
 =?us-ascii?Q?n5PxbwZewNfuU612VdwMlEJ99w7fsHOhbryqa0awc6t/lkTXRqrgiAa678Uf?=
 =?us-ascii?Q?9ngOjdcXG/St/yU+iXNPlJIoTLUi3T0YGkPTh7AehQCyH9ILyBOb02U3Yuqh?=
 =?us-ascii?Q?rwmhPcxWMXOb7CwyUZyPBju5+M8JhYmjORvLuUBEHjm/le/sUMoqpuC/+lIS?=
 =?us-ascii?Q?sV8PFBaxx8+DPbScpG6vlxmgCVB27skLbOzvYnvoBBrK+P9PKWauoEpDq5a5?=
 =?us-ascii?Q?4IcUU0fbUWdCX298yK3rsUwiyDSF7bUxIxCSUFjIbGxONTXXH/fthwdSlUUY?=
 =?us-ascii?Q?QztnLnzY3lyN/wDhml/eJk0N5wdLPnxYzaSSDCF+yJDjVsKIKDqhKTC4vws7?=
 =?us-ascii?Q?brKQbwAwOk61Vafn7ahARKOjmpBUEQMx8LpIiWnhUkLknlf7aoN+pzNeA2vM?=
 =?us-ascii?Q?u1f1uxdKouaYGd2rRMRxCKXivOJw1hDxgdu3tsdoKy2lHtnM77qLhJdCTOZ6?=
 =?us-ascii?Q?BwoU9RMesGt2gCHEvfnYlzc3dBRjsU1aQ6TrUg41XO+hqZdtG2qAC6IVLBvZ?=
 =?us-ascii?Q?jHQ/moCOJE7/iZIT8LXHxQyjd3XTTE0OpP5Z3w3sQLwhJvA5r89OYML23wLy?=
 =?us-ascii?Q?YfRS/79XjNmfbDRoZ2i8exaeRP18awVjW7KwWs0BRs9UM0QRiQpxrSgm4nKF?=
 =?us-ascii?Q?xFsZ36JV4SBdG7JMuD+16IB4svGNuqF02L0Lv3+Mp/GEO6Q7b0iYsbJht5va?=
 =?us-ascii?Q?kofUGyHGjMx/5wNGXzIfuiS4kKhHoeLzBlkxVSrnMJKRpUDEQEdbkZkmSK1k?=
 =?us-ascii?Q?dwGrZGvo1YBU2Od524oJedPtt7ic54CsdbYD7G/C9t/uOPFQyDC+UN047Hk2?=
 =?us-ascii?Q?Q8SdUuAP1eZ82bn0bmUAg5JNfU6hrEpRQNotMjcp0I0b9eWCFOyVgB+T+1l8?=
 =?us-ascii?Q?I8nvmGuapOZDIKxY2v6IzYLKBX93oZqucJLGlhS97u+yV1CPsfedGzfvKdKr?=
 =?us-ascii?Q?aGzFRGwS1T2nJq9JxAgYocnjQXsWzc44ezmZytbfQXrNU58dUdWzPkSKSZ05?=
 =?us-ascii?Q?GwNQ7jaujqKLIjOh/PmvfBCwbkifD4QnbUURRVAG14Ej8oDbv1hhGF79txlz?=
 =?us-ascii?Q?n/eg8zbCk0RT0ge/kuOrrguZCmU4KPz+TeWfSamSdK2ovECawodERPbuMNDZ?=
 =?us-ascii?Q?C/gMVS0IOTUsBlqoKJu7UqIkB+2sAtOSOxSZbb2aTXb/iCoo/+xCbxInQRNv?=
 =?us-ascii?Q?0+SV9BAJJGEz1kXjaGhuyZDB31S4b/0u3cOgoIhjaQmKZCfeiBGK67hr+jnj?=
 =?us-ascii?Q?PooHWP9MLADBGTxZN3jekhKtC3v+HAjA72b5d1hH/nRGflmyWeV/5Pd0bA3v?=
 =?us-ascii?Q?zH3F+LFjZg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2aa2af-a6c3-49c8-ac39-08de795e1527
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 19:50:12.5398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4WzjHi6H/+nPeNMK9qsPjc0wtPTn0kH+bE4w4nvquPOjnY9PEmc6m5af9yC6pz4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
X-Rspamd-Queue-Id: AD9FF1F6645
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17433-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,broadcom.com:email]
X-Rspamd-Action: no action

If drivers ever want to go from an empty drvdata to something with them
they need to have called ib_is_udata_in_empty(). Add the missing calls to
all the system calls that don't have req structures.

Tested-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Acked-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 57 ++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index e1d72ae8261192..6d751febb28c8b 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -190,6 +190,10 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 	size_t outlen = (udata) ? udata->outlen : 0;
 	int rc = 0;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return rc;
+
 	memset(ib_attr, 0, sizeof(*ib_attr));
 	memcpy(&ib_attr->fw_ver, dev_attr->fw_ver,
 	       min(sizeof(dev_attr->fw_ver),
@@ -692,6 +696,11 @@ int bnxt_re_dealloc_pd(struct ib_pd *ib_pd, struct ib_udata *udata)
 {
 	struct bnxt_re_pd *pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
 	struct bnxt_re_dev *rdev = pd->rdev;
+	int ret;
+
+	ret = ib_is_udata_in_empty(udata);
+	if (ret)
+		return ret;
 
 	if (udata) {
 		rdma_user_mmap_entry_remove(pd->pd_db_mmap);
@@ -720,6 +729,10 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	u32 active_pds;
 	int rc = 0;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return rc;
+
 	pd->rdev = rdev;
 	if (bnxt_qplib_alloc_pd(&rdev->qplib_res, &pd->qplib_pd)) {
 		ibdev_err(&rdev->ibdev, "Failed to allocate HW PD");
@@ -834,6 +847,10 @@ int bnxt_re_create_ah(struct ib_ah *ib_ah, struct rdma_ah_init_attr *init_attr,
 	u8 nw_type;
 	int rc;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return rc;
+
 	if (!(rdma_ah_get_ah_flags(ah_attr) & IB_AH_GRH)) {
 		ibdev_err(&rdev->ibdev, "Failed to alloc AH: GRH not set");
 		return -EINVAL;
@@ -995,6 +1012,10 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	unsigned int flags;
 	int rc;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return rc;
+
 	bnxt_re_debug_rem_qpinfo(rdev, qp);
 
 	bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
@@ -1843,6 +1864,11 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 					       ib_srq);
 	struct bnxt_re_dev *rdev = srq->rdev;
 	struct bnxt_qplib_srq *qplib_srq = &srq->qplib_srq;
+	int ret;
+
+	ret = ib_is_udata_in_empty(udata);
+	if (ret)
+		return ret;
 
 	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT) {
 		free_page((unsigned long)srq->uctx_srq_page);
@@ -1992,6 +2018,11 @@ int bnxt_re_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr,
 	struct bnxt_re_srq *srq = container_of(ib_srq, struct bnxt_re_srq,
 					       ib_srq);
 	struct bnxt_re_dev *rdev = srq->rdev;
+	int ret;
+
+	ret = ib_is_udata_in_empty(udata);
+	if (ret)
+		return ret;
 
 	switch (srq_attr_mask) {
 	case IB_SRQ_MAX_WR:
@@ -2109,6 +2140,10 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 	unsigned int flags;
 	u8 nw_type;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return rc;
+
 	if (qp_attr_mask & ~(IB_QP_ATTR_STANDARD_BITS | IB_QP_RATE_LIMIT))
 		return -EOPNOTSUPP;
 
@@ -3126,12 +3161,17 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	struct bnxt_qplib_nq *nq;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_re_cq *cq;
+	int ret;
 
 	cq = container_of(ib_cq, struct bnxt_re_cq, ib_cq);
 	rdev = cq->rdev;
 	nq = cq->qplib_cq.nq;
 	cctx = rdev->chip_ctx;
 
+	ret = ib_is_udata_in_empty(udata);
+	if (ret)
+		return ret;
+
 	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
 		free_page((unsigned long)cq->uctx_cq_page);
 		hash_del(&cq->hash_entry);
@@ -4078,6 +4118,10 @@ int bnxt_re_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	struct bnxt_re_dev *rdev = mr->rdev;
 	int rc;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return rc;
+
 	rc = bnxt_qplib_free_mrw(&rdev->qplib_res, &mr->qplib_mr);
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Dereg MR failed: %#x\n", rc);
@@ -4186,6 +4230,10 @@ struct ib_mw *bnxt_re_alloc_mw(struct ib_pd *ib_pd, enum ib_mw_type type,
 	u32 active_mws;
 	int rc;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return ERR_PTR(rc);
+
 	mw = kzalloc_obj(*mw);
 	if (!mw)
 		return ERR_PTR(-ENOMEM);
@@ -4313,6 +4361,11 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 	struct bnxt_re_dev *rdev = pd->rdev;
 	struct ib_umem *umem;
 	struct ib_mr *ib_mr;
+	int ret;
+
+	ret = ib_is_udata_in_empty(udata);
+	if (ret)
+		return ERR_PTR(ret);
 
 	if (dmah)
 		return ERR_PTR(-EOPNOTSUPP);
@@ -4497,6 +4550,10 @@ struct ib_flow *bnxt_re_create_flow(struct ib_qp *ib_qp,
 	struct bnxt_re_flow *flow;
 	int rc;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return ERR_PTR(rc);
+
 	if (attr->type != IB_FLOW_ATTR_SNIFFER ||
 	    !rdev->rcfw.roce_mirror)
 		return ERR_PTR(-EOPNOTSUPP);
-- 
2.43.0


