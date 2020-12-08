Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B488A2D23C7
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Dec 2020 07:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgLHGpU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Dec 2020 01:45:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgLHGpU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Dec 2020 01:45:20 -0500
Date:   Tue, 8 Dec 2020 08:44:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607409879;
        bh=945L8ljNOuFzzRfnEh+kXCUa029xewKJnPnsaYRdk0o=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=stVnIgDZ45/X9nUWqzxcDFaZlQA5OQ8rk4HX/IWyAjtxT0gh6SpfAynHxRfbk7U3X
         l45qSeXO9QbsG1sC0vQSQpMi5ydLdwaNgqsXY9utR+Upx6XkZOBZl9KXWOv+2IS1oj
         QRiT+KV0NO+zWuu0y+YzMjg9Z0eHGdoA7ROT6sIOM+J3VhYENdbt5EhLYycEMmZE8Y
         I3XfinKzU0N2DrDQF1UsWBYI7fA+UPBw/jafzNW2VNSY3b7uzEO3zUMhwk0EFpTvHM
         Sm+ED7qeKXAiq7fYSKi9U7tTo+YsvA5ozPuYn5QoOt95NTSgqA4uFicyt4HC36QGTX
         Ef3imcBLHYJKw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] RDMA/restrack: update kernel documentation for
 ib_create_named_qp()
Message-ID: <20201208064432.GD4430@unreal>
References: <20201207173255.13355-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207173255.13355-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 07, 2020 at 06:32:55PM +0100, Lukas Bulwahn wrote:
> Commit 66f57b871efc ("RDMA/restrack: Support all QP types") extends
> ib_create_qp() to a named ib_create_named_qp(), which takes the caller's
> name as argument, but it did not add the new argument description to the
> function's kerneldoc.
>
> make htmldocs warns:
>
>   ./drivers/infiniband/core/verbs.c:1206: warning: Function parameter or
>   member 'caller' not described in 'ib_create_named_qp'
>
> Add a description for this new argument based on the description of the
> same argument in other related functions.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
