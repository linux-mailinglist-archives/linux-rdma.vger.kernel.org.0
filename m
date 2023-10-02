Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239D47B5C60
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Oct 2023 23:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjJBVIq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Oct 2023 17:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjJBVIp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Oct 2023 17:08:45 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34340AD
        for <linux-rdma@vger.kernel.org>; Mon,  2 Oct 2023 14:08:43 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-81ZDJZC5NGOH4LIxnAQpBQ-1; Mon, 02 Oct 2023 17:08:21 -0400
X-MC-Unique: 81ZDJZC5NGOH4LIxnAQpBQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 776A3811621;
        Mon,  2 Oct 2023 21:08:20 +0000 (UTC)
Received: from hog (unknown [10.45.224.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 521022156A27;
        Mon,  2 Oct 2023 21:08:16 +0000 (UTC)
Date:   Mon, 2 Oct 2023 23:08:14 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, borisp@nvidia.com,
        saeedm@nvidia.com, leon@kernel.org, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com, sebastian.tobuschat@oss.nxp.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v6 08/10] net: phy: nxp-c45-tja11xx: add MACsec
 support
Message-ID: <ZRsxPvGXJAbgkzYL@hog>
References: <20230928084430.1882670-1-radu-nicolae.pirea@oss.nxp.com>
 <20230928084430.1882670-9-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230928084430.1882670-9-radu-nicolae.pirea@oss.nxp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

2023-09-28, 11:44:28 +0300, Radu Pirea (NXP OSS) wrote:
> +static int nxp_c45_mdo_upd_secy(struct macsec_context *ctx)
> +{
> +	u8 encoding_sa = ctx->secy->tx_sc.encoding_sa;
> +	struct phy_device *phydev = ctx->phydev;
> +	struct nxp_c45_phy *priv = phydev->priv;
> +	struct nxp_c45_secy *phy_secy;
> +	struct nxp_c45_sa next_sa;
> +	bool can_rx_sc0_impl;
> +
> +	phydev_dbg(phydev, "update SecY SCI %016llx\n",
> +		   sci_to_cpu(ctx->secy->sci));
> +
> +	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
> +	if (IS_ERR(phy_secy))
> +		return PTR_ERR(phy_secy);
> +
> +	if (!nxp_c45_mac_addr_free(ctx))
> +		return -EBUSY;

mdo_upd_secy gets called from macsec_set_mac_address, but the error is ignored:

	static int macsec_set_mac_address(struct net_device *dev, void *p)
	{
	[...]
		/* If h/w offloading is available, propagate to the device */
		if (macsec_is_offloaded(macsec)) {
			const struct macsec_ops *ops;
			struct macsec_context ctx;
	
			ops = macsec_get_ops(macsec, &ctx);
			if (ops) {
				ctx.secy = &macsec->secy;
				macsec_offload(ops->mdo_upd_secy, &ctx);
			}
		}
	
		return 0;
	}


Should macsec_set_mac_address try to roll back the change when
mdo_upd_secy fails? Otherwise I guess your device doesn't work.


> +static int nxp_c45_mdo_add_txsa(struct macsec_context *ctx)
> +{
...
> +	nxp_c45_select_secy(phydev, phy_secy->secy_id);
> +	nxp_c45_sa_set_pn(phydev, sa, tx_sa->next_pn, 0);
> +	nxp_c45_sa_set_key(ctx, sa->regs, tx_sa->key.salt.bytes, tx_sa->ssci);
> +	if (ctx->secy->tx_sc.encoding_sa  == sa->an)

nit: double ' ' before '==' (also in nxp_c45_mdo_del_txsa)

-- 
Sabrina

