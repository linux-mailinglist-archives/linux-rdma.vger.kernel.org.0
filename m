Return-Path: <linux-rdma+bounces-17271-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPZyIHTvoGmOoAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17271-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:12:20 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CB61B16A8
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3B9F3054329
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 01:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D53299943;
	Fri, 27 Feb 2026 01:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lF87BZC/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012041.outbound.protection.outlook.com [40.93.195.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA372C326C
	for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 01:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772154692; cv=fail; b=l93Jd+LOD4IKyZBWgtSxEr9MPImyeSGsdzCB2Cbi/4tT3u1Rc4DltrddRvwVH8DG1+0Kht3OMdv1RZu981KdoQ6KDV8UKO/mgeDxvmIrsz/+UDIKzpUx//rFVST0BQ7UCa1shs1Z9FhLnyIV3KO//BV4I+akYejuSorHQ0cbS0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772154692; c=relaxed/simple;
	bh=DuSno1RMkd/GQKS2VF2VR2JUC6zIAjrsqzunUo77Xts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OSRBwZmuD3D/2wwpTizKrdadeNn7T+P4M4f2egAKH5rugdrzWepdpOAK0JI/6NXZ73toXnEmsYRcEjxPmbRDclxyrNKJ7K4bchvV8ZD1MmxfBvVOYhUZJjiNJ/9vm15Y01BRIWpbvnpqcrL0TScFBA+iAivi7JzTrWw7DURkMfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lF87BZC/; arc=fail smtp.client-ip=40.93.195.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJOAv+xMy1RMmSYLQ40XPApLZtojCP5zwZpVCnJFiBQN6TJzUQ6LA9UKxyE/UPvZxramt1KNiL/YNsNsslo6F4CNJyXmUOgXleQCrTp7rIXjCDxWOkkPC1sRTEVp2Jy2R0k2S+u3ZGrK7VqpQhJexXnHTdDiTtZYBoCjzhTaqYC+Tehl8CywG7PIC/frUwBnJsFW+gbShuXoSrszQ74UXkJAWDEXEN4LKg5PqvdhcWeD2Ddcm+mnZBhdgdDzjlcyTQqNExwzu5S17xhtU/54RTUhOldU7CSDHWKwISb0SvjEC4/Di5pw8k/o67rZwYDQJe8YL8oKaJnLfnPHZpgkiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1RncbuCeN4eYS8YRmtmbYdUkWksMZU04tCz4eJnLwk=;
 b=ZvnrlfjasOBbSOK3QIEWwc6NMS0iuyY8kfuQ8XIDDQL+FmPbzs5yfX38ChY+25Mejmc8NQF9IzA9V8tnDmSkIqvqsdYwpUhKsnzhoAYD9R0sD+5m2VP4BPlIbComf3QxdwDGkRYad+iWxOw1a52f7jO4ibGLlMnKnN/KRj9Imb41pu/LX1AmuACDyEnjRu1cCWM77Hdipo8j/93slyIbpxhtcuHmsFcE1cvoKP85OdD9W5AfKoog16Za1mfcws+Xd3n0ZuBZKzAMtKspmvWP/he9c+ZtewIF4mS833XojgvT26LXlGAk/QqAGBtgNisquY7XjGH8HhIdlOraMBicPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1RncbuCeN4eYS8YRmtmbYdUkWksMZU04tCz4eJnLwk=;
 b=lF87BZC/7sGTO7Q+ZztiyFpC8A5C8lfHe9hQErLqtLszLlu+pRHrUvhCwmsopabaI9bXZQvmCq1AKShrYpFFb1nj9ysnIBtZ7LVGoOdpQRj9YRTneb7kxiAP+y2yS8OWrhC41gHOO2Oj/659LH2ICpe163jUja6aBSlXEjJ0uG5tCvYEJ5fxYToK3E1pepEiPjx+1ApBJDXZRrvWXtmgIsXEjflGo6Q/WbcJrfCsANAySoE42LpPii0YvC3SOof23bQV6cOLM1tJhvvtySgugRlriIo0toon7OOIxxxQvs6/BtOk5866ySxJ935kSbwyKS9G/OubNGVLTAzerXnS7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 01:11:23 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 01:11:23 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v2 10/13] RDMA/bnxt_re: Add missing comp_mask validation
