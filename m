Return-Path: <linux-rdma+bounces-9437-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E87EA89412
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 08:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7C41898BFE
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 06:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96372274FE6;
	Tue, 15 Apr 2025 06:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eJQyJh4P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vkHNJiYe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DFC10F2;
	Tue, 15 Apr 2025 06:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744699325; cv=none; b=YrOpLUrGJmfhxhn2matLhPqeCvZ8+6g1DJ4lZjZWLHQSzwD4zzGqdgAvJBXH3WSUXv0W2cBWygCeDqg8e5kV7qaq0aSqb51FaAOGKXw96KfZURVtV4sfXTx49aoX4Q3WR1V5H6gehenv2FutHtlWc/D/YHCbMk1j1g1nL5BOsIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744699325; c=relaxed/simple;
	bh=0p0Ko0PYLixwXFVovp7Vk4gNnBAomxKJKvB8ulTWsdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPK64BDbjFqUkrsC4L7ZRzGscK9FUPtOnKrOmbKLempoqhSIxTyW2WEKa9aujnD6TktunVscSxoOStpHdTLS4c+qeIgyOg/RZXuVzAITtSLi7JoSGDqw0Ggyq2IIyUMUDnwvM78tSMRKNm5g1f7Sc4kOdci/5DBhmu9TYGPkg4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eJQyJh4P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vkHNJiYe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Apr 2025 08:42:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744699322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zcIAga6GYfzSYtTDO27V82Rac8anYUyHC4H02k+lpNo=;
	b=eJQyJh4PDfD3MFybZK57HSiim6SrToWbG5vis+3yeZ9uaCDEfrs1/zbSr78EZdhDUZqCNk
	Zb6/iGTUh8vhK2//ahfE75aaTSwuo+npGWmBUM3RA3qj6pI7LkNvKFrBqcnQw5+I9NxgbK
	r4//3qKNtN7PlsoJNA45nC2bOEapn03Nie9UL7Wi+ePAMxRzEqI63hCy43JtHOv1WxpK49
	GsRer8kOiweAFl/VXWLzf3qUqrJnIaaXuHTwtBwpf+l51hxVG8iszaDWVsjWsAQR96dMIu
	Capvt/4r0j4sNdPTJSDsubtyM3mzzOeljZtVvRZghnIytaTK8FN07P1AyYPLVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744699322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zcIAga6GYfzSYtTDO27V82Rac8anYUyHC4H02k+lpNo=;
	b=vkHNJiYezAQSOxrKFxNBB4BL/zW1bwvyrhu4JqnD9CdZgyVlWlwHGv6AvwNgS/LfIMGT6K
	FJueRUo6PMOUBVCQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, 
	Loic Poulain <loic.poulain@linaro.org>, Brian Norris <briannorris@chromium.org>, 
	Francesco Dolcini <francesco@dolcini.it>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, ath10k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ath11k@lists.infradead.org, ath12k@lists.infradead.org, wcn36xx@lists.infradead.org, 
	linux-wireless@vger.kernel.org, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] net: Don't use %pK through printk
Message-ID: <20250415084125-a8677bbf-5fee-4670-8d4c-4afda6669e5f@linutronix.de>
References: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
 <9c53011a-0e00-49f8-bf7e-b04ddc8c575b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c53011a-0e00-49f8-bf7e-b04ddc8c575b@oss.qualcomm.com>

On Mon, Apr 14, 2025 at 08:02:39AM -0700, Jeff Johnson wrote:
> On 4/14/2025 1:26 AM, Thomas Weißschuh wrote:
> >       wifi: ath10k: Don't use %pK through printk
> >       wifi: ath11k: Don't use %pK through printk
> >       wifi: ath12k: Don't use %pK through printk
> >       wifi: wcn36xx: Don't use %pK through printk
> 
> the first four should go through ath-next and not net-next
> 
> >       wifi: mwifiex: Don't use %pK through printk
> 
> this should go through wireless-next

Ack, thanks. I'll resend it there when the discussions here are done.

