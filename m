Return-Path: <linux-rdma+bounces-18220-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KHvAsdmuGlOdQEAu9opvQ
	(envelope-from <linux-rdma+bounces-18220-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 21:23:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC732A0288
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 21:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A900F30338BC
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 20:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3D33EE1E5;
	Mon, 16 Mar 2026 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4MyFKMl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3AA3EE1CF;
	Mon, 16 Mar 2026 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692611; cv=none; b=AA6MA0N/K5o6wZVCPj4RUzitTqYLNevaZTvwxlGDgTLxlD7Rt0jG6aG369T8wMvIKJoFIUFCxtIxoZZlPcYkdgW2bx/SGfyHi3trf8QurWrLzrxF9pqV4GTUelXfcHCkxlAgkDDwSyyNaT31h5Eohkv66STfppSW+eecBXVdI+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692611; c=relaxed/simple;
	bh=RkcuQuj6xlsGmyH1PUh9mZRiLaMUCyE/uRPr7hWWXEE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uTimZojr9U3YFFMXDWbUCBBviyvUNvJXseCNp+1FHDhItW67UHU7UzoL46QZDGt4lBPqZfPtUgWx2H1KK+WMmUgGCG2KDhP6pLKnjo/1y39IDIb2Y7tlFMt1g5Hne14s3P2r2co6bFS0itHkUoandFu9Aeo/zYQ4rcXf7eiTw5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4MyFKMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5010CC19421;
	Mon, 16 Mar 2026 20:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773692610;
	bh=RkcuQuj6xlsGmyH1PUh9mZRiLaMUCyE/uRPr7hWWXEE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=n4MyFKMl61aR0o41Ses6X2MnWOVcSb/euKsp+Fvf20MTpfoU6zqHueM8/qmJzg6Uj
	 K2htm6YNwWhwPEPC/rNpDDpCS80OHGKvuvq7Uw/NyfvcBFSQ1IjrxEAfZFC+igBpxT
	 SzRajssCwD9cyNAZ3Jqn75BLhQgL810YT2Wc0cXDiyRRUQFOHIx4YtSqQGvn3TBrrW
	 gLoOolDwRF5DNHjMPu3UBrH6Fb7OWshSt5Mp6efVN7sryRQ5Z0wcLggFIeoK7PGjRn
	 xQzAa/ags0/KqTOkj18VXpcmbh3iwSS587vYBdt+mCcA1NepGljd2LkQlqix1WR8Co
	 LNQmiCS4GxciA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>, 
 Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, 
 Shay Drory <shayd@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
In-Reply-To: <20260309093435.1850724-1-tariqt@nvidia.com>
References: <20260309093435.1850724-1-tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next V2 0/9] mlx5-next updates 2026-03-09
Message-Id: <177369260810.226580.14093836432311631798.b4-ty@kernel.org>
Date: Mon, 16 Mar 2026 16:23:28 -0400
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18220-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6DC732A0288
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, 09 Mar 2026 11:34:26 +0200, Tariq Toukan wrote:
> This series contains mlx5 shared updates as preparation for upcoming
> features.
> 
> First patch by Alex contains IFC changes as preparation for an upcoming
> feature.
> Last patch does definition movement to expose a HW constant so it could
> be used later also by core and Eth drivers.
> 
> [...]

Applied, thanks!

[1/9] net/mlx5: Add IFC bits for shared headroom pool PBMC support
      https://git.kernel.org/rdma/rdma/c/f8e761655997cc
[2/9] net/mlx5: Add silent mode set/query and VHCA RX IFC bits
      https://git.kernel.org/rdma/rdma/c/691dffc7255e74
[3/9] net/mlx5: LAG, replace pf array with xarray
      https://git.kernel.org/rdma/rdma/c/91e9f3e7b62657
[4/9] net/mlx5: LAG, use xa_alloc to manage LAG device indices
      https://git.kernel.org/rdma/rdma/c/2b204cdb12068c
[5/9] net/mlx5: E-switch, modify peer miss rule index to vhca_id
      https://git.kernel.org/rdma/rdma/c/da0349d0ffc7b8
[6/9] net/mlx5: LAG, replace mlx5_get_dev_index with LAG sequence number
      https://git.kernel.org/rdma/rdma/c/971b28accc0943
[7/9] net/mlx5: Add VHCA RX flow destination support for FW steering
      https://git.kernel.org/rdma/rdma/c/0bc9059fab6365
[8/9] {net/RDMA}/mlx5: Add LAG demux table API and vport demux rules
      https://git.kernel.org/rdma/rdma/c/d6c9b4de8109a3
[9/9] net/mlx5: Expose MLX5_UMR_ALIGN definition
      https://git.kernel.org/rdma/rdma/c/4dd2115f43594d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


