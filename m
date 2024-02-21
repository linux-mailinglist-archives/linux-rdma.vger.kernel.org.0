Return-Path: <linux-rdma+bounces-1076-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C8B85CC92
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Feb 2024 01:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8FD4B2299B
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Feb 2024 00:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD8C386;
	Wed, 21 Feb 2024 00:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GDyBFVLV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DFF382;
	Wed, 21 Feb 2024 00:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708474368; cv=fail; b=dRUtPx9J0Uj1Mp1f7wFLSVEMmeEW6VWzyceXBvXXn40ntDTYSHNyg2HvG0GGFfPZIuuM8//mBp69BIO16BQ2Uuf2JcDKvdwyBWwHyHhWpgpTlzDbBD4Y5F2W/kE7RdTXkbPsCDdlNMf4p9AYxOtuZUwN4ZNFizXiMygdnaknWbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708474368; c=relaxed/simple;
	bh=d+k4WgsWy5s0/Hg1nDN3TYQDRurV4zpMDCGCHYH2Kck=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=myLqZEh4IBFwvkXknd5LZ5qvgCUPGIRnWByxZvoyBDflPIiK3qRvRak9dNAC/R3uZU0iOl6aVpG38M18pBRi6cAUA8ocAdP9jeTeqN8R+/3F3Ew980UMLMlwWEyTTMCxLqZlV3FraEkoQZfRvhb7dHA31B0dbP2hu65hVyxAfc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GDyBFVLV; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkhW++/4FbP9UYypSKvHQEuvz4OGszvV+PQmgGE6bUHBVgjJhadeinyVE0vNwWH9kvVzzGSm4uVDaPJmFONDbP3mqqGvJ2vVsWgm/cNRGThyJa+QjQzr6uXAl5qPCmEffUft38PzIZHqnmPEl4YSGt0/uvS7/fS33B0z4zcFI/7XVvk8o7pY6e5KaU9xprbtVFjzqZE58/IBXlkeuYVGlTM3NiW9seRBga5X+Wqcwm/4LElHkyfFN8fgtRDEFSCutLTlVn7VcNFxUhLVEvuKAYrZBavwZodu7QPQS4JtCKSTMW6NHF3zxhwynvzP7aCUbNlWW+XI9wfDWeiUxU+Rog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAIfU/s5ZI3CshWW6dQ7ksjmtCvGNye1DV6tmmS7grA=;
 b=AKXGVMNtsXcmnb+7xHHEkkPa/tTShON9RYXayRXCN1cBxMJhQSnyeyXlM01JJLWYyCXN5wSGuhZ8IKwLEdbeMZkBawhW1IuAg1/UDdMKHc3q9lK9RyAcYQwYNM3WsHknRt52rksVxpoISm6RtxYfEiPtGwV50RsGNCAmYiZxY71CbrBQjYHheUHK9di8Y3yappwLMfVq2K10/Fm85JkbKvWj7zYzMgxH0VRETJjhUBGrSzAiUOSNHlEvwJAuPgayY2uOrsBnZT5RzscblJPyziFYjcyzcmQlveJhCw3OBj2Gk4330rEILjr9wU3mmUOKjr1aL6mLBkdY1vT+5Dpbsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAIfU/s5ZI3CshWW6dQ7ksjmtCvGNye1DV6tmmS7grA=;
 b=GDyBFVLV/hMdx//6YVZjIAHh0RU5MYL+ZNQ/C3l11R7z0nMtdLx4+Rh2A/2vK7PgSlrmOgrvix94YpwF4Wi0FxZ0IFgfnqP9rity7ga6ZxQOolQPHR8AwMbMtioV40eKonVi8SsPvSQnjaByweY2hFME0SEjclrLfHKQG/aaQxzZpOWxY0mjDEtODmch5mKbPVuPcxBsZdcgMN186NKGLPYetnQkDsjQI8Or28rGGV0ImG9AVS7NzZggSTBr4hmoCL+08VPAsG+YYlen/Moj/o99PZzy1FNeu7HG2/e6zMm1GFZceX0RFSZicquENLRZRd/pqWLzg6VOI3uUB/QKOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Wed, 21 Feb
 2024 00:12:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 00:12:42 +0000
