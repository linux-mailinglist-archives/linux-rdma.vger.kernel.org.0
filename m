Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F8D14C15C
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2020 21:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgA1UFI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jan 2020 15:05:08 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:47040 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgA1UFI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jan 2020 15:05:08 -0500
Received: by mail-qk1-f196.google.com with SMTP id g195so14636992qke.13
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jan 2020 12:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qHGvnNm431ADLVjT7HmJIlWBbLmY8xDPaZOXmUYqn+c=;
        b=WJrQj0O6fd4fAtWq13BHUq6zi2S+GhF6R4xCH1wwUVIrGdYDTz8Cpx3lqZVEQiiWa+
         6QG+lYsQ6Y8/yyLs1aNrdWHE6T3asJum44AnIbXODfv1Ew4bM+443ESco+vvF5af0MVP
         9UCDrwrpiuke/I2N+b8LcAzoOR3dEaKZyAftIV6IP/yDZl2s+hvSeXN5lRMFG1Djf6IE
         WJCurw8Cv5qGxQ1lk/uGmx7MbtlAp+WDAtasHU9BQgcQG18lGDwLeZZSz5a5kNu8he/9
         bluMnAbzsMcQfacL4n8yEP3R5XQmhUTS8UEZaeqUeTygNPCBZmHO/DpAZNvzu6lPdg4x
         FQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qHGvnNm431ADLVjT7HmJIlWBbLmY8xDPaZOXmUYqn+c=;
        b=LbF4isZWeM2FTSbDtk6CdrJIxjWH4GNP1AXEBq74SMSuh14SMHD1SDkYsV75YP1ZSL
         dRef+BJXKwxQ/RkiDQr/5bPSVWgO8G+nwuDSH7f9F3c69BbjjZr+nIjhVmoJmN5abIOu
         g0zqrRp0hUJ9KMp+Iyedpl2QT8ug8WFAhdJTzWnS8EEFN7pc7M/6OyJag0m224yCM4MM
         deA2sgoK5Xc8irBY2Q4eHShB0g/gy4ty1P0D6xb7dSmLm9fgqCMNCzlI6hVQH6jBQflO
         yueUWugB9mLnxnAeMRncL544LGt1jnasaTrW8/KRjq22Z1cmZ9adHgPP0462hQyhvtc5
         xqaA==
X-Gm-Message-State: APjAAAX2E/V2jxon6X7oJSj0pWjMEBZrViCnjcY2pqi4r/YgISTgvnFc
        oTSO0CcMJ3fuks50pB3Bar+uSg==
X-Google-Smtp-Source: APXvYqy1ALMlfxMj/kDUI3tJA9ltyhtpQEzfvKmuQsl4GHAkQ+hT9gXd/W2jsVMbU2omHSVVfMaUbQ==
X-Received: by 2002:a37:4b8b:: with SMTP id y133mr23863962qka.210.1580241907210;
        Tue, 28 Jan 2020 12:05:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t23sm4205702qtp.82.2020.01.28.12.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Jan 2020 12:05:06 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iwX6f-000671-SV; Tue, 28 Jan 2020 16:05:05 -0400
Date:   Tue, 28 Jan 2020 16:05:05 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yixian Liu <liuyixian@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v7 for-next 2/2] RDMA/hns: Delayed flush cqe process with
 workqueue
Message-ID: <20200128200505.GB8107@ziepe.ca>
References: <1579081753-2839-1-git-send-email-liuyixian@huawei.com>
 <1579081753-2839-3-git-send-email-liuyixian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579081753-2839-3-git-send-email-liuyixian@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 15, 2020 at 05:49:13PM +0800, Yixian Liu wrote:
> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> index fa38582..ad7ed07 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -56,10 +56,16 @@ static void flush_work_handle(struct work_struct *work)
>  	attr_mask = IB_QP_STATE;
>  	attr.qp_state = IB_QPS_ERR;
>  
> -	ret = hns_roce_modify_qp(&hr_qp->ibqp, &attr, attr_mask, NULL);
> -	if (ret)
> -		dev_err(dev, "Modify QP to error state failed(%d) during CQE flush\n",
> -			ret);
> +	while (atomic_read(&hr_qp->flush_cnt)) {
> +		ret = hns_roce_modify_qp(&hr_qp->ibqp, &attr, attr_mask, NULL);
> +		if (ret)
> +			dev_err(dev, "Modify QP to error state failed(%d) during CQE flush\n",
> +				ret);
> +
> +		/* If flush_cnt larger than 1, only need one more time flush */
> +		if (atomic_dec_and_test(&hr_qp->flush_cnt))
> +			atomic_set(&hr_qp->flush_cnt, 1);
> +	}

And this while loop is just 

if (atomic_xchg(&hr_qp->flush_cnt, 0)) {
  [..]
}

I'm not even sure this needs to be a counter, all you need is set_bit()
and test_and_clear()

Jason
