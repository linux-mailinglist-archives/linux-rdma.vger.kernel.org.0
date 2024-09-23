Return-Path: <linux-rdma+bounces-5051-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD2597EFC8
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2024 19:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8819B1F2212F
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2024 17:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3F119F10F;
	Mon, 23 Sep 2024 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GFjeUhha"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B1719D885;
	Mon, 23 Sep 2024 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727111782; cv=fail; b=do23xxEuigIuqYygozAn/GGCpKtCl/d9SClFP5+35fFrQESwaxbfiuf40qfHaWbxkW0NKPILdy8OV93WggXPP0ilzK2LWoi//xQNSgsXmEu1QvBr1+nlRxR5Nf9lZ9gl3UCmm0vqt2tqvLRrBNEuRqBp6M+VryvX365lEBBMXMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727111782; c=relaxed/simple;
	bh=toLjymh09m07TuOr86poulzkhTFyxZ4V3ARP05JIo4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=F/8GXWtQ0Fs4qGDe8gGYgGWXL+65hFwlZg79X2F7OmPvctRGirOTY7eL83T2SdrGFMUoEaGnCQX2IfEpsvweVdzdVNdLoTLGLu5sXPrzyQCslz5k19OP1DMeSq75nQnk2HrQVspVShId9zAk3zBG1hjvZJ67c0kKXnoevolvqTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GFjeUhha; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teHRHPNy2j2XR8ywvhfPwCANuHEMciCmMip05vnYH3uNcu376sDSxFr2Ajb2/NQoq2gJHkjRAw+iEczGMiU2hvue4QNmPmCDYBAPMDmUtEAB41mt30VvyQ3kI5dfHshsRHoMqPKZOFGT8S3jBLSMYdo6zrcQ2Jr3g+RPRK1wUsFw8xDXyie1OOwI4Ey1j0uvMp67xpqfu3sJCaFHJRKDnVe3NDW8odB5a16ZJHXaFEmIYrx/oN5lhqf/OhoNOVy5v9Gc5J6v2rwOAoRBWO2bpSDlz359jhlQ0Z4SJM83N4NWzt74CXdVRs4iwJCXg13zZVceIqnapEq5D6h0SFlRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkUCqEdOSiJzKeSM7xZWZbxZ2jYV3PjnoQ7yM82suAw=;
 b=vePBUGnI/MV9zreUd4X3dA//ltEmALkICuWIYfO358/gfllerxexebnP0ovdTlVWq11qqfRQ2I6ULgqng88/5sDK+LSrBSflLKfg6+CwO6dnblRtUyyA9VqrTkJdQV86GZMrdwX2digQ5dOni5uizeS3+h8f+rtp3WA3X9WLX8nXAsCqQ3KufvCm5hu2Lo4g94cLM17DIBG/Bvbe0F24olx69fxIde3XhFzqrIRjF++tolXcR2yaqk2wIt81Cnb7xluuEnFlxuFhR5IknNVBeC1NbCpQTrmKFCcQeq8lEVtgoWDDp967AajyEYqbi6UFMaDwchM0G/bI//5KUjoTxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkUCqEdOSiJzKeSM7xZWZbxZ2jYV3PjnoQ7yM82suAw=;
 b=GFjeUhhanFuuDoD0gvq0viQI9IDUFXJLXoAO4pn1cjVgWYuA+z94F8NEw2pa6IHCKlcFCNAQ3UEeETWwM07UogL/dVJPbUhoS8YKI/SopjzA4XWBtOecpt1/Y65Fmp2N/1iElJxJ90SzrOjhwn0FcsOadT5Np9zTw/W3l794//a1taETrAV1YZ5XtIZEy2N09gIK61KSo5NORDu0skAVu0oHtdVImuZMNtwnUH3OvLwSQO+YHeLaBvP4FNk3U3Hf1YKJg16U/YiYq7+UAvCNGEzz4QgScs9EiaprzifKGXLAVPX9qfypywFHMtLVCuUghXi4lW3gOGmDaHoHC9NpiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 17:16:16 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 17:16:16 +0000
