Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A854112D4F3
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2019 00:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfL3XTt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 18:19:49 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43832 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfL3XTs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 18:19:48 -0500
Received: by mail-pg1-f196.google.com with SMTP id k197so18719246pga.10;
        Mon, 30 Dec 2019 15:19:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RNoBMwQo5jSm11wTNZzsnaXlpyEFhOXSoQbsa4AWbXk=;
        b=fEG4E6ojXFoo5dUZM60v/eKt/PznsobwrNl7apOMZb9VLn5WRULKF/c3eD8PsD68yh
         z+v0gxDb4ehzqUzmivM4pN4A/gI2oszsSdRm7I6PY4UZQSvLBUBkhb0E1W9GqnSRYaU5
         1Oc0VNYgXRcYwJrFvikrCUKf2aUGYskhUqKeM2sqBlbBIcugdVMoOciE11JUiidbW1S+
         h4lGzCrhb2Zc9+sa4CzXRjMgiQSFU1FQfeej4Sn9Hw+8fZHqHNvMxZ8rh3YMLYSZAT9d
         1iEYqlAl9ieDAydbDYbMT6iLgHLK0Q+gKzVZPox188zw+gqGDGzyrelMi2NjfwS4nPd1
         b8uw==
X-Gm-Message-State: APjAAAVEJobouefmV5E/zbfgE2tMF7HfV73W3jQSTryVXBCr+x/R3UA0
        l2Pa17QmhzeEfBOTT7V8u/XeLvHR
X-Google-Smtp-Source: APXvYqwBbAPH+eSH6xNQVHYpVir9KxmbeIQetG9GGV3XRimNLsEoPY5LC6vZlI8sBjK95cXhgObwfQ==
X-Received: by 2002:a63:a019:: with SMTP id r25mr70002672pge.400.1577747987691;
        Mon, 30 Dec 2019 15:19:47 -0800 (PST)
Received: from ?IPv6:2601:647:4000:10b0:5d64:b7bb:4214:150f? ([2601:647:4000:10b0:5d64:b7bb:4214:150f])
        by smtp.gmail.com with ESMTPSA id n2sm49404556pgn.71.2019.12.30.15.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 15:19:46 -0800 (PST)
Subject: Re: [PATCH v6 14/25] rtrs: a bit of documentation
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        linux-kernel@vger.kernel.org
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-15-jinpuwang@gmail.com>
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
Message-ID: <1ad8b279-1a45-1d70-39c7-acd42f28abca@acm.org>
Date:   Mon, 30 Dec 2019 15:19:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191230102942.18395-15-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2019-12-30 02:29, Jack Wang wrote:
> diff --git a/drivers/infiniband/ulp/rtrs/README b/drivers/infiniband/ulp/rtrs/README

Other kernel driver documentation exists under the Documentation/
directory. Should this README file perhaps be moved to a subdirectory of
the Documentation/ directory?

> +****************************
> +InfiniBand Transport (RTRS)
> +****************************

The abbreviation does not match the full title. Do you agree that this
is confusing?

> +RTRS is used by the RNBD (Infiniband Network Block Device) modules.

Is RNBD an RDMA or an InfiniBand network block device?

> +
> +==================
> +Transport protocol
> +==================
> +
> +Overview
> +--------
> +An established connection between a client and a server is called rtrs
> +session. A session is associated with a set of memory chunks reserved on the
> +server side for a given client for rdma transfer. A session
> +consists of multiple paths, each representing a separate physical link
> +between client and server. Those are used for load balancing and failover.
> +Each path consists of as many connections (QPs) as there are cpus on
> +the client.
> +
> +When processing an incoming rdma write or read request rtrs client uses memory

A quote from
https://linuxplumbersconf.org/event/4/contributions/367/attachments/331/555/LPC_2019_RMDA_MC_IBNBD_IBTRS_Upstreaming.pdf:
"Only RDMA writes with immediate". Has the wire protocol perhaps been
changed such that both RDMA reads and writes are used? I haven't found
any references to RDMA reads in the "IO path" section in this file. Did
I perhaps overlook something?

Thanks,

Bart.
