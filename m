Return-Path: <linux-rdma+bounces-16305-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJIEIqFJf2mDnAIAu9opvQ
	(envelope-from <linux-rdma+bounces-16305-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Feb 2026 13:40:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF0AC5E72
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Feb 2026 13:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 333DB3010165
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Feb 2026 12:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6A232D0F0;
	Sun,  1 Feb 2026 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTqaLd6D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF401E89C;
	Sun,  1 Feb 2026 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769949597; cv=none; b=E3CifMBIRY172ebOmNAIoUMAiNW+/KNd0R749+mTmfSu+5J68KaPwODvTOKe4wVgKN3+GbAs86gP2hLClvfgPMZd0z2EziAPXp6MyOf7eOT+2zWJRe3s0fPpvrqtbnsqQ/kl7P0duLilX9mutEQyHRuKmwwioj2qcCIOilJA+8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769949597; c=relaxed/simple;
	bh=v3+raouSw213YpgfUCrZtR1SGGHs/IsJxIMrwSXNw90=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=domuoN8Xs/87POf19boof7knaJG42YdZMKkTbe4SrIz8wkS4nXqPt0Ho7hvatStESz6ogDNvcWlgVWOqjleC2DFiFaoTM4BcIPJhs0Zu6OsWLzFRq5y02Ba4JYhB7SwfO2el3sm+G53KSzwwk8dEF8HbW+6zBgrsA5Yh9Z93Q04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTqaLd6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A082FC4CEF7;
	Sun,  1 Feb 2026 12:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769949597;
	bh=v3+raouSw213YpgfUCrZtR1SGGHs/IsJxIMrwSXNw90=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dTqaLd6DD6JPADp3lhMDyC5vEkZQ3cab/5cccYRi9X270j0A5xjyVGROM+2f/rEuO
	 kp6GyyrwYRQUWb3RfJeD9ERAE7Kth9EmKjVuyOZJmu1Z2jF6jHPFczA0OfP1RM+lyk
	 nFaJzRlkeusEPluiU/d/xVBNzVDwS01+WTigwle+f+UMhN70J//LY6Wg/shhHtCHJx
	 d2O70HbMfxEGRIHAU1muhrmiBxlogVD626RyagTir2fO7g317u7oLLhBYC9v4xvlLj
	 kXG2ytU0U85vMGvGzuAtDtwD3RL31ueg2uGNwvlOxCyueDE/MLlC/DZmReHYJvwgWN
	 cO9obwdoskWBw==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Yi Liu <liuy22@mails.tsinghua.edu.cn>
Cc: linux-rdma@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260129094900.3517706-1-liuy22@mails.tsinghua.edu.cn>
References: <20260129094900.3517706-1-liuy22@mails.tsinghua.edu.cn>
Subject: Re: [PATCH] RDMA/uverbs: Add __GFP_NOWARN to
 ib_uverbs_unmarshall_recv() kmalloc
Message-Id: <176994959402.82464.1218868614682985568.b4-ty@kernel.org>
Date: Sun, 01 Feb 2026 07:39:54 -0500
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16305-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BF0AC5E72
X-Rspamd-Action: no action


On Thu, 29 Jan 2026 17:49:00 +0800, Yi Liu wrote:
> Since wqe_size in ib_uverbs_unmarshall_recv() is user-provided and already
> validated, but can still be large, add __GFP_NOWARN to suppress memory
> allocation warnings for large sizes, consistent with the similar fix in
> ib_uverbs_post_send().
> 
> 

Applied, thanks!

[1/1] RDMA/uverbs: Add __GFP_NOWARN to ib_uverbs_unmarshall_recv() kmalloc
      https://git.kernel.org/rdma/rdma/c/58b604dfc7bb75

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


