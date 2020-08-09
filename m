Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C39723FD3E
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Aug 2020 09:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgHIHsa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sun, 9 Aug 2020 03:48:30 -0400
Received: from smtp180.sjtu.edu.cn ([202.120.2.180]:47380 "EHLO
        smtp180.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgHIHsa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Aug 2020 03:48:30 -0400
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Aug 2020 03:48:29 EDT
Received: from proxy01.sjtu.edu.cn (smtp185.sjtu.edu.cn [202.120.2.185])
        by smtp180.sjtu.edu.cn (Postfix) with ESMTPS id 1CAEC1008CA20
        for <linux-rdma@vger.kernel.org>; Sun,  9 Aug 2020 15:41:13 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by proxy01.sjtu.edu.cn (Postfix) with ESMTP id 15E6D2042423E
        for <linux-rdma@vger.kernel.org>; Sun,  9 Aug 2020 15:41:13 +0800 (CST)
X-Virus-Scanned: amavisd-new at proxy01.sjtu.edu.cn
Received: from proxy01.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy01.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Dz0RsbVY-mVv for <linux-rdma@vger.kernel.org>;
        Sun,  9 Aug 2020 15:41:12 +0800 (CST)
Received: from [10.86.108.142] (unknown [120.253.239.90])
        (Authenticated sender: Fan_Yang@sjtu.edu.cn)
        by proxy01.sjtu.edu.cn (Postfix) with ESMTPSA id CCA7A20424202
        for <linux-rdma@vger.kernel.org>; Sun,  9 Aug 2020 15:41:12 +0800 (CST)
From:   Fan Yang <Fan_Yang@sjtu.edu.cn>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Asking for help: Is it possible to force use rxe provider functions
 atop a Mellanox ConnectX-5 ethernet network?
Message-Id: <1A873CA4-9A41-41D2-A335-63FA834DE13F@sjtu.edu.cn>
Date:   Sun, 9 Aug 2020 15:41:05 +0800
To:     linux-rdma@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

I have access to a cloud-provided virtual machine with a "Mellanox
Technologies MT27800 Family [ConnectX-5 Virtual Function]" ethernet
controller.  It seems that I cannot use hardware RoCE on it (BTW, do
you know how to check this?), so I decide to use rxe.

However, a divide error occurs when I run my RDMA program:

trap divide error ip:7f8dd1802b8f sp:7ffc63e72a80 error:0 in libmlx5.so.1.12.28.0[7f8dd17eb000+46000]

The backtrace is:

(gdb) bt
#0  0x00007ffff63d3365 in __add_page (context=0x7ffff7f75010)
    at ~/src/rdma-core/providers/mlx5/dbrec.c:58
#1  0x00007ffff63d3587 in mlx5_alloc_dbrec (context=0x7ffff7f75010, pd=0x0, custom_alloc=0x5555557671e8)
    at ~/src/rdma-core/providers/mlx5/dbrec.c:119
#2  0x00007ffff6403320 in create_cq (context=0x7ffff7f75150, cq_attr=0x7fffffffe6d0, cq_alloc_flags=0, 
    mlx5cq_attr=0x0) at ~/src/rdma-core/providers/mlx5/verbs.c:1013
#3  0x00007ffff640388a in mlx5_create_cq (context=0x7ffff7f75150, cqe=3, channel=0x555555765ec0, comp_vector=0)
    at ~/src/rdma-core/providers/mlx5/verbs.c:1134
#4  0x00007ffff79acfb9 in __ibv_create_cq_1_1 (context=0x7ffff7f75150, cqe=3, 
    cq_context=0x55555575b440 <admin_qp>, channel=0x555555765ec0, comp_vector=0)
    at ~/src/rdma-core/libibverbs/verbs.c:520
#5  0x0000555555556e79 in fsr_process_admin_qp_cm_event_req (aqp=0x55555575b440 <admin_qp>, ev=0x555555765a50)
    at ../../../server/fmsgserver_rdma/fmsgserver_rdma.c:449
#6  0x0000555555557299 in fsr_process_admin_qp_cm_event (aqp=0x55555575b440 <admin_qp>, ec=0x55555575c410)
    at ../../../server/fmsgserver_rdma/fmsgserver_rdma.c:552
#7  0x00005555555573b7 in fsr_estab_admin_qp (aqp=0x55555575b440 <admin_qp>)
    at ../../../server/fmsgserver_rdma/fmsgserver_rdma.c:596
#8  0x0000555555557445 in fmsgserver_rdma_init () at ../../../server/fmsgserver_rdma/fmsgserver_rdma.c:619
#9  0x00005555555562cf in main (argc=1, argv=0x7fffffffe9b8) at driver.c:248

I find that the 'match_device' in rdma-core/libibverbs/init.c
will always match the mlx5 provider instead of the rxe provider since the
the pci ID matches (see hca_table in rdma-core/providers/mlx5/mlx5.c).
This leads to mlx5_xxx functions are invoked instead of the rxe_xxx functions.

Do you know how to force use the rxe-provider functions on top of the
mellanox connectX-5 ethernet network?  Currently as a workaround, I
comment out the mlx5 subdirectories in the CMakeLists.txt so that mlx5
won't be tried in 'try_all_drivers'.

Best Regards,
Fan
