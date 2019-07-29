Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA907791B2
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2019 19:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfG2RCo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jul 2019 13:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfG2RCn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jul 2019 13:02:43 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24D642064A;
        Mon, 29 Jul 2019 17:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564419762;
        bh=VtS78KYiLlQsCM/5V3jqRjpqD+Z12mFUhLpPK/E+YN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rF2Hz3vB/VEA/OcVe+t6eJVUecYMZSj4sKIIS+QoqE1MKrBBqz3KXcwdk8N/FmUw6
         sWqf2qt2UJrMtWQHqeIP3qHtOk+HNkqVbmDR6vGSrqi11Zx0eCKjwNj1l4ovbKHj/K
         /pj0fRoTfI7XI8ljv5OiwONIMnANfZJm3VOxkZKQ=
Date:   Mon, 29 Jul 2019 20:02:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH rdma-next 0/2] Add per-device Q counters support
Message-ID: <20190729170233.GM4674@mtr-leonro.mtl.com>
References: <20190723073117.7175-1-leon@kernel.org>
 <c6070b365c50bdaeeaa6ab0f51408bc8ee760d41.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6070b365c50bdaeeaa6ab0f51408bc8ee760d41.camel@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 29, 2019 at 11:22:54AM -0400, Doug Ledford wrote:
> On Tue, 2019-07-23 at 10:31 +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Hi,
> >
> > This series is based on top -rc series [1] and may be considered
> > to be part of it, but can go to -next too.
> >
> > Thanks
> >
> > [1]
> > https://lore.kernel.org/linux-rdma/20190723065733.4899-1-leon@kernel.org
> >
> > Parav Pandit (2):
> >   IB/mlx5: Refactor code for counters allocation
> >   IB/mlx5: Support per device q counters in switchdev mode
>
> I don't think this series is really -rc material.  Too much churn for
> something where the user would have to actively go read files in /sys in
> order to even make any sort of problems appear.
>
> Assuming my build test completes, applied to for-next.  Thanks.

Thanks.

>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD


