Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2236436199
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 14:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhJUMaY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 08:30:24 -0400
Received: from mx22.baidu.com ([220.181.50.185]:41746 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231297AbhJUMaX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 08:30:23 -0400
Received: from BC-Mail-Ex28.internal.baidu.com (unknown [172.31.51.22])
        by Forcepoint Email with ESMTPS id 06DC2D9DC4CF7EAFF5BA;
        Thu, 21 Oct 2021 20:28:06 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex28.internal.baidu.com (172.31.51.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 21 Oct 2021 20:28:05 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 21 Oct 2021 20:28:04 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rcu@vger.kernel.org>
Subject: [PATCH v2 1/6] kthread: Add the helper macro kthread_run_on_cpu()
Date:   Thu, 21 Oct 2021 20:27:52 +0800
Message-ID: <20211021122758.3092-2-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021122758.3092-1-caihuoqing@baidu.com>
References: <20211021122758.3092-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex10.internal.baidu.com (172.31.51.50) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

the helper macro kthread_run_on_cpu() inculdes
kthread_create_on_cpu/wake_up_process().
In some cases, use kthread_run_on_cpu() directly instead of
kthread_create_on_node/kthread_bind/wake_up_process() or
kthread_create_on_cpu/wake_up_process() or
kthreadd_create/kthread_bind/wake_up_process() to simplify the code.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
v1->v2:
	*Remove cpu_to_node from kthread_create_on_cpu params.
	*Updated the macro description comment.

 include/linux/kthread.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 346b0f269161..dfd125523aa9 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -56,6 +56,27 @@ bool kthread_is_per_cpu(struct task_struct *k);
 	__k;								   \
 })
 
+/**
+ * kthread_run_on_cpu - create and wake a cpu bound thread.
+ * @threadfn: the function to run until signal_pending(current).
+ * @data: data ptr for @threadfn.
+ * @cpu: The cpu on which the thread should be bound,
+ * @namefmt: printf-style name for the thread. Format is restricted
+ *	     to "name.*%u". Code fills in cpu number.
+ *
+ * Description: Convenient wrapper for kthread_create_on_cpu()
+ * followed by wake_up_process().  Returns the kthread or
+ * ERR_PTR(-ENOMEM).
+ */
+#define kthread_run_on_cpu(threadfn, data, cpu, namefmt)	       \
+({								       \
+	struct task_struct *__k					       \
+		= kthread_create_on_cpu(threadfn, data, cpu, namefmt); \
+	if (!IS_ERR(__k))					       \
+		wake_up_process(__k);				       \
+	__k;							       \
+})
+
 void free_kthread_struct(struct task_struct *k);
 void kthread_bind(struct task_struct *k, unsigned int cpu);
 void kthread_bind_mask(struct task_struct *k, const struct cpumask *mask);
-- 
2.25.1

