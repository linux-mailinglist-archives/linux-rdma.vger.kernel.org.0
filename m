Return-Path: <linux-rdma+bounces-10363-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E56AB8E91
	for <lists+linux-rdma@lfdr.de>; Thu, 15 May 2025 20:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454BAA077B4
	for <lists+linux-rdma@lfdr.de>; Thu, 15 May 2025 18:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93EE25B66D;
	Thu, 15 May 2025 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkYjEZJl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB4B25A646;
	Thu, 15 May 2025 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332625; cv=none; b=QGJXKrluqkB5+/8/drjxA6CkLh007m5KGDLCVrYnR1C+JXQ7V2zpkYk3Xd6g/MDYw8zH80EjNpQml4dCXR725sS9Y5aBEmYDeZ8z3HfrOuOE6an2gLHbVcS+O/6PlDyK0S7ns6f4QR3EZWDyS3IkIPCl9kahdsCLE5tNZWo+DBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332625; c=relaxed/simple;
	bh=+q0X30a1JXnygoSjEGexR26gtccDj34Q4azIccOlqBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fg6HYTyN419qEe2EP7hNc5MP0co4mmkk7rq18O7VJ4XFjVpMMNHTJyTpSioW0LsXj42QqRXLOiAfhz8KowVvWjZDbQrZR82JEcVNPKSy3OzZvhRHJaYGkGCx+EvRby36uHqI1F88X2Ij2q++Xn4foHe1ZEvUOuMbRFVibNNEg1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkYjEZJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FD6C4CEEB;
	Thu, 15 May 2025 18:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747332625;
	bh=+q0X30a1JXnygoSjEGexR26gtccDj34Q4azIccOlqBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkYjEZJlZEldthfWrYfv6v7KumXOQyzWyA484sg2McJi61TpH7VaKvV9eFEhRxPeM
	 eK3cEWQXGTPOfBGVwLVKh/m6whN2XGhFzSGzzITRV41sw1ITYLl2VXi/0KHNZ0ULgx
	 E2/jM1xGeiLCssinUabngwJ5wK5AS4dSpfP0PAgjK4LR/hWkqqD0StsisJ0TCQIIZs
	 gxDd8cert5lUrKYN5kziNDdNjZxmf+GaXJucFFVRDeFtChiZKhZrCiaXgjumsE1gya
	 61oYw5kzYHH+SPbhlz3oZMaeyklSSe+DxkpPKA7NKpm8NWvYZmENclBIPFQ5j4lrT7
	 8K3M9QaXSVp4Q==
Date: Thu, 15 May 2025 11:10:22 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 00/10] net: faster and simpler CRC32C computation
Message-ID: <20250515181022.GB1411@quark>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250513144018.18770280@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513144018.18770280@kernel.org>

On Tue, May 13, 2025 at 02:40:18PM -0700, Jakub Kicinski wrote:
> On Sat, 10 May 2025 17:41:00 -0700 Eric Biggers wrote:
> > I'm proposing that this series be taken through net-next for 6.16, but
> > patch 9 could use an ack from the NVME maintainers.
> 
> And patch 4 from RDMA. Please repost once those were collected and with
> the benchmarks you shared on Andrew's request. From networking PoV this
> looks good.
> -- 
> pw-bot: defer

Thanks.  linux-nvme and linux-rdma are both Cc'ed on this patchset.

- Eric

