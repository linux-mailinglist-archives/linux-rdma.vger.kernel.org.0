Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0833C56E39
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2019 18:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfFZQA5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jun 2019 12:00:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:2868 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfFZQA4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 26 Jun 2019 12:00:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 09:00:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,420,1557212400"; 
   d="scan'208";a="167084062"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.205.204]) ([10.254.205.204])
  by orsmga006.jf.intel.com with ESMTP; 26 Jun 2019 09:00:55 -0700
Subject: Re: [PATCH for-next v4 0/3] Clean up and refactor some CQ code
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20190614162435.44620.72298.stgit@awfm-01.aw.intel.com>
 <20190625173144.GA27947@mellanox.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <1e0ba685-5ae8-d97d-1555-e4832258cc91@intel.com>
Date:   Wed, 26 Jun 2019 12:00:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190625173144.GA27947@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/25/2019 1:31 PM, Jason Gunthorpe wrote:
> On Fri, Jun 14, 2019 at 12:25:28PM -0400, Dennis Dalessandro wrote:
>> This is really a resubmit of some code clean up we floated a while back. The
>> main goal here is to clean up some of the stuff which should be in the uapi
>> directory vs in in the driver directory. Then to break the single lock for
>> recv wqe processing.
>>
>> The accompanying user bits should already be in a PR on GitHub.
>>
>> Change log documented below each commit message.
> 
> The conflicts with other hfi patches are too big for me, please respin
> this on wip/for-testing and resend.
> 
> Thanks,
> Jason
> 

Jason, can you pull in f56044d ("IB/rdmavt: Add new completion inline") 
and 4a9ceb7 ("IB/{rdmavt, qib, hfi1}: Convert to new completion API") 
from Doug's wip/dl-for-next branch?

There are still conflicts in the first patch here which I will respin, 
but then the rest will apply, the other series will then also apply.

I'll post those after I can run some smoke tests.

-Denny
