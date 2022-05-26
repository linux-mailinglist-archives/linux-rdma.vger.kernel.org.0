Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828645350F1
	for <lists+linux-rdma@lfdr.de>; Thu, 26 May 2022 16:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242818AbiEZOqU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 May 2022 10:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242198AbiEZOqT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 May 2022 10:46:19 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2072.outbound.protection.outlook.com [40.107.102.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471FADC;
        Thu, 26 May 2022 07:46:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alaEJGTQJx1BUVl0q+HT9LB9WpQkxYCNDw9wgoQNPmFX3H9ZWZFzbTnoFuXelslWHecZkvXtfgo0nCVZH9TwRiR9sf7BZv9HRJk3h317l75jL5T/uhugUv+QMzmc/JMg0314MFDY3cq/I0ZaDhQUUDwb5BbTzdURKd1VGxIyKmehauk6FFpkMSGslFcAHRKPygq7gCRMdxWI7uKD6Uoj3g1RZIEpH1zbmE0zYeg0kpmfiQpuKMYI4T57xQVT34GDoRMLd43Mou8ujgCl64AbeQwx8kVQOZrkQEFjZMnRfE6iK/RZy6RYwG8sBeUBjcJSHa0abJ4xZUDQaSIKS5uAPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdIkj0iWPkUvAO4N1hucLg49Q4oKmYqk9IEzSjpM3r8=;
 b=adaZZHtSwBHzs2W85zu9snkijzHqgrLM7sQIn8AhfFGT/7dkyCMgPTciA4/DFaUiXX8YRho+uvJLbhgLUjTkvZZTg7/cw+3VgB0JiJWF7Ic9lTaQOdsfHUh7e96yat9xafBCU3lBiL3K7/lvjigbhH1J8txLJvO2iOTR4VrOjZVclwpDPa6UePyuE2n7w/l/kPdpJh1LYSx0HwVh7UyKSQ+vjtn/UgLF/XprbiZI9ANB8TMRhtSwryjZTfgma312UyHPHae6K1HXErTjo73q+2rJ2dpOn5bsTqx7RJy+56DNJUWGqOw14pOCPf8m419conapKsQkDyoFQ2bDF5hkWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdIkj0iWPkUvAO4N1hucLg49Q4oKmYqk9IEzSjpM3r8=;
 b=MEfYZUfXZgBXwmkOo9p0o2J8WboVdanTwXIibgAH2mBUJqdCGs0N7l+6gVGnNjklHM12qlDQ/vWJvl0sQyMpntmfoaSPI94FSmzGGOkVGfdvb1EPU4B5yJfkLf/yu1m0Cin6QK4mxhzXIPTXiWb3On4DXx7m3IfMmbPSjFREpg1URu3DlfAiyKQl9tjrA1he8WSdhLABCTWJzKJG4B+54FPXt97NlcSqRTkb1x+Z3MqoSgaIaD5XFGoEmfwdeB91TutBBmE5N88Yu6V2vvcRpOkBDwjDOt05SraPoi67XB5xUnwrinONqkqnU6rWE/LgjKw0ZHxxv8kHlQ/CGT0w4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN9PR12MB5195.namprd12.prod.outlook.com (2603:10b6:408:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 14:46:16 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 14:46:16 +0000
Date:   Thu, 26 May 2022 11:46:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20220526144615.GA3087820@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR22CA0028.namprd22.prod.outlook.com
 (2603:10b6:208:238::33) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 869ddda1-371f-4fe1-97ba-08da3f267cc9
X-MS-TrafficTypeDiagnostic: BN9PR12MB5195:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB51959A42D0DCD73EF04F7D92C2D99@BN9PR12MB5195.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uNiO4dIysdQtvgcD7mOCY1PcAE/iDslIzez1g+ouC7FdX198AJetN1o80SixWY2vYIebC+wk/CiIh3Cd+VGpKU1mNS7+RJ3Yaxi9U3RDVnW8YaJjjaMLCbamny2eaMTNRfu9SrC0WgMUfBOwoANr0wRVVHP/oDK/wPHI/dHJ49vVysDi7qgfCDyLIFsyRbvPZf92FiMfHEwcG2vhWUEtJu8vrt9FP9hINU08tJ5MvWHkzOdHnwe+bs8j6XuieJcmdCOLcLxR7pXifZBh5FgvPIT4GyzBPEGj/QH41Bhc7KhMMLHgSy72sdrUm+7xWvvXq98aE2kpkIwzQ1PjkjaBVC0QwqB+OYnXL18x0HbnJm2og9EBuU/N1XrRQ27lKFQ+VWCE8DBKbAI4vS4kAQzsgWM+ReOBmPkfK7EQeE2NeOSud2aOzgWnHDQxCsj2bD45J3Au9YIC869vwWisdPO9n8rZNkFctmS9FdqZjN3/a1oUVXr7XNghnx9XstyUJm3X+VcevII3FHbpC/XXAL/nvMHqtD4zgnbcnwSQv8WAiLpZT35ono6krhh1/H6Gx+SPMFYgWT722FebV1WR5Rs6JPJ15+FSiveekJKd+BQEugBP3uJNB1tqR+k0P/EuZN7pLq/cx/2S1rtHbH34lxQUSJI0tRnSYbOp7hZ8TepdcmDPkxhAPIQb4qsrMacJLBIEpgYYbYw8PV6ofpF3pDWykd2Z70AXNkchhk3URV/p4LHK3tEd40sw3VZ/iw3e8WM68swUNiOPE8EaoJIrunQlxUDOfs+fDK9WlpYOLkk1ea4bB2nfqnLbzDvj7w/2TXy+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66556008)(66476007)(8676002)(4326008)(5660300002)(8936002)(6512007)(21480400003)(508600001)(83380400001)(6486002)(33656002)(966005)(6506007)(1076003)(316002)(44144004)(6916009)(186003)(86362001)(2906002)(36756003)(26005)(107886003)(2616005)(38100700002)(21314003)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LQ+IJ/3jsNNWuG724NIzlQjf7GLRhyYarWkf5Djqv3T/UQIGzpmXZFbwe+c4?=
 =?us-ascii?Q?zUJTGmaiYMvWJGhZicWU46B/B0j8p2n5xf9muQH2lAZhKxTN/vOJfNVuNjpX?=
 =?us-ascii?Q?1aX1mJgzBqz2qhBMNhFwM8Q7MgzM1cVHSvK6iXMH0vC1dID2BbIS02VZSAK+?=
 =?us-ascii?Q?VvR+Lk5gapfxp+eQPwJjT9LJtMKr3waj5iu64W4eTil04A1Ri06Uo+cXj58t?=
 =?us-ascii?Q?rXXwWJZCmjywrCJu/zGfzuUtS+/U4gBrbSPSdNz13U4+rB7qNi/TVVSDEEgC?=
 =?us-ascii?Q?NiQy3dFnjyYThdFpvRtbp7Na9nLe4QrKzqrXjg8W1SY4PB9o/i72we8vMsSW?=
 =?us-ascii?Q?Gh1GdOS2N+dyA2XEQQG3eU++G3OAKNApQDgQwF6OR9oF7A8+9gVIsudKnEPX?=
 =?us-ascii?Q?oGZulgvuagz68YVpU60ErpbGZSXev4scpiXBcYSRPfp6pEaN/iJQnAC1P04V?=
 =?us-ascii?Q?g/znTong4yhVDnY32no/moPaqUgevgyQ1wfPamnsTpbrDiMOU+WkNXuMcceH?=
 =?us-ascii?Q?KQNWgthB0zQ741auunrELieW6FaIsD+M3pyd5Fd7o92eG8l/DEMNOftPj0zo?=
 =?us-ascii?Q?XZ7MIJWycckWKcK13AYPiGjXGzutSrm+1EKcK8mtJMU1Ub2zNISVJhwXC2Cv?=
 =?us-ascii?Q?bSprTNIc5Cmppz3n9TPW1xXHoNWizrj1uD6k70Y3O64L5tlU1jvJeyzMs5LY?=
 =?us-ascii?Q?Z1BJpwhWdPNUBentSeelKExFpG/rTLI09Kq4fxRpzzMN83cdG1YKWh466cEI?=
 =?us-ascii?Q?xyu7iSo0gL54B4Yi6+uKY4pdMSrsrK+fK7cFLl+QghJocRuJ7l1WsunVnT1t?=
 =?us-ascii?Q?JY/1Bs+0pAXR+cKhC8Fx+1igqfkk79+a9IxDfigZeoCPY97bg1PRlCFbbaIx?=
 =?us-ascii?Q?5mvmbT5HQDV/dunyGFj2S0Qef6Ibt8C1iSsDN965uMG3QsUkmw5jHF8EoF93?=
 =?us-ascii?Q?LGYgni5xKN42iNoGh3bgV0UXTv7Vw2kui/J0beYQ/LWW9RTiA4FW8wDogZIk?=
 =?us-ascii?Q?+JabHgXecY2zQf2t4Mno287/j3utPgk1oPa71nVnRT8ipJphyIoenkJ2K1wC?=
 =?us-ascii?Q?yJLlAir1M9PPABmd9k/AcVBP9/jL9lvZMYKXgLKBm/O4lsce258wd1bnod2u?=
 =?us-ascii?Q?c6C5AJrp/8guhcm7KP3wWM0WSaW+6cvfEa2dnIgwFIOONrqH56n6UEDpNj1Z?=
 =?us-ascii?Q?9DUyeBJdUcrxjvIG89NsZdV/GZSOSK/0mGnKlDl64dv9lm62US1BIMyJ/agV?=
 =?us-ascii?Q?CPK4yq52wk41MxVwahVYiBJFwAywKiXyhYESLt7+E+oDbxQlsnuB42TTrDkf?=
 =?us-ascii?Q?xNlWGg2DLH9AHh28qWsF05qnv4LNdNAqRI+Tu3BktVeT3R58jLFIyNy0bcRw?=
 =?us-ascii?Q?A151Nam+UYpUOvMOuvD+PRV45hbFuQgwriU/LfnNyKPNvFxjcCTcdj6ZjuE3?=
 =?us-ascii?Q?JU6zYXj/ejdJ34Z2PySjh6ZcRFcjdgon9v9jkCqyzhGQYRuTA3poIVpCaECx?=
 =?us-ascii?Q?gY/sftIrHq3FuniY0si936JCnXDaiLfsDGlD3MW3PhCQ4pkmG4n74IfJnfGV?=
 =?us-ascii?Q?K2GdzFTZy2Ksj840Vm+j7SwHsWf2ETwOVvt7Mff63JLldfMZ+YXKFiwhKNlm?=
 =?us-ascii?Q?BTK5ntcNdBHQZef8163s5ZFBmIVAgjztLPWmqqvq2RxfVbHfd78bXm6ZJKCh?=
 =?us-ascii?Q?VeQdUQwegQlBY3NqnK3uJksqegAjgTI3guUusWMMj4ztDwHnPotkk9l/vGk6?=
 =?us-ascii?Q?T1mBQ6riUw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869ddda1-371f-4fe1-97ba-08da3f267cc9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 14:46:16.3114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQHvOkz4l7kCioiHrCap3DCOEMoWbllRTkb0ddXxHOBxzHBRDxBL+MvKEYEXscQ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5195
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The usual batch of RDMA changes, one of the smallest PRs I think
possibly ever. There are two new drivers currently posted that are
likely to make the next cycle.

Thanks,
Jason

The following changes since commit 4b0986a3613c92f4ec1bdc7f60ec66fea135991f:

  Linux 5.18 (2022-05-22 09:52:31 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 9c477178a0a187c4718c228cc6e0692564811441:

  RDMA/rtrs-clt: Fix one kernel-doc comment (2022-05-26 10:54:13 -0300)

----------------------------------------------------------------
v5.19 pull request

Small collection of incremental improvement patches:

- Minor code cleanup patches, comment improvements, etc from static tools

- Clean the some of the kernel caps, reducing the historical stealth uAPI
  leftovers

- Bug fixes and minor changes for rdmavt, hns, rxe, irdma

- Remove unimplemented cruft from rxe

- Reorganize UMR QP code in mlx5 to avoid going through the IB verbs layer

- flush_workqueue(system_unbound_wq) removal

- Ensure rxe waits for objects to be unused before allowing the core to
  free them

- Several rc quality bug fixes for hfi1

----------------------------------------------------------------
Aharon Landau (12):
      RDMA/mlx5: Move init and cleanup of UMR to umr.c
      RDMA/mlx5: Move umr checks to umr.h
      RDMA/mlx5: Move mkey ctrl segment logic to umr.c
      RDMA/mlx5: Simplify get_umr_update_access_mask()
      RDMA/mlx5: Expose wqe posting helpers outside of wr.c
      RDMA/mlx5: Introduce mlx5_umr_post_send_wait()
      RDMA/mlx5: Use mlx5_umr_post_send_wait() to revoke MRs
      RDMA/mlx5: Use mlx5_umr_post_send_wait() to rereg pd access
      RDMA/mlx5: Move creation and free of translation tables to umr.c
      RDMA/mlx5: Use mlx5_umr_post_send_wait() to update MR pas
      RDMA/mlx5: Use mlx5_umr_post_send_wait() to update xlt
      RDMA/mlx5: Clean UMR QP type flow from mlx5_ib_post_send()

Bernard Metzler (1):
      RDMA/siw: Enable siw on tunnel devices

Bob Pearson (12):
      RDMA/rxe: Remove type 2A memory window capability
      RDMA/rxe: Remove mc_grp_pool from struct rxe_dev
      RDMA/rxe: Remove support for SMI QPs from rdma_rxe
      RDMA/rxe: Remove reliable datagram support
      RDMA/rxe: Replace paylen by payload
      RDMA/rxe: Remove IB_SRQ_INIT_MASK
      RDMA/rxe: Add rxe_srq_cleanup()
      RDMA/rxe: Check rxe_get() return value
      RDMA/rxe: Move qp cleanup code to rxe_qp_do_cleanup()
      RDMA/rxe: Move mr cleanup code to rxe_mr_cleanup()
      RDMA/rxe: Move mw cleanup code to rxe_mw_cleanup()
      RDMA/rxe: Enforce IBA C11-17

Chengchang Tang (1):
      RDMA/hns: Remove unnecessary check for the sgid_attr when modifying QP

Chengguang Xu (1):
      RDMA/rxe: Skip adjusting remote addr for write in retry operation

Christophe JAILLET (1):
      RDMA/rxe: Fix an error handling path in rxe_get_mcg()

Daisuke Matsuda (1):
      RDMA/mlx5: Remove duplicate pointer assignment in mlx5_ib_alloc_implicit_mr()

Dennis Dalessandro (4):
      RDMA/hfi1: Fix potential integer multiplication overflow errors
      RDMA/hfi1: Remove pointless driver version
      RDMA/hfi1: Consolidate software versions
      RDMA/hfi1: Remove all traces of diagpkt support

Douglas Miller (2):
      RDMA/hfi1: Prevent use of lock before it is initialized
      RDMA/hfi1: Prevent panic when SDMA is disabled

Guo Zhengkui (1):
      RDMA/hns: Remove unnecessary ret variable from hns_roce_dereg_mr()

Guofeng Yue (1):
      RDMA/hns: Remove redundant variable "ret"

Haoyue Xu (1):
      RDMA/hns: Init the variable at the suitable place

Jakob Koschel (1):
      IB/SA: Replace usage of found with dedicated list iterator variable

Jason Gunthorpe (3):
      RDMA: Split kernel-only global device caps from uverbs device caps
      Merge branch 'mlx5-next' of https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge tag 'v5.18' into rdma.git for-next

Julia Lawall (5):
      IB/iser: Fix typo in comment
      IB/qib: Fix typo in comment
      IB/hf1: Fix typo in comment
      RDMA/core: Fix typo in comment
      IB/core: Fix typo in comment

Leon Romanovsky (1):
      RDMA/mlx5: Fix flow steering egress flow

Li Zhijian (1):
      RDMA/rxe: Remove useless parameters for update_state()

Minghao Chi (1):
      RDMA/qedr: Remove unnecessary synchronize_irq() before free_irq()

Mustafa Ismail (1):
      RDMA/irdma: Add SW mechanism to generate completions on error

Niels Dossche (1):
      IB/rdmavt: add missing locks in rvt_ruc_loopback

Robin Murphy (2):
      RDMA/usnic: Stop using iommu_present()
      RDMA/usnic: Refactor usnic_uiom_alloc_pd()

Tetsuo Handa (3):
      RDMA/core: Avoid flush_workqueue(system_unbound_wq) usage
      IB/isert: Avoid flush_scheduled_work() usage
      RDMA/mlx4: Avoid flush_scheduled_work() usage

Wenpeng Liang (3):
      RDMA/hns: Add judgment on the execution result of CMDQ that free vf resource
      RDMA/hns: Use hr_reg_xxx() instead of remaining roce_set_xxx()
      RDMA/hns: Use hr_reg_read() instead of remaining roce_get_xxx()

Xiao Yang (3):
      IB/uverbs: Move enum ib_raw_packet_caps to uapi
      IB/uverbs: Move part of enum ib_device_cap_flags to uapi
      RDMA/rxe: Generate a completion for unsupported/invalid opcode

Yang Li (1):
      RDMA/rtrs-clt: Fix one kernel-doc comment

Yangyang Li (1):
      RDMA/hns: Add the detection for CMDQ status in the device initialization process

Yixing Liu (2):
      RDMA/hns: Remove unused function to_hns_roce_state()
      RDMA/hns: Remove the num_cqc_timer variable

Zhu Yanjun (2):
      RDMA/irdma: Remove the redundant variable
      RDMA/rxe: Optimize the mr pool struct

 drivers/infiniband/core/device.c              |  24 +-
 drivers/infiniband/core/nldev.c               |   2 +-
 drivers/infiniband/core/sa_query.c            |  16 +-
 drivers/infiniband/core/umem_odp.c            |   2 +-
 drivers/infiniband/core/uverbs_cmd.c          |   2 +-
 drivers/infiniband/core/verbs.c               |   8 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |   2 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |   1 -
 drivers/infiniband/hw/cxgb4/provider.c        |   8 +-
 drivers/infiniband/hw/hfi1/common.h           |  55 --
 drivers/infiniband/hw/hfi1/driver.c           |   6 -
 drivers/infiniband/hw/hfi1/efivar.c           |   2 +-
 drivers/infiniband/hw/hfi1/file_ops.c         |   4 +-
 drivers/infiniband/hw/hfi1/init.c             |   2 +-
 drivers/infiniband/hw/hfi1/sdma.c             |  12 +-
 drivers/infiniband/hw/hfi1/verbs.c            |   4 +-
 drivers/infiniband/hw/hns/hns_roce_device.h   |  32 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 451 +++++++----------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h    | 326 ++++--------
 drivers/infiniband/hw/hns/hns_roce_main.c     |   2 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c       |   3 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c       |  20 -
 drivers/infiniband/hw/hns/hns_roce_restrack.c |  49 +-
 drivers/infiniband/hw/irdma/hw.c              |  35 +-
 drivers/infiniband/hw/irdma/main.h            |   1 -
 drivers/infiniband/hw/irdma/puda.c            |   7 +-
 drivers/infiniband/hw/irdma/utils.c           | 147 ++++++
 drivers/infiniband/hw/irdma/verbs.c           |  60 ++-
 drivers/infiniband/hw/irdma/verbs.h           |  13 +-
 drivers/infiniband/hw/mlx4/cm.c               |  29 +-
 drivers/infiniband/hw/mlx4/main.c             |  18 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h          |   3 +
 drivers/infiniband/hw/mlx5/Makefile           |   1 +
 drivers/infiniband/hw/mlx5/fs.c               |   5 -
 drivers/infiniband/hw/mlx5/main.c             | 124 +----
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  89 +---
 drivers/infiniband/hw/mlx5/mr.c               | 421 +---------------
 drivers/infiniband/hw/mlx5/odp.c              |  64 ++-
 drivers/infiniband/hw/mlx5/qp.c               |   1 +
 drivers/infiniband/hw/mlx5/umr.c              | 700 ++++++++++++++++++++++++++
 drivers/infiniband/hw/mlx5/umr.h              |  97 ++++
 drivers/infiniband/hw/mlx5/wr.c               | 377 +++-----------
 drivers/infiniband/hw/mlx5/wr.h               |  60 +++
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |   2 +-
 drivers/infiniband/hw/qedr/main.c             |   1 -
 drivers/infiniband/hw/qedr/verbs.c            |   3 +-
 drivers/infiniband/hw/qib/qib.h               |   2 +-
 drivers/infiniband/hw/usnic/usnic_ib_main.c   |  11 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |   6 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c      |  15 +-
 drivers/infiniband/hw/usnic/usnic_uiom.h      |   3 +-
 drivers/infiniband/sw/rdmavt/qp.c             |   6 +-
 drivers/infiniband/sw/rxe/rxe.c               |   1 +
 drivers/infiniband/sw/rxe/rxe_comp.c          |   3 +-
 drivers/infiniband/sw/rxe/rxe_loc.h           |  17 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c         |   6 +-
 drivers/infiniband/sw/rxe/rxe_mr.c            |  10 +-
 drivers/infiniband/sw/rxe/rxe_mw.c            |  65 +--
 drivers/infiniband/sw/rxe/rxe_opcode.c        |   2 -
 drivers/infiniband/sw/rxe/rxe_param.h         |   2 -
 drivers/infiniband/sw/rxe/rxe_pool.c          |  11 +-
 drivers/infiniband/sw/rxe/rxe_pool.h          |   5 -
 drivers/infiniband/sw/rxe/rxe_qp.c            |  36 +-
 drivers/infiniband/sw/rxe/rxe_recv.c          |   1 -
 drivers/infiniband/sw/rxe/rxe_req.c           |  28 +-
 drivers/infiniband/sw/rxe/rxe_resp.c          |   8 +-
 drivers/infiniband/sw/rxe/rxe_srq.c           | 129 +++--
 drivers/infiniband/sw/rxe/rxe_verbs.c         |  40 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h         |   3 +-
 drivers/infiniband/sw/siw/siw_main.c          |   5 +-
 drivers/infiniband/sw/siw/siw_verbs.c         |   4 +-
 drivers/infiniband/ulp/ipoib/ipoib.h          |   1 +
 drivers/infiniband/ulp/ipoib/ipoib_main.c     |   5 +-
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c    |   6 +-
 drivers/infiniband/ulp/iser/iscsi_iser.c      |   2 +-
 drivers/infiniband/ulp/iser/iscsi_iser.h      |   2 +-
 drivers/infiniband/ulp/iser/iser_verbs.c      |   8 +-
 drivers/infiniband/ulp/isert/ib_isert.c       |  27 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c        |   2 +-
 drivers/infiniband/ulp/srp/ib_srp.c           |   8 +-
 drivers/nvme/host/rdma.c                      |   4 +-
 drivers/nvme/target/rdma.c                    |   4 +-
 fs/cifs/smbdirect.c                           |   2 +-
 include/rdma/ib_verbs.h                       | 138 ++---
 include/rdma/opa_vnic.h                       |   3 +-
 include/uapi/rdma/ib_user_verbs.h             |  42 ++
 net/rds/ib.c                                  |   4 +-
 net/sunrpc/xprtrdma/frwr_ops.c                |   2 +-
 88 files changed, 1968 insertions(+), 2002 deletions(-)
(diffstat from tag for-linus-merged)

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCYo+StQAKCRCFwuHvBreF
YQDfAQCVJozl4jT2cNw4tXkNI4S0K4bfBFcqsUqS3vOshfFNLQEAoPRfn31XZneY
Di6NmE6U7CyX9T9wrQJmv/7Lv5F0ogU=
=S2EL
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
