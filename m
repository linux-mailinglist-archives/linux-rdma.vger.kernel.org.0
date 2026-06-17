Return-Path: <linux-rdma+bounces-22310-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7JGWASyQMmqt2AUAu9opvQ
	(envelope-from <linux-rdma+bounces-22310-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 14:16:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9506999D1
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 14:16:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LXsOIYKr;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22310-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22310-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FD9730BC33C
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 12:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B043C454E;
	Wed, 17 Jun 2026 12:11:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C05288D0;
	Wed, 17 Jun 2026 12:11:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781698261; cv=none; b=QAFTw/5QvZLWYEJY3ixxpg9Yg0YZrc8W4fqWJoY80jUN9JZN9SeGOqnRll3G3jqJVLQAAlmJrSXCfKqcAfjN7DVKy7vHfC9vXvb28kuxY22cW5dCNTRgv2yWZje2ZXxxSoX4gbWf/9j5bBEK/9V/lDV3XKbyNB3/4zpPLEBUTow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781698261; c=relaxed/simple;
	bh=X6HpM5Za44X7ZepaSExNy+W5QBtUM4vthFa/g0qfZHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+bhZNJCvZ0LAbua9+CEJS2A9hh92dqn+iMo4clrZ9pqYAKLlG4i2sKOS0dF1ASFcbTfyTLR0MDYdhC706vuc+4+dlfH1sCPih2LBRB8Z7MeOgpl0/qpKYszc+sl99fJ03hp9TwGJNyTsYdfSz14EKNfdHudU7K3hbMvn7823rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXsOIYKr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595821F000E9;
	Wed, 17 Jun 2026 12:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781698260;
	bh=oGH4exJeiKznSQXGrDnbISb7qf5M+zPLl1Qxv/C3Ccc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LXsOIYKrowM0PHEHQ13vCxCeNrgzz1Ps4BvrtD9w1HLpOQHKCefO4seANf/coE8QS
	 fOjTK2Jc7G8HmX71gKBZMiXOVXpVg/2V+NbLDBrRq1deTedyBJmMWgDWTZrCjphBYV
	 nnPlzvpqCFt8v6FE70tCgTPIfQLZOriSeXCbMs3rpCwIpX0NWKypopE1EDFSVYlxsr
	 j2O6mbNiCAZKgfqNaVpJTGzpB+cOly+a0+/MMeT1LKNJhi7YS6wrOfg/rE1giBM0eI
	 GSQFWiXBwEPbkh/VszliGVCnZgZAg94aPpXXurhKqvQrmPPHoZUTNUDAk7szjyFKIU
	 NP5DLvgoQMaMQ==
Date: Wed, 17 Jun 2026 15:10:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhenhao Wan <whi4ed0g@gmail.com>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Danil Kipnis <danil.kipnis@cloud.ionos.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] RDMA/rtrs-srv: Reject usr_len larger than off in
 process_{read,write}
Message-ID: <20260617121055.GY327369@unreal>
References: <20260617-rtrs-srv-usr-len-underflow-v1-1-942e6414150a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617-rtrs-srv-usr-len-underflow-v1-1-942e6414150a@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22310-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:whi4ed0g@gmail.com,m:haris.iqbal@ionos.com,m:jinpu.wang@ionos.com,m:jgg@ziepe.ca,m:danil.kipnis@cloud.ionos.com,m:jinpu.wang@cloud.ionos.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:danisjiang@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ionos.com,ziepe.ca,cloud.ionos.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,unreal:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B9506999D1

On Wed, Jun 17, 2026 at 12:52:00AM +0800, Zhenhao Wan wrote:
> process_read() and process_write() derive the data length of an I/O
> request as:
> 
> 	usr_len = le16_to_cpu(req->usr_len);
> 	data_len = off - usr_len;
> 
> off comes from the RDMA-Write-with-imm immediate and is only bounded
> above (off < max_chunk_size) in rtrs_srv_rdma_done(). usr_len is read
> from the chunk buffer the remote peer fills over RDMA, so it is peer
> controlled over the full u16 range and is not checked against off.
> 
> If a peer sends usr_len > off, the size_t subtraction underflows and
> the pointer data + data_len passed to the ->rdma_ev() callback points
> before the chunk. The in-tree consumer rnbd_srv_rdma_ev() dereferences
> it as the message header (le16_to_cpu(hdr->type)) before validating it;
> this is an out-of-bounds read reachable from a remote peer.
> 
> Reject usr_len > off before computing data_len in both paths, via the
> existing send_err_msg path. For a well-formed request off is the total
> length data_len + usr_len, so usr_len <= off holds and valid requests
> are unaffected.
> 
> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

It is already fixed in the commit 54bf38b27afc ("RDMA/rtrs-srv: Fix integer underflow in process_read and process_write")

Thanks

