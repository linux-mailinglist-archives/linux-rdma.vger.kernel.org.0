Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2699E0E08
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 00:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfJVWKa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 18:10:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45721 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfJVWKa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 18:10:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1so10777921pgj.12
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2019 15:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TsCb0C4kNPbn2k1q/tpNwv38VXAcvW2m1kuwWMRf0mI=;
        b=DBwaj3w0oFf2dc+mgXDkGCjeIKbct3juTF87lG4PW4vfztH19uWWd9WMv2s7b+vB04
         Aep4nte1GxDSLNZv5i5rcdu3T+hTQtkONfuYvhZ4lpiC22qnTH0G8t2bWMLityggzwce
         8Ewmk0yMs2LINkTgoieOelzNxYIESDrGAj67kCTjrssZ9G1mtGAEdw/wZqj9pBZzge5A
         6WTiw0UuPASmESsMyJe6QF3bMy7dcYNaiMI28LjtvH6jnOZsnOtRQJmpWHcwfmKZMP+3
         F93CrXom4to4FWoZLp4X/KK/g5LMt0fdwLLHpmO5sD+i/e3yLQJ3NEUSc0pmUbBNtU7D
         Fkrw==
X-Gm-Message-State: APjAAAU3aY6cuKyqQ8mkkVa+RbRGwAdfd6MnHSSzY7YSmwMeTIoXoL4z
        eOJbVawZtYinAUPMh9exHdhOcHZS
X-Google-Smtp-Source: APXvYqyETvHDFnGkaPpkkDQcJbVMjapOeievNlGTHpo70QHGfULUV5P/ScblbQqG7TErw2FJeXYh+g==
X-Received: by 2002:a63:e211:: with SMTP id q17mr5648714pgh.316.1571782229069;
        Tue, 22 Oct 2019 15:10:29 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:c3:ccbd:2d81:281:ddbd])
        by smtp.gmail.com with ESMTPSA id f6sm20866662pfq.169.2019.10.22.15.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2019 15:10:27 -0700 (PDT)
Subject: Re: [PATCH] srp_daemon: Use maximum initiator to target IU size
To:     Honggang LI <honli@redhat.com>
Cc:     linux-rdma@vger.kernel.org
References: <20191018044104.21353-1-honli@redhat.com>
 <1d811fc0-1f74-b546-b296-a4e9f8c33d86@acm.org>
 <20191018152253.GA32562@dhcp-128-227.nay.redhat.com>
 <21142610-1e01-4ce8-635c-2fe677e69cf9@acm.org>
 <20191022070025.GA20278@dhcp-128-227.nay.redhat.com>
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
Message-ID: <5f664232-ca58-c25c-e9b1-e441c053c818@acm.org>
Date:   Tue, 22 Oct 2019 15:10:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191022070025.GA20278@dhcp-128-227.nay.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2019-10-22 00:00, Honggang LI wrote:
> +static bool use_imm_data(void)
> +{
> +#ifdef __linux__
> +	bool ret = false;
> +	char flag = 0;
> +	int cnt;
> +	int fd = open("/sys/module/ib_srp/parameters/use_imm_data", O_RDONLY);
> +
> +	if (fd < 0)
> +		return false;
> +	cnt = read(fd, &flag, 1);
> +	if (cnt != 1)
> +		return false;
> +
> +	if (!strncmp(&flag, "Y", 1))
> +		ret = true;
> +	close(fd);
> +	return ret;
> +#else
> +	return false;
> +#endif
> +}

There is already plenty of Linux-specific code in srp_daemon. The #ifdef
__linux__ / #endif guard does not seem useful to me.

There is a file descriptor leak in the above function, namely if read()
returns another value than 1.

The use_imm_data kernel module parameter was introduced in kernel v5.0
(commit 882981f4a411; "RDMA/srp: Add support for immediate data"). The
max_it_iu_size will be introduced in kernel v5.5 (commit 547ed331bbe8;
"RDMA/srp: Add parse function for maximum initiator to target IU size").

So the above check will help for kernel versions before v5.0 but not for
kernel versions [v5.0..v5.5). If that is really what you want, please
explain this in a comment above the use_imm_data() function.

Thanks,

Bart.
