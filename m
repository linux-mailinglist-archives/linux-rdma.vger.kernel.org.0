Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3656B43704A
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Oct 2021 04:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbhJVDBo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 23:01:44 -0400
Received: from mx24.baidu.com ([111.206.215.185]:50834 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232719AbhJVDBj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 23:01:39 -0400
Received: from BC-Mail-EX08.internal.baidu.com (unknown [172.31.51.48])
        by Forcepoint Email with ESMTPS id D41EB5A03CA4A1B0F532;
        Fri, 22 Oct 2021 10:59:20 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-EX08.internal.baidu.com (172.31.51.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Fri, 22 Oct 2021 10:59:20 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 22 Oct 2021 10:59:19 +0800
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
Subject: [PATCH v3 5/6] trace/osnoise: Make use of the helper function kthread_run_on_cpu()
Date:   Fri, 22 Oct 2021 10:57:08 +0800
Message-ID: <20211022025711.3673-6-caihuoqing@baidu.com>
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

Replace kthread_create_on_cpu/wake_up_process()
with kthread_run_on_cpu() to simplify the code.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 kernel/trace/trace_osnoise.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index ce053619f289..cbd78fd5e491 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1525,7 +1525,7 @@ static int start_kthread(unsigned int cpu)
 #else
 	snprintf(comm, 24, "osnoise/%d", cpu);
 #endif
-	kthread = kthread_create_on_cpu(main, NULL, cpu, comm);
+	kthread = kthread_run_on_cpu(main, NULL, cpu, comm);
 
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
@@ -1534,7 +1534,6 @@ static int start_kthread(unsigned int cpu)
 	}
 
 	per_cpu(per_cpu_osnoise_var, cpu).kthread = kthread;
-	wake_up_process(kthread);
 
 	return 0;
 }
-- 
2.25.1

