Return-Path: <linux-rdma+bounces-3400-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8045A9126A0
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 15:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20231C25D2B
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 13:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C5C15574B;
	Fri, 21 Jun 2024 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mn1+JWi/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85240153BD2;
	Fri, 21 Jun 2024 13:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718976299; cv=fail; b=N8/8HyyjK/hXfMomf65M6JmvhXmD1K9btzXHQpS1d46naNrGPXy1hw6Qkf4joEbMFIXnPZR8KfFmr3eFKc3v1pTAqBrvPO9ORLPuyQ6NOwb0+bFIe+lKOSI3gq4zDCStz8zPzDWWcLniqRsRtOZX/dD7mxLQlavKc1HRxfV4J4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718976299; c=relaxed/simple;
	bh=NwDxOyb+/6PByLTTwf99A3+22gDaZYrHaARMYQhorx4=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ftuBsVYXdQnUFNGa8W1EWQIOzwqr7aG1kG4YeBr8Prs0nEr8JhaXb9jJGV2L39U/8+HRdIfvbjVWceZ8kZCazZM1Wz70YPpoKIoP8EgnLattculEYrT3m4SnT2R2SfmokzSURKFyFIq6honxoxsUPrd89YI/SuL1Z4rtyiBMPLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mn1+JWi/; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTjqMlY6NIomkJsLFpFeu0HegF7zP+bTD8ovxxEPLclrLYAdCXEcY5xyGuuSOOgQ3p9Rq4+jTFPJgX+F65gy4/eKCybl1nTj+yJ4ZZA/vK7mtpPmXYGkUQOU1h7NC4JApxIvVMafcjJNb1eHE6US5qzvUT+YNsbVLNFAksmta9QqJV4blc51iQWDI+yvxoDmY9omYDaldIwenHaXT67V11ujCW74J6eQyT1YWjE4qJkjC4IpI4Hm6n/I/1gC0Arqm9rfIBwJ5uHygJ1zbTwOx7H2zkUnzCCswt2/+s7n/vX+jA0lTqIp/ulZOLI0cFplSzu50q+70ttyGMkrafsKJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vToEUbsyutj3YVhRHw6cNggjk1E5aqfOJ4cP2IKtDhA=;
 b=hYecqI/EktHy0MGUm5QLepCm+0aJCAgMEBUHuYappwJYbtiWVh1d+7ML2SWHwn1radPdMOs8ic+D/k45jYuJiPt96eSw4O8ETrp978PoXk4bkhCcMcIAjOoxG+q1urarNDlevU1+Spdw1DpnLr+vX9YAF+IC+7//tNmBTIGqIhNX/m92xXcA/vFcRzUg9Zow+IyYe+6qWP+rMlkPIPeCadWsFyu7ZWGi02UrwMZtMsUVphv0bWzCjmuUlU82P166/Pp5Q0lmSGRpY6q3FXF7EoI9xs1hta+7J1J9xtsc1jAveVMiTKFrVwjjQkGnTcee3GweY2CsG64e0zKQwwtKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vToEUbsyutj3YVhRHw6cNggjk1E5aqfOJ4cP2IKtDhA=;
 b=mn1+JWi/TiJL1AqwGPUD2PhGmc7WxV0q2fQLgSw0rkuJbl8IWuBN/K22L50Km2jEmSYgumRnier0Mn9JKIl7od6Eh9dilsCuxn/WEvBre21FFYzrDNfbKMPnSk/FTpXlg84yYLg0oTGByHzIjK6CsC2E5cvcucHVhbHXdZhNGP+vj8FHDPFCL/g1RpeWxUjy2O5bFN3xS1pvf55raoFbNlLCWu2SYFyfjjbAxjIGrhF5duH+PW2n/aA3pucj/5Xf9vtFtod5DFV3QF9m+g6oZetQfjETT11LTNgCihRsgW2U7pi964E8UGvxW1OyMcp7RMCfLa8Nn8153oQWnkFKkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 13:24:51 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 13:24:51 +0000
