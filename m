Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E98226D9D
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 21:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732569AbfEVTnT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 15:43:19 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37133 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731540AbfEVT2X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 May 2019 15:28:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id o7so3844639qtp.4
        for <linux-rdma@vger.kernel.org>; Wed, 22 May 2019 12:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3ZfKtMBwc5tkohkSpbvb3b5f3Ko8Dw0ybXpSQh5gt/E=;
        b=Ua7JRmVg/PPLyjYi4zwoj4WunekYxL3tW795MlxsVvKdjcveG8GFMEG8wA/t/Opq58
         7xNTL6iMvk6B3aKn6J6SvcJkKT11Q0a/HG+sGy6SZsikPtB/+ZylHjb/ddJodsrkPzf+
         OWA3bjYid2hKY949LckGkjXCuCv5Nn4+ilz3f2KCJbwzgSBhj1eUUb+lXoskoJWlUtZW
         d6uu4kVuXHiWGfya2X3zvyy9B5spYamL9cqhiKjzr/yuiduBoDjoJ/7QIvFRX2U6DSJp
         5nQf7bimXoUDj6zDHNVPZE/BBaZhteVMTgwqoZ9fUWw+M8BPtUVMqAy45tBDyMQzSetZ
         Oj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ZfKtMBwc5tkohkSpbvb3b5f3Ko8Dw0ybXpSQh5gt/E=;
        b=blUO4znkv18ARkcp5V0dLN9/w+jis8Uj25ioinCSLnwm4/gAj3jymkufAIc6r9skJj
         N4zOfzl8ZJN9dvzalILku9Fmy81/bB0Gg2E8yYFMukoDahDjuMIjK4C0814Kop5Z4j2n
         AVYYWGLI2fmYsLcEN8D/g6wQtFjEKK0xDAxSUd7tbDnnigDN124FrQZvzDc8ztz2PBNI
         G8jrlzusmABonz3iEptZzq+gjzfxq5VD3SCWcBEgHLjGZgCLLSsmI62Ew3PaZqrXFucq
         ANuVUIycurHjQLaOAePCW/eMFsbfzvtcCv7mJSFXCMyuP1WEuHh1xOeKmeZyM3IyGiFq
         ht7w==
X-Gm-Message-State: APjAAAWv7dVSNh2yEnZ7R+fbDdpViwM6QoMc8XOU9NkK7RyzVB46i3jH
        v4VvyXLGiUzcvfbgM1hCyRR4xA==
X-Google-Smtp-Source: APXvYqzc1EkjVofK2ryq+qApOiRQDBnphGTKYrTx1+vwOy/VyDTwLBbYuBZjYqsGlyXiaiM/UHb2cw==
X-Received: by 2002:aed:3a87:: with SMTP id o7mr23450420qte.310.1558553302565;
        Wed, 22 May 2019 12:28:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id l47sm13161288qtk.22.2019.05.22.12.28.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 12:28:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTWuT-0005oy-IJ; Wed, 22 May 2019 16:28:21 -0300
Date:   Wed, 22 May 2019 16:28:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] RDMA/mlx5: Use DIV_ROUND_UP_ULL macro to allow 32 bit to
 build
Message-ID: <20190522192821.GG6054@ziepe.ca>
References: <20190522145450.25ff483d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522145450.25ff483d@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 22, 2019 at 02:54:50PM -0400, Steven Rostedt wrote:
> 
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> When testing 32 bit x86, my build failed with:
> 
>   ERROR: "__udivdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
> 
> It appears that a few non-ULL roundup() calls were made, which uses a
> normal division against a 64 bit number. This is fine for x86_64, but
> on 32 bit x86, it causes the compiler to look for a helper function
> __udivdi3, which we do not have in the kernel, and thus fails to build.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---

Do you like this version better?

https://patchwork.kernel.org/patch/10950913/

Jason
