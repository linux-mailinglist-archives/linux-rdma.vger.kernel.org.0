Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528DA23F147
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Aug 2020 18:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgHGQdK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Aug 2020 12:33:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38303 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGQdJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Aug 2020 12:33:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id t11so1288772plr.5
        for <linux-rdma@vger.kernel.org>; Fri, 07 Aug 2020 09:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RBteJymRaE0obdwMEax8s9Joqu/u+fWBtLyA69UI4WY=;
        b=kzQ7sow8QDBEoq2EA34N4INKdT1mkHrZedtOFdfSuFU1dcKRNYy7vIrKXV70TLr+3s
         nHEl+7jhZWjlvDq42mTLNaZEY6ffdnDaw9M2AKU8J77Fcf7vkQhCBGzPYlMG4XFikLaw
         J3AoMiKiK0wbHxt1BZx8/1alOpf7wAPwIod0aXhOABzRdDMtKZSUebXwRXvpfeY1Fg1r
         UoY4pNJMXjFI4hTCLmzo1rKeLmZb91UUTRgogP4T4e2DM+tlFsWYfNpOyRhW0saJfuhz
         N47n+RJOnXpnL+q9BjAioE6PZPEs1Inxh50NHt7jCYKkrlxrbLK3/ebhViKt8M50ZarY
         d/mw==
X-Gm-Message-State: AOAM5326bG5mAC3EaHUELlBY0CwCfXOXV/8aNYJ2v9/+2rV8H3wb4dCk
        0/zWB6smFs+ezsRFzH0ydCI=
X-Google-Smtp-Source: ABdhPJx8xB/HHngUtS1VzkBb4z7epeeXtyyS10cEFtflSsX+RtXFZD9lfBu2JJvXDwv9gIuukxDb0Q==
X-Received: by 2002:a17:90a:5206:: with SMTP id v6mr13684170pjh.202.1596817988777;
        Fri, 07 Aug 2020 09:33:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d88d:857c:b14c:519a? ([2601:647:4802:9070:d88d:857c:b14c:519a])
        by smtp.gmail.com with ESMTPSA id j18sm1769722pgn.33.2020.08.07.09.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 09:33:08 -0700 (PDT)
Subject: Re: [PATCH 1/2] IB/isert: use unlikely macro in the fast path
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com, jgg@mellanox.com, dledford@redhat.com,
        oren@mellanox.com
References: <20200805121231.166162-1-maxg@mellanox.com>
 <20200805131644.GJ4432@unreal>
 <3777c9d9-1d36-f8e0-624f-aa633fd517ab@mellanox.com>
 <20200805160601.GL4432@unreal>
 <6cd8d78e-3017-696b-508c-73c3c8b92802@mellanox.com>
 <20200805163738.GM4432@unreal>
 <5364b857-fb44-78ab-85e9-d0e6700ae7c1@grimberg.me>
 <20200807160956.GO4432@unreal>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3cc0e24e-2585-4a82-f065-9d087079fd16@grimberg.me>
Date:   Fri, 7 Aug 2020 09:33:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807160956.GO4432@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>> I reviewed this patch and didn't find any justification for performance
>>> claim, can you please provide us numbers before/after so we will be able
>>> to decide based on reliable data? It will help us to review our drivers
>>> and improve them even more.
>>
>> I don't see any reason to find evidence in justification here. It's a
>> fastpath call, which is unlikely to fail, and these macros are
>> considered common practice.
>>
>> There is no reason to make Max to go and quantify a micro-optimization.
> 
> Unfortunately Max didn't try to see if these likely/unlikely macros
> change something, but I did.
> 
> Simple objdump -d before and after shows that GCC 9 generates same
> ISERT code before and after this patch. It is expected and there are a lot
> of reasons for that, but all of them can be reduced to two:
> * First, GCC is awesome in building profiled code with right predictions for
> standard flows.
> * Second, likely/unlikely is intended to be used when input/output is random
> from GCC point of view.
> 
> So as a summary, there is no optimization here, just misuse of unlikely macro.
> 
> BTW, old GCCs behave the same and kernel full of wrong copy/paste.

if that is the case, then we can drop this patch. Thanks for checking.
