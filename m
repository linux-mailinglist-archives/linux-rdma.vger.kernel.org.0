Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0966EAE4E
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Apr 2023 17:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjDUPvq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Apr 2023 11:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjDUPvp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Apr 2023 11:51:45 -0400
Received: from out-53.mta0.migadu.com (out-53.mta0.migadu.com [91.218.175.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01D9B47D
        for <linux-rdma@vger.kernel.org>; Fri, 21 Apr 2023 08:51:44 -0700 (PDT)
Message-ID: <1fbd5b6f-ba04-95b3-d37c-35fc12e81303@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682092302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ursWG+qMGx5B7FN2AxN1ffA2GpgrM0KD+npq5cr06Uk=;
        b=hkH2sUKuHY00fXBlRmrM/a/WxkKsIxNbqCidXzgWE9lg2bD1UulcB+Vl4cljfzCoaPYU0j
        hCesCQGFZPdmh7NJtflFFQMTwkuXvkrwI+HsVGa75eHtzipXciGIhykXSTttFYIf9kr0OC
        UIrpZFXNWxceuEVNfg2yAnz0GjAVi0I=
Date:   Fri, 21 Apr 2023 23:51:34 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Add function name to the logs
To:     Jason Gunthorpe <jgg@nvidia.com>, Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org
References: <20230418122611.1436836-1-yanjun.zhu@intel.com>
 <ZEKraDHuNAltduzU@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <ZEKraDHuNAltduzU@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/4/21 23:27, Jason Gunthorpe 写道:
> On Tue, Apr 18, 2023 at 08:26:11PM +0800, Zhu Yanjun wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> Add the function names to the pr_ logs. As such, if some bugs occur,
>> with function names, it is easy to locate the bugs.
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/sw/rxe/rxe.h       |  2 +-
>>   drivers/infiniband/sw/rxe/rxe_queue.h | 16 ++++------------
>>   2 files changed, 5 insertions(+), 13 deletions(-)
> After you delete the warn_on's there is very little left:
>
> rivers/infiniband/sw/rxe/rxe.c:                pr_err("rxe creation allowed on top of a real device only\n");
> drivers/infiniband/sw/rxe/rxe.c:        pr_info("loaded\n");
> drivers/infiniband/sw/rxe/rxe.c:        pr_info("unloaded\n");
> drivers/infiniband/sw/rxe/rxe_net.c:            pr_err("Failed to create IPv4 UDP tunnel\n");
> drivers/infiniband/sw/rxe/rxe_net.c:            pr_warn("IPv6 is not supported, can not create a UDPv6 socket\n");
> drivers/infiniband/sw/rxe/rxe_net.c:            pr_err("Failed to create IPv6 UDP tunnel\n");
> drivers/infiniband/sw/rxe/rxe_net.c:            pr_err("Failed to register netdev notifier\n");
>
> It is not exactly mysterious where these come from?

If I got you correctly, you mean that we can easily locate the above 
pr_xxx logs. As such, it is not necessary to add function names.

 From this perspective, I agree with you.

Why I make this commit is that we can directly use this pr_info("xxxxx") 
when some bug occurs. But in the logs, the function names appear.

With this commit, we can decrease some work loads with some bug occurs.

Now I am debugging a problem. With a similar commit with this, I 
directly use pr_warn("xxx"). But in the logs, function names, line 
number, file names, caller and so on will appear.

This greatly decrease my workloads.

I think this is a smart method. So I introduce this smart method to 
softroce. When some bugs occur in softroce, this method can help us.

Zhu Yanjun

>
> Why do we need the function name?
>
> Jason
