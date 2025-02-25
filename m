Return-Path: <linux-rdma+bounces-8075-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91A3A44B32
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 20:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCCAF3B12E8
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 19:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB651A0BCA;
	Tue, 25 Feb 2025 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tVqJpJTu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4545C1917F1;
	Tue, 25 Feb 2025 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740511375; cv=fail; b=DtpFxJbxy1TGoBU/x65vVxus8cXDTvcSgP+5YzIwaZEOW5b1lQB+4yoIAmcpIdhuDy8K3OlV3XGa91PlIdjBL+HNp5+NbhwpKGhdcL+Es0q4aU73ihDegwd07yIC7cap/TP6Sc9vH59nzLV8uJVi8hyDHdj8iLcU2gHCuuWHWMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740511375; c=relaxed/simple;
	bh=KYAY9AqP/OMgBFAkqAmge6atWNyI9lWP+/xjrh/RAHo=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=m6knmVORFFX3jT4kokogK0WsDBuHgmtqM6lHoxGQrVfKut8gVIfMsdebiZFPKoD1VMXcwVEBgpGdFiR+BM7NfNLPV9kqla6eSeIGta1XNNvrDXJi2RfK5MCtIqbC2u+CJvE445U/HFhGZFFVg8rym/0S+/cxi05ZpPM/BWSKIM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tVqJpJTu; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHpV1qW0d14SlRzCI3Kk7/4JHkK9hO+HVQ/4h963o0p+qxvVbhSgHOyU1sxHndp25z52mZ+qdpa12B821hmdDq88bz2cWIaAn1YRpXxV7gLWY5WCu7QCZqQ0kvONBVFpmAzfOpoWtLh4QkTLdNQQFTBKMEJRR06QzVa+eT+RhA5Ez6P/UZ2ldeqBk34A5nFxxXaP6WgpcJjyh5gdAYteeClcSVmeebBh0aZEHiUUzCGHuWWh8Q84uu5Ej6N2yLBJY4l5nTLtNFoCFEeFY+mBwG48Az9vxAtm2G+dB1RD1aGXcpDgkjXnms/H1yUpr8AwCOwdM1n8iQTkay/e2SVqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYAqLaSQj5uSHwjw9RZy3hKB2+gGdcW+5edBcztiyr0=;
 b=CcgfU3Lf9dOmUdnaQhNc1Y7vuMJ1s9Ix/bS4WINP69anvk8lyeHg/kdxRMn+dol8F24GjuNSg84ZnmL26dolzjdL2oTvaHhUyH72hP2kJO0TQRc/UaZhWSviqDZfoIiXIWoMmQMP1pAuLTwFH5fzhIEoLOS8VdZt8NxFFSCmq+6n+MfmZP3ZE2QnSDSl4SMncY1eZkuPVsJ4MkYTZIA1+Kh2OdD7EbCCQ08yFYN4ICd4qIxhlOxnAQnbiPTr2svab77WBx5AiHurzRHHGyuRw8pjOO2VH5VE3hyvmQEEq2EK0aBGfpmAacNbk90941mXoFBuOz0D1Do4j04GV63IHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYAqLaSQj5uSHwjw9RZy3hKB2+gGdcW+5edBcztiyr0=;
 b=tVqJpJTuCel3PhZ/Fdj/AooSYOs/uve/IvmReiboADffXPcuk4qyuPSBxDVmyCGUnSp1tna49k0KxA+s6KlKub/8nuFZunrvJZjY6oykzf5XtD4wMxeUKZnq/mSuxW6nRML+OGYHdr8lxel2pSZdpV52C1u/7b1ygUYFo0Tpkih5M+3B4kWKKWMPhwuMkcD8em58/W0vNiHQRWnEuU1k2bzYCYOkn8G0T9KfKoSFPxV0sILEGorJqKD4ui1ZJr4OKM6tNQESUaTvxRJSC6szYfLrHej5mLol8q5t94sRQp1Iwv1ckLtns0fbXaBnhQcWQ6RXVB+Sx4DH4QLYF35GlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 19:22:50 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 19:22:50 +0000
