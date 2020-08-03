Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB7F23A041
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Aug 2020 09:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgHCH1f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Aug 2020 03:27:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45107 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgHCH1e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Aug 2020 03:27:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id z18so29617470wrm.12;
        Mon, 03 Aug 2020 00:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bk+w2IXrWrlLfK9eisE+wLzLklGKFWdlPBnk6Rh8O64=;
        b=ZM96H6azdKk5z1l5Dj4VganJCVH4lFwksN+3jB1EQ54QYwQB0GbBTl24ZN//+MTYw9
         /W+9Gn4pDAAUPh45JLSag7maksH9HShAZkIOGIBlfNuQ2hyZlgW7KW/F1FCbdhqHCAnV
         u2HxCRjCwHY6/GJ01sYXLuZJdFwI8ZK5vRHpDClJpiRikbU/QxfzbPfE8MzLdQ+KSg/B
         r+ocz6GhvsWK5fylI2NbnN40x8e/aE2ikovR2mJK0pZ+UxjmdcEJjt1MKU03SgER1jHE
         CjPjwUqOsnklm5DjXAclUbHFwp4FZfxw0vDyYGYiZa9tvrLo7IIDuvqD5PkBZ3vdIjG4
         DL3Q==
X-Gm-Message-State: AOAM532wEzDw6eGW6KKi75j+DPJzrsQDWcv01PyjhlceOplslfkaGvTX
        BBAd54WCiC37YTyEfRa+MP9zbOUB
X-Google-Smtp-Source: ABdhPJwwT7go5S2QLv9PqWVF1Q/fRxRD0anTRKbY917MFHKIx4ANFqMKdEebkep2UNsdw+uif1yInA==
X-Received: by 2002:adf:ec45:: with SMTP id w5mr14068689wrn.415.1596439652366;
        Mon, 03 Aug 2020 00:27:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:6dac:e394:c378:553e? ([2601:647:4802:9070:6dac:e394:c378:553e])
        by smtp.gmail.com with ESMTPSA id l81sm22161672wmf.4.2020.08.03.00.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 00:27:31 -0700 (PDT)
Subject: Re: [IB/srpt] c804af2c1d: last_state.test.blktests.exit_code.143
To:     Yamin Friedman <yaminf@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Max Gurtovoy <maxg@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org, lkp@lists.01.org
References: <20200802060925.GW23458@shao2-debian>
 <f8ef3284-4646-94d9-7eea-14ac0873b03b@acm.org>
 <ed6002b6-cd0c-55c5-c5a5-9c974a476a95@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0c42aeb4-23a5-b9d5-bc17-ef58a04db8e8@grimberg.me>
Date:   Mon, 3 Aug 2020 00:27:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ed6002b6-cd0c-55c5-c5a5-9c974a476a95@mellanox.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>> Greeting,
>>>
>>> FYI, we noticed the following commit (built with gcc-9):
>>>
>>> commit: c804af2c1d3152c0cf877eeb50d60c2d49ac0cf0 ("IB/srpt: use new 
>>> shared CQ mechanism")
>>> https://git.kernel.org/cgit/linux/kernel/git/rdma/rdma.git for-next
>>>
>>>
>>> in testcase: blktests
>>> with following parameters:
>>>
>>>     test: srp-group1
>>>     ucode: 0x21
>>>
>>>
>>>
>>> on test machine: 4 threads Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz 
>>> with 4G memory
>>>
>>> caused below changes (please refer to attached dmesg/kmsg for entire 
>>> log/backtrace):
>>>
>>>
>>>
>>>
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>>
>>>
>>> user  :notice: [   44.688140] 2020-08-01 16:10:22 ./check srp/001 
>>> srp/002 srp/003 srp/004 srp/005 srp/006 srp/007 srp/008 srp/009 
>>> srp/010 srp/011 srp/012 srp/013 srp/015
>>> user  :notice: [   44.706657] srp/001 (Create and remove LUNs)
>>> user  :notice: [   44.718405] srp/001 (Create and remove 
>>> LUNs)                             [passed]
>>> user  :notice: [   44.729902]     runtime  ...  1.972s
>>> user  :notice: [   99.038748] IPMI BMC is not supported on this 
>>> machine, skip bmc-watchdog setup!
>>> user  :notice: [ 3699.039790] Sat Aug  1 17:11:22 UTC 2020 detected 
>>> soft_timeout
>>> user  :notice: [ 3699.060341] kill 960 /usr/bin/time -v -o 
>>> /tmp/lkp/blktests.time /lkp/lkp/src/tests/blktests
>> Yamin and Max, can you take a look at this? The SRP tests from the
>> blktests repository pass reliably with kernel version v5.7 and before.
>> With label next-20200731 from linux-next however that test triggers the
>> following hang:
> 
> I will look into it.

FWIW, I ran into this as well with nvme-rdma, but it also reproduces
when I revert the shared CQ patch from nvme-rdma. Another data point
is that my tests passes with siw.
