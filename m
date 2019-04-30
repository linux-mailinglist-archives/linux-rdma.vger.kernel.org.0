Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8850BF5C8
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 13:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfD3Lfh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 07:35:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:2163 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfD3Lfh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Apr 2019 07:35:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 04:35:37 -0700
X-IronPort-AV: E=Sophos;i="5.60,413,1549958400"; 
   d="scan'208";a="138696500"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.200.201]) ([10.254.200.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES128-SHA; 30 Apr 2019 04:35:35 -0700
Subject: Re: [PATCH for-next] RDMA/uverbs: Initialize udata struct on destroy
 flows
To:     Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <1556613999-14823-1-git-send-email-galpress@amazon.com>
 <20190430111814.GE6705@mtr-leonro.mtl.com>
 <45a1912f-b811-ad4b-cf66-ac02edb4b811@amazon.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <5dbebe7f-a55e-043f-ccc1-30f12096a36b@intel.com>
Date:   Tue, 30 Apr 2019 07:35:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <45a1912f-b811-ad4b-cf66-ac02edb4b811@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/30/2019 7:27 AM, Gal Pressman wrote:
> On 30-Apr-19 14:18, Leon Romanovsky wrote:
>> On Tue, Apr 30, 2019 at 11:46:39AM +0300, Gal Pressman wrote:
>>> Cited commit introduced the udata parameter to different destroy flows
>>> but the uapi method definition does not have udata (i.e has_udata flag
>>> is not set). As a result, an uninitialized udata struct is being passed
>>> down to the driver callbacks.
>>>
>>> Fix that by clearing the driver udata even in cases where has_udata flag
>>> is not set.
>>>
>>> Fixes: c4367a26357b ("IB: Pass uverbs_attr_bundle down ib_x destroy path")
>>> Cc: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
>>> Co-developed-by: Jason Gunthorpe <jgg@ziepe.ca>
>>
>> What is wrong with Signed-off-by that caused you to add new tag?
> 
> Jason is the one that originally wrote and sent the code, this tag seems
> appropriate.
> Obviously I don't mind removing it, it's there to give him credit..

Did you find documentation for using that tag or did you just make it 
up? I think Signed-off-by is what you want here.

-Denny
