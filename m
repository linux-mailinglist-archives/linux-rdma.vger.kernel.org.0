Return-Path: <linux-rdma+bounces-6792-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E75F9A00A76
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 15:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12AAF188221B
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 14:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D88D1EE7BA;
	Fri,  3 Jan 2025 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tztr68mz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8361494B2;
	Fri,  3 Jan 2025 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735914262; cv=fail; b=YSyGkjhIBg3tc0W6YSBYqvodt+arb0F1hPvmKyfrNrRak89csUx6dFXsCUFU7gHnDO7eKvT2cFPzlp5fQklhG23zozHZr+V8qfGSnrg68y3q9l+8M5NqH6Xais2IaA8QoXICg7RDb6Itmum/L1gZl6m6KJJxLvsuguuW1dvm+Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735914262; c=relaxed/simple;
	bh=v79+/StkdccaQ2YV32fNAOOc2Z01V9rtuBHDPkRJ7eM=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=uS5r29lV4G6NwBu6y7S1loJUi7DoZvm9WLJhGWYGfSXz1uxgeVtfQ8h57MKNk5ZRSJN1KfS3LxEx0P0s6JNgjeZQAX6GE3Cw9QYfzDXg1E+4PgE415JPNLPC5v+TO2yenYpX63EEGvYv8JM93nHB5RDJYoXPj0GpWHeF4IoxDo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tztr68mz; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLeTrGZ8f8ylEmfcL6qDNJJDFR3qx2h1SePqY6yZ5ub3gxr0RnFvPLZQZF5RBHkyDKHJe3QHuTT71DXR+zzKwOcfRb3xDm8x7e8f/ow/azmgZbg9lEcSfgQRLDXyHg2QATom3c1blKst5UCtdv10tz4wIdrb3XptKvxDXP6qL5kd/0r0bHsrQ6OtRKlKxacg7f3lWU2Mcg4Voratn1c24ZYviYBh+iHRSWU4Qnh4UfUPz3GBuxpM9tzF9MVTwsH5a24cLNecWNkOCLKmTP0ajwgJ7YKt3N/o0B9OBwMnHwvN1Qfz9BMYIYxE9Ddvm/N3OpLUiRefXKGUftROcJ0UbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APSCZecgqzCmJI/hWmH1HRKYMxoc8wiTWbYi6XGaFVE=;
 b=V2wXoNGvvyoEFvsbz1t1H1qGQK5tr9qldW3ixetseLSE0+bN7ECHwSM+VdB/KGh/IyQgJXs18xfnVyoM5NH+8LkuCnxGBTMFKUXXqjsORtEg0UXi+5ROcoSOvZATEhlVPCQSI5pRnArHzAaz5cE/sGIwEueuOt4Ifj2IxVVm4G9/wvUIZeyCwF2U7BS/ETnImZduscxhY1v87JaHYHwKLQzRC7NoCkDJ/JuNvrQ++EFVRQtV/ecZ44RJ1JlYZVIdurjf2p+QJXpwNh97hG6vnurrtSXOFkK+Lc7NWiXOqGB3BBo5P6Hj0S+md30IhBEMN1sgCMi3q3+PhC8e8LgU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APSCZecgqzCmJI/hWmH1HRKYMxoc8wiTWbYi6XGaFVE=;
 b=tztr68mzSxnvkBVQv02bYyH8AQ5Vx5mMSmCyX53S0NjzCUKDyeDeolBeQ5bY1Gy+2YLMJHjdlF9iV4dMUkPlU+1eu7/ZqVLZOWQ9Sr+u+RTqJwjQjStb9uahYsTkRhWTtpCEsMlAJBCror2KhnStR29oJU+W4wxqHK7uJk2HfMW+Y10/rs3D5ZdOMJ1Sx2ESMwsbv1IYm3P47zJ+6HYiW9FjlOmai+ildUpIBf7znugnvrzBQfX3GZfoJli7525OuTfqcbfgYGdqrej94SAvtZKSaQo0uvGMgOJYcuP2QmuRVysYSN5pEKdZvh9Om2vCDvLL4ymGdGSH4ZmjCpud7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 14:24:13 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 14:24:13 +0000
