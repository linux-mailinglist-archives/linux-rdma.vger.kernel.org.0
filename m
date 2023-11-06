Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6067E262E
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Nov 2023 14:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjKFN6X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Nov 2023 08:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKFN6W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Nov 2023 08:58:22 -0500
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08949BF
        for <linux-rdma@vger.kernel.org>; Mon,  6 Nov 2023 05:58:19 -0800 (PST)
Message-ID: <c736ddff-8523-463a-aa9a-3c8542486d69@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699279097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YpJtQNjFqtQun1UvL/4GUP7sq9HgupW691S6klaKvC8=;
        b=qlvQ3FFPO/1CekUdKexuT0MbYhC22LlVBltuHnwyVYU8d+rzh6Q99+brRFabRMaaFITG4B
        rCabmlVd/Bx7N36ZqC9GYjX1j+HlRLTch5cSgnqqrTzHTbe+lLmrVGrc/w/sMLzvaRq+EF
        ToQJAcBwgjeG4jwxCcV8vhlSSGjR3Yw=
Date:   Mon, 6 Nov 2023 21:58:03 +0800
MIME-Version: 1.0
Subject: Re: [PATCH RFC V2 0/6] rxe_map_mr_sg() fix cleanup and refactor
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>
References: <20231103095549.490744-1-lizhijian@fujitsu.com>
 <d838620b-51df-4216-864e-1c793dae7721@linux.dev>
 <a256a01d-1572-427a-80df-46f2079af967@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <a256a01d-1572-427a-80df-46f2079af967@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/11/6 12:07, Zhijian Li (Fujitsu) 写道:
> 
> 
> On 03/11/2023 21:00, Zhu Yanjun wrote:
>> 在 2023/11/3 17:55, Li Zhijian 写道:
>>> I don't collect the Reviewed-by to the patch1-2 this time, since i
>>> think we can make it better.
>>>
>>> Patch1-2: Fix kernel panic[1] and benifit to make srp work again.
>>>             Almost nothing change from V1.
>>> Patch3-5: cleanups # newly add
>>> Patch6: make RXE support PAGE_SIZE aligned mr # newly add, but not fully tested
>>>
>>> My bad arm64 mechine offten hangs when doing blktests even though i use the
>>> default siw driver.
>>>
>>> - nvme and ULPs(rtrs, iser) always registers 4K mr still don't supported yet.
>>
>> Zhijian
>>
>> Please read carefully the whole discussion about this problem. You will find a lot of valuable suggestions, especially suggestions from Jason.
> 
> Okay, i will read it again. If you can tell me which thread, that would be better.
> 
> 
>>
>>   From the whole discussion, it seems that the root cause is very clear.
>> We need to fix this prolem. Please do not send this kind of commits again.
>>
> 
> Let's think about what's our goal first.
> 
> - 1) Fix the panic[1] and only support PAGE_SIZE MR
> - 2) support PAGE_SIZE aligned MR
> - 3) support any page_size MR.
> 
> I'm sorry i'm not familiar with the linux MM subsystem. It seem it's safe/correct to access
> address/memory across pages start from the return of kmap_loca_page(page).
> In other words, 2) is already native supported, right?

Yes. Please read the comments from Jason, Leon and Bart. They shared a 
lot of good advice. From them, we can know the root cause and how to fix 
this problem.

Good Luck.

Zhu Yanjun

> 
> I get totally confused now.
> 
> 
> 
>> Zhu Yanjun
>>
>>>
>>> [1] https://lore.kernel.org/all/CAHj4cs9XRqE25jyVw9rj9YugffLn5+f=1znaBEnu1usLOciD+g@mail.gmail.com/T/
>>>
>>> Li Zhijian (6):
>>>     RDMA/rxe: RDMA/rxe: don't allow registering !PAGE_SIZE mr
>>>     RDMA/rxe: set RXE_PAGE_SIZE_CAP to PAGE_SIZE
>>>     RDMA/rxe: remove unused rxe_mr.page_shift
>>>     RDMA/rxe: Use PAGE_SIZE and PAGE_SHIFT to extract address from
>>>       page_list
>>>     RDMA/rxe: cleanup rxe_mr.{page_size,page_shift}
>>>     RDMA/rxe: Support PAGE_SIZE aligned MR
>>>
>>>    drivers/infiniband/sw/rxe/rxe_mr.c    | 80 ++++++++++++++++-----------
>>>    drivers/infiniband/sw/rxe/rxe_param.h |  2 +-
>>>    drivers/infiniband/sw/rxe/rxe_verbs.h |  9 ---
>>>    3 files changed, 48 insertions(+), 43 deletions(-)
>>>

