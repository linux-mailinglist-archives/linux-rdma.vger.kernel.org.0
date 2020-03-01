Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08AD8174AC6
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Mar 2020 03:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgCAC05 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 29 Feb 2020 21:26:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41761 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgCAC04 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 29 Feb 2020 21:26:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id b1so3574982pgm.8;
        Sat, 29 Feb 2020 18:26:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4EyJYdSHCL+aWn0kXyIO3Wf11tUNxPvXes0li6sDuEw=;
        b=QKtbPaNSTqARK1O4go6h7LNtMmYynuIxegd441c2wQxrSsBi3bu3BOMRJe+htqpg4t
         wK6yxHR05pfKBA2jUg+fWuk5an6vC40SZkEaiuoICEM/pChNMDf0p92pZoCZtZafBvvR
         hpV3UA+vJ23Vdo3p/ZQxkU6StM2wVET9TX4z9uJffkL7co3oAKQrFqRliYkFZHG3AqpX
         Cd/9y/0I/0/Tl+1ERjhSjvUTHGrT0j7DoXgWr/9D4LZSNT0gm1DGcBG3uKwyzfYc74Va
         Qi1RmXSlF22WT5v/8wIRrScJ0OoAtENYRzMjhb4n2GBdUSv3DJbxLd+XOHz5YCRaUp8s
         0oBg==
X-Gm-Message-State: APjAAAW07Z3+49sYais9X7OPKQp6E4eOxN3UCcjN/i9DywyvHoaYGrAM
        +HLC/6uAAP53oBpNQv3IEOw=
X-Google-Smtp-Source: APXvYqyPmwZ/sUEKaVYELJP+Io1tTkZbhcrhs0pm7JuWcvRt4XgDBcYiEnRqHfcwOva0b3S/TwGDOw==
X-Received: by 2002:aa7:8687:: with SMTP id d7mr11633755pfo.164.1583029615495;
        Sat, 29 Feb 2020 18:26:55 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:bd83:6f94:8c5:942d? ([2601:647:4000:d7:bd83:6f94:8c5:942d])
        by smtp.gmail.com with ESMTPSA id v22sm11866952pfe.49.2020.02.29.18.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 18:26:54 -0800 (PST)
Subject: Re: [PATCH v9 16/25] block/rnbd: client: private header with client
 structs and functions
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de, pankaj.gupta@cloud.ionos.com
References: <20200221104721.350-1-jinpuwang@gmail.com>
 <20200221104721.350-17-jinpuwang@gmail.com>
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
Message-ID: <6aa73b1c-b47a-c239-f8bb-33a44a3c4d97@acm.org>
Date:   Sat, 29 Feb 2020 18:26:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221104721.350-17-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-02-21 02:47, Jack Wang wrote:
> This header describes main structs and functions used by rnbd-client
> module, mainly for managing RNBD sessions and mapped block devices,
> creating and destroying sysfs entries.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
