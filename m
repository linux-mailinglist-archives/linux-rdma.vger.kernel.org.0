Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F5C7B665B
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Oct 2023 12:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjJCK1h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Oct 2023 06:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjJCK1g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Oct 2023 06:27:36 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D1F393;
        Tue,  3 Oct 2023 03:27:33 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id F2B5520B74C0; Tue,  3 Oct 2023 03:27:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F2B5520B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1696328853;
        bh=aysThpHQGFMTeVdI+Rawde/DGhWbjbxle/zDNrgG3rw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QADkRjb0rLbTndCt5MDIufWKkV369E7NKRTSnPiPxX2Lc++TFqUBWabK/acTYpO4n
         Yz0xHi26ZXEeKlDcZd8NT7BskvSOp63eJInSkE4uMkFKejWDh5R/CmGmN8MrkLOiHz
         Mn8Usutan361mbSUx6mbRrRMNBj7Zr3l9c25e5Bs=
Date:   Tue, 3 Oct 2023 03:27:32 -0700
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
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net,v2, 1/3] net: mana: Fix TX CQE error handling
Message-ID: <20231003102732.GB32191@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1696020147-14989-1-git-send-email-haiyangz@microsoft.com>
 <1696020147-14989-2-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696020147-14989-2-git-send-email-haiyangz@microsoft.com>
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

On Fri, Sep 29, 2023 at 01:42:25PM -0700, Haiyang Zhang wrote:
> For an unknown TX CQE error type (probably from a newer hardware),
> still free the SKB, update the queue tail, etc., otherwise the
> accounting will be wrong.
> 
> Also, TX errors can be triggered by injecting corrupted packets, so
> replace the WARN_ONCE to ratelimited error logging.
> 
> Cc: stable@vger.kernel.org
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 4a16ebff3d1d..5cdcf7561b38 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1317,19 +1317,23 @@ static void mana_poll_tx_cq(struct mana_cq *cq)
>  		case CQE_TX_VPORT_IDX_OUT_OF_RANGE:
>  		case CQE_TX_VPORT_DISABLED:
>  		case CQE_TX_VLAN_TAGGING_VIOLATION:
> -			WARN_ONCE(1, "TX: CQE error %d: ignored.\n",
> -				  cqe_oob->cqe_hdr.cqe_type);
> +			if (net_ratelimit())
> +				netdev_err(ndev, "TX: CQE error %d\n",
> +					   cqe_oob->cqe_hdr.cqe_type);
> +
>  			apc->eth_stats.tx_cqe_err++;
>  			break;
>  
>  		default:
> -			/* If the CQE type is unexpected, log an error, assert,
> -			 * and go through the error path.
> +			/* If the CQE type is unknown, log an error,
> +			 * and still free the SKB, update tail, etc.
>  			 */
> -			WARN_ONCE(1, "TX: Unexpected CQE type %d: HW BUG?\n",
> -				  cqe_oob->cqe_hdr.cqe_type);
> +			if (net_ratelimit())
> +				netdev_err(ndev, "TX: unknown CQE type %d\n",
> +					   cqe_oob->cqe_hdr.cqe_type);
> +
>  			apc->eth_stats.tx_cqe_unknown_type++;
> -			return;
> +			break;
>  		}
>  
>  		if (WARN_ON_ONCE(txq->gdma_txq_id != completions[i].wq_num))
> -- 
> 2.25.1
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
