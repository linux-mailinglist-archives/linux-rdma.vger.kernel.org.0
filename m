Return-Path: <linux-rdma+bounces-20834-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NymENahCWpdigQAu9opvQ
	(envelope-from <linux-rdma+bounces-20834-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 13:09:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE109560A23
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 13:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D71D73002B60
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 11:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8409135F5F2;
	Sun, 17 May 2026 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDC1dpf/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473C735DA6A;
	Sun, 17 May 2026 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779016141; cv=none; b=DtP67jIWiOnLydVCoQTdz1yC8diMEKdTvA/y/MZaXWY9xf1D8b6EScwNLLkclkqw6YZOHF9eiRsCZfJMJ7jD4gDNjFwCAjrQ1kCx9hNz2xf7OG7WCScy97jCqBizAgVb72TKlyV4V3DAfHVQ2XKnh1JCH//fOl/HyJiozRl6tiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779016141; c=relaxed/simple;
	bh=RoRJgoXo3TWtbQuTtO53vWzQ9ZyqCPnMiqA6jsk+czY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nmk6lmxwtbJGfjMW4kyPwGbjBUwSHDXH4Bitxm3B4KWGUk8lj97K/PK90AfsJVMSigTKprhmRtRoX9tijL3RhR08gsWpPfyuKGpCf6bk7qTmIP68NvzAZbwtqcZAeYovBMRKwwOCD/HETfq08toLz2EKl9viR4CX9XyWlNfjqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDC1dpf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C08C2BCB8;
	Sun, 17 May 2026 11:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779016140;
	bh=RoRJgoXo3TWtbQuTtO53vWzQ9ZyqCPnMiqA6jsk+czY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VDC1dpf/TjLMNs4mVXRCQwxZPs/8WSBUnPlaM61Fv9B9GLMNhuvGIHK1R8DlBQ4Zh
	 3DscNyKy4GeBA3NVjl5jls7RVC+TlgPXPTc/RbBMFFf9ZRtBkeE49AuaY6DlMgq5rP
	 eGiTGIcAYuqFn151vLoz6Q9QZqW3chmD+SeVPvI+wvUqQLe4EAVtAqgYfTKVlAjwFk
	 7EchUCQMjW03IIckRr4yik7U8G0Sf4zWEMOu8emgFOoJkvDeRH33uwUrJT5RJMLCLO
	 7Zo3a5+Tr8r4Avwt0CpXCoDA5dDDzSUBd1Q51xx92Z7E41FkPicf5PRhIfyFw/lmEw
	 6w90unP8r8M/Q==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, shirazsaleem@microsoft.com, 
 longli@microsoft.com, jgg@ziepe.ca, 
 Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260512094209.264955-1-kotaranov@linux.microsoft.com>
References: <20260512094209.264955-1-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next] RDMA/mana_ib: Report max_msg_sz in
 mana_ib_query_port
Message-Id: <177901613797.2522313.12850778211524772136.b4-ty@kernel.org>
Date: Sun, 17 May 2026 07:08:57 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Queue-Id: AE109560A23
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20834-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Tue, 12 May 2026 02:42:09 -0700, Konstantin Taranov wrote:
> Report max_msg_sz for mana_ib, which is 16MB.

Applied, thanks!

[1/1] RDMA/mana_ib: Report max_msg_sz in mana_ib_query_port
      https://git.kernel.org/rdma/rdma/c/e37d7f67745eb6

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


