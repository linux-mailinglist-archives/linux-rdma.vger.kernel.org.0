Return-Path: <linux-rdma+bounces-1307-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A651C874A74
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 10:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A8B5B236BC
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 09:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A6783A12;
	Thu,  7 Mar 2024 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XS8Mw9yN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A475483A0E;
	Thu,  7 Mar 2024 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802801; cv=none; b=hUNPUZezI9Z6JXHIjz9iLmLoVWviU/QuN2mbXl3hdCWnEeP9PpVgrO9cmjukm+hulFNefq6+ID1KuDNF4ntgP/kGbsGklYD5hmt9N3KslrgWfMmlkjpvnrEQZehEsMksQWwWGNL4Rqwuu9q8EH70+vT7CdWeP3iDVH0j3GX+g8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802801; c=relaxed/simple;
	bh=+hhR7nxyYBcqEf8WenBLfeH0QyK7nBAJcLJPjXRcLwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftf7RBjmmha4X1cnFPW9AfM5D6X8BiCxsHPzEaMFLl/CUYJKnuOUht0qW9SwDLUj4f59jp2zFAKxbqd6ZVXJgabsytkxeya2xGP8k0XkYikEYIETZLoQ6BFQwfhY5JEdGn7IbeqyJJdAO3KbyrVFy6MJ/V/z128/DzhYhMyg5A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XS8Mw9yN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4D6C43394;
	Thu,  7 Mar 2024 09:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709802801;
	bh=+hhR7nxyYBcqEf8WenBLfeH0QyK7nBAJcLJPjXRcLwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XS8Mw9yNAHBrEiKVPrgsJxOuLwvMadc9maRiESUeoh6YYR81U26iox8H+q8PuFYcG
	 0aKMT1PDlxaH7Ps8oa3JidI9XAQYFVed3kxHy9gIZcy5uD66PbRRGxTY4mlN5Plhvw
	 mHoeCjvjleSHve/ALZyf0Kg1nrRLo+MpStKJokcfKIkTe0t695ssft+pNyh4jf7+v2
	 WEAgbFXIy/yWPOYE/+Gdlzhwwv8HbYhpHKps6rbI73BE64N3Gl2CyqL6uaHG69sxSi
	 fsU/n3+Hsb5TKiOMyYHuswIhPyF3/qCq5iuuzBOvL/bBeGLXpY6IYYADUgjkV7S/RZ
	 F7vmXBYz1vJsg==
Date: Thu, 7 Mar 2024 11:13:17 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Wenchao Hao <haowenchao2@huawei.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/restrack: Fix potential invalid address access
Message-ID: <20240307091317.GA8392@unreal>
References: <20240301095514.3598280-1-haowenchao2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301095514.3598280-1-haowenchao2@huawei.com>

On Fri, Mar 01, 2024 at 05:55:15PM +0800, Wenchao Hao wrote:
> struct rdma_restrack_entry's kern_name was set to KBUILD_MODNAME
> in ib_create_cq(), while if the module exited but forgot del this
> rdma_restrack_entry, it would cause a invalid address access in
> rdma_restrack_clean() when print the owner of this rdma_restrack_entry.
> 
> Fix this issue by using kstrdup() to set rdma_restrack_entry's
> kern_name.

I don't like kstrdup() and would like to avoid it, this rdma_restrack_clean()
is purely for debugging and for a long time all upstream ULPs are "clean"
from these not-released bugs.

So my suggestion is to delete that part of code and it will be good enough.

diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index 01a499a8b88d..27727138f188 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -60,47 +60,14 @@ static const char *type2str(enum rdma_restrack_type type)
 void rdma_restrack_clean(struct ib_device *dev)
 {
 	struct rdma_restrack_root *rt = dev->res;
-	struct rdma_restrack_entry *e;
-	char buf[TASK_COMM_LEN];
-	bool found = false;
-	const char *owner;
 	int i;
 
 	for (i = 0 ; i < RDMA_RESTRACK_MAX; i++) {
 		struct xarray *xa = &dev->res[i].xa;
 
-		if (!xa_empty(xa)) {
-			unsigned long index;
-
-			if (!found) {
-				pr_err("restrack: %s", CUT_HERE);
-				dev_err(&dev->dev, "BUG: RESTRACK detected leak of resources\n");
-			}
-			xa_for_each(xa, index, e) {
-				if (rdma_is_kernel_res(e)) {
-					owner = e->kern_name;
-				} else {
-					/*
-					 * There is no need to call get_task_struct here,
-					 * because we can be here only if there are more
-					 * get_task_struct() call than put_task_struct().
-					 */
-					get_task_comm(buf, e->task);
-					owner = buf;
-				}
-
-				pr_err("restrack: %s %s object allocated by %s is not freed\n",
-				       rdma_is_kernel_res(e) ? "Kernel" :
-							       "User",
-				       type2str(e->type), owner);
-			}
-			found = true;
-		}
+		WARN_ON(!xa_empty(xa));
 		xa_destroy(xa);
 	}
-	if (found)
-		pr_err("restrack: %s", CUT_HERE);
-
 	kfree(rt);
 }
 

> 
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>  drivers/infiniband/core/restrack.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> index 01a499a8b88d..6605011c4edc 100644
> --- a/drivers/infiniband/core/restrack.c
> +++ b/drivers/infiniband/core/restrack.c
> @@ -177,7 +177,8 @@ static void rdma_restrack_attach_task(struct rdma_restrack_entry *res,
>  void rdma_restrack_set_name(struct rdma_restrack_entry *res, const char *caller)
>  {
>  	if (caller) {
> -		res->kern_name = caller;
> +		kfree(res->kern_name);
> +		res->kern_name = kstrdup(caller, GFP_KERNEL);
>  		return;
>  	}
>  
> @@ -195,7 +196,7 @@ void rdma_restrack_parent_name(struct rdma_restrack_entry *dst,
>  			       const struct rdma_restrack_entry *parent)
>  {
>  	if (rdma_is_kernel_res(parent))
> -		dst->kern_name = parent->kern_name;
> +		dst->kern_name = kstrdup(parent->kern_name, GFP_KERNEL);
>  	else
>  		rdma_restrack_attach_task(dst, parent->task);
>  }
> @@ -306,6 +307,7 @@ static void restrack_release(struct kref *kref)
>  		put_task_struct(res->task);
>  		res->task = NULL;
>  	}
> +	kfree(res->kern_name);
>  	complete(&res->comp);
>  }
>  
> -- 
> 2.32.0
> 

