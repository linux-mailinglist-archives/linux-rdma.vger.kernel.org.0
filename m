Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97EB149588E
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jan 2022 04:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiAUDfn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jan 2022 22:35:43 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:53238 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233319AbiAUDfn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jan 2022 22:35:43 -0500
Received: from localhost.localdomain (unknown [111.18.137.146])
        by APP-03 (Coremail) with SMTP id rQCowABHT1vxKephbzrQBQ--.61977S4;
        Fri, 21 Jan 2022 11:35:22 +0800 (CST)
From:   kuroro99 <jiatai2021@iscas.ac.cn>
To:     linux-rdma@vger.kernel.org
Cc:     HeJiatai <jiatai2021@iscas.ac.cn>
Subject: [PATCH] Perftest:support get_cycles for riscv
Date:   Fri, 21 Jan 2022 11:35:11 +0800
Message-Id: <20220121033511.2490-1-jiatai2021@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABHT1vxKephbzrQBQ--.61977S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1rCFW8ur1xWF47Gr4fGrg_yoW8Xry7pr
        45KryayrsxKry3WFZaqF98JFn8Xr97GFZxJF9agrWF9F47tw1kWrZ8W3Z0vryYq3Z5Zr9x
        AF4UGry0krnrZw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUq-e
        rUUUUU=
X-Originating-IP: [111.18.137.146]
X-CM-SenderInfo: xmld3trlsqji46lvutnvoduhdfq/
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: HeJiatai <jiatai2021@iscas.ac.cn>

This patch support the get_cycles for riscv to get the system time. And then
perftest can be built successfully in riscv architecture, which was tested in
openeuler-riscv64 and debian-riscv64-qemu.
---
 src/get_clock.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/src/get_clock.h b/src/get_clock.h
index dacbcd0..dde3c34 100755
--- a/src/get_clock.h
+++ b/src/get_clock.h
@@ -104,7 +104,38 @@ static inline cycles_t get_cycles()
 	asm volatile("mrs %0, cntvct_el0" : "=r" (cval));
 	return cval;
 }
+#elif defined(__riscv)
+#define ASM_STR(x) #x
+#define csr_read(csr)						\
+({								\
+	register unsigned long __v;				\
+	__asm__ __volatile__ ("csrr %0, " ASM_STR(csr)          \
+			      : "=r" (__v) :			\
+			      : "memory");			\
+	__v;							\
+})//read mtime csr
+#define CSR_TIME		0xc01  //read mtime from csrs rather than the mmap
+#if  __riscv_xlen == 64
+typedef unsigned long long cycles_t;
+static inline cycles_t get_cycles()
+{
+	return csr_read(CSR_TIME);
+}
+#elif __riscv_xlen == 32
+#define CSR_TIMEH		0xc81
+typedef unsigned long long cycles_t;
+static inline cycles_t get_cycles()
+{	uint32_t hi, lo;
+
+	do {
+		hi = csr_read(CSR_TIMEH);
+		lo = csr_read(CSR_TIME);
+	} while (hi != csr_read(CSR_TIMEH));
 
+	return ((uint64_t)hi << 32) | lo;
+
+}
+#endif/*__riscv*/
 #else
 #warning get_cycles not implemented for this architecture: attempt asm/timex.h
 #include <asm/timex.h>
-- 
2.25.1

