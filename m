Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE4E2CDEFD
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Dec 2020 20:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgLCTbP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Dec 2020 14:31:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46130 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgLCTbP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Dec 2020 14:31:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id s21so1952414pfu.13
        for <linux-rdma@vger.kernel.org>; Thu, 03 Dec 2020 11:31:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D5VMm/i/V8e5b7AzEJE8Vff7dgyCU/Ac9R5mudD43bA=;
        b=Za2cvfh4PZ44+MizIrweuiofDuy69RRFQGwNi5+2vqogmqoQbdF1lpYss09uswrlAB
         LqpxTtKlnECD7l0xfdEV3mnkb0vhwwc+tm7s5Ysh6JRJnNWQD15mSzj8eOONo3jnhh42
         0OP9IzwGRKaXuJLGF6jmRG3Gg1OrH6BoLMR0TD/KrHUm4XTDEv5lNbQxRcygd8QF47q0
         LWo5NDth0km+1LEa8MyNazDgiDi59qfA9CVe7jWekNc9RIOpQG76jNLeEG++T4h+ecFR
         /po248VF1Vm0wP53XjhWxSJr1VqHdRopWXkNoypilwCicXjCHAb4o6nEUM+oVcq7V+dO
         GlAg==
X-Gm-Message-State: AOAM531Ole9/apFW8xqeE/uhB7ngC+MzW0YotrPcPUGMqzVJWNGQIFUr
        edwpnjr6dHGfXAns4F6vS74=
X-Google-Smtp-Source: ABdhPJwdOTQ3W9UvZFdosN0df8SXkM73/K2SOswPbNgOgXndxLjNd1TsNETwgDErceESHNAfYzIYhA==
X-Received: by 2002:a62:7ed2:0:b029:19d:9461:2b30 with SMTP id z201-20020a627ed20000b029019d94612b30mr514138pfc.14.1607023834624;
        Thu, 03 Dec 2020 11:30:34 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:62c:6234:60f2:89a0? ([2601:647:4802:9070:62c:6234:60f2:89a0])
        by smtp.gmail.com with ESMTPSA id i26sm2617132pfq.148.2020.12.03.11.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 11:30:33 -0800 (PST)
Subject: Re: [PATCH] IB/iser: Remove in_interrupt() usage.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Max Gurtovoy <maxg@nvidia.com>, linux-rdma@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Doug Ledford <dledford@redhat.com>
References: <20201126202720.2304559-1-bigeasy@linutronix.de>
 <20201126205357.GU5487@ziepe.ca>
 <20201127123455.scnqc7xvuwwofdp2@linutronix.de>
 <20201127130314.GE552508@nvidia.com>
 <20201127141432.z5hqxosugi6uu6i7@linutronix.de>
 <20201127143138.GG552508@nvidia.com>
 <20201203135608.f67bmpopealp7xcm@linutronix.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3cf15ad5-4c44-f9ca-4a16-1c680d3e265f@grimberg.me>
Date:   Thu, 3 Dec 2020 11:30:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203135608.f67bmpopealp7xcm@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>> Sure, I would do that but as noted above, it the `frwd_lock' is acquired
>>> so you can't acquire the mutex here.
>>
>> Ok, well, I'm thinking this patch is OK as is. Lets wait for Max and Sagi
> 
> a gentle ping to Max and Sagi in case we still wait for them here.

Hey, I agree with the change, it was a while back, and advisory anyways.

But while touching it, you can remove the now redundant goto out tag
because there is no finalization of the routine now.
