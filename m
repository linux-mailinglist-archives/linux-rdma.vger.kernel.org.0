Return-Path: <linux-rdma+bounces-14706-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 478D8C7DF2D
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 10:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCA7F4E2BC0
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 09:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48965299920;
	Sun, 23 Nov 2025 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1OgnJET"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034D322424C;
	Sun, 23 Nov 2025 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763891624; cv=none; b=Qr4PlS/Z10kt0MJv1IoWKjzWR6aqwaJKIJcG3vykpe4XstrQ76gbuZBE4JrLhY2FFnM3xNMurbZWiCU7z28J0sJap1em1LofRO3aJsTzPtrvd6oT0YAWAq3JhKJBocA8A9UcAFNJArXkJ0Ch3ZFF1Hhx07EwQRYFgRf4Z6AdWtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763891624; c=relaxed/simple;
	bh=4WDu+vLFrCl6L1F44PyIbGUV3/87Mt7nKs+7jfu+WnE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bsle4oI7LNW+f5C9HB3qm23LVSWpzOPiooGCdkflhciORwY7xj/fh7Ye19wzLrT/LWR9JYXrWYqVCKtAJlId8/RH+IpXSHDQToWLQ2Oz6WX7aLzHFev/NUKzrUZaGaoGmFH7MN6Bw0Z39OQ6odatJGkHujlzyWRcW5FKeaEfM8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1OgnJET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC45C113D0;
	Sun, 23 Nov 2025 09:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763891623;
	bh=4WDu+vLFrCl6L1F44PyIbGUV3/87Mt7nKs+7jfu+WnE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Y1OgnJETNXEmyOk6eEK9/OeIxaE79e2wi5TxslDMWbzeSpCj8pid0ayvBTR9mEg/H
	 48KMlVO4iN4lzUgwY30bYcjznu+9U4+XHPINcPDgCrCgFXovnON232WsfnwCV2bk+3
	 7sOiIA0+39otsBH5hrfG11xD9Ulgq5/p+sYuvhGxNSpA7kyQTNXlTjlBmfG6ncsgme
	 F+KxhO9t0ZlRrqopLTdFcTWjkgi+vMKEVWadfgCo+Fa4NilKnx0SHtIiNaFE8MLEOJ
	 VsqL77mYIl+ByA+XqOthviODKlU7WYwEQuRaS5KH8PNE6JCWfHyphUw36TlWun3Yee
	 NzzXqoTAa1mNQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Maher Sanalla <msanalla@nvidia.com>, 
 Michael Guralnik <michaelgur@nvidia.com>
In-Reply-To: <20251120-speed-8-v1-0-e6a7efef8cb8@nvidia.com>
References: <20251120-speed-8-v1-0-e6a7efef8cb8@nvidia.com>
Subject: Re: [PATCH rdma-next 0/2] Add new IB rate for XDR (8x) support
Message-Id: <176389162021.1784322.15127178596932198905.b4-ty@kernel.org>
Date: Sun, 23 Nov 2025 04:53:40 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Thu, 20 Nov 2025 17:15:14 +0200, Leon Romanovsky wrote:
> Nothing super fancy, just addition of new 1600_8x lane speed.
> 
> 

Applied, thanks!

[1/2] RDMA/core: Add new IB rate for XDR (8x) support
      https://git.kernel.org/rdma/rdma/c/9e119870a99e50
[2/2] RDMA/mlx5: Add support for 1600_8x lane speed
      https://git.kernel.org/rdma/rdma/c/45085ad3b2a358

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


