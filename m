Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3072150F1
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 18:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfEFQJc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 12:09:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:22774 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfEFQJc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 May 2019 12:09:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 09:09:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="148851087"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.206.13]) ([10.254.206.13])
  by orsmga003.jf.intel.com with ESMTP; 06 May 2019 09:09:29 -0700
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Catch use-after-free access of AH
 structures
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
References: <20190416121310.20783-1-leon@kernel.org>
 <20190506155108.GA29293@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <f540da36-8984-3476-5b91-322bbd804d03@intel.com>
Date:   Mon, 6 May 2019 12:09:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506155108.GA29293@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/6/2019 11:51 AM, Jason Gunthorpe wrote:
> On Tue, Apr 16, 2019 at 03:13:10PM +0300, Leon Romanovsky wrote:
>> From: Leon Romanovsky <leonro@mellanox.com>
>>
>> Prior to commit d345691471b4 ("RDMA: Handle AH allocations by IB/core"),
>> AH destroy path is rdmavt returned -EBUSY warning to application and
>> caused to potential leakage of kernel memory of AH structure.
>>
>> After that commit, the AH structure is always freed but such early
>> return in driver code can potentially cause to use-after-free error.
>>
>> Add warning to catch such situation to help driver developers to fix
>> AH release path.
>>
>> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>> ---
>>   drivers/infiniband/sw/rdmavt/ah.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Applied to for-next
> 
> Denny, since you missed the merge window with the fix, please send a
> fixup next cycle. The WARN_ON will scare people who might be able to
> hit this buggy case.

Sounds reasonable to me.

-Denny


