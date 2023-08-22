Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1435078378F
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 03:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjHVBqc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Aug 2023 21:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjHVBqb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Aug 2023 21:46:31 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5625A130;
        Mon, 21 Aug 2023 18:46:26 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1c4b4c40281so2717830fac.1;
        Mon, 21 Aug 2023 18:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692668785; x=1693273585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6jjoe74yy3Wy/+Z+RJbWubQ0a6e5Bm62jRYoC+ZbTHc=;
        b=odk1+rHfes4GIg4Pqq5gVof4+q6FZFlOLeHnbQU7Eyv908b0SAdYzfdVwFMsfqE9FK
         NBLKGO6Qd/c3BnNRxvMzboynNwzHcQxT/lagrG3ju2MSbLRB4bA3B89H7sGq42cqMojj
         q9b/eK1qMniok0Uvy1acFF7VY8kZK16waxJ9viuRbhrQ4W8VPRey1QfERImINc3jecge
         1ZOaiWE1bSgEH8wgvPoqhND4hJlQCzL0V6BT9+HXJgq811eXMBSUJWAw72RhVIkKjslc
         8nykY2m5NDsWxjKlO1hM8Ys4efZfuL6uA6iHfXipFCGWv/iZCBzAHkvcmWp3axruf2q2
         IL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692668785; x=1693273585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6jjoe74yy3Wy/+Z+RJbWubQ0a6e5Bm62jRYoC+ZbTHc=;
        b=OeA9ETnEHKkCsVV5c5CKjCXbOyvBAWJhYv1iVRsraUOeD1vi118vOFZ9ZEaXj2nbuw
         9KOgxC+qRY8pzyfYqEbOPBo6MoOaV3exROGwfh1yg6qxIkk/2lEM2/dFADTxvmRsKoWw
         740fynFB1C11coq/Pf0P7PTVeu8FXr9bJ5hq9JKdIIKSt2PQOWYKokKjHgWN8grZTpoQ
         v5o5fg9YxvIV9i5Qn/401bDaUoTh02522eFZW3ScKU1Quz3PgwMsS31d37/NrAzVbuqI
         k/XHMRi2LzEzUEqw6V35zVPNPM7IZuecb3V01KbwWk23TrlTwCYI275oUQBTvtkY0h+4
         jvDg==
X-Gm-Message-State: AOJu0YxrFFz3TFdaJlz7L6Z5iNfQOg4ibqfs26u3hvRU+NMGpT+bXNFk
        PkZIexrMgowGqG+kHwzxo9WwoDzxBYmbdg==
X-Google-Smtp-Source: AGHT+IFSonr/Hnhbfv24IcJqYsP0Z52J4WH2WSh1YQ5QHxl5ojANiOtl0zEQ+8uRvg7d3hpXzguOYQ==
X-Received: by 2002:a05:6870:42cc:b0:1bf:cec2:6aff with SMTP id z12-20020a05687042cc00b001bfcec26affmr5518628oah.5.1692668784356;
        Mon, 21 Aug 2023 18:46:24 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:3829:a4f9:4453:7fb2? (2603-8081-140c-1a00-3829-a4f9-4453-7fb2.res6.spectrum.com. [2603:8081:140c:1a00:3829:a4f9:4453:7fb2])
        by smtp.gmail.com with ESMTPSA id dy19-20020a056870c79300b001a9911765efsm4949378oab.40.2023.08.21.18.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 18:46:23 -0700 (PDT)
