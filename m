Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2FA175D8E
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 15:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCBOwH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 09:52:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:57182 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbgCBOwG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Mar 2020 09:52:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 06:52:06 -0800
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="262791876"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.201.53]) ([10.254.201.53])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 02 Mar 2020 06:52:04 -0800
Subject: Re: [PATCH for-rc] IB/hfi1, qib: Ensure RCU is locked when accessing
 list
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
References: <20200225195445.140896.41873.stgit@awfm-01.aw.intel.com>
 <20200228161516.GA26535@ziepe.ca>
 <8c036704-cd70-fd86-4fb7-20621543d1d2@intel.com>
 <20200302132921.GX31668@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <bb4cdcd5-46c9-339a-54a1-5560e14ed9fe@intel.com>
Date:   Mon, 2 Mar 2020 09:52:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302132921.GX31668@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/2/2020 8:29 AM, Jason Gunthorpe wrote:
> On Mon, Mar 02, 2020 at 08:14:52AM -0500, Dennis Dalessandro wrote:
>> On 2/28/2020 11:15 AM, Jason Gunthorpe wrote:
>>> On Tue, Feb 25, 2020 at 02:54:45PM -0500, Dennis Dalessandro wrote:
>>>> The packet handling function, specifically the iteration of the qp list
>>>> for mad packet processing misses locking RCU before running through the
>>>> list. Not only is this incorrect, but the list_for_each_entry_rcu() call
>>>> can not be called with a conditional check for lock dependency. Remedy
>>>> this by invoking the rcu lock and unlock around the critical section.
>>>>
>>>> This brings MAD packet processing in line with what is done for non-MAD
>>>> packets.
>>>>
>>>> Cc: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
>>>> Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
>>>> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
>>>>    drivers/infiniband/hw/hfi1/verbs.c    |    4 +++-
>>>>    drivers/infiniband/hw/qib/qib_verbs.c |    2 ++
>>>>    2 files changed, 5 insertions(+), 1 deletion(-)
>>>
>>> Applied to for-next, thanks
>>>
>>
>> Maybe it should have went to -rc?
> 
> It doesn't even have a fixes line. If you want patches in -rc send
> better commit message. I keep repeating this again and again..
> 
> Jason
> 

Crap, yeah my bad on that. However there really isn't a good fixes line 
for this. It's pretty much just the initial commit of the driver, does 
that really help? It's still just in your WIP branch so is it too late 
to add:

Fixes: 7724105686e7 ("IB/hfi1: add driver files")

Other than a fixes line what else do you need for the commit message? 
Messed up locking is pretty self explanatory I would think.

-Denny


