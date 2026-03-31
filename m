Return-Path: <linux-rdma+bounces-18848-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePcWKTDSy2mILwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18848-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 15:54:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5D336A8E9
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 15:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31B193035D0B
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 13:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4C33F54C6;
	Tue, 31 Mar 2026 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdK2XGpA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4CD3F54B2;
	Tue, 31 Mar 2026 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774965000; cv=none; b=dEJxYNh6wz5J/Moo2MFhsLCwbdJOyu3m0+wAwRVC6D4Zr7RiZuoNHfC42C19fUNv0wHNQlkwKdBB6S2L7q0I5f8mhnp0vBHj4PBehntyhff7lFhejin51QkINyekB96E87vISghOe8HOLzvAXnHIYZCbOePWessji9cu4u4RLqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774965000; c=relaxed/simple;
	bh=AY6kwirrnfx2Prg7i7MJT5cjA1Fe7n/Dyp2t6TaxuLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcaGybNMKronogruebrYIBqNxSVmonj0yU0vIZ+ersmzuBbkdRT2fgCYE1sQOw7ejI7o4dVaWMcOVj1dXvxq4awUzahKWgCAQoEOViviXX1rtgu3/JPCXti4AEFhDi7nr6d7m4RwRoTNtUBTAy7puGwEOpeA5D0AmR8oNuHRb4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdK2XGpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D63C19423;
	Tue, 31 Mar 2026 13:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774964999;
	bh=AY6kwirrnfx2Prg7i7MJT5cjA1Fe7n/Dyp2t6TaxuLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FdK2XGpAkCynr4TpTKrdLIL2BKJULplqoMNc7rzDwEvawfuATR3IQXQd0k3wZKAwX
	 7XC2mISjGYIOt4ssmFzAqtl5e/lxawLz/9JKm8j17TI4HRX9q34UDWF44Dh+TU2FXY
	 b75r76qQbaBrJqVTCox7/sPK4Jf0Exs8rAtMPDImip/rLMCdNZbDq8Ms04df0lK58F
	 5K1WyD3RluZa5+Vz01S4TL41Xn1zk5vYiNi9LTUFrCfVnLwQi3B8vGN4A7qdVuW7Bv
	 D95L9htTztSaK47jRlcD/QAyhkH5IwQJKSs1lzIfGVaRTTuZFSMQTN7DTaTDIHbLpU
	 f+lSSXdc1GuFg==
Date: Tue, 31 Mar 2026 16:49:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Haggai Eran <haggaie@mellanox.com>,
	Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/mlx5: Fix potential NULL dereference in query_device
Message-ID: <20260331134955.GF814676@unreal>
References: <20260331014427.11756-1-prathameshdeshpande7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331014427.11756-1-prathameshdeshpande7@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18848-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B5D336A8E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 02:44:27AM +0100, Prathamesh Deshpande wrote:
> Smatch reported an inconsistent NULL check for 'uhw' in
> mlx5_ib_query_device(). While 'uhw_outlen' is checked at the end of
> the function before calling ib_copy_to_udata(), 'uhw' is explicitly
> checked for NULL earlier in the same function.
> 
> If a caller provides a non-zero 'uhw_outlen' but a NULL 'uhw' pointer,
> ib_copy_to_udata() will attempt to dereference 'uhw',

How is it possible?

