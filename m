Return-Path: <linux-rdma+bounces-16152-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLw5GH8Cemn31QEAu9opvQ
	(envelope-from <linux-rdma+bounces-16152-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 13:35:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCE8A1514
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 13:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D34A73077107
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F5434F253;
	Wed, 28 Jan 2026 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRlKumqp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AB634EF1F
	for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603473; cv=none; b=nQHffDMwbsISan2Hy1woIO8o3FmlLY2Je88iclFzKoTbq7XlOb2HZa20mY0VQmAtzVhTdRZYL4zwNJ8zaeb0OWHEnVu0spz77lHQKgfHjY0/K7vxrkPzmz6X196TgYBHXyFdFMkPkQu2n/N66znyreeg62Gcexj4p9koBoCa5rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603473; c=relaxed/simple;
	bh=+IXb032ARu2hzERwL/5X/RoWUmkELYJGAtjlIbIKCjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzGAtFLnBBJoRJPNSf2TspoATFi6adWC2TXTFCfyDpvYvtq2Rbp6VgNfZQZTdxa7YX84P73/p7XMEFFwVc+pF+TBWXqTwKTGxLlBi9Y6JKFuNxlRdSgmIQFR/x9ijIL8aM7TzESsP/rTiFlsTe5/ysFocqRlInUXOHJ7Cixe26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRlKumqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0454FC16AAE;
	Wed, 28 Jan 2026 12:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769603473;
	bh=+IXb032ARu2hzERwL/5X/RoWUmkELYJGAtjlIbIKCjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PRlKumqpPpOzikFptzY75hgxk/S/4HicbZy+s2y2EUZhOP8khzp0TlfMkzhfLCrZI
	 ooH6rRBOFEPx5wJ5ORd2bjh4+an4o8jHUSUm5MqD1/Lk5DdrHQ8i9R1UN3SJGDpqZS
	 6yvU/wIJPUY3TsRgKg6mPOY7TRB8857MjtcxH211Kuj/sk+9OpYqCFS3XbaWcsT0n/
	 DY3SBGnMkoO2NuOtPHwF73LRQCD/XxXq60Vvkta1+hjTgOGR7BWOnyr36i7P8w3Dxj
	 ATTn+6BQnY7aQ990OUzVpAYCqTcyG2meKIRpFWehti6Q8CJ4gh4ie/xzt6tm+tINfw
	 2TquabMfnG3zw==
Date: Wed, 28 Jan 2026 14:31:10 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH rdma-next v9 1/5] RDMA/uverbs: Support QP creation with
 user allocated memory
Message-ID: <20260128123110.GB40916@unreal>
References: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
 <20260127103109.32163-2-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127103109.32163-2-sriharsha.basavapatna@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16152-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFCE8A1514
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 04:01:05PM +0530, Sriharsha Basavapatna wrote:
> From: Jiri Pirko <jiri@resnulli.us>
> 
> This patch supports creation of QPs with user allocated memory (umem).
> This is similar to the existing CQ umem support. This enables userspace
> applications to provide pre-allocated buffers for QP send and receive
> queues.
> 
> - Add create_qp_umem device operation to the RDMA device ops.
> - Implement get_qp_buffer_umem() helper function to handle both VA-based
>   and dmabuf-based umem allocation.
> - Extend QP creation handler to support umem attributes for SQ and RQ.
> - Add new uAPI attributes to specify umem buffers (VA/length or
>   FD/offset combinations).

In addition to Jiri's feedback, there is no need to copy and paste an
AI‑generated summary of mechanical changes. We can all read the code.

Your commit message should focus on the motivation and any relevant caveats.

Thanks

