Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57D676695C
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 10:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfGLIwa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 04:52:30 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:42291 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfGLIwa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 04:52:30 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mk0BK-1iADl333mK-00kRFQ; Fri, 12 Jul 2019 10:52:17 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rdma/siw: avoid smp_store_mb() on a u64
Date:   Fri, 12 Jul 2019 10:51:23 +0200
Message-Id: <20190712085212.3901785-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KY1ZiQXnqfybV9Y5nyNgAL7twsfFgdD0kgCdlGwv9DpUokeeTuR
 E/e0EqvPepg5mjIPlxUcNKBbSKzzXurSUjp5RwIzk6m3+nESDvY+SO0DFIuWdUpkZkyhOR4
 zYgOmweqYWXXw5qJaVZVyhxs2riJNq+phMrLlVA9pM053QaEckPzWZuxg/a6Z/CXA5b5txx
 66nJ7yUuBk5b1SdoPUSmA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:h1kT/fyAOvw=:tBd5fulYxc9mnD3vsjm3BF
 uDQp8eanGK1Kw53aQIU18FsWzcZ/VJj1ATzEZ6u2sRNIu0RYyrjMT4rbeVMAG3Yma3RDbpToT
 m58cBGXSIkGvG/hrs/m3gl+Kkw36EyZSJQHA1c3SehZFWYwC4URr5uC2N04GcMEQ6K9yNcV8B
 Av/Bj3QtGTbOOEedHDVnv42unstjH7Nb4yfUIQd6izdqMUiJmeuFLTlTLCABKU0Sc8xAu5ohP
 BAHoZKq3w4BGIqvitfmkpjFocVfmgOQ2pNhfABsL8Ip7U1M0u5i3zjYYijh1epsRs905Ecnfm
 b+e6tkgXKyk1MzNoDYDyp02usy0PMizppOLFgRmQOYQavCOvc38H3seKiTF9isYIWasf1qLzn
 Vhh/0XPg0WDEtAVFswOd+hjKU1Td6JlqglUgdwfjeZlEVXIuPFSep4gSjdf4WYHWc4HXxEGpI
 qzSkcygUnDEgPdZZ8dUkA/Wyruq4DgvftcKeyzUICxW6sU8BivZ605BYfe+9riVISVfgUZD96
 4TF4wwmQPZlb+CmBz1bJCq8m4+13S1wCcjQltv/aQNHOT5jPTclxTj0E9Ie4LDCfGSEOK/jjG
 2XFANoZ7tgdmj4OdZJhEWMC6JWrpRriqQz51UbQ/xsiuhsF6O569lgySuXkSDOlzYMDtGAC1x
 xsjKcssb4OlwlnN6KD7a83Yrs4yqE/lTjoMNoiJmWV6dm4Ij8dbPEqeIIXSyUzBgnqLOg6myj
 hgEDDhO/eGz03s/gK7Ol1rM9wYvIs8bozzt2UA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The new siw driver fails to build on i386 with

drivers/infiniband/sw/siw/siw_qp.c:1025:3: error: invalid output size for constraint '+q'
                smp_store_mb(*cq->notify, SIW_NOTIFY_NOT);
                ^
include/asm-generic/barrier.h:141:35: note: expanded from macro 'smp_store_mb'
 #define smp_store_mb(var, value)  __smp_store_mb(var, value)
                                  ^
arch/x86/include/asm/barrier.h:65:47: note: expanded from macro '__smp_store_mb'
 #define __smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)
                                              ^
include/asm-generic/atomic-instrumented.h:1648:2: note: expanded from macro 'xchg'
        arch_xchg(__ai_ptr, __VA_ARGS__);                               \
        ^
arch/x86/include/asm/cmpxchg.h:78:27: note: expanded from macro 'arch_xchg'
 #define arch_xchg(ptr, v)       __xchg_op((ptr), (v), xchg, "")
                                ^
arch/x86/include/asm/cmpxchg.h:48:19: note: expanded from macro '__xchg_op'
                                      : "+q" (__ret), "+m" (*(ptr))     \
                                              ^
drivers/infiniband/sw/siw/siw_qp.o: In function `siw_sqe_complete':
siw_qp.c:(.text+0x1450): undefined reference to `__xchg_wrong_size'
drivers/infiniband/sw/siw/siw_qp.o: In function `siw_rqe_complete':
siw_qp.c:(.text+0x15b0): undefined reference to `__xchg_wrong_size'
drivers/infiniband/sw/siw/siw_verbs.o: In function `siw_req_notify_cq':
siw_verbs.c:(.text+0x18ff): undefined reference to `__xchg_wrong_size'

Since smp_store_mb() has to be an atomic store, but the architecture
can only do this on 32-bit quantities or smaller, but 'cq->notify'
is a 64-bit word.

Apparently the smp_store_mb() is paired with a READ_ONCE() here, which
seems like an odd choice because there is only a barrier on the writer
side and not the reader, and READ_ONCE() is already not atomic on
quantities larger than a CPU register.

I suspect it is sufficient to use the (possibly nonatomic) WRITE_ONCE()
and an SMP memory barrier here. If it does need to be atomic as well
as 64-bit quantities, using an atomic64_set_release()/atomic64_read_acquire()
may be a better choice.

Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
Fixes: f29dd55b0236 ("rdma/siw: queue pair methods")
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/sw/siw/siw_qp.c    | 4 +++-
 drivers/infiniband/sw/siw/siw_verbs.c | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
index 11383d9f95ef..a2c08f17f13d 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -1016,13 +1016,15 @@ static bool siw_cq_notify_now(struct siw_cq *cq, u32 flags)
 	if (!cq->base_cq.comp_handler)
 		return false;
 
+	smp_rmb();
 	cq_notify = READ_ONCE(*cq->notify);
 
 	if ((cq_notify & SIW_NOTIFY_NEXT_COMPLETION) ||
 	    ((cq_notify & SIW_NOTIFY_SOLICITED) &&
 	     (flags & SIW_WQE_SOLICITED))) {
 		/* dis-arm CQ */
-		smp_store_mb(*cq->notify, SIW_NOTIFY_NOT);
+		WRITE_ONCE(*cq->notify, SIW_NOTIFY_NOT);
+		smp_wmb();
 
 		return true;
 	}
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 32dc79d0e898..41c5ab293fe1 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1142,10 +1142,11 @@ int siw_req_notify_cq(struct ib_cq *base_cq, enum ib_cq_notify_flags flags)
 
 	if ((flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED)
 		/* CQ event for next solicited completion */
-		smp_store_mb(*cq->notify, SIW_NOTIFY_SOLICITED);
+		WRITE_ONCE(*cq->notify, SIW_NOTIFY_SOLICITED);
 	else
 		/* CQ event for any signalled completion */
-		smp_store_mb(*cq->notify, SIW_NOTIFY_ALL);
+		WRITE_ONCE(*cq->notify, SIW_NOTIFY_ALL);
+	smp_wmb();
 
 	if (flags & IB_CQ_REPORT_MISSED_EVENTS)
 		return cq->cq_put - cq->cq_get;
-- 
2.20.0

