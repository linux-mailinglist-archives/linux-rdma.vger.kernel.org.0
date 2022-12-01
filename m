Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101D663E92F
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 06:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiLAFFM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 00:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLAFFK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 00:05:10 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BAB303C3
        for <linux-rdma@vger.kernel.org>; Wed, 30 Nov 2022 21:05:06 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id q186so895258oia.9
        for <linux-rdma@vger.kernel.org>; Wed, 30 Nov 2022 21:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQESUE834NUWUTOSQTH1pUKVNisORj47wUkGTFjpC+Q=;
        b=heOP1GWiv7B0zo9kF70GyDRAgX2VH6oz6MTwDQ5kf08a5e2AB7NOqDNu3nZ7y163hW
         rWrBCrEmKtuybOCEKv0zj7C9LBqPdY+tu2trvcNqgINaFIjkn7kzSzi1KYEqFAqc/Afl
         ztQNCWikNS2gxypdMzXf+GoNoVOtuETToE9G+Pe0fxMzQrTcI/bvl9yOz1QqCgZvFqMs
         8KCMEAyVXIHMCBDSqNJErm9agco9YgPafK8abNX+Js993bf60cHKeZebQBqGoytJcbyJ
         jpTYcUCEhxo/2YsTXf3Alov2v5gsXiprGxLTFm7a7KFiY2vO9xNq+yBtBToIIGgHdE43
         A7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQESUE834NUWUTOSQTH1pUKVNisORj47wUkGTFjpC+Q=;
        b=cBmd0ZKFJApRDzPTahbguvbNlMRjUlsUNDlH3xN2iMpH3i8VNMB3ApjgmvaKTyIfB9
         MsVeucvPK5OOAJhWqJrqyERR5NylLGOWMOr9IMktwuQ6Q1jqnxtRqAKAlG6ABrNP+MzV
         UAe28S66Hg2tvEm7l91JcnN/IJHOKiL9uG5xIYRW4m6yyAHtA+7LPdJS9aaO/xxHw26c
         yUIs4lDibU4wilcnGkjkD4XKdxpd0hHSpZb7PlCgMrl65ZvrhtnF6EDcCiHaN2BHb3DT
         Q4ifDSN070vZatPxeVbB9YnFjEFciZfkwxNGeMtbdXbjUUU+sw37ugJcoZ8tR1S2Bgq0
         6a7A==
X-Gm-Message-State: ANoB5pkdnpEl1lYToJEe+tpDFDEIzD7UnJHb9FSJoaRwgVyEWx2W3A0E
        Uol4GIBt7vYOqxS7U4pKavQrBqLvilQyOQ==
X-Google-Smtp-Source: AA0mqf7eHIk4nmkpQhW9C+JQty7JivaiY5Aizne75qUs+rYdpbrXJpBNCs24VXSSwVnCKnXoeH/+Tw==
X-Received: by 2002:a05:6808:617:b0:35b:d151:d3ac with SMTP id y23-20020a056808061700b0035bd151d3acmr3126772oih.202.1669871106122;
        Wed, 30 Nov 2022 21:05:06 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:edbc:46e8:aba5:dca6? (2603-8081-140c-1a00-edbc-46e8-aba5-dca6.res6.spectrum.com. [2603:8081:140c:1a00:edbc:46e8:aba5:dca6])
        by smtp.gmail.com with ESMTPSA id j125-20020acab983000000b0035b451d80afsm1394704oif.58.2022.11.30.21.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 21:05:05 -0800 (PST)
Message-ID: <10cec5db-a6e0-6d02-7d1e-5aba673aa2a9@gmail.com>
Date:   Wed, 30 Nov 2022 23:05:04 -0600
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
 <eff1e3d7-03a5-97fc-e494-f9ba93c185d6@gmail.com>
 <Y4f4NkV+4ZbubQjp@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Y4f4NkV+4ZbubQjp@nvidia.com>
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

On 11/30/22 18:41, Jason Gunthorpe wrote:
> On Wed, Nov 30, 2022 at 06:36:56PM -0600, Bob Pearson wrote:
>> I'm not looking at my patch you responded to but the one you posted to replace maps
>> by xarrays.
> 
> I see, I botched that part
> 
>> The existing rxe driver assumes that if ibmr->type == IB_MR_TYPE_DMA
>> that the iova is just a kernel (virtual) address that is already
>> mapped.
> 
> No, it is not correct
> 
>> Maybe this is not correct but it has always worked this way. These
>> are heavily used by storage stacks (e.g. Lustre) which always use
>> DMA mr's. Since we don't actually do any DMAs we don't need to setup
>> the iommu for these and just do memcpy's without dealing with pages.
> 
> You still should be doing the kmap
> 
> Jason

Does this have to do with 32 bit machines? I have always tested on 64 bit machines and
dma mr's are always already mapped.

Bob
