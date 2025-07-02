Return-Path: <linux-rdma+bounces-11837-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BBAAF5B3D
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 16:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9561C402D0
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2DA2F432B;
	Wed,  2 Jul 2025 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oIyoZid0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976D52561AF;
	Wed,  2 Jul 2025 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751466984; cv=fail; b=p+dpg9LdOT596jA782oeJzeLJw3m2czRjJX0r4pgkP5T4d0KmR5jXY8q3YE4YWveso1ipDISg6HqocmSiiP+xIQIRyLbrO6WRYiJu0xRbqaz8Wr7MnPtnNx5XAR6cpKcOkagAKtXbCYiHPWX/q6lHrezM/ziZ6PdtAUWeamEs1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751466984; c=relaxed/simple;
	bh=T3It2DgiZ6c91qZvX9NYG6k7B9WnBtF1G+rJC+U275k=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=MHtJ1bUzZWIgtMJwPi9wId40bTgFl7KVzGKaB7WBUwABQplQYZBtUq+EdOGRkj8FOHiDyl2eDw17atMViCvJ0+kq0Myvwp4tgznuLXWQGkNVff3hF+3cBBBaHj6e8MFJeJqD0lxZi8cLMLyWbwnli3rgk5lIHc4Bqkm87gmuMGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oIyoZid0; arc=fail smtp.client-ip=40.107.100.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlEIIU06NRAYKKLyEU0H9Ahtqo6wvkRYKW4HBpmcp2FbjkygdbKAZxNKZv6j0y5qTiFEVRPLrFeWED/Z8g80Dhkgacvc3mwBYaRQW/Gb95S31NpO5fiZ9n5PgrBrEaUL0CVmnhOIcUc9K9vPW56z2Ah/iSExiMNBeLVvtc8j3/1hMtrKY24NhuNk8b4E+MA8oPFN6LcJLrtOXfkjcI1e926GIVbaCkyvwDZ+2X26dMSbcMaOKJxWT0Jr0TDy3e1s7o2dDll2B/c3BDpwJa3Nkl831HAVFgdFvspA7nlkaeEm9wNui+Tc1D4NmROePbSBycF00xXH6MuQ1+bcnB9AvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Am3GucaQLv9bpL4o3GpY9nIHePZWes2kzx66UH7LchY=;
 b=RT+46u8/beRa0dt/l76a1I6a+ciLtBTR2+ffve4EJ3PIZVnHOkjBQthcHIJondXbjpO43hXocoRBmEnN8Jc2YEqhBqgUoEP+kyTJ7Hj5JH/WwPDErAlGICv5tAjBqWrFPwVREdC31PZWKK5JAiUYsf+LlspiPr6F1bykpL8b/0RRMy4FM5RvwjtmvogQu/XbH8NO54r8bj0CPzx/2oYrFGNoDevfrCqhfkjooXsX5swM3/vme+tgZN7oiBPpA1h08WMpiaCv/UYPdC6l12Qhdcc/HNgadzIH1DMhj74nXfd7j73Y9URFJzHf2ZpyQY1l282HeFoyofqEbsZWgw+9Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Am3GucaQLv9bpL4o3GpY9nIHePZWes2kzx66UH7LchY=;
 b=oIyoZid0YBsIy28ZfZb15kPv7fKmSEUlKGhz9ODy/XnaCscJChIu9XUdfzd6TOTmRZyeBRWsZB+Wnvpi/9TrVgVFz382B4aApwdQKERBQtiWMFAQqz5mOzilx1OZ85NzIGZSJY79f/XLXn+PrTll4nmcHN8NuPHyXH8DHJo+ovRIBstRq4MRYv+hxdGLfVJVkFtz3aIe6FDnxP9TwyrTOa/yZuneokLM7OS35QSdKyh50RHA9nXl+YaXLaqWXsxQjflU5xdWYoXSAFNNm4dgxwcrnC2TDoBFwKrRoqMrqY+0Of9L/7trKBZdJDrcbepmBMHDu13iWTyrH19YX6dfKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB8594.namprd12.prod.outlook.com (2603:10b6:510:1b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Wed, 2 Jul
 2025 14:36:19 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Wed, 2 Jul 2025
 14:36:18 +0000
Date: Wed, 2 Jul 2025 11:36:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20250702143616.GA1163046@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o43Is2+6ts30ELz8"
Content-Disposition: inline
X-ClientProxiedBy: SA1P222CA0067.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB8594:EE_
X-MS-Office365-Filtering-Correlation-Id: 0faf63d8-0c1f-4c74-f165-08ddb975ce9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WNmcp649SaGMT1DQvOwA5RlWjDy6IRBFHqO7y+B9aZ77KHonXXR7/f7LSMnH?=
 =?us-ascii?Q?aj9uGWEXbSFb0K1M97DJtM9CIb5X6oKD7lQcszRjXwc9+5/7GEPTcxTQKqie?=
 =?us-ascii?Q?aiMJ7vV/noJgo8uElbONykMUtXgGcnMq+QfHmLg7Lgk3JsxN4FweA2nXPfu0?=
 =?us-ascii?Q?DHxqO8jEkDA1qrEFn02DByrX4gNyusGMYhrhJm58DIQ1717KZhUPRc4XRikR?=
 =?us-ascii?Q?gYf7rpKZ2AZf4WG13KObNkps5BwNMj1CySgT9PERMXnO+9Qjq6tVnoKYP+FG?=
 =?us-ascii?Q?gYROKBR/GooX4yiuVVH/9M+q3Mr4kjuFdsrsAEKFBHlguzLee1E+Gh93av6K?=
 =?us-ascii?Q?Q6KIaNlG8F8L9O5FKFxLcGsly3RTptZaLO3TXnEBplclEWKzGLVbz/P+EtYb?=
 =?us-ascii?Q?w0PlImkhsDVL0sRnudJIzLZmHqCdISa6DUxnJU09JzclyGajNlrUNuwnm8gy?=
 =?us-ascii?Q?Bjm6rsNWrPTgtDlgYDes+oL7TeV50kO6eIJk3HV78jmBMvmrdn/r5UYQ5gF9?=
 =?us-ascii?Q?omZZVXTzzDdiT0KQeHCNVSrZn5YQgOHKR52NuxViVmpTgOutfNvtiSPPaqvf?=
 =?us-ascii?Q?AZ2ZVBUNBgKfzHmTHWVCwJ31vaduUtycZLT5DweDp6gG5+ke326fu5X5UtYX?=
 =?us-ascii?Q?b7YQ1N7Xnb4QXkLpfQR+KLjZXQeiBGWpnB0kmC+0+RzGoXMyhwHDa4bOZYQE?=
 =?us-ascii?Q?KhNM9rdvzrPYclbMdxvKAmOFu9K0dJYocH2a0mU4Kur4X+cc7rwQfQk70iRA?=
 =?us-ascii?Q?Sj6ijh4Ud+Y/gNDdnnIfMdmaQCFtQO42jj+XCRHM/1NMXFTgHXtpNXoHXy1H?=
 =?us-ascii?Q?6TOz1pBZV/vlcZXz6Xkus9lanXyEA6FCUjxlweC/jmuIrNJOXhKAWmj/4jnY?=
 =?us-ascii?Q?lv0GhQp+oz/QokCMq9DPg3d66OdxWdtTHVSMY/k/GZhwcuALVl+ayABEYb4m?=
 =?us-ascii?Q?wyEtv7tBDmHi7PPnmmxi2IcMuy3HLM0/N+l8s83EuhjAAl9MW5PqnOeA4EzX?=
 =?us-ascii?Q?CT1Grnal31QQOlYEHoRZUpGwuyiKfH+a3Nfwzoph4YOM02qPIelcnuGJI/Rl?=
 =?us-ascii?Q?aexdhz//jshLLnc9TsH14q2SpgGYghP7iyh98KRIhzuNfAyrSz1zoMFqRZMm?=
 =?us-ascii?Q?yWR7BkMZvxmvpSynJeZ16q72ZbuGUnH/bwcrTUGUnSyhnvFIUufLU3LHzED6?=
 =?us-ascii?Q?n7mn+PlgouSHLOB30h/xVioAJ96Qocq8YpzoYjlXS9NzeGBsIMBORbnjGGKI?=
 =?us-ascii?Q?xXoRlT5nwBcbKumUxskHXxtuB3UgpI74xaEB8+VXAiO9Yj17YXrbAWCYggZz?=
 =?us-ascii?Q?0mbdjhu2zXW0L2X7/Bj7PzaZC/bpbjVEvDPo6UM4jGWH0y7+LrL7zQMdCQ9x?=
 =?us-ascii?Q?5BxyHGu9f1/o0ePA3IEXHXUix3ZQKdQkkRYgwFzkdW2bpFGpRCK+kjqW2L26?=
 =?us-ascii?Q?4bxxGGjKVHo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Jn/rI7VpBzJDSJvaOhveEUSRPecgRb9IThVJtGjcjb3RwrTi/tYCmHMySlM?=
 =?us-ascii?Q?1AXfT8vJO/GCp673V/14BZJE/GGtz3drpXaJrsvpRTqaC40AetcdOk9qWqPm?=
 =?us-ascii?Q?FQGPG7PlH8k89zZ/5Ij32eLO/6BMTyLC7EHo9hbgr7RLTIT6lEdoXo4wckOM?=
 =?us-ascii?Q?c5NzWLpaF/dxQPCma1l/6VMO5HTjRjem//ynWCpDNaVQtZ5tit7CD9PCgdHa?=
 =?us-ascii?Q?KtXwxqfQvp+rKO+vuX/PBomMBeIZfwLZLty8Ajb+xIjbRDeYK/lZWsAjN7r/?=
 =?us-ascii?Q?EcAMTS/CXu/GlmLWDKnrcvD00jZ7eJ1bRN1WVVM+1Eh/qUcAuKctX4nnINC6?=
 =?us-ascii?Q?dfnUO8mI33moxiprZBps2MutAFtqSh0+QHrPI4NDc7FGyeQ42Qf3nOoJjZ7O?=
 =?us-ascii?Q?zYFMZh5Rg02hmR99iLBqKgjlyqgAvrxmHQ7HxgxykNHNgSUKIMhAREQmY+7W?=
 =?us-ascii?Q?1OBG3knsFtQumqh3lt8Wl8tfxZyqE3DrQazkdY+H7KALrQEy2S53Bii7L+Gh?=
 =?us-ascii?Q?6h/BfJiSejoVkYapTVUiSeZIHE24k/zcRUtGpsG1sJFejOK1WzUAnL4LbqoB?=
 =?us-ascii?Q?V0WE7csvuNT5cPCdpOOa1Sac15Hf3tRX8YZzlHStvzCTMuN6FFCbRsdJnFb7?=
 =?us-ascii?Q?CydHjkkAVvHVGQeTm+yT46YdyQBZvMZeMzHrLGjr/Wxm0ob+dCEZrJT9JW9g?=
 =?us-ascii?Q?zt6xKTXMHw4rSzYAVLX1pAiFeGuU5DbcAjE5Uw9oKzD5eoVO8JU+FJ+VwO2I?=
 =?us-ascii?Q?9IcqRh6cquu27TMqO5G51IS3OftaZR6d1+tjLwPQNk/9NJ+/ghq2uUx/AVSC?=
 =?us-ascii?Q?A4UvVRU3v0q2xRhdNNaWQtItp8pAFhbF12dTo+mu5/sSCSmpzDY3jFNOt6HO?=
 =?us-ascii?Q?t/Vk35Xu3IOsBb4GPLA3DHpPXxd7842j2dX3gRJCRReVFhctrAWBKcSYlLRY?=
 =?us-ascii?Q?bh1TtegY8k2vzqiPNHCQkAa3u1XVwthVkYcvPeMoSzzfV9BM0tRakk70NTzB?=
 =?us-ascii?Q?Jg6bL6JJYCUGx9mciAb1S6fqmvrhHTsrgSgh/QuprfaXGTUltS71wVuiVrQt?=
 =?us-ascii?Q?nik5ZHqK8mZSQPRe+UWr41BdX4jf0SPRdOiFQAQl0zV4XQ+/wGJvHtNrxzoa?=
 =?us-ascii?Q?k5AVoFduVocKRwYH2kwXxSGpn+bm95B4wn8Ynus5Ic6tvUujwHFpzCBsPG9l?=
 =?us-ascii?Q?ytjO2etfQXWZ5BcHCIqeoHHqTV1+wo8GIs7wJta+5oOCyNgx4blinmBbBeFn?=
 =?us-ascii?Q?+P0esN1vnX/CqzNmNEIBG6AgE65+R2CFyZ84pMHQ5UU2vs0PdEwBJLFbO4MH?=
 =?us-ascii?Q?K5xfTV/AL7MWucleSmWQOq7gT8O4GK+BQaH6IbMfIhv8yHAsc+KYAaL5yY+M?=
 =?us-ascii?Q?/J58HwyKdCERCpHpdPEHrAWee1lZZfcisYQ44puq6lwbq0NJ8vTmZQ9J4byS?=
 =?us-ascii?Q?RWW4DYMkTQolcmYo1eK4TOtqKyGINSz0BXzvfDbmBKbNysIHD74ZZKSbwo7P?=
 =?us-ascii?Q?ci9HGrziEcytGwb7aK+wowl3NXdKLMJaRGWAR3dD8McWqAgT9dm9FZWsM55h?=
 =?us-ascii?Q?kwgrEBTJ/B79Oxu9SYEpyR3oNHa5VpImp73GNdB6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0faf63d8-0c1f-4c74-f165-08ddb975ce9e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 14:36:18.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BFRyZm5Jhtnwc8X2OiPwK4npibxAwANcTrtweEhKprClKYtvRQ494d+3Y/HcoRg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8594

--o43Is2+6ts30ELz8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Small batch of mlx5 bug fixes.

Thanks,
Jason

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to a9a9e68954f29b1e197663f76289db4879fd51bb:

  RDMA/mlx5: Fix vport loopback for MPV device (2025-06-25 03:41:59 -0400)

----------------------------------------------------------------
RDMA v6.16 first rc pull request

Several mlx5 bugs, crashers, and reports

- Limit stack usage

- Fix mis-use of __xa_store/erase() without holding the lock to a locked
  version

- Rate limit prints in the gid cache error cases

- Fully initialize the event object before making it globally visible in
  an xarray

- Fix deadlock inside the ODP code if the MMU notifier was called from a
  reclaim context

- Include missed counters for some switchdev configurations and mulit-port MPV
  mode

- Fix loopback packet support when in mulit-port MPV mode

----------------------------------------------------------------
Arnd Bergmann (1):
      RDMA/mlx5: reduce stack usage in mlx5_ib_ufile_hw_cleanup

Maor Gottlieb (1):
      RDMA/core: Rate limit GID cache warning messages

Mark Zhang (1):
      RDMA/mlx5: Initialize obj_event->obj_sub_list before xa_insert

Or Har-Toov (3):
      RDMA/mlx5: Fix unsafe xarray access in implicit ODP handling
      IB/mlx5: Fix potential deadlock in MR deregistration
      IB/core: Annotate umem_mutex acquisition under fs_reclaim for lockdep

Patrisious Haddad (3):
      RDMA/mlx5: Fix HW counters query for non-representor devices
      RDMA/mlx5: Fix CC counters query for MPV
      RDMA/mlx5: Fix vport loopback for MPV device

 drivers/infiniband/core/cache.c       |  4 +--
 drivers/infiniband/core/umem_odp.c    | 11 +++++++
 drivers/infiniband/hw/mlx5/counters.c |  4 +--
 drivers/infiniband/hw/mlx5/devx.c     | 10 ++++--
 drivers/infiniband/hw/mlx5/main.c     | 33 +++++++++++++++++++
 drivers/infiniband/hw/mlx5/mr.c       | 61 +++++++++++++++++++++++++++--------
 drivers/infiniband/hw/mlx5/odp.c      |  8 ++---
 7 files changed, 107 insertions(+), 24 deletions(-)

--o43Is2+6ts30ELz8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCaGVD3QAKCRCFwuHvBreF
YXuzAQC9xD+VrsJixyrm8UDb84t3B0MBw689myBWzXFFCGQktwEAk2lpvdmURYTi
vj7d0ctkHYrV/KyiYOkvYytN71bXzQY=
=nRXL
-----END PGP SIGNATURE-----

--o43Is2+6ts30ELz8--

