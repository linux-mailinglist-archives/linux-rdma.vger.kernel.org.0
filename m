Return-Path: <linux-rdma+bounces-15869-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAJ0OdZ/cWk1IAAAu9opvQ
	(envelope-from <linux-rdma+bounces-15869-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 02:39:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52584606C3
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 02:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0ED926892A4
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 01:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8593134F475;
	Thu, 22 Jan 2026 01:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhaPcPYT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E613320CA6;
	Thu, 22 Jan 2026 01:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769045962; cv=none; b=Pp0ykfYD4W1gqhuKTx4OpzmQPTx1K2BGyVIyilDXo2iGK3NN1z0j+Oq8rPyaXZWOEeg3O2pPnXKtdGgKZbMAdUjrUHiRGjPPYnoOKDSBM+dNLGGJa2KSZScuXBofwYdYEpyENanvAZP3Y60ZHXELO6nd57uNsic0XhziRjwrbSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769045962; c=relaxed/simple;
	bh=F8jNl9MJy+FljyVswI1PqcouiQUJLJvmdgG+R8if1CI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHRpvozpm8H8AqwjU6pwNIF2zEAeosNUpMFfWngASaugMz/YEAkvF0tHHcxQFKTvy+dS2SV3sHUT3PAvPiOwN+2SqsDbCewIBwRMpN6aGyjw8XjihNLWNXXyuhyuUKZfABPWSHPRGCmjziP1kRYmN86hBBYNKiqfmOPcY/LJ8zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhaPcPYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3A0C4CEF1;
	Thu, 22 Jan 2026 01:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769045961;
	bh=F8jNl9MJy+FljyVswI1PqcouiQUJLJvmdgG+R8if1CI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rhaPcPYTKW3M4NYSGNJ/AAaFD5YyqQ8kPflsPBFkxT686wzWYdhnS7lc1ATUNTSRY
	 HPTCassKphXBWv9dxhaCZCPs+zqTmSo5d648vXA8Wur8zuBx7yTSt+5B0v1kRu9hdl
	 GvPVJ9NN06wn/RNFgjndI/nvRyZX4EEZrWvHcN9c6E7TgHQu3va5Cnjwfsj4A+UP73
	 yWLIH5SKaBQz9GX+sfHheTwOBtTGcbAbLJaEGhmt8SD/pJ71QBtdFFVZ3UyLwx9al+
	 KZtYpU2giDcvoYpYLncTEevLiOjN007zs+HmECk9SR9zcxaHOc/LGmw6OvMKeJ4PNk
	 gkNcI2mWfuqCg==
Date: Wed, 21 Jan 2026 17:39:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Allison Henderson <allison.henderson@oracle.com>
Cc: "achender@kernel.org" <achender@kernel.org>, "rds-devel@oss.oracle.com"
 <rds-devel@oss.oracle.com>, "horms@kernel.org" <horms@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 0/3] net/rds: RDS-TCP bug fix collection,
 subset 2: lock contention, state machine bugs, message drops
Message-ID: <20260121173920.71a093e5@kernel.org>
In-Reply-To: <83b05fbb38b2610b77d665850662a6f8c594f8cf.camel@oracle.com>
References: <20260118024911.1203224-1-achender@kernel.org>
	<20260120190913.20a16e15@kernel.org>
	<83b05fbb38b2610b77d665850662a6f8c594f8cf.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-15869-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 52584606C3
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 17:50:19 +0000 Allison Henderson wrote:
> Sure, I will drop the "bug fixes" language and remove the Fixes tag
> from patch 2. Also, we noticed a potential race in patch 1, so I'm
> going to hold off on that patch for now. If that sounds good, I'll
> send v2  with those changes.

SG!

