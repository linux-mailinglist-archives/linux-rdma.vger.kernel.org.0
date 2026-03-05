Return-Path: <linux-rdma+bounces-17519-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HX4EvZcqWkL6AAAu9opvQ
	(envelope-from <linux-rdma+bounces-17519-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 11:37:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE26920FC89
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 11:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F325830B8483
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 10:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7B537F8C0;
	Thu,  5 Mar 2026 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLOEqXiu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA23273803;
	Thu,  5 Mar 2026 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772706889; cv=none; b=fTXpmO54TPvsFsm+2Fzp5ReMWMAdxaofXXYWjU9LuQAi72KYLasoUveK0cMrNLtFdDGOtJ+Fq0CUlcHlgSwK1drqzhyq8qRdFkVFq2RKgS3ptp65PJBU71ofi1jNdVrrXra2ovLwAi8b1rget8YNCsX2b0VBHZNv2B12WV6jJjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772706889; c=relaxed/simple;
	bh=PrGLRJ5mfNNhmh+NJl+x6JMsMMWRzC9mI8IsJAXNbkM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W8IOqAQeezCCJqtImd9ep175l3ujeuCdomjulctUFFLeP59wqgI6sOr3uwXAClFeR2A5YeE4Gcoqqr5XVyvJ7/DsDJZHkk5PB4lvDozFn/RwtvaWcPwdw1OamIowipB3cvoRqcr/g0AZePQAth3wubCuE0fNVusR2AyE6kquHDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLOEqXiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6178EC19422;
	Thu,  5 Mar 2026 10:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772706888;
	bh=PrGLRJ5mfNNhmh+NJl+x6JMsMMWRzC9mI8IsJAXNbkM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dLOEqXiuweGH2n9V989CMBERJtG8XhhCaLmkmzIBxc7PvTsE0e1LFAYm4g3q5kUmJ
	 y4ZW9GlQAuz+7oc/2R4FLhd5DK+eEPD3w4N60Sk0VSg12yHvxUMOIPk/JS6b1bX9W+
	 kjsDJORLjbMaO7i+mNQM7jnJV+5Xe+wQAGN1RL1ypdrx1gl79L7WvsD/HAYWs659lp
	 utNsfmmWSvoxwD/T/qMPUI9Xl/Z7bA/nm+vYH3Wp33cDsPYQsgJp1+g3y8bMMEN5BC
	 YjujF/ATiHTPtsgERQmm2YS+AFGVGPTobLEpbf14BxRrzVWzR3t21aW5HVKfDw9Vzv
	 ghiDbwbvkNMJA==
From: Leon Romanovsky <leon@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Maher Sanalla <msanalla@nvidia.com>
In-Reply-To: <20260225-var-tlp-v1-0-fe14a7ac7731@nvidia.com>
References: <20260225-var-tlp-v1-0-fe14a7ac7731@nvidia.com>
Subject: Re: (subset) [PATCH rdma-next 0/6] Add support for TLP emulation
Message-Id: <177270688603.1181551.11297261532942921320.b4-ty@kernel.org>
Date: Thu, 05 Mar 2026 05:34:46 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Queue-Id: DE26920FC89
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17519-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Wed, 25 Feb 2026 16:19:30 +0200, Leon Romanovsky wrote:
> This series adds support for Transaction Layer Packet (TLP) emulation
> response gateway regions, enabling userspace device emulation software
> to write TLP responses directly to lower layers without kernel driver
> involvement.
> 
> Currently, the mlx5 driver exposes VirtIO emulation access regions via
> the MLX5_IB_METHOD_VAR_OBJ_ALLOC ioctl. This series extends that
> ioctl to also support allocating TLP response gateway channels for
> PCI device emulation use cases.
> 
> [...]

Applied, thanks!

[1/6] net/mlx5: Add TLP emulation device capabilities
      (no commit info)
[2/6] net/mlx5: Expose TLP emulation capabilities
      (no commit info)

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


