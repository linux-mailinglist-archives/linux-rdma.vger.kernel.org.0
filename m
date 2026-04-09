Return-Path: <linux-rdma+bounces-19148-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PoYEkl312nTOAgAu9opvQ
	(envelope-from <linux-rdma+bounces-19148-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 11:54:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6883C8BFD
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 11:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76CE9302BA7D
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 09:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDC73B2FC1;
	Thu,  9 Apr 2026 09:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZLD2LrP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28413815D4;
	Thu,  9 Apr 2026 09:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775728326; cv=none; b=I7NgV3wphkdPboiXERcjG2PoX/9ZNcgpqmSrxhyIPj4lznmKjRv9jmCterH2HThu5yU73YLQTaHQy9iiQdVUAQrWC6xOxfVi1HHbEn6K0xQQArDKC53aL62ffUpCm6XlS4INYybJ7m5+d3vLiKRBjZH7DldtWUSieA13ocyvvf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775728326; c=relaxed/simple;
	bh=S6MgvEGvWLwS2ERISFPt2hlfqa1WyiX/NS+gA6uIcKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4pdbK/zEQB4pJUk4izCemENTKjKRUoEckVA7jy+W0sBr0Tj2mBcb2hrp6NzUSoRFzID9Q7LK0+OugCJaPLEjFDB/ejCrDDLLJi/PlzcX4W006cZpMa0jN7dmCUBcDJ33HNylFZHVPzY33RAy0/t3+e4E9B/CjJeny648UzFXqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZLD2LrP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0443C4CEF7;
	Thu,  9 Apr 2026 09:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775728326;
	bh=S6MgvEGvWLwS2ERISFPt2hlfqa1WyiX/NS+gA6uIcKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZLD2LrPDbSkP/LCsSa1HnymcwUFWkj2DVpHY2xJhC6KxdaINAhDAWz3uTYus2z09
	 RIYiN7oV/+WkQH7PQnoJg0c5TdjeUrfWwmfqyJB6e2zZV9sHEhOOFnaU8CmPwC4gKn
	 0qGTwNOE5O3J+/i4MhAOdfA0k8VS3Fwo1EPxhfp0wZet+Sm41eaj3pCaaQYHPXeZwT
	 eUemqVXla8hx81wTFWk7iDX8FGrOj7o5FPC+7JfKzDjclLSrICVx1tdCjTWn0gGjTK
	 +JXOlM76fBdnHRk29qWSr2x0S2+KbT7nSF5J0cagQy4w0vNwB8bfFekTYD7miBvokG
	 SEkjkdeHosrfA==
Date: Thu, 9 Apr 2026 12:51:58 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/mlx5: Fix potential NULL dereference in query_device
Message-ID: <20260409095158.GE86584@unreal>
References: <202603311604.GD814676@unreal>
 <20260331215744.17039-1-prathameshdeshpande7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331215744.17039-1-prathameshdeshpande7@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19148-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B6883C8BFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 10:57:36PM +0100, Prathamesh Deshpande wrote:
> On Tue, Mar 31, 2026 at 10:04:00PM +0300, Leon Romanovsky wrote:
> > Kernel-space callers don't use uverbs path. It is solely for the
> > user-space access.
> 
> Hi Leon,
> 
> Understood. Smatch flags this as an "inconsistent NULL check" because
> 'uhw' is explicitly checked at line 967 (if (uhw && ...)).
> 
> If 'uhw' is guaranteed to be non-NULL in this path, would you prefer
> a patch removing the redundant check at line 967 instead? This would
> align the logic and silence the static analysis warning.

uhw is not guaranteed to be non-NULL in mlx5_ib_query_device(). This
function is used in both kernel and user-space paths. The only condition
that cannot occur is a caller providing a non-zero 'uhw_outlen' while
passing a NULL 'uhw' pointer.

If the caller provides 'uhw_outlen', then 'uhw' will always be present.
The reverse, however, is not always true. See:

   944 static int mlx5_ib_query_device(struct ib_device *ibdev,
   945                                 struct ib_device_attr *props,
   946                                 struct ib_udata *uhw)
   947 {
   948         size_t uhw_outlen = (uhw) ? uhw->outlen : 0;

Thanks

> 
> Thanks,
> Prathamesh
> 