Date: Mon, 23 Sep 2024 14:16:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20240923171614.GA53576@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BQNmG3Va1Mf6qH2K"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:208:236::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH0PR12MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f60f6a-74bf-4e38-945b-08dcdbf36efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WYiG2kKvppk8tu7n+iAiYaI+4EAKiB7FGK1y1GSVKQnA4pKFPgIm9NdcfQDE?=
 =?us-ascii?Q?NcE+njQPfVbX7HyyMOIodkrcMJTsErKP0SRPGGUURR1WynuMAx3LHoLN/ikw?=
 =?us-ascii?Q?MnjTS2QTIewG1sVpJ8o8QoMN+8+9Bf+eIqnnItAlK/IJY7/csXhFgzOXZGwd?=
 =?us-ascii?Q?veogzZadj8AUx8XMt8jk3GDNQhkkZfn38VUVL35AhKRci6LOEemw7Sr/Xdjc?=
 =?us-ascii?Q?dGnQle9N7z8qjZqsdHbUdu6bo40NQ8IUmVdEjJqC49clVfm1y7oAKHQrfjJ9?=
 =?us-ascii?Q?XqGohUBr8XxKx8uWi8cQ42G2NiEItMmtkN3zkJwdlfQ0b9u3VhK4YBQR8xWJ?=
 =?us-ascii?Q?Nnv1YKEY7X0WH2l0+V6bGSybXdit+nQWkxe0InnMaIb8JBvnYdGxsy45cA3a?=
 =?us-ascii?Q?TUPSiowux/dOMdLnPxHbAFQ2La0sZwJY9ogDaB75g4khuTUYyKFthGDZUJgY?=
 =?us-ascii?Q?NCkxgwlUHlrCmOLQattwGHf8t4Eo6RPwO+hwdeuLlRul42rk6WiaiunmBcMA?=
 =?us-ascii?Q?FDO9ppUJ+2mjs9Y+XuYRYXH2RuqhZ4pQDMiJ01m90etXctVuA0pfC8WaYu8S?=
 =?us-ascii?Q?bXXPH/fxqJ6k8I7TzZYnI1VSKlUaIeZJq4FyAKEvnEw/QUKzXtdq+tYTPV8T?=
 =?us-ascii?Q?HQh4XColR6A6ylIfQ1H8Ch5xe9ND8QkJSho8h2YazCSmoxP3n9YBs7F9RuzU?=
 =?us-ascii?Q?eHF7y+KFAxxEsHLLDM3T3F59skSj2/5cpOImr39yE0z7lS9dvaeneHeuixV8?=
 =?us-ascii?Q?RZq+/NQgliy881VOKog084Zal2Xj9yMZSO1yB3o3MYrLulTabFqZJNcc0oWX?=
 =?us-ascii?Q?YCfADpgVEJSoW0w0nXXmDIfviwEBV89BiQxqk3F0JHuSfmJYcoPeqm3O1eqR?=
 =?us-ascii?Q?rOHez9G4MH0iQgQseDa6ASIrie0g6ph34GmN0odLfRiZVEOnk82nwkieTngS?=
 =?us-ascii?Q?7zH3Er9XLx7Rw2IiBSDqfK9pC6tRWzEqOIuVx4SbAlQkGDlrrulb5rGDDsXb?=
 =?us-ascii?Q?zXrm3FZ4J5/PgYxCi1geHfuIWd72ztkS4iiRM+g1Hp1MHptqQCi2EYcysmN0?=
 =?us-ascii?Q?yUIOh5Ge8+zXYsB4GIymaHxf8HEVqiYr+GMqlOkdHRg9sgscXcXXn2ILFlbw?=
 =?us-ascii?Q?44EYn75obc4rAixigHMT+RvV7Y11lqLJN+y8UFM/G89/69k12a2uj4POVJ+H?=
 =?us-ascii?Q?neYgJCfYAlSy5cBlCxVLZSQtyPkLRFvifRVuDaudM4wBalc2c2D4z47NBbon?=
 =?us-ascii?Q?SQ0twZSlH/UmKuSq3b9ejBn1YNqMCctknBDIdqixViHGZGFf0ubJIc4qdydC?=
 =?us-ascii?Q?GzS+rZoAIEuoTL/211IX/pMW+gOZ0Qn6pnaxFfPjWIeU5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Vgg7DNzVKLf+tBFoRbP7/f9R96iegZ0q8yIg7arSS/6zCaxB9aKpGnTnNCp?=
 =?us-ascii?Q?EM3qzjjzyPnWjfJDRG/k63rK3zCBYVjXydGDOkgrich+dj05l/0VnkmjbdT8?=
 =?us-ascii?Q?IZuDB9SsxrRl/ZP5qeyrRP8mGjfILFlq0d3WLB+J2ktaxCgVwo3OLdV6LrPP?=
 =?us-ascii?Q?gkWLiR4snxnmSqOUCCc5E8uRaYs6Rzc/xrtCLOK0nfv1EGcwooU5RJSmIN9T?=
 =?us-ascii?Q?VdM1tXPtjpOAURzsO3HxefngN4CVKcuYvU3NCV/Yy8E0LzX0Kl2q/BDjq+y8?=
 =?us-ascii?Q?YgABAmDuO7A/qKIWMOPRyIAcwiz6bS/DfPHpi5CkDRfIiJoABEsdnfo3F7v8?=
 =?us-ascii?Q?uNlXP3lkZCj9sFeiQu0CifZ2kk599f20ZkC/OofR6yAxGsI5ooQQTi8hm5Sk?=
 =?us-ascii?Q?P4sznRTNrxUJSC3cLb7Uyku3NYQHn5hIAOiVqZ8LIitHe8EKFXM5bvj8Ha7N?=
 =?us-ascii?Q?XSFu0CLDqgGbE9KpD4BO4bJlBqtRNFjsxwVFpRBlq2FcTJcu6YmkVwiGSZ5F?=
 =?us-ascii?Q?aR3nHFvedZiblVGi2B+7tDdqIJdR4+ByahqOringapcynqYyycBd81ajlt7u?=
 =?us-ascii?Q?8hG/B5W1f23sTG8a9It1as6eYZqqTrR0cUTTmUcZg92Z/nfb4qWFcZTms0Ro?=
 =?us-ascii?Q?50L+VHe+rymtvgi1vFhMFQ4FIuW7wvdIN0E6OuTajYbPgkZfoUeMea77abv5?=
 =?us-ascii?Q?V/Gu8eCcglZc/k5ftIUtg+3i4uF4BaDtSA2b9ETa8M0Drt4pL+RNIWQnmGj2?=
 =?us-ascii?Q?HhiykYYeUtXoL08F33l5T+Cp/LmS3NmnXkA31Svr1PPAUaPtC21sFAlzJK00?=
 =?us-ascii?Q?M+u13vAZ9qdhpqrDPfwYcBCTrxPSr71ClVAWHjARgFoqomFEjG5Z6ydK+Gfb?=
 =?us-ascii?Q?MP8MZR4pi6t+T2qrrSH6D70JNn3tiG7z6tOQvNQWyqpnVK6s8VDgeNlHz6Z6?=
 =?us-ascii?Q?CFmRwWSCwON6S6VPSHPydmMQ4BLCU8skfK8ky0oZi/O+c52vX+TjKeEOsovj?=
 =?us-ascii?Q?IItCSNIscCSAM9w2frX0m7bgKrVMvtlcGNjV4qUvb3YD6GPjEGatVLY80OT9?=
 =?us-ascii?Q?sb4Nl/z8qUBbUXU5dYSkop1qM1dvIJNsqFtBpRrnnvonHoSNgRa8IvW3AuD6?=
 =?us-ascii?Q?v7IuY19y4PKi78Lu0quFgFqY3MrFnSwl8JD5thKT/QheutOGS66+qibD9aSk?=
 =?us-ascii?Q?0U2D7zRBzHoSL8kKVSB86G+VB2v3QwPk9Ua3EVjw4G6cZpyJouoQGBS1WzTt?=
 =?us-ascii?Q?TySQkp/t/8BIi4Usk+hW99lNOUijYpnCeRyxA6ZvXL3Mb4qW031RNBjEdSvG?=
 =?us-ascii?Q?SIraEtIRfWcTHAH4+CekUsSTuiRdgYxFD79J/WY25R3WKxUKPKskBYFyvJhU?=
 =?us-ascii?Q?lrBgJoMqgvvLzAfmU+zEpMKdJfHypctlawW136ZOxkCpWkH4ytdvvac7O48o?=
 =?us-ascii?Q?krQ99EzSMljkuyX1gSeUXwgcPW2Ls+kxFci7AnN3qv+aKI6vYTWDy1B6p81B?=
 =?us-ascii?Q?P3xmQ5Adza5rww6bq09cBEaV0Gg/YHpLPoYwF+/BHgYWogxS3tinpoZezCI0?=
 =?us-ascii?Q?CsWUrNMF5ovWW6DveXI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f60f6a-74bf-4e38-945b-08dcdbf36efb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 17:16:16.7610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ad+kYus6hdYB6pPn9Vo2tSRyYq74Uf6rSRUbs49R8SySd+VOsqbpbNzpuQus+dl1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774

