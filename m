Return-Path: <linux-rdma+bounces-20595-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yM4nCjK7BGrFNQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20595-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:56:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A87155386DF
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 331B430DEA90
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 17:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAFC4D90C7;
	Wed, 13 May 2026 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxhJjjcr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36BD2F0C79
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694323; cv=none; b=psY9NNKMh0+WScGqZMJzqlwD6hovEbt2amRjVUdMK0avyDMlcD+yJYVurtK7T4R0ys+YZ3siA6G+zTE4aMB6HJab76RVyTe3tGg6p/oehrmFsqxL7RTMexXc8+ongAC59oida+NtnTdk5RhdnyrqFQufhPjCdo8sSkMMLvZRfRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694323; c=relaxed/simple;
	bh=jRdU4Cw6BrORWapC3GXn8KOGTuivxHKetOgwKZCgpcw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EGsVHkNSFkz7dlUQSj8xvpRPtt0iJCxjfTAY16GAEKazT11WevBnWPY3hR60ryfSN3Qr/HLBdH7qECqXjRXmozxL4+MyFPuDWcNYjAeXCarjwSBQC9+IViCu5P318hwLKC86dSQnpuNPP+r1cmal9B0iPDcDeNCEybn6IDoO1Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxhJjjcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BCFC2BCF5;
	Wed, 13 May 2026 17:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778694323;
	bh=jRdU4Cw6BrORWapC3GXn8KOGTuivxHKetOgwKZCgpcw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mxhJjjcry7pAC0O9av1kpn2g4KoqJ18WQKwwo8NmoHKKhuJyQCtxtIUnErQ68nSdJ
	 y2wFougn17hj5h5csDiAk/SzXZBPoFhVgcUCE6LC5K4CQo893/zCMCfwhWR/jOdHo6
	 AW+GXG21ZJraO/k+WT5QgpDvrBMfuHRoplJ1+qtZ+xOUcWhFBBvagnf2aMIPZuF1oa
	 dbbgU3VAB1V2J1FUhFOel6q0+ySa3wyNE+5CLvcmnHpqPx31WRVr4F6OzF4puRKoG2
	 qOr5KXufiQaVF2InBlTmn19MxwXftEV9MQFkToCe2zmfEgIu9VuVMybTffuEnqRN5E
	 /ng0z4Fo81gHA==
From: Leon Romanovsky <leon@kernel.org>
To: rosenp@gmail.com, bernard.metzler@linux.dev
Cc: jgg@ziepe.ca, kees@kernel.org, gustavoars@kernel.org, 
 linux-rdma@vger.kernel.org
In-Reply-To: <20260511141149.52362-1-bernard.metzler@linux.dev>
References: <20260511141149.52362-1-bernard.metzler@linux.dev>
Subject: Re: [RFC PATCH v3] RDMA/siw: use kzalloc_flex
Message-Id: <177869432039.2333679.10257766726760194039.b4-ty@kernel.org>
Date: Wed, 13 May 2026 13:45:20 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Queue-Id: A87155386DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20595-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Action: no action


On Mon, 11 May 2026 16:11:49 +0200, bernard.metzler@linux.dev wrote:
> Simplify umem allocation by using flexible array member.
> Add __counted_by to get extra runtime analysis.

Applied, thanks!

[1/1] RDMA/siw: use kzalloc_flex
      https://git.kernel.org/rdma/rdma/c/79678bea399052

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


