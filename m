Return-Path: <linux-rdma+bounces-17275-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NR8HBz1oGk8oQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17275-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:36:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1ED1B18C4
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DABED30C7EE3
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 01:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8EE28C2DD;
	Fri, 27 Feb 2026 01:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="riX9g5qo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999A2284B26
	for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 01:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772156098; cv=fail; b=AMrHuh6UsIi5L+UQ8kLKro35GeDtrPvhvk/brS9XVQhqw4xRuc+0iVXWomCCq9kX6lJIsgSCzZzSxxSeN8xSdAfm8VA/qHDpboGLNNnbYoul/eYXinuBCLFHZTY4xsyjQvMrwlO6B2WFmrktQiKIhlGBfSmJ42WXR3blc7ySH6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772156098; c=relaxed/simple;
	bh=pZLEIvCH1f08hyfz9ONfZG1dg4F9YcMeiK4TkDCh7ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kj7muH8BD9FyxMaaOpnWEfu6F7dAUPEYjtqorn+d41QpBGy7wd4XBC3ln+q9YkleiyWi0zt1xUtWm9PCAtJ0CJx6DblL7tuu6+Q/9URyfDUx4pGgf16z1cnYUQ9WVYhgftg8wHAPMWR9eF7DqGDCCgAJ89x2x7012OCXVKSUzHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=riX9g5qo; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVnF+CL70ldHQ0CnS7QG+TBJqOCSIufhCuEX7QLksFFRkKyESI2+IO/lCLQm+90S8y4P+lHXIFsDraYBKxKkLrl3mSujvECPm0wAX5aqcGiQ1iZHrW9G55P4x7DeNYo73jVUR/RQ4ObpSmJjBp6Gy3RF6/LQssm4R5zJyIi3QpnjfMQHFPe+OucgOOEGFVxw1hBCpIQvJOng1Cyiewjnu2WlyCT7bBSkbY2aHyBxzb2d+IeMcFp33RqudITltGii69ur/1Cdxy0phMt/xDnfjto17KoQlosvPBgrtE2YzxcLJBr5BJ4ntEAeN6O3j1cMBdiNwUCKp5YGmKVsj/x8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9d4+zHFLEDn1Ku4rMLpm2gIwb4UJdC+eVcB5Fcj9Ymc=;
 b=AJgpDLcq4WoX8+1zsygy8gxu1PtelueBEEie/Iw4Ss+ap7jUDWNSWmbofI3p4J3r7LbR2ZbGWG+0zFiKjKIFpgte24Oom1DjZ0/pCWbOafkWzwxahnuVQ0JaGGpO10RHBVE9EyVa0ZPEbz/rOLvVg8PpJzi0LlgoLCcDHF/sgdvFZuPE9gPzXOKgt9EOLKnjdHWv/qzqg6Litxf1sHXOKsUvLkRSMoev+9ipClUKGGWUP+1cmPwTwhvCGOwoAgWBv2g6PxfAkjxIvJ6P0BvdT6VH2aUyShSbwq5YCYEalzSIdJPRqhluP7bpGr+qoWLtlfzcfdhw1mc113VElaRPdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9d4+zHFLEDn1Ku4rMLpm2gIwb4UJdC+eVcB5Fcj9Ymc=;
 b=riX9g5qo7k8e3LTM16OF4DnQxTcCx5PbwUGaedLdaIXjX0PWsCFLcB3CQnR7zbwHNyEn+45FvJyx1ahY40CTWh2Oo7NcBiKoea3bch3LHQYpD8sCrIJbXC6IgS7q/UL2B2H7KMzgSTaKt602sGhiQbjVTIjHvAx6SXr16pGq2f4Iyoo12BTw+v5qKmecO8ksqVf8zc8ajY1PtAAO2LeNnYesrODuB+WqV1VlcLQC8DisGzOxoI751ajivLQOdrVJ9A+Iy1mO11goCx18e7CwRFz1wzIjSEb65IAxNrA4Tt9IHmjLKuORYvpLWZjsu+nxwo/3VKqoxpF1/nTAKRazuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 01:34:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 01:34:52 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v2 07/13] RDMA: Provide documentation about the uABI compatibility rules
