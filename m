Return-Path: <linux-rdma+bounces-1749-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 923EB895D51
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 22:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D46D1F2261A
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 20:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140F615CD6F;
	Tue,  2 Apr 2024 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="vZTAHSdL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBD115CD64
	for <linux-rdma@vger.kernel.org>; Tue,  2 Apr 2024 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088591; cv=fail; b=NLr2PWtFVJsBJwNdJEIhD7oF7HmBXdOwQJ+mRugf5/wUZP+9EdW94nSxCIB+vZVdAwqdmuiJLOB3FjOMLr8t6Sg9IVotJKyWrPXs6O9+jlN5so0Mlw5Yk7Gk36vgFLoD0PDi9AtO2DGsMOzbUMxaZ6Teu+7reHx+FPGNG/AdiRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088591; c=relaxed/simple;
	bh=lqRW49La2odyi68sXQA8flsiqJMc5IKimJsH+yvcY1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=XJ2JPEjMpLKBk44h95AUOlxu2YHQDAMn/w1wns3CsSeFNT6wgjVDEYRj/zitNqWTYrB2CHCHB8llBIXNO4AkxK/rYqc70YLlIZnCSegqIykzgxYNc2TquPz+SNntIt70kyScuw13i+gJgTbhsvm+mC9TZ7CXi4kGXlaZym4BO1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=vZTAHSdL; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168]) by mx-outbound11-231.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 02 Apr 2024 20:09:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEutyb+84zL7oMy4SIxqfa3zUOTu5ZxNB9gX7/uSXAqUYpmDzkttfL+PMKtcRbfO+zMgbYzYuZHNPjlec7yp4qBd0fdUlMydX1EWNL3MjcMSrHZT+PfExWisCdnUP1FfXM7LoYye1ljaCi7A+H+WyuDYOaeZ7kglHhO7h8o/Mbnqy3Z9hVtOwVLzsfJWreU90PXJME1oVtOBKppSebqIKY36uvZRIfXFieT8/iQiGDkJPipP1gTjA1uzOOccjRvWi8gUWIcIB3Q4oaBfCssWbgLTsHlW75m+Wh5iR5DXBjjoOdBeHSZRCa6ThRgVlhq5XbDkk4RiGfvfuHz5+bkKnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8aILtDnR7aHuJthAcNBLwQrSJLh+nW4RfJwPAS42mk=;
 b=CFHuubSxIBPwa5n4YVbPGD4wEYBujEG8r/SnsiSPo/aH2OjIHIdunFKEc7dCGCQ1r5RHVelsAP1MkPY50Z4XXtPdtFH4a5QnrnnzuDxjUvTjx4JcItm+GXuhQxElb/Q7CBSzr0mneCxhYQsP+ItkpxA5nlgfUCLykWSgf8GDMndbsN6f3oIEqSTS9jXBqp+ULzkVT+lmGgm7H7I5pQQg+PYhXPgOvaaJCAXT8RzkpYDkyk+S+kTLmQQV0LxPrR7xRVfQmdIKCBJ6o44wni+oxaf52fz0Ood36l11+0ukUp0whocIfFAbEDbnYv4OvaMnJcXj4BTh/EG9HONHFgFhdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8aILtDnR7aHuJthAcNBLwQrSJLh+nW4RfJwPAS42mk=;
 b=vZTAHSdLNoNq7YgBuJjIqdcLikRj6mJPi+0znKtU8N6IFjr5Vi6gxg9rR/HE+B80KaryIo3Du/KKBkYi1CgR6bSAelZNM8dQdvY0uV/IKqFSL5b4oHTpxipIUuz74JJHrBiOK/ZNrYdnHAVemrkQ646HhhENAuKRMOPzhJz46Fc=
