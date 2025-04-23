Return-Path: <linux-rdma+bounces-9714-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45296A9873B
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 12:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B39877ACDB1
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B33F266F15;
	Wed, 23 Apr 2025 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y+jRbLBQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BU3+R4iM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C768242D69;
	Wed, 23 Apr 2025 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403848; cv=none; b=nIdPgDWi/XzRVUvERfTJ0906W7TdIeKav1V6AyG0/SWOkWOGeX9qR6Ml7/z9FNMN6cJ8XW2JXI1HC7pH1UxtyAqvzrOB0I+WOLpNJaB5NkiEZbmHskc70uow0czNRewkHY9d49kjuf1KEQyBGYRRVWS5R68CedowT5wFaGhfEQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403848; c=relaxed/simple;
	bh=8BC5r9nCxmn/POTYq7cf5uAoU24Ba73dr0Z/8M4qJlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7a8ke1HvCbUNRcw9qlW7tbW202ZtFEKN+/SnLC0CsdpxOkI7UV4DqexY0s4HuTyoqyc1BSi2ZlIlO+mJLp4lEwueElpMRMo1BsUwDXDHV4AtMBFDDzaZsBGEJEW5AZe2EqoBwJ4M3jJ/IIdLdbR9e2JWiscmrxsOhDDh71z3eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y+jRbLBQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BU3+R4iM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Apr 2025 12:24:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745403844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TPRw+axkJFcjhHDTuYr2A1761jrA3Q28pCtIdm4HXwk=;
	b=Y+jRbLBQs2+InjYCQ4Z++bBUG9MV0g0zxRFd9ZCp46H+PaxA0ZsGIAfZlY9v2eFUBbhQx8
	i8a0r6+d0gujrN9/7tp1XBSZ2AULSIoISAPdqqEZMK58YyykGkl9W/JnCvj2fVvYFpLEzW
	ekQQF0XzSxjmvAzaq4BsIgcXz+QTBdzZtpCsFReLqx4PY317oSKFCFGLDvBE5B0XDH9HY6
	2msUwNiqyC9YZ7ITP2h9QwDcwzR3b+s7qpbA0JMBTphusnnmwOeKFXiir9Pj5XPqPDzHIm
	JprZJnuH9fnQ192Lv0sOz3FUAJxMNsQ7MYO2gB3T3RXRoj3euNAwOr8GhWn9Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745403844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TPRw+axkJFcjhHDTuYr2A1761jrA3Q28pCtIdm4HXwk=;
	b=BU3+R4iMWPq9T0tBiL9gRULUwfm5F3Eyioai5no9cNVZphwrC76xgcxzWrjZpm2dIf3hg/
	cbDQYxlg2XG2vqBg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 0/2] net: Don't use %pK
 through printk
Message-ID: <20250423122301-64a5773d-a3cf-4e21-9f24-04294ca4eeb0@linutronix.de>
References: <20250417-restricted-pointers-net-v2-0-94cf7ef8e6ae@linutronix.de>
 <4918f292-46b5-491f-a8da-5d42432bde56@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4918f292-46b5-491f-a8da-5d42432bde56@linux.intel.com>

On Thu, Apr 17, 2025 at 03:39:13PM +0200, Dawid Osuchowski wrote:
> On 2025-04-17 3:24 PM, Thomas Weißschuh wrote:
> > acquire sleeping looks in atomic contexts.
> 
> typo? s/sleeping looks/sleeping locks/
> 
> present in patch descriptions as well

Thanks for noticing. I fixed it up in my template now.

