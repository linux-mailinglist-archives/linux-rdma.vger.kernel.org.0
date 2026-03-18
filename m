Return-Path: <linux-rdma+bounces-18310-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA20ONZ9ummTWwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18310-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 11:26:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0D32B9D98
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 11:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8356931046D5
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 10:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADED334DB66;
	Wed, 18 Mar 2026 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9II357F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723E9322B88
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773829445; cv=none; b=GvhdZTKXqhPZNcclmOIkNuCKiLiBRH2mH6VB6A97x8c+ut0u75nyc2rMHRLbA0tQc6TREqH98G2qQYisAS29zx9ChyC33aUcJEfza3fL/QNBeq3R0k+erfpi3tRmw1taj78Qe48j61K3qFrkhjK6AXKWbYFu0k/Lyp4YuUKuXVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773829445; c=relaxed/simple;
	bh=rsZmgO1fYAapRQfzEbNBXct94uBdPvaQlRfFBB77eQ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ep6JDWc+zZAc2907b6e/ubXDCGIiZxrBA3Y9iLdJ0xVCS1QkCIBRcfuIen+LgQwUsEuULHzzlisnaQU8ZHKTZmnStq1o7hCXzKLUV5WXISbgaZV75BrzA3LCCJiwKF1FQwy8u4L1FiAQ7pp/60BbbkCdaPpcfakRKm31FrzgJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9II357F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37BFC19421;
	Wed, 18 Mar 2026 10:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773829445;
	bh=rsZmgO1fYAapRQfzEbNBXct94uBdPvaQlRfFBB77eQ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=h9II357Fl8vAXjTqKnBevAY4MW9tYs+KxP3xrzpFhhUqkwqSFhzKy4xOjbX9zoMVS
	 urF5YX0mGB3kqtCA9jmnJuUUrC44RaLJwwE4DqbztJp+g4vCAf96TvPa22iDLQLj3b
	 mPFe8OE/lvn73UZ0xIMSrnkQmv4YcNhCVaSYpmw7rF+EWG6grqTuu8g7GLQjOxQARo
	 WKQoTqMl/Z8+7djOwxlVnbAX8MUHaA7vGQXB2OKyPPQpSNvg5QJxjAX8BgaTz8KWhz
	 s0WfITgN9dmd2M/WC5sci2/g0LR6rKSqwLZzCHHrrXeESlwSqqzlZDUG5CabqeCP/w
	 E/1y67zpBk3jw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: linux-rdma@vger.kernel.org, krzysztof.czurylo@intel.com
In-Reply-To: <20260316183949.261-1-tatyana.e.nikolova@intel.com>
References: <20260316183949.261-1-tatyana.e.nikolova@intel.com>
Subject: Re: (subset) [for-next 00/12] RDMA/irdma: A few fixes for irdma
Message-Id: <177382944206.752471.10465671999149444195.b4-ty@kernel.org>
Date: Wed, 18 Mar 2026 06:24:02 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-18310-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7B0D32B9D98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, 16 Mar 2026 13:39:37 -0500, Tatyana Nikolova wrote:
> This series includes a few irdma fixes:
> 
>  - Change request_done type to atomic
>  - Change ah_valid type to atomic
>  - Clean up unnecessary dereference of event->cm_node
>  - Initialize free_qp completion before using it
>  - Harden SQ/RQ depth calculation functions
>  - Update ibqp state to error if QP is already in error state
>  - Fix deadlock during netdev reset with active connections
>  - Return EINVAL for invalid arp index error
>  - Remove a NOP wait_event() in irdma_modify_qp_roce()
>  - Remove reset check from irdma_modify_qp_to_err() to ensure disconnect
> 
> [...]

Applied, thanks!

[01/12] RDMA/irdma: Initialize free_qp completion before using it
        (no commit info)
[04/12] RDMA/irdma: Update ibqp state to error if QP is already in error state
        (no commit info)
[05/12] RDMA/irdma: Remove a NOP wait_event() in irdma_modify_qp_roce()
        (no commit info)
[06/12] RDMA/irdma: Clean up unnecessary dereference of event->cm_node
        (no commit info)
[07/12] RDMA/irdma: Remove reset check from irdma_modify_qp_to_err()
        (no commit info)
[08/12] RDMA/irdma: Fix deadlock during netdev reset with active connections
        (no commit info)
[09/12] RDMA/irdma: Return EINVAL for invalid arp index error
        (no commit info)
[10/12] RDMA/irdma: Harden depth calculation functions
        (no commit info)
[11/12] RDMA/irdma: Provide scratch buffers to firmware for internal use
        (no commit info)
[12/12] RDMA/irdma: Add support for GEN4 hardware
        (no commit info)

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


