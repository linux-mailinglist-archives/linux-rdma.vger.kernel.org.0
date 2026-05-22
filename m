Return-Path: <linux-rdma+bounces-21173-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA1bH2PqEGr+fQYAu9opvQ
	(envelope-from <linux-rdma+bounces-21173-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 01:44:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C97D5BB905
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 01:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABE393007AD3
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 23:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9068F38D411;
	Fri, 22 May 2026 23:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SKDmGelR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012012.outbound.protection.outlook.com [40.93.195.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144BE340281;
	Fri, 22 May 2026 23:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779493469; cv=fail; b=pBZ+DZ4vz2rprRyS69t36HmSeXv8QI1r8iYM8a5Ipyv3FMgeIDBjYn9vA77ThCWIqxshqtvzm4SxRo30PAs9WQoG3NqqjX0FKwdfSgBk/cDFIjkjZT5T0RxGlko5f7HKM3oHYYPzIY5eoIJeg8BbBhAxbekVsH64JpyGpusu+Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779493469; c=relaxed/simple;
	bh=XcekWaVwKpqasu16hWa7mvAURorF24oHtF0EDbVb+7U=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=kQLkN4LsaZJhRPq877q21B8WKK0IVbEFKG/PUJGP6npK8s0CA5pfuLmnswxZJHY1qHuYNscH7kti8i0BqIdvp7QO06J/r/BxJWnw2DfnAYREvm7jwY5ocsK2QEy9Vs81GhcCo7Jw6uT74odjbm+8srYIbkC7hcfl27hfkNFCpz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SKDmGelR; arc=fail smtp.client-ip=40.93.195.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJ4ik2wuo4pQrI3wbkdcp3TaODKzFY2Jcmcj9HeINc9GPnuKCBpOIvLGZly/zul51OdfHQLLBWnOedUbI4Uf0DU9mEoNnhlftLPokAINFU0tzdiM8UzXpn3VgurJ+9y6eJSKqU8ZtlregriKv6EAN8PfAmveMDRwoQzs3XbPD36hT6YEmYz0AZbyY1YVIawXnUdGLhFKUgf5hQ/WrtDjp413C4alK/mwAv2cu5YnwCz69K54ZgdMbEnuxb4a55RQFTPmzY53oLOXBP0N7A6yUawKtldFjUUC1uxC4XdaNyQ9uuM593gPgsOMm0zepIpVDmR2tYgMJ8KVIzv/MuFpew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cjO0fFCOw5LJ1RdDva2DZgY90GNa1yan6KwrBtlb9c=;
 b=Ia0NThsgw38aCSy4gKjYIkIE/8x4LGWysg2DiU9X0tZR0HGTo++3e9wQKEc7R2CTqpuzZlTD5ewCut5qqD20QpVoZF4DalORmKxyaEgu7W14oNOy7kpNz8yZCgKBtKJWXUvPMQF+RvQoJCqtb83I7+Mpyig5PZTNLkwCDfbLm1maiFOVznvCdgENUnCkAejXCGGdv/m1hW1urXQWzfxh0LWNwo6TByvbmXqdVsO9oEeB5bkxrFvv4ey8jooNmSkh/QCxQVKPiydrtFghPVbjKWgBFl1oan7Y2uFZIFYNAVwgefkgMJaAirJLMxOfwsnD0/ihsSLKaPYl++McOZJ6vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cjO0fFCOw5LJ1RdDva2DZgY90GNa1yan6KwrBtlb9c=;
 b=SKDmGelREKsdnlPCAWe44E049XQuq8nkCBcr9mgUYUmNknsWssxmvirtoaXYlQkiEpC+M6eVrivM9j8/ASIklYsWjsPRR9Jo8tpuZRse493EzY02xuQ+O+/S/AsfReiEUvwcYQdy4ArIBJ4qhyeix1yK9U+FrsoYOn8x7g+Sxs83dHYkpBlQOA68HUEudoPcBpQR/DDqb3ndbUcv06qYdyUgUKjc0RVrJlsitZ6frplHB+KT0i3WNYk4o6DDi+QIJjkoE9CILDDHPtkDfRwRl+O5e2fewh/ox09JpexP/nyZ0J0IdLawVPV1471JNl5FoD7OGI3zOXND2MXg6N1ksg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Fri, 22 May
 2026 23:44:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 23:44:25 +0000
Date: Fri, 22 May 2026 20:44:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20260522234424.GA1208882@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WjDneLzbz8X7V0en"
Content-Disposition: inline
X-ClientProxiedBy: BL1PR13CA0202.namprd13.prod.outlook.com
 (2603:10b6:208:2be::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: ac4de740-fe65-491a-5d15-08deb85c0e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Lsrnq9PycR3Z4c4mfGAEBoYIpubR102vskHrvVLkwzatsnot7xQDbD2WBLQx/uL00iy+UkGHtHjhwwQrYRGpj59W+ci2v/M3bdhN2In9lSB2HKa8R9PFII4fxjotXGfjIoqBOVqiwIevRyDkUvRB81+gzCaQG7Ov04eTI4A2HikZE6JedJsSMqhQFjeYb+gs7Q5Z/WtIw0V/m3EZuzxr9HwBO/lmSUjvnFmelC1gCCRYnwLuoqLntOvrJQRt7d5id9Rv3WUrdgJPm6VRP60KOL/mjL/T7SqZq0MmLYGRgrH4tb5G++xoCpBAb11QI98Uf6z6qsIwLMVF5RFUJGOfEYync/nwIqjGYSH1QrlzFdigDjnC1lpnU0jztu2yp1BuV5tJDlc0niXu15I5kBqGEq7FDKgMTVEZ5Q3O/6WRtKvbiQ9UhoKlyFI71PxONsXpCAJExJXUoNxDk6+6SKhzi54F+kAWAwOlV67MHOhc5/KWmrTLsJcNbAJoR02bRzFnnVgeohXQYBOvy3CNezfOM5QG2XResWbNrWRpWdC1Z/HcM1gyREv9WA122vQYPAYhRvDNKn9X0EHJLwJgMC0i8CljuS0uPhcqy+lomv1MbSlwNSkZOD+G0e0Odi2Y4TKfckef0SUhtCHF5at9KaH1ZjDKiST/HqZkk7hoUZVY2cfrz8Wnj/cOCj263gspYD0l
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5QBzakLhK36ZW66SDEZlb8rfnEaGZ7sNmTL/qEQHhZZWcNS7u4+PqdDrbOng?=
 =?us-ascii?Q?CVSYI9khF32Wko6a5kdt6qQXT0TtqqWZ8Ej9YSqRlYYLRxicL5q2w42aLrnB?=
 =?us-ascii?Q?SHVj3eoCMiDw6C95UMSiHYBv2VzDV7yTr15MOSWBAnnE/O7BPW99C1ePlxQb?=
 =?us-ascii?Q?zA/O6GXc/8YlRprxJXkvliPeYO+c8N2/wQqIdDOevxK+8SOGuvm5QrmXDFAU?=
 =?us-ascii?Q?39VjXEt2waSqGNBtxZo8xgrTnEoYAazJNlOIaj7axs7iCn9waZoG6+13Bfip?=
 =?us-ascii?Q?y3hQtXckdenzfjybkFXo9dh0rXd2dpu0ADBpHPwQfYb48qt9gaq7GU5ZImgd?=
 =?us-ascii?Q?LZ82b/4f4covjN1CdGYvdMWX7nuLqlT4fyrcwN1WQHb40YJPjR5m6A8qizpQ?=
 =?us-ascii?Q?YoTJcSauy3HVldJ6fkMB8VQq61/3w674P1hB8aWeIjPYS7G/vpgql4+bQzrz?=
 =?us-ascii?Q?qBv4xOqXhkL2yhH/xzjGN+H1O14ynM4nYlbR199UnFT++EEZbMjoWD6zZVyK?=
 =?us-ascii?Q?QAfF6Nm0EYww/nm5Iv7Q5sQ9/A3SrRFUnjelWHXyzX9NGc9oe4iOy3bWPdAQ?=
 =?us-ascii?Q?rYKgLA2kxSaCFofJkFYpaSCl1h6TgS11lRS9YWHU+q2HrdQawqvSqxD0Vgse?=
 =?us-ascii?Q?nY8N2UnAfR74/H5WJRkKMEycCZFz7pA2IDnHpe7z2ahW8NKpErVIm/fEsQMY?=
 =?us-ascii?Q?Xx8kuIrMPzySJw1VRAC2ZkYG/VEoQpIb+Bap3pA+0RSAxY1UsXO3YXqScAcT?=
 =?us-ascii?Q?jaBmOomFJwiusMRkT63KZMpBIZ8tLv32ah5D36g9qzrZ7TNjonDWGoGXhOQ7?=
 =?us-ascii?Q?Ey/zrVexFon2XhUF+Lq1akeJ1O+Pem9dwuFGJf9IqkmQ041/+f6/A3n4Aadw?=
 =?us-ascii?Q?0fyXZkG1cyqJ48OS/dGzgeUIwF18CC9LPLk7S3GbyKnJiavC2tg3qporO27V?=
 =?us-ascii?Q?yvyDGYo2nO487vbz2n6Bsq40niECQum/rGHLUqeZ96QwQP7Jev7dW/o7k+cA?=
 =?us-ascii?Q?US4gvrPO7TwuCPc7yrTZdqw0Udg/ttVfkefRlJ3gDbT4SrbxmXqqA7qYJ7Mn?=
 =?us-ascii?Q?CP/NJj2+WM0KQycbKUy5gzLNA1ZBmdkOK7av23xuYPc/TS1iuCfgNEifI0jM?=
 =?us-ascii?Q?oXpjcq5KnsFDQnrS+XHFEic3rPM+u7pcRnN2kO65LBjbAgu/nc9iPxmrXeT0?=
 =?us-ascii?Q?tQppVlZJp24+UaCl4n/cpfwpRz0m3M2bsA3j52QP2H4rB2Vfv24ICrVza7Nv?=
 =?us-ascii?Q?GTbtedjsgueEE9Fb9u5TzxBM4j/xfhtAn4CcPwADHB+Z8UBjGhRmZOo8X3a9?=
 =?us-ascii?Q?NymlxoKrnEZi0FroLUuIspTAEo+5hQRTpG+JqgngEuCfIRlMUSQn63cXd9hq?=
 =?us-ascii?Q?5MJMgqx7KRF8VhOMf5s5+RdR3c8qw+m/L00FPeyjdr6f8ZyI2lQd98kMgzU/?=
 =?us-ascii?Q?JHvUCG2fvpAmKNn/Qx62DiDJzZ/3gPVoaB3fp/YfKQvx3UACQPlsqIZ5BK+Y?=
 =?us-ascii?Q?U78Od1w84RH5zFaGJ0cTZmKUGPfRnQhRyvprOeF2stfHvblOo/YPxctY2wyh?=
 =?us-ascii?Q?AIKgCUeZoqrQTvXMLilBPPR/S7VnxL/vG42zqEbbG5zl454lq+j1G3Xmzkng?=
 =?us-ascii?Q?jxUzguCcZ3D6kYiVA9TONZQI+/ed3W7gmNc5zSbxdJiLUESwjqmYnCHiUm0w?=
 =?us-ascii?Q?k818XA0vywk7y0WW8Xlj+LE7kAzaMi6tTDyBDb71DdvA4Iiw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4de740-fe65-491a-5d15-08deb85c0e74
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 23:44:25.4187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0Ams/djfVyKWkUMNYz2Et/q4uUxkgjjNbEvvx6K/ScOMTYermoAMcKwEyCbsojG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21173-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9C97D5BB905
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--WjDneLzbz8X7V0en
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Some more security bugs probably found by AI. I think there will be
another batch of these still to come this cycle.

Jason

The following changes since commit 5d6919055dec134de3c40167a490f33c74c12581:

  Linux 7.1-rc3 (2026-05-10 14:08:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 5b74373390113fba798a76b483837029ab010fef:

  RDMA/rtrs: Fix use-after-free in path file creation cleanup (2026-05-19 19:32:48 -0300)

----------------------------------------------------------------
RDMA v7.1 first rc window

- syzbot triggred crash in rxe due to concurrent plug/unplug

- Possible non-zero'd memory exposed to userspace in bnxt_re

- Malicous 'magic packet' with SIW causes a buffer overflow

- Tighten the new uAPI validation code to not crash in debugging prints
  and have the right module dependencies in drivers

- mana was missing the max_msg_sz report to userspace

- UAF in rtrs on an error path

----------------------------------------------------------------
Edward Adam Davis (1):
      RDMA/nldev: Add mutual exclusion in nldev_dellink()

Guangshuo Li (1):
      RDMA/rtrs: Fix use-after-free in path file creation cleanup

Jason Gunthorpe (2):
      RDMA/core: Move the _ib_copy_validate_udata* functions to ib_core_uverbs
      RDMA/core: Do not read wild stack memory in uverbs_get_handler_fn()

Lord Ulf Henrik Holmberg (1):
      RDMA/bnxt_re: zero shared page before exposing to userspace

Michael Bommarito (1):
      RDMA/siw: Reject MPA FPDU length underflow before signed receive math

Shiraz Saleem (1):
      RDMA/mana_ib: Report max_msg_sz in mana_ib_query_port

Yi Lai (1):
      selftests/rdma: explicitly skip tests when required modules are missing

 drivers/infiniband/core/ib_core_uverbs.c           |  87 ++++++++++++
 drivers/infiniband/core/nldev.c                    |   3 +
 drivers/infiniband/core/uverbs.h                   |  34 +++++
 drivers/infiniband/core/uverbs_ioctl.c             | 148 ++-------------------
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |   2 +-
 drivers/infiniband/hw/mana/main.c                  |   1 +
 drivers/infiniband/sw/siw/siw_qp_rx.c              |  15 +++
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c       |   2 +-
 include/rdma/uverbs_ioctl.h                        |   1 +
 tools/testing/selftests/rdma/rxe_ipv6.sh           |   6 +-
 .../selftests/rdma/rxe_rping_between_netns.sh      |   7 +
 .../selftests/rdma/rxe_socket_with_netns.sh        |   6 +
 .../selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh   |   6 +-
 13 files changed, 178 insertions(+), 140 deletions(-)

--WjDneLzbz8X7V0en
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCahDqUwAKCRCFwuHvBreF
YUxTAP9u/PttTzfVlB4KhmpWJD/UvJWoZn3yUJbpNhPUmXxT6AD+OS1Iolt7P4tV
5oTYrvyhydSBzle8HQa4KEkf9JTxHAY=
=RLCR
-----END PGP SIGNATURE-----

--WjDneLzbz8X7V0en--

