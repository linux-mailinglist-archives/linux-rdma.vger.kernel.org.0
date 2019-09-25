Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8BC0BD616
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 03:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391018AbfIYBXJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Sep 2019 21:23:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44687 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388964AbfIYBXI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Sep 2019 21:23:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id g3so2225903pgs.11
        for <linux-rdma@vger.kernel.org>; Tue, 24 Sep 2019 18:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=N88czZaka9elXdi0Y8tqcRVmYCpGWH3gKwwftLqDuqE=;
        b=pbghWis5lgXMtnIc2rmBeMRXmN+jBHx8cuYXkqRUEDnE0T5igRydKTdRHLGoUG2s/L
         pK18sWM90vIWIovCTP5ffWb2wDCS+rdju6nLRAyxKJkiS3/CUgXBS6wGJ6FZk3yGbfjK
         KWZ5ga1kVa4FKWbH/g22Ss/sv+W7EEqOXdP2Hldpyf3Ep6TigNuxaChlMMX4U70siqXg
         SShVlcou7wmhNARMLCoI4RF2CkiOPvwGol9z3x1EP538YZcd8FUTR3xOfp5peEZjKltA
         UODqc/+hO2kyxlCo2D9wAFTfwy5lDbFDTr60w/+j0SGtPtLbKKuM4+l+yei6cyEzizPl
         fGyw==
X-Gm-Message-State: APjAAAX2slkOxsH9ZUuhaBiNXQs1H/AalYa+i2jZeg+KQSL9/RVFO8Q3
        r6M98JX40v2+nACTEy/yGGsDKbhT
X-Google-Smtp-Source: APXvYqxf/uHmECba+LxC6UUxSuwIdwTvwj0/2pPVih2wfIbEkeG3k+FQX3Lm0Nn70qOvN1pbI14i4g==
X-Received: by 2002:a62:7e97:: with SMTP id z145mr6712835pfc.238.1569374586986;
        Tue, 24 Sep 2019 18:23:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:a9:5909:cf30:7c76:8feb])
        by smtp.gmail.com with ESMTPSA id q13sm4482986pfn.150.2019.09.24.18.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 18:23:05 -0700 (PDT)
Subject: Re: [rdma-core patch v2] srp_daemon: print maximum initiator to
 target IU size
To:     Honggang LI <honli@redhat.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org
References: <20190925004200.32401-1-honli@redhat.com>
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
Message-ID: <36264545-674e-bee3-9d05-85c39356c739@acm.org>
Date:   Tue, 24 Sep 2019 18:23:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190925004200.32401-1-honli@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2019-09-24 17:42, Honggang LI wrote:
> From: Honggang Li <honli@redhat.com>
> 
> The 'Send Message Size' field of IOControllerProfile attributes
> contains the maximum initiator to target IU size.
> 
> When there is something wrong with SRP login to a third party
> SRP target, whose ib_srpt parameters can't be collected with
> ordinary method, dump the 'Send Message Size' may help us to
> diagnose the problem.
> 
> Signed-off-by: Honggang Li <honli@redhat.com>
> ---
>  srp_daemon/srp_daemon.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/srp_daemon/srp_daemon.c b/srp_daemon/srp_daemon.c
> index 337b21c7..cf046b79 100644
> --- a/srp_daemon/srp_daemon.c
> +++ b/srp_daemon/srp_daemon.c
> @@ -1022,6 +1022,8 @@ static int do_port(struct resources *res, uint16_t pkey, uint16_t dlid,
>  			pr_human("        vendor ID: %06x\n", be32toh(target->ioc_prof.vendor_id) >> 8);
>  			pr_human("        device ID: %06x\n", be32toh(target->ioc_prof.device_id));
>  			pr_human("        IO class : %04hx\n", be16toh(target->ioc_prof.io_class));
> +			pr_human("        Maximum size of Send Messages in bytes: %d\n",
> +				 be32toh(target->ioc_prof.send_size));
>  			pr_human("        ID:        %s\n", target->ioc_prof.id);
>  			pr_human("        service entries: %d\n", target->ioc_prof.service_entries);
>  
> 

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
