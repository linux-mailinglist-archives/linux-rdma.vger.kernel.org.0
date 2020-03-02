Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07071175B61
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 14:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgCBNO4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 08:14:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:50236 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727173AbgCBNOz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Mar 2020 08:14:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 05:14:55 -0800
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="262767657"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.201.53]) ([10.254.201.53])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 02 Mar 2020 05:14:54 -0800
Subject: Re: [PATCH for-rc] IB/hfi1, qib: Ensure RCU is locked when accessing
 list
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
References: <20200225195445.140896.41873.stgit@awfm-01.aw.intel.com>
 <20200228161516.GA26535@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <8c036704-cd70-fd86-4fb7-20621543d1d2@intel.com>
Date:   Mon, 2 Mar 2020 08:14:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200228161516.GA26535@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/28/2020 11:15 AM, Jason Gunthorpe wrote:
> On Tue, Feb 25, 2020 at 02:54:45PM -0500, Dennis Dalessandro wrote:
>> The packet handling function, specifically the iteration of the qp list
>> for mad packet processing misses locking RCU before running through the
>> list. Not only is this incorrect, but the list_for_each_entry_rcu() call
>> can not be called with a conditional check for lock dependency. Remedy
>> this by invoking the rcu lock and unlock around the critical section.
>>
>> This brings MAD packet processing in line with what is done for non-MAD
>> packets.
>>
>> Cc: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
>> Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
>> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
>> ---
>>   drivers/infiniband/hw/hfi1/verbs.c    |    4 +++-
>>   drivers/infiniband/hw/qib/qib_verbs.c |    2 ++
>>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> Applied to for-next, thanks
> 

Maybe it should have went to -rc?

-Denny
