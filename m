Return-Path: <linux-rdma+bounces-17516-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK//AotOqWk14AAAu9opvQ
	(envelope-from <linux-rdma+bounces-17516-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 10:36:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D403920E933
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 10:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72D343003379
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 09:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8A336606E;
	Thu,  5 Mar 2026 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBAzeDh4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32742749ED
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703281; cv=none; b=UQpWNd2H1AQf/dHAx7qEnJpxBUNMlM1dy7tMJQYFtFPhqtPYiKTgeTOo/yF0W8lvPcJsxpxRgVeX7gUgwjqaGSXcTLE8/ABQiaJY1Mzsj1KZsnkEv3Tpthf/c/KM76YZmDWCjFJIYzzUDU7PaETliAI8J7WjQQcdhwPRt+cS8Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703281; c=relaxed/simple;
	bh=DWU6Jqj8MYcjl3wlGakFkqh5ZKYpSP2I7UvnnRyHGeM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ja9seuMRFByduRQUh2d9wvpEE2oyg4biCgMja1qjsxTlpGKFmIsQqT2CLciGCndD+x5nfaipKX/egC7hVc7Sy2sTkvsXZRaj0JC3qlWVXqVqB7Mk8v3b2++5BdDwTWsJxp1RO7RGBLAu4QfQu2HPfZfU+yKZMfRziEWWDmmDPqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBAzeDh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D202CC116C6;
	Thu,  5 Mar 2026 09:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772703281;
	bh=DWU6Jqj8MYcjl3wlGakFkqh5ZKYpSP2I7UvnnRyHGeM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uBAzeDh4YuWf6drjeHooD3PZuC2DSUHwj5E49YcfIdQvpX/OLSrXF8R+lF+OM0R+p
	 TGGalHfrnIIxq7yfx3MnNApsOU8ETf0CpoQc5zkWvFhzrjGtBSf8KXUTQa6MNBkQgm
	 yNL93yY89aenniS+3z/KmEoKdRabCp9kgeI3lKcZZINnAYMpzimyqVfGDogyQLyt4l
	 MgzgkyL2iAtc2dvodbcXJjpLEZ0TitFZK4EhzaIp79uJMo5WQAjvxoo7x5iB3raJuT
	 B6maHeEawNnDU+HZ2a+mC5FprRuB0oZEia7xnNQvXFjn1Vz51gLRYHwF4GNEAhywu3
	 0qWjzK2yheHng==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Kamal Heib <kheib@redhat.com>
Cc: Siva Reddy Kallam <siva.kallam@broadcom.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20260303043645.425724-1-kheib@redhat.com>
References: <20260303043645.425724-1-kheib@redhat.com>
Subject: Re: [PATCH for-rc] RDMA/bng_re: Fix silent failure in HWRM version
 query
Message-Id: <177270327837.1153412.12711571369478900156.b4-ty@kernel.org>
Date: Thu, 05 Mar 2026 04:34:38 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Queue-Id: D403920E933
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17516-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Mon, 02 Mar 2026 23:36:45 -0500, Kamal Heib wrote:
> If the firmware version query fails, the driver currently ignores the
> error and continues initializing. This leaves the device in a bad state.
> 
> Fix this by making bng_re_query_hwrm_version() return the error code and
> update the driver to check for this error and stop the setup process
> safely if it happens.
> 
> [...]

Applied, thanks!

[1/1] RDMA/bng_re: Fix silent failure in HWRM version query
      https://git.kernel.org/rdma/rdma/c/c242e92c9da456

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