Date: Thu, 26 Feb 2026 21:11:10 -0400
Message-ID: <7-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: db1ccb1d-8b89-46c8-d849-08de75a06784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	mIYi+kUZDEHDs47sDjenJhOoOvgVx3M0H95XnAgztnjYpf8o2TAjC8KH6f3Lazd/kHSC5dczdWxJiGllNmFQYngBXA0EAPNVO4+XTJoFmnwjMNw4RYSLv7ExEkJVKuhsW9dCKXPxxhyzcWMgbkDN73isApi7djVOFD0xxZacrdIW/XYG7jo1h9qTyOUNmwqKuY9YFci/Rl2mTbcdYEsIo6P8Gq0p+ie9zpxWxA9ek3Rav7LcmjOnNFzhThxVgRCo+1vmsFgiikFAIGqcYao2ucTg/lcjkTrnA2Lfzng40uB1iDIFvU29r9lo4DfOorXae8V4VqHaFbUjT96OwSaF4Xr9eaM72kWBip5frVzeO5uC+ZRU7oIJaVjowbwm101Ff+nKojnFKJrtsRvyZaO1apx/rjCafCbzIJVTwUTQSExoXoUhaRuJKxai/gyZIKDMiaHKhzpuLdUlGWjmTCPKTSU8tswHsCiVHaFXm7VeoWZzTlbOQOCUgP/tRqTUPilpXUWb0oiFnxF3GCmY+AZAooKKaw7/llI2DhhrKfYScr0n//P2h0YoNgWKE/DGLByfIBi6FWlJTrbb3zPD9iwqQKJJS5xnfD8qCepvQw4DmLSmcmrqGdo42a560cFU4JLeG9I6pGJjgNQ477pgtyJY4MiPWu+dbz/RBMAMyAhzia0V6aBDIdCsNra3ugNNT7yVB7fDDLCiRDd3zv27aRdE7kXUzZjASYJdSiXerv+CpRg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qaeoS/j+CIx6OtcOSOb+YZEd4AYOPR+Zur7+utaxTBnGvQvqL2SULn03KD27?=
 =?us-ascii?Q?QAC1RZcfZNDqcf624G0cc7flz4vL2RmqAjKP7vN64DHVWsOdun3slpRsV9dV?=
 =?us-ascii?Q?G7LjVAUTy5F661FveFH0GPF4zps1cGDQWFFqf16ESaoay2Pv0xNB9pFCTzVL?=
 =?us-ascii?Q?cg5pCWzD5Gke4+er4i++D2N5rq4YKqLSt/S8NxPzCiyPblc7knr3WryDJftX?=
 =?us-ascii?Q?k8kjUu0mkN6meYtPfuwQuJCyNAH/0zb0PhIO8q7OfhC8c2SuqEa+bA3oD1E/?=
 =?us-ascii?Q?FK+x7Y/mOdJG7cdMCTziON/ZHpdNYbhWZH3RZdjAH/oEcxKRCq5fZ0UnvX4u?=
 =?us-ascii?Q?P0FNS+eBPg/LSe5QvXVumXThjz1j7/8Ffi0fSfO12ero4bu1t0ep42AL1vmE?=
 =?us-ascii?Q?x3ZSteHkTNlciy5xEXWzpKk75HxhILQ3xvYFaMvZ+43nXit8BsoEMJfJOBrr?=
 =?us-ascii?Q?wl5sL1J4yOOj13zA3krm6yrxwIoYjeB+gMZeupi68GqzDDQ8DOEjiZ7qq9PW?=
 =?us-ascii?Q?PkhpAAt9qpBARVhU6J5ugG9hAGUXQDGKefacXOHUhpnPv/zDWcPrQZ9hpLlL?=
 =?us-ascii?Q?4e1P7WTxPfEyLF2GJVT9nlcGdtClej/rWjhuqRqVQLvUnKfmtz31vCo5o3jB?=
 =?us-ascii?Q?voS7pXDKdN/Dncw1EhdEtE96rnmm110PHr+nJ7L/jmJlE07kbqESg7jmTKts?=
 =?us-ascii?Q?QGrvmWBUV412YeLE+RX7JC2xIoOtOAagdHY7DPf2T/wPigrx+yDcUMCHjI8P?=
 =?us-ascii?Q?epKdQh6I3govPEEg7iQL4wlSS42Z22pTYQA1/VPaNwHsBhqxEvzkWLj5meeY?=
 =?us-ascii?Q?PN+Z5szvdwn2Ef3pD1cPz0BF9mOYQB7F9yPIj1ey0EPCnIprI2cGcGQqW1cu?=
 =?us-ascii?Q?0p/ADCinmJJrYDrNbQJojFIX54syFNvAUnbQXRRLB9EPSxalG3eTRq8J2jrm?=
 =?us-ascii?Q?0hZfkXtsG4ykLejnAyEmkTDW4YNy94q8WnXq0tCHfOtn/kocXGt3/DA5Here?=
 =?us-ascii?Q?FAB1jKUT9yiAjkJl4jegAsNJ/UrzChJXyLaWCclvAUxbjPGDeIuqT4AItECv?=
 =?us-ascii?Q?dH/ljYJGBfulzPK5ajSFgwtbTFgeLfUuIGdbh2cqRVVW2Dxjkg0oDubPmQm2?=
 =?us-ascii?Q?iL4w4jfoKmNwoJcJ4by3B7LdEKHNW4LnYmKzX8LR+3vRYiwZokRrHSSQKGjk?=
 =?us-ascii?Q?wXfTkm+SDppTa2KEvQJnfClNn8vDdZfS0a9+LnZU9v/6eW0XeqCoF94sCB8s?=
 =?us-ascii?Q?ydhTfyK6LtJZ5/6qOrrpy2V6nxETw2ZW3HBRCqoGND+uF7QXVWjt58ig6fBz?=
 =?us-ascii?Q?fa19geumGZf9unAF1mgG34WXtVvYD4SGU8z95ctcr6s9InqhroY9MUdMwUd8?=
 =?us-ascii?Q?KmWDlXr7C2gVtdY1P1/05oQzrPSf3xwOSsSe+yHripdTAOVNlFZkwaeJEzcA?=
 =?us-ascii?Q?Fdl9MQRxA51oKcpFuxHMAtqqR3j/LrPsXQyKShJM2t4gu8XnPszmU1BbpfZG?=
 =?us-ascii?Q?36FxLLye+t9xKdVigeB2UgLmbQ6jDJRckI6dALKh81EQ2KmOctEV4ANDzV9n?=
 =?us-ascii?Q?WkRRqz40r1kEiez4W2zV6C/6aZpwHn8sdnH5Wf7C0uQcwS0apxeYgwtrslNo?=
 =?us-ascii?Q?u79oImFfeail9bwf8JQS3/jCt1oSqNgF5r5VhDyQJMvj+dtOdx2pPQt0qDVu?=
 =?us-ascii?Q?8qNtn4Ezihi3NjIoR2Kg/OXl5IeCz/QDUjm8sP4LRfeuh8HWzio1R+JtOK15?=
 =?us-ascii?Q?6OjUR3Ut9w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1ccb1d-8b89-46c8-d849-08de75a06784
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 01:34:52.6463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ckj3K03IsD9YSJx7/YJRmHLUkDNZorS/Gl0nrG0NApc6c3xHoUl7DsocELwZ7yHF
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
	TAGGED_FROM(0.00)[bounces-17275-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: CB1ED1B18C4
X-Rspamd-Action: no action

Write down how all of this is supposed to work using the new helpers.

Tested-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Acked-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/rdma/ib_verbs.h | 87 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 3f3827e1c711d8..e1ba20c3974f08 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1576,6 +1576,93 @@ struct ib_uobject {
 	const struct uverbs_api_object *uapi_object;
 };
 
+/**
+ * struct ib_udata - Driver request/response data from userspace
+ * @inbuf: Pointer to request data from userspace
+ * @outbuf: Pointer to response buffer in userspace
+ * @inlen: Length of request data
+ * @outlen: Length of response buffer
+ *
+ * struct ib_udata is used to hold the driver data request and response
+ * structures defined in the uapi. They follow these rules for forwards and
+ * backwards compatibility:
+ *
+ * 1) Userspace can provide a longer request so long as the trailing part the
+ *    kernel doesn't understand is all zeros.
+ *
+ *    This provides a degree of safety if userspace wrongly tries to use a new
+ *    feature the kernel does not understand with some non-zero value.
+ *
+ *    It allows a simpler rdma-core implementation because the library can
+ *    simply always use the latest structs for the request, even if they are
+ *    bigger. It simply has to avoid using the new members if they are not
+ *    supported/required.
+ *
+ * 2) Userspace can provide a shorter request; the kernel will zero-pad it out
+ *    to fill the storage. The newer kernel should understand that older
+ *    userspace will provide 0 to new fields. The kernel has three options to
+ *    enable new request fields:
+ *
+ *    - Input comp_mask that says the field is supported
+ *    - Look for non-zero values
+ *    - Check if the udata->inlen size covers the field
+ *
+ *    This also corrects any bugs related to not filling in request structures
+ *    as the new helper always fully writes to the struct.
+ *
+ * 3) Userspace can provide a shorter or longer response struct. If shorter,
+ *    the kernel reply is truncated. The kernel should be designed to not write
+ *    to new reply fields unless userspace has affirmatively requested them.
+ *
+ *    If the user buffer is longer, the kernel will zero-fill it.
+ *
+ *    Userspace has three options to enable new response fields:
+ *
+ *    - Output comp_mask that says the field is supported
+ *    - Look for non-zero values
+ *    - Infer the output must be valid because the request contents demand it
+ *      and old kernels will fail the request
+ *
+ * The following helper functions implement these semantics:
+ *
+ * ib_copy_validate_udata_in() - Checks the minimum length, and zero trailing::
+ *
+ *     struct driver_create_cq_req req;
+ *     int err;
+ *
+ *     err = ib_copy_validate_udata_in(udata, req, end_member);
+ *     if (err)
+ *         return err;
+ *
+ * The third argument specifies the last member of the struct in the first
+ * kernel version that introduced it, establishing the minimum required size.
+ *
+ * ib_copy_validate_udata_in_cm() - The above but also validate a
+ * comp_mask member only has supported bits set::
+ *
+ *     err = ib_copy_validate_udata_in_cm(udata, req, first_version_last_member,
+ *                                        DRIVER_CREATE_CQ_MASK_FEATURE_A |
+ *                                        DRIVER_CREATE_CQ_MASK_FEATURE_B);
+ *
+ * ib_respond_udata() - Implements the response rules::
+ *
+ *     struct driver_create_cq_resp resp = {};
+ *
+ *     resp.some_field = value;
+ *     return ib_respond_udata(udata, resp);
+ *
+ * ib_is_udata_in_empty() - Used instead of ib_copy_validate_udata_in() if the
+ * driver does not have a request structure::
+ *
+ *     ret = ib_is_udata_in_empty(udata);
+ *     if (ret)
+ *         return ret;
+ *
+ * Similarly ib_respond_empty_udata() is used instead of ib_respond_udata() if
+ * the driver does not have a response structure::
+ *
+ *    return ib_respond_empty_udata(udata);
+ */
 struct ib_udata {
 	const void __user *inbuf;
 	void __user *outbuf;
-- 
2.43.0


