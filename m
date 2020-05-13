Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1706B1D03F6
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 02:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgEMAxj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 20:53:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39716 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgEMAxi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 May 2020 20:53:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id u35so3998395pgk.6
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 17:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+qfcsAn3dYG7EniR48Efvnf3eAKB5LyAfhk2cLeOPFU=;
        b=qmQDQvtO4M1qw2JeTSaLaVSmwicbdxpavD8qa6vBfRDYGuf9LgRaDMrDN0A8auGWMV
         Tu9en8YDGImQj3V249TuFgfOAPvEYoNVeHhCJoQ3yAOwidlPzZQHD6clR4IBwdIUaq/G
         8UbtLjahzSAmD6l8qDt6QK37j2or5TPVi+25RxedqWSXSowVWk6aPcq01+Cu14/PrzqG
         KjEpt+SFtwhXnLOmbOw6lBwsdBdzX/H+1j5KTYQ00PL2koMPrTKoxuJw7qlZZo8b6/w9
         TufZIvCv/Wg9A1U4aoJ9J/gZLcD75eo4mgHxjnzy9jXMTaqKZHfTsqx4vzbCOzYONKTD
         1W5g==
X-Gm-Message-State: AGi0PuZcHeExzoC6Uv3nLNCJcLbhSi9j03ex7kMUufJf8qFSLESnlkH0
        rx3FuXtY1v0Bto3e5kzUP2I=
X-Google-Smtp-Source: APiQypLS5f4kEN6CG07ekIrxdXVKAa3n1+ZSmrv8qPDPsMyr50aFEFhoJkhBmO+iMb2s7LUD0RzCCQ==
X-Received: by 2002:a62:6186:: with SMTP id v128mr22965054pfb.185.1589331216605;
        Tue, 12 May 2020 17:53:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:fd29:b320:9d75:d158? ([2601:647:4802:9070:fd29:b320:9d75:d158])
        by smtp.gmail.com with ESMTPSA id 14sm13050427pfy.38.2020.05.12.17.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 17:53:35 -0700 (PDT)
Subject: Re: [PATCH] IB/iser: Remove support for FMR memory registration
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Israel Rukshin <israelr@mellanox.com>,
        linux-rdma@vger.kernel.org, dledford@redhat.com, maxg@mellanox.com,
        sergeygo@mellanox.com, Chuck Lever <chuck.lever@oracle.com>
References: <1589299739-16570-1-git-send-email-israelr@mellanox.com>
 <20200512171633.GO4814@unreal> <5b8b0b51-83e3-06c2-9b99-dec0862c0e5b@acm.org>
 <20200512201303.GA19158@mellanox.com>
 <98a0d1aa-6364-a2f1-37f6-9c69e1efaa0b@acm.org>
 <20200512230625.GB19158@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b9dab6bf-d1b8-40c0-63ba-09eb3f4882f5@grimberg.me>
Date:   Tue, 12 May 2020 17:53:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512230625.GB19158@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>>>>> FMR is not supported on most recent RDMA devices (that use fast memory
>>>>>> registration mechanism). Also, FMR was recently removed from NFS/RDMA
>>>>>> ULP.
>>>>>>
>>>>>> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
>>>>>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>>>>>>   drivers/infiniband/ulp/iser/iscsi_iser.h     |  79 +----------
>>>>>>   drivers/infiniband/ulp/iser/iser_initiator.c |  19 ++-
>>>>>>   drivers/infiniband/ulp/iser/iser_memory.c    | 188 ++-------------------------
>>>>>>   drivers/infiniband/ulp/iser/iser_verbs.c     | 126 +++---------------
>>>>>>   4 files changed, 40 insertions(+), 372 deletions(-)
>>>>>
>>>>> Can we do an extra step and remove FMR from srp too?
>>>>
>>>> Which HCA's will be affected by removing FMR support? Or in other words,
>>>> when did (Mellanox) HCA's start supporting fast memory registration? I'm
>>>> asking this because there is a tradition in the Linux kernel not to
>>>> remove support for old hardware unless it is pretty sure that nobody is
>>>> using that hardware anymore.
>>>
>>> We haven't entirely been following that in RDMA.. More like when
>>> people can't test any more it can go.
>>>
>>> For FMR the support was dropped in newer HW so AFAIK, nobody tests
>>> this and it just stands in the way of making FRWR work properly.
>>>
>>> Do the ULPs stop working or do they just run slower with some regular
>>> MR flow?
>>
>> I'm not sure. I do not have access to RDMA adapters that do not support
>> FRWR.
>>
>> A possible test is to check on websites for used products whether old
>> RDMA adapters are still available. Is the InfiniHost adapter one of the
>> adapters that supports FMR? It seems like that adapter is still easy to
>> find.
> 
> I don't know - AFAIK nobody does any testing on those cards any
> more, and doesn't test the ULPs either.
> 
> I know Leon has pushed to remove the mthca driver in the past.  At one
> point there was a suggestion that drivers that do not support FRWR
> should be dropped, but I don't remember if mthca is the last one or
> not.
> 
> There has been a big push to purge useless old stuff, look at the
> entire arch removals for instance. The large RDMA drivers fall under
> the same logic, IMHO.

I think we should remove this support, if there is a user of this
somewhere he can safely use iscsi. Let alone that iser uses the fmr
pools which leaves rkeys exposed for caching purposes. So I'd much
rather remove it than trying to fix it.
