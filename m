Return-Path: <linux-rdma+bounces-18399-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKseOFAGvGmurAIAu9opvQ
	(envelope-from <linux-rdma+bounces-18399-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 15:21:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA462CCA20
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 15:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 988BE305DD25
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 14:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642E033D506;
	Thu, 19 Mar 2026 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWYnPiCx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2349D359A78;
	Thu, 19 Mar 2026 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929812; cv=none; b=hKYJfZWvWCh56HYI8kGf84zHYJWNr2ta+Oa+CCJSVciMvf7xht4gL/bx65us4zu9plp/ssdi5n1y2QHic9Uyjoe6LWuekz8y0u/MRZLHwOTbdbQz1VhHAb1kLrwYMpi3bZwxLg0u1/5aG0Kffy7GrCW7s45O/1nGgtfU79tQwPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929812; c=relaxed/simple;
	bh=I5KJNaocg1QGOAFgj0Yud3STBxnH19g3ivmd0yPTKcw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T2YT/csTNrCY08qLXj4rAnK0Jq08OfBZIdwfc6iLqJ8r+E7oFRfan00QFY4jPzINg+wQZ9gQKHoKMohF1dmxx3quGLOK1vqv9WHx+NhZAI5jXhxrjCfhTpJSKfvO78kDKyunYUi8HINxKD4Ll50IdhwcALWgduGIuLZ/5wYMwN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWYnPiCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF31C2BC9E;
	Thu, 19 Mar 2026 14:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773929811;
	bh=I5KJNaocg1QGOAFgj0Yud3STBxnH19g3ivmd0yPTKcw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HWYnPiCxQDA71RSzhNE5cNoCX5+aW5bAKCxhACN0TK9gwgp6ZlO8z5YfnpqQRD6m4
	 PV/wgveAbsAmOgCLlrhM8xtTJceWs8dYbF5TuF79ImMEznBUMPBc1HfqZJVjFrtodQ
	 zTg0+kl0Hkv00WjKslzUNtW3Vmo2FK4cVunnU+F7Rx9fU+3pLNjfZfssvLMQ1pO1sE
	 OY1VQ4IgKU3lArYQPJujP1lLFpNHJNWMJxrjXsUutMwlibfYDRni2VTPMyxV60GJb0
	 HQq/8pTmYlWCOYLNb0dhWO0R1BR3Zm6Vr68oxyKwFWqo7D+X+n2Y9hsowDgljgiC3j
	 sFmm/eaji3SBA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
 Selvin Xavier <selvin.xavier@broadcom.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Krzysztof Czurylo <krzysztof.czurylo@intel.com>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>, 
 Yishai Hadas <yishaih@nvidia.com>, 
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Zhu Yanjun <zyjzyj2000@gmail.com>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260318-resize_cq-type-v1-0-b2846ed18846@nvidia.com>
References: <20260318-resize_cq-type-v1-0-b2846ed18846@nvidia.com>
Subject: Re: [PATCH rdma-next 0/2] RDMA: Clarify that CQ resize is a
 user-space verb
Message-Id: <177392980868.822397.9956208688572110437.b4-ty@kernel.org>
Date: Thu, 19 Mar 2026 10:16:48 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-18f8f
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18399-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ziepe.ca,broadcom.com,intel.com,nvidia.com,cornelisnetworks.com,gmail.com,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5AA462CCA20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, 18 Mar 2026 12:02:35 +0200, Leon Romanovsky wrote:
> Let's start to clean resize CQ path.

Applied, thanks!

[1/2] RDMA/core: Remove unused ib_resize_cq() implementation
      https://git.kernel.org/rdma/rdma/c/137b01dd466fa4
[2/2] RDMA: Clarify that CQ resize is a user‑space verb
      https://git.kernel.org/rdma/rdma/c/90b7abe25ce9b8

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


