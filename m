Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECB83D095D
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 09:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhGUG0P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 02:26:15 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:7181 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbhGUGZW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jul 2021 02:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1626851160; x=1658387160;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=tHLQ3P3lEq8HeedebmNRO/ZUr6wdMPKM0mMtqdkLzBo=;
  b=GiUZHQFEg35clXIxwXUBFEqoXYMPsrxnDz1RS5PTdVbJRO4n0DeyHhy1
   iuTcY/nnCPTC1Uh/a5ipvHABSwAfHtRoC1SFybuv6BYsYec4UGMjWn2KT
   ilPgTKMNku+i/31Mn+P2qr49gHpxwMnsTpj8yKLI+dVPXoAtvKB85QL6R
   g=;
X-IronPort-AV: E=Sophos;i="5.84,257,1620691200"; 
   d="scan'208";a="147010158"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 21 Jul 2021 07:05:53 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS id B76C5A1F25;
        Wed, 21 Jul 2021 07:05:51 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.216) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Wed, 21 Jul 2021 07:05:46 +0000
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
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <36390571-e7ab-377f-b2a7-26e2a70e4c94@amazon.com>
Date:   Wed, 21 Jul 2021 10:05:40 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <6d0d7c10-600d-03b7-194c-e7356d07c558@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.162.216]
X-ClientProxiedBy: EX13D40UWC003.ant.amazon.com (10.43.162.246) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 20/07/2021 17:57, Yishai Hadas wrote:
> On 7/20/2021 3:27 PM, Leon Romanovsky wrote:
>> On Tue, Jul 20, 2021 at 12:27:46PM +0300, Yishai Hadas wrote:
>>> On 7/20/2021 11:51 AM, Leon Romanovsky wrote:
>>>> On Tue, Jul 20, 2021 at 11:16:23AM +0300, Yishai Hadas wrote:
>>>>> From: Maor Gottlieb <maorg@nvidia.com>
>>>>>
>>>>> Usage will be in next patches.
>>>>>
>>>>> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
>>>>> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
>>>>> ---
>>>>>    providers/mlx5/mlx5.c | 28 ++++++++++++++--------------
>>>>>    providers/mlx5/mlx5.h |  4 ++++
>>>>>    2 files changed, 18 insertions(+), 14 deletions(-)
>>>> Probably, this patch will be needed to be changed after
>>>> "Verbs logging API" PR https://github.com/linux-rdma/rdma-core/pull/1030
>>>>
>>>> Thanks
>>> Well, not really, this patch just reorganizes things inside mlx5 for code
>>> sharing.
>> After Gal's PR, I expect to see all mlx5 file/debug logic gone except
>> some minimal conversion logic to support old legacy variables.
>>
>> All that get_env_... code will go.
>>
>> Thanks
>>
> Looking on current VERBs logging PR, it doesn't give a clean path conversion
> from mlx5.
> 
> For example it missed a debug granularity per object (e.g. QP, CQ, etc.) , in
> addition it doesn't define a driver specific options as we have today in mlx5
> (e.g. MLX5_DBG_DR).
> 
> I believe that this should be added before going forward with the logging PR to
> enable a clean transition later on.
> 
> The transition of mlx5 should preserve current API/semantics (ENV, etc.) and is
> an orthogonal task.

Yishai, if you have any more concerns please share them in the PR.. The
discussion there is going on for a while and you've been quiet so I assumed
you're fine with it.

I disagree about needing to support everything that exists in mlx5 today, the
purpose of the generic mechanism is to unify the environment variables, driver
specific options do the opposite. IMO masking out a few prints isn't worth the
divergence.

If the mlx5 provider has backwards compatibility issues it doesn't necessarily
have to use this API, but we can at least covert most existing providers and all
future providers that wish to support such functionality in a unified way.

BTW, why even insist on having backwards compatibility here? Do you actually
have useful code that relies on debug environment variables?
