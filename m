Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365C5290D20
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 23:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410942AbgJPVOn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 17:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410923AbgJPVOn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Oct 2020 17:14:43 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DC5C061755
        for <linux-rdma@vger.kernel.org>; Fri, 16 Oct 2020 14:14:43 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id w141so4042620oia.2
        for <linux-rdma@vger.kernel.org>; Fri, 16 Oct 2020 14:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=msxu8Dmdlzcyq9vpGiw71cqnuqWpD1deqj4pdt7s0KI=;
        b=RB74eEMjxEQGE4ngkqBs6Db5OCY617KLz21TwQimb/BV5Rwiu8ptm1mvsEiIN7IlHK
         4jYohkacLGO2zIhA2vth0TeqpfBZsmQAwgftcXPluZRuY0oG1EIsjCFrmoGMp+7w8Cyx
         qL7h37Xye6B3CeIjwhpPmLCG5T3U1ftGANjDwWoULBozlgFqT35Uw43g4g2uMWaR+E9l
         5a/Sv2Q6WHmcbsnToQ46099/Z2+VbaIjr/N8Pihc20+O7nfoB3irrEKRwZURCe9wYdpz
         990QKiC7BH0YNlVZCUOsf7PqdcdJW4LaHVaNw/KjCIzlmDp5vdBidOsCsSs+UTyKNZGD
         uHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=msxu8Dmdlzcyq9vpGiw71cqnuqWpD1deqj4pdt7s0KI=;
        b=DZOhB2FnzT7e+dgaAYtUKGOJdenOnrjNFRDO6SVjwdqRgZE+QvakOA8hMyh1lvyGVV
         1Vsg7G4JJ+8Mx8vAeg71IMpduoVwH6E/tkNwRLQHfvoToGt7g2XIWEw1YaQPRDxQOtKU
         iVz9CL/wVFV7H2cKifMAu6mdfFO13JMkbHET8CZNmHMbN1uMB8SCr1eaCmnRnkKQ4Agc
         keuS/yZs+Hx+I/B+d5ybMU5yOz/Rt/L8YpqDDJWI/nIR3OdYaoS9CzDRKDztIng+UtdR
         P4IsbbZkpjnSWvnghaTB8rv/4cYKrdvKpQSvAngZjmSa9ii0ZUQrg9aPTSy36Tfnplj2
         Xlsw==
X-Gm-Message-State: AOAM531YtowaCbhsAqXyghc8ZxL56sQUUaLUK15BpUIPNQvy/S5TRZ6h
        n0+UnMGsPDMgEfZJlwj3Dp4=
X-Google-Smtp-Source: ABdhPJz68wrUrq9eox4TXbgsGUGLCwHPRh9Pv3MK/XD7jrEd9SwYKO3vywzcrSG0TKTgJvZNh9wMZg==
X-Received: by 2002:aca:ebcf:: with SMTP id j198mr3931062oih.9.1602882882509;
        Fri, 16 Oct 2020 14:14:42 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:3929:4284:f7ac:4bbd? (2603-8081-140c-1a00-3929-4284-f7ac-4bbd.res6.spectrum.com. [2603:8081:140c:1a00:3929:4284:f7ac:4bbd])
        by smtp.gmail.com with ESMTPSA id x14sm1421678ooo.43.2020.10.16.14.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 14:14:42 -0700 (PDT)
Subject: Re: [PATCH for next] RDMA/rxe: Fix small problem in network_type
 patch
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
References: <20201016202645.17819-1-rpearson@hpe.com>
 <20201016203317.GS6219@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <50ce01d2-82ca-6404-d8f0-d9ba17aeb888@gmail.com>
Date:   Fri, 16 Oct 2020 16:14:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016203317.GS6219@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/16/20 3:33 PM, Jason Gunthorpe wrote:
> On Fri, Oct 16, 2020 at 03:26:46PM -0500, Bob Pearson wrote:
>> The patch referenced below has a typo that results in using the wrong
>> L2 header size for outbound traffic. (V4 <-> V6).
>>
>> It also breaks RC traffic because they use AVs that use RDMA_NETWORK_XXX
>> enums instead of RXE_NETWORK_TYPE_XXX enums. Fis this by making the
>> encodings the same between these different types.
>>
>> Fixes: e0d696d201dd ("RDMA/rxe: Move the definitions for rxe_av.network_type to
>> 		       uAPI")
> 
> Don't word wrap these
> 
>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>>  drivers/infiniband/sw/rxe/rxe_net.c | 2 +-
>>  include/uapi/rdma/rdma_user_rxe.h   | 5 +++--
>>  2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
>> index 575e1a4ec821..34bef7d8e6b4 100644
>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>> @@ -442,7 +442,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>>  	if (IS_ERR(attr))
>>  		return NULL;
>>  
>> -	if (av->network_type == RXE_NETWORK_TYPE_IPV6)
>> +	if (av->network_type == RXE_NETWORK_TYPE_IPV4)
>>  		hdr_len = ETH_HLEN + sizeof(struct udphdr) +
>>  			sizeof(struct iphdr);
>>  	else
>> diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
>> index e591d8c1f3cf..ce430d3dceaf 100644
>> +++ b/include/uapi/rdma/rdma_user_rxe.h
>> @@ -40,8 +40,9 @@
>>  #include <linux/in6.h>
>>  
>>  enum {
>> -	RXE_NETWORK_TYPE_IPV4 = 1,
>> -	RXE_NETWORK_TYPE_IPV6 = 2,
>> +	/* good reasons to make same as RDMA_NETWORK_XXX */
>> +	RXE_NETWORK_TYPE_IPV4 = 2,
>> +	RXE_NETWORK_TYPE_IPV6 = 3,
>>  };
> 
> No just transcode them in the only place that matters, we still can't
> break userspace
> 
> Jason
> 

done. You should have it.
