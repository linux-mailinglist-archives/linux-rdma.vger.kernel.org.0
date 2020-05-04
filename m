Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BA21C37BC
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2020 13:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgEDLK0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 May 2020 07:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgEDLK0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 May 2020 07:10:26 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A4DB20735;
        Mon,  4 May 2020 11:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588590626;
        bh=VAvwhQH07h5n7zDbiNIuWaRYB+KRt3bNInyfG47CGbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FzxknMPODQjwCAVzWPEl/dWYvpBKZWc1D2okprcqskRlMuqrky+UzdO9lSsgWEBiq
         EF7wZcCx/ypBWrpCepxXXxdAd3F7iw0Ypcu8wsey3xpIcCGETSftneimlH7CW/gUa8
         Nq7EVc5NoPLQuyro+AnE18jCI2gUCOYZDrhS6zVc=
Date:   Mon, 4 May 2020 14:10:22 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Daria Velikovsky <daria@mellanox.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next v1] RDMA/mlx5: Add support for drop action in
 DV steering
Message-ID: <20200504111022.GE111287@unreal>
References: <20200504054227.271486-1-leon@kernel.org>
 <3d2f79f8-bee5-6620-8f46-6f718c619dba@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d2f79f8-bee5-6620-8f46-6f718c619dba@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 04, 2020 at 02:04:07PM +0300, Gal Pressman wrote:
> On 04/05/2020 8:42, Leon Romanovsky wrote:
> > From: Daria Velikovsky <daria@mellanox.com>
> >
> > When drop action is used the matching packet will stop
> > processing in steering and will be dropped. This functionality
> > will allow users to drop matching packets.
> > .
>
> An extra dot slipped in.

Thanks

>
> > Signed-off-by: Daria Velikovsky <daria@mellanox.com>
> > Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
