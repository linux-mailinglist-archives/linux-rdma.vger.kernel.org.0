Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6A51153989
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2020 21:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgBEUan (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Feb 2020 15:30:43 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43522 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBEUam (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Feb 2020 15:30:42 -0500
Received: by mail-qk1-f196.google.com with SMTP id j20so3243027qka.10
        for <linux-rdma@vger.kernel.org>; Wed, 05 Feb 2020 12:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ab6gK2EvR8F4yT17ZLxM8mArNW0sif3F4cu8wMTyywc=;
        b=H++S+5BOVLzvWf68YMbkqRW4PuwJ/CJ1UcvFKZjLjOJeiTS5cf8KstQ5aTzWd0NF8/
         mPe5plStCJXtt2jRQj7001k0wAZ3GETe4BG7iNbY3QbS5xo6te8rFlbdbYEtCMsEQ9Xo
         7y8BTl83hu6WnbAZgSIjpPRM7NAVS34FM6ex1PB1R7475VgdiRIibqgwmyq6gMdZz5kF
         y0bHn2Csz9t4xe2zgBfdHI6I9KczeO4ZSCbYJE8NoVuf3ctNEn6DKu7XfBVvkCr2pd4E
         WASl+Kpo6qjKRQGf/igmXF7/hrmpvMR4hIFaoCmWeeC+0nOHRHKGg1zQOOBgnu3yRkwW
         G1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ab6gK2EvR8F4yT17ZLxM8mArNW0sif3F4cu8wMTyywc=;
        b=Znov1tBP055wsZg58du0SywmqCFjQ3qka07t6yuMsckPHMf7sO0R7lUPUjfa4iksuq
         96w9MFR3zdkj4/+jjqoxSXJa8Ovi9CV6ckWI3xujTuJLprmdLAV2ss8ipq9vfRBDVEt2
         NVRU5tc0Bxf7xpcADEunlclrqTxoT2P8dfTyjhDbWEjjnNdPwcnMVNbKsDkheaPi6Rg5
         u0/qk5vdAU5RVP45TZ8NomBDs9obnYPQIFiudu/O7AGIUuCTuvlmMc8cyJiSY1ksn0Ur
         vLElxWPaSN5yGZabVxAvTIYUaLuDoHxcrS+wjr6uHss4apLBBeSGHs5YVQMXxpTkA1eV
         NDOg==
X-Gm-Message-State: APjAAAXOn+ZQ4su4tabTj7d8RszvxNumtYXdDq0DYT274XoDZBdEDlnJ
        qKsB0BcfPINQA0lflPaxdoGKxMS82SM=
X-Google-Smtp-Source: APXvYqw9KUURw+znCaSyGns6tfJS/+1nfYtIQqpWJbIEgNgIxGmtwn3KFIR7p3YnICAbmrE4UgDtqg==
X-Received: by 2002:a05:620a:a97:: with SMTP id v23mr34773342qkg.251.1580934641790;
        Wed, 05 Feb 2020 12:30:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t37sm524569qth.0.2020.02.05.12.30.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2020 12:30:41 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1izRJo-0007Ve-7C; Wed, 05 Feb 2020 16:30:40 -0400
Date:   Wed, 5 Feb 2020 16:30:40 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Liuyixian (Eason)" <liuyixian@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v7 for-next 2/2] RDMA/hns: Delayed flush cqe process with
 workqueue
Message-ID: <20200205203040.GA25297@ziepe.ca>
References: <1579081753-2839-1-git-send-email-liuyixian@huawei.com>
 <1579081753-2839-3-git-send-email-liuyixian@huawei.com>
 <20200128200505.GB8107@ziepe.ca>
 <f4794cf0-e9db-540b-9752-761734edef5a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4794cf0-e9db-540b-9752-761734edef5a@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 04, 2020 at 04:47:38PM +0800, Liuyixian (Eason) wrote:
> 
> 
> On 2020/1/29 4:05, Jason Gunthorpe wrote:
> > On Wed, Jan 15, 2020 at 05:49:13PM +0800, Yixian Liu wrote:
> >> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> >> index fa38582..ad7ed07 100644
> >> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> >> @@ -56,10 +56,16 @@ static void flush_work_handle(struct work_struct *work)
> >>  	attr_mask = IB_QP_STATE;
> >>  	attr.qp_state = IB_QPS_ERR;
> >>  
> >> -	ret = hns_roce_modify_qp(&hr_qp->ibqp, &attr, attr_mask, NULL);
> >> -	if (ret)
> >> -		dev_err(dev, "Modify QP to error state failed(%d) during CQE flush\n",
> >> -			ret);
> >> +	while (atomic_read(&hr_qp->flush_cnt)) {
> >> +		ret = hns_roce_modify_qp(&hr_qp->ibqp, &attr, attr_mask, NULL);
> >> +		if (ret)
> >> +			dev_err(dev, "Modify QP to error state failed(%d) during CQE flush\n",
> >> +				ret);
> >> +
> >> +		/* If flush_cnt larger than 1, only need one more time flush */
> >> +		if (atomic_dec_and_test(&hr_qp->flush_cnt))
> >> +			atomic_set(&hr_qp->flush_cnt, 1);
> >> +	}
> > 
> > And this while loop is just 
> 
> There is a bug here, the code should be:
> if (!atomic_dec_and_test(&hr_qp->flush_cnt))
> 	atomic_set(&hr_qp->flush_cnt, 1);
> 
> It merges all further flush operation requirements into only one more time flush,
> that is, do the loop once again if flush_cnt larger than 1.
> 
> > 
> > if (atomic_xchg(&hr_qp->flush_cnt, 0)) {
> >   [..]
> > }
> 
> I think we can't use if instead of while loop.

Well, you can't do two operations and still have an atomic, so you
have to fix it somehow. Possibly this needs a spinlock approach
instead.

> With your solution, when user posts a new wr during the
> implementation of [...] in if condition, it will re-queue a new
> init_flush_work, which will lead to a multiple call problem as we
> discussed in v2.

queue_work can be called while a work is still running, it just makes
sure it will run again.

> > I'm not even sure this needs to be a counter, all you need is set_bit()
> > and test_and_clear()
> 
> We need the value of flush_cnt large than 1 to record further flush
> requirements, that's why flush_cnt can be defined as a flag or bit
> value.

This explanation doesn't make sense, the counter isn't being used to
count anything, it is just a flag.

Jason
