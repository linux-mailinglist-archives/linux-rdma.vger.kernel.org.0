Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CB27BF8D1
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Oct 2023 12:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjJJKlf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Oct 2023 06:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjJJKld (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Oct 2023 06:41:33 -0400
Received: from out-207.mta1.migadu.com (out-207.mta1.migadu.com [IPv6:2001:41d0:203:375::cf])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB069A4
        for <linux-rdma@vger.kernel.org>; Tue, 10 Oct 2023 03:41:26 -0700 (PDT)
Message-ID: <54acca3e-ef7b-40be-867f-061544197557@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696934485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kbuRvYUnXLwt5Eabf+Y9M9gKKFbtbd8p+BYdxtoWbWw=;
        b=SyqsEVcOIWYM8NS+GdEKg4ngp/uXSli2+/xGrDu9rN56TO2twgp8A89weRFdIUyuUFAeeq
        LCeLNPG4DRWrrEeJADvQYeFegy3SWMAsAmR53pFRwz9x9j0AZ+aG6GVpXd7Qfhxkb/kywp
        TowYW7QYNMwRYLL9Epk+61d/KM5Jjh4=
Date:   Tue, 10 Oct 2023 18:41:17 +0800
MIME-Version: 1.0
Subject: Re: [bug report][bisected] rdma_rxe: blktests srp lead kernel panic
 with 64k page size
To:     Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Cc:     Robert Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <CAHj4cs8hVFz=3OkVBrfZ3PCHU3fWN=+GpH40PvAs49CZ3-pJvg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CAHj4cs8hVFz=3OkVBrfZ3PCHU3fWN=+GpH40PvAs49CZ3-pJvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/10/9 12:35, Yi Zhang 写道:
> Hello
> 
> blktests srp lead kernel panic[2] on aarch64 when the kernel enabled
> CONFIG_ARM64_64K_PAGES, bisect shows it was introduced from commit[1],
> pls help check it and let me know if you need any info/testing for it, thanks.
> 
> [1]
> commit 325a7eb85199ec9c5b5a7af812f43ea16b735569
> Author: Bob Pearson <rpearsonhpe@gmail.com>
> Date:   Thu Jan 19 17:59:36 2023 -0600
> 
>      RDMA/rxe: Cleanup page variables in rxe_mr.c
> 
>      Cleanup usage of mr->page_shift and mr->page_mask and introduce
>      an extractor for mr->ibmr.page_size. Normal usage in the kernel
>      has page_mask masking out offset in page rather than masking out
>      the page number. The rxe driver had reversed that which was confusing.
>      Implicitly there can be a per mr page_size which was not uniformly
>      supported.
> 
>      Link: https://lore.kernel.org/r/20230119235936.19728-6-rpearsonhpe@gmail.com
>      Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>      Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 

Hi, Yi

I delved into the commit. And the commit can not be reverted cleanly. So 
I made the following diff to try to revert this commit. After this 
commit is applied, rping can work well.

But I can not reproduce the problem that you reported. Can you try to 
make tests with the following diff to verify if this problem is fixed or 
not? Thanks a lot.

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c 
b/drivers/infiniband/sw/rxe/rxe_mr.c
index f54042e9aeb2..50a58fdd12f0 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -58,9 +58,6 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
         mr->rkey = mr->ibmr.rkey = key;

         mr->access = access;
-       mr->ibmr.page_size = PAGE_SIZE;
-       mr->page_mask = PAGE_MASK;
-       mr->page_shift = PAGE_SHIFT;
         mr->state = RXE_MR_STATE_INVALID;
  }

@@ -79,7 +76,7 @@ static unsigned long rxe_mr_iova_to_index(struct 
rxe_mr *mr, u64 iova)

  static unsigned long rxe_mr_iova_to_page_offset(struct rxe_mr *mr, u64 
iova)
  {
-       return iova & (mr_page_size(mr) - 1);
+       return iova & (PAGE_SIZE - 1);
  }

  static bool is_pmem_page(struct page *pg)
