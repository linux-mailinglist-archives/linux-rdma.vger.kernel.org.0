Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3517591D84
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 09:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbfHSHEp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 19 Aug 2019 03:04:45 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:49900 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbfHSHEp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 03:04:45 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 0F8F628590
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 07:04:44 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 000C9285B3; Mon, 19 Aug 2019 07:04:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=ham version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-rdma@vger.kernel.org
Subject: [Bug 204617] New: drivers/infiniband/sw/siw not 32-bit clean - cast
 from pointer to integer warnings on i686
Date:   Mon, 19 Aug 2019 07:04:43 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo
 drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Infiniband/RDMA
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hramrach@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-204617-11804@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=204617

            Bug ID: 204617
           Summary: drivers/infiniband/sw/siw not 32-bit clean - cast from
                    pointer to integer warnings on i686
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.3
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Infiniband/RDMA
          Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
          Reporter: hramrach@gmail.com
        Regression: No

In file included from ../include/linux/printk.h:332,
../drivers/infiniband/sw/siw/siw_cq.c: In function 'siw_reap_cqe':
../drivers/infiniband/sw/siw/siw_cq.c:76:20: warning: cast to pointer from
integer of different size [-Wint-to-pointer-cast]
../include/linux/dynamic_debug.h:125:15: note: in definition of macro
'__dynamic_func_call'
../include/linux/dynamic_debug.h:165:2: note: in expansion of macro
'_dynamic_func_call'
../include/rdma/ib_verbs.h:100:2: note: in expansion of macro
'dynamic_ibdev_dbg'
../drivers/infiniband/sw/siw/siw.h:725:2: note: in expansion of macro
'ibdev_dbg'
../drivers/infiniband/sw/siw/siw_cq.c:74:4: note: in expansion of macro
'siw_dbg_cq'

../drivers/infiniband/sw/siw/siw_qp.c: In function 'siw_activate_tx':
../drivers/infiniband/sw/siw/siw_qp.c:952:28: warning: cast from pointer to
integer of different size [-Wpointer-to-int-cast]

In file included from ../include/linux/kernel.h:15,
../drivers/infiniband/sw/siw/siw_qp_rx.c: In function 'siw_rx_umem':
../drivers/infiniband/sw/siw/siw_qp_rx.c:43:5: warning: cast to pointer from
integer of different size [-Wint-to-pointer-cast]
../include/linux/printk.h:306:37: note: in definition of macro 'pr_warning'
../drivers/infiniband/sw/siw/siw_qp_rx.c:41:4: note: in expansion of macro
'pr_warn'

../drivers/infiniband/sw/siw/siw_qp_rx.c:43:24: warning: cast to pointer from
integer of different size [-Wint-to-pointer-cast]
../include/linux/printk.h:306:37: note: in definition of macro 'pr_warning'
../drivers/infiniband/sw/siw/siw_qp_rx.c:41:4: note: in expansion of macro
'pr_warn'

../drivers/infiniband/sw/siw/siw_qp_rx.c: In function 'siw_rx_pbl':
../drivers/infiniband/sw/siw/siw_qp_rx.c:141:23: warning: cast to pointer from
integer of different size [-Wint-to-pointer-cast]

../drivers/infiniband/sw/siw/siw_qp_rx.c: In function 'siw_proc_send':
../drivers/infiniband/sw/siw/siw_qp_rx.c:488:6: warning: cast to pointer from
integer of different size [-Wint-to-pointer-cast]

../drivers/infiniband/sw/siw/siw_qp_rx.c: In function 'siw_proc_write':
../drivers/infiniband/sw/siw/siw_qp_rx.c:601:5: warning: cast to pointer from
integer of different size [-Wint-to-pointer-cast]

../drivers/infiniband/sw/siw/siw_qp_rx.c: In function 'siw_proc_rresp':
../drivers/infiniband/sw/siw/siw_qp_rx.c:844:24: warning: cast to pointer from
integer of different size [-Wint-to-pointer-cast]

In file included from ../arch/x86/include/asm/string.h:3,
../drivers/infiniband/sw/siw/siw_qp_tx.c: In function 'siw_try_1seg':
../drivers/infiniband/sw/siw/siw_qp_tx.c:53:10: warning: cast to pointer from
integer of different size [-Wint-to-pointer-cast]
../arch/x86/include/asm/string_32.h:182:42: note: in definition of macro
'memcpy'

../drivers/infiniband/sw/siw/siw_qp_tx.c:59:11: warning: cast to pointer from
integer of different size [-Wint-to-pointer-cast]
../arch/x86/include/asm/string_32.h:182:42: note: in definition of macro
'memcpy'

