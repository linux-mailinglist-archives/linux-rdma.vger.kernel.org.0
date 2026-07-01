Return-Path: <linux-rdma+bounces-22773-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qwamI5JjSmrnCAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22773-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 16:00:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 106AA70A319
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 16:00:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=I7pV4J8p;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22773-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22773-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0643430174DA
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2026 14:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924F037B02E;
	Sun,  5 Jul 2026 14:00:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3E637DE9D
	for <linux-rdma@vger.kernel.org>; Sun,  5 Jul 2026 14:00:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260044; cv=none; b=bmngl405MJHJBi7cOaOO3gy17qmLU96EMZWTSfckZIkaAbj8kZ5i8F1w0QitCAZcsOHkciz5sIMvMt9DKr9xump3sQf+cgH6zNlMgam9ITi2IkSL05gp3wQjcssI1gZcqVL9EUXAp65kkDefIvOj5nYDOjQ1KE7aFZnLTJJ/CXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260044; c=relaxed/simple;
	bh=y7TRnlr5oQVJIZI4AuDmRlbnfiDMichbGwxIa3K4MtM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h31Z41c3sflhR4TEJngaBHaypKZuMW14+ZNkrnbUD6qzk9q9HdsvFj//ZRJ3F4sIM2E7boDxKz0nX96y9mTPADjjsF6G7mSKONeya9I2/67aRNliNjS9jPXLcTd2GjhxI9ajqIEwNyBbJqNV2TAlksQvo6FDuGeZN7tIwWTVCjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7pV4J8p; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D431F00A3A;
	Sun,  5 Jul 2026 14:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783260043;
	bh=3IPaAWhG+/8CQhbkQN8vfY8/QL1sw296eIj0KFHosgk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=I7pV4J8pLCxkVwwLXfkk/6KwnEmwoFsKbf1UK/uDXJpOYzqWMsPxgVG+CGPpkiyzn
	 2ECVUlnSoOcq9/tW7zhBqmFWXG0StiaMurQa2oc9rBSAB61IqI+nom9hPRdNyjm6DJ
	 a2VMMPibb+PmOuP8oeIgYUWMM5LjPyPq58wIlwmuULraHmdXqIrlnmUzhE2oo78c+k
	 Z7ZOzujHtM3kF5EeDka1qHJ3bfoJe8DJ3ynnmWKCt6EuiD51WbK+J0jhcZ2bh8rmld
	 kJjVrniFEBz3bL7Pgl5Zn4Fuo3p47aw8BRcGUUWaLlKnnGEePdQPa44eIy2/ITSqgD
	 IfbYBNwN6pT/g==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, linux-rdma@vger.kernel.org, Tao Cui <cui.tao@linux.dev>
Cc: Tao Cui <cuitao@kylinos.cn>
In-Reply-To: <20260615003646.168704-1-cui.tao@linux.dev>
References: <20260615003646.168704-1-cui.tao@linux.dev>
Subject: Re: [PATCH rdma-next v3] RDMA/nldev: add resource summary max
 values for usage display
Message-Id: <178292866708.469534.17932937589206047374.b4-ty@kernel.org>
Date: Wed, 01 Jul 2026 13:57:47 -0400
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
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	DATE_IN_PAST(1.00)[92];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22773-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:cui.tao@linux.dev,m:cuitao@kylinos.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 106AA70A319


On Mon, 15 Jun 2026 08:36:46 +0800, Tao Cui wrote:
> Add RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX netlink attribute to expose
> device resource limits (max_qp, max_cq, max_mr, max_pd, max_srq) in
> the resource summary alongside the existing current count. This allows
> userspace tools like iproute2's rdma to display resource usage in
> curr/max format.
> 
> Expected output from "rdma resource show":
>   Before: 0: mlx5_0: qp 123  cq 45  mr 200  pd 10
>   After:  0: mlx5_0: qp 123/131072  cq 45/65536  mr 200/1000000  pd 10/32768
> 
> [...]

Applied, thanks!

[1/1] RDMA/nldev: add resource summary max values for usage display
      https://git.kernel.org/rdma/rdma/c/5911f6d6e7cce5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


