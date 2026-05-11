Return-Path: <linux-rdma+bounces-20380-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OebIyqpAWqFhgEAu9opvQ
	(envelope-from <linux-rdma+bounces-20380-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 12:02:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB4E50B7E0
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 12:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA4C2300D34D
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 10:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E4A345CD8;
	Mon, 11 May 2026 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEhPIth/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FE72417DE;
	Mon, 11 May 2026 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778493732; cv=none; b=J3YBkBYrSQVE+XNO3JZmmh/54rggBZjZ3N7SqDk7t1zxzKx/pTVY1xSS/mwzj5X/0iBBT8RlIM0dWIVAhn1A4xVMT8S/9urqkF5kk85nObypd7gHxGcHbXcEEQBVjnRJa2qZICBeVaE1+Ehwzc3cl+HIA9NL8g+Od6VTQ76boaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778493732; c=relaxed/simple;
	bh=3m5fpeO8TZCjV1O4lR8wYNwPEzRrH6JL6Z/PhnuTDv8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JEEFB6WAJv1cRaqcwd3MCQKTfkOb9LAMgCEVTIizk18maA9Qu56BRqcz8dV14z6xWtr2ezhSNODI6Q6F4341ejaVEsOjLijQYGQvoxThzbEhg1/SKr9GO1rhuUC1CD4IiT5sYRTUc1mIRcTaBuRV/pfkBfmE+7mYwLDRJfXZmeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEhPIth/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3082CC2BCC9;
	Mon, 11 May 2026 10:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778493732;
	bh=3m5fpeO8TZCjV1O4lR8wYNwPEzRrH6JL6Z/PhnuTDv8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AEhPIth/fPR1HIHQ5YwRJh4WOqht86selW3buOMNfnp9vBGY1xE4xVIdYGm7M7prs
	 hJJrYDDeZOVXTdKfT1TUc3xIIO6fG/7yPzxm9lFgM9LwDbckBWUb+19h51WVkJrB68
	 zoFE3Z7FqayjOqWzBDxtRCaQWCetfP5RfgjKEIyVyTwWkuxUuxWOlLhdl2h/k4Ln+S
	 JY51Opzwz/TTJF7piiLjmgredWmOSSr9x+II9fofAic6qDLH+bGaH2zt5ZCfwthY01
	 VbVhdQuLUOaK8pglQGVQ4pkalxxOq2k4w2+7Csl9i6xeJQznBR8jUiIasRPlnBL6cr
	 SY5iIz2QGtz7w==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: michaelgur@nvidia.com, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260426132356.22264-1-prathameshdeshpande7@gmail.com>
References: <20260426132356.22264-1-prathameshdeshpande7@gmail.com>
Subject: Re: [PATCH v2] RDMA/mlx5: Fix UMR XLT cleanup on ODP populate
 failure
Message-Id: <177849372983.2263318.7427571852742031816.b4-ty@kernel.org>
Date: Mon, 11 May 2026 06:02:09 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Queue-Id: 3CB4E50B7E0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ziepe.ca,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20380-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Sun, 26 Apr 2026 14:23:41 +0100, Prathamesh Deshpande wrote:
> mlx5r_umr_update_xlt() allocates and DMA maps an XLT buffer with
> mlx5r_umr_create_xlt(). The buffer is released by the common cleanup path
> through mlx5r_umr_unmap_free_xlt().
> 
> After mlx5_odp_populate_xlt() became fallible, its error path returned
> directly and skipped that cleanup. This leaks the XLT DMA mapping and
> buffer. If the emergency XLT page was used, it also leaves
> xlt_emergency_page_mutex locked.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Fix UMR XLT cleanup on ODP populate failure
      https://git.kernel.org/rdma/rdma/c/40d05a2e003357

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


