Return-Path: <linux-rdma+bounces-1480-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9EA87EDFF
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Mar 2024 17:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B24B1C21D4F
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Mar 2024 16:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21CF54FA7;
	Mon, 18 Mar 2024 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lAk1pYSM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E0154FA0;
	Mon, 18 Mar 2024 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780678; cv=fail; b=QbUu5TPDy1K8VXVvro0v584Tpf84jN4C6dee01HovKPDn7Emmm0eQOpiUCiEJpG7tzD4pTWnd578aHDAFfNVBzC1QVvUBMJlRa67alqLhsnmG3fCo2REht3kAgg4oaeDodSSSxMZiyi1aezfQIdMVqt+ryn8eumW5SXfuFTdFvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780678; c=relaxed/simple;
	bh=99KV7zenpxNxOQeDuhHPW/pgFPVp1c1aVkAf6BtD6OI=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=gIUJKD5V62YOnUDLciy39SXdHSJGOT6UK9WwH8Y10YIOks9nSVjfjQN1ToglTNNkA+7LrTW9gNuDJf/D194k56pUe4gYDSsIdTT8nWPMwVgfSajr6ae4CWKlZODbe8hWDYVKp0+voDOojYTi8R1g+6Eqno913dH7HrVzY/tZpL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lAk1pYSM; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWYhNSwoPQr9qqvkUbBEEmUTrrhusGiFIhkCC7H03kWtk4eaxKrQnF5ns2skIP7PN6nXnM8DGROC9M0AJ8+/KVA6JJ7ScYRoSD/L+xR7+YHvw9efTj6ODq1gyDPLA5TywfpCStteBCfuDSFz5yVMGL+NegdAi/0IqCKHCvvC/WT9sMwphnf+hJDmWjWOiF0rpX4qmnBv0ZXKBQKwjN1SgFq9ejxhYSDY4NLnCZmhOOsL5otG/aE/z9D3Q02lGYZdidi0CawblBvHTi0HggWmUmIglpQTUbnpuiiyhRBjmOr4Cx/vs+O+s0bdNI3F3KgzISEZBSX4g4dZBaDvS9DqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIBQxvBmXQLwnzEGiI6T7Qd1IROQviD6TH9KBxfSve4=;
 b=dvDshFEa0HOXngksidebYn5nUvlqlZ56vhrqsIEddtQwabhHZ7/S/4enhLJSkjRReOzU9DMdA2GVhWqDmj/xEskI5ICTPKg5KACj9zrbVkZb1v/RFXTegLEvr+YflLZ9tHHS3ymhKOoFWAx+Y9Qkn3mLX4KRJOA/6sRuP64x99Oiovn2KzkVrwkEMWgtJlsE0D98k0vVnCZy9atSkUI8bqwos/xUXLWOaK1KItwJTBoZ9IRmBLHYrCGp+G1SubamvDCOf3DcEQdUFILLe7eklCqJVwYdqkMcAwnrDXkL5wCJpATkQPXLr3Ah7gapNmksqUrhOqshIAhuEbQFlAJsSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIBQxvBmXQLwnzEGiI6T7Qd1IROQviD6TH9KBxfSve4=;
 b=lAk1pYSM+P+X2dC8Cidc01NwkXcaZh61H7idDGQr3i3PmtOtj/3w8C0YWLXF2+vbJUw1NcNTZg1BuvpiSGzd3H5SxVLKMt/Sk9vSF9WgIwC8GByQdjRFi4/JTdoW6ay27sUN/TGJ+RKz+c5MVIFgwyrnTgE6Yr2PnMRktuGV7LGJvWP0xmxHKCWTPXkxcM1X/IGf7T2+eTeW8MZlMG3lU678/fNdPBBpKdh408pTtewoPxKS6Wdx0xdgsgJAJ3me3rYOsFCLnnWb6/fP6TPYgDykxqMkMp8l7tBDJ5s39SH7SCHEMofTJCWi2hqVl68L0xW+XG6F4A001AEQFNSIzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 16:51:13 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 16:51:13 +0000
