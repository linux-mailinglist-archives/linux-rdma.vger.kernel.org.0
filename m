Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAC55B23D2
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 18:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiIHQpX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 12:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiIHQpW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 12:45:22 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCB6B56E6
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 09:45:21 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r18so12178578eja.11
        for <linux-rdma@vger.kernel.org>; Thu, 08 Sep 2022 09:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=wkw2eWGp92q84WCuEf+P6hndiFibH2uRZGdx0WTYti8=;
        b=qrqAMVS3Ae+vGYvoWmQxPg/kMBagz2wSOkzYZjlIhflqVXShBy/T1cUSuXCNEpQO9+
         bkUCgSnvYLYm6q0VVoBLI256RTBSIxH2wxDP5oAEGMnhslvkZkD+bbjQdAfC2vI7aUfc
         6NCUWE8Txv5RCllRC2l2sB9jk2Vn9Dch3wq3hxB7TtXBy7mUvdbVWrgEPGCL1ImD3ArE
         vI9Ol7p0zAgEmjKCAqhdR6B5w50Qc8EGYX1ub6yEJp/1wGgnG1v8D/jYupPpMovGUQjs
         GcYngE6mmqzQQ/TdGTxM3l7YIbytBoARWwDbumzSuD4aV0JbBgxQAxWBCjwDvIDUniNF
         ctbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=wkw2eWGp92q84WCuEf+P6hndiFibH2uRZGdx0WTYti8=;
        b=wpXtKdA8FEmH7vKHBuVAlvQG3RsydQfFrri5WlNvkOvVqhOtMmBjehvYnFsGA6zrrX
         7YcRhWP9K2JC4e/MQDVqNWcWVlNAXZ4pgnAA7LEkzfAR+KzpCg2Yclk7iKkXp6Y3ZTAo
         PVLsCXlZuV8ydu26FibqqCXRdJ9sPddRXlDF0Haz4jF9k/NMUWkhZkabipAy78FCAQBz
         ep2aLJRYUtgc8Ewr2qjV6WbnvRlX8z04DGNdSMnm9BPPD7QAsdQlbIizaBNYimGitJBq
         t2X3z4+SKv8GKHPocqXm96c9jerC/Z5MVclCMbPPJTGrynQPhm2SPZLJDea1jUyratD3
         oVGw==
X-Gm-Message-State: ACgBeo1rIkZbkSiIB/OcsjQE6812BMn8GOAz5Lsf4GvliqMetPJXXeZH
        lWva2VC8I8paLd0qVWiM2SdBJrKc/Wn394fCOX9r3pumNNE=
X-Google-Smtp-Source: AA6agR5Nt4w1Ub5tXw2blk2YIkZCE6VP8yxu0G3HJLlsp0UHQ06CqULjYK8Mx66C/UXTJLf3zUwDW0oqquqguec0jms=
X-Received: by 2002:a17:906:8479:b0:73d:da77:8fbe with SMTP id
 hx25-20020a170906847900b0073dda778fbemr6475483ejc.373.1662655519692; Thu, 08
 Sep 2022 09:45:19 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 8 Sep 2022 12:45:08 -0400
Message-ID: <CAN-5tyFmy8V4BYjkJAEz-cKDHvi=rdqYPdDTk4vtUT=53OPgDA@mail.gmail.com>
Subject: [siw problem] use-after-free in xfstest generic/460 in NFSoRDMA
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bernard,

I'm running into the following problem while running xfstest
generic/460 using NFSoRDMA using soft iWarp. Any ideas why? Thank you.

