Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2208C9EF70
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 17:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfH0Pwl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 11:52:41 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38210 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfH0Pwk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Aug 2019 11:52:40 -0400
Received: by mail-qk1-f194.google.com with SMTP id u190so17438595qkh.5
        for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2019 08:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6lrUQjg09W/CYM9ClcXNjxE0QVh6IyAkViPvOSjzfzA=;
        b=oC/bR3dP+V6QA0ryrp2Q5gukrhxwTxWGqUa4c5vEsZoDDuMZE8u8XWgvaANi6aYmn5
         kOFVUPTtT65NdqiMlddOfAw1S02Saa7YodAHtYo3Hz8tbcKNV8NM6MtZOTaj105pdrSy
         e8fr0I+zgUjP37DiaflDF+RtDPJebz++manAmhh2//MT/GoNGSUiRpNiAW4S/E7wzNWq
         s9/30/jHgFtPrWaEwp0nC3T3hsfW6MgmYVZ/Y+gJLeiIn/cuovL2AGwa/qtwY+E19NJ+
         SORxM5ivQHxJxUcpSWTb7HbkxRlFbqK7GTDiVZej+yqeIPZG7fmwfpQhehfEzdbvjm9R
         0cKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6lrUQjg09W/CYM9ClcXNjxE0QVh6IyAkViPvOSjzfzA=;
        b=FgpA910hJ4HDTbrrAkzAoqRlnB9B/qoKCN/wnFqJW5NlV5ppQ+R+d8J2c3UBNYqBQ8
         ugxFD7erO1bpo3s7bK8IPJgee/iwaCXMTrQz5MYrdrdXG219Wh1h3MSQkb1Nxl/MV7mQ
         9U7AQ4RiHFRYVUlCP5WZA0nywwZDdNhOigzRuM2yaBe9izmlVqUE4UJrXELdGO0v8aPd
         uGaAkubfTxeKaW2hFYbRzChMxfCLo2sZJOUFizVOtQokiactZR8QNpaPWwd6M0XzUDye
         n7mHP7XiNaTiXZ+ltgLZKfZla+tbzMbMd3FhdcVvFxz7InmF7y0fU/h+poNwS5qygQ7H
         tYHQ==
X-Gm-Message-State: APjAAAUizQjfgDunJ41bQPefOSFFWYCekhfyeuEA7vvtQ3Gn0jT7y2EG
        dW+kzuGaUmX4Tfcp2/20B4fbng==
X-Google-Smtp-Source: APXvYqyUG6WklpHvBbsoklMcXBZJhAec8BZF3MrQ5LSq8fMd8YxJID2nO0xhjXKRoobutfRjmk8IYQ==
X-Received: by 2002:a37:8381:: with SMTP id f123mr21349287qkd.316.1566921160105;
        Tue, 27 Aug 2019 08:52:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id x68sm8700999qkc.16.2019.08.27.08.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 08:52:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i2dlv-0003zK-93; Tue, 27 Aug 2019 12:52:39 -0300
Date:   Tue, 27 Aug 2019 12:52:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     leon@kernel.org, dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Merge two enums into a single one
Message-ID: <20190827155239.GA15262@ziepe.ca>
References: <1566665546-8209-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566665546-8209-1-git-send-email-jrdr.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Aug 24, 2019 at 10:22:26PM +0530, Souptick Joarder wrote:
> These two enums can be merged into a single one wihtout effecting
> their caller if those were created without intension.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>  include/uapi/rdma/mlx5-abi.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/include/uapi/rdma/mlx5-abi.h b/include/uapi/rdma/mlx5-abi.h
> index 624f5b53..c89363a 100644
> +++ b/include/uapi/rdma/mlx5-abi.h
> @@ -461,13 +461,10 @@ enum mlx5_ib_mmap_cmd {
>  	MLX5_IB_MMAP_DEVICE_MEM                 = 8,
>  };
>  
> -enum {
> -	MLX5_IB_CLOCK_INFO_KERNEL_UPDATING = 1,
> -};
> -
>  /* Bit indexes for the mlx5_alloc_ucontext_resp.clock_info_versions bitmap */
>  enum {
>  	MLX5_IB_CLOCK_INFO_V1              = 0,
> +	MLX5_IB_CLOCK_INFO_KERNEL_UPDATING = 1,
>  };

The enums are used in different contexts, I don't think this is an
improvement

Jason
