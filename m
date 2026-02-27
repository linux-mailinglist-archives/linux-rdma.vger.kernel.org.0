Return-Path: <linux-rdma+bounces-17274-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKwBMA/1oGk8oQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17274-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:36:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 434411B18BC
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85A5130BAED1
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 01:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ED5284881;
	Fri, 27 Feb 2026 01:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FHB8+Xf5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160BD28D8DB
	for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 01:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772156096; cv=fail; b=TmJ9cCoAeyEecxfnkjzfeoerr2ZOxJp7P0G2MFhhBx2stGlDA5l70ptFmUeRG4EXqLTMnSKetr6Jil3BxdEyIG5+dJkiFlXA4bxCZ2PJhpdyO3HHpUJ8r6Lgi8MCOvAf90iKqFNnI8uqMNEz3tUMwQbJo0y/TXy9dLha9N7+knI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772156096; c=relaxed/simple;
	bh=swUizTVbC9uGkmPw2nxIyOPUHErS0U54vdWHCu1L+cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mv9ydsACAEj9vKF266prjyGmwHk/bqGsj2xMecnQ6DjCUQDaMmLXXlgcbqyIentbbLB/OgZ9Y2B2zPuzjE9k2Dk4LqBG2dE9z32si2BKLGqlxEIV6zW7E+1GBK1vHlPykkXJeij7DaICOj9BTLq1JdCmp3VthWycrLeDE4tiy+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FHB8+Xf5; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gi64sXrOe//iXh2uwkvlFx2PkChfgHIf0rWTUiIg1Pl+ai62DIWj6JleqGwI8OTa9/wTDtra2NfWn512ZD/7g7uf8ynM9LHazNb/udSXcHIgtWf6zmCylrENco/FgRUm8vbD1wjtOmIQViYyP/QDCeAFKfYV3pTzUwlcfqvESrBIYynx/Ry4uwnAVGB+LqRjo7JpGXjHfAVQJuIoS/0f251B2ms03X0ThpME5oqblJDBEB0fYCaGJaQx+n1WO8u1YXcB7lpwJPcHNudLvhVy6sCocYnniNxfdkI6RhyY+zxIRrlhiyj5pxKIHgna+pFu1okdoLuCvjamhF1XbHKAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=if5m9X68kB5wsZZ0iT5/YwY4EQDcD6EJm41+DlAOUy0=;
 b=h0xFOLBaVJrrBE3sOs98x691X5ukaZPT4SMkZCjwi315sYNM7/6QPgmY6h9vrSrEqdcKds4COcqmsKmop3Io5jcP5mE3ToZg99NUMa76mVsj+tSlI/hwuAETpgZYc17dI9p1skyZ2DjszXzBa92PKOo9L1Oz0jL/Bj5IJ6fg4jESVeTLnoqMIXcvNmKWiyRlNt+8laVlmsINp4YrV9hGEFFtHz3Pl8u8FBt2AJVtB6fswAThTiK2HqAKnqU46lnA/YE5u5Vw4b2e+bEQbt8YfxoH0v4iEJV78uPnbUV4aMCy1cAU1z7xxMUrVXHtlshYJrOKyG34/3ZW8YcgmhYaYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=if5m9X68kB5wsZZ0iT5/YwY4EQDcD6EJm41+DlAOUy0=;
 b=FHB8+Xf5fWdYaDFY/J5OozLsh736Q6ZB4iCx5xLDZ7RuhPs1ncy+aeyas70NOd/UoTHHeaLGpobpLkpNb8vINOFQak6jFsJGVXJOVZoBmL+pVbM8UEVEuQYaSSEGAtbreUwypyDMMCfaqND7VC3CRgY49YWVT1jyOfsOb3fTrfDBXuqAIhiIU+Rw+fHh6LEHG6ONDIh4YjgKZkVjD/FWPOJLsAHOPMyB7h4bbD8i8SK4IjA+4VxQfSo5Mp+Lu66BSjU5dq/f3bzbXazC2rHmQ5WcNKMk2og+m8G4U4uMk3mCQfyeind26p+DKch8b5bNynXw5fVTaiI1DR9EgkBJ6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 01:34:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 01:34:51 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v2 08/13] RDMA/bnxt_re: Add compatibility checks to the uapi path
