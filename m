Return-Path: <linux-rdma+bounces-1802-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD7F899F2B
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Apr 2024 16:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4B91F2408A
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Apr 2024 14:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907E616EBE7;
	Fri,  5 Apr 2024 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LH9j6B/h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F9D3EA90;
	Fri,  5 Apr 2024 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326420; cv=none; b=Y90hPm2IRSDDdvjovvngmkyeglueoVYzXa6kVUl8I/HC9s+ewdH0p9oc0FNSfkX53s5BqDzXp+70HROh3gPngt6WQHsg2GPaLzPgCen9mj6fBshLNRTGQGY7g0M9h3MDSqHsrNkbYSNIfXgXgify2DzgjzULgUkyUBWHQ67m7Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326420; c=relaxed/simple;
	bh=ooMaEWwdnVhQeVM7EbJA7zIvOpGClS4gtlhOc2kfOg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pNb/Tro/vNPfNn2m5sT8RhaZ3OXzZb85GEkFTWRCc9wi4448V58tTmRWv7hC49DWzo9ebNOL0qCA9n3uxIq7IjeTFKXFS6S+pUQuqjwFDTi5OGsDm0WFY0M6GHBG1dTl2blVZmq+WBjcenqjkbdKgb5E555QAd0qgfI7pdlArxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LH9j6B/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F900C433C7;
	Fri,  5 Apr 2024 14:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712326419;
	bh=ooMaEWwdnVhQeVM7EbJA7zIvOpGClS4gtlhOc2kfOg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LH9j6B/hpDuwhAOjnpFZUOApRmbDo/JqZiBsS9D56+vbewinHtVybCvPdhHEGN8F7
	 5JU4LPgAEHLgN6hH+QwOSscrhMCIcBvycOzOPnjF83CQ2ix6ItTUNroki50QeBlmrw
	 ndaSrF6ZIt/dVpelf4hMnCGvTZTcg7gRKy7wRSlIxL6tjoJQ89S2mCDZxQvwbKCvzR
	 TOKhHIeWkgboKlu/cLNj+auXKOuS+y8vzcG/ANi+rinpRViM2/yeVviRXZgILZ0kB1
	 RPSFTp8YN7D0JmCo2BjL7pr6VZ3bnvAK3Jgf2DOe09atoKv9OAeiXnwR0W/9Inpsl0
	 XHLybWONor6KA==
Date: Fri, 5 Apr 2024 07:13:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parav Pandit <parav@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "kalesh-anakkur.purayil@broadcom.com"
 <kalesh-anakkur.purayil@broadcom.com>, Saeed Mahameed <saeedm@nvidia.com>,
 "leon@kernel.org" <leon@kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>,
 Shay Drori <shayd@nvidia.com>, Dan Jurgens <danielj@nvidia.com>, Dima
 Chumak <dchumak@nvidia.com>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [net-next v3 1/2] devlink: Support setting max_io_eqs
Message-ID: <20240405071337.3b9ced49@kernel.org>
In-Reply-To: <PH0PR12MB5481D604B1BFE72B76D62D37DC032@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240403174133.37587-1-parav@nvidia.com>
	<20240403174133.37587-2-parav@nvidia.com>
	<20240404192107.667d0f8e@kernel.org>
	<PH0PR12MB5481D604B1BFE72B76D62D37DC032@PH0PR12MB5481.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Apr 2024 03:13:36 +0000 Parav Pandit wrote:
> Netdev qps (txq, rxq pair) channels created are typically upto num cpus by driver, provided it has enough IO event queues upto cpu count.
> 
> Rdma qps are far more than netdev qps as multiple process uses them and they are per user space process resource.
> Those applications use number of QPs based on number of cpus and number of event channels to deliver notifications to user space.

Some other drivers (e.g. intel) support multiple queues per core in
netdev. For mlx5 I think AF_XDP may be a good example (or used to be)
where there may be more than one queue?

So I think the question still stands even for netdev.
We should document whether number of EQs contains the number of Rx/Tx
queues.

> Driver uses the IRQs dynamically upto the PCI's limit based on supported IO event queues.

Right but one IRQ <> one EQ? Typically / always?
SFs "share" the IRQs with PF IIRC, do they share EQs?

> > The next patch says "maximum IO event queues which are typically used to
> > derive the maximum and default number of net device channels"
> > It may not be obvious to non-mlx5 experts, I think it needs to be better
> > documented.  
> I will expand the documentation in .../networking/devlink/devlink-port.rst.
> 
> I will add below change to the v4 that has David's comments also addressed.
> Is this ok for you?

Looks like a good start but I think a few more sentences describing
the relation to other resources would be good.

> --- a/Documentation/networking/devlink/devlink-port.rst
> +++ b/Documentation/networking/devlink/devlink-port.rst
> @@ -304,6 +304,11 @@ When user sets maximum number of IO event queues for a SF or
>  a VF, such function driver is limited to consume only enforced
>  number of IO event queues.
> 
> +IO event queues deliver events related to IO queues, including network
> +device transmit and receive queues (txq and rxq) and RDMA Queue Pairs (QPs).
> +For example, the number of netdevice channels and RDMA device completion
> +vectors are derived from the function's IO event queues.

