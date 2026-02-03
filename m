Return-Path: <linux-rdma+bounces-16439-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHCQM07EgWnZJgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16439-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 10:47:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E9022D7118
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 10:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22222300D08D
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 09:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B810A396D01;
	Tue,  3 Feb 2026 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtfb2dZq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C32C310774
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111994; cv=none; b=bqtSqjK4k0DguoaEZhLRDl51NkkLNXej1bdrzCJ4oyDxO1BBjznWJSw/RyE9WLjL7qf6v5sLuvl+gpD6qUI5Wfcuk+ZlwehcnzSPSm+X5D3uVyISy09l9Q8fefGralsZMLoO94diWNpawApQZuasYGryFom/jBK8G/M4+gF2i24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111994; c=relaxed/simple;
	bh=W+b/4F5SuzkuLwyQM5hHxlQ5/YOuLvDNjh9M3Zrby0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhpTru9c4CQ0Jq9RF8qBq26gNn7c0rjRXwQxYoldHVCekAercpUlLyZQ2Am/7Gxda9RfxiLscVgHfZvbB64DSHvmqP7BfPFP5yvrGb2xwZUD78rMsgs0ipWoPJNqgHhFQ/okZhf6mZEw7bkDTNGfbjZ9gLPTJ8OzQuMMY9h2UiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtfb2dZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B24C19421;
	Tue,  3 Feb 2026 09:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770111994;
	bh=W+b/4F5SuzkuLwyQM5hHxlQ5/YOuLvDNjh9M3Zrby0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mtfb2dZqVtAyjnCXvZz9N6V5Liv4+rMlOkpv89lFJL2zxxVBGlIKLziUulwCRjNLe
	 t8DDNXt0XgHlQSufazQrUk90iLbam2sWu5RceUs7AVRV64BHXAmPH47TiqN3kH06L3
	 kofgft3mVMqaiu5nnF46bbiYQ8VxRvN0RJ97w4zm/UnamJqu2IRXuc62s4niiOqD/T
	 OhSk9RM0qU4XRRxVYHbOSoY1pmaXvyhf3t+9UgVcRomO/SweAXl865yv2ME/k9dkCO
	 fzIClIh6JJwjv09er6cYupXLEHx4VSdxWNdz5i9KZrDrpDLhJOWwCSL2VayVaAW108
	 MPu5sEyORg4Ag==
Date: Tue, 3 Feb 2026 11:46:29 +0200
From: Leon Romanovsky <leon@kernel.org>
To: YunJe Shin <yjshin0438@gmail.com>
Cc: jgg@ziepe.ca, ioerts@kookmin.ac.kr, joonkyoj@yonsei.ac.kr,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/umad: Reject negative data_len in ib_umad_write
Message-ID: <20260203094629.GQ34749@unreal>
References: <20260202183449.GL2328995@ziepe.ca>
 <20260203064620.686140-1-ioerts@kookmin.ac.kr>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203064620.686140-1-ioerts@kookmin.ac.kr>
X-Rspamd-Server: lfdr
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
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16439-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kookmin.ac.kr:email]
X-Rspamd-Queue-Id: E9022D7118
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 03:46:08PM +0900, YunJe Shin wrote:
> ib_umad_write computes data_len from user-controlled count and the
> MAD header sizes. With a mismatched user MAD header size and RMPP
> header length, data_len can become negative and reach ib_create_send_mad().
> This can make the padding calculation exceed the segment size and trigger
> an out-of-bounds memset in alloc_send_rmpp_list().
> 
> Add an explicit check to reject negative data_len before creating the
> send buffer.
> 
> KASAN splat:
> [  211.363464] BUG: KASAN: slab-out-of-bounds in ib_create_send_mad+0xa01/0x11b0
> [  211.364077] Write of size 220 at addr ffff88800c3fa1f8 by task spray_thread/102
> [  211.365867] ib_create_send_mad+0xa01/0x11b0
> [  211.365887] ib_umad_write+0x853/0x1c80
> 
> Fixes: 2be8e3ee8efd ("IB/umad: Add P_Key index support")
> Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
> ---
>  drivers/infiniband/core/user_mad.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Please submit this patch as a separate email, not as a reply.

Include a version number in the commit subject, and provide a changelog
below the Signed-off-by tag and the "---" marker.

Thanks

