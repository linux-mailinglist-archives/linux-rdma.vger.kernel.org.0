Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC12573063E
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jun 2023 19:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjFNRqJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Jun 2023 13:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbjFNRqI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Jun 2023 13:46:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74621BF0
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jun 2023 10:46:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E2CE640A6
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jun 2023 17:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48B9C433C8;
        Wed, 14 Jun 2023 17:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686764766;
        bh=5wkgv8tPp6pcWRSjESKf+awe3ziEHv9EgVGR5zQmIpM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tzfh2SEOrk6Jvkglq5+qNYdbI0BEuxpdJliWyFAvHQAWOz5oiY7NFUWeZEH+YfsOR
         IsMLeCoNcWgYvWQC4xcuA1P5uNTmRp3CM3oiuW1cZtBHi20euPUZYcTu2cyfLHSNDF
         81BSDk6Y7hnCVVAnfTa45Ji+mv4VK4XkDO+LbJnhBaGtwfYIt/cRsCd3FCBNbfvcxx
         7DfDefHdNUYshvFALBNeKHVOEOoOmrNsehgr2P6QgG5jKou8ofziyeVndMy5xheUUe
         lgp9n8yantfcHNXF2zzdLMXs3djRaTHVIvgR+RZnd7VSCqDCwjm4BXoTbtlK8PXVg3
         Eumf5t04lySOA==
Date:   Wed, 14 Jun 2023 10:46:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Maxim Mikityanskiy <maxtram95@gmail.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, j.vosburgh@gmail.com, andy@greyhouse.net,
        rajur@chelsio.com, ayush.sawal@chelsio.com, dmichail@fungible.com,
        borisp@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
        simon.horman@corigine.com, john.fastabend@gmail.com,
        anirudh.venkataramanan@intel.com, tariqt@nvidia.com,
        gal@nvidia.com, raeds@nvidia.com, liorna@nvidia.com,
        louis.peens@corigine.com, yinjun.zhang@corigine.com,
        na.wang@corigine.com, linux-rdma@vger.kernel.org,
        oss-drivers@corigine.com
Subject: Re: [PATCH net-next] net: tls: make the offload check helper take
 skb not socket
Message-ID: <20230614104605.2f9b205f@kernel.org>
In-Reply-To: <ZIlng6G_xP3V8O5E@mail.gmail.com>
References: <20230613205006.1995873-1-kuba@kernel.org>
        <ZIlng6G_xP3V8O5E@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 14 Jun 2023 10:09:02 +0300 Maxim Mikityanskiy wrote:
> On Tue, 13 Jun 2023 at 13:50:06 -0700, Jakub Kicinski wrote:
> > All callers of tls_is_sk_tx_device_offloaded() currently do
> > an equivalent of:
> > 
> >  if (skb->sk && tls_is_skb_tx_device_offloaded(skb->sk))
> > 
> > Have the helper accept skb and do the skb->sk check locally.
> > Two drivers have local static inlines with similar wrappers
> > already.
> > 
> > While at it change the ifdef condition to TLS_DEVICE.
> > Only TLS_DEVICE selects SOCK_VALIDATE_XMIT, so the two are
> > equivalent. This makes removing the duplicated IS_ENABLED()
> > check in funeth more obviously correct.
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> 
> Acked-by: Maxim Mikityanskiy <maxtram95@gmail.com>

Thanks!

> > diff --git a/include/net/tls.h b/include/net/tls.h
> > index b7d0f1e3058b..5e71dd3df8ca 100644
> > --- a/include/net/tls.h
> > +++ b/include/net/tls.h
> > @@ -370,10 +370,12 @@ struct sk_buff *
> >  tls_validate_xmit_skb_sw(struct sock *sk, struct net_device *dev,
> >  			 struct sk_buff *skb);
> >  
> > -static inline bool tls_is_sk_tx_device_offloaded(struct sock *sk)
> > +static inline bool tls_is_skb_tx_device_offloaded(const struct sk_buff *skb)
> >  {
> > -#ifdef CONFIG_SOCK_VALIDATE_XMIT
> > -	return sk_fullsock(sk) &&
> > +#ifdef CONFIG_TLS_DEVICE
> > +	struct sock *sk = skb->sk;
> > +
> > +	return sk && sk_fullsock(sk) &&
> >  	       (smp_load_acquire(&sk->sk_validate_xmit_skb) ==
> >  	       &tls_validate_xmit_skb);
> >  #else  
> 
> After this change, the only usage of CONFIG_SOCK_VALIDATE_XMIT remains
> in sk_validate_xmit_skb, which has #ifdef CONFIG_TLS_DEVICE inside
> #ifdef CONFIG_SOCK_VALIDATE_XMIT. If feels a little bit weird, given
> that both defines always have the same value, but maybe it's OK if we
> consider that more users can start using sk_validate_xmit_skb in the
> future.

I'm working on another user of CONFIG_SOCK_VALIDATE_XMIT
so let's keep the two separate.
