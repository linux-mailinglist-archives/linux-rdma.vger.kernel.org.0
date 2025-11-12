Return-Path: <linux-rdma+bounces-14439-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAF7C52039
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 12:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A85A3A9C48
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 11:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1F31C2BD;
	Wed, 12 Nov 2025 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsJyWf8R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB05630DEC7;
	Wed, 12 Nov 2025 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762947012; cv=none; b=FaDe/TkfNgamfBRNs4ud8uRUFXxY69hw1J4yUjC5jFzfmP/9bpXsLEE6gkc6xTGMEvSIeF7wU6CI+zTtbLdVf8l1bnGuv8odQgD2UCez3OBAdk+Afp91Ya6DvWpIQ73j3bQzn/isXAsGYCnl9I2b05bjKvI1vBx6cjTI1Oj678Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762947012; c=relaxed/simple;
	bh=5NcL0onrz85oA6rav/6xZTGHtyFk94xzteC1b/nZZt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdHz6FINmZ8jrEBB1Ikw6diVhwkE3izu5pbB2CHvI5JhFxO/ZwEK5C4LP/17io3PmiMUEhZm9L2DMtSUuygtLocduuiHUPX3zYrGve4cpKGrOsPJudqmsdgXn/UBmUgjBMJX1iJq5xV/NJp2KvqZT3P3eTiBoT+9zCJ/8U8vSMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsJyWf8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD6AC4CEF8;
	Wed, 12 Nov 2025 11:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762947011;
	bh=5NcL0onrz85oA6rav/6xZTGHtyFk94xzteC1b/nZZt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TsJyWf8R0fbynnMDd+ZYx22ydqx97+0R3B4GVH4lUdL9TEEMpvn/3OPTy653VFXNT
	 YugY8u07wfx+UNN8R0QYGfajzzuD4rPGQeVB/1dFA8p7kokXUfoPNXxMo7xI3N9/fZ
	 vCQT9qP4WHVOVWLuHgqvSm6cdl46KvhWhFp3R5+Yqi9j51t9dZRoAsVtOaD+yeUyQM
	 i1jYXLvneqxiMy+S2C1j5rJHgQV1o8mfdxcFQgGxtRyFC338kV356tFVBOQe0iWKhI
	 u/RDgNiTtEe+aptaIpH0dbk698X7dAnjd9YlDm7VYTgZbKex9VDwtLmeZrfCaVMf3A
	 vw7+hCYUKmzFQ==
Date: Wed, 12 Nov 2025 13:30:05 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Tuo Li <islituo@gmail.com>
Cc: krzysztof.czurylo@intel.com, tatyana.e.nikolova@intel.com, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: Fix possible null-pointer dereference in
 irdma_create_user_ah()
Message-ID: <20251112113005.GC17382@unreal>
References: <20251112074513.63321-1-islituo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112074513.63321-1-islituo@gmail.com>

On Wed, Nov 12, 2025 at 03:45:12PM +0800, Tuo Li wrote:
> The variable udata is checked at the beginning of irdma_create_user_as(),
> indicating that it can be NULL:
> 
>   if (udata && udata->outlen < IRDMA_CREATE_AH_MIN_RESP_LEN)
>     return -EINVAL;

Just delete "udata" check from this if(). irdma_create_user_ah() always
receives udate.

Thanks

