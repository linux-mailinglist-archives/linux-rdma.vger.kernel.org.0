Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8F344429B
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Nov 2021 14:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhKCNqD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Nov 2021 09:46:03 -0400
Received: from mail-mw2nam12on2077.outbound.protection.outlook.com ([40.107.244.77]:25440
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230152AbhKCNqD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 3 Nov 2021 09:46:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JErtrs2zlb80tMQbuG6SaO5h57gp5hzmZPr7PfTvWTOFrd0DKfIl0rLu6uVAzrt+q+HEK7Re+UpcTd/p+5pkwiua1qEX6/vrpo4gD5uPWJNeNkz3/AHkaDzR5HefUEfR/nLnPtUXLKOmJdY9uy8QupDe+kSIREm1AIroyopxf0fy22w4lvh0/wJaimd7xRRTYicoq4MysWy0jsDWCazilmCl0eULxM2C4UN2DorZnlYCvPZDyV/mDzQdqONsiGde7oeL4VGvKZVBTW9X9/Qp9I84s6Ph/Gzo1jr9+0oUUUzMeqjApkiy8A2k2X+W0jYQG3PvYg3AQDWarpuWHPQcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4yh7SoDxTEwvHuyGXS/zztKPXWHJu0rcWABHtk9AeY=;
 b=dUj5JMBVQAD9S2NdP25OS3E7TWUiTrIG8XsV6/7yOMhw9iNy6oH1mf/v/O05buZs+1D7rN2G35B+yMR7XK37ObI0qaH2iHw6T0l0PNOv1rfnLoTKFKaytCHXyw/Givyr8PcYPBeCYtzIPWr4zwdfITJE0QMFE3jFWUVvamyp+XE77u6W5TmRPtWaY7/YjEKZ/ISlH/IxYEUQa2ms4p67gHw5u8+NXq8IUWJF5lyejmvvU9IuBDdBCc+VMvQcZe/jLcBlg5LiH/b3PNMz8LhCv/JT5Nr5JHFD8IzGl7hDzaL/V2zn3IsdZMUuBfZwl7vIy1CxmmHv+1li4KKq2jCE9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4yh7SoDxTEwvHuyGXS/zztKPXWHJu0rcWABHtk9AeY=;
 b=UguNtnzYziB0lyszNTg5+37n2DZTbluPJEBK778jJFjOTROIVfVwmhazCgtHFNWKVWDLJEIilUMLfMI3G4RH249HUvr3eOazUjtuqPnKVEA5RogCZfGbDlmXQ0AoTp3L5izxZqYeQvqsUqQf57HyZad0x4RcnUkDOYMY/kEOOkc8vqW62zQ/NMBnBk+JXn02SMaP/vEGW6Tlfj1sUJbAk98DsmOumPJbPy4FrPHv/kQBOsUDuLlhCluja3hTee/Yb71O61x+8iLIbbSUqptuo+FxczWDXI9r3e1Y42mHCNT4nOwxOu8scagiiqRx+wA+XJu7L+6zii14cxgkbIIgZw==
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM4PR12MB5245.namprd12.prod.outlook.com (2603:10b6:5:398::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15; Wed, 3 Nov 2021 13:43:25 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::8817:6826:b654:6944]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::8817:6826:b654:6944%6]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 13:43:25 +0000
Date:   Wed, 3 Nov 2021 10:43:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20211103134323.GA1344917@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
X-ClientProxiedBy: BL1P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::14) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Wed, 3 Nov 2021 13:43:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1miGXz-005e0G-HL; Wed, 03 Nov 2021 10:43:23 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a574e8fb-9fa6-450e-10ed-08d99ecfe8a8
X-MS-TrafficTypeDiagnostic: DM4PR12MB5245:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5245069A81D3E38450C410EDC28C9@DM4PR12MB5245.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:89;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ty9X4C66lZGpzGJ1AxvxAu3H6xKNWvAswCL56u3RQWlxxpx7/VH2kBrYAREn43MwGskeWQjeeVtOzhNzFYXFF634s+7ESBgTa/ZuupiaC3hIVpwGWM+6NM9UiJAumto5R2mF46ezJ/Vt7Rf4rE7LLxXwF3hI4supn78HMmUkZ9LZWWdqfQXHIL+9pBQHJw4dwIaFjYF9vKHaJI4lkP8+BkO0DwQP+C4Hv5Ro4hF3B3LyFeZpxKfNkpgpYWIs+gPZsSZW7RaLczu9mMi3ZJ8fKAZsvU74VP0ohU62EKH1bTAU2htDi+2B0FBOx4RB8wIAtd+Mw6b3GLNUTqBVYyyvfQBBH0RjXWLYaEfYatNoz550MMpFPmC8hGrrYdzvkXVb3pxDRbUsTbiihE91KO6RGtTCIb9XfFKZsibl6K3QhR8S9CHmKihE6Lf05tgnSjpRcbIuJ1zzbeu4UVMRdY4a0uPOUmTNqDFNYfkAkjhicKkKA8Jgwc6SynQukyWroCm5wFnuIwxuULyCuir+TSdxgFPtgAh7OcziJU1wl1mKdaZ46LKIEvc/mRxt1idXA/zftHZYGr+S/rvGhWX5UorgW2f8jhslzO3dvKXoKtSm6QSa/AZLmodSMUF86RYbisszMzDRkzyITrWKdyotW/Tf1ktUSyGnaNg8gLSzaO12xjw9Q6Vai3HUK2Y2Mjz5JP/y2Lfe7AjbNRQBqvsXibeBJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(8676002)(66476007)(66946007)(2906002)(9746002)(33656002)(38100700002)(9786002)(26005)(110136005)(30864003)(426003)(21480400003)(186003)(66556008)(5660300002)(83380400001)(86362001)(8936002)(4001150100001)(44144004)(4326008)(508600001)(1076003)(2616005)(36756003)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hNv3EAIfgk5HZXKufbJZnhhKNFA4EZ/YDfvse4G0uehmaeaktWWE+iCPw/lB?=
 =?us-ascii?Q?JHINX3dNd6+CKBXFCcbkN8LDP9ML6kDgTabrbCAsZBSjzX/teGikNnauW10c?=
 =?us-ascii?Q?tIqRrlVjAQq4CduSeM9H6La7dRnvpScP7FHjJJjB+3u/i4K5MJZeGd4zXp5A?=
 =?us-ascii?Q?R9EUIjWuN3ipYe3EdNSVtQWxzvvpFfXv6ewUHPS/Cptn0CII2lEyX4zIlWzq?=
 =?us-ascii?Q?PKsVoyu0puFijiiDwd0vCD8BfhlU0uv/n205n20k1TJYSTuS4SE3xl2DrYEH?=
 =?us-ascii?Q?OQ4GG4tFZz71vrhNv5ZplOcQeirCu0BcJq4nIKdBQn0/5u3mNNDcuD8IE7LC?=
 =?us-ascii?Q?+noEKbXn020OONguC0mNwCw7Rk6cJ4ygPgniaRavvHvhiUaJLzbOJj1JNwIA?=
 =?us-ascii?Q?OyGZNk/tzE+AlhXnLiV2fX7eWl2uWygnvDKeXbXXEAX4ljdILBhz5kajjzCO?=
 =?us-ascii?Q?J2202BEB3poqy54bgL3hxprcu4nTBQvG8+2VoThDy7UVXADK85KPi9KX1lV8?=
 =?us-ascii?Q?knGn+0z18x0D+pJfN77fXbjFxIDasoL0okVt9uJiIiAxUVt9d2kL6w3IIIyK?=
 =?us-ascii?Q?OCYapH2cbA7TcdYoy7DRTfL4lBkWM443STaApoRFdlZx3cJstjLdwCJ91BPe?=
 =?us-ascii?Q?bb3Pi2OWGmofd6jPDxRQgdMIGnMFa8abpOfnoMKYdaM1i1bMhM8cWcPGn/ux?=
 =?us-ascii?Q?Lddq9Y0arhMFQBJTf9ZsRDJ27fbwu524q1xwzDzRfM+akHt1GoEVBDIs6c+U?=
 =?us-ascii?Q?cmqBHbMhNs0iwecbifU/FIOwOVln8kJxMQjIzoNaC3lGJxCvRKInz14ilIWR?=
 =?us-ascii?Q?anEXhxtHbrbr6/w6JZw177P9kJ9tBuvVPyeiZa/3vdW6F/ERCkbpclhULEga?=
 =?us-ascii?Q?ePja/Wsbj/+I7kqS5wG7C8VuA8zF9EqDBZk/7c/WXH14lYr6TKU5xkBRI/z7?=
 =?us-ascii?Q?IbNjLy+xriIVNNOxKJbFeJIf89qouC2OACVCvbCySp3uXlleYijsnVsgN82A?=
 =?us-ascii?Q?/CQSOofNJD4Yhg6BDXc4fhhYEADU4JgvJG7mZCXWFIMoiJU4KHtGYjo4IrQs?=
 =?us-ascii?Q?mVFXGGQBqwuOLy+qOWB7BMDjwXfX4gSvT8vMW/m5qg3yBY1SAo3wWfICi+jL?=
 =?us-ascii?Q?DiPkk4l4auNbxhBiJATfG6juWOY2Ojm8i9mK4JoXVyO1LsGsXfkLH35y5EHy?=
 =?us-ascii?Q?x+UFNZ2IKQygLDLzXNa3YYTUW+bf+fXfZqBYf0Bw0HaKEI2cYeAzE05VaSVb?=
 =?us-ascii?Q?b1fr8qH2yIyW7VgtWBF0B9NZUb+Y1oCKvLKnx8EeR3KsZTGEGjNQYdFAK/TC?=
 =?us-ascii?Q?4HDJqHnRSHoWiP+elvkp9sHU3Ymw35D+vPVsYJvaL2+R/1f/MDsYIASreVTd?=
 =?us-ascii?Q?BUBZ3lpoJLviXr+Qp2fvZp6uP1XzbO/hlMxwtpbwtzPHBy/yrdrpGpJo57Vy?=
 =?us-ascii?Q?BFD/KBKmX24AmqPLuzNRa6u2kmc9TPSi/iE6ecPs5Zd08FsUYWClHj/Yq0VT?=
 =?us-ascii?Q?OaTLG3yNqJdc0XSLJTVqP30XOtr8th1HzHGweSlEbEA88C+GwS7WCSSuMTfs?=
 =?us-ascii?Q?Xr/4wkQnSr9AtE8vnsY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a574e8fb-9fa6-450e-10ed-08d99ecfe8a8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 13:43:25.0444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiFLAvn3doBOhwLShxJMcaaRMGSSIFwtusp5j97XvmOHHXw0Cylj6ZuKpRuGyNR2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5245
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

