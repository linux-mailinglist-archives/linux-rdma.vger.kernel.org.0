Return-Path: <linux-rdma+bounces-1989-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 081B18AB440
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Apr 2024 19:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729891F21F0D
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Apr 2024 17:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E8C139583;
	Fri, 19 Apr 2024 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MbeGSKmc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567EA137930;
	Fri, 19 Apr 2024 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713547154; cv=fail; b=U8yrmi3hHOAd0/gZLaJJn+33cSROlmpEQrq/r0mDkY9hfjBs2LpeFp85fp0TeFuNpHLtymp2dc4MwhcHpn/53lkpuAeaXypKiAudqoMcpFRyJ4upC1dGQxrLkGRagU1nEHQ0+Fzdke3aP1NTwnvoD7YI12wpNOvJvSPzbpyuoeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713547154; c=relaxed/simple;
	bh=opup/gK74mRCmZwgE5ZwXqifvvjiteAH3Wy/wF7AeP8=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=b4awH6fKSk5ALtJ0njrIXBuWPUgl/g1E3r4P/bpZo/HoZY+RzvNprT5pRkYwWEKqNYucj+t7V5IhQBrrxCUZ3IIOGzXUK38xsYMTgiiQ7uhc91XyC7z6MrpvMdxpqR57PGEvy1SYvXSipfGy7DucEu+5rUgo5olQzIyETryZX0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MbeGSKmc; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mh+iD2eeRauP6YnPztVyaFMtt3Itlz91G+E/O1V39BOxZLlcMASHoC/F0PzrVez4oTxv8UsScujZL64psFjtvqRu6Qux/XZaDtAXskx0bq62qynib8/kr5MztAetGz1Cxf3DMYpVaGob4t3rnANvXl2YV85u2zlvCRICilezx7YhBdKdmy2tbCCEaK3LkDFBcRDT7J4DJkjr2jOB6gk8yF3UxzfScunwt36eqYP+5M+W8It95wP6IjzESPn5sMzSvCMLIEIURSfNhOup/wbjNWxgM1abvxVQcEGSnEMjCFciQMiT0pXAksQbQFzHtHTUTupC5vB4aAy9Hnd0tVzA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OARUa5tEpBqyDGo/5aa0+/g27/ZFDIbViTEidQnqXTc=;
 b=Hs7qeuYBeMbI6+VukGipCgbIe65CvAsaXYGQYcSVxlm34luC8EPRLyxQAg5V3V+vyYDPIlmBIJofAdhQUsFuVF94r1d7gRAkNE5DQIZIl9INyvyYOh4MSvOW7mGuUCuNngkoaXdMUi65DXSmDmpRJmI6Mr1Bq+PxLhhT1stX8WDZ5Sayez3sAFwSSFYKAkbqgVA6Kvh51ENZIufygTBqKnHoeL0feUO5pgGqgApmkuJi9rDnr/4NOi3ovECWJ+TG/XQc5YIs369v5TJWu8zoVPPKPwn27/58jWpMk+3hVXhZS1EHVYvDrHATU0vTwzwJEXRAyLZ+d5j93RVyKr48dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OARUa5tEpBqyDGo/5aa0+/g27/ZFDIbViTEidQnqXTc=;
 b=MbeGSKmczamqknNF93rAZlh4CiChAQo1jrIjmwU/roEJ/PG5pRNJxiW2oXTwoub+RnTRaBsJ1EQwHsHmJ0UMxR0r5CB7ebBNy/sC6X3hj4jgQxEmQGZOJ0m5OabKY4LLAL3ev78Cy9Iau7xDw2G6Gwp8adRcCM/jnqRLqgLfXZJUfLcBVOijoL041OfDn724b8Icpawhc7QfTQvnR9v5HD/amKOeD2K/h2SQ5wbyKeO5O0HeTWmCYDfqYTc1YSR3Ii6BHjvnMSQZV/gQ8J76jdLXFctW5DVkp2exDMqdklbQKecC6Z62bj8RvRm+dKNAV1aGpRktOCJdfGvTsm8m6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SA1PR12MB6895.namprd12.prod.outlook.com (2603:10b6:806:24e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Fri, 19 Apr
 2024 17:19:10 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7472.044; Fri, 19 Apr 2024
 17:19:10 +0000
Date: Fri, 19 Apr 2024 14:19:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20240419171909.GA3787433@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zbRmr4vzX99hhmfc"
Content-Disposition: inline
X-ClientProxiedBy: DM6PR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::22) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SA1PR12MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 371be152-ea54-48e8-bbb0-08dc6094d376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YYDTXbS/PyTZLa88qCq/x2+eCp9FXVss1lP0OojRZmcOI5z/5aWnneu1YhqAMWvN7w6Q0LRPULj1q9pBI4V2F2Fh8ackW4Ys50FDSsDEwSwsPru+Jnfw4W1CIl612/eTScEad8/Oxrj8bmOf+5/lQgjumnT2BqJMSsQLszAT4FDN76L7BK9mXsaOboXIya0a68LEMJv4WiMYnk7HPecP7NaqCrMrunxITTx3DkeCXDcYCJTxC7oWRiLotUikEaVHYc7RYKYZk/qe7FbIZa0DqqnbUTOZ2fJrxcMnatLSYhSK5FFU5l1C+wG6BxhP3yKkG30b/eGp+FUQBMPVzRNjuwv4oM0C9oL6q0zLDj+hJ6/P1o7LAmXB/nj28E7z41Gj302DpgICMA9E7NpzzxnhsiROtaNSmLkhHXCpMbofV/Zq1jCdZmeMdOAL1oEnykICGtPmSvMT0JBOIE6UskqBqnN4jeZguIoBUWZirtotWauNFg8g07blB974KAyH2iWD//l1jQaXjV2HP9tIV0pnsUxUllKDSBpAe6TDY7FieCn2dnYYGthtyR8TqCYwaondjTEAeuRjSycKza2AZ2h+CJK135HvQs4jcaqvMr158qVRRdxQ/ZLAzUG7J9bpq/noFRruSIXnsuFgteNoURkvWPhWaeUZ/O7BzlCwHak0Zt0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JTXKJUMk7OnKasHBgrh2DrZ8HXytBl5IOOLUKfZ1th9Xqc5HnYvoqNZ4uk+S?=
 =?us-ascii?Q?8bS2TJEiUMBWNzowZJg0D8TA/eVRf0v59HzYUNKuNPM+OPHk+XjZ/DGAH4ty?=
 =?us-ascii?Q?2gx0y4RL5s+0jU+/7MSyZouA/QeOXmt0Tfi2/e6i0RApO9TP6sXr2LDhEO56?=
 =?us-ascii?Q?KnySRbzpgtwZiQAKyfhPZUiXStxU2YdZqYe+Dlg2vHAkcN4gnk1unPobQ1SN?=
 =?us-ascii?Q?LiMkJDtXeAF9tUULbrletT8ZDDXG/V2NuKAypCFLI1JRLQi6TpQSFoRc6Dy1?=
 =?us-ascii?Q?H9QYiFuzPRyf0GsfskaAczzF4Yn9yGBsrc8DuoLWkcK8PywGP7CuBnXFbmJC?=
 =?us-ascii?Q?9KQwsP8UY44A5NLNal38WFZp/2PBT47ygOnG02jX5Zgy4/UJzqr7VoiZaA5r?=
 =?us-ascii?Q?dGDZ21HNLEphRRf8kEk6cM2Y1K9P4DFfwvKkeiWFLLp5QOHoGnFhDhlLHFqN?=
 =?us-ascii?Q?3RUFLMiYtoc+feafUOtNeluo850LdrMf+SKGMwLdJ63JyfCZ8TaEhwFJRqbz?=
 =?us-ascii?Q?WnZmXkLVACPADxB/kMg87jMiqpcx823v1duumOsJM5GI/S4P4dH6oNAGz6oN?=
 =?us-ascii?Q?NoTuKyS0VZSdDTEyDEBC+t1bwlicATTpO5G4EA04by9NzXE/2tOYTJdSClir?=
 =?us-ascii?Q?uUpaQLwT8B9RB2URyrIgiFkayVyCmeir6rUGHnt9E7VjYaSo1Ts5E3+KjrTV?=
 =?us-ascii?Q?oqzs9FluzZ0lRkbRhOxfFGfP0HrZRrDZ5JnbaNoV5kH8lw6ox8/IEAW2aU+/?=
 =?us-ascii?Q?WDZmlw5KfUEcBEx3o1awLJIaU2kRW3HJJxJj83P7viz7becpSTChBZEcbl0g?=
 =?us-ascii?Q?LRL6BRYJFJ08Nb0mCC6/H7EPX4txamlaD7lOik4tzzuR9rcAnUGS4YELF6/2?=
 =?us-ascii?Q?F1IDRybE9BJgpgjJHNpgoV8+PjwzkvKmoQ/bXKX9nKxFGKZpaydLLnsDDEZA?=
 =?us-ascii?Q?x/K+BSu2vKOYy5MRKb+54li8qQ54ijOhYf3cyFolTosiX+EhmokEYPZfY+HV?=
 =?us-ascii?Q?vBXMLOEsR8cTHhjA/AF18tKMXovXDT+VX0kOEv+g2i8kebksDgpaIFwFNuR1?=
 =?us-ascii?Q?2Xij/itCRNunS/p69FRInEUyACgXVdPiZmOH79Mb3O4WUE/Z/klsX/Gz7vM7?=
 =?us-ascii?Q?XXYDRomCVpRF2Fg/RjVS49+8gfF0dan8lonuSp94cHFrN2ZvyyBEdMsaqfWV?=
 =?us-ascii?Q?FCjPfZZzTDqsaPeNOcAQK6yT+BbktSDWUUe0ZWJ9aXkU46f8G5C2/WtEHKwr?=
 =?us-ascii?Q?rehf5Au5Y2IxbXVuH6KF5BOKVL9A5EPpaKcECMo9ISF9wx8ILSK1zryfRhhH?=
 =?us-ascii?Q?d/SXMWHshqYQkirnp1YQOcqLGcjHcCawrSTIu68tY17P2/j5RLY4sYMmCYyk?=
 =?us-ascii?Q?JiaaOeNbHAS6HWsZ4t2y2058seh2rxyNDTz+yen2wXuWp+eFesvjA97MM02u?=
 =?us-ascii?Q?opfMu7mwKVyQ51uBGsz0dxZueWoszePnzb6BEQjAliy/AAc8HQYkyRA1VZuW?=
 =?us-ascii?Q?qLCo9NiRApqkWxds3Yd+vGx7xMdRBzDBxbeEkabTYeg+R+BZNzQcBFdLj2Ur?=
 =?us-ascii?Q?aogL/GxMjzJUetTdAjfFNR9m75sZW+cwb9oXE4t/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371be152-ea54-48e8-bbb0-08dc6094d376
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 17:19:09.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muaa/HnmCh1C0SOgFhrUhn8jysN7/PdnKyd5U+Ie82089r9x0yv4gfLbz2TSkocp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6895

