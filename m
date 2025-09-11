Return-Path: <linux-rdma+bounces-13277-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF74B53441
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 15:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA394188D43A
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 13:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24CB324B32;
	Thu, 11 Sep 2025 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYsPrYqH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6F97261A;
	Thu, 11 Sep 2025 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598459; cv=none; b=HV+uQsZgIERopCRkYOl8BPJFeFqtCX1YydUX/v47H1MngImyq2qgW0TAgjrsWsF26Gn48C0fc6wztNJS/Kiz8t1kN0yAlcwHGujk5BgvFBbKzzjn1GRfb3twEO/th65OS8SjHoTjlwB/lpitEeYaJE8jAonzvRMGwx4p3RHzTgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598459; c=relaxed/simple;
	bh=GyN4TZqUGP7GmM7frRvFOeCqKuKOWiXsTn/1gHowWKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z13Nz8X+V9QfWuyXC6RytJfa38WXsMVOMmV/J1cHzNdz7rpK/lwY+qIMiKr+ax+Iq7YBjhgz+TyyGJ/DL+S9nbGIidnq3n0tc14kU6XLl1dBZy2hcT2iDUQiNnbqkTHIGKptXvhYR1b9YUoJ7+kL0hQsDmh971l/oLE+cg4xl1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYsPrYqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAF5C4CEF0;
	Thu, 11 Sep 2025 13:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757598458;
	bh=GyN4TZqUGP7GmM7frRvFOeCqKuKOWiXsTn/1gHowWKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZYsPrYqHwmsbmX3q3vNT1TJHeHM14ewRbwNcn8r47QqgY869N6wyxKebf92CpfRVF
	 t6MRyZrUOD/YBE4+LmPn/ur4jfS84bTK78TV3xRnvi2DAYACS6xnyam6byVe3P+rgR
	 VvX8WX4uGt0cWh7gdMGjCRnkQ+bnjWM12FRuUNONgQ8MRgH4eLCz6pvRp9wCzCTENj
	 NXIFfP1V0wCqItdI6+LvLKkIyTpoccjSL5leaCEMwrFLg8+Qk+/CGeO6+MfaoSq6Sr
	 Vz9b/BO74auehkJ1qGYQlDSMSQmqSoM3I1fJph5bzZ4LQUWdTvgVeyv2JH6fM38Qrt
	 88pdPAEijT/BA==
Date: Thu, 11 Sep 2025 06:47:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, "Saeed Mahameed" <saeedm@nvidia.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
 <gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Alexei Lazar
 <alazar@nvidia.com>
Subject: Re: [PATCH net V2 10/11] net/mlx5e: Update and set Xon/Xoff upon
 port speed set
Message-ID: <20250911064732.2234b9fb@kernel.org>
In-Reply-To: <20250910170011.70528106@kernel.org>
References: <20250825143435.598584-1-mbloch@nvidia.com>
	<20250825143435.598584-11-mbloch@nvidia.com>
	<20250910170011.70528106@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 17:00:11 -0700 Jakub Kicinski wrote:
> On Mon, 25 Aug 2025 17:34:33 +0300 Mark Bloch wrote:
> > Xon/Xoff sizes are derived from calculations that include
> > the port speed.
> > These settings need to be updated and applied whenever the
> > port speed is changed.
> > The port speed is typically set after the physical link goes down
> > and is negotiated as part of the link-up process between the two
> > connected interfaces.
> > Xon/Xoff parameters being updated at the point where the new
> > negotiated speed is established.  
> 
> Hi, this is breaking dual host CX7 w/ 28.45.1300 (but I think most
> older FW versions, too). Looks like the host is not receiving any
> mcast (ping within a subnet doesn't work because the host receives
> no ndisc), and most traffic slows down to a trickle.
> Lost of rx_prio0_buf_discard increments.
> 
> Please TAL ASAP, this change went to LTS last week.

Any news on this? I heard that it also breaks DCB/QoS configuration
on 6.12.45 LTS.

