Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACB61B80A2
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 22:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgDXU0j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 16:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbgDXU0i (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Apr 2020 16:26:38 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F4042214AF;
        Fri, 24 Apr 2020 20:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587759998;
        bh=F6hgGfn1OQ7snT4vz/4qxh3KrQ9Mk8F2aBcJMTj/TG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KOjE5/Qr2A/f2M9BbxTeT5lvvhQ9DJS+PQGu8Po4BDctq2yG4q6heOR5h260tHf7s
         dWCUoXo2yVho0xYxxFG0J5Q3XdgPvRIozU+dpctV01ogdjgOHp8VJ8VSPmpLhAYJfD
         vfoFXqBYiXZxkGmBI9kQImrtFU0zzQr81kQw0wcc=
Date:   Fri, 24 Apr 2020 23:26:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next 00/18] Refactor mlx5_ib_create_qp (Part I)
Message-ID: <20200424202635.GD15990@unreal>
References: <20200420151105.282848-1-leon@kernel.org>
 <20200424195426.GA29169@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424195426.GA29169@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 24, 2020 at 04:54:26PM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 20, 2020 at 06:10:47PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Hi,
> >
> > This is first part of series which tries to return some sanity
> > to mlx5_ib_create_qp() function. Such refactoring is required
> > to make extension of that function with less worries of breaking
> > driver.
> >
> > Extra goal of such refactoring is to ensure that QP is allocated
> > at the beginning of function and released at the end. It will allow
> > us to move QP allocation to be under IB/core responsibility.
> >
> > It is based on previously sent [1] "[PATCH mlx5-next 00/24] Mass
> > conversion to light mlx5 command interface"
> >
> > Thanks
> >
> > [1] https://lore.kernel.org/linux-rdma/20200420114136.264924-1-leon@kernel.org
> >
> > Leon Romanovsky (18):
> >   RDMA/mlx5: Organize QP types checks in one place
> >   RDMA/mlx5: Delete impossible GSI port check
> >   RDMA/mlx5: Perform check if QP creation flow is valid
> >   RDMA/mlx5: Prepare QP allocation for future removal
> >   RDMA/mlx5: Avoid setting redundant NULL for XRC QPs
> >   RDMA/mlx5: Set QP subtype immediately when it is known
> >   RDMA/mlx5: Separate create QP flows to be based on type
> >   RDMA/mlx5: Split scatter CQE configuration for DCT QP
> >   RDMA/mlx5: Update all DRIVER QP places to use QP subtype
> >   RDMA/mlx5: Move DRIVER QP flags check into separate function
> >   RDMA/mlx5: Remove second copy from user for non RSS RAW QPs
> >   RDMA/mlx5: Initial separation of RAW_PACKET QP from common flow
> >   RDMA/mlx5: Delete create QP flags obfuscation
> >   RDMA/mlx5: Process create QP flags in one place
> >   RDMA/mlx5: Use flags_en mechanism to mark QP created with WQE
> >     signature
> >   RDMA/mlx5: Change scatter CQE flag to be set like other vendor flags
> >   RDMA/mlx5: Return all configured create flags through query QP
> >   RDMA/mlx5: Process all vendor flags in one place
>
> This seems reasonable, can you send it so it applies without other
> series?

Maybe it is doable, but part II needs [1] as pre-requirement.
Do you anyway prefer me to do it?

Thanks

>
> Jason
