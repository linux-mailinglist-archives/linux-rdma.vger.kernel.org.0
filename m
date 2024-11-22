Return-Path: <linux-rdma+bounces-6079-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5219D643D
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 19:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F97161B63
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 18:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73921DEFF0;
	Fri, 22 Nov 2024 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HxqrFleI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C022FC23;
	Fri, 22 Nov 2024 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732300597; cv=fail; b=a9/Z2e72K4j5XPcEHBQHV9XTr7WuO9u82j0m6XYEtW/skGajeTaN4FKDpvFisqsRMfELN7qBCIiDe8fWSdb/ohtUs308ckTAJQkpIPO5CqHqtmUot3AgEiy5gffdxIAWOgUBI7rbbLpX5F4BOyHC/qvcL6fGd51i239vAX9EhRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732300597; c=relaxed/simple;
	bh=HGl9zLr8qRUKwr7LHDzYnzNw9ocjZV7WhN5wZL6G0hE=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=KrSneZNb/vueARNbVQp5dosALniUIazrIKZhaV608FGsv6xvxk4HTX6wvDcaG1kL7smTSbAFksMB6Jf/uWo3UjyOfETWgHW32Bd26aemMQ3IcakOAh8LJWxg4h/SQXfW+5SpoIZIDodNB5AKlM18JPKZJ1dQua9kx8fs69FyNog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HxqrFleI; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHEeB2pF8Kf2Ml2yULnLvwg7f8VhbVGpPlwXMH/CI4lmGqej4XNfjZK4IDv37nYKDgDot0OzKYm7q5g/uoeEsnwtS3QUyv0rKyjiZN8eN7CJxGT0zG7nka39l5npFadSi/9NXUEL9OC+4t8w9AHGfx+aClkhXvJ+SO30qHluCU7ArKEkXLFTmBR+mGSwPJElvGjoYVJQi2UEYATC9GYt3hTLw5hAKD+cxU9uPil4BFsZqpTC2h1KxssXDtUI1hiKeGlzpSYmYbgHKcV7Rv22nt4y8QN/6kCJx1ttYYFVz5bJGdqjlfa+oFm+HJAQyKDde25dJWP5rl2phdXXijP51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjkNAMrkomOD2cBc23326SJp8VGRLKHVn+VmIGlIUec=;
 b=pZ33rRX6iDW0bX9mk606zH4N+HLa9M290GPxTDK1VmLN4xLl0CNz8sZx3m2RP9koMRQivUKVO5PyTy8yzcKUpmlENozl/G8rb3jO3gR3QrO+7qHEo6L1/IDaq2NsKlcT3mZ9yu0AhjOBWh7+WxWTSNs8xQMVtheSL57wXnyVkt3+LWWifJX6kFX30NtEqIsBb/rW6d5osa7AgYMyQnraJRCL96UBzP8CxDVgnHDrkN1o74s+5yGrqnVjQGXQ7EK1qYxZVDdpVoos7Xp85x4fhOyoRbmphz2t3yvsp7vbyaATC65iTmxyd6DvCE84lrUIcE42funbrFkd1iBXhtwzdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjkNAMrkomOD2cBc23326SJp8VGRLKHVn+VmIGlIUec=;
 b=HxqrFleIbL1nbrp7in6j7t757zQNN+PXgfrucHlAjizqZq42YFxxRK1H+yzzFPQ7KFYF0XG2ERStiaPj3Smw5Ecnj7EyfU5khFGqEbKTCwK70QFv6C5bA1oPpNiXkZhF4s2vVdimheS92aUYPLvztAvLDYr0s26FeBMtDmikVCPsApSjAdDbypX6aZbvTyuuR7RFIVa/+6zr5Wax67Rn/fq0jhSv2t/NsyhIeby0iruvAdLwY61aH8AGOKLEbY0tvSRH5MN7H6dzGw8Hv3SNyg+TlTshTRYpdi8bGO2Vkpn7hoASWri970jLaIPe/f1/dyRs+AOd8vozjQcmMM7crw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB8942.namprd12.prod.outlook.com (2603:10b6:a03:53b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 18:36:30 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8158.019; Fri, 22 Nov 2024
 18:36:30 +0000
Date: Fri, 22 Nov 2024 14:36:28 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20241122183628.GA1102912@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2oKeXBWRiAqedICB"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR01CA0025.prod.exchangelabs.com (2603:10b6:208:10c::38)
 To CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e8b691-3f0c-4c5f-3da5-08dd0b2494af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BePv7E60Nqk+kIKIN2Tr/ZlqqRxo7Qq05rxtfLmBCvxAWP6nfOFKV/WKEbx1?=
 =?us-ascii?Q?ZXaWuFpqw8y5bkuxNNHpMO9nV01KYxnjtkDpQwOKNOgeEYBdxt/GpPEbLGk7?=
 =?us-ascii?Q?+13apC9B1FtUFKxUWadyJr8AS4nKnHy0z3KejtSWzyUD57jYcUcxixLI4vEZ?=
 =?us-ascii?Q?hPt/mAYus/SLiugHFxZgKZI6v+QILk/Qm96tiL2UNb02jvtj/iFjjh5NCs0w?=
 =?us-ascii?Q?m+zB6YIvoctvTUAlVbwY8Moj0HR9oiiY1vEiXB6cUvqfvZSZ+5DTKRwqLcx9?=
 =?us-ascii?Q?wAMOHdsD4t5fSFlyzmHSw9rQaxqkGOVWRBhAphPvQkfw9z4a35mamCLnXU+A?=
 =?us-ascii?Q?KJU8QmSIIrbM3ipRw7eVlv0UAp4W1YeoC1UBlfo8EtIBNQz10TVuqEEv1cUm?=
 =?us-ascii?Q?wE6qRWN4Kz5/Zgliw/fiQbZK7A/MDuScFMFw+YQ1twAsvF0RnQQ8yk5WhZID?=
 =?us-ascii?Q?B4+YRTAUR0MSKu2kSKvj2kwIWy/4i2dpaGPIwLqekGJbB+sl6LtbQhEyQ9I4?=
 =?us-ascii?Q?HtyZ23aPGEgjXY+SNUdgn6d+RxZeLWi+yySTMVNieahG+VMF9WLmC2wZwLqf?=
 =?us-ascii?Q?/qKIGa0GuPtelvn7rlW/UqZV0+56U7KPA0D2TMmvxiy2wru+yRyav1VZjgEo?=
 =?us-ascii?Q?+QDsATY7nkoCawbM9SUuRugCqavvzFRIbVLON/eMSpCOUsM3mndH8YhAcD0X?=
 =?us-ascii?Q?dPj0LCi2hncjLwocmYxdQ9L4xMG4RgVT78FJkyR4UqZIdK8pBlkuAxVgazb6?=
 =?us-ascii?Q?KS5p13R12XrSrfRrBeUi/b9ObLk8CbQR9qpM4F+k078zWre5MnFutzChjmRX?=
 =?us-ascii?Q?j3SqcVK8DjFM+JXxpO4cP+HFi8No3sOdlqt01fE6JEwg6VWiYXRwiDGTo5cW?=
 =?us-ascii?Q?jCw6Wv8Hx5SthNrtTp86ThEoUfUh7hA7RADpnB2p+M90m/nLfAEv1RmqQ8wi?=
 =?us-ascii?Q?yS0Z7EhZoXZQudYCmtuM2VczDYfUsU0E06ldcsVneD2yDccsXuLtX4tAgLBj?=
 =?us-ascii?Q?q0rRMz6FM1mDoD2mt1r3WLFaNveWbsSEtg34rP1/ql2bzutbP/m4pnzoLKbv?=
 =?us-ascii?Q?BTGolfv40Uy+x8ZtPxdQLSp9yVhuQAVhYcDgHhfgsJcmKTEFPVefilpRlH3P?=
 =?us-ascii?Q?1eCynZr642uPnT5t6MuNyMJ/JgaBqKMDnp2+R53l73MGvy2/B66Mwp4bVv4d?=
 =?us-ascii?Q?d+rJKuApWBaocY3OrlVLOM/UnNuzNJtfiX6e4wqPjOq/qFpu9VlEUZ0U5u/i?=
 =?us-ascii?Q?egDt5oFsXK3+W9kobP+icJ0PAsQBp3F/d71PAilsZQEZVEtn40bIjOu2/qNv?=
 =?us-ascii?Q?ZEp0hvNhFo6U29j9a9BbEj5MK/J+NDeRni/VuN6g7NhTpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q80/WuQm6iGpFzKDvXVTzLBbL2Qb9yytymSDV5YE7C8ZA6S083ZzqygnKpTA?=
 =?us-ascii?Q?M4ANIE7xwChFdFVPd/zsNOV6ZPE/DbZcAw5R9SncsFeyQnfPb7C5pm4OSFWT?=
 =?us-ascii?Q?CpHmKfKL/VCM2PqVaFd3Mn4x4Zc4WyrlD6YI+nrzHNYlAaG93dd0pURMq3hG?=
 =?us-ascii?Q?YuviNz/KqObGdYdy8ECXjuLxhnb4h/WZkJl5htS6HqUDTx0acA41ukMkL1Yi?=
 =?us-ascii?Q?GCdwcDdO1beVT4a8kd4/BzYynX52hAjsFljOy/wa2JZC2+LEtyAhH7ZpVBhQ?=
 =?us-ascii?Q?05ymlPdpXhMXTdy7DUHwkQz90SB1zseR+xUYrlCRYYyAggzgbA2SicjpP64f?=
 =?us-ascii?Q?W0EiTn/lDGvjduBiHeq8ETTthxkOvfDq+Xw+J5dUd8NO3zH83deYRJoaIA5U?=
 =?us-ascii?Q?yTXWSL0oDD1O2g5eM+BRTu6m6lJjdJkwDt76HzgfPKZRGRODvE+h6aVJfGFA?=
 =?us-ascii?Q?acZCP+LB3rbHjEaG2fWNeB8vKXXYM5/EMUFLfTNLVWa/Noo1e+AkHaZyXZsO?=
 =?us-ascii?Q?+JJU3qAVWrXepvwtzASR12pnmMJhl+SWUVRSpgJs0N0a8TfTr7fpzMQZvD2U?=
 =?us-ascii?Q?Fk1vqR+v8QkIV0cLQmQo85GnmVWI7ec6Id8yF7YjYk4HOpa7SLxF5b1g0WlT?=
 =?us-ascii?Q?4DFQIatCKRvktzdS5EcyvUokoUjrxCTAh2r0VRLtqc1VWYQWVJC/xzAb2IeD?=
 =?us-ascii?Q?N4qicBOaGJJVrXv+Im0RTbeYVO8YsaxZRAN69dzM8ORfQEOtdBU7ReE6pqw7?=
 =?us-ascii?Q?w7Mfmn7rxKiYD8Rm+6Ndpn6Tmxe6BxOsExv5beUvZFhmRq0OgI3qn5tOjTmu?=
 =?us-ascii?Q?8ciVkwRjMvpIC6kWKC8tJKE5wfV5ZgJPKEQUsKn4D/RG32OFb6LGEqCqT4qY?=
 =?us-ascii?Q?cIcGzpScYmHK/RpjA5xoPt7+zDihLMipsbeVd1kO0khdTnAO1Cw1MX/Gs9lI?=
 =?us-ascii?Q?B4zz6qDltOKRL5kZPkTvAEdcxYNSwh1pUzwEgMtHHs0fW8t6vMPCUCEpmvys?=
 =?us-ascii?Q?5ow4xL714D4fQm1fTIREW8daIupY8jDhyhvNXG8g2w6bK9xiptR9qgJ+1Uk6?=
 =?us-ascii?Q?9FqVtLwKVRVCUw4BlBXsPl7+UyUVKu16Yd7ptfk5E8W8FDjyd5JsogYcEq7V?=
 =?us-ascii?Q?qIWqZhndEZyQRW/ibgXqJegatSkrrlkYi1bLTaztSxAZT8TnTjnuxONv+9rI?=
 =?us-ascii?Q?zHWW0O70+R1GESvX1anLQBWn08bF4DPewJmF2IFMXoAXmESpC/urc9uRLB0P?=
 =?us-ascii?Q?y6kdWdRBV6c2GE8fkBEgKPkFlW/VlxE3HhUFq24D9xxnSX7FYxKN+YvMo0Kv?=
 =?us-ascii?Q?CW8eMEo+yQu9R/SrBf5glzrB90yx/2Yd477e9s73sFYpaxGxmr4AUNy9U9rE?=
 =?us-ascii?Q?QRdrKQyFDndQXGVocV0cUQK3odG+Hrj3CZFZs+AhNKXoGCrDyj5p4eBayoOD?=
 =?us-ascii?Q?BS9LXd9G8qJxEC0hl0EpI7CFXYbUHZ1EhXgGJiOManyooNDkN7RrObMjbkxR?=
 =?us-ascii?Q?Jh9kRMPMpuetFUVA1qYf++TPPW/3VF+FxlhOniL964GrWukJqb2yyq6YQH3z?=
 =?us-ascii?Q?O/ezDhKqf0iAtjKFLx4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e8b691-3f0c-4c5f-3da5-08dd0b2494af
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 18:36:30.0583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63viJuSuslMUlzUCq2dQ7S5No+GVeubBlsvRJO6dfBSAq8hM+EBD9o9DIUbgSUr0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8942

--2oKeXBWRiAqedICB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Usual spattering of patches this cycle

Thanks,
Jason

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 68b3bca2df00f0a63f0aa2db2b2adc795665229e:

  RDMA/bnxt_re: Correct the sequence of device suspend (2024-11-17 04:56:39 -0500)

----------------------------------------------------------------
RDMA v6.13 merge window pull request

Seveal fixes scattered across the drivers and a few new features:

- Minor updates and bug fixes to hfi1, efa, iopob, bnxt, hns

- Force disassociate the userspace FD when hns does an async reset

- bnxt new features for optimized modify QP to skip certain stayes, CQ
  coalescing, better debug dumping

- mlx5 new data placement ordering feature

- Faster destruction of mlx5 devx HW objects

- Improvements to RDMA CM mad handling

----------------------------------------------------------------
Bhargava Chenna Marreddy (1):
      RDMA/bnxt_re: Enhance RoCE SRIOV resource configuration design

Chandramohan Akula (2):
      RDMA/bnxt_re: Add support for CQ rx coalescing
      RDMA/bnxt_re: Support different traffic class

Chengchang Tang (2):
      RDMA/core: Provide rdma_user_mmap_disassociate() to disassociate mmap pages
      RDMA/hns: Disassociate mmap pages for all uctx when HW is being reset

Chiara Meiohas (4):
      RDMA/mlx5: Call dev_put() after the blocking notifier
      RDMA/core: Implement RoCE GID port rescan and export delete function
      RDMA/mlx5: Ensure active slave attachment to the bond IB device
      RDMA/nldev: Add IB device and net device rename events

Dr. David Alan Gilbert (1):
      IB/hfi1: make clear_all_interrupts static

Edward Srouji (2):
      net/mlx5: Introduce data placement ordering bits
      RDMA/mlx5: Support OOO RX WQE consumption

Feng Fang (1):
      RDMA/hns: Fix different dgids mapping to the same dip_idx

Gal Pressman (1):
      RDMA/ipoib: Use the networking stack default for txqueuelen

Hongguang Gao (1):
      RDMA/bnxt_re: Fix access flags for MR and QP modify

Junxian Huang (3):
      RDMA/hns: Use dev_* printings in hem code instead of ibdev_*
      RDMA/hns: Fix out-of-order issue of requester when setting FENCE
      RDMA/hns: Fix NULL pointer derefernce in hns_roce_map_mr_sg()

Kalesh AP (10):
      RDMA/bnxt_re: Add support for optimized modify QP
      RDMA/bnxt_re: Add support for modify_device hook
      RDMA/bnxt_re: Add debugfs hook in the driver
      RDMA/bnxt_re: Add set_func_resources support for P5/P7 adapters
      RDMA/bnxt_re: Fail probe early when not enough MSI-x vectors are reserved
      RDMA/bnxt_re: Refactor NQ allocation
      RDMA/bnxt_re: Refurbish CQ to NQ hash calculation
      RDMA/bnxt_re: Cache MSIx info to a local structure
      RDMA/bnxt_re: Use the default mode of congestion control
      RDMA/bnxt_re: Correct the sequence of device suspend

Kashyap Desai (4):
      RDMA/bnxt_re: Check cqe flags to know imm_data vs inv_irkey
      RDMA/bnxt_re: Support driver specific data collection using rdma tool
      RDMA/bnxt_re: Add support for querying HW contexts
      RDMA/bnxt_re: Support raw data query for each resources

Leon Romanovsky (1):
      Introduce mlx5 data direct placement (DDP)

Liu Jian (1):
      RDMA/rxe: Set queue pair cur_qp_state when being queried

Mark Zhang (1):
      RDMA/mlx5: Support querying per-plane IB PortCounters

Michael Margolin (3):
      RDMA/efa: Update device interface
      RDMA/efa: Add option to set QP service level on create
      RDMA/efa: Report link speed according to device attributes

Patrisious Haddad (4):
      RDMA/core: Add device ufile cleanup operation
      RDMA/core: Move ib_uverbs_file struct to uverbs_types.h
      RDMA/mlx5: Add implementation for ufile_hw_cleanup device operation
      RDMA/mlx5: Move events notifier registration to be after device registration

Rosen Penev (1):
      RDMA: Use ethtool string helpers

Sean Hefty (3):
      IB/cm: Explicitly mark if a response MAD is a retransmission
      IB/cm: Do not hold reference on cm_id unless needed
      IB/cm: Rework sending DREQ when destroying a cm_id

Vikas Gupta (1):
      bnxt_en: Add support for RoCE sriov configuration

Yuyu Li (1):
      RDMA/hns: Modify debugfs name

Zhu Yanjun (1):
      RDMA/rxe: Fix the qp flush warnings in req

wenglianfa (3):
      RDMA/hns: Fix an AEQE overflow error caused by untimely update of eq_db_ci
      RDMA/hns: Fix flush cqe error when racing with destroy qp
      RDMA/hns: Fix cpu stuck caused by printings during reset

 drivers/infiniband/core/cm.c                       | 170 ++++----
 drivers/infiniband/core/device.c                   |  39 ++
 drivers/infiniband/core/nldev.c                    |  40 +-
 drivers/infiniband/core/rdma_core.c                |  12 +-
 drivers/infiniband/core/roce_gid_mgmt.c            |  30 +-
 drivers/infiniband/core/uverbs.h                   |  29 --
 drivers/infiniband/core/uverbs_main.c              |  43 +-
 drivers/infiniband/hw/bnxt_re/Makefile             |   3 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h            |  47 ++-
 drivers/infiniband/hw/bnxt_re/debugfs.c            | 138 +++++++
 drivers/infiniband/hw/bnxt_re/debugfs.h            |  21 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           | 130 ++++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.h           |   4 +
 drivers/infiniband/hw/bnxt_re/main.c               | 453 +++++++++++++++++----
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  73 +++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h           |  23 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |  19 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h         |   2 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h          |  13 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |  35 ++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h           |   2 +
 drivers/infiniband/hw/bnxt_re/roce_hsi.h           |  57 ++-
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h    |  63 ++-
 drivers/infiniband/hw/efa/efa_admin_defs.h         |   4 +-
 drivers/infiniband/hw/efa/efa_com_cmd.c            |   6 +-
 drivers/infiniband/hw/efa/efa_com_cmd.h            |   4 +-
 drivers/infiniband/hw/efa/efa_io_defs.h            | 106 ++++-
 drivers/infiniband/hw/efa/efa_verbs.c              |  51 ++-
 drivers/infiniband/hw/hfi1/chip.c                  |   2 +-
 drivers/infiniband/hw/hfi1/chip.h                  |   1 -
 drivers/infiniband/hw/hns/hns_roce_cq.c            |   4 +-
 drivers/infiniband/hw/hns/hns_roce_debugfs.c       |   3 +-
 drivers/infiniband/hw/hns/hns_roce_device.h        |  14 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c           |  48 +--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         | 257 +++++++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |   8 +-
 drivers/infiniband/hw/hns/hns_roce_main.c          |   7 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c            |  11 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |  77 ++--
 drivers/infiniband/hw/hns/hns_roce_srq.c           |   4 +-
 drivers/infiniband/hw/mlx5/devx.c                  |  93 ++++-
 drivers/infiniband/hw/mlx5/devx.h                  |   4 +
 drivers/infiniband/hw/mlx5/mad.c                   |   8 +-
 drivers/infiniband/hw/mlx5/main.c                  |  78 ++--
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |   3 +-
 drivers/infiniband/hw/mlx5/qp.c                    |  51 ++-
 drivers/infiniband/sw/rxe/rxe_qp.c                 |   1 +
 drivers/infiniband/sw/rxe/rxe_req.c                |   6 +-
 drivers/infiniband/ulp/ipoib/ipoib_ethtool.c       |   9 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |   3 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   6 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   6 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c    |  53 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h      |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |  12 +
 include/linux/mlx5/mlx5_ifc.h                      |  23 +-
 include/rdma/ib_verbs.h                            |  17 +
 include/rdma/uverbs_types.h                        |  33 ++
 include/uapi/rdma/efa-abi.h                        |   3 +-
 include/uapi/rdma/mlx5-abi.h                       |   5 +
 include/uapi/rdma/rdma_netlink.h                   |   2 +
 63 files changed, 1977 insertions(+), 499 deletions(-)
 create mode 100644 drivers/infiniband/hw/bnxt_re/debugfs.c
 create mode 100644 drivers/infiniband/hw/bnxt_re/debugfs.h

--2oKeXBWRiAqedICB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZ0DPKgAKCRCFwuHvBreF
YSH8AP9/pufz43bJ3uyVTk0IkwhdQqtfQ6vCIO+4tbpFOKUcBgEA3+N8SMa7t414
ycHVhwWHlLv6d9zGegTXhpc7/4HeHwA=
=11XT
-----END PGP SIGNATURE-----

--2oKeXBWRiAqedICB--

