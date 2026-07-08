Return-Path: <linux-rdma+bounces-22892-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7OKLNXIsTmpKEgIAu9opvQ
	(envelope-from <linux-rdma+bounces-22892-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 12:54:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 738C47248E9
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 12:54:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hBPUW6KM;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22892-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22892-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A15D2308547E
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 10:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2950E430318;
	Wed,  8 Jul 2026 10:50:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FA040803C;
	Wed,  8 Jul 2026 10:50:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507834; cv=none; b=stSDxqwbXHfmfraCyYuwkLp97aqnzCwjqkzRcR/Uy9337uTsvHw96SAeJABBaYmI18b/E8fTrxhVPEmHrzG13H0omz/fEEjMt0rmyhx1PkfFVHZ56IWZEq3lPsatK2RJrLivf35Ujpi59p8plu/AlYtAeoOQgWpO1P5CUwU1geY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507834; c=relaxed/simple;
	bh=H2J1gT3QNH8L6vwnlyMh8QSYC/bZKCr8nlU0sz+H24U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gb9pHeJLqI0VunzmJYXxedgb6Ep9hqUQ+bo/RRESvGJEdLRefpo+/tt9K/e1NH2YYVjCwmxTDOXsKoq/asMJWNEf7eZF58lS0QX4eAYPz82rb2iwPjE9WOfuTNH0XIDqgYkzdXR7YKdiggy9lgBw6uhjyBgFrixmoWID4DSMbK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBPUW6KM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A84E1F000E9;
	Wed,  8 Jul 2026 10:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783507823;
	bh=2CLcg3H7lDvVCt+p3j2pdMu36gi94T5nvB/ND1tSy+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hBPUW6KMeFoFZGuuSZVcnNK8SGmww0sxtlLAZyp9+JZtpodhvYy4otCnti8Lh2cxg
	 tYujRVNRB2BrF+0dY5fakbgE+IDHx3suC2oTA6KQsct48mAjl8x74XLqBRv4aFL1br
	 SNKHM0IX/p/1BHOPyNvxvcG/S0NDCa1qYfyf+7b15XC5+0B/Wub/OxODY8WLh6E80a
	 gQQJaiHFsL1+7DOFZedNn60aXxUKESGylh/7Ry8p94oo2aJHcKF3HEarQ7c92UZNXE
	 OPfdN/ZVg++tAY3WY3XvVQ7/BI6lQS6WXqlKyVB50ZzMT5fwLVYmNQeyZqi+KZDTuP
	 H5MrNEpHRHdLg==
Date: Wed, 8 Jul 2026 13:50:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
	jianhao.xu@seu.edu.cn, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, stable@vger.kernel.org,
	zilin@seu.edu.cn
Subject: Re: [PATCH] RDMA/hfi1: fix init_one() probe failure cleanup
Message-ID: <20260708105018.GN15188@unreal>
References: <20260705122328.GD15188@unreal>
 <20260706143424.145935-1-dawei.feng@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706143424.145935-1-dawei.feng@seu.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dawei.feng@seu.edu.cn,m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:jianhao.xu@seu.edu.cn,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:stable@vger.kernel.org,m:zilin@seu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22892-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 738C47248E9

On Mon, Jul 06, 2026 at 10:34:24PM +0800, Dawei Feng wrote:
> On Sun, 5 Jul 2026 15:23:28 +0300, Leon Romanovsky wrote:
> >Just move hfi1_validate_rcvhdrcnt() to be before hfi1_alloc_devdata()
> >and remove error prints.
> 
> Hi, Leon,
> 
> I agree that this approach is suitable for the hfi1_validate_rcvhdrcnt()
> failure path. However, it is not generally applicable to the other failure
> paths. The later failures still occur after hfi1_alloc_devdata(), so they
> still need proper cleanup handling to avoid leaking the allocated devdata.
> Therefore, I think the current approach may be more appropriate for this
> fix.

https://lore.kernel.org/all/20260708-clean-init-one-hfi1-v1-0-b9e9641268a5@nvidia.com/

Thanks

