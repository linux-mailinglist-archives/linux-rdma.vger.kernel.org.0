Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A3E7B6633
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Oct 2023 12:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjJCKRv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Oct 2023 06:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjJCKRv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Oct 2023 06:17:51 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D74E893;
        Tue,  3 Oct 2023 03:17:48 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id 477DB20B74C0; Tue,  3 Oct 2023 03:17:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 477DB20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1696328268;
        bh=rPoWxArSPTX73zRYqxSh03l9OCqoYJW886p1zjn4TkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lgkAWGaEOC3pMX+wazaPs/M9R0m0veb/24KBGsMHsZ7MzKCfUocTtLXWo3JjVnqEE
         kSwh/5P+V5mJJNzFzbnpLFuZ7bB7k4I4CKfjiFnKj9g82mnXlm9xmFsUOCAmFZolOk
         OFVHYqeqwAlnttFBqL8TBEivQ8xLQuAmNYRFRz3E=
Date:   Tue, 3 Oct 2023 03:17:48 -0700
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
Subject: Re: [PATCH net,v2, 2/3] net: mana: Fix the tso_bytes calculation
Message-ID: <20231003101748.GA32191@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1696020147-14989-1-git-send-email-haiyangz@microsoft.com>
 <1696020147-14989-3-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696020147-14989-3-git-send-email-haiyangz@microsoft.com>
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

On Fri, Sep 29, 2023 at 01:42:26PM -0700, Haiyang Zhang wrote:
> sizeof(struct hop_jumbo_hdr) is not part of tso_bytes, so remove
> the subtraction from header size.
> 
> Cc: stable@vger.kernel.org
> Fixes: bd7fc6e1957c ("net: mana: Add new MANA VF performance counters for easier troubleshooting")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 5cdcf7561b38..86e724c3eb89 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -264,8 +264,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  				ihs = skb_transport_offset(skb) + sizeof(struct udphdr);
>  			} else {
>  				ihs = skb_tcp_all_headers(skb);
> -				if (ipv6_has_hopopt_jumbo(skb))
> -					ihs -= sizeof(struct hop_jumbo_hdr);
>  			}
>  
>  			u64_stats_update_begin(&tx_stats->syncp);
> -- 
> 2.25.1
Reviewed-by:Shradha Gupta <shradhagupta@linux.microsoft.com>
