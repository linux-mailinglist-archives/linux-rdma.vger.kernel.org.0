Return-Path: <linux-rdma+bounces-17518-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA7hFlJcqWkL6AAAu9opvQ
	(envelope-from <linux-rdma+bounces-17518-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 11:34:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D48D220FC12
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 11:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3175030902D9
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 10:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A18372B4F;
	Thu,  5 Mar 2026 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NU6tilMg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EAE3101A0
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772706700; cv=none; b=gE61/uOAW05jd8FN+0JqvOXncQJjkvRI12UC2K+2h9Cz4pFJW9hQZKDEqjAUKOzrj3SP+IoU9ZRSrmsA5MLTlqzVUbJN5RaHx/kAjgB6/6XPqXUEhwZzlZ2BtE8divgEr46TYtth8MrWGcITBXSe1iXOwy5Dd9k5OoVe9aIxVmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772706700; c=relaxed/simple;
	bh=GfJtPnV7ubC3hNBo+T0g0oVi9hCqZit28DtJNWkkX5A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mb8DJnzBa/Qu0ZbqMrB9fJushXZiJuFfP8FtbPfIqqJj/ejhtjBhV1uTRPq5WEgt14RBFwHMUSDAi/JL68+6qZbXDEPOVAFqdck8mIJM2AneUqnJScpzkhezO2FWz0BX8cAtuvqgq1zeQ5sXM3WCa1itKewVFDkcTkwEIyHhI4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NU6tilMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2D3C19423;
	Thu,  5 Mar 2026 10:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772706700;
	bh=GfJtPnV7ubC3hNBo+T0g0oVi9hCqZit28DtJNWkkX5A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NU6tilMg+QOX7pbFnaTAvh9GSTT9m9yeUbW1BjMpDup1GqzE742suinfmYwKtuk7W
	 CShkEP3jRa/ABy3IisY/A2Fkd1GxG3hsF2uUNxSqjykb1/mBvwjbQQldFMEIDAwDXE
	 y9SL9C9ahyDRfuNx/riDzRvAMK4jIp7E/ARjVED8JYJUepIHGQPAuKJBzz+zmkTn5O
	 SijbLDOHrTAN+anGQeX4lPyUwzq+kyBmfNHfxObnC6ByFyr7UL4AoBJ6QI35fmW6/y
	 gfLyhv2RYWy0Uf1w8gSNKydK4+i+Q+gmdfMopVeEpYF9BUHntu8tYmsLeVcotXDL5q
	 ddRqPokqCLX3A==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Cheng Xu <chengyou@linux.alibaba.com>
Cc: linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
In-Reply-To: <20260305062929.58881-1-chengyou@linux.alibaba.com>
References: <20260305062929.58881-1-chengyou@linux.alibaba.com>
Subject: Re: [PATCH for-next] RDMA/erdma: Remove numa_node from struct
 erdma_devattr
Message-Id: <177270669733.1180883.12562293896248896786.b4-ty@kernel.org>
Date: Thu, 05 Mar 2026 05:31:37 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Queue-Id: D48D220FC12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17518-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Thu, 05 Mar 2026 14:29:26 +0800, Cheng Xu wrote:
> Using dev_to_node() to get the pci device's numa information
> instead of caching it in struct erdma_devattr.

Applied, thanks!

[1/1] RDMA/erdma: Remove numa_node from struct erdma_devattr
      https://git.kernel.org/rdma/rdma/c/ce231c29a41877

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


