Return-Path: <linux-rdma+bounces-18785-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFKpJ3BuymnG8gUAu9opvQ
	(envelope-from <linux-rdma+bounces-18785-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 14:37:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB00535B1F7
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 14:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D59F30467F7
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 12:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B0D3CFF6E;
	Mon, 30 Mar 2026 12:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnIFx0gD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0083C552D;
	Mon, 30 Mar 2026 12:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873970; cv=none; b=oY2AL5MZALaFtxpizri93cqjoYsIOS3QNiHsYBdNi3Td+2HTQQ0qI5EkaeJispJQJSYufQI/eEtBXon8u8ikCgOPsLYxyG2BHv7vQ4Tjv1o9411GlK655sJpxhDerIO7mydgSDLSiPxFjC4r4QFwo8uCpIVp5zWDc0Ha5ySp9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873970; c=relaxed/simple;
	bh=x768oepB+eu62Vi9T/UriFrLat3EfNqHLyitLAzJK3Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kZ80ncN9XOKURbGA0WmtfA4EyNRjMgQy2sfiUargcIw8fjMWlT+ZQyG4cRUSdwULVkrWIzuGK5VCUhfGgZG35rSwZPV0Z0y7iRzjtWuytVhnM+jF3yj0yPf7pzPj47zhLvix2w5jpvDIVZ5t4KzuzYvq/oc6DVB7Wyd4UD6qsgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnIFx0gD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7502CC4CEF7;
	Mon, 30 Mar 2026 12:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774873970;
	bh=x768oepB+eu62Vi9T/UriFrLat3EfNqHLyitLAzJK3Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LnIFx0gDkJ8FW8wcZovX7Wrj9KIp0FHKAVomkTbOGrLIbZvUbz1d6Gpx5vPy8oIx1
	 jwqCh+yeVBQeuNwSRbubx1O+Tww9othoXm5UqG8eNTGTtGwNv/njUOQHdlms9LIwVh
	 uC3xyPnektKL8vz873/JDD9ehVyUiGFwjd8hLMGri2Tl+XLTCE0EuRPVsgN2lAMdSN
	 EDxaVA8CBZ80JGkQOg/VQyrjqMRR7ENBA6gbc5sjpToddRdayCnFlzudehvcl8QqMz
	 4a38qttgIbEYkt5misJi57yfV7T6L/SNQ10urFK+MrxTm66ktDWxc92HxLjcdD40DA
	 tJNMnAPBGb2DQ==
From: Leon Romanovsky <leon@kernel.org>
To: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiri Pirko <jiri@resnulli.us>, Jiri Pirko <jiri@resnulli.us>
In-Reply-To: <20260325-fix-mlx4-external-umem-v1-1-1c7c0e779329@nvidia.com>
References: <20260325-fix-mlx4-external-umem-v1-1-1c7c0e779329@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx4: Restrict external umem for CQ
 when copy_to_user() is used
Message-Id: <177487396689.3810252.14139340352108174634.b4-ty@kernel.org>
Date: Mon, 30 Mar 2026 08:32:46 -0400
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
	TAGGED_FROM(0.00)[bounces-18785-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB00535B1F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, 25 Mar 2026 20:16:03 +0200, Leon Romanovsky wrote:
> When the mlx4 firmware reports the MLX4_DEV_CAP_FLAG2_SW_CQ_INIT capability,
> libmlx4 from the rdma-core package expects the driver to initialize memory
> at the address provided in the buf_addr parameter of ucmd.
> 
> This behavior cannot be supported by any external umem implementation, so
> restrict it accordingly.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx4: Restrict external umem for CQ when copy_to_user() is used
      https://git.kernel.org/rdma/rdma/c/1c47f6aa0a13d1

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


