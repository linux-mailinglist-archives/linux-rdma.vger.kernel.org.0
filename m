Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE25958468B
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jul 2022 21:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiG1TYo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jul 2022 15:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiG1TYo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jul 2022 15:24:44 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E706A9E4
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jul 2022 12:24:42 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id b21so1845439qte.12
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jul 2022 12:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=piiPSIBYGCZ0sy7sXIHzYl3IadNQiM71jxwspXEDs1U=;
        b=jD2NatUNFbzSphNp22ky+eZHhr1VJkGM9JskNld/MtfKoXD6GAsI6a27kJejhimF83
         ccLpzj/uPdSC9xnvuvN6SOgjQS/qtQk2nwDKuauYFCB5AFt9EFGO9ZL+yrFYec+dCDTs
         AGAOpdI81I3ejpwwPFRXrwLaVchpAU/9ln/gEVVaaA9r9MOUCCq1eYS2cyJ/dxEPJGcS
         qmLmNQgKsfz+Jc+/F7GWf31GYTun7G+IFMXTJaNAvcDcgn24oi5oZNr+6qUJWfx70F7D
         9nP3xSvHPanr2Xr4BXIAA7oLdkSgNqFw7BoBSAqh6yWz1piiQRkPg1vmkH1TVPnU57mm
         LsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=piiPSIBYGCZ0sy7sXIHzYl3IadNQiM71jxwspXEDs1U=;
        b=4AO6yMU7mNlW/UoQtsGeUHKCB/g0sOt8ByWw9glV9NaupQznyOFg58/G2f99qDAryA
         A1ZnpL2eYVXuUDZQM2hxSt8AB3QwYaalZzzzv1TZsOaOqK+SOfbX9pBxzwxNy9dSfeNe
         6abty0EXKmnED9AmWh0Ox9ZMaKuXK7KMYpe0XcUCoy4UO2FsniiDYCLTnOkCp1V3wyNX
         kcfTl4unHVuzrREZGUJlZpTMj0g8A9JE6UbRp4D9lMdtbh7infWM/94PhvO+u8OoZh4N
         jI8mxRaR9u2ZVd8mOheQ2PrbR2OuLgcc/xNGjdSe3RA5BPtqwxPCEblezdBGloIUCjdK
         M1BQ==
X-Gm-Message-State: AJIora+mnI2VI6tXUSL47iVUmgyqbnA/J4FWhXmyMBw7Anoqp6XPhxBP
        BaSaio5+KFhJY41LcpKXkTmPjJAjNyCZfQ==
X-Google-Smtp-Source: AGRyM1t3DootHdNnMs2Cn/fORNcHq3KLVp5kwZnxIrzn6FOHeQxcl/6vQxoKBx2U2pjetPK38kLeGA==
X-Received: by 2002:a05:622a:1ba5:b0:31f:55c:f033 with SMTP id bp37-20020a05622a1ba500b0031f055cf033mr464156qtb.300.1659036282046;
        Thu, 28 Jul 2022 12:24:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id i8-20020a05620a248800b006b5683ee311sm1169286qkn.100.2022.07.28.12.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 12:24:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oH97g-001Fjo-RT;
        Thu, 28 Jul 2022 16:24:40 -0300
Date:   Thu, 28 Jul 2022 16:24:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gerd Rausch <gerd.rausch@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 1/1] RDMA/addr: Refresh neighbour entries upon
 "rdma_resolve_addr"
Message-ID: <YuLieOUUrBcTB1in@ziepe.ca>
References: <60b4df0f7349570fe91b94eb8861043f0aba7cf2.camel@oracle.com>
 <20220624231134.GE23621@ziepe.ca>
 <101720e727de34c222ac34889b4a75ab6aec4e33.camel@oracle.com>
 <20220625001040.GH23621@ziepe.ca>
 <3a50586afd22c1872dfe3f8fbc22438f7cb82cca.camel@oracle.com>
 <94874f65fe9696ccd671625bdc6bfdc4cc496e30.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94874f65fe9696ccd671625bdc6bfdc4cc496e30.camel@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 28, 2022 at 10:55:39AM -0700, Gerd Rausch wrote:
> Hi Jason,
> 
> On Fri, 2022-06-24 at 17:55 -0700, Gerd Rausch wrote:
> > In other words, I don't see how the STALE case was covered, and I'd have
> > to guess wether the -ENODATA coupling was intentional or accidental.
> > 
> > Now it may be perfectly possible to just make the "neigh_event_send"
> > call above unconditional and call it a day.
> > 
> > I mean, simpler fixes always win over more complex ones.
> > 
> > But, I personally don't know the twists & turns of this code well enough
> > to be able to assert that this won't leave any non-covered conditional
> > corner cases. I certainly hadn't tested that.
> > 
> 
> I finally got around to trying the much simpler fix, and it appears to
> work just as well:
> 
> --------%<--------%<--------%<--------%<--------%<--------%<--------
> --- drivers/infiniband/core/addr.c-
> +++ drivers/infiniband/core/addr.c
> @@ -336,11 +336,11 @@ static int dst_fetch_ha(const struct dst
>  		return -ENODATA;
>  
>  	if (!(n->nud_state & NUD_VALID)) {
> -		neigh_event_send(n, NULL);
>  		ret = -ENODATA;
>  	} else {
>  		neigh_ha_snapshot(dev_addr->dst_dev_addr, n, dst->dev);
>  	}
> +	neigh_event_send(n, NULL);
>  
>  	neigh_release(n);
>  
> --------%<--------%<--------%<--------%<--------%<--------%<--------
> 
> Tested with IPv4 only, but this should work just as well with IPv6:
> 
> STALE neighbor entries transition to DELAY -> REACHABLE with this
> change, i.e. the entries get updated.

It seems OK, but I would still like to see an attempt to explain how
nud_state and neigh_event_send is supposed to be used.. Maybe futile,
but lets try at least.

Jason
