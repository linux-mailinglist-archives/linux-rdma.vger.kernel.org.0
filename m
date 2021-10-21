Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989C2436376
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 15:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhJUNz2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 09:55:28 -0400
Received: from mx24.baidu.com ([111.206.215.185]:58514 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231431AbhJUNz1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 09:55:27 -0400
Received: from BJHW-Mail-Ex14.internal.baidu.com (unknown [10.127.64.37])
        by Forcepoint Email with ESMTPS id 5C8913B2146AA655D59E;
        Thu, 21 Oct 2021 21:53:09 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex14.internal.baidu.com (10.127.64.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 21 Oct 2021 21:53:09 +0800
Received: from localhost (172.31.63.8) by BJHW-MAIL-EX27.internal.baidu.com
 (10.127.64.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 21
 Oct 2021 21:53:08 +0800
Date:   Thu, 21 Oct 2021 21:53:12 +0800
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
Message-ID: <20211021135312.GA3400@LAPTOP-UKSR4ENP.internal.baidu.com>
References: <20211021120135.3003-1-caihuoqing@baidu.com>
 <20211021120135.3003-2-caihuoqing@baidu.com>
 <20211021091001.26c24d5b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211021091001.26c24d5b@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex11.internal.baidu.com (172.31.51.51) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex14_2021-10-21 21:53:09:345
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 21 10月 21 09:10:01, Steven Rostedt wrote:
> On Thu, 21 Oct 2021 20:01:30 +0800
> Cai Huoqing <caihuoqing@baidu.com> wrote:
> 
> > the helper macro kthread_run_on_cpu() inculdes
> 
>  "includes"
> 
> > kthread_create_on_cpu/wake_up_process().
> > In some cases, use kthread_run_on_cpu() directly instead of
> > kthread_create_on_node/kthread_bind/wake_up_process() or
> > kthread_create_on_cpu/wake_up_process() or
> > kthreadd_create/kthread_bind/wake_up_process() to simplify the code.
> > 
> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> > ---
> >  include/linux/kthread.h | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/include/linux/kthread.h b/include/linux/kthread.h
> > index 346b0f269161..dfd125523aa9 100644
> > --- a/include/linux/kthread.h
> > +++ b/include/linux/kthread.h
> > @@ -56,6 +56,28 @@ bool kthread_is_per_cpu(struct task_struct *k);
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
> > + * Description: Convenient wrapper for kthread_create_on_node()
> > + * followed by wake_up_process().  Returns the kthread or
> > + * ERR_PTR(-ENOMEM).
> > + */
> > +#define kthread_run_on_cpu(threadfn, data, cpu, namefmt)		  \
> 
> Why is this a macro and not a static inline function?
> 
> -- Steve
Hi,Thanks for your feedback,

I think using static inline function is nice, but here try to keep
consistent with the other macros,
sush as kthread_create/kthread_init_work...

Thanks,
Cai.
> 
> > +({									  \
> > +	struct task_struct *__k						  \
> > +		= kthread_create_on_cpu(threadfn, data, cpu_to_node(cpu), \
> > +					namefmt);			  \
> > +	if (!IS_ERR(__k))						  \
> > +		wake_up_process(__k);					  \
> > +	__k;								  \
> > +})
> > +
> >  void free_kthread_struct(struct task_struct *k);
> >  void kthread_bind(struct task_struct *k, unsigned int cpu);
> >  void kthread_bind_mask(struct task_struct *k, const struct cpumask *mask);
> 