Date: Thu, 26 Feb 2026 21:11:13 -0400
Message-ID: <10-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:208:329::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: 48083c92-3e3b-4396-acbf-08de759d1d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	Ikju/by9RV5xRaBrEf7Q+NpF7RuFU+k6e6akzskfX2f0iEo6m4RQAlb9HoTCdV+5avMt3Me6F8RJiC7UD3dgMJLF8cn3s9iiDTXp79s/UedcqqE+2iQynT7KRptQhn9DQiYtFkPQN+6muHY5/waiBpA+xHdQe5dnCBbF1yTrsnoJgIUSG0ILyeaEKp2uj30CucIwmLRqetR/S/staM5pUbbggacfBtwjkXvxR4xZ9bvwRcCCGfYS/IC53F11tXLSNa4eQwWtraChqASjNyRIDxeFFLS5GDUIVhXIfZq87e/u7SgbB/1h8xFlBWzV5nz/YjsHplfznNFWxuSmVsNndtVsIHXJHKVccEPAnoXlqfpEibxil2jCH4Fx6Kdvev5Vot+ZZ2GMmsS084ldbQ5kliLPXGaeeNZ/3aAFzzhzSqIwAMr9VsiD90mF7Wgte9VhQeuKhplV2VcIgoENOP5+ENU+teROKYh0th0TRWAYDr3j17awyN4vT5/W/YiI0l29uax0tNH4gjPm229J6u8iulkDSNJEIYcCitldax44EEXeMZkCVyLUApfJqRAM1OU+aEV1UyQgtimUbtkkcKbbB77NOCCa/ZLJh3essKZwpL848c9SBiCHfpR5W1fvoo7TzBXipF8fZSCcyGArE6SkSCqkByss7006+8Z98uNxNBjIAZ3Sq4Zk1aArreirpRVNn9ZzHG78ui6VlomgcJV19An4nqHAqEIsjywWMg5WPYo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ddvXBZvbwCilXPDWzgTZ6c/MV9NyPTwfS0LLJpcBi48/oXqqG/FYF0IC6RlE?=
 =?us-ascii?Q?cnsIlSUE+kX+vJjBJhCopJSZttfLQ2m9ONOzubLxQU8WkvAkTVcytDdc1v4F?=
 =?us-ascii?Q?P/+VMnxnl2PZ/VDyfh7UvpvrSC8VBkYHtcZ454dhNpVhBLAPljaXMN415lAg?=
 =?us-ascii?Q?rBSlDVbgManAzPTLMndTkZKHVK8NqBSsnRjhrPBJzJliq61dvqMbOktXOfgt?=
 =?us-ascii?Q?FIdgpuOfkq6vEZwNoqKHUjoQdp1sKbxw1OHu8G+N9T/A2DAGQK6oNRT/AmcQ?=
 =?us-ascii?Q?JM4hsGuV0uGLM6de8ptMeZvbJRuHAGCJ/sbmsLBgDgYIkklpRcuxh3XXjbNk?=
 =?us-ascii?Q?9cqLGTXxhiOjkru0UHyh97nz7UUXxPiIpcX11fNZ8TOJuML/ifhApMLN1Phj?=
 =?us-ascii?Q?AR6wjf9scE+2tvoL5tKXyBiEI++b7Q6WEYYf8YTJBDVd6f6X7dNBbElYq6HF?=
 =?us-ascii?Q?jQffqaSfyhMnIysH+B+t9/VVe/BIctCCjVDelG2LdnFaBCtovkulMagMXr6G?=
 =?us-ascii?Q?mROfw8HtZjsade2SzvPDHupMcg+oaBJOfluH4CirJKK0hpjyZw9YBYDuDM+y?=
 =?us-ascii?Q?y5oDsL+MEU77PrupCFSfII4yTZ/eidBOwOIekXklnJHCkgM29CWLAUdKpcnE?=
 =?us-ascii?Q?+Hfz29JnfoLcS5Uewj1clDmgzrVllG2arF5ArGZGWLIyaWIjHVMderEfi+Oi?=
 =?us-ascii?Q?IqeMrydByfZW2qD2ACr++lWfSmJkn9cFzlEcFfhooK98GbY/4lz1ZI6Wcw6d?=
 =?us-ascii?Q?pNE8erKOCmpNBnrQ1EGvfA1hGtVDBTOSogzxkMmpK1zifAnCGtSBom7Mze6Q?=
 =?us-ascii?Q?uZiTET6Y6WPcUSGErrREx5U6R41loXsVthwq9km8/YAAlHeew+8OKDwAokm0?=
 =?us-ascii?Q?i5pCv9OEx7/6Ooy27myIFveuxOszjrfOa+MGzyTstY+y+Y9jh1Sqk4uYSI3+?=
 =?us-ascii?Q?Ng9EXR7T5eN+nWkgrb+B8ZYtFsz3I9u8QcT2/KEgen69IYxnPjfuYwlZCcH+?=
 =?us-ascii?Q?yvqtxE5v2O5CMnBl/G9Ov3q4rskw6OziprReDxSPBdvw6wpq9ec+4jGF4DFJ?=
 =?us-ascii?Q?dL1ny3OAFk227A7tUacr90YSp0bc8s/jM0tT1ndneLNRb0BioiVs7ZluizGN?=
 =?us-ascii?Q?m80phQLUAVH3buxUsDELKapZVy11ovCm+jpFQdBu38HYtbwIEM8w0dxIwsik?=
 =?us-ascii?Q?OACpgeL2EOEWm1vpgGKDYCJKaHKIPYoVUI+4B7BMWnxChcnL/NuakR9TdGHD?=
 =?us-ascii?Q?E/2dYmL0L7n4Ej5BA+g/n/HD5PUtBjovX3vpzhsRfZRTANM2hxB2aPGsyVCY?=
 =?us-ascii?Q?u6N2WS9inwMSnTEli2SQfi5J+uxQcpatK8sUM2KfMSRrPPP5qwWItTkRrxSa?=
 =?us-ascii?Q?EVhSRCN4SlHXGBRKootolOZhPZoDI8ET+qKtQln0qRQSfxsGEoMDmsGA2BNO?=
 =?us-ascii?Q?3Yn1diB6VuZdnPhZtDDmW8HVytaGlMNX6mpWgmvGHXwRogaj6dMM8bB+Ekg6?=
 =?us-ascii?Q?NBAYUd6yjEnGIJ+sAJJb8jFKX1092OHgimcsUFonxpoQYAmx+IkHna0hmr4W?=
 =?us-ascii?Q?pceGpbYefOp0u12AUjGIhwZMBnmo8EryUVQtjR2R9p1WXRrH0cmz/VWL1Caw?=
 =?us-ascii?Q?wXBKuY+FW4JAAcBmg8gbAxVZDavTitVWP1eeTvM+qVQ9XdGYOrvq6+roCrVO?=
 =?us-ascii?Q?fsW1X/KjbN4E/zy22xi3O/kV/CEfXXO1+qDNWZu6mOv46ablxf5ndEtsgC6S?=
 =?us-ascii?Q?Q2+Xb6vTQA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48083c92-3e3b-4396-acbf-08de759d1d9a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 01:11:20.4444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxJ3s8QCxjVfMsSJel5/RXeVN2JLky2CPKULFHCn0pqZQ7UVzHoHJ1PU07OfNSDj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
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
	TAGGED_FROM(0.00)[bounces-17271-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,broadcom.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 19CB61B16A8
X-Rspamd-Action: no action

Two existing req driver data structures have comp_mask but nothing
checks them for valid contents. Add the missing checks.

Tested-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Acked-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 6d751febb28c8b..412b99658d9073 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1693,7 +1693,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 
 	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	if (udata) {
-		rc = ib_copy_validate_udata_in(udata, ureq, qp_handle);
+		rc = ib_copy_validate_udata_in_cm(udata, ureq, qp_handle, 0);
 		if (rc)
 			return rc;
 	}
@@ -4471,7 +4471,10 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 		resp.comp_mask |= BNXT_RE_UCNTX_CMASK_QP_RATE_LIMIT_ENABLED;
 
 	if (udata->inlen) {
-		rc = ib_copy_validate_udata_in(udata, ureq, comp_mask);
+		rc = ib_copy_validate_udata_in_cm(
+			udata, ureq, comp_mask,
+			BNXT_RE_COMP_MASK_REQ_UCNTX_POW2_SUPPORT |
+				BNXT_RE_COMP_MASK_REQ_UCNTX_VAR_WQE_SUPPORT);
 		if (rc)
 			goto cfail;
 		if (ureq.comp_mask & BNXT_RE_COMP_MASK_REQ_UCNTX_POW2_SUPPORT) {
-- 
2.43.0


