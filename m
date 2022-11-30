Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FB263E25D
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Nov 2022 21:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiK3Ux1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Nov 2022 15:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiK3Ux0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Nov 2022 15:53:26 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1BA28E2C
        for <linux-rdma@vger.kernel.org>; Wed, 30 Nov 2022 12:53:24 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id t62so20072401oib.12
        for <linux-rdma@vger.kernel.org>; Wed, 30 Nov 2022 12:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+zV2P8yn7DzHyGJXV3P3hn3uAASavMFFaKIAnVsOmqo=;
        b=DkkDjprjpsevzykSE3IHi1SZBJ/gEfvEmA6Kjf69MCpxJeJFyzbNcaTXeA//a3c277
         HVYK0hxGv4xdor+aw/ajU3bKqK4k+xVprsb2mlpzqlGRVmywWu1SKM7C3EJW3gIsU3xQ
         5w7jFrjIENZ+pGZMihGePLqw3fxuf01n++dadbBHMsWl6Smy3hPyPW15qQXFysvEJfi0
         oGio6+0O9kKxMyprldSi+w+yI3OWTLmFdkk99Ayc9ip36kNE/l/JEduoXmpGrU4p1WyN
         TZwzxUAATJ4vZy2LWgclZqoPKXByD+IWqDm6/MBtN1/EtZX+PYN7iV8VjNDVXolcrKGs
         uMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zV2P8yn7DzHyGJXV3P3hn3uAASavMFFaKIAnVsOmqo=;
        b=ouET1gPsS0JnNHToJxpVpBjRButHIjgoaMwRELTXMVekk6+WPPWl53p0d7u4n9f5kD
         NFjXYaWBuCS3cy2CxrJa4B6CMPUJ53iySotMBH2PqFvqY9h+bo4yIbsm9s/vz7Tk1nlc
         XD0iSI/9le5n8lbO+4U7/GqGqwYhjn0+vwsG/6JbjUQ+dgRgSGFtIBHqQTSYY39m6GAj
         Li5YGWPRkTTmlELntTXhCyh0YYE4DzUKmUP4hRrgi2bdunRuPr1ibsRRUw/dw6NXqqcJ
         8+2pJm5OIlhSRX5qO5YcoeBQJ4goiSX7jnx8/5VdYisxglws7B49lOF2W5MwDd/Qjd5h
         R8hA==
X-Gm-Message-State: ANoB5pl+gW09foJn9qZTAjvVge2C4cNY98CtpjuHVgQsRAW6i4ZYEA8d
        AVbksikJ84JmVukTmPaATtE=
X-Google-Smtp-Source: AA0mqf6TMd0+gRxBIgrV2dMxEu2Aipj0UaYl6cRwUY0PRpFtl8pRFfxJBCQIP2P8jcT/7pCF03bpRg==
X-Received: by 2002:a05:6808:1491:b0:35b:a4f7:822a with SMTP id e17-20020a056808149100b0035ba4f7822amr10320321oiw.69.1669841604247;
        Wed, 30 Nov 2022 12:53:24 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:edbc:46e8:aba5:dca6? (2603-8081-140c-1a00-edbc-46e8-aba5-dca6.res6.spectrum.com. [2603:8081:140c:1a00:edbc:46e8:aba5:dca6])
        by smtp.gmail.com with ESMTPSA id b19-20020a056870391300b00142fa439ee5sm1708783oap.39.2022.11.30.12.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 12:53:23 -0800 (PST)
Message-ID: <7ebc82bd-3d1c-e2d3-be4f-2e5c95073a65@gmail.com>
Date:   Wed, 30 Nov 2022 14:53:22 -0600
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
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Y3/Bqa7obMROAtr8@nvidia.com>
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

On 11/24/22 13:10, Jason Gunthorpe wrote:
> On Mon, Oct 31, 2022 at 03:27:55PM -0500, Bob Pearson wrote:
>> +int rxe_add_frag(struct sk_buff *skb, struct rxe_phys_buf *buf,
>> +		 int length, int offset)
>> +{
>> +	int nr_frags = skb_shinfo(skb)->nr_frags;
>> +	skb_frag_t *frag = &skb_shinfo(skb)->frags[nr_frags];
>> +
>> +	if (nr_frags >= MAX_SKB_FRAGS) {
>> +		pr_debug("%s: nr_frags (%d) >= MAX_SKB_FRAGS\n",
>> +			__func__, nr_frags);
>> +		return -EINVAL;
>> +	}
>> +
>> +	frag->bv_len = length;
>> +	frag->bv_offset = offset;
>> +	frag->bv_page = virt_to_page(buf->addr);
> 
> Assuming this is even OK to do, then please do the xarray conversion
> I sketched first:
> 
> https://lore.kernel.org/linux-rdma/Y3gvZr6%2FNCii9Avy@nvidia.com/

I've been looking at this. Seems incorrect for IB_MR_TYPE_DMA which
do not carry a page map but simply convert iova to kernel virtual addresses.
This breaks in the mr_copy routine and atomic ops in responder.
There is also a missing rxe_mr_iova_to_index() function. Looks simple enough
just the number of pages starting from 0.

I am curious what the benefit of the 'advanced' API for xarrays buys here. Is it just
preallocating all the memory before it gets used?

I am happy to go in this direction and if we do it should be ahead of the other
outstanding changes that touch MRs.

I will try to submit a patch to do that.

Bob

> 
> And this operation is basically a xa_for_each loop taking 'struct page
> *' off of the MR's xarray, slicing it, then stuffing into the
> skb. Don't call virt_to_page()
> 
> *However* I have no idea if it is even safe to stuff unstable pages
> into a skb. Are there other examples doing this? Eg zero copy tcp?
> 
> Jason

