Return-Path: <linux-rdma+bounces-16997-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCTdK7KDlWlrSAIAu9opvQ
	(envelope-from <linux-rdma+bounces-16997-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 10:17:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C679154A7C
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 10:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A19030238C8
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 09:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06743195E6;
	Wed, 18 Feb 2026 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk4PTJVw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0815033A9F8
	for <linux-rdma@vger.kernel.org>; Wed, 18 Feb 2026 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771406163; cv=none; b=DIbNSylGO7yXVnDfujBDc8ebnA1vswoiESKXlcKGXXDnJGfCLh/Dr9klmGIqPNH8BKA5CurZJoR8wZ1XaGhgfkPDNmJjrgMqpJoZ5zkaEgGhMRil6IpeNoS9BgZNsmePNUWyqCz42LeT+na63FHeFxbjMkS0soiW6kvhaDS2Yow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771406163; c=relaxed/simple;
	bh=Wp/Qvm7fj/VP+3peXTKOkS4yOo7oRxxdAdG89pCn9CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cc6YCZ+i7WtZYAKQ91rEKBJxMJrA94bW+Cgcs/0oP071GCr9c0bd4wrRa02cBCW+pciA8sZBPz/Lgbg/zBurLrE2D4hXKLnUUfRZkTAGhlMJVMTZpNQdtmBdRxoOvfcTeOyvgQhPVYkpkSQMgMyVCR2247V128MW0DTBCLexBc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk4PTJVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D516C19421;
	Wed, 18 Feb 2026 09:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771406162;
	bh=Wp/Qvm7fj/VP+3peXTKOkS4yOo7oRxxdAdG89pCn9CM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dk4PTJVw7LxO1eNHJq0CZBZx4jaGuVMLq0rKs3gPq5BjlEFifJVBerre5denjxAMc
	 Z8z5+UB1zqj7HR+lmEEiRgTtVlEoGTyyUXIWZJrk0YaqPpqZB0cejXeU5Ttowlzxr8
	 j9OMa8t8jkhS+Psdlywwz+45qhKZNe17vgSLneDo7LrUMlF2ptoUcgh5guAQPIw400
	 nhGuj3YaZXO89YSlrcJJ15f2nv934hB1cIN4AzkuN5DBq/Nqq+sw7yfQBxcgQIbGhd
	 dZ9g63rNF7dt6/HBYF5yiHxT3bqUVaR6f3+DVbI8pjzKkcGc/UStzuo76P7Mu2I2yJ
	 bMXtTN0hE0grA==
Date: Wed, 18 Feb 2026 11:15:59 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Margolin <mrgolin@amazon.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Tom Sela <tomsela@amazon.com>, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add AH usage counter with sysfs
 exposure
Message-ID: <20260218091559.GF10368@unreal>
References: <ef07b718-0198-4f8c-86c1-56149c7fd239@linux.dev>
 <20260212163628.GG12887@unreal>
 <20260215134122.GA18825@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260215171543.GB12989@unreal>
 <42c8552c-eb41-43f5-bea5-fdd46edba65a@linux.dev>
 <20260215175707.GC12989@unreal>
 <20260216110853.GA6455@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260216112207.GF12989@unreal>
 <20260217145426.GA9217@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260218001408.GB723117@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218001408.GB723117@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16997-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C679154A7C
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 08:14:08PM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 17, 2026 at 02:54:26PM +0000, Michael Margolin wrote:
> > to monitor AH usage in production. Resource usage and traffic counters
> > are usually collected periodically (every 1-5 seconds) by dedicated
> > collectors (e.g., Prometheus node exporter). 
> 
> Can you just have two simple stats
>   '# HW AHs created' 
>   '# HW AHs destroyed'
> 
> and the value you want is the simple difference?

Which can be collected from FW through FWCTL?

I don't super excited to see slow, unique sysfs UAPI field in RDMA
subsystem. They are interested to get FW information, let's use
interfaces which are intended for it.

Thanks

> 
> Jason

