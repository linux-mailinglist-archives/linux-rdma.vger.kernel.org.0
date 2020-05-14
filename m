Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48AC1D3221
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2020 16:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgENOHF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 May 2020 10:07:05 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:50588 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgENOHF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 May 2020 10:07:05 -0400
Received: by mail-pj1-f65.google.com with SMTP id t9so12612080pjw.0
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2020 07:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AkaQdQVHafEqHQdZP9VmMFcw3xEnNTdqMRa55YMlJRI=;
        b=WpHljDnqpBFDvge7XLhXU0FpZALswPES7v6sIS4S7dnqyJ6OpLBAgPq9KMO+Tq+mSd
         r0Eu6W7E7UFR867XEo+XMaG4pd5ya51Y/jU+IjZGNEidkP+YxvyxlIDIkbUPlxgkNDCo
         EJ9AEdM2SkSLmj30nJ6XSHWoyL9zS9OzKuUco7uLdpirjwHAy9MQ/E62nQGJMx59N2nm
         kAT4VsFk9zWZhkV8Ufzt3gZosUC4srrZ7lmgLp8DDJPKotMhcHpJDlDglMC1huDj5X+t
         fW1nJl8gQMywDXFVKq4l9vLmRguca+UjVovKXJ+aw4w0DEuHrFlZxMvVRImYY8bOzJ9N
         Kivg==
X-Gm-Message-State: AOAM533AuoB8CYLvu/n/PQTk1c1bbKdB+/wUsTp2Fdi4dwZm16jdpZgY
        WKZyP4KRuflM63DJ8KOHWBk=
X-Google-Smtp-Source: ABdhPJxnYFqKcFVRQqbImSyZo4S0YFeBdhKwf5UBpZFd67q8mPmdJeF1S5d45F54vkYNmFWkEoEyVw==
X-Received: by 2002:a17:902:b107:: with SMTP id q7mr4125205plr.177.1589465223689;
        Thu, 14 May 2020 07:07:03 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:6c16:7f27:8c37:e02d? ([2601:647:4000:d7:6c16:7f27:8c37:e02d])
        by smtp.gmail.com with ESMTPSA id l64sm2188316pgl.21.2020.05.14.07.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 07:07:02 -0700 (PDT)
Subject: Re: [PATCH for-rc v2] RDMA/srpt: Fix disabling device management
To:     Kamal Heib <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
References: <20200514114720.141139-1-kamalheib1@gmail.com>
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
Message-ID: <f82cf85e-d945-a628-63b5-8306941dcfbe@acm.org>
Date:   Thu, 14 May 2020 07:07:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200514114720.141139-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-05-14 04:47, Kamal Heib wrote:
> Avoid disabling device management for devices that don't support
> Management datagrams (MADs) by checking if the "mad_agent" pointer is
> initialized before calling ib_modify_port, also fix the error flow in
> srpt_refresh_port() to disable device management if
> ib_register_mad_agent() fail.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
