Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 872BB9CEE0
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 14:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfHZMCB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 08:02:01 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:10074 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfHZMCB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Aug 2019 08:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566820920; x=1598356920;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=PQR2uQrchM0xGPejc5KE/ICDArUkEAoh8XQ3qYzEwU8=;
  b=kf6JhxfvTOBc6cFiZEGExTHAL8ZOucUh1ZSAlr4XcNKvwTZXtfAImkrK
   UHI46jve51dr17UXSCv6zB1w6ufI9LPrwbPuixFpTIGxnzD2J6NRo4v9A
   jr8A6vMbEjUSCeA2dzx7tJs8gjl6pHDoRaTVo5Wlw7tRxHDLZ7idzK6Lt
   w=;
X-IronPort-AV: E=Sophos;i="5.64,433,1559520000"; 
   d="scan'208";a="781477706"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 26 Aug 2019 12:01:56 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id A4F3EA2409;
        Mon, 26 Aug 2019 12:01:54 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 26 Aug 2019 12:01:53 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.191) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 26 Aug 2019 12:01:49 +0000
Subject: Re: [EXT] Re: [PATCH v7 rdma-next 2/7] RDMA/core: Create mmap
 database and cookie helper functions
To:     Michal Kalderon <mkalderon@marvell.com>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <20190820121847.25871-3-michal.kalderon@marvell.com>
 <20190820132125.GC29246@ziepe.ca>
 <MN2PR18MB31821E7411D0E44267F4A256A1AB0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <CH2PR18MB31752BE286837BFDCEE3B17CA1AA0@CH2PR18MB3175.namprd18.prod.outlook.com>
 <20190821165121.GE8653@ziepe.ca>
 <CH2PR18MB3175EDB5640A3987D97A4DC0A1AA0@CH2PR18MB3175.namprd18.prod.outlook.com>
 <20190821173702.GG8653@ziepe.ca>
 <MN2PR18MB318200091BB02266B29125DAA1A10@MN2PR18MB3182.namprd18.prod.outlook.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <8eab82f5-600e-f865-4168-548910cda3b8@amazon.com>
Date:   Mon, 26 Aug 2019 15:01:44 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <MN2PR18MB318200091BB02266B29125DAA1A10@MN2PR18MB3182.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.191]
X-ClientProxiedBy: EX13D24UWB003.ant.amazon.com (10.43.161.222) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 26/08/2019 14:53, Michal Kalderon wrote:
>> From: Jason Gunthorpe <jgg@ziepe.ca>
>> Sent: Wednesday, August 21, 2019 8:37 PM
>>
>> On Wed, Aug 21, 2019 at 05:14:38PM +0000, Michal Kalderon wrote:
>>
>>>>> Jason, I looked into this deeper today, it seems that since the
>>>>> Core is the one handling the reference counting, and eventually
>>>>> Freeing the object that it makes more sense to keep the allocation
>>>>> In core and not in the drivers, since the driver won't be able to
>>>>> free The entry without providing yet an additional callback
>>>>> function to the Core to be called once the reference count reaches
>> zero.
>>>>
>>>> This already added a callback to free the xa_entry, why can't it
>>>> free all the memory too when kref goes to 0?
>>> True, could free it there. I just think we'll have a bit more
>>> duplication code
>>
>> Well, the drivers already needed to allocate something right?
>>
>>> Between the drivers defining a very similar private structure and
>>> adding Allocation calls before each of the rdma_user_mmap_insert
>> function calls.
>>>  And just to make sure I follow,
>>> Do you mean creating the following structure per driver:
>>> Struct <driver>_user_mmap_entry {
>>> 	struct rdma_user_mmap_entry umap_entry;
>>>               ... <private fields> ...
>>> }
>>
>> Yes, that is the general pattern
> Gal, 
> 
> Following this request from Jason I took another look at the obj that originally
> Was stored in efa_user_mmap_entry, this was used only in debug prints. 
> Do you see added value in storing this obj? or do you agree
> We can drop it ? 

It originally had more use-cases, we lost them at some point.
I'm fine with removing it, especially if each driver can add his own private
fields to the entry.
