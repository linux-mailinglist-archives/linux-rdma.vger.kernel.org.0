Return-Path: <linux-rdma+bounces-16617-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPkWBnxNhWmq/gMAu9opvQ
	(envelope-from <linux-rdma+bounces-16617-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 03:10:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74522F9242
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 03:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EBD93011BCA
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 02:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC03242925;
	Fri,  6 Feb 2026 02:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILh8WY92"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E441F5846;
	Fri,  6 Feb 2026 02:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770343798; cv=none; b=iCNOllwSf0xbj3E82Reav7nr6MYcW/ztbwmwajo2VWlGwSSGiJt3/cSwr4MJLzjwvIsejMARfcpbV7uNX4JOF+v9+kbLAKHwJ3ywW6ajrR6NxCwDuHjKyfDpnBzID32yPZ4IYpiNwMa4n3aGeSzvQF77mrlm8R7ejwNWLU2JnWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770343798; c=relaxed/simple;
	bh=mCEfuVKF5ClXIjAUjvnsjD6UryGkeSvPBNFLTZ+mKck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tje1wcG4wvguR7bjG18/GLqlb5G20/ZeUMQgEuUw9s8Qb+s5X9+bfYPlg5LP3wEDLEud5NBc4X377oM24EDYi5EDdXf9mGydGbXZVWlghCrDf0CVZc0p3DDVVBZEJM8pGmlAEyk9ZxydL6aTDbX+b70IQ8tnetU9HsCgxWa9vMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILh8WY92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E487C4CEF7;
	Fri,  6 Feb 2026 02:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770343798;
	bh=mCEfuVKF5ClXIjAUjvnsjD6UryGkeSvPBNFLTZ+mKck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ILh8WY92OWCH8GsvUqlwwhSu6Gc/S/SAUzVFkgtBpxPLEgj7Ta9Dy8KuZkZYCBz+h
	 6yY4JWkPwc4kXEgoVbe0zAQXc2Ka2D0vG8MoRhIz6WMBklpUZJUf0OL+ozXFtGqT6D
	 em4cy05ijc2j+VUaUAW2aP2DNX8usOOPriySFNiWs0aCLDHXi1Q/cfytbeACcsCc1H
	 HvfZ6pHipXCM+oYsVmgfznbQ5U8pLAifDlIfasmE065JaQbfVl7okW+oj4gZmUSI0h
	 So3YR27zGuqDig29if6KXYdGlY+hNblVG3+zJkZAY50nraCnMEGmei3j7KyhZzayGI
	 5WbcmpcrEFc3A==
From: Jakub Kicinski <kuba@kernel.org>
To: arnd@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	arnd@arndb.de,
	tariqt@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	jianbol@nvidia.com,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	raeds@nvidia.com,
	edumazet@google.com,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	cratiu@nvidia.com
Subject: Re: [net-next] net/mlx5e: fix ip6_dst_lookup link failure
Date: Thu,  5 Feb 2026 18:09:56 -0800
Message-ID: <20260206020956.3176617-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204130057.4107804-1-arnd@kernel.org>
References: <20260204130057.4107804-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-16617-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 74522F9242
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/mlx5e: fix ip6_dst_lookup link failure

This commit adds a Kconfig dependency to prevent a link failure when IPv6
is a loadable module but mlx5 ipsec support is built-in.

Fixes: e35d7da8dd9e ("net/mlx5e: Use ip6_dst_lookup instead of ipv6_dst_lookup_flow for MAC init")

> Add a Kconfig dependency that removes avoids this configuration.

This isn't a bug, but "removes avoids" appears to be an editing artifact
where two verbs were left in place of one.
-- 
pw-bot: cr

