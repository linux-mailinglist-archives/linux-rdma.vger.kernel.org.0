Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44063495A4
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhCYPdv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhCYPdY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:33:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDB4C06174A
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:23 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h10so2854469edt.13
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b9pL+vBoAFevtP42vxhn79G220f2Jstve6xd48Y4v+A=;
        b=f421CRb6zJ12Y0bK00tEXJdoXYwUbh6jj2Oe1OhQuB8+ONX5lP3bu2oa+4tV3kpguQ
         CoD3dAMFfEB1Ghj1aSkMdg8Ihm6u8j7agA39wt0bpGsHdYVgrapa1hdaqD/XNOrbr+zV
         uCeNS+AxxeVioZ042Q/25XbcP1lVCbLZ0m0cZlX6HAgRgIKaHW1+3rfSnQbmI++dMsVK
         ttRx2dykiRyB3y/unSlQy3oKyIICWG2fGV4nHN2yBccY7Ws5kRAYH1dWJirdx4E7Ee7B
         s3HCpjMH8N6Fg7H4YgH/cO3jJXrwRt0cs4XEQIzZYlWMZXLcLTRjfR/kVyER4DnN+W6I
         4Z5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b9pL+vBoAFevtP42vxhn79G220f2Jstve6xd48Y4v+A=;
        b=WtHyIEdyTYP5b1GOHEO4UAU5HEjFiB76HcLGQWvrQjOSmmrAS663eQfjKpBPdrgJk4
         c+RLZA1AW7wcx69ivXptmaVqhyLhkd74ux6XwoN24Llm+shJgXtlSNmCZ2Dx3wu045TA
         GGd3ZxXlvrrCEqLNdtJxTxowtKy22gXQYY9jnJOPJ1QKvWOvG2zzWAs+a+zeqOqNyFij
         ll7qK2CH+fv3ldlfmmBbYxz4MZrw/o0J8953E+m6lccOpK3pvXC87efI4VVAYXdlk0D1
         AQXINIMu1fgOTYaugMTpKrDeXKtBD6NzY2ylqz/mkG/9gTidOLEEfdYsw9krLLay/YsE
         tKmw==
X-Gm-Message-State: AOAM533wPJsbh0afsfU4hxZfrF7QmbOlLIIkCJaLh47of5riAesJhH+v
        WgVWopW/Wct7KXEGv8i02wg6uV/l80oPYgTN
X-Google-Smtp-Source: ABdhPJxV4u8Ju0oVT++M43sMiUrJ7YIbcqcrHveERMLIoBpIK4ACcvwfnbcG6vAdOa27gmZzINneRQ==
X-Received: by 2002:aa7:c804:: with SMTP id a4mr9549997edt.251.1616686402146;
        Thu, 25 Mar 2021 08:33:22 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id n26sm2854750eds.22.2021.03.25.08.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:33:21 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 11/22] RDMA/rtrs-clt: Close rtrs client conn before destroying rtrs clt session files
Date:   Thu, 25 Mar 2021 16:32:57 +0100
Message-Id: <20210325153308.1214057-12-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

KASAN detected the following BUG:
[  821.309371] ==================================================================
[  821.309842] BUG: KASAN: use-after-free in rtrs_clt_update_wc_stats+0x41/0x100 [rtrs_client]
[  821.310114] Read of size 8 at addr ffff88bf2fb4adc0 by task swapper/0/0

[  821.310503] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O      5.4.84-pserver #5.4.84-1+feature+linux+5.4.y+dbg+20201216.1319+b6b887b~deb10
[  821.310511] Hardware name: Supermicro H8QG6/H8QG6, BIOS 3.00       09/04/2012
[  821.310518] Call Trace:
[  821.310526]  <IRQ>
[  821.310541]  dump_stack+0x96/0xe0
[  821.310560]  print_address_description.constprop.4+0x1f/0x300
[  821.310571]  ? irq_work_claim+0x2e/0x50
[  821.310589]  __kasan_report.cold.8+0x78/0x92
[  821.310615]  ? rtrs_clt_update_wc_stats+0x41/0x100 [rtrs_client]
[  821.310639]  kasan_report+0x10/0x20
[  821.310656]  rtrs_clt_update_wc_stats+0x41/0x100 [rtrs_client]
[  821.310681]  rtrs_clt_rdma_done+0xb1/0x760 [rtrs_client]
[  821.310698]  ? lockdep_hardirqs_on+0x1a8/0x290
[  821.310725]  ? process_io_rsp+0xb0/0xb0 [rtrs_client]
[  821.310779]  ? mlx4_ib_destroy_cq+0x100/0x100 [mlx4_ib]
[  821.310802]  ? add_interrupt_randomness+0x1a2/0x340
[  821.310863]  __ib_process_cq+0x97/0x100 [ib_core]
[  821.310924]  ib_poll_handler+0x41/0xb0 [ib_core]
[  821.310945]  irq_poll_softirq+0xe0/0x260
[  821.310974]  __do_softirq+0x127/0x672
[  821.311016]  irq_exit+0xd1/0xe0
[  821.311027]  do_IRQ+0xa3/0x1d0
[  821.311046]  common_interrupt+0xf/0xf
[  821.311055]  </IRQ>
[  821.311065] RIP: 0010:cpuidle_enter_state+0xea/0x780
[  821.311075] Code: 31 ff e8 99 48 47 ff 80 7c 24 08 00 74 12 9c 58 f6 c4 02 0f 85 53 05 00 00 31 ff e8 b0 6f 53 ff e8 ab 4f 5e ff fb 8b 44 24 04 <85> c0 0f 89 f3 01 00 00 48 8d 7b 14 e8 65 1e 77 ff c7 43 14 00 00
[  821.311082] RSP: 0018:ffffffffab007d58 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffca
[  821.311093] RAX: 0000000000000002 RBX: ffff88b803d69800 RCX: ffffffffa91a8298
[  821.311101] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffffffffab021414
[  821.311109] RBP: ffffffffab6329e0 R08: 0000000000000002 R09: 0000000000000000
[  821.311116] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
[  821.311124] R13: 000000bf39d82466 R14: ffffffffab632aa0 R15: ffffffffab632ae0
[  821.311157]  ? lockdep_hardirqs_on+0x1a8/0x290
[  821.311183]  ? cpuidle_enter_state+0xe5/0x780
[  821.311212]  cpuidle_enter+0x3c/0x60
[  821.311233]  do_idle+0x2fb/0x390
[  821.311250]  ? arch_cpu_idle_exit+0x40/0x40
[  821.311272]  ? schedule+0x94/0x120
[  821.311298]  cpu_startup_entry+0x19/0x1b
[  821.311313]  start_kernel+0x5da/0x61b
[  821.311330]  ? thread_stack_cache_init+0x6/0x6
[  821.311342]  ? load_ucode_amd_bsp+0x6f/0xc4
[  821.311358]  ? init_amd_microcode+0xa6/0xa6
[  821.311380]  ? x86_family+0x5/0x20
[  821.311392]  ? load_ucode_bsp+0x182/0x1fd
[  821.311421]  secondary_startup_64+0xa4/0xb0

