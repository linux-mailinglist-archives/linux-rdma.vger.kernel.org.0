Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49282F614A
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jan 2021 13:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbhANMzP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jan 2021 07:55:15 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7839 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbhANMzP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jan 2021 07:55:15 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60003f0b0000>; Thu, 14 Jan 2021 04:54:35 -0800
Received: from [172.27.0.27] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Jan
 2021 12:54:32 +0000
Subject: Re: [PATCH 3/3] IB/isert: simplify signature cap check
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>
CC:     Sagi Grimberg <sagi@grimberg.me>, <linux-rdma@vger.kernel.org>,
        <dledford@redhat.com>, <oren@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>
References: <20210110111903.486681-1-mgurtovoy@nvidia.com>
 <20210110111903.486681-3-mgurtovoy@nvidia.com>
 <ea24823d-c1e9-d40f-866b-6671a13c08ad@grimberg.me>
 <20210114072938.GM4678@unreal> <20210114124939.GG4147@nvidia.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <686825c6-1ec3-4939-edf5-c2dbd47fc8c9@nvidia.com>
Date:   Thu, 14 Jan 2021 14:54:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210114124939.GG4147@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610628875; bh=BVD+bgbTX1+4eK+tCEYAspUPf+XaBVkHPSSaKUPCs5s=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=AvgAJdzY4BQjung94WIOhnRh5iN25YPNz3VXe/uXPh70JoS8d0HUaugQ89jYooZOl
         Tu/831wV8HX9wa56f2op8vCbPMoJuFUHqvjRkSQPimcf0VXAEglrVD0BTFGIy8DwJq
         rTdaFHyOnrE/A7FiYN6KL8FlPu0VtZ3Y/6XyM0OeM4u5mgV6243AQh3rMtT3eW5dJn
         1OaUS2StqO3MZXeWFRG5y96DZanNCsuf0kXL/u/tjylVbjrJE6R8sKpDzUYeVuhx6v
         zNI7Uilc+0lcjohXGRM2c1X0pDULkGS6pGGMCEywvys7Ww1YF5WJZpqjPe9tyvq1ZZ
         NxD/iU0v6lZMQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 1/14/2021 2:49 PM, Jason Gunthorpe wrote:
> On Thu, Jan 14, 2021 at 09:29:38AM +0200, Leon Romanovsky wrote:
>> On Wed, Jan 13, 2021 at 04:08:29PM -0800, Sagi Grimberg wrote:
>>>> Use if/else clause instead of "condition ? val1 : val2" to make the code
>>>> cleaner and simpler.
>>> Not sure what is cleaner and simpler for a simple condition, but I don't
>>> mind either way...
>> Agree, probably even more cleaner variant will be:
>>   device->pi_capable = !!(ib_dev->attrs.device_cap_flags & IB_DEVICE_INTEGRITY_HANDOVER);
> Gah, !! is rarely a sign of something good..

can we take the series as-is ?

We have enough Acks and eyes on these minor cleanups.


>
> Jason
