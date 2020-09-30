Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96DC27E2AC
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 09:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgI3HcL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Sep 2020 03:32:11 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6686 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI3HcL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Sep 2020 03:32:11 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7434480000>; Wed, 30 Sep 2020 00:31:20 -0700
Received: from [172.27.1.181] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 30 Sep
 2020 07:32:09 +0000
Subject: Re: [PATCH rdma-next v2 1/4] IB/core: Improve ODP to use
 hmm_range_fault()
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
References: <20200922082104.2148873-1-leon@kernel.org>
 <20200922082104.2148873-2-leon@kernel.org>
 <20200929192730.GB767138@nvidia.com>
 <089ce58a-a439-79b5-72ac-128d56002878@nvidia.com>
 <20200929201303.GG9475@nvidia.com>
 <c3b37733-f48b-bc97-9077-60dab5954702@nvidia.com>
 <20200930003531.GA816047@nvidia.com>
From:   Yishai Hadas <yishaih@nvidia.com>
Message-ID: <b32c906d-8f8d-93a3-17df-d9506e1435c4@nvidia.com>
Date:   Wed, 30 Sep 2020 10:32:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200930003531.GA816047@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601451080; bh=ZSgEU74Es1Kj5uazFzPeCc7k8KZLxRhX3F03J88F3Ig=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=sIjYCtbE8sRJzyvXCXZ0VDc3m8M87yWBYYqmKB319e9wQqKIvSo0ipvd8xeXf7hnq
         ++zUJnKs2wp7lHFILRAD0bou59i2L4gISD3pnJ8egStmA2TfNuYkXKduGJaNuOp7tf
         wDjYeJPcn9Z6yvMa/32Oi44eBBlzi/YqGPvSgHYlDancLUIPX12Xd8MsZqzn54bJun
         Ip2tjEsWWn29JPVgAOMewk5C8QXReBkggbRw2zshSNujJwGhql3y2Ukr7540t9B75y
         6rHCbz8dHUOtrQI2Ei8JTMyzkqw/Fo128WWkIzxSpZES8E9CCmb0bgG/gNsveTv439
         snTKLqdI5uj6g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/30/2020 3:35 AM, Jason Gunthorpe wrote:
>
>> In addition to my previous note here as of below [1], ignoring the clear
>> error case might break some testing that expects to get an error in this
>> case when the contract was not honored.
> The error code should be preserved, but not all callers care, like
> prefetch for instance

Right, but for now we have a single caller (i.e. pagefault_real_mr) 
which doesn't know in the general case whether it was a prefetch.
This can be considered as of some future improvement that should be 
handled carefully, I prefer in this stage to stay with previous behavior 
in this area.

> Please send an update tomorre with these small changes since it is
> late for me now
>
> Jason

Sure, V3 may be sent soon, thanks for your feedback.

Yishai

