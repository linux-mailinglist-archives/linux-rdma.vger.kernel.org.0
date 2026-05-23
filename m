Return-Path: <linux-rdma+bounces-21181-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIKTJJ/wEGo+fwYAu9opvQ
	(envelope-from <linux-rdma+bounces-21181-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 02:11:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D90775BBB02
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 02:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85951300980F
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 00:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6184A33;
	Sat, 23 May 2026 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jBIRV6Su"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1495D23741
	for <linux-rdma@vger.kernel.org>; Sat, 23 May 2026 00:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495063; cv=fail; b=OBpcnGGQ3U5twSBsi4+dH+CES7S73jjWDphXUoH/o2+Ptyq5LsSC06g+gAaLh9pVO2/JUfp0Xi57kXcqrQxngK2FUSM0AXHW0VuzyJ0r+uaTIueK7lT01eD03fJj+AotlrTWKnvRPq8trtgYyhYTKdygVe/1wau6BYLlVDCH3mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495063; c=relaxed/simple;
	bh=ui7LzcpILBeAHlKUoGomdndN4Zo0b31uUu4f8RA+C+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tmAErO1WSzLsxS8dtQc2eBKS3BFAIO2DuJxA6u2hQPxKVQ2VsfvBa6EeEzO9EN6Kg3fX1qXXe3RsmgYSegoOffvs50UcqbhVvP5EXZWnXWt4Y0rgRWsS/GPeihXK98ddMy9rAh7gqmoie5rwUkdTPh7vW2/wQ5vCxzAyhVWAeck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jBIRV6Su; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SW83NnFXYjWcSB0GJYgCEmVwE2QNtav1uMbqWy7a+XfQfbUm6lSrZDrbQscQNvRW61ljhg4KIvkkM2iUSZZY+CF0SO0oLG2WXstMSuP6CMewcHQLFyYWLqWUSSj8u2dveVqNlXudMXmVmnLUxbzcH4gRq3n9dYv5rKzSsY8wgPfHkdYPcdDeFlKp0ntvJwb5rdgt4XLIwKrG5bFOFUSy7LwT6UlyWG7kpd2Uzvv2fEKiMuGu2003jlxlF2f3lmBr90MUBwLv8KvqA0X0GHD6ZVx4A2HqUUxN78bvxb8wJGLsecy5HAbPEA06cVifthLnFz+D8cU8OkvbxXGeuaE1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gf+UPToKhdc0O3MvYrKVTLZKqLTsyu4iWrDC2L6vjhY=;
 b=LCh30XtbJqcWvldEE+h4BPMVSKopWbwhovUKa7ePTzHhMK8cAIsAX6oz8In8e86FXdR6tMOcBLaPgY7Pt3zBeBVFhYwALZZihLs8gRhFKrQVZ3/VtUxgFmM3sgk58RhfrXjfBdYi6xVhb5hvEYzd2kkDt+ES7McLsosbQ5XDCxEuCbi/18OSLj0pChgIMHoZPiNpAWQvtdy+m1UlUQZqxoFy1dSOPSyUQgLiwXhDd0btGWGSfnawQZq9VGPaxVHS/5HJw/OkCg5Byob+TcsdYwdcDqS3/NETXiz7v053hmMsxtcayLW8KBExrU+QhVm8w1b+EpUslo63bzCzVNL1Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gf+UPToKhdc0O3MvYrKVTLZKqLTsyu4iWrDC2L6vjhY=;
 b=jBIRV6SuFNiJ1jdfAyoFH1VzGbG5eCR4NEv3y1UPeZBYdk0//LSIZ8PWwj+ZbpnYr28Sk+0NAQBn6WBNAfZ/OTkvHHeJOUdYPY9aFakeMe48sErZpiL1egToqaIUcmRX/jg8XGhLVjayxga3W9RgVvBhcnoFQsVEnl3KwTt9Ae0zT83meXcRMUVDqomc1qkaXCcEf2KYZX/4W/aaVro2SWmrB4oAspB6klKanHM/uHmpyEnzJQM/MMgZKgZugyF80RPyA4FbJkciipsMAYQTK2rXKCKXe2Ju08d4uljf2/zbgzQ8C+drnk0vsHGZVfI168Byl+iQW8YMUigFcl0j7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 00:10:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 00:10:55 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	patches@lists.linux.dev
Subject: [PATCH v2 6/6] RDMA/core: Move flow related functions to ib_uverbs_support.ko
Date: Fri, 22 May 2026 21:10:53 -0300
Message-ID: <6-v2-4a21959414f2+3d7-ib_uverbs_support_ko_jgg@nvidia.com>
In-Reply-To: <0-v2-4a21959414f2+3d7-ib_uverbs_support_ko_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:52c::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dff873b-a288-44bd-5124-08deb85fc20e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	nFFbPtVexMAgnaoSV70kVr06VXpsmwvMsfK62L8jrz1K5AfxZfH2cDiQR7jNmfLIDQAvLDwtrNyXOd+OErmkfb7nApL+o01rrVa5D6hXUAerR30WbLV7PNQmKGikaa39hvJY/il+/kiALsrU8bL4Ccxf8/QNpUSWK8F6PQqMV7abMSMb7OQIKlcqdQX17eNxpWuGKO1usu5wN3FcCbb3suKvrq2nOImk5JikjzF4OzlXhrE1BhVjf91m+QUD8lWIkn5QsWjvT3oLYb6+kCtbLetIid9cudC2D2OjwtuXjgtJIUiTIvQGibHFfIi/2nlzhSMxmEpz2Q5l3FgFf0/9OXX8oLkLefKRByKXBrsSoazbgxxLVkWmQs8HxLcyIJ34lysL7o4be0K/hPHgck5u71uiX1U+8qdR4MmDSHtonaeGdN469vtX/Yy0jNlkU2kzRItGaSa1NtSY/nMO7qAzR97TbmB6JmuJICmBZa70nh+IXnAzb/nk7rgvnwDFeyKP2HR/EYy17F0yPvE7RHqxlyFe55H2wvHtzrj/DOCDWc8LNJq+4CWGzu+ksKvdsrJZ758FivKFd5ojSbEV/ZHhwdftleHDYh+/ZuiuXYqawdGe3owG77hoYh7N2BcwgbiL6/N/R7e3TGcufsaivCIpWfdQB5VODG0KwSI4ixpSIb4jsqrKO5E2uDxjHk7hbYQE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GlVjEGCiU9wisLgZbR/cJOVbEzOM7EspyhhVtAnj+kRpMtlYpWbVUwIPFsYV?=
 =?us-ascii?Q?ELihItyGpP2RB3huOQU/QiSsJBKLanADYkzfwIeZNFmMBRWE5VkHl2m0FhOe?=
 =?us-ascii?Q?OR2Bl0S+lyiXH8rvvAUqPK3t0boYpFetatlSkEDOJBoVXPtuG85oGy37Vpb+?=
 =?us-ascii?Q?QgZDWEHRPAPRIetIzWeoByXiDLU9APz2016DlzSbWCCyACxiTE0Hg5MwwHfV?=
 =?us-ascii?Q?TzMqHOD9jvRbIFyuzXOyarUd9LZC2n8mukP0qlYy3fuormPRo4iL/AhRC4em?=
 =?us-ascii?Q?EZDr+WnGooGcYUG0Z+XuB8aQ9KU5j2D3u7FEl3cSjFM1okISGTdTvDf1lb6h?=
 =?us-ascii?Q?S4TdbF9WwVPJEbFEagyecyKwXAKtMmndUKMpoewCusPKz/drYg0gHm3g4oo1?=
 =?us-ascii?Q?Kcu1b1RHb8nrjAaZcIl2Bxkz6vGIRKMqTIXcfMPpgGHHzyJ9zM3p3H2knLbU?=
 =?us-ascii?Q?r3FW5yWXcNsyaSJYjuXhwa8ox+sAAMZipYwOK4t4odF2k12Ak41baITeqQWi?=
 =?us-ascii?Q?6wWmcFTWjfenEBx5CAA2Bv2pSUwLtAAag1IH3lSETYycWQRJpY+FqDXprY6X?=
 =?us-ascii?Q?rvBddmIEyfyFfb4x8xhL1ejJm2/2v9jkWdR1usJTCMZ3vn162+radx2VKer2?=
 =?us-ascii?Q?8AWoAkhm7LTjjnP++SE5IP8YBF4CoesI7+t66yKsWZY+J4IhN3Z9iZzEvpk3?=
 =?us-ascii?Q?TxQdSBz71Ggy0/kfYLFXWiz5bLtzD6uk1Fder8BYmgHBfMn8x0DRG3VuHC/A?=
 =?us-ascii?Q?hHrdRLTb4x0s9tckiyLbCwblmfgYxr9/VVtmv1QxyI/UmhO7L8hOb7N7nS8C?=
 =?us-ascii?Q?oBTplj0juOfGNeXnFXLu3KsOAeN1VX7VHCRmbuQt+8MGDMDUPZrhsUc3HMO+?=
 =?us-ascii?Q?RXcv5yz3VcAXOpbfmd7KevlYxe+XiuQeIFBvsvr9C24d58U30yWjpdakbvBN?=
 =?us-ascii?Q?YA30nUe/0S98gyPTr7o5H7DyZi/mGGTH8ZRZo/QR4o3zmp7ZEgqyNH8B6S9Z?=
 =?us-ascii?Q?aI7HEIti4xI1HoF98TshOMGjTWj6eslT6tLcBx+6iD8woc2FCwSZzS2ITvpp?=
 =?us-ascii?Q?WGNmt8rlA332raG5pC8/LcSQZ9wQ0fPDofrJVXIz/SwVX1YMCVKfTGIBo0py?=
 =?us-ascii?Q?ifu5X3phB7q3qg5rAFwLcKD5sJ2ddanXqythVHByNakzIM2LshxGGCntufGR?=
 =?us-ascii?Q?o9VN9s634kkiP0EwKtjy9Uww6ASmNrCFkX/NLOj5ivhGKY8d5ejIKgFlCPSr?=
 =?us-ascii?Q?BhZ64kWJrkyAYAR/P2vKJQ/PZ+S+whMbJKB1gKj/7WWt7xC/OQTil1DSHVuo?=
 =?us-ascii?Q?swGcaDf2H49HmlAAWPQpg0NyRVj/8vQEXLlBIS+3mT3SNFpg8Ptn06TxDiY2?=
 =?us-ascii?Q?OSLrRtOGhmC64f2ndS42ixEGDwmU5bhcahq8J51/XhYDn3dCcu+vZI4VlwXB?=
 =?us-ascii?Q?01L09RAl3PTN+HkN8q0aySs+9GOOGM+vIHl/Uzoc1zv7dBnaRv++0qFrIoCC?=
 =?us-ascii?Q?ps0gd3mQAAINWOCSItw8fgn62FUTr1HiSVO+SdjzAruEvegkFysHINfQSx5o?=
 =?us-ascii?Q?BwdWfVAOG9iZFR5Xrzuc/1zkGYwFD23xZNkor8laR0NKaYHGidsUcsKRNnEF?=
 =?us-ascii?Q?lBRfGlDOl8ArmhXJyNr4ri3FVoWhVsHmD1UZCM2lWVj91ooFlHwFGNRjne5p?=
 =?us-ascii?Q?e4zRJH78N4mpyV368YtlwpYQxuzf1BzNSHwAFquBQ1fUfFCw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dff873b-a288-44bd-5124-08deb85fc20e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 00:10:55.2198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zoj+KkPFF7g/3dGGrOhxDQhc6J8hB842PYPhluDXwAHEiNiLGyXYv2moJA/u+H/V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21181-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D90775BBB02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mlx5 uses these as part of the driver implementation, move them to the
support module instead.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/Makefile      |  3 +-
 drivers/infiniband/core/uverbs_cmd.c  | 76 --------------------------
 drivers/infiniband/core/uverbs_flow.c | 78 +++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 77 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_flow.c

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index 263129a23050aa..a0d9910638a00c 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -49,4 +49,5 @@ ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
 				uverbs_std_types_qp.o
 
 ib_uverbs_support-y :=		rdma_core.o \
-				ucaps.o
+				ucaps.o \
+				uverbs_flow.o
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 91a62d2ade4dd0..32914007bae66f 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2594,82 +2594,6 @@ static int ib_uverbs_detach_mcast(struct uverbs_attr_bundle *attrs)
 	return ret;
 }
 
