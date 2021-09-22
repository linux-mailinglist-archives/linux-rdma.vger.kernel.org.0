Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD64414F90
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Sep 2021 20:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbhIVSHR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Sep 2021 14:07:17 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:33650 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbhIVSHP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Sep 2021 14:07:15 -0400
Received: by mail-pl1-f181.google.com with SMTP id t4so2363865plo.0;
        Wed, 22 Sep 2021 11:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I5sYw+bSyHIGaSpNI3tdpwWRWpZhz0nrSXfvUCbXn7I=;
        b=ssXy9U40+F9IfrC6fpp5u1P/cJQsmr5M1RK/MO2W7t3ebmS/1ryhi5MjDc9eCs341O
         Kp03CXrFKcNv6kEiu/lzv68+ztkdkgKCBPBTDlOzovKwUwK99Wng3nZvGV9fw8UHdVHF
         7nP+BDPhRPCEkdVJMVd3KVUfcq9KlA1WuY58eJDZuCK80AaxMBWLyOwJCKNyceFNYk+P
         Zf6qWdZrpEoc8imdbrqfY6xan346HnwRVZm/3uQgY23UXLO7I7eek4Xd4beS+rMseKdg
         Dq5CGrgICGYp0rbojUxy1rm6VS1eHAABSFWS6LvKCqFRjJkpgRFBJREr7fZsJ9SNT54c
         CG3A==
X-Gm-Message-State: AOAM530oWMY3BXbQXSMGixYY8YXNnp0mziDOtJlqLG2G6txPApH9pDxD
        Asj9wypxlacnWr/lzQuejtZaUGxk3C0=
X-Google-Smtp-Source: ABdhPJyOaDgTW+/81YD2pq3w8KkpuBCHttPDwqG4QLnT22VlpSS/51FacXz/PHjs/8l/aU7tQwNd/g==
X-Received: by 2002:a17:902:ab16:b0:13a:356c:6a03 with SMTP id ik22-20020a170902ab1600b0013a356c6a03mr167270plb.38.1632333944401;
        Wed, 22 Sep 2021 11:05:44 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:f3b9:da7d:f0c0:c71c])
        by smtp.gmail.com with ESMTPSA id c9sm3050706pfi.212.2021.09.22.11.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 11:05:43 -0700 (PDT)
Subject: Re: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
To:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Guo Zhi <qtxuning1999@sjtu.edu.cn>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210922134857.619602-1-qtxuning1999@sjtu.edu.cn>
 <CH0PR01MB71536ECA05AA44C4FAD83502F2A29@CH0PR01MB7153.prod.exchangelabs.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <276b9343-c23d-ac15-bb73-d7b42e7e7f0f@acm.org>
Date:   Wed, 22 Sep 2021 11:05:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CH0PR01MB71536ECA05AA44C4FAD83502F2A29@CH0PR01MB7153.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/22/21 10:51 AM, Marciniszyn, Mike wrote:
>> Subject: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
>>
>> Pointers should be printed with %p or %px rather than cast to (unsigned long
>> long) and printed with %llx.
>> Change %llx to %p to print the pointer.
>>
>> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> 
> The unsigned long long was originally used to insure the entire accurate pointer as emitted.
> 
> This is to ensure the pointers in prints and event traces match values in stacks and register dumps.
> 
> I think the %p will obfuscate the pointer so %px is correct for our use case.

How about applying Guo's patch and adding a configuration option to the
kernel for disabling pointer hashing for %p and related format specifiers?
Pointer hashing is useful on production systems but not on development
systems.

Thanks,

Bart.

