Return-Path: <linux-rdma+bounces-672-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8C8835F0C
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 11:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3931C22830
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 10:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE023A1A6;
	Mon, 22 Jan 2024 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgCY1wAg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E56B3C6A4
	for <linux-rdma@vger.kernel.org>; Mon, 22 Jan 2024 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917811; cv=none; b=nwLz6w21QRU6Ou29mniWL/xVCj1BtBcqp1PAHGhpOLlu2Z4jzlnUFhCKpllDL+WGxwCHqP5IBYDi5vEkiBEF4/i+9L1ZMMSsxImP0bGBgbeeIx9nRvArzhyIHb1BiNGpH9vTVgRsniBRBhqlzuqXdelTCWpoorgRwAX0Sdl7GhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917811; c=relaxed/simple;
	bh=rEF1CxWR+ottaYTVk9rAMQIiwDCm+6B3xLIJ/kqRujM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVOxW8TTPNnku401wDUoAwyHNmWMmcOa46amfrTXcmIvTj/ZQzFECMd4jFLSfoeljQpwEPK7Bm/YukNh7LaxSBVmjp4QToIjvSVIxmCyOFcfRjtKfbL9x5i/2O/dQrUFmHV2ooobbTGpvMyBFalUUmJIboeL5EwGMTG0Kh5inlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgCY1wAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E6AC43390;
	Mon, 22 Jan 2024 10:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705917810;
	bh=rEF1CxWR+ottaYTVk9rAMQIiwDCm+6B3xLIJ/kqRujM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HgCY1wAgE9Iy6QJd3nKBJuzZakApE88YwfXG7+Y3+GZioSzMchGpbEE08yUToQwsM
	 O0fLLCoujjN7StFRTyso0AAab2k2iYahGUJhQ3EzLpj+0VI7uWG6fuoGrFyHzhNuil
	 QxB2/ukt4At8hCV009TNrP0yMZYKo30Mb1ZkYFMap7Y16K6oAVkgxRZi//58uQ24SK
	 1agwNsoSuFLRTvMILupJvxlw+60tNx+6VMtM0P3PsoTLTGxDN2BrcUbb7UUHJv7kSp
	 +0ROJyrOK0xedIGm/Xltw49t25bWQeV/BJtinH/vFh3MkfevKNipNARlXfbe1SPy7N
	 m54g49n0EkO5g==
Date: Mon, 22 Jan 2024 12:03:26 +0200
From: Leon Romanovsky <leon@kernel.org>
To: =?utf-8?B?6ZmI6YC45Yeh?= <neverhook430@gmail.com>
Cc: linux-rdma@vger.kernel.org
Subject: Re: Questions about RDMA subsystem shared mode for RoCE device with
 MLNX_OFED driver
Message-ID: <20240122100326.GB7547@unreal>
References: <CAAoLqsQ-iHo4YwsHyt6MkBKE20Ze=DF4kkFKkDX9QCDiDC2+oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAoLqsQ-iHo4YwsHyt6MkBKE20Ze=DF4kkFKkDX9QCDiDC2+oQ@mail.gmail.com>

On Fri, Jan 19, 2024 at 08:31:00PM +0800, 陈逸凡 wrote:
> Questions:
> 1. Is RDMA shared mode supported for RoCE/iWARP devices? To be more
> clearly, ibdev ant netdev required to be in the same net namespace or
> not?
> 2. If the answer for first question is ‘YES’, but my test failed with
> MLNX_OFED driver, it does check whether user can access the netdev of
> the target gid attr, which means they(user and the netdev) should be
> at the same namespace. Meanwhile the upstream code dose not have the
> corresponding codes.

Please contact your support representative for MLNX_OFED related questions.
Linux RDMA mailing list is not correct place for it.

Thanks

