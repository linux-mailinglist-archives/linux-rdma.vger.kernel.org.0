Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61EBD11B8E2
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2019 17:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfLKQdt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Dec 2019 11:33:49 -0500
Received: from mga12.intel.com ([192.55.52.136]:12717 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730373AbfLKQdt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Dec 2019 11:33:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 08:33:48 -0800
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="225586853"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.204.32]) ([10.254.204.32])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 11 Dec 2019 08:33:47 -0800
Subject: Re: [PATCH for-next v2 00/11] rdmavt/hfi1 updates for next
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
References: <20191126141055.58836.79452.stgit@awfm-01.aw.intel.com>
 <3a570d5b-330b-bbc6-9a7a-60a112b1c66b@intel.com>
 <20191211162140.GB6622@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <5c72c47c-e5c0-3389-a16f-4cf39f2d4a86@intel.com>
Date:   Wed, 11 Dec 2019 11:33:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191211162140.GB6622@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/11/2019 11:21 AM, Jason Gunthorpe wrote:
> On Wed, Dec 11, 2019 at 08:34:40AM -0500, Dennis Dalessandro wrote:
>> On 11/26/2019 9:12 AM, Dennis Dalessandro wrote:
>>> Here are some refactoring and code reorg patches for the merge window. Nothing
>>> too scary, no new features. This lays the ground work for stuff coming in
>>> future merge cycles.
>>>
>>> There is also one bug fix, from Kaike.
>>>
>>> Changes from v1
>>> Fix Review-by tags with corrupted email address.
>>>
>>>
>>> Grzegorz Andrejczuk (3):
>>>         IB/hfi1: Move common receive IRQ code to function
>>>         IB/hfi1: Decouple IRQ name from type
>>>         IB/hfi1: Return void in packet receiving functions
>>>
>>> Kaike Wan (1):
>>>         IB/hfi1: Don't cancel unused work item
>>>
>>> Michael J. Ruhl (1):
>>>         IB/hfi1: List all receive contexts from debugfs
>>>
>>> Mike Marciniszyn (6):
>>>         IB/hfi1: Add accessor API routines to access context members
>>>         IB/hfi1: Move chip specific functions to chip.c
>>>         IB/hfi1: Add fast and slow handlers for receive context
>>>         IB/hfi1: IB/hfi1: Add an API to handle special case drop
>>>         IB/hfi1: Create API for auto activate
>>>         IB/rdmavt: Correct comments in rdmavt_qp.h header
>>
>> I guess these didn't catch the train for 5.5 merge window. Do I need to
>> resubmit to break this into two series, one for RC and one for next?
> 
> It is more reliable if it shows in patchworks as you want

Ok, you can toss this series then if you haven't yet and I'll respin and 
resubmit.

> 
>> I think 1, 9, 10, and 11 could/should probably go for RC.
> 
> Make sure they have suitable commit messages please

Will do.

-Denny
