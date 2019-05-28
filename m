Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 183B42C83E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 16:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfE1OBy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 10:01:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbfE1OBy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 May 2019 10:01:54 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF9D32133F;
        Tue, 28 May 2019 14:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559052113;
        bh=DNS9HBKYsW+rBcgfdPEl8z3csl2gMl5A4ceh0Wgm4UM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gf3w3Vm7BwY/pEAK+HEUChIyrZBYrhGvZ1N3oDFytvA/J4oy6ReJUrt1eRGe4Vtyy
         Vppgheq8RFLIdNoZLvwjYie0tPXeHUgUh25C2OoGGME1zhlL5YNovMVV4N/U5/sPz8
         25VAXSA8z34IDEoiCGYYQbFamRIcXUORh+Qghky4=
Date:   Tue, 28 May 2019 17:01:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Ariel Levkovich <lariel@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlx5: avoid 64-bit division
Message-ID: <20190528140145.GO4633@mtr-leonro.mtl.com>
References: <20190520111902.7104DE0184@unicorn.suse.cz>
 <20190520112835.GF4573@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520112835.GF4573@mtr-leonro.mtl.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 20, 2019 at 02:28:35PM +0300, Leon Romanovsky wrote:
> On Mon, May 20, 2019 at 01:19:02PM +0200, Michal Kubecek wrote:
> > Commit 25c13324d03d ("IB/mlx5: Add steering SW ICM device memory type")
> > breaks i386 build by introducing three 64-bit divisions. As the divisor
> > is MLX5_SW_ICM_BLOCK_SIZE() which is always a power of 2, we can replace
> > the division with bit operations.
>
> Interesting, we tried to solve it differently.
> I added it to our regression to be on the same side.

This patch works for us.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
