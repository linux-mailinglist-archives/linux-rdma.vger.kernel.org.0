Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634054B2465
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Feb 2022 12:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346428AbiBKLfT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Feb 2022 06:35:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349513AbiBKLfT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Feb 2022 06:35:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43CA7E8E
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 03:35:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EE7911D4;
        Fri, 11 Feb 2022 03:35:18 -0800 (PST)
Received: from [10.57.70.89] (unknown [10.57.70.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72E0B3F73B;
        Fri, 11 Feb 2022 03:35:16 -0800 (PST)
Message-ID: <a0d3b1f7-986f-591d-2675-8ee753d2e7db@arm.com>
Date:   Fri, 11 Feb 2022 11:35:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Error when running fio against nvme-of rdma target (mlx5 driver)
Content-Language: en-GB
To:     Martin Oliveira <Martin.Oliveira@eideticom.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Kelly Ursenbach <Kelly.Ursenbach@eideticom.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Lee, Jason" <jasonlee@lanl.gov>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Logan Gunthorpe <Logan.Gunthorpe@eideticom.com>
References: <MW3PR19MB42505C41C2BA3F425A5CB606E42D9@MW3PR19MB4250.namprd19.prod.outlook.com>
 <62fd851d-564e-e2f3-1a40-b594810d9f01@nvidia.com>
 <MW3PR19MB4250DFC4E2AEB8184299A4BBE42F9@MW3PR19MB4250.namprd19.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <MW3PR19MB4250DFC4E2AEB8184299A4BBE42F9@MW3PR19MB4250.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022-02-10 23:58, Martin Oliveira wrote:
> On 2/9/22 1:41 AM, Chaitanya Kulkarni wrote:
>> On 2/8/22 6:50 PM, Martin Oliveira wrote:
>>> Hello,
>>>
>>> We have been hitting an error when running IO over our nvme-of setup, using the mlx5 driver and we are wondering if anyone has seen anything similar/has any suggestions.
>>>
>>> Both initiator and target are AMD EPYC 7502 machines connected over RDMA using a Mellanox MT28908. Target has 12 NVMe SSDs which are exposed as a single NVMe fabrics device, one physical SSD per namespace.
>>>
>>
>> Thanks for reporting this, if you can bisect the problem on your setup
>> it will help others to help you better.
>>
>> -ck
> 
> Hi Chaitanya,
> 
> I went back to a kernel as old as 4.15 and the problem was still there, so I don't know of a good commit to start from.
> 
> I also learned that I can reproduce this with as little as 3 cards and I updated the firmware on the Mellanox cards to the latest version.
> 
> I'd be happy to try any tests if someone has any suggestions.

The IOMMU is probably your friend here - one thing that might be worth 
trying is capturing the iommu:map and iommu:unmap tracepoints to see if 
the address reported in subsequent IOMMU faults was previously mapped as 
a valid DMA address (be warned that there will likely be a *lot* of 
trace generated). With 5.13 or newer, booting with "iommu.forcedac=1" 
should also make it easier to tell real DMA IOVAs from rogue physical 
addresses or other nonsense, as real DMA addresses should then look more 
like 0xffff24d08000.

That could at least help narrow down whether it's some kind of 
use-after-free race or a completely bogus address creeping in somehow.

Robin.