Received: from SA1PR19MB5570.namprd19.prod.outlook.com (2603:10b6:806:236::11)
 by DM4PR19MB6270.namprd19.prod.outlook.com (2603:10b6:8:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 19:36:48 +0000
Received: from SA1PR19MB5570.namprd19.prod.outlook.com
 ([fe80::956b:a5db:c859:cfa2]) by SA1PR19MB5570.namprd19.prod.outlook.com
 ([fe80::956b:a5db:c859:cfa2%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 19:36:47 +0000
Date: Tue, 2 Apr 2024 21:36:33 +0200
From: Etienne AUJAMES <eaujames@ddn.com>
To: jgg@ziepe.ca, leon@kernel.org, markzhang@nvidia.com
Cc: linux-rdma@vger.kernel.org, Gael.DELBARY@cea.fr,
	guillaume.courrier@cea.fr
Subject: [PATCH rdma-next] IB/cma: Define options to set CM timeouts and
 retries
Message-ID: <ZgxeQbxfKXHkUlQG@eaujamesDDN>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: LO4P123CA0676.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::14) To SA1PR19MB5570.namprd19.prod.outlook.com
 (2603:10b6:806:236::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR19MB5570:EE_|DM4PR19MB6270:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D+GxwM9ERDjTSOWblq7Yk5C+I6CrkmGJInGwDTIU3yEQvfnXfaaOGTGy0rsEx2K0v6s0Jp7KeOKM3ROBjfti+nts4CV9QAnyYXTDwBIh8cypG2ilzn/SBX0tx/1PAhLeKrtTuO3cZCRriryHexDG81ufbZop/ndZFwrY4I+SAHKIDOCHCqDglSteg50L1v0aDPCY8DSo6YPHFOlmbR2mLyOS4FMaUArIFE18VjSXgA1dggaJBpZSj6HsgUKppbHmv0I6657nPN8bQGuN6aFPcjGJercthsQVoIWKssuMPiFwfcN0iMul7IIJnqji/ATFCi4z7goMAThrHhnxR3/24MtBYhNHuI2K4SNbMPaUyK+1T9TjYHzuFaZsfhm+SUKc284pQVYbNPRz1BhzfXo7/rzLr6NClq/G/s3a4gYVJS9+yx2MBaEIv6pdg7cl9lC1LP/PoTQUgqn9QeBy5LBDO/2Q2rjrqtXf0jIbZqChzgwE34zEa2SQwPCekI8kLENy3/VAAgictnBXzSfToPEDj7D4IrABj2croWRhKRuhXUQMRGqoZhK67gWlGsg5Hxqg3BOPOKmA3UgZfWDn29p/B5E2xOCrfgmi2+garBENu/VFyvllPpNZ0pl5ZdPuxQOOkx++sRK61b1eyUrZlrnZtteMr0RLB8bydM3NF/97H6E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB5570.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KIAO9CRDc161SdnEnnmoeg3EhMb3n2zNkW3k8SJThMaGuRNy1ChUBiIpLKZc?=
 =?us-ascii?Q?t/GuEd3wr6k5rYYa0lH737PhUDmBAe5jsMIBvmUDvwkXEmSvtLxwdzp+f25I?=
 =?us-ascii?Q?1oz2NL7N97BLPj/6aDic7ffsfkOxdhPUX3paKZvjaurEvlSW1l7fEF7P9Wv7?=
 =?us-ascii?Q?uARxpuQHxtJyNZiD7fL90zRAzz50g+eAyhqZXF81YMyR/KzMC7JvkPbuHX4N?=
 =?us-ascii?Q?FXFXOI9Yo5J2hAuQMjOmjfkUm7npMWCJvtOV5pPVvSo4eAq7puQhPyLWiE1z?=
 =?us-ascii?Q?dHGgPYxZ+1eIuffnLEHZHZfyWoJl+Tf4sH/A8rWoW1Wtnm+eB4vQPzRGPMT8?=
 =?us-ascii?Q?zVU2F82s4J8l95Tz0Uca/tmblZAEg5kMou/AWS8DVSnAgcThBOF2ogrYXkCU?=
 =?us-ascii?Q?8j7dbz5ys4NZ7cg+nLUWQ6bvGdaXkNHwcgvtVfnDVAprVr8JuKudgnTRt5BG?=
 =?us-ascii?Q?EFiMKaT9pymCCrW+xgIz1WEqluifapaH9LeGbHPsSm8VcpLcmewDAf0CiLf8?=
 =?us-ascii?Q?ORRzQ/7rrnr/iBUFOfmDjKdfEtfOcSpyZ1Spn9Uedqj+bxBJ11PzRFMF5GTS?=
 =?us-ascii?Q?c+OzyvJBEsCUa1Ra/XX+NLdROC9RrIuLDIca53rPEPTj+QucGqcLNJxFHDSL?=
 =?us-ascii?Q?VqsIo4CNLGaCYzoO/Owv2xXVS/C9pXc6pXGT/gIFNs+f/UkdgxKKsnFyLlm6?=
 =?us-ascii?Q?W8pTm7morwZXJpeFyPSYGDELdZec9+Sag4QOfj985pQ+ToyU2j69gYL4qEIL?=
 =?us-ascii?Q?weecGYNrdBLLMjYyQzO/b2qYcsGlHRHbI/b4MbhvQhVpV1tlNv0lv2P3XNkd?=
 =?us-ascii?Q?RHgdh0NPRmyZbYx0p7eft+/7UzKpjLA/9zMa4WoIToALeKk4K63hPLEZaQet?=
 =?us-ascii?Q?LeWpxLbC0INwiUWxMwCYdl/618zyDY56IHmFMwBSBzl2WF5p+z7xlqSJ9g5s?=
 =?us-ascii?Q?mVjz6d4JbhAbOlx/fowp7wTDQH7wn/cTCbQ4Hu8A9XL54PuDvL9dpkMP60jT?=
 =?us-ascii?Q?3W7qgNtboGqVs16dRWC3jq9ejqUbptGjqD7ATEYP9iwKbPyhETGeanjRGBbl?=
 =?us-ascii?Q?coGFDP8G3iHhc8PkBYRUMWtqs3QXiaA4iQBa49d2rSdDVb5TPA9t55U2U34F?=
 =?us-ascii?Q?VGYdC+jDYEmbnneaP8xGCQFtrJh0I/Wg9jwKEetXofkVwjucZ345v1mnI8iI?=
 =?us-ascii?Q?WleTdDqudHrMg4ls2fyJBDwEghYXmued6PCiEHh+T/+q+yZBH1vdMOQ+6zaY?=
 =?us-ascii?Q?zg1xkVmwQdOybUH9RXprnhBRr7WnT6lmqqyS9YC0V4oRGQ+0eFDFeAB1Y7H8?=
 =?us-ascii?Q?WoGbQn/1AwspC6Bd12BXiHM72PKwQtkO4N4Fz3b0d55sVhLsfmIVqh7qNEn2?=
 =?us-ascii?Q?UeNjypuQcOG5oQaFRAYigofw/xSQRDQdKMjy2NUx990IUTgueuemqIVmzKNu?=
 =?us-ascii?Q?ewZ61aaiFG/Ti1AGqmc5naQoQvYe1kDWgAq068QOYvLbHxiJ0YMVYZmhL8YS?=
 =?us-ascii?Q?9tC50Fyymw24NNXf2z9aZpSihbr5+O5jmNziLwBv/YvOar2Jpzg4te5XL9i2?=
 =?us-ascii?Q?kkwIqFn7/I/9TLBckVX4OT7B4qXho8+c7oxwmGzcuS4hfppCvON5a10GQga3?=
 =?us-ascii?Q?lgvPO/ZPfuo9wOrMCMy1JIaOMp8EIZ9cSQQwI9Wl4PBA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f/3uAdEuok6bhaiJ7krTNHFb0JuCkeV2Ji4xRIyKouGl3HA+olHGCG/9znHUUV2mi+lZiUEYbETtGgSip2l64Y4ReWqMlDGTuAqsiDM3u1PFJ2QX/O0ftgtrPCb/MsbB6ufXG9MtFjfu7kSSqIHc/fg4uchyIb3hpdlTF2Jw1hMZH6JxvunyfHhBPPu3WalqyV64ybxSyKnlzaQXG0kG1oH/RO2NW68SPhJVxFkoR9XPaaL58vBA3VWJarxP9kB+tDQzbuCAw3W7A8e8frAEmwHYuu9xc5ieuJQv+t3bmBY5jA8Lf7R3uYQDAtTkDcOsyAjVi05a1j82gt9hD5DL08+c2nLWc9dnWzuWrbTrSWjY3D43e6pzp+AHh+SdixLjfThd9sCMy+SRzmYexBaKo9QeemY0kAt2KjsKIyYvj28+dV6fkcenAaERLHoAa+hDYih63QqqRtN5HdN/ZnyK88GIJaHD2tFBSRxyijktNlskq0oSiUw43iqAsLD98gd1etiJ7d9fUf7SPYBQLylixd0Zm7V1QuWbfnESZNhITtOGZsjArJNqMVlACjta+WV/CqfWlY2DHcwFttutsoFMOae+qIcK6flQHlaZkO5LEVxUmu0kFwQJ+U/DhzwCbVqrBB+NXLy1bKxxrPXepCzPbg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 964951c8-0f82-442b-8217-08dc534c3c6e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB5570.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 19:36:47.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /O49S8UX0CPdxNGzQEMNL9xcFqyJkXRYXDWddQya8o1ONSr+v5DCbErV4K+pAKgQY/brrLc23PYgYtrjb4gfZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6270
X-OriginatorOrg: ddn.com
X-BESS-ID: 1712088584-103047-27234-8981-1
X-BESS-VER: 2019.1_20240329.1832
X-BESS-Apparent-Source-IP: 104.47.73.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuaWpkZAVgZQ0DQ5xcggzTDVws
	Q4KSU1OdE0OckozQwoammemGaSmqhUGwsAjZqaOUEAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.255293 [from 
	cloudscan16-11.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Define new options in 'rdma_set_option' to override default CM retries
("Max CM retries") and timeouts ("Local CM Response Timeout" and "Remote
CM Response Timeout").

These options can be useful for RoCE networks (no SM) to decrease the
overall connection timeout with an unreachable node (by default, it can
take several minutes).

Signed-off-by: Etienne AUJAMES <eaujames@ddn.com>
---
 drivers/infiniband/core/cma.c      | 92 ++++++++++++++++++++++++++++--
 drivers/infiniband/core/cma_priv.h |  4 ++
 drivers/infiniband/core/ucma.c     | 14 +++++
 include/rdma/rdma_cm.h             |  5 ++
 include/uapi/rdma/rdma_user_cm.h   |  4 +-
 5 files changed, 113 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 1e2cd7c8716e..cc73b9708862 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1002,6 +1002,8 @@ __rdma_create_id(struct net *net, rdma_cm_event_handler event_handler,
 	id_priv->tos_set = false;
 	id_priv->timeout_set = false;
 	id_priv->min_rnr_timer_set = false;
+	id_priv->max_cm_retries = false;
+	id_priv->cm_timeout = false;
 	id_priv->gid_type = IB_GID_TYPE_IB;
 	spin_lock_init(&id_priv->lock);
 	mutex_init(&id_priv->qp_mutex);
@@ -2845,6 +2847,80 @@ int rdma_set_min_rnr_timer(struct rdma_cm_id *id, u8 min_rnr_timer)
 }
 EXPORT_SYMBOL(rdma_set_min_rnr_timer);
 
+/**
+ * rdma_set_cm_retries() - Set the maximum of CM retries of the QP associated
+ *			   with a connection identifier.
+ * @id: Communication identifier associated with service type.
+ * @max_cm_retries: 4-bit value definied as "Max CM Retries" REQ field
+ *		    (Table 99 "REQ Message Contents" in the IBTA specification).
+ *
+ * This function should be called before rdma_connect() on active side.
+ * The value will determine the maximum number of times the CM should
+ * resend a connection request or reply (REQ/REP) before giving up (UNREACHABLE
+ * event).
+ *
+ * Return: 0 for success
+ */
+int rdma_set_cm_retries(struct rdma_cm_id *id, u8 max_cm_retries)
+{
+	struct rdma_id_private *id_priv;
+
+	/* It is a 4-bit value */
+	if (max_cm_retries & 0xf0)
+		return -EINVAL;
+
+	if (WARN_ON(id->qp_type != IB_QPT_RC && id->qp_type != IB_QPT_XRC_TGT))
+		return -EINVAL;
+
+	id_priv = container_of(id, struct rdma_id_private, id);
+	mutex_lock(&id_priv->qp_mutex);
+	id_priv->max_cm_retries = max_cm_retries;
+	id_priv->max_cm_retries_set = true;
+	mutex_unlock(&id_priv->qp_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL(rdma_set_cm_retries);
+
+/**
+ * rdma_set_cm_timeout() - Set the CM timeouts of the QP associated with a
+ *			   connection identifier.
+ * @id: Communication identifier associated with service type.
+ * @cm_timeout: 5-bit value, expressed as 4.096 * 2^(timeout) usec.
+ *		This value should be superior than 0.
+ *
+ * This function should be called before rdma_connect() on active side.
+ * The value will affect the "Remote CM Response Timeout" and the
+ * "Local CM Response Timeout" timeouts to respond to a connection request (REQ)
+ * and to wait for connection reply (REP) ack on the remote node.
+ *
+ * Round-trip timeouts for a REQ and REP requests:
+ * REQ_timeout_ms = remote_cm_response_timeout_ms + 2* PacketLifeTime_ms
+ * REP_timeout_ms = local_cm_response_timeout_ms
+ *
+ * Return: 0 for success
+ */
+int rdma_set_cm_timeout(struct rdma_cm_id *id, u8 cm_timeout)
+{
+	struct rdma_id_private *id_priv;
+
+	/* It is a 5-bit value */
+	if (!cm_timeout || (cm_timeout & 0xe0))
+		return -EINVAL;
+
+	if (WARN_ON(id->qp_type != IB_QPT_RC && id->qp_type != IB_QPT_XRC_TGT))
+		return -EINVAL;
+
+	id_priv = container_of(id, struct rdma_id_private, id);
+	mutex_lock(&id_priv->qp_mutex);
+	id_priv->cm_timeout = cm_timeout;
+	id_priv->cm_timeout_set = true;
+	mutex_unlock(&id_priv->qp_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL(rdma_set_cm_timeout);
+
 static int route_set_path_rec_inbound(struct cma_work *work,
 				      struct sa_path_rec *path_rec)
 {
@@ -4295,8 +4371,11 @@ static int cma_resolve_ib_udp(struct rdma_id_private *id_priv,
 	req.path = id_priv->id.route.path_rec;
 	req.sgid_attr = id_priv->id.route.addr.dev_addr.sgid_attr;
 	req.service_id = rdma_get_service_id(&id_priv->id, cma_dst_addr(id_priv));
-	req.timeout_ms = 1 << (CMA_CM_RESPONSE_TIMEOUT - 8);
-	req.max_cm_retries = CMA_MAX_CM_RETRIES;
+	req.timeout_ms = id_priv->cm_timeout_set ?
+		id_priv->cm_timeout : CMA_CM_RESPONSE_TIMEOUT;
+	req.timeout_ms = 1 << (req.timeout_ms - 8);
+	req.max_cm_retries = id_priv->max_cm_retries_set ?
+		id_priv->max_cm_retries : CMA_MAX_CM_RETRIES;
 
 	trace_cm_send_sidr_req(id_priv);
 	ret = ib_send_cm_sidr_req(id_priv->cm_id.ib, &req);
@@ -4368,9 +4447,12 @@ static int cma_connect_ib(struct rdma_id_private *id_priv,
 	req.flow_control = conn_param->flow_control;
 	req.retry_count = min_t(u8, 7, conn_param->retry_count);
 	req.rnr_retry_count = min_t(u8, 7, conn_param->rnr_retry_count);
-	req.remote_cm_response_timeout = CMA_CM_RESPONSE_TIMEOUT;
-	req.local_cm_response_timeout = CMA_CM_RESPONSE_TIMEOUT;
-	req.max_cm_retries = CMA_MAX_CM_RETRIES;
+	req.remote_cm_response_timeout = id_priv->cm_timeout_set ?
+		id_priv->cm_timeout : CMA_CM_RESPONSE_TIMEOUT;
+	req.local_cm_response_timeout = id_priv->cm_timeout_set ?
+		id_priv->cm_timeout : CMA_CM_RESPONSE_TIMEOUT;
+	req.max_cm_retries = id_priv->max_cm_retries_set ?
+		id_priv->max_cm_retries : CMA_MAX_CM_RETRIES;
 	req.srq = id_priv->srq ? 1 : 0;
 	req.ece.vendor_id = id_priv->ece.vendor_id;
 	req.ece.attr_mod = id_priv->ece.attr_mod;
diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
index b7354c94cf1b..e3a35eb1bf96 100644
--- a/drivers/infiniband/core/cma_priv.h
+++ b/drivers/infiniband/core/cma_priv.h
@@ -95,10 +95,14 @@ struct rdma_id_private {
 	u8			tos_set:1;
 	u8                      timeout_set:1;
 	u8			min_rnr_timer_set:1;
+	u8			max_cm_retries_set:1;
+	u8			cm_timeout_set:1;
 	u8			reuseaddr;
 	u8			afonly;
 	u8			timeout;
 	u8			min_rnr_timer;
+	u8			max_cm_retries;
+	u8			cm_timeout;
 	u8 used_resolve_ip;
 	enum ib_gid_type	gid_type;
 
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 5f5ad8faf86e..a95f513077ac 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1284,6 +1284,20 @@ static int ucma_set_option_id(struct ucma_context *ctx, int optname,
 		}
 		ret = rdma_set_ack_timeout(ctx->cm_id, *((u8 *)optval));
 		break;
+	case RDMA_OPTION_ID_CM_RETRIES:
+		if (optlen != sizeof(u8)) {
+			ret = -EINVAL;
+			break;
+		}
+		ret = rdma_set_cm_retries(ctx->cm_id, *((u8 *)optval));
+		break;
+	case RDMA_OPTION_ID_CM_TIMEOUTS:
+		if (optlen != sizeof(u8)) {
+			ret = -EINVAL;
+			break;
+		}
+		ret = rdma_set_cm_timeout(ctx->cm_id, *((u8 *)optval));
+		break;
 	default:
 		ret = -ENOSYS;
 	}
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index 8a8ab2f793ab..b5923ceb9853 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -344,6 +344,11 @@ int rdma_set_afonly(struct rdma_cm_id *id, int afonly);
 int rdma_set_ack_timeout(struct rdma_cm_id *id, u8 timeout);
 
 int rdma_set_min_rnr_timer(struct rdma_cm_id *id, u8 min_rnr_timer);
+
+int rdma_set_cm_retries(struct rdma_cm_id *id, u8 max_cm_retries);
+
+int rdma_set_cm_timeout(struct rdma_cm_id *id, u8 cm_timeout);
+
  /**
  * rdma_get_service_id - Return the IB service ID for a specified address.
  * @id: Communication identifier associated with the address.
diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
index 7cea03581f79..eadff72ecd54 100644
--- a/include/uapi/rdma/rdma_user_cm.h
+++ b/include/uapi/rdma/rdma_user_cm.h
@@ -313,7 +313,9 @@ enum {
 	RDMA_OPTION_ID_TOS	 = 0,
 	RDMA_OPTION_ID_REUSEADDR = 1,
 	RDMA_OPTION_ID_AFONLY	 = 2,
-	RDMA_OPTION_ID_ACK_TIMEOUT = 3
+	RDMA_OPTION_ID_ACK_TIMEOUT = 3,
+	RDMA_OPTION_ID_CM_RETRIES = 4,
+	RDMA_OPTION_ID_CM_TIMEOUTS = 5
 };
 
 enum {
-- 
2.39.3


