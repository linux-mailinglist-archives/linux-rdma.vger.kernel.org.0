Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAAA1C993C
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2020 20:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEGSYh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 May 2020 14:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgEGSYh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 May 2020 14:24:37 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01DCB2073A;
        Thu,  7 May 2020 18:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588875876;
        bh=ttfxh5UZgMWDmlCbVUviUlcKCIw0gaoctdxt32VgcHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vZFF+uizKqMn2OVUpNdm0ULOf+2jh2PSuQmfwCjtnPgOu69M77NXimqc7P9+edXSh
         btbrk0qiLI+8+dbQGljQb4qaCa11ZkJ6f+tL5VKFAKWnATe8yXFVZL1520PlG5ecPK
         dyohdNfiTUgKJqfbwqdsYviXxWS9OB2axEVpbY7Q=
Date:   Thu, 7 May 2020 21:24:32 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/mlx5: remove duplicated assignment to
 variable rcqe_sz
Message-ID: <20200507182432.GD104730@unreal>
References: <20200507151610.52636-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507151610.52636-1-colin.king@canonical.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 07, 2020 at 04:16:10PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable rcqe_sz is being unnecessarily assigned twice, fix this
> by removing one of the duplicates.
>
> Addresses-Coverity: ("Evaluation order violation")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>

Fixes: 8bde2c509e40 ("RDMA/mlx5: Update all DRIVER QP places to use QP subtype")

Thanks,
Acked-by: Leon Romanovsky <leonro@mellanox.com>
