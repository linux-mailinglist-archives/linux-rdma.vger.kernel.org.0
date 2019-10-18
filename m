Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31C81DBC2E
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 06:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387841AbfJRE5M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 00:57:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36202 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731903AbfJRE5M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Oct 2019 00:57:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so3079666pfr.3
        for <linux-rdma@vger.kernel.org>; Thu, 17 Oct 2019 21:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xTDqaCFrDT/AH/JnoA0Ry1FR1MW8Gce+C0SSDSEjGao=;
        b=BXZDpCVvmj//fuZW6gO2ClRYw9Qd9ikcet6K342AAswZk+QpdR6HqoedN4Q6ic0ic6
         uxLi9mKaUBUHe5Z7kDDgG0tZ+I8kJIf8SaJThLE+0UcQA0oxfZR9KYXxizJUVaHz85Zl
         9rY5eOKQfSV1h2NOMtLO2hXykcVL0wpGPeDuZPNoEQUoaUi1Gr+IhKZ633YEy3XZWT9F
         6UVbLHLR4CjQPH/PA1ie616/TRIRjQqr28BEJ4aY2e9Ibg340+JYCaffmVGg7L+hYfix
         R+WLKTz1kIAPY7mtbYK2UPLg7Y+Nlykw1nkhCafc4+kcqydltaWBGgQGARaPz+YJQb1i
         fwZw==
X-Gm-Message-State: APjAAAW5wuPbOcQL/eY7NGs5fs26HFP3RkRsl4qIhWvWJZzDmB26jEQr
        9iMWRiRLZbfydDbwJfFob3QuKP4u
X-Google-Smtp-Source: APXvYqwDw095wNjWMB5ZkXYYv69o6pf0gSwT8MJdAL4iL8ekOOJU/DGKX/yrhYC+4k7RQqk2SQsreg==
X-Received: by 2002:a17:90a:cb88:: with SMTP id a8mr8693904pju.85.1571374630915;
        Thu, 17 Oct 2019 21:57:10 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:ce:84e0:ff05:5b17:3d9e])
        by smtp.gmail.com with ESMTPSA id c62sm4822177pfa.92.2019.10.17.21.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2019 21:57:09 -0700 (PDT)
Subject: Re: [PATCH] srp_daemon: Use maximum initiator to target IU size
To:     Honggang LI <honli@redhat.com>
Cc:     linux-rdma@vger.kernel.org
References: <20191018044104.21353-1-honli@redhat.com>
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
Message-ID: <1d811fc0-1f74-b546-b296-a4e9f8c33d86@acm.org>
Date:   Thu, 17 Oct 2019 21:57:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018044104.21353-1-honli@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2019-10-17 21:41, Honggang LI wrote:
> +	if (config->print_max_it_iu_size) {
> +		len += snprintf(target_config_str+len,
> +				sizeof(target_config_str) - len,
> +				",max_it_iu_size=%d",
> +				be32toh(target->ioc_prof.send_size));
> +
> +		if (len >= sizeof(target_config_str)) {
> +			pr_err("Target config string is too long, ignoring target\n");
> +			closedir(dir);
> +			return -1;
> +		}
> +	}

Hi Honggang,

I think this patch will make srp_daemon incompatible with versions of
the ib_srp kernel driver that do not support the max_it_iu_size
parameter and also that that's unacceptable. How about the following
approach:
* Do not add a new command-line option.
* Add max_it_iu_size at the end. I think that approach will trigger a
warning with older versions of the SRP kernel driver but also that it
won't break SRP login.

Thanks,

Bart.