Date: Tue, 25 Feb 2025 15:22:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20250225192249.GA637700@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cgSZ1ZWG0XX6KUPy"
Content-Disposition: inline
X-ClientProxiedBy: YQBPR01CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 918def53-2617-4fe7-01e3-08dd55d1cb2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gqjixooGz5VsHu6LKPbHESZce6GfImF0YLPCTKUrEfHOFlF6iSLVWGhztgCD?=
 =?us-ascii?Q?pKsdzQnyf22/ZE6vdk6B9WQpGR0tLvF4eNllrIYUVClOMWGwxiDQo6AeJsuV?=
 =?us-ascii?Q?hnF/RdxBwhtgHaM8OAMUqcdFrN9UIDlutyr9zypBT/WnAV1M3VVaOQWujhWG?=
 =?us-ascii?Q?OZtF3zpvinpepUlgVm4b2l+QP7rmHJrYPxz5EMm9FITyQ60iSO2hAgKGzqW7?=
 =?us-ascii?Q?u4ZPNHWGClTcEMUyHcJLO7mRIOXReZSlH8ERh92aqcQIPpHJu3ztkZ0PbURz?=
 =?us-ascii?Q?s6VRPkozfYG67wjHElctysAY2a6MXJosfjftc5UHT1k5BoTznhuTGhR5VNXA?=
 =?us-ascii?Q?8ZtACVPsnx2tFT0aFrb8A7j33d8aNvcykZrELC/BnMa0dltdQVSlf7zr/i83?=
 =?us-ascii?Q?HGLfcU3OFSN3my5VXDXAf05/TNLZATbnLzoDG90XrFZdNtiahQ01aDXzcMEV?=
 =?us-ascii?Q?LjXfFl30ejjx3Jvxa2DQkJOK9EWJyY7OAksodH28VWAPXqKeiAv5fBOyWZiE?=
 =?us-ascii?Q?0QagXvNHt2HM18mw2nafuFz7TZycBwPCOhRdY28t2VEQL9B7Ms7modBS+22L?=
 =?us-ascii?Q?gY38JU/QIIzhNpfNHNoabTAS31ScuRLVTbVbt+GroTW1wNEUzmb9uU3rLchK?=
 =?us-ascii?Q?szN+7pPq+6oImbbmOG7V9wegPU6tjZw0BBxH5GuJqHxLr0J57w5o17wB63qq?=
 =?us-ascii?Q?S9x1lgtPPV4znl+YEAq8cOELPHNSdqjfiMeyYcnK8Fm+V+PjNxO6eDFQ/Fu/?=
 =?us-ascii?Q?sMl2wy/gmSm4yDJtPfxWs11/H7XmZADz08lrxU91cIct2WhFxIleDN8NTIF4?=
 =?us-ascii?Q?6k52OnumX2utgs8/7vjKSg7ZMfP2LmVk0YgpURyOZR5b3khG74KFgzPDcZil?=
 =?us-ascii?Q?q5z7ZoyOlUAe/ydv79wthSozq2JYIr60Iq9QqKRjTlkIZ99/KVYShg0puAku?=
 =?us-ascii?Q?avc2Ctkdvk+XAlVOO8kigAYEb0LztgJalcQgJs23YeXfZORlzLMWTgqT+Ry0?=
 =?us-ascii?Q?5N/kycGY+1LOmtm2fkMs0GOLFAVgWluCOgSU+hCTkC3uVxd5O2I75QUom2CR?=
 =?us-ascii?Q?I9ned84kHTgAFd0Ay6pdI+HrnZtKyujFPplLlSIeIlpXfdijCIuSxibBcIhG?=
 =?us-ascii?Q?X6FztG/92zgWaAOvrfsw1uMQQosF9UGD8cxpz2DaMhIEP94TbjiQDVFJnwUz?=
 =?us-ascii?Q?d61mAuUNizXwnI3cbKckW5uEJBrYKIqNo8+rQYYYJaiNK15ExwTKYsgBOuHX?=
 =?us-ascii?Q?GQlfEWf6JAnoU32LDCjNMG5N17xsK5iFyLcL/C3BbALoHe1UT0H1TKO/2Ddu?=
 =?us-ascii?Q?hhVdIU5nCgxQ8VxCnOgD9kOa2B/w/d1KeqQaNKreUsy4I43hr3xT1+wEV0cw?=
 =?us-ascii?Q?C92HuKfxj8CUIdVrh82A3dtCGquX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ukRGMZa9wKEvIoxEGRO2uQhz09UoBfFO3iM8kE0aESaceujpPo+q1g3gyJwg?=
 =?us-ascii?Q?O/bqOAccmeorhKCgeo1YdGXie7ckTdpKwzPh4obJt3PkpfyKS3EemjdIi+3K?=
 =?us-ascii?Q?qJP1Da20yb1UkSOLp+5FvTWpryN4GLPLetEuT6ud0ZlM34KnPx6fnAmr1iWQ?=
 =?us-ascii?Q?j9laHCg8WuHWsihALrQcktLRavgByByJxqhlG8U6o6cs8xHaOo0rHkHW/8kM?=
 =?us-ascii?Q?dHtsbewl1YcUuT67JRVfamCHQjuLRHeKRvNB/lMlcCbh9H9sv96pT2dP+/1a?=
 =?us-ascii?Q?lUiUi6QUsZA9sjcjJ/XDPWbmPCaAOL+ixhw63HPKj1VItBMcCsDrWAPNRlH/?=
 =?us-ascii?Q?/EP264uqAyVj79vbK9YgppclfkuGcHRDpXLQGnjqEOjOxTsEzmBV1K5JT1tP?=
 =?us-ascii?Q?0Cdalug2oLiFNp5UekGryU4vOvUGJJV5Z7fn8AQdvgSnoaN49bMatNnEUEPa?=
 =?us-ascii?Q?deSHWn5UZ639yyZmwttBFO+RotrcEjHexj7c6VboD129jascveXFpK3uKf4e?=
 =?us-ascii?Q?qtLbb6iulIjg0k9txz921+1s2jqqNfpgRJWyLfvPGfxzG6E2Eb9wFJHa9o0n?=
 =?us-ascii?Q?dTpxfJxG0JyAIe5aotKqgLPJ25QSVGDqsno6FOyySzMMcO7GjYN4PBWQRRih?=
 =?us-ascii?Q?wtefNTGK/fFswel0N7qHsCO7q5oVhv/uLxKzydasePQKLDQ9b9t2MsUe9BDP?=
 =?us-ascii?Q?yXNemO7RU/IQqSkEWwAWG5ASeUsjFKlEB4yDKqgo7XWVrcJbuoU3BoA1Wx4I?=
 =?us-ascii?Q?btpJyTVphIun5AQULXlaqtvcnEpbrru01bm5ohd2yg8GnEF78iMMPGGiv3Rx?=
 =?us-ascii?Q?rJTwqK1uf9vjr2m6+z9u0Yy8E7d3ptPJ2fjh213F9d2Hg4wsayXhEqCWdLs1?=
 =?us-ascii?Q?8MmVAYdpM9fyB1J1kHljrY9u/3UVN0pn5q7bVe2IuFPkBx8IOfI8jlOa+BPq?=
 =?us-ascii?Q?PzXf3q4HvKJhyhEq3XD3ETrv82a81YI2nr/yi57OuE9NRKk9vT+02ZCRTErz?=
 =?us-ascii?Q?9lxzPBskVCu/rTdUkA9bC5GYAGtzjUU5WvWD6qRZ8cShBtRr9SvGxlMgqKeL?=
 =?us-ascii?Q?1X61JI/fJSOg81iklrEn7aO7Rc0GBFSyGDADGY92EtUGpbzH24KzYKclbQJf?=
 =?us-ascii?Q?idO8o2Cm7RF8r050sweXFEkh483sdjMmetexC/jiP6XK5g5jDs5q32UWDUuF?=
 =?us-ascii?Q?cF+/ZqD25Hi+NSfnaSUB3fYAzU6skNEsonugNCQAU4xtNQWJ85JHOylzi60I?=
 =?us-ascii?Q?8YDpY7QfzjMqygsdAb4vVs7KxaZrUakPGo/AHb/64wlnzKlnkeb+9iTApjEL?=
 =?us-ascii?Q?AVkZRSOM6n9mDREOgeHQx8lWl0OOLBvocUoUJEwgmhePZhSHW9kwBuf6NnAv?=
 =?us-ascii?Q?D4vL8lhQfTa++iNWQppaLaAMENbIVI+CWhBhE0GysAE9AsXmj182MLMr5NBM?=
 =?us-ascii?Q?ujhF7c0FTJ+5+Lt6Tz4BVigcBFW579fMFWqAzmT+d4JMK0yG+z/09POns6i5?=
 =?us-ascii?Q?MyRHRxAuA0p7/4LkkK7N1cB8IjJ5HwOCPrHzK/rJuo14nDmjt+nGMLuxJsIU?=
 =?us-ascii?Q?aSxSLar6zmS/12Hllcj0/WeR4nX7Fi96vnWHY21n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918def53-2617-4fe7-01e3-08dd55d1cb2c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 19:22:50.3581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8d8//LfZDmeOVLK9sPn/pWlJ/ry/O2E8Qt9K1gt+ta5+QRMOiUsHJ04ywJ6Bc2Nn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257

