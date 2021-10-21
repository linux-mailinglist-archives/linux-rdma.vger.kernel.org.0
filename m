Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740864363C3
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 16:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhJUOKL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 10:10:11 -0400
Received: from mx22.baidu.com ([220.181.50.185]:41234 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229878AbhJUOKK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 10:10:10 -0400
Received: from BC-Mail-Ex31.internal.baidu.com (unknown [172.31.51.25])
        by Forcepoint Email with ESMTPS id 5EC8FA995A63A3F0F11B;
        Thu, 21 Oct 2021 22:07:52 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex31.internal.baidu.com (172.31.51.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 21 Oct 2021 22:07:52 +0800
Received: from localhost (172.31.63.8) by BJHW-MAIL-EX27.internal.baidu.com
 (10.127.64.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 21
 Oct 2021 22:07:51 +0800
Date:   Thu, 21 Oct 2021 22:07:55 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/6] kthread: Add the helper macro kthread_run_on_cpu()
Message-ID: <20211021140755.GA3448@LAPTOP-UKSR4ENP.internal.baidu.com>
References: <20211021120135.3003-1-caihuoqing@baidu.com>
 <OFACD03FD5.99AACE16-ON00258775.004BD474-00258775.004BD47C@ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OFACD03FD5.99AACE16-ON00258775.004BD474-00258775.004BD47C@ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex10.internal.baidu.com (172.31.51.50) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 21 10月 21 13:48:15, Bernard Metzler wrote:
> -----"Cai Huoqing" <caihuoqing@baidu.com> wrote: -----
> 
> >To: <caihuoqing@baidu.com>
> >From: "Cai Huoqing" <caihuoqing@baidu.com>
> >Date: 10/21/2021 02:02PM
> >Cc: "Bernard Metzler" <bmt@zurich.ibm.com>, "Doug Ledford"
> ><dledford@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Davidlohr
> >Bueso" <dave@stgolabs.net>, "Paul E. McKenney" <paulmck@kernel.org>,
> >"Josh Triplett" <josh@joshtriplett.org>, "Steven Rostedt"
> ><rostedt@goodmis.org>, "Mathieu Desnoyers"
> ><mathieu.desnoyers@efficios.com>, "Lai Jiangshan"
> ><jiangshanlai@gmail.com>, "Joel Fernandes" <joel@joelfernandes.org>,
> >"Ingo Molnar" <mingo@redhat.com>, "Daniel Bristot de Oliveira"
> ><bristot@kernel.org>, <linux-rdma@vger.kernel.org>,
> ><linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>
> >Subject: [EXTERNAL] [PATCH 0/6] kthread: Add the helper macro
> >kthread_run_on_cpu()
> >
> >the helper macro kthread_run_on_cpu() inculdes
> >kthread_create_on_cpu/wake_up_process().
> >In some cases, use kthread_run_on_cpu() directly instead of
> >kthread_create_on_node/kthread_bind/wake_up_process() or
> >kthread_create_on_cpu/wake_up_process() or
> >kthreadd_create/kthread_bind/wake_up_process() to simplify the code.
> 
> I do not see kthread_bind() being covered by the helper,
> as claimed? rcutorture, ring-buffer, siw are using it in
> the code potentially being replaced by the helper.
> kthread_bind() is best to be called before thread starts
> running, so should be part of it.
Hi,
kthread_bind() is already part of kthread_create_on_cpu which is
called by kthread_run_on_cpu() here.

Thanks,
Cai.
> 
> Thanks,
> Bernard.
> >
> >Cai Huoqing (6):
> >  kthread: Add the helper macro kthread_run_on_cpu()
> >  RDMA/siw: Make use of the helper macro kthread_run_on_cpu()
> >  ring-buffer: Make use of the helper macro kthread_run_on_cpu()
> >  rcutorture: Make use of the helper macro kthread_run_on_cpu()
> >  trace/osnoise: Make use of the helper macro kthread_run_on_cpu()
> >  trace/hwlat: Make use of the helper macro kthread_run_on_cpu()
> >
> > drivers/infiniband/sw/siw/siw_main.c |  7 +++----
> > include/linux/kthread.h              | 22 ++++++++++++++++++++++
> > kernel/rcu/rcutorture.c              |  7 ++-----
> > kernel/trace/ring_buffer.c           |  7 ++-----
> > kernel/trace/trace_hwlat.c           |  6 +-----
> > kernel/trace/trace_osnoise.c         |  3 +--
> > 6 files changed, 31 insertions(+), 21 deletions(-)
> >
> >-- 
> >2.25.1
> >
> >
