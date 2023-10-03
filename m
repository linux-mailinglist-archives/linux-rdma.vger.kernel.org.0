Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378507B66AE
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Oct 2023 12:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjJCKqK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Oct 2023 06:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjJCKqJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Oct 2023 06:46:09 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55D77B0;
        Tue,  3 Oct 2023 03:46:04 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id B8C4620B74C0; Tue,  3 Oct 2023 03:46:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B8C4620B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1696329963;
        bh=A/JzxQYqx0L95oDaP99JeHhU08q4Gp3osyahR3qmoOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=COPhpXVTfaZ2zAGsvAX772Ne+p8Av91/mdpaEiuftJyQQ3yi5xGKkqRdDPiBAzEvj
         Y8xOJzH43Ie6yHbaRnyp28rh+SOg0tTCIJZQpFNcBjOZ0JKBaZMm3jEs2oysHkcP9w
         1vb1hk7Alh7/G/pD1/8sVWqXgtoxPugJG6xHVDZk=
Date:   Tue, 3 Oct 2023 03:46:03 -0700
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
        paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
        davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
        longli@microsoft.com, ssengar@linux.microsoft.com,
        linux-rdma@vger.kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
        sharmaajay@microsoft.com, hawk@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net,v2, 3/3] net: mana: Fix oversized sge0 for GSO packets
Message-ID: <20231003104603.GC32191@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1696020147-14989-1-git-send-email-haiyangz@microsoft.com>
 <1696020147-14989-4-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696020147-14989-4-git-send-email-haiyangz@microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 29, 2023 at 01:42:27PM -0700, Haiyang Zhang wrote:
