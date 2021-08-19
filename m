Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7266E3F1928
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 14:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239094AbhHSM16 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 08:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239187AbhHSM15 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Aug 2021 08:27:57 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39F5C06175F
        for <linux-rdma@vger.kernel.org>; Thu, 19 Aug 2021 05:27:20 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d2so4387530qto.6
        for <linux-rdma@vger.kernel.org>; Thu, 19 Aug 2021 05:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5h8DRQ7Bx+eFzlj90sftRVtoQw5ByFsjYM5vOznvNjM=;
        b=Lh2+mUHm/NzMtpiU3c8gY3ZdaGQ0hTG/m9kvEQgXEg1RKz+3FaF0xDsca30ygZMj4U
         71tVT3HVfOJ+uq/ae3O+V2/wNz1ZKRL5oXrfJMrT9ZLS8IGqK1WZlS1VIy7/pMZF5p1U
         iJ4mL0UEz55891lYfc4fFzXB5mnKfGVvXu5qR2IqQy99MvlG8TXgE0bJRzU78LOMzryT
         7Xl+HKBwG9bWchW9H2+S/GBzGWNkuVy8E57+OfP+v2vJHi/dIPH6q7xZxwuYZQV9zBN7
         98qA2j6Yif6IJCGo5nBcNVo6T60PWrjlYnFBGmvL3mwjjuqqvooktAaU5gBmctIMOXRS
         0LWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5h8DRQ7Bx+eFzlj90sftRVtoQw5ByFsjYM5vOznvNjM=;
        b=h6wiTHBpHcVPsfpKJlQETx7dNwCidhwdhCQX0Oe4Kd6BOWNIEZ7vr8qWJiuZQozp4k
         akZaYDTP1pqVfkK20ZR8B493ItV3s531Ado0aQpS1RLcoFLrbJwQx79ecDIkuo7PjbNJ
         12uru4tfsMWPA7ZY/PCoUGi4gHwNqt4v0J9knXoJrk7c0mVxlJA/n7lHsLAeNTMO8zHg
         7LO8+Pkii/CGdZIZS9+wvYy47v4fl7HlEyaovMfn88+lf476Q85LJ1OXvGCQU16uH+e+
         PWy3MypaZNgAY7S/KaFb01UgzNAwMTaGGbIUS387+4LIWcg1Rm0/nD1o/pDqmV1V3n6t
         8iSA==
X-Gm-Message-State: AOAM533Kl8Bq7FLqHRrig0KGX1Ymxf3TZ5jqH5vDAMS8CmUUJKHn+gQD
        X3Kz/eEZi0e3G6ql9+BzBc+CNw==
X-Google-Smtp-Source: ABdhPJxwk7vI3dEd2/mwgiJx7X4NGPWrwVGFe3LSMD/MyzGQMgDurTmsWQFQ5lpblgS6WBAbFYMPPg==
X-Received: by 2002:a05:622a:11cc:: with SMTP id n12mr12404820qtk.363.1629376038633;
        Thu, 19 Aug 2021 05:27:18 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id d7sm1266808qth.70.2021.08.19.05.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 05:27:18 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mGh8e-0016LT-A5; Thu, 19 Aug 2021 09:27:16 -0300
Date:   Thu, 19 Aug 2021 09:27:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 56/63] RDMA/mlx5: Use struct_group() to zero struct
 mlx5_ib_mr
Message-ID: <20210819122716.GP543798@ziepe.ca>
References: <20210818060533.3569517-1-keescook@chromium.org>
 <20210818060533.3569517-57-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818060533.3569517-57-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 17, 2021 at 11:05:26PM -0700, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memset(), avoid intentionally writing across
> neighboring fields.
> 
> Add struct_group() to mark region of struct mlx5_ib_mr that should be
> initialized to zero.
> 
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index bf20a388eabe..f63bf204a7a1 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -644,6 +644,7 @@ struct mlx5_ib_mr {
>  	struct ib_umem *umem;
>  
>  	/* This is zero'd when the MR is allocated */
> +	struct_group(cleared,
>  	union {
>  		/* Used only while the MR is in the cache */
>  		struct {
> @@ -691,12 +692,13 @@ struct mlx5_ib_mr {
>  			bool is_odp_implicit;
>  		};
>  	};
> +	);
>  };
>  
>  /* Zero the fields in the mr that are variant depending on usage */
>  static inline void mlx5_clear_mr(struct mlx5_ib_mr *mr)
>  {
> -	memset(mr->out, 0, sizeof(*mr) - offsetof(struct mlx5_ib_mr, out));
> +	memset(&mr->cleared, 0, sizeof(mr->cleared));
>  }

Why not use the memset_after(mr->umem) here?

Jason
