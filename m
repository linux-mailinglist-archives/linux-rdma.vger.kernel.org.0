Return-Path: <linux-rdma+bounces-19293-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HHRG8oB3Wk3YwkAu9opvQ
	(envelope-from <linux-rdma+bounces-19293-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 16:46:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A18083ED7DF
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 16:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93074300B9F6
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 14:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF7E3E0238;
	Mon, 13 Apr 2026 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctmBTqxv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4463F3E023A;
	Mon, 13 Apr 2026 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091576; cv=none; b=Edqn2UsobaymX/eR25cyjHC1nXgGakosh+JPodZHKqA3HlCOaZY05T17FCXl66j5Hmxo1F1hnMDMj+aBqz2+/QPcOaicG0K2iMjSnwZjdOLHkb/Fpceqgkt+SHT5JIqjFTlli0g+2kMFMNNKNHyh1/xlO9Zf5nYDWCZtmgginNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091576; c=relaxed/simple;
	bh=LX76nBcia05Wypmo3qmaTIFtWpzCvXEJ000jmQNoSI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBOIgqadv9q6fzojDh6SbgQGVmV48PjAeikYO38HDt6uehlcns1LYqU/CIbnpTE4T0pMDsSuo19fZbUR6sAX7W7C8+rLSXRkILf1Jyn0y2Gb3wSNhJVNeSgs+XiS5bPr2jbNSTB/wUPGwFVxvfRJh2N3dmi9Te1uBeWlS3pJk8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctmBTqxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D59C2BCAF;
	Mon, 13 Apr 2026 14:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776091575;
	bh=LX76nBcia05Wypmo3qmaTIFtWpzCvXEJ000jmQNoSI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ctmBTqxvhL/I41q7h7vEd5mKgYRgzi7E5nWeenFaoubGHe6g30pwd281xsMdeCBS3
	 mEltFdK109vL37BrqeTfmiZQg4iGB4X4f6YgMaVcNE9t/MLf6YRhEUEQPOEYET1eW6
	 mVk2Nb9vIodVaSnJk4OXku+zWHQGyswW7kJyLuk0z/MzEy0ZLLI+HDIHyg2Qlw72fz
	 BKZiq8/+ErYBA4eAT5sXrXFZ8H3vJKe8SlTdJCmY+/zI6VLfhQndHqoASR8I2EaDLF
	 FDfHbE7ayvzvNu6sgLvCYzI1WruV/y2UvKiXhCBFbBiW2IY/08R2zIpPqV39E7HIpe
	 R5+O2/KIgqioQ==
Date: Mon, 13 Apr 2026 17:46:10 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: Carolina Jubran <cjubran@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] net/mlx5: Fix OOB access and stack information leak
 in PTP event handling
Message-ID: <20260413144610.GJ21470@unreal>
References: <20260412000418.8415-1-prathameshdeshpande7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412000418.8415-1-prathameshdeshpande7@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19293-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A18083ED7DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 01:04:10AM +0100, Prathamesh Deshpande wrote:
> In mlx5_pps_event(), several critical issues were identified:
> 
> 1. The 'pin' index from the hardware event was used without bounds
>    checking to index 'pin_config' and 'pps_info->start'. Check against
>    MAX_PIN_NUM to prevent out-of-bounds access.

You were told more than once that this is impossible.

<...>

> +	if (WARN_ON_ONCE(pin >= MAX_PIN_NUM))
> +		return NOTIFY_OK;

Let's not add useless checks in fast path.

Thanks