==================================================================
[ 1306.370743] BUG: KASAN: use-after-free in down_write+0x78/0x110
[ 1306.372186] Write of size 8 at addr ffff888054beb180 by task
kworker/u256:2/3880
[ 1306.373893]
[ 1306.374268] CPU: 0 PID: 3880 Comm: kworker/u256:2 Not tainted 6.0.0-rc4+ #118
[ 1306.375905] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[ 1306.378465] Workqueue: siw_cm_wq siw_cm_work_handler [siw]
[ 1306.379872] Call Trace:
[ 1306.380497]  <TASK>
[ 1306.381077]  dump_stack_lvl+0x33/0x46
[ 1306.382151]  print_report.cold.12+0xb2/0x6b7
[ 1306.383200]  ? down_write+0x78/0x110
[ 1306.384060]  kasan_report+0xa3/0x120
[ 1306.384914]  ? __wake_up_common+0x41/0x240
[ 1306.385879]  ? down_write+0x78/0x110
[ 1306.386725]  kasan_check_range+0x179/0x1e0
[ 1306.387690]  down_write+0x78/0x110
[ 1306.388526]  ? down_write_killable+0x120/0x120
[ 1306.389592]  siw_qp_llp_close+0x2b/0x250 [siw]
[ 1306.391019]  siw_cm_work_handler+0x3af/0x1410 [siw]
[ 1306.392358]  ? set_next_entity+0xb1/0x2b0
[ 1306.393463]  ? siw_qp_cm_drop+0x290/0x290 [siw]
[ 1306.394680]  ? preempt_count_sub+0x14/0xc0
[ 1306.395641]  ? _raw_spin_unlock+0x15/0x30
[ 1306.396588]  ? finish_task_switch+0xe5/0x3e0
[ 1306.397610]  ? __switch_to+0x2fa/0x760
[ 1306.398507]  ? __schedule+0x575/0xf50
[ 1306.399377]  process_one_work+0x3b1/0x6b0
[ 1306.400342]  worker_thread+0x5a/0x640
[ 1306.401209]  ? __kthread_parkme+0xae/0xd0
[ 1306.402167]  ? process_one_work+0x6b0/0x6b0
[ 1306.403306]  kthread+0x160/0x190
[ 1306.404085]  ? kthread_complete_and_exit+0x20/0x20
[ 1306.405252]  ret_from_fork+0x1f/0x30
[ 1306.406160]  </TASK>
[ 1306.406694]
[ 1306.407067] Allocated by task 3880:
[ 1306.407898]  kasan_save_stack+0x1c/0x40
[ 1306.408808]  __kasan_kmalloc+0x84/0xa0
[ 1306.409693]  __kmalloc+0x186/0x2f0
[ 1306.410504]  create_qp.part.23+0x2e8/0x330 [ib_core]
[ 1306.412062]  ib_create_qp_kernel+0x75/0x160 [ib_core]
[ 1306.413672]  rdma_create_qp+0x101/0x240 [rdma_cm]
[ 1306.414911]  rpcrdma_xprt_connect+0xa76/0xae0 [rpcrdma]
[ 1306.416606]  xprt_rdma_connect_worker+0x78/0x180 [rpcrdma]
[ 1306.418242]  process_one_work+0x3b1/0x6b0
[ 1306.419205]  worker_thread+0x5a/0x640
[ 1306.420200]  kthread+0x160/0x190
[ 1306.421024]  ret_from_fork+0x1f/0x30
[ 1306.422029]
[ 1306.422432] Freed by task 3882:
[ 1306.423242]  kasan_save_stack+0x1c/0x40
[ 1306.424450]  kasan_set_track+0x21/0x30
[ 1306.425451]  kasan_set_free_info+0x20/0x40
[ 1306.426545]  __kasan_slab_free+0x104/0x190
[ 1306.427599]  kfree+0x15b/0x360
[ 1306.428597]  ib_destroy_qp_user+0x11b/0x210 [ib_core]
[ 1306.430235]  rdma_destroy_qp+0x34/0xd0 [rdma_cm]
[ 1306.431464]  rpcrdma_ep_put+0x69/0x180 [rpcrdma]
[ 1306.432906]  rpcrdma_xprt_disconnect+0x3fb/0x4d0 [rpcrdma]
[ 1306.434601]  xprt_rdma_close+0xe/0x50 [rpcrdma]
[ 1306.436183]  xprt_autoclose+0xa0/0x190 [sunrpc]
[ 1306.438386]  process_one_work+0x3b1/0x6b0
[ 1306.439406]  worker_thread+0x5a/0x640
[ 1306.440559]  kthread+0x160/0x190
[ 1306.441574]  ret_from_fork+0x1f/0x30
[ 1306.442475]
[ 1306.442900] The buggy address belongs to the object at ffff888054beb000
[ 1306.442900]  which belongs to the cache kmalloc-2k of size 2048
[ 1306.445828] The buggy address is located 384 bytes inside of
[ 1306.445828]  2048-byte region [ffff888054beb000, ffff888054beb800)
[ 1306.448524]
[ 1306.448895] The buggy address belongs to the physical page:
[ 1306.450168] page:00000000bf2cbf48 refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x54be8
[ 1306.452435] head:00000000bf2cbf48 order:3 compound_mapcount:0
compound_pincount:0
[ 1306.454495] flags:
0xfffffc0010200(slab|head|node=0|zone=1|lastcpupid=0x1fffff)
[ 1306.456354] raw: 000fffffc0010200 ffffea0001593600 dead000000000002
ffff888001042000
[ 1306.458377] raw: 0000000000000000 0000000080080008 00000001ffffffff
0000000000000000
[ 1306.460189] page dumped because: kasan: bad access detected
[ 1306.461478]
[ 1306.461854] Memory state around the buggy address:
[ 1306.463056]  ffff888054beb080: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 1306.464791]  ffff888054beb100: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 1306.466471] >ffff888054beb180: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 1306.468128]                    ^
[ 1306.468902]  ffff888054beb200: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 1306.470611]  ffff888054beb280: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 1306.472279] ==================================================================


I have dynamic debugging turned on but I'm not sure how far before the
KASAN output you'd be interested to see.

This is what's after:

