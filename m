Return-Path: <linux-rdma+bounces-19808-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPwEOfnv82n38wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19808-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 02:12:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AF04A92BD
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 02:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C05E0307755D
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 00:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBB714A619;
	Fri,  1 May 2026 00:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z1SwNDOr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C46335975;
	Fri,  1 May 2026 00:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777594139; cv=fail; b=etRV23Js/yDEZ6P7+1H+ZMGx1DdE+6m91hSXIWr0vkEzzgP2YumygOg0/GCMBGQtfZHBDQZXIdSL+QDE23FWOqUzxK/A5bghZPidFkLZCDhT/DpsLXJk3lKzC+G5vNneU+CYF3fWipG6BRqht2QSTEM5eBeEUtKUCpb2S8CYLLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777594139; c=relaxed/simple;
	bh=ND7sKTofEY0sDte7OfNZDhZr2X/goVZR/Mqh+hWroh8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qZaruup6TlI4Rr18iZsnA85L1xt5qUXgZ18scW6mxLF4ojqo7btRohYEKS9oNfR3eNyCjVy7at3NidrDcLzqj/37+R8ZdlsLaFWKjdGT7KkOiz3e3w3yp6ocDoxy2rmdGQNmkBoynZiWXCwJ+QGb7yozTmToIlBi0fcEMyia14E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z1SwNDOr; arc=fail smtp.client-ip=52.101.61.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lm3PFygP+Zu1EcPfuq3cf0vAocrh7ZmbEF4E5hcUpnbo65m3Jr+V+bMIA2EeZFy/g7s0LOK4tIBS5UVVBS529tD5Aydrw//pZ4L3KXevyy2wBGqXQcdlRRoIwjibMY/nyuqExMSvxcmiRh2uxTfq3wV/UoFNpXAjb1FUT7OSGPSb68ys8ldUOZxrIOlo6clayZ1JH9RiFW6+2NhN/HjU34W5hBWKfGQsioI3EcCUbQFGaaZUfPHQ6XicQetimGTXGX6BhQlzQv/e52RycT3Dn8uYWF0834mKKX2ZS48RGaLuZgevpNkamPvrd7wYrJ+R+Sf+eOcw6mZwGaqPDjwvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4rx+HwIlN4DXQsISJIiNaNKocWNbLy0KAHbQUoM+CE=;
 b=nj5rfzJmBvGeNqGL4Zg2CH7GusKsuNDeD3vexyFlIrr/Bwb0uTNI852pq1aUGCvtL5rc8dDGNTst3Wbl/mNFpaKOhwDBZ8/NPD8PuMKyZeqX9mh/E8mNi1ld/HGkfEyGmCoUcEpKgIULxpaTX1+CvOeqjRhCzMXkHCXNsu2nBPnDAofRI2cpumQiRIQm+T5WgV6RKSjPWgRy1sIlOqH3A/YuTiZ4+p1FPKcJWB6vMsXNdXJIRK7/QbHunwJNVZNey1407r1VfmdDlVAdYfSvJMhcbGF0nwpBQqPp9h30PYeYQtU6qgksjG7NbajJp/HmSHvpp5EumqsWQe2wMLL6eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4rx+HwIlN4DXQsISJIiNaNKocWNbLy0KAHbQUoM+CE=;
 b=Z1SwNDOr7G6ZUWcW3uXoYpHKLSK+fRnYOkP6X4aa9m4HbsuGqozG/z1nTnfgKB7SF4mFIarvg9RYH12sYkluYexBtui3EVBOmTayWio8W/XzKIc7s3DhhRhBSD+Ce/8VE+flGzqhselZxShqFa63uHuH0MKWfRvRC2Q0cHhhBKNpbWres4PAw8e870pWNNoKIb3Kxf3/+7Q9t6U9yHtsWLRS/Mu+JxrhGr2XkYDaP9lSUodaAy3E1aZpwUVEWqUnknwkX0k0kNtzN9V6LyT78RT1nXZt0sjLjirz1Uqw0qrx84cwi9kmu4TOhCs1/7CrjtDgqEfdaulkvch+ewXohA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SAVPR12MB999167.namprd12.prod.outlook.com (2603:10b6:806:4e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Fri, 1 May
 2026 00:08:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Fri, 1 May 2026
 00:08:39 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: patches@lists.linux.dev
Subject: [PATCH 00/11] mlx5 support for VFIO self test
Date: Thu, 30 Apr 2026 21:08:26 -0300
Message-ID: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0152.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SAVPR12MB999167:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b886a4d-5a52-4f21-22c4-08dea715cbb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ow4iWnjDiPC7DGKGCoogC1/0QUibBkny19bRTL8dtKtAVG4ZUrnOfiv48xyPubLXim9agKQse++siq7uaTtb/ykWTTymJO1MHLPQ9rtnzU7tNLzlXlL1+Vn7v7dCtri0gHl5J+kWcwZ2X/Ba12nEOclFK5f1fH83kEC+F6toUzyQUDLVqRIPZ3Ji8WKeUc/uNTeXqji28brSdu+JFpq/4MkgM0TI8yRAema81QiadSgP3upB84OH1l4JS79o0ADWrWG7xvce+5Znt75bbDHhQOEl8OQPEgIG3NuoBun1dNT/pl6kHxsuOCsVkj1yVw4h4oG+h9iH08dxV0wiwaxS7WngbKGsjh0NvSuNWKpbMLQHm6cbDHdnM/fPQLONwyKWttjODnPxX2jNZco0w7c68PGMn5XmRi+Nr4QkmrY3vqj8bPwwjlpfFlYQ1e6NT983FIf+giGHzLb6D/Lp73kpTX6BO9m7pwygWtu8i7GumRHbZIkFv1+9pvLfMDcIKqiw70L9vW1XsM57kaIidoSkoSW0qyXQNdJ67fjVECFfZB8m822IBYw7VhZ0Lx4C0WCV9go9jES18dvTrLd3rZxlgw5BAatI9HR65D5dQi1+LlM/6GI/C6h9MyZPo/nFInFYw+YNWF4W+MAF/0eAJ1gRs2/iF2nJJBX8Y4r+Hnn4lOS/TjCKPAr09aYj77z9cuXnGR4C8075yUcIALxiYI0QfJm94edgRPXmW6E2LUow7DU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ih1kvpQ6RgmfjkDzgbZkGWvQMpXJp4tXtpC5dtU321OMTwYLMt3deDkX1jM1?=
 =?us-ascii?Q?QrAaw87vmsAMACEZpm4A5tx08+mp/eUfWWFBqCivQbQ1EeszceNST3F9qwlX?=
 =?us-ascii?Q?Gas/tS0JRVa12bmOGy3ea8AJAXpZLJkC0EwpDLVsGvN1XrpeH87xGGm7YtOX?=
 =?us-ascii?Q?jbwo+bi62jaArrBYPGcz+xAv0gKKv1QJAMydyDgsiAGV5lrFxi1GxWb6gxc3?=
 =?us-ascii?Q?IystCYsvDJiutVSLM2q+l+xQNfriAtTDHfhMBNG+pSOETlGjIDO3hMPAf7Q9?=
 =?us-ascii?Q?oFAdV7ZdjqRyhAJ6eLowLjwAHk0AM/1sKzKjPnOEc5SWwXHrXIlz9P39boZk?=
 =?us-ascii?Q?oPiCNWmGdkTVxmnMfG6G/mQJWw59OTBVmmL6RbxS5OnmFMzh+vhXsr23wKMa?=
 =?us-ascii?Q?psTySzQWZKq/NqbWGmA1dJTa+L7hYb64XjbXw0t9IMr/uL6wf23bAyKJ58Qa?=
 =?us-ascii?Q?hcZux/PCrR3kkA4ubdpMXcCq4dvWNWmX/cwa2oPhVKnl2Qq9AvVXCmP2TQjx?=
 =?us-ascii?Q?p9XbZu5iFlOEE4d8fFcDjFo1TP3MN8AXdPUY8UGJ2TInA8igDsgJ1IFchPva?=
 =?us-ascii?Q?JDHRDc7bPBusMeebyOVluvxZ7TM1v0QPwATAhQD7PvzQm4zYNa+viAV+4/xY?=
 =?us-ascii?Q?A9EXJQzXxfA4/MeduRpWLnsPbLissHeAUmU6kcdqn8UgRWk1ClzLfLx+vYHF?=
 =?us-ascii?Q?54sQqXmkRNdFmCu8rdlFDObuKFzN0VP+nMQvJD/GYHYkpAH97jtj7Qi6GAnp?=
 =?us-ascii?Q?LAYSfDQ4VMKvRmAo3mkklA0OSUAYkvW6zhz6Y/DnLSFBvf1CgdnxC6C0IcCk?=
 =?us-ascii?Q?7JdoAqS+pDlMSdWpUedG0+8rpAfz6gVKFF+EaxKMmC0paybEBNST2qXP8oBh?=
 =?us-ascii?Q?rE8Bq3n5o+lp/wfE102RxaUuKVLn6GpcRfCxr1gPlBvfbXtlciORH7yqmGHu?=
 =?us-ascii?Q?1FPPD5Zxuyc3cyeFWIqp9NHZ0godfJlkrVR4Pl4Bt1AgL105qIK54NzNkaXr?=
 =?us-ascii?Q?ooO5JKjlKYb5SB2TcmFGMIlbO7muuMyBTLN6a0h8rr7oj6QOtcWNllkp3IT8?=
 =?us-ascii?Q?5uedh7geXMnbvGptZtq6g7BBo6j+3KIBwo0g048fn5TfEWHEZcMb25T2PCSc?=
 =?us-ascii?Q?c77QkcRqpiuO/KEnMvK6cxlnj/1QJArdCeZsSIK0x8HXCKbW37LYf3xziQ8e?=
 =?us-ascii?Q?gF7qfvrBZBvSTBL90Yrq2/AkhYEUP5UzXlnpjFIdeHB4tDABifKxvpFOnCVG?=
 =?us-ascii?Q?0uxgmqLWU4TDYDjI/Vtf40t5AdYBaknGk+WBXyLluelJl0kD6KNIT7+l/r9e?=
 =?us-ascii?Q?m7XYL4+UvmVC9M/AzIYX+ARkUQ5nqQS7NLVQekVvGAuOFKkxeXKGtaQ75uOo?=
 =?us-ascii?Q?YsW6nHPt8bjdOpULuOKWzkX+daZ7sSg5vsZKMg7BcGKlJU1EDpXlt1Fjth7H?=
 =?us-ascii?Q?I6kpcMQKXlgPrLmx6PQot57frM5ouqi0Jyv/02CtjbU/VJw8E5qCywAIoA8h?=
 =?us-ascii?Q?M0XpIOsRqIt9fLSPoMJ3IK2T4FTpQkdb6p5VFQkVhRz+QIMiqbHjeVAUub0M?=
 =?us-ascii?Q?10w0VW1uj8U3TV8nH/guvbXCPLscfTTy/soQHZav/jVXlEgYhjj/LOBNmqWp?=
 =?us-ascii?Q?4ivFJVAn5DyYcvpKed+VOuHWxsSMoI+bjkfViR8HmqLVh0DYf+UYHwiv20dV?=
 =?us-ascii?Q?oT9WOO18xrNF0rB4Jj40oSn9hgfWUbtODmvkeQKWMFU5z0vf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b886a4d-5a52-4f21-22c4-08dea715cbb7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 00:08:38.8251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QetU0dTsnK4H06TNItrjZdVirR9QlSNlxv99/Op0kfIx41NnNELO+xRhNexkiIUo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999167
X-Rspamd-Queue-Id: 63AF04A92BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19808-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid]

