Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69BB3EFFC7
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 15:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfKEOaM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 09:30:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbfKEOaM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 09:30:12 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6028B214D8;
        Tue,  5 Nov 2019 14:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572964212;
        bh=JyhAvuI9xYpQM+SGSD5xqGtMqgtkBy4E96Wgjf5mP7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vKvMqMa2amnF6+cRLGcowJrS/zcYqKIg6kH5w1NdUX71TD9tI8BvYEug+xlRVhpBX
         Q8VvnU+jeQlL0eGV2SStVZRwSbQ4nFbGEZO58PLgVdbxT/S3XQRFqjfcwTAdfjDxKl
         zwqC/WMiO8Cz4rwS7vT/kh5VZPy23fkB+UFQMpyA=
Date:   Tue, 5 Nov 2019 16:30:08 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB: mlx5: no need to check return value of
 debugfs_create functions
Message-ID: <20191105143008.GC6763@unreal>
References: <20191104074141.GA1292396@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104074141.GA1292396@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 04, 2019 at 08:41:41AM +0100, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/infiniband/hw/mlx5/main.c    | 62 +++++++---------------------
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  9 +---
>  2 files changed, 16 insertions(+), 55 deletions(-)
>
> Note, I kind of need to take this through my tree now as I broke the
> build due to me changing the use of debugfs_create_atomic_t() in my
> tree and not noticing this being used here.  Sorry about that, any
> objections?
>
> And 0-day seems really broken to have missed this for the past months,
> ugh, I need to stop relying on it...
>

Thanks,
Acked-by: Leon Romanovsky <leonro@mellanox.com>
