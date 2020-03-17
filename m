Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04720189199
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 23:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgCQWuJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 18:50:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37612 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgCQWuI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Mar 2020 18:50:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id a32so11672792pga.4
        for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2020 15:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5hBg2UInqixDNtz8m0CWKvWrEprkNxjnjLnmqE6peRY=;
        b=ScWk7GKGFTT9ws9ce2UdqD28lHY2sIyLXTQHa+Ga3eRJBmWLpert5IsaupXsp418Q1
         FGHF6VdLvX3vbAkvYLx4Yz4Gy5jk4r93I1HwCo3fnvtRIdcoyQDV9bR10IxTaX+gH0Gb
         UwoqydO+YwZmU6cX6jKH+rTFTZN0k4IDrw2XdqSx60lsPSac9OP/nJAJ2LMOrLIftO48
         yBjXo8BD1Lsbwq20QsCBXMt2ZCUCSXHngSlKeIBgEYGjGTTPjzRTzHUHi95bLC6XZ8vr
         Sus79IycjTLqP8fxwZBxHUvBlrplef/r7/+f2gXbHlLJIqZmGqryNEIRLQ5q1AlQtFU8
         +9qg==
X-Gm-Message-State: ANhLgQ31YrvhuEByrwFSnhUV2/wvRByVlWwFGBDlhGZEgtOuX0qWoNDz
        1NduJIEG0XRhR53smxpb5pw=
X-Google-Smtp-Source: ADFU+vsYTjDoZEcwmb5AYdgQkBYd0HDAqlu60fFz42fJwFGtgidjsPtmvvKSHiGbbiMTZfNQxSijYw==
X-Received: by 2002:a63:ec50:: with SMTP id r16mr1568610pgj.274.1584485406022;
        Tue, 17 Mar 2020 15:50:06 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:a8f7:65f:9d45:d2f4? ([2601:647:4000:d7:a8f7:65f:9d45:d2f4])
        by smtp.gmail.com with ESMTPSA id 64sm4266798pfd.48.2020.03.17.15.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 15:50:04 -0700 (PDT)
Subject: Re: [PATCH 4/5] IB/core: cache the CQ completion vector
To:     Max Gurtovoy <maxg@mellanox.com>,
        Chuck Lever <chucklever@gmail.com>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        loberman@redhat.com, linux-rdma@vger.kernel.org, kbusch@kernel.org,
        leonro@mellanox.com, jgg@mellanox.com, dledford@redhat.com,
        idanb@mellanox.com, shlomin@mellanox.com,
        Oren Duer <oren@mellanox.com>, vladimirk@mellanox.com
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-5-maxg@mellanox.com>
 <448195E1-CE26-4658-8106-91BAFF115853@gmail.com>
 <078fd456-b1bc-a103-070b-d1a8ea6bff9c@mellanox.com>
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
Message-ID: <caa4b25d-c669-8a3f-e4d1-88f8d3a4f345@acm.org>
Date:   Tue, 17 Mar 2020 15:50:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <078fd456-b1bc-a103-070b-d1a8ea6bff9c@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-03-17 08:41, Max Gurtovoy wrote:
> On 3/17/2020 5:19 PM, Chuck Lever wrote:
>> If you want to guarantee that there is an SRQ for each comp_vector and a
>> comp_vector for each SRQ, stick with a CQ allocation API that enables
>> explicit selection of the comp_vector value, and cache that value in the
>> caller, not in the core data structures.
> 
> I'm Ok with that as well. This is exactly what we do in the nvmf/rdma
> but I wanted to stick also with the SRP target approach.
> 
> Any objection to remove the call for ib_alloc_cq_any() from ib_srpt and
> use ib_alloc_cq() ?
Hi Max,

Wasn't that call introduced by Chuck (see also commit 20cf4e026730
("rdma: Enable ib_alloc_cq to spread work over a device's comp_vectors")
# v5.4)? Anyway, I'm fine with the proposed change.

Thanks,

Bart.
