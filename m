Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCD8113E51
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2019 09:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfEEHyJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 May 2019 03:54:09 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:26769 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfEEHyJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 May 2019 03:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1557042848; x=1588578848;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=vqPOXsZaKKebq9THmT989nSaZ9oYS+8QMOCxFBogXd0=;
  b=vFR2JCye3GKTfL8C66KF81Qf/r7B50hoXyb9x5ZELKz0C+8Gja/u+2mL
   0u2aU1143W3fj9eQoY9AvwSRD4XsFlQREokylvSFpd7aifbMJnsB0H+6W
   Sd5jLbKjg8bmIfTQ7GdTSBUXy/3z+G09Vwd4PmWEgWjFSuzCuyPZZbYff
   o=;
X-IronPort-AV: E=Sophos;i="5.60,433,1549929600"; 
   d="scan'208";a="802916341"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 May 2019 07:54:06 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x457rxP5043440
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 5 May 2019 07:54:02 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 5 May 2019 07:54:00 +0000
Received: from [10.218.62.21] (10.43.162.53) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 5 May
 2019 07:53:53 +0000
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
 <aa4a148e-8c9e-e30e-26ae-4ae5b9cf7216@amazon.com>
 <20190503121821.GA13315@mellanox.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <d78b6b83-7fe7-0592-79e5-368e000b37a9@amazon.com>
Date:   Sun, 5 May 2019 10:53:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503121821.GA13315@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.53]
X-ClientProxiedBy: EX13D16UWB002.ant.amazon.com (10.43.161.234) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 03-May-19 15:18, Jason Gunthorpe wrote:
> On Fri, May 03, 2019 at 12:48:44PM +0300, Gal Pressman wrote:
>> On 02-May-19 21:02, Jason Gunthorpe wrote:
>>>
>>> On Wed, May 01, 2019 at 01:48:22PM +0300, Gal Pressman wrote:
>>>> +static int mmap_entry_insert(struct efa_dev *dev,
>>>> +			     struct efa_ucontext *ucontext,
>>>> +			     struct efa_mmap_entry *entry,
>>>> +			     u8 mmap_flag)
>>>> +{
>>>> +	u32 mmap_page;
>>>> +	int err;
>>>> +
>>>> +	err = xa_alloc(&ucontext->mmap_xa, &mmap_page, entry, xa_limit_32b,
>>>> +		       GFP_KERNEL);
>>>> +	if (err) {
>>>> +		ibdev_dbg(&dev->ibdev, "mmap xarray full %d\n", err);
>>>> +		return err;
>>>> +	}
>>>> +
>>>> +	entry->key = (u64)mmap_page << PAGE_SHIFT;
>>>> +	set_mmap_flag(&entry->key, mmap_flag);
>>>
>>> This doesn't look like it is in the right order..  There is no locking
>>> here so the xa_alloc should only be called on a fully intialized entry
>>>
>>> And because there is no locking you also can't really have a
>>> mmap_obj_entries_remove..
>>>
>>> I think this needs a mutex lock also head across mmap_get to be correct..
>>
>> What needs to be atomic here is the "mmap_page" allocations, which is guaranteed
>> by xa_alloc.
>> A unique page is allocated for each insertion and then a key is generated for
>> the entry. The key needs the mmap page hence the order, a lock would be
>> redundant as the sequence does not require it.
>>
>> There are no concurrent gets (to other operations) as the key will only be
>> accessed once the insertion is done and the response is returned (at this point
>> the entry is fully initialized).
> 
> nonsense, a hostile userspace can call parallel mmap to trigger races
> 
>> There are no concurrent removes as they only happen in error flow which happens
>> after all the relevant insertions are done (and won't be accessed) or when the
>> ucontext is being deallocated which cannot happen simultaneously with anything else.
> 
> Nope, also can be done in parallel with a hostile userspace

Thanks, will add a lock.
