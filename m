Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731F148DF36
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jan 2022 21:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiAMUwA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jan 2022 15:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiAMUwA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jan 2022 15:52:00 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DD6C061574
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jan 2022 12:52:00 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id t9so9446872oie.12
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jan 2022 12:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=d46Pk6oia9ktx6Y6oQj1oZw2Nbcr0E9zX6n3Zub9VCM=;
        b=dq17y8q1t4qnfeBC3n6eHenBzP2PekvAmOQpw4le+EAae/iMFjOOeuZaJQf0FaxJSW
         mISwy/WaxWFlToCuTpT1avH0T99qLGgBAxn0M/RaRhbAdbIxTUW/Oi8XttvRMyNpidBO
         tmK1nV4wGyhvW+62j+/PtawlXFU/4rJj2E6WXgfMJaW4IQ94dsW/0Iw1bhN3lIyK6aDt
         Ek0eDF+1w1m5Wg68KH6W/TgrEG+s0FcN9NME9GEJDPEx2n7svBEcALhkq9uBhpQl0N81
         3l06oyxeCzHHLSj2oTjYYiQVrpjZzbAmFC7dE69VKwpt4AmJQhwtjYqo8hyKvrt6hhBz
         Sv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d46Pk6oia9ktx6Y6oQj1oZw2Nbcr0E9zX6n3Zub9VCM=;
        b=x+dPBNzWcrO2KCe7xwtILxP5V9SJeneXbQ1my78jzQHd303dB1An1QhcAjQdSu3RWu
         DL7oSBWI+rmJQVW9rUWSrSI8DBUzDDol7b5iw9xdPTTxl35l5UsuO6RpECI1unfGRxw9
         rSuiwagtDo8VidSsDY0vLOwYXSgx4K3q9d9hhLqg4fNMJ+gnHwpuR/ucdmWc6GCk+kyf
         3T7Aumri4Y8pDPEFz85dPXlEQC1BJe35yAo1CCFsw3P5hYOHUvs9qQrB0JqeVJoR29xY
         hXCr8Rsu7+ruof49zW/nG/rx1h1cLiELrHCnP5VL2q2B52KU/2B5gmMqqp83InGO0MHj
         Rb9g==
X-Gm-Message-State: AOAM532X1SQ2M7EGkgBOFnFpEtOItPvXxZgIMyjCE29FbREMYwpKF2RY
        NoUMRF4JoO9iYeoxSpwXIGImVzv6qu8=
X-Google-Smtp-Source: ABdhPJyx9O/hxVxsZ0OSdLHNICI4RJsjMWbrmFoiA3GL8aLLmadRNUq4REJimaQmqxmKgpNmZRyEPg==
X-Received: by 2002:a05:6808:23c7:: with SMTP id bq7mr4833202oib.124.1642107119668;
        Thu, 13 Jan 2022 12:51:59 -0800 (PST)
Received: from [192.168.0.27] (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id bg41sm964305oob.42.2022.01.13.12.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 12:51:59 -0800 (PST)
Message-ID: <326487d9-74cc-185e-1790-90730425057a@gmail.com>
Date:   Thu, 13 Jan 2022 14:51:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [rdma-core PATCH] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Content-Language: en-US
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220111014145.2374669-1-yangx.jy@fujitsu.com>
 <61DCEA00.1030002@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <61DCEA00.1030002@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/10/22 20:22, yangx.jy@fujitsu.com wrote:
> On 2022/1/11 9:41, Xiao Yang wrote:
>> The expression "cons == ((qp->cur_index + 1) % q->index_mask)" mistakenly
>> assumes the queue is full when qp->cur_index is equal to "maximum - 1"
>> (maximum is correct).
> Hi All,
> 
> The commit message seems inappropriate so I will resend this patch.
> 
> Best Regards,
> Xiao Yang
>> For example:
>> If cons and qp->cur_index are 0 and q->index_mask is 1, check_qp_queue_full()
>> reports ENOSPC.
>>
>> Fixes: 1a894ca10105 ("Providers/rxe: Implement ibv_create_qp_ex verb")
>> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
>> ---
>>  providers/rxe/rxe_queue.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/providers/rxe/rxe_queue.h b/providers/rxe/rxe_queue.h
>> index 6de8140c..708e76ac 100644
>> --- a/providers/rxe/rxe_queue.h
>> +++ b/providers/rxe/rxe_queue.h
>> @@ -205,7 +205,7 @@ static inline int check_qp_queue_full(struct rxe_qp *qp)
>>  	if (qp->err)
>>  		goto err;
>>  
>> -	if (cons == ((qp->cur_index + 1) % q->index_mask))
>> +	if (cons == ((qp->cur_index + 1) & q->index_mask))
>>  		qp->err = ENOSPC;
>>  err:
>>  	return qp->err;

The way these queues work they can only hold 2^n - 1 entries. The reason for this is
to distinguish empty and full. If you let the last entry be written then producer would advance to equal consumer which is the initial empty condition. So a queue which can hold 1 entry has to have two slots (n=1) but can only hold one entry. It begins with

prod = cons = 0 and is empty and is *not* full

Adding one entry gives

slot[0] = value, prod = 1, cons = 0 and is full and not empty

After reading this value

slot[0] = old value, prod = cons = 1 and queue is empty again.

Writing a new value

slot[1] = new value, slot[0] = old value, prod = 0 and cons = 1 and queue is full again.

The expression full = (cons == ((qp->cur_index + 1) % q->index_mask)) is correct.

Please do not make this change.

Bob
