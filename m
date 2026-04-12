Return-Path: <linux-rdma+bounces-19258-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLKBD1fK22nzGgkAu9opvQ
	(envelope-from <linux-rdma+bounces-19258-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 18:37:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ECB3E4DF6
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 18:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C354302A6FF
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 16:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5AE2E975E;
	Sun, 12 Apr 2026 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kon2JfsS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6712DC331;
	Sun, 12 Apr 2026 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776011792; cv=none; b=Ox8PRGVovlDm2qBNP2hDYFBkUQoMF0N3MSoAukET4nYrQNKRdBTQoTns0mhI/F+QvKqOYs99uKh+Gg3qvHXkOeksubrmFzSqWDkkM+H6zznceZVT8FDTPsEgrEOlxIcQ9BuqGv6AcbHYKJrxGnt0BdjfbBfueoHYJIL2k8bCuQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776011792; c=relaxed/simple;
	bh=4QjD8Gil0KJjjLLI+MuDfyRITEVYm2cDNV44JrR0LNg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6/6rGBUOq83Xv+HNHZ1TNeiHS0eFitUuKlkdy2NRMB/lHUb36KNrZVZowNaWwtcS1kmbkhG6/SilBVLJ5spwK6MkX0TKAfA/Kuera44XcM5ZQWAdhkh6H6B5VhH5UdF6bJp2ozAn1qkVO87hTtHsF5xvAkWXOmj7klYKQMQwL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kon2JfsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3517C19424;
	Sun, 12 Apr 2026 16:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776011792;
	bh=4QjD8Gil0KJjjLLI+MuDfyRITEVYm2cDNV44JrR0LNg=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=kon2JfsSdeJ0OJF/zLZ76ZzAGIUgLO6vVq7rQECZyWzXP85caRpaC7JatXxGYVtzw
	 Zf0CPHhlMlEJVJnz+Oy/JyIhvBd0UrslvunFuHFcl+lR0TrI5MZmBN4NUILVoLnmC/
	 Ho6A3Unlb7faFK5SrMJm5CEE982WUybkF4Q0f63wvYXVAaUuHTy+BluhrTGzrrwUQl
	 eI8uAqFNVn3K/lXa0W1+ufV++gdszRoU7L+WprW4J+YTjs+R3kHLif3cCnSey9Ydln
	 7yAgbVeORxW5yyitxlszVOjz6rWCtVLN6bKBSnvAulSn/jIK+4aJnrTsxhQJSigChF
	 XSPabJVLS/5yQ==
Date: Sun, 12 Apr 2026 19:36:26 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	Joel Colledge <joel.colledge@linbit.com>,
	linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 06/20] drbd: add RDMA transport implementation
Message-ID: <20260412163626.GE21470@unreal>
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
 <20260327223820.2244227-7-christoph.boehmwalder@linbit.com>
 <adXq36pbGLXMZc2r@infradead.org>
 <adZCPanS7iZlcPE9@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adZCPanS7iZlcPE9@localhost.localdomain>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19258-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rdmamojo.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88ECB3E4DF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 02:01:43PM +0200, Christoph Böhmwalder wrote:
> On Tue, Apr 07, 2026 at 10:42:55PM -0700, Christoph Hellwig wrote:
> > You really need to add the RDMA mailing list before adding new RDMA
> > code.  I'll try to review the bits I still remember, but you also
> > need a maintainer ACK.
> 
> Thanks for the hint and your detailed feedback. I'll address all that
> in v2 (plus some other similar fixes).

Thanks Christoph for adding us.
I fast-forward read the patch and immediately spotted two things:
1. Please don't call directly to HW drivers.
+	err = device->ops.query_device(device, &dev_attr, &uhw);
+	if (err) {
+		tr_err(transport, "ib_query_device: %d\n", err);
+		return err;
+	}

2. Add any missing API to RDMA subsystem, don't leave it to the users:
+	} else if (reduced) {
+		/* ib_create_qp() may return -ENOMEM if max_send_wr or max_recv_wr are
+		   too big. Unfortunately there is no way to find the working maxima.
+		   http://www.rdmamojo.com/2012/12/21/ibv_create_qp/
+		   Suggests "Trial end error" to find the maximal number. */
+
+		tr_warn(transport, "Needed to adjust buffer sizes for HCA\n");
+		tr_warn(transport, "rcvbuf = %d sndbuf = %d \n",
+			path->flow[DATA_STREAM].rx_descs_max * DRBD_SOCKET_BUFFER_SIZE,
+			path->flow[DATA_STREAM].tx_descs_max * DRBD_SOCKET_BUFFER_SIZE);
+		tr_warn(transport, "It is recommended to apply this change to the configuration\n");
+	}
+

Thanks


> 
> Thanks,
> Christoph

