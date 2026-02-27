Return-Path: <linux-rdma+bounces-17262-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKZ+FELvoGmOoAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17262-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:11:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B04711B1649
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60E0B302F423
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 01:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9C0274FD0;
	Fri, 27 Feb 2026 01:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m5a3UoTn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010046.outbound.protection.outlook.com [52.101.193.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D1A266576
	for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772154685; cv=fail; b=UtKSqo7LB6ncGqhr07OiCL8WKHgbX6lpLYsikv46RPv1YsIQb7R/GVvrR3vwpkCvJx/JsV/3OmR8NkypQWqyhRgDatW4DZbmVzn3NAmFZ7wk0zbb8m4K5zLPjFPo9jBSJAPAEilyNFIhqFoQ4TPCk8yac37/lSM3GqWWQtf4hAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772154685; c=relaxed/simple;
	bh=iKZNYHlfsnUtCCwOviAklz/PZ1/rcw9Pbzu6abH0mxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kCBE3IV7bUINsWMkXLMDhHYlJOZhy4nTEvn7J0fMEcuaFwD4rfLZzfwXJFaA+4BqQQk2rzO+KHax0Llfd2C0YmEuL9dehSi+Eg23pzJWxEHyg639LhLo796bpBGGCdh7+6UE5sNtQ+405xHMWgKRpcVGmgRggbtJZXcQU7JCwAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m5a3UoTn; arc=fail smtp.client-ip=52.101.193.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y19aVDbQv6q1Uwd4DfJ8kwoDW5MeU59HhW1Z74f1qRkxTmTPFQm2fiPX1GFRpKnmaztlLrVR/12XGSNIrTAZ24oE2cZweHFVclj2rNwOKu+GQqD3iAVOmUXuTUb0A2heI5TvUV8M+1TPcVD2yu7gXAUiTkBJBjUFQKVYtha803TuREH88ttaQ3Cnkc2G626sd8zkRBnC81yWWDwKwKvq4j4QZt8Zad8gAFasAdCx6mEs6PM8V/al5/1Qdf3ZtbZSTUlhmED9XK4PTVx8CJYgQTh5hsdoG8dPTVHSRgqlK996BnEAeboHSG4iREtF4LuCGM1/SHm8blPOvbtzm5JIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrVDFaYkjKYVzyb/Q5uT8anJu07zPVTqE4+9wTigZ30=;
 b=EcjRTpt1bcka8VtzNKUTuqx0KxYKHuosC/A4JDEYSZHSOndoF6jiPqSxvw0dnErIImlbPt+5NuV67YDEe5FkSXMNE8QcCbKuVnwgq3o2JqO0FsYyAuj1DM2/Z+O+/kV4SSaejQ72SsPW49/2jLCxgF/mWyp+h238OoNqrLcowrlNQor1nNCgxJIH7kTr8RDPuZlEoO5mX0LTg9S8/7Drm/McGfS7iuzjVAFLqIIM+lc/Wp+sxOKjxQAPipciopkUfdSdNAJPSfmzsGxzzjyve6s5hbSnaga0FfHNnVBC7dpufpxwF40PfXsOuD9S2/N6cY5NqIKlzUw9WHyeyQfXTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrVDFaYkjKYVzyb/Q5uT8anJu07zPVTqE4+9wTigZ30=;
 b=m5a3UoTnVTIqxnSra65sPcgjUgYzMx2gAEWmOuQII7jAKYVy/t7jloPrfsRe5I4D8vh2yY3FNep7mjT6zDYpo1fHelYN35T61GzfUtLNUImJ/JKar/zvza2mPo/FprN0+HrrihdbzEtjqt8ADxJLM18uRD82GoFdEmMJYuVywFH/++weGm9+aohaoTVS7vfrB6DUSgRVbu0J6DQJ6z56Dkr6G+qdmFPkzISbsX8LUG9SjBbAVRJ5XBYeiQbxlIRkOemt7KMTkMUNUpeTp+ejZe5kn0t12eU0sOZphd98jlpohI1HVxP/LhsS0S4hHa4jFyf7nRp72M9G8TMnIJv1oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB9459.namprd12.prod.outlook.com (2603:10b6:610:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 01:11:19 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 01:11:18 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v2 04/13] RDMA: Add ib_copy_validate_udata_in_cm()
Date: Thu, 26 Feb 2026 21:11:07 -0400
Message-ID: <4-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0041.namprd15.prod.outlook.com
 (2603:10b6:208:237::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d0f88a3-9ae3-4542-d7c5-08de759d1bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	c2Xc52zOG341lK2wZvoOaVO652LuUmDGphDMSHJBhkbU/MNqjH3RSyaUyES88CypWoIk2liaIhMXJznIbPtA7LxNPjjr/j7p7l4H9K1au2apmOozlyRKE0x9q7FMbS5QMx6IwkhH+qA/uPRNRmbEBrGnfjFI13DFH/U5QZASJYenbtYNEHoqsXuyCCX0DSOTEfRTYdW5l83MR6iyAqsNUiI5zARY4v5YXPySwP+8o8uHqe9+isGp092UL7K2OsE1PCG6AF+8EUM1+Nip1zwZcAmgi3EAFYUdoOxua62Et2cwKC5yAaRF7/OGQlLdMX/mbc8bgkQhKFcsF64SUqMOYKeTYjjyRrG1iHoMrk4ctxrEEUsXE4sFF+oHQMvaM9gXIp2hgdyF+bofu4CAB/Bo+ljJGLEinDZ9tZSuELpnDBvEMhtJHi5Cq4F0fMRhf11FEc+pqwlWIsIBG9mcScm/DH+q1khoGlp9jciIKi2ueaRVkFmASRjYLTV+XbdK6Wf0Mxhdf61hvcVPzvT74wpHbXc39D+dN20cPlZb15uphguvaGtFCIQyC+kM+Yr++NXy88BMaXtYGxPG+gWucZazQV0pw8NecSNq32ZHQpymoB7ZzPj0bs6vTHDGfER83I9uiOX4KN/jv7rEbvMQ+uuK6i2ygFHuukdnGWDFCgX8wVScZJEVFbcOfXajdTl8psT/8eKxNRb2xiRrvRZret8hg3N2wDbqa6KKeOY5CXTxoBs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AWWy5XWREuluc+9dsqFdNPU7/FIXIZZOHvxanP27JE/bmddgpnuWBpZiHv6x?=
 =?us-ascii?Q?g1txuexSElFYT1FN+ugxA4WdHM+xXT8IhS8Rx0Aw4B5JBnTvTREtMUAlHvO+?=
 =?us-ascii?Q?UM5bE3fvzjx3dTZ3+GKZ1Jbt6s5NFSymcabHR9N33z6Hcr5hJKhKaaKC7ARI?=
 =?us-ascii?Q?VnIbz7AAqa7l6jFCAfquMDQJ5VHw3BDwVW5BaH10l4mXkiBe4K6DUwD1gATT?=
 =?us-ascii?Q?rfbAPRczJJqjRm5mk74CaIW4ew/vDtslSx+/6ZEb2lnYx+2sE9R57/z8rPGk?=
 =?us-ascii?Q?qlSFAxXDQRHBi+BMXce/vjr7v0v2G8uQoqLCFFFnPwgiJdAgKCUA5PPyCanc?=
 =?us-ascii?Q?hwjB36pOL3OFlKrAhi9BZhK8GAO/bUbP+S1du45FfyI/PAFmFa80n+JG+h6C?=
 =?us-ascii?Q?n3bgsPA6n8xapQvpmQM9lvwuykXtiNAcRyxdodOwpd36SCx12MeOeD8eY6t3?=
 =?us-ascii?Q?zJpv0wZNCHmpHBZ6BuC3Vx3rvjzoIOPUD4mpoYNQfIcLgnj0FxRO/pUdFaJL?=
 =?us-ascii?Q?JSHgpLvEp9xqlmbt4TaNFbhE0/geDaX7upQKLItJYBV12Hs0c9nMAm3lgrjg?=
 =?us-ascii?Q?i5Cb8kbySLff31OAl0F93DZB41giWvaUf5/VuwuyEGL8bVarZWNQQJNEmLKn?=
 =?us-ascii?Q?adZ85nqLBKSetP7CrL9BfEo8u/q0LScXUm4Os9JhHYJl4neW4NRbCaqkslKk?=
 =?us-ascii?Q?IMSgHdkcDLGa18RdYf5TOtqZi4u+tGSkIv1tYkvazX5yCBoh5Om3Xqi0Mkoe?=
 =?us-ascii?Q?5F3wAwbFCToRoouKFeZt2rXOi8p8eVh+GUI47IkcUwGFNLA4ARhb2JujswXn?=
 =?us-ascii?Q?4ZWNr5JETh22+HlnyTxBQCKGhDm3s4/lMyahhOGMziPBC9sYu9gYKcDv6GG8?=
 =?us-ascii?Q?IPmTmvYl9kRN3/fzgzZqtS1TwxwEF5FKu65eBBGpQ4pmNxG5V9lDFtJFtmfV?=
 =?us-ascii?Q?xfR2vGAveccpMf39hxbPPHtvfI5nPzZFHjoZrrTycczoDthrb0hTPqHTF1b3?=
 =?us-ascii?Q?hbT42qoXcYEsK2e7KxIpep0kGOZh7tRp0f87zHnYBHlhsKaUhWkuIUKqAdUw?=
 =?us-ascii?Q?Ps6YiB+Cku9nItdsVyn69XugEqmCCXxOvUplEEe+BCYkhz8XsgL1dsahcHVP?=
 =?us-ascii?Q?9Vcu6uk6aimfF7Fku4SdK/MDwxNjfvyMAuvNUWeUL3RRph/Eq2rGKAzwwSm6?=
 =?us-ascii?Q?tl5ug/ukgQIMcu19fG0dJmiCX2T2vlQtyY5uXM+8RnVsdWMSa48Z/r+nU3ga?=
 =?us-ascii?Q?um8etkQMRipW02RC6DV6tEsGvaIr08Zs/5Jt86/4Jwn2gU1asrKbRG5DORzk?=
 =?us-ascii?Q?gMAyADPE/w4LgeIgwANg0krA+rS+7DtBgvNTYTuOxVqy3bFneKbxVd7SNuzG?=
 =?us-ascii?Q?frBD2ElUZWlsNqkD1bbesdjJWUoa2/5PhijdEiTD/xJtahdyBYoigVu6EYy0?=
 =?us-ascii?Q?RWMQcGCCp8L6E9g/2Mpq9kZUjh+gUpzVj0RgOJpCehr7W19WjSJBExem+t4q?=
 =?us-ascii?Q?RTEh5G0ZksiH9LLSZkIxQv+E1knHadS2PWKHnRMpC8mrkUZR7/IcPnin+oxc?=
 =?us-ascii?Q?i/CbKtyWvQSQhNarnoqUnxlbe5EJ+RBvLnwEZwHHO1LOKCXs7+RGN2npyZpv?=
 =?us-ascii?Q?Qj0+BAh2Vck07DFZyHXj0gaRty7MJVbsWyErosEJDqcOrZqMO4AyLS0Mfh9a?=
 =?us-ascii?Q?1C22b/XjtiQg+eHGDUAQ4rSJiFsZ8xFr4jtQf6aMnw5lGUxPszwKT37XR+bJ?=
 =?us-ascii?Q?K19l3dKuag=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0f88a3-9ae3-4542-d7c5-08de759d1bed
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 01:11:17.8129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yH/WVmvdQqqjofLJZY5roCmDS4E2uSCnFKgiSkxrwVYw5q+hOkdSVkznXjLX1HHm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9459
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17262-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B04711B1649
X-Rspamd-Action: no action

For structures with comp_mask also absorb the check of comp_mask valid
bits into the helper. This is slightly tricky because ~ might not fully
extend to 64 bits, the helper inserts an explicit type to ensure that ~
covers all bits.

Tested-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Acked-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/uverbs_ioctl.c | 12 ++++++++++++
 include/rdma/uverbs_ioctl.h            | 25 +++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index 81798c0875ed3a..5e5b00c6236fa8 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -898,3 +898,15 @@ int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
 	return 0;
 }
 EXPORT_SYMBOL(_ib_copy_validate_udata_in);
+
+int _ib_copy_validate_udata_cm_fail(struct ib_udata *udata, u64 req_cm,
+				    u64 valid_cm)
+{
+	ibdev_dbg(
+		rdma_udata_to_dev(udata),
+		"System call driver input udata has unsupported comp_mask %llx & ~%llx = %llx for ioctl %ps called by %pSR\n",
+		req_cm, valid_cm, req_cm & ~valid_cm,
+		uverbs_get_handler_fn(udata), __builtin_return_address(0));
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(_ib_copy_validate_udata_cm_fail);
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index 5ea53a49b7c6b5..e4719419460422 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -1044,4 +1044,29 @@ uverbs_get_raw_fd(int *to, const struct uverbs_attr_bundle *attrs_bundle,
 	_ib_copy_validate_udata_in(_udata, &(_req), sizeof(_req), \
 				   offsetofend(typeof(_req), _end_member))
 
+int _ib_copy_validate_udata_cm_fail(struct ib_udata *udata, u64 req_cm,
+				    u64 valid_cm);
+
+/**
+ * ib_copy_validate_udata_in_cm - Copy the req structure and check the comp_mask
+ * @_udata: The system calls ib_udata struct
+ * @_req: The name of an on-stack structure that holds the driver data
+ * @_end_member: The member in the struct that is the original end of struct
+ *               from the first kernel to introduce it.
+ * @_valid_cm: A bitmask of bits permitted in the comp_mask_field.
+ *
+ * Check that the udata input request struct is properly formed for this kernel.
+ * Then copy it into req
+ */
+#define ib_copy_validate_udata_in_cm(_udata, _req, _end_member, _valid_cm)    \
+	({                                                                    \
+		typeof((_req).comp_mask) __valid_cm = _valid_cm;              \
+		int ret =                                                     \
+			ib_copy_validate_udata_in(_udata, _req, _end_member); \
+		if (!ret && ((_req).comp_mask & ~__valid_cm))                 \
+			ret = _ib_copy_validate_udata_cm_fail(                \
+				_udata, (_req).comp_mask, __valid_cm);        \
+		ret;                                                          \
+	})
+
 #endif
-- 
2.43.0


