Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6DF2B1100
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 23:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgKLWGg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 17:06:36 -0500
Received: from mga11.intel.com ([192.55.52.93]:58660 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbgKLWGg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Nov 2020 17:06:36 -0500
IronPort-SDR: SOoksNdVTbPM/z+3K7hpo2CwEOJdW8EE9+ijUE4nnucIzVxjyRVRMkj2g3sl72qthxc9xSebWG
 sxNTvqx87DJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="166881308"
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; 
   d="scan'208";a="166881308"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 14:06:35 -0800
IronPort-SDR: T8MDzx4SRkUkS0HKS2NUZARQtv9NXz7cdV3kWhAyinx0gw+1ruzcGvkdWp6rv5q1RcKeqgye4S
 RcWnC5Q4mvFA==
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; 
   d="scan'208";a="542418875"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.205.29]) ([10.254.205.29])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 14:06:33 -0800
Subject: Re: [PATCH for-rc v2] IB/hfi1: Move cached value of mm into handler
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, Jann Horn <jannh@google.com>,
        linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-mm@kvack.org, Jason Gunthorpe <jgg@nvidia.com>
References: <20201112025837.24440.6767.stgit@awfm-01.aw.intel.com>
 <20201112171439.GT3976735@iweiny-DESK2.sc.intel.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <b45c2303-a78e-a3b6-fcd2-371886caf788@cornelisnetworks.com>
Date:   Thu, 12 Nov 2020 17:06:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201112171439.GT3976735@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/12/2020 12:14 PM, Ira Weiny wrote:
> On Wed, Nov 11, 2020 at 09:58:37PM -0500, Dennis Dalessandro wrote:
>> Two earlier bug fixes have created a security problem in the hfi1
>> driver. One fix aimed to solve an issue where current->mm was not valid
>> when closing the hfi1 cdev. It attempted to do this by saving a cached
>> value of the current->mm pointer at file open time. This is a problem if
>> another process with access to the FD calls in via write() or ioctl() to
>> pin pages via the hfi driver. The other fix tried to solve a use after
>> free by taking a reference on the mm. This was just wrong because its
>> possible for a race condition between one process with an mm that opened
>> the cdev if it was accessing via an IOCTL, and another process
>> attempting to close the cdev with a different current->mm.
> 
> Again I'm still not seeing the race here.  It is entirely possible that the fix
> I was trying to do way back was mistaken too...  ;-)  I would just delete the
> last 2 sentences...  and/or reference the commit of those fixes and help
> explain this more.

I was attempting to refer to [1], the email that started all of this.

>>
>> To fix this correctly we move the cached value of the mm into the mmu
>> handler struct for the driver.
> 
> Looking at this closer I don't think you need the mm member of mmu_rb_handler
> any longer.  See below.

We went back and forth on this as well. We thought it better to rely on 
our own pointer vs looking into the notifier to get the mm. Same 
reasoning for doing our own referecne counting. Question is what is the 
preferred way here. Functionally it makes no difference and I'm fine 
going either way.


> NIT: I really think you should follow up with a spelling fix patch...  Sorry
> just got frustrated greping for 'handler' and not finding this!  ;-)
> 
>>   	INIT_WORK(&handlr->del_work, handle_remove);
>>   	INIT_LIST_HEAD(&handlr->del_list);
>>   	INIT_LIST_HEAD(&handlr->lru_list);
>>   	handlr->wq = wq;
>>   
>> -	ret = mmu_notifier_register(&handlr->mn, handlr->mm);
>> +	ret = mmu_notifier_register(&handlr->mn, current->mm);
>>   	if (ret) {
>>   		kfree(handlr);
>>   		return ret;
>>   	}
>>   
>> +	handlr->mm = current->mm;
> 
> Sorry I did not catch this before but do you need to store this pointer?  Is it
> not enough to check the ->mn.mm? ...
> 
> I think that would also make it clear you are relying on the mmget() within the
> mmu_notifier_register()  Because that is the reference you are using rather
> than having another reference here which could potentially be used wrongly in
> the future.

That's the question. It does make sense to do that if we are sticking 
iwth the notifier's reference vs our own explicit one. I'm not 100% sold 
that we should not be doing the ref counting and keeping our own 
pointer. To me we shoudln't be looking inside the notifer struct and 
instead honestly there should probably be an API/helper call to get the 
mm from it. I'm open to either approach.


-Denny
