Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647B559F8D4
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Aug 2022 13:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbiHXLuL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Aug 2022 07:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbiHXLuJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Aug 2022 07:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D677961B
        for <linux-rdma@vger.kernel.org>; Wed, 24 Aug 2022 04:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661341807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=lQxlRxrfEhKSptP68KjRTrAyXaf8+4veMAr6U0qOsIk=;
        b=A0XuUBy6r+slhKC5q/TZkgFlDhJ55LYUoeY8dZXH4cO4Wrufun37kjoyIVJhUPTyNMPn0t
        F9yt+mXs/Oh5F/Z0v21rZtnSH1wTY2BONZZJODjzQdlKEUBFvKcocjgK+JnKt+30RAmHxg
        0Xf6mSy+MeMBOXiOPdp9hUTzph46NvI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-605-KsuxDVP3MGCPzCUSIkNFYA-1; Wed, 24 Aug 2022 07:50:05 -0400
X-MC-Unique: KsuxDVP3MGCPzCUSIkNFYA-1
Received: by mail-ed1-f70.google.com with SMTP id q18-20020a056402519200b0043dd2ff50feso10706441edd.9
        for <linux-rdma@vger.kernel.org>; Wed, 24 Aug 2022 04:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=lQxlRxrfEhKSptP68KjRTrAyXaf8+4veMAr6U0qOsIk=;
        b=KOp5mTFzjQ7dW2yfzcyhgszVUj2r2vZp5jyEW25wKS8zwJ0kPKo2x07RkuT2ufMJxr
         bOmN6cMlbZD2CwHJfrf48W+XN0JAu7+27oVd/Ph7VoQalb98wF7H+YD+BNMXKFttb7k2
         ZrluzcGGpAHHQCdKLPeHeGPx5fTeHj0PPmiOzB9GU8POIj9kelc860B4lk5lqBV3zmDk
         CFDqGKTe+Z0dWfs8X3/ob8kD3NFDlm718B77SKn+2Kes0XSR0gspvf2bifiSlIePBxuO
         N9DF/9aW/Z2dPuF8kLKgWDz/CxPTF7vB2xMN/EWmzqenywjJjKNBAc+2Hvrp6NMLsDkY
         1Eug==
X-Gm-Message-State: ACgBeo0Sc3Mf2+wSN1DZ6t6ppwsODQyqKf0NgXW+fd81dkQjZYGPAJix
        kcIfVZf2siOPxYAHtrmM0e0v3v4zPq29orPsNx3cyMALgNG59SXGwcBIiQHefVTctSFNIMWkR81
        VLA1AFzDQ7hXRIuoTol/kvaEVI5LQkAksDl/UiA==
X-Received: by 2002:a05:6402:4313:b0:446:ffc0:50b5 with SMTP id m19-20020a056402431300b00446ffc050b5mr7132174edc.153.1661341804413;
        Wed, 24 Aug 2022 04:50:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Dg+RzLfwIzfdJY+qG/WwkyZha6coUqF3uTPmt07TOtQFBu0sbkvb/mW0lWd3dGlUCqeIFaCRU3vX9QhrYqq8=
X-Received: by 2002:a05:6402:4313:b0:446:ffc0:50b5 with SMTP id
 m19-20020a056402431300b00446ffc050b5mr7132161edc.153.1661341804152; Wed, 24
 Aug 2022 04:50:04 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 24 Aug 2022 19:49:52 +0800
Message-ID: <CAHj4cs8B=XE+=iuotM3VAufq3ZFdXoJCP24w+e4sfWrc1gVJvg@mail.gmail.com>
Subject: [bug report] bnxt_re: UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
To:     RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello

I found this issue during the system boots up with 6.0.0-rc2, pls help
check it, thanks.

