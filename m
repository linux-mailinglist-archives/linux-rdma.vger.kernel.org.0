Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636A21F0A43
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jun 2020 08:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgFGGiQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Jun 2020 02:38:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgFGGiQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 7 Jun 2020 02:38:16 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9A31206D5;
        Sun,  7 Jun 2020 06:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591511895;
        bh=hjgqBKs8I5xfqLOw2CAF9mq9SLkbP+7OE/QANem/4Mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YUfdYQYmo5DWw5bY7vgI8wtaqcAWPNx1QvkWUgyJyY8+IYho1V61yrrRNJdF/CTUu
         Ln8GeYRktxvLTQByNjwHQGH9jNMJf5OAm9Aqga7fXjyERmjVlltVOi5T52uF6ZY4GB
         gDz6TPHG+n9N5TMoL6gT7+TP4D33EkUcn+pvzF3E=
Date:   Sun, 7 Jun 2020 09:38:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Tom Seewald <tseewald@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] [next] RDMA/mlx5: Fix -Wformat warning in
 check_ucmd_data()
Message-ID: <20200607063812.GE164174@unreal>
References: <20200605023012.9527-1-tseewald@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605023012.9527-1-tseewald@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 04, 2020 at 09:30:12PM -0500, Tom Seewald wrote:
> Variables of type size_t should use %zu rather than %lu [1]. The variables
> "inlen", "ucmd", "last", and "size" are all size_t, so use the correct
> format specifiers.
>
> [1] https://www.kernel.org/doc/html/latest/core-api/printk-formats.html
>
> Signed-off-by: Tom Seewald <tseewald@gmail.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks,
Acked-by: Leon Romanovsky <leonro@mellanox.com>
