Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D7F753B96
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jul 2023 15:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjGNNOC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jul 2023 09:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbjGNNOB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Jul 2023 09:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F75E134
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jul 2023 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689340400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=36HhvwwCwNRISkyKnM/sv2zqdgTqt3zr0Ydeg6lZGjI=;
        b=IJfBXw/v8K9Jz6psuZkLikq/RAOxGtb3Tkv05E8CRRBAaJhM5lAUzqp6Df012BkYiNveNA
        iUeBR7ryXefLa/Vz3y0+WECW8ykUisnrIE4dNQA567zI1e4wyMEK6+DHL/GPTILVmrsKWD
        vQ9rwwBFaP8zHvkdzOi8Il86OQ6Oocc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-2JXH8AF8Np6qNEYXK2Z79Q-1; Fri, 14 Jul 2023 09:13:19 -0400
X-MC-Unique: 2JXH8AF8Np6qNEYXK2Z79Q-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4f624a4ea72so1678786e87.2
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jul 2023 06:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689340397; x=1691932397;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=36HhvwwCwNRISkyKnM/sv2zqdgTqt3zr0Ydeg6lZGjI=;
        b=DhG+QDzsUXDBP4idg/7Z/MfRm80PZi5qCT2UIJTbsUVRKuL0cj8zFvQSoqRoSMoQ9x
         c9QquHUZg7NOJ3M5I90enes0vxop90h/Ox5mupVqhiX2xp4mjeLvhuCimkH/S9MgDRxp
         6h2WkZziGJafI60Y1SDHwzwi3LPpVUNeqpP2ze5mo3eBzDipSdVeg82GS1PRBjN6KxVB
         6cSimVEoGN+mNSQA0fCeO0rdoA2rnEX+K7kE47oAZXEyAJfB54q9L2CBBdtN0zYeHVgE
         ZWc5TjJXSNeh7FhgVzARSSmbGQW9NeFXq1nfsalKdQm+MYo19eE1nlb6g7od+noKBE2k
         Uebg==
X-Gm-Message-State: ABy/qLYbcsMxhLenZmPauacrNz+kAqIzcfcPnRTHHyMeFn74Lc1TaqdD
        lhGDsooogk2zstEL0aNy0FbH56M8U1lzhtfJdHV7Nm4f3oTFhVgNrsy3JKnznd0euuL0e0Z6xjk
        Jkls1G95aEmx4NzwhgpY2dw==
X-Received: by 2002:a05:6512:114e:b0:4f8:5e8b:5ec8 with SMTP id m14-20020a056512114e00b004f85e8b5ec8mr4799843lfg.9.1689340397776;
        Fri, 14 Jul 2023 06:13:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGUZKsDBZIffHa15ofyhKzNHwZj9wwVByfwtni8shzuZklgsuym2B+BpTxYpImmZmtelIMblA==
X-Received: by 2002:a05:6512:114e:b0:4f8:5e8b:5ec8 with SMTP id m14-20020a056512114e00b004f85e8b5ec8mr4799812lfg.9.1689340397336;
        Fri, 14 Jul 2023 06:13:17 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id y17-20020aa7c251000000b0050bc4600d38sm5686281edo.79.2023.07.14.06.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 06:13:16 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <3b043a95-a4bc-bbaf-c8e0-240e8ddea62f@redhat.com>
Date:   Fri, 14 Jul 2023 15:13:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     brouer@redhat.com,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Paul Rosswurm <paulros@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Long Li <longli@microsoft.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next] net: mana: Add page pool for RX buffers
Content-Language: en-US
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
References: <1689259687-5231-1-git-send-email-haiyangz@microsoft.com>
 <20230713205326.5f960907@kernel.org>
 <85bfa818-6856-e3ea-ef4d-16646c57d1cc@redhat.com>
 <PH7PR21MB31166EF9DB2F453999D2E92ECA34A@PH7PR21MB3116.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB31166EF9DB2F453999D2E92ECA34A@PH7PR21MB3116.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 14/07/2023 14.51, Haiyang Zhang wrote:
> 
> 
>> -----Original Message-----
>> From: Jesper Dangaard Brouer <jbrouer@redhat.com>
>> On 14/07/2023 05.53, Jakub Kicinski wrote:
>>> On Thu, 13 Jul 2023 14:48:45 +0000 Haiyang Zhang wrote:
>>>> Add page pool for RX buffers for faster buffer cycle and reduce CPU
>>>> usage.
>>>>
>>>> Get an extra ref count of a page after allocation, so after upper
>>>> layers put the page, it's still referenced by the pool. We can reuse
>>>> it as RX buffer without alloc a new page.
>>>
>>> Please use the real page_pool API from include/net/page_pool.h
>>> We've moved past every driver reinventing the wheel, sorry.
>>
>> +1
>>
>> Quoting[1]: Documentation/networking/page_pool.rst
>>
>>    Basic use involves replacing alloc_pages() calls with the
>> page_pool_alloc_pages() call.
>>    Drivers should use page_pool_dev_alloc_pages() replacing
>> dev_alloc_pages().
>   
> Thank Jakub and Jesper for the reviews.
> I'm aware of the page_pool.rst doc, and actually tried it before this
> patch, but I got lower perf. If I understand correctly, we should call
> page_pool_release_page() before passing the SKB to napi_gro_receive().
> 
> I found the page_pool_dev_alloc_pages() goes through the slow path,
> because the page_pool_release_page() let the page leave the pool.
> 
> Do we have to call page_pool_release_page() before passing the SKB
> to napi_gro_receive()? Any better way to recycle the pages from the
> upper layer of non-XDP case?
> 

Today SKB "upper layers" can recycle page_pool backed packet data/page.

Just use skb_mark_for_recycle(skb), then you don't need 
page_pool_release_page().

I guess, we should update the documentation, mentioning this.

--Jesper