-struct ib_uflow_resources *flow_resources_alloc(size_t num_specs)
-{
-	struct ib_uflow_resources *resources;
-
-	resources = kzalloc_obj(*resources);
-
-	if (!resources)
-		return NULL;
-
-	if (!num_specs)
-		goto out;
-
-	resources->counters =
-		kzalloc_objs(*resources->counters, num_specs);
-	resources->collection =
-		kzalloc_objs(*resources->collection, num_specs);
-
-	if (!resources->counters || !resources->collection)
-		goto err;
-
-out:
-	resources->max = num_specs;
-	return resources;
-
-err:
-	kfree(resources->counters);
-	kfree(resources);
-
-	return NULL;
-}
-EXPORT_SYMBOL(flow_resources_alloc);
-
-void ib_uverbs_flow_resources_free(struct ib_uflow_resources *uflow_res)
-{
-	unsigned int i;
-
-	if (!uflow_res)
-		return;
-
-	for (i = 0; i < uflow_res->collection_num; i++)
-		atomic_dec(&uflow_res->collection[i]->usecnt);
-
-	for (i = 0; i < uflow_res->counters_num; i++)
-		atomic_dec(&uflow_res->counters[i]->usecnt);
-
-	kfree(uflow_res->collection);
-	kfree(uflow_res->counters);
-	kfree(uflow_res);
-}
-EXPORT_SYMBOL(ib_uverbs_flow_resources_free);
-
-void flow_resources_add(struct ib_uflow_resources *uflow_res,
-			enum ib_flow_spec_type type,
-			void *ibobj)
-{
-	WARN_ON(uflow_res->num >= uflow_res->max);
-
-	switch (type) {
-	case IB_FLOW_SPEC_ACTION_HANDLE:
-		atomic_inc(&((struct ib_flow_action *)ibobj)->usecnt);
-		uflow_res->collection[uflow_res->collection_num++] =
-			(struct ib_flow_action *)ibobj;
-		break;
-	case IB_FLOW_SPEC_ACTION_COUNT:
-		atomic_inc(&((struct ib_counters *)ibobj)->usecnt);
-		uflow_res->counters[uflow_res->counters_num++] =
-			(struct ib_counters *)ibobj;
-		break;
-	default:
-		WARN_ON(1);
-	}
-
-	uflow_res->num++;
-}
-EXPORT_SYMBOL(flow_resources_add);
-
 static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 				       struct ib_uverbs_flow_spec *kern_spec,
 				       union ib_flow_spec *ib_spec,
