Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309855E8268
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Sep 2022 21:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiIWTPO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Sep 2022 15:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIWTPN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Sep 2022 15:15:13 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADEC1257B4
        for <linux-rdma@vger.kernel.org>; Fri, 23 Sep 2022 12:15:12 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id g130so937335oia.13
        for <linux-rdma@vger.kernel.org>; Fri, 23 Sep 2022 12:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=dLZmq/KTvW77FSHjPbMXW5/BYObT87DTGOpegoyOzaQ=;
        b=VWhbuHXxBjsNqNBQb6//shh8njBmRtYy08eWp2dy877wipbrAhH4sZe9u6gNWVUUCm
         1FvDOrwlE3Dzc8/19Jhg71mD8n2TEklTySBpnm49NuTXxMGlaisvfYXiJVN3k1hnAVfD
         lHy/fpcMiA3fZcj1AIE3Q/Naw4OZAp0BJmNUnouwgT4fe7Gig0brSmSY1DKybFDTrb5H
         KDFJHVoKD7Vdnm+7m0NWH2Ngg659FDQmG2VF3J5Q/V6dDt8YAJRGyaupKyTzTGiJg97H
         WycUx3bITkqcioqnCOBEoF68tHCzoIyuokBBPN0y9O6gU0J9C5VD1AOe1i/bdId1zQT9
         J3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dLZmq/KTvW77FSHjPbMXW5/BYObT87DTGOpegoyOzaQ=;
        b=LxB1zhi0OMfdI0Tvk5iTv6ATxUU2aziM+d5fzq+AmrgVsLSuHQFvZ1TeJda4dVbZTF
         Yc52SAX6gJj6psLzQI1QtG4oO2KaZTlJf/VzNAHpVG2W3MRs9btRA+pyR5potgWwSZc2
         h7kX/jUSS5x5OzPqXuEd+HIicMgVOX6IiO1Ee21O7uXR+2i3Z9LMrUjleJjbzkUUrA14
         p8Ni55gx2gzBWjXMlvwtm3dOSbvcmW7vIlo0zOZ86vc1rOQkmrIKhioMpouZ//0l3zdG
         4/LlUaV7nnE/5l5EC1xPmueQICmpPDCt5F3ZmcY9kOTdufis6amjlIEFeQax8DY2+wjr
         EjeA==
X-Gm-Message-State: ACrzQf2m4qXZqqUzumvI8pFm7+WMAvmyqWkn5SfqERM+EUaczjRELI3R
        KVvmWgDasoMvzjra9eb0b3Iop3YZoz/dUw==
X-Google-Smtp-Source: AMsMyM7YA1HcQ0n0rT2FCTsLioRQ8LnGiqm64KeKhSA0THjj6lqr1vSlMoyTUnYifzsM4ckNcO/9ag==
X-Received: by 2002:aca:2206:0:b0:34f:d9b1:475e with SMTP id b6-20020aca2206000000b0034fd9b1475emr4836525oic.18.1663960511395;
        Fri, 23 Sep 2022 12:15:11 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:9ff2:9514:431a:7d34? (2603-8081-140c-1a00-9ff2-9514-431a-7d34.res6.spectrum.com. [2603:8081:140c:1a00:9ff2:9514:431a:7d34])
        by smtp.gmail.com with ESMTPSA id p3-20020a056830318300b00654625c0c4dsm4384206ots.17.2022.09.23.12.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 12:15:10 -0700 (PDT)
Message-ID: <b5ed392f-db49-3a97-57ec-43c07b2ca592@gmail.com>
Date:   Fri, 23 Sep 2022 14:15:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH for-next] RDMA/rxe: Guard mr state against race conditions
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, lizhijian@fujitsu.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
References: <20220802212731.2313-1-rpearsonhpe@gmail.com>
 <Yy39hbAqAaKsIsH6@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Yy39hbAqAaKsIsH6@nvidia.com>
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

On 9/23/22 13:40, Jason Gunthorpe wrote:
> On Tue, Aug 02, 2022 at 04:27:32PM -0500, Bob Pearson wrote:
>> Currently the rxe driver does not guard changes to the mr state
>> against race conditions which can arise from races between
>> local operations and remote invalidate operations. This patch
>> adds a spinlock to the mr object and makes these state changes
>> atomic. It also introduces parameters to count the number of
>> active dma transfers and indicate that an invalidate operation
>> is pending.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>> v2
>>   Addressed issues raised by Jason Gunthorpe regarding preventing
>>   access to memory after a local or remote invalidate operation
>>   is carried out. The patch was updated to busy wait the invalidate
>>   operation until recent memcpy operations complete while blocking
>>   additional dma operations from starting.
>> ---
>>  drivers/infiniband/sw/rxe/rxe_loc.h   |   6 +-
>>  drivers/infiniband/sw/rxe/rxe_mr.c    | 149 +++++++++++++------
>>  drivers/infiniband/sw/rxe/rxe_req.c   |   8 +-
>>  drivers/infiniband/sw/rxe/rxe_resp.c  | 200 ++++++++++++--------------
>>  drivers/infiniband/sw/rxe/rxe_verbs.h |  10 +-
>>  5 files changed, 204 insertions(+), 169 deletions(-)
> 
> Applied to rdma-core
> 
> Thanks,
> Jason

Thanks

Bob
