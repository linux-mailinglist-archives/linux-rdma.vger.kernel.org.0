Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1608225B64B
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 00:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIBWGu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 18:06:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39399 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBWGr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Sep 2020 18:06:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id v15so418352pgh.6
        for <linux-rdma@vger.kernel.org>; Wed, 02 Sep 2020 15:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TGHpHg05lrtDBriniYpM+XAo+E9+8HWsXYDmjr6MPV0=;
        b=FfMOnwMvT9qER8bYwbzHrLEECDa/WfDHRdsTVafEyke5iSi+iwFhlvqupvKPy5cJrK
         oXkP3WantSR7VBITbD1c9v7ykBMkQpccp3b/tByfRwSgEd4PnxB4807Dqr2BuPd+KwIL
         MKPvG364BoVIJiXMACuQ62Th5lH42Ycy0PEOTTA1I65sWeYKgciFAUlGMuq9O+8F9unm
         EIlSIR+dvwJKT8zlaIOgyCgcS7KOuph1QpypBF7aXmJTEnKDBC5sqMKII+ssJ6ejOjcr
         Xd9JjV3NX08Wbni3rKPVK9hxPHzSWy8HAQXobel3UCns4+kcb92Us3b7YNRSznH2G7CP
         01WQ==
X-Gm-Message-State: AOAM533Ppy4iA2pX3H3qRUUQ+rOXLr6bm5YG+Z5ITLThgQ6ckOoM8+1t
        rqE/Q2dOrur6Aaj0k7OwD0M=
X-Google-Smtp-Source: ABdhPJxmo8M4b1ixENhCdn/spqsJKECOT8AgBujNc3po9hZy9FcAF+7iuD96P1VRtBUygzfH1reNHA==
X-Received: by 2002:a17:902:bb8d:: with SMTP id m13mr448461pls.11.1599084406868;
        Wed, 02 Sep 2020 15:06:46 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4025:ed24:701e:8cf3? ([2601:647:4802:9070:4025:ed24:701e:8cf3])
        by smtp.gmail.com with ESMTPSA id r123sm505737pfc.187.2020.09.02.15.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 15:06:46 -0700 (PDT)
Subject: Re: [PATCH v2] IB/isert: fix unaligned immediate-data handling
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Stephen Rust <srust@blockbridge.com>,
        Doug Dumitru <doug@dumitru.com>
References: <20200901030826.140880-1-sagi@grimberg.me>
 <20200902185333.GA1420661@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <780aa197-e377-ea0b-1fdd-8619057003e8@grimberg.me>
Date:   Wed, 2 Sep 2020 15:06:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902185333.GA1420661@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> Currently we allocate rx buffers in a single contiguous buffers for
>> headers (iser and iscsi) and data trailer. This means that most likely
>> the data starting offset is aligned to 76 bytes (size of both headers).
>>
>> This worked fine for years, but at some point this broke, resulting in
>> data corruptions in isert when a command comes with immediate data
>> and the underlying backend device assumes 512 bytes buffer alignment.
>>
>> We assume a hard-requirement for all direct I/O buffers to be 512 bytes
>> aligned. To fix this, we should avoid passing unaligned buffers for I/O.
>>
>> Instead, we allocate our recv buffers with some extra space such that we
>> can have the data portion align to 512 byte boundary. This also means
>> that we cannot reference headers or data using structure but rather
>> accessors (as they may move based on alignment). Also, get rid of the
>> wrong __packed annotation from iser_rx_desc as this has only harmful
>> effects (not aligned to anything).
>>
>> This affects the rx descriptors for iscsi login and data plane.
>>
>> Reported-by: Stephen Rust <srust@blockbridge.com>
>> Tested-by: Doug Dumitru <doug@dumitru.com>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>> Changes from v1:
>> - revised change log
> 
> This still needs to identify when this regression occurred for
> backporting, what is the fixes line?

I don't have the exact bisection, the original report mentioned:
3d75ca0adef4 ("block: introduce multi-page bvec helpers")

But I cannot explain what in that patch caused this.
