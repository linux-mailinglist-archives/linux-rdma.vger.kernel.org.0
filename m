Return-Path: <linux-rdma+bounces-18066-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J2+CAg0smkuJgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18066-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 04:33:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9517E26CCFB
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 04:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C4EC307AA27
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 03:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43D337417B;
	Thu, 12 Mar 2026 03:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksofKqnc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B0221FCD;
	Thu, 12 Mar 2026 03:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773286401; cv=none; b=eeVVy4PxJfi9aSRsu+dqPPXj/EcQ9mDCRa0sFhZ605Q8HrvkMvfwwkQwqGGpKwDP8JKUzKY9SIziMzFKRdR4EpktaRFOj1K9SHiROqtVEGJZ4nX2CmBfoOj/bOgaQTErj8iuDAgwqIV20p2LkPcza0p5hAKhH/w+WY8w06EePhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773286401; c=relaxed/simple;
	bh=9rgwBN4KgHcwoIa7ezCCM/dYf9VHg6Q0vDwthV2vBX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SeHNr0lYBEXX4bCB7zxw3+N1nFYRSYNy7c+z0HNTDdqQ5daL3o+aZiwuNDYMXRgY35reRMXnawAA0vduIs/5x5mCUUBHIzMeef+RFG6d5ZXz4btN08ba6Ws+nESLRWC4dx7I+NJZQHXdHI78q0opAi6HHb66WEbpwHmXTIGBsxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksofKqnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF98C4CEF7;
	Thu, 12 Mar 2026 03:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773286401;
	bh=9rgwBN4KgHcwoIa7ezCCM/dYf9VHg6Q0vDwthV2vBX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ksofKqncXZtbYl4At45xJWgbNVm6hsyFk+tqKaCoXRqhkav3s8eG04UrRV6XBO6Yk
	 30mp7lB9ptoxmQEDyXLDxhrjqHCceWyOz8V0R1gL56ED+QMwGB3bLWDwRgXV29NijV
	 ykCBY9D91r+ntUxeRi7sdd7Ejx1m5SYGplpAG4nKsoIQmGYkczrmCUdZj1OS6SyYK/
	 eb52Bq5l4Z48Cv/Y9BCXHHv6rHgFNMD6ebvehoUmcVrfxfE2drsagbVrAvEHM4u/BM
	 a963Llun88mve22IjfO66Q7qNW2qE1arHyTo5i2Co+t1/sWTXDAsNLDrT9qlcpknoh
	 JFSY2E7UQn9iw==
Date: Wed, 11 Mar 2026 20:33:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, "Mark Bloch"
 <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe
 Shemesh <moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next] net/mlx5e: Enable mac forwarding on uplink
 representor
Message-ID: <20260311203319.76d35ce0@kernel.org>
In-Reply-To: <20260310104841.1862380-1-tariqt@nvidia.com>
References: <20260310104841.1862380-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-18066-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9517E26CCFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 10 Mar 2026 12:48:41 +0200 Tariq Toukan wrote:
> This small patch enables mac forwarding to MPFs via uplink representor,

"mac forwarding to MPF via uplink representor"
Can't wrap my head around this "via". Could you explain this better?
Perhaps some tool can spit out a little diagram to make the flow clear?

