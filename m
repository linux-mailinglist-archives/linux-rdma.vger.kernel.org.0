Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB9F712B05
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2019 11:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfECJtb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 May 2019 05:49:31 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:62463 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfECJtb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 May 2019 05:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1556876970; x=1588412970;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=RZtFN9FVD02ZdwDmx/8YRP0OlNlryNJBi1GWm5GnauI=;
  b=sxVhV6XKh9HK2nnKHlANkBrtdCnMEUenddhxWsaUnstOv9BnS8Hj5ZcH
   gVrOie0MkxN4veKME+O1+xfc59c5/heyM29mtUDsz5C3Wn/t2zF38OZtm
   fc6jS7HcxQioBmxVqCrsANWkdPgdK5CziRceHJWkfD8AVQwbjKqoszk/Z
   4=;
X-IronPort-AV: E=Sophos;i="5.60,425,1549929600"; 
   d="scan'208";a="797640151"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 May 2019 09:49:29 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x439nOQn127065
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 3 May 2019 09:49:28 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 3 May 2019 09:49:28 +0000
Received: from [10.95.88.5] (10.43.161.192) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 3 May
 2019 09:49:02 +0000
Subject: Re: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Sean Hefty <sean.hefty@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Steve Wise" <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-11-git-send-email-galpress@amazon.com>
 <20190502180218.GA27746@mellanox.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <aa4a148e-8c9e-e30e-26ae-4ae5b9cf7216@amazon.com>
Date:   Fri, 3 May 2019 12:48:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502180218.GA27746@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.192]
X-ClientProxiedBy: EX13D27UWA002.ant.amazon.com (10.43.160.30) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 02-May-19 21:02, Jason Gunthorpe wrote:
> 
> On Wed, May 01, 2019 at 01:48:22PM +0300, Gal Pressman wrote:
>> +static int mmap_entry_insert(struct efa_dev *dev,
>> +			     struct efa_ucontext *ucontext,
>> +			     struct efa_mmap_entry *entry,
>> +			     u8 mmap_flag)
>> +{
>> +	u32 mmap_page;
>> +	int err;
>> +
>> +	err = xa_alloc(&ucontext->mmap_xa, &mmap_page, entry, xa_limit_32b,
>> +		       GFP_KERNEL);
>> +	if (err) {
>> +		ibdev_dbg(&dev->ibdev, "mmap xarray full %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	entry->key = (u64)mmap_page << PAGE_SHIFT;
>> +	set_mmap_flag(&entry->key, mmap_flag);
> 
> This doesn't look like it is in the right order..  There is no locking
> here so the xa_alloc should only be called on a fully intialized entry
> 
> And because there is no locking you also can't really have a
> mmap_obj_entries_remove..
> 
> I think this needs a mutex lock also head across mmap_get to be correct..

What needs to be atomic here is the "mmap_page" allocations, which is guaranteed
by xa_alloc.
A unique page is allocated for each insertion and then a key is generated for
the entry. The key needs the mmap page hence the order, a lock would be
redundant as the sequence does not require it.

There are no concurrent gets (to other operations) as the key will only be
accessed once the insertion is done and the response is returned (at this point
the entry is fully initialized).

There are no concurrent removes as they only happen in error flow which happens
after all the relevant insertions are done (and won't be accessed) or when the
ucontext is being deallocated which cannot happen simultaneously with anything else.
