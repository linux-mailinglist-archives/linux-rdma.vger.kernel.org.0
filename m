Return-Path: <linux-rdma+bounces-13760-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E87BB19F5
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Oct 2025 21:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A9A166DC7
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Oct 2025 19:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26595335C7;
	Wed,  1 Oct 2025 19:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rXrnIcRj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1739F17A305;
	Wed,  1 Oct 2025 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759347344; cv=fail; b=a3UWfSeq98X8KSQJm+mzDPSJXiGR6AyFQo0el9JVZPdoDnPCGNDohNwbY1jjRIkZ20pCf5oeh+42duI7rVOdjZq4cukI1pBdDMy7zjHqvbvB4Ma8w2TCSR13sFFpj0kc7joczXMiakPt1i7OXeihoown+nGuy157NDw5mqQu06A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759347344; c=relaxed/simple;
	bh=zzHsguRGGgWB/OM6dCl18fEWJiRdSehaoz2iObVWmHU=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Ven0LsRuFOxvg64HOJ5c9VZrza+4Snia8S9ggJXWbzhry/lcv62BKwfHM+oV2xDS1ok1g8urNbGT/QH4zOhNw1AHflL0B7xiqVryyRL1tEaYlMe3fw+L+wQfscDVm8lbW2ZDzYBFfr1EWT+x6zpMUpBxOH9SQ0epX4VflnNmCJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rXrnIcRj; arc=fail smtp.client-ip=52.101.52.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPTQRVVy76ib8fI3AsRcFEHpv6ymb/pgwzb2IIPfAatihiMFHWLFYVB9mhEfC+ZscT0O24/deBGwtzdBIg+yHKlP93puz+jLo6Z0y4p6fKnzK74NiDPutJ81vFLNdMC5yzNZHDDAIenWBtxBWGh1EELL/YN/hyGRDOBhr9Y1FAaQpJuLU2gjbpoAlUpijqkgz/UMTX3v1VyYVS7oaVPQfdJKD53bE53AGUypYCz/YoKM9BxSKn3mG86zSKMmm/54AbEbXUvYhNnkwfu44mXqgEd18D8qBYlL2CHWqCmA7KZsFJqth1muiOJmUvZ3leYwtCnKOJxmSbO4SsavgDABBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=honiNsCgK8EWXgMa0xrBhPgfkLH+0qz/x2DdgpkXoC8=;
 b=yxTvpc0Y+GOkFIAg3DQM7/zxM5TdmQytNvrRV3Xw67qn88PXEiFURAhhQSllXBbnGGQxJxl2+bCwS5ykPWPpeuWjZbtMHNkPyKsNsGk30kf64TYlG3chjQEBX4CU375t7ZxTHceJ05OTS6gLnsaHT1v67Jm4E8P8kAXQPggRMOoEiQH7ZTku+REdQdr2sAEDf4tbgYtS4cGqiwHrQujtF1fnJnLCS6fGFoE/OksyyGd1n7lJxNDbmWjX8gBBz9tRtR28VNjOXkeM34RDl8Ac020DDkEZ1F6AM4OzpY4347TDfkEmJd0F4us5oNkBCvoC1TZfJSGcHShTgMKO7OVgDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=honiNsCgK8EWXgMa0xrBhPgfkLH+0qz/x2DdgpkXoC8=;
 b=rXrnIcRjd+/OCNgKNp7Wcc9x7n3KzuSZ3enHpolElUOe9hvam3QuJAlPyH2NGewhZdNbXX+Eh+L68/sOouu1WPvQjwgLSkUkaIGFXJkYwqWjQapZOO+vIhfpOoT9uwg6Lgp1DImaIDDWO/DiXQdxD9e2nzPcH8B8YxR0RXeejvFitMBWJO+kQWPJn4GZsfAH/o34QZlb6bOcRYYI0i3HLcdrAjMQuq/O1AHb8Cxa83A1VCzdcSxs/KMiVDBxU/4cRPZUusIZs+6KfYp4gjYl8cpVlX3lPxaAi1JMSPUMcnvitrR86hm3vJQtYIU3RwhNFemsFKfdIKtUoVaPXh4zmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 19:35:36 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 19:35:36 +0000
