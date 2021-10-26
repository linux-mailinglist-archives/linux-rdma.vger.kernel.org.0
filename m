Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB0E43AC0B
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Oct 2021 08:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhJZGMy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Oct 2021 02:12:54 -0400
Received: from out0.migadu.com ([94.23.1.103]:62450 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232875AbhJZGMy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 Oct 2021 02:12:54 -0400
Message-ID: <1d60192a-0eec-70ed-9c3c-8e6f3866d99c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1635228629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oBQbtnpH+00gV7mBGAxGI5OEydFCoAjp1v+/FzoQd1k=;
        b=J+BKMrUXFE4YEUzli0oDEhIbt38gYW1tEOzDBCtkYly1rEGQeGMsw8UvDnRTiDbVeiugqj
        fA6eoevDZXQa+EntqUz6Tjr9ZMV23IJQ3P/aTu3vyJDm4LOzFlrVPGXAUHj7QufCLzyQNX
        bsGXPfbtlWYVe8wBSURqPlQfF0UPRa0=
Date:   Tue, 26 Oct 2021 09:10:26 +0300
MIME-Version: 1.0
Subject: Re: [PATCH for-next 0/3] EFA dmabuf memory regions
Content-Language: en-US
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Oded Gabbay <ogabbay@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Firas Jahjah <firasj@amazon.com>
References: <20211012120903.96933-1-galpress@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Gal Pressman <gal.pressman@linux.dev>
In-Reply-To: <20211012120903.96933-1-galpress@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: gal.pressman@linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/10/2021 15:09, Gal Pressman wrote:
> Hey all,
>
> This is a followup to my previous RFCs [1][2], which now adds a new api
> to the RDMA subsystem that allows drivers to get a pinned dmabuf memory
> region without requiring an implementation of the move_notify callback.
> The new api makes use of the dynamic attachment api implemented in the
> RDMA subsystem, but calls dma_buf_pin() in order to make sure that the
> callback will not be called, as suggested by Christian.
>
> As explained in the previous RFC, move_notify requires the RDMA device
> to support on-demand-paging (ODP) which is not common on most devices
> (only supported by mlx5).
>
> While the dynamic requirement makes sense for certain GPUs, some devices
> (such as habanalabs) have device memory that is always "pinned" and do
> not need/use the move_notify operation.
>
> Patch #1 changes the dmabuf documentation to make it clear that pinning
> does not necessarily mean the memory must be moved to system memory, it
> is up to the exporter to decide.
> Patch #2 adds the RDMA api that allows drivers to get pinned dmabuf
> memory regions.
> Patch #3 adds the EFA implementation of the dmabuf importer.
>
> The motivation of this submission is to use habanalabs as the dmabuf
> exporter, and EFA as the importer to allow for peer2peer access through
> libibverbs.
>
> [1] https://lore.kernel.org/linux-rdma/20210818074352.29950-1-galpress@amazon.com/
> [2] https://lore.kernel.org/linux-rdma/20211007104301.76693-1-galpress@amazon.com/
>
> Thanks


Hey Jason, did you get a chance to take a look?

