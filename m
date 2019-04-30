Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1F15F8B5
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 14:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfD3MWN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 08:22:13 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:56579 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfD3MWN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Apr 2019 08:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1556626932; x=1588162932;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=tiPS0oj/MVP0+pKD0C6cuBqpWvaLtizT8ludLikx/aE=;
  b=qKtdtAvgk5D+0it5GR4lze/S2fl688xIpcDd7IXuwJ8J78Qa/rQT8Nwf
   YinMsbGLrTjxZ8/WwiusG4kp5tqJa6NFyFf1AfDJEXlGbvgWc18SecQqo
   GL29GXgKc4zZ1u4wAxagF6Ep7aoTEqclCCLJd2ct22S7+u82CO0qFH+MR
   M=;
X-IronPort-AV: E=Sophos;i="5.60,413,1549929600"; 
   d="scan'208";a="797087899"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Apr 2019 12:22:08 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x3UCM2tu062775
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 30 Apr 2019 12:22:08 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Apr 2019 12:22:07 +0000
Received: from [10.95.87.116] (10.43.162.83) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 30 Apr
 2019 12:22:03 +0000
Subject: Re: [PATCH for-next] RDMA/uverbs: Initialize udata struct on destroy
 flows
To:     Leon Romanovsky <leon@kernel.org>
CC:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        <linux-rdma@vger.kernel.org>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <1556613999-14823-1-git-send-email-galpress@amazon.com>
 <20190430111814.GE6705@mtr-leonro.mtl.com>
 <45a1912f-b811-ad4b-cf66-ac02edb4b811@amazon.com>
 <5dbebe7f-a55e-043f-ccc1-30f12096a36b@intel.com>
 <dc45f88e-16fe-bd9d-f45a-584fd83ab773@amazon.com>
 <20190430120732.GG6705@mtr-leonro.mtl.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <d91f85f2-ee3e-d0a6-7e10-4689ce87f938@amazon.com>
Date:   Tue, 30 Apr 2019 15:21:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430120732.GG6705@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.83]
X-ClientProxiedBy: EX13D19UWA001.ant.amazon.com (10.43.160.169) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 30-Apr-19 15:07, Leon Romanovsky wrote:
> On Tue, Apr 30, 2019 at 02:38:30PM +0300, Gal Pressman wrote:
>> On 30-Apr-19 14:35, Dennis Dalessandro wrote:
>>> On 4/30/2019 7:27 AM, Gal Pressman wrote:
>>>> On 30-Apr-19 14:18, Leon Romanovsky wrote:
>>>>> On Tue, Apr 30, 2019 at 11:46:39AM +0300, Gal Pressman wrote:
>>>>>> Cited commit introduced the udata parameter to different destroy flows
>>>>>> but the uapi method definition does not have udata (i.e has_udata flag
>>>>>> is not set). As a result, an uninitialized udata struct is being passed
>>>>>> down to the driver callbacks.
>>>>>>
>>>>>> Fix that by clearing the driver udata even in cases where has_udata flag
>>>>>> is not set.
>>>>>>
>>>>>> Fixes: c4367a26357b ("IB: Pass uverbs_attr_bundle down ib_x destroy path")
>>>>>> Cc: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
>>>>>> Co-developed-by: Jason Gunthorpe <jgg@ziepe.ca>
>>>>>
>>>>> What is wrong with Signed-off-by that caused you to add new tag?
>>>>
>>>> Jason is the one that originally wrote and sent the code, this tag seems
>>>> appropriate.
>>>> Obviously I don't mind removing it, it's there to give him credit..
>>>
>>> Did you find documentation for using that tag or did you just make it up? I
>>> think Signed-off-by is what you want here.
>>
>> https://www.kernel.org/doc/html/v5.0/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
> 
> I see no benefit of this new tag over SOB, especially for the patch which
> has 100% code of that Co-* author.

I disagree, and probably more people as well as the tag was introduced to the
kernel in addition to the SOB.
Either way, I have no dog in this fight, the tag can be removed.

Jason, let me know if I should resubmit without it.
