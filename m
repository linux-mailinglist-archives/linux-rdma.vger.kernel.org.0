Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901D1269228
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 18:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgINQw7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 12:52:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36568 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgINQvA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Sep 2020 12:51:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id f2so259028pgd.3
        for <linux-rdma@vger.kernel.org>; Mon, 14 Sep 2020 09:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/aJ4X4AVP27asaO12N1gmfnn+t87XNKA0mGMbUFaBuQ=;
        b=dZIT7YYd4Tt9+VN42vE2UoaPrZpyXh1Da8bZRa+w9uHw4QwSfIy5RSaeHLD61iERsZ
         FfG4EgChn00fc8qcA8Bkm3C6IlazZb51rO+BIdO/gEKlp0NoNWUvlrjH5b+OWQ3cfa+3
         paOTYeMPoIZLgcV008slbNRD+Vn+hI1Jzc2+AKEoeOcZyjZc2Euti83Mk+CUATgXOhgy
         LFVwBtd8xYJrU8z9bIaK89PUqiXrEbnDH0Q1Mu7tmW5iIoqwhVGlR1hK/8UDWVbLD6Ij
         FbCuQiIWIPd3ieffXru816x67lAnCzpR8z8IfTJzrjcPSk80UGckrE+pZL1sWiodvSkl
         yrXg==
X-Gm-Message-State: AOAM531O26krKXJGX37o+zjYRlxJP6cZcK27ulfcCSxAG6Jss2Zx918e
        J8vrclOcMMlC1qz/PWfzeJk=
X-Google-Smtp-Source: ABdhPJw8SAkKavtSlTdMFjBKOhgJJXZGBOg+UF/jde/P9+f8qmb4oAVT5pL7loPf9eTeXkeBai+lxw==
X-Received: by 2002:a62:d44e:0:b029:13c:1611:652f with SMTP id u14-20020a62d44e0000b029013c1611652fmr14036268pfl.15.1600102258951;
        Mon, 14 Sep 2020 09:50:58 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:3f5a:7698:1b81:cc96? ([2601:647:4000:d7:3f5a:7698:1b81:cc96])
        by smtp.gmail.com with ESMTPSA id o5sm9553294pjs.13.2020.09.14.09.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 09:50:58 -0700 (PDT)
Subject: Re: [PATCH] srp_daemon: Avoid extra permissions for the lock file
To:     Sergey Gorenko <sergeygo@nvidia.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20200819141745.11005-1-sergeygo@nvidia.com>
 <BN8PR12MB3220065FFCE12DED0704BE9BBF230@BN8PR12MB3220.namprd12.prod.outlook.com>
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
Message-ID: <b2cc891a-3fb0-25d9-ca8b-e26800c90143@acm.org>
Date:   Mon, 14 Sep 2020 09:50:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <BN8PR12MB3220065FFCE12DED0704BE9BBF230@BN8PR12MB3220.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-09-14 02:24, Sergey Gorenko wrote:
> Could you review the patch? I'm asking for you because you are specified
> as a maintainer for srp_daemon in rdma-core.

Thanks for the reminder. That patch had escaped from my attention.

Bart.
