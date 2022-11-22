Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C42633453
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Nov 2022 05:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiKVEHS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Nov 2022 23:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiKVEHR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Nov 2022 23:07:17 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75C02E9E1
        for <linux-rdma@vger.kernel.org>; Mon, 21 Nov 2022 20:07:15 -0800 (PST)
Message-ID: <6cb433cb-c463-7cd8-ee5e-7e922733744a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669090033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wgWG3+jRHTx4R9aZspcJHjLiQSk6hLRD6kLxtYaQjS0=;
        b=cwPjNohm64uTspn2tZX+gaWEWtmjmH1pJ84FDJ1cSXbNdvpxYd+iUZdSR2e+Qp80SAJLnA
        l7RDj4VUYYC6pL3nt+bIWGfFKJ2mABSgAzpLt8tGzFdvOb8dVlrRZ4a3OI2bz1uNmosz/I
        GTRxj46JGy2NuG5TdTcGoBuuTwMMvyg=
Date:   Tue, 22 Nov 2022 12:07:06 +0800
MIME-Version: 1.0
Subject: Re: [for-next PATCH 1/1] RDMA/rxe: sgt_append from ib_umem_get is not
 highmem
To:     Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        Zhu Yanjun <yanjun.zhu@linux.dev>
References: <c806a812-4ecd-226f-109e-84642357fbcb@linux.dev>
 <20221120012939.539953-1-yanjun.zhu@intel.com> <Y3uZMQJgcNFDhq5L@ziepe.ca>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <Y3uZMQJgcNFDhq5L@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/11/21 23:28, Jason Gunthorpe 写道:
> On Sat, Nov 19, 2022 at 08:29:38PM -0500, Zhu Yanjun wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> In ib_umem_get, sgt_append is allocated from the function
>> sg_alloc_append_table_from_pages. And it is not from highmem.
> 
> You've confused the allocation of the SGL table itself with the
> page_address called on the struct page * stored inside the SGL table.
> 
> Think of the SGL as an array of 'struct page *'
> 
About "The page_address() can return NULL because the 'struct page *' it 
  contains came from userspace and could very will be highmem.",

 From the function ib_umem *ib_umem_get(struct ib_device *device, 
unsigned long addr,size_t size, int access), I agree with you that 
struct page comes from user space.

But from "Understanding the Linux Kernel", third edition - sections 
"8.1.3. Memory Zones" and "8.1.6. Kernel Mappings of High-Memory Page 
Frames".

In the process' virtual address space, the user space occupies the first 
3GB, and the kernel space the 4th GB of this linear address space.

The first 896MB of the kernel space (not only kernel code, but its data 
also) is "directly" mapped to the first 896 MB of the physical memory.

The last 128MB part of the virtual kernel space is where are mapped some 
pieces of the physical "high memory" (> 896MB) : thus it can only map no 
more than 128MB of "high memory" at a time.

It seems that page_address of these "128MB high memory" will return NULL.

But can user space access these high memory? From "Understanding the 
Linux Kernel", third edition, it seems that it is in kernel space.

Thanks and Regards,
Zhu Yanjun

> 
> Jason

