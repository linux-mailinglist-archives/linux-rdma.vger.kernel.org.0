Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296B739DA8F
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 13:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhFGLFO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 07:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhFGLFL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 07:05:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E11960FE4;
        Mon,  7 Jun 2021 11:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623063799;
        bh=hQtUPBUvgpzuxWl0h3TPYmE+AWlHLm2PeRvlaKHbzRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=naTc5dcCNw7g/p5mXxtOBvGwR7ULpS5gybjLxRtKLfxhqtwcim4LYoPVKD1LJtoQF
         nwJZhPzUBQAuQP60SUeLv3ygnTt/zjznudzaQpkfplHufDIpKy1Zr+xXKgeUkzU1NA
         appZphbcsoxznQMhLQ/Ns1V41UDLb+1fvvZvz4Kq68A1sTez+2qI2668uPLkyusSfe
         HYc/0ETUPNiO3i6q6eXUjOBczhuZrEoIK4lmWiB5DVpE7iVwsiABlUWkd7CuYWTj5C
         3jCtsbYr6d3/SEs4hZFeJv+2GWEkOKnxnLhPaeHLIXpayArw6XS6hU7M8oqDMyz+pW
         0OElOO0PWEeMA==
Date:   Mon, 7 Jun 2021 14:03:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix qp reference counting for atomic
 ops
Message-ID: <YL389Dqd8+akhb1i@unreal>
References: <20210604230558.4812-1-rpearsonhpe@gmail.com>
 <CAD=hENcwwjS8X2R24+cFRyyrA5_k=F5LuC4bx1tzCVW969uvuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENcwwjS8X2R24+cFRyyrA5_k=F5LuC4bx1tzCVW969uvuQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 07, 2021 at 04:16:37PM +0800, Zhu Yanjun wrote:
> On Sat, Jun 5, 2021 at 7:07 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >
> > Currently the rdma_rxe driver attempts to protect atomic responder
> > resources by taking a reference to the qp which is only freed when the
> > resource is recycled for a new read or atomic operation. This means that
> > in normal circumstances there is almost always an extra qp reference
> > once an atomic operation has been executed which prevents cleaning up
> > the qp and associated pd and cqs when the qp is destroyed.
> >
> > This patch removes the call to rxe_add_ref() in send_atomic_ack() and the
> > call to rxe_drop_ref() in free_rd_atomic_resource(). If the qp is
> 
> Not sure if it is a good way to fix this problem by removing the call
> to rxe_add_ref.
> Because taking a reference to the qp is to protect atomic responder resources.
> 
> Removing rxe_add_ref is to decrease the protection of the atomic
> responder resources.

All those rxe_add_ref/rxe_drop_ref in RXE are horrid. It will be good to delete them all.

Thanks
