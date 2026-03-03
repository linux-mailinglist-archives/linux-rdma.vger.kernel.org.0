Return-Path: <linux-rdma+bounces-17438-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKjZMSk8p2mofwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17438-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:53:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C76DE1F66CD
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A4973039679
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 19:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395D6386441;
	Tue,  3 Mar 2026 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RHtct28m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EA5385510
	for <linux-rdma@vger.kernel.org>; Tue,  3 Mar 2026 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567429; cv=fail; b=rV/wem/1m1De/85DDtWyftmsm+JWH793BEW96RJFx45k0EBPBETRnFgxwSuf07rfcHno0aEjTALSOUQIsI9iAHM62k+PCxuGHhOF9exOZXILSgUPp2rZ0ti8qCzeWiwN5DkRgbO/08+H0aW7Tb5PLfsPPTGCTAwfvEf/coqZfCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567429; c=relaxed/simple;
	bh=4uBjGl/LodNIRCPQtgGTsGNf+H6crIuhq+9x4iidqk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pbBY1KR+VWOf+w2NSzcupWjX5Wf63plymgrAoidr6184eursn8mAlSkB5IWN3U9uXVYXAJDn73FeXjgCroj/iFRbt83pvp04POY7Uqjn/+4qchz2/qPyE1lRNqv5R7baAuAWk2T5V6o0m3taGZ8YkQB6HzN1DvHL7IaJxUv8vy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RHtct28m; arc=fail smtp.client-ip=52.101.46.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAyexEhj5pjhS27HX4dcp3c/WY+8i5+Px/ExvtTfsDSETBWpKN+e+tBt1CYfM2B+nqLnVUCtf54iqrTndH3jXOee1CIlQYOfLJggWvBAhprPqnn/PZJ+j78907NaNXKPTOUbdPWflzKKki3bNRUczg2EHO4KVqU60ZkUh8i2857NEHabwHVHNhe1aLrNRobq3H5MGBSSstlJ/t+lIXAOaquvXNZsUk0ZzRUJa1kI4hCUOOpTyQFMwK1/27cps/FZitTwJHRex9RBjZqDDhkek+ME64UIde8h9NBccI3RCljk82wtlQFRJSkmJGf/o7uDwwL2EWXCs4yqJWpgRuzJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iB/UMCvkFtchRBq39pKI7UyFuYS1lcriJZgkIVFUM1A=;
 b=HEsV1eES5RybHCd9mL36q7M6V6CHFol7FJG6EbukrQiYlLil9aH6iSEUn9cbQtUNXiQAx10a6CM/QkqRL6AF2gbEtuhzwywXLXhaXEeZmLAfQSssvR7PydweuTTGKHow1JblOs82daSzEaWzabWh2sHxrVF1CeX5pOUM6iqqgHIoOB56kHG2YfBlWAwX8dcmB4AGjLORTk8tw24wdjrdrZbb/zHv1LSWl77MnA3SMq2wi3LSsONdoHWv0dpE3FDN9EcLyFnTE4D51ySZoAWKVIVK7bqBiGFCQYpLgFurDHaTmxFNoTzKO/usaKZb2PQuUoSNyDRSkaldIV1v4VpI/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iB/UMCvkFtchRBq39pKI7UyFuYS1lcriJZgkIVFUM1A=;
 b=RHtct28mHEgrS5n6ln7Q5q0wjoyMvNmfb3AJFJ+JlgjO6GtZtdEQMonzWZly999GGrRrjR6sgYQ/FwbsI02A08L8E3Mrr8C77BbMHpy/tjXW+S1AXS1ucwMrh2dqRaIBxQOfmDy7UAh/3Vd8hh40RtJc7UoIDfItReKijXAgmaQBbCI8SzcsYt3RpxBX8li5lovZ2M0+q1+cNYTqzXaWSlJZgVYqFdYq7b+tswAMd6nJGwjWLU2CnBKrcDCrBGk3/qNejM+xv8gbmt+RvrkKXzzc0+79wUWb9nUYMYlxTBFboMjA6i8QOGl+8/nr/H0WJKamYLTguguyJhPye8mhag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 19:50:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 19:50:18 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v3 12/13] RDMA/bnxt_re: Use ib_respond_empty_udata()
