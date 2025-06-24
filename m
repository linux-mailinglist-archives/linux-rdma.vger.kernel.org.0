Return-Path: <linux-rdma+bounces-11597-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E46AE6EB4
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 20:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67F63B6D7F
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 18:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83C92E62C7;
	Tue, 24 Jun 2025 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kv5PRwb7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E16E4C74;
	Tue, 24 Jun 2025 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750790235; cv=none; b=kuvWjyOnLkW2JpiqxL8uNNUsv+9uUfd5Eu0rG2uuil8Bkv0nyReJBlucO4cybhBgBOF3wuDr6NBTti2ID72CHC00RZ/ndpH3+9RBbrlbem16RqWmNdbyo72RXM+KOUtom3U/PHFKICQkIo7FTO/O6JOcRf1PjJNOZSXh2VCEFW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750790235; c=relaxed/simple;
	bh=EnBZ2b/YUldxRheRPlo+ak77Z0UBbQRp25tN9IbfL/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sdbp5Fro0amtxfY1aJdaDegfs5OuV++lCMvyMaEWiWwkc9KC4tY5YUhrLet1xQIYK8ZzYYn6s+8BORlig5ppn1y0zlj9dLopgZAKWZeoW+J7lVEGT5vMBrjEiRSyZ5BdntvNffUJamzOapyRzCPSBQJsn7c0p++UMndtzmXCPoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kv5PRwb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48276C4CEEF;
	Tue, 24 Jun 2025 18:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750790235;
	bh=EnBZ2b/YUldxRheRPlo+ak77Z0UBbQRp25tN9IbfL/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kv5PRwb77k7GGvw2iYbUYdxeWVEFR2bCGdtyHvU3a9aDp3kB680QZ+FlMTttp3GMO
	 4vJj+X4dFzAGEvEgwk5Ga83GgDzYzDLGo5Q/ncZG4hTw0d//iEwlZy3dQRFt8v+XgR
	 y8fdmtLDTeAUmbA6h7y+6Z/kp3+9KgTBf3MLaZ6dtqdlaoE1ypGykAEa5ShlG/PmXS
	 eTc07RKV0EFLXIiY6UoXdrnJDG2Pp/enHPRlaeZdUQ1Jobiill4XEIemIHBZpRtwUq
	 uyETroJOcGw65YuwfqQth0MXRmpdqfav/GFfgE6GgJXuLUdvhKKWzeVsTrosZ0tSKN
	 WQ9r636vB+0rQ==
Date: Tue, 24 Jun 2025 19:37:10 +0100
From: Simon Horman <horms@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com,
	gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	moshe@nvidia.com, Vlad Dogaru <vdogaru@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [PATCH net-next v2 1/8] net/mlx5: HWS, remove unused
 create_dest_array parameter
Message-ID: <20250624183710.GD1562@horms.kernel.org>
References: <20250622172226.4174-1-mbloch@nvidia.com>
 <20250622172226.4174-2-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622172226.4174-2-mbloch@nvidia.com>

On Sun, Jun 22, 2025 at 08:22:19PM +0300, Mark Bloch wrote:
> From: Vlad Dogaru <vdogaru@nvidia.com>
> 
> `flow_source` is not used anywhere in mlx5hws_action_create_dest_array.
> 
> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