Date: Fri, 21 Jun 2024 10:24:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20240621132450.GA4186507@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IneDYfhUKu7NOiwZ"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR18CA0018.namprd18.prod.outlook.com
 (2603:10b6:208:23c::23) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b904ec-624e-479a-6c68-08dc91f5880c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ToZU/cLXt3mA5RCDPWdqwcP4nUa2FAcD2gj+iTQPvIjx623l+65KjTuLO9pN?=
 =?us-ascii?Q?0yV+304khJliRzlXXwd0wMDDMKbYsD/560YtFyhNMdddQh53ha25JG6y3NAh?=
 =?us-ascii?Q?gSHuWVd+YmMnyuP9KVmnC5muEwRqEexPK/7oJAoRXkoFQ96EZ79a+KFuOqU7?=
 =?us-ascii?Q?quIRlxL4qbggxyVvoHrZDWBrTTcklkcCKoBvgn1pZrc0PjwZCUYmDdQ68SFQ?=
 =?us-ascii?Q?Ih0smXPosX7l0IjvjCu6odumv2Qe8Bpv3MM/l+jQ/3GNURE3ySCzO7k/eW4n?=
 =?us-ascii?Q?gk4o9W976MSDcjudSc5QRkMtEPJeTqilZ0VWcWdH81Ds3Nqqlup7iOvE/Sw1?=
 =?us-ascii?Q?kE5TssKW30sATq/wi5MCz9FqC4GwkvVckfoMdaSPfrrzpPPRTF4fmXAlbuoU?=
 =?us-ascii?Q?G/FhrYzf70e8PGpOLqar5Bbk/spb6o1SssCxuproq1OgtgMHXoJpPrf57fR1?=
 =?us-ascii?Q?jaNg7FMgQOM7agLWdSf0dlM8nAtauLQNAnrgavDTNJ34yEmt1cxWGEJcHqPL?=
 =?us-ascii?Q?8vuTSS+Wzw+ig8fJhqIA+M8X4jDkU9/rDOSs8gHC3jBVRShkH/3ZL7ni14nf?=
 =?us-ascii?Q?u4u9HlDz3OAksCT9GQpJoz24+iHdj1i297mK3zaVx0qlKoaTdT+RIXGRSWOg?=
 =?us-ascii?Q?yfMheUWGwKbkQhkg2ne05GMux0sKG339chXehtkk4m00K6/LsPi+hea+qtZr?=
 =?us-ascii?Q?nfXnCcA3OoAqSFzOBJLcDxPaBR83H/Jj6mXdJjL4jnoyUUrnkfMaoZGaSdDb?=
 =?us-ascii?Q?PuY0fkO5jgDLYhv2sQXkJc++52NDb7jVFM7a0/K35A9IttmHT0Rmk3r3R1ZR?=
 =?us-ascii?Q?i/+K6CtjDa4FJimHNwrHLBY9snrg3TBYFzyJeHGLialrAs5Op6Hmk9G9tL3q?=
 =?us-ascii?Q?AaigCYXTt++ljZuXyB3klYJWvPr4MDkAWIoBrrrJmNK+nLfqZ0bIIeT4K/Lf?=
 =?us-ascii?Q?vkl7iL3QbK4yG9KKH5BIfJtNnCHM6VUE7ULVe9d73n1YOnVvRFBZv2jb52jY?=
 =?us-ascii?Q?5h7gDH9i6SPvB0YgpOx+xtDrq48Ilv6qSywpV8hHZjMJZtkuVr+JxA4bXQlr?=
 =?us-ascii?Q?f+ihbINqRyWeFDb5ZqCFgf9gynUfiRo8+4YVkC9LNOjH8zeVzGIe2P2n2QEn?=
 =?us-ascii?Q?/4Byko7WJTL0VyzNcZEbQek9psRZgV9gcW2dVJNpdDnWm9VewmZ1PjVZKZaE?=
 =?us-ascii?Q?y4MfmYmh8q7oRMkQcA2DTpXN0rRpIyQr++TTHMPkev1Iskvc9lWjpgdUV4i0?=
 =?us-ascii?Q?cSK6NyDJ9lDK0/GH3evWQZ6G0S2zmbx7r+73wulwzqP6IZ0acEgGu7kuFYJk?=
 =?us-ascii?Q?kxkGZK8TWncHwOm66cltwYMI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GOYs7dRuTdz34pJ5fwWoyd2PQstw5cwJnvqo/taipaRG5FN0odZUHYV/vZOz?=
 =?us-ascii?Q?Evykl3aiXzepuU1ke0ew1eCvKANVKdaz7nBy9szxcaqYwsVpw2/wbiPKLC+t?=
 =?us-ascii?Q?4d6W/Ncho+58duOOlU3ACn3E/ndGfpXWQUTUHuencZe9jR3rR9K4yWZSZ/D5?=
 =?us-ascii?Q?uRAuLAw6SecEJqOUF8JczO0xwknLIoxP7kfHKMNK790+u14oaWVMmc8C2x4e?=
 =?us-ascii?Q?1FkVKyq+R0e2CJGer4iCAmraMjC6l7EhRKzV6OUKnll/POs3ww5hFteZaGVG?=
 =?us-ascii?Q?b8leqzUitE0zB/0/jKkcfIKxqManQjSanRLb7DC6WZXt9rcwzvDkQNcM3/qY?=
 =?us-ascii?Q?wuQkuZDuKleDBtJylyecJ22mWAtjLU10vWwdFCjjiGHKWnTxyRcr1+T0x25V?=
 =?us-ascii?Q?QfLEDatllmbSFm/3F0pGHWNFpqFS9j2wrPShD5bu5GpgE+L2C0igYFl93jOd?=
 =?us-ascii?Q?b4fykx3twsmI8WOaUAravThv2Jum5iAxABwylPXk2VQadZTL+Vpo8h3vcrlE?=
 =?us-ascii?Q?Bs9X4OafP8vG9wJC6x+bL+XTsJhB3V0KQFZgThy1Ov1IZnK9epSMakH4pS23?=
 =?us-ascii?Q?hewxpsqj8CBYdsxSEwYWRt98PNmQNWcRmdPzifM0tJlgecps1GdvlNV52k7p?=
 =?us-ascii?Q?reuYNaCJWn5Nt9x0gFlrJ4/r0q/4yzbx81xeEynMb7AQks6YkA+I7H/KCPF7?=
 =?us-ascii?Q?KHm6S4lxdXekNC8wvoA92mfhonaxXWiQ/G2H2K9hWJ56ZYnK+ZypjhGKJeq8?=
 =?us-ascii?Q?tGQFyHDdctIcBlerRaG2qFqV680TSfdpwfZOTKF8M9tDRiLzhpAv6F5gat6l?=
 =?us-ascii?Q?tUrlneh9ebEjQS0fhIU94Oa4w/2FCPWaSgNW0dJRr16zZiEvZGGEEEkAWbwT?=
 =?us-ascii?Q?NBAdDbhTrQD1tzHJNUF01q54nQoLX0rUzjgE+qJ/Ojr3f8o7Ch9NRSV7M8QU?=
 =?us-ascii?Q?S9xYmZkRHmrnCGuehpgNPisliAA9alVu/hcCqLL/MsZ2lbyEAULBBcUAmbbB?=
 =?us-ascii?Q?ssBBp3tDM+fryQLYuBOb30NnxoGJQpw2vLi/ql0wwiRjbwZG83khwiRzKWh+?=
 =?us-ascii?Q?zsiQ+v50iXm6CUM2R9A9rJdph9Mf4SkPzkk1rEwkJ010JdV/uNry+ZgNctsq?=
 =?us-ascii?Q?FW5CAlvqOgOKTYocd9uel54oPUOLaBRhFSm4QUMxg/cRn2NoEp4J65OOOPRD?=
 =?us-ascii?Q?+Jj1yNVNI0hlYkvclnn0l7ZFbKPFhx2rU52tD0M6cAttCRwOFcmWY8oRGv1E?=
 =?us-ascii?Q?PEpzy1roPeNq3Vt224QZrZ0azF1SaTSIS3TDwHckBEkNqNmYR8u+4AI/903x?=
 =?us-ascii?Q?Hpw3jlgsWAOfY66ntChm45PL18VdzTaDA4On93+pxOgmczWV1q1DGZ05xJ3v?=
 =?us-ascii?Q?8I+mOyUP86AY1OdDp0VTl0RjtkGydTkiMrblC4k8XX81aTm69m7hK4HQTFVB?=
 =?us-ascii?Q?q9kH1Q8Lki8hfQiOs4mdwxx/vGC/zjjd8dUQMvSSkpKfbVVy6aR1NpcdgWNy?=
 =?us-ascii?Q?ydnn0PUU3P7uPoM14qi0vtBZMo96nB25x4RIvpLS/vBl1JHsz1avQ+JH0b26?=
 =?us-ascii?Q?5M29aRfn5BDRFhABWF4TIlW3GONN8lN3zKs/e9nK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b904ec-624e-479a-6c68-08dc91f5880c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 13:24:51.6486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvuHXEWeQX/rSYTsZChL7cZgyQc3DGGbr1ZD2suqhOVUSFZVRjPABRdeFkco4rDC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700

