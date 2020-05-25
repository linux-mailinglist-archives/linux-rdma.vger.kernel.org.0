Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020EF1E1170
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 17:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391041AbgEYPO2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 11:14:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36461 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390998AbgEYPO1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 11:14:27 -0400
Received: by mail-pl1-f196.google.com with SMTP id bg4so2281859plb.3
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 08:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pQIaqg6vOScDn8TuMxQJdAT5NeQRfEOse6mbkGyRrts=;
        b=Kmqlp/0TvDp3zbgC3MNgCi/2UHH222Lj24HjWuujfEBSsNj60GqggVYr82yW3PxGnq
         UTLiW/dhv2upV0ym2H9vDt0bjNqqxbVNLZkM5l1+ciFIM5ZizOwwcx8EgzQEoNoG5F9d
         Ujxebb10uMKBoa1ZrUTms+W1mJ+UhEuIbwrof6ExdrCumeO7gNSoJAHHCcYQUImyL8xM
         uAhY1N5FTb5BWKtOJQjSejZl5aVr0OvlnNxGyABms6tDW6tHlNH1UmEg/Asv/KyrPAJ3
         J/+qKzjRwqYFrE7C8cjlKjXbbVmzZqVxuEhMT4hOPV406pePLRPMux76tro8b3vlyaZ7
         AqbQ==
X-Gm-Message-State: AOAM530DfY6UJT5WUmZSZOF7C9ywu/t0/2lB/kM++iKB72vW8bpreOVZ
        OoakgMJBeiAjPkFpuUgVSdLyOKpZ
X-Google-Smtp-Source: ABdhPJzGRQoeDvWrF63J2Zd7zLSFY1OksIBE4yBc7bhIRxiNfKPS2gUfY5fHgRPzZUx5sFa+PwvgCw==
X-Received: by 2002:a17:902:8f96:: with SMTP id z22mr28312360plo.24.1590419665258;
        Mon, 25 May 2020 08:14:25 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:2590:9462:ff8a:101f? ([2601:647:4000:d7:2590:9462:ff8a:101f])
        by smtp.gmail.com with ESMTPSA id w14sm11896544pgo.75.2020.05.25.08.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 08:14:24 -0700 (PDT)
Subject: Re: [PATCH V3 2/4] RDMA/core: Introduce shared CQ pool API
To:     Yamin Friedman <yaminf@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
References: <1589892216-39283-1-git-send-email-yaminf@mellanox.com>
 <1589892216-39283-3-git-send-email-yaminf@mellanox.com>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <dcbddbce-2f30-06a4-383a-c4f41b39f2de@acm.org>
Date:   Mon, 25 May 2020 08:14:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1589892216-39283-3-git-send-email-yaminf@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-05-19 05:43, Yamin Friedman wrote:
> +	/*
> +	 * Allocated at least as many CQEs as requested, and otherwise
           ^^^^^^^^^
           allocate?

> +	spin_lock_irqsave(&dev->cq_pools_lock, flags);
> +	list_splice(&tmp_list, &dev->cq_pools[poll_ctx - 1]);
> +	spin_unlock_irqrestore(&dev->cq_pools_lock, flags);

Please add a WARN_ONCE() or WARN_ON_ONCE() statement that checks that
poll_ctx >= 1.

> +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int nr_cqe,
> +			     int comp_vector_hint,
> +			     enum ib_poll_context poll_ctx)
> +{
> +	static unsigned int default_comp_vector;
> +	int vector, ret, num_comp_vectors;
> +	struct ib_cq *cq, *found = NULL;
> +	unsigned long flags;
> +
> +	if (poll_ctx > ARRAY_SIZE(dev->cq_pools) || poll_ctx == IB_POLL_DIRECT)
> +		return ERR_PTR(-EINVAL);

How about changing this into the following?

	if ((unsigned)(poll_ctx - 1) >= ARRAY_SIZE(dev->cq_pools))
		return ...;

I think that change will make this code easier to verify.

> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 1659131..d40604a 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -1555,6 +1555,7 @@ enum ib_poll_context {
>  	IB_POLL_SOFTIRQ,	   /* poll from softirq context */
>  	IB_POLL_WORKQUEUE,	   /* poll from workqueue */
>  	IB_POLL_UNBOUND_WORKQUEUE, /* poll from unbound workqueue */
> +	IB_POLL_LAST,
>  };

Please consider changing IB_POLL_LAST into IB_POLL_LAST =
IB_POLL_UNBOUND_WORKQUEUE. Otherwise the compiler will produce annoying
warnings on switch statements that do not handle IB_POLL_LAST explicitly.

Thanks,

Bart.