[   64.822670] ================================================================================
[   64.831218] UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
[   64.837784] shift exponent 64 is too large for 64-bit type 'long
unsigned int'
[   64.845038] CPU: 21 PID: 8 Comm: kworker/u96:0 Tainted: G
I        6.0.0-rc2.fix1+ #2
[   64.853652] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS
2.13.3 12/13/2021
[   64.861226] Workqueue: bnxt_re bnxt_re_task [bnxt_re]
[   64.866303] Call Trace:
[   64.868758]  <TASK>
[   64.870874]  dump_stack_lvl+0x44/0x5b
[   64.874558]  ubsan_epilogue+0x5/0x3a
[   64.878141]  __ubsan_handle_shift_out_of_bounds.cold.12+0xb4/0xf3
[   64.884260]  ? _raw_spin_unlock_irqrestore+0x30/0x60
[   64.889250]  bnxt_qplib_alloc_init_hwq.cold.18+0x1db/0x251 [bnxt_re]
[   64.895639]  ? kasan_save_stack+0x2b/0x40
[   64.899665]  ? bnxt_qplib_free_hwq+0xa0/0xa0 [bnxt_re]
[   64.901312] hfi1 0000:d8:00.0: hfi1_0: Eager buffer size 8388608
[   64.904818]  ? bnxt_re_create_qp+0x1bfe/0x5000 [bnxt_re]
[   64.904843]  ? ib_mad_init_device+0x389/0xd20 [ib_core]
[   64.915433]  ? add_client_context+0x2fe/0x450 [ib_core]
[   64.920693]  ? enable_device_and_get+0x1b7/0x350 [ib_core]
[   64.926216]  ? ib_register_device+0x785/0xb10 [ib_core]
[   64.931489]  bnxt_qplib_create_qp+0x316/0x1ac0 [bnxt_re]
[   64.936838]  ? bnxt_qplib_create_qp1+0x1260/0x1260 [bnxt_re]
[   64.942506]  ? find_held_lock+0x3a/0x1d0
[   64.946454]  ? lock_release+0x42f/0xce0
[   64.950307]  ? lock_is_held_type+0xdd/0x130
[   64.954535]  ? __kasan_kmalloc+0x84/0xa0
[   64.958479]  ? kmem_cache_alloc_trace+0x199/0x2a0
[   64.963194]  ? bnxt_re_create_qp+0x1bfe/0x5000 [bnxt_re]
[   64.968534]  bnxt_re_create_qp+0x2334/0x5000 [bnxt_re]
[   64.973689]  ? mark_held_locks+0xb7/0x120
[   64.977751]  ? bnxt_re_destroy_qp+0x7e0/0x7e0 [bnxt_re]
[   64.980429] DMA-API: dma_debug_entry pool grown to 131072 (200%)
[   64.982998]  ? __module_address.part.39+0x65/0x220
[   64.987798]  ? preempt_count_add+0x80/0x150
[   64.991997]  ? is_module_address+0x41/0x60
[   64.996105]  ? static_obj+0x9b/0xc0
[   64.999604]  ? lockdep_init_map_type+0x2fc/0x800
[   65.004242]  ? __init_swait_queue_head+0xcb/0x150
[   65.008968]  ? create_qp+0x59a/0x940 [ib_core]
[   65.013454]  create_qp+0x59a/0x940 [ib_core]
[   65.017773]  ? ib_drain_qp+0x50/0x50 [ib_core]
[   65.022272]  ? lock_is_held_type+0xdd/0x130
[   65.026483]  ib_create_qp_kernel+0x87/0x2d0 [ib_core]
[   65.031573]  create_mad_qp+0x163/0x2a0 [ib_core]
[   65.036231]  ? __list_del_entry+0xb0/0xb0 [ib_core]
[   65.041149]  ? ib_sa_init.cold.42+0x24/0x24 [ib_core]
[   65.046272]  ? __ib_alloc_pd+0x10f/0x560 [ib_core]
[   65.051110]  ib_mad_init_device+0x389/0xd20 [ib_core]
[   65.056224]  ? lock_downgrade+0x6b0/0x6b0
[   65.060250]  ? ib_mad_post_receive_mads+0xf10/0xf10 [ib_core]
[   65.066034]  ? downgrade_write+0x10a/0x3b0
[   65.070143]  ? up_write+0x4a0/0x4a0
[   65.073646]  ? do_raw_spin_unlock+0x54/0x230
[   65.077958]  add_client_context+0x2fe/0x450 [ib_core]
[   65.083075]  ? ib_unregister_driver+0x1b0/0x1b0 [ib_core]
[   65.088538]  enable_device_and_get+0x1b7/0x350 [ib_core]
[   65.093890]  ? add_one_compat_dev+0x700/0x700 [ib_core]
[   65.099170]  ? rdma_counter_init+0x14c/0x3d0 [ib_core]
[   65.104362]  ib_register_device+0x785/0xb10 [ib_core]
[   65.109463]  ? alloc_port_data.part.22+0x390/0x390 [ib_core]
[   65.115171]  ? _raw_spin_unlock_irqrestore+0x3b/0x60
[   65.120146]  ? ib_device_set_netdev+0x3d8/0x610 [ib_core]
[   65.125592]  bnxt_re_task+0x632/0x8f0 [bnxt_re]
[   65.130141]  ? bnxt_re_netdev_event+0xb40/0xb40 [bnxt_re]
[   65.135560]  ? lock_is_held_type+0xdd/0x130
[   65.139768]  ? rcu_read_lock_sched_held+0xb3/0xe0
[   65.144493]  ? rcu_read_lock_bh_held+0xd0/0xd0
[   65.148969]  process_one_work+0x970/0x16c0
[   65.153104]  ? pwq_dec_nr_in_flight+0x270/0x270
[   65.157678]  worker_thread+0x8a/0xe50
[   65.161378]  ? process_one_work+0x16c0/0x16c0
[   65.165749]  kthread+0x29b/0x340
[   65.168995]  ? kthread_complete_and_exit+0x20/0x20
[   65.173803]  ret_from_fork+0x1f/0x30
[   65.177430]  </TASK>
[   65.179695] ================================================================================

-- 
Best Regards,
  Yi Zhang

