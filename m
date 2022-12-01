Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8080363E693
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 01:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiLAAhB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Nov 2022 19:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiLAAg7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Nov 2022 19:36:59 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA6D54344
        for <linux-rdma@vger.kernel.org>; Wed, 30 Nov 2022 16:36:58 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id p24-20020a0568301d5800b0066e6dc09be5so1735380oth.8
        for <linux-rdma@vger.kernel.org>; Wed, 30 Nov 2022 16:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tMGxN5qsyLyDjgPX0fJSKxjrkxmPtm66xlN72RxVArM=;
        b=VysSYE4bLSX94y9bpDq1Q4J8TFn0PWj9bcsPIfooXD34K2YfK+KzGAyRL0OrJ9Pk/m
         wjKuanjAGh+cn1PJhhPBWRITmzjfNXfm+0KX+A2TGp4ZvmyQtmBT9qInL3ZBa6bBuGTD
         KCc5i8wri2lOk/NG9yB3MBv9UPB/q5EmprjvLOmxI/BZ5+QlCXnwVWQHeyx5My/nU4bz
         79RH90X96qB8TmrdDoCv0b1adohMK2INwsGA+8GEcjMkXHxsKoJFT49TrWMIIUCA0rZ2
         UbbC8amQYY/HpTkJ/aXiOv2dEAEHL6YB/UxX/rGvdFYD+N6nBn8zcqzmIgk4nuJAjrbl
         c7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tMGxN5qsyLyDjgPX0fJSKxjrkxmPtm66xlN72RxVArM=;
        b=DomH6RRHGBQ4Cw/PiR0tkLGJ0hZuWieGXMB09VghxQckcjUKF40HSk5kmHjMm2243w
         oBZO1MudenKwnmLcuPt+zOdESWveLKVT0QyjHuAwtcPNYCks25nR96QVmEDPIM6WPKxF
         /jq9GeuXjmlnrUj5+yjQu3eg/cU0DKSErE0gvBXs7tXLSZ6h1gXvXBzN9Oxm+IDlkqzX
         ZO2xIVQ3yWOfk/1cX0IcNh9OGhmcusAwhnrYTUaG1Lre9IRGOMpS1/3NS5fuSt4QC9pw
         +4I1S3VHO/xx004LbIKpjxC+iMD4BskY8oHTQ0hMF+jLYKZ+yPNyhQ+hWGbSlsa+dYxj
         xz5w==
X-Gm-Message-State: ANoB5plFNDwf5nvrWBBKT9+9wvlRukkmo9hTaHnsALwJTwsl3TKDtAhG
        b9PCzj6XrpbwXTcFh+XxDt26LSFh1y95zw==
X-Google-Smtp-Source: AA0mqf7REhLSRImhgcy1wmz+pE5gh2PxSF5r7F2iWzTJOo1C/tai71fQ7EinKnAiUtlE0966ea73Tw==
X-Received: by 2002:a05:6830:d13:b0:66e:17fa:5a77 with SMTP id bu19-20020a0568300d1300b0066e17fa5a77mr19159052otb.124.1669855017542;
        Wed, 30 Nov 2022 16:36:57 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:edbc:46e8:aba5:dca6? (2603-8081-140c-1a00-edbc-46e8-aba5-dca6.res6.spectrum.com. [2603:8081:140c:1a00:edbc:46e8:aba5:dca6])
        by smtp.gmail.com with ESMTPSA id s11-20020a056870ea8b00b00143d4709a38sm1936973oap.55.2022.11.30.16.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 16:36:57 -0800 (PST)
Message-ID: <eff1e3d7-03a5-97fc-e494-f9ba93c185d6@gmail.com>
Date:   Wed, 30 Nov 2022 18:36:56 -0600
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
 <fd788906-6e40-8109-f6a1-5f281361c68c@gmail.com>
 <Y4fzZk7D9GgLNhy9@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Y4fzZk7D9GgLNhy9@nvidia.com>
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

On 11/30/22 18:20, Jason Gunthorpe wrote:
> On Wed, Nov 30, 2022 at 06:16:53PM -0600, Bob Pearson wrote:
>> On 11/30/22 17:36, Jason Gunthorpe wrote:
>>> On Wed, Nov 30, 2022 at 02:53:22PM -0600, Bob Pearson wrote:
>>>> On 11/24/22 13:10, Jason Gunthorpe wrote:
>>>>> On Mon, Oct 31, 2022 at 03:27:55PM -0500, Bob Pearson wrote:
>>>>>> +int rxe_add_frag(struct sk_buff *skb, struct rxe_phys_buf *buf,
>>>>>> +		 int length, int offset)
>>>>>> +{
>>>>>> +	int nr_frags = skb_shinfo(skb)->nr_frags;
>>>>>> +	skb_frag_t *frag = &skb_shinfo(skb)->frags[nr_frags];
>>>>>> +
>>>>>> +	if (nr_frags >= MAX_SKB_FRAGS) {
>>>>>> +		pr_debug("%s: nr_frags (%d) >= MAX_SKB_FRAGS\n",
>>>>>> +			__func__, nr_frags);
>>>>>> +		return -EINVAL;
>>>>>> +	}
>>>>>> +
>>>>>> +	frag->bv_len = length;
>>>>>> +	frag->bv_offset = offset;
>>>>>> +	frag->bv_page = virt_to_page(buf->addr);
>>>>>
>>>>> Assuming this is even OK to do, then please do the xarray conversion
>>>>> I sketched first:
>>>>>
>>>>> https://lore.kernel.org/linux-rdma/Y3gvZr6%2FNCii9Avy@nvidia.com/
>>>>
>>>> I've been looking at this. Seems incorrect for IB_MR_TYPE_DMA which
>>>> do not carry a page map but simply convert iova to kernel virtual
>>>> addresses.
>>>
>>> There is always a struct page involved, even in the kernel case. You
>>> can do virt_to_page on kernel addresses
> 
>> Agreed but there isn't a page map set up for DMA mr's. You just get the whole kernel
>> address space. So the call to rxe_mr_copy_xarray() won't work. There isn't an
>> xarray to copy to/from. Much easier to just leave the DMA mr code in place since
>> it does what we want very simply. Also you have to treat the DMA mr separately for
>> atomic ops.
> 
> You mean the all physical memory MR type? It is true, but you still
> have to add the kmap and so on. It should be a similar function that
> assumes the IOVA is a physical address is a kernel mapped address and
> does virt_to_page/etc instead of the xarray loop.
> 
> Jason

I'm not looking at my patch you responded to but the one you posted to replace maps
by xarrays. The existing rxe driver assumes that if ibmr->type == IB_MR_TYPE_DMA that
the iova is just a kernel (virtual) address that is already mapped. Maybe this is
not correct but it has always worked this way. These are heavily used by storage stacks
(e.g. Lustre) which always use DMA mr's. Since we don't actually do any DMAs we don't
need to setup the iommu for these and just do memcpy's without dealing with pages.

Bob
