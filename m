Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48A84FA78C
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Apr 2022 14:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiDIMQE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 9 Apr 2022 08:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiDIMQD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 9 Apr 2022 08:16:03 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66592A8899
        for <linux-rdma@vger.kernel.org>; Sat,  9 Apr 2022 05:13:54 -0700 (PDT)
Message-ID: <103051da-45c8-15e8-e039-244bf1d9e067@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649506432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H0n+rJRFKLdFpjx4exGlgd6tYMvrFHccDcOLZc5A+3Y=;
        b=WRQxgIBeBilB/yQ0ctWo2Ukb5hIpiTBO2e9DmppUfMc8iGSowDI7FkjcMze4pSZpzXsSjU
        h1Ls//PN5OImf1eyOGLGKe/X1GjhXvlpCt1yQwpGix4K1pAv7HtQOdxXaVM+wEmfvbfJvg
        Frtk2QVFESyUImQGZ2/qBIQEGOVKvaQ=
Date:   Sat, 9 Apr 2022 20:13:41 +0800
MIME-Version: 1.0
Subject: Re: [bug report] rdma_rxe: WARNING: inconsistent lock state,
 inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage
To:     Yi Zhang <yi.zhang@redhat.com>, Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Robert Pearson <rpearsonhpe@gmail.com>
References: <CAHj4cs-MT13RiEsWXUAcX_H5jEtjsebuZgSeUcfptNVuELgjYQ@mail.gmail.com>
 <ebcabe3b-56f9-533b-e975-3a9945c3ee99@linux.dev>
 <CAHj4cs-XYMAtoLpVTAKL601SBkz+-8ctcP49MA7T5X-PjoqdMg@mail.gmail.com>
 <e677d777-8646-81d4-3299-e4e390587074@linux.dev>
 <CAHj4cs8EcLsMWCan=YStQX+DtEqACPUeMqjqN=Deg=grUfp-gw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <CAHj4cs8EcLsMWCan=YStQX+DtEqACPUeMqjqN=Deg=grUfp-gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/4/9 13:33, Yi Zhang 写道:
> Hi Yanjun
> 
> Pls check the full log below:

Hi,

With rping, I can also reproduce this problem.
And with the following diff, all the warnings and dead lock will disappear.

But sometimes the kernel will crash after long time running. I am 
working on it.

Please make tests and let me know the test result. Thanks a lot.

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c 
b/drivers/infiniband/sw/rxe/rxe_pool.c
index 87066d04ed18..8af428a15672 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -121,6 +121,7 @@ void *rxe_alloc(struct rxe_pool *pool)
         struct rxe_pool_elem *elem;
         void *obj;
         int err;
+       unsigned long flags;

         if (WARN_ON(!(pool->flags & RXE_POOL_ALLOC)))
                 return NULL;
@@ -138,8 +139,10 @@ void *rxe_alloc(struct rxe_pool *pool)
         elem->obj = obj;
         kref_init(&elem->ref_cnt);

-       err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
-                             &pool->next, GFP_KERNEL);
+       xa_lock_irqsave(&pool->xa, flags);
+       err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
+                               &pool->next, GFP_KERNEL);
+       xa_unlock_irqrestore(&pool->xa, flags);
         if (err)
                 goto err_free;

@@ -155,6 +158,7 @@ void *rxe_alloc(struct rxe_pool *pool)
  int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
  {
         int err;
+       unsigned long flags;

         if (WARN_ON(pool->flags & RXE_POOL_ALLOC))
                 return -EINVAL;
@@ -166,8 +170,10 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct 
rxe_pool_elem *elem)
         elem->obj = (u8 *)elem - pool->elem_offset;
         kref_init(&elem->ref_cnt);

-       err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
-                             &pool->next, GFP_KERNEL);
+       xa_lock_irqsave(&pool->xa, flags);
+       err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
+                               &pool->next, GFP_KERNEL);
+       xa_unlock_irqrestore(&pool->xa, flags);
         if (err)
                 goto err_cnt;

