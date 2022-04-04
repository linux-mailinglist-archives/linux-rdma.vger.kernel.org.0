Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABB04F1B85
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Apr 2022 23:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379683AbiDDVUk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 17:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380326AbiDDTdp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 15:33:45 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E623F20F41
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 12:31:48 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-d6ca46da48so11898737fac.12
        for <linux-rdma@vger.kernel.org>; Mon, 04 Apr 2022 12:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YlOe/ylcM4Uv9wPppiqGueQ0tJJ6UnWozD/bBxEhkDU=;
        b=oT2VK/12yW0yt5/1tJdzA9VQ3LT4LEADQHoRyOblmYfVmSZtOpy9TdNSwomEcyqSgi
         ummXfOUgGnm1Pyw9JhG2awZ493ObloF2ZPXnhAdTBIXceVXgtrEMPCINd5jV1uIWDT9b
         cby3CZyZMO80Rgc8zEegoHwfRCJiUq85T3XKkwuUwLxkx373jRIbkHLl2xJv3spQ/J0l
         d6WqMJ19qId8NJqzSRVIOW5tYTn3nCECAgYFUag32DSRirCP+WWiF5d0PSFwB8nB5EbN
         +IYLTNUndhvvxi2KW+BLC5zhIli91BQIEfoPGiQsgZQ3dYaOylt1farg0ueK8X9Yz4aa
         BD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YlOe/ylcM4Uv9wPppiqGueQ0tJJ6UnWozD/bBxEhkDU=;
        b=iY14GFMvpFiRY+VukC+7WXBHMvJJ/+SawEX6JLvrdKKRIBFTttVOtCpOn27EkZeOpK
         jZ9sALVYQMaR2UpxoAKgLD9Ex610uTQMwJdmQW0JMRXBN8Xy7JNbrnbaq/Y+Rpj5tL3O
         q/fPL8jga5H2SjMQN3FhYChHV1NECwp3hmrNKEmZc7cG7E/wfl3XmsZXGs3eUx0z2Bf9
         pR3Ryeo66aXqYiCzJEQ3RueZ1ZqpbGiymuKGfkVtyATve1mKkK2LkRJOU0T5OI8r3YND
         Idr5WopBtUdXuQyxyvWHwyR+KMj5X2vYYbyiG5thsxZa9skF6yA4vX8C+YovsuEd6ga6
         cbaQ==
X-Gm-Message-State: AOAM533cb+s+q+cIn/vh/89SzKmlFrlgLZ2R4Xk0YaPRf85VuIFOEG2f
        uirBLOsh0+Q8aUPkSPpOSLhCT3UW3dQ=
X-Google-Smtp-Source: ABdhPJz1iv4y4zrYMRLjQfBcnjY0ABAWGpolDvaxz/6DtNzYm7Qmn9kh3DcmMwzYzLobn5Ayjpxq8A==
X-Received: by 2002:a05:6870:d10b:b0:e2:1f:f3bf with SMTP id e11-20020a056870d10b00b000e2001ff3bfmr402297oac.157.1649100708300;
        Mon, 04 Apr 2022 12:31:48 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:5ce5:a41:7a36:d73b? (2603-8081-140c-1a00-5ce5-0a41-7a36-d73b.res6.spectrum.com. [2603:8081:140c:1a00:5ce5:a41:7a36:d73b])
        by smtp.gmail.com with ESMTPSA id e9-20020a056820060900b003216277bfdasm4356293oow.19.2022.04.04.12.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 12:31:48 -0700 (PDT)
Message-ID: <dcbe5883-2c04-617e-cc3a-5680ca6d823c@gmail.com>
Date:   Mon, 4 Apr 2022 14:31:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: warnings from pyverbs tests
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <09525cae-22de-d28d-de4a-120598d0f80b@gmail.com>
 <20220404184444.GR2120790@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220404184444.GR2120790@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/4/22 13:44, Jason Gunthorpe wrote:
> On Mon, Apr 04, 2022 at 01:19:21PM -0500, Bob Pearson wrote:
>> Back from vacation I see the following warnings when I run the pyverbs test suite.
>>
>> <frozen importlib._bootstrap>:228: RuntimeWarning: pyverbs.device.Context size changed, may indicate binary incompatibility. Expected 160 from C header, got 176 from PyObject
>>
>> <frozen importlib._bootstrap>:228: RuntimeWarning: pyverbs.qp.QPEx size changed, may indicate binary incompatibility. Expected 136 from C header, got 144 from PyObject
>>
>> <frozen importlib._bootstrap>:228: RuntimeWarning: pyverbs.qp.QPInitAttrEx size changed, may indicate binary incompatibility. Expected 208 from C header, got 216 from PyObject
>>
>> <frozen importlib._bootstrap>:228: RuntimeWarning: pyverbs.pd.PD size changed, may indicate binary incompatibility. Expected 128 from C header, got 136 from PyObject
>>
>> <frozen importlib._bootstrap>:228: RuntimeWarning: pyverbs.pd.ParentDomain size changed, may indicate binary incompatibility. Expected 144 from C header, got 152 from PyObject
>>
>> <frozen importlib._bootstrap>:228: RuntimeWarning: pyverbs.providers.mlx5.mlx5dv.Mlx5Context size changed, may indicate binary incompatibility. Expected 192 from C header, got 200 from PyObject
>>
>>
>> It seems the headers in rdma-core and the kernel are out of sync. I just pulled fresh bits from both.
> 
> 
> I don't think it has to do with kernel, that looks like a python
> compilation problem. Rebuild a fresh rdma-core and make sure it is not
> mixing and matching shared librarie somehow
> 
> Jason

I removed rdma-core/build and rebuilt everything. That fixed it.

Thanks.