Date: Mon, 18 Mar 2024 13:51:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20240318165111.GA71443@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RDj6IjsSBZhiwyg2"
Content-Disposition: inline
X-ClientProxiedBy: SN7PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:806:122::8) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: f62229e0-5e5b-4a71-c7a1-08dc476b9ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bsvf38SEOSJbYpjHcfhXS821H8oH9qP07b7h2nDDCBelCZxbO+VxEQawU764KjBCQNTov0i7rMH7L2rm/yIti/uIF2H0szfOuHNE4qk6mjL+LF9EjxS5alOXOqGkd5fTX3VQwVp8g503638LIJN3QdW4rGYUQSj3LboqtO/+Saw9kYlajKywSnlqH5gJhhLUQZOXEslfL3iff8KeVkakFH8RgrR9Ba4kgq5wGLiJwjpTSOAc8IlEOTWUO4mNHD7+/JWQjEs4G4o4t6AoafPn3AgM6ugrkQh/9jcFTbBEvXQwdILA9cvI/l4KQ8nKxNHMeqPYuL8OfxRnXA3HhepNBRdq2WCjkdnCn8Tpc36tts5N9MpsxZWTuTqv9X3v49Z6NMEGA7pLHxLmY+NO+LNCmG98gHYuaYWojG4KtNDNJ6+Avvt+NNdk9snK1BhSS32ui5GXktbY9ncxwHl3cP6aQQm1hzAEbHe0Fx4Pz+v4mvedIcw8c31GcCX84kYDzVSUSGVwFifc+sZnhVsY3HqokLKiWMpZDwj3XPKOmCCgTJTtfym0lAhJYEM5Klgo7fKK2/9ZiLNjdqE/P2tMNPCKp79WqfGKWxzMS657tRK0KNCEJtuyTgGhDV0h2k87rS5QlqG7TSSA2iJhCXAEcoB0QbQSKjmeBNzhOQbFg312YwE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jCxiRxiWxQE5Mfshx6hpEYrVYiGMhnTnJamkN9aKxevFjo4/uWsRu8VcdhYM?=
 =?us-ascii?Q?bjILZxPl0kDm7c7L9aMGBW7UXp0gDQxl3UkLCtE4luNa+dqCMOSH0SkUSPbQ?=
 =?us-ascii?Q?psaKUPD4HT57EqASOsHjfMYZHr9uC5j0JO/Wp0exJ86tlVyJbRZtQrp+xSCX?=
 =?us-ascii?Q?uADCOf1pVagDbPEowmljnEzndfRH8b40wHJBdkJmN6y/wG2Rrf711U1oStm0?=
 =?us-ascii?Q?4ms2/onjAFQGmPXxfkdq2CQbBJG15UvdNRrX6DCCFyuuLgfsAF0UbQYlq2QS?=
 =?us-ascii?Q?DthEK05iL1KzIqW3N8tJG1ko5VVV6p0UYpo9sd+b3GBjCFB3DwOH8ivU7nwP?=
 =?us-ascii?Q?iha3K3oty5rEBxrHm+1Io0a0Hsn9gSkIDLicKwZG0ARFPEf1361tDWIOqh+T?=
 =?us-ascii?Q?Q1B6ON9folaPcY504WIEfdVITLDHa8sFDQorFOoO1o4DwJSLPgE/c07gKtoi?=
 =?us-ascii?Q?LiHKijj/l5fPRoMT2ufyEs9HX2awHtCLuH2FrM9fGRK1kDhMrCH6gSJVYn5t?=
 =?us-ascii?Q?sSoPPSVpf6yFFARSyjj/WPmUv5FpbksQDlQVqjpaFl9RSp5SupMr9m1jF6Ey?=
 =?us-ascii?Q?8voO9XVT3J+l04Iv348G6ntbhIofoWZnnPg61U+LkbDjstlekYJtHEIxzZ3m?=
 =?us-ascii?Q?bTfi4WCO6MYdcePHQC/N0bjq2kjtipxPZoqkoJOT0R9cbz0rTTwuT7kQ4nbD?=
 =?us-ascii?Q?h8cKcJeXm1iTe2U2lVuMET32v5SxPCsEilvEg0peB0O6sG9LW/y34IgfdRCh?=
 =?us-ascii?Q?9mjpOnYN5ubQ4T+DEdlcHQORK1LgYbTPJwsjL0IIHrKaGpEahdyr+IXxNekM?=
 =?us-ascii?Q?JpVdoj6ICI5UD5Vy05UXNyvvM8jMfVjyxwiZCt14LC1tOztpspXxp3A07BnD?=
 =?us-ascii?Q?TRk6dZYEuewZHAe0Vxnl+s3Jr26fT8atdH3TwBI0V2NHdxoRpgI7mfKYsUb2?=
 =?us-ascii?Q?nVhJ1lJ0N9bMzp/VN7PjqgYVLFxOcrNeApYXAjFAf80fW41aXh5kAq1MUUMX?=
 =?us-ascii?Q?d5rLfBE8PVfHFm3EHKafrGFQ+gcS6LJw7m3Y3N6xSFWIgKhtlRnHv+48h8Zy?=
 =?us-ascii?Q?3dJSHWpaO9sGMJ+6bp/3FwCxBg7pJalxoUUNSDhcHUe/UpJ15+K87wHzC6BQ?=
 =?us-ascii?Q?RHV3h7f5vrmh+K/0IYizXTjwXG2fWxwyVfo745vyZn6h0vHVOEzIfTJmHDEK?=
 =?us-ascii?Q?LXOXWg1aebSnVkCZ52lQ1POj9I+RmkiZWcBbUQYI5Ee8n43nLeCnDMNyOJwO?=
 =?us-ascii?Q?50p4LwekmPMY0arrn/wyJnTkyV9rv349XcsNhIttKMr/VAtczy3MxpUrKrIk?=
 =?us-ascii?Q?fZ4zQhNcoPhP4dQr1BFUirVPkwLuQ6sgv1j6FKFcNTlpHfgq42pvbI+s5S1l?=
 =?us-ascii?Q?yjOZRDdkHI1SfAnnluBLzqWhstR16KuCgh6VK8UC7AQ87+mvSv2bLkF9yzfC?=
 =?us-ascii?Q?73pAGu9CIH5x/IxhO5k9aGZ6PP74UzO1sdTuA+Sia+riWwTNDQN2CBA7T5jE?=
 =?us-ascii?Q?dvfK3cAwh1cknMkNbMomu8Na3Xw3qfLBIW7hVU4E4ASVDend650nBOH16pYB?=
 =?us-ascii?Q?qoL7ql492aoYrCLXSu4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f62229e0-5e5b-4a71-c7a1-08dc476b9ee8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 16:51:13.3717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JgyqQ8bfwjjyiAuvuzxWLdV5uABO6XOspzny4I2fQtxoD/jodm8YY4eJ8WresnSd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811