[  821.311652] Allocated by task 5730:
[  821.313411]  save_stack+0x19/0x80
[  821.313420]  __kasan_kmalloc.constprop.9+0xc1/0xd0
[  821.313429]  kmem_cache_alloc_trace+0x15b/0x350
[  821.313443]  alloc_sess+0xf4/0x570 [rtrs_client]
[  821.313456]  rtrs_clt_open+0x3b4/0x780 [rtrs_client]
[  821.313469]  find_and_get_or_create_sess+0x649/0x9d0 [rnbd_client]
[  821.313481]  rnbd_clt_map_device+0xd7/0xf50 [rnbd_client]
[  821.313493]  rnbd_clt_map_device_store+0x4ee/0x970 [rnbd_client]
[  821.313503]  kernfs_fop_write+0x141/0x240
[  821.313512]  vfs_write+0xf3/0x280
[  821.313521]  ksys_write+0xba/0x150
[  821.313530]  do_syscall_64+0x68/0x270
[  821.313539]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[  821.313708] Freed by task 5822:
[  821.313918]  save_stack+0x19/0x80
[  821.313928]  __kasan_slab_free+0x125/0x170
[  821.313936]  kfree+0xe7/0x3f0
[  821.313945]  kobject_put+0xd3/0x240
[  821.313959]  rtrs_clt_destroy_sess_files+0x3f/0x60 [rtrs_client]
[  821.313972]  rtrs_clt_close+0x3c/0x80 [rtrs_client]
[  821.313984]  close_rtrs+0x45/0x80 [rnbd_client]
[  821.313996]  rnbd_client_exit+0x10f/0x2bd [rnbd_client]
[  821.314006]  __x64_sys_delete_module+0x27b/0x340
[  821.314014]  do_syscall_64+0x68/0x270
[  821.314024]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[  821.314197] The buggy address belongs to the object at ffff88bf2fb4ad80
                which belongs to the cache kmalloc-96 of size 96
[  821.314514] The buggy address is located 64 bytes inside of
                96-byte region [ffff88bf2fb4ad80, ffff88bf2fb4ade0)
[  821.314820] The buggy address belongs to the page:
[  821.315023] page:ffffea00fcbed280 refcount:1 mapcount:0 mapping:ffff8887c6016e00 index:0xffff88bf2fb4a800
[  821.315032] flags: 0x1effff8000000200(slab)
[  821.315044] raw: 1effff8000000200 ffffea00bf41b640 0000000300000003 ffff8887c6016e00
[  821.315054] raw: ffff88bf2fb4a800 000000008020001d 00000001ffffffff 0000000000000000
[  821.315061] page dumped because: kasan: bad access detected

[  821.315232] Memory state around the buggy address:
[  821.315434]  ffff88bf2fb4ac80: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[  821.315694]  ffff88bf2fb4ad00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[  821.315950] >ffff88bf2fb4ad80: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[  821.316205]                                            ^
[  821.316414]  ffff88bf2fb4ae00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[  821.316671]  ffff88bf2fb4ae80: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
[  821.316929] ==================================================================

When rtrs_clt_close is triggered, it iterates over all the present
rtrs_clt_sess and triggers close on them. However, the call to
rtrs_clt_destroy_sess_files is done before the rtrs_clt_close_conns. This
is incorrect since during the initialization phase we allocate
rtrs_clt_sess first, and then we go ahead and create rtrs_clt_con for it.

If we free the rtrs_clt_sess structure before closing the rtrs_clt_con, it
may so happen that an inflight IO completion would trigger the function
rtrs_clt_rdma_done, which would lead to the above UAF case.

Hence close the rtrs_clt_con connections first, and then trigger the
destruction of session files.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 124197e3162f..42f49208b8f7 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2726,8 +2726,8 @@ void rtrs_clt_close(struct rtrs_clt *clt)
 
 	/* Now it is safe to iterate over all paths without locks */
 	list_for_each_entry_safe(sess, tmp, &clt->paths_list, s.entry) {
-		rtrs_clt_destroy_sess_files(sess, NULL);
 		rtrs_clt_close_conns(sess, true);
+		rtrs_clt_destroy_sess_files(sess, NULL);
 		kobject_put(&sess->kobj);
 	}
 	free_clt(clt);
-- 
2.25.1