--IneDYfhUKu7NOiwZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Collected bug fixes so far for this cycle.

Thanks,
Jason

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 82a5cc783d49b86afd2f60e297ecd85223c39f88:

  RDMA/mana_ib: Ignore optional access flags for MRs (2024-06-21 10:19:36 -0300)

----------------------------------------------------------------
RDMA v6.10 first rc

Small bug fixes:

- Prevent a crash in bnxt if the en and rdma drivers disagree on the MSI
  vectors

- Have rxe memcpy inline data from the correct address

- Fix rxe's validation of UD packets

- Several mlx5 mr cache issues: bad lock balancing on error, missing
  propagation of the ATS property to the HW, wrong bucketing of freed
  mrs in some cases

- Incorrect goto error unwind in mlx5 driver probe

- Missed userspace input validation in mlx5 SRQ create

- Incorrect uABI in MANA rejecting valid optional MR creation flags

----------------------------------------------------------------
Honggang LI (2):
      RDMA/rxe: Fix data copy for IB_SEND_INLINE
      RDMA/rxe: Fix responder length checking for UD request packets

Jason Gunthorpe (3):
      RDMA/mlx5: Remove extra unlock on error path
      RDMA/mlx5: Follow rb_key.ats when creating new mkeys
      RDMA/mlx5: Ensure created mkeys always have a populated rb_key

