Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E553BE249A
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 22:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390572AbfJWUal (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 16:30:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40657 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388677AbfJWUal (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 16:30:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so13631506pfb.7;
        Wed, 23 Oct 2019 13:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=eGqUfv6sd2HLtSop8YbX8zWnp4hgxgG4pQ8tGisDPl0=;
        b=brzAWrnjtYEL6SXjtfIaO3EnABa/T489AqMsZeZ6V4GkldZCWg8uG6M3Ft+LkpyQGb
         nvTAzjWULd/TNcNPlFSMLJb0B6fk/cIcOSUhZJe+u1exLuBaGf4dtnfJMpfRarhu+6oB
         E+Yk7O7B1tBi8+5VcvSzMU+ssaKhlSTQ51I/ULumdh5rfSlf7uftmG6i7lNocbsEP2y0
         Ttq0tzwSiU3KJg3dQMtRoND+JUxqGDtoPGkrfTaxJe6E9FPOa7GMymaT+Kmi4e/twkFV
         dB0AXw3VbRNQUtLNEby+UXIHCOYWPw+otKqBiX9qdUKuFpOeOpqpTxk4yjW/lWEMSAdU
         m65A==
X-Gm-Message-State: APjAAAV81LaVJvrqSvBNNZ8PArbYPbNMj+04rPdiMYiBXJwrq8MxT5zR
        JLVjgiB8MmAr0gf2ZvGMFu8=
X-Google-Smtp-Source: APXvYqzyX3WPOZzBRdqJCJZBC+pvDWqqkoymNafk81Bli5XihrZsb8w3zGvlgKmwoxQ2bhVqj6d+Qg==
X-Received: by 2002:a62:a104:: with SMTP id b4mr13354050pff.239.1571862640562;
        Wed, 23 Oct 2019 13:30:40 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:c3:e5ef:65f1:8f3f:3a78])
        by smtp.gmail.com with ESMTPSA id a11sm23181325pgw.64.2019.10.23.13.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 13:30:39 -0700 (PDT)
Subject: Re: [PATCH 06/12] infiniband: fix ulp/srpt/ib_srpt.h kernel-doc
 notation
To:     rd.dunlab@gmail.com, linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
References: <20191010035239.532908118@gmail.com>
 <20191010035239.950150496@gmail.com>
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
Message-ID: <879db40b-1d88-d4ab-082e-b8535cb44cd4@acm.org>
Date:   Wed, 23 Oct 2019 13:30:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191010035239.950150496@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2019-10-09 20:52, rd.dunlab@gmail.com wrote:
> --- linux-next-20191009.orig/drivers/infiniband/ulp/srpt/ib_srpt.h
> +++ linux-next-20191009/drivers/infiniband/ulp/srpt/ib_srpt.h
> @@ -387,12 +387,9 @@ struct srpt_port_id {
>   * @sm_lid:    cached value of the port's sm_lid.
>   * @lid:       cached value of the port's lid.
>   * @gid:       cached value of the port's gid.
> - * @port_acl_lock spinlock for port_acl_list:
>   * @work:      work structure for refreshing the aforementioned cached values.
> - * @port_guid_tpg: TPG associated with target port GUID.
> - * @port_guid_wwn: WWN associated with target port GUID.
> - * @port_gid_tpg:  TPG associated with target port GID.
> - * @port_gid_wwn:  WWN associated with target port GID.
> + * @port_guid_id: target port GUID
> + * @port_gid_id: target port GID
>   * @port_attrib:   Port attributes that can be accessed through configfs.
>   * @refcount:	   Number of objects associated with this port.
>   * @freed_channels: Completion that will be signaled once @refcount becomes 0.

This is sufficient to silence the warnings reported by the kernel-doc
tool but I don't think that the new descriptions make really clear what
these structure members represent. Do you want to address this or do you
expect me to post a follow-up patch?

Thanks,

Bart.
