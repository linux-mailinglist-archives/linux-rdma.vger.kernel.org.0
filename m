Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207843208F4
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Feb 2021 07:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBUGYp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Feb 2021 01:24:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:48888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhBUGYp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Feb 2021 01:24:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A16D64EDB;
        Sun, 21 Feb 2021 06:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613888645;
        bh=OtWgaqk5m3in6GOA2Ca0pTAyl6+g/j4GLgVUwfvPTGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DGXJvLLRPQ7Q8Foe9n75zyDeklum37ewUMumGa11odUZkBjbamGTPqvAREPKv6sP0
         kucYh/5kDTCcvVh07NUu6c2JyW30XrXuFbkv+A/NxQ9utvVZHWSED9c+UHG8bHSm5y
         rLJVm5Gb8G+XJHFbVWH4nGaFuebohlRlIJoJ5fs/fZuKuD8Dl17samz/Ju7lN9KtwI
         l+AzSDKG5Lzi9BzGO9nqG68bXtgF/vUsPRI+PO/sfm6ezxELHomyw6jRbFMKG+JFgI
         tDch7xlutF5lsZPsWnpLAFYSeZ7r6ew9wG7oM5+N3aHMm9WmXj2V7E2x2wWuAD3vGT
         FlsC1VN96OLJA==
Date:   Sun, 21 Feb 2021 08:24:02 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, danil.kipnis@cloud.ionos.com
Subject: Re: [PATCH 2/2] RDMA/rtrs-clt: Use rdma_event_msg in log
Message-ID: <YDH8gr8yCYiEyqdO@unreal>
References: <20210219115019.38981-1-jinpu.wang@cloud.ionos.com>
 <20210219115019.38981-2-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219115019.38981-2-jinpu.wang@cloud.ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 19, 2021 at 12:50:19PM +0100, Jack Wang wrote:
> It's easier to understand string instead of enum.
>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
