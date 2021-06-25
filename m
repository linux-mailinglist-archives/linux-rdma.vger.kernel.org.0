Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45393B3C04
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 07:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhFYFQU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 01:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhFYFQU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Jun 2021 01:16:20 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B4EC061574
        for <linux-rdma@vger.kernel.org>; Thu, 24 Jun 2021 22:13:58 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so8112105oth.9
        for <linux-rdma@vger.kernel.org>; Thu, 24 Jun 2021 22:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7A9AmGfy9/gpItjkyvTolgruyPAoCJKMWQxUMLTGaMo=;
        b=Sl7BQ6svMRWOYgwnTgJGBRC4sKwsnFzUi/MyVE8kRSHg3pNwtnO8vEBofm+njPxVNq
         xfOxwHRh9V6WvCnaq5IzoC9EAhdDZUGo5O+fjMpWtdge76L0fBWObB1uWt2F73F6v/H/
         5xlzPJIUyjTit2Xhf/rkAxT1TCbrLgP2SYMj8eGbQ3axlfzVJKzRt1J38V+8/SRv5cI5
         Gy/jvDaJdDTt7FUHatwOgbNMnLDpVVoTpdpm/lVsVQ8hxgLGauZ9CSPszYnV02rKLd0v
         Mqo7tJ4D8rZujCtJLeOsSCEzda+cFVwicwpqmzWILuBrjgwZiUaLZ0EysmzzQFBIBd9C
         uCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7A9AmGfy9/gpItjkyvTolgruyPAoCJKMWQxUMLTGaMo=;
        b=J2Q0WKXdKIiUvEWAqNms7Lae9TD8qmOEDTpd4TbXUjs2jcOIOIioisIxZJtbjds6DJ
         wi4vjycuP2L1/oZ6BPGR+jwGzpR8ruH2H8jLgC+n5vlIfqEWkQ/8o5Ai6NTiivBwvOaz
         Mody4NESy7aoPJRLSCa7zjAMbTGleoYvd9Hi50uyM4uJJ0oLZHzeCaTQJi/rEYAPtwTy
         wCc/ZdJdlkbo9Ci55ZSarodp8qLwOZ4OIoZf0rCQaqjMkN6xS3LzmbWd4SpMZlWNR8Nd
         VWL885QvxeHcJ/szGu7khMkqk/pM15n1ptEMeq8vYCIGTqZ8TKiqukGfB3UyZQBR5mwq
         2eSg==
X-Gm-Message-State: AOAM531FF7Ol5GJN1H0osSxuACwekpKHAsI2GMuqAX+7uB/KBzRkcGni
        TZAtAi051WgU8t5OMBGhS+E=
X-Google-Smtp-Source: ABdhPJwyY2wY1ISdyVJIn7+/1wOaNyjRN29xLM4JxXau3E9oUv3pObjSLYop3jBaBeIt1MARaQAgtw==
X-Received: by 2002:a05:6830:248a:: with SMTP id u10mr7938178ots.264.1624598038266;
        Thu, 24 Jun 2021 22:13:58 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:8bf2:41e6:f3a9:1be4? (2603-8081-140c-1a00-8bf2-41e6-f3a9-1be4.res6.spectrum.com. [2603:8081:140c:1a00:8bf2:41e6:f3a9:1be4])
        by smtp.gmail.com with ESMTPSA id e4sm823615oii.24.2021.06.24.22.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 22:13:58 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] RDMA/rxe: Increase value of RXE_MAX_AH
To:     Shoaib Rao <rao.shoaib@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Zhu Yanjun <zyjzyj2000@gmail.com>
References: <20210617182511.1257629-1-Rao.Shoaib@oracle.com>
 <20210617182511.1257629-3-Rao.Shoaib@oracle.com>
 <3aa5a673-3fd7-744b-b664-510005215bd2@gmail.com>
 <10d9763c-4d10-3820-93a0-b79f55acfa8e@oracle.com>
 <edcf0cc0-4da8-5af3-3366-220b4eeba5e4@gmail.com>
 <20210618163359.GA1096940@ziepe.ca>
 <14e2c2a4-6067-c657-6ea4-91cd3c19d032@gmail.com>
 <20210618232535.GB1096940@ziepe.ca>
 <9b651595-94b1-4ecd-1e37-16459530f297@oracle.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <5979c6c7-7ffe-d08c-f970-f97a1727988a@gmail.com>
Date:   Fri, 25 Jun 2021 00:13:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9b651595-94b1-4ecd-1e37-16459530f297@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/24/21 4:21 PM, Shoaib Rao wrote:
> 
> On 6/18/21 4:25 PM, Jason Gunthorpe wrote:
>> On Fri, Jun 18, 2021 at 01:58:48PM -0500, Bob Pearson wrote:
>>> On 6/18/21 11:33 AM, Jason Gunthorpe wrote:
>>>> On Thu, Jun 17, 2021 at 10:56:58PM -0500, Bob Pearson wrote:
>>>>  
>>>>> It isn't my call. But I am in favor of tunable parameters. -- Bob Pearson
>>>> Can we just delete the concept completely?
>>>>
>>>> Jason
>>>>
>>> Not sure where you are headed here. Do you mean just lift the limits
>>> all together?
>> Yes.. The spec doesn't have like a UCONTEXT limit for instance, and
>> real HW like mlx5 has huge reported limits anyhow.
> 
> These limits are reported via uverbs, so what do we report without current applications. Creating pool also requires limits but I guess we can use something like -1 to indicate there is no limit. I would have to look at all the values to see if we can implement this.
> 
> Shoaib
> 
> 
>>
>> Jason
The object create in pools (rxe_alloc_locked) just calls kzalloc for objects allocated by rxe and checks the limits. For objects allocated by rdma-core (__rxe_add_to_pool) it just checks the limits. The only place where the limit really matters is when a pool is indexed (RXE_POOL_INDEXED). Then there is a bitmask used to allocate the indices for the objects which consumes one byte for each 8 objects. 

From Jason's comment I think just setting the limits fairly large but not excessive is the right approach.

Bob
