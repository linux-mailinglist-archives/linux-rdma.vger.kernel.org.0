Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC25D189C0C
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 13:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgCRMgl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 08:36:41 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41808 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgCRMgl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 08:36:41 -0400
Received: by mail-wr1-f51.google.com with SMTP id h9so1382570wrc.8
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 05:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=90RIKfEEjJS/Wt8DZCvhpGOUJIjK1HAxXm+VfN+axJw=;
        b=vEpHoQnsMNnkgDk6LzjQ69VbfVvruBFbevuIVMnZAlc5DOcWXkVHllT62NLH0R/SBs
         GwoSI7gMIfJSlRuhCQOinOovFMw0QRF4F095NyA9OsnYsq51ABOB50DX4gRqY7IFLU2S
         n1olFgl90D4NaCfLT10FtcFcmqkpTc0aqnWR41sJ1jWKUJ+wnhtssWI2RfDEbv32X1X9
         rrZpw1zJ8JaL1MRohqXDPFBqUOE0u7U7pGap0dj4jVciKi52vfLyCbaGaOJn67m4GvkX
         HJj2a94Ovy725LfO7Ghzq3J90WzQNotVxAxPcDIu7esbXdO+alHhGLVNbSz59F+ZX2IH
         lEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=90RIKfEEjJS/Wt8DZCvhpGOUJIjK1HAxXm+VfN+axJw=;
        b=GZIFRMB+M+05Wbnr6IoWNXUyqmGLHBdVktqS1dxVBnRgATP+EAVKTeDUS94QcIlRUg
         NrTM9845zZW7umIaSP3Z5I47F+kHDA08/82XOuq+3f/7yH4RAS7EX4uqFzkkl6CjQg9V
         hfe7ZmJdB6pjZqzDTfJNQOKUyKTWE1q+Tlzb+7UXkilTGEGxtK6QmNjwtOrEEE2NIis8
         3MT2pxxc1JV0ToKvoNUJf3L9dkzlE5s6L6XW9qNh/LpurPO9IHca+Ni2RCoVE3kg+jjT
         bqXispKXjxjLkzUAulK7IOU0XmtZldO1qXQRt7y3qUmbtulKIrGR5lKsXJ+FyQxXZ6NW
         qePA==
X-Gm-Message-State: ANhLgQ398pEMizQyCs4guN5xqh0+lW/kXsiCnKSu17+es+XI/HlEd858
        seCn3stfnIExuPg8rlVaaj2oJUbZfU4=
X-Google-Smtp-Source: ADFU+vtqc3QxnGduF+dzle8CBc/6wd+E9G7XBHsO8LeLAHzfrD3msSrfRyiI2G9libarfwQR7hcLNw==
X-Received: by 2002:adf:a285:: with SMTP id s5mr5755262wra.118.1584534998013;
        Wed, 18 Mar 2020 05:36:38 -0700 (PDT)
Received: from [10.0.0.57] ([5.22.133.241])
        by smtp.googlemail.com with ESMTPSA id f22sm2359331wmf.2.2020.03.18.05.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 05:36:37 -0700 (PDT)
Subject: Re: Lockless behavior for CQs in userspace
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Andrew Boyer <aboyer@pensando.io>,
        Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org, maorg@mellanox.com
References: <6C1A3349-65B0-4F22-8E82-1BBC22BF8CA2@pensando.io>
 <20200317150057.GJ3351@unreal>
 <F97A8269-872F-4B94-8F03-7A8E26AE0952@pensando.io>
 <20200317195153.GX20941@ziepe.ca>
 <73154a58-8d65-702a-2bf3-1d0197079ed8@dev.mellanox.co.il>
 <20200318114332.GE13183@mellanox.com>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <49d65148-8915-9a61-383f-1919e0594a8c@dev.mellanox.co.il>
Date:   Wed, 18 Mar 2020 14:36:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318114332.GE13183@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/18/2020 1:43 PM, Jason Gunthorpe wrote:
> On Wed, Mar 18, 2020 at 09:52:27AM +0200, Yishai Hadas wrote:
> 
>> We can really consider extending the functionality of a parent domain that
>> was just added for CQ in case it holds a thread domain for this purpose.
>> However, current code enforces creating a dedicated BF as part of thread
>> domain unless we extend ibv_alloc_td() to ask only for marking the single
>> thread functionality.
> 
> Doesn't the CQ need a BF too?
> 

Not really, it uses a per-allocated device one for writing 8 bytes for 
doorbell, applicable only in the arm/events mode.

> In any event, I don't think it matters, any real application is likely
> to use the thread domain with a QP as well so the BF will not be
> wasted
> 

Agree.

>> The existing alternative is or to use the legacy ENV that mentioned above or
>> to use the ibv_cq_ex functionality which upon its creation gets an explicit
>> flag for single threaded one (i.e. IBV_CREATE_CQ_ATTR_SINGLE_THREADED).
> 
> An apps that don't want the BF can always use
> IBV_CREATE_CQ_ATTR_SINGLE_THREADED
>

This requires moving to the new polling mechanism where this option is 
really applicable (see a3a31e8dc6a3fbf577dd8b12742d0c70cf63bd29).

> I think consistency says that if a thread domain is passed into CQ it
> should trigger IBV_CREATE_CQ_ATTR_SINGLE_THREADED
> 

I would say, as of turning the general ENV of MLX5_SINGLE_THREADED but 
only for this single CQ to support the legacy polling mode, the new one 
has its own flag/flow in any case.

Yishai
