Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B584290BC4
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 20:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403962AbgJPSwA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 14:52:00 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16240 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403961AbgJPSwA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Oct 2020 14:52:00 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f89eba30000>; Fri, 16 Oct 2020 11:51:15 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Oct
 2020 18:51:59 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 16 Oct 2020 18:51:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GM9UiWyz+D87gke2LuPgkE+/WBc5ou/c0nPahGYkLycNhVXG0Bgwdnv8HzP9nBGefQazetz5AA1XPSW/zDIzdf+X9XDE1hsaM6LdIStX5t6y/Xho23OqbrKWREct95KVNnn0+6jZ2msRrurNCnMIjLM7R5c85cCtqgfzaluUp9Dz0fZHDSWc1Sa8ZAxlTlO/HVS8P0plA9wi/4kIxWhUIOwkYdLikjbAiZzS15odoF9881UVaqTTP1IDRM6QQcr/BvV97ge7mwgcwWeJZLWnGpiNh5KiXFq+9dQ7os39QuQ/EAAIq0qTLoQjKFltsGITu+SQm/0SCBCavkzEE1ngyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xjtm19UnJ+lO9JMJ1gpuSTy9Qzh8GYj5tjjYOpNUphY=;
 b=lZlYOYR50vh4QiNN7gRSTeg/yjcBwBSCoJ2StiUGJPwyfZBr0GUkozNTsQczl+lxokua0WeNymBizp3G2YSgfYoom6VH9TIOXImcpDDe3H9ds3Dt6fhulYXWA40kt3uXIBWpFtpz2xJpkxn2bU1aXeUdr51mig7X4dgVzf7nI3KPNGocgwKk1sZKKayNlEkZZ+WPwtsiip58fQRsYUTBVg9eeQOXhI+Hi0eWL1jHNfTlCJZIEbDoZm2mC85h3BVrFgrGfKGMQqhEbcjfYksA3nppidFpupv4IBDhkzxe8aNesbr8e3jn6c9gTt7e3w2vKnOxazzCnDLxcA0U2xgX3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23; Fri, 16 Oct
 2020 18:51:57 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.020; Fri, 16 Oct 2020
 18:51:57 +0000