Konstantin Taranov (1):
      RDMA/mana_ib: Ignore optional access flags for MRs

Patrisious Haddad (1):
      RDMA/mlx5: Add check for srq max_sge attribute

Selvin Xavier (1):
      RDMA/bnxt_re: Fix the max msix vectors macro

Yishai Hadas (1):
      RDMA/mlx5: Fix unwind flow as part of mlx5_ib_stage_init_init

 drivers/infiniband/hw/bnxt_re/bnxt_re.h |  4 +---
 drivers/infiniband/hw/mana/mr.c         |  1 +
 drivers/infiniband/hw/mlx5/main.c       |  4 ++--
 drivers/infiniband/hw/mlx5/mr.c         |  8 ++++----
 drivers/infiniband/hw/mlx5/srq.c        | 13 ++++++++-----
 drivers/infiniband/sw/rxe/rxe_resp.c    | 13 +++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.c   |  2 +-
 7 files changed, 30 insertions(+), 15 deletions(-)

--IneDYfhUKu7NOiwZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZnV/IAAKCRCFwuHvBreF
YSPBAQDOTATf8OAkX1tqwvG+Gm+XGkyIM4D8UkcH8jGJRwADRgD+NYn194AdmIAd
1rRuMVb629fSJp9N3Li9OWHfmw0Pegk=
=u/VL
-----END PGP SIGNATURE-----

--IneDYfhUKu7NOiwZ--