--RDj6IjsSBZhiwyg2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Seems very small this cycle, there are still a few patches on the
mailing list but things seem to be getting overall quieter.

Thanks,
Jason

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 96d9cbe2f2ff7abde021bac75eafaceabe9a51fa:

  RDMA/cm: add timeout to cm_destroy_id wait (2024-03-10 13:17:54 +0200)

----------------------------------------------------------------
RDMA v6.9

Very small update this cycle:

- Minor code improvements in fi, rxe, ipoib, mana, cxgb4, mlx5, irdma,
  rxe, rtrs, mana

- Simplify the hns hem mechanism

- Fix EFA's MSI-X allocation in resource constrained configurations

- Fix a KASN splat in srpt

- Narrow hns's congestion control selection to QPs granularity and allow
  userspace to select it

- Solve a parallel module loading race between the CM module and a driver
  module

- Flexible array cleanup

- Dump hns's SCC Conext to 'rdma res' for debugging

- Make mana build page lists for HW objects that require a 0 offset
  correctly

- Stuck CM ID debugging

----------------------------------------------------------------
Alexey Dobriyan (2):
      RDMA/cxgb4: Delete unused c4iw_ep_redirect prototype
      RDMA/mlx5: Delete unused mlx5_ib_copy_pas prototype

Alexey Kodanev (1):
      RDMA/rtrs-clt: Check strnlen return len in sysfs mpath_policy_store()

Chengchang Tang (5):
      RDMA/hns: Refactor mtr find
      RDMA/hns: Refactor mtr_init_buf_cfg()
      RDMA/hns: Alloc MTR memory before alloc_mtt()
      RDMA/hns: Support flexible umem page size
      RDMA/hns: Support adaptive PBL hopnum

Christian Heusel (1):
      RDMA/ipoib: Print symbolic error name instead of error code

Erick Archer (1):
      RDMA/uverbs: Remove flexible arrays from struct *_filter

Guoqing Jiang (1):
      RDMA/rxe: Remove unused 'iova' parameter from rxe_mr_init_user

Gustavo A. R. Silva (1):
      RDMA/uverbs: Avoid -Wflex-array-member-not-at-end warnings

Junxian Huang (1):
      RDMA/hns: Support userspace configuring congestion control algorithm with QP granularity

Konstantin Taranov (5):
      RDMA/mana_ib: Introduce mdev_to_gc helper function
      RDMA/mana_ib: Introduce mana_ib_get_netdev helper function
      RDMA/mana_ib: Introduce mana_ib_install_cq_cb helper function
      RDMA/mana_ib: Fix bug in creation of dma regions
      RDMA/mana_ib: Use virtual address in dma regions for MRs

