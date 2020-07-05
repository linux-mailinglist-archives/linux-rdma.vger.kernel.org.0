Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A9F214CAF
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 15:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGENUd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 09:20:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbgGENUd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 5 Jul 2020 09:20:33 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7712F2073E;
        Sun,  5 Jul 2020 13:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593955233;
        bh=AquMBgAphvp3hTfk08dtsDLX7MT6n+hVBIvbeQNjSq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vIZXgWNwe/tok6zFoZO6Z+Ry6d9lOBTSU6QKC/AdsU534WWU2or72m3asypID6mfK
         wr1+SZAi/mTvA9vh1qImYZQX1z0/8a9SD2QSWwrNNEd5ZRFX75RsMlpHyP6Xt1xeHW
         SvH1pFaQ+INFE0UWO2R7L2jrAxfe3+J4qUxtn/fI=
Date:   Sun, 5 Jul 2020 16:20:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: Re: [PATCH for-next v1 2/4] RDMA/rxe: Return void from
 rxe_init_port_param()
Message-ID: <20200705132029.GE5149@unreal>
References: <20200705104313.283034-1-kamalheib1@gmail.com>
 <20200705104313.283034-3-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705104313.283034-3-kamalheib1@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 05, 2020 at 01:43:11PM +0300, Kamal Heib wrote:
> The return value from rxe_init_port_param() is always 0 - change it to
> be void.
>
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
