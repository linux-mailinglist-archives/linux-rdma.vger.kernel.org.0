Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26993D7461
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 13:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhG0LcN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 07:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbhG0LcL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Jul 2021 07:32:11 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69070C061757
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jul 2021 04:32:08 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id c7-20020a9d27870000b02904d360fbc71bso13029885otb.10
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jul 2021 04:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SBLramiIuxnYBNTFyiM38kciXpevnvfrUj+a2o0wtN8=;
        b=Yc6F1wDk+nHrx8EMqyZb+auhcJSSSJ7mo/iIkElSmnjJo+i+Kt+bwpmEDscWvKrbZO
         J2xkpA6r0srje4WlIEjUmU1QX6V3ZTyoddM/15+nAMVyxUxViKvp2/mH2nXAO4T7EoZk
         YqcK6gfkgwxKHQDrq+ciIHMkwPAhjHwCkNUR6+fVxHJt4CFASfYZCTim/wdrBK2B+qLh
         Vdusww84CFqgXxMd39COtWAzJCg4yC2qhv6qvUOvRPoo6hkdWYOlihiH9u2Geg6vj3l8
         aLvb/ElWWOK4TZxjjWqwm1BtBZi1ulADpsH3JTTXRNxWGdKFyG1RTALZ46UAb/dWmIJb
         20vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SBLramiIuxnYBNTFyiM38kciXpevnvfrUj+a2o0wtN8=;
        b=pNvYxlsn3tHOSiE2GvsrHO/HWq3cy0+YtxIPQ2S3s71AyAoENINbxagAbKWVM7z4LK
         S+hXpdrMCeebhmDDSBI4Sji6hS/k7Zj+f1iPeA6iYDjyItw5jQufDRVRjzaTL0hhLm9L
         tjVs3kBc+eXnq54yRs0xJmbVuHkIRyGq/bH4aCdqMOllWvNaadyKIrJML3jdVW0I1yx8
         sxeBxSxagYEq3nlIUNlkEzKH+coOLvE9+TE+VzoqXFhLmUZJnZvVj+hflSna/uAlAfJh
         H3SWrvybROpYsvD7a4PUrn3lhw95FgUmL+FQjuSnYfeAfkyl/bhYILmpp/NzJUKIHyDA
         8aiw==
X-Gm-Message-State: AOAM530aJGCm0OxYXabnoTqFk2TWcoHUDkdTN9arm3oZyGcCCaJpgvVE
        Wp+WxfEQYHuepr2ro+hfDrdYSDw/jlc=
X-Google-Smtp-Source: ABdhPJwSkTpI4/XfiAGo4hTx09xSnFiJ3mMEfhzQq7y6SxGAamziQ2ltzPjcFzX7ZmVcnVIfK52QPg==
X-Received: by 2002:a05:6830:1b71:: with SMTP id d17mr14637527ote.193.1627385527660;
        Tue, 27 Jul 2021 04:32:07 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:79a:6fd8:e907:f2b3? (2603-8081-140c-1a00-079a-6fd8-e907-f2b3.res6.spectrum.com. [2603:8081:140c:1a00:79a:6fd8:e907:f2b3])
        by smtp.gmail.com with ESMTPSA id t7sm491774otl.25.2021.07.27.04.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 04:32:07 -0700 (PDT)
Subject: Re: [PATCH for-next] RDMA/rxe: Let rdma-core manage PDs
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20210726215815.17056-1-rpearsonhpe@gmail.com>
 <YP/uTbQ71dZWYIal@unreal>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <c181c1b9-a2a6-3cf0-8644-762f6398bb5e@gmail.com>
Date:   Tue, 27 Jul 2021 06:31:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YP/uTbQ71dZWYIal@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/27/21 6:30 AM, Leon Romanovsky wrote:
> On Mon, Jul 26, 2021 at 04:58:16PM -0500, Bob Pearson wrote:
>> Currently several rxe objects hold references to PDs which are ref-
>> counted. This replicates work already done by RDMA core which takes
>> references to PDs in the ib objects which are contained in the rxe
>> objects. This patch removes struct rxe_pd from rxe objects and removes
>> reference counting for PDs except for PD alloc and PD dealloc. It also
>> adds inline extractor routines which return PDs from the PDs in the
>> ib objects. The names of these are made consistent including a rxe_
>> prefix.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_comp.c  |  4 ++--
>>  drivers/infiniband/sw/rxe/rxe_loc.h   |  4 ++--
>>  drivers/infiniband/sw/rxe/rxe_mr.c    |  8 +++----
>>  drivers/infiniband/sw/rxe/rxe_mw.c    | 31 +++++++++++----------------
>>  drivers/infiniband/sw/rxe/rxe_qp.c    |  9 +-------
>>  drivers/infiniband/sw/rxe/rxe_req.c   |  2 +-
>>  drivers/infiniband/sw/rxe/rxe_resp.c  |  4 ++--
>>  drivers/infiniband/sw/rxe/rxe_verbs.c | 26 ++++++----------------
>>  drivers/infiniband/sw/rxe/rxe_verbs.h | 24 +++++++++++++++------
>>  9 files changed, 48 insertions(+), 64 deletions(-)
> 
> Last time when I looked on it, I came to conclusion that all RXE
> references can be dropped.
> 
> Thanks
> 
This is a step in that direction. There are more coming.
Regards,

Bob