Date: Thu, 26 Feb 2026 21:11:11 -0400
Message-ID: <8-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:208:52f::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 412486eb-368c-4d20-c0ea-08de75a066c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	E2We9U4uRsG1DfxzpSEnUtqeVxc+t3ZzOjB623Gvjod3EC0YGgkxTQLc8Tcce4q9sE6W21JUV2ooBRftaUbq9XU+sthm+8H17h+4paXCA5tVmWjarsJqrfgq3+GzMsQRvS8Dksx4d+GRfmE3y8zJ+DBsi8AELMc4Frr019nNZ9/ZkFI+ZjR2YE4j5EWPEHWdi/1g98O1/PRbDbfaaxOtT8+ON7Cjcpc8S8mMdR5KufAal96CyHm4uMoaxbfWWbQ7sWIN7vfb3UokAWymAPY98NjtQVyUyS2LQmJ3+ZAtjWxVhLlP19U7GaRygpMvNBEIlvyxFofwgCSd5ur0nzyTvwRIUVQegzFZHAUdlDlEY/kjoBi3gaZyOGpPLG8gJdpqwvjooZC9Dard9GJudksSDI4Q+nIgV3XziQrVc+9CG0Bj219za+ULWB1ozDS6cGKSLWFF450fX0aFG8jKcuL2BwYUEEGNyIPfi3II3XqypmDfWvlwRWy2n6j0/ewndQxlZZ8ms34FzLKwoFYOElC1okOYqpmWS97ib9XPA8tElRX5W6wLOVoAyvFdO+5vaYj6pwdz7V9vgCEx7C3swsXTVG59yBX9nwbkVL221p7xIeOzQzsB2D/FgTINsDOcl8fW2hf50OuJPFky2YHzQ1I5yfVnejySs1v5hWIA3yJC4mwmPbvBsYusTIJ2OkxUIusW5JVPJDezc9IaRsYQmDv7fudO7Cg/6ZNTD7J4Nhnd8mM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?orG8EraI8p4fBm/CZipmkkpXd7g6CQe46vl39sLNCabh4Ii0AbX3sc9gA+1o?=
 =?us-ascii?Q?VvAtqZzcTMUD1KM9Y8jOQslwe1B4zbJUOPsuA2legcIVa6NMEFaZAo8cczPy?=
 =?us-ascii?Q?BVdfDRgmJAXSDi4jd8WKe1RT2tJ9u0uBak5P8Agp0L+xigmVk+Y0d59wf17C?=
 =?us-ascii?Q?73azE0tJuvUUfT+fSU0jsl0R4Sab+HBXaIVK5cXr994FqE2lzAboWozbjnfQ?=
 =?us-ascii?Q?0rDVeM87pM47CkrpoxH68nEqcUugOKuj5NKLw1GvDwIOHDBUkOO6AUjke46n?=
 =?us-ascii?Q?TOvHUJpdgqom2oc1yc+qdPGDE9OzoVhsIwbc95crgfCZKTTgwPluuJpvjQb9?=
 =?us-ascii?Q?A2hvAhXVdAcomog9+IegXi2VxM5bxQjBwEG633Uz3F/JXEs7dQgyeCAwhN3E?=
 =?us-ascii?Q?J57RBknGlEZ40D/7+HqkLUErtX2z0zbHvAPdXGjDJMfGQwLzgyIHou2+x4Ib?=
 =?us-ascii?Q?yHqtfEIX6Q0ok3qwRKI0j9uevlBq21M60UFrTuKQXFLbgfauMIJeRY92S1As?=
 =?us-ascii?Q?BD3UhRLl3yvRu7NX54C/RXTXR8cN1qif239m8c/rXTKRoZvan/JEmo8apCdH?=
 =?us-ascii?Q?hcfO9De45Lpbu6xgvK19kbugOc4+j5lHvSc4Alglh/RFiIY7R6oDvvmcHkFI?=
 =?us-ascii?Q?uS8vzc2k51qMs96PVuHO8VReUD6m3rQaQZGpF3NX801TBkWmbE5IwKfoiSF2?=
 =?us-ascii?Q?+AvyoB+XRuO5/6V6seUvZqXpx0up3XEt64OV3Ba/57NLOEwQJKqexYCXxuJW?=
 =?us-ascii?Q?nZA936KzEJaFJ2XuA3TkmUZboTu5fWcV36AZMezNJoFq36063oXpIFFKgPjJ?=
 =?us-ascii?Q?PfA1D97sw8N0DiOKbEZ1oOIou0t1cAYK/A+7tZLaKY07p7Dhr7w+KNy5JnIC?=
 =?us-ascii?Q?3CEXHzpzWNdOB4Gp6xMpRvPI6AfCsiYCs/fGkdZtDIPby0GmMTjdRz/NlZoR?=
 =?us-ascii?Q?YTE/CXyW7C8Jwgdu/TsSOHh24KHay/1bAltbw3SREsojauI412RjdQgL3gGb?=
 =?us-ascii?Q?u7mvUmVCfTh0d2r5+kgEbbq/UC1Dwa/CYFeNB8P9QFqQG+mPrdyplEMfOuGq?=
 =?us-ascii?Q?gfS+z5w59qGpUCxkF8aK0FFBAgtertETY6SsSnuYIunXDR/fXCVEwksiqiiO?=
 =?us-ascii?Q?NHSLzQ41HmLQ7nd80kBzZIXaR58NmMSebPLukTRG8ic1tYgGgcP7e24hf1if?=
 =?us-ascii?Q?GQBBOqAV1kqPDoCO4bthjbdLOoSJMe6LtDC5kYWUhJTNOOwv0a2w665y3Ety?=
 =?us-ascii?Q?45BQ7GKcmPd3oToaoaPDguaw7K3B8O5YSjE9YeMbEg1RkSZBFrl0NeuB/8UG?=
 =?us-ascii?Q?PtBXQQrUxy8g+4QgSYSJgneHYPUdRjnC4qwCCRzzLxSvm4fgp0v4P3DkbACj?=
 =?us-ascii?Q?L9JgnGINurx4etR8HM3hFFjxAMimwh0JrkyybR69eW7OJv0MHcDBlsmRn96f?=
 =?us-ascii?Q?T2Sj+l1QyLL64KlScLYSiZe30MKdRL1f+wdgcIOEeJD+lFyhtdaH/7PBHijb?=
 =?us-ascii?Q?BvO8Q8qf6Fvp45JvGEhB01IxQu9PI6DpvFVGq0y2ccsKwkZldJZO7tPe47We?=
 =?us-ascii?Q?p+uoI0W4bVzjUYgJFPsZzn9QAVvI3TZWwB1/RgFgPt743wReYWa9cHpRrgq6?=
 =?us-ascii?Q?dlXITLhx7WJeYH6imDwhWWt1S7cCSWdNVyC803J+XkVFZwn1iK/RVH/EfyLa?=
 =?us-ascii?Q?oarBfImO/iiZkz4kIOPTXdVdu0jaTTZ/1vi0GvxGwOqQygMe2CfGNb5xwUJi?=
 =?us-ascii?Q?V7ilmO1aig=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412486eb-368c-4d20-c0ea-08de75a066c8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 01:34:51.5313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QogQAdkeexgBR8XZpwNpJop7GrdV+EicPvuULShyhW+jLGGscH6VSrYMhVVWXGg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17274-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,broadcom.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 434411B18BC
