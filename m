Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071352879DB
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 18:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgJHQUs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 12:20:48 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:40906 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgJHQUs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Oct 2020 12:20:48 -0400
Received: by mail-wr1-f47.google.com with SMTP id j2so7274768wrx.7
        for <linux-rdma@vger.kernel.org>; Thu, 08 Oct 2020 09:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cl0qx+uvvQ/d/tOqvj4mHFS0lcLyOdj+N6HhnDNaPEU=;
        b=e6POJ3N7sOeWN5rtlNFNA9TXcb/5VvXcfWRCQB2BJWEWIyT6al1ZhHWRT8OwBo7lI2
         DZuqXZTHN75kfKX+53pyOSYX4rBEA8hUgCcOtLOWlFzo2ylOCCZaGDjSEGH+sO5Ol5ff
         Nj7OPVpW+BS/1NqUbVJ98t7tjOldZgRl6RwIf6GSM1n9Gfj77oU9HOzSNYZ/H/EHN2rY
         dhcYsuj06nvl2Pl70MQqgiQAT3AdOUUKXMPF9LeDhg+JlK8bz5WVVv2LudHddDNjpjia
         O+r3/4kb3v6mnhue5Q8IMqvYg7UDZBkSROWIwOlvwSlJf80GVOWBijKC9M9fyzUw+Ss8
         Ut3g==
X-Gm-Message-State: AOAM530UmWEn5ghkWaCZSYoe4XMgaqEorR0wmkoFHCBDh3oZnT0YbENb
        Q/eCMJeSttsPbZbHhpTTOFE=
X-Google-Smtp-Source: ABdhPJxZEoDjgtbOm35/H5l/SeNwaMox1+rAggKlqK1UKPP8uwPq2qPIQtBpeplifDnB+oWHNMwomA==
X-Received: by 2002:adf:a455:: with SMTP id e21mr11248978wra.158.1602174046825;
        Thu, 08 Oct 2020 09:20:46 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:68d6:3fd5:5a8b:9959? ([2601:647:4802:9070:68d6:3fd5:5a8b:9959])
        by smtp.gmail.com with ESMTPSA id s19sm15850488wmc.0.2020.10.08.09.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 09:20:46 -0700 (PDT)
Subject: Re: reduce iSERT Max IO size
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Krishnamraju Eraparaju <krishna2@chelsio.com>,
        linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Max Gurtovoy <maxg@mellanox.com>
References: <20200922104424.GA18887@chelsio.com>
 <07e53835-8389-3e07-6976-505edbd94f2a@grimberg.me>
 <20201002171007.GA16636@chelsio.com>
 <4d0b1a3f-2980-c7ed-ef9a-0ed6a9c87a69@grimberg.me>
 <20201003033644.GA19516@chelsio.com>
 <4391e240-5d6d-fb59-e6fb-e7818d1d0bd2@nvidia.com>
 <20201007033619.GA11425@chelsio.com>
 <1a034761-3723-3c70-8a44-25ef2cbf786e@nvidia.com>
 <fe4ff8ac-fd0a-ed6f-312b-51be9a9fdcc6@grimberg.me>
 <20201008053002.GC13580@unreal>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5ab4fea9-fefb-d138-cc3b-03f87cd6ee66@grimberg.me>
Date:   Thu, 8 Oct 2020 09:20:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008053002.GC13580@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>>> I think max IO size, at iSER initiator, depends on
>>>> "max_fast_reg_page_list_len".
>>>> currently, below are the supported "max_fast_reg_page_list_len" of
>>>> various iwarp drivers:
>>>>
>>>> iw_cxgb4: 128 pages
>>>> Softiwarp: 256 pages
>>>> i40iw: 512 pages
>>>> qedr: couldn't find.
>>>>
>>>> For iwarp case, if 512 is the max pages supported by all iwarp drivers,
>>>> then provisioning a gigantic MR pool at target(to accommodate never used
>>>> 16MiB IO) wouldn't be a overkill?
>>>
>>> For RoCE/IB Mellanox HCAs we support 16MiB IO size and even more. We
>>> limited to 16MiB in iSER/iSERT.
>>>
>>> Sagi,
>>>
>>> what about adding a module parameter for this as we did in iSER initiator ?
>>
>> I don't think we have any other choice...
> 
> Sagi,
> 
> I didn't read whole thread and know little about ULPs, but wonder if isn't
> it possible to check device type (iWARP/RoCE) during iSERT initialization
> and create MR pool only after device is recognized?

Its already done this way. The problem is that there is no handshake
procedure in iSER between the host and the target for what the maximum
transfer size would be, so currently isert sets up to a worse case of
16MB. This has implications on memory requirements.

In the absence of a handshake we should have the user choose with a 
param... Ideally that would be a configfs parameter, but a modparam can 
work as well here.
