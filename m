Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1E21D40D8
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2020 00:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgENWX2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 May 2020 18:23:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38854 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgENWX2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 May 2020 18:23:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id g12so92685wmh.3
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2020 15:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LmMRh5nmpsUoiDKLAYDTZ2ak6LDAbqupzSot/v7rSLM=;
        b=WxHNctuuHv0IbT6POFPdTPlHAtcdewXEvt9Y+bxv4W79w30fpWWbVZ2a9JBL+13aXB
         UOCdoufacNRpDcOq4m86GbUtD7TuMHKBU+YHOfMUUVgm2R4tgEuzyRHqUlIvGOBZ1iXs
         13FWzaivRuT8AEcTuWeEtQ/vEYg4vXD7b1WiHLpQhO94gYmcGJZxApANU//3gC5fXLmc
         nqQ49UzpbPuZ/4aCWnEM2yQ6BvoQX8+sN6AV+NBUYaqJZ4tVTslDaDtXD1BLLMnMpet2
         Dt9ZqyLAf6CZa96996a3njUXKTX4dmBtwoNWqnpwAQfto5EKWdPT3U3KPnFn9GVffvvr
         mUSQ==
X-Gm-Message-State: AOAM533mM0FNhDX3WNkanzUmuai9m8oVC4lF4MXYru+S9Xle8wK42zyE
        +DjYw7bOEXX4YZmK/Rw3X4s2nVa9
X-Google-Smtp-Source: ABdhPJxtaio6gck15N8zYtswrd1HLfy7tTIT7CwRsAS9GUq8qZPYxWpfr1iuo2OoGbGVmr3zndkKNQ==
X-Received: by 2002:a1c:384:: with SMTP id 126mr550040wmd.58.1589495004816;
        Thu, 14 May 2020 15:23:24 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:6545:4064:199d:d22b? ([2601:647:4802:9070:6545:4064:199d:d22b])
        by smtp.gmail.com with ESMTPSA id 89sm603875wrj.37.2020.05.14.15.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 15:23:24 -0700 (PDT)
Subject: Re: [PATCH 0/8 v1] Remove FMR support from RDMA drivers
To:     santosh.shilimkar@oracle.com,
        Aron Silverton <aron.silverton@oracle.com>,
        Max Gurtovoy <maxg@mellanox.com>
Cc:     bvanassche@acm.org, Jason Gunthorpe <jgg@mellanox.com>,
        linux-rdma@vger.kernel.org, dledford@redhat.com, leon@kernel.org,
        israelr@mellanox.com, shlomin@mellanox.com
References: <20200514120305.189738-1-maxg@mellanox.com>
 <905E7E0C-1F87-4552-A7E3-5C49EDBED138@oracle.com>
 <5c48f60b-23b7-da64-6f37-f52de7bb625d@oracle.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <479add48-6fdb-f925-c3b9-699c6aa4cfbf@grimberg.me>
Date:   Thu, 14 May 2020 15:23:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5c48f60b-23b7-da64-6f37-f52de7bb625d@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> +Santosh
>>
>> You probably meant to copy the RDS maintainer? Not sure if this should 
>> have
>> also been sent to netdev@vger.kernel.org.
>>
> Thanks Aron.
> 
>>
>>> On May 14, 2020, at 7:02 AM, Max Gurtovoy <maxg@mellanox.com> wrote:
>>>
>>> This series removes the support for FMR mode to register memory. This 
>>> ancient
>>> mode is unsafe and not maintained/tested in the last few years. It 
>>> also doesn't
>>> have any reasonable advantage over other memory registration methods 
>>> such as
>>> FRWR (that is implemented in all the recent RDMA adapters). This 
>>> series should
>>> be reviewed and approved by the maintainer of the effected drivers and I
>>> suggest to test it as well.
>>>
> I know the security issue has been brought up before and this plan of 
> removal of FMR support was on the cards

Actually, what is unsafe is not necessarily fmrs, but rather the
fmr_pool interface. So Max, you can keep fmr if rds wants it, but
we can get rid of fmr pools.

> but on RDS at least on CX3 we
> got more throughput with FMR vs FRWR. And the reasons are well
> understood as well why its the case.

Looking at the rds code, it seems that rds doesn't do any fast
registration at all, rkeys are long lived and are only invalidated (or
unmaped) when need recycling or when a socket is torn down...

So I'm not clear exactly about the model here, but seems to me
its almost like rds needs something like phys_mr, which is static for
all of its lifetime. It seems that fmrs just create a hassle for
rds, unless I'm missing something...

Having said that, it surely isn't the most secure behavior...
At least its not the global dma rkey...

> Is it possible to keep core support still around so that HCA's which
> supports FMR, ULPs can still can leverage it if they want.
>  From RDS perspective, if the HCA like CX3 doesn't support both modes,
> code prefers FMR vs FRWR and hence the question.

Max can start by removing fmr_pools, fmrs can stay as there is nothing
fundamentally wrong with them. And apparently there are still users.
