Return-Path: <linux-rdma+bounces-17399-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGGHO2DmpWlLHwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17399-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 20:34:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 843A41DED9A
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 20:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F27D3042B4E
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 19:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963D047D947;
	Mon,  2 Mar 2026 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfKtUQPW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A3D22A7E9;
	Mon,  2 Mar 2026 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772480082; cv=none; b=Z7BXYG/QGdpRivfTAccjWlB4z6c7TFk+DgTtkSN5De+rHoH9NdP6gLcz46LUexRFaDmg9VOyaQtFOsrctZqpIgNi34xWmk8/+XD5G1oPBG0gMYiANA+sy6Q9Cu7fY41uMRUh6bdxN831JP3lzWEcj0q2wuqoqHWLlbzidHy1sIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772480082; c=relaxed/simple;
	bh=miPePayw+w4YDui8oX6YxeGULNU5oqC1RDU+hLjpQPI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Kg/DyfTevvJyynuX4lZ1g4Xsp7xukR74jRgs2XOogdiiwTlPWE4XXdBY7+UMFF8ltkrojrf1FEighm1CaLso7gRRTmJ1sPy8JN6lqhEkq5Yl7bn18kpBxPEcbEWSwCMX1it/DGxECcJT7ZXneDI6DZfAeVLFIg6uIOX6oMmR0QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfKtUQPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81218C19423;
	Mon,  2 Mar 2026 19:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772480081;
	bh=miPePayw+w4YDui8oX6YxeGULNU5oqC1RDU+hLjpQPI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DfKtUQPWmLhOghpHrA7YNi0stP0J+4kIthim9d06+ozI3UIVv+eHi24cWDxik9ILI
	 wAtAQAm9La2ZOw2crCU9zD+7bU9aRu3Xa0LP/52Pyy4AensO+0BO4/klAhGlRRh6ug
	 HEoXKszMGFKF5mQKc1A2W2Pa+cDn3Msz/UvA6uMQ0reOZ9JR6zvyptQA3tz2K0sn/C
	 9kLr939NuNg2Cz8Fxd9Tg5EfLiF09qT1+1+A6sUGkjE2X98jtn0GrOWIhgNbvEqddE
	 DWfHIFEdrGShJp+p3oDgjg5ux43phpEGhMOEBbqXLN0Yk/8yGL/LQKF/hH0PFr8LPZ
	 3lA6VBKQiXouA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260226-get_vector_affinity-v1-1-910a899c4e5d@nvidia.com>
References: <20260226-get_vector_affinity-v1-1-910a899c4e5d@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/core: Delete not-implemented
 get_vector_affinity
Message-Id: <177248007902.993006.9633514710267482543.b4-ty@kernel.org>
Date: Mon, 02 Mar 2026 14:34:39 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
X-Rspamd-Queue-Id: 843A41DED9A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17399-lists,linux-rdma=lfdr.de];
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


On Thu, 26 Feb 2026 15:44:12 +0200, Leon Romanovsky wrote:
> No drivers implement .get_vector_affinity(), and no callers invoke
> ib_get_vector_affinity(), so remove it.
> 
> 

Applied, thanks!

[1/1] RDMA/core: Delete not-implemented get_vector_affinity
      https://git.kernel.org/rdma/rdma/c/d5712689e05c9d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


