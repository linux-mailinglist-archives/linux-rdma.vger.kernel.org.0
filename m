Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3382FB132
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 07:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbhASGOY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 01:14:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387894AbhASFhc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Jan 2021 00:37:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F32B207A0;
        Tue, 19 Jan 2021 05:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611034603;
        bh=vBIvNQ4pvRcKNaNvSN89j2YjPGarRzFsXCywE520Ws4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UepkQPv/v3JLhMERQOqJbz44DTuJzE+uy9TYk8Ml0b+ivaq5hdiHR7Uvln5bPBGdK
         5b1zetGz8psiIM7ADnHt989qlzEN99itJWPskoGLxzupZeF2xuHgvfZDL23pUnGM2l
         Pa+HiLUD1revZPagTG0pJy5gubrg4jVSjk33C/3kdVn1CL69Sys4aBaz4raMYRKqW7
         tjBJE9j4aJ4C0lVie9qjHUMq1bTjW70ijCxfXHydY+Qh7W+O6/Rwmw97+w7VIWxHp1
         EZv7VZZE6tB7J4NIvUv9t+HvYqWu4SdyYw6NIjXyz/aA5AODClaPpH2NxLQ01bdBbf
         81P12aXuW4G2A==
Date:   Tue, 19 Jan 2021 07:36:39 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH mlx5-next 0/3] Cleanup around DEVX get/set commands
Message-ID: <20210119053639.GA21258@unreal>
References: <20201230130121.180350-1-leon@kernel.org>
 <20210118200031.GA729141@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118200031.GA729141@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 18, 2021 at 04:00:31PM -0400, Jason Gunthorpe wrote:
> On Wed, Dec 30, 2020 at 03:01:18PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > Be more strict with DEVX get/set operations for the obj_id.
> >
> > Yishai Hadas (3):
> >   RDMA/mlx5: Use the correct obj_id upon DEVX TIR creation
> >   net/mlx5: Expose ifc bits for query modify header
> >   RDMA/mlx5: Use strict get/set operations for obj_id
>
> This looks fine, can you update the shared branch with the ifc update
> please

Thanks, I added only one commit ab0da5a57188 ("net/mlx5: Expose ifc bits for query modify header").
Other two can go through rdma-next tree.

Thanks

>
> Jason
