Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D05160B1A2
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 18:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiJXQaR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 12:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbiJXQ3z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 12:29:55 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77542196EE1
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 08:16:14 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id j188so11150398oih.4
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HvNKDRU9v+ulGGm0NdZfyIwgLbpAZgjd8aLBNadoLJs=;
        b=bEgxKyupvH2AqTwNSmggMwpz+CWrURiPErnWrbiLFZGy3+pbZYZ7mpSpqf1Nm/1tVj
         DXUMTfcmPRaWy3zDFcBlfxjiZIyUfRD9Nf/FqY4agGhoU9FAc9vLU/LaOSFhWHe7sy3e
         W3lINzGNkEeMf6rQPT+6ywPHcoxjOShGYwidWEa1DtOXqvJIVLZWODInKgl0iyFA142q
         /+H6pb0Sl49TKmFzSyGbbwsK6vPvWHY1LcrSdYE3gonzXqwDGeoF/926qRY3h36lAjXh
         wZtAyVdsVpUSE4uTLniJwjoUE1SXlCYw5mv5/m2DvafqY5tD5lqeNbDThiG9hZlveAs8
         7ReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HvNKDRU9v+ulGGm0NdZfyIwgLbpAZgjd8aLBNadoLJs=;
        b=wBj+DzQ8vJKt0y98O0VVdi+7h3Bm59Drv3ZPNzh0x2ZFrkqNSRuheJUqFMzi0aZbzS
         WETkjEIx/RRG2nae00sLQ2aj1ci014F2eX93nyt1+pxxLDiyQl4EVMELxTnGM3/Dgc3t
         Mrt7YT53SFMPfkzrEqbe3gNgCwsw9w/3RORXPLh/vvVteEsg2H5MPYgeGf28zksVb0hH
         XYlIEsOW0oCt7sa8mA3nvWnSnlp1sHyN/eyAR7WY3bySHExynDxZub5bV9KIpTKQK8Gr
         RZTy69xV4Dz23JCkammV4OYMjp7kARv2sLru01ivcuQ5gE8DqIdm1lR8J4M1YjKzcJiJ
         fS9w==
X-Gm-Message-State: ACrzQf1Nz6oWt4b9P/1QafSAnur/GWoFvmZLYUa7xa7cEwkD2JT9oTPf
        LmZbSZu4zw0MXD/GTrpyFiU4Vg3MdUI=
X-Google-Smtp-Source: AMsMyM5JNO1Nh3e/R9demQq0zEE/3yBUYHG3EN+2VWmiG02AeWaQd8EEl+bD4kx3dq1Ya7ozHB76aw==
X-Received: by 2002:aca:30c4:0:b0:355:24e0:8583 with SMTP id w187-20020aca30c4000000b0035524e08583mr16111536oiw.42.1666620433072;
        Mon, 24 Oct 2022 07:07:13 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:1e0:e60:c33:b344? (2603-8081-140c-1a00-01e0-0e60-0c33-b344.res6.spectrum.com. [2603:8081:140c:1a00:1e0:e60:c33:b344])
        by smtp.gmail.com with ESMTPSA id cc3-20020a05683061c300b00665919f7823sm739600otb.8.2022.10.24.07.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 07:07:12 -0700 (PDT)
Message-ID: <be29ec7e-9f9e-40a1-358f-4a44c5defc0c@gmail.com>
Date:   Mon, 24 Oct 2022 09:07:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] RDMA/rxe: Remove the member 'type' of struct rxe_mr
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
References: <20221021134513.17730-1-yangx.jy@fujitsu.com>
 <Y1Z8R7xB1omokwZ/@unreal>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Y1Z8R7xB1omokwZ/@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/24/22 06:51, Leon Romanovsky wrote:
> On Fri, Oct 21, 2022 at 01:45:17PM +0000, yangx.jy@fujitsu.com wrote:
>> The member 'type' is included in both struct rxe_mr and struct ib_mr
>> so remove the duplicate one of struct rxe_mr.
>>
>> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_mr.c    | 16 ++++++++--------
>>  drivers/infiniband/sw/rxe/rxe_verbs.h |  1 -
>>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> <...>
> 
>>  	default:
>>  		pr_warn("%s: mr type (%d) not supported\n",
>> -			__func__, mr->type);
>> +			__func__, mr->ibmr.type);
>>  		return -EFAULT;
> 
> <...>
> 
>> -	if (unlikely(mr->type != IB_MR_TYPE_MEM_REG)) {
>> -		pr_warn("%s: mr->type (%d) is wrong type\n", __func__, mr->type);
>> +	if (unlikely(mr->ibmr.type != IB_MR_TYPE_MEM_REG)) {
>> +		pr_warn("%s: mr type (%d) is wrong\n", __func__, mr->ibmr.type);
> 
> Someone needs to convert pr_*() calls to ibdev_*() prints.
> 
> Thanks

I have a patch laying around that does this. Hoping some of the backlog of rxe patches gets
accepted so I don't have to backport everything.

Bob
