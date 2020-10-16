Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B0B29080E
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 17:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406809AbgJPPOR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 11:14:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:10047 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395540AbgJPPOQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Oct 2020 11:14:16 -0400
IronPort-SDR: 2DizwvBUhuWmJ8EyQBSdx4z8c408FNlxtJmDQLPXlQOLaYn7eYhD4G1Q+Ojd3eRzW2bDaVJKlB
 ykZ/Bq+T7IaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9776"; a="230817975"
X-IronPort-AV: E=Sophos;i="5.77,383,1596524400"; 
   d="scan'208";a="230817975"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 08:14:13 -0700
IronPort-SDR: FIF5WfCWETsAWReYXNH+IIVmcS0AuT+c154fIAwTkaCjCiLGCgs3vaP9O/ffQx6b5mKKrZqUTJ
 Afvm+IYQUmPw==
X-IronPort-AV: E=Sophos;i="5.77,383,1596524400"; 
   d="scan'208";a="531752068"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.202.122]) ([10.254.202.122])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 08:14:11 -0700
Subject: Re: [PATCH] IB/hfi1: Avoid allocing memory on memoryless numa node
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Xianting Tian <tian.xianting@h3c.com>,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201010085732.20708-1-tian.xianting@h3c.com>
 <9ba33073-044c-9da6-a90d-4626e6441793@cornelisnetworks.com>
 <20201016141152.GC36674@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <c69d2429-25cc-75dc-d4de-3ee66e9aaa08@cornelisnetworks.com>
Date:   Fri, 16 Oct 2020 11:14:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201016141152.GC36674@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/16/2020 10:11 AM, Jason Gunthorpe wrote:
> On Mon, Oct 12, 2020 at 08:36:57AM -0400, Dennis Dalessandro wrote:
>> On 10/10/2020 4:57 AM, Xianting Tian wrote:
>>> In architecture like powerpc, we can have cpus without any local memory
>>> attached to it. In such cases the node does not have real memory.
>>>
>>> Use local_memory_node(), which is guaranteed to have memory.
>>> local_memory_node is a noop in other architectures that does not support
>>> memoryless nodes.
>>>
>>> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
>>>    drivers/infiniband/hw/hfi1/file_ops.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
>>> index 8ca51e43c..79fa22cc7 100644
>>> +++ b/drivers/infiniband/hw/hfi1/file_ops.c
>>> @@ -965,7 +965,7 @@ static int allocate_ctxt(struct hfi1_filedata *fd, struct hfi1_devdata *dd,
>>>    	 */
>>>    	fd->rec_cpu_num = hfi1_get_proc_affinity(dd->node);
>>>    	if (fd->rec_cpu_num != -1)
>>> -		numa = cpu_to_node(fd->rec_cpu_num);
>>> +		numa = local_memory_node(cpu_to_node(fd->rec_cpu_num));
>>>    	else
>>>    		numa = numa_node_id();
>>>    	ret = hfi1_create_ctxtdata(dd->pport, numa, &uctxt);
>>>
>>
>> The hfi1 driver depends on X86_64. I'm not sure what this patch buys, can
>> you expand a bit?
> 
> Yikes, that is strongly discouraged.

Hmm. This was never raised as an issue before. Regardless I can't recall 
why we did this in the first place. I'll do some digging, try to jog my 
memory.

-Denny
