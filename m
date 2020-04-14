Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3761A8A3F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2020 20:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504479AbgDNSvs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Apr 2020 14:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504464AbgDNSvo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Apr 2020 14:51:44 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780BBC061A0C
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 11:51:44 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g74so14451425qke.13
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 11:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mNvcNki6DCZFlJtIurocF3iVY17GM7LhVVQ5RlcG4fI=;
        b=NlJ+/mDaUQtpLI6q/kjYwbiSsd0/JkXQsHrWHugJxu7K9BN+1w+KqhPTq/bUaSZ79f
         a1msdGVgwtl1lPqz04n0C01bL3IDng99SwhCtdgIXBVR4An/Vgb90pyj05viPRUyaMbV
         YdpPZ10cL2PkiznAGyWoAK3GPxlFSWhI0KjoH1KI7b9HprwlH+MjHidj6GKerGuiE3EB
         RqYCXFZbE635rhJrhiQ5MwUaUKWw1+SiDegYjYMfdGQ/iISeDWHX3CUjxsyJrqTqE+5L
         9qMwcRHjLdWIeQ0R8ZDKOhMzUm/fcfU6Bx7sdkGyJWcGu/Sqcn46pvfWzxEpQ8Jjpg6d
         chqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mNvcNki6DCZFlJtIurocF3iVY17GM7LhVVQ5RlcG4fI=;
        b=h6UxdPnXQsE48QbPRMbTq9I2rZNqWSnQ7ysG/pDwoCPmH+343qYm/oVydy0yLYbWz8
         Y9rzknRCezUpY2EW3vzMr2yhmFiyNiQm40yHBgKN6dMLLPEUAMcvo9C+AvWTtBv2x+HI
         AVdewqHU7tv9J+WxOKZjdfrJ1m9im/hqzOvOE37xd6gmeMW9bo4/JJP11n4RBbl6uzp9
         O7nNLCkAuyanlEHaR6ng4GDx4xVKyny6Wm4Jf2xShxKETXLsYOTsGSNw2S3ZvaOy91hv
         S6YeHUr2xhyXcmFLOmOIo8kGBf891+ac4D7FLdlRRYTVO/KL9wl945Gxs20E4mZheZWE
         8PTg==
X-Gm-Message-State: AGi0PuasCSDiXjRbNqI9NVjNCsErZgs2ePcNkeR/YHDdm4g+G8py0At7
        GxwhgIJ7SS1Pfo9xmbnfc6ya8w==
X-Google-Smtp-Source: APiQypIfGc4y/p8sfMl7qqOxTl+qTWeoksvDcOBTkh7phnqgjSUcZ+0q7EorhqNV5eZg6PlzHUaiIg==
X-Received: by 2002:a05:620a:15a4:: with SMTP id f4mr8808177qkk.221.1586890303770;
        Tue, 14 Apr 2020 11:51:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id l189sm11101494qkd.112.2020.04.14.11.51.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 11:51:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jOQes-0001CG-PO; Tue, 14 Apr 2020 15:51:42 -0300
Date:   Tue, 14 Apr 2020 15:51:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/cm: Fix missing RDMA_CM_EVENT_REJECTED
 event after receiving REJ message
Message-ID: <20200414185142.GB4556@ziepe.ca>
References: <20200406173242.1465911-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406173242.1465911-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 06, 2020 at 08:32:42PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> The cm_reset_to_idle() call before formatting event changed the CM_ID
> state from IB_CM_REQ_RCVD to be IB_CM_IDLE. It caused to wrong value
> of CM_REJ_MESSAGE_REJECTED field.
> 
> The result of that was that rdma_reject() calls in the passive side
> didn't generate RDMA_CM_EVENT_REJECTED event in the active side.
> 
> Fixes: 81ddb41f876d ("RDMA/cm: Allow ib_send_cm_rej() to be done under lock")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/cm.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> --
> 2.25.1

Applied to for-rc, thanks

Jason
