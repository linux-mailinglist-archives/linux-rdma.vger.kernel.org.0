Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B057174AD8
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Mar 2020 03:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgCAC6I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 29 Feb 2020 21:58:08 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35966 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgCAC6I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 29 Feb 2020 21:58:08 -0500
Received: by mail-pj1-f67.google.com with SMTP id gv17so2934503pjb.1;
        Sat, 29 Feb 2020 18:58:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=D4MlvJRj68LMrS7IDPbO+oW/bka+rXu9QTiGNQT3WrE=;
        b=sV60QJbWtxYwUzl63TEEb4By2OcP2dW2a/IVxVc+amCTa33B58bJiwDqXbAeLICbbw
         kkmecNSYnHe3XSdn/D194VUELomcs29Eowv8uk832EdSf2kxm4lFQ2BhPnR5GwGaPMjm
         DcYO9KTr1yxbQrDpFJ9M/YzdIAft7FxdTBMDgEuL2gRIpN75OqNrI96C2Bzb0ee2ICuw
         iI12sk5dFKFAzGkoDw4wynLrDoDmPcrcuRt7kV4RboERygPK9fQ8PA1CfNBIEnKUg1MN
         Jx9ua2um8BIOPRZwV3nLRc0fulZTW877JZBQPoMHDG/Nn5/Hycp2uIxHtgQtkeA0mo6u
         MUPA==
X-Gm-Message-State: APjAAAW0P3ao+lrm4B5C7hpigIBkmBwlEjfqTB3MUFFevkifyiayIX6f
        0B1da0F9t5tMkkHDrrcZB5Y=
X-Google-Smtp-Source: APXvYqySEvSPq5aQq2NXAwwzRcJoEJSGapgOqKZjldd2M0y8kpJRHJHlx9C5wy6hqoFm0JSDu3dSMQ==
X-Received: by 2002:a17:90a:9416:: with SMTP id r22mr13501977pjo.2.1583031487129;
        Sat, 29 Feb 2020 18:58:07 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:bd83:6f94:8c5:942d? ([2601:647:4000:d7:bd83:6f94:8c5:942d])
        by smtp.gmail.com with ESMTPSA id r198sm17215775pfr.54.2020.02.29.18.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 18:58:06 -0800 (PST)
Subject: Re: [PATCH v9 20/25] block/rnbd: server: main functionality
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de, pankaj.gupta@cloud.ionos.com
References: <20200221104721.350-1-jinpuwang@gmail.com>
 <20200221104721.350-21-jinpuwang@gmail.com>
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
Message-ID: <33864f54-62af-cb5f-45fa-55a283dcd434@acm.org>
Date:   Sat, 29 Feb 2020 18:58:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221104721.350-21-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-02-21 02:47, Jack Wang wrote:
> +static int dev_search_path_set(const char *val, const struct kernel_param *kp)
> +{
> +	char *dup;
> +
> +	if (strlen(val) >= sizeof(dev_search_path))
> +		return -EINVAL;
> +
> +	dup = kstrdup(val, GFP_KERNEL);
> +
> +	if (dup[strlen(dup) - 1] == '\n')
> +		dup[strlen(dup) - 1] = '\0';
> +
> +	strlcpy(dev_search_path, dup, sizeof(dev_search_path));
> +
> +	kfree(dup);
> +	pr_info("dev_search_path changed to '%s'\n", dev_search_path);
> +
> +	return 0;
> +}

It is not necessary in this function to do memory allocation. Something
like the following (untested) code should be sufficient:

	const char *p = strrchr(val, '\n') ? : val + strlen(val);

	snprintf(dev_search_path, sizeof(dev_search_path), "%.*s",
		(int)(p - val), val);

How are concurrent attempts to change dev_search_path serialized?

Thanks,

Bart.