[ 1306.475413] siw0: QP[1] siw_qp_llp_close: llp close: no state
transition needed: ERROR
[ 1306.477241] siw0: QP[1] siw_qp_llp_close: llp close exit: state ERROR
[ 1307.688823] siw0: CEP[0xffff888031ff1600] __siw_cep_dealloc: free endpoint

this was before (note NFS layer is detecting that NFS server isn't responding)

[ 1301.718666] nfs: server 192.168.1.124 not responding, still trying
[ 1305.913263] siw0: CEP[0xffff888031ff1600] siw_cm_llp_state_change: state: 7
[ 1305.915269] siw0: CEP[0xffff888031ff1600] siw_cm_queue_work: [QP
1]: work type: 4, timeout 0
[ 1305.918056] siw0: CEP[0xffff888031ff1600] siw_cm_llp_error_report:
error 104, socket state: 7, cep state: 7
[ 1305.918138] siw0: CEP[0xffff888031ff1600] siw_cm_work_handler: [QP
1]: work type: 4, state 7
[ 1305.921167] siw0: QP[1] siw_qp_sq_process: wqe type 9 processing failed: -104
[ 1305.923282] siw0: CEP[0xffff888031ff1600] siw_cm_upcall: [QP 1]:
reason=4, status=0
[ 1305.925212] siw0: QP[1] siw_qp_sq_process: proc. read.response failed: -104
[ 1305.925243] siw0: QP[1] siw_sq_resume: SQ task failed: err -104
[ 1305.927612] siw0: CEP[0xffff888031ff1600] siw_cm_upcall: [QP 1]:
reason=5, status=0
[ 1305.929894] siw0: QP[1] siw_qp_modify: state: RTS => CLOSING
[ 1305.931615] siw0: CEP[0xffff888031ff1600] siw_cm_work_handler:
release: timer=n, QP[1]
[ 1305.931639] siw0: QP[1] siw_qp_llp_close: enter llp close, state = RTS
[ 1305.934168] siw0: CQ[500590320] siw_rqe_complete: Call completion handler
[ 1305.934239] siw0: CEP[0xffff888031ff1600] siw_qp_cm_drop: already closed
[ 1305.943804] siw0: QP[1] siw_verbs_modify_qp: desired IB QP state: ERR
[ 1305.945323] siw0: CQ[500590320] siw_reap_cqe: idx 0, type 8, flags
1, id 0xffff888031246c00
[ 1305.947253] siw0: CQ[500590320] siw_req_notify_cq: flags: 0x06
[ 1305.963279] siw0: QP[1] siw_qp_modify: state: CLOSING => ERROR
[ 1305.965195] siw0: CQ[500590320] siw_rqe_complete: Call completion handler
[ 1305.966914] siw0: CQ[500590320] siw_reap_cqe: idx 1, type 8, flags
1, id 0xffff88801d38fbd0
[ 1305.969017] siw0: CQ[500590320] siw_req_notify_cq: flags: 0x06
[ 1306.065108] siw0: QP[1] siw_verbs_modify_qp: desired IB QP state: ERR
[ 1306.066882] siw0: QP[1] siw_qp_modify: state: ERROR => ERROR
[ 1306.068578] siw0: CQ[3814951205] siw_sqe_complete: Call completion handler
[ 1306.070415] siw0: CQ[3814951205] siw_reap_cqe: idx 1, type 0, flags
 1, id 0xffff88801d38fb68
[ 1306.072506] siw0: CQ[3814951205] siw_req_notify_cq: flags: 0x06
[ 1306.079748] siw0: MEM[0x4b102701] siw_dereg_mr: deregister MR
[ 1306.081309] siw0: MEM[0x4b102701] siw_free_mem: free mem, pbl: y
[ 1306.082814] siw0: MEM[0xe7728501] siw_dereg_mr: deregister MR
[ 1306.084320] siw0: MEM[0xe7728501] siw_free_mem: free mem, pbl: y
[ 1306.086048] siw0: MEM[0xa5b4d801] siw_dereg_mr: deregister MR
[ 1306.087476] siw0: MEM[0xa5b4d801] siw_free_mem: free mem, pbl: y
[ 1306.089028] siw0: MEM[0x6b7ed500] siw_dereg_mr: deregister MR
[ 1306.090457] siw0: MEM[0x6b7ed500] siw_free_mem: free mem, pbl: y
[ 1306.318414] siw0: QP[1] siw_destroy_qp: state 5
[ 1306.319688] siw0: QP[1] siw_qp_modify: state: ERROR => ERROR
[ 1306.321075] siw0: CQ[500590320] siw_destroy_cq: free CQ resources
[ 1306.322616] siw0: CQ[3814951205] siw_destroy_cq: free CQ resources
[ 1306.324373] siw0: MEM[0x16f39e00] siw_dereg_mr: deregister MR
[ 1306.325986] siw0: MEM[0x16f39e00] siw_free_mem: free mem, pbl: n
[ 1306.327995] siw0: PD[26] siw_dealloc_pd: free PD
