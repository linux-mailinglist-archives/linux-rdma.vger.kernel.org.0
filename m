Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA053D0B44
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 11:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbhGUIVh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 04:21:37 -0400
Received: from smtp-fw-80007.amazon.com ([99.78.197.218]:42689 "EHLO
        smtp-fw-80007.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbhGUILE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jul 2021 04:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1626857502; x=1658393502;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=IxyV0Vl5tqMbOjKpkvb1u6RCHQueye5XVxcwJP0XeTs=;
  b=gRgs4/Dsmrhx00nzY7ubA6H8bmC01//AJc3R7Me4JRog7/uzxccBU3Et
   gttCi/YuMKq7GgtrTieKUAol4VZB2n69jBLGZ6ocUHjDnzDFlc16ElQvb
   6E+r/5Yq2qPab3Rv6FZ9e5ZovBVgmQ7zvmw2Gkg/uTHKn44kfummR/7Rt
   U=;
X-IronPort-AV: E=Sophos;i="5.84,257,1620691200"; 
   d="scan'208";a="13663050"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP; 21 Jul 2021 08:51:30 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id 432D5A19D1;
        Wed, 21 Jul 2021 08:51:29 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.229) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Wed, 21 Jul 2021 08:51:24 +0000
Subject: Re: [PATCH rdma-core 03/27] mlx5: Enable debug functionality for vfio
To:     Yishai Hadas <yishaih@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>,
        "Leybovich, Yossi" <sleybo@amazon.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
 <20210720081647.1980-4-yishaih@nvidia.com> <YPaOlTDrV877Jgnt@unreal>
 <2054ad99-254f-4e46-d193-4b1183000d87@nvidia.com> <YPbBFAgEOjfLcYrI@unreal>
 <6d0d7c10-600d-03b7-194c-e7356d07c558@nvidia.com>
 <36390571-e7ab-377f-b2a7-26e2a70e4c94@amazon.com>
 <36f3d02d-e70a-dc8e-0dbd-07fad437c2c4@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <f1dc0691-d9b0-3dec-d815-41694706bf6e@amazon.com>
Date:   Wed, 21 Jul 2021 11:51:18 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <36f3d02d-e70a-dc8e-0dbd-07fad437c2c4@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.229]
X-ClientProxiedBy: EX13D22UWC004.ant.amazon.com (10.43.162.198) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 21/07/2021 10:58, Yishai Hadas wrote:
> On 7/21/2021 10:05 AM, Gal Pressman wrote:
>> On 20/07/2021 17:57, Yishai Hadas wrote:
>>> On 7/20/2021 3:27 PM, Leon Romanovsky wrote:
>>>> On Tue, Jul 20, 2021 at 12:27:46PM +0300, Yishai Hadas wrote:
>>>>> On 7/20/2021 11:51 AM, Leon Romanovsky wrote:
>>>>>> On Tue, Jul 20, 2021 at 11:16:23AM +0300, Yishai Hadas wrote:
>>>>>>> From: Maor Gottlieb <maorg@nvidia.com>
>>>>>>>
>>>>>>> Usage will be in next patches.
>>>>>>>
>>>>>>> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
>>>>>>> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
>>>>>>> ---
>>>>>>>     providers/mlx5/mlx5.c | 28 ++++++++++++++--------------
>>>>>>>     providers/mlx5/mlx5.h |  4 ++++
>>>>>>>     2 files changed, 18 insertions(+), 14 deletions(-)
>>>>>> Probably, this patch will be needed to be changed after
>>>>>> "Verbs logging API" PR https://github.com/linux-rdma/rdma-core/pull/1030
>>>>>>
>>>>>> Thanks
>>>>> Well, not really, this patch just reorganizes things inside mlx5 for code
>>>>> sharing.
>>>> After Gal's PR, I expect to see all mlx5 file/debug logic gone except
>>>> some minimal conversion logic to support old legacy variables.
>>>>
>>>> All that get_env_... code will go.
>>>>
>>>> Thanks
>>>>
>>> Looking on current VERBs logging PR, it doesn't give a clean path conversion
>>> from mlx5.
>>>
>>> For example it missed a debug granularity per object (e.g. QP, CQ, etc.) , in
>>> addition it doesn't define a driver specific options as we have today in mlx5
>>> (e.g. MLX5_DBG_DR).
>>>
>>> I believe that this should be added before going forward with the logging PR to
>>> enable a clean transition later on.
>>>
>>> The transition of mlx5 should preserve current API/semantics (ENV, etc.) and is
>>> an orthogonal task.
>> Yishai, if you have any more concerns please share them in the PR.. The
>> discussion there is going on for a while and you've been quiet so I assumed
>> you're fine with it.
>>
>> I disagree about needing to support everything that exists in mlx5 today, the
>> purpose of the generic mechanism is to unify the environment variables, driver
>> specific options do the opposite. IMO masking out a few prints isn't worth the
>> divergence.
> 
> 
> The options in mlx5 gives more granularity and supports vendor specific options,
> this may be needed down the road by other vendors as well.
> 
> If we come with a new API need to consider such options in the general case.
> 
> NP, I'll comment in the logging PR as well.
> 
>>
>> If the mlx5 provider has backwards compatibility issues it doesn't necessarily
>> have to use this API, but we can at least covert most existing providers and all
>> future providers that wish to support such functionality in a unified way.
> 
> 
> The point was that current suggestion doesn't allow a clean transition for mlx5,
> so we won't use it unless the API will give a matching alternative.
> 
>> BTW, why even insist on having backwards compatibility here? Do you actually
>> have useful code that relies on debug environment variables?
> 
> Logging options (env, mask, etc.) are kind of API which need to be preserved,
> it's used in the field for debug purposes, no reason to loose granularity and
> trace.

It's used in the field by *people*, which unlike legacy code can learn to use
the new debug env variables, they don't need backwards compatibility (the same
as users of debugfs).
I addressed the granularity issue in the PR.
