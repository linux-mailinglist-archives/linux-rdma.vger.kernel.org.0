Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3237C13B02A
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2020 18:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgANRAh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jan 2020 12:00:37 -0500
Received: from mga07.intel.com ([134.134.136.100]:62403 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgANRAh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Jan 2020 12:00:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 09:00:36 -0800
X-IronPort-AV: E=Sophos;i="5.70,433,1574150400"; 
   d="scan'208";a="213395849"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.201.179]) ([10.254.201.179])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Jan 2020 09:00:34 -0800
Subject: Re: [PATCH 1/3] infiniband: hw: hfi1: verbs.c: Use built-in RCU list
 checking
To:     Jason Gunthorpe <jgg@ziepe.ca>, madhuparnabhowmik04@gmail.com
Cc:     mike.marciniszyn@intel.com, paulmck@kernel.org,
        joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200114162345.19995-1-madhuparnabhowmik04@gmail.com>
 <20200114165740.GB22037@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <74adec84-ec5b-ea1b-7adf-3f8608838259@intel.com>
Date:   Tue, 14 Jan 2020 12:00:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200114165740.GB22037@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/14/2020 11:57 AM, Jason Gunthorpe wrote:
> On Tue, Jan 14, 2020 at 09:53:45PM +0530, madhuparnabhowmik04@gmail.com wrote:
>> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
>>
>> list_for_each_entry_rcu has built-in RCU and lock checking.
>> Pass cond argument to list_for_each_entry_rcu.
>>
>> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
>>   drivers/infiniband/hw/hfi1/verbs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
>> index 089e201d7550..22f2d4fd2577 100644
>> +++ b/drivers/infiniband/hw/hfi1/verbs.c
>> @@ -515,7 +515,7 @@ static inline void hfi1_handle_packet(struct hfi1_packet *packet,
>>   				       opa_get_lid(packet->dlid, 9B));
>>   		if (!mcast)
>>   			goto drop;
>> -		list_for_each_entry_rcu(p, &mcast->qp_list, list) {
>> +		list_for_each_entry_rcu(p, &mcast->qp_list, list, lockdep_is_held(&(ibp->rvp.lock))) {
> 
> Okay, this looks reasonable
> 
> Mike, Dennis, is this the right lock to test?
> 

I'm looking at that right now actually, I don't think this is correct. 
Wanted to talk to Mike before I send a response though.

-Denny