--BQNmG3Va1Mf6qH2K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

There is a small conflict with netdev in the shared ifc file - take
both and keep the list sorted:

@@@ -313,7 -315,7 +315,8 @@@ enum=20
        MLX5_CMD_OP_MODIFY_VHCA_STATE             =3D 0xb0e,
        MLX5_CMD_OP_SYNC_CRYPTO                   =3D 0xb12,
        MLX5_CMD_OP_ALLOW_OTHER_VHCA_ACCESS       =3D 0xb16,
+       MLX5_CMD_OP_GENERATE_WQE                  =3D 0xb17,
 +      MLX5_CMD_OPCODE_QUERY_VUID                =3D 0xb22,
        MLX5_CMD_OP_MAX
  };
 =20
Nothing especially stood out to me here. The new multipath PCI feature
is a sign of things to come, I think we will see more of this in the
next 10 years. Broadcom and HNS continue to update their drivers for
their new HW generations.

The tag for-linus-merged with my merge resolution to your tree is also
available to pull.

Apologies for the delay, LPC travel was a bit troublesome this year.

Thanks,
Jason

The following changes since commit 5be63fc19fcaa4c236b307420483578a56986a37:

  Linux 6.11-rc5 (2024-08-25 19:07:11 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 70920941923316b760bc7a804eb3d49a126d8712:

  RDMA/bnxt_re: Remove the unused variable en_dev (2024-09-22 16:53:46 +030=
0)

----------------------------------------------------------------
RDMA v6.12 merge window

Usual collection of small improvements and fixes:

- Bug fixes and minor improvments in cxgb4, siw, mlx5, rxe, efa, rts, hfi,
  erdma, hns, irdma

- Code cleanups/typos/etc. Tidy alloc_ordered_workqueue() calls

- Multipath PCI for mlx5

- Variable size work queue, SRQ changes, and relaxed ordering for new bnxt =
HW

- New ODP fault resolution FW protocol in mlx5

- New "rdma monitor" netlink mechanism

----------------------------------------------------------------
Anumula Murali Mohan Reddy (1):
      RDMA/cxgb4: use dma_mmap_coherent() for mapping non-contiguous memory

Chandramohan Akula (4):
      RDMA/bnxt_re: Refactor the BNXT_RE_METHOD_GET_TOGGLE_MEM method
      RDMA/bnxt_re: Share a page to expose per SRQ info with userspace
      RDMA/bnxt_re: Change aux driver data to en_info to hold more informat=
ion
      RDMA/bnxt_re: Use the aux device for L2 ULP callbacks

Cheng Xu (3):
      RDMA/erdma: Refactor the initialization and destruction of EQ
      RDMA/erdma: Add disassociate ucontext support
      RDMA/erdma: Return QP state in erdma_query_qp

Chengchang Tang (2):
      RDMA/hns: Fix spin_unlock_irqrestore() called with IRQs enabled
      RDMA/hns: Fix 1bit-ECC recovery address in non-4K OS

Chiara Meiohas (6):
      RDMA/nldev: Enhance netlink message parsing and validation
      RDMA/mlx5: Initialize phys_port_cnt earlier in RDMA device creation
      RDMA/device: Remove optimization in ib_device_get_netdev()
      RDMA/mlx5: Use IB set_netdev and get_netdev functions
      RDMA/nldev: Add support for RDMA monitoring
      RDMA/nldev: Expose whether RDMA monitoring is supported

Chris Mi (1):
      IB/mlx5: Fix UMR pd cleanup on error flow of driver init

Grzegorz Prajsner (1):
      RDMA/rtrs: Register ib event handler

Hongguang Gao (1):
      RDMA/bnxt_re: Get the toggle bits from SRQ events

Jack Wang (7):
      RDMA/rtrs-clt: Fix need_inv setting in error case
      RDMA/rtrs-clt: Rate limit errors in IO path
      RDMA/rtrs: Reset hb_missed_cnt after receiving other traffic from peer
      RDMA/rtrs-clt: Reuse need_inval from mr
      RDMA/rtrs-clt: Print request type for errors
      RDMA/rtrs-clt: Do local invalidate after write io completion
      RDMA/rtrs-clt: Remove an extra space

Jason Gunthorpe (1):
      Merge branch 'bnxt_re_variable_wqes' into rdma.git for-next

Jiapeng Chong (1):
      RDMA/bnxt_re: Remove the unused variable en_dev

Jinjie Ruan (4):
      RDMA/qib: Simplify an alloc_ordered_workqueue() invocation
      RDMA/mad: Simplify an alloc_ordered_workqueue() invocation
      RDMA/mlx4: Simplify an alloc_ordered_workqueue() invocation
      RDMA/mlx4: Simplify an alloc_ordered_workqueue() invocation

Junxian Huang (5):
      RDMA/hns: Don't modify rq next block addr in HIP09 QPC
      RDMA/hns: Fix VF triggering PF reset in abnormal interrupt handler
      RDMA/hns: Optimize hem allocation performance
      RDMA/hns: Fix restricted __le16 degrades to integer issue
      RDMA/hns: Fix ah error counter in sw stat not increasing

Kalesh AP (4):
      RDMA/bnxt_re: Update HW interface headers
      RDMA/bnxt_re: Rename a variable
      RDMA/bnxt_re: Avoid an extra hwrm per MR creation
      RDMA/bnxt_re: Add support for MR Relaxed Ordering

Leon Romanovsky (1):
      Introducing Multi-Path DMA Support for mlx5 RDMA Driver

Long Li (2):
      RDMA/mana_ib: use the correct page table index based on hardware page=
 size
      RDMA/mana_ib: use the correct page size for mapping user-mode doorbel=
l page

Maher Sanalla (1):
      RDMA/mlx5: Enable ATS when allocating kernel MRs

Mark Bloch (3):
      RDMA/mlx5: Expose vhca id for all ports in multiport mode
      RDMA/mlx5: Check RoCE LAG status before getting netdev
      RDMA/mlx5: Obtain upper net device only when needed

Md Haris Iqbal (3):
      RDMA/rtrs: For HB error add additional clt/srv specific logging
      RDMA/rtrs-clt: Reset cid to con_num - 1 to stay in bounds
      RDMA/rtrs-srv: Avoid null pointer deref during path establishment

Michael Guralnik (12):
      RDMA/mlx5: Drop redundant work canceling from clean_keys()
      RDMA/mlx5: Fix counter update on MR cache mkey creation
      RDMA/mlx5: Limit usage of over-sized mkeys from the MR cache
      RDMA/mlx5: Fix MR cache temp entries cleanup
      net/mlx5: Expand mkey page size to support 6 bits
      net/mlx5: Expose HW bits for Memory scheme ODP
      RDMA/mlx5: Add new ODP memory scheme eqe format
      RDMA/mlx5: Enforce umem boundaries for explicit ODP page faults
      RDMA/mlx5: Split ODP mkey search logic
      RDMA/mlx5: Add handling for memory scheme page fault events
      RDMA/mlx5: Add implicit MR handling to ODP memory scheme
      net/mlx5: Handle memory scheme ODP capabilities

Mikhail Lobanov (1):
      RDMA/cxgb4: Added NULL check for lookup_atid

Nathan Chancellor (1):
      RDMA/nldev: Add missing break in rdma_nl_notify_err_msg()

Patrisious Haddad (1):
      IB/core: Fix ib_cache_setup_one error flow cleanup

Saravanan Vajravel (1):
      RDMA/mad: Improve handling of timed out WRs of mad agent

Selvin Xavier (9):
      RDMA/bnxt_re: Add support for Variable WQE in Genp7 adapters
      RDMA/bnxt_re: Get the WQE index from slot index while completing the =
WQEs
      RDMA/bnxt_re: Fix the table size for PSN/MSN entries
      RDMA/bnxt_re: Handle variable WQE support for user applications
      RDMA/bnxt_re: Enable variable size WQEs for user space applications
      RDMA/bnxt_re: Fix the compatibility flag for variable size WQE
      RDMA/bnxt_re: Fix the max WQE size for static WQE support
      RDMA/bnxt_re: Group all operations under add_device and remove_device
      RDMA/bnxt_re: Recover the device when FW error is detected

Shen Lichuan (1):
      RDMA/rdmavt: Convert to use ERR_CAST()

Showrya M N (1):
      RDMA/siw: Remove NETDEV_GOING_DOWN event handler

Vitaliy Shevtsov (1):
      RDMA/irdma: fix error message in irdma_modify_qp_roce()

Yehuda Yitschak (1):
      RDMA/efa: Add support for node guid

Yishai Hadas (9):
      net/mlx5: Add IFC related stuff for data direct
      RDMA/mlx5: Introduce the 'data direct' driver
      RDMA/mlx5: Add the initialization flow to utilize the 'data direct' d=
evice
      RDMA/umem: Add support for creating pinned DMABUF umem with a given d=
ma device
      RDMA/umem: Introduce an option to revoke DMABUF umem
      RDMA: Pass uverbs_attr_bundle as part of '.reg_user_mr_dmabuf' API
      RDMA/mlx5: Add support for DMABUF MR registrations with Data-direct
      RDMA/mlx5: Introduce GET_DATA_DIRECT_SYSFS_PATH ioctl
      RDMA/mlx5: Consider the query_vuid cap for data_direct

Yue Haibing (2):
      RDMA/mlx5: Remove two unused declarations
      RDMA/cxgb4: Remove unused declarations

Zhang Zekun (4):
      RDMA/core: Remove unused declaration rdma_resolve_ip_route()
      RDMA/ipoib: Remove unused declarations
      IB/iser: Remove unused declaration in header file
      IB/qib: Remove unused declarations in header file

Zhu Yanjun (1):
      RDMA/iwcm: Fix WARNING:at_kernel/workqueue.c:#check_flush_dependency

wenglianfa (2):
      RDMA/hns: Fix Use-After-Free of rsv_qp on HIP08
      RDMA/hns: Fix the overflow risk of hem_list_calc_ba_range()

zhenwei pi (3):
      RDMA/rxe: Use sizeof instead of hard code number
      RDMA/rxe: Fix misspelling of 'rmda'
      RDMA/rxe: Fix __bth_set_resv6a

 drivers/infiniband/core/cache.c                   |   4 +-
 drivers/infiniband/core/core_priv.h               |   3 -
 drivers/infiniband/core/device.c                  |  48 ++-
 drivers/infiniband/core/iwcm.c                    |   2 +-
 drivers/infiniband/core/mad.c                     |  19 +-
 drivers/infiniband/core/netlink.c                 |   1 +
 drivers/infiniband/core/nldev.c                   | 187 ++++++++--
 drivers/infiniband/core/umem_dmabuf.c             |  66 +++-
 drivers/infiniband/core/uverbs_std_types_mr.c     |   2 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h           |  23 ++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c          | 254 ++++++++-----
 drivers/infiniband/hw/bnxt_re/ib_verbs.h          |  20 +-
 drivers/infiniband/hw/bnxt_re/main.c              | 213 +++++++----
 drivers/infiniband/hw/bnxt_re/qplib_fp.c          |  72 +++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h          |  25 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h         |  11 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c          |  19 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h          |  11 +-
 drivers/infiniband/hw/bnxt_re/roce_hsi.h          |  36 +-
 drivers/infiniband/hw/cxgb4/cm.c                  |   5 +
 drivers/infiniband/hw/cxgb4/cq.c                  |   8 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h            |  40 ++-
 drivers/infiniband/hw/cxgb4/provider.c            |  67 ++--
 drivers/infiniband/hw/cxgb4/qp.c                  |  32 +-
 drivers/infiniband/hw/efa/efa.h                   |   2 +-
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h   |   3 +
 drivers/infiniband/hw/efa/efa_com_cmd.c           |   1 +
 drivers/infiniband/hw/efa/efa_com_cmd.h           |   1 +
 drivers/infiniband/hw/efa/efa_main.c              |   1 +
 drivers/infiniband/hw/efa/efa_verbs.c             |   4 +-
 drivers/infiniband/hw/erdma/erdma.h               |   3 +-
 drivers/infiniband/hw/erdma/erdma_cmdq.c          |  26 +-
 drivers/infiniband/hw/erdma/erdma_eq.c            |  87 +++--
 drivers/infiniband/hw/erdma/erdma_main.c          |   5 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c         |  29 +-
 drivers/infiniband/hw/erdma/erdma_verbs.h         |   1 +
 drivers/infiniband/hw/hns/hns_roce_ah.c           |  14 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c          |  22 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c        |  33 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c           |  16 +-
 drivers/infiniband/hw/irdma/verbs.c               |   4 +-
 drivers/infiniband/hw/mana/main.c                 |   8 +-
 drivers/infiniband/hw/mlx4/alias_GUID.c           |   4 +-
 drivers/infiniband/hw/mlx4/mad.c                  |  10 +-
 drivers/infiniband/hw/mlx5/Makefile               |   1 +
 drivers/infiniband/hw/mlx5/cmd.c                  |  21 ++
 drivers/infiniband/hw/mlx5/cmd.h                  |   2 +
 drivers/infiniband/hw/mlx5/data_direct.c          | 227 ++++++++++++
 drivers/infiniband/hw/mlx5/data_direct.h          |  23 ++
 drivers/infiniband/hw/mlx5/ib_rep.c               |  22 +-
 drivers/infiniband/hw/mlx5/main.c                 | 324 ++++++++++++++---
 drivers/infiniband/hw/mlx5/mlx5_ib.h              |  60 +++-
 drivers/infiniband/hw/mlx5/mr.c                   | 418 ++++++++++++++++--=
----
 drivers/infiniband/hw/mlx5/odp.c                  | 405 ++++++++++++++++--=
---
 drivers/infiniband/hw/mlx5/std_types.c            |  76 +++-
 drivers/infiniband/hw/mlx5/umr.c                  |  96 +++--
 drivers/infiniband/hw/mlx5/umr.h                  |   1 +
 drivers/infiniband/hw/qib/qib_init.c              |   9 +-
 drivers/infiniband/hw/qib/qib_verbs.h             |   4 -
 drivers/infiniband/sw/rdmavt/mr.c                 |   6 +-
 drivers/infiniband/sw/rxe/rxe_hdr.h               |   2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c              |   4 +-
 drivers/infiniband/sw/siw/siw.h                   |   2 -
 drivers/infiniband/sw/siw/siw_main.c              |  37 --
 drivers/infiniband/ulp/ipoib/ipoib.h              |   4 -
 drivers/infiniband/ulp/iser/iscsi_iser.h          |   4 -
 drivers/infiniband/ulp/rtrs/rtrs-clt.c            |  92 +++--
 drivers/infiniband/ulp/rtrs/rtrs-clt.h            |   3 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h            |   2 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c            |  51 ++-
 drivers/infiniband/ulp/rtrs/rtrs-srv.h            |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c |  76 ++--
 drivers/net/ethernet/mellanox/mlx5/core/main.c    |  54 +--
 include/linux/mlx5/device.h                       |  31 +-
 include/linux/mlx5/driver.h                       |   2 +-
 include/linux/mlx5/mlx5_ifc.h                     | 113 +++++-
 include/rdma/ib_umem.h                            |  18 +
 include/rdma/ib_verbs.h                           |   4 +-
 include/rdma/rdma_netlink.h                       |  12 +
 include/uapi/rdma/bnxt_re-abi.h                   |  13 +
 include/uapi/rdma/mlx5_user_ioctl_cmds.h          |   9 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h         |   4 +
 include/uapi/rdma/rdma_netlink.h                  |  16 +
 83 files changed, 2796 insertions(+), 896 deletions(-)
(diffstat from tag for-linus-merged)

--BQNmG3Va1Mf6qH2K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZvGiXQAKCRCFwuHvBreF
YQdTAP4rYlovP+5FxbKOhagL+ylOIRsyzncUsGUmWop62/OQvgD+JpgYblqyUXTt
Y5wH9k++R3SV9Lat95sU6cxXVlB5HwI=
=/aWI
-----END PGP SIGNATURE-----

--BQNmG3Va1Mf6qH2K--

