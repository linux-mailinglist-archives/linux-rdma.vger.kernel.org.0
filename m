Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C921228B4B5
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 14:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgJLMhC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 08:37:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:39194 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgJLMhB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Oct 2020 08:37:01 -0400
IronPort-SDR: OR2bUKtcph/ao4WnueK4SiN3repoxYzBpqlQyOiEqNdKlvmqJjoKDxFAPjZmPp2CBk7X/SnUVQ
 L3q9UpSDk/sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="162264369"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="162264369"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 05:37:01 -0700
IronPort-SDR: 1XoUDNBtzVcVscTXU97SkSUBX9lsh7d3oEWRdc/OOsaupeZ0VbRU50p0x2r5vDKTHCKzQTBLE4
 Aut4qsodfQCQ==
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="529937906"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.201.99]) ([10.254.201.99])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 05:37:00 -0700
Subject: Re: [PATCH] IB/hfi1: Avoid allocing memory on memoryless numa node
To:     Xianting Tian <tian.xianting@h3c.com>, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201010085732.20708-1-tian.xianting@h3c.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <9ba33073-044c-9da6-a90d-4626e6441793@cornelisnetworks.com>
Date:   Mon, 12 Oct 2020 08:36:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201010085732.20708-1-tian.xianting@h3c.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/10/2020 4:57 AM, Xianting Tian wrote:
> In architecture like powerpc, we can have cpus without any local memory
> attached to it. In such cases the node does not have real memory.
> 
> Use local_memory_node(), which is guaranteed to have memory.
> local_memory_node is a noop in other architectures that does not support
> memoryless nodes.
> 
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> ---
>   drivers/infiniband/hw/hfi1/file_ops.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
> index 8ca51e43c..79fa22cc7 100644
> --- a/drivers/infiniband/hw/hfi1/file_ops.c
> +++ b/drivers/infiniband/hw/hfi1/file_ops.c
> @@ -965,7 +965,7 @@ static int allocate_ctxt(struct hfi1_filedata *fd, struct hfi1_devdata *dd,
>   	 */
>   	fd->rec_cpu_num = hfi1_get_proc_affinity(dd->node);
>   	if (fd->rec_cpu_num != -1)
> -		numa = cpu_to_node(fd->rec_cpu_num);
> +		numa = local_memory_node(cpu_to_node(fd->rec_cpu_num));
>   	else
>   		numa = numa_node_id();
>   	ret = hfi1_create_ctxtdata(dd->pport, numa, &uctxt);
> 

The hfi1 driver depends on X86_64. I'm not sure what this patch buys, 
can you expand a bit?

-Denny
