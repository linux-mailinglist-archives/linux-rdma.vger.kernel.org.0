Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393E92AC993
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Nov 2020 01:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgKJAGZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Nov 2020 19:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJAGY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Nov 2020 19:06:24 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C58C0613CF
        for <linux-rdma@vger.kernel.org>; Mon,  9 Nov 2020 16:06:23 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id h12so7404786qtc.9
        for <linux-rdma@vger.kernel.org>; Mon, 09 Nov 2020 16:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yX5QL1qES3b/Bku6ul29vkGASbNkXxT4r025bOENuB0=;
        b=Q6FjnbBQqeSPoMQK5k6x1N8LrOVBM+a9yc6GvVS3kPEEOS4b76xtP4Qtr+Rf1Z7Hfv
         L91iIskGZs5++KTAT/jVked4JHq/Ro7OrmkKZXCJB+IUTnp4FeZ/9WlonwlagdVRJSSD
         nK1mcUMyz3WqP7mClbDQaVgIi7lsbOpiW7nymGw+fz2zvdqSzJHbsBvqhYYuV0FhfYrs
         pD+tB2X07xXx+9i9AZ6Le/OKnjtKdSoR1EXAt+BmJzsihksOemZKPxCqMAbtb/ss2Oft
         CK4nNUC8J+dbI8fvtfxHHW6ANJ3wbE7XIj78CLmEbkVbEPNDF8uhDkQi08/jZXJ1Fe6S
         qssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yX5QL1qES3b/Bku6ul29vkGASbNkXxT4r025bOENuB0=;
        b=BNgZJIj+YQraD4zW4PBNJ/ta8dNUaS4bufBg+/tP7GDAOvv2R2ZLo+8fYIM7sscyJ0
         vNtSE2b6E53bItn1b/KWCz4sqoKxb4cTmP62Z9lzql2QzVYyXLMPf5CLZ8kicLca65DL
         K/IMS1pq8nUAlm0u2NAZUv5ni1YXwVZhHVKw1wMy4gslJMix2kGnMifbMYYlZpNqt0NR
         WvM63JkCkVx4U8FBUi2A1NZLJ5lwBLVPAc6W8A2htYcqfhhWHDt/s9W+9fBH9KUevHaK
         bmNXrL+86ytDkTDMtwJx5g+CEzSzAO0BTBZVDr0aopkF9xbydNuCECH7wTlX/YuGJnhw
         /lKQ==
X-Gm-Message-State: AOAM532SDxhH4FYemCDoM1o08+umjpVEeIJPehUbtFwHf3HCheLvvzq8
        FxiIn/pUM1BjCo03nxtdzqa7bQ==
X-Google-Smtp-Source: ABdhPJxIze9PP+D+0OkbuVGb0ER2DW/fkIdpHngI4eWixp8ibhn+diXgdlruvw1rzzu8CNeXslT8aw==
X-Received: by 2002:ac8:615c:: with SMTP id d28mr15886785qtm.104.1604966782537;
        Mon, 09 Nov 2020 16:06:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id k64sm7428185qkc.97.2020.11.09.16.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 16:06:21 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kcHAz-002AMB-Ar; Mon, 09 Nov 2020 20:06:21 -0400
Date:   Mon, 9 Nov 2020 20:06:21 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v9 1/5] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20201110000621.GK244516@ziepe.ca>
References: <1604949781-20735-1-git-send-email-jianxin.xiong@intel.com>
 <1604949781-20735-2-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604949781-20735-2-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 09, 2020 at 11:22:57AM -0800, Jianxin Xiong wrote:

> +	page_size = ib_umem_find_best_pgsz(&umem_dmabuf->umem, PAGE_SIZE,
> +					   umem_dmabuf->umem.iova);
> +
> +	if (WARN_ON(cur != end || page_size != PAGE_SIZE)) {
> +		ib_umem_dmabuf_unmap_pages(umem_dmabuf);
> +		return -EINVAL;
> +	}

This is not a warn_on situation, users can trigger this

Jason
