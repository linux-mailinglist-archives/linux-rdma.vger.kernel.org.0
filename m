Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF245854C0
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Jul 2022 19:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238238AbiG2RvB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Jul 2022 13:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237460AbiG2RvA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Jul 2022 13:51:00 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7310F1CB0E
        for <linux-rdma@vger.kernel.org>; Fri, 29 Jul 2022 10:50:59 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10e615a36b0so5173867fac.1
        for <linux-rdma@vger.kernel.org>; Fri, 29 Jul 2022 10:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=R8FCXUXuenscXTHzPYA20gcTcsddBqHhJzzZ7VyW71g=;
        b=p0eaqFwYnpIhFghjV8iYMOa1j05g3m2BRbSGWa2BC698lAUWQ3B9ZGrg+PlD6L8f4m
         1kaTWvr9AGjvVkkvkpha74hmCrDkbaSfYbMF2PwDJ3wGZnq/a4B4Ti27PvJzSFOlzZmD
         cq8JSaH1hhSKAId/Bvsu/WIUjWhXpB40OGO/oEWFCi+AuaYJ+r02mTfPL0hwXKqZkvvp
         Brs7jO5sTmbc3A1U75qwvw7f5e0nr9aNZVlxGNL7cvrROGACf3TxGewFpb3oNmaARyGU
         tlexa0XAKaon0IdHPLEZDS++QKmE/rWBMRQz1/aRevVMOgL7A74PH06vx1rZuwo08vOR
         gXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=R8FCXUXuenscXTHzPYA20gcTcsddBqHhJzzZ7VyW71g=;
        b=oL9+VzxsvOY6AdyApfPukGheeM1Er4WgnIkcOGGgg5VabfAP6ME+pA8FqcPIx6imWo
         /0LJvyLvxBL1KW1UVSZu4L1vcLdqnG+5PqGoEEJG5PQ7pYbp0EJj03Pfm7+14pITtevJ
         Sj/EZL1eK9txuhKhmgoz2CU7sI4ImQoaS47i78h2szKZjmn0/SbET6Y2ksVf0OSmMz7s
         4DTYe7rh/Jo4oTFSMEUNJGjazaHgz5Q+f51ZnLAAodPEksmriU1ucBjLT9hQQ00PPiw5
         wVbSU4ClJo2v9IPMaHy1oVzMlSOyJCumdTkDjdWOHByus8hM4PvsBWKhA6ndII9Cvy6k
         CJVg==
X-Gm-Message-State: AJIora8yNMfB3WbPCwvYI5jMefPds4WUDZPNjmeQH+3UfkPNJwMUaj92
        C8fnkjjbEwSsS4vguz9yUv0=
X-Google-Smtp-Source: AGRyM1tcvLuVgnSZNnrIJt/dNEQ6puQ5TfKfOtaXaeldCeijJQhQlaZ3wd1LOqfZYaN1pMonGe/mnA==
X-Received: by 2002:a05:6870:459d:b0:10e:75b7:15b7 with SMTP id y29-20020a056870459d00b0010e75b715b7mr2668211oao.115.1659117058804;
        Fri, 29 Jul 2022 10:50:58 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:3383:1c1c:70ed:cc53? (2603-8081-140c-1a00-3383-1c1c-70ed-cc53.res6.spectrum.com. [2603:8081:140c:1a00:3383:1c1c:70ed:cc53])
        by smtp.gmail.com with ESMTPSA id c1-20020a9d6141000000b0061c1a0b4677sm1368684otk.12.2022.07.29.10.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 10:50:58 -0700 (PDT)
Message-ID: <49603aa5-5176-23eb-7f32-055bce0d04eb@gmail.com>
Date:   Fri, 29 Jul 2022 12:50:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH for-next] RDMA/rxe: Guard mr state with spin lock
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     lizhijian@fujitsu.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
References: <20220725200114.2666-1-rpearsonhpe@gmail.com>
 <YuK8jXgAncDlppm9@nvidia.com>
 <04e87d78-29a2-735a-b984-d2321a8edc9d@gmail.com>
In-Reply-To: <04e87d78-29a2-735a-b984-d2321a8edc9d@gmail.com>
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

On 7/28/22 12:54, Bob Pearson wrote:
> On 7/28/22 11:42, Jason Gunthorpe wrote:
>> On Mon, Jul 25, 2022 at 03:01:15PM -0500, Bob Pearson wrote:
>>> Currently the rxe driver does not guard changes to the mr state
>>> against race conditions which can arise from races between
>>> local operations and remote invalidate operations. This patch
>>> adds a spinlock to the mr object and makes the state changes
>>> atomic.
>>
>> This doesn't make it atomic..
>>
>>> +	state = smp_load_acquire(&mr->state);
>>> +
>>>  	if (unlikely((type == RXE_LOOKUP_LOCAL && mr->lkey != key) ||
>>>  		     (type == RXE_LOOKUP_REMOTE && mr->rkey != key) ||
>>>  		     mr_pd(mr) != pd || (access && !(access & mr->access)) ||
>>> -		     mr->state != RXE_MR_STATE_VALID)) {
>>> +		     state != RXE_MR_STATE_VALID)) {
>>>  		rxe_put(mr);
>>
>> This is still just differently racy
>>
>> The whole point of invalidate is to say that when the invalidate
>> completion occurs there is absolutely no touching of the memory that
>> MR points to.
>>
>> I don't see how this acheives this like this. You need a proper lock
>> spanning from the lookup here until all the "dma" is completed.
>>
>> Jason
> 
> Interesting. Then things are in a bit of a mess. Before this patch of course there
> was nothing. And, rxe_resp.c currently looks up an mr from the rkey and saves it
> in the qp and then uses it for additional packets as required for e.g. rdma write
> operations. A local invalidate before a multipacket write finishes will have the wrong
> effect. It will continue to use the mr to perform the data copies. And the data copy
> routine does not validate the mr state. We would have to save the rkey instead and
> re-lookup the mr for each packet.
> 
> For a single packet we complete the dma in a single tasklet call. We would have a choice
> of holding a spinlock (for a fairly long time) or marking the mr as busy and deferring a
> local invalidate. A remote invalidate would fall between the packets of an rdma op.
> 
> Bob

Just rechecked all this and it isn't bad. The rxe responder only saves the mr during a single
packet processing cycle. Still not locked against races but at least no major surgery needed
for rdma writes.

Bob
