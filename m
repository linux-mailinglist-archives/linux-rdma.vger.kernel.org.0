Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7C6302A02
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Jan 2021 19:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbhAYSU7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Jan 2021 13:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbhAYSUm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Jan 2021 13:20:42 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0A2C061786
        for <linux-rdma@vger.kernel.org>; Mon, 25 Jan 2021 10:19:51 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id s15so8157155plr.9
        for <linux-rdma@vger.kernel.org>; Mon, 25 Jan 2021 10:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=0c4KjDt9RqUgbcxyXAyGUkPhwWC8rpyfeee6wZQAFco=;
        b=AqNbyr+0wl4qPhxc3CH+99Y1/W6aQeouqpdR58sNIYDkGf5WmwV5MgeLJBM+IJ1Pvc
         dioGNRhcggbnIEy9SigRQFGl8trx8Oxl81+dLdOAiLTHheihfnqS0qNI5qKQ51G6PrWi
         AjxiMB4vDodzkwLRjltgGxDQrHLTXzNrsIXnVtWs2KYQTZTQ3pIGDts5Yr21ui0aaIQi
         4bSnWwkHoSrHG0JHeaBj3YOZKvkMqu3AnHvqU6KZCxOoYOENDNIxXW9TJT6Fpy/alZj4
         lOQ5W05p4mQz8efM/bPfTOaLOcBGbqYkFi5TwVKa1jIVc91DXYFZhhGlS/2/K5IOi6+O
         Zr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=0c4KjDt9RqUgbcxyXAyGUkPhwWC8rpyfeee6wZQAFco=;
        b=EVEISJ73rljlsoYtQ9P78s7sNoCtgDjpX1dGU6L9fIyAu8kypgbjIdm5AWKP9yOOoh
         J2mRq5XYjYRCPc7zM2qCphOkctEmeGJabsr6rWKIiOaYaSAuPxx5sMhV38pI5M+jw6cv
         CW9XVdGdnz8++v9X60nz0NZdfow3JglLg7N6N1us87e97uH6x+iIg1XWS45JVFWvuK4I
         LWGEmYAykRQC4cGFuDdbrpIWBMCdyuWVEq/4Ikwc/5a83+oUdHWl8QIIwGgv3+j9jRi3
         OCjIHbenRKVFaokI/ec1uVxyAvpj5ltr3pDBfJSnJuJWEDD788fHOy8ouJlkHLJwxBfO
         PkrQ==
X-Gm-Message-State: AOAM532PtmDVSLn6spdWAoyJJKpWtCgiBaVrFEDCaEofVbCiv3ZEPY+N
        rZbPIEzF9CEuhCBTDe6lLie7/g==
X-Google-Smtp-Source: ABdhPJx4cEmVf7ft4lmXwGwBrpz2zFbNGi/QGjI/RQLigXVw/jFM6+G/RZb7dQlNfHWGfUuyCC1KTQ==
X-Received: by 2002:a17:902:f54e:b029:de:19f9:c45f with SMTP id h14-20020a170902f54eb02900de19f9c45fmr1958100plf.48.1611598790601;
        Mon, 25 Jan 2021 10:19:50 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id w21sm16351255pff.220.2021.01.25.10.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 10:19:49 -0800 (PST)
Date:   Mon, 25 Jan 2021 10:19:48 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Alexander Lobakin <alobakin@pm.me>
cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Aleksandr Nogikh <nogikh@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Dexuan Cui <decui@microsoft.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Marco Elver <elver@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH net-next 2/3] net: constify page_is_pfmemalloc() argument
 at call sites
In-Reply-To: <20210125164612.243838-3-alobakin@pm.me>
Message-ID: <85978330-9753-f7a-f263-7a1cfd95b851@google.com>
References: <20210125164612.243838-1-alobakin@pm.me> <20210125164612.243838-3-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 25 Jan 2021, Alexander Lobakin wrote:

> Constify "page" argument for page_is_pfmemalloc() users where applicable.
> 
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c   | 2 +-
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c     | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c       | 2 +-
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c       | 2 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.c         | 2 +-
>  drivers/net/ethernet/intel/igb/igb_main.c         | 2 +-
>  drivers/net/ethernet/intel/igc/igc_main.c         | 2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 2 +-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c   | 2 +-
>  include/linux/skbuff.h                            | 4 ++--
>  11 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index 512080640cbc..0f8e962b5010 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> @@ -2800,7 +2800,7 @@ static void hns3_nic_alloc_rx_buffers(struct hns3_enet_ring *ring,
>  	writel(i, ring->tqp->io_base + HNS3_RING_RX_RING_HEAD_REG);
>  }
>  
> -static bool hns3_page_is_reusable(struct page *page)
> +static bool hns3_page_is_reusable(const struct page *page)
>  {
>  	return page_to_nid(page) == numa_mem_id() &&
>  		!page_is_pfmemalloc(page);

Hi Alexander,

All of these functions appear to be doing the same thing, would it make 
sense to simply add this to a header file and remove all the code 
duplication as well?
