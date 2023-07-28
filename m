Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED87F766181
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jul 2023 03:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjG1Byu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 21:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjG1Byt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 21:54:49 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADC8173F
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 18:54:48 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b9ec15e014so1426796a34.0
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 18:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690509288; x=1691114088;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gww8VXBUg38r6OY6QWFoN7l9AV551GICLnZJOuBHzhc=;
        b=mAIHnf4rvYo3R4BK4KMTDYTF/5tWT2JnVBIkgcy9ce/GlIwdJKmY6Uy+fzYIPz7wRQ
         U7PsaMLc2tbJnlKe5w+FQaKIzUfDj5dl8tBQHFqi0Xz5WiB3BPuwGhJtNsua1ZUFAWJY
         hNDXzQ2VTa7uwtvGAiYc6ZzcXnvFDqob10QCamgwi6NK4VCLK/WRPLqR9c3zVicaUXp/
         J8XO60Vemt81gayhEUQJ40AAC501F62I0oNMbv8xadawPkyCTQ8EsMEVmHJJXApZZ+wd
         lLi5GOtbqQOAs2Y3dbetaa25BLFJ/eeA7BX4U1k6kIzp1Ixiw0+kyAq96hkhBHYMAhLm
         Fnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690509288; x=1691114088;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gww8VXBUg38r6OY6QWFoN7l9AV551GICLnZJOuBHzhc=;
        b=kDH68Vq9TI7H7exB77W7HQSSn8H3bI9YxzT42mHdsc352G5EVOX4PrDv+wSvpfxuKl
         W/6OSpYeCd+fq6pt+q+97+sz3yeh1p3kLB9lSwFhHzq2RzX8JEY8mCGWn+8XLsQUTWAL
         D/0CfDyA4VgaTnP/Dg6gk2dsqpvd3TbDgitvraiFxAUevs2YdZ0szJWlXwmwR2sPFukK
         74Njrb15E4mJRGxL26353paPwOLrvOFqk6euXG0y8vBH5fiIodcQnGFIhWhP8GXtDt8e
         Tj+bSNANXq99PriHzEasgZwPgkuAQumbYjA9iCZED/YrKpoEA1DF0GgdZPADFEaOUSih
         zooA==
X-Gm-Message-State: ABy/qLZKPqLkozNA4sJJmL4onbcIofV945gevSJUnQ4tHfpTyzGLZuLQ
        bCCg/jy/s2W6fg5OgAPURL4=
X-Google-Smtp-Source: APBJJlHQ1v0ybqx2SukwZF316OW5JpW9c+sakhxd9kFRoXwlUKQSLFVo0Gz3RoltwqAqgRFqG+PRcQ==
X-Received: by 2002:a05:6870:b50b:b0:1bb:8abf:4a80 with SMTP id v11-20020a056870b50b00b001bb8abf4a80mr1560610oap.9.1690509287969;
        Thu, 27 Jul 2023 18:54:47 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:af49:6f67:7a95:d734? (2603-8081-140c-1a00-af49-6f67-7a95-d734.res6.spectrum.com. [2603:8081:140c:1a00:af49:6f67:7a95:d734])
        by smtp.gmail.com with ESMTPSA id 4-20020a4a1a04000000b00565d41ba4d0sm1207828oof.35.2023.07.27.18.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 18:54:47 -0700 (PDT)
Message-ID: <58cd3b75-2ebb-9217-197a-5f710a301028@gmail.com>
Date:   Thu, 27 Jul 2023 20:54:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-next v3 00/10] RDMA/rxe: Implement support for
 nonlinear packets
Content-Language: en-US
To:     Zhu Yanjun <yanjun.zhu@linux.dev>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org, jhack@hpe.com
References: <20230727200128.65947-1-rpearsonhpe@gmail.com>
 <d2b1f434-4b49-d7af-6260-2194ef67731d@linux.dev>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <d2b1f434-4b49-d7af-6260-2194ef67731d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/27/23 19:40, Zhu Yanjun wrote:
