Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA232FF7F3
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 23:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbhAUWbJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 17:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbhAUWbI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 17:31:08 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD091C06174A
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 14:30:27 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id e70so3240419ote.11
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 14:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KxcAgD5+AXo/pDmDTmgP/cf31qHgZs0eb4obGAFlHCs=;
        b=FQLZVUjwS0XqMWyM4ZbI3oUgCyM3tLqaXZHLXe1gglogL+pUeZ5zpBsbDA9tWJ9eh9
         SemjuJtJS8mu//YFAtgy8G2fpAvPLMXVFqFQaqLtQ2frW7b6GR6uihtgI5K69u0YFFyn
         s9pnRW18sOF8ZHN/spfY9L8GrcVtjYHHw0Doba9HMy2agsgPJTTTmS1C1XIGWkTeiWuj
         /WYKg5HUUeoH/LrhWRbJjZlgKTbmAc/TzCy/frFiuEe+++yfAlF+is62Pqtq9JdjXi96
         aUKotTjTbFTIIF6rOCC732sbnDrTs7nP63nNQxjV+5opaBCb2kdscc6qdZr4wxhNYPQw
         nX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KxcAgD5+AXo/pDmDTmgP/cf31qHgZs0eb4obGAFlHCs=;
        b=Je3t+lDmUOEiAhwGGablhL5/EVQZeVa+t47KIeoKmarRcidpY2BVc/HTY/LjjD+dE7
         8Nlu89FvLUOhtneF8sUZxL3a2/E8o6T9MYegLv4NTEgKWm+qXxczfMt9/G/SsUQ4tUkf
         AXihjcsL6xjBT2kJb3Y6I970PxTIS+6oXR0vgZ3zVnPKDSWF1f/jf+KY1aSkA6MCViG7
         vw9bwcSUqCsBGvfeBCIR4C4HY3XnaL+xzq8i6U7U0J2/UyjHZYNtuanV2RVH5BHMW8WF
         j2NiIK0XM8bEHTZhmRhsGjYvg4uO7y8koW/Tx+DxeXdjLf2kXSWSDHKNqumLyQ4U43SR
         YDfQ==
X-Gm-Message-State: AOAM530icatOAoSzy/muaj8/yC5GI3nWasv1Eqmg22rwc7fkZ2pYmS9p
        MO6o37qMwKO2Ru/ZqFw+/Fo=
X-Google-Smtp-Source: ABdhPJw9IrrsJmcM+yFMTAnkEAyJq7yYIX5yzBjchpIeDSGcwFUnXq2YD3Jobhw084MLBdHDctDk7A==
X-Received: by 2002:a9d:6015:: with SMTP id h21mr1034724otj.365.1611268227240;
        Thu, 21 Jan 2021 14:30:27 -0800 (PST)
Received: from ?IPv6:2603:8081:140c:1a00:355d:9507:a6cb:314b? (2603-8081-140c-1a00-355d-9507-a6cb-314b.res6.spectrum.com. [2603:8081:140c:1a00:355d:9507:a6cb:314b])
        by smtp.gmail.com with ESMTPSA id n16sm1313016oop.9.2021.01.21.14.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 14:30:26 -0800 (PST)
Subject: Re: [PATCH for-next] RDMA/rxe: Fix bug in rxe_alloc
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>,
        syzbot+ec2fd72374785d0e558e@syzkaller.appspotmail.com
References: <20210119214947.3833-1-rpearson@hpe.com>
 <20210121002032.GA1146326@nvidia.com>
 <c92cac5e-9b57-5d68-d4fc-0ddca8cd6814@gmail.com>
Message-ID: <292488c2-8dc4-a535-49b0-cc159d134b50@gmail.com>
Date:   Thu, 21 Jan 2021 16:30:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <c92cac5e-9b57-5d68-d4fc-0ddca8cd6814@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/21/21 4:06 PM, Bob Pearson wrote:
> On 1/20/21 6:20 PM, Jason Gunthorpe wrote:
>> On Tue, Jan 19, 2021 at 03:49:47PM -0600, Bob Pearson wrote:
>>
>>>  	read_lock_irqsave(&pool->pool_lock, flags);
>>> -	obj = rxe_alloc_nl(pool);
>>> +	if (pool->state != RXE_POOL_STATE_VALID) {
>>> +		read_unlock_irqrestore(&pool->pool_lock, flags);
>>> +		return NULL;
>>> +	}
>>> +
>>> +	kref_get(&pool->ref_cnt);
>>>  	read_unlock_irqrestore(&pool->pool_lock, flags);
>>
>> What is this lock actually protecting?? Every data read under it is not
>> written under the lock?? Even the memory storing the lock could be kfreed.
>>
>> This should all be fixed by relying on the ib_device kref. Today rxe
>> only frees the pools from ops->dealloc_driver which can only happen
>> once the ib_device_try_get() is all put back
>>
>> So the structure you want is to never call rxe_alloc from anything
>> that is not holding the ib_device_try(), or implicitly under a client.
>>
>> Basically this is already everything in ops - so things work
>> queues/etc internal to rxe need attention.
>>
>> I'm not completely sure why rxe_alloc does a ib_device_try_get()
>> either. Every verbs object is also  guarneteed to be cleaned up before
>> dealloc_driver is called.
>>
>> Most likely thing is all of this can just be deleted.
>>
>> Jason
>>
> 
> The pool lock will only get freed if the rxe device struct gets freed and that is
> after the end of this world.
> 
> I had no idea what ib_device_try_get() was about so I didn't touch it.
> I don't believe that rxe_alloc() ever gets called except from verbs/ops. None of
> the worker threads ever create new objects. So I will delete those ..._get ..._put.
> 
> If you are right then pool->state is not needed either and then the locking is not
> needed for alloc for races with shutdown. Will still want the lock for things like
> the mcast bug where we only want to create one instance of an object or two threads
> looking up an object from a RB tree.
> 
> bob
> 
[fixed typo in address]
On looking some more rxe_alloc() takes a reference on the pool for each new object and also takes a reference on the ib_device. These don't really add much value since the pool references are enough to catch counting bugs.


