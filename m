Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9867C32F357
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Mar 2021 20:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhCES7v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Mar 2021 13:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhCES7r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Mar 2021 13:59:47 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9389BC061574
        for <linux-rdma@vger.kernel.org>; Fri,  5 Mar 2021 10:59:47 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id x78so3651156oix.1
        for <linux-rdma@vger.kernel.org>; Fri, 05 Mar 2021 10:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6n6B9k3zxjlTo4XhwO58OxdLHvj9GwCp8rcIx772UPQ=;
        b=ReLRqfN2sD7ExxhBNCxx4A6ZDxxhXcF8EiDT76qlUaf3SyFyEAoLPoHbGF2wHnt+Z2
         z2PoYrPDhnEypLj/bb5imxhpsZRm57qm39MUIB5Axmu4YagfjFJ80qnhpREf9aFB9Qiz
         Hq3teEYRc0wpVU/TnjgWwO10i8L1El7xCOIOZRMi9hwWfm1g4sNmhFjTgoyRLlgDpRNN
         nr0jQHPdqg6IjDdfjgKHlUTLEQiqaSlUzdZQxq5CYYzkjio89C0fy9IPdO3jJH/0PFl/
         pTwNFs1eM1BL2IiNu7q+cFG9zJn7YTcUP+knWUDFqvHHiu6UX9dK+pUWEC3NdXYBvc1E
         XCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6n6B9k3zxjlTo4XhwO58OxdLHvj9GwCp8rcIx772UPQ=;
        b=MuIrZZ7tnHG1yf5884+LClGRv8/ESrahOIz7Ab2mQNqdI9bcV+uYH/FDd+rCxKyqx0
         1ojeajCtudv5PC492LC8o8Td2EqW2sVMUaDmg40OBwQ6J2EaDEhLnQm26fPtPPFGYq9k
         siiMCYEI7lZTuJhYDhmTaslgXO45XTA0LM2J18inWU2fPIrJc3xeou+BICiPn3ruWE9x
         xu4rbdaAu3bWI/jqGgvwR7PKx+g+uEIWryFC5hcvnqMynaCgOeWKxQvD29ymdsr+odYY
         aqF0Q9wUkXmZeNMGSzdVB1h8K4lTr7aYgW4GTj6S+PBsQWVzJEFlCHtcb4vZfei8biOc
         wwSg==
X-Gm-Message-State: AOAM530wyFx13fgSYGV8zZZ33rUN4xbvwDiQn853N79vCnU+WQuxuzdh
        z7wdUj3PPHBp1ib2PhFtiiphAyh8FaCqQg==
X-Google-Smtp-Source: ABdhPJxbJyRXez70R5v1hxu8bRfrH3oV2oAkDNkrNVRJm6D+RDdg1dr09ojE1/cjjgtMyIXs/TGQUQ==
X-Received: by 2002:a05:6808:24d:: with SMTP id m13mr7977037oie.165.1614970786925;
        Fri, 05 Mar 2021 10:59:46 -0800 (PST)
Received: from ?IPv6:2603:8081:140c:1a00:4367:b935:ca34:b256? (2603-8081-140c-1a00-4367-b935-ca34-b256.res6.spectrum.com. [2603:8081:140c:1a00:4367:b935:ca34:b256])
        by smtp.gmail.com with ESMTPSA id c10sm728921otu.78.2021.03.05.10.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 10:59:46 -0800 (PST)
Subject: Re: [PATCH for-next v3] RDMA/rxe: Fix ib_device reference counting
 (again)
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20210304192048.2958-1-rpearson@hpe.com>
 <20210305182031.GA1884080@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <8959c33c-8346-c503-0d5f-f11e91e6d9b9@gmail.com>
Date:   Fri, 5 Mar 2021 12:59:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305182031.GA1884080@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/5/21 12:20 PM, Jason Gunthorpe wrote:
> On Thu, Mar 04, 2021 at 01:20:49PM -0600, Bob Pearson wrote:
>> From: Bob Pearson <rpearsonhpe@gmail.com>
>>
>> Three errors occurred in the fix referenced below.
>>
>> 1) rxe_rcv_mcast_pkt() dropped a reference to ib_device when
>> no error occurred causing an underflow on the reference counter.
>> This code is cleaned up to be clearer and easier to read.
>>
>> 2) Extending the reference taken by rxe_get_dev_from_net() in
>> rxe_udp_encap_recv() until each skb is freed was not matched by
>> a reference in the loopback path resulting in underflows.
>>
>> 3) In rxe_comp.c in rxe_completer() the function free_pkt() did
>> not clear skb which triggered a warning at done: and could possibly
>> at exit: . The WARN_ONCE() calls are not actually needed.
>> The call to free_pkt() is moved to the end to clearly show that
>> all skbs are freed.
>>
>> This patch fixes these errors.
>>
>> Fixes: 899aba891cab ("RDMA/rxe: Fix FIXME in rxe_udp_encap_recv()")
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> Version 3:
>> V2 of this patch had spelling errors and style issues which are
>> fixed in this version.
>>
>> Version 2:
>> v1 of this patch incorrectly added a WARN_ON_ONCE in rxe_completer
>> where it could be triggered for normal traffic. This version
>> replaced that with a pr_warn located correctly.
>>
>> v1 of this patch placed a call to kfree_skb in an if statement
>> that could trigger style warnings. This version cleans that up.
>>
>>  drivers/infiniband/sw/rxe/rxe_comp.c | 55 +++++++++++---------------
>>  drivers/infiniband/sw/rxe/rxe_net.c  | 10 ++++-
>>  drivers/infiniband/sw/rxe/rxe_recv.c | 59 +++++++++++++++++-----------
>>  3 files changed, 67 insertions(+), 57 deletions(-)
> 
> I split this into three patches for-rc as is required by Linus.
> 
> It looks reasonable to me and the reorganizing make sense
> 
> Thanks,
> Jason
> 
Thanks. Sorry this took so long to resolve.

bob
