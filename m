Return-Path: <linux-rdma+bounces-8524-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E64CA58E86
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 09:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747483AB73E
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 08:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD21522423A;
	Mon, 10 Mar 2025 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrMMhx6I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91876221F13;
	Mon, 10 Mar 2025 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596457; cv=none; b=aFRxctyTD1yL3erqmai2EJauG92PBriljVWTs/0mZXekZjCs10cjbQYHHW2kBGzN/BEIavVoRGipgKOpdtEEOWWL05vwwSW7EAdvrvO5H2Q/IZSmVUSCIn5LvT7XRW86q3MLvWFLX0kCvq8mg8zXbOJVx2oLBTG1zauv4C6qhaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596457; c=relaxed/simple;
	bh=LbhKqE9ARKxh5Om8xA8bVJLhSQJDq+eo4FUOXoer76Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TgxV+ulNNIq5eF8ts++ZWvP+sOPtVODCFdXfGVakpZxtUUnmI+msPcWh+IOIlcmDhgecY/x1ZwHFjYscIL4P9ru5VQ74BLVQ8ujMysU8ld4P9u2F00JJ53gQR86Ql/+hWV6AoGN+X4vLYpsaOaKdcb+hiUncUUyRTrVTJkvOmjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrMMhx6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E7FC4CEE5;
	Mon, 10 Mar 2025 08:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741596457;
	bh=LbhKqE9ARKxh5Om8xA8bVJLhSQJDq+eo4FUOXoer76Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CrMMhx6IQoxI3nez2E7ZpKbWicXf/UbZ7Pk6EE63+zgZoOb4Ss9Eza95FjqbVoPJp
	 5mTk6/Yra6xbJK86/DP1KAQUHi+s98bZlJjniKw+0ZuxDJ9ko+DsY+Z3IE1ZVZlgLe
	 66W9vCxB3ylExfEPG5uIKS7cqGosmqqMPZkLu6Eb/bQItPBsYeAuQq2eB7u7+3iRK7
	 ehwPCAygY2+Rj4JdUAOqy398XkvTjDYvTbTtLj1tj+uiP7MTTLTtGNS0PDAbotplM8
	 5bLm+OJ0psm9TpGS2Sq+EQKGqubUJ+xYe6JpSUyHaftidePr8mV5OrjWubQ4AQzQ9C
	 +WhzWtYP0nPgg==
From: Leon Romanovsky <leon@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Cc: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Moshe Shemesh <moshe@nvidia.com>, linux-rdma@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Cosmin Ratiu <cratiu@nvidia.com>, 
 Yael Chemla <ychemla@nvidia.com>, Leon Romanovsky <leon@kernel.org>
In-Reply-To: <1741545697-23041-1-git-send-email-tariqt@nvidia.com>
References: <1741545697-23041-1-git-send-email-tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next] net/mlx5: Add IFC bits for PPCNT recovery
 counters group
Message-Id: <174159645340.444856.147815401586670383.b4-ty@kernel.org>
Date: Mon, 10 Mar 2025 04:47:33 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sun, 09 Mar 2025 20:41:37 +0200, Tariq Toukan wrote:
> Add recovery counters group layout of PPCNT (Ports Performance Counters
> Register). This group counts recovery events per link. Also add the
> corresponding bit in PCAM to indicate this group is supported.
> 
> 

Applied, thanks!

[1/1] net/mlx5: Add IFC bits for PPCNT recovery counters group
      https://git.kernel.org/rdma/rdma/c/f550694e88b7b1

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