Message-ID: <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
Date:   Mon, 21 Aug 2023 20:46:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [bug report] blktests srp/002 hang
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/21/23 01:46, Shinichiro Kawasaki wrote:
> I observed a process hang at the blktests test case srp/002 occasionally, using
> kernel v6.5-rcX. Kernel reported stall of many kworkers [1]. PID 2757 hanged at
> inode_sleep_on_writeback(). Other kworkers hanged at __inode_wait_for_writeback.
> 
> The hang is recreated in stable manner by repeating the test case srp/002 (from
> 15 times to 30 times).
> 
> I bisected and found the commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support
> for rxe tasks") looks like the trigger commit. When I revert it from the kernel
> v6.5-rc7, the hang symptom disappears. I'm not sure how the commit relates to
> the hang. Comments will be welcomed.
> 
> [1]
> 
> ...
> [ 1670.489181] scsi 4:0:0:1: alua: Detached
> [ 1670.985461] ib_srpt:srpt_zerolength_write: ib_srpt 10.0.2.15-38: queued zerolength write
> [ 1670.985702] ib_srpt:srpt_zerolength_write: ib_srpt 10.0.2.15-36: queued zerolength write
> [ 1670.985716] ib_srpt:srpt_zerolength_write_done: ib_srpt 10.0.2.15-38 wc->status 5
> [ 1670.985821] ib_srpt:srpt_release_channel_work: ib_srpt 10.0.2.15-38
> [ 1670.985824] ib_srpt:srpt_zerolength_write_done: ib_srpt 10.0.2.15-36 wc->status 5
> [ 1670.985909] ib_srpt:srpt_zerolength_write: ib_srpt 10.0.2.15-34: queued zerolength write
> [ 1670.985924] ib_srpt:srpt_release_channel_work: ib_srpt 10.0.2.15-36
> [ 1670.986104] ib_srpt:srpt_zerolength_write_done: ib_srpt 10.0.2.15-34 wc->status 5
> [ 1670.986244] ib_srpt:srpt_release_channel_work: ib_srpt 10.0.2.15-34
> [ 1671.049223] ib_srpt:srpt_zerolength_write: ib_srpt 10.0.2.15-40: queued zerolength write
> [ 1671.049588] ib_srpt:srpt_zerolength_write_done: ib_srpt 10.0.2.15-40 wc->status 5
> [ 1671.049626] ib_srpt:srpt_release_channel_work: ib_srpt 10.0.2.15-40
> [ 1844.873748] INFO: task kworker/0:1:9 blocked for more than 122 seconds.
> [ 1844.877893]       Not tainted 6.5.0-rc7 #106
> [ 1844.878903] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1844.880255] task:kworker/0:1     state:D stack:0     pid:9     ppid:2      flags:0x00004000
> [ 1844.881830] Workqueue: dio/dm-1 iomap_dio_complete_work
> [ 1844.882999] Call Trace:
> [ 1844.883900]  <TASK>
> [ 1844.884703]  __schedule+0x10ac/0x5e80
> [ 1844.885609]  ? do_raw_spin_unlock+0x54/0x1f0
> [ 1844.886569]  ? __pfx___schedule+0x10/0x10
> [ 1844.887596]  ? lock_release+0x378/0x650
> [ 1844.888431]  ? schedule+0x92/0x220
> [ 1844.889232]  ? mark_held_locks+0x96/0xe0
> [ 1844.890117]  schedule+0x133/0x220
> [ 1844.890874]  bit_wait+0x17/0xe0
> [ 1844.891619]  __wait_on_bit+0x66/0x180
> [ 1844.892409]  ? __pfx_bit_wait+0x10/0x10
> [ 1844.893192]  __inode_wait_for_writeback+0x12b/0x1b0
> [ 1844.894245]  ? __pfx___inode_wait_for_writeback+0x10/0x10
> [ 1844.895225]  ? __pfx_wake_bit_function+0x10/0x10
> [ 1844.896138]  ? find_held_lock+0x2d/0x110
> [ 1844.897085]  writeback_single_inode+0xf9/0x3f0
> [ 1844.898186]  sync_inode_metadata+0x91/0xd0
> [ 1844.899036]  ? __pfx_sync_inode_metadata+0x10/0x10
> [ 1844.900106]  ? lock_release+0x378/0x650
> [ 1844.900988]  ? file_check_and_advance_wb_err+0xb5/0x230
> [ 1844.901978]  generic_buffers_fsync_noflush+0x1bf/0x270
> [ 1844.902964]  ext4_sync_file+0x469/0xb60
> [ 1844.903859]  iomap_dio_complete+0x5d1/0x860
> [ 1844.904828]  ? __pfx_aio_complete_rw+0x10/0x10
> [ 1844.905841]  iomap_dio_complete_work+0x52/0x80
> [ 1844.906774]  process_one_work+0x898/0x14a0
> [ 1844.907673]  ? __pfx_lock_acquire+0x10/0x10
> [ 1844.908644]  ? __pfx_process_one_work+0x10/0x10
> [ 1844.909693]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [ 1844.910676]  worker_thread+0x100/0x12c0
> [ 1844.911612]  ? __kthread_parkme+0xc1/0x1f0
> [ 1844.912542]  ? __pfx_worker_thread+0x10/0x10
> [ 1844.913584]  kthread+0x2ea/0x3c0
> [ 1844.914465]  ? __pfx_kthread+0x10/0x10
> [ 1844.915335]  ret_from_fork+0x30/0x70
> [ 1844.916269]  ? __pfx_kthread+0x10/0x10
> [ 1844.917308]  ret_from_fork_asm+0x1b/0x30
> [ 1844.918243]  </TASK>
> [ 1844.918998] INFO: task kworker/1:0:25 blocked for more than 122 seconds.
> [ 1844.920107]       Not tainted 6.5.0-rc7 #106
> [ 1844.921041] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1844.922262] task:kworker/1:0     state:D stack:0     pid:25    ppid:2      flags:0x00004000
> [ 1844.923550] Workqueue: dio/dm-1 iomap_dio_complete_work
> [ 1844.924598] Call Trace:
> [ 1844.925407]  <TASK>
> [ 1844.926194]  __schedule+0x10ac/0x5e80
> [ 1844.927097]  ? do_raw_spin_unlock+0x54/0x1f0
> [ 1844.928032]  ? __pfx___schedule+0x10/0x10
> [ 1844.928937]  ? lock_release+0x378/0x650
> [ 1844.929823]  ? schedule+0x92/0x220
> [ 1844.930682]  ? mark_held_locks+0x96/0xe0
> [ 1844.931579]  schedule+0x133/0x220
> [ 1844.932411]  bit_wait+0x17/0xe0
> [ 1844.933238]  __wait_on_bit+0x66/0x180
> [ 1844.934107]  ? __pfx_bit_wait+0x10/0x10
> [ 1844.934996]  __inode_wait_for_writeback+0x12b/0x1b0
> [ 1844.935956]  ? __pfx___inode_wait_for_writeback+0x10/0x10
> [ 1844.936969]  ? __pfx_wake_bit_function+0x10/0x10
> [ 1844.937942]  ? find_held_lock+0x2d/0x110
> [ 1844.938891]  writeback_single_inode+0xf9/0x3f0
> [ 1844.939836]  sync_inode_metadata+0x91/0xd0
> [ 1844.940758]  ? __pfx_sync_inode_metadata+0x10/0x10
> [ 1844.941730]  ? lock_release+0x378/0x650
> [ 1844.942640]  ? file_check_and_advance_wb_err+0xb5/0x230
> [ 1844.943647]  generic_buffers_fsync_noflush+0x1bf/0x270
> [ 1844.944652]  ext4_sync_file+0x469/0xb60
> [ 1844.945561]  iomap_dio_complete+0x5d1/0x860
> [ 1844.946469]  ? __pfx_aio_complete_rw+0x10/0x10
> [ 1844.947417]  iomap_dio_complete_work+0x52/0x80
> [ 1844.948358]  process_one_work+0x898/0x14a0
> [ 1844.949284]  ? __pfx_lock_acquire+0x10/0x10
> [ 1844.950204]  ? __pfx_process_one_work+0x10/0x10
> [ 1844.951152]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [ 1844.952094]  worker_thread+0x100/0x12c0
> [ 1844.952998]  ? __pfx_worker_thread+0x10/0x10
> [ 1844.953919]  kthread+0x2ea/0x3c0
> [ 1844.954760]  ? __pfx_kthread+0x10/0x10
> [ 1844.955669]  ret_from_fork+0x30/0x70
> [ 1844.956550]  ? __pfx_kthread+0x10/0x10
> [ 1844.957418]  ret_from_fork_asm+0x1b/0x30
> [ 1844.958321]  </TASK>
> [ 1844.959085] INFO: task kworker/1:1:49 blocked for more than 122 seconds.
> [ 1844.960193]       Not tainted 6.5.0-rc7 #106
> [ 1844.961122] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1844.962340] task:kworker/1:1     state:D stack:0     pid:49    ppid:2      flags:0x00004000
> [ 1844.963619] Workqueue: dio/dm-1 iomap_dio_complete_work
> [ 1844.964667] Call Trace:
> [ 1844.965503]  <TASK>
> [ 1844.966289]  __schedule+0x10ac/0x5e80
> [ 1844.967207]  ? lock_acquire+0x1a9/0x4e0
> [ 1844.968122]  ? __pfx___schedule+0x10/0x10
> [ 1844.969034]  ? lock_release+0x378/0x650
> [ 1844.969922]  ? schedule+0x92/0x220
> [ 1844.970778]  ? mark_held_locks+0x96/0xe0
> [ 1844.971674]  schedule+0x133/0x220
> [ 1844.972526]  bit_wait+0x17/0xe0
> [ 1844.973336]  __wait_on_bit+0x66/0x180
> [ 1844.974206]  ? __pfx_bit_wait+0x10/0x10
> [ 1844.975086]  __inode_wait_for_writeback+0x12b/0x1b0
> [ 1844.976046]  ? __pfx___inode_wait_for_writeback+0x10/0x10
> [ 1844.977056]  ? __pfx_wake_bit_function+0x10/0x10
> [ 1844.978007]  ? find_held_lock+0x2d/0x110
> [ 1844.978917]  writeback_single_inode+0xf9/0x3f0
> [ 1844.979865]  sync_inode_metadata+0x91/0xd0
> [ 1844.980786]  ? __pfx_sync_inode_metadata+0x10/0x10
> [ 1844.981765]  ? lock_release+0x378/0x650
> [ 1844.982677]  ? file_check_and_advance_wb_err+0xb5/0x230
> [ 1844.983687]  generic_buffers_fsync_noflush+0x1bf/0x270
> [ 1844.984696]  ext4_sync_file+0x469/0xb60
> [ 1844.985608]  iomap_dio_complete+0x5d1/0x860
> [ 1844.986548]  ? __pfx_aio_complete_rw+0x10/0x10
> [ 1844.987484]  iomap_dio_complete_work+0x52/0x80
> [ 1844.988435]  process_one_work+0x898/0x14a0
> [ 1844.989352]  ? __pfx_lock_acquire+0x10/0x10
> [ 1844.990275]  ? __pfx_process_one_work+0x10/0x10
> [ 1844.991220]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [ 1844.992164]  worker_thread+0x100/0x12c0
> [ 1844.993065]  ? __kthread_parkme+0xc1/0x1f0
> [ 1844.993977]  ? __pfx_worker_thread+0x10/0x10
> [ 1844.994934]  kthread+0x2ea/0x3c0
> [ 1844.995783]  ? __pfx_kthread+0x10/0x10
> [ 1844.996670]  ret_from_fork+0x30/0x70
> [ 1844.997544]  ? __pfx_kthread+0x10/0x10
> [ 1844.998409]  ret_from_fork_asm+0x1b/0x30
> [ 1844.999308]  </TASK>
> [ 1845.000094] INFO: task kworker/0:2:74 blocked for more than 123 seconds.
> [ 1845.001315]       Not tainted 6.5.0-rc7 #106
> [ 1845.002326] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1845.003630] task:kworker/0:2     state:D stack:0     pid:74    ppid:2      flags:0x00004000
> [ 1845.004991] Workqueue: dio/dm-1 iomap_dio_complete_work
> [ 1845.006108] Call Trace:
> [ 1845.006975]  <TASK>
> [ 1845.007805]  __schedule+0x10ac/0x5e80
> [ 1845.008781]  ? do_raw_spin_unlock+0x54/0x1f0
> [ 1845.009780]  ? __pfx___schedule+0x10/0x10
> [ 1845.010736]  ? lock_release+0x378/0x650
> [ 1845.011666]  ? schedule+0x92/0x220
> [ 1845.012579]  ? mark_held_locks+0x96/0xe0
> [ 1845.013531]  schedule+0x133/0x220
> [ 1845.014414]  bit_wait+0x17/0xe0
> [ 1845.015287]  __wait_on_bit+0x66/0x180
> [ 1845.016219]  ? __pfx_bit_wait+0x10/0x10
> [ 1845.017164]  __inode_wait_for_writeback+0x12b/0x1b0
> [ 1845.018185]  ? __pfx___inode_wait_for_writeback+0x10/0x10
> [ 1845.019269]  ? __pfx_wake_bit_function+0x10/0x10
> [ 1845.020282]  ? find_held_lock+0x2d/0x110
> [ 1845.021246]  writeback_single_inode+0xf9/0x3f0
> [ 1845.022248]  sync_inode_metadata+0x91/0xd0
> [ 1845.023222]  ? __pfx_sync_inode_metadata+0x10/0x10
> [ 1845.024255]  ? lock_release+0x378/0x650
> [ 1845.025207]  ? file_check_and_advance_wb_err+0xb5/0x230
> [ 1845.026281]  generic_buffers_fsync_noflush+0x1bf/0x270
> [ 1845.027347]  ext4_sync_file+0x469/0xb60
> [ 1845.028302]  iomap_dio_complete+0x5d1/0x860
> [ 1845.029275]  ? __pfx_aio_complete_rw+0x10/0x10
> [ 1845.030276]  iomap_dio_complete_work+0x52/0x80
> [ 1845.031281]  process_one_work+0x898/0x14a0
> [ 1845.032248]  ? __pfx_lock_acquire+0x10/0x10
> [ 1845.033199]  ? __pfx_process_one_work+0x10/0x10
> [ 1845.034182]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [ 1845.035188]  worker_thread+0x100/0x12c0
> [ 1845.036138]  ? __pfx_worker_thread+0x10/0x10
> [ 1845.037104]  kthread+0x2ea/0x3c0
> [ 1845.037996]  ? __pfx_kthread+0x10/0x10
> [ 1845.038923]  ret_from_fork+0x30/0x70
> [ 1845.039840]  ? __pfx_kthread+0x10/0x10
> [ 1845.040763]  ret_from_fork_asm+0x1b/0x30
> [ 1845.041729]  </TASK>
> [ 1845.042531] INFO: task kworker/3:2:169 blocked for more than 123 seconds.
> [ 1845.043703]       Not tainted 6.5.0-rc7 #106
> [ 1845.044780] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1845.046068] task:kworker/3:2     state:D stack:0     pid:169   ppid:2      flags:0x00004000
> [ 1845.047400] Workqueue: dio/dm-1 iomap_dio_complete_work
> [ 1845.048518] Call Trace:
> [ 1845.049392]  <TASK>
> [ 1845.050214]  __schedule+0x10ac/0x5e80
> [ 1845.051172]  ? lock_acquire+0x1a9/0x4e0
> [ 1845.052141]  ? __pfx___schedule+0x10/0x10
> [ 1845.053086]  ? lock_release+0x378/0x650
> [ 1845.054017]  ? schedule+0x92/0x220
> [ 1845.054920]  ? mark_held_locks+0x96/0xe0
> [ 1845.055866]  schedule+0x133/0x220
> [ 1845.056761]  bit_wait+0x17/0xe0
> [ 1845.057645]  __wait_on_bit+0x66/0x180
> [ 1845.058573]  ? __pfx_bit_wait+0x10/0x10
> [ 1845.059502]  __inode_wait_for_writeback+0x12b/0x1b0
> [ 1845.060528]  ? __pfx___inode_wait_for_writeback+0x10/0x10
> [ 1845.061603]  ? __pfx_wake_bit_function+0x10/0x10
> [ 1845.062604]  ? find_held_lock+0x2d/0x110
> [ 1845.063548]  writeback_single_inode+0xf9/0x3f0
> [ 1845.064564]  sync_inode_metadata+0x91/0xd0
> [ 1845.065534]  ? __pfx_sync_inode_metadata+0x10/0x10
> [ 1845.066552]  ? lock_release+0x378/0x650
> [ 1845.067504]  ? file_check_and_advance_wb_err+0xb5/0x230
> [ 1845.068557]  generic_buffers_fsync_noflush+0x1bf/0x270
> [ 1845.069609]  ext4_sync_file+0x469/0xb60
> [ 1845.070563]  iomap_dio_complete+0x5d1/0x860
> [ 1845.071550]  ? __pfx_aio_complete_rw+0x10/0x10
> [ 1845.072543]  iomap_dio_complete_work+0x52/0x80
> [ 1845.073547]  process_one_work+0x898/0x14a0
> [ 1845.074518]  ? __pfx_lock_acquire+0x10/0x10
> [ 1845.075468]  ? __pfx_process_one_work+0x10/0x10
> [ 1845.076456]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [ 1845.077436]  worker_thread+0x100/0x12c0
> [ 1845.078382]  ? __pfx_worker_thread+0x10/0x10
> [ 1845.079354]  kthread+0x2ea/0x3c0
> [ 1845.080230]  ? __pfx_kthread+0x10/0x10
> [ 1845.081163]  ret_from_fork+0x30/0x70
> [ 1845.082075]  ? __pfx_kthread+0x10/0x10
> [ 1845.083014]  ret_from_fork_asm+0x1b/0x30
> [ 1845.083957]  </TASK>
> [ 1845.084756] INFO: task kworker/0:3:221 blocked for more than 123 seconds.
> [ 1845.085927]       Not tainted 6.5.0-rc7 #106
> [ 1845.086911] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1845.088205] task:kworker/0:3     state:D stack:0     pid:221   ppid:2      flags:0x00004000
> [ 1845.089566] Workqueue: dio/dm-1 iomap_dio_complete_work
> [ 1845.090635] Call Trace:
> [ 1845.091503]  <TASK>
> [ 1845.092318]  __schedule+0x10ac/0x5e80
> [ 1845.093282]  ? do_raw_spin_unlock+0x54/0x1f0
> [ 1845.094265]  ? __pfx___schedule+0x10/0x10
> [ 1845.095200]  ? lock_release+0x378/0x650
> [ 1845.096132]  ? schedule+0x92/0x220
> [ 1845.097018]  ? mark_held_locks+0x96/0xe0
> [ 1845.097959]  schedule+0x133/0x220
> [ 1845.098863]  bit_wait+0x17/0xe0
> [ 1845.099736]  __wait_on_bit+0x66/0x180
> [ 1845.100649]  ? __pfx_bit_wait+0x10/0x10
> [ 1845.101600]  __inode_wait_for_writeback+0x12b/0x1b0
> [ 1845.102606]  ? __pfx___inode_wait_for_writeback+0x10/0x10
> [ 1845.103673]  ? __pfx_wake_bit_function+0x10/0x10
> [ 1845.104685]  ? find_held_lock+0x2d/0x110
> [ 1845.105633]  writeback_single_inode+0xf9/0x3f0
> [ 1845.106625]  sync_inode_metadata+0x91/0xd0
> [ 1845.107612]  ? __pfx_sync_inode_metadata+0x10/0x10
> [ 1845.108635]  ? lock_release+0x378/0x650
> [ 1845.109591]  ? file_check_and_advance_wb_err+0xb5/0x230
> [ 1845.110645]  generic_buffers_fsync_noflush+0x1bf/0x270
> [ 1845.111698]  ext4_sync_file+0x469/0xb60
> [ 1845.112657]  iomap_dio_complete+0x5d1/0x860
> [ 1845.113639]  ? __pfx_aio_complete_rw+0x10/0x10
> [ 1845.114625]  iomap_dio_complete_work+0x52/0x80
> [ 1845.115616]  process_one_work+0x898/0x14a0
> [ 1845.116582]  ? __pfx_lock_acquire+0x10/0x10
> [ 1845.117575]  ? __pfx_process_one_work+0x10/0x10
> [ 1845.118573]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [ 1845.119557]  worker_thread+0x100/0x12c0
> [ 1845.120480]  ? __pfx_worker_thread+0x10/0x10
> [ 1845.121453]  kthread+0x2ea/0x3c0
> [ 1845.122339]  ? __pfx_kthread+0x10/0x10
> [ 1845.123277]  ret_from_fork+0x30/0x70
> [ 1845.124192]  ? __pfx_kthread+0x10/0x10
> [ 1845.125131]  ret_from_fork_asm+0x1b/0x30
> [ 1845.126085]  </TASK>
> [ 1845.127043] INFO: task kworker/1:2:230 blocked for more than 123 seconds.
> [ 1845.128574]       Not tainted 6.5.0-rc7 #106
> [ 1845.129789] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1845.131441] task:kworker/1:2     state:D stack:0     pid:230   ppid:2      flags:0x00004000
> [ 1845.133125] Workqueue: dio/dm-1 iomap_dio_complete_work
> [ 1845.134546] Call Trace:
> [ 1845.135547]  <TASK>
> [ 1845.136475]  __schedule+0x10ac/0x5e80
> [ 1845.137599]  ? lock_acquire+0x1a9/0x4e0
> [ 1845.138703]  ? __pfx___schedule+0x10/0x10
> [ 1845.139859]  ? lock_release+0x378/0x650
> [ 1845.140980]  ? schedule+0x92/0x220
> [ 1845.142026]  ? mark_held_locks+0x96/0xe0
> [ 1845.143161]  schedule+0x133/0x220
> [ 1845.144196]  bit_wait+0x17/0xe0
> [ 1845.145233]  __wait_on_bit+0x66/0x180
> [ 1845.146262]  ? __pfx_bit_wait+0x10/0x10
> [ 1845.147380]  __inode_wait_for_writeback+0x12b/0x1b0
> [ 1845.148650]  ? __pfx___inode_wait_for_writeback+0x10/0x10
> [ 1845.149950]  ? __pfx_wake_bit_function+0x10/0x10
> [ 1845.151181]  ? find_held_lock+0x2d/0x110
> [ 1845.152288]  writeback_single_inode+0xf9/0x3f0
> [ 1845.153474]  sync_inode_metadata+0x91/0xd0
> [ 1845.154608]  ? __pfx_sync_inode_metadata+0x10/0x10
> [ 1845.155857]  ? lock_release+0x378/0x650
> [ 1845.156997]  ? file_check_and_advance_wb_err+0xb5/0x230
> [ 1845.158309]  generic_buffers_fsync_noflush+0x1bf/0x270
> [ 1845.159569]  ext4_sync_file+0x469/0xb60
> [ 1845.160709]  iomap_dio_complete+0x5d1/0x860
> [ 1845.161881]  ? __pfx_aio_complete_rw+0x10/0x10
> [ 1845.163086]  iomap_dio_complete_work+0x52/0x80
> [ 1845.164269]  process_one_work+0x898/0x14a0
> [ 1845.165367]  ? __pfx_lock_acquire+0x10/0x10
> [ 1845.166541]  ? __pfx_process_one_work+0x10/0x10
> [ 1845.167706]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [ 1845.168880]  worker_thread+0x100/0x12c0
> [ 1845.170006]  ? __kthread_parkme+0xc1/0x1f0
> [ 1845.171083]  ? __pfx_worker_thread+0x10/0x10
> [ 1845.172302]  kthread+0x2ea/0x3c0
> [ 1845.173350]  ? __pfx_kthread+0x10/0x10
> [ 1845.174465]  ret_from_fork+0x30/0x70
> [ 1845.175522]  ? __pfx_kthread+0x10/0x10
> [ 1845.176616]  ret_from_fork_asm+0x1b/0x30
> [ 1845.177754]  </TASK>
> [ 1845.178624] INFO: task kworker/2:3:291 blocked for more than 123 seconds.
> [ 1845.180123]       Not tainted 6.5.0-rc7 #106
> [ 1845.181306] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1845.182914] task:kworker/2:3     state:D stack:0     pid:291   ppid:2      flags:0x00004000
> [ 1845.184626] Workqueue: dio/dm-1 iomap_dio_complete_work
> [ 1845.186012] Call Trace:
> [ 1845.187004]  <TASK>
> [ 1845.187939]  __schedule+0x10ac/0x5e80
> [ 1845.189072]  ? do_raw_spin_unlock+0x54/0x1f0
> [ 1845.190177]  ? __pfx___schedule+0x10/0x10
> [ 1845.191356]  ? lock_release+0x378/0x650
> [ 1845.192421]  ? schedule+0x92/0x220
> [ 1845.193501]  ? mark_held_locks+0x96/0xe0
> [ 1845.194535]  schedule+0x133/0x220
> [ 1845.195595]  bit_wait+0x17/0xe0
> [ 1845.196603]  __wait_on_bit+0x66/0x180
> [ 1845.197697]  ? __pfx_bit_wait+0x10/0x10
> [ 1845.198820]  __inode_wait_for_writeback+0x12b/0x1b0
> [ 1845.200061]  ? __pfx___inode_wait_for_writeback+0x10/0x10
> [ 1845.201315]  ? __pfx_wake_bit_function+0x10/0x10
> [ 1845.202522]  ? find_held_lock+0x2d/0x110
> [ 1845.203679]  writeback_single_inode+0xf9/0x3f0
> [ 1845.204885]  sync_inode_metadata+0x91/0xd0
> [ 1845.205943]  ? __pfx_sync_inode_metadata+0x10/0x10
> [ 1845.207190]  ? lock_release+0x378/0x650
> [ 1845.208325]  ? file_check_and_advance_wb_err+0xb5/0x230
> [ 1845.209581]  generic_buffers_fsync_noflush+0x1bf/0x270
> [ 1845.210883]  ext4_sync_file+0x469/0xb60
> [ 1845.212022]  iomap_dio_complete+0x5d1/0x860
> [ 1845.213177]  ? __pfx_aio_complete_rw+0x10/0x10
> [ 1845.214315]  iomap_dio_complete_work+0x52/0x80
> [ 1845.215547]  process_one_work+0x898/0x14a0
> [ 1845.216714]  ? __pfx_lock_acquire+0x10/0x10
> [ 1845.217887]  ? __pfx_process_one_work+0x10/0x10
> [ 1845.219026]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [ 1845.220280]  worker_thread+0x100/0x12c0
> [ 1845.221386]  ? __kthread_parkme+0xc1/0x1f0
> [ 1845.222569]  ? __pfx_worker_thread+0x10/0x10
> [ 1845.223743]  kthread+0x2ea/0x3c0
> [ 1845.224788]  ? __pfx_kthread+0x10/0x10
> [ 1845.225908]  ret_from_fork+0x30/0x70
> [ 1845.226996]  ? __pfx_kthread+0x10/0x10
> [ 1845.228110]  ret_from_fork_asm+0x1b/0x30
> [ 1845.229254]  </TASK>
> [ 1845.230191] INFO: task kworker/1:3:322 blocked for more than 123 seconds.
> [ 1845.231562]       Not tainted 6.5.0-rc7 #106
> [ 1845.232622] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1845.233992] task:kworker/1:3     state:D stack:0     pid:322   ppid:2      flags:0x00004000
> [ 1845.235439] Workqueue: dio/dm-1 iomap_dio_complete_work
> [ 1845.236681] Call Trace:
> [ 1845.237629]  <TASK>
> [ 1845.238526]  __schedule+0x10ac/0x5e80
> [ 1845.239559]  ? do_raw_spin_unlock+0x54/0x1f0
> [ 1845.240622]  ? __pfx___schedule+0x10/0x10
> [ 1845.241639]  ? lock_release+0x378/0x650
> [ 1845.242650]  ? schedule+0x92/0x220
> [ 1845.243654]  ? mark_held_locks+0x96/0xe0
> [ 1845.244707]  schedule+0x133/0x220
> [ 1845.245657]  bit_wait+0x17/0xe0
> [ 1845.246631]  __wait_on_bit+0x66/0x180
> [ 1845.247601]  ? __pfx_bit_wait+0x10/0x10
> [ 1845.248630]  __inode_wait_for_writeback+0x12b/0x1b0
> [ 1845.249743]  ? __pfx___inode_wait_for_writeback+0x10/0x10
> [ 1845.250948]  ? __pfx_wake_bit_function+0x10/0x10
> [ 1845.252021]  ? find_held_lock+0x2d/0x110
> [ 1845.253043]  writeback_single_inode+0xf9/0x3f0
> [ 1845.254123]  sync_inode_metadata+0x91/0xd0
> [ 1845.255205]  ? __pfx_sync_inode_metadata+0x10/0x10
> [ 1845.256294]  ? lock_release+0x378/0x650
> [ 1845.257332]  ? file_check_and_advance_wb_err+0xb5/0x230
> [ 1845.258542]  generic_buffers_fsync_noflush+0x1bf/0x270
> [ 1845.259701]  ext4_sync_file+0x469/0xb60
> [ 1845.260765]  iomap_dio_complete+0x5d1/0x860
> [ 1845.261790]  ? __pfx_aio_complete_rw+0x10/0x10
> [ 1845.262907]  iomap_dio_complete_work+0x52/0x80
> [ 1845.263961]  process_one_work+0x898/0x14a0
> [ 1845.265025]  ? __pfx_lock_acquire+0x10/0x10
> [ 1845.266074]  ? __pfx_process_one_work+0x10/0x10
> [ 1845.267197]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [ 1845.268305]  worker_thread+0x100/0x12c0
> [ 1845.269328]  ? __kthread_parkme+0xc1/0x1f0
> [ 1845.270368]  ? __pfx_worker_thread+0x10/0x10
> [ 1845.271457]  kthread+0x2ea/0x3c0
> [ 1845.272422]  ? __pfx_kthread+0x10/0x10
> [ 1845.273443]  ret_from_fork+0x30/0x70
> [ 1845.274438]  ? __pfx_kthread+0x10/0x10
> [ 1845.275475]  ret_from_fork_asm+0x1b/0x30
> [ 1845.276555]  </TASK>
> [ 1845.277433] INFO: task kworker/u8:7:2757 blocked for more than 123 seconds.
> [ 1845.278808]       Not tainted 6.5.0-rc7 #106
> [ 1845.279897] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1845.281313] task:kworker/u8:7    state:D stack:0     pid:2757  ppid:2      flags:0x00004000
> [ 1845.282753] Workqueue: writeback wb_workfn (flush-253:1)
> [ 1845.283993] Call Trace:
> [ 1845.284945]  <TASK>
> [ 1845.285853]  __schedule+0x10ac/0x5e80
> [ 1845.286872]  ? lock_acquire+0x1b9/0x4e0
> [ 1845.287917]  ? __pfx___schedule+0x10/0x10
> [ 1845.288934]  ? __blk_flush_plug+0x27a/0x450
> [ 1845.289979]  ? inode_sleep_on_writeback+0xf4/0x160
> [ 1845.291131]  schedule+0x133/0x220
> [ 1845.292052]  inode_sleep_on_writeback+0x14e/0x160
> [ 1845.293130]  ? __pfx_inode_sleep_on_writeback+0x10/0x10
> [ 1845.294289]  ? __pfx_lock_release+0x10/0x10
> [ 1845.295362]  ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1845.296574]  ? __pfx___writeback_inodes_wb+0x10/0x10
> [ 1845.297750]  wb_writeback+0x330/0x7a0
> [ 1845.298800]  ? __pfx_wb_writeback+0x10/0x10
> [ 1845.299876]  ? get_nr_dirty_inodes+0xc7/0x170
> [ 1845.300988]  wb_workfn+0x7a1/0xcc0
> [ 1845.302019]  ? __pfx_wb_workfn+0x10/0x10
> [ 1845.303071]  ? lock_acquire+0x1b9/0x4e0
> [ 1845.304127]  ? __pfx_lock_acquire+0x10/0x10
> [ 1845.305232]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [ 1845.306341]  process_one_work+0x898/0x14a0
> [ 1845.307377]  ? __pfx_lock_acquire+0x10/0x10
> [ 1845.308410]  ? __pfx_process_one_work+0x10/0x10
> [ 1845.309551]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [ 1845.310678]  worker_thread+0x100/0x12c0
> [ 1845.311702]  ? __kthread_parkme+0xc1/0x1f0
> [ 1845.312778]  ? __pfx_worker_thread+0x10/0x10
> [ 1845.313864]  kthread+0x2ea/0x3c0
> [ 1845.314848]  ? __pfx_kthread+0x10/0x10
> [ 1845.315885]  ret_from_fork+0x30/0x70
> [ 1845.316879]  ? __pfx_kthread+0x10/0x10
> [ 1845.317885]  ret_from_fork_asm+0x1b/0x30
> [ 1845.318896]  </TASK>
> [ 1845.319767] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
> [ 1845.321587] 
>                Showing all locks held in the system:
> [ 1845.323498] 2 locks held by kworker/0:1/9:
> [ 1845.324569]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.326209]  #1: ffff888100877d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.327999] 1 lock held by rcu_tasks_kthre/13:
> [ 1845.329153]  #0: ffffffffa8c7b010 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xde0
> [ 1845.330838] 1 lock held by rcu_tasks_rude_/14:
> [ 1845.332043]  #0: ffffffffa8c7ad70 (rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xde0
> [ 1845.333713] 1 lock held by rcu_tasks_trace/15:
> [ 1845.334939]  #0: ffffffffa8c7aa70 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xde0
> [ 1845.336716] 2 locks held by kworker/1:0/25:
> [ 1845.337890]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.339639]  #1: ffff888100977d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.341440] 1 lock held by khungtaskd/43:
> [ 1845.342669]  #0: ffffffffa8c7bbe0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x51/0x340
> [ 1845.344347] 2 locks held by kworker/1:1/49:
> [ 1845.345577]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.347382]  #1: ffff88810164fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.349278] 2 locks held by kworker/0:2/74:
> [ 1845.350547]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.352400]  #1: ffff88811c8ffd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.354301] 2 locks held by kworker/3:2/169:
> [ 1845.355618]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.357472]  #1: ffff88811f0e7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.359445] 2 locks held by kworker/0:3/221:
> [ 1845.360862]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.362800]  #1: ffff888126567d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.364804] 2 locks held by kworker/1:2/230:
> [ 1845.366259]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.368270]  #1: ffff8881285f7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.370338] 2 locks held by kworker/2:3/291:
> [ 1845.371807]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.373789]  #1: ffff88812a1f7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.375949] 2 locks held by kworker/1:3/322:
> [ 1845.377464]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.379533]  #1: ffff888105a6fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.381731] 1 lock held by in:imjournal/663:
> [ 1845.383335] 2 locks held by kworker/u8:7/2757:
> [ 1845.384953]  #0: ffff888101191938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.387067]  #1: ffff88813542fd98 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.389320] 2 locks held by kworker/3:4/2759:
> [ 1845.390985]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.393164]  #1: ffff888122ddfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.395410] 2 locks held by kworker/0:4/2760:
> [ 1845.397073]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.399329]  #1: ffff888107dbfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.401670] 2 locks held by kworker/1:5/2762:
> [ 1845.403414]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.405626]  #1: ffff888105fbfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.407962] 2 locks held by kworker/1:6/2764:
> [ 1845.409693]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.411996]  #1: ffff888134647d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.414335] 2 locks held by kworker/3:5/2765:
> [ 1845.416107]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.418376]  #1: ffff888128effd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.420758] 2 locks held by kworker/1:7/2767:
> [ 1845.422532]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.424711]  #1: ffff88810fcefd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.427082] 2 locks held by kworker/1:8/2768:
> [ 1845.428790]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.431080]  #1: ffff88812a42fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.433495] 2 locks held by kworker/1:9/2770:
> [ 1845.435192]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.437507]  #1: ffff888135477d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.439982] 2 locks held by kworker/3:6/2771:
> [ 1845.441737]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.444015]  #1: ffff888127c6fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.446448] 2 locks held by kworker/3:10/2776:
> [ 1845.448255]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.450561]  #1: ffff888129fafd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.452971] 2 locks held by kworker/3:11/2777:
> [ 1845.454703]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.457029]  #1: ffff8881056b7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.459377] 2 locks held by kworker/2:8/2779:
> [ 1845.461157]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.463483]  #1: ffff88812e997d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.465906] 2 locks held by kworker/3:13/2780:
> [ 1845.467678]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.469988]  #1: ffff888128d57d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.472395] 2 locks held by kworker/3:14/2781:
> [ 1845.474175]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.476468]  #1: ffff88812c9bfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.478896] 2 locks held by kworker/3:15/2782:
> [ 1845.480638]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.482919]  #1: ffff888104f27d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.485299] 2 locks held by kworker/3:17/2784:
> [ 1845.487097]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.489383]  #1: ffff88812224fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.491737] 2 locks held by kworker/3:18/2785:
> [ 1845.493480]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.495790]  #1: ffff8881361afd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.498159] 2 locks held by kworker/3:19/2786:
> [ 1845.499941]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.502266]  #1: ffff888127e67d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.504618] 2 locks held by kworker/3:22/2790:
> [ 1845.506418]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.508708]  #1: ffff888130d4fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.511121] 2 locks held by kworker/2:10/2791:
> [ 1845.512938]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.515179]  #1: ffff888113127d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.517588] 2 locks held by kworker/3:23/2793:
> [ 1845.519372]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.521683]  #1: ffff88812a89fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.524075] 2 locks held by kworker/3:24/2794:
> [ 1845.525876]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.528115]  #1: ffff888129a1fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.530515] 2 locks held by kworker/3:25/2795:
> [ 1845.532283]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.534610]  #1: ffff88812ebb7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.537020] 2 locks held by kworker/3:26/2796:
> [ 1845.538809]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.541117]  #1: ffff888119577d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.543506] 2 locks held by kworker/1:11/2797:
> [ 1845.545286]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.547624]  #1: ffff88813716fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.550018] 2 locks held by kworker/3:27/2798:
> [ 1845.551827]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.554139]  #1: ffff888136747d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.556535] 2 locks held by kworker/1:13/2800:
> [ 1845.558325]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.560657]  #1: ffff888131687d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.563055] 2 locks held by kworker/1:15/2802:
> [ 1845.564867]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.567176]  #1: ffff8881342d7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.569574] 2 locks held by kworker/1:17/2804:
> [ 1845.571352]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.573643]  #1: ffff888132137d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.576005] 2 locks held by kworker/1:18/2805:
> [ 1845.577768]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.580107]  #1: ffff888134a5fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.582512] 2 locks held by kworker/1:19/2806:
> [ 1845.584307]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.586598]  #1: ffff888135b87d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.588971] 2 locks held by kworker/1:20/2807:
> [ 1845.590771]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.593039]  #1: ffff88810513fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.595437] 2 locks held by kworker/1:22/2809:
> [ 1845.597257]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.599584]  #1: ffff8881397bfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.601975] 2 locks held by kworker/1:23/2810:
> [ 1845.603756]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.606073]  #1: ffff888139807d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.608442] 2 locks held by kworker/3:30/2814:
> [ 1845.610262]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.612547]  #1: ffff888101a27d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.614937] 2 locks held by kworker/2:13/2815:
> [ 1845.616711]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.618912]  #1: ffff888120087d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.621317] 2 locks held by kworker/2:15/2817:
> [ 1845.623090]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.625381]  #1: ffff88812258fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.627743] 2 locks held by kworker/2:16/2818:
> [ 1845.629551]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.631844]  #1: ffff888133d47d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.634251] 2 locks held by kworker/2:19/2821:
> [ 1845.636011]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.638324]  #1: ffff88812ea37d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.640711] 2 locks held by kworker/2:20/2822:
> [ 1845.642514]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.644824]  #1: ffff88813abd7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.647217] 2 locks held by kworker/2:21/2823:
> [ 1845.649025]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.651351]  #1: ffff88813454fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.653690] 2 locks held by kworker/2:22/2824:
> [ 1845.655501]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.657763]  #1: ffff888132e5fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.660177] 2 locks held by kworker/3:31/2825:
> [ 1845.661943]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.664289]  #1: ffff888138177d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.666651] 2 locks held by kworker/3:32/2826:
> [ 1845.668418]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.670748]  #1: ffff88812a26fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.673018] 2 locks held by kworker/3:38/2832:
> [ 1845.674821]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.677132]  #1: ffff8881319b7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.679533] 2 locks held by kworker/2:24/2834:
> [ 1845.681338]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.683668]  #1: ffff8881185efd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.686081] 2 locks held by kworker/2:25/2835:
> [ 1845.687877]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.690160]  #1: ffff8881299a7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.692548] 2 locks held by kworker/2:27/2837:
> [ 1845.694316]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.696589]  #1: ffff888105ae7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.698995] 2 locks held by kworker/2:28/2838:
> [ 1845.700799]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.703139]  #1: ffff888133fd7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.705549] 2 locks held by kworker/2:30/2840:
> [ 1845.707341]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.709638]  #1: ffff888127627d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.712057] 2 locks held by kworker/2:31/2841:
> [ 1845.713853]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.716160]  #1: ffff88810a8d7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.718564] 2 locks held by kworker/2:34/2845:
> [ 1845.720341]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.722653]  #1: ffff888134107d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.725061] 2 locks held by kworker/3:40/2847:
> [ 1845.726873]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.729184]  #1: ffff88812f5cfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.731588] 2 locks held by kworker/2:36/2848:
> [ 1845.733384]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.735681]  #1: ffff8881184efd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.738077] 2 locks held by kworker/2:37/2851:
> [ 1845.739855]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.742191]  #1: ffff88813b89fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.744532] 2 locks held by kworker/1:24/2852:
> [ 1845.746338]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.748635]  #1: ffff8881275c7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.751036] 2 locks held by kworker/1:26/2854:
> [ 1845.752810]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.755139]  #1: ffff88812238fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.757498] 2 locks held by kworker/1:28/2856:
> [ 1845.759286]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.761628]  #1: ffff888122f2fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.763996] 2 locks held by kworker/1:29/2857:
> [ 1845.765766]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.768067]  #1: ffff88812215fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.770425] 2 locks held by kworker/1:30/2858:
> [ 1845.772237]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.774564]  #1: ffff888137177d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.776959] 2 locks held by kworker/1:32/2860:
> [ 1845.778767]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.781058]  #1: ffff88812a6bfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.783435] 2 locks held by kworker/1:34/2862:
> [ 1845.785261]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.787605]  #1: ffff888119487d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.790019] 2 locks held by kworker/1:35/2863:
> [ 1845.791759]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.794093]  #1: ffff888135497d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.796540] 2 locks held by kworker/1:37/2865:
> [ 1845.798278]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.800636]  #1: ffff8881053b7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.803035] 2 locks held by kworker/2:38/2866:
> [ 1845.804808]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.807150]  #1: ffff88810533fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.809571] 2 locks held by kworker/2:39/2867:
> [ 1845.811371]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.813698]  #1: ffff888119d57d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.816104] 2 locks held by kworker/2:41/2869:
> [ 1845.817858]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.820217]  #1: ffff888119d7fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.822579] 2 locks held by kworker/2:46/2874:
> [ 1845.824384]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.826691]  #1: ffff888106be7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.829051] 2 locks held by kworker/2:49/2878:
> [ 1845.830865]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.833194]  #1: ffff88813af5fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.835616] 2 locks held by kworker/2:51/2881:
> [ 1845.837390]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.839737]  #1: ffff888122957d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.842116] 2 locks held by kworker/2:52/2882:
> [ 1845.843933]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.846254]  #1: ffff888123fe7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.848710] 2 locks held by kworker/2:53/2883:
> [ 1845.850464]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.852749]  #1: ffff88812282fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.855191] 2 locks held by kworker/2:54/2884:
> [ 1845.856982]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.859288]  #1: ffff88813baffd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.861684] 2 locks held by kworker/2:55/2885:
> [ 1845.863494]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.865779]  #1: ffff888111c97d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.868184] 2 locks held by kworker/2:56/2886:
> [ 1845.869955]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.872223]  #1: ffff888111c8fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.874666] 2 locks held by kworker/1:40/2888:
> [ 1845.876443]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.878794]  #1: ffff88811b197d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.881130] 2 locks held by kworker/0:5/2889:
> [ 1845.882854]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.885148]  #1: ffff888118247d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.887535] 2 locks held by kworker/2:58/2890:
> [ 1845.889341]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.891495]  #1: ffff88810cf57d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.893905] 2 locks held by kworker/1:41/2897:
> [ 1845.895655]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.897934]  #1: ffff888137987d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.900296] 2 locks held by kworker/2:61/2898:
> [ 1845.902071]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.904422]  #1: ffff88811008fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.906816] 2 locks held by kworker/0:7/2899:
> [ 1845.908574]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.910857]  #1: ffff88810530fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.913250] 2 locks held by kworker/2:62/2900:
> [ 1845.915027]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.917326]  #1: ffff88812eccfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.919696] 2 locks held by kworker/0:8/2901:
> [ 1845.921496]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.923773]  #1: ffff888139277d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.926133] 2 locks held by kworker/0:9/2903:
> [ 1845.927908]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.930231]  #1: ffff888105f27d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.932617] 2 locks held by kworker/1:43/2905:
> [ 1845.934393]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.936659]  #1: ffff88810629fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.939044] 2 locks held by kworker/1:44/2907:
> [ 1845.940855]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.943143]  #1: ffff88811d127d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.945543] 2 locks held by kworker/0:10/2908:
> [ 1845.947309]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.949590]  #1: ffff8881361b7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.952001] 2 locks held by kworker/1:45/2909:
> [ 1845.953773]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.956004]  #1: ffff888121147d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.958426] 2 locks held by kworker/2:65/2910:
> [ 1845.960240]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.962547]  #1: ffff88810c597d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.964935] 2 locks held by kworker/1:46/2911:
> [ 1845.966701]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.968990]  #1: ffff88812b2ffd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.971313] 2 locks held by kworker/1:47/2913:
> [ 1845.973100]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.975451]  #1: ffff88813f79fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.977880] 2 locks held by kworker/0:11/2916:
> [ 1845.979682]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.981949]  #1: ffff88811d7e7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.984317] 2 locks held by kworker/2:68/2917:
> [ 1845.986087]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.988369]  #1: ffff88812c017d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.990715] 2 locks held by kworker/1:50/2920:
> [ 1845.992496]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1845.994769]  #1: ffff888123fc7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1845.997095] 2 locks held by kworker/0:12/2921:
> [ 1845.998885]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.001218]  #1: ffff8881202f7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.003603] 2 locks held by kworker/1:51/2923:
> [ 1846.005405]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.007715]  #1: ffff8881114ffd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.010124] 2 locks held by kworker/2:71/2924:
> [ 1846.011907]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.014223]  #1: ffff88812ef5fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.016615] 2 locks held by kworker/2:73/2928:
> [ 1846.018367]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.020712]  #1: ffff888117667d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.023000] 2 locks held by kworker/2:74/2931:
> [ 1846.024774]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.027108]  #1: ffff88811322fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.029466] 2 locks held by kworker/0:14/2932:
> [ 1846.031284]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.033576]  #1: ffff88810fd5fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.035945] 2 locks held by kworker/2:75/2933:
> [ 1846.037730]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.040007]  #1: ffff8881367a7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.042335] 2 locks held by kworker/0:16/2935:
> [ 1846.044121]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.046392]  #1: ffff88810c55fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.048757] 2 locks held by kworker/0:17/2937:
> [ 1846.050524]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.052871]  #1: ffff8881368a7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.055241] 2 locks held by kworker/2:77/2938:
> [ 1846.056990]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.059306]  #1: ffff888122217d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.061588] 2 locks held by kworker/2:78/2940:
> [ 1846.063332]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.065636]  #1: ffff8881212a7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.068005] 2 locks held by kworker/1:56/2941:
> [ 1846.069793]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.072091]  #1: ffff8881192efd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.074460] 2 locks held by kworker/2:79/2942:
> [ 1846.076276]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.078593]  #1: ffff88811b187d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.080997] 2 locks held by kworker/1:57/2943:
> [ 1846.082766]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.085099]  #1: ffff888139457d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.087514] 2 locks held by kworker/2:80/2944:
> [ 1846.089313]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.091623]  #1: ffff888134697d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.094002] 2 locks held by kworker/1:59/2948:
> [ 1846.095792]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.098122]  #1: ffff888107d27d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.100558] 2 locks held by kworker/2:82/2949:
> [ 1846.102361]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.104650]  #1: ffff88812810fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.107035] 2 locks held by kworker/0:19/2950:
> [ 1846.108804]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.111121]  #1: ffff8881313f7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.113499] 2 locks held by kworker/1:60/2951:
> [ 1846.115278]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.117586]  #1: ffff88810d01fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.120000] 2 locks held by kworker/2:84/2954:
> [ 1846.121772]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.124105]  #1: ffff88812618fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.126532] 2 locks held by kworker/0:21/2955:
> [ 1846.128332]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.130576]  #1: ffff888107c6fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.132910] 2 locks held by kworker/0:24/2960:
> [ 1846.134696]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.136967]  #1: ffff888100cafd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.139353] 2 locks held by kworker/0:25/2962:
> [ 1846.141106]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.143454]  #1: ffff888111267d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.145841] 2 locks held by kworker/2:88/2963:
> [ 1846.147625]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.149903]  #1: ffff888134d0fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.152280] 2 locks held by kworker/3:46/2964:
> [ 1846.154068]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.156371]  #1: ffff88810f7afd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.158751] 2 locks held by kworker/3:47/2967:
> [ 1846.160398]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.162653]  #1: ffff88813c7b7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.165045] 2 locks held by kworker/0:28/2968:
> [ 1846.166830]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.169156]  #1: ffff88812dc77d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.171558] 2 locks held by kworker/0:29/2970:
> [ 1846.173363]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.175655]  #1: ffff88812892fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.178081] 2 locks held by kworker/0:30/2971:
> [ 1846.179861]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.182198]  #1: ffff88812dfd7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.184562] 2 locks held by kworker/0:31/2973:
> [ 1846.186364]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.188663]  #1: ffff8881304ffd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.191053] 2 locks held by kworker/3:50/2974:
> [ 1846.192850]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.195153]  #1: ffff88811fa6fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.197534] 2 locks held by kworker/3:51/2975:
> [ 1846.199290]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.201640]  #1: ffff888130c0fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.204059] 2 locks held by kworker/2:90/2978:
> [ 1846.205833]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.208134]  #1: ffff888138457d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.210548] 2 locks held by kworker/2:94/2983:
> [ 1846.212355]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.214684]  #1: ffff88813c5b7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.217078] 2 locks held by kworker/0:33/2984:
> [ 1846.218870]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.221180]  #1: ffff888118337d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.223616] 2 locks held by kworker/0:34/2987:
> [ 1846.225402]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.227712]  #1: ffff88812b827d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.230049] 2 locks held by kworker/0:35/2988:
> [ 1846.231865]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.234180]  #1: ffff88811761fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.236603] 2 locks held by kworker/0:36/2990:
> [ 1846.238405]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.240743]  #1: ffff88813a327d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.243154] 2 locks held by kworker/3:54/2991:
> [ 1846.244944]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.247254]  #1: ffff88813a32fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.249661] 2 locks held by kworker/2:96/2992:
> [ 1846.251415]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.253744]  #1: ffff88813a5cfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.256072] 2 locks held by kworker/1:62/2993:
> [ 1846.257867]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.260131]  #1: ffff88810f7c7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.262502] 2 locks held by kworker/2:98/2996:
> [ 1846.264306]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.266598]  #1: ffff88813544fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.268989] 2 locks held by kworker/1:64/2997:
> [ 1846.270789]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.273098]  #1: ffff88810f497d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.275485] 2 locks held by kworker/2:102/3001:
> [ 1846.277249]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.279558]  #1: ffff888107d37d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.281985] 2 locks held by kworker/0:38/3004:
> [ 1846.283756]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.286069]  #1: ffff88812db1fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.288455] 2 locks held by kworker/0:39/3006:
> [ 1846.290218]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.292529]  #1: ffff88812b847d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.294939] 2 locks held by kworker/2:105/3007:
> [ 1846.296685]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.299010]  #1: ffff888135e37d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.301429] 2 locks held by kworker/0:40/3008:
> [ 1846.303243]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.305566]  #1: ffff888112cffd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.307892] 2 locks held by kworker/2:107/3011:
> [ 1846.309698]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.312023]  #1: ffff88812e577d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.314422] 2 locks held by kworker/2:108/3013:
> [ 1846.316249]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.318523]  #1: ffff88812183fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.320928] 2 locks held by kworker/0:43/3014:
> [ 1846.322729]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.325007]  #1: ffff88813b8f7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.327362] 2 locks held by kworker/1:65/3015:
> [ 1846.329133]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.331460]  #1: ffff8881230efd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.333826] 2 locks held by kworker/0:44/3016:
> [ 1846.335617]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.337933]  #1: ffff888134f77d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.340294] 2 locks held by kworker/2:110/3019:
> [ 1846.342063]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.344356]  #1: ffff888123877d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.346708] 2 locks held by kworker/2:111/3021:
> [ 1846.348463]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.350711]  #1: ffff88811b93fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.353066] 2 locks held by kworker/0:48/3024:
> [ 1846.354871]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.357159]  #1: ffff88812500fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.359565] 2 locks held by kworker/0:49/3026:
> [ 1846.361326]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.363655]  #1: ffff8881184a7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.366021] 2 locks held by kworker/0:50/3027:
> [ 1846.367802]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.370043]  #1: ffff8881184afd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.372410] 2 locks held by kworker/1:66/3028:
> [ 1846.374214]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.376522]  #1: ffff88813478fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.378915] 2 locks held by kworker/1:67/3029:
> [ 1846.380682]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.383009]  #1: ffff8881216e7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.385428] 2 locks held by kworker/1:72/3034:
> [ 1846.387211]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.389542]  #1: ffff88812bdd7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.391894] 2 locks held by kworker/1:73/3035:
> [ 1846.393613]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.395947]  #1: ffff88812bddfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.398383] 2 locks held by kworker/1:74/3036:
> [ 1846.400150]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.402449]  #1: ffff88811c49fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.404851] 2 locks held by kworker/1:75/3037:
> [ 1846.406632]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.408913]  #1: ffff888111587d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.411257] 2 locks held by kworker/1:77/3039:
> [ 1846.413046]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.415323]  #1: ffff88811157fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.417715] 2 locks held by kworker/1:79/3042:
> [ 1846.419479]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.421757]  #1: ffff888126f77d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.424093] 2 locks held by kworker/1:80/3043:
> [ 1846.425872]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.428177]  #1: ffff888126f7fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.430604] 2 locks held by kworker/1:82/3046:
> [ 1846.432382]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.434722]  #1: ffff88811b027d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.437127] 2 locks held by kworker/2:116/3052:
> [ 1846.438947]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.441264]  #1: ffff888138e4fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.443697] 2 locks held by kworker/2:118/3054:
> [ 1846.445508]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.447719]  #1: ffff88813ecc7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.450101] 2 locks held by kworker/2:120/3056:
> [ 1846.451878]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.454210]  #1: ffff88813ecdfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.456602] 2 locks held by kworker/2:122/3058:
> [ 1846.458392]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.460678]  #1: ffff88811c597d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.463034] 2 locks held by kworker/2:123/3059:
> [ 1846.464820]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.467113]  #1: ffff88811c59fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.469512] 2 locks held by kworker/2:125/3061:
> [ 1846.471288]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.473547]  #1: ffff88811c47fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.475876] 2 locks held by kworker/2:127/3063:
> [ 1846.477645]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.479943]  #1: ffff88812fbf7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.482357] 2 locks held by kworker/2:128/3064:
> [ 1846.484135]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.486426]  #1: ffff88810f5a7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.488860] 2 locks held by kworker/2:131/3067:
> [ 1846.490666]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.492903]  #1: ffff88811f307d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.495335] 2 locks held by kworker/2:133/3069:
> [ 1846.497155]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.499482]  #1: ffff888130447d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.501832] 2 locks held by kworker/2:134/3070:
> [ 1846.503601]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.505908]  #1: ffff888130457d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.508286] 2 locks held by kworker/2:141/3077:
> [ 1846.510081]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.512419]  #1: ffff88813d78fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.514763] 2 locks held by kworker/0:55/3078:
> [ 1846.516571]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.518869]  #1: ffff88813d79fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.521270] 2 locks held by kworker/0:56/3080:
> [ 1846.523060]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.525405]  #1: ffff8881252f7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.527817] 2 locks held by kworker/0:58/3082:
> [ 1846.529590]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.531794]  #1: ffff888110d6fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.534196] 2 locks held by kworker/0:59/3083:
> [ 1846.535999]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.538293]  #1: ffff888110d77d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.540713] 2 locks held by kworker/0:60/3084:
> [ 1846.542437]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.544711]  #1: ffff888119c07d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.547111] 2 locks held by kworker/0:62/3086:
> [ 1846.548917]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.551264]  #1: ffff88811464fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.553629] 2 locks held by kworker/0:64/3088:
> [ 1846.555433]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.557729]  #1: ffff88813ee47d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.560105] 2 locks held by kworker/0:65/3089:
> [ 1846.561924]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.564227]  #1: ffff88813ee4fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.566623] 2 locks held by kworker/0:66/3090:
> [ 1846.568414]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.570750]  #1: ffff88813ee5fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.573183] 2 locks held by kworker/0:68/3092:
> [ 1846.574932]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.577277]  #1: ffff8881169b7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.579664] 2 locks held by kworker/0:69/3093:
> [ 1846.581445]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.583780]  #1: ffff8881169bfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.586161] 2 locks held by kworker/0:73/3097:
> [ 1846.587954]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.590274]  #1: ffff88811632fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.592663] 2 locks held by kworker/0:74/3098:
> [ 1846.594470]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.596751]  #1: ffff88811633fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.599107] 2 locks held by kworker/0:76/3100:
> [ 1846.600881]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.603217]  #1: ffff8881169dfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.605601] 2 locks held by kworker/0:77/3101:
> [ 1846.607402]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.609573]  #1: ffff8881169e7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.611971] 2 locks held by kworker/0:78/3102:
> [ 1846.613730]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.616042]  #1: ffff8881169f7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.618444] 2 locks held by kworker/0:79/3103:
> [ 1846.620254]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.622558]  #1: ffff8881169ffd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.624952] 2 locks held by kworker/0:80/3104:
> [ 1846.626680]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.628957]  #1: ffff888113257d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.631318] 2 locks held by kworker/0:82/3106:
> [ 1846.633132]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.635458]  #1: ffff88811326fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.637825] 2 locks held by kworker/2:143/3107:
> [ 1846.639535]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.641623]  #1: ffff888113277d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.643714] 2 locks held by kworker/0:83/3108:
> [ 1846.645345]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.647378]  #1: ffff888116747d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.649476] 2 locks held by kworker/0:85/3110:
> [ 1846.651108]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.653157]  #1: ffff88811675fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.655265] 2 locks held by kworker/2:145/3115:
> [ 1846.656907]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.658943]  #1: ffff88811681fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.661043] 2 locks held by kworker/0:88/3116:
> [ 1846.662672]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.664700]  #1: ffff88811682fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.666800] 2 locks held by kworker/0:89/3117:
> [ 1846.668428]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.670467]  #1: ffff888116837d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.672564] 2 locks held by kworker/0:90/3118:
> [ 1846.674191]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.676231]  #1: ffff888116847d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.678334] 2 locks held by kworker/0:91/3119:
> [ 1846.679962]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.682000]  #1: ffff88811684fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.684357] 2 locks held by kworker/0:94/3122:
> [ 1846.686158]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.688463]  #1: ffff88811687fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.690827] 2 locks held by kworker/0:96/3124:
> [ 1846.692624]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.694930]  #1: ffff888116797d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.697350] 2 locks held by kworker/0:97/3125:
> [ 1846.699168]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.701468]  #1: ffff8881167a7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.703838] 2 locks held by kworker/3:55/3126:
> [ 1846.705562]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.707872]  #1: ffff8881167efd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.710221] 2 locks held by kworker/3:57/3129:
> [ 1846.712016]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.714368]  #1: ffff88810f7efd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.716772] 2 locks held by kworker/2:147/3130:
> [ 1846.718550]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.720798]  #1: ffff888130f3fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.723151] 2 locks held by kworker/3:58/3131:
> [ 1846.724961]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.727251]  #1: ffff88813387fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.729629] 2 locks held by kworker/3:60/3136:
> [ 1846.731377]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.733722]  #1: ffff88811cac7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.736070] 2 locks held by kworker/2:151/3137:
> [ 1846.737871]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.740181]  #1: ffff888119a2fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.742605] 2 locks held by kworker/3:61/3138:
> [ 1846.744409]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.746708]  #1: ffff888132bbfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.749059] 2 locks held by kworker/3:62/3141:
> [ 1846.750851]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.753065]  #1: ffff8881378dfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.755504] 2 locks held by kworker/2:155/3144:
> [ 1846.757284]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.759575]  #1: ffff888118bffd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.761933] 2 locks held by kworker/2:157/3147:
> [ 1846.763742]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.766062]  #1: ffff88812f4c7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.768433] 2 locks held by kworker/3:66/3150:
> [ 1846.770245]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.772589]  #1: ffff88812c59fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.774922] 2 locks held by kworker/2:159/3151:
> [ 1846.776705]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.778997]  #1: ffff888128447d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.781418] 2 locks held by kworker/3:67/3152:
> [ 1846.783229]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.785552]  #1: ffff8881010c7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.787935] 2 locks held by kworker/2:160/3153:
> [ 1846.789731]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.791997]  #1: ffff88811b8dfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.794398] 2 locks held by kworker/3:68/3154:
> [ 1846.796217]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.798461]  #1: ffff8881230c7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.800827] 2 locks held by kworker/3:69/3156:
> [ 1846.802626]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.804880]  #1: ffff88811a5afd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.807294] 2 locks held by kworker/2:162/3157:
> [ 1846.809032]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.811342]  #1: ffff888123e27d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.813731] 2 locks held by kworker/3:70/3158:
> [ 1846.815471]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.817704]  #1: ffff888119967d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.820099] 2 locks held by kworker/2:163/3159:
> [ 1846.821912]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.824259]  #1: ffff88812eb17d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.826658] 2 locks held by kworker/3:72/3162:
> [ 1846.828445]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.830737]  #1: ffff88812b71fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.833091] 2 locks held by kworker/3:73/3164:
> [ 1846.834905]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.837180]  #1: ffff8881236cfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.839547] 2 locks held by kworker/2:166/3165:
> [ 1846.841359]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.843683]  #1: ffff888127ce7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.846077] 2 locks held by kworker/2:167/3166:
> [ 1846.847874]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.850188]  #1: ffff888130f5fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.852581] 2 locks held by kworker/3:74/3167:
> [ 1846.854381]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.856638]  #1: ffff88812a03fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.858994] 2 locks held by kworker/2:168/3168:
> [ 1846.860803]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.863125]  #1: ffff888118547d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.865502] 2 locks held by kworker/3:76/3170:
> [ 1846.867274]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.869590]  #1: ffff8881290efd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.871966] 2 locks held by kworker/2:169/3171:
> [ 1846.873759]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.876067]  #1: ffff888113537d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.878500] 2 locks held by kworker/2:170/3172:
> [ 1846.880241]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.882550]  #1: ffff88812800fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.884923] 2 locks held by kworker/2:171/3174:
> [ 1846.886717]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.888964]  #1: ffff88810b7afd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.891342] 2 locks held by kworker/3:78/3175:
> [ 1846.893152]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.895444]  #1: ffff88810b7cfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.897839] 2 locks held by kworker/2:173/3178:
> [ 1846.899645]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.901930]  #1: ffff88813824fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.904368] 2 locks held by kworker/2:174/3180:
> [ 1846.906166]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.908487]  #1: ffff88811fbffd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.910889] 2 locks held by kworker/2:175/3181:
> [ 1846.912677]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.914993]  #1: ffff88810d657d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.917381] 2 locks held by kworker/2:176/3183:
> [ 1846.919126]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.921418]  #1: ffff88812cd0fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.923802] 2 locks held by kworker/0:99/3184:
> [ 1846.925561]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.927875]  #1: ffff888129a8fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.930261] 2 locks held by kworker/0:101/3188:
> [ 1846.932086]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.934427]  #1: ffff888122d0fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.936855] 2 locks held by kworker/0:102/3189:
> [ 1846.938637]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.940957]  #1: ffff888135087d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.943360] 2 locks held by kworker/2:179/3190:
> [ 1846.945154]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.947422]  #1: ffff88812db5fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.949816] 2 locks held by kworker/2:180/3192:
> [ 1846.951610]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.953888]  #1: ffff888135c2fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.956310] 2 locks held by kworker/2:181/3194:
> [ 1846.958131]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.960429]  #1: ffff88811e607d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.962842] 2 locks held by kworker/0:105/3195:
> [ 1846.964653]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.966944]  #1: ffff88810786fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.969357] 2 locks held by kworker/2:182/3196:
> [ 1846.971031]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.973347]  #1: ffff88810b6dfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.975722] 2 locks held by kworker/0:106/3197:
> [ 1846.977477]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.979799]  #1: ffff888133eb7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.982180] 2 locks held by kworker/2:183/3198:
> [ 1846.983956]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.986282]  #1: ffff88810fd4fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.988625] 2 locks held by kworker/2:184/3200:
> [ 1846.990385]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.992687]  #1: ffff88811d3bfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1846.995091] 2 locks held by kworker/0:108/3201:
> [ 1846.996880]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1846.999212]  #1: ffff8881194f7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.001610] 2 locks held by kworker/2:185/3202:
> [ 1847.003419]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.005697]  #1: ffff88812201fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.008064] 2 locks held by kworker/0:109/3203:
> [ 1847.009833]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.012147]  #1: ffff88812360fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.014580] 2 locks held by kworker/0:110/3205:
> [ 1847.016323]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.018596]  #1: ffff88812dbffd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.020968] 2 locks held by kworker/0:111/3206:
> [ 1847.022748]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.025005]  #1: ffff888121917d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.027404] 2 locks held by kworker/0:113/3208:
> [ 1847.029168]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.031487]  #1: ffff888125257d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.033927] 2 locks held by kworker/0:114/3209:
> [ 1847.035695]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.037924]  #1: ffff888117cffd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.040327] 2 locks held by kworker/0:115/3210:
> [ 1847.042093]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.044392]  #1: ffff88813ee97d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.046790] 2 locks held by kworker/3:84/3214:
> [ 1847.048447]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.050752]  #1: ffff88811624fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.053143] 2 locks held by kworker/3:85/3215:
> [ 1847.054922]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.057177]  #1: ffff88811625fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.059600] 2 locks held by kworker/3:86/3216:
> [ 1847.061342]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.063655]  #1: ffff888116267d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.066031] 2 locks held by kworker/3:87/3217:
> [ 1847.067846]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.070173]  #1: ffff888116277d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.072605] 2 locks held by kworker/3:88/3218:
> [ 1847.074322]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.076675]  #1: ffff88811627fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.079050] 2 locks held by kworker/3:90/3220:
> [ 1847.080866]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.083139]  #1: ffff88811629fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.085557] 2 locks held by kworker/0:116/3224:
> [ 1847.087325]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.089540]  #1: ffff8881162cfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.091896] 2 locks held by kworker/0:117/3225:
> [ 1847.093708]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.095968]  #1: ffff8881162dfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.098385] 2 locks held by kworker/0:120/3228:
> [ 1847.100165]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.102497]  #1: ffff8881162ffd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.104912] 2 locks held by kworker/0:122/3230:
> [ 1847.106730]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.109025]  #1: ffff888116617d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.111433] 2 locks held by kworker/0:124/3232:
> [ 1847.113261]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.115545]  #1: ffff888116637d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.117891] 2 locks held by kworker/0:125/3233:
> [ 1847.119688]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.121958]  #1: ffff88811664fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.124367] 2 locks held by kworker/0:126/3234:
> [ 1847.126165]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.128485]  #1: ffff888116657d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.130883] 2 locks held by kworker/0:127/3235:
> [ 1847.132680]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.134962]  #1: ffff888116667d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.137353] 2 locks held by kworker/0:128/3236:
> [ 1847.139112]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.141422]  #1: ffff88811666fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.143839] 2 locks held by kworker/0:129/3237:
> [ 1847.145625]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.147894]  #1: ffff88811667fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.150250] 2 locks held by kworker/0:130/3238:
> [ 1847.152017]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.154368]  #1: ffff888116687d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.156773] 2 locks held by kworker/0:135/3243:
> [ 1847.158555]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.160730]  #1: ffff8881166c7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.163142] 2 locks held by kworker/0:136/3244:
> [ 1847.164910]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.167258]  #1: ffff8881166cfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.169669] 2 locks held by kworker/3:95/3246:
> [ 1847.171438]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.173713]  #1: ffff8881166efd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.176070] 2 locks held by kworker/3:97/3248:
> [ 1847.177888]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.180173]  #1: ffff88813ef07d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.182623] 2 locks held by kworker/0:137/3249:
> [ 1847.184437]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.186710]  #1: ffff88813ef1fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.189078] 2 locks held by kworker/3:99/3251:
> [ 1847.190888]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.193149]  #1: ffff88813ef37d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.195552] 2 locks held by kworker/3:102/3254:
> [ 1847.197351]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.199679]  #1: ffff88813ef57d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.202095] 2 locks held by kworker/3:104/3256:
> [ 1847.203830]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.206136]  #1: ffff88813ef6fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.208511] 2 locks held by kworker/3:107/3259:
> [ 1847.210327]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.212667]  #1: ffff88813ef9fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.215030] 2 locks held by kworker/3:109/3261:
> [ 1847.216850]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.219130]  #1: ffff88813efb7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.221522] 2 locks held by kworker/3:110/3262:
> [ 1847.223298]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.225646]  #1: ffff88813efbfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.227959] 2 locks held by kworker/3:112/3264:
> [ 1847.229749]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.232022]  #1: ffff88811600fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.234410] 2 locks held by kworker/1:85/3265:
> [ 1847.236204]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.238532]  #1: ffff88811601fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.240856] 2 locks held by kworker/1:86/3266:
> [ 1847.242656]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.244925]  #1: ffff888116027d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.247269] 2 locks held by kworker/1:87/3267:
> [ 1847.249067]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.251384]  #1: ffff88811607fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.253760] 2 locks held by kworker/1:88/3268:
> [ 1847.255546]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.257786]  #1: ffff888116087d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.260211] 2 locks held by kworker/1:89/3269:
> [ 1847.262017]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.264285]  #1: ffff888116097d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.266675] 2 locks held by kworker/0:138/3270:
> [ 1847.268432]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.270712]  #1: ffff8881393cfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.273097] 2 locks held by kworker/0:139/3272:
> [ 1847.274906]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.277199]  #1: ffff8881160e7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.279629] 2 locks held by kworker/1:91/3273:
> [ 1847.281402]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.283688]  #1: ffff8881160f7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.286055] 2 locks held by kworker/1:92/3275:
> [ 1847.287859]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.290142]  #1: ffff88811610fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.292499] 2 locks held by kworker/1:93/3277:
> [ 1847.294276]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.296572]  #1: ffff888116167d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.298959] 2 locks held by kworker/0:143/3280:
> [ 1847.300741]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.303053]  #1: ffff88811618fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.305458] 2 locks held by kworker/0:144/3282:
> [ 1847.307260]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.309562]  #1: ffff8881161a7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.311971] 2 locks held by kworker/1:99/3289:
> [ 1847.313761]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.316077]  #1: ffff888116407d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.318447] 2 locks held by kworker/1:100/3291:
> [ 1847.320274]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.322556]  #1: ffff88811641fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.324976] 2 locks held by kworker/0:149/3292:
> [ 1847.326775]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.329064]  #1: ffff88811642fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.331461] 2 locks held by kworker/0:150/3294:
> [ 1847.333272]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.335568]  #1: ffff888116447d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.337986] 2 locks held by kworker/1:102/3295:
> [ 1847.339772]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.342014]  #1: ffff88811644fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.344402] 2 locks held by kworker/0:151/3296:
> [ 1847.346193]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.348481]  #1: ffff88811645fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.350902] 2 locks held by kworker/1:103/3297:
> [ 1847.352678]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.354987]  #1: ffff888116467d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.357395] 2 locks held by kworker/0:152/3298:
> [ 1847.359178]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.361441]  #1: ffff8881164afd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.363841] 2 locks held by kworker/1:104/3299:
> [ 1847.365642]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.367965]  #1: ffff8881164bfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.370355] 2 locks held by kworker/0:154/3301:
> [ 1847.372178]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.374487]  #1: ffff8881164d7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.376872] 2 locks held by kworker/0:155/3302:
> [ 1847.378658]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.380974]  #1: ffff8881164e7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.383376] 2 locks held by kworker/0:156/3303:
> [ 1847.385153]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.387476]  #1: ffff8881164efd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.389924] 2 locks held by kworker/0:157/3304:
> [ 1847.391724]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.394012]  #1: ffff888116507d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.396410] 2 locks held by kworker/0:158/3306:
> [ 1847.398175]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.400498]  #1: ffff888124897d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.402864] 2 locks held by kworker/2:188/3307:
> [ 1847.404675]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.406978]  #1: ffff88811f0afd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.409328] 2 locks held by kworker/0:159/3310:
> [ 1847.411083]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.413366]  #1: ffff888129117d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.415716] 2 locks held by kworker/0:160/3312:
> [ 1847.417507]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.419764]  #1: ffff888105837d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.422101] 2 locks held by kworker/0:161/3314:
> [ 1847.423922]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.426202]  #1: ffff88813d44fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.428598] 2 locks held by kworker/0:162/3316:
> [ 1847.430401]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.432698]  #1: ffff888121b37d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.435047] 2 locks held by kworker/2:194/3317:
> [ 1847.436834]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.439139]  #1: ffff88812ba5fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.441506] 2 locks held by kworker/0:163/3318:
> [ 1847.443320]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.445432]  #1: ffff88812923fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.447767] 2 locks held by kworker/2:197/3321:
> [ 1847.449571]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.451878]  #1: ffff88811ea3fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.454252] 2 locks held by kworker/2:199/3323:
> [ 1847.456041]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.458354]  #1: ffff888113057d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.460746] 2 locks held by kworker/2:202/3326:
> [ 1847.462556]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.464785]  #1: ffff8881330b7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.467097] 2 locks held by kworker/3:113/3328:
> [ 1847.468870]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.471219]  #1: ffff888122eb7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.473651] 2 locks held by kworker/1:105/3329:
> [ 1847.475411]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.477759]  #1: ffff888127057d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.480120] 2 locks held by kworker/2:204/3331:
> [ 1847.481886]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.484226]  #1: ffff888117757d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.486641] 2 locks held by kworker/2:206/3333:
> [ 1847.488454]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.490716]  #1: ffff88812be7fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.493118] 2 locks held by kworker/2:209/3336:
> [ 1847.494924]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.497212]  #1: ffff88811778fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.499623] 2 locks held by kworker/2:210/3337:
> [ 1847.501424]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.503699]  #1: ffff8881304efd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.506080] 2 locks held by kworker/2:213/3340:
> [ 1847.507880]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.510224]  #1: ffff88811ffbfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.512684] 2 locks held by kworker/2:220/3347:
> [ 1847.514454]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.516795]  #1: ffff8881165c7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.519190] 2 locks held by kworker/1:106/3348:
> [ 1847.520945]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.523275]  #1: ffff8881165cfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.525698] 2 locks held by kworker/1:108/3350:
> [ 1847.527508]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.529801]  #1: ffff8881165e7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.532214] 2 locks held by kworker/1:109/3351:
> [ 1847.534035]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.536369]  #1: ffff8881165f7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.538787] 2 locks held by kworker/1:110/3352:
> [ 1847.540550]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.542874]  #1: ffff888116a37d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.545280] 2 locks held by kworker/1:111/3353:
> [ 1847.547082]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.549357]  #1: ffff888116a47d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.551733] 2 locks held by kworker/1:112/3354:
> [ 1847.553531]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.555790]  #1: ffff888116a4fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.558151] 2 locks held by kworker/1:114/3356:
> [ 1847.559954]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.562196]  #1: ffff888116a6fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.564639] 2 locks held by kworker/1:115/3357:
> [ 1847.566434]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.568712]  #1: ffff888116a7fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.571103] 2 locks held by kworker/1:116/3358:
> [ 1847.572922]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.575204]  #1: ffff888116a87d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.577562] 2 locks held by kworker/1:117/3359:
> [ 1847.579381]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.581713]  #1: ffff888116a9fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.584083] 2 locks held by kworker/1:119/3361:
> [ 1847.585908]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.588165]  #1: ffff888116ab7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.590577] 2 locks held by kworker/1:120/3362:
> [ 1847.592382]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.594688]  #1: ffff888116abfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.597066] 2 locks held by kworker/1:121/3363:
> [ 1847.598848]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.601147]  #1: ffff888116acfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.603549] 2 locks held by kworker/1:123/3365:
> [ 1847.605340]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.607647]  #1: ffff888116ae7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.610047] 2 locks held by kworker/1:124/3366:
> [ 1847.611864]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.614188]  #1: ffff888116aefd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.616565] 2 locks held by kworker/1:125/3367:
> [ 1847.618340]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.620638]  #1: ffff888116affd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.623046] 2 locks held by kworker/1:126/3368:
> [ 1847.624844]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.627133]  #1: ffff888116b07d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.629539] 2 locks held by kworker/1:127/3369:
> [ 1847.631330]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.633633]  #1: ffff888116b17d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.636059] 2 locks held by kworker/1:129/3371:
> [ 1847.637882]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.640201]  #1: ffff888116b2fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.642586] 2 locks held by kworker/1:130/3372:
> [ 1847.644401]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.646695]  #1: ffff888116b3fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.649024] 2 locks held by kworker/1:132/3374:
> [ 1847.650768]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.653070]  #1: ffff888116b5fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.655470] 2 locks held by kworker/1:134/3376:
> [ 1847.657301]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.659606]  #1: ffff888116b77d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.661962] 2 locks held by kworker/1:135/3377:
> [ 1847.663777]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.666019]  #1: ffff888116b87d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.668437] 2 locks held by kworker/1:136/3378:
> [ 1847.670250]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.672595]  #1: ffff888116b8fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.674955] 2 locks held by kworker/1:137/3379:
> [ 1847.676736]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.678987]  #1: ffff888116b9fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.681417] 2 locks held by kworker/1:138/3380:
> [ 1847.683182]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.685500]  #1: ffff888116ba7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.687873] 2 locks held by kworker/1:141/3383:
> [ 1847.689653]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.691934]  #1: ffff888116bcfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.694359] 2 locks held by kworker/1:143/3385:
> [ 1847.696172]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.698478]  #1: ffff888116befd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.700903] 2 locks held by kworker/1:144/3386:
> [ 1847.702685]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.704954]  #1: ffff888116bf7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.707320] 2 locks held by kworker/1:146/3388:
> [ 1847.709107]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.711342]  #1: ffff88813e40fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.713773] 2 locks held by kworker/1:147/3389:
> [ 1847.715521]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.717823]  #1: ffff88813e41fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.720135] 2 locks held by kworker/2:226/3395:
> [ 1847.721952]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.724259]  #1: ffff88813e46fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.726683] 2 locks held by kworker/2:230/3399:
> [ 1847.728488]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.730738]  #1: ffff88813e4a7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.733151] 2 locks held by kworker/2:235/3404:
> [ 1847.734971]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.737282]  #1: ffff88813e4dfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.739700] 2 locks held by kworker/2:237/3406:
> [ 1847.741471]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.743751]  #1: ffff88813e4f7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.746141] 2 locks held by kworker/2:238/3407:
> [ 1847.747934]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.750210]  #1: ffff88813e507d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.752594] 2 locks held by kworker/2:240/3409:
> [ 1847.754389]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.756657]  #1: ffff88813e51fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.759038] 2 locks held by kworker/0:165/3410:
> [ 1847.760840]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.763088]  #1: ffff88813e52fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.765501] 2 locks held by kworker/0:166/3411:
> [ 1847.767292]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.769539]  #1: ffff88813e587d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.771912] 2 locks held by kworker/0:167/3412:
> [ 1847.773703]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.775930]  #1: ffff88813e58fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.778359] 2 locks held by kworker/0:170/3415:
> [ 1847.780177]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.782469]  #1: ffff88813e5b7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.784868] 2 locks held by kworker/0:171/3416:
> [ 1847.786668]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.788962]  #1: ffff88813e5bfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.791373] 2 locks held by kworker/0:172/3417:
> [ 1847.793191]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.795535]  #1: ffff88813e5cfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.797917] 2 locks held by kworker/0:173/3418:
> [ 1847.799712]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.802009]  #1: ffff88813e5d7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.804327] 2 locks held by kworker/0:174/3419:
> [ 1847.806122]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.808399]  #1: ffff88813e5e7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.810832] 2 locks held by kworker/0:175/3420:
> [ 1847.812621]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.814863]  #1: ffff88813e5efd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.817249] 2 locks held by kworker/0:177/3422:
> [ 1847.819043]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.821388]  #1: ffff88813e607d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.823768] 2 locks held by kworker/0:181/3426:
> [ 1847.825577]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.827834]  #1: ffff88811e057d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.830158] 2 locks held by kworker/0:184/3429:
> [ 1847.831957]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.834282]  #1: ffff88811d1bfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.836701] 2 locks held by kworker/2:241/3430:
> [ 1847.838428]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.840701]  #1: ffff88813b6efd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.843032] 2 locks held by kworker/2:242/3431:
> [ 1847.844838]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.847128]  #1: ffff888138427d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.849525] 2 locks held by kworker/2:245/3434:
> [ 1847.851328]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.853618]  #1: ffff88813e617d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.856041] 2 locks held by kworker/2:250/3439:
> [ 1847.857842]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.860122]  #1: ffff88813e657d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.862556] 2 locks held by kworker/2:251/3440:
> [ 1847.864373]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.866672]  #1: ffff88813e667d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.869094] 2 locks held by kworker/2:253/3442:
> [ 1847.870890]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.873154]  #1: ffff88813e67fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.875581] 2 locks held by kworker/3:114/3447:
> [ 1847.877394]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.879740]  #1: ffff88813e6b7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.882098] 2 locks held by kworker/3:115/3448:
> [ 1847.883918]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.886171]  #1: ffff88813e6c7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.888583] 2 locks held by kworker/3:116/3449:
> [ 1847.890398]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.892705]  #1: ffff88813e747d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.895051] 2 locks held by kworker/3:118/3451:
> [ 1847.896847]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.899132]  #1: ffff88813e767d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.901507] 2 locks held by kworker/3:120/3453:
> [ 1847.903236]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.905527]  #1: ffff88813e77fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.907901] 2 locks held by kworker/3:122/3455:
> [ 1847.909708]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.912026]  #1: ffff88813e797d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.914454] 2 locks held by kworker/3:124/3457:
> [ 1847.916231]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.918510]  #1: ffff88813e7afd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.920927] 2 locks held by kworker/3:125/3458:
> [ 1847.922695]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.925008]  #1: ffff88813e7bfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.927436] 2 locks held by kworker/3:128/3461:
> [ 1847.929255]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.931546]  #1: ffff88813e7dfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.933891] 2 locks held by kworker/3:131/3464:
> [ 1847.935689]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.937985]  #1: ffff88813e047d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.940359] 2 locks held by kworker/0:186/3467:
> [ 1847.942142]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.944467]  #1: ffff88813e06fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.946777] 2 locks held by kworker/0:188/3469:
> [ 1847.948559]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.950874]  #1: ffff88813e087d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.953271] 2 locks held by kworker/0:189/3470:
> [ 1847.955060]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.957359]  #1: ffff88813e097d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.959762] 2 locks held by kworker/0:191/3472:
> [ 1847.961559]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.963833]  #1: ffff88813e0afd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.966201] 2 locks held by kworker/0:192/3473:
> [ 1847.967990]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.970260]  #1: ffff88813e0b7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.972661] 2 locks held by kworker/0:193/3474:
> [ 1847.974439]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.976762]  #1: ffff88813e0c7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.979010] 2 locks held by kworker/0:195/3476:
> [ 1847.980748]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.983039]  #1: ffff88813e0e7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.985423] 2 locks held by kworker/0:197/3478:
> [ 1847.987205]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.989489]  #1: ffff88813e0ffd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.991878] 2 locks held by kworker/0:198/3479:
> [ 1847.993608]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1847.995881]  #1: ffff88813e13fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1847.998236] 2 locks held by kworker/0:199/3480:
> [ 1848.000010]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.002319]  #1: ffff88813e14fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.004719] 2 locks held by kworker/0:200/3481:
> [ 1848.006525]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.008835]  #1: ffff88813e157d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.011188] 2 locks held by kworker/0:203/3484:
> [ 1848.012969]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.015327]  #1: ffff88813e17fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.017729] 2 locks held by kworker/0:205/3486:
> [ 1848.019539]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.021850]  #1: ffff88813e19fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.024275] 2 locks held by kworker/0:206/3487:
> [ 1848.026073]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.028400]  #1: ffff88813e1a7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.030781] 2 locks held by kworker/0:207/3488:
> [ 1848.032591]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.034794]  #1: ffff88813e1b7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.037098] 2 locks held by kworker/0:208/3489:
> [ 1848.038870]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.041174]  #1: ffff88813e1c7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.043556] 2 locks held by kworker/0:209/3490:
> [ 1848.045370]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.047648]  #1: ffff88813e1d7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.050062] 2 locks held by kworker/0:211/3492:
> [ 1848.051827]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.054123]  #1: ffff88813e227d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.056524] 2 locks held by kworker/0:215/3496:
> [ 1848.058345]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.060635]  #1: ffff88813e257d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.063063] 2 locks held by kworker/0:219/3500:
> [ 1848.064887]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.067150]  #1: ffff88813e287d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.069530] 2 locks held by kworker/0:220/3501:
> [ 1848.071321]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.073575]  #1: ffff88813e28fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.075995] 2 locks held by kworker/0:221/3502:
> [ 1848.077815]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.080025]  #1: ffff8881348afd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.082419] 2 locks held by kworker/0:222/3503:
> [ 1848.084240]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.086510]  #1: ffff88812e54fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.088878] 2 locks held by kworker/0:224/3505:
> [ 1848.090652]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.092903]  #1: ffff888126f0fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.095228] 2 locks held by kworker/3:133/3506:
> [ 1848.097027]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.099344]  #1: ffff88813c507d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.101705] 2 locks held by kworker/0:225/3507:
> [ 1848.103476]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.105768]  #1: ffff88811f2d7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.108190] 2 locks held by kworker/0:228/3510:
> [ 1848.109978]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.112277]  #1: ffff888130bc7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.114622] 2 locks held by kworker/0:229/3511:
> [ 1848.116439]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.118707]  #1: ffff88811cd5fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.121118] 2 locks held by kworker/0:231/3513:
> [ 1848.122938]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.125207]  #1: ffff888122837d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.127584] 2 locks held by kworker/0:234/3516:
> [ 1848.129347]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.131683]  #1: ffff8881277bfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.134053] 2 locks held by kworker/0:235/3517:
> [ 1848.135872]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.138204]  #1: ffff88811a1bfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.140577] 2 locks held by kworker/0:237/3519:
> [ 1848.142368]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.144709]  #1: ffff8881182f7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.147107] 2 locks held by kworker/0:238/3520:
> [ 1848.148899]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.151163]  #1: ffff8881394ffd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.153550] 2 locks held by kworker/0:239/3521:
> [ 1848.155363]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.157675]  #1: ffff888120a3fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.160047] 2 locks held by kworker/0:240/3522:
> [ 1848.161866]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.164186]  #1: ffff88812cf97d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.166588] 2 locks held by kworker/0:241/3523:
> [ 1848.168362]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.170636]  #1: ffff888132a37d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.172998] 2 locks held by kworker/1:149/3528:
> [ 1848.174801]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.177106]  #1: ffff88813b2b7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.179521] 2 locks held by kworker/1:153/3532:
> [ 1848.181318]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.183570]  #1: ffff888115c87d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.185967] 2 locks held by kworker/1:154/3533:
> [ 1848.187772]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.190094]  #1: ffff888115c8fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.192475] 2 locks held by kworker/1:156/3535:
> [ 1848.194287]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.196585]  #1: ffff888115ca7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.198982] 2 locks held by kworker/1:157/3536:
> [ 1848.200771]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.203095]  #1: ffff88813e3bfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.205467] 2 locks held by kworker/1:159/3538:
> [ 1848.207299]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.209643]  #1: ffff88813e3d7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.212044] 2 locks held by kworker/1:160/3539:
> [ 1848.213848]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.216173]  #1: ffff88813e3e7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.218566] 2 locks held by kworker/1:162/3541:
> [ 1848.220380]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.222663]  #1: ffff88813e3ffd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.225041] 2 locks held by kworker/1:163/3542:
> [ 1848.226859]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.229127]  #1: ffff88813dc0fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.231558] 2 locks held by kworker/1:164/3543:
> [ 1848.233346]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.235588]  #1: ffff88813dc17d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.237998] 2 locks held by kworker/1:165/3544:
> [ 1848.239818]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.242102]  #1: ffff88813dc27d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.244507] 2 locks held by kworker/0:245/3546:
> [ 1848.246246]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.248542]  #1: ffff88813dc3fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.250948] 2 locks held by kworker/0:248/3549:
> [ 1848.252757]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.254964]  #1: ffff88813dc67d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.257370] 2 locks held by kworker/0:249/3550:
> [ 1848.259162]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.261488]  #1: ffff88813dc77d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.263876] 2 locks held by kworker/0:250/3551:
> [ 1848.265634]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.267917]  #1: ffff88813dc7fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.270327] 2 locks held by kworker/0:252/3553:
> [ 1848.272112]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.274439]  #1: ffff88813dc97d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.276827] 2 locks held by kworker/0:253/3554:
> [ 1848.278595]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.280893]  #1: ffff88813dca7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.283292] 2 locks held by kworker/0:255/3556:
> [ 1848.285086]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.287396]  #1: ffff88813dcbfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.289755] 2 locks held by kworker/3:134/3558:
> [ 1848.291566]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.293838]  #1: ffff88813dcdfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.296224] 2 locks held by kworker/3:135/3559:
> [ 1848.297985]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.300275]  #1: ffff88813dce7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.302673] 2 locks held by kworker/3:136/3560:
> [ 1848.304445]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.306727]  #1: ffff88813dcf7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.309148] 2 locks held by kworker/3:137/3561:
> [ 1848.310950]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.313250]  #1: ffff88813dd37d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.315666] 2 locks held by kworker/3:141/3565:
> [ 1848.317476]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.319782]  #1: ffff88813dd6fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.322179] 2 locks held by kworker/3:143/3567:
> [ 1848.323971]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.326288]  #1: ffff88813dd87d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.328681] 2 locks held by kworker/3:144/3568:
> [ 1848.330412]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.332695]  #1: ffff88813dd97d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.335071] 2 locks held by kworker/3:146/3570:
> [ 1848.336870]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.339177]  #1: ffff88813ddafd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.341567] 2 locks held by kworker/3:149/3573:
> [ 1848.343358]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.345637]  #1: ffff88813ddcfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.348027] 2 locks held by kworker/3:150/3574:
> [ 1848.349819]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.352086]  #1: ffff88813dddfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.354507] 2 locks held by kworker/3:151/3575:
> [ 1848.356320]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.358664]  #1: ffff88813ddf7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.361065] 2 locks held by kworker/3:152/3576:
> [ 1848.362867]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.365196]  #1: ffff88813de07d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.367604] 2 locks held by kworker/3:153/3577:
> [ 1848.369354]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.371643]  #1: ffff88813de0fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.374031] 2 locks held by kworker/0:257/3578:
> [ 1848.375841]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.378138]  #1: ffff88813de1fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.380570] 2 locks held by kworker/3:154/3579:
> [ 1848.382385]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.384693]  #1: ffff88813de3fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.387099] 2 locks held by kworker/3:156/3581:
> [ 1848.388912]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.391253]  #1: ffff88813dedfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.393640] 2 locks held by kworker/1:167/3585:
> [ 1848.395440]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.397769]  #1: ffff888134f9fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.400195] 2 locks held by kworker/1:168/3586:
> [ 1848.402010]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.404334]  #1: ffff8881304a7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.406710] 2 locks held by kworker/1:169/3587:
> [ 1848.408518]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.410797]  #1: ffff888128997d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.413123] 2 locks held by kworker/1:170/3588:
> [ 1848.414922]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.417223]  #1: ffff888128c0fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.419652] 2 locks held by kworker/1:173/3591:
> [ 1848.421465]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.423770]  #1: ffff88812479fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.426139] 2 locks held by kworker/3:159/3592:
> [ 1848.427922]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.430183]  #1: ffff88813b37fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.432620] 2 locks held by kworker/3:161/3594:
> [ 1848.434390]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.436736]  #1: ffff88812f527d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.439124] 2 locks held by kworker/1:174/3595:
> [ 1848.440806]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.443037]  #1: ffff88812ddefd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.445407] 2 locks held by kworker/1:175/3596:
> [ 1848.447227]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.449537]  #1: ffff88813d93fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.451925] 2 locks held by kworker/1:176/3597:
> [ 1848.453695]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.456000]  #1: ffff88813d94fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.458405] 2 locks held by kworker/1:178/3599:
> [ 1848.460161]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.462413]  #1: ffff88813d967d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.464819] 2 locks held by kworker/1:179/3600:
> [ 1848.466623]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.468907]  #1: ffff88813dadfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.471296] 2 locks held by kworker/1:180/3601:
> [ 1848.473040]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.475356]  #1: ffff88813dae7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.477785] 2 locks held by kworker/1:181/3602:
> [ 1848.479595]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.481902]  #1: ffff88813daf7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.484286] 2 locks held by kworker/1:182/3603:
> [ 1848.486088]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.488360]  #1: ffff88813daffd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.490762] 2 locks held by kworker/1:184/3605:
> [ 1848.492571]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.494862]  #1: ffff88813db1fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.497218] 2 locks held by kworker/1:185/3606:
> [ 1848.498997]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.501268]  #1: ffff88813db2fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.503383] 2 locks held by kworker/1:186/3607:
> [ 1848.505022]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.507066]  #1: ffff88813db37d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.509171] 2 locks held by kworker/1:189/3610:
> [ 1848.510820]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.512859]  #1: ffff88813db5fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.514967] 2 locks held by kworker/1:191/3612:
> [ 1848.516610]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.518642]  #1: ffff88813db77d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.520738] 2 locks held by kworker/1:192/3613:
> [ 1848.522384]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.524420]  #1: ffff88813db7fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.526519] 2 locks held by kworker/1:193/3614:
> [ 1848.528154]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.530192]  #1: ffff88813db8fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.532301] 2 locks held by kworker/1:194/3615:
> [ 1848.533949]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.535994]  #1: ffff88813db9fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.538100] 2 locks held by kworker/1:195/3616:
> [ 1848.539738]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.541777]  #1: ffff88813dbafd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.543878] 2 locks held by kworker/1:196/3617:
> [ 1848.545523]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.547550]  #1: ffff88813dbb7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.549645] 2 locks held by kworker/1:198/3619:
> [ 1848.551279]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.553424]  #1: ffff88813dbd7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.555635] 2 locks held by kworker/1:199/3620:
> [ 1848.557345]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.559466]  #1: ffff88813dbe7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.561573] 2 locks held by kworker/1:200/3621:
> [ 1848.563208]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.565245]  #1: ffff88813dbefd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.567358] 2 locks held by kworker/1:203/3624:
> [ 1848.568987]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.571029]  #1: ffff888161817d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.573136] 2 locks held by kworker/1:206/3627:
> [ 1848.574789]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.576827]  #1: ffff888161837d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.578934] 2 locks held by kworker/1:209/3630:
> [ 1848.580574]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.582608]  #1: ffff88816185fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.584704] 2 locks held by kworker/1:210/3631:
> [ 1848.586343]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.588374]  #1: ffff88816186fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.590480] 2 locks held by kworker/1:211/3632:
> [ 1848.592125]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.594163]  #1: ffff88816187fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.596268] 2 locks held by kworker/3:162/3633:
> [ 1848.597914]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.599956]  #1: ffff88816189fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.602064] 2 locks held by kworker/3:163/3634:
> [ 1848.603707]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.605740]  #1: ffff888127a6fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.607845] 2 locks held by kworker/3:164/3635:
> [ 1848.609485]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.611528]  #1: ffff888128f3fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.613627] 2 locks held by kworker/3:166/3637:
> [ 1848.615263]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.617310]  #1: ffff88812b83fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.619419] 2 locks held by kworker/3:167/3638:
> [ 1848.621064]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.623106]  #1: ffff88812aa57d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.625217] 2 locks held by kworker/3:168/3639:
> [ 1848.626872]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.628921]  #1: ffff888127d3fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.631031] 2 locks held by kworker/3:170/3641:
> [ 1848.632673]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.634706]  #1: ffff88811ec6fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.636811] 2 locks held by kworker/3:171/3642:
> [ 1848.638453]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.640493]  #1: ffff88812f687d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.642594] 2 locks held by kworker/3:172/3643:
> [ 1848.644233]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.646272]  #1: ffff8881380a7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.648388] 2 locks held by kworker/1:212/3644:
> [ 1848.650034]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.652083]  #1: ffff888126e6fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.654204] 2 locks held by kworker/1:213/3645:
> [ 1848.655862]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.657906]  #1: ffff8881276afd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.660014] 2 locks held by kworker/1:214/3646:
> [ 1848.661658]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.663690]  #1: ffff8881323dfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.665799] 2 locks held by kworker/1:215/3647:
> [ 1848.667443]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.669472]  #1: ffff888129ecfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.671566] 2 locks held by kworker/1:216/3648:
> [ 1848.673206]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.675248]  #1: ffff88810f47fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.677353] 2 locks held by kworker/1:218/3650:
> [ 1848.679001]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.681046]  #1: ffff888126487d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.683158] 2 locks held by kworker/1:220/3652:
> [ 1848.684810]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.686858]  #1: ffff88813d47fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.688970] 2 locks held by kworker/1:222/3654:
> [ 1848.690618]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.692656]  #1: ffff8881289d7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.694758] 2 locks held by kworker/1:223/3655:
> [ 1848.696401]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.698445]  #1: ffff888126a6fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.700559] 2 locks held by kworker/1:224/3656:
> [ 1848.702204]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.704245]  #1: ffff88812338fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.706363] 2 locks held by kworker/1:226/3658:
> [ 1848.708009]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.710057]  #1: ffff888105697d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.712165] 2 locks held by kworker/1:227/3659:
> [ 1848.713818]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.715864]  #1: ffff888130d6fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.717969] 2 locks held by kworker/1:229/3661:
> [ 1848.719616]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.721652]  #1: ffff88813c977d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.723760] 2 locks held by kworker/3:173/3663:
> [ 1848.725406]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.727446]  #1: ffff88812b3a7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.729563] 2 locks held by kworker/3:174/3664:
> [ 1848.731188]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.733232]  #1: ffff88812b28fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.735350] 2 locks held by kworker/3:176/3666:
> [ 1848.736998]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.739041]  #1: ffff888130617d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.741151] 2 locks held by kworker/3:177/3667:
> [ 1848.742800]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.744841]  #1: ffff88812fcbfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.746948] 2 locks held by kworker/3:180/3670:
> [ 1848.748596]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.750633]  #1: ffff88812f107d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.752736] 2 locks held by kworker/3:181/3671:
> [ 1848.754382]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.756410]  #1: ffff88812feffd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.758503] 2 locks held by kworker/3:182/3672:
> [ 1848.760134]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.762174]  #1: ffff88812bc8fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.764287] 2 locks held by kworker/3:185/3675:
> [ 1848.765941]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.767986]  #1: ffff8881348dfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.770095] 2 locks held by kworker/3:187/3677:
> [ 1848.771739]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.773785]  #1: ffff888132c87d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.775892] 2 locks held by kworker/3:188/3678:
> [ 1848.777537]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.779565]  #1: ffff888121e2fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.781669] 2 locks held by kworker/3:195/3685:
> [ 1848.783314]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.785354]  #1: ffff88812c187d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.787460] 2 locks held by kworker/3:197/3687:
> [ 1848.789094]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.791137]  #1: ffff888131f5fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.793245] 2 locks held by kworker/3:198/3688:
> [ 1848.794897]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.796942]  #1: ffff88813516fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.799050] 2 locks held by kworker/3:202/3692:
> [ 1848.800695]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.802729]  #1: ffff8881350efd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.804833] 2 locks held by kworker/3:204/3694:
> [ 1848.806476]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.808520]  #1: ffff88811e2a7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.810620] 2 locks held by kworker/3:205/3695:
> [ 1848.812256]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.814287]  #1: ffff88812f4cfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.816397] 2 locks held by kworker/3:207/3697:
> [ 1848.818041]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.820082]  #1: ffff8881247dfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.822188] 2 locks held by kworker/3:208/3698:
> [ 1848.823848]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.825889]  #1: ffff88811934fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.827995] 2 locks held by kworker/3:209/3699:
> [ 1848.829643]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.831677]  #1: ffff8881231d7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.833786] 2 locks held by kworker/3:211/3701:
> [ 1848.835431]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.837472]  #1: ffff888133b6fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.839583] 2 locks held by kworker/3:212/3702:
> [ 1848.841220]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.843267]  #1: ffff88813242fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.845377] 2 locks held by kworker/3:214/3704:
> [ 1848.847024]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.849080]  #1: ffff8881316b7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.851197] 2 locks held by kworker/3:217/3707:
> [ 1848.852849]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.854894]  #1: ffff88811476fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.856998] 2 locks held by kworker/3:218/3708:
> [ 1848.858649]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.860681]  #1: ffff888132bdfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.862786] 2 locks held by kworker/3:220/3710:
> [ 1848.864428]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.866459]  #1: ffff888125137d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.868556] 2 locks held by kworker/3:221/3711:
> [ 1848.870182]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.872225]  #1: ffff888132597d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.874338] 2 locks held by kworker/3:223/3713:
> [ 1848.875983]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.878025]  #1: ffff8881209cfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.880131] 2 locks held by kworker/3:224/3714:
> [ 1848.881784]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.883828]  #1: ffff88811f877d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.885935] 2 locks held by kworker/3:225/3715:
> [ 1848.887576]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.889601]  #1: ffff88811cf47d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.891689] 2 locks held by kworker/3:226/3716:
> [ 1848.893331]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.895372]  #1: ffff88811cd7fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.897468] 2 locks held by kworker/3:227/3717:
> [ 1848.899110]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.901150]  #1: ffff888111b9fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.903256] 2 locks held by kworker/3:232/3722:
> [ 1848.904908]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.906947]  #1: ffff88812aed7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.909055] 2 locks held by kworker/3:233/3723:
> [ 1848.910698]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.912732]  #1: ffff888130637d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.914839] 2 locks held by kworker/3:238/3728:
> [ 1848.916481]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.918521]  #1: ffff8881399efd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.920623] 2 locks held by kworker/1:231/3737:
> [ 1848.922259]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.924298]  #1: ffff8881290a7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.926411] 2 locks held by kworker/1:232/3738:
> [ 1848.928047]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.930086]  #1: ffff888120b77d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.932193] 2 locks held by kworker/1:237/3743:
> [ 1848.933842]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.935906]  #1: ffff8881100f7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.938012] 2 locks held by kworker/1:238/3744:
> [ 1848.939659]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.941690]  #1: ffff88812e0e7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.943802] 2 locks held by kworker/1:239/3745:
> [ 1848.945451]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.947488]  #1: ffff88810ad5fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.949607] 2 locks held by kworker/1:241/3747:
> [ 1848.951246]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.953289]  #1: ffff88811fb5fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.955408] 2 locks held by kworker/1:242/3748:
> [ 1848.957058]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.959102]  #1: ffff888119eefd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.961208] 2 locks held by kworker/1:243/3749:
> [ 1848.962862]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.964903]  #1: ffff888130d87d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.967016] 2 locks held by kworker/1:244/3750:
> [ 1848.968662]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.970700]  #1: ffff8881289afd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.972810] 2 locks held by kworker/1:245/3751:
> [ 1848.974456]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.976486]  #1: ffff8881063cfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.978601] 2 locks held by kworker/1:246/3752:
> [ 1848.980230]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.982276]  #1: ffff88811fca7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.984392] 2 locks held by kworker/1:248/3754:
> [ 1848.986033]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.988077]  #1: ffff888106997d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.990184] 2 locks held by kworker/1:249/3755:
> [ 1848.991840]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.993885]  #1: ffff8881372afd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1848.995994] 2 locks held by kworker/1:250/3756:
> [ 1848.997641]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1848.999679]  #1: ffff8881209b7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1849.001787] 2 locks held by kworker/1:251/3757:
> [ 1849.003436]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1849.005482]  #1: ffff8881314ffd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1849.007582] 2 locks held by kworker/1:252/3758:
> [ 1849.009219]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1849.011260]  #1: ffff888130d8fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1849.013377] 2 locks held by kworker/1:253/3759:
> [ 1849.015026]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1849.017066]  #1: ffff8881371b7d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1849.019201] 2 locks held by kworker/1:255/3761:
> [ 1849.020862]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1849.022902]  #1: ffff88811d897d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1849.025007] 2 locks held by kworker/1:256/3762:
> [ 1849.026649]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1849.028680]  #1: ffff88813b99fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1849.030792] 2 locks held by kworker/1:257/3763:
> [ 1849.032440]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1849.034483]  #1: ffff88813b0efd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1849.036590] 2 locks held by kworker/3:247/3765:
> [ 1849.038220]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1849.040260]  #1: ffff888134867d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1849.042382] 2 locks held by kworker/3:248/3766:
> [ 1849.044023]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1849.046066]  #1: ffff888124b7fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1849.048170] 2 locks held by kworker/3:249/3767:
> [ 1849.049821]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1849.051860]  #1: ffff888131aafd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1849.053964] 2 locks held by kworker/3:251/3769:
> [ 1849.055610]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1849.057647]  #1: ffff8881068ffd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1849.059746] 2 locks held by kworker/3:252/3770:
> [ 1849.061399]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1849.063434]  #1: ffff88810b757d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1849.065537] 2 locks held by kworker/3:254/3772:
> [ 1849.067174]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1849.069213]  #1: ffff888136d97d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1849.071346] 2 locks held by kworker/3:255/3773:
> [ 1849.072992]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1849.075027]  #1: ffff88811830fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1849.077139] 2 locks held by kworker/3:256/3774:
> [ 1849.078795]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1849.080838]  #1: ffff888127547d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1849.082946] 2 locks held by kworker/1:258/4004:
> [ 1849.084592]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1849.086626]  #1: ffff88812cbefd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1849.088727] 2 locks held by kworker/0:18/13817:
> [ 1849.090368]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1849.092406]  #1: ffff8881213cfd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1849.094515] 2 locks held by kworker/1:97/23521:
> [ 1849.096151]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1849.098194]  #1: ffff88810c33fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1849.100300] 2 locks held by kworker/1:259/28552:
> [ 1849.101959]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1849.103997]  #1: ffff888140777d98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1849.106102] 2 locks held by kworker/3:258/38106:
> [ 1849.107766]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1849.109802]  #1: ffff888111b0fd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> [ 1849.111912] 2 locks held by kworker/1:172/39248:
> [ 1849.113563]  #0: ffff88813c00c938 ((wq_completion)dio/dm-1){+.+.}-{0:0}, at: process_one_work+0x790/0x14a0
> [ 1849.115594]  #1: ffff888110eefd98 ((work_completion)(&dio->aio.work)){+.+.}-{0:0}, at: process_one_work+0x7be/0x14a0
> 
> [ 1849.119116] =============================================
> 
> 
> [2]
> 
> $ ps axuw | grep " D "
> root           9  0.0  0.0      0     0 ?        D    10:55   0:00 [kworker/0:1+dio/dm-1]
> root          25  0.0  0.0      0     0 ?        D    10:55   0:00 [kworker/1:0+dio/dm-1]
> root          49  0.0  0.0      0     0 ?        D    10:55   0:00 [kworker/1:1+dio/dm-1]
> root          74  0.0  0.0      0     0 ?        D    10:55   0:00 [kworker/0:2+dio/dm-1]
> root         169  0.0  0.0      0     0 ?        D    10:55   0:00 [kworker/3:2+dio/dm-1]
> root         221  0.0  0.0      0     0 ?        D    10:55   0:00 [kworker/0:3+dio/dm-1]
> root         230  0.0  0.0      0     0 ?        D    10:55   0:00 [kworker/1:2+dio/dm-1]
> root         291  0.0  0.0      0     0 ?        D    10:55   0:00 [kworker/2:3+dio/dm-1]
> root         322  0.0  0.0      0     0 ?        D    10:55   0:00 [kworker/1:3+dio/dm-1]
> root        2757  2.1  0.0      0     0 ?        D    10:57   1:14 [kworker/u8:7+flush-253:1]
> root        2759  0.0  0.0      0     0 ?        D    10:57   0:00 [kworker/3:4+dio/dm-1]
> root        2760  0.0  0.0      0     0 ?        D    10:57   0:00 [kworker/0:4+dio/dm-1]
> root        2762  0.0  0.0      0     0 ?        D    10:57   0:00 [kworker/1:5+dio/dm-1]
> root        2764  0.0  0.0      0     0 ?        D    10:57   0:00 [kworker/1:6+dio/dm-1]
> root        2765  0.0  0.0      0     0 ?        D    10:57   0:00 [kworker/3:5+dio/dm-1]
> ...

Shinichiro,

I have been aware for a long time that there is a problem with blktests/srp. I see hangs in
002 and 011 fairly often. I have not been able to figure out the root cause but suspect that
there is a timing issue in the srp drivers which cannot handle the slowness of the software
RoCE implemtation. If you can give me any clues about what you are seeing I am happy to help
try to figure this out.

Bob Pearson
rpearson@hpe.com (rpearsonhpe@gmail.com)