Date: Tue, 20 Feb 2024 20:12:41 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20240221001241.GA2081949@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mU+IiBB6J3anmRb6"
Content-Disposition: inline
X-ClientProxiedBy: BL1PR13CA0394.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 84597207-aa20-4222-4894-08dc3271d28c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a75kDoEqvU26nZLk1l3gVaHguS+41VWzUwg+7G83SvFE1MYmieJ9U4oEZjpEk2YHUGOGMMVyLFnBN8s3/SlLovS3TyvRWtgIhbIsAd5HLsuqlO5ZLqwHvliL6Wu2NFaBhe6sg53LmC4l33j8OJom5W4atoNQ7Mq+7nNiPx6AyJ/XN2AamXzBXl5RT1nIDtVKc22iMs8XK3Wq4I95aN0e3JQMR38E1shfBngX+QFdXlqM6D6jUg+ar5vhiYZKOzLhALwGcAESFluCk7kXU6lPgsyIjOeh+edzFhlWtufRIhbvG82nwWmvuTkXRAktFdIixAnQTs5IWAxTrI7GGU3AOip36X3l2eSNToOEfoWS2+ZVZjaAWvlz1x8G3PWQIQTsCOupmpe314uhUUMqwkWqh6zKVkA37QAEhEdXV++mCacf+4aOEn50iJ5cPtNOi5At/YQWym6UZ9jFB336K/c++iXq3pi16JDzozvSO0PXwNGpXesyt9xpgSWBwJMYx/YYpe7hEYFXa7uje0/nN2+tB4qav5hhsCwE1t+136zYBYeEVNZdMStKzneTQYvlB57N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MnQzbNP43dxf/Cmvl0k2t0xic5MtBSMc0bPWSrRR/mp4C7wqfwpye+a/QS9G?=
 =?us-ascii?Q?mnfKgtEgioR6LniV71BJw2OM9/AUCyoMOZkFJefk6yyLz8+Tsi4q8sExzBz2?=
 =?us-ascii?Q?yC2VKb8g9SZbDdoK/Phi4iAPKXxAiqBfFJQUICUQQ+Tcn9cP3m5oKG+RvB1r?=
 =?us-ascii?Q?ZHwV0RFeA/iREbnnUsvVB/P3ABzKyRyubNVjGpXDhIxuwtvdUR53TLfMVDkP?=
 =?us-ascii?Q?2aTyjNqEvQ8qAOvt52jhLEx59uuVDY/nCUxbsDdH/K4ReImuoI+9YO9nwt13?=
 =?us-ascii?Q?f+/7l5AS9+anG1dA28wfO4iPBz8ItsF7j+CwxqlNA50CQ58r6C2WW+a0XKUi?=
 =?us-ascii?Q?6N7jDOzOsPIzAxR3F07whsR3rfIToRW+GVFefEF25EXmGQjp76UJE3G6ZGCh?=
 =?us-ascii?Q?3vKWgLr85c/OJCOvI6p3m8L0nKT7taiudhJ6DoCJ7E4WASLBUX4TnJM4aO9q?=
 =?us-ascii?Q?tmFQeFiELLoUR5np8zwHoKde/dezjQZSXYcwb9yqb8Ie/lOQf6Lel0NNNdB3?=
 =?us-ascii?Q?NMGhx7UiDhgPZhpbjpZc0RxLfmDUpqKk9UIixLsIDgd8Z0RNzKDjmi3T9gOp?=
 =?us-ascii?Q?8u9+AupEaDFyrr9qZLrRLRXvQVUWghYmXaYbQIpOqYaCrGh4wXJr4eAaMxiF?=
 =?us-ascii?Q?q6J0/Bo3/Qf2NyFJ66E/nlfS+EyKJ6iQGZoq5h0tMtzKDOM+GRlaPgfghaeD?=
 =?us-ascii?Q?zBeuZplUavbKPmJNhnq54tf6tTehLfQ66USkfUpNWs1HTrq8GVkFJz80ITKK?=
 =?us-ascii?Q?+TignyRHCxfSTOb3iGqJwpzcSj0uCu/No7VzsGvIWhCdv0drBvaOmyVQwQQB?=
 =?us-ascii?Q?zGoKL74eX3OGTP+pj23s8PMDlNXbxsd36D424Nt5SSgeSoW7eFq8A+ffduTN?=
 =?us-ascii?Q?nPNAD0m1C/pih2phGdELk7x0qZlLbPWEEOzoa1PIsmw12rWBrEovBfdH2ivp?=
 =?us-ascii?Q?Fd3lAyaMwi01k48bZwKk8e1WxI5Xxji8yRBJCa9OKYF8xZP6E/ZmwEI+2wqc?=
 =?us-ascii?Q?7cqqD4ymGjx8NBKTXkqmHacphcbVwQ6z6xnq+Ugt0MDQtA5bimc6P2qiPvxO?=
 =?us-ascii?Q?msjPy4IQzeJVcTwTboBiGDtJuXAjTDgqKFbZo1xauvxoZ+KeCRJn+UL7uEvq?=
 =?us-ascii?Q?vmdj0CQusmon12+pKLbudFxiucxNvvXo9EFXVxZ/duI5ea6tN466567pk8/J?=
 =?us-ascii?Q?cqubYj0FJbf/+DSVt1CaQN99HJyikeLzWIwQEY1YGeJMiIXcg97PN6HrfvfA?=
 =?us-ascii?Q?eh0icpNR1hcLS9kzaroowE5aUUTNrsO0YGGbEMS4gjj+NbalOgg1oyXyojkL?=
 =?us-ascii?Q?rqE4m6pea/np7ypqSU4L9PogyOQFVmh3BBhfgM8ZOipDPd8+JdLrdyykA0Ya?=
 =?us-ascii?Q?l8DpN86OGIf6d3hsFSbM1OedSvSnUhLJqvBti0cJ5GaVzbZxFtiE0PWvcghf?=
 =?us-ascii?Q?Nbwi9P4m6UczFPAX/WVQyqVXZoDZVXNwDQqrPP80QQDe64K8mYzCgg0KwDVr?=
 =?us-ascii?Q?PE+i1T8XE+P4pXvg23efWoMA1QopKarbUHFPjXO+r+dDk+Jo5GsCzfRajMGb?=
 =?us-ascii?Q?2BIuWfvxvD+aWu266aMaT2J551voWocxd9tpke5q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84597207-aa20-4222-4894-08dc3271d28c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 00:12:42.6023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1vjSQbEf/SjOPYFonPBwoLkVGFQfnC1qbtr5W46ivKiXVd6N+A1rLoDM0Ut25lc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382

