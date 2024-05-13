Return-Path: <linux-rdma+bounces-2457-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E1C8C43A1
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 16:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1105F286622
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11EC1EB3A;
	Mon, 13 May 2024 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9UAtgI9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCF74C79;
	Mon, 13 May 2024 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612309; cv=none; b=Atoutrj4ClPVa5ts2pLSqpvbxdFmfzWxspPJ6FFPozZGYVAFLtygL0w9ed7wfz+CuXScJr1V6MDFft7lJwSSX78jQfYgpPZ6Mi7GGhKyiGUXb+hgu0wZMYA2Ildx3cvgBmGGjcyFdxoqCKMP9RCuYgG/XNbrVuKYeT6yKGGvTyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612309; c=relaxed/simple;
	bh=V/P5iT8isuf0xGi5C2QCfFIakRJ0d6VOy5DAlXaa1sY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PYVyoIncHsDA32KL7szBGFG6DwxZqq2nOldAFGq22yUN7PlLzuXOO1qQy/vHJlFY5YHEwiWv0DvYruo5fXnSXOB3ryvgRcpX/zB8EHr+6c0Shql7WVqY/1/FMyxgnyXS3DC/rhVEpZV8vjKUgCm4av82du8rR0/+maNjqO8Mj/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9UAtgI9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E31C32781;
	Mon, 13 May 2024 14:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715612309;
	bh=V/P5iT8isuf0xGi5C2QCfFIakRJ0d6VOy5DAlXaa1sY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z9UAtgI9+HkAomVzZPyNk+oLAfVVOefour6250hJVttD9mzKmEGaW5b35KOZAhUV+
	 BElvXm6xcRzcOBGdla1CQIpqzGv+S/t6F/DlT1C8TJzW5WFyfjDqX63vxkAYnCGKFB
	 ghri6LVFiE7jZfrCjzNlieg+ky0EfRN+XxUcCnHPM6Jh6mSZOLKg+4otAWS/8LdUnC
	 mFsMGuDzhraYefcTGInIdk7uaPOPxSEILeG6YWp1V1JxYhC0PmhSwsqcDjH9bf0Tum
	 bq/YOtSih0xYjZGfEHlMRC7s73O/dd1nxljc6U5BcLGheNoGaW+a0sRWDLt7mgOAaW
	 XQlaglOPLjqAg==
Date: Mon, 13 May 2024 07:58:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, zyjzyj2000@gmail.com, nalramli@fastly.com, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver)
Subject: Re: [PATCH net-next v2 1/1] net/mlx5e: Add per queue netdev-genl
 stats
Message-ID: <20240513075827.66d42cc1@kernel.org>
In-Reply-To: <20240510041705.96453-2-jdamato@fastly.com>
References: <20240510041705.96453-1-jdamato@fastly.com>
	<20240510041705.96453-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 04:17:04 +0000 Joe Damato wrote:
> Add functions to support the netdev-genl per queue stats API.
> 
> ./cli.py --spec netlink/specs/netdev.yaml \
> --dump qstats-get --json '{"scope": "queue"}'
> 
> ...snip
> 
>  {'ifindex': 7,
>   'queue-id': 62,
>   'queue-type': 'rx',
>   'rx-alloc-fail': 0,
>   'rx-bytes': 105965251,
>   'rx-packets': 179790},
>  {'ifindex': 7,
>   'queue-id': 0,
>   'queue-type': 'tx',
>   'tx-bytes': 9402665,
>   'tx-packets': 17551},
> 
> ...snip
> 
> Also tested with the script tools/testing/selftests/drivers/net/stats.py
> in several scenarios to ensure stats tallying was correct:
> 
> - on boot (default queue counts)
> - adjusting queue count up or down (ethtool -L eth0 combined ...)
> - adding mqprio TCs
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Tariq, could you take a look? Is it good enough to make 6.10? 
Would be great to have it..

