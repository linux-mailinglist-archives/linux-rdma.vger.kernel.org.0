Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D003D212441
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 15:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgGBNL5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 09:11:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729177AbgGBNL5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Jul 2020 09:11:57 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E0EC20772;
        Thu,  2 Jul 2020 13:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593695516;
        bh=giOuJWzTkbHlW5F2N4y7TcNM6fnozOkTyNNF4tYNyLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MeT2PsfbjMC86fZNUKR8lHLwGTMPEqoxVC0OfcVXuwslXHP2lbhNrUCEGwN2BpMqC
         au6gNQq0WJ2FvURwr6xR8UPkIHjWS+2CiJTewMMV2AFslRLhBpUXZKl2dV+wyLWbyG
         88r72qSfRMZKBwjHduqYYOeGAh2B4oVnogY9y8eY=
Date:   Thu, 2 Jul 2020 16:11:52 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next 0/6] Cleanup mlx5_ib main file
Message-ID: <20200702131152.GD4837@unreal>
References: <20200702081809.423482-1-leon@kernel.org>
 <20200702130809.GU23821@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702130809.GU23821@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 02, 2020 at 10:08:09AM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 02, 2020 at 11:18:03AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Over the years, the main.c file grew above all imagination and was >8K
> > LOC of the code. This caused to a huge burden while I started to work on
> > ib_flow allocation patches.
> >
> > This series implements long standing "internal" wish to move flow logic
> > from the main to separate file.
> >
> > Based on
> > https://lore.kernel.org/linux-rdma/20200630101855.368895-4-leon@kernel.org
>
> Isn't this the series you said to drop? Can this be applied
> independently?

I asked to drop one patch in question, the one that revealed issue with
reference counting and convoluted error unwind flow.
https://lore.kernel.org/lkml/20200630145926.GA4837@unreal

It probably can be applied independently, but I didn't try.

Thanks

>
> Jason
