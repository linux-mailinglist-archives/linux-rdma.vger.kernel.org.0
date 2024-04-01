Return-Path: <linux-rdma+bounces-1704-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECADD893AC0
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 13:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80B9BB21719
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 11:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7348E21A0A;
	Mon,  1 Apr 2024 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToaB1wA5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3099C219E0;
	Mon,  1 Apr 2024 11:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711972432; cv=none; b=flcpVPaRyxDRNafmJKEXr35r0Q/a//OVbQE/kt3PpNblrm0EHDXbe4R20YO131moGazA5BSQQpIqAB6rRNcYbAz9bpRzwypuuSXwj2L4/A2xRs13Ri+qXwJEANWl/LKnMJWS+4MnqIJUJUUaSpfVu9eQwIOP35/aW5h+UTFuNHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711972432; c=relaxed/simple;
	bh=BeyIIZe+gftamRnznrps10v2YP0dN37xtl8idY9zoK8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qf3pFT4u4x3gXHEcyhlmZ9rh+uVTuw5twoeBFTGHzFSK+ce74q9rslTtufYimLcN8TqOEQCEhy9f9R9UF07SUYSfxMC+WWx/u06N+605A8xOlnYOz0j6V+VXv2rWzbRagKoM3E4CpgaJbg8wTEC4GiCF1JWfYQuQf01SxYrRDWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToaB1wA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472E1C433C7;
	Mon,  1 Apr 2024 11:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711972431;
	bh=BeyIIZe+gftamRnznrps10v2YP0dN37xtl8idY9zoK8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ToaB1wA5b0M7IoWSUmnzHo8Yx82Xh2nZ61kDkIJc/vZTpJB0HAU0SnwCDxfZG07L0
	 BIpY6mt3rD/WAJ+nk0TbUYOCS4URHSazDA5X8wVTasy8lZYeoNbIYISFUs2kIbnInX
	 wVVx0EzfMVF7yhSRgjkxbiG7Tvbfd88bbEexK94rXaJUqhXwITMFcY2OAb3zNyEOKI
	 XY3LnZVLiH09KxcDvm8aGkHez4STy2UhcNtovLVZlrpkKu0/m6nbDBAF3Q5RpDu8k7
	 n5CZEOUsuIMv+7hxkFdQx1elgW9FmKCLSZU35fiYlexGkJPuY3G/+p0fc1bVIhkL5t
	 2ZJlU2fDwTMng==
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, keescook@chromium.org, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240319090944.2021309-1-leitao@debian.org>
References: <20240319090944.2021309-1-leitao@debian.org>
Subject: Re: [PATCH v4] IB/hfi1: allocate dummy net_device dynamically
Message-Id: <171197242851.77676.14242528699640486562.b4-ty@kernel.org>
Date: Mon, 01 Apr 2024 14:53:48 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Tue, 19 Mar 2024 02:09:43 -0700, Breno Leitao wrote:
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_device from struct hfi1_netdev_rx by converting it
> into a pointer. Then use the leverage alloc_netdev() to allocate the
> net_device object at hfi1_alloc_rx().
> 
> [...]

Applied, thanks!

[1/1] IB/hfi1: allocate dummy net_device dynamically
      https://git.kernel.org/rdma/rdma/c/c965b039a750c4

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