Date:   Fri, 16 Oct 2020 15:51:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20201016185155.GA233060@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
X-ClientProxiedBy: BL0PR1501CA0032.namprd15.prod.outlook.com
 (2603:10b6:207:17::45) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR1501CA0032.namprd15.prod.outlook.com (2603:10b6:207:17::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Fri, 16 Oct 2020 18:51:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kTUpX-000yg5-52; Fri, 16 Oct 2020 15:51:55 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602874275; bh=Xjtm19UnJ+lO9JMJ1gpuSTy9Qzh8GYj5tjjYOpNUphY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:Content-Type:Content-Disposition:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=HkGXx9QrNRF2S4Kds13r18eH2arfTPnAlRkoOqpgTkAZYIi6FolREX7hmZXoi3b0i
         xxAyJKLqpRD2akiPow7GRs/0InH1n3eg+Ml9VF2ioguVXd7LNBoBiodTH4gL9oeqsB
         LYk7QsyGzGwA3v7NCvRUiIfC9jyzm/AxHxwtjjRlDq/jbu/+nbxgqWpHYEYXHNe6Gb
         G8RGq0kYlTD3Vvx7L94FOOJEKCGkD/2uqorsA4kdm/XPzcJUZPrYUXlUokqtbW2X7s
         GDt712bR59n8zofJfztHUVycgQGKoOJhWVTXIm2LB5D7whyUuz72y4NGFRLdkPPU+r
         curG72MMuDdhw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

These are the proposed RDMA patches for 5.10.

A usual cycle for RDMA with a typical mix of driver and core subsystem
updates. There was a lot of activity in the last week on fixing up some sma=
ll
patches that were merged during the rc8 period, so the top couple commits a=
re
new things that haven't been in linux-next, but they are all rc-ish unbreak=
ing
stuff.

There is a compilation break after merging this, the signature of
__sg_alloc_table_from_pages() was changed in this PR. The series that did t=
his
has been reviewed and been in linux-next for a while.

You'll need to apply this fixup to the merge commit (it is in the tag
for-linus-merged for reference):

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 11fe9ff76fd572..8ee53839825338 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -807,6 +807,7 @@ struct sg_table *drm_prime_pages_to_sg(struct drm_devic=
e *dev,
 				       struct page **pages, unsigned int nr_pages)
 {
 	struct sg_table *sg =3D NULL;
+	struct scatterlist *sge;
 	size_t max_segment =3D 0;
 	int ret;

@@ -820,11 +821,13 @@ struct sg_table *drm_prime_pages_to_sg(struct drm_dev=
ice *dev,
 		max_segment =3D dma_max_mapping_size(dev->dev);
 	if (max_segment =3D=3D 0 || max_segment > SCATTERLIST_MAX_SEGMENT)
 		max_segment =3D SCATTERLIST_MAX_SEGMENT;
-	ret =3D __sg_alloc_table_from_pages(sg, pages, nr_pages, 0,
-					  nr_pages << PAGE_SHIFT,
-					  max_segment, GFP_KERNEL);
-	if (ret)
+	sge =3D __sg_alloc_table_from_pages(sg, pages, nr_pages, 0,
+					  nr_pages << PAGE_SHIFT, max_segment,
+					  NULL, 0, GFP_KERNEL);
+	if (IS_ERR(sge)) {
+		ret =3D PTR_ERR(sge);
 		goto out;
+	}

 	return sg;
 out:

Thanks,
Jason

The following changes since commit 549738f15da0e5a00275977623be199fbbf7df50:

  Linux 5.9-rc8 (2020-10-04 16:04:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to c7a198c700763ac89abbb166378f546aeb9afb33:

  RDMA/ucma: Fix use after free in destroy id flow (2020-10-16 14:07:08 -03=
00)

----------------------------------------------------------------
RDMA 5.10 pull request

The typical set of driver updates across the subsystem:

 - Driver minor changes and bug fixes for mlx5, efa, rxe, vmw_pvrdma, hns,
   usnic, qib, qedr, cxgb4, hns, bnxt_re

 - Various rtrs fixes and updates

 - Bug fix for mlx4 CM emulation for virtualization scenarios where MRA
   wasn't working right

 - Use tracepoints instead of pr_debug in the CM code

 - Scrub the locking in ucma and cma to close more syzkaller bugs

 - Use tasklet_setup in the subsystem

 - Revert the idea that 'destroy' operations are not allowed to fail at
   the driver level. This proved unworkable from a HW perspective.

 - Revise how the umem API works so drivers make fewer mistakes using it

 - XRC support for qedr

 - Convert uverbs objects RWQ and MW to new the allocation scheme

 - Large queue entry sizes for hns

 - Use hmm_range_fault() for mlx5 On Demand Paging

 - uverbs APIs to inspect the GID table instead of sysfs

 - Move some of the RDMA code for building large page SGLs into
   lib/scatterlist

----------------------------------------------------------------
Aharon Landau (3):
      net/mlx5: Refactor query port speed functions
      RDMA/mlx5: Delete duplicated mlx5_ptys_width enum
      RDMA: Fix link active_speed size

Alex Dewar (3):
      RDMA/qib: Remove superfluous fallthrough statements
      RDMA/qib: Tidy up process_cc()
      RDMA/ucma: Fix resource leak on error path

Alex Vesker (3):
      RDMA/mlx5: Add sw_owner_v2 bit capability
      RDMA/mlx5: Allow DM allocation for sw_owner_v2 enabled devices
      RDMA/mlx5: Expose TIR and QP ICM address for sw_owner_v2 devices

Allen Pais (5):
      RDMA/bnxt_re: Convert tasklets to use new tasklet_setup() API
      RDMA/hfi1: Convert tasklets to use new tasklet_setup() API
      RDMA/i40iw: Convert tasklets to use new tasklet_setup() API
      RDMA/qib: Convert tasklets to use new tasklet_setup() API
      RDMA/rxe: Convert tasklets to use new tasklet_setup() API

Alok Prasad (1):
      RDMA/qedr: Endianness warnings cleanup

Avihai Horon (4):
      RDMA/core: Change rdma_get_gid_attr returned error code
      RDMA/core: Modify enum ib_gid_type and enum rdma_network_type
      RDMA/core: Introduce new GID table query API
      RDMA/uverbs: Expose the new GID query API to user space

Bob Pearson (8):
      RDMA/rxe: Fix style warnings
      RDMA/rxe: Add SPDX hdrs to rxe source files
      RDMA/rxe: Address an issue with hardened user copy
      RDMA/core: Added missing WR and WC opcodes
      RDMA/rxe: Remove duplicate entries in struct rxe_mr
      RDMA/rxe: Fix skb lifetime in rxe_rcv_mcast_pkt()
      RDMA/rxe: Fix bug rejecting all multicast packets
      RDMA/rxe: Handle skb_clone() failure in rxe_recv.c

Chuck Lever (3):
      RDMA/core: Move the rdma_show_ib_cm_event() macro
      RDMA/cm: Replace pr_debug() call sites with tracepoints
      RDMA/cm: Add tracepoints to track MAD send operations

Colin Ian King (2):
      RDMA/bnxt_re: Fix sizeof mismatch for allocation of pbl_tbl.
      IB/rdmavt: Fix sizeof mismatch

Daniel Kranzdorf (1):
      RDMA/efa: Add messages and RDMA read work requests HW stats

Dennis Dalessandro (1):
      IB/hfi,rdmavt,qib,opa_vnic: Update MAINTAINERS

Gal Pressman (6):
      RDMA/efa: Add a generic capability check helper
      RDMA/efa: Be consistent with modify QP bitmask
      RDMA/efa: Introduce SRD QP state machine
      RDMA/efa: Introduce SRD RNR retry
      RDMA/efa: Remove redundant udata check from alloc ucontext response
      RDMA/efa: Group keep alive received counter with other SW stats

Gioh Kim (1):
      RDMA/rtrs: Remove unused field of rtrs_iu

H=C3=A5kon Bugge (7):
      IB/mlx4: Add and improve logging
      IB/mlx4: Add support for MRA
      IB/mlx4: Separate tunnel and wire bufs parameters
      IB/mlx4: Fix starvation in paravirt mux/demux
      IB/mlx4: Add support for REJ due to timeout
      IB/mlx4: Adjust delayed work when a dup is observed
      IB/mlx4: Convert rej_tmout radix-tree to XArray

Jason Gunthorpe (59):
      RDMA/cm: Remove unused cm_class
      RDMA/ucma: Fix refcount 0 incr in ucma_get_ctx()
      RDMA/ucma: Remove unnecessary locking of file->ctx_list in close
      RDMA/ucma: Consolidate the two destroy flows
      RDMA/ucma: Fix error cases around ucma_alloc_ctx()
      RDMA/ucma: Remove mc_list and rely on xarray
      RDMA/cma: Add missing locking to rdma_accept()
      RDMA/ucma: Do not use file->mut to lock destroying
      RDMA/ucma: Fix the locking of ctx->file
      RDMA/ucma: Fix locking for ctx->events_reported
      RDMA/ucma: Add missing locking around rdma_leave_multicast()
      RDMA/ucma: Change backlog into an atomic
      RDMA/ucma: Narrow file->mut in ucma_event_handler()
      RDMA/ucma: Rework how new connections are passed through event delive=
ry
      RDMA/ucma: Remove closing and the close_wq
      RDMA/core: Trigger a WARN_ON if the driver causes uobjects to become =
leaked
      RDMA/umem: Fix signature of stub ib_umem_find_best_pgsz()
      Merge tag 'v5.9-rc3' into rdma.git for-next
      RDMA/core: Change how failing destroy is handled during uobj abort
      RDMA/umem: Fix ib_umem_find_best_pgsz() for mappings that cross a pag=
e boundary
      RDMA/umem: Prevent small pages from being returned by ib_umem_find_be=
st_pgsz()
      RDMA/umem: Use simpler logic for ib_umem_find_best_pgsz()
      RDMA/umem: Add rdma_umem_for_each_dma_block()
      RDMA/umem: Replace for_each_sg_dma_page with rdma_umem_for_each_dma_b=
lock
      RDMA/umem: Split ib_umem_num_pages() into ib_umem_num_dma_blocks()
      RDMA/efa: Use ib_umem_num_dma_pages()
      RDMA/i40iw: Use ib_umem_num_dma_pages()
      RDMA/qedr: Use rdma_umem_for_each_dma_block() instead of open-coding
      RDMA/qedr: Use ib_umem_num_dma_blocks() instead of ib_umem_page_count=
()
      RDMA/bnxt: Do not use ib_umem_page_count() or ib_umem_num_pages()
      RDMA/hns: Use ib_umem_num_dma_blocks() instead of opencoding
      RDMA/ocrdma: Use ib_umem_num_dma_blocks() instead of ib_umem_page_cou=
nt()
      RDMA/pvrdma: Use ib_umem_num_dma_blocks() instead of ib_umem_page_cou=
nt()
      RDMA/mlx4: Use ib_umem_num_dma_blocks()
      RDMA/qedr: Remove fbo and zbva from the MR
      RDMA/ocrdma: Remove fbo from MR
      RDMA/cma: Fix locking for the RDMA_CM_CONNECT state
      RDMA/cma: Make the locking for automatic state transition more clear
      RDMA/cma: Fix locking for the RDMA_CM_LISTEN state
      RDMA/cma: Remove cma_comp()
      RDMA/cma: Combine cma_ndev_work with cma_work
      RDMA/cma: Remove dead code for kernel rdmacm multicast
      RDMA/cma: Consolidate the destruction of a cma_multicast in one place
      RDMA/cma: Fix use after free race in roce multicast join
      Merge branch 'mlx5_active_speed' into rdma.git for-next
      Merge branch 'mlx_sw_owner_v2' into rdma.git for-next
      RDMA/mlx5: Remove dead check for EAGAIN after alloc_mr_from_cache()
      RDMA/mlx5: Use set_mkc_access_pd_addr_fields() in reg_create()
      RDMA/mlx5: Make mkeys always owned by the kernel's PD when not enabled
      RDMA/mlx5: Disable IB_DEVICE_MEM_MGT_EXTENSIONS if IB_WR_REG_MR can't=
 work
      RDMA/mlx5: Clarify what the UMR is for when creating MRs
      RDMA/ucma: Rework ucma_migrate_id() to avoid races with destroy
      RDMA/core: Remove ucontext->closing
      RDMA/addr: Fix race with netevent_callback()/rdma_addr_cancel()
      RDMA/bnxt_re: Use rdma_umem_for_each_dma_block()
      Merge branch 'dynamic_sg' into rdma.git for-next
      lib/scatterlist: Do not limit max_segment to PAGE_ALIGNED values
      RDMA: Explicitly pass in the dma_device to ib_register_device
      RDMA/rxe: Move the definitions for rxe_av.network_type to uAPI

Jiaran Zhang (2):
      RDMA/hns: Add check for the validity of sl configuration
      RDMA/hns: Solve the overflow of the calc_pg_sz()

Joe Perches (1):
      MAINTAINERS: CISCO VIC LOW LATENCY NIC DRIVER

Julia Lawall (1):
      RDMA/efa: Drop double zeroing for sg_init_table()

Kamal Heib (4):
      RDMA/vmw_pvrdma: Fix kernel-doc documentation
      RDMA/usnic: Remove the query_pkey callback
      RDMA/qedr: Fix reported max_pkeys
      RDMA/ipoib: Set rtnl_link_ops for ipoib interfaces

Keita Suzuki (1):
      RDMA/qedr: Fix resource leak in qedr_create_qp

Lang Cheng (3):
      RDMA/hns: Add a check for current state before modifying QP
      RDMA/hns: Correct typo of hns_roce_create_cq()
      RDMA/hns: Remove unused variables and definitions

Leon Romanovsky (31):
      RDMA/mlx5: Simplify multiple else-if cases with switch keyword
      RDMA/mlx5: Replace open-coded offsetofend() macro
      RDMA: Remove constant domain argument from flow creation call
      RDMA/mlx5: Fix potential race between destroy and CQE poll
      RDMA: Restore ability to fail on PD deallocate
      RDMA: Restore ability to fail on AH destroy
      RDMA/mlx5: Issue FW command to destroy SRQ on reentry
      RDMA: Restore ability to fail on SRQ destroy
      RDMA/core: Delete function indirection for alloc/free kernel CQ
      RDMA: Allow fail of destroy CQ
      RDMA: Change XRCD destroy return value
      RDMA: Restore ability to return error for destroy WQ
      RDMA: Make counters destroy symmetrical
      RDMA: Clean MW allocation and free flows
      RDMA: Convert RWQ table logic to ib_core allocation scheme
      RDMA/cma: Delete from restrack DB after successful destroy
      RDMA/mlx5: Don't call to restrack recursively
      RDMA/restrack: Count references to the verbs objects
      RDMA/restrack: Simplify restrack tracking in kernel flows
      RDMA/restrack: Improve readability in task name management
      RDMA/mlx5: Embed GSI QP into general mlx5_ib QP
      RDMA/mlx5: Reuse existing fields in parent QP storage object
      RDMA/mlx5: Change GSI QP to have same creation flow like other QPs
      RDMA/mlx5: Delete not needed GSI QP signal QP type
      RDMA/mlx4: Embed GSI QP into general mlx4_ib QP
      RDMA/mlx4: Prepare QP allocation to remove from the driver
      RDMA/core: Align write and ioctl checks of QP types
      RDMA/drivers: Remove udata check from special QP
      RDMA/mthca: Combine special QP struct with mthca QP
      RDMA/i40iw: Remove intermediate pointer that points to the same struct
      overflow: Include header file with SIZE_MAX declaration

Lijun Ou (2):
      RDMA/hns: Avoid unncessary initialization
      RDMA/hns: Set the unsupported wr opcode

Liu Shixin (2):
      RDMA/ipoib: Convert to use DEFINE_SEQ_ATTRIBUTE macro
      RDMA/mlx5: Fix type warning of sizeof in __mlx5_ib_alloc_counters()

Maor Gottlieb (4):
      RDMA/mlx5: Enable sniffer when device is in switchdev mode
      lib/scatterlist: Add support in dynamic allocation of SG table from p=
ages
      RDMA/umem: Move to allocate SG table from pages
      RDMA/ucma: Fix use after free in destroy id flow

Mark Zhang (3):
      RDMA/mlx5: Add new IB rates support
      IB/mlx5: Add tx_affinity support for DCI QP
      IB/mlx5: Add DCT RoCE LAG support

Max Gurtovoy (1):
      IB/isert: remove duplicated error prints

Md Haris Iqbal (1):
      RDMA/rtrs-srv: Incorporate ib_register_client into rtrs server init

Michal Kalderon (8):
      RDMA/qedr: Fix qp structure memory leak
      RDMA/qedr: Fix doorbell setting
      RDMA/qedr: Fix use of uninitialized field
      RDMA/qedr: Fix return code if accept is called on a destroyed qp
      qede: Notify qedr when mtu has changed
      RDMA/qedr: Fix iWARP active mtu display
      RDMA/qedr: Fix inline size returned for iWARP
      RDMA/qedr: Fix function prototype parameters alignment

Mohammad Heib (1):
      RDMA/rxe: prevent rxe creation on top of vlan interface

Parav Pandit (1):
      RDMA/i40iw: Avoid typecast from void to pci_dev

Potnuri Bharat Teja (1):
      RDMA/iw_cxgb4: Disable delayed ack by default

Rikard Falkeborn (2):
      RDMA/core: Constify struct attribute_group
      RDMA/rtrs: Constify static struct attribute_group

Sindhu, Devale (1):
      i40iw: Add support to make destroy QP synchronous

Tvrtko Ursulin (2):
      tools/testing/scatterlist: Rejuvenate bit-rotten test
      tools/testing/scatterlist: Show errors in human readable form

Weihang Li (5):
      RDMA/hns: Get udp sport num dynamically instead of using a fixed value
      RDMA/hns: Refactor process about opcode in post_send()
      RDMA/hns: Fix configuration of ack_req_freq in QPC
      RDMA/hns: Fix missing sq_sig_type when querying QP
      RDMA/hns: Support inline data in extented sge space for RC

Wenpeng Liang (4):
      RDMA/hns: Add support for EQE in size of 64 Bytes
      RDMA/hns: Add support for CQE in size of 64 Bytes
      RDMA/hns: Add support for QPC in size of 512 Bytes
      RDMA/hns: Fix the wrong value of rnr_retry when querying qp

Yangyang Li (2):
      RDMA/hns: Add support for SCCC in size of 64 Bytes
      RDMA/hns: Add interception for resizing SRQs

Yishai Hadas (4):
      IB/core: Improve ODP to use hmm_range_fault()
      IB/core: Enable ODP sync without faulting
      RDMA/mlx5: Extend advice MR to support non faulting mode
      RDMA/mlx5: Sync device with CPU pages upon ODP MR registration

Yuval Basson (1):
      RDMA/qedr: Add support for user mode XRC-SRQ's

 .clang-format                                      |   1 +
 Documentation/ABI/stable/sysfs-class-infiniband    |  17 -
 MAINTAINERS                                        |  17 +-
 drivers/gpu/drm/drm_prime.c                        |  11 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c        |  12 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c         |  15 +-
 drivers/infiniband/Kconfig                         |   1 +
 drivers/infiniband/core/Makefile                   |   2 +-
 drivers/infiniband/core/addr.c                     |  11 +-
 drivers/infiniband/core/cache.c                    |  72 ++-
 drivers/infiniband/core/cm.c                       | 126 ++--
 drivers/infiniband/core/cm_trace.c                 |  15 +
 drivers/infiniband/core/cm_trace.h                 | 414 ++++++++++++++
 drivers/infiniband/core/cma.c                      | 635 +++++++++++------=
----
 drivers/infiniband/core/cma_configfs.c             |   9 +-
 drivers/infiniband/core/cma_trace.h                |  40 --
 drivers/infiniband/core/core_priv.h                |  13 +-
 drivers/infiniband/core/counters.c                 |  15 +-
 drivers/infiniband/core/cq.c                       |  39 +-
 drivers/infiniband/core/device.c                   |  77 +--
 drivers/infiniband/core/rdma_core.c                |  34 +-
 drivers/infiniband/core/restrack.c                 | 161 +++---
 drivers/infiniband/core/restrack.h                 |  10 +-
 drivers/infiniband/core/sysfs.c                    |  15 +-
 drivers/infiniband/core/ucma.c                     | 542 ++++++++----------
 drivers/infiniband/core/umem.c                     | 139 ++---
 drivers/infiniband/core/umem_odp.c                 | 291 ++++------
 drivers/infiniband/core/uverbs_cmd.c               |  93 ++-
 drivers/infiniband/core/uverbs_main.c              |   7 +-
 drivers/infiniband/core/uverbs_std_types.c         |  15 +-
 .../infiniband/core/uverbs_std_types_counters.c    |   4 +-
 drivers/infiniband/core/uverbs_std_types_cq.c      |   8 +-
 drivers/infiniband/core/uverbs_std_types_device.c  | 199 ++++++-
 drivers/infiniband/core/uverbs_std_types_wq.c      |   2 +-
 drivers/infiniband/core/verbs.c                    | 114 ++--
 drivers/infiniband/hw/bnxt_re/bnxt_re.h            |   2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |  90 +--
 drivers/infiniband/hw/bnxt_re/ib_verbs.h           |   8 +-
 drivers/infiniband/hw/bnxt_re/main.c               |   3 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |   7 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |  11 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c          |  30 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h          |   3 +-
 drivers/infiniband/hw/cxgb4/cm.c                   |   4 +-
 drivers/infiniband/hw/cxgb4/cq.c                   |   3 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h             |   7 +-
 drivers/infiniband/hw/cxgb4/mem.c                  |  40 +-
 drivers/infiniband/hw/cxgb4/provider.c             |  11 +-
 drivers/infiniband/hw/cxgb4/qp.c                   |   3 +-
 drivers/infiniband/hw/efa/efa.h                    |  14 +-
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h    |  69 ++-
 drivers/infiniband/hw/efa/efa_com_cmd.c            |  28 +-
 drivers/infiniband/hw/efa/efa_com_cmd.h            |  18 +
 drivers/infiniband/hw/efa/efa_main.c               |   4 +-
 drivers/infiniband/hw/efa/efa_verbs.c              | 258 +++++++--
 drivers/infiniband/hw/hfi1/sdma.c                  |  22 +-
 drivers/infiniband/hw/hfi1/verbs.c                 |   2 +-
 drivers/infiniband/hw/hns/hns_roce_ah.c            |  23 +-
 drivers/infiniband/hw/hns/hns_roce_alloc.c         |   3 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c            |  27 +-
 drivers/infiniband/hw/hns/hns_roce_device.h        |  74 +--
 drivers/infiniband/hw/hns/hns_roce_hem.c           |   8 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |  51 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.h         |   4 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         | 534 ++++++++++++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |  43 +-
 drivers/infiniband/hw/hns/hns_roce_main.c          |  19 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c            |  81 +--
 drivers/infiniband/hw/hns/hns_roce_pd.c            |   3 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |  80 +--
 drivers/infiniband/hw/hns/hns_roce_srq.c           |   5 +-
 drivers/infiniband/hw/i40iw/i40iw.h                |   9 +-
 drivers/infiniband/hw/i40iw/i40iw_cm.c             |  10 +-
 drivers/infiniband/hw/i40iw/i40iw_hw.c             |   4 +-
 drivers/infiniband/hw/i40iw/i40iw_main.c           |  16 +-
 drivers/infiniband/hw/i40iw/i40iw_pble.c           |   4 +-
 drivers/infiniband/hw/i40iw/i40iw_type.h           |   3 +-
 drivers/infiniband/hw/i40iw/i40iw_utils.c          |  63 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c          |  64 ++-
 drivers/infiniband/hw/i40iw/i40iw_verbs.h          |   3 +-
 drivers/infiniband/hw/mlx4/ah.c                    |   5 -
 drivers/infiniband/hw/mlx4/cm.c                    | 152 ++++-
 drivers/infiniband/hw/mlx4/cq.c                    |   4 +-
 drivers/infiniband/hw/mlx4/mad.c                   | 158 ++---
 drivers/infiniband/hw/mlx4/main.c                  |  45 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h               |  62 +-
 drivers/infiniband/hw/mlx4/mr.c                    |  35 +-
 drivers/infiniband/hw/mlx4/qp.c                    | 345 +++++------
 drivers/infiniband/hw/mlx4/srq.c                   |   8 +-
 drivers/infiniband/hw/mlx5/ah.c                    |   9 +-
 drivers/infiniband/hw/mlx5/cmd.c                   |   8 +-
 drivers/infiniband/hw/mlx5/cmd.h                   |   4 +-
 drivers/infiniband/hw/mlx5/counters.c              |   7 +-
 drivers/infiniband/hw/mlx5/cq.c                    |  16 +-
 drivers/infiniband/hw/mlx5/fs.c                    | 148 ++---
 drivers/infiniband/hw/mlx5/gsi.c                   | 154 ++---
 drivers/infiniband/hw/mlx5/main.c                  |  70 ++-
 drivers/infiniband/hw/mlx5/mem.c                   |   4 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h               | 100 +++-
 drivers/infiniband/hw/mlx5/mr.c                    | 189 +++---
 drivers/infiniband/hw/mlx5/odp.c                   |  56 +-
 drivers/infiniband/hw/mlx5/qp.c                    | 182 +++---
 drivers/infiniband/hw/mlx5/qp.h                    |   4 +-
 drivers/infiniband/hw/mlx5/qpc.c                   |   5 +-
 drivers/infiniband/hw/mlx5/srq.c                   |  23 +-
 drivers/infiniband/hw/mlx5/srq.h                   |   2 +-
 drivers/infiniband/hw/mlx5/srq_cmd.c               |  22 +-
 drivers/infiniband/hw/mlx5/wr.c                    |  27 +-
 drivers/infiniband/hw/mthca/mthca_dev.h            |   2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c       |  39 +-
 drivers/infiniband/hw/mthca/mthca_provider.h       |  27 +-
 drivers/infiniband/hw/mthca/mthca_qp.c             |  75 ++-
 drivers/infiniband/hw/ocrdma/ocrdma.h              |   1 -
 drivers/infiniband/hw/ocrdma/ocrdma_ah.c           |   3 +-
 drivers/infiniband/hw/ocrdma/ocrdma_ah.h           |   2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_hw.c           |   5 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c         |   4 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c        |  38 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h        |   6 +-
 drivers/infiniband/hw/qedr/main.c                  |  31 +-
 drivers/infiniband/hw/qedr/qedr.h                  |  33 ++
 drivers/infiniband/hw/qedr/qedr_iw_cm.c            |   6 +-
 drivers/infiniband/hw/qedr/verbs.c                 | 438 ++++++++------
 drivers/infiniband/hw/qedr/verbs.h                 |  11 +-
 drivers/infiniband/hw/qib/qib.h                    |   6 +-
 drivers/infiniband/hw/qib/qib_iba7322.c            |   7 +-
 drivers/infiniband/hw/qib/qib_mad.c                |  52 +-
 drivers/infiniband/hw/qib/qib_sdma.c               |  10 +-
 drivers/infiniband/hw/usnic/usnic_ib_main.c        |   5 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c       |  18 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h       |   6 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c       |   7 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c     |   4 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_misc.c     |   9 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c       |   3 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c       |   9 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c      |   7 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c    |  15 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h    |  10 +-
 drivers/infiniband/sw/rdmavt/ah.c                  |   3 +-
 drivers/infiniband/sw/rdmavt/ah.h                  |   2 +-
 drivers/infiniband/sw/rdmavt/cq.c                  |   3 +-
 drivers/infiniband/sw/rdmavt/cq.h                  |   2 +-
 drivers/infiniband/sw/rdmavt/pd.c                  |   3 +-
 drivers/infiniband/sw/rdmavt/pd.h                  |   2 +-
 drivers/infiniband/sw/rdmavt/srq.c                 |   3 +-
 drivers/infiniband/sw/rdmavt/srq.h                 |   2 +-
 drivers/infiniband/sw/rdmavt/vt.c                  |  10 +-
 drivers/infiniband/sw/rxe/rxe.c                    |  43 +-
 drivers/infiniband/sw/rxe/rxe.h                    |  29 +-
 drivers/infiniband/sw/rxe/rxe_av.c                 |  29 +-
 drivers/infiniband/sw/rxe/rxe_comp.c               |  32 +-
 drivers/infiniband/sw/rxe/rxe_cq.c                 |  35 +-
 drivers/infiniband/sw/rxe/rxe_hdr.h                |  29 +-
 drivers/infiniband/sw/rxe/rxe_hw_counters.c        |  29 +-
 drivers/infiniband/sw/rxe/rxe_hw_counters.h        |  29 +-
 drivers/infiniband/sw/rxe/rxe_icrc.c               |  29 +-
 drivers/infiniband/sw/rxe/rxe_loc.h                |  29 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c              |  29 +-
 drivers/infiniband/sw/rxe/rxe_mmap.c               |  29 +-
 drivers/infiniband/sw/rxe/rxe_mr.c                 |  54 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |  39 +-
 drivers/infiniband/sw/rxe/rxe_net.h                |  29 +-
 drivers/infiniband/sw/rxe/rxe_opcode.c             |  29 +-
 drivers/infiniband/sw/rxe/rxe_opcode.h             |  29 +-
 drivers/infiniband/sw/rxe/rxe_param.h              |  29 +-
 drivers/infiniband/sw/rxe/rxe_pool.c               |  89 +--
 drivers/infiniband/sw/rxe/rxe_pool.h               |  36 +-
 drivers/infiniband/sw/rxe/rxe_qp.c                 |  32 +-
 drivers/infiniband/sw/rxe/rxe_queue.c              |  29 +-
 drivers/infiniband/sw/rxe/rxe_queue.h              |  29 +-
 drivers/infiniband/sw/rxe/rxe_recv.c               |  68 ++-
 drivers/infiniband/sw/rxe/rxe_req.c                |  33 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |  29 +-
 drivers/infiniband/sw/rxe/rxe_srq.c                |  29 +-
 drivers/infiniband/sw/rxe/rxe_sysfs.c              |  35 +-
 drivers/infiniband/sw/rxe/rxe_task.c               |  37 +-
 drivers/infiniband/sw/rxe/rxe_task.h               |  33 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |  52 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h              |  48 +-
 drivers/infiniband/sw/siw/siw_main.c               |   8 +-
 drivers/infiniband/sw/siw/siw_verbs.c              |   9 +-
 drivers/infiniband/sw/siw/siw_verbs.h              |   6 +-
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            |   6 +-
 drivers/infiniband/ulp/ipoib/ipoib_fs.c            |  50 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |   2 +
 drivers/infiniband/ulp/ipoib/ipoib_netlink.c       |  11 +
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c          |   2 +
 drivers/infiniband/ulp/isert/ib_isert.c            |  15 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c       |   6 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h             |   1 -
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c       |   4 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             |  76 ++-
 drivers/infiniband/ulp/rtrs/rtrs-srv.h             |   7 +
 .../ethernet/mellanox/mlx5/core/ipoib/ethtool.c    |  31 +-
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |  23 +-
 drivers/net/ethernet/qlogic/qed/qed_rdma.c         |  15 +-
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c    |   4 +-
 drivers/net/ethernet/qlogic/qede/qede_rdma.c       |  17 +
 include/linux/mlx5/mlx5_ifc.h                      |   6 +-
 include/linux/mlx5/port.h                          |  15 +-
 include/linux/overflow.h                           |   1 +
 include/linux/qed/qed_rdma_if.h                    |   2 -
 include/linux/qed/qede_rdma.h                      |   4 +-
 include/linux/scatterlist.h                        |  38 +-
 include/rdma/ib_cache.h                            |   3 +
 include/rdma/ib_cm.h                               |   3 -
 include/rdma/ib_umem.h                             |  46 +-
 include/rdma/ib_umem_odp.h                         |  21 +-
 include/rdma/ib_verbs.h                            | 212 ++-----
 include/rdma/rdma_cm.h                             |  46 +-
 include/rdma/restrack.h                            |  21 +-
 include/trace/events/rdma.h                        |  41 +-
 include/trace/events/rpcrdma.h                     |   1 +
 include/uapi/rdma/efa-abi.h                        |   1 +
 include/uapi/rdma/hns-abi.h                        |   4 +-
 include/uapi/rdma/ib_user_ioctl_cmds.h             |  16 +
 include/uapi/rdma/ib_user_ioctl_verbs.h            |  15 +
 include/uapi/rdma/ib_user_verbs.h                  |  11 +
 include/uapi/rdma/rdma_user_rxe.h                  |  12 +-
 lib/scatterlist.c                                  | 133 ++++-
 tools/testing/scatterlist/Makefile                 |   3 +-
 tools/testing/scatterlist/linux/mm.h               |  35 ++
 tools/testing/scatterlist/main.c                   |  53 +-
 224 files changed, 5209 insertions(+), 4693 deletions(-)
(diffstat from tag for-linus-merged)

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl+J68gACgkQOG33FX4g
mxqdxg//a55vnDUkdgvuEG8ttCN3yIDACYP7LSSIjzQBBv0MPyyi2DEwkL3wFDgM
n/xXiHnmiTNxEqkiWAyI/rB7+T413S0TAi4lgsMjj1Fx3XfyP+cxBGt0cL266iw4
u47RfX3gs+Bss9+PKYvFZbhnI43SAV4EIdsmbYj3/ELdjstBSvhXjuhpQfTJPEQI
8ornt33DL/gdewLpHtsuWNqELPq91t6AgG3woiEh0+x1QtGMu9FylWkTpH0CKVYD
Ah156Ru2z5HvJ+hT1lBU3PXquV0bTspFDvBFZ576mY+UVlY0Ql4o9akD88TYoifU
MTmdiP/PlRXeJ/IxhJ+1WDG86iJ7Ce6PGjkw2cJ4s3S7bhUXXmbzwdRAmQXA2Rx0
8CwqCmoCO8jyKdHphacHIa690Ap6nK/tDTrcC8m7e517Xl9wqAfWU2nI4I925HNO
Fv9kEhvn9MOx6Hdhj+hokQrDih22Hf9XiKBvQPmfYYLnR5xk79RUCAb/5ebVTuZP
mZKuzWWXQry3In33w05CtIlY4UkKmPAIrzpeR13/nB6kmBqJHkuD06KUuKODoGXu
9DXKpNn69Nn8Ld2urEl6pMmRoF+0cC8lPkaMxxZHTuEPSsJrJm9/5DJ2rkMiF3Zz
WvHEwjeAO7245gf8ET+acOlk+nYSva6aIIOjps2zQbcLJ11GjFY=
=hkPl
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
