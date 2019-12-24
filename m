Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 633B4129FCE
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2019 10:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfLXJsX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Dec 2019 04:48:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfLXJsX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Dec 2019 04:48:23 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20FB8206CB;
        Tue, 24 Dec 2019 09:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577180902;
        bh=wc+XRxSpnLul7GcXTe27B2aUJDVDrS3fPxi3cFC0Vj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYB3Nk+qHcdx7A3Rp7mc59wuHt9AJFn32NeF8GZPQ4olbQVIDWRKYo5NNvZbWcpan
         PLrHfiAHS3mxI9dJxhfNvRchXColsucC4dFNK/xnv1MNNKYqYGUCwh31opaTIzcx2m
         1j7E21AgQ1Wyzor0GbOeUosy9JkHqO+R+0PzH9tQ=
Date:   Tue, 24 Dec 2019 11:48:19 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     bmt@zurich.ibm.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 5/5] RDMA/mlx5: use true,false for bool variable
Message-ID: <20191224094819.GB120310@unreal>
References: <1577176812-2238-1-git-send-email-zhengbin13@huawei.com>
 <1577176812-2238-6-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577176812-2238-6-git-send-email-zhengbin13@huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 24, 2019 at 04:40:12PM +0800, zhengbin wrote:
> Fixes coccicheck warning:
>
> drivers/infiniband/hw/mlx5/mr.c:150:2-26: WARNING: Assignment of 0/1 to bool variable
> drivers/infiniband/hw/mlx5/mr.c:1455:2-26: WARNING: Assignment of 0/1 to bool variable
> drivers/infiniband/hw/mlx5/qp.c:1874:6-20: WARNING: Assignment of 0/1 to bool variable
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 4 ++--
>  drivers/infiniband/hw/mlx5/qp.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>

Thanks,
Acked-by: Leon Romanovsky <leonro@mellanox.com>
