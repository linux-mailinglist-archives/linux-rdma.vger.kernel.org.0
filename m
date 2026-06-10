Return-Path: <linux-rdma+bounces-22041-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id veirNLCpKGp7HgMAu9opvQ
	(envelope-from <linux-rdma+bounces-22041-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 02:02:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CE512664DF7
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 02:02:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ezPUSfg+;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22041-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22041-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 344613015A88
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 00:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9101BA34;
	Wed, 10 Jun 2026 00:02:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FACA8C1F
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 00:02:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781049770; cv=fail; b=dBKqZJwbI0/lN/hqxqNrpw1Ygq9F5BMN46ByAzhLkmoOGvBQqMIGkshwIJflDITw0z8QfOEcTeDYlknbVtIyA48nfzCB5tlXmHis96vQerbwHt0Rc7bLjZ2vrUxdEI2U4dn8wuJt6L5m+QrV5c7Qx2vN0NEeNWTBDxSay1O8eK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781049770; c=relaxed/simple;
	bh=1dLZhpysZ4HXc8n5IxJzE4KvyFvXRxCJjzjEF6AXx3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T/a5+uBXmyhZ22Z0ZUc5e8E4IuP7mjFJsv/mKsLsrNx4BUSCIU2yOh0zg0eySlj8xDKS40YgFFQDPrSDZWHXlzgR4djRp8bT6au7soqvJLu6WPSDsqOxKKxBjp3oCQDU7GMjllBIKk7Pdkc/WuqY0c54ilfEHth/H3enjeXsTTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ezPUSfg+; arc=fail smtp.client-ip=52.101.61.19
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9P+Q+Dj4/TR6YBfja6dSx6pXevq1A4NL5dIlD6RkZ0nZRfRDwLliNwv9WkSWxO0EY6ghwcKymrv3jBYEszX2YKFgSrDlmGksU7MNYBSWzPB3PJWJdsqyo365C3p5xVrXAab9xG5RQ/24up7OozpWd+5C7IDOkippk3PpmHsj1ulMuTGr9Cgfdzg5lsBJImvzPYvq5imPwCjzcL2ixOQek6jHuNX7fCcDaXK3dYRTmxvm32NqxDWZlabnPgCzOHV1ODX+5A38Dr5ZlAr4kiE8nVJKY9hDaRqgkiU3L0xwwtl0TElhGCcmjMvHRxZpV644ycKrkejWooZ9VG1W6ZR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJJaBKO4/ymX2EF/eWOLxF4n2d+Cs6zwMN0o3R1+D4c=;
 b=KzH1SsIwzMTuZSO0HYVLL2ZbNAuloscWOgrNh1vETXLp1zf4ms3mc7w53ncwuNy6mbmlS1tUGTujIkdJMNSjFZvnw/r4zKYNIhVEcXLssK7z36Hgd28Rvyvd2cJpS6+0q460XR9E3SKXkJ3WV/qbRFFDizsa3f9ekr5impV6/ly8RjJMSfb0PH1YBcq9gfiBFRjn6fOmWcEg/ZnBsf/aUg1Jd9rUwI6NfhjpY7IKULGOLG2dWhfDE4z+ZVexw96BTReISPW2oyaGYKHk6FICZF8wsZxjPnsptgXyzkFBfnkjyXr6kjF1bhZdagdDD/DGPJL5FK7OMv7QAt6OOJKq2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJJaBKO4/ymX2EF/eWOLxF4n2d+Cs6zwMN0o3R1+D4c=;
 b=ezPUSfg+JqnSDtF54mWASmw6S87K0RvD3/gIEHfTZgdNbTVvg8lAoa6CNK/rQpGMuL9gmFiJjYf58t+RJjW6SK5aC/QWAxPNhptPVtBRE+bWEHJvSt3aKqbP2WOvFN0ngZQcTehUSPTiKfnhmprcGH2cCPAHpRi0+KkKVP8XjEkokKIbyWG5LugGjb3m+kz1pQ53kbbjIuZXnmUuL10kB50/PCcRpPSTH070wUX8sHal68NO2oyq1Z3i6GHmMow0OgI1VHzqxH4YshxA0mDKJDaeUoYkID3+ytz3D30ooNkUH0aB/TlQoEgk80Pv73iCCczxFddxCQfH2qomLns4XQ==
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by DS2PR12MB9663.namprd12.prod.outlook.com (2603:10b6:8:27a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 00:02:46 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 00:02:46 +0000
From: Michael Gur <michaelgur@nvidia.com>
To: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Edward Srouji <edwards@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 1/9] RDMA/mlx5: Fix mkey creation error flow rollback
Date: Wed, 10 Jun 2026 03:01:37 +0300
Message-ID: <20260610000145.820592-2-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260610000145.820592-1-michaelgur@nvidia.com>
References: <20260610000145.820592-1-michaelgur@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|DS2PR12MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: ed7e74c1-0ceb-4bd3-0f63-08dec68399f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Opq7gehl3170+omcYdmmxIwgZf4LBzz10Md+e0eZo6zsOxJ9xLWrmX7zi69anav6TZxq89MZocFlmd6gi44MH65BoUMsktWJu9TWXZ6atgOzmsuw85SzQp0ZgW8QLDVAkH1puX5JmBzgvC7wBTIJ9OgUsaKTvCiWpVPhJlGa9DELKN18WoCa4dvRhXwWeTxWoxlDBOUG0orQvGpFjYlZT+PuarjYTBsS0Ts0nVtX+6uixia6EdH78HY8x10kAx0E/elMTi03rkYGHxujzxrAZttNp+PudRBzgbJR/Th+bc+pwQh/7iJPGJK28i0R/FGAa6HcAFUE7YTx8SOOzR25QzErAnp0RHlhE2/fVd80/1J7diEVxk93iwXHIlTvHOTVvP6UnIpMTjLnCdqotdvrqZHZRN/eF/XZIut76hgV1T4FmskWCIhIfF5O7nfLZnG6fMo+97/6J1aRq01zr9s9ad/YwBZSLHxMbt6T7yN/vkPfGzBkZelnb7jn4CFfb0ZFRMmLg64W2f/4dqnD6ahXcOHwTZOBqIf1dsz4B3nBcPkwx0gCUtcTaNZeAQPw5589gxVwlpBn/IFJqZab+fEIeZqAezpizOYhqYcgQlTq7xozKHOltuXnO6LoHaZC7ViPiPDC6CjI6V5iL3cnWPgCWJq4Ara4AM1G0Wr7F6TUd3t9JBKiW4izOHpFFtptubA5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZxRuS0y4WE5ih1aAoZ/94qqhov7+MTCumsr2yOSgWXlucaD/3GG4NEbejiRy?=
 =?us-ascii?Q?vyIK8V1NdAP5aeBvMhoyXs3NxFwLn0qiIqWhHo3Z5YwaiUPR524Ap02GcGgd?=
 =?us-ascii?Q?fMD29GZoFq3nnef3ww9GIGPe2XrfWNvSp5etRTQMBwx2NNYFxBJ0rZtJ1cVn?=
 =?us-ascii?Q?++0HLSXanuygG3HeWEFAasDRXAF6dBUOenQW6Ltw7ZyVH73y6SWjBbv7LK9T?=
 =?us-ascii?Q?zG2gKI85eq8rwRgxqCrCXN/3DerHCjqw8Y8WvEvVp5wNELamw9a9o+NoIIjO?=
 =?us-ascii?Q?kOYZ/Zl76sPDvQeasAJJO2h81InRXeR70BhvTnHOpUbCoU1jcIm+8Cu5lXyy?=
 =?us-ascii?Q?3gkj7mdH6KGvJw3uDuDGpfdeNDg7g1BYRA+2vc0JKvn+oZzmUiGzLiDNknZp?=
 =?us-ascii?Q?T3x8jYNui2wYrcKEdfs9SPK5zb95YKYcFxwUhP6ZUMI2sWfA5a+pvJ5Fj99R?=
 =?us-ascii?Q?SO17uKnMihgcE7Sm8BDNCL64dMRs6V8E6eaSVNaYZ6SMPfiko0W4XMjf9aVA?=
 =?us-ascii?Q?tonGyXmtq6LuhDr5y5a0FUZdqW0CZ4vWwnLRQCCdI9JR1qMmVpThhsh5XR8U?=
 =?us-ascii?Q?R8YhXMoQKhzUC7v1pW/i+FTWdBDwH30ElrMTfyISAEMdgzQh+H/79l3h+Rnh?=
 =?us-ascii?Q?0ejKhsPAYDHdj/io5sI5/4aedpQnQJrYsXtHOJuPDh2SPHaE1IMHX+F0jyJj?=
 =?us-ascii?Q?AWIfwL2w0KJO8A8fBfVfBdazVmTiJ3yILRKZydS0BbuvNg3Rte4hEqtpPTpz?=
 =?us-ascii?Q?3+8MGTCAK/y4uZnHXo2Lsqf/TpicdG5CDFcm2Q6M9ZG8HKOvZeHgfa+xqF2s?=
 =?us-ascii?Q?NYeKq6GDPnnXIs0Q4ycDgF87dUkVq0Bv3yOygPHFSYHLVGUedAIkianXLkx+?=
 =?us-ascii?Q?Mo2hA3/l+08oOkzH6eqH9qfF6V5aYWJ6jRaM4u5Ke+YmDEBcNoVcNWOucroW?=
 =?us-ascii?Q?35IUL0oN24n7FmFnkKg4GPXeNrPrnZz3ytrIwczRSkF0y7vLVPGbm27hD8pn?=
 =?us-ascii?Q?MmEJYEpyz5sGJIfScXciAWyfndqSbehH1dtd6pzn8QHbmfNKIAAaJqt9rKzU?=
 =?us-ascii?Q?x/9Sza0NULJwE6K+EnARu2An9DSBvfGUU18ATH2CFtOVbUGPCnczv+Rrx4vo?=
 =?us-ascii?Q?CBOral/rJqWmZlUG9ezbPoETq8rarrkFKTEttj6P5osPe+PmrjDEs4VM7Um0?=
 =?us-ascii?Q?gQU4VIY85nrMx4T6Gd+fhkxTyGM70MJelZWY9lmIEFCMNioFFwJx6+y0pWzh?=
 =?us-ascii?Q?WiVSbRmcI9PmTevt/vTDVY6U0IrmwLKBN3sO207UbZEUsPClt9jfQE8A6dGA?=
 =?us-ascii?Q?qku3apKa0bp/vyLvZ/xKY5E6eBjGjI1/7POJ+3H9zJucQtQPUdaCbIXIdiUU?=
 =?us-ascii?Q?YmrsJ8jFQ8RXLwuSrIw0mp8AIceZuCO2AEs7hMRHs6WbvaY/neQiYUkw7e3T?=
 =?us-ascii?Q?Fl5XjHJ/U0OHIgC6wXN4VZlecmR5V9z+cU6V3Okk/2LxPcI7PU5i1Hbnh4tZ?=
 =?us-ascii?Q?eNVoJrvjT0YoVcxTnMnwI5Re4bw5UL5CVowzPO6Arhv7UxMEOvr8480tWCHD?=
 =?us-ascii?Q?ZZ2IVQKKJ3ONrf9ookzjstciLxjPUg/BXRVqonJuQ5qkNqwiNGCTZarGZG5l?=
 =?us-ascii?Q?cjMxlEkGA4788DlAJ5gk3hUvxHM74T8cbw67xQD4Sd9pcNHkpouaCCHHOI5h?=
 =?us-ascii?Q?4NlhPQfZSuzL7f0mILPYdI3K7dLrctGGecr4AbhDcxDZHlCofc8sLASLH6ZL?=
 =?us-ascii?Q?F6WseYxB8w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7e74c1-0ceb-4bd3-0f63-08dec68399f6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 00:02:46.0004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 203+NrEJisrnYMPgyVINVX4x4u8QzuCTzEmrgnlvXnPkowKkQJQbJd3W4IRU/eBCf1ijn2/JPwRpwFyTCyprbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9663
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22041-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:edwards@nvidia.com,m:yishaih@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE512664DF7

From: Michael Guralnik <michaelgur@nvidia.com>

Fix the indices of mkeys destroyed in case of an error in batch mkey
creation.

Fixes: 36680ef7bceb ("RDMA/mlx5: Switch from MR cache to FRMR pools")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 254e6aa4ccaf..c174e27e2e65 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -294,7 +294,7 @@ static int mlx5r_create_mkeys(struct ib_device *device, struct ib_frmr_key *key,
 free_in:
 	kfree(in);
 	if (err)
-		for (; i > 0; i--)
+		for (i--; i >= 0; i--)
 			mlx5_core_destroy_mkey(dev->mdev, handles[i]);
 	return err;
 }
-- 
2.52.0


