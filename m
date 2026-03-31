Return-Path: <linux-rdma+bounces-18846-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFwWA1fRy2mILwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18846-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 15:51:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 665C836A874
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 15:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B75430467DA
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 13:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB68F33263F;
	Tue, 31 Mar 2026 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwhVOFmo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7713630A0;
	Tue, 31 Mar 2026 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774964712; cv=none; b=LEGbgGyMxzVOJdohEsVr+AsQOi29um91mdECp8fgcDUrEmvdQyD2sJjYrW1QlyrKX30EQQv+cRTDF1nXnakSrY7UNDlKQ5uGJA4NjLMna5dJbXYkADPObJF3iGeulhwMqBVYqO5JfzOIWlIG39pgMywTJrSeyjLW38nGK9JRcx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774964712; c=relaxed/simple;
	bh=+rXRTnfq/E4V9DYqU+mgl8EQlW+xLpGIZqzQ6WqwiGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ee3cA3yq1Vbv4c6q8mjyA0Y5z1wPlp23oC3S2pIILL3CLSiCzot1H0rfh7ZBMR5Fh63fq6DFwxbISra+eGYdcuNYym+FzX+0gZo2agnEzH/nKg6xIKr1PHa6cITzFtSaSRumIXxEeK+w388sBhr4TdJD20tv4SMqfPT0kibTTv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwhVOFmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE0EC19423;
	Tue, 31 Mar 2026 13:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774964712;
	bh=+rXRTnfq/E4V9DYqU+mgl8EQlW+xLpGIZqzQ6WqwiGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UwhVOFmoKSu6IYNxb7oykQ5Xnh5wyWmNKCY5olGh0T+A4zmf3YVPpjPTqkC2oxfnj
	 vu8GHFX6lS3JPemlcj2SQElDTMtkG3Se2V+lEL1qhdCOrSDPKfDXzz4ZefUQ1no9er
	 WyJc349qB4xgDjneaBoi2UUlDVwve2Coo1+0+6YdLiZ9xeVJna78ss6i/PBPSCS6bn
	 aX3M/gEgle8p/VTo3dKgkh+0KQJUhybjjea3TvbsCs7jMEyqCToNtAUmbEqgyAjQHe
	 30JTWUxjE1N9foNBRkJrmpb7zguNUCLB36Du0K02kkr0YKKsnpUeX5gUrYP7dpOl38
	 +Gv8yKWbboB8Q==
Date: Tue, 31 Mar 2026 16:45:08 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Haggai Eran <haggaie@mellanox.com>,
	Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/mlx5: Fix memory leak in GSI QP destroy error path
Message-ID: <20260331134508.GD814676@unreal>
References: <20260331004811.8851-1-prathameshdeshpande7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331004811.8851-1-prathameshdeshpande7@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18846-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 665C836A874
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 01:48:10AM +0100, Prathamesh Deshpande wrote:
> In mlx5_ib_destroy_gsi(), if the call to ib_destroy_qp() fails for
> the hardware receive QP (gsi->rx_qp), the function currently returns
> early. This results in a memory leak of the software resources
> (outstanding_wrs, tx_qps) and the 'gsi' structure itself.
> 
> Align the GSI destroy path with the 'best-effort' cleanup pattern. Even
> if the hardware fails to release the QP, proceed with the software
> cleanup to prevent orphan allocations.

GSI QP are different from other "best-effort" failures. It MUST to fail.
We are intentionally leaking resources here.

Thanks