> 在 2023/7/28 4:01, Bob Pearson 写道:
>> This patch set is a revised version of an older set which implements
>> support for nonlinear or fragmented packets. This avoids extra copies
>> in both the send and receive paths and gives significant performance
>> improvement for large messages such as are used in storage applications.
>>
>> This patch set has been heavily tested at large system scale and
>> demonstrated a 2X improvement in file system read performance on
>> a 200 Gb/sec network.
>>
>> The patch set is rebased to the current for-next branch with the
>> following previous patch sets applied:
>>     RDMA/rxe: Fix incomplete state save in rxe_requester
>>     RDMA/rxe: Misc fixes and cleanups
>>     Enable rcu locking of verbs objects
>>     RDMA/rxe: Misc cleanups
>>
>> Bob Pearson (10):
>>    RDMA/rxe: Add sg fragment ops
>>    RDMA/rxe: Extend rxe_mr_copy to support skb frags
>>    RDMA/rxe: Extend copy_data to support skb frags
>>    RDMA/rxe: Extend rxe_init_packet() to support frags
>>    RDMA/rxe: Extend rxe_icrc.c to support frags
>>    RDMA/rxe: Extend rxe_init_req_packet() for frags
>>    RDMA/rxe: Extend response packets for frags
>>    RDMA/rxe: Extend send/write_data_in() for frags
>>    RDMA/rxe: Extend do_read() in rxe_comp.c for frags
>>    RDMA/rxe: Enable sg code in rxe
>>
>>   drivers/infiniband/sw/rxe/rxe.c        |   5 +
>>   drivers/infiniband/sw/rxe/rxe.h        |   3 +
>>   drivers/infiniband/sw/rxe/rxe_comp.c   |  46 +++-
>>   drivers/infiniband/sw/rxe/rxe_icrc.c   |  65 ++++-
>>   drivers/infiniband/sw/rxe/rxe_loc.h    |  27 +-
>>   drivers/infiniband/sw/rxe/rxe_mr.c     | 348 +++++++++++++++++++------
>>   drivers/infiniband/sw/rxe/rxe_net.c    | 109 +++++++-
>>   drivers/infiniband/sw/rxe/rxe_opcode.c |   2 +
>>   drivers/infiniband/sw/rxe/rxe_recv.c   |   1 +
>>   drivers/infiniband/sw/rxe/rxe_req.c    |  88 ++++++-
>>   drivers/infiniband/sw/rxe/rxe_resp.c   | 172 +++++++-----
>>   drivers/infiniband/sw/rxe/rxe_verbs.h  |   8 +-
>>   12 files changed, 672 insertions(+), 202 deletions(-)
>>
>>
> 
> What are the following? This is the new format in linux kernel community?
If you type --base d6b811de06c8900be after git format-patch it documents what the patch
was applied to. I have multiple patch sets that have to be applied in order.
Three of them have already been submitted but are not upstream yet. The fourth
one was submitted just before this set.

Bob
> 
> Zhu Yanjun
> 
>> base-commit: 693e1cdebb50d2aa67406411ca6d5be195d62771
>> prerequisite-patch-id: c3994e7a93e37e0ce4f50e0c768f3c1a0059a02f
>> prerequisite-patch-id: 48e13f6ccb560fdeacbd20aaf6696782c23d1190
>> prerequisite-patch-id: da75fb8eaa863df840e7b392b5048fcc72b0bef3
>> prerequisite-patch-id: d0877649e2edaf00585a0a6a80391fe0d7bbc13b
>> prerequisite-patch-id: 6495b1d1f664f8ab91ed9ef9d2ca5b3b27d7df35
>> prerequisite-patch-id: a6367b8fedd0d8999139c8b857ebbd3ce5c72245
>> prerequisite-patch-id: 78c95e90a5e49b15b7af8ef57130739c143e88b5
>> prerequisite-patch-id: 7c65a01066c0418de6897bc8b5f44d078d21b0ec
>> prerequisite-patch-id: 8ab09f93c23c7875e56c597e69236c30464723b6
>> prerequisite-patch-id: ca9d84b34873b49048e42fb4c13a2a097c215c46
>> prerequisite-patch-id: 0f6a587501c8246e1185dfd0cbf5e2044c5f9b13
>> prerequisite-patch-id: 5246df93137429916d76e75b9a13a4ad5ceb0bad
>> prerequisite-patch-id: 41b0e4150794dd914d9fcb4cd106fe4cf4227611
>> prerequisite-patch-id: 02b08ec037bc35b9c7771640c89c66504cdf38a6
>> prerequisite-patch-id: dfccc06c16454d7fe8e6fcba064d4e471d314666
>> prerequisite-patch-id: 7459a6e5cdd46efd53ba27f9b3e9028af6e0863b
>> prerequisite-patch-id: 36d49f9303f5cb276a5601c1ab568eea6eca7d3a
>> prerequisite-patch-id: 6359a681e40832694f81ca003c10e5327996bf7d
>> prerequisite-patch-id: 558175db657f374dbd3e0a57ac4c5fb77a56b6c6
>> prerequisite-patch-id: d6b811de06c8900be5840dd29715161d26db66cf
> 

