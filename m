Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C37A3C69AE
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jul 2021 07:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhGMFU7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jul 2021 01:20:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231373AbhGMFU7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Jul 2021 01:20:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2979460D07;
        Tue, 13 Jul 2021 05:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626153489;
        bh=RDqFFxlKptbJnXJj1mDlxi2ngMNXV9FAWjF9gZq/CSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YIrGmtu+moFqe4ZHSNWA3oqK+rQRae/lDYe2kxp+xEL6pRGrxDpdWRMX22thuUo4M
         0XSM/WgKHmuziF4Uhf8JrTQGe9TwihkwUOqFGByB3u9otQSSAeUXfXLMSe16uSL7uP
         RJ626PHJk7DvFmSnSUsFwktyXEHRDYMgqwuu3gFQA7eUB7VELDlSZ44Uz406ry1Juw
         vK1/DE89Ee7J6kXuorfzfB4SCa8aHpFXmUni9hUKtwXy1pD8GMqILdTNM7BOZW40GP
         JFCbtu7Ih1uaE/5eSCEN4FdjipxxBKM/h8y1syHLeYb6MloiUJ/8e6pHMpWGtpXYdo
         Y+olisz05Uyug==
Date:   Tue, 13 Jul 2021 08:18:06 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     linux-rdma@vger.kernel.org, Takanari Hayama <taki@igel.co.jp>
Subject: Re: [RFC] RDMA with Continuous Memory Allocator
Message-ID: <YO0iDpxD2pJYV3t+@unreal>
References: <CANXvt5oKHQFcKm5ypgS1FyMm_K9KntpmDVHDQRH3fsKXOXoc5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXvt5oKHQFcKm5ypgS1FyMm_K9KntpmDVHDQRH3fsKXOXoc5A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 09, 2021 at 07:24:48PM +0900, Shunsuke Mie wrote:
> Hi all,
> 
> I tried to use Continuous Memory Allocator (CMA) allocated memory for
> RDMA transfer buffer in userspace, but it failed.

Sorry for my question, but why do you need it?
From that I remember, CMA memory is used for the devices that doesn't
support scatter-gather, while RDMA devices (umem) need SG.

Thanks

> 
> For more details, an ibv_reg_mr() API fails when I pass an mmaped
> memory region of allocated memory by the CMA. The reason why, a CMA
> mmap function, __dma_mmap_from_coherent(), sets  VM_IO and VM_PFNMAP
> to vma->vm_flags, and an ib_uverbs_reg_mr(), kernel function
> corresponding to the ibv_reg_mr(), tries to pin the memory region but,
> it becomes to fail. because VM_IO or VM_PFNMAP regions cannot be
> pined. As a result, the ibv_reg_mr() returns an error.
> 
> I think the ib_umem_get() that is called in the ib_uverbs_reg_mr() and
> pins memories needs some modifications to support RDMA transfer
> to/from the CMA memory.
> 
> I’d like to know your comments, ideas, and other solution.
> 
> Thanks a lot,
> Shunsuke.