Add an mlx5 driver to VFIO self test. This is largely a remix of the
existing VFIO mlx5 driver in rdma-core. It uses an RDMA loopback QP
to issue RDMA WRITE operations which effectively perform memory
copies using DMA. Since mlx5 has a stable programming ABI this
should work on devices from CX5 to current HW. The device FW must
support the QP loopback configuration.

Also support send_msi by arming completion events of the RDMA WRITE
to trigger MSI delivery.

mlx5 device startup is very complex and most of this code is just
booting the device, with a smaller amount for operating the QP.

This entire series was coded by Claude Code in about 4 days. It
used about 4.5M output tokens, 30 individual sessions and 5600 lines
of AI-generated .md files. I spent an annoying amount of time
de-slopping and cleaning its work product to make it presentable.
However, previous VFIO drivers have taken on the order of 1-2
months to write, so getting one in a week is pretty remarkable.

For those interested, the flow I used was broadly a prompt sequence
sort of like:

 - Hey Claude, go look at the falcon series, VFIO self test, the
   mlx5 driver, rdma-core and some PDF documentation and make a
   plan to put mlx5 under the selftest.
 - Write an rdma-core application using the built-in VFIO provider
   that can do the required memcpy operations that vfio selftests
   wants.
   (This resulted in a 1k loc C file that compiled and ran the
    first time but had a few bugs related to device programming
    that the AI resolved.)
 - Replace the rdma-core components with open-coded versions to
   create a fully stand-alone program that does the DMA memcpy.
 - Review and audit the thing.
 [Pause and de-slop it]
 - Make it work on a PF too (this is surprisingly hard!).
 [Move to a kernel tree and copy all the .md files and .c program
  it made]
 - Hey Claude, look at all this stuff and make a broad plan to
   actually build a VFIO self test.
 - Here is my 1 sentence advice on what each patch should look
   like, make a detailed plan to make a patch for every one.
 [Pause and polish the patch plans]
 - Execute plan X then commit it [pause and de-slop each patch,
   repeat].
 [Review and final polish]