> Handle the case when GSO SKB linear length is too large.
> 
> MANA NIC requires GSO packets to put only the header part to SGE0,
> otherwise the TX queue may stop at the HW level.
> 
> So, use 2 SGEs for the skb linear part which contains more than the
> packet header.
> 
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> v2: coding style updates suggested by Simon Horman
> 
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 191 +++++++++++++-----
>  include/net/mana/mana.h                       |   5 +-
>  2 files changed, 138 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 86e724c3eb89..48ea4aeeea5d 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -91,63 +91,137 @@ static unsigned int mana_checksum_info(struct sk_buff *skb)
>  	return 0;
>  }
>  
> +static void mana_add_sge(struct mana_tx_package *tp, struct mana_skb_head *ash,
> +			 int sg_i, dma_addr_t da, int sge_len, u32 gpa_mkey)
> +{
> +	ash->dma_handle[sg_i] = da;
> +	ash->size[sg_i] = sge_len;
> +
> +	tp->wqe_req.sgl[sg_i].address = da;
> +	tp->wqe_req.sgl[sg_i].mem_key = gpa_mkey;
> +	tp->wqe_req.sgl[sg_i].size = sge_len;
> +}
> +
>  static int mana_map_skb(struct sk_buff *skb, struct mana_port_context *apc,
> -			struct mana_tx_package *tp)
> +			struct mana_tx_package *tp, int gso_hs)
>  {
>  	struct mana_skb_head *ash = (struct mana_skb_head *)skb->head;
> +	int hsg = 1; /* num of SGEs of linear part */
>  	struct gdma_dev *gd = apc->ac->gdma_dev;
> +	int skb_hlen = skb_headlen(skb);
> +	int sge0_len, sge1_len = 0;
>  	struct gdma_context *gc;
>  	struct device *dev;
>  	skb_frag_t *frag;
>  	dma_addr_t da;
> +	int sg_i;
>  	int i;
>  
>  	gc = gd->gdma_context;
>  	dev = gc->dev;
> -	da = dma_map_single(dev, skb->data, skb_headlen(skb), DMA_TO_DEVICE);
>  
> +	if (gso_hs && gso_hs < skb_hlen) {
> +		sge0_len = gso_hs;
> +		sge1_len = skb_hlen - gso_hs;
> +	} else {
> +		sge0_len = skb_hlen;
> +	}
> +
> +	da = dma_map_single(dev, skb->data, sge0_len, DMA_TO_DEVICE);
>  	if (dma_mapping_error(dev, da))
>  		return -ENOMEM;
>  
> -	ash->dma_handle[0] = da;
> -	ash->size[0] = skb_headlen(skb);
> +	mana_add_sge(tp, ash, 0, da, sge0_len, gd->gpa_mkey);
>  
> -	tp->wqe_req.sgl[0].address = ash->dma_handle[0];
> -	tp->wqe_req.sgl[0].mem_key = gd->gpa_mkey;
> -	tp->wqe_req.sgl[0].size = ash->size[0];
> +	if (sge1_len) {
> +		sg_i = 1;
> +		da = dma_map_single(dev, skb->data + sge0_len, sge1_len,
> +				    DMA_TO_DEVICE);
> +		if (dma_mapping_error(dev, da))
> +			goto frag_err;
> +
> +		mana_add_sge(tp, ash, sg_i, da, sge1_len, gd->gpa_mkey);
> +		hsg = 2;
> +	}
>  
>  	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
> +		sg_i = hsg + i;
> +
>  		frag = &skb_shinfo(skb)->frags[i];
>  		da = skb_frag_dma_map(dev, frag, 0, skb_frag_size(frag),
>  				      DMA_TO_DEVICE);
> -
>  		if (dma_mapping_error(dev, da))
>  			goto frag_err;
>  
> -		ash->dma_handle[i + 1] = da;
> -		ash->size[i + 1] = skb_frag_size(frag);
> -
> -		tp->wqe_req.sgl[i + 1].address = ash->dma_handle[i + 1];
> -		tp->wqe_req.sgl[i + 1].mem_key = gd->gpa_mkey;
> -		tp->wqe_req.sgl[i + 1].size = ash->size[i + 1];
> +		mana_add_sge(tp, ash, sg_i, da, skb_frag_size(frag),
> +			     gd->gpa_mkey);
>  	}
>  
>  	return 0;
>  
>  frag_err:
> -	for (i = i - 1; i >= 0; i--)
> -		dma_unmap_page(dev, ash->dma_handle[i + 1], ash->size[i + 1],
> +	for (i = sg_i - 1; i >= hsg; i--)
> +		dma_unmap_page(dev, ash->dma_handle[i], ash->size[i],
>  			       DMA_TO_DEVICE);
>  
> -	dma_unmap_single(dev, ash->dma_handle[0], ash->size[0], DMA_TO_DEVICE);
> +	for (i = hsg - 1; i >= 0; i--)
> +		dma_unmap_single(dev, ash->dma_handle[i], ash->size[i],
> +				 DMA_TO_DEVICE);
>  
>  	return -ENOMEM;
>  }
>  
> +/* Handle the case when GSO SKB linear length is too large.
> + * MANA NIC requires GSO packets to put only the packet header to SGE0.
> + * So, we need 2 SGEs for the skb linear part which contains more than the
> + * header.
> + * Return a positive value for the number of SGEs, or a negative value
> + * for an error.
> + */
> +static int mana_fix_skb_head(struct net_device *ndev, struct sk_buff *skb,
> +			     int gso_hs)
> +{
> +	int num_sge = 1 + skb_shinfo(skb)->nr_frags;
> +	int skb_hlen = skb_headlen(skb);
> +
> +	if (gso_hs < skb_hlen) {
> +		num_sge++;
> +	} else if (gso_hs > skb_hlen) {
> +		if (net_ratelimit())
> +			netdev_err(ndev,
> +				   "TX nonlinear head: hs:%d, skb_hlen:%d\n",
> +				   gso_hs, skb_hlen);
> +
> +		return -EINVAL;
> +	}
> +
> +	return num_sge;
> +}
> +
> +/* Get the GSO packet's header size */
> +static int mana_get_gso_hs(struct sk_buff *skb)
> +{
> +	int gso_hs;
> +
> +	if (skb->encapsulation) {
> +		gso_hs = skb_inner_tcp_all_headers(skb);
> +	} else {
> +		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
> +			gso_hs = skb_transport_offset(skb) +
> +				 sizeof(struct udphdr);
> +		} else {
> +			gso_hs = skb_tcp_all_headers(skb);
> +		}
> +	}
> +
> +	return gso_hs;
> +}
> +
>  netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {
>  	enum mana_tx_pkt_format pkt_fmt = MANA_SHORT_PKT_FMT;
>  	struct mana_port_context *apc = netdev_priv(ndev);
> +	int gso_hs = 0; /* zero for non-GSO pkts */
>  	u16 txq_idx = skb_get_queue_mapping(skb);
>  	struct gdma_dev *gd = apc->ac->gdma_dev;
>  	bool ipv4 = false, ipv6 = false;
> @@ -159,7 +233,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	struct mana_txq *txq;
>  	struct mana_cq *cq;
>  	int err, len;
> -	u16 ihs;
>  
>  	if (unlikely(!apc->port_is_up))
>  		goto tx_drop;
> @@ -209,19 +282,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	pkg.wqe_req.client_data_unit = 0;
>  
>  	pkg.wqe_req.num_sge = 1 + skb_shinfo(skb)->nr_frags;
> -	WARN_ON_ONCE(pkg.wqe_req.num_sge > MAX_TX_WQE_SGL_ENTRIES);
> -
> -	if (pkg.wqe_req.num_sge <= ARRAY_SIZE(pkg.sgl_array)) {
> -		pkg.wqe_req.sgl = pkg.sgl_array;
> -	} else {
> -		pkg.sgl_ptr = kmalloc_array(pkg.wqe_req.num_sge,
> -					    sizeof(struct gdma_sge),
> -					    GFP_ATOMIC);
> -		if (!pkg.sgl_ptr)
> -			goto tx_drop_count;
> -
> -		pkg.wqe_req.sgl = pkg.sgl_ptr;
> -	}
>  
>  	if (skb->protocol == htons(ETH_P_IP))
>  		ipv4 = true;
> @@ -229,6 +289,26 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  		ipv6 = true;
>  
>  	if (skb_is_gso(skb)) {
> +		int num_sge;
> +
> +		gso_hs = mana_get_gso_hs(skb);
> +
> +		num_sge = mana_fix_skb_head(ndev, skb, gso_hs);
> +		if (num_sge > 0)
> +			pkg.wqe_req.num_sge = num_sge;
> +		else
> +			goto tx_drop_count;
> +
> +		u64_stats_update_begin(&tx_stats->syncp);
> +		if (skb->encapsulation) {
> +			tx_stats->tso_inner_packets++;
> +			tx_stats->tso_inner_bytes += skb->len - gso_hs;
> +		} else {
> +			tx_stats->tso_packets++;
> +			tx_stats->tso_bytes += skb->len - gso_hs;
> +		}
> +		u64_stats_update_end(&tx_stats->syncp);
> +
>  		pkg.tx_oob.s_oob.is_outer_ipv4 = ipv4;
>  		pkg.tx_oob.s_oob.is_outer_ipv6 = ipv6;
>  
> @@ -252,26 +332,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  						 &ipv6_hdr(skb)->daddr, 0,
>  						 IPPROTO_TCP, 0);
>  		}
> -
> -		if (skb->encapsulation) {
> -			ihs = skb_inner_tcp_all_headers(skb);
> -			u64_stats_update_begin(&tx_stats->syncp);
> -			tx_stats->tso_inner_packets++;
> -			tx_stats->tso_inner_bytes += skb->len - ihs;
> -			u64_stats_update_end(&tx_stats->syncp);
> -		} else {
> -			if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
> -				ihs = skb_transport_offset(skb) + sizeof(struct udphdr);
> -			} else {
> -				ihs = skb_tcp_all_headers(skb);
> -			}
> -
> -			u64_stats_update_begin(&tx_stats->syncp);
> -			tx_stats->tso_packets++;
> -			tx_stats->tso_bytes += skb->len - ihs;
> -			u64_stats_update_end(&tx_stats->syncp);
> -		}
> -
>  	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
>  		csum_type = mana_checksum_info(skb);
>  
> @@ -294,11 +354,25 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  		} else {
>  			/* Can't do offload of this type of checksum */
>  			if (skb_checksum_help(skb))
> -				goto free_sgl_ptr;
> +				goto tx_drop_count;
>  		}
>  	}
>  
> -	if (mana_map_skb(skb, apc, &pkg)) {
> +	WARN_ON_ONCE(pkg.wqe_req.num_sge > MAX_TX_WQE_SGL_ENTRIES);
> +
> +	if (pkg.wqe_req.num_sge <= ARRAY_SIZE(pkg.sgl_array)) {
> +		pkg.wqe_req.sgl = pkg.sgl_array;
> +	} else {
> +		pkg.sgl_ptr = kmalloc_array(pkg.wqe_req.num_sge,
> +					    sizeof(struct gdma_sge),
> +					    GFP_ATOMIC);
> +		if (!pkg.sgl_ptr)
> +			goto tx_drop_count;
> +
> +		pkg.wqe_req.sgl = pkg.sgl_ptr;
> +	}
> +
> +	if (mana_map_skb(skb, apc, &pkg, gso_hs)) {
>  		u64_stats_update_begin(&tx_stats->syncp);
>  		tx_stats->mana_map_err++;
>  		u64_stats_update_end(&tx_stats->syncp);
> @@ -1256,11 +1330,16 @@ static void mana_unmap_skb(struct sk_buff *skb, struct mana_port_context *apc)
>  	struct mana_skb_head *ash = (struct mana_skb_head *)skb->head;
>  	struct gdma_context *gc = apc->ac->gdma_dev->gdma_context;
>  	struct device *dev = gc->dev;
> -	int i;
> +	int hsg, i;
> +
> +	/* Number of SGEs of linear part */
> +	hsg = (skb_is_gso(skb) && skb_headlen(skb) > ash->size[0]) ? 2 : 1;
>  
> -	dma_unmap_single(dev, ash->dma_handle[0], ash->size[0], DMA_TO_DEVICE);
> +	for (i = 0; i < hsg; i++)
> +		dma_unmap_single(dev, ash->dma_handle[i], ash->size[i],
> +				 DMA_TO_DEVICE);
>  
> -	for (i = 1; i < skb_shinfo(skb)->nr_frags + 1; i++)
> +	for (i = hsg; i < skb_shinfo(skb)->nr_frags + hsg; i++)
>  		dma_unmap_page(dev, ash->dma_handle[i], ash->size[i],
>  			       DMA_TO_DEVICE);
>  }
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 9f70b4332238..4d43adf18606 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -103,9 +103,10 @@ struct mana_txq {
>  
>  /* skb data and frags dma mappings */
>  struct mana_skb_head {
> -	dma_addr_t dma_handle[MAX_SKB_FRAGS + 1];
> +	/* GSO pkts may have 2 SGEs for the linear part*/
> +	dma_addr_t dma_handle[MAX_SKB_FRAGS + 2];
>  
> -	u32 size[MAX_SKB_FRAGS + 1];
> +	u32 size[MAX_SKB_FRAGS + 2];
>  };
>  
>  #define MANA_HEADROOM sizeof(struct mana_skb_head)
> -- 
> 2.25.1
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
