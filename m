Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5520063E65E
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 01:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiLAAT2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Nov 2022 19:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiLAATI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Nov 2022 19:19:08 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7635C8B19E
        for <linux-rdma@vger.kernel.org>; Wed, 30 Nov 2022 16:16:55 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id w26-20020a056830061a00b0066c320f5b49so12315474oti.5
        for <linux-rdma@vger.kernel.org>; Wed, 30 Nov 2022 16:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NiR/yJeIwbaJtmevC4zUA/IxJWdWJo8Sj/My0B5Nh00=;
        b=Hzrhm/KWxVFnBppIvoSl9s1d4TR8MlqjZUPxc2W3Bbw1xvXq7pc21e3FqUYO/VLQ4B
         sTk6oMzz+P1vOA1V5LOae9GVpNcKPg7WRHg//l8PLRjJjTrlGz52jev5ieCBgq9uBNF3
         KKkTFSGid131Sk1rY71LdGwdY/vi13NnpYNrMF0j771RS9FUWlzk+CFqXi7qf9kE5rtR
         ACmG615MOMD4Em2JM8ZtRt3YveOq8zEvNdBg3aL6UVBXbF/2M78FlWakDZnq9GWZzQ8T
         hkXV2l/ZrxJSlio7N8MpVOnm/ij3NgqrRsE5sALTMHaWMqVzyi5OR9f8pKvk4dxJNOi6
         N3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NiR/yJeIwbaJtmevC4zUA/IxJWdWJo8Sj/My0B5Nh00=;
        b=ikzCvE2JqN0JMSaifxJfLq17jxl/rDcx4wGEinWKffShuFoxttWsDz7wGNBGX5E4oS
         J+eKA0cc6/T3nK8bj35k+oZRfHN2P3QKaKt+uAT2w3hrQPqiLwfH9JiFHWe8rjZOTmeN
         mgJ4MrIthp1OJzfLlrIe/TQMwmyLN8aicaCfHxOHfODw14FG5igBR4aKZlJX4WyVooho
         LpJTXJabTLha1R4wuySOFgxE4rjWjptMSnwJtIpt3xbYEjf0hpQgvycRq1p2WoOQflPc
         tUNhIk32wONfSjh0zuiv+cAeTyLPsTsviLyIb4yFs0i6h47soBPrAlfOZACgViuU0Wnw
         np5g==
X-Gm-Message-State: ANoB5pmcKGzcJ1SKmBiy0cUPXjs34UOYtnZJyzEtDBLq/tz2NakntY+a
        hGxjPkCd8cCn7t4nGG+vqWY=
X-Google-Smtp-Source: AA0mqf6GGne21ScE+SyLkplWSh5B3ksnwYCt14c0Ezx98TAVch1n9R+biqtF1xCLgxyiQD2wqZ90Iw==
X-Received: by 2002:a9d:748e:0:b0:66e:39ed:9a26 with SMTP id t14-20020a9d748e000000b0066e39ed9a26mr13105239otk.130.1669853814811;
        Wed, 30 Nov 2022 16:16:54 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:edbc:46e8:aba5:dca6? (2603-8081-140c-1a00-edbc-46e8-aba5-dca6.res6.spectrum.com. [2603:8081:140c:1a00:edbc:46e8:aba5:dca6])
        by smtp.gmail.com with ESMTPSA id k14-20020a0568080e8e00b0034d8abf42f1sm1242974oil.23.2022.11.30.16.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 16:16:54 -0800 (PST)
Message-ID: <fd788906-6e40-8109-f6a1-5f281361c68c@gmail.com>
Date:   Wed, 30 Nov 2022 18:16:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH for-next v2 06/18] RDMA/rxe: Add rxe_add_frag() to
 rxe_mr.c
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20221031202805.19138-1-rpearsonhpe@gmail.com>
 <20221031202805.19138-6-rpearsonhpe@gmail.com> <Y3/Bqa7obMROAtr8@nvidia.com>
 <7ebc82bd-3d1c-e2d3-be4f-2e5c95073a65@gmail.com>
 <Y4fo6tknpuCveRgq@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Y4fo6tknpuCveRgq@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/30/22 17:36, Jason Gunthorpe wrote:
> On Wed, Nov 30, 2022 at 02:53:22PM -0600, Bob Pearson wrote:
>> On 11/24/22 13:10, Jason Gunthorpe wrote:
>>> On Mon, Oct 31, 2022 at 03:27:55PM -0500, Bob Pearson wrote:
>>>> +int rxe_add_frag(struct sk_buff *skb, struct rxe_phys_buf *buf,
>>>> +		 int length, int offset)
>>>> +{
>>>> +	int nr_frags = skb_shinfo(skb)->nr_frags;
>>>> +	skb_frag_t *frag = &skb_shinfo(skb)->frags[nr_frags];
>>>> +
>>>> +	if (nr_frags >= MAX_SKB_FRAGS) {
>>>> +		pr_debug("%s: nr_frags (%d) >= MAX_SKB_FRAGS\n",
>>>> +			__func__, nr_frags);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	frag->bv_len = length;
>>>> +	frag->bv_offset = offset;
>>>> +	frag->bv_page = virt_to_page(buf->addr);
>>>
>>> Assuming this is even OK to do, then please do the xarray conversion
>>> I sketched first:
>>>
>>> https://lore.kernel.org/linux-rdma/Y3gvZr6%2FNCii9Avy@nvidia.com/
>>
>> I've been looking at this. Seems incorrect for IB_MR_TYPE_DMA which
>> do not carry a page map but simply convert iova to kernel virtual
>> addresses.
> 
> There is always a struct page involved, even in the kernel case. You
> can do virt_to_page on kernel addresses
Agreed but there isn't a page map set up for DMA mr's. You just get the whole kernel
address space. So the call to rxe_mr_copy_xarray() won't work. There isn't an
xarray to copy to/from. Much easier to just leave the DMA mr code in place since
it does what we want very simply. Also you have to treat the DMA mr separately for
atomic ops.

Bob
> 
>> I am curious what the benefit of the 'advanced' API for xarrays buys here. Is it just
>> preallocating all the memory before it gets used?
> 
> It runs quite a bit faster
> 
> Jason

