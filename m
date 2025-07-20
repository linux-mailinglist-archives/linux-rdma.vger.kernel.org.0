Return-Path: <linux-rdma+bounces-12319-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33792B0B431
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 10:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948513BA210
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 08:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F841C07D9;
	Sun, 20 Jul 2025 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQMPnWmk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DEC42AA9;
	Sun, 20 Jul 2025 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752999871; cv=none; b=iD553jc8M3N6UCsbIp6z05maUv67fpVhmvcYza7m6SHp/yZqdTNVhr8PsIxm+VG45n2DfcyfRengQax3367w0yFa0nZUCSWvpQKbEveiQwDIqt7pBVJg1zn30kyyhCx7IjO4i1BMyVq2EBAn0QGPZG+2hqotjwKU2fZEnWfNxWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752999871; c=relaxed/simple;
	bh=bUcE52Zt5jpJ3pvK2EgGE02MU+dzzUhh9d6v/2yi+m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hANlsOV5Qhm6BGDBg0YSONxm5gqmhdMJ0FQKTwETfymU6PVx9KxsIgHWAW08cb+Nu02idu5zACTohU5z+P0fzRlJG7lmjDjMmhTdNcZ0upxgRPkTRfaxW023ShCeGwx8gC+LighckZcCuYq5RzXKvCJul5D7rWOyu8hMibYv3Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQMPnWmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8660BC4CEE7;
	Sun, 20 Jul 2025 08:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752999871;
	bh=bUcE52Zt5jpJ3pvK2EgGE02MU+dzzUhh9d6v/2yi+m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQMPnWmkcBocUUhIT372pTZorV7c8tHqe8JJRewdvHa8YYo3XUWCJIrbwAIs014ha
	 HxUWPY5B5fzkeV/xgbYkKwRhgW0ENxkNyFY9b+IxeyusK79+ApBnxlpo9XLn+JHzqj
	 bxbIdMUylrharF5ROTVfp3c8Piv6XtHv8Zw7YqS19wHl3t+kXaYB4cVqLRGiee6V6C
	 MPxQLEXXs1WDl94GldkaGONjty3m7rT7JvuHCAxZbMKk4SzuOhYv7K8PW/decBUxsA
	 GKnegyz8MXZNQ4x7ho80hfTRhmDssHywNij6/q860c0ft0d4YndnD7F4hPUOxlFvCg
	 B3YryCbRd6JrA==
Date: Sun, 20 Jul 2025 11:24:27 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, longli@microsoft.com, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: add support of multiple ports
Message-ID: <20250720082427.GF402218@unreal>
References: <1752834048-31696-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752834048-31696-1-git-send-email-kotaranov@linux.microsoft.com>

On Fri, Jul 18, 2025 at 03:20:48AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> If the HW indicates support of multiple ports for rdma, create an IB device
> with a port per netdev in the ethernet mana driver.
> 
> CM is only available on port 1, but RC QPs are supported on all
> ports.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/device.c  | 107 +++++++++++++--------------
>  drivers/infiniband/hw/mana/main.c    |  13 +++-
>  drivers/infiniband/hw/mana/mana_ib.h |   1 +
>  3 files changed, 64 insertions(+), 57 deletions(-)

mana_get_primary_netdev() can return NULL.

You should check return value even it can't be happen or remove "if
(port_index >= ac->num_ports)" that returns NULL.

Thanks

