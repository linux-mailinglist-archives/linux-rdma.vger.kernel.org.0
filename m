Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0C518ABAA
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 05:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgCSEPb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 00:15:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43585 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgCSEPa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Mar 2020 00:15:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id f206so683250pfa.10
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 21:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8kkJruqha5cfOcqdL2dBZSpbnGPcrevIKMbH+BYaoog=;
        b=dBoN2/PWD+jXOftKHCw/aHuzQ/aUMcjp/qlzs65QJkaP4j7XxDnVbqF2bJpC2r3rMa
         Rgc6zX62er7rBHk8RdhcpwQJINfo5KAYYLz7tdUwcZ0JmN5GACBuEdOxyq96BT1TJl4I
         WyjzVUM5Pu2t/+m1VUl/8mBkwXRrfs4qC/4KsF9yO0JLZ94J2tpP12sSOHbapguqg30R
         3Ny7XyEfwmKJyWiKdKSJZNou2AkzPQhMGH2ClUzPR51Q97prHKTw9E8VU5CifX6J6wtP
         bUuCMGqwhNlLe3WaGOAblCRC0JD6VG46TcV5DeRuklRFmzC9lZV9xryhglctL4RH+2Mm
         /pFA==
X-Gm-Message-State: ANhLgQ1O8SU6cXWazmYhM/PYttjXcpbO0PJCYa5VR5sgP0aRtj0G4w59
        +gYuJ09sPyrlHQAa0bKEZNg=
X-Google-Smtp-Source: ADFU+vu9hTq+vovNK3nH59FW/BDgaY26b3Q8S/Z5QE3/J7G7QtC0rlIGC3JHo1IAl2lJTGqiG4pIPA==
X-Received: by 2002:a62:3854:: with SMTP id f81mr1875949pfa.81.1584591327319;
        Wed, 18 Mar 2020 21:15:27 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:84b7:c685:175f:6f9b? ([2601:647:4000:d7:84b7:c685:175f:6f9b])
        by smtp.gmail.com with ESMTPSA id k3sm536056pgr.40.2020.03.18.21.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 21:15:26 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] RDMA/srpt: use ib_alloc_cq instead of
 ib_alloc_cq_any
To:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, loberman@redhat.com,
        linux-rdma@vger.kernel.org
Cc:     kbusch@kernel.org, leonro@mellanox.com, jgg@mellanox.com,
        dledford@redhat.com, idanb@mellanox.com, shlomin@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, rgirase@redhat.com
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-5-maxg@mellanox.com>
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
Message-ID: <9bb2758f-19b2-34ff-dd78-78ff00ae234f@acm.org>
Date:   Wed, 18 Mar 2020 21:15:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318150257.198402-5-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-03-18 08:02, Max Gurtovoy wrote:
> For spreading the completion vectors fairly, add global ida for RDMA
> channeles and use ida_simple_{get,remove} API. This is a preparation
  ^^^^^^^^^
  channels?

> +/* Will be used to allocate an index for srpt_rdma_ch. */
> +static DEFINE_IDA(srpt_channel_ida);

I don't think that we need a global data structure for spreading work
across completion vectors. How about assigning 0 to ch->idx if
SRP_MTCH_ACTION is not set during login and assigning 1 .. n to ch->idx
for all other channels for which SRP_MTCH_ACTION is set during login?

> +	 /* Spread the io channeles across completion vectors */
                       ^^^^^^^^^^^^
                       RDMA channels?

Thanks,

Bart.