@@ -143,6 +140,9 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, 
u64 length, u64 iova,
                 return PTR_ERR(umem);
         }

+       mr->page_shift = PAGE_SHIFT;
+       mr->page_mask = PAGE_SIZE - 1;
+
         err = rxe_mr_fill_pages_from_sgt(mr, &umem->sgt_append.sgt);
         if (err) {
                 ib_umem_release(umem);
@@ -232,14 +232,16 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct 
scatterlist *sgl,
                   int sg_nents, unsigned int *sg_offset)
  {
         struct rxe_mr *mr = to_rmr(ibmr);
-       unsigned int page_size = mr_page_size(mr);
+       int n;

         mr->nbuf = 0;
-       mr->page_shift = ilog2(page_size);
-       mr->page_mask = ~((u64)page_size - 1);
-       mr->page_offset = mr->ibmr.iova & (page_size - 1);
+       n = ib_sg_to_pages(ibmr, sgl, sg_nents, sg_offset, rxe_set_page);
+
+       mr->page_shift = ilog2(ibmr->page_size);
+       mr->page_mask = ibmr->page_size - 1;
+       mr->offset = ibmr->iova & mr->page_mask;

-       return ib_sg_to_pages(ibmr, sgl, sg_nents, sg_offset, rxe_set_page);
+       return n;
  }

  static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h 
