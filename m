Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 781D1196389
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2020 05:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgC1E0J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Mar 2020 00:26:09 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53439 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgC1E0J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 28 Mar 2020 00:26:09 -0400
Received: by mail-pj1-f67.google.com with SMTP id l36so4766665pjb.3;
        Fri, 27 Mar 2020 21:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2KNTRreR7/QNIxvs47qkeR0tg0ESW3Na3avWlW9173E=;
        b=iDbOj3i3CWRfVTBjqANtNBq8iEffKwUVwi7J+upJvsonJtpeeIyXT1IBpB42EX8FeY
         GY1H0jmgZIyfVh89iZ0efshcQYxjxnrlb/2+8V+ezvHoLwidD1VfMDmRTnfbFhJZMbDc
         /rOlsY8x0c7K1JSsomvqoviPAh751XYD7G/1l6RFt+/z/nSygeT3neHdAmYUIOWO9sR1
         Bme33GGYOw9D966IEZgK+/gZfJWaK9f5LjGIhO81kqzBrzkjvf9p90lUe5ih1ZC+3Bzv
         9CCMQvzAWcAjPUvKPS0oET43sIo+ZPqlECy1z6TKbgZruYIEAOBlSRr2KMNEwn9okLBj
         KLaQ==
X-Gm-Message-State: ANhLgQ1hm0DGKAV2lFsBKmk52E+NlLZ+0L7Lf69bVyOOdeLfVnX/I/kr
        Q5kBx8fgKbsh8aoiNTetLaw=
X-Google-Smtp-Source: ADFU+vv9gSXl1er+T1RZrVar2BpGUmP1feSa0D5s63Swscg2gYtdb6jNwmOaI98OCYpeTDwTaXU58Q==
X-Received: by 2002:a17:90b:3752:: with SMTP id ne18mr3067204pjb.143.1585369565375;
        Fri, 27 Mar 2020 21:26:05 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:3563:edda:f4cf:995c? ([2601:647:4000:d7:3563:edda:f4cf:995c])
        by smtp.gmail.com with ESMTPSA id j21sm5177678pff.39.2020.03.27.21.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 21:26:04 -0700 (PDT)
Subject: Re: [PATCH v11 04/26] RDMA/rtrs: core: lib functions shared between
 client and server modules
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-5-jinpu.wang@cloud.ionos.com>
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
Message-ID: <cad654ae-d6c9-882d-aeeb-d6871994d280@acm.org>
Date:   Fri, 27 Mar 2020 21:26:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200320121657.1165-5-jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-03-20 05:16, Jack Wang wrote:
> +/**
> + * rtrs_str_to_sockaddr() - Convert rtrs address string to sockaddr
> + * @addr:	String representation of an addr (IPv4, IPv6 or IB GID):
> + *              - "ip:192.168.1.1"
> + *              - "ip:fe80::200:5aee:feaa:20a2"
> + *              - "gid:fe80::200:5aee:feaa:20a2"
> + * @len:        String address length
> + * @port:	Destination port
> + * @dst:	Destination sockaddr structure
> + *
> + * Returns 0 if conversion successful. Non-zero on error.
> + */
> +static int rtrs_str_to_sockaddr(const char *addr, size_t len,
> +				 short port, struct sockaddr_storage *dst)
> +{
> +	if (strncmp(addr, "gid:", 4) == 0) {
> +		return rtrs_str_gid_to_sockaddr(addr + 4, len - 4, port, dst);
> +	} else if (strncmp(addr, "ip:", 3) == 0) {
> +		char port_str[8];
> +		char *cpy;
> +		int err;
> +
> +		snprintf(port_str, sizeof(port_str), "%u", port);
> +		cpy = kstrndup(addr + 3, len - 3, GFP_KERNEL);
> +		err = cpy ? inet_pton_with_scope(&init_net, AF_UNSPEC,
> +						 cpy, port_str, dst) : -ENOMEM;
> +		kfree(cpy);
> +
> +		return err;
> +	}
> +	return -EPROTONOSUPPORT;
> +}

Please use 'u16' or 'uint16_t' for port numbers instead of 'short'.

> +/**
> + * rtrs_addr_to_sockaddr() - convert path string "src,dst" to sockaddreses
> + * @str:	string containing source and destination addr of a path
> + *		separated by comma. I.e. "ip:1.1.1.1,ip:1.1.1.2". If str
> + *		contains only one address it's considered to be destination.
> + * @len:	string length
> + * @port:	will be set to port.
                ^^^^^^^^^^^^^^^^^^^
What does this mean? Please make comments easy to comprehend.

> + * @addr:	will be set to the source/destination address or to NULL
> + *		if str doesn't contain any sorce address.
                                           ^^^^^
Is this perhaps a typo?

> + *
> + * Returns zero if conversion successful. Non-zero otherwise.
> + */
> +int rtrs_addr_to_sockaddr(const char *str, size_t len, short port,
                                                          ^^^^^
I think most kernel code uses type u16 for port numbers.

> +			   struct rtrs_addr *addr)
> +{
> +	const char *d;
> +
> +	d = strchr(str, ',');
> +	if (!d)
> +		d = strchr(str, '@');
> +	if (d) {
> +		if (rtrs_str_to_sockaddr(str, d - str, 0, addr->src))
                                                      ^^^
Does this mean that the @port argument only applies to the destination
address? If so, please mention this in the comment above this function.

> +			return -EINVAL;
> +		d += 1;
> +		len -= d - str;
> +		str  = d;
> +
> +	} else {
> +		addr->src = NULL;
> +	}
> +	return rtrs_str_to_sockaddr(str, len, port, addr->dst);
> +}
> +EXPORT_SYMBOL(rtrs_addr_to_sockaddr);

So this function either accepts ',' or '@' as separator between source
and destination address? Shouldn't that be mentioned in the comment
block above the function?

Thanks,

Bart.
