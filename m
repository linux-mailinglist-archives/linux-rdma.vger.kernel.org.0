Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBBC3A076D
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 01:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbhFHXHB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 19:07:01 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:38464 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbhFHXHA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 19:07:00 -0400
Received: by mail-wr1-f54.google.com with SMTP id c9so14592909wrt.5
        for <linux-rdma@vger.kernel.org>; Tue, 08 Jun 2021 16:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nTinY+c+OIhObfTEmkTUdRD4dUhuH9fxaFlVcwqJwBU=;
        b=SndYwFT1AFAGsjzMkBviCxOB2eQp4GfzNx5VGqBWzXAGAb7gvaf6H6WwkFB7IjQ6vT
         S2GMrXANvX7Fo31yjzyT4XEige9d7y0C+iAac3DE/DgPvt/OLlad4XxQCGNXLEv3TiFu
         lTaNwVEB+YOSrJiRlPry1o66VuLec7RedsesvN0NSZm6lTn5fOqVLIp0woxHRC6gXDrn
         /QfQn0pvJlfagmxx0FLNDtG1mc5oAb6PyKGaAji2v7h9LO9t3GfuvxNr2zKyofvpxel0
         wpoog4c3xZDFySg+4HaTp3IAf0vZD9z63xeUbyab+15fdHwiNwuFXEfte9KiXs5O0uUr
         DrDg==
X-Gm-Message-State: AOAM532nYm2HVljjr9h92JY+O6VBAE9KcXo5zdclQtR2/2OF2VrrAY0S
        Xprk7y4D/hHSi/xbCbQjZe4=
X-Google-Smtp-Source: ABdhPJzZbFY4NEm4XeJIiuCjuk2EeKE2uBvvDITRRhwDUYjJ5StROqbcE6WrNKkbwRBbMGvTgw60Sw==
X-Received: by 2002:a05:6000:2ce:: with SMTP id o14mr25407099wry.145.1623193495309;
        Tue, 08 Jun 2021 16:04:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:12a9:2416:ca98:264f? ([2601:647:4802:9070:12a9:2416:ca98:264f])
        by smtp.gmail.com with ESMTPSA id 30sm22942734wrl.37.2021.06.08.16.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 16:04:55 -0700 (PDT)
Subject: Re: [PATCH 1/1] IB/isert: align target max I/O size to initiator size
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, Kamal Heib <kheib@redhat.com>
Cc:     israelr@nvidia.com, alaa@nvidia.com, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
References: <20210524085215.29005-1-mgurtovoy@nvidia.com>
 <46c4d30d-510d-b329-4793-8a354642632e@grimberg.me>
 <fdef3991-74e1-63f1-593e-ac2018286ae9@nvidia.com>
 <b62e5d29-025a-0827-ecad-a48812114220@redhat.com>
 <e6623d9e-0122-ea0c-e148-f739bd15b0bb@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0e4f17d0-5237-e9ae-44a0-4891a53bb26a@grimberg.me>
Date:   Tue, 8 Jun 2021 16:04:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e6623d9e-0122-ea0c-e148-f739bd15b0bb@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> On 5/25/21 7:22 PM, Max Gurtovoy wrote:
>>> On 5/25/2021 6:54 PM, Sagi Grimberg wrote:
>>>>> Since the Linux iser initiator default max I/O size set to 512KB and
>>>>> since there is no handshake procedure for this size in iser protocol,
>>>>> set the default max IO size of the target to 512KB as well.
>>>>>
>>>>> For changing the default values, there is a module parameter for both
>>>>> drivers.
>>>> Is this solving a bug?
>>> No. Only OOB for some old connect-IB devices.
>>>
>>> I think it's reasonable to align initiator and target defaults anyway.
>>>
>>>
>> Actually, this patch is solving a bug when trying iser over 
>> Connect-IB, We see
>> the following failure when trying to do discovery:
> 
> You can work around this using the ib_isert sg_tablesize module param 
> and set it to 128.
> 
> So it's more OOB behavior than a bug.
> 
> Anyway, This is good practice to be able to establish connections also 
> for old devices without WAs and we also aligning to the sg_table size in 
> the initiator side.
> 
> Jason/Sagi,
> 
> can you comment on this patch for 5.14 ?

Actually, if this is the case, why not have a fallback when creating the
QP? Seems more reasonable to have the exception for the old devices
rather than having those mandate the common denominator no?
