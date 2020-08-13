Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A59243D0C
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Aug 2020 18:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgHMQNr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Aug 2020 12:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMQNp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Aug 2020 12:13:45 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EECC061757
        for <linux-rdma@vger.kernel.org>; Thu, 13 Aug 2020 09:13:45 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f5so2825054plr.9
        for <linux-rdma@vger.kernel.org>; Thu, 13 Aug 2020 09:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cs8gh9ya9FYSHDVRwCkzYIU3yDO5ozRzK+mhfLwio9s=;
        b=va3kPVrAuHnChVIJIvRSX/yRKdxlHMlortljgRAMGyj3VgNe73uOOMPVILHByZvtvZ
         4zc49uBrk1OXxvRrumHuFKLViNzjs5KU6rNXCccE9MkQJRIJR1P0j/OpRl+QRCEV5f19
         sjy3GXciZm3sIG3q8MEmb2i/opg7/3baurNulYRf6oIMHn5S62gnGpBnM8Snp32Z7DGS
         eD/EzJ4xcx3ZVfvg1cOnM8VwBJZk2j1miA0bW3q/o3l4tYVW76ArM86/gvscKg74GHM0
         BPLLMqM/RDeoYX63KvAUojRcxFM7kGcIppwPCRWqEFf6lB7BDN8R6ivhVsKyGuqZLWMj
         3zlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cs8gh9ya9FYSHDVRwCkzYIU3yDO5ozRzK+mhfLwio9s=;
        b=ahq1TaAX2AOqBrfZJdYa2sYGCXnB1TG1VAU3oclqlEiYMCMMhN0TuuCjpjBILG6/QB
         UaNAKqEv2iwuR2sNCRlNDFPY3YOXJwYjVP7G6Iuj/4eD/mnO53qUAa4fOPAwiBhnkd/X
         x+prISBuv2VLijJtbHHuh/OS4Cs1ZxqIwbNeqyfiPpv+q9Dex3BFiYJof/uU/OO3dZkP
         icGop0SsEwHNGTgOEZDyT6kYEAA1PpoQNNcu4cvy8h/ac2XjI7cKjuGQCCsiWIteVK5S
         NByWM7cHuUCRHkWM019n7FkA9ccRQ16B2a8m8uimxL1q/TQ3tvu7vwpeawZwXmkLTdoV
         WclQ==
X-Gm-Message-State: AOAM532qq74klKqbtntEG4cHkYlCETg3X0O9vi3eqU6iamGqnRwP2s1J
        Knh4bsnpf8xSVkaDQGrqYzM=
X-Google-Smtp-Source: ABdhPJw+lWXkhfVKb/3yxGGkHEVRsOUxoljBMGhQa5UMjxi58ZOvmzzaziWlzLR1N/Kb/fCi3ADk+Q==
X-Received: by 2002:a17:902:714c:: with SMTP id u12mr4632385plm.290.1597335225289;
        Thu, 13 Aug 2020 09:13:45 -0700 (PDT)
Received: from [10.75.201.17] ([118.201.220.138])
        by smtp.gmail.com with ESMTPSA id 196sm6657701pfc.178.2020.08.13.09.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 09:13:44 -0700 (PDT)
Subject: Re: [PATCH] RDMA/rxe: prevent rxe creation on top of vlan interface
To:     mohammad <goody698@gmail.com>, linux-rdma@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, kamalheib1@gmail.com,
        leon@kernel.org
References: <20200811150415.3693-1-goody698@gmail.com>
 <72e827bd-2934-8947-15e5-3692ab7409ae@gmail.com>
 <bf68fa99-3300-0e63-9b72-3bf143b74a3d@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Message-ID: <0fe502ec-ca24-78b2-85a8-557c5b3ac9ae@gmail.com>
Date:   Fri, 14 Aug 2020 00:13:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <bf68fa99-3300-0e63-9b72-3bf143b74a3d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/13/2020 5:52 PM, mohammad wrote:
>
> On 8/13/20 6:16 AM, Zhu Yanjun wrote:
>> On 8/11/2020 11:04 PM, Mohammad Heib wrote:
>>> Creating rxe device on top of vlan interface will create a 
>>> non-functional device
>>> that has an empty gids table and can't be used for rdma cm 
>>> communication.
>>
>> Can we fix this empty gids table?
>
> I'm not sure if that can be done in the rxe only, since the IP's of 
> the netdev enrolls into
>
> the gids table by the ibcore in the device registration 
> stage(gid_table_setup_one) and that requires making changes in the 
> ibcore.
>
>
> we can enroll those IP's into the device gids table after the rxe 
> device registration but still
>
> we have to expose some ibcore functions (add_netdev_ips) and track the 
> address change events of the
>
> vlan interface and update the gids table accordingly to those IP's 
> changes.

Thanks a lot for your explanations.

Not sure if a patch containing the above is better than just preventing 
rxe creation on top of vlan interface.

Zhu Yanjun

>
>>
>> So this gids table can be used for rdma cm communication.
>>
>> Zhu Yanjun
>>
>>>
>>> This is caused by the logic in 
>>> enum_all_gids_of_dev_cb()/is_eth_port_of_netdev(),
>>> which only considers networks connected to "upper devices" of the 
>>> configured
>>> network device, resulting in an empty set of gids for a vlan interface,
>>> and attempts to connect via this rdma device fail in 
>>> cm_init_av_for_response
>>> because no gids can be resolved.
>>>
>>> apparently, this behavior was implemented to fit the HW-RoCE devices 
>>> that create
>>> RoCE device per port, therefore RXE must behave the same like 
>>> HW-RoCE devices
>>> and create rxe device per real device only.
>>>
>>> In order to communicate via a vlan interface, the user must use the 
>>> gid index of
>>> the vlan address instead of creating rxe over vlan.
>>>
>>> Signed-off-by: Mohammad Heib <goody698@gmail.com>
>>> ---
>>>   drivers/infiniband/sw/rxe/rxe.c       | 6 ++++++
>>>   drivers/infiniband/sw/rxe/rxe_sysfs.c | 6 ++++++
>>>   2 files changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe.c 
>>> b/drivers/infiniband/sw/rxe/rxe.c
>>> index 5642eefb4ba1..d2076aa7a732 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe.c
>>> @@ -310,6 +310,12 @@ static int rxe_newlink(const char *ibdev_name, 
>>> struct net_device *ndev)
>>>       struct rxe_dev *exists;
>>>       int err = 0;
>>>   +    if (is_vlan_dev(ndev)) {
>>> +        pr_err("rxe creation allowed on top of a real device only\n");
>>> +        err = -EPERM;
>>> +        goto err;
>>> +    }
>>> +
>>>       exists = rxe_get_dev_from_net(ndev);
>>>       if (exists) {
>>>           ib_device_put(&exists->ib_dev);
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_sysfs.c 
>>> b/drivers/infiniband/sw/rxe/rxe_sysfs.c
>>> index ccda5f5a3bc0..0a083c3d900a 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_sysfs.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_sysfs.c
>>> @@ -73,6 +73,12 @@ static int rxe_param_set_add(const char *val, 
>>> const struct kernel_param *kp)
>>>           return -EINVAL;
>>>       }
>>>   +    if (is_vlan_dev(ndev)) {
>>> +        pr_err("rxe creation allowed on top of a real device only\n");
>>> +        err = -EPERM;
>>> +        goto err;
>>> +    }
>>> +
>>>       exists = rxe_get_dev_from_net(ndev);
>>>       if (exists) {
>>>           ib_device_put(&exists->ib_dev);
>>
>>

