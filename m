Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CF54360ED
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 14:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhJUMEI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 08:04:08 -0400
Received: from mx24.baidu.com ([111.206.215.185]:42234 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230231AbhJUMEH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 08:04:07 -0400
Received: from BC-Mail-Ex14.internal.baidu.com (unknown [172.31.51.54])
        by Forcepoint Email with ESMTPS id 2F5A7EB1F769EEB57D21;
        Thu, 21 Oct 2021 20:01:42 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex14.internal.baidu.com (172.31.51.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 21 Oct 2021 20:01:42 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 21 Oct 2021 20:01:40 +0800
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
Subject: [PATCH 0/6] kthread: Add the helper macro kthread_run_on_cpu()
Date:   Thu, 21 Oct 2021 20:01:29 +0800
Message-ID: <20211021120135.3003-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-EX04.internal.baidu.com (172.31.51.44) To
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

Cai Huoqing (6):
  kthread: Add the helper macro kthread_run_on_cpu()
  RDMA/siw: Make use of the helper macro kthread_run_on_cpu()
  ring-buffer: Make use of the helper macro kthread_run_on_cpu()
  rcutorture: Make use of the helper macro kthread_run_on_cpu()
  trace/osnoise: Make use of the helper macro kthread_run_on_cpu()
  trace/hwlat: Make use of the helper macro kthread_run_on_cpu()

 drivers/infiniband/sw/siw/siw_main.c |  7 +++----
 include/linux/kthread.h              | 22 ++++++++++++++++++++++
 kernel/rcu/rcutorture.c              |  7 ++-----
 kernel/trace/ring_buffer.c           |  7 ++-----
 kernel/trace/trace_hwlat.c           |  6 +-----
 kernel/trace/trace_osnoise.c         |  3 +--
 6 files changed, 31 insertions(+), 21 deletions(-)

-- 
2.25.1

