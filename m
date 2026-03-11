Return-Path: <linux-rdma+bounces-17928-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOUdDbHdsGkuoAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17928-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 04:12:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D5D25B4E2
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 04:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5DA76302BBA1
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 03:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC63F35837E;
	Wed, 11 Mar 2026 03:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmO0g5WW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884F935A938;
	Wed, 11 Mar 2026 03:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773198763; cv=none; b=J8f+16G9r6zaHw9SjAADdoiePBhNCqAt85QRvy/Za8G+Ea97fU7VvPzMjZVH/LuYZa2n/nh5PT3tPxPzEV/FMhSGalL6SUPg8atj4qH/8v8wm3MwT6iWpAZDQ/bgYqNHB4XSG/kryCVH1MJSDQgYCJDgWbkK6RYaT7Fme9Rkc5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773198763; c=relaxed/simple;
	bh=SDUWr51B+h5ikqvo7TzBEoMCm6C8OxHIRzg3bWcb7GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7NpCbTHlxCUc0JeL9743WkacyCRl1l/+KgHbToom3CT6iJhTuD0/wE9wiJ8JbRmxBGzgEELec+Mr0lDcIwS80ObM7uMmnSIlfqHF0xvsl85CHELEKiBspfrmTQ5v6t9XcaqxFDTrUomqQt3p9W5hYURym7R2m+4SWnJJpd/n5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmO0g5WW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907C7C19423;
	Wed, 11 Mar 2026 03:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773198763;
	bh=SDUWr51B+h5ikqvo7TzBEoMCm6C8OxHIRzg3bWcb7GQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QmO0g5WWQTdZhQYSc2d7BIBWhFKMOZjtRH4SeL5O1qETn7L5HsVtD/RlBRGpb+U/C
	 qNv0ZP2CKT8SEZGGhreTyzvz/iNG/DdIz/hcLD6B3J+3CrjrK85ku4S3Nv5C+Htkbz
	 /cM1SurMlNPKnL9qTxlxyelI1MdiNO2gJos0Nded+7dGrYq/E/N8c/qTj/FLwy9WJJ
	 xUcscguVuZdL80S+1N1dlC4sVAY3pegXu3TvkYSnQhscMhpo5HRTNgIQ9x+AT6xUQe
	 zOpEfKtCA2f9faZ+ZDx1p+INskCdAf5Bdk1jYLZCQHhYk1Kbba4obZpyspx+u2EQCC
	 +frKdXgxeRXKA==
Date: Tue, 10 Mar 2026 20:12:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, "Mark Bloch"
 <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe
 Shemesh <moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 1/5] net/mlx5e: Report hw_gso_packets and
 hw_gso_bytes netdev stats
Message-ID: <20260310201241.2f6e87c3@kernel.org>
In-Reply-To: <20260309095519.1854805-2-tariqt@nvidia.com>
References: <20260309095519.1854805-1-tariqt@nvidia.com>
	<20260309095519.1854805-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 36D5D25B4E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17928-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Action: no action

On Mon, 9 Mar 2026 11:55:15 +0200 Tariq Toukan wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> Report hardware GSO statistics via the netdev queue stats API by mapping
> the existing TSO counters to hw_gso_packets and hw_gso_bytes fields.

The docs on our stats are based on the virtio spec:
https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
which is not very detailed, but to me "bytes of TSO packets"
is a sum of skb->len of those packets. And mlx5 seems to only
be counting payloads??

Maybe given the ambiguity / mismatch report just the packet
count? IDK how useful the bytes are in real life anyway.

