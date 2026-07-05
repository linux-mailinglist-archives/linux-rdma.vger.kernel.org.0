Return-Path: <linux-rdma+bounces-22765-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ycZyCxlASmoQAAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22765-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 13:29:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70278709D02
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 13:29:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Kqefn8fc;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22765-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22765-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2B0E301015E
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2026 11:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6613769E3;
	Sun,  5 Jul 2026 11:29:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648A8DDC5;
	Sun,  5 Jul 2026 11:29:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783250962; cv=none; b=MTceyCFVwyz6izzXjxKzHU2+xBfHBu2YmGLJSrL/HSMzZkDIOMXsVAxC238m1EjLxfhOwuCVrMxH0zDtrKCU4qu1gMI/5/1S9Jge3mTyX/R9I6gDvU9ijWig0LC2gG3qq8vpI7cqpSNy482nvT33r6SWeWzzp7YL287xVF76Rp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783250962; c=relaxed/simple;
	bh=AnSiRn5Mz+KaE+5vfLgi26j5InO1gkSSQ+L4NikMCGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdvVCWcsdmlnQPB2zOy5wKwWmYHH0vxgjJqDR3cJZX5R3lgnPU+lzKKN9/I9P2lapIWhsN1qFKlNgtTLPylsLQQQXujDkXdG1SmlqUD4cUip8gMauLjFw2HI6O70B04SXL+Y70N0BTEXXewowUNxRzh2kGWuz+nef0Jv0XWL1vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kqefn8fc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D721F000E9;
	Sun,  5 Jul 2026 11:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783250961;
	bh=iBRWHL1Dv4Qu26+bJrh6S9nes0enzYT8ggJ3P5MCRLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kqefn8fcKhATqEQkNd0a2laG/0F2dXy6UaPiADVUUChwPLgVaU+/y+GEirmqgcAcl
	 H3TWuMqOdrCewUngQt0K1rVXCF5x+5dJHdNWYSv1VvxDKRIJCgnb3v1HIQtZagzu76
	 HhBjKKLaCqMYQi8S2btIySyX75vNOqYlNTzZA44Y/Eht7uNqLwXBqzRfL7fW0IqPxv
	 encLgWZllK78vOAxKXxEoO/EKcG8Q3ZJZcYYa2ckXbNGQKeGkrS5Rixi0Fyn273yYN
	 c+Wv/GWNwDz9XJGBWkHj4KkyMbSNSU9FXnJzbj/HZhKqkbaSjxPwXG7qvdGSCTl5zL
	 KxuMazAqxGIaQ==
Date: Sun, 5 Jul 2026 14:29:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: zhang.yanze@zte.com.cn
Cc: jgg@ziepe.ca, julianbraha@gmail.com, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, wei.quan@zte.com.cn,
	han.junyang@zte.com.cn, ran.ming@zte.com.cn,
	han.chengfei@zte.com.cn
Subject: Re: [PATCH rdma v2 0/2] Add ZTE DingHai Ethernet Protocol Driver for
 RDMA
Message-ID: <20260705112915.GB15188@unreal>
References: <20260626165050955lBuUhmj0yLn5xCsQ-tbx4@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626165050955lBuUhmj0yLn5xCsQ-tbx4@zte.com.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ziepe.ca,gmail.com,vger.kernel.org,zte.com.cn];
	TAGGED_FROM(0.00)[bounces-22765-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:zhang.yanze@zte.com.cn,m:jgg@ziepe.ca,m:julianbraha@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:wei.quan@zte.com.cn,m:han.junyang@zte.com.cn,m:ran.ming@zte.com.cn,m:han.chengfei@zte.com.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70278709D02

On Fri, Jun 26, 2026 at 04:50:50PM +0800, zhang.yanze@zte.com.cn wrote:
> From: Yanze Zhang <zhang.yanze@zte.com.cn>
> 
> Hi maintainers and reviewers,
> 
> This is v2 of the ZTE DingHai (ZXDH) RDMA driver submission.
> Thank you Julian Braha for the review on v1.
> 
> Changes in v2:
> - Removed redundant 'depends on INFINIBAND' from Kconfig as it is already
>   wrapped by the parent if-block (Julian Braha).
> 
> The driver provides RoCEv2 support for ZTE DingHai network adapters and has
> been tested with perftest and rping utilities.
> 
> Best regards,
> Yanze Zhang
> 
> Yanze Zhang (2):
> RDMA/zrdma: Add ZTE Dinghai Ethernet Protocol Driver for RDMA
> RDMA/zrdma: Add hardware config code and improve driver init flow

1. Split this driver into smaller patches to simplify review.
2. Remove unused defines and functions from the driver.
3. The driver must be functional. It cannot operate without a
   driver ID.
4. Please refresh your
   https://github.com/linux-rdma/rdma-core/pull/1611 PR.

Thanks

