Return-Path: <linux-rdma+bounces-16018-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HsMGzFnd2nCfQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16018-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 14:08:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC56889AD
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 14:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B501F3017BCF
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 13:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDBA3382E8;
	Mon, 26 Jan 2026 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjhGDSRV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CD03382D9
	for <linux-rdma@vger.kernel.org>; Mon, 26 Jan 2026 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432875; cv=none; b=G4sBQCyqyO4uqZN9aw1t/0hrPYOM6UJSVLR0/N8Og6jZbOYKB8VQ0kMJ9Ptb7rL0v/sHNzzydZRQxVaD3pTN2qFq9o9vjWXsxEsmuoK9DLMJiZzYWuuVgVKPIt4IOx8FXu9k6qCUFWhdQAnkYqLahlywX87DrAe4u/SgB/oEoFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432875; c=relaxed/simple;
	bh=B/5YeOvDnLTI8cymykg5V9MqsXBBOk2SyzKtXCFLRaM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OBBgBA/zDpqlUZ/Lps2DrT7zQ1bCjLTFUULt34/vDm6KzNvJ3tc2Mlry/TlITKdR7jrHZoPc/7aeoziwib0WS7uMLLQ6NB9hOEydLvZhF8mP726z+vDihoSSbzCovprJRPAN6gdpd7LrNPl1HRMp6ZIp167PLpi3/pnBwfxvr4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjhGDSRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF452C19425;
	Mon, 26 Jan 2026 13:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769432875;
	bh=B/5YeOvDnLTI8cymykg5V9MqsXBBOk2SyzKtXCFLRaM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mjhGDSRVHTNI6eXPczVsGLzEqbbEQyFRHH3HCBkmp0h9Ff3wPsviQRMEmeyJFQ0Ld
	 WmOKfUWT/fPTMPZMPRtFvLZ9eO9WY8MRyI6QzC2a2pd1ff+GJaDg6DS3G5/MogFuns
	 6wXnkUZPikFpikKv7lHLpcrPXqenmRP3VeePZ5z0NDFfIbV1QQWNxqyv2bD7ZWSg4J
	 qXUwlWC7EIFUdVRfP91oVllalAxysqT1zNOLSmc+FA+l/wjrMGtM2HwnIBEbeNdJpg
	 RHM5psek98YLYhGzixziSX5V5qs9kpb4DMoJzYiNlUq9m3p7FRHW7HiSTtMxf9i4pw
	 4G7WxHbUjywwg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Yi Liu <liuy22@mails.tsinghua.edu.cn>
Cc: linux-rdma@vger.kernel.org, security@kernel.org
In-Reply-To: <20260122142900.2356276-2-liuy22@mails.tsinghua.edu.cn>
References: <20260122142900.2356276-2-liuy22@mails.tsinghua.edu.cn>
Subject: Re: [PATCH 1/1] RDMA/uverbs: Validate wqe_size before using it in
 ib_uverbs_post_send
Message-Id: <176943287232.905908.15213939727195511144.b4-ty@kernel.org>
Date: Mon, 26 Jan 2026 08:07:52 -0500
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16018-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0DC56889AD
X-Rspamd-Action: no action


On Thu, 22 Jan 2026 22:29:00 +0800, Yi Liu wrote:
> ib_uverbs_post_send() uses cmd.wqe_size from userspace without any
> validation before passing it to kmalloc() and using the allocated
> buffer as struct ib_uverbs_send_wr.
> 
> If a user provides a small wqe_size value (e.g., 1), kmalloc() will
> succeed, but subsequent accesses to user_wr->opcode, user_wr->num_sge,
> and other fields will read beyond the allocated buffer, resulting in
> an out-of-bounds read from kernel heap memory. This could potentially
> leak sensitive kernel information to userspace.
> 
> [...]

Applied, thanks!

[1/1] RDMA/uverbs: Validate wqe_size before using it in ib_uverbs_post_send
      https://git.kernel.org/rdma/rdma/c/1956f0a74ccf5d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


