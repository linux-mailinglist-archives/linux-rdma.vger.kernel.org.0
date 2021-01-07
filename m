Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4214E2EE7CA
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jan 2021 22:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbhAGVpZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jan 2021 16:45:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51543 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbhAGVpY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Jan 2021 16:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610055837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j1WBhlktToi1vWvZaR5+DgjHLfs7iNt/Cu4S6xB04DU=;
        b=dkY+2RKlTfAdikxxzIbsxE6HDuBPDzP6vTJd4nYa1iQk2QKZQfqj87xlMTGoWqIbV6leq1
        5sN8rypCwjZtlXsjqOXz5D5Xtd6wJi1QLbdyue0++fIiH9+6Q+wEO1zVElZWV4DFx/QHyj
        sVXV5n0CNz75M5k4lbOC6GHgcIdK728=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-RHoWdGwNNI6UgoaRJ_K6pw-1; Thu, 07 Jan 2021 16:43:56 -0500
X-MC-Unique: RHoWdGwNNI6UgoaRJ_K6pw-1
Received: by mail-pg1-f199.google.com with SMTP id y2so5766853pgq.23
        for <linux-rdma@vger.kernel.org>; Thu, 07 Jan 2021 13:43:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=j1WBhlktToi1vWvZaR5+DgjHLfs7iNt/Cu4S6xB04DU=;
        b=V1+RXTCVsBz2lxu3qnDrdoIS8eqLGxXc8rIh9sU1xHaBWVkFLwiN4BA1lNxHq0hfxW
         SpxrgWNjpA6t1z1CqHcGAHWg4FIgNpC/c47womnUVr/ob8zHqno7O8ymgvlzk6Vkkgle
         IJgs2rg0lgG7Nb/dP+AAAGxMLe67bpnisOxgVcsrI7fHW5TDegmvhaRvJ/gV8Yk+u20V
         b4Y2QNcNHgQ2FfQULNajqIl1sw00UPj+b5EyZDqwwj9wvMRz1N9juCLQ1zlcdwqUUL68
         zhSKaWmOWnTOTYmPFICQ/1+SsXhjAFBgUxFhv8iWswIYiISTcL6Sh8mr6CJPa+smhm+7
         FKTA==
X-Gm-Message-State: AOAM533B5b/GiY42m3cOFXdu0GbbGfxN/CdNNJZaQpdZL6uiKaqDuZvA
        6zInkZPE27LCByDOGAKXQ7MI5UDKWQYTDFwHLlq/Dk6weSkM7gZwYI/5SZktV8C8QGLIk0/q6PV
        mkjZYLghH18oqQ6OuqcXnOg==
X-Received: by 2002:a63:fe13:: with SMTP id p19mr3763090pgh.119.1610055835347;
        Thu, 07 Jan 2021 13:43:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5tmk+1kJ7p3tl2fEpGQCVYC3T+sDFUsmhkAMNVSAuIoaB2DY+I7y+Fpp26Kgj3/iCVDzOgg==
X-Received: by 2002:a63:fe13:: with SMTP id p19mr3763072pgh.119.1610055835113;
        Thu, 07 Jan 2021 13:43:55 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 11sm6959307pgz.22.2021.01.07.13.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 13:43:54 -0800 (PST)
Subject: Re: [PATCH] RDMA/ocrdma: fix use after free in
 ocrdma_dealloc_ucontext_pd()
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        dledford@redhat.com, leon@kernel.org, maxg@mellanox.com,
        galpress@amazon.com, michaelgur@nvidia.com, monis@mellanox.com,
        gustavoars@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201230024653.1516495-1-trix@redhat.com>
 <20210107204102.GA933840@nvidia.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <00c76f8e-4e46-2ab5-772b-ad5db59f8490@redhat.com>
Date:   Thu, 7 Jan 2021 13:43:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210107204102.GA933840@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 1/7/21 12:41 PM, Jason Gunthorpe wrote:
> On Tue, Dec 29, 2020 at 06:46:53PM -0800, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> In ocrdma_dealloc_ucontext_pd() uctx->cntxt_pd is assigned to
>> the variable pd and then after uctx->cntxt_pd is freed, the
>> variable pd is passed to function _ocrdma_dealloc_pd() which
>> dereferences pd directly or through its call to
>> ocrdma_mbx_dealloc_pd().
>>
>> Reorder the free using the variable pd.
>>
>> Fixes: 21a428a019c9 ("RDMA: Handle PD allocations by IB/core")
>> Signed-off-by: Tom Rix <trix@redhat.com>
>>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> Applied to for-rc
>
> Is anyone testing ocrdma? Just doing the pyverbs rdma tests with kasn
> turned on would have instantly caught this, and the change is nearly a
> year old.
>
> Is ocrdma obsolete enough we can delete the driver?

I am not an authority on ocrdma, i am fixing treewide, the problems clang static analysis flags.

Tom

>
> Thanks,
> Jason
>

