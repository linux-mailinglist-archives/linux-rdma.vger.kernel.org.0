Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A51226C78
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jul 2020 18:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgGTQxb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jul 2020 12:53:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728894AbgGTQxb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Jul 2020 12:53:31 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FA5E206F2;
        Mon, 20 Jul 2020 16:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595264010;
        bh=51eX4RbjR13//bKG6t4MxC19Gu7Ke1ZC0a5OeTjjW1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AwG3zANqtE7QCznI2kYffT6Xx+Y9ZtJfbsEhwAtAuvi3YSAEVvH5g/REbeUX4vysE
         0KBKgjj/MjrTooSHIaqQMCfeW/6ESp67RHhPy2h0HYeyxZbmFKANwnuCZL1/gvWn7t
         Qm+f9cwP5V/ZHS0cMXBNWaldNgKEoRy/2z/ycvf0=
Date:   Mon, 20 Jul 2020 19:53:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Add missing srcu_read_lock in ODP
 implicit flow
Message-ID: <20200720165326.GD1080481@unreal>
References: <20200719065747.131157-1-leon@kernel.org>
 <20200720143105.GM2021248@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720143105.GM2021248@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 20, 2020 at 11:31:05AM -0300, Jason Gunthorpe wrote:
> On Sun, Jul 19, 2020 at 09:57:47AM +0300, Leon Romanovsky wrote:
> > From: Maor Gottlieb <maorg@mellanox.com>
> >
> > According to the locking scheme, mlx5_ib_update_xlt should be called
> > with srcu_read_lock().
> > This fixes the below LOCKDEP trace.
> >
> > [  861.917222] WARNING: CPU: 1 PID: 1130 at
> > drivers/infiniband/hw/mlx5/odp.c:132 mlx5_odp_populate_xlt+0x175/0x180
> > [mlx5_ib]
>
> Why do I keep getting patches with oops reports word wrapped??
>
> Do not wrap oops.
>
> Do not include timestamp in oops.
>
> Trim useless informatin

I'll try my best.

This note for INTERNAL review, please DON'T trim anything from OOPS, I
don't want to lose information just because someone was too extatic.

Thanks
