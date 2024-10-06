Return-Path: <linux-rdma+bounces-5255-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C1F991E8E
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Oct 2024 15:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F1B4B21497
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Oct 2024 13:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF8013EFFB;
	Sun,  6 Oct 2024 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiUQr9QP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0A66026A
	for <linux-rdma@vger.kernel.org>; Sun,  6 Oct 2024 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728221494; cv=none; b=cRTNBBXOZrOWaSSk3+wu/lRXFTkxEMibENrwZ6Q/b+KTW1xr1De3CmjK1GJ96md1TZzxFZgXvJjbxvF/xiIVpIoNdcdIW4GhXjnlkoZEwTDQ+rgnSz0hjevoBD/RWMe3zaExEkSU4jdDu3RAIhL2HJQoxuYa8St5N+fDl2+a/Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728221494; c=relaxed/simple;
	bh=xmhbcwZsLFYvg5MOiTzHVl0RjSFYnbj3gCeExT2gTVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8RmGuOrIk8rKpydkKcv4e3CWBQBw+FdrT6uBp+zbfVLenQYxJATG77rJIdaqQEu7svlCcCdBAzXnxWxQ3u3mjMGVa9RP7FQBBmkGN03v3VCbnITZCJvcWmInh8gKQLCcTfoCfHZXntff+JPc2V99yWjkc4/9h6EoKKuY7QAJMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiUQr9QP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576A4C4CEC5;
	Sun,  6 Oct 2024 13:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728221493;
	bh=xmhbcwZsLFYvg5MOiTzHVl0RjSFYnbj3gCeExT2gTVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tiUQr9QP0kxcXa0D0r5qmW+qp5eIU852vfwxU/gV0/eJ3o+9T7qSr1QyBMD3n3ZEk
	 vg84COVHDv6j5kymJq5YtKfQ2caCPjK/3hwFaH+dOBvECPiJm3ZBfl2qFj0e1cOy5E
	 T7x00uHVgKHQEyaNYzcN1WHU3F1tASEfz+uHhqgIWP3DQqWuPPAMfy4UPwGpMcRJKr
	 82/l/WrrccVO0hkDoaHX0+rf/Sgw0+ZFKb3mCHgTfjY9k8N/oF/+mUZ0GSUIdLEKPU
	 qZrNrVbxaijPev4xBRBJ2rMAanO2MI6SoECfz5DDiemH2RUKZgmaTOyadOiV9gQdWi
	 sEOUL4nV5WoEQ==
Date: Sun, 6 Oct 2024 16:31:30 +0300
From: Leon Romanovsky <leon@kernel.org>
To: IVANE ADAM <ivane.adam@univ-grenoble-alpes.fr>
Cc: linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: Performance issue for a simple RDMA PingPong
Message-ID: <20241006133130.GE4116@unreal>
References: <1837235494.9324983.1727941451114.JavaMail.zimbra@univ-grenoble-alpes.fr>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1837235494.9324983.1727941451114.JavaMail.zimbra@univ-grenoble-alpes.fr>

On Thu, Oct 03, 2024 at 09:44:11AM +0200, IVANE ADAM wrote:
> Hello everyone, 
> 
> I'm currently having a performance issue to synchronize two different nodes with a simple ping/pong algorithm. 

<...>

> I was able to test this on multiple configuration: 
> Linux version : 5.10.0-20-amd64, linux distribution : Debian11 & Debian12 
> We have a Omni-Path network, configured to 100Gb/s ( Intel Omni-Path HFI Silicon 100 Series [discrete] with the hfi1 driver) Firmware version: 1.27.0 
> Or a Infiniband network, configured to 100Gb/s (Mellanox Technologies MT28908 Family [ConnectX-6] with the mlx5_core driver) Firmware version: 20.29.2002 

Please work with your FAEs, they will help you to resolve the issue.

Thanks

