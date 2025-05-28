Return-Path: <linux-rdma+bounces-10849-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAB9AC68DF
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 14:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96654E3129
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 12:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0AF283FE2;
	Wed, 28 May 2025 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmJ4P4Lt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD48E27C872
	for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748434296; cv=none; b=Phe+fFfep4Wd5LNarNjdb6LY7QOPNChzXVm+VoPPfHOAscHaeyAnJ04FFWJzMxagJJYqqHWCAPvcSi//RHiWenveUV9KFezHrptx2/0ys+qXrkZd78bD2o7vdAxjbgEFikdc8DHHInjQ7PloolwlIfZY6Mpm0XpspZh+vX1uDRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748434296; c=relaxed/simple;
	bh=Xnu7P9FjsgMPy2AEMXic42Vn0msYgD9I4pS52AlBfOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJu2foQ0yZuqIFWv9c2smbunvcouVNy93QTIi5+NHTFD8J6A3lw1yjUYtSR6Pw4Z4Y3LJOhMxvuaJmcPQWhl0r+WVTqqEIejJLoX2klqeb5VS/uLfX9d5Rp/170yDW8a4SoFKcL7s5TtBLyoG9NtOIiHHEBzjEJnDRMpm1pRY1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmJ4P4Lt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA7BC4CEE7;
	Wed, 28 May 2025 12:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748434296;
	bh=Xnu7P9FjsgMPy2AEMXic42Vn0msYgD9I4pS52AlBfOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZmJ4P4LtB7HWp7bqPey/U/+twrcqC576tL/2eZ+rEOJlQEOm6gqsiHTxTtWbQVKUf
	 pCRZ6GwZ+64kPCZj7ROnRLTxW5eMMH/X3QmPoFgnAHZDXaJmblmINFZ+NgYxB0+GI2
	 kgPqaRnRlq5K74OdqbvnwXkQbbmCi2wnrSFPf/u/jJWadSsLCdTUS3DMVY/g/xCQsP
	 OiW6ua8r5/PJHq4g6Gtb+Ch6MUCujsCVaEgDhx9MG7AeV34vdMCRbKkEzYzLKPiG75
	 b89tc6gflnO75j467FiLC6L0uvnzfosL8t7hj70TEPD5h+5oNiwEUG8vlMWgNu/P70
	 /1ejK/wb5+BJw==
Date: Wed, 28 May 2025 15:11:32 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/2] Remove ancient qib driver
Message-ID: <20250528121132.GA7435@unreal>
References: <174836066896.2436819.16982870133237201013.stgit@awdrv-04.cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174836066896.2436819.16982870133237201013.stgit@awdrv-04.cornelisnetworks.com>

On Tue, May 27, 2025 at 11:46:02AM -0400, Dennis Dalessandro wrote:
> Time for qib to go bye-bye.

Thanks for doing this, it is too bad that you sent it during merge window.

BTW, can we get rid of rdmavt later too? Do you plan to reuse it?

Thanks

