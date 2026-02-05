Return-Path: <linux-rdma+bounces-16601-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM5gLX2/hGnG4wMAu9opvQ
	(envelope-from <linux-rdma+bounces-16601-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 17:04:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD1EF4EF9
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 17:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A44530626F8
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 15:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BE142DFE5;
	Thu,  5 Feb 2026 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0fqCVm4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB83C410D3B;
	Thu,  5 Feb 2026 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307076; cv=none; b=bcT+ROch02TXN6q6K1eXLTsL6I0L8/dH7tzeNvtwv0oYnN2JFewJKEwTjWWzNuQORErTb0Ex9Y9WISlXNjjMxfo+I4w1M6J0hzru5BllA5IqsvzOWiy5QXRi27rwozvXtvu2qyjtE+1SV9q8BSPBjJu2HWJQwM0nIaT37oYjEx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307076; c=relaxed/simple;
	bh=W2fZIjX7V8Pk74oGH+QPOaH/hYX6U8I61iaNsnEv+9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLdwR3bsqx6uQi7tWV6XzFgenJpd6RgxX64YGQDigE0VDeaOxB3AVQa8nHm1t/EIEqio9RuWkeuFUyG0/ySF0VOJTI0mQeZliqNa3m0Q9qcDJrbFHo8+9pL4RqV9Tx6T+rIxBD/VYGEKjxLEUymyjUcXtAsQtJ8fYafw4fHDlMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0fqCVm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73FFC4CEF7;
	Thu,  5 Feb 2026 15:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770307076;
	bh=W2fZIjX7V8Pk74oGH+QPOaH/hYX6U8I61iaNsnEv+9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q0fqCVm42e4JXG4R26qSMvQVVhx9qxJJFvaNRJy9L4uWnRpEbXVQCsgivPHSDaZVw
	 UlnYCYt5a7dV2jeQgfvc3vRKpcDy2gnBnyHdxRY8F9dcsZmiZlWewZaAd6VPjY88qH
	 R4LwU5/3qkRzFUuimLv4G/QmU5mq/v/cIgAa7GkVFEFKXvUG9jrDWnJTh/Htd0wdNa
	 FxM168Kw8KmOw6aY2A51+SEDZSIks/aXJSyRgVtFvGgh5rI/zro0EXknRx5WxDCsF3
	 d2udo6OPWEcQNbon5W2W1jF3W/vVGFp+a3GU8lfAGQyFovQ1KrKxOOlKVQnNs2gpqo
	 3V7gWT6S671dA==
Date: Thu, 5 Feb 2026 07:57:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>, Mark
 Bloch <mbloch@nvidia.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Gal Pressman
 <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yael Chemla
 <ychemla@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>
Subject: Re: [PATCH net-next] net/mlx5: Fix 1600G link mode enum naming
Message-ID: <20260205075754.57d3a5b3@kernel.org>
In-Reply-To: <99b57ed5-f0bd-4ce9-a665-b949df755b39@linux.intel.com>
References: <20260204194324.1723534-1-tariqt@nvidia.com>
	<99b57ed5-f0bd-4ce9-a665-b949df755b39@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-16601-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
X-Rspamd-Queue-Id: 7FD1EF4EF9
X-Rspamd-Action: no action

On Thu, 5 Feb 2026 13:42:16 +0100 Dawid Osuchowski wrote:
> WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report

FTR netdev ignores this warning.

