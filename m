Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF653AC1B0
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 05:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhFRD7K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Jun 2021 23:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhFRD7J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Jun 2021 23:59:09 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65772C061574
        for <linux-rdma@vger.kernel.org>; Thu, 17 Jun 2021 20:57:00 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id c13so9010467oib.13
        for <linux-rdma@vger.kernel.org>; Thu, 17 Jun 2021 20:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hhSuLzmXiowWvC8BtzwOFqlQKjsbt/8lDystloZ8n7U=;
        b=tE0wR9vCnhHRajzAKTYVK+B6/s6Y76jb3VCmYnA5XNT4uTbRbn8NNPtAbwBdcX9JjS
         MGjyi9xcEubUvo1VGawyI387b0J6W7O0JFoi3ABULOvaoiOZ6ME3LseaeYS8fEzNZdof
         9HWqnVdFyjnj3jEva8oy63dkJO6YenrFjZHuF9JNAD/2+pXL96XTcWbt3z7pfGalzUKc
         n0HtG1v65XCuXAa2mGD3IF7IS4jCA7Gw9BAXGJvqiIcRi3XWT3PSmpuVdWm9XgOJ9+i+
         oXkFJY9f+rClMzE85VZpMVYfuuIUhPcZArCQfxq0kNPBs/Jgv8eFpFWQwr4etxsnIhiT
         FHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hhSuLzmXiowWvC8BtzwOFqlQKjsbt/8lDystloZ8n7U=;
        b=JBfufy+RhLBnEfqOwl3BaDDBjxsHp6ZKGClhZp1dpt7xRl8O9hBapMvGfenEdIJcGC
         W0nF4HVYKMY6QLg1wh77biXFvWmZE5lt7D/hkGXbiI9rklrLc77Q/0uBpnop/rG4qkHD
         Lp8I0W6mWs/IxsliBH0zKv5wHXI90+XNEQKLnv7XzofEpQeIuAcUoCEeHJNHTNo8PXJW
         7wXZSDOkvgcFfDiDAN4QyHOPXN/LnmM+DnBKHPrCvFCN/p/YuAeZB9OhI3zWAxjmyUTR
         5sgZCAO7fCuvc3Tdu2HKLiuYQu8aPRY2w1fuFkjPpgP02BFik4TU41KzfVK+8XmBcWXm
         qhrw==
X-Gm-Message-State: AOAM531yZPLQ8GhNNWjr4XQINXTxXhsk5IfprULev4b4E+TGu6LayEz/
        9pPGO/KE3vMLjTUFT8hcy6g=
X-Google-Smtp-Source: ABdhPJzQnkOboWAGjD22fQN9o6FrYh0vitk8X1w9XPchqwRmY+sj0cYF4qJNOqJySPLFjAdjxrrV+w==
X-Received: by 2002:aca:ab15:: with SMTP id u21mr13384413oie.50.1623988619835;
        Thu, 17 Jun 2021 20:56:59 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:2fce:3453:431e:5204? (2603-8081-140c-1a00-2fce-3453-431e-5204.res6.spectrum.com. [2603:8081:140c:1a00:2fce:3453:431e:5204])
        by smtp.gmail.com with ESMTPSA id s15sm1539147oih.15.2021.06.17.20.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 20:56:59 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] RDMA/rxe: Increase value of RXE_MAX_AH
To:     Shoaib Rao <rao.shoaib@oracle.com>, linux-rdma@vger.kernel.org,
        jgg@ziepe.ca, Zhu Yanjun <zyjzyj2000@gmail.com>
References: <20210617182511.1257629-1-Rao.Shoaib@oracle.com>
 <20210617182511.1257629-3-Rao.Shoaib@oracle.com>
 <3aa5a673-3fd7-744b-b664-510005215bd2@gmail.com>
 <10d9763c-4d10-3820-93a0-b79f55acfa8e@oracle.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <edcf0cc0-4da8-5af3-3366-220b4eeba5e4@gmail.com>
Date:   Thu, 17 Jun 2021 22:56:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <10d9763c-4d10-3820-93a0-b79f55acfa8e@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/17/21 5:57 PM, Shoaib Rao wrote:
> 
> On 6/17/21 1:45 PM, Bob Pearson wrote:
>> On 6/17/21 1:25 PM, Rao Shoaib wrote:
>>> From: Rao Shoaib <rao.shoaib@oracle.com>
>>>
>>> In our internal testing we have found that the
>>> current limit is too small, this patch bumps it
>>> up to a higher value required for our tests, which
>>> are indicative of our customer usage.
>>>
>>> Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
>>> ---
>>>   drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
>>> index 3b9b1ff4234f..d375f2cff484 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_param.h
>>> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
>>> @@ -66,7 +66,7 @@ enum rxe_device_param {
>>>       RXE_MAX_MCAST_GRP        = 8192,
>>>       RXE_MAX_MCAST_QP_ATTACH        = 56,
>>>       RXE_MAX_TOT_MCAST_QP_ATTACH    = 0x70000,
>>> -    RXE_MAX_AH            = 100,
>>> +    RXE_MAX_AH            = 64000,
>>>       RXE_MAX_SRQ            = 17408,
>>>       RXE_MAX_SRQ_WR            = 0x4000,
>>>       RXE_MIN_SRQ_WR            = 1,
>>>
>> Interesting. There is no real reason to pick most of these values since it's just memory and does not reflect underlying hardware resources. It is advantageous to also be able to set them smaller to verify whether test cases correctly limit resources. It seems that there should be a way (module parameter or other) to adjust these values without having to recompile the driver. Thoughts?
> 
> I agree with you 100% but it seems like the original design did not intent to make them configurable at run time. I see that recently some other values were bumped up by others so I went with hard coded values. In the inhouse kernel version we used to decide on the values had them configurable because we did not know what values we wanted, and recompiling was time consuming.
> 
> While some tests may require small values we want to test with lots of users/connections.
> 
> If there is consensus I can submit a different patch to make these values configurable. In the meantime I hope we can bump up these values.
> 
> Kindly let me know.
> 
> Shoaib
> 
>>
>> Regards,
>>
>> Bob Pearson

It isn't my call. But I am in favor of tunable parameters. -- Bob Pearson
