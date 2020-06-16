Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532CC1FBD42
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 19:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbgFPRox (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 13:44:53 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:29671 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgFPRox (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jun 2020 13:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592329492; x=1623865492;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Jk2QhAZ814TFcqg7SGj3/dFYmDnMs6ijM+ZPsFGztlE=;
  b=rx9ZkxzsyaGEzrCAsKszanbVPR298U8AQBXPQrDutwHxf1wrpraAGMPs
   M8OpONVCYT1O1Z1LD1uAYs4C4bfpa4Bm6X1Ecv8kTC4Xvv3K4IKdBt+s1
   no/fRZ+O86+d13tGQP0owVouZt13IOSOxieanCVUdisnM2ikCURp2W76f
   0=;
IronPort-SDR: whklrC+nDObsrzOFSdWoxNv0cObjz5Kl5AwfnOvjz3HIFsKty0EZKLbu0Y8IPOk8pyLttfSrmJ
 vw6Iw3cg8y0g==
X-IronPort-AV: E=Sophos;i="5.73,518,1583193600"; 
   d="scan'208";a="37975549"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 16 Jun 2020 17:44:51 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id C2CACC0716;
        Tue, 16 Jun 2020 17:44:49 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Jun 2020 17:44:48 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.253) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Jun 2020 17:44:44 +0000
Subject: Re: [PATCH for-next] RDMA/efa: Move provider specific attributes to
 ucontext allocation response
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        "Firas JahJah" <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20200615075920.58936-1-galpress@amazon.com>
 <20200616063045.GC2141420@unreal>
 <cba7128b-c427-bc26-5f43-69a22463debc@amazon.com>
 <20200616093835.GB2383158@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <f6773480-5954-b58b-21f0-f5ee4ec7238b@amazon.com>
Date:   Tue, 16 Jun 2020 20:44:37 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200616093835.GB2383158@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.253]
X-ClientProxiedBy: EX13P01UWB002.ant.amazon.com (10.43.161.191) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 16/06/2020 12:38, Leon Romanovsky wrote:
> On Tue, Jun 16, 2020 at 11:53:11AM +0300, Gal Pressman wrote:
>> On 16/06/2020 9:30, Leon Romanovsky wrote:
>>> On Mon, Jun 15, 2020 at 10:59:20AM +0300, Gal Pressman wrote:
>>>> Provider specific attributes which are necessary for the userspace
>>>> functionality should be part of the alloc ucontext response, not query
>>>> device. This way a userspace provider could work without issuing a query
>>>> device verb call. However, the fields will remain in the query device
>>>> ABI in order to maintain backwards compatibility.
>>>
>>> I don't really understand why "should be ..."? Device properties exposed
>>> here are per-device and will be equal to all ucontexts, so instead of
>>> doing one very fast system call, you are "punishing" every ucontext
>>> call.
>>
>> I talked about it with Jason in the past, the query device verb is intended to
>> follow the IBA verb, alloc ucontext should return driver specific data that's
>> required to operate the user space provider.
>> A query device call should not be mandatory to load the provider.
> 
> Why? query_device is declared as mandatory verb for any provider, so
> anyway all in-the-tree RDMA drivers will have such verb.

I don't think the concern here is if the verb exists or not, my understanding is
that query device should be used for IBA query device attributes, not other
provider specific stuff.
Jason, want to chime in with your thoughts?

>> Whether it's done through query device/ucontext response, both happen for each
>> new context call. With this patch, we gather all needed data in one system call
>> instead of two.
> 
> Is it important in control path to have one call?

Not a huge difference, better one than two though.

>>> What is wrong with calling one query_device before allocating any
>>> ucontext? What are you trying to achieve and what will it give?
>>
>> How can you call query device without allocating a context?
> 
> Forget about my comment above, it was my over-thinking.
> 
> I had in mind some scheme that first ucontext will cache the all device
> related data and share it with other ucontexts.
> 
> Thanks
> 