It is based on a tree with the falcon series applied.

Jason Gunthorpe (11):
  net/mlx5: Add IFC structures for CQE and WQE
  net/mlx5: Move HW constant groups from device.h/cq.h to mlx5_ifc.h
  net/mlx5: Extract MLX5_SET/GET macros into mlx5_ifc_macros.h
  net/mlx5: Add ONCE and MMIO accessor variants to mlx5_ifc_macros.h
  selftests: Add additional kernel functions to tools/include/
  selftests: Fix arm64 IO barriers to match kernel
  vfio: selftests: Allow drivers to specify required region size
  vfio: selftests: Add dev_dbg
  vfio: selftests: Add mlx5 driver - HW init and command interface
  vfio: selftests: Add mlx5 driver - data path and memcpy ops
  vfio: selftests: mlx5 driver - add send_msi support

 include/linux/mlx5/cq.h                       |   10 -
 include/linux/mlx5/device.h                   |  231 +-
 include/linux/mlx5/mlx5_ifc.h                 |  178 ++
 include/linux/mlx5/mlx5_ifc_macros.h          |  185 ++
 tools/arch/arm64/include/asm/barrier.h        |   18 +
 tools/arch/x86/include/asm/barrier.h          |    5 +
 tools/include/asm-generic/io.h                |   28 +
 tools/include/asm/barrier.h                   |    8 +
 tools/include/linux/stddef.h                  |   10 +
 .../selftests/vfio/lib/drivers/mlx5/mlx5.c    | 1920 +++++++++++++++++
 .../selftests/vfio/lib/drivers/mlx5/mlx5_hw.h |  114 +
 .../vfio/lib/drivers/mlx5/mlx5_ifc.h          |    1 +
 .../vfio/lib/drivers/mlx5/mlx5_ifc_fpga.h     |    1 +
 .../vfio/lib/drivers/mlx5/mlx5_ifc_macros.h   |    1 +
 .../lib/include/libvfio/vfio_pci_device.h     |    6 +
 .../lib/include/libvfio/vfio_pci_driver.h     |    3 +
 tools/testing/selftests/vfio/lib/libvfio.mk   |    1 +
 .../selftests/vfio/lib/vfio_pci_driver.c      |    2 +
 .../selftests/vfio/vfio_pci_driver_test.c     |    3 +-
 19 files changed, 2485 insertions(+), 240 deletions(-)
 create mode 100644 include/linux/mlx5/mlx5_ifc_macros.h
 create mode 100644 tools/include/linux/stddef.h
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h
 create mode 120000 tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_ifc.h
 create mode 120000 tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_ifc_fpga.h
 create mode 120000 tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_ifc_macros.h


base-commit: 75b2e40c376951e2174f08c871389955253d3f5e
-- 
2.43.0


