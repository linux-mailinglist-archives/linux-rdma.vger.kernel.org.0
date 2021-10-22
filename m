Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED5943705E
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Oct 2021 05:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhJVDIA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 23:08:00 -0400
Received: from mx22.baidu.com ([220.181.50.185]:57914 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232508AbhJVDH7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 23:07:59 -0400
Received: from BC-Mail-Ex18.internal.baidu.com (unknown [172.31.51.12])
        by Forcepoint Email with ESMTPS id 13DE3CBE79C2B0832747;
        Fri, 22 Oct 2021 11:05:21 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex18.internal.baidu.com (172.31.51.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Fri, 22 Oct 2021 11:05:20 +0800
Received: from localhost (172.31.63.8) by BJHW-MAIL-EX27.internal.baidu.com
 (10.127.64.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 22
 Oct 2021 11:05:20 +0800
Date:   Fri, 22 Oct 2021 11:05:24 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/6] kthread: Add the helper macro kthread_run_on_cpu()
Message-ID: <20211022030524.GA3762@LAPTOP-UKSR4ENP.internal.baidu.com>
References: <20211021120135.3003-1-caihuoqing@baidu.com>
 <20211021120135.3003-2-caihuoqing@baidu.com>
 <20211021091001.26c24d5b@gandalf.local.home>
 <20211021135312.GA3400@LAPTOP-UKSR4ENP.internal.baidu.com>
 <20211021095858.51d600fc@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211021095858.51d600fc@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex18.internal.baidu.com (172.31.51.12) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 21 10月 21 09:58:58, Steven Rostedt wrote:
> On Thu, 21 Oct 2021 21:53:12 +0800
> Cai Huoqing <caihuoqing@baidu.com> wrote:
> 
> > > > +/**
> > > > + * kthread_run_on_cpu - create and wake a cpu bound thread.
> > > > + * @threadfn: the function to run until signal_pending(current).
> > > > + * @data: data ptr for @threadfn.
> > > > + * @cpu: The cpu on which the thread should be bound,
> > > > + * @namefmt: printf-style name for the thread. Format is restricted
> > > > + *	     to "name.*%u". Code fills in cpu number.
> > > > + *
> > > > + * Description: Convenient wrapper for kthread_create_on_node()
> > > > + * followed by wake_up_process().  Returns the kthread or
> > > > + * ERR_PTR(-ENOMEM).
> > > > + */
> > > > +#define kthread_run_on_cpu(threadfn, data, cpu, namefmt)		  \  
> > > 
> > > Why is this a macro and not a static inline function?
> > > 
> > > -- Steve  
> > Hi,Thanks for your feedback,
> > 
> > I think using static inline function is nice, but here try to keep
> > consistent with the other macros,
> > sush as kthread_create/kthread_init_work...
> 
> Which they did because they didn't want to use va_list to have variable
> arguments, which you don't have.
> 
> Which begs the question, should you?
> 
> -- Steve
Hi, Thanks your reply.

I get it, V3 here:
https://lore.kernel.org/lkml/20211022025711.3673-2-caihuoqing@baidu.com/

Thanks,
Cai
