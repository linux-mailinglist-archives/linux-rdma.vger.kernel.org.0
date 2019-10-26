Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABDC0E5800
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Oct 2019 04:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfJZCKs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Oct 2019 22:10:48 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:44753 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfJZCKr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Oct 2019 22:10:47 -0400
Received: by mail-pg1-f182.google.com with SMTP id e10so2768705pgd.11
        for <linux-rdma@vger.kernel.org>; Fri, 25 Oct 2019 19:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pn1qvz6Md7SO6ix33L65Mj4xPBnWVkFXB9i9ZN4vaWU=;
        b=rmPtBbPv/HrpWDxQl1ugEs2sX1FwM6zxH0s0AdvG+av0mr6q6W00gQriRKVXlOPz0U
         xMUHJynZgvPUVME8n98dyjsieiKkokWvd63fxk97BwokKkVnG4R09zY3oC7fbswRW/pW
         MSw9AcSfUIoz4Y/OcnE+KHc2jUxvle886mCzCaW9AAgrRAhOl6Dhg/RE3zMVdgiDmrcb
         Vu6pWH9S2KrX9k1w9hAvJjwSE8o1g2uCR71KOiOGGpixvukJmbcXSV5Cn9CMb6ekMPPA
         kuxFEqeUmHmCmBN/Sz7u8n8HVBxgmQy3DFTk0ZXAgBG4w46Kwq1EYeaydOIm665W3I1f
         7ImQ==
X-Gm-Message-State: APjAAAWaFPOJxw6ns3kmdFv6e0x5Vzqs3haTOs5F92L2k3e6r+oWAAMC
        jaRN12VYW4pYKjlj2DfCDuebV2Gn
X-Google-Smtp-Source: APXvYqwFrX6t0m1+T8yhGnc9iWvbd/EJXCek4RgQ2YiG6AZj8V1i12RFkfgR/JXlEmXOs5oTykRjEg==
X-Received: by 2002:a63:ed4b:: with SMTP id m11mr7894781pgk.24.1572055846366;
        Fri, 25 Oct 2019 19:10:46 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:c3:e8e8:6182:152f:5392])
        by smtp.gmail.com with ESMTPSA id j10sm3485303pfn.128.2019.10.25.19.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 19:10:45 -0700 (PDT)
Subject: Re: [linux-next patch] RDMA/srp: add module parameter
 'has_max_it_iu_size'
To:     Honggang LI <honli@redhat.com>, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org
References: <20191025132318.13906-1-honli@redhat.com>
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
Message-ID: <e797397c-3bfb-610a-bcf1-9cfdfc75c680@acm.org>
Date:   Fri, 25 Oct 2019 19:10:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191025132318.13906-1-honli@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2019-10-25 06:23, Honggang LI wrote:
> +module_param(has_max_it_iu_size, bool, 0444);
> +MODULE_PARM_DESC(has_max_it_iu_size,
> +		  "Indicate the module supports max_it_iu_size login parameter");

Since the approach of this patch requires to add one new kernel
parameter every time a new login parameter is added, I don't think this
approach is future-proof. Has it been considered to export a list of all
supported login parameters to user space?

Thanks,

Bart.
