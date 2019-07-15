Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5DE6985C
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2019 17:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbfGOP0e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Jul 2019 11:26:34 -0400
Received: from mail-eopbgr130080.outbound.protection.outlook.com ([40.107.13.80]:3791
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730650AbfGOP0d (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 15 Jul 2019 11:26:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLnPeRxEP/arBrp0rKdhOHIXmnE6twQMmheVKBYpX+Wy3eXCMlatXmnyjDao1HxE4H5cQyJxNl7nNjIVmYTZfrBbTfFBVBV0chfRLGPtj8Lif1xzEGSboNX0SxiYXBef1lrzn2terZFYEWYXn5T6FdxaPqxwmtSCOiGSGT47IQJXj7fQRBPfAxMwFI0YLSTagREi4vo93noWGJeCMFV0eY0R7bzYdAiYW8RpEDXBB7Fcu16UGxKdNo8Jp4+Y45Y7X9LTPmDhUD/fLPtZOAl5FUR/P2H/yPfDY8sTnmjBad1SJQlLuuQCoc4iOebCUTsJUeupFkmolnMnUdPpsVR+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hs6s/FjTyE1Wn6pTpof+ci/V8gnOBwmwlOc98cku0Ic=;
 b=bF3R6Jco7J5WSe1b7WtLPE9MHBIBfn9i5fuEHD3JSNANPvUN2HGITHiAOTusnabdHuPK6Bh6HK6/EXNf+roqtap/+YaBkbClrFn0Ph0peruZnP8h9InshxSswE/XEqqjWvqsKGZeYTQtaTdKHZV+gx6TS7D0OC0AkUsk1yS7hYmKVeToeqeScLti2OMK31UdP3Miw65sLKhUJ1pp+A0MqB6qTyHtWmKjQ9OAxqwbUUBESI1iRQWB3/mspwhBqht6grPwTIXDKeDVPAlNzxZ7EyIiFjRpDIKyAk21kQ9laQ7U1G86geK1aC64SOP2XslNjoHXtb8XOaxAfeslDQYiKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hs6s/FjTyE1Wn6pTpof+ci/V8gnOBwmwlOc98cku0Ic=;
 b=Ru/IqXwaJJ3jnHsuu5VTffS9bocLcTd3iXpKbeAZ6npcMU1AvjBbzjFqQ4RHVejy+Ox4x/1MuVAZBACnzrpFVXUsMsvIDWhDCRrizZHTVOvURtvS9Bcwe3Btl7LeTnPI+M1zPbaS1VOj/PIUzJTJiyhR/FSTR9Q77Mo6JxSbmh4=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5824.eurprd05.prod.outlook.com (20.178.123.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Mon, 15 Jul 2019 15:26:23 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2073.012; Mon, 15 Jul 2019
 15:26:22 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHVOyGo1FUF1NG/I0q/v/6LhLCu5Q==
Date:   Mon, 15 Jul 2019 15:26:22 +0000
Message-ID: <20190715152618.GA32337@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::29) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d35bbf1f-a5e3-4bbe-edfc-08d70938caf6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(49563074)(7193020);SRVR:VI1PR05MB5824;
x-ms-traffictypediagnostic: VI1PR05MB5824:
x-microsoft-antispam-prvs: <VI1PR05MB5824953AA5DEA9238E25F453CFCF0@VI1PR05MB5824.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:126;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(174874002)(102836004)(6486002)(386003)(6506007)(1076003)(30864003)(53936002)(71190400001)(71200400001)(52116002)(36756003)(66556008)(66616009)(66476007)(305945005)(86362001)(2906002)(486006)(99286004)(5660300002)(66446008)(64756008)(66946007)(99936001)(26005)(6436002)(8676002)(476003)(478600001)(66066001)(25786009)(6116002)(186003)(3846002)(110136005)(54906003)(33656002)(68736007)(53946003)(316002)(8936002)(81156014)(81166006)(7736002)(5024004)(14444005)(256004)(4326008)(14454004)(6512007)(9686003)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5824;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ugm0pvQG465z8MAcNYNe96bj8HxhTQEFSrQfrLUrNVUYP7k6CwNU8caTzgmbMvUc9gagQwXuVHuOGh7R8+KJ9nZtIJM0/tyh2IqqaMCr8vKzI06e0dpmw45mCthJRLBogOvHOWDNhyXM6MibqUwkuwmxnmGOB2P0yZMb214dqMEBxK9BIWQ3mOw5F02lzbNI5TVXLGSr8wOpIEhqcd/dn6r0T8QZ2SoofwBvTy4aE9yfPDxjdPKwn4edvQrgTJFv6MPth9lYkpos0cghxjgU1yH9WKb9sCMVDhQfuYX0hKG3QVafyO16qtmqjM9wXJxeNaeMzG3v6hJqGvKWFiLV3zANvXs8cX2Ovdzqulw/DBObLzkIFQhhlkU5+nlUt4n36SmJ5b6ToUtLqJQit+fGYlWUVIEV7vK5jvNbxudN1ls=
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35bbf1f-a5e3-4bbe-edfc-08d70938caf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 15:26:22.8481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5824
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

These are the proposed RDMA patches for 5.3

This has been a more exciting merge window than usual, the late merge of the
new siw driver, combined with the absence of the 0-Day testing service and the
July long weekend created a stream of build fixes for siw this week. I'm
hoping we got them all, but if there are more I will send them for rc1.

There is one non-textual conflict with an API change in netdev that will
require this patch in the merge commit to resolve:

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 43f7f12e5f7f81..a7cde98e73e8c8 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1963,6 +1963,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 	if (id->local_addr.ss_family == AF_INET) {
 		struct in_device *in_dev = in_dev_get(dev);
 		struct sockaddr_in s_laddr, *s_raddr;
+		const struct in_ifaddr *ifa;

 		memcpy(&s_laddr, &id->local_addr, sizeof(s_laddr));
 		s_raddr = (struct sockaddr_in *)&id->remote_addr;
@@ -1973,8 +1974,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 			&s_raddr->sin_addr, ntohs(s_raddr->sin_port));

 		rtnl_lock();
-		for_ifa(in_dev)
-		{
+		in_dev_for_each_ifa_rtnl(ifa, in_dev) {
 			if (ipv4_is_zeronet(s_laddr.sin_addr.s_addr) ||
 			    s_laddr.sin_addr.s_addr == ifa->ifa_address) {
 				s_laddr.sin_addr.s_addr = ifa->ifa_address;
@@ -1986,7 +1986,6 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 					listeners++;
 			}
 		}
-		endfor_ifa(in_dev);
 		rtnl_unlock();
 		in_dev_put(in_dev);
 	} else if (id->local_addr.ss_family == AF_INET6) {

The tag for-linus-merged with my merge resolution to your tree is also available to pull.

The following changes since commit f8efee08dd9d41ab71010e9b16c9ead51753b7d6:

  net/mlx5: Add rts2rts_qp_counters_set_id field in hca cap (2019-07-04 21:36:33 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 0b043644c0ca601cb19943a81aa1f1455dbe9461:

  RMDA/siw: Require a 64 bit arch (2019-07-12 12:12:06 -0300)

----------------------------------------------------------------
5.3 Merge window RDMA pull request

A smaller cycle this time. Notably we see another new driver, 'Soft
iWarp', and the deletion of an ancient unused driver for nes.

- Revise and simplify the signature offload RDMA MR APIs

- More progress on hoisting object allocation boiler plate code out of the
  drivers

- Driver bug fixes and revisions for hns, hfi1, efa, cxgb4, qib, i40iw

- Tree wide cleanups: struct_size, put_user_page, xarray, rst doc conversion

- Removal of obsolete ib_ucm chardev and nes driver

- netlink based discovery of chardevs and autoloading of the modules
  providing them

- Move more of the rdamvt/hfi1 uapi to include/uapi/rdma

- New driver 'siw' for software based iWarp running on top of netdev,
  much like rxe's software RoCE.

- mlx5 feature to report events in their raw devx format to userspace

- Expose per-object counters through rdma tool

- Adaptive interrupt moderation for RDMA (DIM), sharing the DIM core
  from netdev

----------------------------------------------------------------
Bart Van Assche (1):
      RDMA/srp: Accept again source addresses that do not have a port number

Bernard Metzler (12):
      rdma/siw: iWarp wire packet format
      rdma/siw: main include file
      rdma/siw: network and RDMA core interface
      rdma/siw: connection management
      rdma/siw: application interface
      rdma/siw: application buffer management
      rdma/siw: queue pair methods
      rdma/siw: transmit path
      rdma/siw: receive path
      rdma/siw: completion queue methods
      rdma/siw: addition to kernel build environment
      RDMA/siw: Remove unnecessary kthread create/destroy printouts

Colin Ian King (4):
      RDMA/hns: fix inverted logic of readl read and shift
      RDMA/hns: fix potential integer overflow on left shift
      RDMA/hns: fix spelling mistake "attatch" -> "attach"
      RDMA/uverbs: remove redundant assignment to variable ret

Dag Moxnes (1):
      RDMA/core: Fix race when resolving IP address

Dan Carpenter (2):
      RDMA/uverbs: check for allocation failure in uapi_add_elm()
      RDMA/hns: Fix an error code in hns_roce_set_user_sq_size()

Daniel Kranzdorf (1):
      RDMA/efa: Entropy in admin commands id

Danit Goldberg (1):
      IB/mlx5: Report correctly tag matching rendezvous capability

Dennis Dalessandro (2):
      IB/hfi1: Remove extra brackets from an if
      IB/hfi1: No need to use try_module_get for debugfs

Doug Ledford (3):
      Merge remote-tracking branch 'mlx5-next/mlx5-next' into HEAD
      RDMA/netlink: Resort policy array
      RDMA/netlink: Audit policy settings for netlink attributes

Firas Jahjah (1):
      RDMA/efa: Print address on AH creation failure

Fuqian Huang (3):
      IB: Remove unneeded memset
      IB/ipoib: Remove memset after vzalloc in ipoib_cm.c
      IB/i40iw: Use kmemdup rather than open coding

Gal Pressman (6):
      RDMA/efa: Use kvzalloc instead of kzalloc with fallback
      RDMA/efa: Remove unneeded admin commands abort flow
      RDMA/efa: Use rdma block iterator in chunk list creation
      RDMA/efa: Remove unused includes
      RDMA/efa: Use API to get contiguous memory blocks aligned to device supported page size
      RDMA/efa: Be consistent with success flow return value

Geert Uytterhoeven (2):
      IB/hfi1: Spelling s/statisfied/satisfied/
      rdma/siw: Add missing dependencies on LIBCRC32C and DMA_VIRT_OPS

Gustavo A. R. Silva (5):
      IB/rdmavt: Use struct_size() helper
      IB/qib: Use struct_size() helper
      IB/hfi1: Use struct_size() helper
      RDMA/ucma: Use struct_size() helper
      RDMA/siw: Mark expected switch fall-throughs

Israel Rukshin (15):
      IB/iser: Refactor iscsi_iser_check_protection function
      IB/iser: Remove unused sig_attrs argument
      IB/isert: Remove unused sig_attrs argument
      RDMA/rw: Fix doc typo
      RDMA/rw: Print the correct number of sig MRs
      RDMA/core: Fix doc typo
      RDMA/core: Introduce IB_MR_TYPE_INTEGRITY and ib_alloc_mr_integrity API
      IB/iser: Use IB_WR_REG_MR_INTEGRITY for PI handover
      IB/iser: Unwind WR union at iser_tx_desc
      RDMA/core: Add an integrity MR pool support
      RDMA/core: Rename signature qp create flag and signature device capability
      RDMA/rw: Introduce rdma_rw_inv_key helper
      RDMA/rw: Use IB_WR_REG_MR_INTEGRITY for PI handover
      RDMA/mlx5: Remove unused IB_WR_REG_SIG_MR code
      RDMA/mlx5: Improve PI handover performance

Jason Gunthorpe (23):
      RDMA/umem: Move page_shift from ib_umem to ib_odp_umem
      rdma: Delete the ib_ucm module
      RDMA: Move driver_id into struct ib_device_ops
      RDMA: Move uverbs_abi_ver into struct ib_device_ops
      RDMA: Move owner into struct ib_device_ops
      rdma: Remove nes
      RDMA: Move rdma_node_type to uapi/
      RDMA: Add NLDEV_GET_CHARDEV to allow char dev discovery and autoload
      RDMA: Report available cdevs through RDMA_NLDEV_CMD_GET_CHARDEV
      RDMA/odp: Fix missed unlock in non-blocking invalidate_start
      RDMA/uverbs: Use offsetofend instead of opencoding
      RDMA/odp: Do not leak dma maps when working with huge pages
      Merge tag 'v5.2-rc6' into rdma.git for-next
      Merge branch 'siw' into rdma.git for-next
      Merge mlx5-next into rdma for-next
      Merge mlx5-next into rdma for-next
      RDMA/siw: Fix DEFINE_PER_CPU compilation when ARCH_NEEDS_WEAK_PER_CPU
      RDMA/rvt: Do not use a kernel header in the ABI
      Merge branch 'vhca-tunnel' into rdma.git for-next
      Merge tag 'blk-dim-v2' into rdma.git for-next
      RDMA/core: Make rdma_counter.h compile stand alone
      RDMA/siw: Add missing rtnl_lock around access to ifa
      RMDA/siw: Require a 64 bit arch

John Hubbard (1):
      RDMA: Convert put_page() to put_user_page*()

Kamal Heib (3):
      RDMA/core: Return void from ib_device_check_mandatory()
      RDMA/ipoib: implement ethtool .get_link() callback
      RDMA/ipoib: Remove check for ETH_SS_TEST

Kamenee Arumugam (4):
      IB/hfi1: Move rvt_cq_wc struct into uapi directory
      IB/hfi1: Move receive work queue struct into uapi directory
      IB/rdmavt: Fracture single lock used for posting and processing RWQEs
      IB/{hfi1, qib, rdmavt}: Put qp in error state when cq is full

Konstantin Taranov (1):
      RDMA/rxe: Fill in wc byte_len with IB_WC_RECV_RDMA_WITH_IMM

Lang Cheng (6):
      RDMA/hns: Move spin_lock_irqsave to the correct place
      RDMA/hns: Remove jiffies operation in disable interrupt context
      RDMA/hns: reset function when removing module
      RDMA/hns: Set reset flag when hw resetting
      RDMA/hns: Use %pK format pointer print
      RDMA/hns: Clean up unnecessary variable initialization

Leon Romanovsky (20):
      rds: Don't check return value from destroy CQ
      RDMA/ipoib: Remove check of destroy CQ
      RDMA/core: Make ib_destroy_cq() void
      RDMA/nes: Remove useless NULL checks
      RDMA/i40iw: Remove useless NULL checks
      RDMA/nes: Remove second wait queue initialization call
      RDMA/efa: Remove check that prevents destroy of resources in error flows
      RDMA/cxgb3: Use sizeof() notation instead of plain sizeof
      RDMA/cxgb3: Don't expose DMA addresses
      RDMA/cxgb3: Delete and properly mark unimplemented resize CQ function
      RDMA/cxgb4: Use sizeof() notation
      RDMA/cxgb4: Don't expose DMA addresses
      RDMA/nes: Avoid memory allocation during CQ destroy
      RDMA: Clean destroy CQ in drivers do not return errors
      RDMA: Convert CQ allocations to be under core responsibility
      RDMA: Convert destroy_wq to be void
      RDMA: Check umem pointer validity prior to release
      RDMa/hns: Don't stuck in endless timeout loop
      RDMA/mlx5: Use proper allocation API to get zeroed memory
      RDMA/mlx5: Set RDMA DIM to be enabled by default

Lijun Ou (11):
      RDMA/hns: Update CQE specifications
      RDMA/hns: Replace magic numbers with #defines
      RDMA/hns: Bugfix for posting multiple srq work request
      RDMA/hns: Bugfix for filling the sge of srq
      RDMA/hns: Add mtr support for mixed multihop addressing
      RDMA/hns: Add a group interfaces for optimizing buffers getting flow
      RDMA/hns: Fix bug when wqe num is larger than 16K
      RDMA/hns: Cleanup unnecessary exported symbols
      RDMA/hns: Fix building modular hns
      RDMA/hns: Bugfix for cleaning mtr
      RDMA/hns: Bugfix for calculating qp buffer size

Liu, Changcheng (1):
      RDMA/i40iw: Set queue pair state when being queried

Maksym Planeta (1):
      ibverbs/rxe: Remove variable self-initialization

Maor Gottlieb (2):
      RDMA/mlx5: Consider eswitch encap mode
      RDMA/mlx5: Enable decap and packet reformat on FDB

Mark Zhang (16):
      RDMA/restrack: Introduce statistic counter
      RDMA/restrack: Add an API to attach a task to a resource
      RDMA/restrack: Make is_visible_in_pid_ns() as an API
      RDMA/counter: Add set/clear per-port auto mode support
      RDMA/counter: Add "auto" configuration mode support
      IB/mlx5: Support set qp counter
      IB/mlx5: Add counter set id as a parameter for mlx5_ib_query_q_counters()
      IB/mlx5: Support statistic q counter configuration
      RDMA/nldev: Allow counter auto mode configration through RDMA netlink
      RDMA/netlink: Implement counter dumpit calback
      IB/mlx5: Add counter_alloc_stats() and counter_update_stats() support
      RDMA/core: Get sum value of all counters when perform a sysfs stat read
      RDMA/counter: Allow manual mode configuration support
      RDMA/nldev: Allow counter manual mode configration through RDMA netlink
      RDMA/nldev: Allow get counter mode through RDMA netlink
      RDMA/nldev: Allow get default counter statistics through RDMA netlink

Matthew Wilcox (2):
      ucma: Convert multicast_idr to XArray
      ucma: Convert ctx_idr to XArray

Mauro Carvalho Chehab (2):
      docs: infiniband: convert docs to ReST and rename to *.rst
      docs: infiniband: add it to the driver-api bookset

Max Gurtovoy (15):
      RDMA/rw: Add info regarding SG count failure
      RDMA/core: Introduce new header file for signature operations
      RDMA/core: Save the MR type in the ib_mr structure
      RDMA/core: Introduce ib_map_mr_sg_pi to map data/protection sgl's
      RDMA/core: Add signature attrs element for ib_mr structure
      RDMA/mlx5: Implement mlx5_ib_map_mr_sg_pi and mlx5_ib_alloc_mr_integrity
      RDMA/mlx5: Add attr for max number page list length for PI operation
      RDMA/mlx5: Pass UMR segment flags instead of boolean
      RDMA/mlx5: Update set_sig_data_segment attribute for new signature API
      RDMA/mlx5: Introduce and implement new IB_WR_REG_MR_INTEGRITY work request
      RDMA/core: Validate integrity handover device cap
      RDMA/mlx5: Use PA mapping for PI handover
      RDMA/mlx5: Refactor MR descriptors allocation
      net/mlx5: Introduce VHCA tunnel device capability
      IB/mlx5: Implement VHCA tunnel mechanism in DEVX

Michael J. Ruhl (4):
      IB/rdmavt: Set QP allowed opcodes after QP allocation
      IB/{rdmavt, hfi1, qib}: Remove AH refcount for UD QPs
      IB/{rdmavt, hfi1, qib}: Add helpers to hide SWQE WR details
      IB/hfi1: Reduce excessive aspm inlines

Mike Marciniszyn (5):
      IB/rdmavt: Add new completion inline
      IB/{rdmavt, qib, hfi1}: Convert to new completion API
      IB/hfi1: Add missing INVALIDATE opcodes for trace
      IB/rdmavt: Enhance trace information for FRWR debug
      IB/rdmavt: Add trace for map_mr_sg

Nathan Chancellor (2):
      IB/rdmavt: Fix variable shadowing issue in rvt_create_cq
      rdma/siw: Use proper enumerated type in map_cqe_status

Nirranjan Kirubaharan (1):
      iw_cxgb4: Fix qpid leak

Parav Pandit (2):
      IB/mlx5: Fixed reporting counters on 2nd port for Dual port RoCE
      IB/core: Work on the caller socket net namespace in nldev_newlink()

Qian Cai (1):
      RDMA/core: Fix -Wunused-const-variable warnings

Sagiv Ozeri (1):
      RDMA/qedr: Fix incorrect device rate.

Valentine Fatiev (1):
      IB/ipoib: Add child to parent list only if device initialized

Xi Wang (1):
      RDMA/hns: Fixs hw access invalid dma memory error

Yamin Friedman (3):
      linux/dim: Implement RDMA adaptive moderation (DIM)
      RDMA/core: Provide RDMA DIM support for ULPs
      RDMA/nldev: Added configuration of RDMA dynamic interrupt moderation to netlink

Yangyang Li (1):
      RDMA/hns: Modify ba page size for cqe

Yishai Hadas (6):
      IB/mlx5: Introduce MLX5_IB_OBJECT_DEVX_ASYNC_EVENT_FD
      IB/mlx5: Register DEVX with mlx5_core to get async events
      IB/mlx5: Enable subscription for device events over DEVX
      IB/mlx5: Implement DEVX dispatching event
      IB/mlx5: Add DEVX support for CQ events
      IB/mlx5: DEVX cleanup mdev

Yixian Liu (1):
      RDMA/hns: Remove unnecessary print message in aeq

YueHaibing (3):
      IB/hfi1: Remove set but not used variables 'offset' and 'fspsn'
      RDMA/hns: Remove set but not used variable 'fclr_write_fail_flag'
      rdma/siw: Remove set but not used variable 's'

Yuval Shaia (1):
      IB/mlx4: Delete unused func arg

chenglang (1):
      RDMA/hns: Fixup qp release bug

 Documentation/ABI/stable/sysfs-class-infiniband    |   17 -
 Documentation/index.rst                            |    1 +
 .../{core_locking.txt => core_locking.rst}         |   64 +-
 Documentation/infiniband/index.rst                 |   23 +
 Documentation/infiniband/{ipoib.txt => ipoib.rst}  |   24 +-
 .../infiniband/{opa_vnic.txt => opa_vnic.rst}      |  110 +-
 Documentation/infiniband/{sysfs.txt => sysfs.rst}  |    4 +-
 .../{tag_matching.txt => tag_matching.rst}         |    5 +
 .../infiniband/{user_mad.txt => user_mad.rst}      |   33 +-
 .../infiniband/{user_verbs.txt => user_verbs.rst}  |   12 +-
 MAINTAINERS                                        |   15 +-
 drivers/infiniband/Kconfig                         |   14 +-
 drivers/infiniband/core/Makefile                   |    5 +-
 drivers/infiniband/core/addr.c                     |    2 +-
 drivers/infiniband/core/core_priv.h                |   10 +
 drivers/infiniband/core/counters.c                 |  634 ++++
 drivers/infiniband/core/cq.c                       |   95 +-
 drivers/infiniband/core/device.c                   |  150 +-
 drivers/infiniband/core/mr_pool.c                  |    8 +-
 drivers/infiniband/core/nldev.c                    |  800 +++-
 drivers/infiniband/core/restrack.c                 |   49 +-
 drivers/infiniband/core/restrack.h                 |    3 +
 drivers/infiniband/core/rw.c                       |  201 +-
 drivers/infiniband/core/sysfs.c                    |   16 +-
 drivers/infiniband/core/ucm.c                      | 1350 -------
 drivers/infiniband/core/ucma.c                     |  114 +-
 drivers/infiniband/core/umem.c                     |   13 +-
 drivers/infiniband/core/umem_odp.c                 |  106 +-
 drivers/infiniband/core/user_mad.c                 |   53 +-
 drivers/infiniband/core/uverbs_cmd.c               |   28 +-
 drivers/infiniband/core/uverbs_main.c              |   40 +-
 drivers/infiniband/core/uverbs_std_types_cq.c      |   19 +-
 drivers/infiniband/core/uverbs_std_types_mr.c      |    1 +
 drivers/infiniband/core/uverbs_uapi.c              |    4 +-
 drivers/infiniband/core/verbs.c                    |  165 +-
 drivers/infiniband/hw/Makefile                     |    1 -
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |   66 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h           |    9 +-
 drivers/infiniband/hw/bnxt_re/main.c               |    8 +-
 drivers/infiniband/hw/cxgb3/cxio_hal.c             |   33 +-
 drivers/infiniband/hw/cxgb3/cxio_hal.h             |    3 +-
 drivers/infiniband/hw/cxgb3/iwch_cm.c              |    2 +-
 drivers/infiniband/hw/cxgb3/iwch_provider.c        |  160 +-
 drivers/infiniband/hw/cxgb4/cm.c                   |   21 +-
 drivers/infiniband/hw/cxgb4/cq.c                   |   55 +-
 drivers/infiniband/hw/cxgb4/device.c               |    9 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h             |   11 +-
 drivers/infiniband/hw/cxgb4/mem.c                  |    8 +-
 drivers/infiniband/hw/cxgb4/provider.c             |    9 +-
 drivers/infiniband/hw/cxgb4/qp.c                   |   95 +-
 drivers/infiniband/hw/cxgb4/resource.c             |   16 +-
 drivers/infiniband/hw/efa/efa.h                    |    9 +-
 drivers/infiniband/hw/efa/efa_com.c                |  118 +-
 drivers/infiniband/hw/efa/efa_com.h                |    1 -
 drivers/infiniband/hw/efa/efa_com_cmd.c            |    8 +-
 drivers/infiniband/hw/efa/efa_main.c               |   10 +-
 drivers/infiniband/hw/efa/efa_verbs.c              |  248 +-
 drivers/infiniband/hw/hfi1/Makefile                |    1 +
 drivers/infiniband/hw/hfi1/aspm.c                  |  270 ++
 drivers/infiniband/hw/hfi1/aspm.h                  |  262 +-
 drivers/infiniband/hw/hfi1/debugfs.c               |    5 +-
 drivers/infiniband/hw/hfi1/mad.c                   |    9 +-
 drivers/infiniband/hw/hfi1/pcie.c                  |    6 +-
 drivers/infiniband/hw/hfi1/pio.c                   |    3 +-
 drivers/infiniband/hw/hfi1/qp.c                    |    8 +-
 drivers/infiniband/hw/hfi1/rc.c                    |   29 +-
 drivers/infiniband/hw/hfi1/tid_rdma.c              |    7 +-
 drivers/infiniband/hw/hfi1/trace_ibhdrs.h          |    2 +
 drivers/infiniband/hw/hfi1/uc.c                    |    3 +-
 drivers/infiniband/hw/hfi1/ud.c                    |   36 +-
 drivers/infiniband/hw/hfi1/user_pages.c            |   11 +-
 drivers/infiniband/hw/hfi1/verbs.c                 |    6 +-
 drivers/infiniband/hw/hns/Kconfig                  |   15 +-
 drivers/infiniband/hw/hns/Makefile                 |   15 +-
 drivers/infiniband/hw/hns/hns_roce_alloc.c         |  101 +-
 drivers/infiniband/hw/hns/hns_roce_cmd.c           |    6 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c            |   81 +-
 drivers/infiniband/hw/hns/hns_roce_db.c            |   12 +-
 drivers/infiniband/hw/hns/hns_roce_device.h        |  108 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c           |  504 ++-
 drivers/infiniband/hw/hns/hns_roce_hem.h           |   16 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |   79 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  280 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |   23 +-
 drivers/infiniband/hw/hns/hns_roce_main.c          |   31 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c            |  166 +-
 drivers/infiniband/hw/hns/hns_roce_pd.c            |    4 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |  220 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c           |   40 +-
 drivers/infiniband/hw/i40iw/i40iw_cm.c             |    4 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c          |   56 +-
 drivers/infiniband/hw/mlx4/cq.c                    |   43 +-
 drivers/infiniband/hw/mlx4/main.c                  |   21 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h               |    9 +-
 drivers/infiniband/hw/mlx4/mr.c                    |   16 +-
 drivers/infiniband/hw/mlx4/qp.c                    |   11 +-
 drivers/infiniband/hw/mlx4/srq.c                   |    9 +-
 drivers/infiniband/hw/mlx5/cq.c                    |   56 +-
 drivers/infiniband/hw/mlx5/devx.c                  | 1053 +++++-
 drivers/infiniband/hw/mlx5/mad.c                   |   60 +-
 drivers/infiniband/hw/mlx5/main.c                  |  157 +-
 drivers/infiniband/hw/mlx5/mem.c                   |   20 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |   47 +-
 drivers/infiniband/hw/mlx5/mr.c                    |  554 ++-
 drivers/infiniband/hw/mlx5/odp.c                   |   23 +-
 drivers/infiniband/hw/mlx5/qp.c                    |  312 +-
 drivers/infiniband/hw/mthca/mthca_allocator.c      |    2 -
 drivers/infiniband/hw/mthca/mthca_memfree.c        |    6 +-
 drivers/infiniband/hw/mthca/mthca_provider.c       |   52 +-
 drivers/infiniband/hw/nes/Kconfig                  |   16 -
 drivers/infiniband/hw/nes/Makefile                 |    4 -
 drivers/infiniband/hw/nes/nes.c                    | 1211 ------
 drivers/infiniband/hw/nes/nes.h                    |  574 ---
 drivers/infiniband/hw/nes/nes_cm.c                 | 3992 --------------------
 drivers/infiniband/hw/nes/nes_cm.h                 |  470 ---
 drivers/infiniband/hw/nes/nes_context.h            |  193 -
 drivers/infiniband/hw/nes/nes_hw.c                 | 3887 -------------------
 drivers/infiniband/hw/nes/nes_hw.h                 | 1380 -------
 drivers/infiniband/hw/nes/nes_mgt.c                | 1155 ------
 drivers/infiniband/hw/nes/nes_mgt.h                |   97 -
 drivers/infiniband/hw/nes/nes_nic.c                | 1870 ---------
 drivers/infiniband/hw/nes/nes_utils.c              |  916 -----
 drivers/infiniband/hw/nes/nes_verbs.c              | 3759 ------------------
 drivers/infiniband/hw/nes/nes_verbs.h              |  198 -
 drivers/infiniband/hw/ocrdma/ocrdma_hw.c           |   11 +-
 drivers/infiniband/hw/ocrdma/ocrdma_hw.h           |    2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c         |    8 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c        |   38 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h        |    7 +-
 drivers/infiniband/hw/qedr/main.c                  |    8 +-
 drivers/infiniband/hw/qedr/verbs.c                 |   82 +-
 drivers/infiniband/hw/qedr/verbs.h                 |    7 +-
 drivers/infiniband/hw/qib/qib_qp.c                 |    4 +-
 drivers/infiniband/hw/qib/qib_rc.c                 |   29 +-
 drivers/infiniband/hw/qib/qib_uc.c                 |    3 +-
 drivers/infiniband/hw/qib/qib_ud.c                 |   28 +-
 drivers/infiniband/hw/qib/qib_user_pages.c         |   11 +-
 drivers/infiniband/hw/qib/qib_user_sdma.c          |   11 +-
 drivers/infiniband/hw/qib/qib_verbs.c              |    6 +-
 drivers/infiniband/hw/usnic/usnic_ib.h             |    4 +
 drivers/infiniband/hw/usnic/usnic_ib_main.c        |    8 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c       |   22 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h       |    7 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c           |    7 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h          |    2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c       |   46 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c     |    8 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c       |    3 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c       |   16 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h    |    7 +-
 drivers/infiniband/sw/Makefile                     |    1 +
 drivers/infiniband/sw/rdmavt/ah.c                  |    6 +-
 drivers/infiniband/sw/rdmavt/cq.c                  |  250 +-
 drivers/infiniband/sw/rdmavt/cq.h                  |    7 +-
 drivers/infiniband/sw/rdmavt/mr.c                  |    6 +-
 drivers/infiniband/sw/rdmavt/qp.c                  |  402 +-
 drivers/infiniband/sw/rdmavt/qp.h                  |    2 +
 drivers/infiniband/sw/rdmavt/rc.c                  |   41 +-
 drivers/infiniband/sw/rdmavt/srq.c                 |   69 +-
 drivers/infiniband/sw/rdmavt/trace_mr.h            |   56 +-
 drivers/infiniband/sw/rdmavt/vt.c                  |    7 +-
 drivers/infiniband/sw/rdmavt/vt.h                  |    9 +
 drivers/infiniband/sw/rxe/rxe_comp.c               |    2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c                 |    3 +-
 drivers/infiniband/sw/rxe/rxe_pool.c               |    1 +
 drivers/infiniband/sw/rxe/rxe_resp.c               |    5 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |   40 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h              |    3 +-
 drivers/infiniband/sw/siw/Kconfig                  |   18 +
 drivers/infiniband/sw/siw/Makefile                 |   11 +
 drivers/infiniband/sw/siw/iwarp.h                  |  380 ++
 drivers/infiniband/sw/siw/siw.h                    |  745 ++++
 drivers/infiniband/sw/siw/siw_cm.c                 | 2070 ++++++++++
 drivers/infiniband/sw/siw/siw_cm.h                 |  133 +
 drivers/infiniband/sw/siw/siw_cq.c                 |  101 +
 drivers/infiniband/sw/siw/siw_main.c               |  685 ++++
 drivers/infiniband/sw/siw/siw_mem.c                |  460 +++
 drivers/infiniband/sw/siw/siw_mem.h                |   74 +
 drivers/infiniband/sw/siw/siw_qp.c                 | 1322 +++++++
 drivers/infiniband/sw/siw/siw_qp_rx.c              | 1458 +++++++
 drivers/infiniband/sw/siw/siw_qp_tx.c              | 1269 +++++++
 drivers/infiniband/sw/siw/siw_verbs.c              | 1760 +++++++++
 drivers/infiniband/sw/siw/siw_verbs.h              |   91 +
 drivers/infiniband/ulp/ipoib/Kconfig               |    2 +-
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            |    1 -
 drivers/infiniband/ulp/ipoib/ipoib_ethtool.c       |    3 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |   34 +-
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c         |    7 +-
 drivers/infiniband/ulp/iser/iscsi_iser.c           |   12 +-
 drivers/infiniband/ulp/iser/iscsi_iser.h           |   64 +-
 drivers/infiniband/ulp/iser/iser_initiator.c       |   12 +-
 drivers/infiniband/ulp/iser/iser_memory.c          |  121 +-
 drivers/infiniband/ulp/iser/iser_verbs.c           |  156 +-
 drivers/infiniband/ulp/isert/ib_isert.c            |   19 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |   21 +-
 drivers/nvme/host/rdma.c                           |    2 +-
 include/linux/dim.h                                |   23 +
 include/linux/mlx5/mlx5_ifc.h                      |    6 +-
 include/linux/mlx5/qp.h                            |    4 +-
 include/rdma/ib_umem.h                             |   19 +-
 include/rdma/ib_umem_odp.h                         |   20 +
 include/rdma/ib_verbs.h                            |  247 +-
 include/rdma/mr_pool.h                             |    2 +-
 include/rdma/rdma_counter.h                        |   65 +
 include/rdma/rdma_netlink.h                        |    8 +
 include/rdma/rdma_vt.h                             |    5 +-
 include/rdma/rdmavt_cq.h                           |   25 +-
 include/rdma/rdmavt_qp.h                           |  312 +-
 include/rdma/restrack.h                            |    9 +-
 include/rdma/rw.h                                  |    9 -
 include/rdma/signature.h                           |  122 +
 include/uapi/rdma/ib_user_cm.h                     |  326 --
 include/uapi/rdma/mlx5_user_ioctl_cmds.h           |   19 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h          |    9 +
 include/uapi/rdma/rdma_netlink.h                   |   86 +-
 include/uapi/rdma/rdma_user_ioctl_cmds.h           |    1 +
 include/uapi/rdma/rvt-abi.h                        |   66 +
 include/uapi/rdma/siw-abi.h                        |  185 +
 lib/dim/Makefile                                   |    6 +-
 lib/dim/rdma_dim.c                                 |  108 +
 net/rds/ib_cm.c                                    |    8 +-
 221 files changed, 18855 insertions(+), 24841 deletions(-)
(diffstat from tag for-linus-merged)

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl0smxgACgkQOG33FX4g
mxqG5g/+NiXl4abSR/KGYlA1eGHtXeLUJQDWKq0588woq9O2x5m+uaot33YcHTjI
Sq7pn4PZIENR5kwlGkYZNTxbJ19IMDfyXSB9tAQoNWckhncFWDnh3EdWhvfCSuot
9Aw4VDHRyRXE0rXfiQIjq4bHam5QzmuWeR3OEWlzKDPOz5NohHHk1XYOSq1ijjbE
KHujmrr+dQLjNaWYtlLudAhLaErvrxKCmipqGxaZ2BeP/8rDaZuLX9cx19AU4ML6
tYooiIKpO0VttfkUfLLlMBX9jxiIsTZsoWbGP1q6hfjEV3n8QIqme9S5W/CB25C/
tOpzSa7b5mH9r+CP3FEdapTUekq+g8hEm+VknU52b/q19QeoDKjqblqBnWkiljr3
/b14YQE/p/Dq3WO0CBXSbbF31N5s1BcwXYwlEwcdo1wQMSpLrjUUmd6wGkR6lolm
X5z8nydInzi28x+tGMQbYDPjJ/MQmFcm7pUeAROuJc3+2ghtJYGH7lH1niAqYGkX
fy96wFeu102uH88mPNqgyUsZHpTPA/y5Rh3NZNPQ1dW5hRC8wzn4omZBWhXZopAc
jN8F9DRMmZGgutXk7Wk1epoU1WqMp9V3rM+GG8b9jgWrKTWDV/0X5phGkjXA1/OB
A3YgB2e2O+/6t95lS08WT3DlrLvgqmB9jG7CgME/pTl0akG6Jew=
=AZdB
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
