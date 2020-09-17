Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FE726D858
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 12:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgIQKFb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 06:05:31 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17463 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgIQKFZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Sep 2020 06:05:25 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6334af0000>; Thu, 17 Sep 2020 03:04:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 17 Sep 2020 03:05:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 17 Sep 2020 03:05:14 -0700
Received: from [172.27.13.3] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 10:05:12 +0000
Subject: Re: [PATCH rdma-next 2/4] IB/core: Enable ODP sync without faulting
To:     Christoph Hellwig <hch@infradead.org>,
        Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, <linux-rdma@vger.kernel.org>
References: <20200914113949.346562-1-leon@kernel.org>
 <20200914113949.346562-3-leon@kernel.org>
 <20200916164706.GB11582@infradead.org>
From:   Yishai Hadas <yishaih@nvidia.com>
Message-ID: <a86ea407-df6b-4665-2d75-9a4e6f1a102f@nvidia.com>
Date:   Thu, 17 Sep 2020 13:05:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200916164706.GB11582@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600337071; bh=oM4E7KlYknsfJq1sHMLpI6KompOMmb6f7XJX+MO3y6g=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:
         Content-Transfer-Encoding:Content-Language:X-Originating-IP:
         X-ClientProxiedBy;
        b=LOlx3opI92VKuGCTuEnRT2vnxRe0weZCmLtIjceXp6oIrb99E1jjIdoQyh/R7v4NC
         NvG9GRBQVfdpV5/vYWZjBgJ15PYrCy9qwd2eEON5VdSMBUYh2+RB14UwyNFaM8/6ke
         bqmoaBAmqZQ8fUzXBOWzUFaFZ1iN9aXBe4HLuReJw1XwRS1RBZCe0lxtaDssO7uDIO
         DQanN+AlMBvKco62MfHoDlFyZJYnUtuZbU2cY76uLCg2/MmYT9wLWoAxRB6AHXrcGY
         xsE2eRt5HxY7XESp6xTzXOIctNAYAuj2m2NeaBKTXGMPvpeYW/xvA5t0g3XG/M7mkf
         0/CglB8CiA96Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/16/2020 7:47 PM, Christoph Hellwig wrote:
>> +		if (fault) {
>> +			/*
>> +			 * Since we asked for hmm_range_fault() to populate pages,
> Totally pointless line over 80 characters.
I'll leave the comment as was asked by Leon, will fix to match 80 
characters.
>> +			access_mask = (range.hmm_pfns[pfn_index] & HMM_PFN_WRITE) ?
>> +				(ODP_READ_ALLOWED_BIT | ODP_WRITE_ALLOWED_BIT) :
>> +				 ODP_READ_ALLOWED_BIT;
>> +		}
> Another weird overly long line, caused by rather osfucated code.  This
> really should be something like:
>
> 			access_mask = ODP_READ_ALLOWED_BIT;
> 			if (range.hmm_pfns[pfn_index] & HMM_PFN_WRITE)
> 				access_mask |= ODP_WRITE_ALLOWED_BIT;
>
No problem, will be part of V1.