diff --git a/drivers/infiniband/core/uverbs_flow.c b/drivers/infiniband/core/uverbs_flow.c
new file mode 100644
index 00000000000000..1528a294f7f85f
--- /dev/null
+++ b/drivers/infiniband/core/uverbs_flow.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+#include "uverbs.h"
+
+struct ib_uflow_resources *flow_resources_alloc(size_t num_specs)
+{
+	struct ib_uflow_resources *resources;
+
+	resources = kzalloc_obj(*resources);
+
+	if (!resources)
+		return NULL;
+
+	if (!num_specs)
+		goto out;
+
+	resources->counters =
+		kzalloc_objs(*resources->counters, num_specs);
+	resources->collection =
+		kzalloc_objs(*resources->collection, num_specs);
+
+	if (!resources->counters || !resources->collection)
+		goto err;
+
+out:
+	resources->max = num_specs;
+	return resources;
+
+err:
+	kfree(resources->counters);
+	kfree(resources);
+
+	return NULL;
+}
+EXPORT_SYMBOL(flow_resources_alloc);
+
+void ib_uverbs_flow_resources_free(struct ib_uflow_resources *uflow_res)
+{
+	unsigned int i;
+
+	if (!uflow_res)
+		return;
+
+	for (i = 0; i < uflow_res->collection_num; i++)
+		atomic_dec(&uflow_res->collection[i]->usecnt);
+
+	for (i = 0; i < uflow_res->counters_num; i++)
+		atomic_dec(&uflow_res->counters[i]->usecnt);
+
+	kfree(uflow_res->collection);
+	kfree(uflow_res->counters);
+	kfree(uflow_res);
+}
+EXPORT_SYMBOL(ib_uverbs_flow_resources_free);
+
+void flow_resources_add(struct ib_uflow_resources *uflow_res,
+			enum ib_flow_spec_type type,
+			void *ibobj)
+{
+	WARN_ON(uflow_res->num >= uflow_res->max);
+
+	switch (type) {
+	case IB_FLOW_SPEC_ACTION_HANDLE:
+		atomic_inc(&((struct ib_flow_action *)ibobj)->usecnt);
+		uflow_res->collection[uflow_res->collection_num++] =
+			(struct ib_flow_action *)ibobj;
+		break;
+	case IB_FLOW_SPEC_ACTION_COUNT:
+		atomic_inc(&((struct ib_counters *)ibobj)->usecnt);
+		uflow_res->counters[uflow_res->counters_num++] =
+			(struct ib_counters *)ibobj;
+		break;
+	default:
+		WARN_ON(1);
+	}
+
+	uflow_res->num++;
+}
+EXPORT_SYMBOL(flow_resources_add);
-- 
2.43.0


