Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D21B1EA5A8
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2020 16:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgFAOR3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Jun 2020 10:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgFAOR2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Jun 2020 10:17:28 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5D3C05BD43
        for <linux-rdma@vger.kernel.org>; Mon,  1 Jun 2020 07:17:28 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 205so9151828qkg.3
        for <linux-rdma@vger.kernel.org>; Mon, 01 Jun 2020 07:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2iPsdF4kh6pch4rZM84YL73vIodEhxTfIdVzNbxxbSU=;
        b=LoNEukwBPj8mILN1IAW3dKT3zfAOpSmNqhaNp+qg92jzxKzhteoTBKLMm5Yyky8lZj
         sPFxifz4zpwksO9BUHCHMNVwgf4KvGgLto6rc9irJbMlayN04shOnnNfCZTk7a6OPGO7
         hTR49imIh76547ZURtq1YWgwXNdLtQdaWuQJz4A4IAEC+rYdKtAJhPjYsi8uA4VnJEo9
         tIWfPTm6zBObvm2oXUYwz0H9MwsPuhJ9BBlHynVWoJQwTI8uzuaRnXNfia4/L44r1Fey
         GykSXpicDINg8tMvkB9w8WLEUVcW2PfHqQ3k84gPsqTL9wUd7ZNMZ5tahj6DHhUm31yo
         aaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2iPsdF4kh6pch4rZM84YL73vIodEhxTfIdVzNbxxbSU=;
        b=sk9xbaoVOkbgGRnsBgC43NCxpR0hd4PQj+em2DakkWnSoTCTr5+3zN6FgeVV0WUooo
         pWhGeMiY0O/nf1KcxRxCyq7OMYGUirnan5HLroPkBYSjd7FRPt3FZJa1gCXxLTB6rS5Q
         MAb7nOkFk6jteMv7TgP9dzpkUJTgt7KMcC2Qu+p02Reel522F2sOhctGmPXeUWWRKgDj
         1uUrHi64qiXYUKoT+FErX0c109Lru7Qkia0HBf6hHYo53jRUfoWPKVFpmA0Q0LeX61h/
         7e+pDEaZ8SgDZCVT/KL5tstuLzqLr4j6p2zb9NzJqgQFpupBr8x0+fB/EnYemz0SkJ0u
         OJqg==
X-Gm-Message-State: AOAM532K0G5P/vexJNVtkoeFv6sPAW07nndK+CFbKRizwTKQnYPuOBpC
        d9Y7nficX4zVhD3lbQAPekiRxA==
X-Google-Smtp-Source: ABdhPJxEvaWTyQMc3+4F0xfVG5nHOcpmIIDU7jiRhJXYuZlxzYk7rbfo0j2QGbJlSQ0g2bDRQz5Yuw==
X-Received: by 2002:a05:620a:15da:: with SMTP id o26mr18349645qkm.304.1591021047250;
        Mon, 01 Jun 2020 07:17:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id q32sm15390872qtf.36.2020.06.01.07.17.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Jun 2020 07:17:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jflFm-0006LQ-A0; Mon, 01 Jun 2020 11:17:26 -0300
Date:   Mon, 1 Jun 2020 11:17:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/core: Move and rename trace_cm_id_create()
Message-ID: <20200601141726.GA24329@ziepe.ca>
References: <20200530174934.21362.56754.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530174934.21362.56754.stgit@manet.1015granger.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 30, 2020 at 01:52:58PM -0400, Chuck Lever wrote:
> The restrack ID for an rdma_cm_id is not assigned until it is
> associated with a device.
> 
> Here's an example I captured while testing NFS/RDMA's support for
> DEVICE_REMOVAL. The new tracepoint name is "cm_id_attach".
> 
>            <...>-4261  [001]   366.581299: cm_event_handler:     cm.id=0 src=0.0.0.0:45919 dst=192.168.2.55:20049 tos=0 ADDR_ERROR (1/-19)
>            <...>-4261  [001]   366.581304: cm_event_done:        cm.id=0 src=0.0.0.0:45919 dst=192.168.2.55:20049 tos=0 ADDR_ERROR consumer returns 0
>            <...>-1950  [000]   366.581309: cm_id_destroy:        cm.id=0 src=0.0.0.0:45919 dst=192.168.2.55:20049 tos=0
>            <...>-7     [001]   369.589400: cm_event_handler:     cm.id=0 src=0.0.0.0:49023 dst=192.168.2.55:20049 tos=0 ADDR_ERROR (1/-19)
>            <...>-7     [001]   369.589404: cm_event_done:        cm.id=0 src=0.0.0.0:49023 dst=192.168.2.55:20049 tos=0 ADDR_ERROR consumer returns 0
>            <...>-1950  [000]   369.589407: cm_id_destroy:        cm.id=0 src=0.0.0.0:49023 dst=192.168.2.55:20049 tos=0
>            <...>-4261  [001]   372.597650: cm_id_attach:         cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 device=mlx4_0
>            <...>-4261  [001]   372.597652: cm_event_handler:     cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 ADDR_RESOLVED (0/0)
>            <...>-4261  [001]   372.597654: cm_event_done:        cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 ADDR_RESOLVED consumer returns 0
>            <...>-4261  [001]   372.597738: cm_event_handler:     cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 ROUTE_RESOLVED (2/0)
>            <...>-4261  [001]   372.597740: cm_event_done:        cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 ROUTE_RESOLVED consumer returns 0
>            <...>-4691  [007]   372.600101: cm_qp_create:         cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 pd.id=2 qp_type=RC send_wr=4091 recv_wr=256 qp_num=530 rc=0
>            <...>-4691  [007]   372.600207: cm_send_req:          cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 qp_num=530
>            <...>-185   [002]   372.601212: cm_send_mra:          cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0
>            <...>-185   [002]   372.601362: cm_send_rtu:          cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0
>            <...>-185   [002]   372.601372: cm_event_handler:     cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 ESTABLISHED (9/0)
>            <...>-185   [002]   372.601379: cm_event_done:        cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 ESTABLISHED consumer returns 0
> 
> Fixes: ed999f820a6c ("RDMA/cma: Add trace points in RDMA Connection Manager")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/cma.c       |    2 +-
>  drivers/infiniband/core/cma_trace.h |   20 +++++++++++++++-----
>  2 files changed, 16 insertions(+), 6 deletions(-)

Applied to for-next, thanks

Jason
