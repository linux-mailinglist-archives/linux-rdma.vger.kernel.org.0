Return-Path: <linux-rdma+bounces-13248-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A1CB51695
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 14:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9F417D8C5
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 12:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F71305977;
	Wed, 10 Sep 2025 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmXcCjLh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5452B9B9;
	Wed, 10 Sep 2025 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757506403; cv=none; b=PAgz7EdXCN7AfP+2x6nLqaU3rhTBPXWFY8bqalPL6yr7nL0AGcQlr0yqcGfR+OWy4bU2ClzN2KoXLk2dRVPDyp8wfSfoYkAW5MqTYYVeGgz8AmeGVrVEC+mi9BmtxbcKITgVkPnrgybRM7o4Ws65Gh8N3yZgcoEnt3Ll7oFjhQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757506403; c=relaxed/simple;
	bh=f3KbczFHpmwYU58la1F5EYlpqZP5oVM2bUX9Zue5rLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9c4DGCxD/QqcxQ3tsp+0HNvg1wLgQ+meg2t2brut//Jp/1Q9tKstR4bJOdy7Hiq3VumIALKWyzaeFYiU0/gjKhPVZIZxDRIGGRxDqurLPmkZYDq2D4tQ1tWSpYq1n0zzNURw75mx3WBxPpo78qO3GfxgJgihFpm5qGMKyl1zKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmXcCjLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154B7C4CEF0;
	Wed, 10 Sep 2025 12:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757506402;
	bh=f3KbczFHpmwYU58la1F5EYlpqZP5oVM2bUX9Zue5rLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EmXcCjLhq0PdiWqVXY25K8xURhXjqT6ThC7ByoWfW9BUsJvEKmXdaJN/+p1i+dpqo
	 G6LeN42SXsZXbxWsa5j1I4aTv3w51AlJjisfB/cnpAvJPdMRfAcDV0li/ABwsdwkwi
	 MougOHqDkAb+2xpLPsY+rX6clRWMi4QeMaInPDmHm3lacgAQ5vHkN+A9rVocef4SZ4
	 h6NwMNQVH0UNLZto/rw9P83A74HSjnx+DiOaTYL9nMDR/KzWjbmsgK7N48ll8SlJ1u
	 wdYvYUxZuyskqinghPjli5mpoag/3+3rMvddqjj/WwieOY6Fcec11GrRhD3LOjYFs6
	 aSHjKVsPsl2ug==
Date: Wed, 10 Sep 2025 15:13:17 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Tatyana Nikolova <tatyana.e.nikolova@intel.com>, jiri@resnulli.us,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
	Jakub Kicinski <kuba@kernel.org>, Mohammad Heib <mheib@redhat.com>
Subject: Re: [iwl-next] ice, irdma: Add rdma_qp_limits_sel devlink parameter
 for irdma
Message-ID: <20250910121317.GQ341237@unreal>
References: <20250904195719.371-1-tatyana.e.nikolova@intel.com>
 <20250909122051.GF341237@unreal>
 <33d327a0-72d3-4775-8842-6c4ceaff41e2@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33d327a0-72d3-4775-8842-6c4ceaff41e2@intel.com>

On Wed, Sep 10, 2025 at 09:41:14AM +0200, Przemek Kitszel wrote:
> On 9/9/25 14:20, Leon Romanovsky wrote:
> > On Thu, Sep 04, 2025 at 02:57:19PM -0500, Tatyana Nikolova wrote:
> > > Add a devlink parameter to switch between different QP resource profiles
> > > (max number of QPs) supported by irdma for Intel Ethernet 800 devices. The
> > > rdma_qp_limits_sel is translated into an index in the rsrc_limits_table to
> > > select a power of two number between 1 and 256 for max supported QPs (1K-256K).
> > > To reduce the irdma memory footprint, set the rdma_qp_limits_sel default value
> > > to 1 (max 1K QPs).
> > > 
> > > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > > Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> > > ---
> > > Since the changes to irdma are minor, this is targeted to iwl-next/net-next.
> > 
> > <...>
> > 
> > >   #define DEVLINK_LOCAL_FWD_DISABLED_STR "disabled"
> > >   #define DEVLINK_LOCAL_FWD_ENABLED_STR "enabled"
> > >   #define DEVLINK_LOCAL_FWD_PRIORITIZED_STR "prioritized"
> > > @@ -1621,6 +1723,7 @@ enum ice_param_id {
> > >   	ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
> > >   	ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
> > >   	ICE_DEVLINK_PARAM_ID_LOCAL_FWD,
> > > +	ICE_DEVLINK_PARAM_ID_RDMA_QP_LIMITS_SEL,
> > >   };
> > 
> > I was under impression that driver-specific devlink knobs are not
> > allowed. Was this limitation changed for Intel?
> 
> I'm not aware of such limitation.

It is possible that my impression was wrong.

> It's always better to have generic params, but some knobs are not likely
> to be reused; anyway it would be easy to convert into generic.

Unlikely, you will need to keep old parameter and new at the same time
for backward compatibility reasons.

> 
> To have this particular param more generic-ready, we have converted from
> our internal format (values were 0...7, mapped into some powers of two)
> to what one could imagine other drivers would like to add at some point
> (perhaps multiplying the user-provided value by 1K is unnecessarily
> complicating adoption for small NICs, IDK?).
> 
> Do you believe this should be switched to generic now (instead of when
> there is a future user)?
> What about a name (this should be kept forever)?

mlx5 has .log_max_qp in mlx5_profile which looks similar to what you are
proposing here, so RDMA_QP_LIMITS sounds fine to me.

> 
> side note:
> We are also going to add yet another param, now used only by intel, but
> we do so as a generic one: "max number of MAC addrs for VF in i40e", see
> https://lore.kernel.org/intel-wired-lan/20250907100454.193420-1-mheib@redhat.com/T/#t
> 
> 
> > 
> > Thanks
> 

