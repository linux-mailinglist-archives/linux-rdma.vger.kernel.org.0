Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF8F38F14B
	for <lists+linux-rdma@lfdr.de>; Mon, 24 May 2021 18:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbhEXQOD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 May 2021 12:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236736AbhEXQN5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 May 2021 12:13:57 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182A0C06138A
        for <linux-rdma@vger.kernel.org>; Mon, 24 May 2021 09:04:18 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so25678787otg.2
        for <linux-rdma@vger.kernel.org>; Mon, 24 May 2021 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Nk+ZrSTAPLCXCuQpr/kJw1xz+e/xh30HnEeWFcKjVhE=;
        b=aihKVDy1HmPv7W76TiSDb70K5a4uuPEGT2Du25SBu/sTP3FvEtorZtIStmZLNq+XVb
         QcvmFdQ9xWaI4Um0NGvO6pLEl805HnJFRfoJG1MhGYLz8R6iP3UJ0KspOEEMdqbab4sg
         Fi2aNb+cbSYwx04dSZq2Vd+jfXyiYj8HTrrqiQgSNVqV9bd1mBCJc8CC8op5N66eVLEs
         Y2xUXuTxdXQsWDXorpO6Hs5UnvShIawqwJ/pGmIP/hBqVgdovHjAR8T6fQ0yAsyKqrBT
         uGbUSKf2v93uIa5XQGLoqLTn7hS2cvo/fDfVpO4+ewPfDpAUm/MUhJszr7X6kX/rFS4d
         9aGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Nk+ZrSTAPLCXCuQpr/kJw1xz+e/xh30HnEeWFcKjVhE=;
        b=rBwXlPlPhiiKfiy6O/wvmnl3Kztud57ljmVYiUMUVR8EC5yqReOUQ61+bowwarQC13
         FCodMRVPXHZheBY6iKlulkivmSyvDf2S4ZImnfQ53WXNHFo9PzevdBfpOcAWx7/afdba
         z/EP/NGa06F2dSMM9SM1ATPS04cGH/prcetyK8Y8nfAOTUkRUsxLwmmQkmCJQc1SqXn3
         Svfhv1tz1i7mx1AQxyAWpFprzTJEMauR39rinhvvn+aEJcMIbH4tYrUVIk0Sl+PaQu+b
         Y0pe5qyhQ4QP4odzBa/FvU72RG/B8VNifmYRGtgZKszO7iG/fhDqATlefbZGOc23xrgi
         rOrQ==
X-Gm-Message-State: AOAM5303rxuhw8la4tgn9S694lvcEaMEgMXhZosYP846wDbvf4l2mBxO
        zQYaSZb55ym7C5DkoAZCFQ3+LGa8zO4yGg==
X-Google-Smtp-Source: ABdhPJy67crWHmBeYILOeFZ1ZBAGRIAXqu7YNI/POnTDAinYeM6t9fVkqKGn3JgCwJ1yrc8rIvko7Q==
X-Received: by 2002:a05:6830:90f:: with SMTP id v15mr18955566ott.223.1621872257266;
        Mon, 24 May 2021 09:04:17 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:6c75:b0b:aa76:4a5c? (2603-8081-140c-1a00-6c75-0b0b-aa76-4a5c.res6.spectrum.com. [2603:8081:140c:1a00:6c75:b0b:aa76:4a5c])
        by smtp.gmail.com with ESMTPSA id v79sm2726397oia.14.2021.05.24.09.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 09:04:16 -0700 (PDT)
Subject: Re: [PATCH for-next v7 00/10] RDMA/rxe: Implement memory windows
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210521201824.659565-1-rpearsonhpe@gmail.com>
 <CAD=hENeKHgwLEOAsZ+2tu7M-+3Pv9QVccbWSwLy+zV-zX2h-bg@mail.gmail.com>
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
Message-ID: <dd81d60d-f4fa-feae-90a0-201ee995e07f@gmail.com>
Date:   Mon, 24 May 2021 11:04:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAD=hENeKHgwLEOAsZ+2tu7M-+3Pv9QVccbWSwLy+zV-zX2h-bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/23/2021 10:14 PM, Zhu Yanjun wrote:
> On Sat, May 22, 2021 at 4:19 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>> This series of patches implement memory windows for the rdma_rxe
>> driver. This is a shorter reimplementation of an earlier patch set.
>> They apply to and depend on the current for-next linux rdma tree.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>> v7:
>>    Fixed a duplicate INIT_RDMA_OBJ_SIZE(ib_mw, ...) in rxe_verbs.c.
> With this patch series, there are about 17 errors and 1 failure in rdma-core.

Zhu,

You have to sync the kernel-header file with the kernel.

Bob

> "
> ----------------------------------------------------------------------
> Ran 183 tests in 2.130s
>
> FAILED (failures=1, errors=17, skipped=124)
> "
>
> After these patches, not sure if rxe can communicate with the physical
> NICs correctly because of the
> above errors and failure.
>
> Zhu Yanjun
>
>> v6:
>>    Added rxe_ prefix to subroutine names in lines that changed
>>    from Zhu's review of v5.
>> v5:
>>    Fixed a typo in 10th patch.
>> v4:
>>    Added a 10th patch to check when MRs have bound MWs
>>    and disallow dereg and invalidate operations.
>> v3:
>>    cleaned up void return and lower case enums from
>>    Zhu's review.
>> v2:
>>    cleaned up an issue in rdma_user_rxe.h
>>    cleaned up a collision in rxe_resp.c
>>
>> Bob Pearson (9):
>>    RDMA/rxe: Add bind MW fields to rxe_send_wr
>>    RDMA/rxe: Return errors for add index and key
>>    RDMA/rxe: Enable MW object pool
>>    RDMA/rxe: Add ib_alloc_mw and ib_dealloc_mw verbs
>>    RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
>>    RDMA/rxe: Move local ops to subroutine
>>    RDMA/rxe: Add support for bind MW work requests
>>    RDMA/rxe: Implement invalidate MW operations
>>    RDMA/rxe: Implement memory access through MWs
>>
>>   drivers/infiniband/sw/rxe/Makefile     |   1 +
>>   drivers/infiniband/sw/rxe/rxe.c        |   1 +
>>   drivers/infiniband/sw/rxe/rxe_comp.c   |   1 +
>>   drivers/infiniband/sw/rxe/rxe_loc.h    |  29 +-
>>   drivers/infiniband/sw/rxe/rxe_mr.c     |  79 ++++--
>>   drivers/infiniband/sw/rxe/rxe_mw.c     | 356 +++++++++++++++++++++++++
>>   drivers/infiniband/sw/rxe/rxe_opcode.c |  11 +-
>>   drivers/infiniband/sw/rxe/rxe_opcode.h |   3 +-
>>   drivers/infiniband/sw/rxe/rxe_param.h  |  19 +-
>>   drivers/infiniband/sw/rxe/rxe_pool.c   |  45 ++--
>>   drivers/infiniband/sw/rxe/rxe_pool.h   |   8 +-
>>   drivers/infiniband/sw/rxe/rxe_req.c    | 102 ++++---
>>   drivers/infiniband/sw/rxe/rxe_resp.c   | 110 +++++---
>>   drivers/infiniband/sw/rxe/rxe_verbs.c  |   5 +-
>>   drivers/infiniband/sw/rxe/rxe_verbs.h  |  38 ++-
>>   include/uapi/rdma/rdma_user_rxe.h      |  34 ++-
>>   16 files changed, 691 insertions(+), 151 deletions(-)
>>   create mode 100644 drivers/infiniband/sw/rxe/rxe_mw.c
>> --
>> 2.27.0
>>
