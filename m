Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486B4437041
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Oct 2021 04:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhJVDBd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 23:01:33 -0400
Received: from mx22.baidu.com ([220.181.50.185]:50378 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232613AbhJVDBc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 23:01:32 -0400
Received: from BC-Mail-Ex09.internal.baidu.com (unknown [172.31.51.49])
        by Forcepoint Email with ESMTPS id E763CEC8D8E4ACBD5A29;
        Fri, 22 Oct 2021 10:59:04 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex09.internal.baidu.com (172.31.51.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Fri, 22 Oct 2021 10:59:04 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 22 Oct 2021 10:59:03 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <rostedt@goodmis.org>
CC:     Cai Huoqing <caihuoqing@baidu.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rcu@vger.kernel.org>
Subject: [PATCH v3 1/6] kthread: Add the helper function kthread_run_on_cpu()
Date:   Fri, 22 Oct 2021 10:57:04 +0800
Message-ID: <20211022025711.3673-2-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211022025711.3673-1-caihuoqing@baidu.com>
References: <20211022025711.3673-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex28.internal.baidu.com (172.31.51.22) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

the helper function kthread_run_on_cpu() includes
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
v2->v3:
	*Convert this helper macro to static inline function
	*Fix typo in changelog

v1 link:
	https://lore.kernel.org/lkml/20211021120135.3003-2-caihuoqing@baidu.com/
v2 link:
	https://lore.kernel.org/lkml/20211021122758.3092-2-caihuoqing@baidu.com/

 include/linux/kthread.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 346b0f269161..db47aae7c481 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -56,6 +56,31 @@ bool kthread_is_per_cpu(struct task_struct *k);
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
+static inline struct task_struct *
+kthread_run_on_cpu(int (*threadfn)(void *data), void *data,
+			unsigned int cpu, const char *namefmt)
+{
+	struct task_struct *p;
+
+	p = kthread_create_on_cpu(threadfn, data, cpu, namefmt);
+	if (!IS_ERR(p))
+		wake_up_process(p);
+
+	return p;
+}
+
 void free_kthread_struct(struct task_struct *k);
 void kthread_bind(struct task_struct *k, unsigned int cpu);
 void kthread_bind_mask(struct task_struct *k, const struct cpumask *mask);
-- 
2.25.1

