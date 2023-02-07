Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C1268CD1E
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Feb 2023 04:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBGDJt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Feb 2023 22:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBGDJs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Feb 2023 22:09:48 -0500
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE8313D49
        for <linux-rdma@vger.kernel.org>; Mon,  6 Feb 2023 19:09:42 -0800 (PST)
X-QQ-mid: bizesmtp62t1675739377tg1rlx4l
Received: from [172.20.10.25] ( [182.150.116.99])
        by bizesmtp.qq.com (ESMTP) with SMTP id 0
        for <linux-rdma@vger.kernel.org>; Tue, 07 Feb 2023 11:09:37 +0800 (CST)
X-QQ-SSF: 0140000000000070H000000A0001000
X-QQ-FEAT: HPkwb3INVpDp57fDtp4oWZZ3EEtSvTDICO0CkL5ldXQUuJLIC7VSG7ZD90Usj
        W1ec3a/IvXa8ToUPYnhdCKfenUwgDpuGX5D0e30qFp7a7Zj7pTleoDJ6+CI0DLrqoNio2tF
        wmmugG0iztFdD3p8mNdnTFupb0vuGQpxJhhj/ubIiI/zv6KKoJU2ijWvgBxxGabji+DGgOm
        hjgURd+uSK0JHJD+4dI/f/1/rB/CeUietA3169JKMaMYGBDSm2rQR6bdbP0wng8PJpc72MZ
        znvJkmrnOK/rCQWV4+L9aQu0QL6DBj8Y7fBdcfWIkRi6rFJTyTm948qyDBaGr1sTMFOaR+r
        0mU0WW3qlEnOFgCHgmujsq1uZnKJNm1LYkxg7JX2ALm/Wlq4Kw=
X-QQ-GoodBg: 2
Message-ID: <8DDFF0AC89400BC0+76d0cfd8-78d8-ba3a-9685-fa1596e5a8c9@enmotech.com>
Date:   Tue, 7 Feb 2023 11:09:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
To:     linux-rdma@vger.kernel.org
From:   yang <wei.xin@enmotech.com>
Subject: ibv_reg_mr hang
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:enmotech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

when I test with command `ib_send_bw -D5 -d mlx5_1` it hangs forever, 
the stack I get from `/proc/pid/stack` is


mlx5_ib_post_send_wait+0xce/0x200 [mlx5_ib]

mlx5_ib_update_mr-pas+0x299/0x370 [mlx5_ib]

create_real_mr+0x1a4/0x200 [mlx5_ib]

ib_uverbs_reg_mr+0x17e/0x270 [ib_uverbs]

ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xdd/0x140 [ib_uverbs]

ib_uverbs_run_method+0x229/0x7a0 [ib_uverbs]

ib_uverbs_cmd_verbs.isra.5+0x1a5/0x390 [ib_uverbs]

ib_uverbs_ioctl+0xb8/0x110 [ib_uverbs]

do_vfs_ioctl+0xa4/0x640

ksys_vfs_ioctl+0x70/0x80

do_syscall_64+0x61/0x250

entry_SYSCALL_64_after_hwframe+0x44/0xa9

-------------------------------------------------------------------

OS:  openEuler 20.03

Kernel: 4.19.90-2112.8.0.0131.oel

ofed: MLNX_OFED_LINUX-5.7-1.0.2.0