--cgSZ1ZWG0XX6KUPy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Usual rc pull, a whole bunch of driver fixes. bnxt_re has started
testing driver unload and fixed a bunch of bugs there.

Thanks,
Jason

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to b66535356a4834a234f99e16a97eb51f2c6c5a7d:

  RDMA/bnxt_re: Fix the page details for the srq created by kernel consumers (2025-02-23 06:57:56 -0500)

----------------------------------------------------------------
RDMA v6.14 first rc pull request

- Fix a mlx5 malfunction if the UMR QP gets an error

- Return the correct port number to userspace for a mlx5 DCT

- Don't cause a UMR QP error if DMABUF teardown races with invalidation

- Fix a WARN splat when unregisering so mlx5 device memory MR types

- Use the correct alignment for the mana doorbell so that two processes
  do not share the same physical page on non-4k page systems

- MAINTAINERS updates for MANA

- Retry failed HNS FW commands because some can take a long time

- Cast void * handle to the correct type in bnxt to fix corruption

- Avoid a NULL pointer crash in bnxt_re

- Fix skipped ib_device_unregsiter() for bnxt_re due to some earlier
  rework

- Correctly detect if the bnxt supports extended statistics

- Fix refcount leak in mlx5 odp introduced by a previous fix

- Map the FW result for the port rate to the userspace values properly in
  mlx5, returns correct values for newer 800G ports

