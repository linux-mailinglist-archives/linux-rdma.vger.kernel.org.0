Return-Path: <linux-rdma+bounces-18501-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH4gDMk3wGnxEwQAu9opvQ
	(envelope-from <linux-rdma+bounces-18501-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Mar 2026 19:41:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E012EA579
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Mar 2026 19:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B33B300D32C
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Mar 2026 18:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6EF36E465;
	Sun, 22 Mar 2026 18:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUd3Ij5o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD6C346E6D;
	Sun, 22 Mar 2026 18:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774204865; cv=none; b=ErYq82asxmDA57h74ow0nM2F6LFw1XpjNTwMsnaTIc5Pub71NNxie9fYPsWH3sMvwHbutcLiViUXvDZbO5skNjU0uVQlMBkmE6/az+cO4lL36npBLDg/aozoMncbMz0QG4F4EqbefZ2wco/d9ZNdf8Bb9PSFc7TiwX49Qe4cDR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774204865; c=relaxed/simple;
	bh=9aVIR9Q3GFsJbREmDHykk78zavC2kgRPGm4fnPSwQfM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ulZHupxGXQuDhN+ulzsU5/XV8OisVEaTkM6luQzNmpowqQ1j16+WkxmFSrlUxowz5QK3vDAcEXhA+e89jZh+EQywEGhPU7Ry2t6wzFNA33uNhGevt76V9ZS9ovgn80v6PWenNQDRuvRFpTl4jjD17TyXd66toStXFMq1mukTp74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUd3Ij5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E59C19424;
	Sun, 22 Mar 2026 18:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774204865;
	bh=9aVIR9Q3GFsJbREmDHykk78zavC2kgRPGm4fnPSwQfM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kUd3Ij5oEfXgGguu5Qpx7Ygz9l+n7Dd6vj3+OPJ//w1nNrpplLIbt/Wts9l6DryPh
	 I3d12pgxdMu9NBDHqu37vlPdXs7hm3p2oga4pIzYgkWWCQxCVVPi4u+SeN1H6pcNtn
	 D+nWilIG+WTQEhiFy93J3uaP23c2lHRm+h2+KWlv5se1TKFK8kNp+fT8B1+gYkxkyN
	 mhIcLRFynsDmthdVdK0n/PAhBAw2rn2nab8vBpbK6y+H78W8sH0co4fKWYS1/iYa+Y
	 TbnL3ZWkA5tXKKhw0DoxeS9XpTjIFy7tNHroL80JxgLYWDyEZzA/ZQNMZyVpv9pqTv
	 qjnF0N9+7qasA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>, 
 Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>, Simon Horman <horms@kernel.org>, 
 Shay Drori <shayd@nvidia.com>, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Moshe Shemesh <moshe@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
In-Reply-To: <20260319122211.27384-1-tariqt@nvidia.com>
References: <20260319122211.27384-1-tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next 0/2] mlx5-next updates 2026-03-19
Message-Id: <177420486191.2044775.9250138333807571163.b4-ty@kernel.org>
Date: Sun, 22 Mar 2026 14:41:01 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18501-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 76E012EA579
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, 19 Mar 2026 14:22:09 +0200, Tariq Toukan wrote:
> This series contains mlx5 shared cleanups and updates.
> 
> Regards,
> Tariq
> 
> Parav Pandit (1):
>   mlx5: Remove redundant iseg base
> 
> [...]

Applied, thanks!

[1/2] mlx5: Remove redundant iseg base
      https://git.kernel.org/rdma/rdma/c/c0368933dd3d4a
[2/2] net/mlx5: Add vhca_id_type bit to alias context
      https://git.kernel.org/rdma/rdma/c/26469110c750c8

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


