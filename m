Return-Path: <linux-rdma+bounces-8529-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B75AA59660
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 14:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13CE3A52D3
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 13:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8C7226545;
	Mon, 10 Mar 2025 13:31:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A842206B2;
	Mon, 10 Mar 2025 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741613476; cv=none; b=pPSJCzHYjN19kvsCj2jwRfaTpc5rO8hyAPDSXgQar9frPzu/Ks5GZzhu4Jkf2q39a+HvryCw4EXcskkSgxYhDe6jrz8rZfGxdPGI5WlzjpeerK6cC24O52hGWH1S+hhzoho7OxDR6nx8CMEkLDrSUf0eSkpXdW4xqWOSfxtqtOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741613476; c=relaxed/simple;
	bh=PHey9c3fSFb5c0rKUPTi+1g/2zVV9QZ1kXG7mABqo/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKZmMcYJIUiwHjm8Wde6s1sIzGbNenlPvjeFgCDaDqg8ndp3afQFiOG4DfZQqTLSzI+vnoiGcQUG2ZrOGwQd3tkUEhiosQSejHOKUcBTewUXUgxDOitSozTb+N2zrRq/5afrMAFGWgdggnyTDAXJjDT49hJu8PQEpRPAI1qY8+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id B1681160E; Mon, 10 Mar 2025 08:31:10 -0500 (CDT)
Date: Mon, 10 Mar 2025 08:31:10 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Parav Pandit <parav@nvidia.com>
Cc: linux-rdma@vger.kernel.org, linux-security-module@vger.kernel.org,
	ebiederm@xmission.com
Subject: Re: [PATCH] RDMA/uverbs: Fix CAP_NET_RAW check for flow create in
 user namespace
Message-ID: <20250310133110.GA190312@mail.hallyn.com>
References: <20250308180602.129663-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308180602.129663-1-parav@nvidia.com>

On Sat, Mar 08, 2025 at 08:06:02PM +0200, Parav Pandit wrote:
> A process running in a non-init user namespace possesses the
> CAP_NET_RAW capability. However, the patch cited in the fixes
> tag checks the capability in the default init user namespace.
> Because of this, when the process was started by Podman in a
> non-default user namespace, the flow creation failed.
> 
> Fix this issue by checking the CAP_NET_RAW networking capability
> in the owner user namespace that created the network namespace.

Hi,

you say

 > Fix this issue by checking the CAP_NET_RAW networking capability
 > in the owner user namespace that created the network namespace.

But in fact you are checking the CAP_NET_RAW against the user's
network namespace.  That is usually not the same thing, although
it is possible that in this case it is.

What is cmd.flow_id?  Is that guaranteed to represent something in
the current process' network namespace?  Or is it possible that a
user without privilege in his user namespace could unshare userns+netns
but then cause this fn to be called against a flow in the original
network namespace?

> 
> This change is similar to the following cited patches.
> 
> commit 5e1fccc0bfac ("net: Allow userns root control of the core of the network stack.")
> commit 52e804c6dfaa ("net: Allow userns root to control ipv4")
> commit 59cd7377660a ("net: openvswitch: allow conntrack in non-initial user namespace")
> commit 0a3deb11858a ("fs: Allow listmount() in foreign mount namespace")
> commit dd7cb142f467 ("fs: relax permissions for listmount()")
> 
> Fixes: c938a616aadb ("IB/core: Add raw packet QP type")
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> 
> ---
> I would like to have feedback from the LSM experts to make sure this
> fix is correct. Given the widespread usage of the capable() call,
> it makes me wonder if the patch right.
> 
> Secondly, I wasn't able to determine which primary namespace (such as
> mount or IPC, etc.) to consider for the CAP_IPC_LOCK capability.
> (not directly related to this patch, but as concept)
> ---
>  drivers/infiniband/core/uverbs_cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 5ad14c39d48c..8d6615f390f5 100644
> --- a/drivers/infiniband/core/uverbs_cmd.c
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -3198,7 +3198,7 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
>  	if (cmd.comp_mask)
>  		return -EINVAL;
>  
> -	if (!capable(CAP_NET_RAW))
> +	if (!ns_capable(current->nsproxy->net_ns->user_ns, CAP_NET_RAW))
>  		return -EPERM;
>  
>  	if (cmd.flow_attr.flags >= IB_FLOW_ATTR_FLAGS_RESERVED)
> -- 
> 2.26.2
> 

