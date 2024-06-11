Return-Path: <linux-rdma+bounces-3045-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FED902DA0
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 02:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791741C21A5E
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 00:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0066116;
	Tue, 11 Jun 2024 00:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv6VGs9p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972EE3FB2C;
	Tue, 11 Jun 2024 00:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718065336; cv=none; b=UjzUzG8+6C2EeojFlY8njiEzsn+iSexCGxQvx6R8n4tTp1kUm2vrO8+36Hj86Ct/H0rlzEItWQC+q+YYWRl6ptwNgiu5to0O7Wb2WZu1ZG1IlBTZL13nvq/XqGnidiL4O+fKpzgY6DqxOMJMlAde4z2lxHc8MKWLH5LW0CPSc9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718065336; c=relaxed/simple;
	bh=yi8s0s8TC1pEMrWdl8G3ODuepnLCbim5xwOYcuofqX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kG02xApTqwPjpTyjry0eB0PxkJeuCZIUjzs12eAq5Hl9GabcWQLtfJIvKeXzbZGb/Qn4HqgjIHkW06Nc9pPQCVkTgrNz0KJGLEQ4VI7Uz6r4RG/w/XJb0YlFuBKyog+OGtmHVba0+3lRNoQdQ7/KMTBbxJRQNLlhe8c9dzX3xHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv6VGs9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E219C32786;
	Tue, 11 Jun 2024 00:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718065336;
	bh=yi8s0s8TC1pEMrWdl8G3ODuepnLCbim5xwOYcuofqX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fv6VGs9pxE9zt7PVu9lU7P5ZFYa7tZWD9PSOCR4+pGEv5FnQdwNMy7UVDtS04ouMM
	 9K1URjtiG8BFHfY0vk3RwIkulpr6NIqlb7iELVXhA384WS8mW8HnC22xALr3EcVWvC
	 Mn2zBS5ezhQecfvJyDcTU09sJn0JanHvtnm2mtg87PRnyPO9Q3xBSexaHZk9szjn21
	 UM7ZaJE9PpvwFRF2y0s4rgYmH5vqGJCBb1SJTMiHN1bT92oI6r4bctYE7qa4+r/wyr
	 DKLchRjvyyZIkkEIu+sEnYOGJasxtZBzNki0FPfmtiCViZj5PmnuL6joHXQwccBcJM
	 61rfM6IsA45Gg==
Date: Mon, 10 Jun 2024 17:22:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nalramli@fastly.com, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "open
 list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>
Subject: Re: [RFC net-next v4 2/2] net/mlx5e: Add per queue netdev-genl
 stats
Message-ID: <20240610172214.17fc8d95@kernel.org>
In-Reply-To: <fd788395-c936-49cf-a85d-d39d1d055131@gmail.com>
References: <20240604004629.299699-1-jdamato@fastly.com>
	<20240604004629.299699-3-jdamato@fastly.com>
	<11b9c844-a56e-427f-aab3-3e223d41b165@gmail.com>
	<ZmIwIJ9rxllqQT18@LQ3V64L9R2>
	<20240606171942.4226a854@kernel.org>
	<ZmJcEM7brxivyDUV@LQ3V64L9R2>
	<fd788395-c936-49cf-a85d-d39d1d055131@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Jun 2024 10:53:55 +0300 Tariq Toukan wrote:
> I don't want to create more work for you, but IMO in the longterm I 
> should follow it up with a patch that adds PTP-RX to real_num_rx_queues.

Please don't. real_num_*x_queues is basically uAPI. Let's not modify
behavior at the uAPI level to work around deficiencies of the device.