b/drivers/infiniband/sw/rxe/rxe_verbs.h
index ccb9d19ffe8a..f1424d315acd 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -309,7 +309,7 @@ struct rxe_mr {
         int                     access;
         atomic_t                num_mw;

-       unsigned int            page_offset;
+       u32                     offset;
         unsigned int            page_shift;
         u64                     page_mask;

@@ -321,7 +321,7 @@ struct rxe_mr {

  static inline unsigned int mr_page_size(struct rxe_mr *mr)
  {
-       return mr ? mr->ibmr.page_size : PAGE_SIZE;
+       return PAGE_SIZE;
  }

  enum rxe_mw_state {

Zhu Yanjun


> [2] dmesg:
> [ 1120.381103] run blktests srp/001 at 2023-10-08 21:02:34
> [ 1120.647692] null_blk: module loaded
> [ 1120.675092] null_blk: disk nullb0 created
> [ 1120.683950] null_blk: disk nullb1 created
> [ 1121.053881] rdma_rxe: loaded
> [ 1121.071624] (null): rxe_set_mtu: Set mtu to 1024
> [ 1121.080184] infiniband enP2p1s0v0_rxe: set active
> [ 1121.080194] infiniband enP2p1s0v0_rxe: added enP2p1s0v0
> [ 1121.128323] scsi_debug:sdebug_add_store: dif_storep 524288 bytes @
> ffff80009a460000
> [ 1121.129215] scsi_debug:sdebug_driver_probe: scsi_debug: trim
> poll_queues to 0. poll_q/nr_hw = (0/1)
> [ 1121.138297] scsi_debug:sdebug_driver_probe: host protection DIF3 DIX3
> [ 1121.138310] scsi host4: scsi_debug: version 0191 [20210520]
>    dev_size_mb=32, opts=0x0, submit_queues=1, statistics=0
> [ 1121.138813] scsi 4:0:0:0: Direct-Access     Linux    scsi_debug
>    0191 PQ: 0 ANSI: 7
> [ 1121.139134] scsi 4:0:0:0: Power-on or device reset occurred
> [ 1121.145365] sd 4:0:0:0: Attached scsi generic sg1 type 0
> [ 1121.145439] sd 4:0:0:0: [sdb] 65536 512-byte logical blocks: (33.6
> MB/32.0 MiB)
> [ 1121.145501] sd 4:0:0:0: [sdb] Write Protect is off
> [ 1121.145513] sd 4:0:0:0: [sdb] Mode Sense: 73 00 10 08
> [ 1121.145601] sd 4:0:0:0: [sdb] Write cache: enabled, read cache:
> enabled, supports DPO and FUA
> [ 1121.145758] sd 4:0:0:0: [sdb] Enabling DIX T10-DIF-TYPE3-CRC,
> application tag size 6 bytes
> [ 1121.145769] sd 4:0:0:0: [sdb] Enabling DIF Type 3 protection
> [ 1121.145777] sd 4:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
> [ 1121.145784] sd 4:0:0:0: [sdb] Optimal transfer size 524288 bytes
> [ 1121.148475] sd 4:0:0:0: [sdb] Attached SCSI disk
> [ 1121.552336] Rounding down aligned max_sectors from 4294967295 to 4294967168
> [ 1121.602229] ib_srpt:srpt_add_one: ib_srpt device = 000000000a5842dc
> [ 1121.602256] ib_srpt:srpt_use_srq: ib_srpt
> srpt_use_srq(enP2p1s0v0_rxe): use_srq = 0; ret = 0
> [ 1121.602266] ib_srpt:srpt_add_one: ib_srpt Target login info:
> id_ext=1e1b0dfffe9f67ae,ioc_guid=1e1b0dfffe9f67ae,pkey=ffff,service_id=1e1b0dfffe9f67ae
> [ 1121.602290] ib_srpt:srpt_add_one: ib_srpt added enP2p1s0v0_rxe.
> [ 1121.920615] Rounding down aligned max_sectors from 255 to 128
> [ 1121.948272] Rounding down aligned max_sectors from 255 to 128
> [ 1121.975917] Rounding down aligned max_sectors from 4294967295 to 4294967168
> [ 1122.487117] ib_srp:srp_add_one: ib_srp: srp_add_one:
> 18446744073709551615 / 4096 = 4503599627370495 <> 512
> [ 1122.487136] ib_srp:srp_add_one: ib_srp: enP2p1s0v0_rxe:
> mr_page_shift = 12, device->max_mr_size = 0xffffffffffffffff,
> device->max_fast_reg_page_list_len = 512, max_pages_per_mr = 512,
> mr_max_size = 0x200000
> [ 1122.539669] ib_srp:srp_parse_in: ib_srp: 10.19.240.81 -> 10.19.240.81:0
> [ 1122.539691] ib_srp:srp_parse_in: ib_srp: 10.19.240.81:5555 ->
> 10.19.240.81:5555
> [ 1122.539700] ib_srp:add_target_store: ib_srp: max_sectors = 1024;
> max_pages_per_mr = 512; mr_page_size = 4096; max_sectors_per_mr =
> 4096; mr_per_cmd = 2
> [ 1122.539710] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len = 8260
> [ 1122.544979] ib_srpt Received SRP_LOGIN_REQ with i_port_id
> fe80:0000:0000:0000:1e1b:0dff:fe9f:67ae, t_port_id
> 1e1b:0dff:fe9f:67ae:1e1b:0dff:fe9f:67ae and it_iu_len 8260 on port 1
> (guid=fe80:0000:0000:0000:1e1b:0dff:fe9f:67ae); pkey 0xffff
> [ 1122.545168] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset = 68
> [ 1122.546622] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib:
> max_cqe= 8191 max_sge= 32 sq_size = 8191 ch= 000000007ddb8927
> [ 1122.546726] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr
> 10.19.240.81 or i_port_id 0xfe800000000000001e1b0dfffe9f67ae
> [ 1122.546780] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection
> sess=00000000f393b6f7 name=10.19.240.81 ch=000000007ddb8927
> [ 1122.546973] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len = 8260
> [ 1122.546988] scsi host5: ib_srp: using immediate data
> [ 1122.547044] ib_srpt:srpt_zerolength_write: ib_srpt 10.19.240.81-18:
> queued zerolength write
> [ 1122.547127] ib_srpt:srpt_zerolength_write_done: ib_srpt
> 10.19.240.81-18 wc->status 0
> [ 1122.552276] ib_srpt Received SRP_LOGIN_REQ with i_port_id
> fe80:0000:0000:0000:1e1b:0dff:fe9f:67ae, t_port_id
> 1e1b:0dff:fe9f:67ae:1e1b:0dff:fe9f:67ae and it_iu_len 8260 on port 1
> (guid=fe80:0000:0000:0000:1e1b:0dff:fe9f:67ae); pkey 0xffff
> [ 1122.552527] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset = 68
> [ 1122.552969] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib:
> max_cqe= 8191 max_sge= 32 sq_size = 8191 ch= 00000000080908b6
> [ 1122.553054] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr
> 10.19.240.81 or i_port_id 0xfe800000000000001e1b0dfffe9f67ae
> [ 1122.553095] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection
> sess=000000005db9b14f name=10.19.240.81 ch=00000000080908b6
> [ 1122.553204] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len = 8260
> [ 1122.553216] scsi host5: ib_srp: using immediate data
> [ 1122.553267] ib_srpt:srpt_zerolength_write: ib_srpt 10.19.240.81-20:
> queued zerolength write
> [ 1122.553346] ib_srpt:srpt_zerolength_write_done: ib_srpt
> 10.19.240.81-20 wc->status 0
> [ 1122.558431] ib_srpt Received SRP_LOGIN_REQ with i_port_id
> fe80:0000:0000:0000:1e1b:0dff:fe9f:67ae, t_port_id
> 1e1b:0dff:fe9f:67ae:1e1b:0dff:fe9f:67ae and it_iu_len 8260 on port 1
> (guid=fe80:0000:0000:0000:1e1b:0dff:fe9f:67ae); pkey 0xffff
> [ 1122.558665] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset = 68
> [ 1122.559112] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib:
> max_cqe= 8191 max_sge= 32 sq_size = 8191 ch= 000000005bf29d9f
> [ 1122.559196] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr
> 10.19.240.81 or i_port_id 0xfe800000000000001e1b0dfffe9f67ae
> [ 1122.559235] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection
> sess=00000000496e5c2f name=10.19.240.81 ch=000000005bf29d9f
> [ 1122.559342] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len = 8260
> [ 1122.559352] scsi host5: ib_srp: using immediate data
> [ 1122.559390] Unable to handle kernel paging request at virtual
> address 001bb829281c2fb8
> [ 1122.559406] ib_srpt:srpt_zerolength_write: ib_srpt 10.19.240.81-22:
> queued zerolength write
> [ 1122.567320] Mem abort info:
> [ 1122.567323]   ESR = 0x0000000096000004
> [ 1122.567326]   EC = 0x25: DABT (current EL), IL = 32 bits
> [ 1122.567330]   SET = 0, FnV = 0
> [ 1122.567332]   EA = 0, S1PTW = 0
> [ 1122.567335]   FSC = 0x04: level 0 translation fault
> [ 1122.567338] Data abort info:
> [ 1122.567340]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [ 1122.567343]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [ 1122.567347]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [ 1122.567351] [001bb829281c2fb8] address between user and kernel address ranges
> [ 1122.567356] Internal error: Oops: 0000000096000004 [#1] SMP
> [ 1122.567361] Modules linked in: ib_srp scsi_transport_srp target_core_user
> [ 1122.575766] ib_srpt:srpt_zerolength_write_done: ib_srpt
> 10.19.240.81-22 wc->status 0
> [ 1122.578490]  uio target_core_pscsi target_core_file ib_srpt
> target_core_iblock target_core_mod rdma_cm iw_cm ib_cm scsi_debug
> rdma_rxe ib_uverbs ip6_udp_tunnel udp_tunnel null_blk dm_service_time
> ib_umad crc32_generic ib_core rfkill sunrpc vfat fat dm_multipath
> cavium_rng_vf thunderx_edac cavium_rng ipmi_ssif ipmi_devintf
> ipmi_msghandler drm fuse xfs libcrc32c nicvf cavium_ptp crct10dif_ce
> ghash_ce sha2_ce sha256_arm64 sha1_ce nicpf thunder_bgx i2c_thunderx
> thunder_xcv mdio_thunder mdio_cavium sg dm_mirror dm_region_hash
> dm_log dm_mod [last unloaded: null_blk]
> [ 1122.694324] CPU: 6 PID: 216 Comm: kworker/6:1 Kdump: loaded Not
> tainted 6.6.0-rc4+ #3
> [ 1122.709550] Workqueue: ib_cm cm_work_handler [ib_cm]
> [ 1122.714576] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [ 1122.721537] pc : __kmem_cache_alloc_node+0x100/0x2c0
> [ 1122.726506] lr : __kmem_cache_alloc_node+0xb4/0x2c0
> [ 1122.731382] sp : ffff800087bcfa10
> [ 1122.734692] x29: ffff800087bcfa10 x28: 0000000000000000 x27: b71eb439291cd087
> [ 1122.741835] x26: ffff80007cd82774 x25: 00000000ffffffff x24: 0000000000000068
> [ 1122.748977] x23: ffff8000820ba000 x22: f71bb829281c2f78 x21: 0000000000000000
> [ 1122.756119] x20: 0000000000000cc0 x19: ffff000100010700 x18: ffffffffffffffff
> [ 1122.763261] x17: 7a20646575657571 x16: 203a30322d31382e x15: ffff8000826feeff
> [ 1122.770403] x14: 0000000000000001 x13: 6174616420657461 x12: 6964656d6d692067
> [ 1122.777545] x11: 00000000ffff7fff x10: 00000000ffff7fff x9 : ffff800080398a00
> [ 1122.784688] x8 : ffff000148a5c000 x7 : 0000000000000000 x6 : 000000000000007f
> [ 1122.791829] x5 : ffff000107bac8c0 x4 : ffff80007cd82774 x3 : 000000000010f006
> [ 1122.798971] x2 : b82f1c2829b81bf7 x1 : f71bb829281c2f78 x0 : 0000000000000040
> [ 1122.806113] Call trace:
> [ 1122.808555]  __kmem_cache_alloc_node+0x100/0x2c0
> [ 1122.813178]  kmalloc_trace+0x40/0x110
> [ 1122.816842]  srp_alloc_iu.constprop.0+0x3c/0x168 [ib_srp]
> [ 1122.822268]  srp_alloc_iu_bufs+0xa0/0x240 [ib_srp]
> [ 1122.827072]  srp_cm_rep_handler+0x2a4/0x2d8 [ib_srp]
> [ 1122.832049]  srp_rdma_cm_handler+0x104/0x2c0 [ib_srp]
> [ 1122.837113]  cma_cm_event_handler+0x34/0x140 [rdma_cm]
> [ 1122.842306]  cma_ib_handler+0x98/0x310 [rdma_cm]
> [ 1122.846955]  cm_process_work+0x2c/0x1e8 [ib_cm]
> [ 1122.851517]  cm_queue_work_unlock+0x50/0x138 [ib_cm]
> [ 1122.856514]  cm_rep_handler+0x250/0x550 [ib_cm]
> [ 1122.861075]  cm_work_handler+0x2d8/0x3b8 [ib_cm]
> [ 1122.865724]  process_one_work+0x174/0x3c8
> [ 1122.869734]  worker_thread+0x2c8/0x3e0
> [ 1122.873481]  kthread+0x100/0x110
> [ 1122.876707]  ret_from_fork+0x10/0x20
> [ 1122.880286] Code: aa1603e1 f9405e7b 8b0002c2 dac00c42 (f8606ac4)
> [ 1122.886391] SMP: stopping secondary CPUs
> [ 1122.891420] Starting crashdump kernel...
> [ 1122.895341] Bye!
> 
> 

