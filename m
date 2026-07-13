Return-Path: <linux-rdma+bounces-23097-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DZCdCrSlVGoZowMAu9opvQ
	(envelope-from <linux-rdma+bounces-23097-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 10:45:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F54C748E18
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 10:45:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Hy5rKu0Z;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23097-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23097-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86450300602E
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 08:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9293B3898;
	Mon, 13 Jul 2026 08:36:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BB33B2D18;
	Mon, 13 Jul 2026 08:36:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931781; cv=none; b=AWhqsbuaXGjcxGfX0q83/0jcvHdEGL5ttDNPz5I7xhmVchCMIStV6O9Jy7of3XG00HED6fq7S6PcsPP25EntlDQ/d9MQ4SXfGkktVFkhjWbUad+WM5pplQNpnn9kpGMzAsu5DLqyU9kGQK+tX8uhu/tGoKHTVQ7phndXgsLshAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931781; c=relaxed/simple;
	bh=dLfURvyONimeAjYipF2/rUflFTv+KVQKgD2DtEnkhAk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QItcE+I3MBdiuT7jleKuIFVF5MJtqoyOCHw/zitYPfK01sjWjrJAUJeRhpwfFRV61BibXP/BmhsIV3u5UKopbtEOvqktepdJiZs8YOgZRpQUIETfEtKEtCAp8wSsSQmzIzdKlk0JHoE3EOvya4Ps2MEdHq51BFxohhXgvaijQzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hy5rKu0Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAD81F000E9;
	Mon, 13 Jul 2026 08:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783931779;
	bh=I4buFcsf30H6aCot49azEcvMwmak6OkUu/zmiH06haQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Hy5rKu0ZXt3yYonMMUesuXVQJBVxb54GSRUhmu8S+eH6bhuLRRq5Ac3NynQ/SEhbl
	 99X1SIIg1rfSLq3UFOfTQVedkCAOGp84AhgXeO9bx57vNniKXMpjHj2XBd8gagBf+f
	 HaMrasY+QktV/3FPk/m2qxKGP1SqlfQcznRz/kW+6qhTO6R4MGt0trS6IjEO9q4aNP
	 NwuXWUBqPRnLM5THCD0p2+NKcIyYzn6MTg140IAGjzCE56mp/n4xYMp0ZFoRRCSdOA
	 LLEv15y9tsVuVuZsrsgM1nPfGht/TF78qaX6PYiFvP2n4iB40C2Es/fj6KwRM0Fk9A
	 jvej8vVkg7Kkg==
From: Leon Romanovsky <leon@kernel.org>
To: yishaih@nvidia.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Cc: manjunath.b.patil@oracle.com, anand.a.khoje@oracle.com
In-Reply-To: <20260615171759.557425-1-praveen.kannoju@oracle.com>
References: <20260615171759.557425-1-praveen.kannoju@oracle.com>
Subject: Re: [PATCH v2] IB/mlx4: delete allocated id_map_entry while
 sending REJ
Message-Id: <178393177689.1679084.4077224530208522909.b4-ty@kernel.org>
Date: Mon, 13 Jul 2026 04:36:16 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23097-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:yishaih@nvidia.com,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:praveen.kannoju@oracle.com,m:manjunath.b.patil@oracle.com,m:anand.a.khoje@oracle.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F54C748E18


On Mon, 15 Jun 2026 17:17:59 +0000, Praveen Kumar Kannoju wrote:
> The mlx4 CM paravirtualization layer rewrites a VF's local
> communication ID to a PF-visible ID when CM MADs are sent from the VF.
> For messages that start or advance a connection from the VF side, such
> as REQ, REP, MRA and SIDR_REQ, mlx4_ib_multiplex_cm_handler() allocates
> an id_map_entry when no existing mapping is found.
> 
> A REJ is different because it is a terminal response to an already known
> exchange. It should either find an existing id_map_entry, rewrite the
> local communication ID, and schedule that entry for deletion, or it
> should pass through unchanged when no mapping exists.
> 
> [...]

Applied, thanks!

[1/1] IB/mlx4: delete allocated id_map_entry while sending REJ
      https://git.kernel.org/rdma/rdma/c/9539e619660471

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


