Return-Path: <linux-rdma+bounces-17036-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE2WFgNymGkoIgMAu9opvQ
	(envelope-from <linux-rdma+bounces-17036-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 15:38:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA39A1686E1
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 15:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 629E53017528
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 14:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBB227AC4C;
	Fri, 20 Feb 2026 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lZOMGlXw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E127FB1E;
	Fri, 20 Feb 2026 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771598334; cv=none; b=rj8295WM079DX9OuN4Dt3KZiTlHW+xdL8Cr0ykPDKnbXiNfh9/r4MOYTaxALCVfZk/Ekr1eNIgGGNyc6/RFUsLCDqDIi4UO9xRgkVCPE7d03Gbj8pJ2S7SJOtuqPCjHqpJCjSvBrp1do9DkFikjG8rZqDEb4Ep4LzUWUDqpYVHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771598334; c=relaxed/simple;
	bh=ZQKZIuANss7mRdxhtQSOp+rsWdIqBBpVrgYTVUFdqlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9dROGuKULaaHtfnTlXWVlWk+Hq/pnDm3c2qfLDttSu1ucSBB6V2RbO/5wRij+IYcvw0+UFZqQE1Yi6VijlR1Cz86SA8mJTy7p7zVKa14jasPTyrwW7VmMQ3dglAJ3g35/sAwgglpneVX/qr6Lz5fYD0UB3E1XGOZ7Ok1VSGwNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lZOMGlXw; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (unknown [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F2E78C16540;
	Fri, 20 Feb 2026 14:38:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0D2895FA8F;
	Fri, 20 Feb 2026 14:38:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6076C102F19B0;
	Fri, 20 Feb 2026 15:38:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771598315; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=5N0Tr9nEeyaGCQQ1ZP7M9zIXF5VdXQNEcmOJxKptgNc=;
	b=lZOMGlXw/CXIUOZHqXdeFVLJ4H5+Mgmjxgcec9SLP4FGH7A7/P27dxhwFTxr14Wchikqjx
	L1CMT7hZJXbv6+qf9kHA3vx/A80D/8Tk18PM01/6uLZQ5irUP/pxRpbMQY+YifD5SKOobj
	YX6LTOgyDb6HwXdeV/1+a2pKNLJ4wwLI6J6G/ubJvsvhRAWDhJLKFrA+WHQ2/kKJKnnAKe
	IPV637cNu/AxC5jvEuD69nrzstOQlusfhEACPXSHz5OUIFwhoP1hemWgUOtr8LU+7QV3ln
	UVsSOwMq2g58hivMuaZJVag3vejx4Pqf/IgEiz/Z0/g3WCUU5PlgnHa9rTSsUg==
Date: Fri, 20 Feb 2026 15:38:32 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "yanjun.zhu" <yanjun.zhu@linux.dev>
Cc: Heiner Kallweit <hkall@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, driver-core@lists.linux.dev,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-rdma@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH RFC 02/10] rtc: prepare for struct device member groups
 becoming a constant array
Message-ID: <20260220143832ea0e1754@mail.local>
References: <5d0951ec-42c9-453f-9966-ecca593c4153@kernel.org>
 <95e5af90-ed53-4009-a4ea-19ed04499ecc@kernel.org>
 <392127ee-11ad-4517-bb72-91af64fd191e@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <392127ee-11ad-4517-bb72-91af64fd191e@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17036-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexandre.belloni@bootlin.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:url,bootlin.com:email]
X-Rspamd-Queue-Id: CA39A1686E1
X-Rspamd-Action: no action

On 18/02/2026 16:53:00-0800, yanjun.zhu wrote:
> On 2/17/26 2:26 PM, Heiner Kallweit wrote:
> > This prepares for making struct device member groups a constant array.
> > The assignment groups = rtc->dev.groups would result in a "discarding
> > const qualifier" warning with this change.
> > No functional change intended.
> > 
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > ---
> >   drivers/rtc/sysfs.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/rtc/sysfs.c b/drivers/rtc/sysfs.c
> > index 4ab05e105a7..ae5e1252b4c 100644
> > --- a/drivers/rtc/sysfs.c
> > +++ b/drivers/rtc/sysfs.c
> > @@ -308,7 +308,7 @@ const struct attribute_group **rtc_get_dev_attribute_groups(void)
> >   int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group **grps)
> >   {
> >   	size_t old_cnt = 0, add_cnt = 0, new_cnt;
> > -	const struct attribute_group **groups, **old;
> > +	const struct attribute_group **groups, *const *old;
> >   	if (grps) {
> >   		for (groups = grps; *groups; groups++)
> > @@ -320,9 +320,9 @@ int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group **grps)
> >   		return -EINVAL;
> >   	}
> > -	groups = rtc->dev.groups;
> > -	if (groups)
> > -		for (; *groups; groups++)
> > +	old = rtc->dev.groups;
> > +	if (old)
> > +		while (*old++)
> >   			old_cnt++;
> 
> The change from for (; *groups; groups++) to while (*old++) is not
> functionally equivalent. In the while version, the post-increment old++
> executes even when *old is NULL. This leaves the pointer old pointing one
> element past the NULL terminator. While old_cnt remains correct, this is a
> side-effect-heavy idiom that differs from standard kernel patterns and could
> be fragile if old is used later in the function.
> 

Thanks for pointing this out, I agree we should keep the original for
loop.

With that change,
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>


> Best Regards,
> Zhu Yanjun
> 
> >   	new_cnt = old_cnt + add_cnt + 1;
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

