Return-Path: <linux-rdma+bounces-17155-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMvpDoXwnmnoXwQAu9opvQ
	(envelope-from <linux-rdma+bounces-17155-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 13:52:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 997C2197A32
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 13:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED931301DC0C
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 12:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34143ACA70;
	Wed, 25 Feb 2026 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPuBGem9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66259395260;
	Wed, 25 Feb 2026 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023935; cv=none; b=pKfp6+9gE9pWXo0ww6PWXb4N2sCE3PP4yDzjCN/Wwwxqfoph8ANbhqYx5zfNvmD+g3ZBffFYTw3CzC47ksj+t7tAP7FveRpWrsVBrlr/lGkOlN7v+znhsx6MY8xVwVoB8ATrSsfIquKuAN/ZQPSQ0S9BMAxUXf11gKrDAbVtDt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023935; c=relaxed/simple;
	bh=saKejpggt6DMHP9gCdREPVHfEP7i469GFxSySj3JmXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iz4ZdQaTQtDmcuSeD106/eiNoOLDf6yGn78Hu4ce7sEKdGg5OB0v0xLab8qckYAHBHk5mkQdLmlFxCpizmi0vPFVkJ4Q0lbMCb1CoCBTLfH4+cVwVtRX1kuBLyhYp8G0U2/aOK4dXUaj9fD7sk0bcHpjbtAyLnikBVzJXctwQGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPuBGem9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB83C19421;
	Wed, 25 Feb 2026 12:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772023935;
	bh=saKejpggt6DMHP9gCdREPVHfEP7i469GFxSySj3JmXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QPuBGem9qYJoRTr00Y9f18Gz5gfNWHlLuNtsCzj2RxYX67ux72CzJJ9xAQu20di6E
	 NXagunISUF5IDDeNXVD8lSPRvsvZ96hc7io8BgVTFwIPVTTkIHfdeVv57Wm4+DdiCe
	 D6JBIr6S/YCxdJOodrnTNbTmHKGg0MU/zlpIWK8WQ1GAoaCTrtY77gY0erG9yrSTPb
	 MOsXd3C8/OKiqs7kfoQZLGDiUR2mnabXUwFe3Q/tQz6ZWn5Cm/xC9dcy3YY/zbGmjU
	 fGeGBQj89pn6WM/54oRzkU2kJBCJXP/vhXSnY/5+mFbMAXs9lpP+EBlTJo/3UwYLoZ
	 70nT+ENTMBlPQ==
Date: Wed, 25 Feb 2026 14:52:11 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Steve French <smfrench@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>, Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: Re: [PATCH] RDMA/core: check id_priv->restricted_node_type in
 cma_listen_on_dev()
Message-ID: <20260225125211.GE9541@unreal>
References: <20260224165951.3582093-2-metze@samba.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224165951.3582093-2-metze@samba.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,gmail.com,kernel.org,talpey.com,microsoft.com,lists.samba.org];
	TAGGED_FROM(0.00)[bounces-17155-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samba.org:email,talpey.com:email]
X-Rspamd-Queue-Id: 997C2197A32
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 05:59:52PM +0100, Stefan Metzmacher wrote:
> When listening on wildcard addresses we have a global list for
> the application layer rdma_cm_id and for any existing
> device or any device added in future we try to listen
> on any wildcard listener.
> 
> When the listener has a restricted_node_type we
> should prevent listening on devices with a different
> node type.
> 
> While there fix the documentation comment of
> rdma_restrict_node_type() to include rdma_resolve_addr()
> instead of having rdma_bind_addr() twice.
> 
> Fixes: a760e80e90f5 ("RDMA/core: introduce rdma_restrict_node_type()")
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Steve French <smfrench@gmail.com>
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: Long Li <longli@microsoft.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: linux-cifs@vger.kernel.org
> Cc: samba-technical@lists.samba.org
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
> ---
>  drivers/infiniband/core/cma.c | 6 +++++-
>  include/rdma/rdma_cm.h        | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)

Applied, thanks.

