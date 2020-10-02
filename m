Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFDF281CEF
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 22:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgJBU3d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Oct 2020 16:29:33 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:54969 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgJBU3c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Oct 2020 16:29:32 -0400
Received: by mail-pj1-f52.google.com with SMTP id j19so1641760pjl.4
        for <linux-rdma@vger.kernel.org>; Fri, 02 Oct 2020 13:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IGRa6OA2iv8Tc9y/ynX5HahmE2AZXUkXwDakrJcjRUI=;
        b=ozXQzPBVMskFbK6SzXxWRD35aNTUS4ERcKrIaxGE4fPcs4dOXHJj5qwQJIjGIlkQ0h
         AK61keHmCG22O/Tah//0TLQcUyO+k9Lyg9DzCQ1o79CZLmUOYcw9AVca4JXvGdJKNQNc
         9JtkoT88QtmGlo3Ufxzsxqw2BXbQ9BhkFEOJDAGF+tTG3t4Hu/TfI8a0CAZ+MViiCU01
         I15md5YAHGg4rGrdckFLDyKCWMaXa/2qItmUeKubsVHAr2V9Jea0rp0cCaogkSgji2Mz
         ZKRhBJra094dPiVWRtFeE3moPPM5tX8lUKucG0Pwp3QaAjp2+oQG7XOtJsUu1plAdQew
         FaHg==
X-Gm-Message-State: AOAM533GMvweD+zUe19tYWtVj01X5iAqhezqcqgwv42q3A/muJR+YTLf
        fTnK6DxNRBFynt6L+TGJOYU=
X-Google-Smtp-Source: ABdhPJzjjC5QuL8rB5FE33cLFk/yClCIMTtBwVWjZFRSz8vCIb1PaW8HMEejMWOsRTZP+HR4o1y3Gw==
X-Received: by 2002:a17:90b:3409:: with SMTP id kg9mr4750089pjb.122.1601670572136;
        Fri, 02 Oct 2020 13:29:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:1be2:3dfb:f0b7:cc27? ([2601:647:4802:9070:1be2:3dfb:f0b7:cc27])
        by smtp.gmail.com with ESMTPSA id n128sm2558409pga.37.2020.10.02.13.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 13:29:31 -0700 (PDT)
Subject: Re: reduce iSERT Max IO size
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>
References: <20200922104424.GA18887@chelsio.com>
 <07e53835-8389-3e07-6976-505edbd94f2a@grimberg.me>
 <20201002171007.GA16636@chelsio.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4d0b1a3f-2980-c7ed-ef9a-0ed6a9c87a69@grimberg.me>
Date:   Fri, 2 Oct 2020 13:29:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002171007.GA16636@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> Hi Sagi & Max,
> 
> Any update on this?
> Please change the max IO size to 1MiB(256 pages).

I think that the reason why this was changed to handle the worst case
was in case there are different capabilities on the initiator and the
target with respect to number of pages per MR. There is no handshake
that aligns expectations.

If we revert that it would restore the issue that you reported in the
first place:

--
IB/isert: allocate RW ctxs according to max IO size

Current iSER target code allocates MR pool budget based on queue size.
Since there is no handshake between iSER initiator and target on max IO
size, we'll set the iSER target to support upto 16MiB IO operations and
allocate the correct number of RDMA ctxs according to the factor of MR's
per IO operation. This would guaranty sufficient size of the MR pool for
the required IO queue depth and IO size.

Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
Tested-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
--

> 
> 
> Thanks,
> Krishnam Raju.
> On Wednesday, September 09/23/20, 2020 at 01:57:47 -0700, Sagi Grimberg wrote:
>>
>>> Hi,
>>>
>>> Please reduce the Max IO size to 1MiB(256 pages), at iSER Target.
>>> The PBL memory consumption has increased significantly after increasing
>>> the Max IO size to 16MiB(with commit:317000b926b07c).
>>> Due to the large MR pool, the max no.of iSER connections(On one variant
>>> of Chelsio cards) came down to 9, before it was 250.
>>> NVMe-RDMA target also uses 1MiB max IO size.
>>
>> Max, remind me what was the point to support 16M? Did this resolve
>> an issue?
