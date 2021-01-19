Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64732FC236
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 22:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbhASSpV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 13:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbhASSJP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jan 2021 13:09:15 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F17C061573;
        Tue, 19 Jan 2021 10:08:35 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id g3so10445330ejb.6;
        Tue, 19 Jan 2021 10:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QUIebfX8U940ENGHUTnKwYQ6vp3a2I5vmh0z1iwQG5o=;
        b=b+NjSi8PtAmQc+ZlPq6VTlb/cUTGixdwmfMxQjrNKadr6m31k0f694vi7xBuV+CTTz
         3gq5WRCHjKUdJQISQdXvV4mrdV1CpNlVKGkQj1JtGnOqKpWUrVuTSq86IutQQSDOLSOc
         2BG/LjX6OEOR74D9Eso8Z/afSjVVF9zorwjjGbIugB6V7PeuZpT7GIDLTkTCXT9JX+vA
         ep3Wsf44MjzhookyrMbIECdDhIzQgeQPfplMRVWlKBvuwFF0Ha/dMcPN57aTVa03yfPW
         iPnkNE9h9HWDEHpCOBypmyJz0KOnLWV7ADgOzdAZFl5u3WvR/ptP1TJbnU1gdEx2g3kw
         clIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QUIebfX8U940ENGHUTnKwYQ6vp3a2I5vmh0z1iwQG5o=;
        b=m8itd4a4G1LySpPDN7lIht4nLtPeDXCx1wf5ec5nJdPKliyXN9fvQTCxwyUINYgYlb
         NUPv+VJg7oEFP8sJutKuyp7bWI3WHmzIkkpf96DqRlDk+N+LcTuzRHLsU8A2InrIeJHx
         ZBNFO1tqA6fYg8lJuE9lGCAluhWDk5ycZBk7clfG+e4KNkBREP35/WAbgmz6XAeg18Uz
         S0SCLRANussjSFc6RZemZiIQTcDhqYnybrgaP9YIJwgOWq0dADNCGwyUjVZ7U+jsFS1a
         ixO1Pdn5pZKW2X/g5PMQiu45WXaVoK8NLFiyX6mERJGjs3/6rWnAiZa1OdpX9aN3bq+7
         vi/w==
X-Gm-Message-State: AOAM532r1tYgFOgr//NZ27rrFcCdQgN97nm1AfP/yNHFcTyssiAlc2ej
        lNRAxzSA8Hrv7oacTf4avhg=
X-Google-Smtp-Source: ABdhPJxbPkdPQezctxiD6SZFvmQnmR1KZV4He8vTQy9fMToLOFpgvarG+gK/zrilW2FVZgdv7Grt0g==
X-Received: by 2002:a17:906:f98f:: with SMTP id li15mr3724800ejb.123.1611079713890;
        Tue, 19 Jan 2021 10:08:33 -0800 (PST)
Received: from [192.168.178.40] (ipbcc06d06.dynamic.kabel-deutschland.de. [188.192.109.6])
        by smtp.gmail.com with ESMTPSA id b101sm4741633edf.49.2021.01.19.10.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 10:08:33 -0800 (PST)
Subject: Re: [PATCH v6 1/4] sgl_alloc_order: remove 4 GiB limit, sgl_free()
 warning
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Douglas Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, ddiss@suse.de, bvanassche@acm.org
References: <20210118163006.61659-1-dgilbert@interlog.com>
 <20210118163006.61659-2-dgilbert@interlog.com>
 <20210118182854.GJ4605@ziepe.ca>
 <59707b66-0b6c-b397-82fe-5ad6a6f99ba1@interlog.com>
 <20210118202431.GO4605@ziepe.ca>
 <7f443666-b210-6f99-7b50-6c26d87fa7ca@gmail.com>
 <20210118234818.GP4605@ziepe.ca>
 <6faed1e2-13bc-68ba-7726-91924cf21b66@gmail.com>
 <20210119180327.GX4605@ziepe.ca>
From:   Bodo Stroesser <bostroesser@gmail.com>
Message-ID: <7ba5bfdf-6bc2-eddb-4c26-133c1bc08a33@gmail.com>
Date:   Tue, 19 Jan 2021 19:08:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119180327.GX4605@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 19.01.21 19:03, Jason Gunthorpe wrote:
> On Tue, Jan 19, 2021 at 06:24:49PM +0100, Bodo Stroesser wrote:
>>
>> I had a second look into math.h, but I don't find any reason why round_up
>> could overflow. Can you give a hint please?
> 
> #define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
>                                                      ^^^^^
> 
> That +1 can overflow

But that would be a unsigned long long overflow. I considered this to
not be relevant.

> 
> It looks like it would not be so bad to implement some
> check_round_up_overflow() if people prefer
> 
> Jason
> 
