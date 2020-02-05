Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 176B3153921
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2020 20:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgBETbY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Feb 2020 14:31:24 -0500
Received: from mga09.intel.com ([134.134.136.24]:50692 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbgBETbX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Feb 2020 14:31:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 11:31:23 -0800
X-IronPort-AV: E=Sophos;i="5.70,406,1574150400"; 
   d="scan'208";a="235696041"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.205.112]) ([10.254.205.112])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Feb 2020 11:31:22 -0800
Subject: Re: [PATCH for-rc] RDMA/hfi1: Fix memory leak in
 _dev_comp_vect_mappings_create
To:     Kamal Heib <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20200205110530.12129-1-kamalheib1@gmail.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <d43977d1-768b-4e15-e8ac-7238167e7583@intel.com>
Date:   Wed, 5 Feb 2020 14:31:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200205110530.12129-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/5/2020 6:05 AM, Kamal Heib wrote:
> Make sure to free the allocated cpumask_var_t's to avoid the following
> reported memory leak by kmemleak:
> 
> $ cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff8897f812d6a8 (size 8):
>    comm "kworker/1:1", pid 347, jiffies 4294751400 (age 101.703s)
>    hex dump (first 8 bytes):
>      00 00 00 00 00 00 00 00                          ........
>    backtrace:
>      [<00000000bff49664>] alloc_cpumask_var_node+0x4c/0xb0
>      [<0000000075d3ca81>] hfi1_comp_vectors_set_up+0x20f/0x800 [hfi1]
>      [<0000000098d420df>] hfi1_init_dd+0x3311/0x4960 [hfi1]
>      [<0000000071be7e52>] init_one+0x25e/0xf10 [hfi1]
>      [<000000005483d4c2>] local_pci_probe+0xd4/0x180
>      [<000000007c3cbc6e>] work_for_cpu_fn+0x51/0xa0
>      [<000000001d626905>] process_one_work+0x8f0/0x17b0
>      [<000000007e569e7e>] worker_thread+0x536/0xb50
>      [<00000000fd39a4a5>] kthread+0x30c/0x3d0
>      [<0000000056f2edb3>] ret_from_fork+0x3a/0x50
> 
> Fixes: 5d18ee67d4c1 ("IB/{hfi1, rdmavt, qib}: Implement CQ completion vector support")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>   drivers/infiniband/hw/hfi1/affinity.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
> index c142b23bb401..1aeea5d65c01 100644
> --- a/drivers/infiniband/hw/hfi1/affinity.c
> +++ b/drivers/infiniband/hw/hfi1/affinity.c
> @@ -479,6 +479,8 @@ static int _dev_comp_vect_mappings_create(struct hfi1_devdata *dd,
>   			  rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), i, cpu);
>   	}
>   
> +	free_cpumask_var(available_cpus);
> +	free_cpumask_var(non_intr_cpus);
>   	return 0;
>   
>   fail:
> 

Perhaps this should also target stable kernel?

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