Date: Fri, 3 Jan 2025 10:24:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20250103142412.GA170790@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W5bV9QAzMP8JvH2C"
Content-Disposition: inline
X-ClientProxiedBy: BN9PR03CA0665.namprd03.prod.outlook.com
 (2603:10b6:408:10e::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b67cc2d-8dec-4d2e-61b1-08dd2c024c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LMZm96xTRC3HtKN0f1kOA5iASN5GtVkxuGvcsz/q8B2eSHgjteE5RDOdpGyH?=
 =?us-ascii?Q?/RMBfpL0px8c0O0nkMe3gEYmqzvOl9VaEk1KJakOuXcVHRBHhW/whE3Wi1Ku?=
 =?us-ascii?Q?yadml9jWoqCVvVwgxJAhCeTPa/L1odz50k71KPH1doukoKgF02Fvit3PhKey?=
 =?us-ascii?Q?xfEXf25Og5VUPZziIGkx9KfBBpAORUDg5wOwD51RmKq9UGKj37PoZRlVOdZQ?=
 =?us-ascii?Q?APhJNB2gFBPj9yfd4syuj699vvHm0i9qgXGGgWcemnxIDn+4BvPzhFTNeGRh?=
 =?us-ascii?Q?i12EtMal+Y0MreAJV6PYpJAOL0F44gNI2Rll4itcYbPliYr8tbE90V3D2/qL?=
 =?us-ascii?Q?StnvrPgtFmwCqxVqAGIa8KVm9PMOAbEF9zhNlMCrsaHMuwQyoyDLesRfvYBW?=
 =?us-ascii?Q?ktUUcYu/x6Tghg6rLLaOy7BkiVVyrA7pEUMFMX4eQE9hBOrfVWrwtvMu/d8v?=
 =?us-ascii?Q?O/13MdorLSspfCkBFa+c+QH3CShQFoKj9HXs5bT/FiMDjjegLSDZOCMdN4Nf?=
 =?us-ascii?Q?QrRjKTcQW2ghqA3HehPS7g7DW96Mpp5zpbPYDMzL/oMBgVzTv/SkfI3znMDd?=
 =?us-ascii?Q?1cW5vRnWqFb3ZC1o6usKOTwEHqrMG6WV+2SWlh1Gou/+wbd3UDjz6/kKSZNX?=
 =?us-ascii?Q?FC5AQ46PrsgKpQNBING0lKFMtsiIDN5GPECl1e8S5ZmDnUgpINPi7c8yrGwV?=
 =?us-ascii?Q?Y24VUXDbQO1xx6mYibxA57SBgkyn7xstRbakj20zRGogOJ6GrAOoAR+Dh8Zm?=
 =?us-ascii?Q?hWwMixZnKcJtsv7V+5BsAcxTcQXDY8BfjEbpJVE0C/vpW/6MA5OfGg2sZMGv?=
 =?us-ascii?Q?GNhqrlbcREgvoQMDRNqebE13EihMnNakXP6Kg9i8Vik+T1gl0gDnzBIwHFwQ?=
 =?us-ascii?Q?0RJY2CGSGCPq6viBxTAFl3FJheFvyLd5SQukJQa/URU2cLM54lfYm5VowL+p?=
 =?us-ascii?Q?a5FyN23DxIcZnMl/QU2bhuM9PVsDYwGTU50Mgu3mRxp7EyfAAUcT0HKdbGpL?=
 =?us-ascii?Q?J3S+wSZvzPhrb9KRLKN2g9+gxAyHDdClh0VaM0+mRF0KXLwGZm5Fyg53eYBi?=
 =?us-ascii?Q?+zNcZlCAywe04N7SH8DAXPvn9Vln2AuDaIl58yK/SxYtxwVr9wjdcyQoyotm?=
 =?us-ascii?Q?BcD1K37FI0sEts5Tx9nhx3wi4mXkvd+F+mFAY6DrlCqRzxiEd2Cz18Gv3za1?=
 =?us-ascii?Q?fdGdb58P8k368avLYShRhvoXqkUVY1QfOdXaoLMq2PHLGs3rD3/TfpEeuMxU?=
 =?us-ascii?Q?aDjTC4MxlghS3Up4Rt519pmV+9qPnzorWGGpeWrpxPU+72i4U3YFgrqYx9xe?=
 =?us-ascii?Q?tV7LRcBO3+x11IkvC6+3Jqc6Z2ORUGL4TKkaXEvoDuP7W9I/tTEk6tptk8cC?=
 =?us-ascii?Q?9j1MtXbIGrotARAYqU5ZnJ7UOX4K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YUq0ZGd7EV8DrFZligdlquV0r2X9O88xXLYFZ5EvQitItv1kf6nOz/NGRiEC?=
 =?us-ascii?Q?wT8aMv8YqEMMY5eyBfT6x3VTLbeqK2iT1k0Eh8IYkjYQIwLDMk9d95UxBjsy?=
 =?us-ascii?Q?xCDspG8ce0+0c2EHEeL9iCqz8pIwbIaoaKpdM2oOIPXwL3Bkm36Ndf/dj7Ep?=
 =?us-ascii?Q?t/f3Ob3eW79jH95Fh/uerIegLBM8Oj/Q7yWfmeOkcueDrS6wFrH3QlEyD4vs?=
 =?us-ascii?Q?nF2F5BO0LpGuIa7MlAaBSMWe5v9FZ5sonTWfjz3TojRtXZtGgucZLMEIERGT?=
 =?us-ascii?Q?0oJmnBPIP6iHHeuiCYfVXtsHpI3cL3mlirbnMg+mK9howRXAfKfOIMBZYagJ?=
 =?us-ascii?Q?IxBHWSIeouwWZQwXzr1wwF8AOJvTn0Z3iX9LIpJghUTuUGM7i9SrTnOWaKD5?=
 =?us-ascii?Q?XyDNVtkzQ0/AoWvujv379wX1NUlpxhoV95eZIt7LnnB8RBujUOsLt8qtULNa?=
 =?us-ascii?Q?hsOCK+Y4doe2QjfwQyOOPEpTD7KygzMgcqHakwFvID28mFa8DKOL6C3h4aAJ?=
 =?us-ascii?Q?QZoFFfP3gpmlwtsUG3Adrl1/Dv9cvoR1IQb4j10xxcpyh8+pcdGj8qkUTWtw?=
 =?us-ascii?Q?8/oNUePAX+uJjwd4u1nDc9oBIkk8ZUGsUec4f1wlPh60XXW5UgkKY4NJ4+ub?=
 =?us-ascii?Q?QEn4QBzLym2HeBZWqb8rSTnCfFk6bk3+OjP/f9ER2ZR9NfXhaenP9GiVVugY?=
 =?us-ascii?Q?3/lsHBC0pVL7gQiKCmd21o5Zr8ItCedj+J+pKRHUVERkA0XOFxuCjEdu0p/h?=
 =?us-ascii?Q?EKgPHy1GBn1EEZXdCPLOhGe2GWWdJPmOn5DKPdnJ1AHjjPFHHSCD8oOsxdX4?=
 =?us-ascii?Q?3GkJ7+yHWKlGFUsJTUkBhSZCsdHL6FerA88l2aFV1hCazA+zUfnDi73gTwOn?=
 =?us-ascii?Q?4SsSCwlzMWS0xFOLIWQC5YEbHwfCS0/FLBOzsWKG1A1logKkNGxBdf4qQbyA?=
 =?us-ascii?Q?r82f8zht1eldZaVsFTyH8ll5jRMArXX8jt6cfBN5vEnboPfGBBVIVRKXdMQ8?=
 =?us-ascii?Q?qO0pP3XTWincEeoeeSVNi3Fqn4v/XXlwRSYqux3IqYw0B9EY0X2mVzvMiQXz?=
 =?us-ascii?Q?cnO0+RnhMDcbWDd7AQoAO6jXzvCyQatt8mJ48Zl1cY/Sh5iNGaHvaq5pET2/?=
 =?us-ascii?Q?FspkK8fckueZyqDEIRoOjzju3wN5MxWvB+o4Ty9tRA46kFDocvOuDoB/XSEQ?=
 =?us-ascii?Q?RUbgrAzHC1CTNUwDcQxXqNPy2//H1XceQApwI5unRrek9r4btwqGdVYUV827?=
 =?us-ascii?Q?Dw2bJQaEM6D+vpihUvsiXhVntkuuPWUeqgpss0bN5CzTDWZ0NQDdgs2O+BX3?=
 =?us-ascii?Q?y/nDgwbkZcFJxoLTlw4PZu8MlMR/a2oCw6JqVft9vkMb3MxW4dBIbaAhjDuz?=
 =?us-ascii?Q?cpHyabkm1gHT6c6kZGOcK5uakffFarkihgTQR+BXIA1z7h/BMnqWgrWoB1Lt?=
 =?us-ascii?Q?yuh17ZMgIVBzh9yxbTgQ4c9exuTZLEkcrLXYCZFNNp02XPtNF8SCj5DdlIlx?=
 =?us-ascii?Q?c+bjlCIscI9lThJxOEjTq72qCZZE4BqSgT30StfeRIX6dvzM9+A794GmN6YP?=
 =?us-ascii?Q?BKQsnCxTrbEhaLhzinTv7twg0Zi21SlhF8AKKPCz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b67cc2d-8dec-4d2e-61b1-08dd2c024c21
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 14:24:13.6749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDLqFArZR6I29OYnZi0rFPbfsZysE7Iy14jWSR/WaVClePXSpiGJuPyOWCBlAH1F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267

--W5bV9QAzMP8JvH2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Somewhat larger batch of fixes as I was away the last few weeks.

Thanks,
Jason

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 45d339fefaa3dcd237038769e0d34584fb867390:

  RDMA/mlx5: Enable multiplane mode only when it is supported (2025-01-03 09:17:19 -0400)

----------------------------------------------------------------
RDMA v6.13 first rc pull request

Alot of fixes accumulated over the holiday break:

- Static tool fixes, value is already proven to be NULL, possible integer
  overflow

- Many bnxt_re fixes:
  * Crashes due to a mismatch in the maximum SGE list size
  * Don't waste memory for user QPs by creating kernel-only structures
  * Fix compatability issues with older HW in some of the new HW features
    recently introduced: RTS->RTS feature, work around 9096
  * Do not allow destroy_qp to fail
  * Validate QP MTU against device limits
  * Add missing validation on madatory QP attributes for RTR->RTS
  * Report port_num in query_qp as required by the spec
  * Fix creation of QPs of the maximum queue size, and in the variable mode
  * Allow all QPs to be used on newer HW by limiting a work around only to
    HW it affects
  * Use the correct MSN table size for variable mode QPs
  * Add missing locking in create_qp() accessing the qp_tbl
  * Form WQE buffers correctly when some of the buffers are 0 hop
  * Don't crash on QP destroy if the userspace doesn't setup the dip_ctx
  * Add the missing QP flush handler call on the DWQE path to avoid
    hanging on error recovery
  * Consistently use ENXIO for return codes if the devices is fatally errored

- Try again to fix VLAN support on iwarp, previous fix was reverted due to
  breaking other cards

- Correct error path return code for rdma netlink events

- Remove the seperate net_device pointer in siw and rxe which syzkaller
  found a way to UAF

- Fix a UAF of a stack ib_sge in rtrs

- Fix a regression where old mlx5 devices and FW were wrongly activing
  new device features and failing

----------------------------------------------------------------
Anumula Murali Mohan Reddy (1):
      RDMA/core: Fix ENODEV error for iWARP test over vlan

Bernard Metzler (1):
      RDMA/siw: Remove direct link to net_device

Chengchang Tang (3):
      RDMA/hns: Fix accessing invalid dip_ctx during destroying QP
      RDMA/hns: Fix warning storm caused by invalid input in IO path
      RDMA/hns: Fix missing flush CQE for DWQE

Chiara Meiohas (1):
      RDMA/nldev: Set error code in rdma_nl_notify_event

Damodharam Ammepalli (3):
      RDMA/bnxt_re: Fix setting mandatory attributes for modify_qp
      RDMA/bnxt_re: Add send queue size check for variable wqe
      RDMA/bnxt_re: Fix MSN table size for variable wqe mode

Dan Carpenter (1):
      RDMA/uverbs: Prevent integer overflow issue

Hongguang Gao (1):
      RDMA/bnxt_re: Fix to export port num to ib_query_qp

Kalesh AP (5):
      RDMA/bnxt_re: Don't fail destroy QP and cleanup debugfs earlier
      RDMA/bnxt_re: Fix the check for 9060 condition
      RDMA/bnxt_re: Fix reporting hw_ver in query_device
      RDMA/bnxt_re: Disable use of reserved wqes
      RDMA/bnxt_re: Fix error recovery sequence

Kashyap Desai (2):
      RDMA/bnxt_re: Fix max SGEs for the Work Request
      RDMA/bnxt_re: Avoid sending the modify QP workaround for latest adapters

Leon Romanovsky (1):
      RDMA/bnxt_re: Remove always true dattr validity check

Li Zhijian (1):
      RDMA/rtrs: Ensure 'ib_sge list' is accessible

Mark Zhang (1):
      RDMA/mlx5: Enable multiplane mode only when it is supported

Patrisious Haddad (1):
      RDMA/mlx5: Enforce same type port association for multiport RoCE

Saravanan Vajravel (1):
      RDMA/bnxt_re: Add check for path mtu in modify_qp

Selvin Xavier (3):
      RDMA/bnxt_re: Avoid initializing the software queue for user queues
      RDMA/bnxt_re: Fix max_qp_wrs reported
      RDMA/bnxt_re: Fix the locking while accessing the QP table

Zhu Yanjun (1):
      RDMA/rxe: Remove the direct link to net_device

wenglianfa (1):
      RDMA/hns: Fix mapping error of zero-hop WQE buffer

 drivers/infiniband/core/cma.c              | 16 ++++++
 drivers/infiniband/core/nldev.c            |  2 +-
 drivers/infiniband/core/uverbs_cmd.c       | 16 +++---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c   | 50 +++++++++----------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h   |  4 ++
 drivers/infiniband/hw/bnxt_re/main.c       |  8 +--
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 79 +++++++++++++++++++-----------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h   |  4 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  5 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h  |  5 ++
 drivers/infiniband/hw/bnxt_re/qplib_sp.c   | 18 ++++---
 drivers/infiniband/hw/bnxt_re/roce_hsi.h   |  1 +
 drivers/infiniband/hw/hns/hns_roce_hem.c   | 43 ++++++++++------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 11 ++++-
 drivers/infiniband/hw/hns/hns_roce_mr.c    |  5 --
 drivers/infiniband/hw/mlx5/main.c          |  8 +--
 drivers/infiniband/sw/rxe/rxe.c            | 23 +++++++--
 drivers/infiniband/sw/rxe/rxe.h            |  3 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c      | 22 ++++++++-
 drivers/infiniband/sw/rxe/rxe_net.c        | 24 +++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.c      | 26 ++++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.h      | 11 +++--
 drivers/infiniband/sw/siw/siw.h            |  7 ++-
 drivers/infiniband/sw/siw/siw_cm.c         | 27 +++++++---
 drivers/infiniband/sw/siw/siw_main.c       | 15 +-----
 drivers/infiniband/sw/siw/siw_verbs.c      | 35 ++++++++-----
 drivers/infiniband/ulp/rtrs/rtrs-srv.c     |  2 +-
 include/linux/mlx5/driver.h                |  6 +++
 include/linux/mlx5/mlx5_ifc.h              |  4 +-
 29 files changed, 321 insertions(+), 159 deletions(-)

--W5bV9QAzMP8JvH2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZ3fzCwAKCRCFwuHvBreF
YUpHAP92g7vQ/Sx6zhCLFaLcXc51zcKaSvYz69/2Zv3AvmzVJQEAldSfbI8nC6JN
6iiGHnsZykaRe/5nUskHwDMSq+m9+QE=
=yyCp
-----END PGP SIGNATURE-----

--W5bV9QAzMP8JvH2C--

