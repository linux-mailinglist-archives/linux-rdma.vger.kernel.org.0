Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F45B18AB97
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 05:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgCSEJ5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 00:09:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44047 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgCSEJ5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Mar 2020 00:09:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so462301plr.11
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 21:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IA2ZrCAj2QOeX9VAZ6IlxR0zqg85cijD6AoTZDygdmg=;
        b=I6nykTlHtF7kQmnPEF2KwBoiMhjJ75XshSRAxYgGsB3YRLAzJqUoGsv4rZ+LwG/6/S
         FeCsqyzNoQiMMmQB0asaj8dpJg5QkII2zQTsU8rdy8d12lzr8k0+P7+zun6OCJfIiyk1
         VYcV7ONOPYkTR3JNIY4Yv2A1aDeiaFaDx2m1SVaC8eLaOYUUCbT5zn1SmCH22usiLVOB
         Y6s+0KtidZHw6dssLl5XA2uvXXUm1IMpn4dKqvbIw7L0MuaSOdMxN7csZjW8vnCjI6ML
         kr/iSiGnzNrCYZlOVwq4rKkvLGkRTmUCGlUhq6EUBRxeGvFZaGe6H0BX1iFWyP7cx0aG
         9INQ==
X-Gm-Message-State: ANhLgQ0N7yCYZBZToYrHi5TTnG8LFCJLuZn+BjFpzuRonAReK/2rJsYK
        tUqAyFSjWJNWAASdq3Vkj0E=
X-Google-Smtp-Source: ADFU+vuNz8/cU6F2gX3xUITQhfYXcdoegiS8FZ7eN+ojKpEN2C00CJKeWb7adFF8z1ZV6JIdHak0hA==
X-Received: by 2002:a17:902:61:: with SMTP id 88mr1614748pla.17.1584590995743;
        Wed, 18 Mar 2020 21:09:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:84b7:c685:175f:6f9b? ([2601:647:4000:d7:84b7:c685:175f:6f9b])
        by smtp.gmail.com with ESMTPSA id i11sm387824pje.30.2020.03.18.21.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 21:09:54 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] nvmet-rdma: use SRQ per completion vector
To:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, loberman@redhat.com,
        linux-rdma@vger.kernel.org
Cc:     kbusch@kernel.org, leonro@mellanox.com, jgg@mellanox.com,
        dledford@redhat.com, idanb@mellanox.com, shlomin@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, rgirase@redhat.com
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-4-maxg@mellanox.com>
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
Message-ID: <d72e0312-1dfd-460e-bc83-49699d86dd64@acm.org>
Date:   Wed, 18 Mar 2020 21:09:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318150257.198402-4-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-03-18 08:02, Max Gurtovoy wrote:
> In order to save resource allocation and utilize the completion
                   ^^^^^^^^^^^^^^^^^^^
                   resources?

> +static int nvmet_rdma_srq_size = 1024;
> +module_param_cb(srq_size, &srq_size_ops, &nvmet_rdma_srq_size, 0644);
> +MODULE_PARM_DESC(srq_size, "set Shared Receive Queue (SRQ) size, should >= 256 (default: 1024)");

Is an SRQ overflow fatal? Isn't the SRQ size something that should be
computed by the nvmet_rdma driver such that SRQ overflows do not happen?

Thanks,

Bart.
