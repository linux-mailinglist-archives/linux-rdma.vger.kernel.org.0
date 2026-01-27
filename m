Return-Path: <linux-rdma+bounces-16042-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1KiUFUU1eGl+owEAu9opvQ
	(envelope-from <linux-rdma+bounces-16042-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 04:47:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9408FB75
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 04:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE7CA300AB15
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 03:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859C8313274;
	Tue, 27 Jan 2026 03:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GR3nswgn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488C62032D;
	Tue, 27 Jan 2026 03:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769485632; cv=none; b=s/M3Qi2o9qh/xZqnt18K5j0s1j+GvDbKWvKkPKh3xR8J7qm/wNQLxZD8ryBkINgOyHFAtgd0ZowXpcdIh+N89efw+WcAKhnElZsCCKQGRBZ7oOHttRG6MxwDtcWXzHwNfLSXlROU/X/yXFbFO1Fn4Qi19G9NrMhSkulTk3w0O90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769485632; c=relaxed/simple;
	bh=eCtTMn+dgF976gW4E/kz6A9W+a2G9bcVZYD7/SEoZoM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYOC4ov7vHowyxKcamwFuW3B619k/GArlpeSowhfT/S297LoUX8rRhYlSgrDQkp7d14ABVHfGxw5pkMIkzVYPSv15yepas5jC97nVRLeWQh45Auss0WV8KgZ+ujH6uVrk5ZjKa/YjpgjAUIngqgWHgVk24NPnbw9Dy/KSqaImpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GR3nswgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E83C116C6;
	Tue, 27 Jan 2026 03:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769485632;
	bh=eCtTMn+dgF976gW4E/kz6A9W+a2G9bcVZYD7/SEoZoM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GR3nswgnupC7rIsF9BPhnJFuJYwb+noZQ7/IpRDB+2+g3RMMnAqtW4xT+6kDcb5uf
	 dY7xZZ+jCRsXM1XhIlr9uC0pulDrNBEKYV6Dp4gs2n4zEzqpP0fEg9pwaJdDsG/X/g
	 vsbRmk1fIITKTBwE3dEebVjAr5tagY2ryGtk1YBYDK15z6LWGfrJrCATFgy1YDJ+xo
	 xN7xlMIHsfhAEm434c5xRvOVMyyska6B7458vTURfncCNsc8sWk44Tfb8xeSMVks77
	 EN+fEIju1IIXWwDkV6ZfXpoQk26wegk2spZiAU2qRp26xMeDqmR6+XyntC26QG/sCM
	 0adk3PKqq6QLA==
Date: Mon, 26 Jan 2026 19:47:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: tariqt@nvidia.com
Cc: Kery Qi <qikeyu2017@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 jackm@dev.mellanox.co.il, ogerlitz@mellanox.com, monis@mellanox.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx4: fix MAC table total count corruption in
 __mlx4_unregister_mac()
Message-ID: <20260126194710.5a154b8c@kernel.org>
In-Reply-To: <20260122183906.2015-2-qikeyu2017@gmail.com>
References: <20260122183906.2015-2-qikeyu2017@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16042-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,dev.mellanox.co.il,mellanox.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE9408FB75
X-Rspamd-Action: no action

On Fri, 23 Jan 2026 02:39:07 +0800 Kery Qi wrote:
> In __mlx4_unregister_mac(), when operating in mf_bonded mode
> (SR-IOV with bonding), it appears that the code might be incorrectly
> decrementing table->total instead of dup_table->total when cleaning
> up the duplicate table entry.
> 
> If this is the case, it would cause the primary table's total counter
> to be decremented twice (once for itself and once when it should
> decrement the duplicate table), leading to counter corruption.
> Over time, table->total could become negative, which would
> break the "table->total == table->max" fullness check in
> __mlx4_register_mac().
> 
> The registration path correctly increments both counters:
>   ++table->total;
>   if (dup) {
>       ...
>       ++dup_table->total;
>   }
> 
> However, the unregistration path seems to have a typo:
>   --table->total;
>   if (dup) {
>       ...
>       --table->total; // Should this be --dup_table->total?

Looks legit, Tariq? Are you trying to find/dust off an mlx4 card? :)