X-Rspamd-Action: no action

Check that the driver data is properly sized and properly zeroed by
calling ib_copy_validate_udata_in().

Use git history to find the commit introducing each req struct and use
that to select the end member.

Tested-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Acked-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 29 +++++++++++++-----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 5c5ecfacf50612..e1d72ae8261192 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1671,9 +1671,11 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
 
 	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
-	if (udata)
-		if (ib_copy_from_udata(&ureq, udata,  min(udata->inlen, sizeof(ureq))))
-			return -EFAULT;
+	if (udata) {
+		rc = ib_copy_validate_udata_in(udata, ureq, qp_handle);
+		if (rc)
+			return rc;
+	}
 
 	rc = bnxt_re_test_qp_limits(rdev, qp_init_attr, dev_attr);
 	if (!rc) {
@@ -1863,9 +1865,11 @@ static int bnxt_re_init_user_srq(struct bnxt_re_dev *rdev,
 	int bytes = 0;
 	struct bnxt_re_ucontext *cntx = rdma_udata_to_drv_context(
 		udata, struct bnxt_re_ucontext, ib_uctx);
+	int rc;
 
-	if (ib_copy_from_udata(&ureq, udata, sizeof(ureq)))
-		return -EFAULT;
+	rc = ib_copy_validate_udata_in(udata, ureq, srq_handle);
+	if (rc)
+		return rc;
 
 	bytes = (qplib_srq->max_wqe * qplib_srq->wqe_size);
 	bytes = PAGE_ALIGN(bytes);
@@ -3177,10 +3181,10 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->qplib_cq.sg_info.pgshft = PAGE_SHIFT;
 	if (udata) {
 		struct bnxt_re_cq_req req;
-		if (ib_copy_from_udata(&req, udata, sizeof(req))) {
-			rc = -EFAULT;
+
+		rc = ib_copy_validate_udata_in(udata, req, cq_handle);
+		if (rc)
 			goto fail;
-		}
 
 		cq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
 				       entries * sizeof(struct cq_base),
@@ -3309,10 +3313,9 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 		entries = dev_attr->max_cq_wqes + 1;
 
 	/* uverbs consumer */
-	if (ib_copy_from_udata(&req, udata, sizeof(req))) {
-		rc = -EFAULT;
+	rc = ib_copy_validate_udata_in(udata, req, cq_va);
+	if (rc)
 		goto fail;
-	}
 
 	cq->resize_umem = ib_umem_get(&rdev->ibdev, req.cq_va,
 				      entries * sizeof(struct cq_base),
@@ -4414,8 +4417,8 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 	if (_is_modify_qp_rate_limit_supported(dev_attr->dev_cap_flags2))
 		resp.comp_mask |= BNXT_RE_UCNTX_CMASK_QP_RATE_LIMIT_ENABLED;
 
-	if (udata->inlen >= sizeof(ureq)) {
-		rc = ib_copy_from_udata(&ureq, udata, min(udata->inlen, sizeof(ureq)));
+	if (udata->inlen) {
+		rc = ib_copy_validate_udata_in(udata, ureq, comp_mask);
 		if (rc)
 			goto cfail;
 		if (ureq.comp_mask & BNXT_RE_COMP_MASK_REQ_UCNTX_POW2_SUPPORT) {
-- 
2.43.0