--zbRmr4vzX99hhmfc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Three small updates, a bug fix and two small debugging improvements.

Thanks,
Jason

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to be121ffb384f53e966ee7299ffccc6eeb61bc73d:

  RDMA/mlx5: Fix port number for counter query in multi-port configuration (2024-04-08 13:33:10 +0300)

----------------------------------------------------------------
RDMA v6.9 first rc

Three minor updates:

- Add a missing mutex_destroy() in rxe

- Enhance the debugging print for cm_destroy failures to help debug these

- Fix mlx5 MAD processing in cases where multiport devices are running in
  switchedev mode

----------------------------------------------------------------
Mark Zhang (1):
      RDMA/cm: Print the old state when cm_destroy_id gets timeout

Michael Guralnik (1):
      RDMA/mlx5: Fix port number for counter query in multi-port configuration

Yanjun.Zhu (1):
      RDMA/rxe: Fix the problem "mutex_destroy missing"

 drivers/infiniband/core/cm.c     | 11 +++++++----
 drivers/infiniband/hw/mlx5/mad.c |  3 ++-
 drivers/infiniband/sw/rxe/rxe.c  |  2 ++
 3 files changed, 11 insertions(+), 5 deletions(-)

--zbRmr4vzX99hhmfc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZiKniQAKCRCFwuHvBreF
YS0LAP9PngrFz8rHw8lP0CgnMIncFitSKwTDC14uZ53ZX0Fc4wD/eTWz8iIcP6b2
OGREOcVtSSXuoCqh6wQe9ECHkWgzggA=
=kV4U
-----END PGP SIGNATURE-----

--zbRmr4vzX99hhmfc--