@@ -200,8 +206,11 @@ static void rxe_elem_release(struct kref *kref)
  {
         struct rxe_pool_elem *elem = container_of(kref, typeof(*elem), 
ref_cnt);
         struct rxe_pool *pool = elem->pool;
+       unsigned long flags;

-       xa_erase(&pool->xa, elem->index);
+       xa_lock_irqsave(&pool->xa, flags);
+       __xa_erase(&pool->xa, elem->index);
+       xa_unlock_irqrestore(&pool->xa, flags);

         if (pool->cleanup)
                 pool->cleanup(elem);

Zhu Yanjun

> 
> [  154.195111] run blktests srp/001 at 2022-04-09 01:24:07
> [  154.884071] null_blk: module loaded
> [  155.147385] device-mapper: multipath service-time: version 0.3.0 loaded
> [  155.150041] device-mapper: table: 253:3: multipath: error getting
> device (-EBUSY)
> [  155.157596] device-mapper: ioctl: error adding target to table
> [  155.249783] rdma_rxe: loaded
> [  155.317915] infiniband eno1_rxe: set active
> [  155.317934] infiniband eno1_rxe: added eno1
> [  155.359282] eno2 speed is unknown, defaulting to 1000
> [  155.364471] eno2 speed is unknown, defaulting to 1000
> [  155.369831] eno2 speed is unknown, defaulting to 1000
> [  155.408213] infiniband eno2_rxe: set down
> [  155.408220] infiniband eno2_rxe: added eno2
> [  155.408707] eno2 speed is unknown, defaulting to 1000
> [  155.434214] eno2 speed is unknown, defaulting to 1000
> [  155.450731] eno3 speed is unknown, defaulting to 1000
> [  155.455862] eno3 speed is unknown, defaulting to 1000
> [  155.461208] eno3 speed is unknown, defaulting to 1000
> [  155.499441] infiniband eno3_rxe: set down
> [  155.499448] infiniband eno3_rxe: added eno3
> [  155.499689] eno3 speed is unknown, defaulting to 1000
> [  155.525458] eno2 speed is unknown, defaulting to 1000
> [  155.530772] eno3 speed is unknown, defaulting to 1000
> [  155.547309] eno4 speed is unknown, defaulting to 1000
> [  155.552440] eno4 speed is unknown, defaulting to 1000
> [  155.557788] eno4 speed is unknown, defaulting to 1000
> [  155.596054] infiniband eno4_rxe: set down
> [  155.596061] infiniband eno4_rxe: added eno4
> [  155.596613] eno4 speed is unknown, defaulting to 1000
> [  155.712777] scsi_debug:sdebug_add_store: dif_storep 524288 bytes @
> ffffc9000112c000
> [  155.715031] scsi_debug:sdebug_driver_probe: scsi_debug: trim
> poll_queues to 0. poll_q/nr_hw = (0/1)
> [  155.724090] scsi_debug:sdebug_driver_probe: host protection DIF3 DIX3
> [  155.724098] scsi host15: scsi_debug: version 0191 [20210520]
>                   dev_size_mb=32, opts=0x0, submit_queues=1, statistics=0
> [  155.727128] scsi 15:0:0:0: Direct-Access     Linux    scsi_debug
>     0191 PQ: 0 ANSI: 7
> [  155.729894] sd 15:0:0:0: Attached scsi generic sg1 type 0
> [  155.730139] sd 15:0:0:0: Power-on or device reset occurred
> [  155.735821] sd 15:0:0:0: [sdb] Enabling DIF Type 3 protection
> [  155.736235] sd 15:0:0:0: [sdb] 65536 512-byte logical blocks: (33.6
> MB/32.0 MiB)
> [  155.736294] sd 15:0:0:0: [sdb] Write Protect is off
> [  155.736310] sd 15:0:0:0: [sdb] Mode Sense: 73 00 10 08
> [  155.736405] sd 15:0:0:0: [sdb] Write cache: enabled, read cache:
> enabled, supports DPO and FUA
> [  155.736610] sd 15:0:0:0: [sdb] Optimal transfer size 524288 bytes
> [  155.749700] sd 15:0:0:0: [sdb] Enabling DIX T10-DIF-TYPE3-CRC protection
> [  155.749715] sd 15:0:0:0: [sdb] DIF application tag size 6
> [  155.750455] sd 15:0:0:0: [sdb] Attached SCSI disk
> [  156.559521] eno2 speed is unknown, defaulting to 1000
> [  156.664761] eno3 speed is unknown, defaulting to 1000
> [  156.770702] eno4 speed is unknown, defaulting to 1000
> [  156.927509] Rounding down aligned max_sectors from 4294967295 to 4294967288
> [  156.996061] ib_srpt:srpt_add_one: ib_srpt device = 00000000b38bff2d
> [  156.996162] ib_srpt:srpt_use_srq: ib_srpt srpt_use_srq(eno1_rxe):
> use_srq = 0; ret = 0
> [  156.996168] ib_srpt:srpt_add_one: ib_srpt Target login info:
> id_ext=f2d4e2fffee6e1e0,ioc_guid=f2d4e2fffee6e1e0,pkey=ffff,service_id=f2d4e2fffee6e1e0
> [  156.996450] ib_srpt:srpt_add_one: ib_srpt added eno1_rxe.
> [  156.996460] ib_srpt:srpt_add_one: ib_srpt device = 000000000c435da2
> [  156.996492] ib_srpt:srpt_use_srq: ib_srpt srpt_use_srq(eno2_rxe):
> use_srq = 0; ret = 0
> [  156.996497] ib_srpt:srpt_add_one: ib_srpt Target login info:
> id_ext=f2d4e2fffee6e1e0,ioc_guid=f2d4e2fffee6e1e0,pkey=ffff,service_id=f2d4e2fffee6e1e0
> [  156.996508] eno2 speed is unknown, defaulting to 1000
> [  157.001651] ib_srpt:srpt_add_one: ib_srpt added eno2_rxe.
> [  157.001659] ib_srpt:srpt_add_one: ib_srpt device = 00000000a61769b4
> [  157.001699] ib_srpt:srpt_use_srq: ib_srpt srpt_use_srq(eno3_rxe):
> use_srq = 0; ret = 0
> [  157.001703] ib_srpt:srpt_add_one: ib_srpt Target login info:
> id_ext=f2d4e2fffee6e1e0,ioc_guid=f2d4e2fffee6e1e0,pkey=ffff,service_id=f2d4e2fffee6e1e0
> [  157.001714] eno3 speed is unknown, defaulting to 1000
> [  157.006815] ib_srpt:srpt_add_one: ib_srpt added eno3_rxe.
> [  157.006823] ib_srpt:srpt_add_one: ib_srpt device = 000000008f72349b
> [  157.006856] ib_srpt:srpt_use_srq: ib_srpt srpt_use_srq(eno4_rxe):
> use_srq = 0; ret = 0
> [  157.006860] ib_srpt:srpt_add_one: ib_srpt Target login info:
> id_ext=f2d4e2fffee6e1e0,ioc_guid=f2d4e2fffee6e1e0,pkey=ffff,service_id=f2d4e2fffee6e1e0
> [  157.006871] eno4 speed is unknown, defaulting to 1000
> [  157.011971] ib_srpt:srpt_add_one: ib_srpt added eno4_rxe.
> [  157.476167] Rounding down aligned max_sectors from 255 to 248
> [  157.546137] Rounding down aligned max_sectors from 255 to 248
> [  157.616022] Rounding down aligned max_sectors from 4294967295 to 4294967288
> [  160.335819] ib_srp:srp_add_one: ib_srp: srp_add_one:
> 18446744073709551615 / 4096 = 4503599627370495 <> 512
> [  160.335830] ib_srp:srp_add_one: ib_srp: eno1_rxe: mr_page_shift =
> 12, device->max_mr_size = 0xffffffffffffffff,
> device->max_fast_reg_page_list_len = 512, max_pages_per_mr = 512,
> mr_max_size = 0x200000
> [  160.336229] ib_srp:srp_add_one: ib_srp: srp_add_one:
> 18446744073709551615 / 4096 = 4503599627370495 <> 512
> [  160.336235] ib_srp:srp_add_one: ib_srp: eno2_rxe: mr_page_shift =
> 12, device->max_mr_size = 0xffffffffffffffff,
> device->max_fast_reg_page_list_len = 512, max_pages_per_mr = 512,
> mr_max_size = 0x200000
> [  160.336757] ib_srp:srp_add_one: ib_srp: srp_add_one:
> 18446744073709551615 / 4096 = 4503599627370495 <> 512
> [  160.336763] ib_srp:srp_add_one: ib_srp: eno3_rxe: mr_page_shift =
> 12, device->max_mr_size = 0xffffffffffffffff,
> device->max_fast_reg_page_list_len = 512, max_pages_per_mr = 512,
> mr_max_size = 0x200000
> [  160.337006] ib_srp:srp_add_one: ib_srp: srp_add_one:
> 18446744073709551615 / 4096 = 4503599627370495 <> 512
> [  160.337011] ib_srp:srp_add_one: ib_srp: eno4_rxe: mr_page_shift =
> 12, device->max_mr_size = 0xffffffffffffffff,
> device->max_fast_reg_page_list_len = 512, max_pages_per_mr = 512,
> mr_max_size = 0x200000
> [  160.489879] ib_srp:srp_parse_in: ib_srp: 10.16.221.116 -> 10.16.221.116:0
> [  160.489910] ib_srp:srp_parse_in: ib_srp: 10.16.221.116:5555 ->
> 10.16.221.116:5555
> [  160.489971] ib_srp:add_target_store: ib_srp: max_sectors = 1024;
> max_pages_per_mr = 512; mr_page_size = 4096; max_sectors_per_mr =
> 4096; mr_per_cmd = 2
> [  160.489978] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len = 8260
> [  160.499158] ------------[ cut here ]------------
> [  160.503831] WARNING: CPU: 25 PID: 1907 at kernel/softirq.c:363
> __local_bh_enable_ip+0xc7/0x110
> [  160.512450] Modules linked in: ib_srp scsi_transport_srp
> target_core_user uio target_core_pscsi target_core_file ib_srpt
> target_core_iblock target_core_mod rdma_cm iw_cm ib_cm ib_umad
> scsi_debug rdma_rxe ib_uverbs dm_service_time ip6_udp_tunnel
> udp_tunnel null_blk dm_multipath ib_core rpcsec_gss_krb5 auth_rpcgss
> nfsv4 dns_resolver nfs lockd grace fscache netfs rfkill sunrpc vfat
> fat kmem intel_rapl_msr intel_rapl_common isst_if_common iTCO_wdt
> iTCO_vendor_support mgag200 skx_edac i2c_algo_bit x86_pkg_temp_thermal
> drm_shmem_helper intel_powerclamp drm_kms_helper coretemp syscopyarea
> sysfillrect sysimgblt fb_sys_fops kvm_intel kvm irqbypass
> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel rapl intel_cstate
> drm device_dax intel_uncore mei_me wmi_bmof pcspkr i2c_i801 mei
> lpc_ich i2c_smbus intel_pch_thermal nd_pmem ipmi_ssif nd_btt dax_pmem
> acpi_power_meter xfs libcrc32c sd_mod t10_pi crc64_rocksoft crc64 sg
> ahci libahci nfit crc32c_intel libata megaraid_sas tg3 wmi libnvdimm
> dm_mirror
> [  160.512669]  dm_region_hash dm_log dm_mod ipmi_si ipmi_devintf
> ipmi_msghandler
> [  160.606678] CPU: 25 PID: 1907 Comm: check Tainted: G S        I
>    5.18.0-rc1.yanjun.v1+ #2
> [  160.615293] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS
> 2.11.2 004/21/2021
> [  160.622944] RIP: 0010:__local_bh_enable_ip+0xc7/0x110
> [  160.627996] Code: 00 e8 5d 83 08 00 e8 78 7a 3b 00 fb 65 8b 05 d0
> 93 e1 61 85 c0 75 05 0f 1f 44 00 00 5b 5d c3 65 8b 05 29 a0 e1 61 85
> c0 75 9d <0f> 0b eb 99 e8 00 79 3b 00 eb 9a 48 89 ef e8 86 0a 16 00 eb
> a3 48
> [  160.646744] RSP: 0018:ffff88810a9ef3f0 EFLAGS: 00010046
> [  160.651978] RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
> [  160.659110] RDX: 0000000000000000 RSI: 0000000000000200 RDI: ffffffffa228d58c
> [  160.666243] RBP: ffffffffc241cd72 R08: ffffed103a3de28b R09: ffffed103a3de28b
> [  160.673375] R10: ffff8881d1ef1453 R11: ffffed103a3de28a R12: ffff8881d1ef1450
> [  160.680508] R13: ffff8881d1ef143c R14: ffff8882a4823850 R15: ffff8881d1ef14b0
> [  160.687638] FS:  00007fbae6b89740(0000) GS:ffff888e2fc00000(0000)
> knlGS:0000000000000000
> [  160.695725] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  160.701470] CR2: 00005558050bac08 CR3: 00000001e1a5a002 CR4: 00000000007706e0
> [  160.708602] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  160.715734] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  160.722867] PKRU: 55555554
> [  160.725581] Call Trace:
> [  160.728033]  <TASK>
> [  160.730141]  __rxe_add_to_pool+0x1ce/0x260 [rdma_rxe]
> [  160.735209]  rxe_create_ah+0xe2/0x330 [rdma_rxe]
> [  160.739849]  _rdma_create_ah+0x391/0x490 [ib_core]
> [  160.744678]  ? __ib_create_cq+0x260/0x260 [ib_core]
> [  160.749577]  ? rcu_read_lock_bh_held+0xc0/0xc0
> [  160.754040]  rdma_create_ah+0x185/0x250 [ib_core]
> [  160.758769]  ? _rdma_create_ah+0x490/0x490 [ib_core]
> [  160.763772]  cm_alloc_msg+0x15f/0x510 [ib_cm]
> [  160.768147]  cm_alloc_priv_msg+0x4c/0xb0 [ib_cm]
> [  160.772781]  ib_send_cm_req+0x816/0x1000 [ib_cm]
> [  160.777413]  ? ib_send_cm_rej+0x80/0x80 [ib_cm]
> [  160.781974]  ? lock_is_held_type+0xd9/0x130
> [  160.786179]  ? rcu_read_lock_bh_held+0xc0/0xc0
> [  160.790633]  ? _raw_spin_unlock+0x29/0x40
> [  160.794661]  rdma_connect_locked+0x795/0x1940 [rdma_cm]
> [  160.799899]  ? rdma_create_qp+0x6d0/0x6d0 [rdma_cm]
> [  160.804795]  ? lock_release+0x42f/0xc90
> [  160.808637]  ? rdma_connect+0x20/0x40 [rdma_cm]
> [  160.813188]  ? mutex_lock_io_nested+0x1460/0x1460
> [  160.817898]  ? rcu_read_lock_sched_held+0xaf/0xe0
> [  160.822610]  ? __kasan_slab_alloc+0x2f/0x90
> [  160.826830]  rdma_connect+0x2b/0x40 [rdma_cm]
> [  160.831201]  srp_send_req+0x9ed/0x1660 [ib_srp]
> [  160.835746]  ? module_assert_mutex_or_preempt+0x41/0x70
> [  160.840974]  ? __module_address.part.54+0x25/0x380
> [  160.845769]  ? srp_qp_event+0x60/0x60 [ib_srp]
> [  160.850225]  ? is_module_address+0x41/0x60
> [  160.854331]  ? static_obj+0x97/0xc0
> [  160.857832]  ? lockdep_init_map_type+0x2f8/0x7f0
> [  160.862471]  srp_connect_ch+0xe3/0x1f0 [ib_srp]
> [  160.867018]  add_target_store+0x1196/0x28e0 [ib_srp]
> [  160.871993]  ? __lock_acquire+0xc24/0x34a0
> [  160.876124]  ? srp_create_ch_ib+0x13e0/0x13e0 [ib_srp]
> [  160.881267]  ? lock_acquire+0x1e2/0x5a0
> [  160.885116]  ? rcu_read_unlock+0x50/0x50
> [  160.889052]  ? lock_is_held_type+0xd9/0x130
> [  160.893258]  ? kernfs_fop_write_iter+0x2d0/0x490
> [  160.897885]  kernfs_fop_write_iter+0x2d0/0x490
> [  160.902340]  new_sync_write+0x33a/0x550
> [  160.906192]  ? new_sync_read+0x540/0x540
> [  160.910140]  ? lock_is_held_type+0xd9/0x130
> [  160.914338]  ? rcu_read_lock_held+0xc0/0xc0
> [  160.918541]  vfs_write+0x617/0x910
> [  160.921960]  ksys_write+0xf1/0x1c0
> [  160.925369]  ? __ia32_sys_read+0xb0/0xb0
> [  160.929299]  ? syscall_trace_enter.isra.15+0x175/0x250
> [  160.934455]  do_syscall_64+0x37/0x80
> [  160.938040]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  160.943099] RIP: 0033:0x7fbae5d205c8
> [  160.946685] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00
> 00 00 f3 0f 1e fa 48 8d 05 d5 3f 2a 00 8b 00 85 c0 75 17 b8 01 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89
> d4 55
> [  160.965430] RSP: 002b:00007ffd98335b28 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> [  160.972996] RAX: ffffffffffffffda RBX: 0000000000000081 RCX: 00007fbae5d205c8
> [  160.980130] RDX: 0000000000000081 RSI: 000055580502ca20 RDI: 0000000000000001
> [  160.987262] RBP: 000055580502ca20 R08: 000000000000000a R09: 00007fbae5d80820
> [  160.994395] R10: 000000000000000a R11: 0000000000000246 R12: 00007fbae5fc06e0
> [  161.001525] R13: 0000000000000081 R14: 00007fbae5fbb880 R15: 0000000000000081
> [  161.008685]  </TASK>
> [  161.010876] irq event stamp: 298919
> [  161.014368] hardirqs last  enabled at (298917):
> [<ffffffffa0370be0>] _raw_read_unlock_irqrestore+0x30/0x50
> [  161.024014] hardirqs last disabled at (298918):
> [<ffffffffa0370219>] _raw_spin_lock_irqsave+0x69/0x90
> [  161.033228] softirqs last  enabled at (297844):
> [<ffffffffa060064a>] __do_softirq+0x64a/0xa4c
> [  161.041748] softirqs last disabled at (298919):
> [<ffffffffc241cce8>] __rxe_add_to_pool+0x138/0x260 [rdma_rxe]
> [  161.051660] ---[ end trace 0000000000000000 ]---
> 
> [  161.058297] ================================
> [  161.062572] WARNING: inconsistent lock state
> [  161.066844] 5.18.0-rc1.yanjun.v1+ #2 Tainted: G S      W I
> [  161.072850] --------------------------------
> [  161.077122] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> [  161.083129] ksoftirqd/25/163 [HC0[0]:SC1[1]:HE0:SE0] takes:
> [  161.088699] ffff8881d1ef1468 (&xa->xa_lock#15){+.?.}-{2:2}, at:
> rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
> [  161.098182] {SOFTIRQ-ON-W} state was registered at:
> [  161.103061]   lock_acquire+0x1d2/0x5a0
> [  161.106811]   _raw_spin_lock+0x33/0x80
> [  161.110565]   rxe_alloc+0x1be/0x290 [rdma_rxe]
> [  161.115011]   rxe_get_dma_mr+0x3a/0x80 [rdma_rxe]
> [  161.119716]   __ib_alloc_pd+0x1a0/0x550 [ib_core]
> [  161.124448]   ib_mad_init_device+0x2d9/0xd20 [ib_core]
> [  161.129613]   add_client_context+0x2fa/0x450 [ib_core]
> [  161.134769]   enable_device_and_get+0x1b7/0x350 [ib_core]
> [  161.140186]   ib_register_device+0x757/0xaf0 [ib_core]
> [  161.145343]   rxe_register_device+0x2eb/0x390 [rdma_rxe]
> [  161.150656]   rxe_net_add+0x83/0xc0 [rdma_rxe]
> [  161.155102]   rxe_newlink+0x76/0x90 [rdma_rxe]
> [  161.159547]   nldev_newlink+0x245/0x3e0 [ib_core]
> [  161.164279]   rdma_nl_rcv_msg+0x2d4/0x790 [ib_core]
> [  161.169176]   rdma_nl_rcv+0x1ca/0x3f0 [ib_core]
> [  161.173726]   netlink_unicast+0x43b/0x640
> [  161.177737]   netlink_sendmsg+0x7eb/0xc40
> [  161.181749]   sock_sendmsg+0xe0/0x110
> [  161.185416]   __sys_sendto+0x1d7/0x2b0
> [  161.189170]   __x64_sys_sendto+0xdd/0x1b0
> [  161.193182]   do_syscall_64+0x37/0x80
> [  161.196846]   entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  161.201986] irq event stamp: 21493
> [  161.205391] hardirqs last  enabled at (21492): [<ffffffff9e215de8>]
> __local_bh_enable_ip+0xa8/0x110
> [  161.214431] hardirqs last disabled at (21493): [<ffffffffa0370219>]
> _raw_spin_lock_irqsave+0x69/0x90
> [  161.223558] softirqs last  enabled at (21482): [<ffffffffa060064a>]
> __do_softirq+0x64a/0xa4c
> [  161.231991] softirqs last disabled at (21487): [<ffffffff9e2159f2>]
> run_ksoftirqd+0x32/0x60
> [  161.240334]
>                 other info that might help us debug this:
> [  161.246860]  Possible unsafe locking scenario:
> 
> [  161.252780]        CPU0
> [  161.255232]        ----
> [  161.257685]   lock(&xa->xa_lock#15);
> [  161.261265]   <Interrupt>
> [  161.263889]     lock(&xa->xa_lock#15);
> [  161.267644]
>                  *** DEADLOCK ***
> 
> [  161.273561] no locks held by ksoftirqd/25/163.
> [  161.278009]
>                 stack backtrace:
> [  161.282368] CPU: 25 PID: 163 Comm: ksoftirqd/25 Tainted: G S      W
> I       5.18.0-rc1.yanjun.v1+ #2
> [  161.291493] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS
> 2.11.2 004/21/2021
> [  161.299146] Call Trace:
> [  161.301597]  <TASK>
> [  161.303705]  dump_stack_lvl+0x44/0x57
> [  161.307370]  mark_lock.part.52.cold.79+0x3c/0x46
> [  161.311992]  ? lock_chain_count+0x20/0x20
> [  161.316003]  ? rxe_do_task+0x26/0x230 [rdma_rxe]
> [  161.320628]  ? orc_find.part.4+0x310/0x310
> [  161.324731]  ? __module_text_address.part.55+0x13/0x140
> [  161.329954]  ? rxe_do_task+0x26/0x230 [rdma_rxe]
> [  161.334573]  ? rxe_do_task+0x26/0x230 [rdma_rxe]
> [  161.339192]  ? is_module_text_address+0x41/0x60
> [  161.343726]  ? rxe_do_task+0x26/0x230 [rdma_rxe]
> [  161.348345]  ? kernel_text_address+0x13/0xd0
> [  161.352616]  ? create_prof_cpu_mask+0x20/0x20
> [  161.356979]  ? sched_clock_cpu+0x15/0x200
> [  161.360991]  __lock_acquire+0x1565/0x34a0
> [  161.365003]  ? rcu_read_lock_sched_held+0xaf/0xe0
> [  161.369709]  ? rcu_read_lock_bh_held+0xc0/0xc0
> [  161.374153]  lock_acquire+0x1d2/0x5a0
> [  161.377820]  ? rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
> [  161.383055]  ? rcu_read_unlock+0x50/0x50
> [  161.386981]  ? mark_lock.part.52+0xa3d/0x1c00
> [  161.391338]  ? _raw_spin_lock_irqsave+0x69/0x90
> [  161.395873]  _raw_spin_lock_irqsave+0x42/0x90
> [  161.400230]  ? rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
> [  161.405456]  rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
> [  161.410509]  ? __rxe_add_to_pool+0x260/0x260 [rdma_rxe]
> [  161.415735]  ? __rxe_get+0xc1/0x140 [rdma_rxe]
> [  161.420183]  rxe_get_av+0x168/0x2a0 [rdma_rxe]
> [  161.424635]  ? lockdep_lock+0xcb/0x1c0
> [  161.428387]  rxe_requester+0x75b/0x4a90 [rdma_rxe]
> [  161.433182]  ? rxe_do_task+0xe2/0x230 [rdma_rxe]
> [  161.437809]  ? sched_clock_cpu+0x15/0x200
> [  161.441819]  ? find_held_lock+0x3a/0x1c0
> [  161.445746]  ? rnr_nak_timer+0x80/0x80 [rdma_rxe]
> [  161.450453]  ? lock_release+0x42f/0xc90
> [  161.454293]  ? lock_downgrade+0x6b0/0x6b0
> [  161.458304]  ? lock_acquired+0x262/0xb10
> [  161.462233]  ? __local_bh_enable_ip+0xa8/0x110
> [  161.466677]  ? rnr_nak_timer+0x80/0x80 [rdma_rxe]
> [  161.471389]  rxe_do_task+0x134/0x230 [rdma_rxe]
> [  161.475925]  tasklet_action_common.isra.12+0x1f7/0x2d0
> [  161.481064]  __do_softirq+0x1ea/0xa4c
> [  161.484730]  ? tasklet_kill+0x1c0/0x1c0
> [  161.488567]  run_ksoftirqd+0x32/0x60
> [  161.492146]  smpboot_thread_fn+0x503/0x860
> [  161.496245]  ? sort_range+0x20/0x20
> [  161.499736]  kthread+0x29b/0x340
> [  161.502970]  ? kthread_complete_and_exit+0x20/0x20
> [  161.507763]  ret_from_fork+0x1f/0x30
> [  161.511346]  </TASK>
> 
> 
> On Sat, Apr 9, 2022 at 11:27 AM Yanjun Zhu <yanjun.zhu@linux.dev> wrote:
>>
>> 在 2022/4/8 17:10, Yi Zhang 写道:
>>> On Fri, Apr 8, 2022 at 1:09 PM Yanjun Zhu <yanjun.zhu@linux.dev> wrote:
>>>>
>>>>
>>>> Hi, all
>>>>
>>>> In 5.18-rc1, this commit "[PATCH for-next] RDMA/rxe: Revert changes from
>>>> irqsave to bh locks" does not exist.
>>>>
>>>> The link is
>>>> https://patchwork.kernel.org/project/linux-rdma/patch/20220215194448.44369-1-rpearsonhpe@gmail.com/
>>>>
>>> Hi Yanjun
>>> I tried rdma/for-next which already included this commit, and this
>>> issue still can be reproduced.
>>
>> Hi, Yi
>>
>> I delved into the source code. And I found the followings:
>>
>> xa_lock first is acquired in this:
>>
>> [  296.655588] {SOFTIRQ-ON-W} state was registered at:
>>
>> [  296.660467]   lock_acquire+0x1d2/0x5a0
>> [  296.664221]   _raw_spin_lock+0x33/0x80
>> [  296.667972]   __rxe_add_to_pool+0x183/0x230 [rdma_rxe]
>> [  296.673112]   __ib_alloc_pd+0xf9/0x550 [ib_core]
>> [  296.677758]   ib_mad_init_device+0x2d9/0xd20 [ib_core]
>> [  296.682924]   add_client_context+0x2fa/0x450 [ib_core]
>> [  296.688088]   enable_device_and_get+0x1b7/0x350 [ib_core]
>> [  296.693503]   ib_register_device+0x757/0xaf0 [ib_core]
>> [  296.698660]   rxe_register_device+0x2eb/0x390 [rdma_rxe]
>> [  296.703973]   rxe_net_add+0x83/0xc0 [rdma_rxe]
>> [  296.708421]   rxe_newlink+0x76/0x90 [rdma_rxe]
>> [  296.712865]   nldev_newlink+0x245/0x3e0 [ib_core]
>> [  296.717597]   rdma_nl_rcv_msg+0x2d4/0x790 [ib_core]
>> [  296.722492]   rdma_nl_rcv+0x1ca/0x3f0 [ib_core]
>> [  296.727042]   netlink_unicast+0x43b/0x640
>> [  296.731056]   netlink_sendmsg+0x7eb/0xc40
>> [  296.735069]   sock_sendmsg+0xe0/0x110
>> [  296.738734]   __sys_sendto+0x1d7/0x2b0
>> [  296.742486]   __x64_sys_sendto+0xdd/0x1b0
>> [  296.746500]   do_syscall_64+0x37/0x80
>> [  296.750166]   entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [  296.755304] irq event stamp: 25305
>> [  296.758710] hardirqs last  enabled at (25304): [<ffffffff89815de8>]
>> __local_bh_enable_ip+0xa8/0x110
>> [  296.767750] hardirqs last disabled at (25305): [<ffffffff8b970219>]
>> _raw_spin_lock_irqsave+0x69/0x90
>> [  296.776875] softirqs last  enabled at (25294): [<ffffffff8bc0064a>]
>> __do_softirq+0x64a/0xa4c
>> [  296.785307] softirqs last disabled at (25299): [<ffffffff898159f2>]
>> run_ksoftirqd+0x32/0x60
>> [  296.793654]
>>
>> xa_lock then is acquired in this:
>> {IN-SOFTIRQ-W}:
>>
>> stack backtrace:
>> [  296.835686] CPU: 30 PID: 188 Comm: ksoftirqd/30 Tainted: G S
>> I       5.18.0-rc1 #1
>> [  296.843859] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS
>> 2.11.2 004/21/2021
>> [  296.851509] Call Trace:
>> [  296.853964]  <TASK>
>> [  296.856070]  dump_stack_lvl+0x44/0x57
>> [  296.859734]  mark_lock.part.52.cold.79+0x3c/0x46
>> [  296.913364]  __lock_acquire+0x1565/0x34a0
>> [  296.926529]  lock_acquire+0x1d2/0x5a0
>> [  296.948247]  _raw_spin_lock_irqsave+0x42/0x90
>> [  296.957830]  rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
>> [  296.972554]  rxe_get_av+0x168/0x2a0 [rdma_rxe]
>> [  296.980761]  rxe_requester+0x75b/0x4a90 [rdma_rxe]
>> [  297.023764]  rxe_do_task+0x134/0x230 [rdma_rxe]
>> [  297.028297]  tasklet_action_common.isra.12+0x1f7/0x2d0
>> [  297.033435]  __do_softirq+0x1ea/0xa4c
>> [  297.040941]  run_ksoftirqd+0x32/0x60
>> [  297.044518]  smpboot_thread_fn+0x503/0x860
>> [  297.052110]  kthread+0x29b/0x340
>> [  297.060137]  ret_from_fork+0x1f/0x30
>> [  297.063720]  </TASK>
>>
>>   From the above, in the function __rxe_add_to_pool, xa_lock is acquired.
>> Then the function __rxe_add_to_pool is interrupted by softirq. The
>> function rxe_pool_get_index will also acquire xa_lock.
>>
>> Finally, the dead lock appears.
>>
>> [  296.806097]        CPU0
>> [  296.808550]        ----
>> [  296.811003]   lock(&xa->xa_lock#15);  <----- __rxe_add_to_pool
>> [  296.814583]   <Interrupt>
>> [  296.817209]     lock(&xa->xa_lock#15); <---- rxe_pool_get_index
>> [  296.820961]
>>                   *** DEADLOCK ***
>>
>> I disable softirq in the function __rxe_add_to_pool. Please make tests
>> with the following.
>> Please let me know the test results. Thanks a lot.
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c
>> b/drivers/infiniband/sw/rxe/rxe_pool.c
>> index 87066d04ed18..9a8f83787d61 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
>> @@ -166,10 +166,14 @@ int __rxe_add_to_pool(struct rxe_pool *pool,
>> struct rxe_pool_elem *elem)
>>           elem->obj = (u8 *)elem - pool->elem_offset;
>>           kref_init(&elem->ref_cnt);
>>
>> +       local_bh_disable();
>>           err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>>                                 &pool->next, GFP_KERNEL);
>> -       if (err)
>> +       if (err) {
>> +               local_bh_enable();
>>                   goto err_cnt;
>> +       }
>> +       local_bh_enable();
>>
>>           return 0;
>>
>> Zhu Yanjun
>>
>>>
>>>> Please apply this commit and make tests again.
>>>> Please let me know the test result.
>>>>
>>>> Best Regards,
>>>>
>>>> Zhu Yanjun
>>>>
>>>> 在 2022/4/6 11:08, Yi Zhang 写道:
>>>>> Hello
>>>>>
>>>>> Below WARNING triggered during blktests srp/ tests with 5.18.0-rc1
>>>>> debug kernel, pls help check it, let me know if you need any info for
>>>>> it, thanks.
>>>>>
>>>>> [  290.308984] run blktests srp/001 at 2022-04-05 23:01:02
>>>>> [  290.999913] null_blk: module loaded
>>>>> [  291.260285] device-mapper: multipath service-time: version 0.3.0 loaded
>>>>> [  291.262990] device-mapper: table: 253:3: multipath: error getting
>>>>> device (-EBUSY)
>>>>> [  291.270535] device-mapper: ioctl: error adding target to table
>>>>> [  291.362284] rdma_rxe: loaded
>>>>> [  291.428444] infiniband eno1_rxe: set active
>>>>> [  291.428462] infiniband eno1_rxe: added eno1
>>>>> [  291.467142] eno2 speed is unknown, defaulting to 1000
>>>>> [  291.472327] eno2 speed is unknown, defaulting to 1000
>>>>> [  291.477680] eno2 speed is unknown, defaulting to 1000
>>>>> [  291.516123] infiniband eno2_rxe: set down
>>>>> [  291.516130] infiniband eno2_rxe: added eno2
>>>>> [  291.516649] eno2 speed is unknown, defaulting to 1000
>>>>> [  291.542551] eno2 speed is unknown, defaulting to 1000
>>>>> [  291.558995] eno3 speed is unknown, defaulting to 1000
>>>>> [  291.564127] eno3 speed is unknown, defaulting to 1000
>>>>> [  291.569462] eno3 speed is unknown, defaulting to 1000
>>>>> [  291.607876] infiniband eno3_rxe: set down
>>>>> [  291.607883] infiniband eno3_rxe: added eno3
>>>>> [  291.608430] eno3 speed is unknown, defaulting to 1000
>>>>> [  291.632891] eno2 speed is unknown, defaulting to 1000
>>>>> [  291.638180] eno3 speed is unknown, defaulting to 1000
>>>>> [  291.655089] eno4 speed is unknown, defaulting to 1000
>>>>> [  291.660213] eno4 speed is unknown, defaulting to 1000
>>>>> [  291.665569] eno4 speed is unknown, defaulting to 1000
>>>>> [  291.703975] infiniband eno4_rxe: set down
>>>>> [  291.703982] infiniband eno4_rxe: added eno4
>>>>> [  291.704642] eno4 speed is unknown, defaulting to 1000
>>>>> [  291.822650] scsi_debug:sdebug_add_store: dif_storep 524288 bytes @
>>>>> ffffc90001801000
>>>>> [  291.825441] scsi_debug:sdebug_driver_probe: scsi_debug: trim
>>>>> poll_queues to 0. poll_q/nr_hw = (0/1)
>>>>> [  291.834505] scsi_debug:sdebug_driver_probe: host protection DIF3 DIX3
>>>>> [  291.834513] scsi host15: scsi_debug: version 0191 [20210520]
>>>>>                     dev_size_mb=32, opts=0x0, submit_queues=1, statistics=0
>>>>> [  291.837267] scsi 15:0:0:0: Direct-Access     Linux    scsi_debug
>>>>>       0191 PQ: 0 ANSI: 7
>>>>> [  291.839793] sd 15:0:0:0: Power-on or device reset occurred
>>>>> [  291.840110] sd 15:0:0:0: Attached scsi generic sg1 type 0
>>>>> [  291.845521] sd 15:0:0:0: [sdb] Enabling DIF Type 3 protection
>>>>> [  291.845878] sd 15:0:0:0: [sdb] 65536 512-byte logical blocks: (33.6
>>>>> MB/32.0 MiB)
>>>>> [  291.845939] sd 15:0:0:0: [sdb] Write Protect is off
>>>>> [  291.845954] sd 15:0:0:0: [sdb] Mode Sense: 73 00 10 08
>>>>> [  291.846049] sd 15:0:0:0: [sdb] Write cache: enabled, read cache:
>>>>> enabled, supports DPO and FUA
>>>>> [  291.846254] sd 15:0:0:0: [sdb] Optimal transfer size 524288 bytes
>>>>> [  291.859380] sd 15:0:0:0: [sdb] Enabling DIX T10-DIF-TYPE3-CRC protection
>>>>> [  291.859398] sd 15:0:0:0: [sdb] DIF application tag size 6
>>>>> [  291.860158] sd 15:0:0:0: [sdb] Attached SCSI disk
>>>>> [  292.666414] eno2 speed is unknown, defaulting to 1000
>>>>> [  292.771984] eno3 speed is unknown, defaulting to 1000
>>>>> [  292.876762] eno4 speed is unknown, defaulting to 1000
>>>>> [  293.033291] Rounding down aligned max_sectors from 4294967295 to 4294967288
>>>>> [  293.102261] ib_srpt:srpt_add_one: ib_srpt device = 0000000047a39f45
>>>>> [  293.102363] ib_srpt:srpt_use_srq: ib_srpt srpt_use_srq(eno1_rxe):
>>>>> use_srq = 0; ret = 0
>>>>> [  293.102369] ib_srpt:srpt_add_one: ib_srpt Target login info:
>>>>> id_ext=f2d4e2fffee6e1e0,ioc_guid=f2d4e2fffee6e1e0,pkey=ffff,service_id=f2d4e2fffee6e1e0
>>>>> [  293.102680] ib_srpt:srpt_add_one: ib_srpt added eno1_rxe.
>>>>> [  293.102692] ib_srpt:srpt_add_one: ib_srpt device = 00000000b2dfcbe9
>>>>> [  293.102725] ib_srpt:srpt_use_srq: ib_srpt srpt_use_srq(eno2_rxe):
>>>>> use_srq = 0; ret = 0
>>>>> [  293.102730] ib_srpt:srpt_add_one: ib_srpt Target login info:
>>>>> id_ext=f2d4e2fffee6e1e0,ioc_guid=f2d4e2fffee6e1e0,pkey=ffff,service_id=f2d4e2fffee6e1e0
>>>>> [  293.102741] eno2 speed is unknown, defaulting to 1000
>>>>> [  293.107884] ib_srpt:srpt_add_one: ib_srpt added eno2_rxe.
>>>>> [  293.107893] ib_srpt:srpt_add_one: ib_srpt device = 0000000061e03247
>>>>> [  293.107922] ib_srpt:srpt_use_srq: ib_srpt srpt_use_srq(eno3_rxe):
>>>>> use_srq = 0; ret = 0
>>>>> [  293.107926] ib_srpt:srpt_add_one: ib_srpt Target login info:
>>>>> id_ext=f2d4e2fffee6e1e0,ioc_guid=f2d4e2fffee6e1e0,pkey=ffff,service_id=f2d4e2fffee6e1e0
>>>>> [  293.107936] eno3 speed is unknown, defaulting to 1000
>>>>> [  293.113038] ib_srpt:srpt_add_one: ib_srpt added eno3_rxe.
>>>>> [  293.113046] ib_srpt:srpt_add_one: ib_srpt device = 00000000c0e3d43d
>>>>> [  293.113081] ib_srpt:srpt_use_srq: ib_srpt srpt_use_srq(eno4_rxe):
>>>>> use_srq = 0; ret = 0
>>>>> [  293.113085] ib_srpt:srpt_add_one: ib_srpt Target login info:
>>>>> id_ext=f2d4e2fffee6e1e0,ioc_guid=f2d4e2fffee6e1e0,pkey=ffff,service_id=f2d4e2fffee6e1e0
>>>>> [  293.113096] eno4 speed is unknown, defaulting to 1000
>>>>> [  293.118198] ib_srpt:srpt_add_one: ib_srpt added eno4_rxe.
>>>>> [  293.584001] Rounding down aligned max_sectors from 255 to 248
>>>>> [  293.654030] Rounding down aligned max_sectors from 255 to 248
>>>>> [  293.724363] Rounding down aligned max_sectors from 4294967295 to 4294967288
>>>>> [  296.450772] ib_srp:srp_add_one: ib_srp: srp_add_one:
>>>>> 18446744073709551615 / 4096 = 4503599627370495 <> 512
>>>>> [  296.450783] ib_srp:srp_add_one: ib_srp: eno1_rxe: mr_page_shift =
>>>>> 12, device->max_mr_size = 0xffffffffffffffff,
>>>>> device->max_fast_reg_page_list_len = 512, max_pages_per_mr = 512,
>>>>> mr_max_size = 0x200000
>>>>> [  296.451222] ib_srp:srp_add_one: ib_srp: srp_add_one:
>>>>> 18446744073709551615 / 4096 = 4503599627370495 <> 512
>>>>> [  296.451229] ib_srp:srp_add_one: ib_srp: eno2_rxe: mr_page_shift =
>>>>> 12, device->max_mr_size = 0xffffffffffffffff,
>>>>> device->max_fast_reg_page_list_len = 512, max_pages_per_mr = 512,
>>>>> mr_max_size = 0x200000
>>>>> [  296.451517] ib_srp:srp_add_one: ib_srp: srp_add_one:
>>>>> 18446744073709551615 / 4096 = 4503599627370495 <> 512
>>>>> [  296.451523] ib_srp:srp_add_one: ib_srp: eno3_rxe: mr_page_shift =
>>>>> 12, device->max_mr_size = 0xffffffffffffffff,
>>>>> device->max_fast_reg_page_list_len = 512, max_pages_per_mr = 512,
>>>>> mr_max_size = 0x200000
>>>>> [  296.451769] ib_srp:srp_add_one: ib_srp: srp_add_one:
>>>>> 18446744073709551615 / 4096 = 4503599627370495 <> 512
>>>>> [  296.451774] ib_srp:srp_add_one: ib_srp: eno4_rxe: mr_page_shift =
>>>>> 12, device->max_mr_size = 0xffffffffffffffff,
>>>>> device->max_fast_reg_page_list_len = 512, max_pages_per_mr = 512,
>>>>> mr_max_size = 0x200000
>>>>> [  296.605925] ib_srp:srp_parse_in: ib_srp: 10.16.221.116 -> 10.16.221.116:0
>>>>> [  296.605956] ib_srp:srp_parse_in: ib_srp: 10.16.221.116:5555 ->
>>>>> 10.16.221.116:5555
>>>>> [  296.606014] ib_srp:add_target_store: ib_srp: max_sectors = 1024;
>>>>> max_pages_per_mr = 512; mr_page_size = 4096; max_sectors_per_mr =
>>>>> 4096; mr_per_cmd = 2
>>>>> [  296.606021] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len = 8260
>>>>>
>>>>> [  296.616660] ================================
>>>>> [  296.620931] WARNING: inconsistent lock state
>>>>> [  296.625207] 5.18.0-rc1 #1 Tainted: G S        I
>>>>> [  296.630259] --------------------------------
>>>>> [  296.634531] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
>>>>> [  296.640535] ksoftirqd/30/188 [HC0[0]:SC1[1]:HE0:SE0] takes:
>>>>> [  296.646106] ffff888151491468 (&xa->xa_lock#15){+.?.}-{2:2}, at:
>>>>> rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
>>>>> [  296.655588] {SOFTIRQ-ON-W} state was registered at:
>>>>> [  296.660467]   lock_acquire+0x1d2/0x5a0
>>>>> [  296.664221]   _raw_spin_lock+0x33/0x80
>>>>> [  296.667972]   __rxe_add_to_pool+0x183/0x230 [rdma_rxe]
>>>>> [  296.673112]   __ib_alloc_pd+0xf9/0x550 [ib_core]
>>>>> [  296.677758]   ib_mad_init_device+0x2d9/0xd20 [ib_core]
>>>>> [  296.682924]   add_client_context+0x2fa/0x450 [ib_core]
>>>>> [  296.688088]   enable_device_and_get+0x1b7/0x350 [ib_core]
>>>>> [  296.693503]   ib_register_device+0x757/0xaf0 [ib_core]
>>>>> [  296.698660]   rxe_register_device+0x2eb/0x390 [rdma_rxe]
>>>>> [  296.703973]   rxe_net_add+0x83/0xc0 [rdma_rxe]
>>>>> [  296.708421]   rxe_newlink+0x76/0x90 [rdma_rxe]
>>>>> [  296.712865]   nldev_newlink+0x245/0x3e0 [ib_core]
>>>>> [  296.717597]   rdma_nl_rcv_msg+0x2d4/0x790 [ib_core]
>>>>> [  296.722492]   rdma_nl_rcv+0x1ca/0x3f0 [ib_core]
>>>>> [  296.727042]   netlink_unicast+0x43b/0x640
>>>>> [  296.731056]   netlink_sendmsg+0x7eb/0xc40
>>>>> [  296.735069]   sock_sendmsg+0xe0/0x110
>>>>> [  296.738734]   __sys_sendto+0x1d7/0x2b0
>>>>> [  296.742486]   __x64_sys_sendto+0xdd/0x1b0
>>>>> [  296.746500]   do_syscall_64+0x37/0x80
>>>>> [  296.750166]   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>>> [  296.755304] irq event stamp: 25305
>>>>> [  296.758710] hardirqs last  enabled at (25304): [<ffffffff89815de8>]
>>>>> __local_bh_enable_ip+0xa8/0x110
>>>>> [  296.767750] hardirqs last disabled at (25305): [<ffffffff8b970219>]
>>>>> _raw_spin_lock_irqsave+0x69/0x90
>>>>> [  296.776875] softirqs last  enabled at (25294): [<ffffffff8bc0064a>]
>>>>> __do_softirq+0x64a/0xa4c
>>>>> [  296.785307] softirqs last disabled at (25299): [<ffffffff898159f2>]
>>>>> run_ksoftirqd+0x32/0x60
>>>>> [  296.793654]
>>>>>                   other info that might help us debug this:
>>>>> [  296.800177]  Possible unsafe locking scenario:
>>>>>
>>>>> [  296.806097]        CPU0
>>>>> [  296.808550]        ----
>>>>> [  296.811003]   lock(&xa->xa_lock#15);
>>>>> [  296.814583]   <Interrupt>
>>>>> [  296.817209]     lock(&xa->xa_lock#15);
>>>>> [  296.820961]
>>>>>                    *** DEADLOCK ***
>>>>>
>>>>> [  296.826880] no locks held by ksoftirqd/30/188.
>>>>> [  296.831326]
>>>>>                   stack backtrace:
>>>>> [  296.835686] CPU: 30 PID: 188 Comm: ksoftirqd/30 Tainted: G S
>>>>> I       5.18.0-rc1 #1
>>>>> [  296.843859] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS
>>>>> 2.11.2 004/21/2021
>>>>> [  296.851509] Call Trace:
>>>>> [  296.853964]  <TASK>
>>>>> [  296.856070]  dump_stack_lvl+0x44/0x57
>>>>> [  296.859734]  mark_lock.part.52.cold.79+0x3c/0x46
>>>>> [  296.864355]  ? lock_chain_count+0x20/0x20
>>>>> [  296.868367]  ? rxe_do_task+0x26/0x230 [rdma_rxe]
>>>>> [  296.872994]  ? orc_find.part.4+0x310/0x310
>>>>> [  296.877096]  ? __module_text_address.part.55+0x13/0x140
>>>>> [  296.882326]  ? rxe_do_task+0x26/0x230 [rdma_rxe]
>>>>> [  296.886947]  ? rxe_do_task+0x26/0x230 [rdma_rxe]
>>>>> [  296.891566]  ? is_module_text_address+0x41/0x60
>>>>> [  296.896098]  ? rxe_do_task+0x26/0x230 [rdma_rxe]
>>>>> [  296.900718]  ? kernel_text_address+0x13/0xd0
>>>>> [  296.904991]  ? create_prof_cpu_mask+0x20/0x20
>>>>> [  296.909351]  ? sched_clock_cpu+0x15/0x200
>>>>> [  296.913364]  __lock_acquire+0x1565/0x34a0
>>>>> [  296.917377]  ? rcu_read_lock_sched_held+0xaf/0xe0
>>>>> [  296.922079]  ? rcu_read_lock_bh_held+0xc0/0xc0
>>>>> [  296.926529]  lock_acquire+0x1d2/0x5a0
>>>>> [  296.930193]  ? rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
>>>>> [  296.935429]  ? rcu_read_unlock+0x50/0x50
>>>>> [  296.939353]  ? mark_lock.part.52+0xa3d/0x1c00
>>>>> [  296.943712]  ? _raw_spin_lock_irqsave+0x69/0x90
>>>>> [  296.948247]  _raw_spin_lock_irqsave+0x42/0x90
>>>>> [  296.952603]  ? rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
>>>>> [  296.957830]  rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
>>>>> [  296.962882]  ? __rxe_add_to_pool+0x230/0x230 [rdma_rxe]
>>>>> [  296.968108]  ? __rxe_get+0xc1/0x140 [rdma_rxe]
>>>>> [  296.972554]  rxe_get_av+0x168/0x2a0 [rdma_rxe]
>>>>> [  296.977007]  ? lockdep_lock+0xcb/0x1c0
>>>>> [  296.980761]  rxe_requester+0x75b/0x4a90 [rdma_rxe]
>>>>> [  296.985557]  ? rxe_do_task+0xe2/0x230 [rdma_rxe]
>>>>> [  296.990183]  ? sched_clock_cpu+0x15/0x200
>>>>> [  296.994193]  ? find_held_lock+0x3a/0x1c0
>>>>> [  296.998119]  ? rnr_nak_timer+0x80/0x80 [rdma_rxe]
>>>>> [  297.002826]  ? lock_release+0x42f/0xc90
>>>>> [  297.006664]  ? lock_downgrade+0x6b0/0x6b0
>>>>> [  297.010676]  ? lock_acquired+0x262/0xb10
>>>>> [  297.014605]  ? __local_bh_enable_ip+0xa8/0x110
>>>>> [  297.019051]  ? rnr_nak_timer+0x80/0x80 [rdma_rxe]
>>>>> [  297.023764]  rxe_do_task+0x134/0x230 [rdma_rxe]
>>>>> [  297.028297]  tasklet_action_common.isra.12+0x1f7/0x2d0
>>>>> [  297.033435]  __do_softirq+0x1ea/0xa4c
>>>>> [  297.037100]  ? tasklet_kill+0x1c0/0x1c0
>>>>> [  297.040941]  run_ksoftirqd+0x32/0x60
>>>>> [  297.044518]  smpboot_thread_fn+0x503/0x860
>>>>> [  297.048618]  ? sort_range+0x20/0x20
>>>>> [  297.052110]  kthread+0x29b/0x340
>>>>> [  297.055342]  ? kthread_complete_and_exit+0x20/0x20
>>>>> [  297.060137]  ret_from_fork+0x1f/0x30
>>>>> [  297.063720]  </TASK>
>>>>>
>>>>
>>>
>>>
>>
> 
> 

