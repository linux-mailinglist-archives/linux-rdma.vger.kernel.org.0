Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF15E634D77
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Nov 2022 02:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbiKWBx6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Nov 2022 20:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbiKWBx4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Nov 2022 20:53:56 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3441F5DB92
        for <linux-rdma@vger.kernel.org>; Tue, 22 Nov 2022 17:53:54 -0800 (PST)
Message-ID: <0bf27382-c593-89ef-a366-8738865c6f47@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669168432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1C/6yBlJe9pzUfekFxn+whmeSomeceDh0JA2xgQAoUA=;
        b=sckX09t3S/4C6kY/l0YmlrkQF/+rMokiC7icW8Qn4RW+URSD1aI75g8x3+s0XFKLrI3gPK
        nSSuA0gdzD9E8au3BxP1Kp2X1KtzRj6D4sZEkgTkpT5T4LtYV0tlMacnQtXyR5I+JUoLTB
        /auXl1wNHqs3NrT5BUG9lbiNpZTtlTQ=
Date:   Wed, 23 Nov 2022 09:53:45 +0800
MIME-Version: 1.0
Subject: Re: [for-next PATCH 1/1] RDMA/rxe: sgt_append from ib_umem_get is not
 highmem
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
References: <c806a812-4ecd-226f-109e-84642357fbcb@linux.dev>
 <20221120012939.539953-1-yanjun.zhu@intel.com> <Y3uZMQJgcNFDhq5L@ziepe.ca>
 <6cb433cb-c463-7cd8-ee5e-7e922733744a@linux.dev> <Y3zXSK1Wb1/T7vx1@ziepe.ca>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <Y3zXSK1Wb1/T7vx1@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/11/22 22:06, Jason Gunthorpe 写道:
> On Tue, Nov 22, 2022 at 12:07:06PM +0800, Yanjun Zhu wrote:
>
>> But can user space access these high memory? From "Understanding the Linux
>> Kernel", third edition, it seems that it is in kernel space.
> Yes, "highmem" is effecitvely the ability to have a struct page * that
> is not mapped into the kernel address space, but is mapped into a
> userspace process address sspace.
Got it. I am interested in this "highmem is mapped into a

userspace process address space.".


Would you like to share some documents, links or source code about this 
with me?


I want to delve into this "highmem is mapped into a

userspace process address space."

Thanks and Regards,

Zhu Yanjun


>
> Jason
