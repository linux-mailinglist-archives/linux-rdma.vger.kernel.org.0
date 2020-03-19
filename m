Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2B118AB84
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 05:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgCSECS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 00:02:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33635 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgCSECS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Mar 2020 00:02:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id n7so693427pfn.0
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 21:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CS6j/dj+b0UdPfXca74cRX59NxtxC7h0wAYHH2FNfHA=;
        b=G1ESG/MzauhndbECiQMuH/bgWg2+S8z8l4z2dUFKWk8kXjI7AqnMZNEwmRIsCjgUAt
         suzn69L3U//iKZvIZZQTAYY6hJqJ6mbMifeTFLOIMbjzczmsrPk4j4tWqIznm8ex7dqP
         9IaZAo0lUhAlZWbSLf+vhhsEPnluWDLV/YpUvBld4IuxYLPj58Bp+CS1eWjpXTd5lB2Q
         fNngUVE0fHVyHtsmbJAqZell3vbOu6Ds1DFjf3PL+b4mx81Mav08EZx3DJeoVg+peDAa
         EotKrezWZ9vYzPCB/UQq+AvKtO0wp1PyNG8aW6pY2wOqUD5ekNE5MaPjaKuvwx+B4IBC
         R2Mw==
X-Gm-Message-State: ANhLgQ1uofwP2u+ZMdmVZVoB4XbfmV773+wrpW/C7KHaDyLc85W71S+B
        USXgK2DbPfwg042c/nAJH5g=
X-Google-Smtp-Source: ADFU+vusO1JaNVfvuDAODDqmien8P0AqPsSWq6bSkBcLJkLuDhxFX8vcFUALvEyvUbWHGJg/U/6FSw==
X-Received: by 2002:a63:9dc2:: with SMTP id i185mr1208717pgd.240.1584590536968;
        Wed, 18 Mar 2020 21:02:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:84b7:c685:175f:6f9b? ([2601:647:4000:d7:84b7:c685:175f:6f9b])
        by smtp.gmail.com with ESMTPSA id fz3sm403037pjb.41.2020.03.18.21.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 21:02:15 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] nvmet-rdma/srpt: SRQ per completion vector
To:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, loberman@redhat.com,
        linux-rdma@vger.kernel.org
Cc:     kbusch@kernel.org, leonro@mellanox.com, jgg@mellanox.com,
        dledford@redhat.com, idanb@mellanox.com, shlomin@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, rgirase@redhat.com
References: <20200318150257.198402-1-maxg@mellanox.com>
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
Message-ID: <64006872-53be-d7fa-831f-a1e79302038e@acm.org>
Date:   Wed, 18 Mar 2020 21:02:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318150257.198402-1-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-03-18 08:02, Max Gurtovoy wrote:
> I used RoCE link layer. For SRP, I used 1 server with RoCE loopback connection
> (results are not mentioned below) for testing. Hopefully I'll get a tested-by
> signature and feedback from Laurence and Rupesh on the SRP part during the review
> process.

Hi Max,

The MAD code in ib_srpt is not triggered when using RoCE. Please also
test SRP over IB.

Additionally, how does this patch series affect SRP performance?

Thanks,

Bart.