Date: Tue,  3 Mar 2026 15:50:09 -0400
Message-ID: <12-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 6172ed93-8bd4-401c-1a3c-08de795e1671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	WjXH4gXx9nsLuaUOK6GWrzWcVepmKLvRiNj8vpQlm/QPGc7jUTx1YQNKiuK1WMNJeMGPTH8wuApM65MlVfgt7lSzqijJdf7YieeVPG5tYWwTRAhqph7OSZHjNXRpY0Ovj04p6hXDjh7vadGkxWPDAVCPZIFlzSg6c1OHIJehPWHOSV/fYtZU0X5Ks4SiytfHWa1qyoQGc85wekcygpkb5UwEAdLNpz62+VBub5MFH0p547djFVMgAg48CAY0sKkxf41/FPvi/Xb3CJjK6Nw5k+JuE7wrmKIkpP/gYimfgJwfT0ctrEydQoJEQR6Bg0VA4JtG8kh60ukJ9Z1Qeg9qlsPe94iXRk3k882QbQ9tTBah4H3SGl5D5ofjLSWfND8Ry8afZa1vGA66XkX4fzYJBQkM2EXuCQyquvsGVAflOtT1pw7D84/MBLNIlGg+7mCPBVm2B5qUcspV4xPKpF08iLhVKKr33UO8oSowkKdrwmOqfqF53cm5xAKep+RPAX5U1dKbiPCQF3rUCaWuM16JsQ/pqNGshnrXxDUfEk36lfJoJNqh4zk4pQUpg6bFTNL6EDrLsyxmeoPJf1Y4kyztmGNB5QlsMSIEeof6rMMbbwatdGcs5qGKXZml0IKI2aoymSYRdTRye22xmoa/Cybdol4NIxMNWWCe5DWRUwIXOsd6+BSqJfgPn7QKIxOGld2fbhfBdQYz/kTcdYrCYK7TJkVRrgufAozPyFxiF9G0fRs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ieLCpm2ZCZXiQY1sfXBduTTDAvZmGVqMc+VOGxZ6Pc8N8qtRCEvJjw0e54k?=
 =?us-ascii?Q?Rg6SJIO+5zr59qEaHxPNmywv/CcZu6WRAMIog4DKpJ5vPtWBAUnDR3h3KNW4?=
 =?us-ascii?Q?a0yQBQyfBX2AU7PTI4+EJEL3b/5Z4ehSv/2UxwErT4GWW+LwI4Gk9aeZRj3x?=
 =?us-ascii?Q?3USHUCWHdqLzIgRY/dkKFQHmVDXFSZ47mPltxA9GncnwttdIyIGlsWfyV8YR?=
 =?us-ascii?Q?2/0tvzxSV+lqgPRCDuhfq15xfxwxc3meM1SfChg7jJyjVTZ/0igTfLQGDIxF?=
 =?us-ascii?Q?73dRm306fPIvmATz8ExoRZXYZjPstxuLewhtDil5O9YwNI3Jm8eqBx3P6dUt?=
 =?us-ascii?Q?jQr0KK/fsg46dVMZ68enqXwT6E6O3fgnjebyufEXJmGGU7nW+WIo6J674oTN?=
 =?us-ascii?Q?pSxPzCjUKJF1U5sI+SIhm5A4amP76+dttrpSFurFKeN5gDolJLZYd7q8l6R5?=
 =?us-ascii?Q?XGRsp/XVXdZD46iFS6KLqhSxREzQrcZVMQ1+C/xMzbnImIlyIvNmfbkxWgwd?=
 =?us-ascii?Q?uKMbjSd6EV7FLwVlwBZ6H8wmEUZNBXr2P64RkM2Sz/FfHRVbo3OGG8nVgjvW?=
 =?us-ascii?Q?KmuawJeUQfJ2t4Bi0pdoX9okFrYiGAJcmxpnaQnUN3zrNdmjUjJ4LKOGS76/?=
 =?us-ascii?Q?oSf8EtudfJwkVhOjVaS1cQA1sEmtQfF5CMR6ROf82JsFzo1RRMlsxwhZIVSr?=
 =?us-ascii?Q?rPwgLhiUwibRYfi12bOrLC6yVpUv3GHDZzx6IvzVNEEerVpc4m4a5W2Rn+M4?=
 =?us-ascii?Q?thd65EfhJnumxtHUIai/jMAc/c3ZYkbCW/31Dig0QqBsQBChUt982aOzPafo?=
 =?us-ascii?Q?Gbjc8ASxiq8lVDLgAJ6D0cNuf4a0OndTTc/PXH7A96bz2JvlffPIOUquSk98?=
 =?us-ascii?Q?hkZkR+6ExG/COkwgvdMzqZn83qNw1BrS3w4D/gAf2Jix4V8Zb2svR3+ZETTs?=
 =?us-ascii?Q?Ws9jdWz5h4skml0NmOlVa1P5KVS9nta+lalmaONGp04qOewo5qOSeEWBdrXB?=
 =?us-ascii?Q?hGspMvLqXvO7QyHQHJAx7o08lOd/iG+v5gqksYW6DusrVSs8rzb6Cm9Pvw5h?=
 =?us-ascii?Q?Wigj1cRFr+znwAKLEv6zY1kT93/u3/2mE+eBdO3gH4e1Y9puzq5Ki9puVCMl?=
 =?us-ascii?Q?AV4L2LRClaerNbLpUiLWz3zG6UZMsRnBPBAZxll4wXtMMxKNhY9DQWnvPdNK?=
 =?us-ascii?Q?KwMckNC8LIzk4TV0A69V1eOGufXj06somh6vwlMF9fecicGx/bsO6rycdt2n?=
 =?us-ascii?Q?F2m9mRyjuA6bwrghYzNGp420YqLjvIokcJZzQjZf0XUCxaLKO5RnI/l0uaIS?=
 =?us-ascii?Q?iQMdWyV+HfrTz5/6UMORIua359FU8Y0whG8HnwVLwHXeWQGbAl2LGVOcEtwn?=
 =?us-ascii?Q?3jxFkpDXdr0+PrgcG05081tI2waEt/aqIplX+UUvE/rROUxNdeODTzV6tP98?=
 =?us-ascii?Q?1dyRj1pYCmyPyW5s3FCZvv8t0Z5fdspRvg3Cs9Lbr1m2jQn/P9irC6dmPFce?=
 =?us-ascii?Q?a+qGdtsQ7wTt5uQyCKVNmAN/Zb+hNE++GJGZctGpR581e3doYACilOLB62sK?=
 =?us-ascii?Q?TiGpDo9ohW2hhkziHcmCNYTxebSXE4B9bafxXHEdQSFwPGmrgB9i50VqcxpU?=
 =?us-ascii?Q?llWgeDblV4ZnaD3JLaE4yHJ63fs6KrGssNW3ynQXCgRy+IArUzJHQ9EG0EOl?=
 =?us-ascii?Q?hkqPbcljUcetrQV+KU2Ksx+aqlBzwjo0x8G5hZD7nwVGF9CilTtuXoDjXBJ+?=
 =?us-ascii?Q?XxaX0Hg75g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6172ed93-8bd4-401c-1a3c-08de795e1671
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 19:50:14.7509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KG/xdtZqySliiYm/XBDoDkaBbXyS8ovtu7QjrlFXDL5eVhrskfGUmbJYAXBKyq4v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
X-Rspamd-Queue-Id: C76DE1F66CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17438-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Action: no action

