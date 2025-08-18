Return-Path: <linux-rdma+bounces-12811-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EDBB2AD3B
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Aug 2025 17:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2E5188777A
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Aug 2025 15:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E00931813A;
	Mon, 18 Aug 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuE8IpLI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20611283FC3;
	Mon, 18 Aug 2025 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531955; cv=none; b=ue7XLE0Z94HJDPsv73TRW3gXAj6INDntumVn+5l3fjH8PsPckYzNzohdK8PMfNDZLNMFrbiHyGe0C5M8kQU85PQ7/Q/jEKnkbizcUTEao8jojLIw6J64o3RLxzE5xHeZuPMjbB5EJK7DO/KU+S39IxD9JnDoJpFlczNk3XlwFww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531955; c=relaxed/simple;
	bh=hnsi28Tz7v23mH68o8SpW2Z9qHvy5g1uLMZ8O8gitfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBhkt/y4u23D4mw+g+H/MXhKKqtciHHsk8zpNeoqeeUVkj0ruCvAiFJQfiG3iObimmPErkLqMQliqYF+NV8rqpA+jHE6N/uKVVx06srI/VOpdJIj/xqONjEzKbmyid/CT4O9vEWdb9Q/6VOssmW/85cEK7/9R0fwFqAW5VeLnBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuE8IpLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCEBC4CEEB;
	Mon, 18 Aug 2025 15:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755531954;
	bh=hnsi28Tz7v23mH68o8SpW2Z9qHvy5g1uLMZ8O8gitfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PuE8IpLIWWrlrb6jSAu+ChECzZUvehsysHKUgVTeOmEySKpy9v51Vvyz8PyCPdpp2
	 3SVgvtIfmh5UZckZ7ySMcg0pZ+IKQx+KMr+Ld00EhS2tEEs2dMT4ISyg3IqVFxCqRI
	 9s6APYhjaxQiwDz0NbIpjt6L07CkuVPGiVfcqiZ/GHXKLIPI3faUKqdyrVnfpt2zVf
	 C8XUD0G2XKH/0sSSeZzoknRojICeeGLafizkciiQ6wGSVZIg5vvVw+XAz+qLqmJCfh
	 zcsDePU6e2R9Bd81AAFaeFfN3mKdqwd9jum/0mnfktZhOMO5lF37euZNGNVSD7lLm0
	 Ari8ZvaAgjjww==
Date: Mon, 18 Aug 2025 08:45:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jiri
 Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, Brett Creeley <brett.creeley@amd.com>, Michael
 Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Cai Huoqing <cai.huoqing@linux.dev>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Sunil Goutham <sgoutham@marvell.com>, Linu
 Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Ido Schimmel
 <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Manish Chopra
 <manishc@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org, Gal Pressman
 <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V3 4/5] devlink: Make health reporter error
 burst period configurable
Message-ID: <20250818084552.1d182f31@kernel.org>
In-Reply-To: <016a3fed-2f4b-4721-b92c-cf00cd5f3125@nvidia.com>
References: <1755111349-416632-1-git-send-email-tariqt@nvidia.com>
	<1755111349-416632-5-git-send-email-tariqt@nvidia.com>
	<20250815122627.77877d21@kernel.org>
	<016a3fed-2f4b-4721-b92c-cf00cd5f3125@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Aug 2025 19:08:47 +0300 Shahar Shitrit wrote:
> On 15/08/2025 22:26, Jakub Kicinski wrote:
> > On Wed, 13 Aug 2025 21:55:48 +0300 Tariq Toukan wrote:  
> >> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> >> index bb87111d5e16..0e81640dd3b2 100644
> >> --- a/Documentation/netlink/specs/devlink.yaml
> >> +++ b/Documentation/netlink/specs/devlink.yaml
> >> @@ -853,6 +853,9 @@ attribute-sets:
> >>          type: nest
> >>          multi-attr: true
> >>          nested-attributes: dl-rate-tc-bws
> >> +      -
> >> +        name: health-reporter-error-burst-period  
> > 
> > the "graceful-period" does not have the word "error"
> > in it. Why is it necessary to include it in this parameter?
> > What else would be bursting in an error reporter if not errors?  
> 
> I see. Would you suggest renaming it to "burst period" through the
> entire series?
> for example in devlink.h:
> default_error_burst_period --> default_burst_period

Yes, AFAICT it won't result in any loss of clarity.

