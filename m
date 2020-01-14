Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72B0913B1F8
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2020 19:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgANSYI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jan 2020 13:24:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:23319 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbgANSYH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Jan 2020 13:24:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 10:24:04 -0800
X-IronPort-AV: E=Sophos;i="5.70,319,1574150400"; 
   d="scan'208";a="213424198"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.201.179]) ([10.254.201.179])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Jan 2020 10:24:02 -0800
Subject: Re: [PATCH 1/3] infiniband: hw: hfi1: verbs.c: Use built-in RCU list
 checking
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, madhuparnabhowmik04@gmail.com
Cc:     mike.marciniszyn@intel.com, paulmck@kernel.org,
        joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200114162345.19995-1-madhuparnabhowmik04@gmail.com>
 <20200114165740.GB22037@ziepe.ca>
 <74adec84-ec5b-ea1b-7adf-3f8608838259@intel.com>
Message-ID: <25133367-6544-d0af-ae30-5178909748b1@intel.com>
Date:   Tue, 14 Jan 2020 13:24:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <74adec84-ec5b-ea1b-7adf-3f8608838259@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/14/2020 12:00 PM, Dennis Dalessandro wrote:
> On 1/14/2020 11:57 AM, Jason Gunthorpe wrote:
>> On Tue, Jan 14, 2020 at 09:53:45PM +0530, 
>> madhuparnabhowmik04@gmail.com wrote:
>>> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
>>>
>>> list_for_each_entry_rcu has built-in RCU and lock checking.
>>> Pass cond argument to list_for_each_entry_rcu.
>>>
>>> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
>>>   drivers/infiniband/hw/hfi1/verbs.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/infiniband/hw/hfi1/verbs.c 
>>> b/drivers/infiniband/hw/hfi1/verbs.c
>>> index 089e201d7550..22f2d4fd2577 100644
>>> +++ b/drivers/infiniband/hw/hfi1/verbs.c
>>> @@ -515,7 +515,7 @@ static inline void hfi1_handle_packet(struct 
>>> hfi1_packet *packet,
>>>                          opa_get_lid(packet->dlid, 9B));
>>>           if (!mcast)
>>>               goto drop;
>>> -        list_for_each_entry_rcu(p, &mcast->qp_list, list) {
>>> +        list_for_each_entry_rcu(p, &mcast->qp_list, list, 
>>> lockdep_is_held(&(ibp->rvp.lock))) {
>>
>> Okay, this looks reasonable
>>
>> Mike, Dennis, is this the right lock to test?
>>
> 
> I'm looking at that right now actually, I don't think this is correct. 
> Wanted to talk to Mike before I send a response though.
> 
> -Denny

That's definitely going to throw a ton of lock dep messages. It's not 
really the right lock either. Instead what we probably need to do is 
what we do in the non-multicast part of the code and take the 
rcu_read_lock().

I'd say hold off on this and we'll fix it right. Same goes for the qib one.

The rdmavt one though looks to be OK. I'll give it a test.

-Denny
