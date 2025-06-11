Return-Path: <linux-rdma+bounces-11194-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C23AD56EA
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 15:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E5717DF63
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 13:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEE128A3FA;
	Wed, 11 Jun 2025 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOhBjSs/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D331E485;
	Wed, 11 Jun 2025 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648387; cv=none; b=eftChIqkCYuWl2cAbXR9A+mkE5D/OY7rL6ic6H78rhYFUoqDl8d1MfZqM5/IQVDWy0m3movPpWRf5TWBRFNW2qvV2kcmyLlCO1zAGm7H0r9bJj8dWmEHgs/ToOhmbRtj8qnO1WlrZM8m/vnrE4bLc/K+V45xX4JvQPJsl57F7lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648387; c=relaxed/simple;
	bh=ZonKMq3fpA10TBa+LA12TyNyEizTL7bynRwgCcXEexs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AuNqjwm78NnoMTQRCRUFwMoiSqfq2jHUe3n4FJW5pQQR/wxD+LYqMcMZ8jY54Hc/LWbNWb7OGKGvMQroB9082KtvLEltMcqjXSngfc8M28O1tLkZ5B/WJW/HOOfXSFj1Sey2Thiq1lQzej78JOslgIE0aF7XO3+Abseoav/WJhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOhBjSs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39991C4CEEE;
	Wed, 11 Jun 2025 13:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749648386;
	bh=ZonKMq3fpA10TBa+LA12TyNyEizTL7bynRwgCcXEexs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GOhBjSs/Ayuu/3wgQgj0eko+lxHeDB1rRdh55YpmFmNi8D03M/JF79gbjTDpImtnJ
	 uiqZo+Bh9NF0PQJbJsqExCWCDuejAoYKtETW1AaTqQ6ImCsyDp6Dp9l//IwbqdcKYy
	 LvHs1h+OpPD9hGabB5LLNSBUxWG6htoRQ0us0ALck4bnjd6+++MVuTboz/oSrlKTY3
	 4uZj7iJHJo2GQDSnA2MQb0y0MukLsMTLm7Ve/i1Dzq5XCSTGevaFURT9lnJQMQy8Us
	 ucIa18I7RCNU/8DViLgxHIbIZthO9jqqRZdeV4BHV+ovLaTjQEOOe9wvRRuf9uJ4cO
	 d8BZLpYI8eQoA==
Date: Wed, 11 Jun 2025 06:26:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, <saeedm@nvidia.com>, <gal@nvidia.com>,
 <leonro@nvidia.com>, <tariqt@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next v4 10/11] net/mlx5e: Support ethtool
 tcp-data-split settings
Message-ID: <20250611062625.758e7df1@kernel.org>
In-Reply-To: <20250610150950.1094376-11-mbloch@nvidia.com>
References: <20250610150950.1094376-1-mbloch@nvidia.com>
	<20250610150950.1094376-11-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 18:09:49 +0300 Mark Bloch wrote:
> +		NL_SET_ERR_MSG(extack,
> +			       "TCP-data-split is not supported when GRO HW is disabled\n");

unnecessary trailing new line, you probably want to use
NL_SET_ERR_MSG_MOD(), too
-- 
pw-bot: cr

