Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACEE2FC7C0
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jan 2021 03:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbhATCYA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 21:24:00 -0500
Received: from mga17.intel.com ([192.55.52.151]:1924 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731437AbhATCVP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Jan 2021 21:21:15 -0500
IronPort-SDR: +iEjr9p5Pc/SruQHfwhlhdIbb3TYb6a7wqhGcoSxAP/MHMJyuhq8IksABKbg6iVAJhhjAJchLv
 bRWiEyLx2VDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="158805844"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="158805844"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 18:19:26 -0800
IronPort-SDR: KBaqGuVhwUADj+5zuhsRdrgXO822NRFc2xAMPmreV8fFKdt29AdMT+ihcegqFGqVdARj8VPH3z
 9AOyCLyrMLrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="466919841"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2021 18:19:24 -0800
Cc:     baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>, logang@deltatee.com,
        Christoph Hellwig <hch@lst.de>, murphyt7@tcd.ie
Subject: Re: performance regression noted in v5.11-rc after c062db039f40
To:     Chuck Lever <chuck.lever@oracle.com>
References: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
 <20210112143819.GA9689@willie-the-truck>
 <607648D8-BF0C-40D6-9B43-2359F45EE74C@oracle.com>
 <e83eed0d-82cd-c9be-cef1-5fe771de975f@arm.com>
 <D6B45F88-08B7-41B5-AAD2-BFB374A42874@oracle.com>
 <0f7c344a-00b6-72bc-5c39-c6cdc571211b@linux.intel.com>
 <603D10B9-5089-4CC3-B940-5646881BBA89@oracle.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1107f22e-c01e-0dbd-4286-3a264b36e4e4@linux.intel.com>
Date:   Wed, 20 Jan 2021 10:11:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <603D10B9-5089-4CC3-B940-5646881BBA89@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/19/21 10:37 PM, Chuck Lever wrote:
> 
> 
>> On Jan 18, 2021, at 8:22 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> Do you mind posting the cap and ecap of the iommu used by your device?
>>
>> You can get it via sysfs, for example:
>>
>> /sys/bus/pci/devices/0000:00:14.0/iommu/intel-iommu# ls
>> address  cap  domains_supported  domains_used  ecap  version
> 
> [root@manet intel-iommu]# lspci | grep Mellanox
> 03:00.0 Network controller: Mellanox Technologies MT27520 Family [ConnectX-3 Pro]
> [root@manet intel-iommu]# pwd
> /sys/devices/pci0000:00/0000:00:03.0/0000:03:00.0/iommu/intel-iommu
> [root@manet intel-iommu]# for i in *; do   echo -n $i ": ";   cat $i; done
> address : c7ffc000
> cap : d2078c106f0466

MGAW: 101111 (supporting 48-bit address width)
SAGAW: 00100 (supporting 48-bit 4-level page table)

So the calculation of domain->domain.geometry.aperture_end is right.

> domains_supported : 65536
> domains_used : 62
> ecap : f020de
> version : 1:0
> [root@manet intel-iommu]#
> 
> 
>>> Fwiw, this system uses the Intel C612 chipset with Intel(R) Xeon(R)
>>> E5-2603 v3 @ 1.60GHz CPUs.
>>
>> Can you please also hack a line of code to check the return value of
>> iommu_dma_map_sg()?
> 
> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
> index baca49fe83af..e811562ead0e 100644
> --- a/net/sunrpc/xprtrdma/frwr_ops.c
> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
> @@ -328,6 +328,7 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
>   
>          dma_nents = ib_dma_map_sg(ep->re_id->device, mr->mr_sg, mr->mr_nents,
>                                    mr->mr_dir);
> +       trace_printk("ib_dma_map_sg(%d) returns %d\n", mr->mr_nents, dma_nents);
>          if (!dma_nents)
>                  goto out_dmamap_err;
>          mr->mr_device = ep->re_id->device;
> 
> During the 256KB iozone test I used before, this trace log is generated:
> 
>     kworker/u28:3-1269  [000]   336.054743: bprint:               frwr_map: ib_dma_map_sg(30) returns 1
>     kworker/u28:3-1269  [000]   336.054835: bprint:               frwr_map: ib_dma_map_sg(30) returns 1
>     kworker/u28:3-1269  [000]   336.055022: bprint:               frwr_map: ib_dma_map_sg(4) returns 1
>     kworker/u28:3-1269  [000]   336.055118: bprint:               frwr_map: ib_dma_map_sg(30) returns 1
>     kworker/u28:3-1269  [000]   336.055312: bprint:               frwr_map: ib_dma_map_sg(30) returns 1
>     kworker/u28:3-1269  [000]   336.055407: bprint:               frwr_map: ib_dma_map_sg(4) returns 1

This is the result after commit c062db039f40, right? It also looks good
to me. Are you using iotlb strict mode (intel_iommu=strict) or lazy mode
(by default)?

Best regards,
baolu
