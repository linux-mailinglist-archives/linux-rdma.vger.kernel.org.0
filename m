Return-Path: <linux-rdma+bounces-13280-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51403B535C8
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 16:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6989DAA4736
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 14:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81A1340DA2;
	Thu, 11 Sep 2025 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaFkYOP4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8540D3376B3;
	Thu, 11 Sep 2025 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601392; cv=none; b=QqmmMULWST15FQ2bk+zHvs13OzWxkeaDK2ZwM5nUEv5hRa7XCS4rkAFb6iB1pexMxCjrJFODCPV5catQOWRE7F/CqxEa3DtoNES2SVECuKdUrIX1cSc2nVXl6EMnJ5125j4JGABL6ZMXQXhUO6K0uYOLMK8TBd19Ai2e3wCX4MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601392; c=relaxed/simple;
	bh=xmwE7Dd3BUl4FfFfkILXOnu6GtYmwpiyNr7Jy+EZ2oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCLxhWTRQylvemHlB9rxtDF5tEhYlnBLb73dOWpkj7NhNAdrYBuCxXkZX9x6br6O0IzSpAzION79BlRx2wuYdHc8e6WSGjm8qchFnxD704cv0QK0UiFs99eAwf0QwQib/xkGglkj9BfhOKA8JYTthQonbwJFadKs6EHEr/X/GP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaFkYOP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12B5C4CEF0;
	Thu, 11 Sep 2025 14:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757601392;
	bh=xmwE7Dd3BUl4FfFfkILXOnu6GtYmwpiyNr7Jy+EZ2oQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NaFkYOP4lP4otQm6RHM9IPoLQW55MnIzhxxRrdtHCErFJ7RT5CKT5pX+QCwsTW8iG
	 K/FQNLVPKBwte1CuNpMA3PF/vhHHDa5jnVE9v/bbmUBtn8k+TNY5dxue3QWQ+WL4n3
	 pLnXp99/4OBJ0XHsXKkhYstxoF/uGqlB772S9nRJ5/jn9GSp1vQwvnVvVv+kG05ceT
	 PMVoDlcdD8jx3pLoXG21JwDu7uXOkdzYY3hSaPGOKkBZu8ahDTA5lI74q7xAsmNF9X
	 KH/KuKzXfcsU6zRVAs/3eMcMrkEjelhO9jxXWkGan2tipU5bJ2XN5SpBHgiF0vfZrz
	 HEcAxG5NHCg8A==
Date: Thu, 11 Sep 2025 07:36:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Gal Pressman
 <gal@nvidia.com>, linux-rdma@vger.kernel.org, Alexei Lazar
 <alazar@nvidia.com>
Subject: Re: [PATCH net V2 10/11] net/mlx5e: Update and set Xon/Xoff upon
 port speed set
Message-ID: <20250911073630.14cd6764@kernel.org>
In-Reply-To: <fdd4a537-8fa3-42ae-bfab-80c0dc32a7c2@nvidia.com>
References: <20250825143435.598584-1-mbloch@nvidia.com>
	<20250825143435.598584-11-mbloch@nvidia.com>
	<20250910170011.70528106@kernel.org>
	<20250911064732.2234b9fb@kernel.org>
	<fdd4a537-8fa3-42ae-bfab-80c0dc32a7c2@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 17:25:22 +0300 Mark Bloch wrote:
> On 11/09/2025 16:47, Jakub Kicinski wrote:
> > On Wed, 10 Sep 2025 17:00:11 -0700 Jakub Kicinski wrote:  
> >> Hi, this is breaking dual host CX7 w/ 28.45.1300 (but I think most
> >> older FW versions, too). Looks like the host is not receiving any
> >> mcast (ping within a subnet doesn't work because the host receives
> >> no ndisc), and most traffic slows down to a trickle.
> >> Lost of rx_prio0_buf_discard increments.
> >>
> >> Please TAL ASAP, this change went to LTS last week.  
> > 
> > Any news on this? I heard that it also breaks DCB/QoS configuration
> > on 6.12.45 LTS.  
> 
> We are looking into this, once we have anything I'll update.
> Just to make sure, reverting this is one commit solves the
> issue you are seeing?

It did for me, but Daniel (who is working on the PSP series)
mentioned that he had reverted all three to get net-next working:

  net/mlx5e: Set local Xoff after FW update
  net/mlx5e: Update and set Xon/Xoff upon port speed set
  net/mlx5e: Update and set Xon/Xoff upon MTU set

