Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E2941E283
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 22:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344351AbhI3UHV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 16:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhI3UHU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 16:07:20 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DBAC06176A
        for <linux-rdma@vger.kernel.org>; Thu, 30 Sep 2021 13:05:35 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id v10so8762327oic.12
        for <linux-rdma@vger.kernel.org>; Thu, 30 Sep 2021 13:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gdCnpcJereW2pu9GC0EVDaFFhjMQU5hpvhBHHP8aryA=;
        b=OGncPGKDbogo9Kv+SkCPBJi+OcCHyBaau8W59uK7/wbAYIkcI963Tic2MUl5i9IN/n
         OmwxRY/gS5b74qcjSJfB6UCH3pLVkidFev9yYNFmD6C/qxeNh+W1Y6lceNrFYciCnHBe
         7EaaIaI290dKO+neFqIroy1WHJhI2L9KUr2G78RR8E2YviGn10cI1sQ1zF95blNkL9ZQ
         g0n9WrJwgisI34PNiH6U5qzNuQY8Xeiow+rM0BcFMrHj+M105SqNa/CoIx5NJc/HWdCC
         fm5JrjF6MY7Nq9vQtwHbQiJQgLFAGnZ7VGWd3PsVV0qLVsJNk+har8+2fyPhi/ZgoEkJ
         S2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gdCnpcJereW2pu9GC0EVDaFFhjMQU5hpvhBHHP8aryA=;
        b=xIsccQ0mmQbUbHq7WqMYlkXE3Qrsvx66IfntTi0gdAjWFpXJhBxaCCu2Jnw0ha71iH
         XZCNlyblvsXU5D/zqIX6ok7S6xFjMJ6WbX+nHQWuYoLfUzWi/M7JzDPT2HjYguDDIyBp
         kQjeQxKmLVviXOmjDqWJ0VokpRnXoVq3R2JWJmmywUg31EevPXlFRZC4wJh+PniFL3sU
         qXYUeEva3quT/h2xMXz5xanH5g+BgCoRtHacoEk6Ea8n46Bsqw52Uh21SkQp4hdI6JMc
         INPPVy/9iZEqD2PrfSRTyJ7Ov6vNZGCvX0JYbyA0EPgghp6QSuHNVbxwwNebH1Zlv0mk
         xPqw==
X-Gm-Message-State: AOAM530sheTM1FDe8f7LMjstmKjEr0oz9PMGiHUwuZiH3cCI1VZBZODb
        9DKuPUcd7xQGN/P6/xnD8qM=
X-Google-Smtp-Source: ABdhPJwj5+qMhTjLJHTsowFc+Nm893vsjQ2hyjoyRWZJ1rpZ+3aqiYiA+u+6Ethpfs1vbXJCfP8M5Q==
X-Received: by 2002:a05:6808:1a11:: with SMTP id bk17mr981099oib.0.1633032334781;
        Thu, 30 Sep 2021 13:05:34 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:5d73:3dc5:19d1:b31c? (2603-8081-140c-1a00-5d73-3dc5-19d1-b31c.res6.spectrum.com. [2603:8081:140c:1a00:5d73:3dc5:19d1:b31c])
        by smtp.gmail.com with ESMTPSA id s7sm706303oiw.27.2021.09.30.13.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 13:05:34 -0700 (PDT)
Subject: Re: [PATCH] Provider/rxe: Remove printf()
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com, jgg@nvidia.com
References: <20210929214214.18767-1-rpearsonhpe@gmail.com>
 <YVVIwUBwvr9AGHtC@unreal>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <0518fdd4-aa93-d797-16ec-cbbb8e73c3cf@gmail.com>
Date:   Thu, 30 Sep 2021 15:05:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVVIwUBwvr9AGHtC@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/30/21 12:18 AM, Leon Romanovsky wrote:
> On Wed, Sep 29, 2021 at 04:42:15PM -0500, Bob Pearson wrote:
>> Currently the rxe provider issues a print statement if it detects
>> an invalid work request and also returns an error. A recently
>> added python test case triggers such a message which is expected
>> since the test is deliberately constructing invalid work requests.
>>
>> This patch removes the print statement which has no practical use.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  providers/rxe/rxe.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Please remove this "fprintf(stderr, "rxe: Failed to query sgid.\n");"
> line too.
> 
> Thanks
> 
NP
>>
>> diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
>> index 3533a325..42fc447c 100644
>> --- a/providers/rxe/rxe.c
>> +++ b/providers/rxe/rxe.c
>> @@ -1513,10 +1513,8 @@ static int post_one_send(struct rxe_qp *qp, struct rxe_wq *sq,
>>  		length += ibwr->sg_list[i].length;
>>  
>>  	err = validate_send_wr(qp, ibwr, length);
>> -	if (err) {
>> -		printf("validate send failed\n");
>> +	if (err)
>>  		return err;
>> -	}
>>  
>>  	wqe = (struct rxe_send_wqe *)producer_addr(sq->queue);
>>  
>> -- 
>> 2.30.2
>>

