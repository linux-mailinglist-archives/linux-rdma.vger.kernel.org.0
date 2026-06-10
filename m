Return-Path: <linux-rdma+bounces-22040-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7IcTDKupKGp4HgMAu9opvQ
	(envelope-from <linux-rdma+bounces-22040-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 02:02:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C603664DF4
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 02:02:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=UMKziGJd;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22040-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22040-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91E1E3025C06
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 00:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43C5BA3D;
	Wed, 10 Jun 2026 00:02:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012020.outbound.protection.outlook.com [40.107.209.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907258C1F
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 00:02:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781049766; cv=fail; b=RALznI4l+yNvYkntLggi4+2TZKfR0Ag12B5YhE5TJqRwobXLFXikbeGihe3gqLqgDxhd/kkICfnsPUQpm6poWo9VGc0oDq5/yOtzwP1BNdEk6aP0r/rZeLK3vvdt+C9kpFZICA91+CK/DF8PDrWx6cjzuVa8dXYWdO/8XkjQc6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781049766; c=relaxed/simple;
	bh=1/2x49PRxmuKWGRF/ocPgu83f2+OmoTrfzB3tac4HEI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=taiiuognqwBsNfwhiccnWDguzQ69BCWHMX8TOXA3MiZ9Cs5h9Gu9FRNFB2akCrE7qvwO4VZVcP2ciOcJZUle3JVeE2m4mVF4CP3vni4JI1+L+CjsX94JeQ0MQjeOvz/bS7hfzCF/4yg4skfqZjtj+dKF0n5uk0dKeaUzQyIgFd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UMKziGJd; arc=fail smtp.client-ip=40.107.209.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yARm8HB8IKrtwJzkpT1U3YHPVU1hSHdnAJ4QJo7D2DPaZI7vT3qawPZzuU72a12MoFXDJ4nwBha3c32uKCV8lj3/LcB4IvZCuuqSjQvCJkcinAg6PWx50a1qw7L/9f1+Q2xuHAbsR5JCHTBxmp+J29XKKYz2toyXX5uxiqYpPpDK3PVZu/SJ4fkZHx1Az3UmPg9AZP5TMuPGge5Hjr+oJM6Z62nRzlY01M7AUl7OzgNzAuX1FIY8vHwqEazH0xtGQMmvOZuHrEjN0tE3YjCu805KCU72YYEyNggEFNxT/1yc3l/M4T45ln4tasgGW/K0oPOx5lIIm7i84ujWHHU1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qTwcn2SmvWhbsqPGq2IYRs1N6NtNJL/T/RECamMlHA=;
 b=OhFPuxPwjHrLv2fwpR8ZezbvteJEvuLLGnqT/F92uDUz5Rltj1+pxy4c8K7MbYDiQeHZLRQS1z2WQ1CqQLVhSuMgSdteqrn6fBcmHYihySmqAoYuLodANJFgUO9+pjdJnZ5UtsTg33Mw7egINZVRdzndtWXQ3VhsqxyjB/kMXRUBg2Sx9hJ3hbCnLA86HXk4lRPDcOWBQCtAItT38YT0L7sCJjXJbxulgbLxZdb/hjavlPaCWbEEoxKq6H7+46TKygnDJFNf/8y1x4UJq6/7KXJFG4ptZOGco5QO9ciENUoJLNi+HP4vsN82c4wdyTrAPu3hjUlt92kfI6+lCBvTrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qTwcn2SmvWhbsqPGq2IYRs1N6NtNJL/T/RECamMlHA=;
 b=UMKziGJd2dffPZVVQApywsOKm6o1v6nKmYNHVRJd788OitL1HX4voUgziowZog/r6VkH92gcYLCBglkZSKphQSFNyjACcHQO+UX2N/EUwCVEzlPiuM7SJDhyu5qahjZ5iD5+b4cB8iyvStmt3UTLz1qkkNjBV1BDtatwi2P4MLXBe4mj6d1JyEfQcuRgf96DY6IiYa0Dqm76htM5HUl/OAzYjL2xhaURJQmpRt5Ozqai4u+p5wpZdhR4GiaABPTNF81kZR/VJ+3m9Zho8RIjSzPUYUYckIC56Ag9iZVMu/vSg9fuoeM/+txzEEeaCM+7XVUVQky7m+i28KmawJQ+Zw==
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by DS2PR12MB9663.namprd12.prod.outlook.com (2603:10b6:8:27a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 00:02:42 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 00:02:41 +0000
From: Michael Gur <michaelgur@nvidia.com>
To: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Edward Srouji <edwards@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 0/9] FRMR pools fixes
Date: Wed, 10 Jun 2026 03:01:36 +0300
Message-ID: <20260610000145.820592-1-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|DS2PR12MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: 2998e504-0370-45e1-8502-08dec6839768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ffjlMOUUsOQWqGYN8m02KdCqa/8+jV5OLAyahxdLIRljXFpflSYyE3Ju6uwcxvDiwlzRXAwvRAl9fDQbZmWSqVSm50Gj5wWvF5rfIsKHVL5/vmap5KbcJOoP9rVPOz8XiVnRP/d+qxVg10UKVEtN5N7XjspIDnyF0pS92bl3nyX8ioKDQfb0j+wBzMy6+B8/l5Ps6oQvkFOIR6ndzCUR0thdPoT31HHPacCus2/zlQVJOKDsrWk0XUqrJGntmZ6HrgiP8eHwvHTiyrtK5l7f1RBYlwoLklRFWoNwh+ybOBivfR6pwxELdsFBY1B77zZ4dZKH9HMhgkpqHdfmlEmoKOktyfI5M85fhbseXsn0YxMLS3YrNDj95W2jEDXpX3PQhFRwtp0CmmURIBkj5C4WBwjchc5TB8qiECHXwfyJOsFA3R+pdqwfvsj7TLzYcVj8YcZN/3kBDEZAdio9nvmLKxM+PE0LkPc7j3B61wvksMF3LdOYGTx+Kbtt0LINRfdlqEztDIzmiTufG5H+/2D+kwDSRnNJgiSee+2ndYXveAiCuXLz4hhTZn6Q8/we5TFKHZFBPLHFE6etk6Kmo34zL1f04ZEorWG5MBYSPUYuynWE5l1qvSbDsHcWNDmtBZvv80QgYhES+/4Mt6sHwU1SIdhwZKGts8JtW485OGp5yj3TLM1tjbaRMOjaGy0PMDlo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cIEahOIs5lSE6SzzPub5JoxEXX/nPYyyQJocWCMDNu41w+8GPicTKuPykpf+?=
 =?us-ascii?Q?eLOoMic94nj98vmLo6O8Yd2TkFcYjB4sr7HVdhnzU9alnRsi/tSKOZz+0UO5?=
 =?us-ascii?Q?w0VAIUYFAYa1t8U9PXJxxZz9Num84H3OsMBNXJP+ab8SpGZA+mNEAuhI33H8?=
 =?us-ascii?Q?CA7etDUpTVWoL+rf1E6NRBP5p42N0atUOD6N04P0Ty+KuNL66sdN836JXgdQ?=
 =?us-ascii?Q?W5w1+B0Lf4aafCxz1yd10V2SKEsG2D937UaGFUOO/AUQIs0PRutfeMjTdjq3?=
 =?us-ascii?Q?s+Fcq9ZjlsRI15GWLhzz6sEVBVEyBFlZ9+XSJGwFTeUwFl60tznHbTRCX19H?=
 =?us-ascii?Q?l1L3Es8CaY1cXeNPYcC5AfOshqcpIyskAoSfj7Fjhdj4TPu/r/u6TtW3oofz?=
 =?us-ascii?Q?4FwGJJNHb0F6hc9zwCDehzB54iUanj+x0q9slqoiL0MVlAqIc1e3TRk3CRsZ?=
 =?us-ascii?Q?1Axi/SQQ32oqs+eeZ01cE4muzPlBe2ZSmA6HOCOvOld2FSwPWF12wrY/TbV4?=
 =?us-ascii?Q?AEk2029cEPJmMikuXMe4na7BhMKeatSGn9WJwU0/y9LsAxPvQMkhdm42pn+j?=
 =?us-ascii?Q?0iNmpAOlAOQIaknv1XprSuOtSo6mMlIRYrFHJTf8fbcX4Cel2h7xZFylZntA?=
 =?us-ascii?Q?z4cdNc5HMHn180a2bbmRK+Vz9NKnYo4Ijhsnzm0vCi8M1Jj6ZWZ6FF1Nl4pa?=
 =?us-ascii?Q?khO873ESgELgIySCxfFlF4VQs91pjPK9W1J1D53ZOpzDkFvTXHaDTQ0YLOQP?=
 =?us-ascii?Q?/GHj7bThzk3rxSNmdHdJN2iKpJ4+S2IuQyMbBTh8DU3g7Xugy0nyHhsuEjBM?=
 =?us-ascii?Q?AiDFY26pGPNZCwIn0rAEEmnn+mV6UIhSh4TvK940NZ/ZG94RlmmQzKmsuz+9?=
 =?us-ascii?Q?/rIQGci4C+Sv+6Sm0IywD3nNE18nQZ6p9w3NERieZTppEKOxrRLgJTnli6PO?=
 =?us-ascii?Q?1uAacomoH0ut4IO2pjZbiAj/kSq912LjipfFrvGQZ3FTVfAYqGrY+ohn/pnR?=
 =?us-ascii?Q?20haf2YPLQAVCob1KLLwI5CH+oGvWLtp6fxngKjacgaAW5hyy4KWEv+apxn+?=
 =?us-ascii?Q?uhAjB/ZIByYv2UzQH0pey9Lk1bOLJE+zs413MIXZjQnQdOJsdMzS0z6Jnc+j?=
 =?us-ascii?Q?1JSedNxEdzGwSo/KJP3TBer95iAcsRovti7zlvxkSLwCl63jvzZMy4qc4i8i?=
 =?us-ascii?Q?S/7qAA9rhelKAkteWJ6xTfb72JW2wrRt2PEsNdXpy4h6ypDkG/0fPGM4hsyQ?=
 =?us-ascii?Q?dATGXKZQukZls5q89u6c0zvjWGU0qtU+wq+bBFxrGq/OcZ8r89WJgDNnR6I1?=
 =?us-ascii?Q?wqVRZGwtEjcg6tiIPrRAHeM7ERBzRrpGcTWONCWZHSeirG8l61DsiBtDceu0?=
 =?us-ascii?Q?JNZbwMlJSNIEr+YVTYZYpqntY6bi8LZWNAfcJ5yyOWbeH/OY9U1hBMVa39E5?=
 =?us-ascii?Q?TKp+t+d7XA+IraupiVhlnjYV92oFUfe+38DujZHqnSNKKsgMxNhQfUcbEFvi?=
 =?us-ascii?Q?kw8UVTiWJYSkYUFqgKZfGtF39FCWZnwi29FRLFdDfSfbecSG/vjzEt+4U3DJ?=
 =?us-ascii?Q?fWoxKl5EiEJOxN1Iot8I8sz0tsoO3e/QvuIlff6NoD+Y3doM7f5RtWR7qBt9?=
 =?us-ascii?Q?4vNgELS11ed3YcPpFN9sE31pjQrIWIl9LyRat1reJO1z0GyyOociyE5MT06Z?=
 =?us-ascii?Q?YYmfaiEhkF3tXT08XCdm9yPmMZw/wqeOp5J84wuj2GFpolcmCKc+fWpkNvSr?=
 =?us-ascii?Q?M6L0EXW6/Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2998e504-0370-45e1-8502-08dec6839768
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 00:02:41.7090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLgQRg+wpy6iO5K4NH0PV6aI5zjVQLkNyBTZPYCRLt4kFbSB9uhtFudsZeMXvguJTT1hvzbTjuQML8mBg6Yg6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9663
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22040-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:edwards@nvidia.com,m:yishaih@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C603664DF4

From: Michael Guralnik <michaelgur@nvidia.com>

This series addresses several bugs in FRMR pool handling.

Patch 2 fixes incorrect masking of TPH-related bits in the FRMR pool key,
which caused stale TPH values to be used when creating handles from an
empty pool.

Patch 3 fixes set-pinned flow to use the pool key returned from the
driver build_key callback instead of the raw key supplied by user.

Patch 8 extends the FRMR pools API with a new drop() operation.
This allows drivers to update pool state on handle destruction when
revocation fails, without incorrectly returning the handle to the pool.

The remaining patches fix error path handling, covering cases where memory
allocation fails during queue expansion, and where handle creation or
destruction operations return errors.

Michael Guralnik (9):
  RDMA/mlx5: Fix mkey creation error flow rollback
  RDMA/mlx5: Fix TPH extraction in FRMR pool key
  RDMA/core: Fix skipped usage for driver built FRMR key
  RDMA/core: Fix FRMR aging push to queue error flow
  RDMA/core: Fix FRMR set pinned push error path
  RDMA/core: Avoid NULL dereference on FRMR bad usage
  RDMA/core: Fix FRMR handle leak on push failure
  RDMA/core: Add ib_frmr_pool_drop for unrecoverable handles
  RDMA/mlx5: Drop FRMR pool handle on UMR revoke failure

 drivers/infiniband/core/frmr_pools.c | 104 +++++++++++++++++++--------
 drivers/infiniband/hw/mlx5/mr.c      |  31 +++++---
 include/rdma/frmr_pools.h            |   3 +-
 3 files changed, 98 insertions(+), 40 deletions(-)

-- 
2.52.0


