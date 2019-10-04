Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4939CC235
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 19:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbfJDR4h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 13:56:37 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42168 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbfJDR4h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 13:56:37 -0400
Received: by mail-qk1-f194.google.com with SMTP id f16so6579926qkl.9
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3LFbYySXRieLEJyyVRoIwjcY2D+c5wrknoXBmUitFnw=;
        b=AbAsisv3FHbRR0lsJYZ9oQG43Vu+7dGo274iB1Il7P+bxD8//2SZo4NQJKmvbyDONX
         hLBljjQfUtX+VGpYJqlDB3qo/BFX8464PuxpPmPAC9Q5piAgoqhFHm8vXdYt29uOaq77
         6ho4tyTYKnzYnzd0mmaWuu4iTQW+hYNOPdd0rYAeAEiu+i5EbFGnPIRfUCZKAt91GNl6
         mHD4M9OjlZ2Mbno8eLQ5IjW3VTvWMCwwf/Cvt/s2NpQPjTS4I++SMU0qs4L49LgpcKFL
         ieOXrSsOw5ba9ES2Ng2Ql8FcqLZgf3Gd/C6Z7TJ1TL7rM9VtS/ysFBRzU/cwrMXDhNzH
         DMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3LFbYySXRieLEJyyVRoIwjcY2D+c5wrknoXBmUitFnw=;
        b=BrBS6e5WZTeA/e61thEhdMpeiXRoKM5yyiCdOOl2JgUPr+1gK3kWSGTg54Fej4X2v5
         9vJAVImsR+zSwxY9b4aaGJshvNgTuYKRmIym9tLWwhfjlTfL0i8AETl9K+Gjgetj2CQ1
         LZ8wsUEFDck6GDQKYXt1lFTSktvkXgyvYmouTzTbo+ApudBGkKd0Uk+M+jW03ZXO2QOp
         ZQ7nC9pnb63iaWBtLSP/9ozNdIfNKox4AJXLwIZRSuraawxQUP4muvV6B2iwoWIra+VL
         7tZMeBoz4Q4zZw+D5aD8diOrSxNIdEVyMyfEoHjDulvRQC/J9b9mQSRoUHJ9QEjI4bRc
         WsZA==
X-Gm-Message-State: APjAAAUkCOslGHhgPne60g2iX3H+W28RToARVXWdTPZliMqtOSh8G9x8
        Ea+IdPsW8BQCwiI4i0Dh9KgUew==
X-Google-Smtp-Source: APXvYqzBwRVA8oi/0dMXCy0A3Xz41BH+1nImbdcYUmahvkitUo5BAxwOf1g89cv3b+k0ru5UIItkYg==
X-Received: by 2002:a37:6650:: with SMTP id a77mr11503520qkc.65.1570211795959;
        Fri, 04 Oct 2019 10:56:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id h68sm3223165qkd.35.2019.10.04.10.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 10:56:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iGRog-0006GM-Tq; Fri, 04 Oct 2019 14:56:34 -0300
Date:   Fri, 4 Oct 2019 14:56:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dledford@redhat.com, leon@kernel.org, parav@mellanox.com,
        majd@mellanox.com, markz@mellanox.com, swise@opengridcomputing.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Fix an error handling path in
 'res_get_common_doit()'
Message-ID: <20191004175634.GA24049@ziepe.ca>
References: <20190818091044.8845-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818091044.8845-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 18, 2019 at 11:10:44AM +0200, Christophe JAILLET wrote:
> According to surrounding error paths, it is likely that 'goto err_get;' is
> expected here. Otherwise, a call to 'rdma_restrack_put(res);' would be
> missing.
> 
> Fixes: c5dfe0ea6ffa ("RDMA/nldev: Add resource tracker doit callback")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/core/nldev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
