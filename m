Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40F9436270
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 15:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhJUNMW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 09:12:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231346AbhJUNMV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 09:12:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 547BF60ED5;
        Thu, 21 Oct 2021 13:10:04 +0000 (UTC)
Date:   Thu, 21 Oct 2021 09:10:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/6] kthread: Add the helper macro kthread_run_on_cpu()
Message-ID: <20211021091001.26c24d5b@gandalf.local.home>
In-Reply-To: <20211021120135.3003-2-caihuoqing@baidu.com>
References: <20211021120135.3003-1-caihuoqing@baidu.com>
        <20211021120135.3003-2-caihuoqing@baidu.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 21 Oct 2021 20:01:30 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> the helper macro kthread_run_on_cpu() inculdes

 "includes"

> kthread_create_on_cpu/wake_up_process().
> In some cases, use kthread_run_on_cpu() directly instead of
> kthread_create_on_node/kthread_bind/wake_up_process() or
> kthread_create_on_cpu/wake_up_process() or
> kthreadd_create/kthread_bind/wake_up_process() to simplify the code.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  include/linux/kthread.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/linux/kthread.h b/include/linux/kthread.h
> index 346b0f269161..dfd125523aa9 100644
> --- a/include/linux/kthread.h
> +++ b/include/linux/kthread.h
> @@ -56,6 +56,28 @@ bool kthread_is_per_cpu(struct task_struct *k);
>  	__k;								   \
>  })
>  
> +/**
> + * kthread_run_on_cpu - create and wake a cpu bound thread.
> + * @threadfn: the function to run until signal_pending(current).
> + * @data: data ptr for @threadfn.
> + * @cpu: The cpu on which the thread should be bound,
> + * @namefmt: printf-style name for the thread. Format is restricted
> + *	     to "name.*%u". Code fills in cpu number.
> + *
> + * Description: Convenient wrapper for kthread_create_on_node()
> + * followed by wake_up_process().  Returns the kthread or
> + * ERR_PTR(-ENOMEM).
> + */
> +#define kthread_run_on_cpu(threadfn, data, cpu, namefmt)		  \

Why is this a macro and not a static inline function?

-- Steve

> +({									  \
> +	struct task_struct *__k						  \
> +		= kthread_create_on_cpu(threadfn, data, cpu_to_node(cpu), \
> +					namefmt);			  \
> +	if (!IS_ERR(__k))						  \
> +		wake_up_process(__k);					  \
> +	__k;								  \
> +})
> +
>  void free_kthread_struct(struct task_struct *k);
>  void kthread_bind(struct task_struct *k, unsigned int cpu);
>  void kthread_bind_mask(struct task_struct *k, const struct cpumask *mask);

