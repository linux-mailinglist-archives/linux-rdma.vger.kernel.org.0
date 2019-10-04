Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F909CB983
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 13:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbfJDLvE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 07:51:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45944 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730814AbfJDLvD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 07:51:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id q7so3606212pgi.12
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 04:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LDjxN9zYfYwQGavnLYA8WpnuYwjGQxc3ZfqoyY+I8d4=;
        b=eDZ+LnQEXYZs967EljhFpazUQwxyUnRr8qR/yJ+x3NhXFEjxLwXjpxOsiUBJ78DaKI
         /UMmcl3MEa8C5DRK+Ei3BqtgIO6FTYRD/5EskT6tIuU4YqyusAUCYOJRZqPQdwu2enYd
         PIA2NetokHIFO9SSciCIAErYX/HJ9orevIsr117hbKzymnue9yy/3p5cECN/O2PkESTS
         yGSINmk/SzLffG2biSja81ucIkF79GxNnrTHJs9S6qEgWTECz8xrfr7pAf9FWhNCtYX2
         ONA1XdL8wy//pherVLPZyMIOkhWw9L6uw7RivR13h9eSRr2ajhUAGKRgu6C5aSLZ53cG
         R1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LDjxN9zYfYwQGavnLYA8WpnuYwjGQxc3ZfqoyY+I8d4=;
        b=THpvNOfQrbMJT1tw5gS/+J+d/kFhVLkXkRJJbfBPgqHDnzgAsAWPmSm7t3i+cFd44f
         zyUQciUrl8ttoRWNET0ogC223wnriP3XzBL8aPCgoW79w+kThGwLpnjt+ktRL+GbFavN
         vYemb5Evelu/C+mTT+4XAsTeWG30JyJcdQMox/Y8annJ0873VXFpjPv/KXt17xO5DACu
         cqfJ2N+gfeFwhM5VRcI2wRh3O1ON9VKPhkrGx+N4lK0htZHODZcpnRjRmGFb4/EGeGpD
         pMI2NeZEOMMAVS9PizsnYsmpJTSda8HhGbbuMNlkoowwwppGRmel/+g8DnsvDxOutjNv
         TiZw==
X-Gm-Message-State: APjAAAWyPP80P2zzgrkmPgZWrxAEF4B11fRShiLONj3H/EWpovb4Jkgb
        by07GMmTAlJzZ4YKUMPc5AyA0A==
X-Google-Smtp-Source: APXvYqxWE88uDnUENVAwGnB6kBNSopPGvxoHD74Gl2YC8ZBHYCtxnod+sGwQ8qN4JjQgDDUDo1m3ng==
X-Received: by 2002:a17:90a:24a8:: with SMTP id i37mr16435220pje.123.1570189861247;
        Fri, 04 Oct 2019 04:51:01 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:668d:6035:b425:3a3a])
        by smtp.gmail.com with ESMTPSA id u65sm6097605pfu.104.2019.10.04.04.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 04:50:59 -0700 (PDT)
Date:   Fri, 4 Oct 2019 04:50:57 -0700
From:   Michel Lespinasse <walken@google.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 05/11] IB/hfi1: convert __mmu_int_rb to half closed
 intervals
Message-ID: <20191004115057.GA2371@google.com>
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191003201858.11666-6-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003201858.11666-6-dave@stgolabs.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 03, 2019 at 01:18:52PM -0700, Davidlohr Bueso wrote:
> diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
> index 14d2a90964c3..fb6382b2d44e 100644
> --- a/drivers/infiniband/hw/hfi1/mmu_rb.c
> +++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
> @@ -47,7 +47,7 @@
>  #include <linux/list.h>
>  #include <linux/rculist.h>
>  #include <linux/mmu_notifier.h>
> -#include <linux/interval_tree_generic.h>
> +#include <linux/interval_tree_gen.h>
>  
>  #include "mmu_rb.h"
>  #include "trace.h"
> @@ -89,7 +89,7 @@ static unsigned long mmu_node_start(struct mmu_rb_node *node)
>  
>  static unsigned long mmu_node_last(struct mmu_rb_node *node)
>  {
> -	return PAGE_ALIGN(node->addr + node->len) - 1;
> +	return PAGE_ALIGN(node->addr + node->len);
>  }

May as well rename the function mmu_node_end(). I was worried if it
was used anywhere else, but it turned out it's only used when defining
the interval tree.

I would also suggest moving this function (as well as mmu_node_first)
right before its use, rather than just after, which would allow you to
also remove the function prototype a few lines earlier.

Looks good to me otherwise.

Reviewed-by: Michel Lespinasse <walken@google.com>

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
