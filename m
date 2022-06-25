Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5DD55A53B
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jun 2022 02:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiFYAKp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jun 2022 20:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFYAKn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jun 2022 20:10:43 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C98EE
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jun 2022 17:10:43 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id cu16so6869015qvb.7
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jun 2022 17:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mh9kH2SCVCLw6AIgmqSmrtXoiWu/ExF+f+8+e+eJOTA=;
        b=DS367MPkfTju3trDhPQwHnAwlSA7q54glVtwzokkWoVaUDCoP2av5d5CiIiJ/Zkk72
         4pIipaxGdCGLW3TxbZb5kg509QEI6ZnBiPX8es2dWiKhkfDutVBoZqaiABIrgVZsHDJv
         r3S8Cr2Fr8P0TmDwpI4lwyzGP2/X2FZYuE6koU2G9jpInrhhOfP4GQQzMIubcp+xPR5n
         3xe7Qj9KW1X0Cejx0GByDkdQfOpuvNKGBQcHv4Q4HX+vPbMUSXyVLVKzVwJaXQEB7tP7
         UYENsm0uDzD14pN0hhUifa6IH19tfA09g9skvx7Be24h4WgjZI06DcYoYIkt+JxkeBjJ
         8qjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mh9kH2SCVCLw6AIgmqSmrtXoiWu/ExF+f+8+e+eJOTA=;
        b=El0NkaPzCOzKNudgg+mPvY660xJEmROcujdQOiI9klIYTSgMUM2O+CCmEeuPsnNLfg
         tuAlAAiFdU0ZsWV+bbaXyDWGegHgg2JYoz/jlykS1/A4BBqqfXJS7Sstfg0QpXTbT28a
         BgHq5YkGJJq+PuDtNhwLu+aOuMOnDRLgUsNgen1jPMDhiVCttirHTKwlJft3rKFYWnnt
         SidaiyInHM2adWT/48Peya1NucaHNvvnUudkop3F4rT4nOKXPagTuyi/qdf8jcHmCyXz
         1DmFqGzps4obbkPEBxYovUFp9iNHrVKVc3q4i5x3zz6deEc8FsOviFfzB7HGG5xasBlH
         E7Ww==
X-Gm-Message-State: AJIora+SBltbi1iiZYBsXYHw3H1uwrUr7U7Z08eBcUltaNYHRPU/ALv+
        HMzr8l+VaAwMgcpXNy1h81yJmEyfqlJfWQ==
X-Google-Smtp-Source: AGRyM1u8TRJ2ScnA4cOWqTEC5/iugdycGfPNnA0pidiJd1JLu5+5XzeaQYs0PGzYsKrbur2LjjHFlw==
X-Received: by 2002:ac8:59c3:0:b0:317:cd40:bda9 with SMTP id f3-20020ac859c3000000b00317cd40bda9mr1428308qtf.596.1656115842181;
        Fri, 24 Jun 2022 17:10:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a288d00b006a3325fd985sm3187235qkp.13.2022.06.24.17.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 17:10:41 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o4tNo-001IWo-V3; Fri, 24 Jun 2022 21:10:40 -0300
Date:   Fri, 24 Jun 2022 21:10:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gerd Rausch <gerd.rausch@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 1/1] RDMA/addr: Refresh neighbour entries upon
 "rdma_resolve_addr"
Message-ID: <20220625001040.GH23621@ziepe.ca>
References: <60b4df0f7349570fe91b94eb8861043f0aba7cf2.camel@oracle.com>
 <20220624231134.GE23621@ziepe.ca>
 <101720e727de34c222ac34889b4a75ab6aec4e33.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <101720e727de34c222ac34889b4a75ab6aec4e33.camel@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 24, 2022 at 05:03:23PM -0700, Gerd Rausch wrote:
> Hi Jason,
> 
> On Fri, 2022-06-24 at 20:11 -0300, Jason Gunthorpe wrote:
> > On Thu, Jun 16, 2022 at 08:57:14AM -0700, Gerd Rausch wrote:
> > > Unlike with IPv[46], where "ip_finish_output2" triggers
> > > a refresh of STALE neighbour entries via "neigh_output",
> > > "rdma_resolve_addr" never triggers an update.
> > 
> > Why? We alread call neigh_event_send() right after this in
> > addr_resolve_neigh(), and this seems to ignore the input resolve_neigh
> > to addr_resolve() ?
> > 
> 
> This in "dst_fetch_ha"?:
> --------%<--------%<--------%<--------%<--------%<--------
>         if (!(n->nud_state & NUD_VALID)) {
>                 neigh_event_send(n, NULL);
>                 ret = -ENODATA;
> --------%<--------%<--------%<--------%<--------%<--------
> 
> With:
> #define NUD_VALID	(NUD_PERMANENT|NUD_NOARP|NUD_REACHABLE|NUD_PROBE
> |NUD_STALE|NUD_DELAY)
> 
> and the knowledge that the ARP entry is NUD_STALE,
> how would that function be called and perform the necessary refresh?
> 
> 
> > I think there is more going on here than this commit message is
> > explaining.
> > 
> 
> If the intention of the above mentioned "neigh_event_send" was to
> refresh stale entries, then the "if" condition ought to change, no?

Maybe yes.

If you are saying with this patch that neigh_event_send() should be
called unconditionally for every 'packet' why not remove the test
above instead of calling it twice?

On the other hand I see many places checking for NUD_VALID before
calling it.

So, really the commit message needs to explain how neigh_event_send()
is supposed to be used and explain that NUD_VALID is OK to drop.

I'm having a hard time guessing from a quick look around.

Jason
