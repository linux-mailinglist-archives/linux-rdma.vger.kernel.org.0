Return-Path: <linux-rdma+bounces-15998-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL10FCBxdml0QwEAu9opvQ
	(envelope-from <linux-rdma+bounces-15998-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 20:38:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAAC823CB
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 20:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C961D30038F2
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 19:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21002F83A7;
	Sun, 25 Jan 2026 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EW91Ki1b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7338C800;
	Sun, 25 Jan 2026 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769369880; cv=none; b=fhRgNkbpWsLhFeAFFgAfD/Z9QK+cHOrBxVXZwPpVGyjjhZlelWy55uqY9ggw6gg4hVnXLyH6XneAaxPt9V6sUNCKW64QAAPmyNGJy0wLzu30zPLhPXB2z0Q1EL4UPpdvUCivYbTGXZYSm548qEQLg8IB35ByikSPrd0G5TRWV/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769369880; c=relaxed/simple;
	bh=CJJoAyHycnWBHWJ3K9UH9JsSF4QzEnlHxtNRXEkKYF0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AH31UiTV9zVIa6za7tOoh72VsZa+2QhB/TSWMWr3+O12Df6gMrzD/K0+7I4OOe0QGP1nN+wTMl14Putn8BwKMmKzJpk3rVJcTz4fYdLTrHCd7wREd5lVqebORuz8AXOqkHqQTwmFmUZexME5zSBvyqBbPVloR5AXSWBnZvvmwfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EW91Ki1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0D6C4CEF1;
	Sun, 25 Jan 2026 19:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769369879;
	bh=CJJoAyHycnWBHWJ3K9UH9JsSF4QzEnlHxtNRXEkKYF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EW91Ki1bnyV6hL0gLSqe0lWMgwVzGSEO4FxhMWUnXMJUxea7tCXNpnWQtApwfQsQz
	 hXX+wKr1b9LhB54vNjlPyKAUT8zMLomBW7pBDjFm/C45EE4TZN/iQ9ABQo52rBYGEA
	 bBjygq4DfWF0iZEbaon9lr3xXRrPyxqPKQA21ynK3QScoof5Ae+PR/nw4A8T8bC5Vr
	 qBWPVTdJkJUBRaZZfEY58mWZCorDxb2GGvdNYTeB48vhxHWsj6JhL23obe5FdjbIFC
	 pnEQ5wZDzrLsEvtzNMpcFqqVNbK65jGwK/QTWTxOV0itRjxTwgfB7lP4zy302fhCAf
	 rmI42ODIOJDLg==
Date: Sun, 25 Jan 2026 11:37:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alice Ryhl
 <aliceryhl@google.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Leon Romanovsky <leon@kernel.org>, Steven Price
 <steven.price@arm.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 7/7] netclassid: use thread_group_leader(p) in
 update_classid_task()
Message-ID: <20260125113758.0f985df0@kernel.org>
In-Reply-To: <aXY_4NSP094-Cf-2@redhat.com>
References: <aXY_h8i78n6yD9JY@redhat.com>
	<aXY_4NSP094-Cf-2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15998-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CEAAC823CB
X-Rspamd-Action: no action

On Sun, 25 Jan 2026 17:08:00 +0100 Oleg Nesterov wrote:
> Cleanup and preparation to simplify the next changes.

Acked-by: Jakub Kicinski <kuba@kernel.org>

