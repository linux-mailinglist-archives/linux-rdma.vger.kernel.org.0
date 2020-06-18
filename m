Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC971FF427
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2020 16:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgFROD5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jun 2020 10:03:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41074 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730294AbgFRODz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Jun 2020 10:03:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so2829147pfx.8;
        Thu, 18 Jun 2020 07:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1WN3ZnREZD5mqi8HO9H+H34Iu3eMNBHfeSJB4E/zR+M=;
        b=dQAvWbzQ0azWoU0hn8ksocV8vqrPCfJh0DuOlWUvM2DyoCXeFrVBtE5k8aGHvnHfZO
         2ZC08y+8tW3OEZNNdFKPv26RknJCbyUjz3D1AEd1m+ugrwHI7/C48CHFKt/wgr7ZNG+f
         rMOApomfJV1UfrcBoXpFYyW06vbyHkMTjXzSPyyRFWxldcn1oVY8xWeTuxRnYu2UTi8A
         wR9Ri1wD3GmiRq30z1PHlzrKL3u7Hb6EEk9JJcOnc9kb/oP6aQRLlSLUZ7/UgPfGbCqu
         OYDUvlLbSzNsSyDWlKNmVgh3Igclrl8cA2+jvCmcs4OM7h/QVy9dkNOwF/+nL4kT5iqo
         eqFg==
X-Gm-Message-State: AOAM532sURYNj2uxBbhZc5Oa4rA1NJElXa3piQd/+vlzdwuaZPO8wj+q
        kVrrfunjxMQKmUlpGVXqfB4vexTF
X-Google-Smtp-Source: ABdhPJzbhwbwQOEUu3YJw6YezVA/RUpvZiw+gzIegGMyl/FadwacdffeWBUE8cH6Ocg4N6Sg/YgkoQ==
X-Received: by 2002:a63:5406:: with SMTP id i6mr3323164pgb.155.1592489034924;
        Thu, 18 Jun 2020 07:03:54 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id h9sm2537716pjs.50.2020.06.18.07.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 07:03:54 -0700 (PDT)
Subject: Re: [PATCH v3] IB/srpt: Remove WARN_ON from srpt_cm_req_recv
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20200617140803.181333-1-jingxiangfeng@huawei.com>
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
Message-ID: <3d0354bc-e859-740a-f2d8-362604377f86@acm.org>
Date:   Thu, 18 Jun 2020 07:03:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617140803.181333-1-jingxiangfeng@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-06-17 07:08, Jing Xiangfeng wrote:
> The callers pass the pointer '&req' or 'private_data' to
> srpt_cm_req_recv(), and 'private_data' is initialized in srp_send_req().
> 'sdev' is allocated and stored in srpt_add_one(). It's easy to show that
> sdev and req are always valid. So we remove unnecessary WARN_ON.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