--mU+IiBB6J3anmRb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Misc collection of rc fixes for rdma. Most irdma and bnxt series.

Thanks,
Jason

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to eb5c7465c3240151cd42a55c7ace9da0026308a1:

  RDMA/srpt: fix function pointer cast warnings (2024-02-14 11:15:54 +0200)

----------------------------------------------------------------
RDMA v6.8 first rc

irdma and bnxt_re fixes:

- Missing error unwind in hf1

- For bnxt - fix fenching behavior to work on new chips, fail unsupported
  SRQ resize back to userspace, propogate SRQ FW failure back to
  userspace.

- Correctly fail unsupported SRQ resize back to userspace in bnxt

- Adjust a memcpy in mlx5 to not overflow a struct field.

- Prevent userspace from triggering mlx5 fw syndrome logging from sysfs

- Use the correct access mode for MLX5_IB_METHOD_DEVX_OBJ_MODIFY to avoid
  a userspace failure on modify

- For irdma - Don't UAF a concurrent tasklet during destroy, prevent
  userspace from issuing invalid QP attrs, fix a possible CQ overflow,
  capture a missing HW async error event

- sendmsg() triggerable memory access crash in hfi1

- Fix the srpt_service_guid parameter to not crash due to missing function
  pointer

- Don't leak objects in error unwind in qedr

- Don't weirdly cast function pointers in srpt

----------------------------------------------------------------
Arnd Bergmann (1):
      RDMA/srpt: fix function pointer cast warnings

Bart Van Assche (1):
      RDMA/srpt: Support specifying the srpt_service_guid parameter

Daniel Vacek (1):
      IB/hfi1: Fix sdma.h tx->num_descs off-by-one error

Kalesh AP (5):
      RDMA/bnxt_re: Avoid creating fence MR for newer adapters
      RDMA/bnxt_re: Remove a redundant check inside bnxt_re_vf_res_config
      RDMA/bnxt_re: Fix unconditional fence for newer adapters
      RDMA/bnxt_re: Return error for SRQ resize
      RDMA/bnxt_re: Add a missing check in bnxt_qplib_query_srq

Kamal Heib (1):
      RDMA/qedr: Fix qedr_create_user_qp error flow

Leon Romanovsky (1):
      RDMA/mlx5: Fix fortify source warning while accessing Eth segment

Mark Zhang (1):
      IB/mlx5: Don't expose debugfs entries for RRoCE general parameters if not supported

Mike Marciniszyn (1):
      RDMA/irdma: Fix KASAN issue with tasklet

Mustafa Ismail (2):
      RDMA/irdma: Set the CQ read threshold for GEN 1
      RDMA/irdma: Add AE for too many RNRS

Shiraz Saleem (1):
      RDMA/irdma: Validate max_send_wr and max_recv_wr

Yishai Hadas (1):
      RDMA/mlx5: Relax DEVX access upon modify commands

Zhipeng Lu (1):
      IB/hfi1: Fix a memleak in init_credit_return

 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 43 +++++++++++++++++++++-----------
 drivers/infiniband/hw/bnxt_re/main.c     |  3 ---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c |  3 ++-
 drivers/infiniband/hw/hfi1/pio.c         |  6 ++++-
 drivers/infiniband/hw/hfi1/sdma.c        |  2 +-
 drivers/infiniband/hw/irdma/defs.h       |  1 +
 drivers/infiniband/hw/irdma/hw.c         |  8 ++++++
 drivers/infiniband/hw/irdma/verbs.c      |  9 ++++---
 drivers/infiniband/hw/mlx5/cong.c        |  6 +++++
 drivers/infiniband/hw/mlx5/devx.c        |  2 +-
 drivers/infiniband/hw/mlx5/wr.c          |  2 +-
 drivers/infiniband/hw/qedr/verbs.c       | 11 +++++++-
 drivers/infiniband/ulp/srpt/ib_srpt.c    | 17 ++++++++-----
 include/linux/mlx5/mlx5_ifc.h            |  2 +-
 include/linux/mlx5/qp.h                  |  5 +++-
 15 files changed, 84 insertions(+), 36 deletions(-)

--mU+IiBB6J3anmRb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZdU/9wAKCRCFwuHvBreF
YZWXAQC2gGIk9t94NRthhlS6GB/PYYMA7o3mEL1jEiOpuXH+IwEAuQ+xqI7zsvol
zsFVI/FrEYKDDAyd3/D3NmHYmq5qlQ4=
=R5VZ
-----END PGP SIGNATURE-----

--mU+IiBB6J3anmRb6--

