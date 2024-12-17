Return-Path: <linux-rdma+bounces-6563-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC4A9F45A7
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 09:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26F2188CF72
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 08:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C4D1D5AD1;
	Tue, 17 Dec 2024 08:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EtjEdEHp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4255E143723;
	Tue, 17 Dec 2024 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734422679; cv=none; b=cLRSrXCW0D1Q4DODKzTzWR0CTXMBvelOChhPQFuT+6MSFYMK3XJitCInMChH4iAMuONDnr6azCU4FRDsqrP2aEz3Oh5CQ4GfbUaRJIIHyKYM8xxAcA22vLp/K2befqJnZZCHqt20OBBwefi/mcBDJU/y+xkoK5ORjoCOy+oS6K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734422679; c=relaxed/simple;
	bh=0WNFZcCRtxdzdcKZD2RUn0ShHxYFlVtMrenesMJ0Ris=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVQUSPx77QqC9FVCn0prgOuhkLdHLBOBNSMDbtYVkE2e33bYO0648wShpLd33dmifiYFqOFy3LJcXLA0+VmHvrqi0CPOddg53JG12tlp3mW95C3m4g92bzsSPKQnwpIJfmooMiF/vesWBJfa9/Nc0Lm8afbbbKuC415r9QcB3Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EtjEdEHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D4EC4CED3;
	Tue, 17 Dec 2024 08:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734422678;
	bh=0WNFZcCRtxdzdcKZD2RUn0ShHxYFlVtMrenesMJ0Ris=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EtjEdEHpqN1dt6vNsb6hCfdIKbUolRK1rw9QWI1BCHT07CbuuFxID8KusPM/qqfyZ
	 tS0zRaFWWYpypegD/e7Y10HA3bcfNhm10j0z0+opE4UyN83DI6cY5xGdBtU00xzbni
	 ESx4kKOw8H50Qwhk4V7t//3s8nbNlHbUnZBy97gs=
Date: Tue, 17 Dec 2024 09:04:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ma Ke <make_ruc2021@163.com>
Cc: bvanassche@acm.org, jgg@ziepe.ca, leon@kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] RDMA/srp: Fix error handling in srp_add_port
Message-ID: <2024121717-trustful-opulently-c386@gregkh>
References: <20241217075538.2909996-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217075538.2909996-1-make_ruc2021@163.com>

On Tue, Dec 17, 2024 at 03:55:38PM +0800, Ma Ke wrote:
> The reference count of the device incremented in device_initialize() is
> not decremented when device_add() fails. Add a put_device() call before
> returning from the function to decrement reference count for cleanup.
> Or it could cause memory leak.

That is not what you did here.  Please be more careful when sending out
"bugfixes" like this.

thanks,

greg k-h

