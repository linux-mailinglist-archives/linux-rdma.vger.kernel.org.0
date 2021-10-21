Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BD34360F6
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 14:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhJUMEl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 08:04:41 -0400
Received: from mx22.baidu.com ([220.181.50.185]:42860 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231560AbhJUMEf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 08:04:35 -0400
Received: from BC-Mail-Ex06.internal.baidu.com (unknown [172.31.51.46])
        by Forcepoint Email with ESMTPS id 0230A1FB162E2EA254AD;
        Thu, 21 Oct 2021 20:02:18 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex06.internal.baidu.com (172.31.51.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 21 Oct 2021 20:02:17 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 21 Oct 2021 20:02:16 +0800
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
Subject: [PATCH 3/6] ring-buffer: Make use of the helper macro kthread_run_on_cpu()
Date:   Thu, 21 Oct 2021 20:01:32 +0800
Message-ID: <20211021120135.3003-4-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021120135.3003-1-caihuoqing@baidu.com>
References: <20211021120135.3003-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-EX04.internal.baidu.com (172.31.51.44) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Repalce kthread_create/kthread_bind/wake_up_process()
with kthread_run_on_cpu() to simplify the code.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 kernel/trace/ring_buffer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c5a3fbf19617..afb306e21e5b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5898,16 +5898,13 @@ static __init int test_ringbuffer(void)
 		rb_data[cpu].buffer = buffer;
 		rb_data[cpu].cpu = cpu;
 		rb_data[cpu].cnt = cpu;
-		rb_threads[cpu] = kthread_create(rb_test, &rb_data[cpu],
-						 "rbtester/%d", cpu);
+		rb_threads[cpu] = kthread_run_on_cpu(rb_test, &rb_data[cpu],
+						     cpu, "rbtester/%u");
 		if (WARN_ON(IS_ERR(rb_threads[cpu]))) {
 			pr_cont("FAILED\n");
 			ret = PTR_ERR(rb_threads[cpu]);
 			goto out_free;
 		}
-
-		kthread_bind(rb_threads[cpu], cpu);
- 		wake_up_process(rb_threads[cpu]);
 	}
 
 	/* Now create the rb hammer! */
-- 
2.25.1

