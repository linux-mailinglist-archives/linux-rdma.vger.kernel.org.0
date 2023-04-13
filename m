Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442C86E079C
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Apr 2023 09:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDMHWV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Apr 2023 03:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDMHWU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Apr 2023 03:22:20 -0400
Received: from out-36.mta0.migadu.com (out-36.mta0.migadu.com [91.218.175.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B7055AB
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 00:22:17 -0700 (PDT)
Message-ID: <1adb4df4-ee14-1d26-d1ac-49108b2de03d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1681370535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lrpBu7VCZKoA001HLE4vPibpdz3/Vwpx54m9wTzphZU=;
        b=LLuXJ9wZDsS08Msbkza06vw6arYcwD/prNjZBPl+Y5uu4w/YnTLq+FcS7BYKYHwn+pKB1W
        pGbSfKeYKwksm5GfegdLeW2zmQaDp9bGTkvcaH1sucqcLe1lX4UbbRwu9qCPsTq1xV/Gg9
        w4moEnP3xPGo0KW9RFpn0MTbUqV6rSQ=
Date:   Thu, 13 Apr 2023 15:22:08 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv3 0/8] Fix the problem that rxe can not work in net
 namespace
To:     Mark Lehrer <lehrer@gmail.com>, Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, parav@nvidia.com
References: <20230214060634.427162-1-yanjun.zhu@intel.com>
 <CADvaNzUvWA56BnZqNy3niEC-B0w41TPB+YFGJbn=3bKBi9Orcg@mail.gmail.com>
 <CADvaNzUdktEg=0vhrQgaYcg=GRjnQThx8_gVz71MNeqYw3e1kQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CADvaNzUdktEg=0vhrQgaYcg=GRjnQThx8_gVz71MNeqYw3e1kQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/4/13 5:01, Mark Lehrer 写道:
>> the fabrics device and writing the host NQN etc.  Is there an easy way
>> to prove that rdma_resolve_addr is working from userland?
> Actually I meant "is there a way to prove that the kernel
> rdma_resolve_addr() works with netns?"

I think rdma_resolve_addr can work with netns because rdma on mlx5 can 
work well with netns.

I do not delve into the source code. But IMO, this function should be 
used in rdma on mlx5.

>
> It seems like this is the real problem.  If we run commands like nvme
> discover & nvme connect within the netns context, the system will use
> the non-netns IP & RDMA stacks to connect.  As an aside - this seems
> like it would be a major security issue for container systems, doesn't
> it?

Do you make tests nvme + mlx5 + net ns in your host? Can it work?

Thanks

Zhu Yanjun

>
> I'll investigate to see if the fabrics module & nvme-cli have a way to
> set and use the proper netns context.
>
> Thanks,
> Mark
