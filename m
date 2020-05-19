Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DF71D9E28
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 19:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgESRrF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 13:47:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39429 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESRrF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 13:47:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id u35so175916pgk.6;
        Tue, 19 May 2020 10:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4s+D7uXo64x5bPgFnHyM5djSl5hgZ8Bh8N4Mq4iYj5Y=;
        b=KHDnBqFgYAKLvypgf5M+vv59jdH7jOW12qs2UVOf4i2Obmm5xCXesWQgfqMGeZTQSY
         4i3g8MWxcyRJaESaDWJKEWQp4IIjKBcwtTuiOeyfBCSdw18gRrCpu7eV7QhToZtS8jxG
         q5O3f0HeCnnbUo/6RSYUPMWf4eNWCiE//7M6KBj8b8ZHvwLMC+JlN/qkYx7XaeF+JnWh
         3lIaMjL4ZlDMa6fZvSoLCwCmfnpogYsTJ8QBnkv/6QT3buI9WTrmeunCf1eqwHaOagXd
         RJgDJw8k1nacwnn8MJO8TV6aoAVcOovwWppkgoo6ZGr34Wgk8X2ZYB85OdahLQFmRkId
         ysZA==
X-Gm-Message-State: AOAM533pYIHDjI7rcNP4EC9NdPLH1FOFowO+Pdskiox+Pt6GZEu21IV+
        H4cYKJ8UcAaCaRqpyWVCaBw=
X-Google-Smtp-Source: ABdhPJyjxNyEvaWspm5HdpSza/NH+XaiPNLPq6/NmJt65fHgKgq3qOtVTcIeJKdMA1/9tdLmKz7ing==
X-Received: by 2002:a62:4e88:: with SMTP id c130mr259853pfb.122.1589910424698;
        Tue, 19 May 2020 10:47:04 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:51be:e4c2:6c63:36da? ([2601:647:4000:d7:51be:e4c2:6c63:36da])
        by smtp.gmail.com with ESMTPSA id ay15sm181806pjb.18.2020.05.19.10.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 10:47:03 -0700 (PDT)
Subject: Re: [PATCH v2] RDMA/rtrs: client: Fix function return on success
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <20200519163612.GA6043@embeddedor>
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
Message-ID: <0f42902d-0b8c-08ac-0d6e-b819205ce24d@acm.org>
Date:   Tue, 19 May 2020 10:47:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519163612.GA6043@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-05-19 09:36, Gustavo A. R. Silva wrote:
> Remove the if-statement and return the value contained in _err_,
> unconditionally.

Thanks Gustavo!

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
