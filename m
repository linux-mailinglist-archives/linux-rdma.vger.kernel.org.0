Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DED2437FF
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Aug 2020 11:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHMJw5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Aug 2020 05:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgHMJw4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Aug 2020 05:52:56 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4932C061757
        for <linux-rdma@vger.kernel.org>; Thu, 13 Aug 2020 02:52:55 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a5so4679041wrm.6
        for <linux-rdma@vger.kernel.org>; Thu, 13 Aug 2020 02:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=V7Es5JYzZ9YYRokXYRb/HdpkgD9NPO2eJImu9Fwscwo=;
        b=kYC57pUlNz+7k36/mOsYxtcspOicIlNvrMYIIzK3K7OGyJERRUQ5Vmwg8BE1IgwDFh
         9jlNAJfytnkGxFpNJz3ieKCC8eKWNJljo80zddFwy9SEwCM9wcc4W7CmZBM3uUnAx2O4
         SOjzyuOGpKIZEV55V+VDGH0L7BRCkrd/FNC9CIrqzY+WcLRKLDD3v43SyCBy9s1KMLdY
         HEbjZAFV1VXwI2DCC7/t1q0T2Xj0G1lGjcglz910ykMENQJIclIyHH1nqarleXPMuXyH
         ynj4xOiK7nCbwqe2296ltxyMkMGXhwvPOEOxK1FfsXG27Fd+ZA2lNztil49wHLEKrCKl
         Yy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=V7Es5JYzZ9YYRokXYRb/HdpkgD9NPO2eJImu9Fwscwo=;
        b=td05rVRoMJhTg/BIw0moKUdhnuOIbjQuWvhrLelcgKWAXIGQ4HiS6XFxXEOil8FhTv
         mW4xjhmctten6hsrFTEh0nFAfJIMRrE95LwCZhmQll4yMeaLopo0TmZvXSRImhYy63aq
         uAA4BWOcRbUzQykpFVGhdqUhsHJtF2atoia/h4fPu75Bwg6L3M1hy4zyPTAciOhAfdFW
         SmLZTYaPm3M/xcKwaT10ZR/ztZxiU4gs1If23M5ed4BLdny/7Q8231OtxexpzCdUSVG9
         XENhvB1wXxEIf7XObG7IMYM322asfC4eS5M70uQPgHNE2AImabLmUVgWK/VJW678Cbl1
         GANg==
X-Gm-Message-State: AOAM530kRRgiLPgCDOXXmZ/mWioibt9o8v+aqscjmqbgeeQvj9ho6j67
        khWIlWWJAyp6oLFL/77qQw==
X-Google-Smtp-Source: ABdhPJwzs5H4cvwDcMExPAGDfjDBdyqRe+mgXe5zpU+0XSadD6aA4fn/QS1lQEkdKKFANq7wKt2YUw==
X-Received: by 2002:adf:a19e:: with SMTP id u30mr3189968wru.274.1597312374610;
        Thu, 13 Aug 2020 02:52:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ed0:52b8:d200:a27:853c:38cb:3b83])
        by smtp.gmail.com with ESMTPSA id g8sm8551415wme.13.2020.08.13.02.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 02:52:54 -0700 (PDT)
Subject: Re: [PATCH] RDMA/rxe: prevent rxe creation on top of vlan interface
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, kamalheib1@gmail.com,
        leon@kernel.org
References: <20200811150415.3693-1-goody698@gmail.com>
 <72e827bd-2934-8947-15e5-3692ab7409ae@gmail.com>
From:   mohammad <goody698@gmail.com>
Message-ID: <bf68fa99-3300-0e63-9b72-3bf143b74a3d@gmail.com>
Date:   Thu, 13 Aug 2020 12:52:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <72e827bd-2934-8947-15e5-3692ab7409ae@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 8/13/20 6:16 AM, Zhu Yanjun wrote:
> On 8/11/2020 11:04 PM, Mohammad Heib wrote:
>> Creating rxe device on top of vlan interface will create a 
>> non-functional device
>> that has an empty gids table and can't be used for rdma cm 
>> communication.
>
> Can we fix this empty gids table?

I'm not sure if that can be done in the rxe only, since the IP's of the 
netdev enrolls into

the gids table by the ibcore in the device registration 
stage(gid_table_setup_one) and that requires making changes in the ibcore.


we can enroll those IP's into the device gids table after the rxe device 
registration but still

we have to expose some ibcore functions (add_netdev_ips) and track the 
address change events of the

vlan interface and update the gids table accordingly to those IP's changes.

>
> So this gids table can be used for rdma cm communication.
>
> Zhu Yanjun
>
>>
>> This is caused by the logic in 
>> enum_all_gids_of_dev_cb()/is_eth_port_of_netdev(),
>> which only considers networks connected to "upper devices" of the 
>> configured
>> network device, resulting in an empty set of gids for a vlan interface,
>> and attempts to connect via this rdma device fail in 
>> cm_init_av_for_response
>> because no gids can be resolved.
>>
>> apparently, this behavior was implemented to fit the HW-RoCE devices 
>> that create
>> RoCE device per port, therefore RXE must behave the same like HW-RoCE 
>> devices
>> and create rxe device per real device only.
>>
>> In order to communicate via a vlan interface, the user must use the 
>> gid index of
>> the vlan address instead of creating rxe over vlan.
>>
>> Signed-off-by: Mohammad Heib <goody698@gmail.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe.c       | 6 ++++++
>>   drivers/infiniband/sw/rxe/rxe_sysfs.c | 6 ++++++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe.c 
>> b/drivers/infiniband/sw/rxe/rxe.c
>> index 5642eefb4ba1..d2076aa7a732 100644
>> --- a/drivers/infiniband/sw/rxe/rxe.c
>> +++ b/drivers/infiniband/sw/rxe/rxe.c
>> @@ -310,6 +310,12 @@ static int rxe_newlink(const char *ibdev_name, 
>> struct net_device *ndev)
>>       struct rxe_dev *exists;
>>       int err = 0;
>>   +    if (is_vlan_dev(ndev)) {
>> +        pr_err("rxe creation allowed on top of a real device only\n");
>> +        err = -EPERM;
>> +        goto err;
>> +    }
>> +
>>       exists = rxe_get_dev_from_net(ndev);
>>       if (exists) {
>>           ib_device_put(&exists->ib_dev);
>> diff --git a/drivers/infiniband/sw/rxe/rxe_sysfs.c 
>> b/drivers/infiniband/sw/rxe/rxe_sysfs.c
>> index ccda5f5a3bc0..0a083c3d900a 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_sysfs.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_sysfs.c
>> @@ -73,6 +73,12 @@ static int rxe_param_set_add(const char *val, 
>> const struct kernel_param *kp)
>>           return -EINVAL;
>>       }
>>   +    if (is_vlan_dev(ndev)) {
>> +        pr_err("rxe creation allowed on top of a real device only\n");
>> +        err = -EPERM;
>> +        goto err;
>> +    }
>> +
>>       exists = rxe_get_dev_from_net(ndev);
>>       if (exists) {
>>           ib_device_put(&exists->ib_dev);
>
>
