Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12D2B9B258
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2019 16:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395265AbfHWOmX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Aug 2019 10:42:23 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35646 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393140AbfHWOmX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Aug 2019 10:42:23 -0400
Received: by mail-qt1-f195.google.com with SMTP id u34so11433333qte.2
        for <linux-rdma@vger.kernel.org>; Fri, 23 Aug 2019 07:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PVclVyDvMuyvwCDjzjvdQ3z5dWrv3St0OJNsgcRBZ1g=;
        b=K/MGjeyoOlMfnKYuWbxmbMKTx2FerMDkhHKU92Sw34U1xXJVVSnQ17fUIFSXO1NF+Y
         whO17sxabfTE9uvS6vR4lDAzrwuzNAJ2ZqnKfzoUezBF67LNHuZ5ZUlychtRy2Fdtbj3
         tnHDZldyMga4GZv+DhsC2a+UZ+TLo4pXtvmnfQKzqIR8M2JnXsMUsLZPJM1fGoL7Kx1U
         dfwmJmfMcloOHkB7lCVAtqxD3Oa8ePQFfRROZ9RZXZww8oAC+DQz+NODAE71mOb3HQWR
         nZKAPe5OofvV2HKsL30E8u9+ziHnMapMbyob6ss0Jf2CqHQOYGPwhNsBEHaG8GTU7Lbb
         7DCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PVclVyDvMuyvwCDjzjvdQ3z5dWrv3St0OJNsgcRBZ1g=;
        b=Qa3R+OImWyn5AXOziWkZ/UdSRji9xz0rMyD8zx3JMN5qkP0e5BnO9XcrLt4srqvDIx
         CIg6gC4aBniKA7NwGJRp8I3MQG78t+KVxyb+3Kfo+6aT+GNUpMF2U/XgbmUeH2sRKZZ8
         N36M5MVE1vApkxEfjuz1Usxo/U6xhp0bGe0KdBKWZrE4U5K8ve6axQswc/wkWSWyKFOw
         JfrBEyyVSexwKaM/9krWSzl5O9Si9r9jddNihGMf6L/D9KErx4uVmgoIV52RMQKm4Fwl
         RlYiooYbr1SBypBfkKwdi7l8x74azFHJwFhegxrQvLc8i7iawwU2Io2OOM+x4zKy4XOT
         eDAw==
X-Gm-Message-State: APjAAAX1SquiOLF/GuWY0GUtQomGraeXoqeBlNyNcW1xLb73qvA1QmAI
        RdolxjNeiA4Dlg5/j17OOLKSKQ==
X-Google-Smtp-Source: APXvYqxrsgD3Kp/y67AUNwxI4Gd2jYCkOZlRniSAejZTj7RGE3WTn2IAzagWcgkf3ufvmepEr63TpA==
X-Received: by 2002:ad4:4021:: with SMTP id q1mr4198610qvp.36.1566571342107;
        Fri, 23 Aug 2019 07:42:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id n66sm1434683qkf.89.2019.08.23.07.42.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Aug 2019 07:42:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i1Alh-0007p2-7A; Fri, 23 Aug 2019 11:42:21 -0300
Date:   Fri, 23 Aug 2019 11:42:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        geert@linux-m68k.org
Subject: Re: [PATCH v3] RDMA/siw: Fix 64/32bit pointer inconsistency
Message-ID: <20190823144221.GF12968@ziepe.ca>
References: <0f280f83ded4ec624ab897f8a83b4ab1565f35cd.camel@redhat.com>
 <20190822173738.26817-1-bmt@zurich.ibm.com>
 <20190822184147.GO29433@mtr-leonro.mtl.com>
 <OF013F89F4.F7760460-ON0025845F.004F2CE0-0025845F.00500308@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF013F89F4.F7760460-ON0025845F.004F2CE0-0025845F.00500308@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 23, 2019 at 02:33:56PM +0000, Bernard Metzler wrote:
> >> > diff --git a/drivers/infiniband/sw/siw/siw_cm.c
> >> > b/drivers/infiniband/sw/siw/siw_cm.c
> >> > index 9ce8a1b925d2..ae7ea3ad7224 100644
> >> > +++ b/drivers/infiniband/sw/siw/siw_cm.c
> >> > @@ -355,8 +355,8 @@ static int siw_cm_upcall(struct siw_cep *cep,
> >> > enum iw_cm_event_type reason,
> >> >  		getname_local(cep->sock, &event.local_addr);
> >> >  		getname_peer(cep->sock, &event.remote_addr);
> >> >  	}
> >> > -	siw_dbg_cep(cep, "[QP %u]: id 0x%p, reason=%d, status=%d\n",
> >> > -		    cep->qp ? qp_id(cep->qp) : -1, id, reason, status);
> >> > +	siw_dbg_cep(cep, "[QP %u]: reason=%d, status=%d\n",
> >> > +		    cep->qp ? qp_id(cep->qp) : -1, reason, status);
> >>                                              ^^^^
> >> There is a chance that such construction (attempt to print -1 with
> >%u)
> >> will generate some sort of warning.
> >> 
> >> Thanks
> >
> >I didn't see any warnings when I built it.  And %u->-1 would be the
> >same
> >error on 64bit or 32bit, so I think we're safe here.
> >
> 
> Doug,
> May I ask you to amend this patch in a way which would
> just stop this monument of programming stupidity from
> prolonging into the future, while of course recognizing
> the impossibility of erasing it from the past?
> Exchanging the %u with %d would help me regaining
> some self-confidence ;)

A
  q?a:b

Expression has only a single type. There are some tricky rules on
this, but since gcc does not complain on the %u it means
'q?(u32):(int)' is a (u32) and the -1 is implicitly casted.

The better thing to write would have been U32_MAX instead of -1

Jason
