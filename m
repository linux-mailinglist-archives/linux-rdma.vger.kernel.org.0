Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78A176FEA3
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 13:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfGVLVa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 07:21:30 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:3211 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbfGVLVa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 07:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1563794489; x=1595330489;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=UamyUVt1CSu9HK+BA6IiVr3enzA4Y8E7gUujArdb7j0=;
  b=bbCYobRUx6MdzHyUggH+OkfmENpt9Cahm0Z9rSotcjmlogjhFo5JsZQk
   L1ahnMjl0J18IGEmK5CpOfYKeSgtfgXiR/NnnuHeb3t6v85som1GZDvo8
   rujTNNwXllYHZOJVp73mPABYnYunwSgcbWYI9as1bX9RD1UPiHCoPVk3s
   o=;
X-IronPort-AV: E=Sophos;i="5.64,294,1559520000"; 
   d="scan'208";a="686943742"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 22 Jul 2019 11:21:28 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id F0718A2750;
        Mon, 22 Jul 2019 11:21:27 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 22 Jul 2019 11:21:26 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.85) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 22 Jul 2019 11:21:23 +0000
Subject: Re: rdma-core device memory leak
To:     Leon Romanovsky <leon@kernel.org>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>
References: <9c250b8c-df24-7491-deda-ede0b72fd689@amazon.com>
 <20190722091523.GC5125@mtr-leonro.mtl.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <394ed0b6-9f77-d951-5315-fe496d72f9d1@amazon.com>
Date:   Mon, 22 Jul 2019 14:21:18 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722091523.GC5125@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.85]
X-ClientProxiedBy: EX13D11UWB004.ant.amazon.com (10.43.161.90) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 22/07/2019 12:15, Leon Romanovsky wrote:
> On Mon, Jul 22, 2019 at 11:10:51AM +0300, Gal Pressman wrote:
>> Hi all,
>>
>> I'm seeing memory leaks when running tests with valgrind memcheck tool [1]. It
>> seems like it's caused due to verbs_device refcount never reaching zero.
>>
>> Last related commit is 8125fdeb69bb ("verbs: Avoid ibv_device memory leak"),
>> which seems like it should prevent this issue - but I'm not sure it covers all
>> cases.
>>
>> When calling ibv_get_device_list, try_driver will eventually get called and set
>> the device refcount to one. The refcount for each device will be increased when
>> iterating the devices list, and on each verbs_init_context call.
>>
>> In the free flow, the refcount is decreased on verbs_uninit_context and when
>> iterating the devices list - which brings the refcount back to one, as initially
>> set by try_driver (hence uninit_device isn't called).
>>
>> Is there a reason for initializing refcount to one instead of zero? According to
>> the cited commit the reference count should be decreased when the device no
>> longer exists in the sysfs, but the device isn't necessarily removed from the sysfs.
> 
> Such scheme allows us to avoid rdma-core provider reinitialization every
> time application "plays" with ibv_get_device_list(). Anyway, the rdma-core
> library (libibverbs) won't be unloaded till dclose() is called and glibc
> reference count won't reach zero, so we don't need to release provider
> till that point of time too.

So you consider these valgrind errors false alarms?
