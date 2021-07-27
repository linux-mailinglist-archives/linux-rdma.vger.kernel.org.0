Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377E03D7540
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 14:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhG0MpC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 08:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbhG0MpB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Jul 2021 08:45:01 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C102C061757
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jul 2021 05:45:02 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id w6so14923763oiv.11
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jul 2021 05:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i5Nt6NGzbA51toYcT/VTgo7QuL6cA4aE1IVXhXN32jc=;
        b=XZCIkGC5Sj/YjxEjhp7DbdT4aDGKQ8YqwwzxdrgXM/yvMuPkkg/DNllOpQQMp+6uv5
         WyQ7eXvvqPcdR0dlDdR2zngrb4c6kSw55gD13RJUu/I3Of/ZwafM6SIz4WImOUixJnoT
         PRxKPIhiOmquQb1AnTRQFwhwGWcKq1AQIKRi5mdPnG3XYMSLlyXKCjTtIKtQIxlxkPfw
         DQAL/+Q3Hlg2/QycPl2+fPgJmmIqVhaPRI2JkHolVrFvkCGeDebzifRTwNnrbEaJZR33
         Oe0bFKKrzFxoMG/zYgq/2OE8u6z6GnZU8kr34aWl8NYtH3lLY1/xgxARei7jv9JMiN10
         XJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i5Nt6NGzbA51toYcT/VTgo7QuL6cA4aE1IVXhXN32jc=;
        b=ElT5Smr545uHZXSZBgplGa7MdoDnziC72KqY7+uOKMwiixow7rw3imBxUTTAP+GSXk
         FxYyHhrp0lnLKxKsTAzb70Vlq0FHwZkbWWLuCNuZhLEB18oyWG+kM+XOoxAyv1Irb8S7
         6zqnSwO8pno+mkeQ2NffNJEy5C6fLecqmCqcmWJnCEdGlibqmUmfsdOZdmyJFyu/1bzt
         FGUEs9Jh/67WbVzPy5SURoCbrmRI7kxWo0K2TM97B839hW8onCpbqGLkwD/IlWBM1VP3
         Uwvu1D3RFb98ZvcP57dNHpBLAheT4+Eo95TeuxPBD4i8OM7d5WKwo6v5K/ivt18iqG+H
         HnTA==
X-Gm-Message-State: AOAM5320tN0XYDmaA62yU5lkl8gLjIKsyK/Gz/ap6bk69/oYO0PMtEeW
        FrqEm19MHv98ya9fd5d0ezQok4pUGQ8=
X-Google-Smtp-Source: ABdhPJzWrzKdXqWbr3X2FrndVl3e4iVSuyxII3o9i9nPSBbwpGnmvBgbf6ADbur5wmy2pPHB71i2Mg==
X-Received: by 2002:aca:d404:: with SMTP id l4mr14424423oig.21.1627389901387;
        Tue, 27 Jul 2021 05:45:01 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:79a:6fd8:e907:f2b3? (2603-8081-140c-1a00-079a-6fd8-e907-f2b3.res6.spectrum.com. [2603:8081:140c:1a00:79a:6fd8:e907:f2b3])
        by smtp.gmail.com with ESMTPSA id r5sm492786oti.5.2021.07.27.05.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 05:45:00 -0700 (PDT)
Subject: Re: [PATCH for-next] RDMA/rxe: Let rdma-core manage PDs
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20210726215815.17056-1-rpearsonhpe@gmail.com>
 <YP/uTbQ71dZWYIal@unreal> <c181c1b9-a2a6-3cf0-8644-762f6398bb5e@gmail.com>
 <YP/18Ycu+EMLA8T8@unreal>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <ceea9bc1-1e9d-a30c-a875-442a0c8d9c47@gmail.com>
Date:   Tue, 27 Jul 2021 07:44:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YP/18Ycu+EMLA8T8@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/27/21 7:02 AM, Leon Romanovsky wrote:
> On Tue, Jul 27, 2021 at 06:31:59AM -0500, Bob Pearson wrote:
>> On 7/27/21 6:30 AM, Leon Romanovsky wrote:
>>> On Mon, Jul 26, 2021 at 04:58:16PM -0500, Bob Pearson wrote:
>>>> Currently several rxe objects hold references to PDs which are ref-
>>>> counted. This replicates work already done by RDMA core which takes
>>>> references to PDs in the ib objects which are contained in the rxe
>>>> objects. This patch removes struct rxe_pd from rxe objects and removes
>>>> reference counting for PDs except for PD alloc and PD dealloc. It also
>>>> adds inline extractor routines which return PDs from the PDs in the
>>>> ib objects. The names of these are made consistent including a rxe_
>>>> prefix.
>>>>
>>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>>> ---
>>>>  drivers/infiniband/sw/rxe/rxe_comp.c  |  4 ++--
>>>>  drivers/infiniband/sw/rxe/rxe_loc.h   |  4 ++--
>>>>  drivers/infiniband/sw/rxe/rxe_mr.c    |  8 +++----
>>>>  drivers/infiniband/sw/rxe/rxe_mw.c    | 31 +++++++++++----------------
>>>>  drivers/infiniband/sw/rxe/rxe_qp.c    |  9 +-------
>>>>  drivers/infiniband/sw/rxe/rxe_req.c   |  2 +-
>>>>  drivers/infiniband/sw/rxe/rxe_resp.c  |  4 ++--
>>>>  drivers/infiniband/sw/rxe/rxe_verbs.c | 26 ++++++----------------
>>>>  drivers/infiniband/sw/rxe/rxe_verbs.h | 24 +++++++++++++++------
>>>>  9 files changed, 48 insertions(+), 64 deletions(-)
>>>
>>> Last time when I looked on it, I came to conclusion that all RXE
>>> references can be dropped.
>>>
>>> Thanks
>>>
>> This is a step in that direction. There are more coming.
> 
> Glad to hear, thank you for your work.
> 
>> Regards,
>>
>> Bob

The other ones I can immediately get rid of are AHs, CQs and SRQs.

The ones I think may require ref counting are MRs, MWs, QPs, and XRCSRQs. Each of these
get looked up from information in RoCE packets from rkeys, qpns, and srq_nums, For reliable transports
on slow networks this can require that these objects hang around for a while and the user has no
visibility to this unless there is a completion event waiting but not for e.g. reads, writes or atomics on the target side. There can be races between destroying these objects and messages completing causing
kernel oops. Do you know another way to address these cases?

Bob
