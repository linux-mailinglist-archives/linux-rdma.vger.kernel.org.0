Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F6D483153
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jan 2022 14:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiACNQE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 08:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiACNQE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 08:16:04 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F1BC061761;
        Mon,  3 Jan 2022 05:16:04 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n4NBv-0006ka-RO; Mon, 03 Jan 2022 14:15:59 +0100
Message-ID: <0d897f0a-6671-bb78-21d5-e475d1db29b9@leemhuis.info>
Date:   Mon, 3 Jan 2022 14:15:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix dereg mr flow for kernel MRs
Content-Language: en-BS
To:     Leon Romanovsky <leon@kernel.org>,
        Tony Lu <tonylu@linux.alibaba.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
        Alaa Hleihel <alaa@nvidia.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <f298db4ec5fdf7a2d1d166ca2f66020fd9397e5c.1640079962.git.leonro@nvidia.com>
 <YcKSzszT/zw2ECjh@TonyMac-Alibaba> <YdLHDzmNXlqSMj/A@unreal>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <YdLHDzmNXlqSMj/A@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1641215764;8329ada1;
X-HE-SMSGID: 1n4NBv-0006ka-RO
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

On 03.01.22 10:51, Leon Romanovsky wrote:
> On Wed, Dec 22, 2021 at 10:51:58AM +0800, Tony Lu wrote:
>> On Tue, Dec 21, 2021 at 11:46:41AM +0200, Leon Romanovsky wrote:
>>> From: Maor Gottlieb <maorg@nvidia.com>
>>>
>>> The cited commit moved umem into the union, hence
>>> umem could be accessed only for user MRs. Add udata check
>>> before access umem in the dereg flow.
>>>
>>> Fixes: f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow")
>>> Tested-by: Chuck Lever <chuck.lever@oracle.com>
>>> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
>>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>>> ---
>>>  drivers/infiniband/hw/mlx5/mlx5_ib.h | 2 +-
>>>  drivers/infiniband/hw/mlx5/mr.c      | 4 ++--
>>>  drivers/infiniband/hw/mlx5/odp.c     | 4 ++--
>>>  3 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
>>
>> This patch was tested and works for me in our environment for SMC. It
>> wouldn't panic when release link and call ib_dereg_mr.
>>
>> Tested-by: Tony Lu <tonylu@linux.alibaba.com>
> 
> Thanks, unfortunately, this patch is incomplete.

Could you be a bit more verbose and give a status update? It's hard to
follow from the outside. But according to the "Fixes: f0ae4afe3d35"
above this was supposed to fix a regression introduced in v5.16-rc5 that
was also reported here:
https://lore.kernel.org/linux-rdma/9974ea8c-f1cb-aeb4-cf1b-19d37536894a@linux.alibaba.com/

Commit f0ae4afe3d35 in fact was also backported to v5.15.y and might
cause trouble there as well.

Should it maybe simply be reverted (and reapplied with all fixes later)
in mainline (5.16 will likely be released in 6 days!) and v5.15.y?

Ciao, Thorsten (wearing his 'Linux kernel regression tracker' hat)

P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
on my table. I can only look briefly into most of them. Unfortunately
therefore I sometimes will get things wrong or miss something important.
I hope that's not the case here; if you think it is, don't hesitate to
tell me about it in a public reply, that's in everyone's interest.

BTW, I have no personal interest in this issue, which is tracked using
regzbot, my Linux kernel regression tracking bot
(https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
this mail to get things rolling again and hence don't need to be CC on
all further activities wrt to this regression.

