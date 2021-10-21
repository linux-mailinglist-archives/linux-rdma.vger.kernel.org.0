Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535FB4361A0
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 14:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhJUMao (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 08:30:44 -0400
Received: from mx24.baidu.com ([111.206.215.185]:42188 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231297AbhJUMal (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 08:30:41 -0400
Received: from BC-Mail-Ex25.internal.baidu.com (unknown [172.31.51.19])
        by Forcepoint Email with ESMTPS id D8679228D1FD6CAE5394;
        Thu, 21 Oct 2021 20:28:23 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex25.internal.baidu.com (172.31.51.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 21 Oct 2021 20:28:23 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 21 Oct 2021 20:28:22 +0800
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
Subject: [PATCH v2 4/6] rcutorture: Make use of the helper macro kthread_run_on_cpu()
Date:   Thu, 21 Oct 2021 20:27:55 +0800
Message-ID: <20211021122758.3092-5-caihuoqing@baidu.com>
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

Repalce kthread_create_on_node//kthread_bind/wake_up_process()
with kthread_run_on_cpu() to simplify the code.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 kernel/rcu/rcutorture.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 503e14e62e8f..6c3ba8c0d7ff 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2025,9 +2025,8 @@ static int rcutorture_booster_init(unsigned int cpu)
 	mutex_lock(&boost_mutex);
 	rcu_torture_disable_rt_throttle();
 	VERBOSE_TOROUT_STRING("Creating rcu_torture_boost task");
-	boost_tasks[cpu] = kthread_create_on_node(rcu_torture_boost, NULL,
-						  cpu_to_node(cpu),
-						  "rcu_torture_boost");
+	boost_tasks[cpu] = kthread_run_on_cpu(rcu_torture_boost, NULL,
+					      cpu, "rcu_torture_boost_%u");
 	if (IS_ERR(boost_tasks[cpu])) {
 		retval = PTR_ERR(boost_tasks[cpu]);
 		VERBOSE_TOROUT_STRING("rcu_torture_boost task create failed");
@@ -2036,8 +2035,6 @@ static int rcutorture_booster_init(unsigned int cpu)
 		mutex_unlock(&boost_mutex);
 		return retval;
 	}
-	kthread_bind(boost_tasks[cpu], cpu);
-	wake_up_process(boost_tasks[cpu]);
 	mutex_unlock(&boost_mutex);
 	return 0;
 }
-- 
2.25.1

