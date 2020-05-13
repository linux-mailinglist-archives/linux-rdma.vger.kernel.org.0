Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF371D1F9A
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 21:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390034AbgEMTtK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 15:49:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46256 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732218AbgEMTtK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 May 2020 15:49:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id p21so192049pgm.13
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 12:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ucfG/cjt6FPeU/fwEWI0KmZZ91qDf3vcCIODa70eY64=;
        b=LnTwxf+nFjoo3lvgeUR+k3tYM9RPdCDffg/DiM2kzFhfjJhlOtSJSZSpvDgTTKMuHt
         nJsHe6TfaDvOukzP1OxwNDUXO3/ICxSDY9NEOV5Es5xOo0uJ5g9JQdE869Xn6OeXXRR+
         z5XtYlZlKhrmboiRNKEWiCExFoYMSQxuHsRGxUhAL2NBcrxCGpcJdbKAQCNrAw2IsFE+
         TdMYe70jbsksf493ASWQwErfdlfTuQXelGiw1SVhGv2BiYvS6yZ1EL2FR5Fnb6sLljkm
         RsS94Wu4h/jce2PTGJ3F3uxDgLn1+ljWbSjRMq+CbM1FH9fmqrurxSt+usY2qfoMPwbb
         M8yg==
X-Gm-Message-State: AOAM530gV6XWhZvPWWbKgjkElUZl7KW8DDjqeTR8hOqPm0a715aQhCYb
        +gbs7kTdCTEDKVa6iigbfL4=
X-Google-Smtp-Source: ABdhPJx/9t29ctyFfAPIfl/Vpb7OuxwAe2LdXywjwnn/UtQB3GLIs0shlF1s2vMEEqZGMaTGhN2gtg==
X-Received: by 2002:a63:1854:: with SMTP id 20mr872516pgy.257.1589399349511;
        Wed, 13 May 2020 12:49:09 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:89b0:7138:eb9:79bf? ([2601:647:4000:d7:89b0:7138:eb9:79bf])
        by smtp.gmail.com with ESMTPSA id w84sm304499pfc.116.2020.05.13.12.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 12:49:08 -0700 (PDT)
Subject: Re: [PATCH] IB/iser: Remove support for FMR memory registration
To:     Leon Romanovsky <leon@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Israel Rukshin <israelr@mellanox.com>,
        linux-rdma@vger.kernel.org, dledford@redhat.com, maxg@mellanox.com,
        sergeygo@mellanox.com, Chuck Lever <chuck.lever@oracle.com>
References: <1589299739-16570-1-git-send-email-israelr@mellanox.com>
 <20200512171633.GO4814@unreal> <5b8b0b51-83e3-06c2-9b99-dec0862c0e5b@acm.org>
 <20200512201303.GA19158@mellanox.com>
 <98a0d1aa-6364-a2f1-37f6-9c69e1efaa0b@acm.org>
 <20200512230625.GB19158@mellanox.com>
 <b9dab6bf-d1b8-40c0-63ba-09eb3f4882f5@grimberg.me>
 <20200513071855.GQ4814@unreal>
 <be388f26-9b86-b826-5d4b-8dec201ea5ef@intel.com>
 <20200513184349.GA4814@unreal>
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
Message-ID: <bf17c39b-2e16-6e0b-0a5d-11177cbe3232@acm.org>
Date:   Wed, 13 May 2020 12:49:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513184349.GA4814@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-05-13 11:43, Leon Romanovsky wrote:
> mlx4 works too :), I had in mind more older cards than qib, which was
> added to the kernel only ten years ago. For example mlx4 was added 13
> years ago an mthca before git era (>15 years).

Most of the pre-git patches are available in a git repository. This is
the approach I use to view changes that predate the time when Linus
switched to git:
https://stackoverflow.com/questions/3264283/linux-kernel-historical-git-repository-with-full-history

Bart.
