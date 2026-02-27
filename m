Return-Path: <linux-rdma+bounces-17265-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JPGAE3voGmOoAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17265-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:11:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3DA1B1671
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A08D530532B4
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 01:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6662327991A;
	Fri, 27 Feb 2026 01:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jbYBlCsl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010046.outbound.protection.outlook.com [52.101.193.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB4F27FB3C
	for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772154688; cv=fail; b=iNw/mY+w3j9IRN/XCmUlgpl31S0F4Utplf9sZ8Ui8dW8Q5idyY/msbp28OGenYx2ORsE2ocCAodGbSdgmgH/pSsRE0jgLgLsSCDpPbKxXbiz+he6NsHqUU/S4AGnLMr40VeVWzdK+r/g/0uk5EFU+EMNiWJLog8fS30csWJsboE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772154688; c=relaxed/simple;
	bh=D7sVLgekwwGqCf5bT4+O9OGm0u9mw5z8GCpvf2zlGNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hRMG6zfCJFl1hkD4QXAfBcXpjf5pxqOTrOgM+GYdKS8QEyXnrWiFASJD55m4adJhYNj+2Tp1zfyeWVcLP5N8sZdGAl7dos4/Y9KlUFzPLEt8MHWBYyDvZSMvXDsR2YthJ837iDJmqZKHUtW1olix5zKRf0SOaoSnki1LjTWR/4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jbYBlCsl; arc=fail smtp.client-ip=52.101.193.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvpND3IcyuwPKL2feRJA7L2KEo52hWD6sAx3uDoBLc40uVzi0CosipjmBl4F2H+A94hyr3YcdN4rY/t+eEpxkKDDlmdt1e3iD7hkKLz/ngmyK3sO9Z6L3FFPugApDqXQUuVgW/aQXrbLSCi4HPPm4MnqISALkDMbO5bbF36L40VRU6hdnHCInt81ql4lXh6pCFp562H9fAxEX0iumbPrSRrvwFBZ1Zx0fSJl4ns7Clu1SZZRCdgfszdOJnU6hlzp0b3JB3OSihv7IbR97ndGflqVD9bDLkXQiS4XNo+2K7EsPNe6p6MtqkiPQdAUa/f3dmFrwyO9SF7tFDrbW1HJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hN+f29qWVdXmC8UfiDGCFA3GAWNqOuJFH4CpB56QLU=;
 b=Bx4QX98ZjAcHsuGoM7mpb0IXP8bUrF2+BAxq+MRS6QJ8i45mZvcrzLdhUYysO1Bj7mllLVbTk8JClRzlIvlLhE/3TDgIE8TmDjpQe1BXV4az/6+3+B+JMgRqD4ga7BGsYbzUUAhgvQDz7a8rJUhB0JVp6eDW06KSPY/jOPGbsRDkvwC/McIPJtAuMF5xdHaMOE0EhTzqcy7q/Rl93SSRwBZ4y4jGhCvPHkw8szBULtDfO0Epypj8+3kDSMQ1mMK5HfuI3mBg4uC/MslrIzx6jLwF2/YE16Z4I0Ai08GMpFvSe8Qgci00uQPavLJg3VFUa2xp1mmB/fYBupr9v3Fh2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hN+f29qWVdXmC8UfiDGCFA3GAWNqOuJFH4CpB56QLU=;
 b=jbYBlCslxO/CGqPz9Hr/mj77bjl62wiA8d6x2gOXP4R4LPnTrNYbS1mqOZJafXEAnaRnAUtyO11pV0/8KVUNhraNa35nurhHu67rsFlpoovenDZu1bBppgi3XaU1IQwt8hp82XVS/MWMCc1T7q9MM2ob/QKn6+oXuUFovB+DcecHyam4PCbY7AFX1u7lnSnAfOfCJLu8Wm08T9PVuV+TbfcukGIAryEr9QDkfGzcMBKK4+EotwpiEfQ6Nma0HdYn3mgtkoWFgkDPA4Wh/M/OTD2HipYRDScDoTP/LIdQf1dvSkOQ0IUztxziWsDJ6EXunxV5GG0SO5UvUmZcT/ETWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB9459.namprd12.prod.outlook.com (2603:10b6:610:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 01:11:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 01:11:20 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v2 11/13] RDMA/bnxt_re: Use ib_respond_udata()
Date: Thu, 26 Feb 2026 21:11:14 -0400
Message-ID: <11-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:208:fc::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: 945b18cd-2cdd-43f9-2164-08de759d1bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	q82XsgvaEeGRi7EeErKJ5Nt1DUkUTRacwK4PnyB44yO4bEVP5F6p86FpZSW5igcGbrMUFXYEKc9Qnaa0zp5pQx1LkiMWD+R4xSVXIyO7FThXINhv/lBkqCavptdEo5uvZIBcBI7N3AEIR0xxMAJwvJrdRhr68zpGM43hs6M3RyiVUtea+M4o9czaBfVihYQe7ITqQ2/jtTtduDAAx4pFWYfrzrj7Jnc/GZgb9Xss9Gb98UlpgK979P5piWFEYO0NdcOEFpxR70YMAtsIRt2fABAPLgmJlk8hFxTUKPjWhldHfHfavlDU1S719URws3M7Z7uVCIfKWlGGp77nZpXO4tN6AuKWXeVx1YKfgMfVD1LteZx7wVvPoOS9BD39oPdwImPaHze9Q/sY0umGaTczDAFl0ylzjWlLNCwrFSjbwJO/Zmp7fJ5EmAWsvikDU/TbOaUl9x1PAyc3jkJKlUvaSMb4etj3ssAlGU3MIAO1laljz2xxDZIi09dxtuoVkih3i1rd/3FkTgtCzCraNiemDubecGUILN/pLQKHJBAO595S/w6R5waLg+bBiLgarZVNn7wDQF4wvanggzrghOcOqJ4MpkrExIk365v4HOQZTv6WjISOQUTL3OzW9kUaQc+LOQnQJRD7kuXeV/SKWqNjOOxgeKqApqT8wMiF3HTTNxlT5vcdR/U3W5JSOGfA0+1M7JlisQWEMSuR81GOCXU3TG7faqA3Xxyy+RavsRLUW0Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b7DQdijDnoznfPeKgzqAssbd1l+9lkyviApJBK2rZACS4uupI2/H1sdeSY4E?=
 =?us-ascii?Q?qkc2RNV/xXrgfbbnhfcsHU3isvPzgpt7ULrOPVRu8BJC/hu2MtBR4n83YRpj?=
 =?us-ascii?Q?iVY6xYzRYzvm8U99mu2e3/YX2SR8K0SDmroMxRw1zQrhOWOolfDtZYaKTbqa?=
 =?us-ascii?Q?8bLCVKEnXouxAPUk2sVlPDh3vrPrnxGXj/d9M0GOA7ypyvDjtoVFHvG++tJ4?=
 =?us-ascii?Q?gk07QcqCPITgVJQCSFIZgXOrdQulk8l/HNeemnNKx6pumcP3HSfqsspPS4Hf?=
 =?us-ascii?Q?hQ1i+6JeH+AVvloNyuA+g0U6FN7CB7nfnPU/FcKJtz3QK2vCZ7EoFH7Sg5q9?=
 =?us-ascii?Q?7e+f6YSOgGE1bdgscKBkTODAwV9HgzkI9/xD6YeXbA78gZvWKegzMP2e4m+T?=
 =?us-ascii?Q?fjzxXQWbuNLjoBkIOl/Cmd+bL5F1e3V0e9RP4uV6LaPnk66SmBpz8P7/DX84?=
 =?us-ascii?Q?A/StgoY2VSrBfqSinqLVHtgfpl8iQZyLvLiDlIkBcD574zQ10Rl6q/keiopw?=
 =?us-ascii?Q?3XxL7BS+ChuEdsZcNKoFvuoDkQwLMbKghCadpWi5HkmK+4C4FstOhWgad5aI?=
 =?us-ascii?Q?aKcCdyoRCHc6s34QVsHyeq7/ztdUa9y2LwYOLvH90jmbm0AIPhqR3tYmoc64?=
 =?us-ascii?Q?IHHdj8mKmOl+R3J3YNWB8OlXYjMAdYTbbsgIiBUtGQeNZfM+baXgCrkriCpv?=
 =?us-ascii?Q?Z1V7Ml7sCCmbJSiV1HNufpDpX6jvvbkCNtZtXQJccOOIUtinx1P+GHeDyInD?=
 =?us-ascii?Q?+gV/rNwWA8Tgbxv+fyeC8keibzUMlcDXn4SRp2qD8Hi3Lxql5WqdCa9e1TSl?=
 =?us-ascii?Q?4EGU/bisptACkb+KTA5LYKBzdlSfjpzcgwvs52bwD6b18YJal+miA0JK/4uY?=
 =?us-ascii?Q?pgbOtxtJhpA7QiLhzEHaVOQZwLXyt5ri1PpfOtREOkeThTNn/Lj5GiHCp4Ix?=
 =?us-ascii?Q?cEFgcrw65hHMvsS70EvsRU4dgTHl2gC/p86GMFwqQ8vfkQDArN+e4H5P4kt/?=
 =?us-ascii?Q?BtXJA61PVFGU7suWa+fCDqk8biAFtRrJVUyaPqsgOlGwOEKTfMH1nwfhle8C?=
 =?us-ascii?Q?tyOu8ak2NLUGZMj8ZKr/5t9dbz9GX1iar6mZuH/lKiwKk88Ihh4XYNAXMIob?=
 =?us-ascii?Q?CIBP9eW4OSOZiMPgd5PLm1gZ7xhDcyvxncFlvsJZ24QAwXdxHl+Uf9HLG0qF?=
 =?us-ascii?Q?foFGa23oabY81a601TKdJoOyohAYN+Ah7cRxaD2qAzcbxfsXzVYs7zM+h9mI?=
 =?us-ascii?Q?ZsPLzp5g3q0EXphTTXihAdGXCnKbLiu/tM9FtNBIbZ6ZN7Q++RLJ35q7TGqw?=
 =?us-ascii?Q?8jez6ZbJS6QvpIkbqYMb3q1YUz5Cmyl4vp4jJuSU+8kCLGchTbOjhUmW1Bav?=
 =?us-ascii?Q?WuC5LRMg35CGwODFpZPPAfPtiJ+7Fm0cl2xLOeymZJlqbU3rIc4r/1ouA6KP?=
 =?us-ascii?Q?zOVj0Dj/ZDJHhwto7BCaf4WBcUftrYliw6QsP+DwtM/nU+h5fas4LrqL0NZR?=
 =?us-ascii?Q?LjAsgyf2WYT6DxEyarr8gTls/gFhmmFKvhtWNiCIyGzCKoe2uEE0bEJn5Ocs?=
 =?us-ascii?Q?FFjrpUYxCkiykxHVpXzAJeuLLlIB8FNydZ2brkvpzChOEtUsDVjSedg7LD2a?=
 =?us-ascii?Q?W59dr1vFDHnyTtTtQ3CGPK6C4cRYxTTR8v18NvTieHz/2FIMCfj+ss7zNPTt?=
 =?us-ascii?Q?iZO6Z0vYEgjtle8MbGw95CZNXbt4lZplT6zVYImlDOKHg+Wm3uYthM9uzebX?=
 =?us-ascii?Q?IPdmX27Dmw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945b18cd-2cdd-43f9-2164-08de759d1bf2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 01:11:17.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwknO00IcZVwkIsLsBiusKs74Db2JTiU/TjIXSCnRj7L7LG7LvUi59wJ/zjwRYH9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9459
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17265-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: AB3DA1B1671
X-Rspamd-Action: no action

All the calls to ib_copy_to_udata() can use this helper safely.

Tested-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Acked-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 31 +++++++-----------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 412b99658d9073..663f452946c782 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -187,7 +187,6 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
 	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	struct bnxt_re_query_device_ex_resp resp = {};
-	size_t outlen = (udata) ? udata->outlen : 0;
 	int rc = 0;
 
 	rc = ib_is_udata_in_empty(udata);
@@ -258,8 +257,7 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 	ib_attr->max_pkeys = 1;
 	ib_attr->local_ca_ack_delay = BNXT_RE_DEFAULT_ACK_DELAY;
 
-	if ((offsetofend(typeof(resp), packet_pacing_caps) <= outlen) &&
-	    _is_modify_qp_rate_limit_supported(dev_attr->dev_cap_flags2)) {
+	if (_is_modify_qp_rate_limit_supported(dev_attr->dev_cap_flags2)) {
 		resp.packet_pacing_caps.qp_rate_limit_min =
 			dev_attr->rate_limit_min;
 		resp.packet_pacing_caps.qp_rate_limit_max =
@@ -267,11 +265,7 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 		resp.packet_pacing_caps.supported_qpts =
 			1 << IB_QPT_RC;
 	}
-	if (outlen)
-		rc = ib_copy_to_udata(udata, &resp,
-				      min(sizeof(resp), outlen));
-
-	return rc;
+	return ib_respond_udata(udata, resp);
 }
 
 int bnxt_re_modify_device(struct ib_device *ibdev,
@@ -769,7 +763,7 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 
 		pd->pd_db_mmap = &entry->rdma_entry;
 
-		rc = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
+		rc = ib_respond_udata(udata, resp);
 		if (rc) {
 			rdma_user_mmap_entry_remove(pd->pd_db_mmap);
 			rc = -EFAULT;
@@ -1727,11 +1721,9 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 
 			resp.qpid = qp->qplib_qp.id;
 			resp.rsvd = 0;
-			rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
-			if (rc) {
-				ibdev_err(&rdev->ibdev, "Failed to copy QP udata");
+			rc = ib_respond_udata(udata, resp);
+			if (rc)
 				goto qp_destroy;
-			}
 		}
 	}
 
@@ -1990,9 +1982,8 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 			}
 			resp.comp_mask |= BNXT_RE_SRQ_TOGGLE_PAGE_SUPPORT;
 		}
-		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+		rc = ib_respond_udata(udata, resp);
 		if (rc) {
-			ibdev_err(&rdev->ibdev, "SRQ copy to udata failed!");
 			bnxt_qplib_destroy_srq(&rdev->qplib_res,
 					       &srq->qplib_srq);
 			goto fail;
@@ -3281,9 +3272,8 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		resp.tail = cq->qplib_cq.hwq.cons;
 		resp.phase = cq->qplib_cq.period;
 		resp.rsvd = 0;
-		rc = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
+		rc = ib_respond_udata(udata, resp);
 		if (rc) {
-			ibdev_err(&rdev->ibdev, "Failed to copy CQ udata");
 			bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
 			goto free_mem;
 		}
@@ -4489,12 +4479,9 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 		}
 	}
 
-	rc = ib_copy_to_udata(udata, &resp, min(udata->outlen, sizeof(resp)));
-	if (rc) {
-		ibdev_err(ibdev, "Failed to copy user context");
-		rc = -EFAULT;
+	rc = ib_respond_udata(udata, resp);
+	if (rc)
 		goto cfail;
-	}
 
 	return 0;
 cfail:
-- 
2.43.0


