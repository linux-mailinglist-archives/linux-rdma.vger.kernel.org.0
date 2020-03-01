Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33E03174ACF
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Mar 2020 03:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgCACqt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 29 Feb 2020 21:46:49 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33787 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgCACqs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 29 Feb 2020 21:46:48 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so3605041pgk.0;
        Sat, 29 Feb 2020 18:46:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QFrhEImAvQZ8UlbfrVqXpyaxNG8CrIP7kf+hHo3p18Y=;
        b=M+ZklhydisDUxGa+22u+DH5LQfy+R+gy0NadsCi2aB7wIfwB7+He5sWxgO6tJXelVR
         D3X2xLK7SdH5ooQw8XVmEXYPfA84znccGpzavIcA/tHpt/G2tQ3eYm0AvWINl66/JjMI
         WwjPaVqMMH5ni+A7E7edlLd8KrKdPeFawhdWJ3zbeg2VCk6VB4Gh6++P32oN96js5HWn
         8TqDHbVBX7MZY23owSKkv3s+ZACui7uTXrNZy7QnVruoFQEZOl+96bCTu1ilrh67kr0b
         vCgb3EVYK3f0Rcwk/BvoeWiPncnavR3sIZf6Rs7la1T7cap0jZA+5RiRBZlinVQNd3Cn
         EtKA==
X-Gm-Message-State: APjAAAXhQjCATOMtbSlOy2XC3RKXMANht2pz1PwZ+ExmCJ8dKFa4LSg9
        N9ILD2rS7w6eN9MjZFI+EiQ=
X-Google-Smtp-Source: APXvYqyKKyEUwn4yKN2nUyycCjxvJxShJ0zaVWKh21db7+gYYGJKCtiK8KOmByHrQJtvP8kg5Lavkw==
X-Received: by 2002:a63:4e4a:: with SMTP id o10mr12705018pgl.212.1583030807650;
        Sat, 29 Feb 2020 18:46:47 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:bd83:6f94:8c5:942d? ([2601:647:4000:d7:bd83:6f94:8c5:942d])
        by smtp.gmail.com with ESMTPSA id p17sm15783101pfn.31.2020.02.29.18.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 18:46:46 -0800 (PST)
Subject: Re: [PATCH v9 17/25] block/rnbd: client: main functionality
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de, pankaj.gupta@cloud.ionos.com
References: <20200221104721.350-1-jinpuwang@gmail.com>
 <20200221104721.350-18-jinpuwang@gmail.com>
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
Message-ID: <16e946dd-b244-594b-937e-689f2f23614e@acm.org>
Date:   Sat, 29 Feb 2020 18:46:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221104721.350-18-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-02-21 02:47, Jack Wang wrote:
> +/**
> + * rnbd_get_cpu_qlist() - finds a list with HW queues to be rerun
> + * @sess:	Session to find a queue for
> + * @cpu:	Cpu to start the search from
> + *
> + * Description:
> + *     Each CPU has a list of HW queues, which needs to be rerun.  If a list
> + *     is not empty - it is marked with a bit.  This function finds first
> + *     set bit in a bitmap and returns corresponding CPU list.
> + */
> +static struct rnbd_cpu_qlist *
> +rnbd_get_cpu_qlist(struct rnbd_clt_session *sess, int cpu)
> +{
> +	int bit;
> +
> +	/* First half */
> +	bit = find_next_bit(sess->cpu_queues_bm, nr_cpu_ids, cpu);
> +	if (bit < nr_cpu_ids) {
> +		return per_cpu_ptr(sess->cpu_queues, bit);
> +	} else if (cpu != 0) {
> +		/* Second half */
> +		bit = find_next_bit(sess->cpu_queues_bm, cpu, 0);
> +		if (bit < cpu)
> +			return per_cpu_ptr(sess->cpu_queues, bit);
> +	}
> +
> +	return NULL;
> +}

Please make the "first half" and "second half" comments unambiguous. To
me it seems like the code under "first half" searches through the second
half of the bitmap and that the code under "second half" searches
through the first half of the bitmap.

> +	/**
> +	 * That is simple percpu variable which stores cpu indeces, which are
> +	 * incremented on each access.  We need that for the sake of fairness
> +	 * to wake up queues in a round-robin manner.
> +	 */

Please start block comments with "/*".

> +static void wait_for_rtrs_disconnection(struct rnbd_clt_session *sess)
> +	__releases(&sess_lock)
> +	__acquires(&sess_lock)
> +{
> +	DEFINE_WAIT_FUNC(wait, autoremove_wake_function);

Please use DEFINE_WAIT() instead of open-coding it.

Thanks,

Bart.