Like ib_is_udata_in_empty() for the request side ib_respond_empty_udata()
is called on the response side if there no response struct.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 25 ++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 663f452946c782..62286a06db8168 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -709,7 +709,7 @@ int bnxt_re_dealloc_pd(struct ib_pd *ib_pd, struct ib_udata *udata)
 					   &pd->qplib_pd))
 			atomic_dec(&rdev->stats.res.pd_count);
 	}
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
@@ -898,7 +898,7 @@ int bnxt_re_create_ah(struct ib_ah *ib_ah, struct rdma_ah_init_attr *init_attr,
 	if (active_ahs > rdev->stats.res.ah_watermark)
 		rdev->stats.res.ah_watermark = active_ahs;
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 int bnxt_re_query_ah(struct ib_ah *ib_ah, struct rdma_ah_attr *ah_attr)
@@ -1053,7 +1053,7 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	if (scq_nq != rcq_nq)
 		bnxt_re_synchronize_nq(rcq_nq);
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 static u8 __from_ib_qp_type(enum ib_qp_type type)
@@ -1869,7 +1869,7 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 	bnxt_qplib_destroy_srq(&rdev->qplib_res, qplib_srq);
 	ib_umem_release(srq->umem);
 	atomic_dec(&rdev->stats.res.srq_count);
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 static int bnxt_re_init_user_srq(struct bnxt_re_dev *rdev,
@@ -2030,7 +2030,7 @@ int bnxt_re_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr,
 		/* On success, update the shadow */
 		srq->srq_limit = srq_attr->srq_limit;
 		/* No need to Build and send response back to udata */
-		return 0;
+		return ib_respond_empty_udata(udata);
 	default:
 		ibdev_err(&rdev->ibdev,
 			  "Unsupported srq_attr_mask 0x%x", srq_attr_mask);
@@ -2375,9 +2375,12 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 		ibdev_err(&rdev->ibdev, "Failed to modify HW QP");
 		return rc;
 	}
-	if (ib_qp->qp_type == IB_QPT_GSI && rdev->gsi_ctx.gsi_sqp)
+	if (ib_qp->qp_type == IB_QPT_GSI && rdev->gsi_ctx.gsi_sqp) {
 		rc = bnxt_re_modify_shadow_qp(rdev, qp, qp_attr_mask);
-	return rc;
+		if (rc)
+			return rc;
+	}
+	return ib_respond_empty_udata(udata);
 }
 
 int bnxt_re_query_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
@@ -3174,7 +3177,7 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 
 	atomic_dec(&rdev->stats.res.cq_count);
 	kfree(cq->cql);
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
@@ -3376,7 +3379,7 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 	cq->ib_cq.cqe = cq->resize_cqe;
 	atomic_inc(&rdev->stats.res.resize_count);
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 
 fail:
 	if (cq->resize_umem) {
@@ -4129,7 +4132,9 @@ int bnxt_re_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 
 	kfree(mr);
 	atomic_dec(&rdev->stats.res.mr_count);
-	return rc;
+	if (rc)
+		return rc;
+	return ib_respond_empty_udata(udata);
 }
 
 static int bnxt_re_set_page(struct ib_mr *ib_mr, u64 addr)
-- 
2.43.0


