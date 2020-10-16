Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8027E28FC37
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 03:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388759AbgJPBXH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Oct 2020 21:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388752AbgJPBXH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Oct 2020 21:23:07 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7FFC061755
        for <linux-rdma@vger.kernel.org>; Thu, 15 Oct 2020 18:23:07 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id e20so975311otj.11
        for <linux-rdma@vger.kernel.org>; Thu, 15 Oct 2020 18:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RovObBpNisJCKcc/ON8pW/HebeWPeEw1lRWgivGX+88=;
        b=eF4EJZmdwnsO6i1icQu84XR/scp/0aIBHnrMyh/7fAWxlXgUJ+wm2EWxXKA+zytyav
         EvK7Zce+WgAseBx1WZyc9iumD91y3OAvCPEWi8130/q7Y/uaQsN9hBXcT/LFX0SotuL6
         Zb5BOZAbxFLw/Mxd3yORXeZWnmMTUQmkA8pYZEI5w1dA4cNRiT24UfLyLl8OV+qUNCxA
         VmdM8Xp7Si0J3vABNPHRtAZnJCEL26WGSGxxw0lNEoss/6qjybXvHoB+yhkNVzFzLtX+
         q8B5zwvycwDNHWvpyMwdbITd8vs27LCkJF/sCvzFBC8E86Suo221qLxkM4I7GOHa4ywk
         mS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RovObBpNisJCKcc/ON8pW/HebeWPeEw1lRWgivGX+88=;
        b=XT+Nt/tCBVubFlUyxs76Woyg9bcjdK6veyl0lQcQ8sjVQ6RB+0m/Ug+e2Zs+93i7SJ
         LnMsLfvEFjq5rVcdEip2OJNG0umlPAHL5OvGN5qTDgJ11XvVselIqpdPjKspE6nxFGeR
         VXrN1l3khbqbxYrL316G+KvX9n3bQ3Mqc7K+1QDBiNVmOEVt32zOd8Z9IM9vpHmwwt7c
         pmj3Aj9RShSwERJlg7FpYKcrcSaVONTn7mpiz6pmNe7MVCXvXho4a3zXJip6FiVSXDFp
         FHRPnwao51ln6S8UZSFYvbTjv6MRYO4amGnUzXDdXOaH3dqiEv7QUw6FkNCLOHWUX76C
         e2TQ==
X-Gm-Message-State: AOAM532QE48b4CaoR/4bOQZFewsPrkmLfxX+qmRfGuEX3y3YXed7SCVS
        DpGEi39aLiLTbMIUvbBgY6g=
X-Google-Smtp-Source: ABdhPJxAvYCQDqmEq5jXXK5aM8ak7krdh9IXe+X4s5scYfBMhYDhzjGhPWSMvtOREhcZvX5BitOiSw==
X-Received: by 2002:a9d:ac9:: with SMTP id 67mr897282otq.321.1602811386327;
        Thu, 15 Oct 2020 18:23:06 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:4fdb:8393:d75b:2d46? (2603-8081-140c-1a00-4fdb-8393-d75b-2d46.res6.spectrum.com. [2603:8081:140c:1a00:4fdb:8393:d75b:2d46])
        by smtp.gmail.com with ESMTPSA id m1sm422211otq.30.2020.10.15.18.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 18:23:05 -0700 (PDT)
Subject: Re: [PATCH] Provider/rxe: Fix regression to UD traffic
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
References: <20201015201750.8336-1-rpearson@hpe.com>
 <20201015234720.GA6219@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <fc242ad5-2175-6b34-2d5c-3daae3f4b68b@gmail.com>
Date:   Thu, 15 Oct 2020 20:23:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201015234720.GA6219@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/15/20 6:47 PM, Jason Gunthorpe wrote:
> On Thu, Oct 15, 2020 at 03:17:51PM -0500, Bob Pearson wrote:
>> Update enum rdma_network_type copy to match kernel version.
>> Without this change provider/rxe will send incorrect
>> network types to the kernel in send WQEs.
>>
>> This fix keeps rxe functional but should be replaced by a better
>> implementation.
>>
>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>> ---
>>  providers/rxe/rxe.h | 1 +
>>  1 file changed, 1 insertion(+)
> 
> Well, we can't just break user space so the kernel has to change in
> some way to accommodate this.
> 
> Obviously rxe should not have uAPI stuff that is not in
> include/uapi/rdma, so lets just fix that directly.
> 
> Please confirm I did this right. The PR for this merge window must be
> sent Friday.

That works too. I am figuring out how to convert ah_handle to ib_ah in rdma_rxe. I think I've mostly got it.
uobj_get_obj_read(type, id, attr) is close to what I need. The problem is that all the code in this area assumes
it is getting called in a user verb API call so there is an attr to pass around. What we need is an API like
rdma_get_obj(ucontext, type, id) since we need a way to get to the user api data structures. Better would be
a pointer from qp to ucontext or ufile that would be set for user QPs. If we did this rxe just use handles from
the core instead of creating its own databases of objects.

Your patch will get us going for now. The above is a longer project that won't fit in your short term schedule.

Bob
