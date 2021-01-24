Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03CF301A4E
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Jan 2021 08:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbhAXHS4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Jan 2021 02:18:56 -0500
Received: from mga04.intel.com ([192.55.52.120]:56604 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbhAXHSz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 24 Jan 2021 02:18:55 -0500
IronPort-SDR: ZldrTAERNDT3OipNWFaTIyH5V6vm4lRLYeXbrOAIIxTQ4ETwGe1yhIpd0HtLtMGCXLDjVoiwnm
 0W8IlHuIowGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9873"; a="177028695"
X-IronPort-AV: E=Sophos;i="5.79,370,1602572400"; 
   d="scan'208";a="177028695"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2021 23:17:10 -0800
IronPort-SDR: Cu+Wa8KxtY0DpZTSBmPG0m8XnB+LFEVb/7ZarXdc6luqLnglI+PtrvbdgyIrMjBtPxR+OOOxeM
 gh4CINFgl9uQ==
X-IronPort-AV: E=Sophos;i="5.79,370,1602572400"; 
   d="scan'208";a="386713678"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.31.40]) ([10.255.31.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2021 23:17:05 -0800
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        "murphyt7@tcd.ie" <murphyt7@tcd.ie>,
        "isaacm@codeaurora.org" <isaacm@codeaurora.org>
Subject: Re: performance regression noted in v5.11-rc after c062db039f40
To:     Robin Murphy <robin.murphy@arm.com>,
        Chuck Lever <chuck.lever@oracle.com>
References: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
 <20210112143819.GA9689@willie-the-truck>
 <607648D8-BF0C-40D6-9B43-2359F45EE74C@oracle.com>
 <e83eed0d-82cd-c9be-cef1-5fe771de975f@arm.com>
 <3568C74A-A587-4464-8840-24F7A93ABA06@oracle.com>
 <990a7c1e-e8c0-a6a8-f057-03b104cebca3@linux.intel.com>
 <3A4451BB-41BD-429B-BE0C-12AE7D03A99B@oracle.com>
 <f1d38e5a-3136-172f-c792-0bbf59131514@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <463fdf02-3d8e-37d3-c819-4a3c173a4138@linux.intel.com>
Date:   Sun, 24 Jan 2021 15:17:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <f1d38e5a-3136-172f-c792-0bbf59131514@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/1/23 1:38, Robin Murphy wrote:
>>> I kind of believe it's due to the indirect calls. This is also reported
>>> on ARM.
>>>
>>> https://lore.kernel.org/linux-iommu/1610376862-927-1-git-send-email-isaacm@codeaurora.org/ 
>>>
>>>
>>> Maybe we can try changing indirect calls to static ones to verify this
>>> problem.
>>
>> I liked the idea of map_sg() enough to try my hand at building a PoC for
>> Intel, based on Isaac's patch series. It's just a cut-and-paste of the
>> generic iommu.c code with the indirect calls to ops->map() replaced.
>>
>> The indirect calls do not seem to be the problem. Calling intel_iommu_map
>> directly appears to be as costly as calling it indirectly.
>>
>> However, perhaps there are other ways map_sg() can be beneficial. In
>> v5.10, __domain_mapping and iommu_flush_write_buffer() appear to be
>> invoked just once for each large map operation, for example.
> 
> Oh, if the driver needs to do maintenance beyond just installing PTEs, 
> that should probably be devolved to iotlb_sync_map anyway. There's a 
> patch series here generalising that to be more useful, which is 
> hopefully just waiting to be merged now:
> 
> https://lore.kernel.org/linux-iommu/20210107122909.16317-1-yong.wu@mediatek.com/ 
> 

The iotlb_sync_map() could help here as far as I can see. I will post a
call-for-test patch set later.

> 
> Robin.

Best regards,
baolu