These are the proposed RDMA patches for 5.16.

Not a very exciting cycle, we again meet the now-normal PR size that
is predominately fixes with a few driver features.

Thanks,
Jason

The following changes since commit 8bb7eca972ad531c9b149c0a51ab43a417385813:

  Linux 5.15 (2021-10-31 13:53:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to f1a090f09f42be5a5542009f0be310fdb3e768fc:

  RDMA/core: Require the driver to set the IOVA correctly during rereg_mr (2021-11-03 09:37:52 -0300)

----------------------------------------------------------------
RDMA v5.16 merge window pull request

A typical collection of patches this cycle, mostly fixing with a few new
features:

- Fixes from static tools. clang warnings, dead code, unused variable,
  coccinelle sweeps, etc

- Driver bug fixes and minor improvements in rxe, bnxt_re, hfi1, mlx5,
  irdma, qedr

- rtrs ULP bug fixes an improvments

- Additional counters for bnxt_re

- Support verbs CQ notifications in EFA

- Continued reworking and fixing of rxe

- netlink control to enable/disable optional device counters

- rxe now can use AH objects for its UD path, fixing various bugs in the
  process

- Add DMABUF support to EFA

----------------------------------------------------------------
Aharon Landau (12):
      RDMA/mlx5: Avoid taking MRs from larger MR cache pools when a pool is empty
      RDMA/counter: Add a descriptor in struct rdma_hw_stats
      RDMA/counter: Add an is_disabled field in struct rdma_hw_stats
      RDMA/counter: Add optional counter support
      RDMA/nldev: Add support to get status of all counters
      RDMA/nldev: Split nldev_stat_set_mode_doit out of nldev_stat_set_doit
      RDMA/nldev: Allow optional-counter status configuration through RDMA netlink
      RDMA/mlx5: Support optional counters in hw_stats initialization
      RDMA/mlx5: Add steering support in optional flow counters
      RDMA/mlx5: Add modify_op_stat() support
      RDMA/mlx5: Add optional counter support in get_hw_stats callback
      RDMA/core: Require the driver to set the IOVA correctly during rereg_mr

Alok Prasad (1):
      RDMA/qedr: Fix NULL deref for query_qp on the GSI QP

Andy Shevchenko (1):
      IB/hf1: Use string_upper() instead of an open coded variant

Arnd Bergmann (1):
      RDMA/mlx5: fix build error with INFINIBAND_USER_ACCESS=n

Bob Pearson (11):
      RDMA/rxe: Add memory barriers to kernel queues
      RDMA/rxe: Cleanup MR status and type enums
      RDMA/rxe: Separate HW and SW l/rkeys
      RDMA/rxe: Create duplicate mapping tables for FMRs
      RDMA/rxe: Only allow invalidate for appropriate MRs
      RDMA/rxe: Move AV from rxe_send_wqe to rxe_send_wr
      RDMA/rxe: Change AH objects to indexed
      RDMA/rxe: Create AH index and return to user space
      RDMA/rxe: Replace ah->pd by ah->ibah.pd
      RDMA/rxe: Lookup kernel AH from ah index in UD WQEs
      RDMA/rxe: Convert kernel UD post send to use ah_num

Cai Huoqing (1):
      RDMA/hns: Use dma_alloc_coherent() instead of kmalloc/dma_map_single()

Chengchang Tang (1):
      RDMA/hns: Use the core code to manage the fixed mmap entries

Christophe JAILLET (3):
      RDMA: Remove redundant 'flush_workqueue()' calls
      RDMA/rxe: Save a few bytes from struct rxe_pool
      RDMA/rxe: Use 'bitmap_zalloc()' when applicable

Colin Ian King (1):
      RDMA/iwpm: Remove redundant initialization of pointer err_str

Edwin Peer (1):
      RDMA/bnxt_re: Use separate response buffer for stat_ctx_free

Gal Pressman (4):
      RDMA/efa: CQ notifications
      dma-buf: Fix pin callback comment
      RDMA/umem: Allow pinned dmabuf umem usage
      RDMA/efa: Add support for dmabuf memory regions

Gustavo A. R. Silva (1):
      RDMA/hfi1: Use struct_size() and flex_array_size() helpers

Haoyue Xu (1):
      RDMA/hns: Fix initial arm_st of CQ

Jack Wang (2):
      RDMA/rtrs: Fix warning when use poll mode on client side.
      RDMA/rtrs: Replace duplicate check with is_pollqueue helper

Jakub Kicinski (3):
      RDMA/ipoib: Use dev_addr_mod()
      RDMA/mlx5: Use dev_addr_mod()
      RDMA: Constify netdev->dev_addr accesses

Jason Gunthorpe (8):
      Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      IB/mlx5: Flow through a more detailed return code from get_prefetchable_mr()
      Merge tag 'v5.15-rc4' into rdma.get for-next
      RDMA/cma: Split apart the multiple uses of the same list heads
      Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge brank 'mlx5_mkey' into rdma.git for-next
      Merge tag 'v5.15' into rdma.git for-next
      Merge branch 'for-rc' into rdma.git for-next

Joe Perches (1):
      RDMA/rxe: Make rxe_type_info static const

Junji Wei (1):
      RDMA/rxe: Fix wrong port_cap_flags

Kamal Heib (5):
      RDMA/qedr: Remove unsupported qedr_resize_cq callback
      RDMA/bnxt_re: Fix kernel panic when trying to access bnxt_re_stat_descs
      RDMA/bnxt_re: Use helper function to set GUIDs
      RDMA/qed: Use helper function to set GUIDs
      RDMA/bnxt_re: Remove unsupported bnxt_re_modify_ah callback

Leon Romanovsky (1):
      RDMA/mlx4: Return missed an error if device doesn't support steering

Logan Gunthorpe (2):
      RDMA/rw: switch to dma_map_sgtable()
      RDMA/core: Set sgtable nents when using ib_dma_virt_map_sg()

Mark Zhang (2):
      RDMA/core: Add a helper API rdma_free_hw_stats_struct
      RDMA/core: Fix missed initialization of rdma_hw_stats::lock

Md Haris Iqbal (5):
      RDMA/rtrs: Use sysfs_emit instead of s*printf function for sysfs show
      RDMA/rtrs: Remove len parameter from helper print functions of sysfs
      RDMA/rtrs: Introduce destroy_cq helper
      RDMA/rtrs: Do not allow sessname to contain special symbols / and .
      RDMA/rtrs-clt: Follow "one entry one value" rule for IO migration stats

Mike Marciniszyn (6):
      IB/hfi1: Remove cache and embed txreq in ring
      IB/hfi1: Get rid of hot path divide
      IB/hfi1: Get rid of tx priv backpointer
      IB/hfi1: Tune netdev xmit cachelines
      IB/hfi1: Remove atomic completion count
      IB/hfi1: Add ring consumer and producers traces

Rao Shoaib (1):
      RDMA/rxe: Bump up default maximum values used via uverbs

Scott Breyer (3):
      IB/hfi1: Rebranding of hfi1 driver to Cornelis Networks
      IB/qib: Rebranding of qib driver to Cornelis Networks
      IB/opa_vnic: Rebranding of OPA VNIC driver to Cornelis Networks

Selvin Xavier (10):
      RDMA/bnxt_re: Add extended statistics counters
      RDMA/bnxt_re: Update statistics counter name
      RDMA/bnxt_re: Reduce the delay in polling for hwrm command completion
      RDMA/bnxt_re: Support multiple page sizes
      RDMA/bnxt_re: Suppress unwanted error messages
      RDMA/bnxt_re: Fix query SRQ failure
      RDMA/bnxt_re: Fix FRMR issue with single page MR allocation
      RDMA/bnxt_re: Use GFP_KERNEL in non atomic context
      RDMA/bnxt_re: Correct FRMR size calculation
      RDMA/bnxt_re: Check if the vlan is valid before reporting

Xiao Yang (7):
      RDMA/rxe: Add new RXE_READ_OR_WRITE_MASK
      RDMA/rxe: Add MASK suffix for RXE_READ_OR_ATOMIC and RXE_WRITE_OR_SEND
      RDMA/rxe: Remove unused WR_READ_WRITE_OR_SEND_MASK
      RDMA/rxe: Remove the is_user members of struct rxe_sq/rxe_rq/rxe_srq
      RDMA/rxe: Change the is_user member of struct rxe_cq to bool
      RDMA/rxe: Set partial attributes when completion status != IBV_WC_SUCCESS
      RDMA/rxe: Remove duplicate settings

Yixing Liu (1):
      RDMA/hns: Modify the value of MAX_LP_MSG_LEN to meet hardware compatibility

Zhu Yanjun (11):
      RDMA/rxe: remove the redundant variable
      RDMA/rxe: remove the unnecessary variable
      RDMA/irdma: Delete unused struct irdma_bth
      RDMA/irdma: Remove irdma_uk_mw_bind()
      RDMA/irdma: Remove irdma_sc_send_lsmm_nostag()
      RDMA/irdma: Remove irdma_get_hw_addr()
      RDMA/irdma: Remove irdma_cqp_up_map_cmd()
      RDMA/irdma: Make irdma_uk_cq_init() return a void
      RDMA/irdma: Remove the unused spin lock in struct irdma_qp_uk
      RDMA/irdma: Remove the unused variable local_qp
      RDMA/irdma: optimize rx path by removing unnecessary copy

wangyugui (1):
      RDMA/core: Use kvzalloc when allocating the struct ib_port

 drivers/infiniband/core/cma.c                      |  34 +-
 drivers/infiniband/core/cma_priv.h                 |  11 +-
 drivers/infiniband/core/counters.c                 |  40 ++-
 drivers/infiniband/core/device.c                   |   1 +
 drivers/infiniband/core/iwpm_util.c                |   2 +-
 drivers/infiniband/core/nldev.c                    | 278 ++++++++++++---
 drivers/infiniband/core/rw.c                       |  66 ++--
 drivers/infiniband/core/sa_query.c                 |   1 -
 drivers/infiniband/core/sysfs.c                    |  58 ++--
 drivers/infiniband/core/umem_dmabuf.c              |  51 +++
 drivers/infiniband/core/uverbs_cmd.c               |   3 -
 drivers/infiniband/core/verbs.c                    |  49 +++
 drivers/infiniband/hw/bnxt_re/bnxt_re.h            |  19 +-
 drivers/infiniband/hw/bnxt_re/hw_counters.c        | 380 +++++++++++++--------
 drivers/infiniband/hw/bnxt_re/hw_counters.h        |  30 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |  45 ++-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h           |   1 -
 drivers/infiniband/hw/bnxt_re/main.c               |  16 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  15 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |   6 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h         |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c          |  22 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h          |  10 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |  57 +++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h           |  33 +-
 drivers/infiniband/hw/bnxt_re/roce_hsi.h           |  85 +++++
 drivers/infiniband/hw/cxgb4/cm.c                   |   1 -
 drivers/infiniband/hw/cxgb4/device.c               |   1 -
 drivers/infiniband/hw/cxgb4/provider.c             |  22 +-
 drivers/infiniband/hw/efa/efa.h                    |  23 +-
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h    | 100 +++++-
 drivers/infiniband/hw/efa/efa_admin_defs.h         |  41 +++
 drivers/infiniband/hw/efa/efa_com.c                | 164 +++++++++
 drivers/infiniband/hw/efa/efa_com.h                |  38 ++-
 drivers/infiniband/hw/efa/efa_com_cmd.c            |  35 +-
 drivers/infiniband/hw/efa/efa_com_cmd.h            |  10 +-
 drivers/infiniband/hw/efa/efa_main.c               | 182 ++++++++--
 drivers/infiniband/hw/efa/efa_regs_defs.h          |   7 +-
 drivers/infiniband/hw/efa/efa_verbs.c              | 213 +++++++++---
 drivers/infiniband/hw/hfi1/Kconfig                 |   4 +-
 drivers/infiniband/hw/hfi1/chip.c                  |   3 +-
 drivers/infiniband/hw/hfi1/driver.c                |   3 +-
 drivers/infiniband/hw/hfi1/efivar.c                |  10 +-
 drivers/infiniband/hw/hfi1/init.c                  |   3 +-
 drivers/infiniband/hw/hfi1/ipoib.h                 |  82 +++--
 drivers/infiniband/hw/hfi1/ipoib_main.c            |   2 +-
 drivers/infiniband/hw/hfi1/ipoib_tx.c              | 316 ++++++++---------
 drivers/infiniband/hw/hfi1/trace_tx.h              |  71 +++-
 drivers/infiniband/hw/hfi1/user_exp_rcv.c          |   5 +-
 drivers/infiniband/hw/hfi1/verbs.c                 |  53 +--
 drivers/infiniband/hw/hns/hns_roce_device.h        |  26 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |  10 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  32 +-
 drivers/infiniband/hw/hns/hns_roce_main.c          | 142 ++++++--
 drivers/infiniband/hw/irdma/cm.h                   |  12 +-
 drivers/infiniband/hw/irdma/ctrl.c                 |  43 +--
 drivers/infiniband/hw/irdma/hw.c                   |   7 +-
 drivers/infiniband/hw/irdma/main.h                 |   5 +-
 drivers/infiniband/hw/irdma/osdep.h                |   1 -
 drivers/infiniband/hw/irdma/protos.h               |   2 -
 drivers/infiniband/hw/irdma/trace_cm.h             |   8 +-
 drivers/infiniband/hw/irdma/type.h                 |   3 +-
 drivers/infiniband/hw/irdma/uk.c                   | 101 ++----
 drivers/infiniband/hw/irdma/user.h                 |  32 +-
 drivers/infiniband/hw/irdma/utils.c                |  49 +--
 drivers/infiniband/hw/irdma/verbs.c                | 146 ++++----
 drivers/infiniband/hw/mlx4/alias_GUID.c            |   4 +-
 drivers/infiniband/hw/mlx4/main.c                  |  44 ++-
 drivers/infiniband/hw/mlx4/mlx4_ib.h               |   2 +-
 drivers/infiniband/hw/mlx4/qp.c                    |   4 +-
 drivers/infiniband/hw/mlx5/counters.c              | 283 ++++++++++++---
 drivers/infiniband/hw/mlx5/fs.c                    | 187 ++++++++++
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |  28 +-
 drivers/infiniband/hw/mlx5/mr.c                    |  26 +-
 drivers/infiniband/hw/mlx5/odp.c                   |  40 ++-
 drivers/infiniband/hw/qedr/main.c                  |   1 -
 drivers/infiniband/hw/qedr/verbs.c                 |  25 +-
 drivers/infiniband/hw/qedr/verbs.h                 |   1 -
 drivers/infiniband/hw/qib/qib_driver.c             |   5 +-
 drivers/infiniband/hw/usnic/usnic_fwd.c            |   2 +-
 drivers/infiniband/hw/usnic/usnic_fwd.h            |   2 +-
 drivers/infiniband/sw/rxe/rxe_av.c                 |  20 +-
 drivers/infiniband/sw/rxe/rxe_comp.c               |  55 ++-
 drivers/infiniband/sw/rxe/rxe_cq.c                 |  28 +-
 drivers/infiniband/sw/rxe/rxe_hw_counters.c        |  42 +--
 drivers/infiniband/sw/rxe/rxe_loc.h                |   2 +
 drivers/infiniband/sw/rxe/rxe_mr.c                 | 275 +++++++++++----
 drivers/infiniband/sw/rxe/rxe_mw.c                 |  36 +-
 drivers/infiniband/sw/rxe/rxe_opcode.h             |   6 +-
 drivers/infiniband/sw/rxe/rxe_param.h              |  34 +-
 drivers/infiniband/sw/rxe/rxe_pool.c               |  41 ++-
 drivers/infiniband/sw/rxe/rxe_pool.h               |  15 -
 drivers/infiniband/sw/rxe/rxe_qp.c                 |  16 +-
 drivers/infiniband/sw/rxe/rxe_queue.c              |  30 +-
 drivers/infiniband/sw/rxe/rxe_queue.h              | 374 +++++++++-----------
 drivers/infiniband/sw/rxe/rxe_req.c                |  65 ++--
 drivers/infiniband/sw/rxe/rxe_resp.c               |  50 +--
 drivers/infiniband/sw/rxe/rxe_srq.c                |   3 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              | 139 +++-----
 drivers/infiniband/sw/rxe/rxe_verbs.h              |  62 ++--
 drivers/infiniband/sw/siw/siw_cm.c                 |   4 +-
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            |   4 +-
 drivers/infiniband/ulp/ipoib/ipoib_ib.c            |   9 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |  18 +-
 drivers/infiniband/ulp/opa_vnic/Kconfig            |   4 +-
 drivers/infiniband/ulp/opa_vnic/Makefile           |   3 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c    |   7 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c       |  55 +--
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c       |  11 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |   6 +
 drivers/infiniband/ulp/rtrs/rtrs-clt.h             |  13 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h             |   2 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c       |   3 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c       |   2 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             |   6 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.h             |   3 +-
 drivers/infiniband/ulp/rtrs/rtrs.c                 |  31 +-
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |   8 +-
 drivers/net/ethernet/qlogic/qed/qed_rdma.c         |  17 +-
 include/linux/dma-buf.h                            |   4 +-
 include/rdma/ib_hdrs.h                             |   1 +
 include/rdma/ib_umem.h                             |  11 +
 include/rdma/ib_verbs.h                            |  74 ++--
 include/rdma/rdma_counter.h                        |   2 +
 include/uapi/rdma/efa-abi.h                        |  18 +-
 include/uapi/rdma/rdma_netlink.h                   |   5 +
 include/uapi/rdma/rdma_user_rxe.h                  |  10 +-
 127 files changed, 3655 insertions(+), 1946 deletions(-)
(diffstat from tag for-linus-merged)

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmGCkfkACgkQOG33FX4g
mxr/eg//dYJnP0n7q/69QFwIP/nV/AmEBi5yTP5qtAZ+0rhZiohEIF3ApMZ8mS+9
GF+AdZEiT+HMGnzazltWsE9MXedoBoqirkJnWF4dvnV+JE8GsNxxxTIVkUIgg3ag
b3q5cwuqs8Qt74xaU5hU2+04qjfaJlTliaAZQSq+JLL+clAPOujoB8S68/1gSwpF
vmYb5cgOiJupQ/DsOtqw3JVN2MJ+hFqtUgmMFHckAWp+3v3/9bl0g2SeJCoAjPZc
+78DWuXK1i733jlN9h2DFhovWNmyaXSOL+nzu2oRRLJKsSOaNk800e1bmbcg9qJ9
iIngFH+zpnP2v+HjbhsBdO0b80OOiCcZlOvgCRKz2SXZlQ+J6/zy7YVs5Wcp3XCO
eDRYLX7KOo1hxOTzkixv57OpCgTf2zd4EpCGmgr7uXfmPnEqyLhcHe9BYhpbEE5I
hLdE8qWOFkBDf8SZSM+osmmzbV4DM/hGgQz+nHgxK3Y7RNVblqid4fI1A6kYALJE
BYVx54k7VJIlv92HJxJnafCGeX7T9Chu48O31VqD9HHF/dSr1dutfSTL8e7q1sqK
VeLRNe+H/bOsd3XCKH7+WRtMzgB+6PTOsEK8tMFCfui32hcElg/MGQEzRpoIXUQS
Tq/U+eyPZXgPX5uVJbFOdrWMNCm2ejcYlbcv/Mc+EprfzmWob2g=
=ToxR
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