Li Zhijian (2):
      RDMA/rxe: Improve newline in printing messages
      RDMA/rxe: Remove rxe_info from rxe_set_mtu

Luoyouming (1):
      RDMA/hns: Fix mis-modifying default congestion control algorithm

Manjunath Patil (1):
      RDMA/cm: add timeout to cm_destroy_id wait

Mustafa Ismail (1):
      RDMA/irdma: Remove duplicate assignment

Randy Dunlap (1):
      IB/hfi1: fix spellos and kernel-doc

Shifeng Li (1):
      RDMA/device: Fix a race between mad_client and cm_client init

William Kucharski (1):
      RDMA/srpt: Do not register event handler until srpt device is fully setup

Yonatan Nachum (1):
      RDMA/efa: Limit EQs to available MSI-X vectors

Yunsheng Lin (1):
      RDMA/hns: Simplify 'struct hns_roce_hem' allocation

wenglianfa (1):
      RDMA/hns: Append SCC context to the raw dump of QPC

 drivers/infiniband/core/cm.c                   |  20 +-
 drivers/infiniband/core/device.c               |  37 +--
 drivers/infiniband/core/uverbs_cmd.c           |  16 +-
 drivers/infiniband/core/uverbs_ioctl.c         |  78 +++---
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h         |   2 -
 drivers/infiniband/hw/efa/efa.h                |   1 +
 drivers/infiniband/hw/efa/efa_main.c           |  32 ++-
 drivers/infiniband/hw/hfi1/tid_rdma.c          |  25 +-
 drivers/infiniband/hw/hns/hns_roce_cmd.h       |   3 +
 drivers/infiniband/hw/hns/hns_roce_cq.c        |  11 +-
 drivers/infiniband/hw/hns/hns_roce_device.h    |  35 ++-
 drivers/infiniband/hw/hns/hns_roce_hem.c       |  95 ++-----
 drivers/infiniband/hw/hns/hns_roce_hem.h       |  56 +---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c     | 154 ++++++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h     |   9 +-
 drivers/infiniband/hw/hns/hns_roce_main.c      |   3 +
 drivers/infiniband/hw/hns/hns_roce_mr.c        | 339 ++++++++++++++++++-------
 drivers/infiniband/hw/hns/hns_roce_qp.c        |  60 +++++
 drivers/infiniband/hw/hns/hns_roce_restrack.c  |  23 +-
 drivers/infiniband/hw/irdma/verbs.c            |   3 +-
 drivers/infiniband/hw/mana/cq.c                |  29 ++-
 drivers/infiniband/hw/mana/main.c              |  82 +++---
 drivers/infiniband/hw/mana/mana_ib.h           |  27 +-
 drivers/infiniband/hw/mana/mr.c                |  17 +-
 drivers/infiniband/hw/mana/qp.c                |  94 +++----
 drivers/infiniband/hw/mana/wq.c                |   4 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h           |   1 -
 drivers/infiniband/sw/rxe/rxe.c                |   6 +-
 drivers/infiniband/sw/rxe/rxe.h                |   6 +-
 drivers/infiniband/sw/rxe/rxe_comp.c           |   4 +-
 drivers/infiniband/sw/rxe/rxe_cq.c             |   4 +-
 drivers/infiniband/sw/rxe/rxe_loc.h            |   2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c             |  18 +-
 drivers/infiniband/sw/rxe/rxe_mw.c             |   2 +-
 drivers/infiniband/sw/rxe/rxe_qp.c             |   8 +-
 drivers/infiniband/sw/rxe/rxe_resp.c           |  12 +-
 drivers/infiniband/sw/rxe/rxe_task.c           |   4 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c          | 218 ++++++++--------
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   3 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c   |   2 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c          |   3 +-
 include/rdma/ib_verbs.h                        |  19 +-
 include/rdma/uverbs_ioctl.h                    |  14 +-
 include/uapi/rdma/hns-abi.h                    |  16 ++
 44 files changed, 899 insertions(+), 698 deletions(-)

--RDj6IjsSBZhiwyg2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZfhw/QAKCRCFwuHvBreF
YZKgAP4mTWElPeXiqnQpTgVh/XY3AmmBk7pMcxDVAkwIObxw/wD/YD5wUxB8QXa1
pOyob6bW/JsVzRCKe8C5X32fYojZ0AM=
=Ep/2
-----END PGP SIGNATURE-----

--RDj6IjsSBZhiwyg2--

