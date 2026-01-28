Return-Path: <linux-rdma+bounces-16150-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGLTA0n/eWm71QEAu9opvQ
	(envelope-from <linux-rdma+bounces-16150-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 13:21:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FFEA1231
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 13:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C794301D05F
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB93B2F6165;
	Wed, 28 Jan 2026 12:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBgxhgh2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C72E8B98;
	Wed, 28 Jan 2026 12:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769602739; cv=none; b=FX+EtJPjxv3cgFa5UFkk86o85SSRvJ9VpNsh34xUW11Xzy5MFgvMRM/w/u8sW93lZPyz1OFFlhSyFYFFg4+9rZ26r5k+YadQhK1ZXYKTfQbpCZAcsopu8cpW0PbBzQa/xrGljzNsrxYE0Iupy+4Z9h82o1G/b6lpQOzjvyNZvLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769602739; c=relaxed/simple;
	bh=F5pQw1a6a+SIfvOfhXS7H2+dwAt6MCZdib2T/iPUi/Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gPU6HjkxsRcDTLvgWLqNxvY9JNgmEZwxQOgA5A3UWaUxFBEiaRnGUvZos9PuIe2fNStTYwspU+v19eQmhZeE4dnz9YdO+cGjiryVpGtZxgcltmdkJ65DYkQUPRT6LYrdIX052ieiZoniL+N2l0GnyL9ZrSg3DNGnBh9Hd1T1BAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBgxhgh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A698BC4CEF1;
	Wed, 28 Jan 2026 12:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769602739;
	bh=F5pQw1a6a+SIfvOfhXS7H2+dwAt6MCZdib2T/iPUi/Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FBgxhgh2Q6oZVNxrE8LGLmSt07AcCeGpuxr7w8TcNlm/k95qTLBen2XWrsXGetbZQ
	 gQOWwlshwpF2+t2pd71om1/uHTKAFZ4nkUeUCRqplS82F8Yj5W3JilMMB9GegtqdZk
	 IOn4K0F0jmyMN9GkoO2plN1lVEU51WdAP0aTHEyGvSEEGXihkiRnE73paYRaw2GV3g
	 M3/iB8JvCBNfQw3VAmH8etTuAj3vE8p8FWEMTMQfsFuGPUo/QO0YRY2rbqTpNMOatA
	 XzGq8VTamp4BaDGOFowOUQM0oSL/smRjqEwvl2TFYq1JT12ia/jFkzCTrpP/2SG9s6
	 VCt1A8Vv+He4A==
From: Leon Romanovsky <leon@kernel.org>
To: carlos.bilbao@kernel.org
Cc: Carlos Bilbao <carlos.bilbao@lambdal.com>, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>
In-Reply-To: <20260128014446.405247-1-carlos.bilbao@kernel.org>
References: <20260128014446.405247-1-carlos.bilbao@kernel.org>
Subject: Re: [PATCH v2] RDMA/irdma: Use kvzalloc for paged memory DMA
 address array
Message-Id: <176960273607.35487.18087501676811274121.b4-ty@kernel.org>
Date: Wed, 28 Jan 2026 07:18:56 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16150-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92FFEA1231
X-Rspamd-Action: no action


On Tue, 27 Jan 2026 17:44:46 -0800, carlos.bilbao@kernel.org wrote:
> Allocate array chunk->dmainfo.dmaaddrs using kvzalloc() to allow the
> allocation to fall back to vmalloc when contiguous memory is unavailable
> (instead of failing and logging page allocation warnings).
> 
> 

Applied, thanks!

[1/1] RDMA/irdma: Use kvzalloc for paged memory DMA address array
      https://git.kernel.org/rdma/rdma/c/959d2c356e32ab

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


