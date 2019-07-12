Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD2A6756D
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 21:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfGLTkJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 15:40:09 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33441 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfGLTkI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 15:40:08 -0400
Received: by mail-ot1-f65.google.com with SMTP id q20so10576428otl.0;
        Fri, 12 Jul 2019 12:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HFpxZgsSIxsazA1/oZg/kAp/zrOjt6UHihSAZrgcZlE=;
        b=Ae4lZh/7hluwXWWoHAwv/UxbvQkZ3mhXQxISte0T+aLmWoht5y5eLA5RRW7CeodQlH
         SI+ZUvEgGUdsKBuwzaFPUYMXK+K7rmRz9c1LhGwaq6iULRHEBcAZwwAQyP1dPq8Dugyo
         QLsWegTKxfYgdbpsNkVn5oL2ozbB4diD7LIsmyfqfrDTZ3TKBUvJC+4bKPRf2ik2VVrs
         iOlPzlNC7k5RfbvDKgiVS47JFHvAVF4m+8ZeQ4bIBaXp0p622qG6wF1tzbAxCjI1CfWJ
         fT7AONZ63kfeOSpDbe/9xYNKj6C9n13U1Rs9WimJpidC8bPQzcOzIjYdjZ2dwmnryGcJ
         fjnQ==
X-Gm-Message-State: APjAAAVIcNowOGg9Aa75mlf+YzTjZHfTZttQbuZ10/xGIv5VKN8OFO26
        VyB1dqY5ta+uqKWgxGtltQ8=
X-Google-Smtp-Source: APXvYqzveAK2peSCSmr6FwEGqa68OjQzEs78W1hOb+X3FP4XQUInf/BMTUhVYhWSQQweFrMPHqspLA==
X-Received: by 2002:a05:6830:120e:: with SMTP id r14mr9497773otp.4.1562960407781;
        Fri, 12 Jul 2019 12:40:07 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 68sm3380373otg.78.2019.07.12.12.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 12:40:07 -0700 (PDT)
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To:     Jinpu Wang <jinpuwang@gmail.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, bvanassche@acm.org,
        jgg@mellanox.com, dledford@redhat.com,
        Roman Pen <r.peniaev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <a8f2f1d2-b5d9-92fc-40c8-090af0487723@grimberg.me>
 <CAHg0HuxZvXH899=M4vC7BTH-bP2J35aTwsGhiGoC8AamD8gOyA@mail.gmail.com>
 <aef765ed-4bb9-2211-05d0-b320cc3ac275@grimberg.me>
 <CAD9gYJKcJ47ogKL4S_KMtxpS1gPHHhqqG7-GTi-2c0cOJ-LJtw@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <11653912-924a-965a-45fe-3abd1ca00053@grimberg.me>
Date:   Fri, 12 Jul 2019 12:40:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAD9gYJKcJ47ogKL4S_KMtxpS1gPHHhqqG7-GTi-2c0cOJ-LJtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> Hi Sagi,
> 
>>>> Another question, from what I understand from the code, the client
>>>> always rdma_writes data on writes (with imm) from a remote pool of
>>>> server buffers dedicated to it. Essentially all writes are immediate (no
>>>> rdma reads ever). How is that different than using send wrs to a set of
>>>> pre-posted recv buffers (like all others are doing)? Is it faster?
>>> At the very beginning of the project we did some measurements and saw,
>>> that it is faster. I'm not sure if this is still true
>>
>> Its not significantly faster (can't imagine why it would be).
>> What could make a difference is probably the fact that you never
>> do rdma reads for I/O writes which might be better. Also perhaps the
>> fact that you normally don't wait for send completions before completing
>> I/O (which is broken), and the fact that you batch recv operations.
> 
> I don't know how do you come to the conclusion we don't wait for send
> completion before completing IO.
> 
> We do chain wr on successfull read request from server, see funtion
> rdma_write_sg,

I was referring to the client side
