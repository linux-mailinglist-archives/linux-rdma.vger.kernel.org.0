Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C6E31A570
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 20:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbhBLTbd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 14:31:33 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:43621 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbhBLTb0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Feb 2021 14:31:26 -0500
Received: by mail-pg1-f178.google.com with SMTP id n10so304906pgl.10
        for <linux-rdma@vger.kernel.org>; Fri, 12 Feb 2021 11:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q39EKNM+QgLPy43GbyIaziJOQjbWdvRFvxeeSIvZiWo=;
        b=Cm9T3Z6tviazDo/16ZD8p8Yb9PsT0NPN6qif9PKR7l5i7u9xAf8XlGa5XslcY81Qc7
         nKLKl9GxWMfwydB8no42V/yTpEuIuL48AyxGLtLMmHOwWQWHfq3Iq9Ss/WqrGHDgLCz5
         +qUvJU/E/MGHXz9J1d9TKGYQp6hHFjB7BEdY0od29NWH3/CyyW0u2sqafJKPIoWqV1zd
         l/XXHu+IJnN9M3ops+1uzR+L7l3vPMMBNQL8iYxthQT7iicdezqXdBVQ6RrwLAoAQmGc
         JLtGraVWK4V9gG4xEipwaCpb+vUBh9NGeFvbEOrlbDabiy8HPtrCrBz5k4AdKr8AoH1i
         +IUg==
X-Gm-Message-State: AOAM531NLmyCkCTQ5m/NETquO1K9GZklyflbxcYn/pfNRTJN+eoIh9LV
        PeTY5mDZHgBuRyVNEF17G8+9WW6I1e0=
X-Google-Smtp-Source: ABdhPJwYkdmDgHUOpuTYK7GgLL/wrQmbnXvz8HwWAJX2SJ60wDcaX4MaWfpHGae/ELeOOtT5BXvnbA==
X-Received: by 2002:a62:7bd2:0:b029:1e5:3aed:34c with SMTP id w201-20020a627bd20000b02901e53aed034cmr4116945pfc.71.1613158245191;
        Fri, 12 Feb 2021 11:30:45 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:1506:bcba:266a:29b2? ([2601:647:4000:d7:1506:bcba:266a:29b2])
        by smtp.gmail.com with ESMTPSA id ck10sm8789579pjb.5.2021.02.12.11.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 11:30:44 -0800 (PST)
Subject: Re: [PATCH] RDMA/srp: Fix support for unpopulated and unbalanced NUMA
 nodes
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>,
        g@nvidia.com
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        bart.vanassche@wdc.com
References: <9cb4d9d3-30ad-2276-7eff-e85f7ddfb411@suse.com>
 <20210212172122.GA1722574@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <569cb3cd-45d9-e5c8-33ac-9e8b167da18a@acm.org>
Date:   Fri, 12 Feb 2021 11:30:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210212172122.GA1722574@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/12/21 9:21 AM, Jason Gunthorpe wrote:
> On Fri, Feb 05, 2021 at 09:14:28AM +0100, Nicolas Morey-Chaisemartin wrote:
>> The current code computes a number of channels per SRP target and spreads
>> them equally across all online NUMA nodes.
>> Each channel is then assigned a CPU within this node.
>>
>> In the case of unbalanced, or even unpopulated nodes, some channels
>> do not get a CPU associated and thus do not get connected.
>> This causes the SRP connection to fail.
>>
>> This patch solves the issue by rewriting channel computation and allocation:
>> - Drop channel to node/CPU association as it had
>>   no real effect on locality but added unnecessary complexity.
>> - Tweak the number of channels allocated to reduce CPU contention when possible:
>>   - Up to one channel per CPU (instead of up to 4 by node)
>>   - At least 4 channels per node, unless ch_count module parameter is used.
>>
>> Signed-off-by: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
>> ---
>>  drivers/infiniband/ulp/srp/ib_srp.c | 110 ++++++++++++----------------
>>  1 file changed, 45 insertions(+), 65 deletions(-)
> 
> Bart?

Oops, this patch had escaped from my attention.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
