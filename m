Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755CC453B61
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Nov 2021 22:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhKPVEv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 16 Nov 2021 16:04:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231624AbhKPVEu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Nov 2021 16:04:50 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A76461A8D;
        Tue, 16 Nov 2021 21:01:51 +0000 (UTC)
Date:   Tue, 16 Nov 2021 16:01:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Cai,Huoqing" <caihuoqing@baidu.com>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
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
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/6] kthread: Add the helper function
 kthread_run_on_cpu()
Message-ID: <20211116160150.44267ea8@gandalf.local.home>
In-Reply-To: <40fae23eb02c4363bc75649e23f78c1c@baidu.com>
References: <20211022025711.3673-1-caihuoqing@baidu.com>
        <20211022025711.3673-2-caihuoqing@baidu.com>
        <40fae23eb02c4363bc75649e23f78c1c@baidu.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 26 Oct 2021 08:32:30 +0000
"Cai,Huoqing" <caihuoqing@baidu.com> wrote:

> Hello,
> Just a ping, to see if there are any more comments :-P

I have no real issue with this patch set. As it seems to be a generic clean
up, perhaps Andrew might like to take a look at it, and if he's fine with
it, he can take it through his tree?

-- Steve


> > -----Original Message-----
> > From: Cai,Huoqing <caihuoqing@baidu.com>
> > Sent: 2021年10月22日 10:57
> > Subject: [PATCH v3 1/6] kthread: Add the helper function kthread_run_on_cpu()
> > 
> > the helper function kthread_run_on_cpu() includes
> > kthread_create_on_cpu/wake_up_process().
> > In some cases, use kthread_run_on_cpu() directly instead of
> > kthread_create_on_node/kthread_bind/wake_up_process() or
> > kthread_create_on_cpu/wake_up_process() or
> > kthreadd_create/kthread_bind/wake_up_process() to simplify the code.
> > 
> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> > ---
> > v1->v2:
> > 	*Remove cpu_to_node from kthread_create_on_cpu params.
> > 	*Updated the macro description comment.
> > v2->v3:
> > 	*Convert this helper macro to static inline function
> > 	*Fix typo in changelog
> > 
> > v1 link:
> > 	https://lore.kernel.org/lkml/20211021120135.3003-2-
> > caihuoqing@baidu.com/
> > v2 link:
> > 	https://lore.kernel.org/lkml/20211021122758.3092-2-
> > caihuoqing@baidu.com/
> > 
> >  include/linux/kthread.h | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/include/linux/kthread.h b/include/linux/kthread.h
> > index 346b0f269161..db47aae7c481 100644
> > --- a/include/linux/kthread.h
> > +++ b/include/linux/kthread.h
> > @@ -56,6 +56,31 @@ bool kthread_is_per_cpu(struct task_struct *k);
> >  	__k;								   \
> >  })
> > 
> > +/**
> > + * kthread_run_on_cpu - create and wake a cpu bound thread.
> > + * @threadfn: the function to run until signal_pending(current).
> > + * @data: data ptr for @threadfn.
> > + * @cpu: The cpu on which the thread should be bound,
> > + * @namefmt: printf-style name for the thread. Format is restricted
> > + *	     to "name.*%u". Code fills in cpu number.
> > + *
> > + * Description: Convenient wrapper for kthread_create_on_cpu()
> > + * followed by wake_up_process().  Returns the kthread or
> > + * ERR_PTR(-ENOMEM).
> > + */
> > +static inline struct task_struct *
> > +kthread_run_on_cpu(int (*threadfn)(void *data), void *data,
> > +			unsigned int cpu, const char *namefmt)
> > +{
> > +	struct task_struct *p;
> > +
> > +	p = kthread_create_on_cpu(threadfn, data, cpu, namefmt);
> > +	if (!IS_ERR(p))
> > +		wake_up_process(p);
> > +
> > +	return p;
> > +}
> > +
> >  void free_kthread_struct(struct task_struct *k);
> >  void kthread_bind(struct task_struct *k, unsigned int cpu);
> >  void kthread_bind_mask(struct task_struct *k, const struct cpumask *mask);
> > --
> > 2.25.1  
> 

