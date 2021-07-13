Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8483C6C01
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jul 2021 10:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhGMIdp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jul 2021 04:33:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234157AbhGMIdn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Jul 2021 04:33:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E0FA611C0;
        Tue, 13 Jul 2021 08:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626165053;
        bh=GUJSY4jiCkUPxGAqM9aAcpi+Hi+h4ylWFG+oSaC6FBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pkfyQXMfFkfXTWb1gXY+8Cz+ulc2+PrGNzb4p/mKiRpM68i6JnihJDj7QbrAfq/Uk
         nvustT/PtQz3OpF3PhtsH5tkjRFVJaWwz9ldv46mtf85DCGBj9Mbw62rhul5cyh8Y2
         AuNbLlz6aYLsoxpe9cyVH1LukJ7XatkMv5BM5BKHD3nUceUwyDJg37iYMz8x/+2rpk
         +dI1uwB1HiGKv+f3OA5WsV4467b5FTMcb76x/UiqGyf7Og6s11ZZgNsRbN73LWYhML
         qjLoLpI9sikJD7buqNjmHvcV4j5VfEq+jEyLuUelIWVSz82UHZVJMmBSRWJuTB5m78
         SsQeVNXLriXMA==
Date:   Tue, 13 Jul 2021 11:30:50 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     linux-rdma@vger.kernel.org, Takanari Hayama <taki@igel.co.jp>
Subject: Re: [RFC] RDMA with Continuous Memory Allocator
Message-ID: <YO1POgdglR8QpfU/@unreal>
References: <CANXvt5oKHQFcKm5ypgS1FyMm_K9KntpmDVHDQRH3fsKXOXoc5A@mail.gmail.com>
 <YO0iDpxD2pJYV3t+@unreal>
 <CANXvt5pMnCeMjAH02LM0szoJz526DRMZ9wZMC4-v7s-e=N33iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXvt5pMnCeMjAH02LM0szoJz526DRMZ9wZMC4-v7s-e=N33iQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 13, 2021 at 03:57:53PM +0900, Shunsuke Mie wrote:
> Hi Leon,
> Thank you for your reply.
> 
> > Sorry for my question, but why do you need it?
> I'd like to write data to the buffer, prepared by DRM (gpu) driver as
> a frame buffer, using RDMA.
> There is a similar project as follows.
> https://www.openfabrics.org/wp-content/uploads/2020-workshop-presentations/303.-OFI-GPU-DMA-BUF-OFA2020v2.pdf
> They prepare a mechanism to share a dmabuf fd between DRM driver and
> RDMA driver, in order to update frame buffer using RDMA. I'm trying to
> develop that in userland.
> 
> Some DRM drivers use CMA to allocate the buffer. I met the problem in
> an environment that CMA used.

In some flows, dma-buf pins memory under the hood.

Anyway, for regular umem, you can try to use mlx5 that supports on
demand paging (ODP). That feature allows you to create umem without
need to pin pages.

Thanks
