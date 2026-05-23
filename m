Return-Path: <linux-rdma+bounces-21185-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGOWJqfwEGo+fwYAu9opvQ
	(envelope-from <linux-rdma+bounces-21185-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 02:11:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1509A5BBB17
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 02:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2F87301B4D4
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 00:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88CDEEBB;
	Sat, 23 May 2026 00:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ghjqjQ/O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8D128F5
	for <linux-rdma@vger.kernel.org>; Sat, 23 May 2026 00:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495071; cv=fail; b=PnbXGMGFNTZzW+/jIlTmq8oaQ1De86zMvi2kEmNbvkc23kbvaWh5QQbch++mpoBJ0+HAu8Tk5YSVwZK430mXfxHxVm0ATkwAYyxgYX41kAGP3zDu6CQEIItK8JkZw/guD6q4PIF7ZFgXXpezUDj5enY5aX8YpTbKgn1No7aIJfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495071; c=relaxed/simple;
	bh=OUQ3nHl353fa8YwRoRwA5DKM5aaHZrNyBBKHjLqIaTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uLoZC+mbnMNjVOQgM3DzOzgiwi4mHBtEb+t/TwIGyK3kqz+zsNW0surEcnlMLvFYc3fXl9QIXwEGdo2GcPPizQzvnq4TTH425tqXSLr4xvRc48MTav7IsDKCKVbpqjAYvZ9GsAUaZ04oglrvHvjwAIaemwovKuViiHDhDwWIJ30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ghjqjQ/O; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVptt9Sqh+WyB6nQhXrcieGUPyDHGt/UzO/wPA19ymjn+RVGeGEC1Oyw8U3v4BoyFRDFeINjVN9rgVyocR1LDhIbZRbybB6lKVWovR63xGquNRo+6QxDOCLH2nDXllLysAj97eItPaKQMm6NlLoT6uezgOdaCPhuseL1Sgm+s2uVMbRM1PEKXDutJ8gNMBTNJ46E6YIrXMi1GqKOW7eweeWnisHEY+RC/OJ7OyWmcdJUu1PuH2vrMDvtdB3oLoclOHLPrKJIbKvDYrJGAH6EmcNdwIZGSAbcmZMhzAcbRmBC9F9PFVnar4wq5871jcyMAyyQAixAJI2eK1+egIu5cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGGXNsbfzj5aKGpCkNoAPVrqoIatzXhJ9/QVphz5gIM=;
 b=Vx0bBtMbD540QEtSFIa47cPuR+5P7HamreYxTAwIlJk1ijCJuQ87Lj1uy1SW4l7cvy1O/gmQO833fAavP2oEMggbjGctA/nC6xARs1XO/vJbWNMJt1IzTHJ0usPt0CHRcDHN4VXqg9H50O7gKp0fzyCL+JvaR7kofjxTuj7jkFLoMsRKFcXjJg7slGp6I8pbYptzN3DtrRar8TfoSfiSpJNnTiN1cvY1uf+tps+1kp4gv4iIKixSvz7tQb+BB2ZE6I4z8rQDNnOZacv4vZa/gBrA1Fh4S9q21y+Lvery+uFGT8MPO107/CQeNiygPC3ul+BPSWKf5BpVNPKBhYN5ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGGXNsbfzj5aKGpCkNoAPVrqoIatzXhJ9/QVphz5gIM=;
 b=ghjqjQ/OxboUEr9SkqP/eBys9qs9B5dA5trjs4XdPgpTlxMYb8bk4F0zTXhw4Vt2f+WXLCS9RhCwZ4lgmWDcfYlsPjOPX51Uj/Ah5yGC+VaLElIayksHYoOSPCOrpMT7QwKwgxysh7zYvjbb+LHnycJ8owMFyNXqwuGSaTlo53OUZOjNq7Xz8nofyJeY3Mw9/ooy2Iwz4uM+/0GiC9aGtA0KfXE8oMLrKmyPWveSyiEHBztEmxLwJgYC+T5KOVf6ksZtBkO7tcBPGX0hj9ibmcFPICpdG3UxHUQ3vSAl3mJW3XqqA9gA3vthHec5HAGpnSnMcXDlTL6iMjJFcyegdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 00:10:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 00:10:56 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	patches@lists.linux.dev
Subject: [PATCH v2 5/6] RDMA/core: Move ucaps into ib_uverbs_support.ko
Date: Fri, 22 May 2026 21:10:52 -0300
Message-ID: <5-v2-4a21959414f2+3d7-ib_uverbs_support_ko_jgg@nvidia.com>
In-Reply-To: <0-v2-4a21959414f2+3d7-ib_uverbs_support_ko_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0271.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 91259c83-0192-4a03-70f6-08deb85fc229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	BepvWpGnmXaLrR6anePOhf5EwB6wuHSFF74BkjXoYLNhAO1jV30WnGZcdV8ZzCkHA7qQHHqXt3fWIK0T92l5YLce+82M5WJfN/ES/cVM2J8j0S2EJRQRgVUWGKoycILsLTHvoHSb/mw68/fFizxRE4J967xN1dW1hCkvtR1h14/sPnou/q1jjmAW3rDA12UQkk+7IWH17VZjTg1sC9lgbPgcNVeGLG7fFOx/h9VVRn1rOmQBqOLuGibv5nZGkCPp7EJQNtbtovzuZvtkBNI3GD6LhyDnFpjBIrH4qs6Q0Q5AHhgrLkX1gvDfmUGioH79RFzr/ZrohZTy+E/wfxmU+frq5MG3Kv3sL1PhOMf+v4xY26b3WW4RXtE361v50HeCDt8K6wpQA+Fpuwz8h2LTXAb7zYZJMA6SvIJKJN0HvdJDpyOjvnwR8oC+o89N4IV4uST3n8ToVyBHH5TbeBS1fS3ag5ANDJDqlWUHdJSiGi8Stg/f2zwArmpXjfXmcPFZywRe8gs7yMljcVvvjB/QMcaUG7fr8vVkDuMvtPTFvpEnccSYMz6A9uXTng1+a8PUOSGp3BMIHbHX6DeY9mSABtxHNzdeake4qppbQDTD8EzfNqjfkcYRnqxPXqdLGeTa+aTGHltI/CBASxECX+6xzJfrgrPIE4375b4No5R7E4F5kyMUl0EN2fsiptZHkYN5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2UKc09riJAOpYhpYmMdqWjKiLufgKmXpIXriz28McZ9mwsvInMZ2lG7hZFdR?=
 =?us-ascii?Q?ckJxsdg8Qd9kR9rOoY5c5cpWVeSrsncmlsJo4k53SWbhOjkul4EMWvUf318B?=
 =?us-ascii?Q?IiwJt39vRR1s+BigJJ/MS9lHdwgNTSxXOHryKPBx7w97+w8Kv1oALiGnbApA?=
 =?us-ascii?Q?Ja6o8fcYYGv1NsEWeuTxvULwLhsG9XDNq6htCptglyjrqJfbfnaOQPT8Z3di?=
 =?us-ascii?Q?AvkGvgiKJGm1kejsiqmcEpO1W8YKe6Focsg45OCHM+Hschav/rkjqG/P99jl?=
 =?us-ascii?Q?SfqVO+flB0audmMXg0WTxcsRkH5umujFYTYrtvpR+2h0OBEOd3URAHXaR51d?=
 =?us-ascii?Q?S/4NzsVGxFCJdL2HXUFZ/Mvvf4npxpcvkP/xmv9yFMIX5QSPsXBNo7guGYEE?=
 =?us-ascii?Q?0KbPdyHxPPEwnWwSLXJkplYmHVk7g5Ph5o1U3h0mcfnmK+Wd4beUxENLl+QY?=
 =?us-ascii?Q?Xwixsxdo6TDj+CRlAK6QCMNvI3ZDd9ITeQmHTn8agK/kPpaqOpbjsg+NgtQ1?=
 =?us-ascii?Q?cqw6c9IZV3GKH8HMoGZ59N3hAJWDqOvthV1VBxAmQ1/p+Zn6w2GKXbzfpAbd?=
 =?us-ascii?Q?RSfD4grIwdTyRxe/HdQuu+peaTnN3MGGBG7ojVaOb8s5lVCljnbg+lOsV44W?=
 =?us-ascii?Q?+nGkdG3WwWVzjm2elbPmDoVldLkK5mW8pM2L3Gxo499UvUhS77+PKMxheVFL?=
 =?us-ascii?Q?ekZ3JNExRZhAjv9aapKMKAcpLt6h/JepCEs4ufbDj+mfWro1SzNAikt0y8GQ?=
 =?us-ascii?Q?Br2Va8BaGX7XEEByXrRK4BubtgksadzbFWKGVLP4ADSLbM8AMXBAxiDjQ7eD?=
 =?us-ascii?Q?+TsPj7vF8b/I9jdU35LPwxitxypgVGBSQ0OCRpzFLAG9RGluEO+OG+CWwgvp?=
 =?us-ascii?Q?pCBe0XSWkKCDSzfT2trG1ZQiH7EVP947iKrT3MfHbUUHvw/balkWAxQ8dgay?=
 =?us-ascii?Q?JzUtZ1K7hLuUuyd4Vs9fXTEMGbfioAISCWBCLFfxA+SEC24TAVSErSxE6/aK?=
 =?us-ascii?Q?paJehDEgloE3GSh/67TF+nmBc/5i+ZjMXxHhmd+8Hg9WGCTtKJuY94+4U7Te?=
 =?us-ascii?Q?CDXpNkpIWCSntqvCGExkYsSu63v3lZ0iq6qHnl01ows4+tJK6qjlJ44NQgup?=
 =?us-ascii?Q?zfwIms/oeNJD+FaoJ1FuuXLr95nkdTF3Ul+/Q4+SjZAzLKoG1CUY1lquMipL?=
 =?us-ascii?Q?teb/QVHrMqUmGCu4wfV8SQz0s41phaYaJU5Uei6cMNLq/5Ablm8VDqQCBYoQ?=
 =?us-ascii?Q?NGSpKpkuarW9sbJdH0V8OzwiPQ5+KdQU+zAYZ+wX4YKzcIiSlak2WXVvuxog?=
 =?us-ascii?Q?PVq59zHLfHV3Q0DnJO0uzVh55sq1rYv0INpqpsYSQvbHET5BZbpjF+BZEcWy?=
 =?us-ascii?Q?Tq/eX9v2czKj+HR0KZ+Y5T7v2gwgmJ+gnqAI79z7ljxYl3cns07j+HtYfHKr?=
 =?us-ascii?Q?5fUr5FzZTFlzzbiqgm6SAszJJWfx6FsTBY6K2ATsC3m9V40HvbBP9nsdPAJW?=
 =?us-ascii?Q?ShDbzblOVnU71OS2bLAQ8vB9HcL675lC/cVJOJ9rIXmk5LCEAH+5oGkiu8bC?=
 =?us-ascii?Q?f+gvc2tHaWZ/C+coEfEaR2Bst1bK5mx8aF9D+U/y/tJNjJju30z0pBwzeN0O?=
 =?us-ascii?Q?UZGjyl499P9QbdUU5ncRwm7lzoMTpWJhgGpy4Q52qOzEwXmKOZsfAh3Mgiqc?=
 =?us-ascii?Q?QDvRyKr1ID3ta0l9OqXmteLWC1o9Q9iF+Ao9Xp9I4/i0AgLB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91259c83-0192-4a03-70f6-08deb85fc229
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 00:10:55.3679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Z2xhdblTkkSNmo1Er1Ye52838m/B4y3gRGtTNKPF9wYbMgCjC7N54E4hkoJxkgU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21185-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 1509A5BBB17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mlx5 uses these move them into the support module from ib_uverbs.ko.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/Makefile      | 6 +++---
 drivers/infiniband/core/ucaps.c       | 5 ++++-
 drivers/infiniband/core/uverbs_main.c | 1 -
 include/rdma/ib_ucaps.h               | 1 -
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index e696bb197b0e1f..263129a23050aa 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -46,7 +46,7 @@ ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
 				uverbs_std_types_async_fd.o \
 				uverbs_std_types_srq.o \
 				uverbs_std_types_wq.o \
-				uverbs_std_types_qp.o \
-				ucaps.o
+				uverbs_std_types_qp.o
 
-ib_uverbs_support-y :=		rdma_core.o
+ib_uverbs_support-y :=		rdma_core.o \
+				ucaps.o
diff --git a/drivers/infiniband/core/ucaps.c b/drivers/infiniband/core/ucaps.c
index 948093260dbda1..7f32d7b7bb0773 100644
--- a/drivers/infiniband/core/ucaps.c
+++ b/drivers/infiniband/core/ucaps.c
@@ -51,7 +51,7 @@ static const struct file_operations ucaps_cdev_fops = {
  *
  * This is called once, when removing the ib_uverbs module.
  */
-void ib_cleanup_ucaps(void)
+static void ib_cleanup_ucaps(void)
 {
 	mutex_lock(&ucaps_mutex);
 	if (!ucaps_class_is_registered) {
@@ -265,3 +265,6 @@ int ib_get_ucaps(int *fds, int fd_count, uint64_t *idx_mask)
 	mutex_unlock(&ucaps_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(ib_get_ucaps, "rdma_core");
+
+module_exit(ib_cleanup_ucaps);
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index ab6f1e3cb47a18..3ccf58e96aedeb 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -1350,7 +1350,6 @@ static void __exit ib_uverbs_cleanup(void)
 				 IB_UVERBS_NUM_FIXED_MINOR);
 	unregister_chrdev_region(dynamic_uverbs_dev,
 				 IB_UVERBS_NUM_DYNAMIC_MINOR);
-	ib_cleanup_ucaps();
 	mmu_notifier_synchronize();
 }
 
diff --git a/include/rdma/ib_ucaps.h b/include/rdma/ib_ucaps.h
index d9f96be3a553f8..b629c99117d8fe 100644
--- a/include/rdma/ib_ucaps.h
+++ b/include/rdma/ib_ucaps.h
@@ -14,7 +14,6 @@ enum rdma_user_cap {
 	RDMA_UCAP_MAX
 };
 
-void ib_cleanup_ucaps(void);
 int ib_get_ucaps(int *fds, int fd_count, uint64_t *idx_mask);
 #if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 int ib_create_ucap(enum rdma_user_cap type);
-- 
2.43.0