- Don't wrongly destroy counters objects that were not automatically
  created during mlx5 bind qp

- Set page size/shift members of kernel owned SRQs to fix a crash in nvme
  target

----------------------------------------------------------------
Junxian Huang (1):
      RDMA/hns: Fix mbox timing out by adding retry mechanism

Kalesh AP (3):
      RDMA/bnxt_re: Fix an issue in bnxt_re_async_notifier
      RDMA/bnxt_re: Add sanity checks on rdev validity
      RDMA/bnxt_re: Fix issue in the unload path

Kashyap Desai (1):
      RDMA/bnxt_re: Fix the page details for the srq created by kernel consumers

Konstantin Taranov (1):
      RDMA/mana_ib: Allocate PAGE aligned doorbell index

Long Li (1):
      MAINTAINERS: update maintainer for Microsoft MANA RDMA driver

Mark Zhang (1):
      IB/mlx5: Set and get correct qp_num for a DCT QP

Patrisious Haddad (2):
      RDMA/mlx5: Fix AH static rate parsing
      RDMA/mlx5: Fix bind QP error cleanup flow

Selvin Xavier (1):
      RDMA/bnxt_re: Fix the statistics for Gen P7 VF

Yishai Hadas (4):
      RDMA/mlx5: Fix the recovery flow of the UMR QP
      RDMA/mlx5: Fix a race for DMABUF MR which can lead to CQE with error
      RDMA/mlx5: Fix a WARN during dereg_mr for DM type
      RDMA/mlx5: Fix implicit ODP hang on parent deregistration

 MAINTAINERS                                 |  2 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h     |  1 -
 drivers/infiniband/hw/bnxt_re/hw_counters.c |  4 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c    |  2 +
 drivers/infiniband/hw/bnxt_re/main.c        | 22 ++++----
 drivers/infiniband/hw/bnxt_re/qplib_res.h   |  8 +++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 64 ++++++++++++++++------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  2 +
 drivers/infiniband/hw/mana/main.c           |  2 +-
 drivers/infiniband/hw/mlx5/ah.c             |  3 +-
 drivers/infiniband/hw/mlx5/counters.c       |  8 ++-
 drivers/infiniband/hw/mlx5/mr.c             | 16 +++++-
 drivers/infiniband/hw/mlx5/odp.c            |  1 +
 drivers/infiniband/hw/mlx5/qp.c             | 10 ++--
 drivers/infiniband/hw/mlx5/qp.h             |  1 +
 drivers/infiniband/hw/mlx5/umr.c            | 83 +++++++++++++++++++----------
 16 files changed, 161 insertions(+), 68 deletions(-)

--cgSZ1ZWG0XX6KUPy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZ74YhQAKCRCFwuHvBreF
YaB1AP0aGIymZnIQOYTrDsl+7xYB2dQisKdOuorm9lgO9J0W/QEAtdBvZby5to/J
wcr0jHmw9jBq402cJA6uH+qAWAciUQw=
=3tWt
-----END PGP SIGNATURE-----

--cgSZ1ZWG0XX6KUPy--

