Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142C16B76E8
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Mar 2023 12:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjCMLyR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Mar 2023 07:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjCMLxR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Mar 2023 07:53:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E8E67015;
        Mon, 13 Mar 2023 04:52:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECF4FB80DFD;
        Mon, 13 Mar 2023 11:52:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A23C433D2;
        Mon, 13 Mar 2023 11:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678708358;
        bh=u7ciXzaxMyBkt6kojTny0z24aQnIZXt5ygzCX2whg20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XRq6aqFChRZdAq+wZCPlA/EridxtvSAaFH9w2i0r4h+h60cUws/LHsqKWeM9+NKSo
         yZ6cCb2jfwM8auMbrISfjAKSDVmo2K7+fJfNnKvuY9wDglqt9tcKXcqL8XP5mohXcJ
         Kcyt0dYjryZbITjhOKKJHiL6sMiRSkBydaJUzM7f3U/+vwGBtZAFWdU+8EDt1l/TvE
         kvXoyIzfdI28QpbMZ9NAYijikrNmpnXeiikyI2UhcXWjOKVsJtSIQyI/rC4yhuvWBg
         enADPQTpDwEpn3QyQbyBUJfNT2pDycUl4AQEsI3U/tJjMBWA0TERAt+5A1qLQlaIFE
         n1aG83y377YNQ==
Date:   Mon, 13 Mar 2023 13:52:35 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     void0red <void0red@gmail.com>
Cc:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/hifi1: add a null check of kzalloc_node in
 hfi1_ipoib_txreq_init
Message-ID: <20230313115235.GA135453@unreal>
References: <20230227100212.910820-1-void0red@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227100212.910820-1-void0red@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 27, 2023 at 06:02:12PM +0800, void0red wrote:
> From: Kang Chen <void0red@gmail.com>
> 
> kzalloc_node may fails, check it and do the cleanup.
> 
> Signed-off-by: Kang Chen <void0red@gmail.com>
> ---
>  drivers/infiniband/hw/hfi1/ipoib_tx.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Added Fixes line and applied.
Fixes: b1151b74ff68 ("IB/hfi1: Fix alloc failure with larger txqueuelen")

Thanks

> 
> diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
> index 5d9a7b09c..349eb4139 100644
> --- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
> +++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
> @@ -737,10 +737,13 @@ int hfi1_ipoib_txreq_init(struct hfi1_ipoib_dev_priv *priv)
>  		txq->tx_ring.shift = ilog2(tx_item_size);
>  		txq->tx_ring.avail = hfi1_ipoib_ring_hwat(txq);
>  		tx_ring = &txq->tx_ring;
> -		for (j = 0; j < tx_ring_size; j++)
> +		for (j = 0; j < tx_ring_size; j++) {
>  			hfi1_txreq_from_idx(tx_ring, j)->sdma_hdr =
>  				kzalloc_node(sizeof(*tx->sdma_hdr),
>  					     GFP_KERNEL, priv->dd->node);
> +			if (!hfi1_txreq_from_idx(tx_ring, j)->sdma_hdr)
> +				goto free_txqs;
> +		}
>  
>  		netif_napi_add_tx(dev, &txq->napi, hfi1_ipoib_poll_tx_ring);
>  	}
> -- 
> 2.34.1
> 
