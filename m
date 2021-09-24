Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DE8416A1F
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Sep 2021 04:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243907AbhIXCsd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Sep 2021 22:48:33 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:40735 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbhIXCsc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Sep 2021 22:48:32 -0400
Received: by mail-pl1-f177.google.com with SMTP id j15so4015434plh.7;
        Thu, 23 Sep 2021 19:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ez9AZhmbkqgjmKUjZFTyGc3YPzKzZZ/EAaN5J8pQEd4=;
        b=3YYEsB1qAGcjW1MPTBAAGE/skn1YVeb1dIIa0c2CpxDgbUiDiP2joudQHF0cxnP2uX
         dD09QKc8SjBFMEXaGsntzlf7VbNuDiHeIkqzJ5Kpkl3ftK306YJSKrnWt+ntWpvTq5xB
         YnKXIvLjNm+U0+G+zddzqzqWE/cy8WJZZngClQX84MgwDk3hnPCXim1FZpNLa7Gr1Ey6
         iMW8dKDGQIxVC8PCNJ8nvD6ahDOcrkt92N9vMtFI1BFgxXmudz6zeVimZ2/XlFwrBg95
         q2Ks9qXVCL/c8+2bgkEjOyLtmzHjcGr1pNLlyJRSNR59iNeENWu3D8BMueKfU0F99dmv
         zUQA==
X-Gm-Message-State: AOAM53378jNE8Ges7cIvUQuzbrUbxHmJ2eo738UgNim9VoWjRVXKillt
        /4xKXX6M+BYlweKg8tHjVHY=
X-Google-Smtp-Source: ABdhPJyqURa1kHq2oz+fi/L296+n+h2t3Q/HL1nhe6p81CuXq452zeLFzqpeDpb3um15BwbCwaESeg==
X-Received: by 2002:a17:90a:7d11:: with SMTP id g17mr9233637pjl.150.1632451619389;
        Thu, 23 Sep 2021 19:46:59 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:cbba:97c1:e6a:66d5? ([2601:647:4000:d7:cbba:97c1:e6a:66d5])
        by smtp.gmail.com with ESMTPSA id i8sm7009301pfq.22.2021.09.23.19.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 19:46:58 -0700 (PDT)
Message-ID: <9cda0704-0e63-39b2-7874-fd679314eb2b@acm.org>
Date:   Thu, 23 Sep 2021 19:46:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Guo Zhi <qtxuning1999@sjtu.edu.cn>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210922134857.619602-1-qtxuning1999@sjtu.edu.cn>
 <CH0PR01MB71536ECA05AA44C4FAD83502F2A29@CH0PR01MB7153.prod.exchangelabs.com>
 <276b9343-c23d-ac15-bb73-d7b42e7e7f0f@acm.org> <YUwin2cn8X5GGjyY@unreal>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YUwin2cn8X5GGjyY@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/22/21 23:45, Leon Romanovsky wrote:
> Isn't kptr_restrict sysctl is for that?

Hi Leon,

After I sent my email I discovered the following commit: 5ead723a20e0
("lib/vsprintf: no_hash_pointers prints all addresses as unhashed"; v5.12).
I think that commit does what we need?

Thanks,

Bart.


commit 5ead723a20e0447bc7db33dc3070b420e5f80aa6
Author: Timur Tabi <timur@kernel.org>
Date:   Sun Feb 14 10:13:48 2021 -0600

     lib/vsprintf: no_hash_pointers prints all addresses as unhashed

     If the no_hash_pointers command line parameter is set, then
     printk("%p") will print pointers as unhashed, which is useful for
     debugging purposes.  This change applies to any function that uses
     vsprintf, such as print_hex_dump() and seq_buf_printf().

     A large warning message is displayed if this option is enabled.
     Unhashed pointers expose kernel addresses, which can be a security
     risk.

     Also update test_printf to skip the hashed pointer tests if the
     command-line option is set.

     Signed-off-by: Timur Tabi <timur@kernel.org>
     Acked-by: Petr Mladek <pmladek@suse.com>
     Acked-by: Randy Dunlap <rdunlap@infradead.org>
     Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
     Acked-by: Vlastimil Babka <vbabka@suse.cz>
     Acked-by: Marco Elver <elver@google.com>
     Signed-off-by: Petr Mladek <pmladek@suse.com>
     Link: https://lore.kernel.org/r/20210214161348.369023-4-timur@kernel.org