Date: Wed, 1 Oct 2025 16:35:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [GIT PULL] Please pull FWCTL subsystem changes
Message-ID: <20251001193534.GA3227444@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vlZd6WAu1ApJJAhr"
Content-Disposition: inline
X-ClientProxiedBy: BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::6) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH0PR12MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a2b775-5221-4af1-4bb8-08de0121b1ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SCkN7L/JajO7dHUAAPMjKrUc+V5yUF2JBvTgg25TlG7D7DRB1004FTY4LxXg?=
 =?us-ascii?Q?/qUItxBaDW6PrYFOT8scEsDmQ1Oue1k6HgIMotFEz4a1bBXQo/Om8TwhX/0H?=
 =?us-ascii?Q?69c2lfHp9CkOzfPqeDqV1cnmzCuYx/OCa6SLjCX8f5EOxsatFe8swdBoboUC?=
 =?us-ascii?Q?5ENmhWe6FHTxC22YNXDd9FhTSOxCCyAZ+cCGorMY/dV6G2kG/jgyVQfMXBEB?=
 =?us-ascii?Q?++HpQOT0OdFSYw95fYNtKUiNsZ84yxFXCGYXytLSjV6d0xzNtMjoEfrPUvvG?=
 =?us-ascii?Q?9rfxg6yrMbbq2WDyN/dCayTsyA1UqOVlAa0/Gnb/v18eVBpEyYGKRCf2lc+2?=
 =?us-ascii?Q?C+fEVetcI43cL/2S94ARIMS0Y7u6o7TL/bHdNNlQne1zs2JtKMucRQCMNGdh?=
 =?us-ascii?Q?qrFN9lWTfIr0FXtK0CcNKGPRVrGnzPmctesCPteNENs2UXp6Nv7KLYvduQFg?=
 =?us-ascii?Q?6E6Y8XoYX852fGR9h6y/Nx32gb0JBdNO02GjfksLmZMg9gpdMleVMt2JQGrg?=
 =?us-ascii?Q?px8cmOz8yIXhnSkiYAOWDzKQNyMLDjOC8CBQ2ov45lq3Js6nht9gyEhYGLsp?=
 =?us-ascii?Q?b6nJwy6bJAJEB62/gqO6us1myxsxXaPXwfjH4VE8dzLe/J/ZwuYGdrpT8fZe?=
 =?us-ascii?Q?uJWHjgiO8q+4jztmQiGc/2ntMsLoZ4rmGc2hYZTNBvI/+n6j/PfmeTqt30hS?=
 =?us-ascii?Q?FVDEvWEq/lpPXVnfe+rcRvzpf3/+awfQoanLaic5tkf9HHcozxNFcDUxpjhU?=
 =?us-ascii?Q?su8QoXscCrekPwuP2GOpOTAZmWUlxvohPVQHQTnb9QhpoKN62vDC8NsvxHMU?=
 =?us-ascii?Q?zn83k4KhEOTmogwyt8kd7wlnMrRzCXjnkwjNwemrI6bxa8yuj9pCqUpimtJk?=
 =?us-ascii?Q?P3t1ysyWRmQQ8IB9iDcxkJa+T6UYjBB09MqloVzvPSLvNgx+yIbHDwmAdbbA?=
 =?us-ascii?Q?/oaYe3CgyH2BH2dCr4HqK/FA8JlfmS0iQLeAfWJBVc5aFVEM0ef10FwKJOlz?=
 =?us-ascii?Q?SBwludqMlE9fSZjIXIT2I5rQRR0uLFmNKnRLtmaBmTW0eyIe3j8zXQ6GqNrP?=
 =?us-ascii?Q?5KQXJNPfnfIdWsIFwRpc8Psfr761YxZwP9hFbi6yxobR3aBcMKkC3rtadbyj?=
 =?us-ascii?Q?FnYAoiSSEg1OwI4A1UGFqDp2FQph2akI3FaCExPMweyWcLnP21ViJLvBXa1C?=
 =?us-ascii?Q?+g2k5rqd3Het9djfe1lUpycbtqkT+XrBoAtjRalEkGusfPPrCdWcR967LYG2?=
 =?us-ascii?Q?MWBlYfyPtMOFplforw7Uc17WHuHtQXcVKi78sGFfZT6QWyYemJwdiH+i820e?=
 =?us-ascii?Q?WNmhJtm9K1h9o6UHqiEY4pHY4F6SXeBMTooVBS6vQDvXxgqv6mlK0ERTX7xE?=
 =?us-ascii?Q?8GkIoIAxOv59ZPAfFFysTrL9Aez2Ab49d+XAm/kwe1vMmdE10F66R0e7+cSy?=
 =?us-ascii?Q?/VIscQ5nlW4q2LJQaxYhmBDfZrMEKaUI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?keqp3h04bqOcZE7E0ZMQOM7YUBSFRN4n1aI/q536tf9mN5xDXHhntTi4oXBa?=
 =?us-ascii?Q?vlKvdSqw11unEIGm/MEIqG/f5IYea87/vFMlYT1VMi7xI9d5oesNVQW1070x?=
 =?us-ascii?Q?N2fLuHRzz2TVL3HIEeWchGI4wTLVt2oe4c+lAhIRb0T5kOKPsmDV9f3AB1D/?=
 =?us-ascii?Q?B0av7/xeRzCvAOmkPJw+PSzjJ4rmxsykTVFIMdsLfF0s/mXVviVk3XuTWIVg?=
 =?us-ascii?Q?/sQ/MhIb4knn786d5NvpBB0o/l8QsqfnDG4fWld0s4tc4b+s5sw/aWnihFCx?=
 =?us-ascii?Q?Bi17iYSNyGXDV12POa/QWhLE9fFkIafMCmHFnSTS1L2n47Xf3A1Cwuj6ciZq?=
 =?us-ascii?Q?u5YLUZrKz1WeXrbsp8GpuiRLy0igGputZeloXuCGxR6qBpuxM6Gw0gzA6uqO?=
 =?us-ascii?Q?iSrr8+GzmTRTuJcIFBpg0BGqgD1C9bBTmI7WSJvx3LSI3vDvnccPGPX4s7Fo?=
 =?us-ascii?Q?+c0kzK+xiNbzudlebtAKRMahPfEE8jHBe4quZsMmSM0EY1e2yhTCJG3ebJVC?=
 =?us-ascii?Q?2dOsX7AtZ/QOZvZ1daZJ/mzMKFzpmL6vFc1s8qZHn2Mm/M11QgFGoHjR6Muj?=
 =?us-ascii?Q?VYkT3x6BfjMh5Pr2nOctm/LlEEuC6Qh/MPnej/9j4IZpgkXGsLpeWMsoMAFG?=
 =?us-ascii?Q?o5kk7e1msoj2qycVpu2oQ+tjpU9EQfbnhTuavf2QC6oJF0AS0OtUhZ0Jp2Yr?=
 =?us-ascii?Q?wrg/Ac+LWRbp2kOXpfkzIISU9XU9F7DWLY0bmlR7cMqhLlaZ5w8ZZTXlZDnZ?=
 =?us-ascii?Q?T0bxaz4E7Wtf+yYfeOpJTiLU2ZL4J+CKLgadsKF6+MfXsAm7Hb6e1MbkGRV7?=
 =?us-ascii?Q?mumz14ZEnrraPzFteQllgIBJtxNHe8oHWcHXbLDRZ/juKWNs7bQM6vCvUcn7?=
 =?us-ascii?Q?dND8PylMP/zClIg6vy1fRxN1+rrEsqpvmLvigsvsanLMIkleJ1D9O44sA7BZ?=
 =?us-ascii?Q?KzhBjT9D+gZ+Tq0So9h7y7J2go0IZPJ+gyutPuVeslG06U6q5X2mKAOcu1d0?=
 =?us-ascii?Q?e4/qvQxhCjTcQaMBXQU96jDri3IEODtQ0kX3MwY6fS6FuNwofJ/dwPUm33I0?=
 =?us-ascii?Q?EuyCM8EHyFe/Dlxz1V+PGbDpLykfHjYfma/OeCRmaoLEwpZw/b1F0dVCR8Ka?=
 =?us-ascii?Q?/vBy7o7nKL8KnGwfpluDIj9Owoq/G9Oa3Z+OSFQakOY3huT64NXpzafnUk7J?=
 =?us-ascii?Q?fHY1qlqz53s3f5prDU/rSdG+kXhdisf1ok4IxOdgJZ8ROz7QA2/0Q6jO42NE?=
 =?us-ascii?Q?HZ7e5ixYmLvKSSV+6rsM0IXtrGazN/N9PehsSbeSUcU9xa0ln1K6HoBW85r9?=
 =?us-ascii?Q?ELcvsE1eVhoqPr5uknm9t1w04jUB2ge3HpXT7IIXmc5o1wgbKhz1LcH2vkK+?=
 =?us-ascii?Q?KGBMYtWaZrSVHRu24fYj2BLTbgPO6ZC/sN3r5QiRRWNknBMYpol7+gijUmZM?=
 =?us-ascii?Q?Sd3dH2qunNz9eJywuQVK9w7H21fIF3OZpJXjVy4NnkPG5h4FMfL4gsetU0Wr?=
 =?us-ascii?Q?3MTbn9btxABwwm1qn5pl9Fq08PiEl02Uluxh/LGZpl2NJT4mza3kZ3XwhQ6w?=
 =?us-ascii?Q?y2VO+ENYqEmocAWMim8iuJKycy1SJwnqNfPEetAw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a2b775-5221-4af1-4bb8-08de0121b1ec
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 19:35:36.5687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyc7SKObkihj7ML2nJ6DbyNBZ+eGfuVBEXqINXE3CDNeBU1FAVy9F1H0tLOx7NLG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645

