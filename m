Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2BA6BBA10
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 18:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390940AbfIWQ7O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 12:59:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43436 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390600AbfIWQ7O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 12:59:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id a2so9466206pfo.10
        for <linux-rdma@vger.kernel.org>; Mon, 23 Sep 2019 09:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OAnMMIT9Vqgb6afR1uuGeTvM3DpRpXBvaKR+J8XYskY=;
        b=GMSrxG6BQBkZVDQS2/wEO0HDK8JVz+7mkuAhhB3tskfIHsCun88550XbnvoGSay0OX
         TxzSTgN4yVfBJl5oBJHWhz8qokBO3R3a4HzUa9SsUE9FpX9VeQK5fdcQx5hk8oUPi8Hg
         9JbCEV9+J+FGY887ZBRyG2UIVCG9eCFpaAE61NQGU58vStYA/YoOf45fJIcCk8M38dw2
         9kBFB18YvC3sGArMo3NSjg6/nX+ntVR2pPJLa70hagGu7i1WZSTV8RKyEXP1l9rCdtQa
         2tFOYZ1iyzQNq+8zerKB1KNNrN5tEk2hYFsfvhVZ1xwtPqKtxpGGaXXYhZ2pA94Ld+Oh
         r47g==
X-Gm-Message-State: APjAAAVM/2aVpKdv/li2JY7VgH2zySi5d+YJ/f9+/aDzqlQdPrZKYpJ0
        5GmAtdvGjlAujgMgqiR3FBs+tFlw
X-Google-Smtp-Source: APXvYqw1iK2Yf9ckdpSomLB7fYFE24BV0dGPIB32Veow9MIokYalhhIkBDZP++oO4AyfTRqPye+09g==
X-Received: by 2002:aa7:96a9:: with SMTP id g9mr616125pfk.16.1569257952775;
        Mon, 23 Sep 2019 09:59:12 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 22sm12565598pfo.131.2019.09.23.09.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 09:59:11 -0700 (PDT)
Subject: Re: [rdma-core patch] srp_daemon: print maximum initiator to target
 IU size
To:     Honggang LI <honli@redhat.com>
Cc:     linux-rdma@vger.kernel.org
References: <20190916013607.9474-1-honli@redhat.com>
 <deb829a3-813e-6b99-c932-ceecc06e09b3@acm.org>
 <20190918005508.GA8676@dhcp-128-227.nay.redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <46dfd841-f7d3-52fb-6737-253ce95108c2@acm.org>
Date:   Mon, 23 Sep 2019 09:59:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918005508.GA8676@dhcp-128-227.nay.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/17/19 5:55 PM, Honggang LI wrote:
> On Tue, Sep 17, 2019 at 10:19:37AM -0700, Bart Van Assche wrote:
>> On 9/15/19 6:36 PM, Honggang LI wrote:
>>> From: Honggang Li <honli@redhat.com>
>>>
>>> The 'Send Message Size' field of IOControllerProfile attributes
>>> contains the maximum initiator to target IU size.
>>>
>>> When there is something wrong with SRP login to a third party
>>> SRP target, whose ib_srpt parameters can't be collected with
>>> ordinary method, dump the 'Send Message Size' may help us to
>>> diagnose the problem.
>>>
>>> Signed-off-by: Honggang Li <honli@redhat.com>
>>> ---
>>>    srp_daemon/srp_daemon.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/srp_daemon/srp_daemon.c b/srp_daemon/srp_daemon.c
>>> index 337b21c7..90533c77 100644
>>> --- a/srp_daemon/srp_daemon.c
>>> +++ b/srp_daemon/srp_daemon.c
>>> @@ -1022,6 +1022,8 @@ static int do_port(struct resources *res, uint16_t pkey, uint16_t dlid,
>>>    			pr_human("        vendor ID: %06x\n", be32toh(target->ioc_prof.vendor_id) >> 8);
>>>    			pr_human("        device ID: %06x\n", be32toh(target->ioc_prof.device_id));
>>>    			pr_human("        IO class : %04hx\n", be16toh(target->ioc_prof.io_class));
>>> +			pr_human("        Maximum initiator to target IU size: %d\n",
>>> +				 be32toh(target->ioc_prof.send_size));
>>>    			pr_human("        ID:        %s\n", target->ioc_prof.id);
>>>    			pr_human("        service entries: %d\n", target->ioc_prof.service_entries);
>>
>> How about using the terminology from the InfiniBand Architecture
> 
> As this is srp specific, so I suggest to use the terminology from
> srp specification 'srp2r06'.
> 
> Table B.7 — IOControllerProfile attributes for SRP target ports
> ----------------------------------------------------------------
> | Field            | SRP requirement                           |
> ----------------------------------------------------------------
> |(skip many lines).....                                        |
> ----------------------------------------------------------------
> |Send Message Size |MAXIMUM INITIATOR TO TARGET IU LENGTH      |
> ----------------------------------------------------------------
> 
>> Specification? This is what I found in release 1.3, table 306:
>>
>> "Maximum size of Send Messages in bytes"

I don't have a strong opinion about which description to use. The latter 
may be easier to comprehend though. I'm not sure whether every SRP user 
knows what an SRP "IU" is ...

Bart.
