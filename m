Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8CB6C43D2
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Mar 2023 08:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjCVHFj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Mar 2023 03:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCVHFj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Mar 2023 03:05:39 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A25758B60
        for <linux-rdma@vger.kernel.org>; Wed, 22 Mar 2023 00:05:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VePnhn6_1679468734;
Received: from 30.221.102.45(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VePnhn6_1679468734)
          by smtp.aliyun-inc.com;
          Wed, 22 Mar 2023 15:05:35 +0800
Message-ID: <2c82439c-15d0-d5dd-b1c5-46053d3dd202@linux.alibaba.com>
Date:   Wed, 22 Mar 2023 15:05:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH for-next v2 2/2] RDMA/erdma: Support non-4K page size in
 doorbell allocation
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
References: <20230307102924.70577-1-chengyou@linux.alibaba.com>
 <20230307102924.70577-3-chengyou@linux.alibaba.com>
 <20230314102313.GB36557@unreal>
 <e6eec8de-7442-7f2b-8c90-af9222b2e12b@linux.alibaba.com>
 <20230314141020.GL36557@unreal>
 <1604d654-583f-52eb-ff76-fd92647d3625@linux.alibaba.com>
 <20230315102210.GT36557@unreal> <ZBm/deQgMYfdPt/u@ziepe.ca>
Content-Language: en-US
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <ZBm/deQgMYfdPt/u@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 3/21/23 10:30 PM, Jason Gunthorpe wrote:
> On Wed, Mar 15, 2023 at 12:22:10PM +0200, Leon Romanovsky wrote:
<...>
> 
> This sounds similar to how mlx5 chops up its doorbell space
> 
> But I don't understand your device security model.
> 
> In mlx5 it is not allowed to share doorbells between unrelated
> processes. Doorbells have built in security and a doorbell can only
> trigger QP/CQ's that are explicitly linked to that doorbell.
> 
> Thus mlx5 is careful to only mmap doorbells that are linked to the
> QPs. On 64K page size userspace receives alot of doorbells per mmap,
> all linked to the same security context.
> 
> Improperly sharing MMIO pages can result in various security problems
> if a hostile userspace can write arbitary things to MMIO space.
> 
> Here you seem to be talking about overmapping stuff. What is the
> security argument that it is safe to leak to userspace parts of the
> device MMIO BAR beyond that strictly cotnained to the single doorbell?

Thank you for your explanation. IIUC, this security mechanism of mlx5
needs the support of HW, and the HW can reject doorbells from unauthorized
doorbell space.

The current generation of erdma devices do not have this capability due to
implementation complexity. Without this HW capability, isolating the MMIO
space in software doesn't prevent the attack, because the malicious APPs
can map mmio itself, not through verbs interface.

Our consideration of security is mainly focused on the VM/VF level,
not at the process/ucontext level: no matter what the user does inside the
VM, it cannot affect other VMs. Therefore, The userspace isolation of mmio
inside one VM is incomplete and shared mmio pages cannot be avoided in
this generation.

> This has to be clearly explained in the commit message and a comment.

All right, I will do this in v3.

Thanks,
Cheng Xu
