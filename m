Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAA36B81E7
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Mar 2023 20:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCMTzM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Mar 2023 15:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCMTzM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Mar 2023 15:55:12 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71339567AB
        for <linux-rdma@vger.kernel.org>; Mon, 13 Mar 2023 12:55:07 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id a4-20020a056830008400b0069432af1380so7294377oto.13
        for <linux-rdma@vger.kernel.org>; Mon, 13 Mar 2023 12:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678737307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rzbLLGhXon326u0i8vYyH9LZBtkIfRL78cKJLdQ7MYQ=;
        b=FDIpprTSgFqoiBgQrfna4K6J/xcLZarNboYnLW1kMyPlzjw7TlzmfC5SLXu+SKFhEP
         gEp/JskZZShJfs6AZBjJFvV+JnkXTAEK0WOhG7CoJSf0AbtJ9ex929JKTIDFX1Cby3bo
         1njYIv/R5MuzD1xZX44BiOoGuBlrSueC61ujsUKsABkdnuF9LEYZ1w6Vn9voeq1rxo0+
         mFOTxahhaFBuFnG+4W5Pqh5oKJQDzfrJzI9q100rpuXXw7FiK/5mqFiaKz6UTAHAxqG9
         DYCD6yVRaOygond11804TV79QQNwG1RPpnckKmnJgFeL2zk07Q3SUpkOf81tkNY6WqW/
         25QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678737307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzbLLGhXon326u0i8vYyH9LZBtkIfRL78cKJLdQ7MYQ=;
        b=N9s6DhFEHTkZEvtmKj/RPNYUXrLg+SfilZFw9DhbM6MegBvj9AQ17jfzyCYKxgYAtW
         xgTr6KT+xBNsjQE7bHZUO9BCwx+Ae4j3vG6YngcwUk0ttloHtgHjEvJBSu/kuCLyiONJ
         /ovGZBSw/KoT2JsJaMvsHUHXL1rbkfY99doIPrBAr8YmUwv4/QpAtmLNJW+M+jejkVn2
         MlQsqn6ZE1kDDKwXGnfKVI/G2zA/dM4QbpStFSo9raocF1DDeADyoCQgSSmhaMRtMGtY
         vQkRfGNOjW5fk4cWU/Xy5katW/YQFeXzdBQJE8r/hlA5JI2qhZUoiaJQFVvPAkQ54ZyL
         Q3rw==
X-Gm-Message-State: AO0yUKVKYHCi5PX2hLKk/OaSQFm3ikvEHybn8LnelUG2ajx7VA++GwKD
        GT2wWQbqy1NFTPLExn7aH68=
X-Google-Smtp-Source: AK7set/jNxSzzilYVNnCH2YrBJ4MdLqyLoVfY8TvJcjtlVdZrXM2IO4aMNoQCHzz/BSLJUwSJpenbA==
X-Received: by 2002:a9d:12ab:0:b0:690:e511:58b2 with SMTP id g40-20020a9d12ab000000b00690e51158b2mr20678538otg.26.1678737306820;
        Mon, 13 Mar 2023 12:55:06 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:541:eebd:242d:8128? (2603-8081-140c-1a00-0541-eebd-242d-8128.res6.spectrum.com. [2603:8081:140c:1a00:541:eebd:242d:8128])
        by smtp.gmail.com with ESMTPSA id y11-20020a4ade0b000000b005252e5b6604sm259414oot.36.2023.03.13.12.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 12:55:06 -0700 (PDT)
Message-ID: <d5567336-4892-5a2b-f8c3-49e5c088d3f6@gmail.com>
Date:   Mon, 13 Mar 2023 14:55:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] RDMA/rxe: Fix parameter errors
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, leonro@nvidia.com,
        linux-rdma@vger.kernel.org, Rao.Shoaib@oracle.com
References: <20230119180506.5197-1-rpearsonhpe@gmail.com>
 <Y8mXfmju8W+3FdDp@nvidia.com>
 <108cf8f1-6123-620e-8700-53246c7a8287@gmail.com>
 <ZAZSR2g4ZzESuXRc@nvidia.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ZAZSR2g4ZzESuXRc@nvidia.com>
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

On 3/6/23 14:51, Jason Gunthorpe wrote:
> On Wed, Mar 01, 2023 at 05:15:07PM -0600, Bob Pearson wrote:
>> On 1/19/23 13:18, Jason Gunthorpe wrote:
>>> On Thu, Jan 19, 2023 at 12:05:07PM -0600, Bob Pearson wrote:
>>>> Correct errors in rxe_param.h caused by extending the range of
>>>> indices for MRs allowing it to overlap the range for MWs. Since
>>>> the driver determines whether an rkey is for an MR or MW by comparing
>>>> the index part of the rkey with these ranges this can cause an
>>>> MR to be incorrectly determined to be an MW.
>>>>
>>>> Additionally the parameters which determine the size of the index
>>>> ranges for MR, MW, QP and SRQ are incorrect since the actual
>>>> number of integers in the range [min, max] is (max - min + 1) not
>>>> (max - min).
>>>>
>>>> This patch corrects these errors.
>>>>
>>>> Fixes: 0994a1bcd5f7 ("RDMA/rxe: Bump up default maximum values used via uverbs")
>>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>>> ---
>>>>  drivers/infiniband/sw/rxe/rxe_param.h | 27 +++++++++++++++++++--------
>>>>  1 file changed, 19 insertions(+), 8 deletions(-)
>>>
>>> This
>>>
>>> commit 1aefe5c177c1922119afb4ee443ddd6ac3140b37
>>> Author: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
>>> Date:   Tue Dec 20 17:08:48 2022 +0900
>>>
>>>     RDMA/rxe: Prevent faulty rkey generation
>>>     
>>>     If you create MRs more than 0x10000 times after loading the module,
>>>     responder starts to reply NAKs for RDMA/Atomic operations because of rkey
>>>     violation detected in check_rkey(). The root cause is that rkeys are
>>>     incremented each time a new MR is created and the value overflows into the
>>>     range reserved for MWs.
>>>     
>>>     This commit also increases the value of RXE_MAX_MW that has been limited
>>>     unlike other parameters.
>>>     
>>>     Fixes: 0994a1bcd5f7 ("RDMA/rxe: Bump up default maximum values used via uverbs")
>>>     Link: https://lore.kernel.org/r/20221220080848.253785-2-matsuda-daisuke@fujitsu.com
>>>     Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
>>>     Tested-by: Li Zhijian <lizhijian@fujitsu.com>
>>>     Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
>>>     Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>>>
>>>
>>> Is already in v6.2-rc and conflicts with this patch, it looks like it
>>> is doing the same thing, can you sort it out please?
>>>
>>> Thanks,
>>> Jason
>>
>> Did this get lost? for-next is now at 6.2-rc3 now and the bug is
>> still in rxe_param.h.
> 
> Check again we are at v6.3-rc1 now, if something needs to be fixed
> send a new patch..
> 
> Jason

Just checked. It now looks good in for-next.

Thanks

Bob
