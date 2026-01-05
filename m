Return-Path: <linux-rdma+bounces-15304-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2B8CF2416
	for <lists+linux-rdma@lfdr.de>; Mon, 05 Jan 2026 08:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E5A2301BEB7
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jan 2026 07:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F042356C9;
	Mon,  5 Jan 2026 07:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsOGgugr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC1C4A35;
	Mon,  5 Jan 2026 07:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767599199; cv=none; b=EZ9uy4ghh0xnz69NGbo8mJaNT9fusB80PrUilQ0oeJ66+J6UAJ2YeRN246t4yy7QYDi3VDlBcp6LhcXe7mUGBPWt5PQu3wrSTwWd/gyepe8ksJB7wi1SuJQmU9qaZCnknApfd5FhJoAXCgVy+fEPA6zQKsDfi7Y91GcKEGlVa54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767599199; c=relaxed/simple;
	bh=q+ApUgnXUM4IKI4EuqMpS5rCqxB4UyTLSVFwbzh6d9o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UHVd1A4d/Xf1cwuItCSG6IK6nE9OUYKgLBVw2ZWiYichqy5U9fHrzj45YFgynwk8pRzTyrVS9v5RDewZ4aYBAckeQJ+a6rl8nr3I3pZHoSPI9MBoN2qyPZz7j5TJNPEoNEA+gJPJrM2Z22ICJwtov2RSEwN4fEY0t5UoxzDYrSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsOGgugr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EC9C116D0;
	Mon,  5 Jan 2026 07:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767599199;
	bh=q+ApUgnXUM4IKI4EuqMpS5rCqxB4UyTLSVFwbzh6d9o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MsOGgugrJXYS8xhKqJONEtYwRyRa6TX8HfVSWezQTI7zFjbNGW3EviNGDCnW+PVnN
	 x5lDs8fiMoHSxv/b24LcmB2AwJ26pGFgH3Zam5NkUgsq5oI4NoiVApfsdiUYarbmQe
	 rOIfPq6Ej9fxYoJuZcOb0orEJzMwMqV/d518SPGfypBRpMFNXstO7W67X5dhBNiNCK
	 7qIL+Mn8qKM3mHWYqNqqbf0hfV0Zy42SvAgKr3PQ3dtZ6HczNKpZlKvHoWKsse1gi0
	 jYud13AP+5nCkaOewqV4HizYez2aawJ9PuYiLy2+hxSTZJx3bUdMSa58DQUY0OZmuq
	 YD1XQUc6u5enQ==
From: Leon Romanovsky <leon@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Edward Srouji <edwards@nvidia.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Or Har-Toov <ohartoov@nvidia.com>, 
 Maher Sanalla <msanalla@nvidia.com>
In-Reply-To: <20251218-vf-bw-lag-mode-v1-0-7d8ed4368bea@nvidia.com>
References: <20251218-vf-bw-lag-mode-v1-0-7d8ed4368bea@nvidia.com>
Subject: Re: (subset) [PATCH rdma-next 00/10] Support effective VF
 bandwidth query in LAG mode
Message-Id: <176759919623.1149539.16050199058638618062.b4-ty@kernel.org>
Date: Mon, 05 Jan 2026 02:46:36 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Thu, 18 Dec 2025 17:57:50 +0200, Edward Srouji wrote:
> Currently, mlx5 driver exposes only the parent function's speed to VFs,
> providing no way to query the actual effective bandwidth in LAG and
> MPESW configurations. This limitation prevents userspace and
> upper-layer software from obtaining accurate bandwidth information,
> which impacts traffic scheduling decisions.
> 
> This series addresses this by:
> 
> [...]

Applied, thanks!

[05/10] IB/core: Add async event on device speed change
        (no commit info)
[06/10] IB/core: Add helper to convert port attributes to data rate
        (no commit info)
[07/10] IB/core: Refactor rate_show to use ib_port_attr_to_rate()
        (no commit info)
[08/10] IB/core: Add query_port_speed verb
        (no commit info)
[09/10] RDMA/mlx5: Raise async event on device speed change
        (no commit info)
[10/10] RDMA/mlx5: Implement query_port_speed callback
        (no commit info)

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