../drivers/infiniband/sw/siw/siw_qp_tx.c:59:26: warning: cast to pointer from
integer of different size [-Wint-to-pointer-cast]
../arch/x86/include/asm/string_32.h:182:45: note: in definition of macro
'memcpy'

../drivers/infiniband/sw/siw/siw_qp_tx.c:61:23: warning: cast to pointer from
integer of different size [-Wint-to-pointer-cast]

../drivers/infiniband/sw/siw/siw_qp_tx.c:62:9: warning: cast to pointer from
integer of different size [-Wint-to-pointer-cast]

In file included from ../arch/x86/include/asm/string.h:3,
../drivers/infiniband/sw/siw/siw_qp_tx.c:82:12: warning: cast to pointer from
integer of different size [-Wint-to-pointer-cast]
../arch/x86/include/asm/string_32.h:182:42: note: in definition of macro
'memcpy'

../drivers/infiniband/sw/siw/siw_qp_tx.c:87:12: warning: cast to pointer from
integer of different size [-Wint-to-pointer-cast]
../arch/x86/include/asm/string_32.h:182:42: note: in definition of macro
'memcpy'

../drivers/infiniband/sw/siw/siw_qp_tx.c:101:12: warning: cast to pointer from
integer of different size [-Wint-to-pointer-cast]
../arch/x86/include/asm/string_32.h:182:42: note: in definition of macro
'memcpy'

../drivers/infiniband/sw/siw/siw_qp_tx.c: In function 'siw_qp_prepare_tx':
../drivers/infiniband/sw/siw/siw_qp_tx.c:169:29: warning: cast from pointer to
integer of different size [-Wpointer-to-int-cast]

../drivers/infiniband/sw/siw/siw_qp_tx.c:192:29: warning: cast from pointer to
integer of different size [-Wpointer-to-int-cast]

../drivers/infiniband/sw/siw/siw_qp_tx.c:204:29: warning: cast from pointer to
integer of different size [-Wpointer-to-int-cast]

../drivers/infiniband/sw/siw/siw_qp_tx.c:219:29: warning: cast from pointer to
integer of different size [-Wpointer-to-int-cast]

../drivers/infiniband/sw/siw/siw_qp_tx.c: In function 'siw_tx_hdt':
../drivers/infiniband/sw/siw/siw_qp_tx.c:476:24: warning: cast to pointer from
integer of different size [-Wint-to-pointer-cast]

../drivers/infiniband/sw/siw/siw_qp_tx.c:535:7: warning: cast to pointer from
integer of different size [-Wint-to-pointer-cast]

../drivers/infiniband/sw/siw/siw_qp_tx.c: In function 'siw_qp_sq_proc_tx':
../drivers/infiniband/sw/siw/siw_qp_tx.c:832:29: warning: cast from pointer to
integer of different size [-Wpointer-to-int-cast]

../drivers/infiniband/sw/siw/siw_qp_tx.c: In function 'siw_fastreg_mr':
../drivers/infiniband/sw/siw/siw_qp_tx.c:927:26: warning: cast to pointer from
integer of different size [-Wint-to-pointer-cast]

../drivers/infiniband/sw/siw/siw_verbs.c: In function 'siw_copy_inline_sgl':
../drivers/infiniband/sw/siw/siw_verbs.c:665:22: warning: cast from pointer to
integer of different size [-Wpointer-to-int-cast]

../drivers/infiniband/sw/siw/siw_verbs.c: In function 'siw_post_send':
../drivers/infiniband/sw/siw/siw_verbs.c:828:19: warning: cast from pointer to
integer of different size [-Wpointer-to-int-cast]

In file included from ../include/linux/printk.h:332,
../drivers/infiniband/sw/siw/siw_verbs.c:846:32: warning: cast to pointer from
integer of different size [-Wint-to-pointer-cast]
../include/linux/dynamic_debug.h:125:15: note: in definition of macro
'__dynamic_func_call'
../include/linux/dynamic_debug.h:165:2: note: in expansion of macro
'_dynamic_func_call'
../include/rdma/ib_verbs.h:100:2: note: in expansion of macro
'dynamic_ibdev_dbg'
../drivers/infiniband/sw/siw/siw.h:721:2: note: in expansion of macro
'ibdev_dbg'
../drivers/infiniband/sw/siw/siw_verbs.c:845:3: note: in expansion of macro
'siw_dbg_qp'

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
