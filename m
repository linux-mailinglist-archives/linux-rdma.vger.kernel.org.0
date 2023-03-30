Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732276CF93D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 04:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjC3Cpu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 22:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjC3Cps (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 22:45:48 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8133F4EEF
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 19:45:47 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id a30-20020a9d3e1e000000b006a13f728172so6137658otd.3
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 19:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680144347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eJPSTwJDg3ixzTRgn+GKzddInSIaeFdntRk3bu3JW3E=;
        b=EYEM15j0AkeFCzeIxfe4evDBkf5G6SvaoMgbCpBkTE3zKLlwJvndtiFAg9Mt9jEWSK
         bFALYiHqGL9sALrsED4yI9atO7QDdxUySgPZTdzjnRCBsJpGSby5JLoTn2znWyrSsrRU
         Ni5ZqXszbx/PdjAsh6Gw/H1MuZvj9WYkF9JhvcX2tGJSROZuJqEf5EMLy4tlQBxR3XlL
         hGTjLwCZEurjyWt7zLCioqMuLpkklNhjcMcTlIadWR6XbgBj7rvTtSUXVmDOsps/QNUY
         MzgOSz64+KFjSF4kIsuqREVQMt9NYnHo0YP/j+icaZOiQQZiIOw8Z2mLL7HoWsCeR6sH
         sklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680144347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJPSTwJDg3ixzTRgn+GKzddInSIaeFdntRk3bu3JW3E=;
        b=Eg2lwb73Xag5FgPrnIXu6rChZ80Him2+FEAMjMb/cnqIfUqNL8P4Hmy4ELtkWACq8S
         AwXXqjr1P8YSfrjFbZBw7FutRbhKtOk7ARYZL3TfRAlcXdrn8ouFCe/RpJo3sLx3O93i
         7kWin15CIMmZgJCkkIOK292qwSS98okn9HzQl/5apSotIfjWg+Znm78r5hf8YzVOKwBN
         0g85Ho621JHbTxdiHKaffc0pJQ3aT51F1b/rGBXMqwEPO8y6HtLM371HaktXBhPcyHVf
         GYlKVD+lIaTr6A5h6jC6YxoINjHmcXSe3dW9iHtkIHAFhqiUerTfJ0Rbv8LKrnwMv9ro
         Xvlg==
X-Gm-Message-State: AO0yUKV/wlxOcb94HplGNLtZJiIOYGuiwjp/Z+C8LU7BorlUTVZoqw2z
        IJJY2txcM9khtLj85Gfjq4ZxnJu1EYo=
X-Google-Smtp-Source: AK7set+JCh4CWQCcRdTTjRSR2mbqQleO5IPvu0g0qN+SLDkej5i6Cna9W3K/C2TIhhVix9Kolj5U5Q==
X-Received: by 2002:a05:6830:1bc5:b0:694:39d1:a225 with SMTP id v5-20020a0568301bc500b0069439d1a225mr10814050ota.17.1680144346818;
        Wed, 29 Mar 2023 19:45:46 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:5b9e:1cc2:c3f7:6f9c? (2603-8081-140c-1a00-5b9e-1cc2-c3f7-6f9c.res6.spectrum.com. [2603:8081:140c:1a00:5b9e:1cc2:c3f7:6f9c])
        by smtp.gmail.com with ESMTPSA id bf9-20020a0568700a0900b0017264f96879sm3083248oac.17.2023.03.29.19.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 19:45:46 -0700 (PDT)
Message-ID: <66639a8e-e8b8-64b4-5b04-dec357db86a8@gmail.com>
Date:   Wed, 29 Mar 2023 21:45:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] RDMA/rxe: Pass a pointer to virt_to_page()
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        linux-rdma@vger.kernel.org
References: <20230324103252.712107-1-linus.walleij@linaro.org>
 <ZB2s3GeaN/FBpR5K@nvidia.com>
 <CACRpkdYTynQS3XwW8j_vamb7wcRwu0Ji1ZZ-HDDs0wQQy4SRzA@mail.gmail.com>
 <ZCTGw3+9rYQAmlJS@nvidia.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ZCTGw3+9rYQAmlJS@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/29/23 18:16, Jason Gunthorpe wrote:
> On Wed, Mar 29, 2023 at 04:28:08PM +0200, Linus Walleij wrote:
> 
>> I'm a bit puzzled: could the above code (which exist in
>> three instances in the driver) even work as it is? Or is it not used?
>> Or is there some failover from DMA to something else that is constantly
>> happening?
> 
> The physical address dma type IB_MR_TYPE_DMA is rarely used and maybe
> nobody ever tested it, at least in a configuration where kva != pa
> 
> Then again, maybe I got it wrong and it is still a kva in this case
> because it is still ultimately DMA mapped when using IB_MR_TYPE_DMA?
> 
> Bob?
> 
> Jason

In the amd64 environment I use to dev and test there is no difference AFAIK.
I have to go on faith that other platforms work but have very little experience.

Bob
