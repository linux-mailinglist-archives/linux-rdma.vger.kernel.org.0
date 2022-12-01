Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713E663F5FD
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 18:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiLARLO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 12:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiLARLN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 12:11:13 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9536A9CCE
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 09:11:12 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-142306beb9aso2831571fac.11
        for <linux-rdma@vger.kernel.org>; Thu, 01 Dec 2022 09:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ccPVRThM90DNGCYZzvGappvJYD8IohxbWtS1OBRpkF8=;
        b=A1gRMDYFltDXftkMuoraXh7XNb2ZzCPLhuzWSdxxfDDeMv5xUWJdpH4TP2G4UEx2iA
         nlaGUC4xXtb2Gq/cAlv4n5GyhW0rHmVqdiPiqh1ChCYHRXDSURVI/yC1zNt3yXYulZ14
         tK1balm+BBNfp9Lc3Zg8uYDTwXEwaL3kvZftuJIOklGXWxzsgy4JuIWla4Y3X9FPxqmo
         d8sOzpSVZN9p8XTtdNmXZP/d1v4fJ12UkDx2tFv4wnHj5Gs4rDIzmI4q42cYdonmYp96
         9XOM9IQcYwgGPG8G8INvr8n4QcnYC0nNW3xoZ1yjm3LLNbWLJPQBIQU8QjbmH4S+T6Io
         2tIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccPVRThM90DNGCYZzvGappvJYD8IohxbWtS1OBRpkF8=;
        b=feYD1O76p+Mr2UnNjjBgRKidqyJf6sXS/Eg/XVxCi1BegNbhe/vzh2SllFWSWQUrJj
         HEeQsnyKql6UdInTMKi0emzyA5S/2KUJPwDFmHYMP4UUP/fX1i++zyTjTsRcDBvgHdZS
         kqZ6ms3Ri3NxHIN4Drpr33fE8RIR3h3gbr2VEBdU11M1tBHn5LNXy2s49zwByl4fPVbd
         EyCat5rBSteP1BQOhmmPHKGmCwwXJZw5F0jFhlu7xL0JWF9JweL0XZuVQo0KP1vyWxFR
         H2CeSoGyiYkOgxW8rAvv5bEQO41klHSzLF7JbNbnV7OdSlmnXTUqzXdXE5ropWnNlRf4
         BFkQ==
X-Gm-Message-State: ANoB5png1yAYsJZoNDFWwI12ULahhKbdrCyx3JeFeG8HitSpeLFIeVvY
        SL8hVcjXR9iV/z4T0e4/7Ec=
X-Google-Smtp-Source: AA0mqf6WzWQAsZ5DQINpbmJjeALBlk0a+7IbTWEMzYWZax9CoStRPxzqtxoFzvZBEtQ5oOfFFgB36w==
X-Received: by 2002:a05:6870:e256:b0:132:c488:8385 with SMTP id d22-20020a056870e25600b00132c4888385mr27384312oac.299.1669914672120;
        Thu, 01 Dec 2022 09:11:12 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:edbc:46e8:aba5:dca6? (2603-8081-140c-1a00-edbc-46e8-aba5-dca6.res6.spectrum.com. [2603:8081:140c:1a00:edbc:46e8:aba5:dca6])
        by smtp.gmail.com with ESMTPSA id r15-20020a4a964f000000b00499527def25sm1939232ooi.47.2022.12.01.09.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 09:11:11 -0800 (PST)
Message-ID: <24f77b1b-b2e0-17f7-06b3-7ac17a247efc@gmail.com>
Date:   Thu, 1 Dec 2022 11:11:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH for-next v2 06/18] RDMA/rxe: Add rxe_add_frag() to
 rxe_mr.c
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <Y3/Bqa7obMROAtr8@nvidia.com>
 <7ebc82bd-3d1c-e2d3-be4f-2e5c95073a65@gmail.com>
 <Y4fo6tknpuCveRgq@nvidia.com>
 <fd788906-6e40-8109-f6a1-5f281361c68c@gmail.com>
 <Y4fzZk7D9GgLNhy9@nvidia.com>
 <eff1e3d7-03a5-97fc-e494-f9ba93c185d6@gmail.com>
 <Y4f4NkV+4ZbubQjp@nvidia.com>
 <d80f31c4-2e51-c726-2954-a7039befe329@gmail.com>
 <82449ff1-2602-a6d0-e33d-af783545bcb0@gmail.com>
 <443943ee-6f79-b6df-4533-723953173a5e@gmail.com>
 <Y4jKyHYosuveRQrj@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Y4jKyHYosuveRQrj@nvidia.com>
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

On 12/1/22 09:39, Jason Gunthorpe wrote:
> On Thu, Dec 01, 2022 at 09:38:10AM -0600, Bob Pearson wrote:
> 
>> Further, looking at ipoib as an example, it builds sge lists using the lkey from get_dma_mr()
>> and sets the sge->addr to a kernel virtual memory address after previously calling
>> ib_dma_map_single() so the addresses are mapped for dma access and visible before use.
>> They are unmapped after the read/write operation completes. What is the point of kmapping
>> the address after dma mapping them?
> 
> Because not everything is ipoib, and things like block will map sgls
> with struct pages, not kva.
> 
> Jason

OK it's working now but there is a bug in your rxe_mr_fill_pages_from_sgt() routine.
You have a

	if (xas_xa_index && WARN_ON(sg_iter.sg_pgoffset % PAGE_SIZE)) {...}

which seems to assume that sg_pgoffset contains the byte offset in the current page.
But looking at __sg_page_iter_next() it appears that it is the number of pages offset
in the current sg entry which results in a splat when I run ib_send_bw.

Bob
