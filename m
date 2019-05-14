Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 157F81C8CB
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2019 14:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfENMcz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 08:32:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:42415 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfENMcz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 May 2019 08:32:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 05:32:54 -0700
X-ExtLoop1: 1
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.201.71]) ([10.254.201.71])
  by FMSMGA003.fm.intel.com with ESMTP; 14 May 2019 05:32:53 -0700
Subject: Re: [PATCH 5/5] IB/hfi1: Fix improper uses of smp_mb__before_atomic()
To:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1556568902-12464-6-git-send-email-andrea.parri@amarulasolutions.com>
 <14063C7AD467DE4B82DEDB5C278E8663BE6AADCE@FMSMSX108.amr.corp.intel.com>
 <20190429231657.GA2733@andrea> <20190509211221.GA4966@andrea>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <0a78eded-6c08-8d32-ec31-d62d6feb2118@intel.com>
Date:   Tue, 14 May 2019 08:32:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509211221.GA4966@andrea>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/9/2019 5:12 PM, Andrea Parri wrote:
> On Tue, Apr 30, 2019 at 01:16:57AM +0200, Andrea Parri wrote:
>> Hi Mike,
>>
>>>> This barrier only applies to the read-modify-write operations; in
>>>> particular, it does not apply to the atomic_read() primitive.
>>>>
>>>> Replace the barrier with an smp_mb().
>>>
>>> This is one of a couple of barrier issues that we are currently looking into.
>>>
>>> See:
>>>
>>> [PATCH for-next 6/9] IB/rdmavt: Add new completion inline
>>>
>>> We will take a look at this one as well.
>>
>> Thank you for the reference and for looking into this,
> 
> So, I'm planning to just drop this patch; or can I do something to help?
> 
> Please let me know.

Mike was looking into this, and I've got a handful of patches from him 
to review. He's unavailable for a while but if it's not included in the 
patches I've got we'll get something out shortly. So yes I think we can 
hold off on this patch for now. Thanks.

-Denny
