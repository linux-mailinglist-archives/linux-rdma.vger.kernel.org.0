Return-Path: <linux-rdma+bounces-3480-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEC9916F82
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 19:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC49A1C22F7E
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 17:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7F4172BC7;
	Tue, 25 Jun 2024 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9EpkWp6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89C4437A;
	Tue, 25 Jun 2024 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337522; cv=none; b=jKjth+5hbAek2t32jZV6kARf97jNVJHckXZPGxbl1y4VFGNpf02NmEyQF/kz6YjuqONfPmfFvFjlWrcXJfA3cWqnl4tHZh2C7anZfik+qN7nf3qydCuA0yJSeQqo8Na0UGcQcIopoeuPiFixWRprSG2vKTGTUPKUi4HzZKSwXOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337522; c=relaxed/simple;
	bh=3juEGBiQ0BSrKT3CulYrFtDalEOYotCXZj3U2euRQMA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bHTvnazQAb4E63pnApnhN49MTRaxF0hXkw0IMkwasWz+lnyh8na+6v1RPCOEPh6+48xHbjEgQu+bW82GGjA0setLCRUa/JB7jotTifkFjJQyS8KaMNUlCTzS7EDb/cM8Skqqpvdpm7EyKW0Nv7kL6HMNpx6RoNJ/sGb1uARq98k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9EpkWp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71874C32781;
	Tue, 25 Jun 2024 17:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719337522;
	bh=3juEGBiQ0BSrKT3CulYrFtDalEOYotCXZj3U2euRQMA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=n9EpkWp67ouvx+rGC2qwzAr0gQpCTZGKe9NRP+i0p33idMEjaZ0GZ+trKm62pc+Xd
	 e39vFQHH07/YbC8LuahI623ocrlMjua4LZ0R0VtgStyXhz+OFrquuLhm+oyQKPP/Qy
	 EtYBryaTAVzroSM4pGAjFzTByYM98YjESVwy1zeaKbg1Ngh7VUUuX3Il3CPzOQjTCv
	 u7B9LLPrfFfJN2DBQMlEZb4gkkOxJRXGibgPJV4hp/fYsiMW8UOBARqXdpwy8yDIxk
	 gfyvvo5T2qRc+bgBwmthy0fFe7gh3aFabV8ncUT3sv1GV+Jdn2TaFHKIBijAPfUrG8
	 Q1lpDbsepvl/w==
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-rdma@vger.kernel.org
In-Reply-To: <b826dd05eefa5f4d6a7a1b4d191eaf37c714ed04.1719259997.git.christophe.jaillet@wanadoo.fr>
References: <b826dd05eefa5f4d6a7a1b4d191eaf37c714ed04.1719259997.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] RDMA/hfi1: Constify struct mmu_rb_ops
Message-Id: <171933751680.963586.6452376643796322440.b4-ty@kernel.org>
Date: Tue, 25 Jun 2024 20:45:16 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-13183


On Mon, 24 Jun 2024 22:13:27 +0200, Christophe JAILLET wrote:
> 'struct mmu_rb_ops' is not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   10879	    164	      0	  11043	   2b23	drivers/infiniband/hw/hfi1/pin_system.o
> 
> [...]

Applied, thanks!

[1/1] RDMA/hfi1: Constify struct mmu_rb_ops
      https://git.kernel.org/rdma/rdma/c/ccf238c8da1511

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


