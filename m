Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A1B271815
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Sep 2020 23:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgITVNb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Sep 2020 17:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgITVNb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Sep 2020 17:13:31 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8E4C061755
        for <linux-rdma@vger.kernel.org>; Sun, 20 Sep 2020 14:13:31 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x69so14602360oia.8
        for <linux-rdma@vger.kernel.org>; Sun, 20 Sep 2020 14:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d0irN35u46dyF0yfzTOe9CvprMWAS7yBdSFhvVlC71w=;
        b=nFqY2UF+v3mQgncEvdNl4gG2WBgDC77xLP55B21U9A7BfH1lxgq1MYzYuNAWHWu6KA
         TRayfnUQxCLrDKlw52QoAgaGK87AzODG5gyFb9IeN0ws+EdkcuESQVsR6EhfyoR1xcm6
         903u9MrPl+2ZAGYUFk9GKzlM8vlmScifBDZhqaIHdWkjI3NDJpucK40Kgcb00vU702TI
         EcU96Y1NhlrOd9W/eKfgmVTK0HfaKTKsGKGtqytWMs+jqo4MeNl2Tqzn7N+o3aQewoBF
         AXcm4DUIoePNKTtWDpZOJ0MbhOdjJeYmVcTuTnyDiaGn+/bOgQnS9LTa7zdowVeNr1Mo
         aVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d0irN35u46dyF0yfzTOe9CvprMWAS7yBdSFhvVlC71w=;
        b=cOLP/CmQQSXCyoVXiMM6ZGjYZOAKkDbBrq9gGw1RgOari0DvDnnL39jWjaKoLv/WmC
         QvuL0DbVOwUYI7Ggr0xRw7LPE7MFbxzY9pEagkWcnYJsmMT42QxfGjCjgOG7qqLJzayF
         SNTFTVixIs4IFzByy0YlFc+eyUNiKZKuf6h0kAvb60Jlb5cRdPREOQ/h1Sji1MxxC+d4
         ZssHzxkVvKxrPKbPA4Q4Qf8CAVBrK1l7t/wB4DSafeXCrrM9grwbROXPdiLrIKxxN6qE
         bhKzPnnb9r15/9dZpglggouVl1mHnnsBXn6pf4Jm6wFpXKGokzR5EmOa+MsB3c1CPRfs
         Dz8A==
X-Gm-Message-State: AOAM5322LARPCFEEA1pmms9JCm5uSYEJRwTBAlP6yUDcfuqLMzRGKpUk
        BZReNPuo5RPkFW/CMkli5oQ=
X-Google-Smtp-Source: ABdhPJznbx+9Il1H/Px9x35Q9ZvOPeeX6zHaPuCVK+ub4PENBzQezs6HjVDouSpp+kEpbgR9lR+hLg==
X-Received: by 2002:aca:1e08:: with SMTP id m8mr15047567oic.168.1600636410356;
        Sun, 20 Sep 2020 14:13:30 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:d694:2e0d:a0f6:ae9b? ([2605:6000:8b03:f000:d694:2e0d:a0f6:ae9b])
        by smtp.gmail.com with ESMTPSA id m15sm7505304ooj.10.2020.09.20.14.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 14:13:29 -0700 (PDT)
Subject: Re: [PATCH for-next v5 00/12] rdma_rxe: API extensions
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Bob Pearson <rpearson@hpe.com>
References: <20200918211517.5295-1-rpearson@hpe.com>
 <20200918235117.GK3699@nvidia.com>
 <ec3bf0ed-8dde-5f36-656f-3cf6d64bd7a2@gmail.com>
 <088207e0-bdaf-0d0c-62b9-612941825ca8@gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <f6803def-13b8-04f0-5fd0-cbad702f1837@gmail.com>
Date:   Sun, 20 Sep 2020 16:13:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <088207e0-bdaf-0d0c-62b9-612941825ca8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/19/20 3:46 AM, Zhu Yanjun wrote:
> On 9/19/2020 4:44 PM, Zhu Yanjun wrote:
>>
>> On 9/19/2020 7:51 AM, Jason Gunthorpe wrote:
>>> On Fri, Sep 18, 2020 at 04:15:05PM -0500, Bob Pearson wrote:
>>>> This patch series is a collection of API extensions for the rdma_rxe driver.
>>>> With this patch set installed there are no errors in pyverbs run-tests and
>>>> 31 tests are skipped down from 56. The remaining skipped test cases include
>>>>     - XRC tests
>>>>     - ODP tests
>>>>     - Parent device tests
>>>>     - Import tests
>>>>     - Device memory
>>>>     - MLX5 specific tests
>>>>     - EFA tests
>>> It seems like a big improvement! Thanks!
>>>
>>> Zhu, can you look through this too?
>>
>> OK. It seems that a problem occurred in this patch set.
>>
>> Hi, Bob
>>
>> Please fix this problem. Thanks a lot.
> 
> The problem mail is in the attachment. Please check and fix it.
> 
> Zhu Yanjun
> 
>>
>> Zhu Yanjun
>>
>>>
>>> Jason
>>>
>>>> It continues from the previous (v4) set which implemented memory windows and
>>>> has had a number of individual patches picked up in for-next.
>>>>
>>>> This set (v5) includes:
>>>>     Ported to current head of tree
>>>>     Memory windows patches not yet picked up
>>>>     kernel support for the extended user space APIs:
>>>>       - ibv_query_device_ex
>>>>       - ibv_create_cq_ex
>>>>       - ibv_create_qp_ex
>>>>     Fixes for multicast which is not currently working
>>> I would like to progress the simple independent obviously OK bits,
>>> could you split them out?
>>>
>>> Jason
> 
> 
Zhu,

The missing prototype was a good catch. (That is resolved now.) But I can't figure out the null pointer arithmetic warnings. They are all in obscure distant header files. Do you have any insight about those?

Bob