--vlZd6WAu1ApJJAhr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Small update for fwctl.

There is a driver for broadcom ethernet on the list now that will
likely come in the next cycle.

Thanks,
Jason

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fwctl/fwctl.git tags/for-linus-fwctl

for you to fetch changes up to 479bec4cb39a1bfb2e5d3e3959d660f61399cad4:

  pds_fwctl: Replace kzalloc + copy_from_user with memdup_user in pdsfc_fw_rpc (2025-09-22 10:33:10 -0300)

----------------------------------------------------------------
fwctl 6.17 merge window rc pull request

- Fix mismtached kvalloc() kfree() on error paths

- Remove NOP dev_err_probe(), shouldn't print on error paths anyhow

- For mlx5 permit:
    MLX5_CMD_OP_MODIFY_CONG_STATUS
    MLX5_CMD_OP_QUERY_ADJACENT_FUNCTIONS_ID
    MLX5_CMD_OP_DELEGATE_VHCA_MANAGEMENT
    MLX5_CMD_OP_QUERY_DELEGATED_VHCA

- Use memdup_user in pds

----------------------------------------------------------------
Akhilesh Patil (1):
      fwctl/mlx5: Fix memory alloc/free in mlx5ctl_fw_rpc()

Avihai Horon (1):
      fwctl/mlx5: Allow MODIFY_CONG_STATUS command

Liao Yuanhong (1):
      pds_fwctl: Remove the use of dev_err_probe()

Saeed Mahameed (1):
      fwctl/mlx5: Add Adjacent function query commands and their scope

Thorsten Blum (1):
      pds_fwctl: Replace kzalloc + copy_from_user with memdup_user in pdsfc_fw_rpc

 drivers/fwctl/mlx5/main.c |  9 ++++++++-
 drivers/fwctl/pds/main.c  | 18 +++++-------------
 2 files changed, 13 insertions(+), 14 deletions(-)

--vlZd6WAu1ApJJAhr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCaN2ChQAKCRCFwuHvBreF
YcnWAP4305Gwco7bSC8AjPMzbIa0/R3pTSVsuCX4PEP40GCvvQD+OODvs35VCBRy
3qGWAu1jMKPCsMKZlpbSUopXdAjdFA4=
=xVlh
-----END PGP SIGNATURE-----

--vlZd6WAu1ApJJAhr--

