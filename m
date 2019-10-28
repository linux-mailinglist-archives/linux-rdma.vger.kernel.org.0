Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4155E7716
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 17:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfJ1Q5F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 12:57:05 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37768 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfJ1Q5F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 12:57:05 -0400
Received: by mail-qk1-f194.google.com with SMTP id u184so9144547qkd.4
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GhbPzWV49glcuzG4m0O/U4UGiD+17rDN+b4Tdlhcz5w=;
        b=or744+wIg1+sOPODHvEmIBlka/QIBxVNND2apelw4ZoNMgN0W9u/oCbxiNoCUPfufd
         Bu82mFEZnflrFwxowU9gDxfqRGyahoHTsZ9fMJ59ZBkxa8eIYeoB7FGcvvG1GAgy8Z1N
         RdT4KenFST+BJn+adbv7AXVLk7nkUp3qKko4KE71+yS38g6zd4ajE9MzONqBIllAE+nM
         7CdNlkQKbVU77YG/wuZo0Zy/zkA5xfE3ih3lG2kD45u9PN8QZyml9wLWT2sTbhsxe5L3
         rrr/3q2erhoP3gfpvJ40kpfs3WnzAb5Tj/RPrUNAOSdArXjp48d+GvwNW14vQebCxhfp
         UaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GhbPzWV49glcuzG4m0O/U4UGiD+17rDN+b4Tdlhcz5w=;
        b=PXCrbb6o8V4bO/28xZn4qgl2XUJ9XjjmlzGvVC0zUMuBjEMrJq0gFSYXCUEzqsaPJv
         WPfWiDBq2nYLMFVXcnV05ZOTIbNCLN2u+6cH0V5REx9lsxxwN8kKWOsuA60LlE1zhWw6
         gtFlRZ3pvBoXq7RcwF5QNglf3QDZWKfpku5+3rGidRpR/MlcngurvsmT3yIacQPknILh
         n0AY3weLVXPyKsF6LiiDLIIFWRWdxT0bddRb+e2Ix15az10kWKmeWHUosmS0V+3Ftz1U
         FAtyeiOLbTrRu5TOjJjD0Q2/Sz9yuJIPuqNHkUZX+ZsTbYPuelQM/lp43GgMNFQSkbx3
         +Nyw==
X-Gm-Message-State: APjAAAXlKqs5P7gb25dGMQszp9pWt2xtGF2OlQ1B/XUYMgVRLZJ3gdHC
        NLGYlE9meTlRaEC+lpAygloSBuvqTEo=
X-Google-Smtp-Source: APXvYqxxZUqyZqJN5MEKgzMaOzA0snjIyq6YwvMFn4Odt0KKW9Pmnn7Mx2bwZzX0Y2OJxRyMz4gGXQ==
X-Received: by 2002:a37:b985:: with SMTP id j127mr16773815qkf.337.1572281822929;
        Mon, 28 Oct 2019 09:57:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id i4sm4526230qki.24.2019.10.28.09.57.02
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 09:57:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP8KD-0006V3-SR
        for linux-rdma@vger.kernel.org; Mon, 28 Oct 2019 13:57:01 -0300
Date:   Mon, 28 Oct 2019 13:57:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] rdma: Remove nes ABI header
Message-ID: <20191028165701.GA24961@ziepe.ca>
References: <20191024135059.GA20084@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024135059.GA20084@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 24, 2019 at 01:51:03PM +0000, Jason Gunthorpe wrote:
> This was missed when nes was removed.
> 
> Fixes: 2d3c72ed5041 ("rdma: Remove nes")
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  include/uapi/rdma/nes-abi.h | 115 ------------------------------------
>  1 file changed, 115 deletions(-)
>  delete mode 100644 include/uapi/rdma/nes-abi.h

Applied to for-next

Jason
