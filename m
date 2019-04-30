Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBBC1F5D6
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 13:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfD3Li6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 07:38:58 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:16265 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfD3Li6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Apr 2019 07:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1556624337; x=1588160337;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=WTj2K2Lf8HXesK2UL/c1IwQw+mXAEYW4/eKoTUbulag=;
  b=C/VEd9431AVhdnr4EVkzeUqf+em9Kl9M3Fdmswb19GDKZrLsNQkXPst3
   q1NIvsdLO3oirpfudIex8/J6ZVZEGX0IUgR5PNGn6Exqrk6HjPfxkkk3o
   DArXRoWhonpZv6RqIxViNX9D5WPU/OqMsz59Wqydv1/rhylVcM5E0kpjk
   4=;
X-IronPort-AV: E=Sophos;i="5.60,413,1549929600"; 
   d="scan'208";a="400247935"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Apr 2019 11:38:44 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x3UBcdJH052108
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 30 Apr 2019 11:38:43 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Apr 2019 11:38:43 +0000
Received: from [10.95.87.116] (10.43.162.83) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 30 Apr
 2019 11:38:36 +0000
Subject: Re: [PATCH for-next] RDMA/uverbs: Initialize udata struct on destroy
 flows
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <1556613999-14823-1-git-send-email-galpress@amazon.com>
 <20190430111814.GE6705@mtr-leonro.mtl.com>
 <45a1912f-b811-ad4b-cf66-ac02edb4b811@amazon.com>
 <5dbebe7f-a55e-043f-ccc1-30f12096a36b@intel.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <dc45f88e-16fe-bd9d-f45a-584fd83ab773@amazon.com>
Date:   Tue, 30 Apr 2019 14:38:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5dbebe7f-a55e-043f-ccc1-30f12096a36b@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.83]
X-ClientProxiedBy: EX13D17UWC003.ant.amazon.com (10.43.162.206) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 30-Apr-19 14:35, Dennis Dalessandro wrote:
> On 4/30/2019 7:27 AM, Gal Pressman wrote:
>> On 30-Apr-19 14:18, Leon Romanovsky wrote:
>>> On Tue, Apr 30, 2019 at 11:46:39AM +0300, Gal Pressman wrote:
>>>> Cited commit introduced the udata parameter to different destroy flows
>>>> but the uapi method definition does not have udata (i.e has_udata flag
>>>> is not set). As a result, an uninitialized udata struct is being passed
>>>> down to the driver callbacks.
>>>>
>>>> Fix that by clearing the driver udata even in cases where has_udata flag
>>>> is not set.
>>>>
>>>> Fixes: c4367a26357b ("IB: Pass uverbs_attr_bundle down ib_x destroy path")
>>>> Cc: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
>>>> Co-developed-by: Jason Gunthorpe <jgg@ziepe.ca>
>>>
>>> What is wrong with Signed-off-by that caused you to add new tag?
>>
>> Jason is the one that originally wrote and sent the code, this tag seems
>> appropriate.
>> Obviously I don't mind removing it, it's there to give him credit..
> 
> Did you find documentation for using that tag or did you just make it up? I
> think Signed-off-by is what you want here.

https://www.kernel.org/doc/html/v5.0/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
