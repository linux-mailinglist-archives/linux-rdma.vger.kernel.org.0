Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CA1437044
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Oct 2021 04:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhJVDBe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 23:01:34 -0400
Received: from mx24.baidu.com ([111.206.215.185]:50476 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232673AbhJVDBc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 23:01:32 -0400
Received: from BC-Mail-Ex06.internal.baidu.com (unknown [172.31.51.46])
        by Forcepoint Email with ESMTPS id CD3A3B9D11194F42EE09;
        Fri, 22 Oct 2021 10:59:11 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex06.internal.baidu.com (172.31.51.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Fri, 22 Oct 2021 10:59:11 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 22 Oct 2021 10:59:10 +0800
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
Subject: [PATCH v3 2/6] RDMA/siw: Make use of the helper function kthread_run_on_cpu()
Date:   Fri, 22 Oct 2021 10:57:05 +0800
Message-ID: <20211022025711.3673-3-caihuoqing@baidu.com>
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

Replace kthread_create/kthread_bind/wake_up_process()
with kthread_run_on_cpu() to simplify the code.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/infiniband/sw/siw/siw_main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 9093e6a80b26..e5c586913d0b 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -98,15 +98,14 @@ static int siw_create_tx_threads(void)
 			continue;
 
 		siw_tx_thread[cpu] =
-			kthread_create(siw_run_sq, (unsigned long *)(long)cpu,
-				       "siw_tx/%d", cpu);
+			kthread_run_on_cpu(siw_run_sq,
+					   (unsigned long *)(long)cpu,
+					   cpu, "siw_tx/%u");
 		if (IS_ERR(siw_tx_thread[cpu])) {
 			siw_tx_thread[cpu] = NULL;
 			continue;
 		}
-		kthread_bind(siw_tx_thread[cpu], cpu);
 
-		wake_up_process(siw_tx_thread[cpu]);
 		assigned++;
 	}
 	return assigned;
-- 
2.25.1

