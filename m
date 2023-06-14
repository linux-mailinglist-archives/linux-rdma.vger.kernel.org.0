Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7E2722797
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jun 2023 15:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjFENfp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 09:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjFENfY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 09:35:24 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8991BF
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 06:35:12 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53f7bef98b7so4209549a12.3
        for <linux-rdma@vger.kernel.org>; Mon, 05 Jun 2023 06:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1685972112; x=1688564112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ9YEyXdfxIriIIMHnODtjK+/Crk0/ld21e+qZyv40A=;
        b=VE6r3tEprgGUx8SgCYBffVRP6JbbmmcR1q4fZ1wh65I1j670EdBOJuyO8FMOOBPKzD
         cS/hXdmzEeapUS8lJ4FKhXMfehxhGTyrs0DvNC21eiN/nmHmdt7l1BnkND1tZ/KvrAND
         VDoFSCYdS93O05omPwPnnKXB79tI3L14iFurQmVEvrSkPtX2mjkqNlVCF7IBB+Y2a7qN
         DCaUe2rg7iJG/aomwW5JKLznTwG7VPGl9ddzas+jt0/K7RvgT9DtHL08jtHy6mAE9ZQa
         OBPf2db661cjg0p8hzt/PHtU5HfeJrfW44SaxDwfMMU0JKGZ1ajJMM2DToOk1CqwMjy1
         DKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685972112; x=1688564112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQ9YEyXdfxIriIIMHnODtjK+/Crk0/ld21e+qZyv40A=;
        b=DCFH9s6wA7VrnJI0Wtx2kxUWf8wieyb4sfKocpXKTINTWrrExopDS24BkE2mVSf4UL
         ulRnmdocvGOS01GvCJDqHn3T+175kICGV/Xo1TzA0rvBbyjQx+6QK9YRt/LCosms0Dii
         DTQzfzObY40apa+R60OxpXe8fbEEpp2rwsrSfplsVKE93dGQpTmDsJvqNERjEwPrwAZS
         VyNxyajmgMgqIXrE6ijTO0qOHwFFBtY1uxZqj555K8w9HwpQERoedASPHxa8x6JUoViM
         NiSs8G/nC07iocLsB1FFAitGIUtHAefPEI78at9BGOwJ7GLSGpK4g7XGKjiqAPdp5qeT
         exEQ==
X-Gm-Message-State: AC+VfDwTQrbLGOfN6AW94OE6L0nPEQXOngOpOs0zpLGsmtX6vShmcBWz
        rV+D4CTc2ukKXX+GPBz2xSAGug==
X-Google-Smtp-Source: ACHHUZ7lcwTCBonG3pbLMxNGCQHIgpAzINF4LZqWdbfmP30nhlcE4dHT0tzD3NPMXEHIGqvx92Uqng==
X-Received: by 2002:a17:902:f7cc:b0:1af:beae:c0b with SMTP id h12-20020a170902f7cc00b001afbeae0c0bmr6415399plw.22.1685972111898;
        Mon, 05 Jun 2023 06:35:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902eac500b001b03a1a3151sm6643287pld.70.2023.06.05.06.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 06:35:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q6AMX-002mN1-DO;
        Mon, 05 Jun 2023 10:35:09 -0300
Date:   Mon, 5 Jun 2023 10:35:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Wei Hu <weh@microsoft.com>, netdev@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
        longli@microsoft.com, sharmaajay@microsoft.com, leon@kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, vkuznets@redhat.com,
        ssengar@linux.microsoft.com, shradhagupta@linux.microsoft.com
Subject: Re: [PATCH 1/1] RDMA/mana_ib: Add EQ interrupt support to mana ib
 driver.
Message-ID: <ZH3kjU7a2L7EkEQ2@ziepe.ca>
References: <20230605114313.1640883-1-weh@microsoft.com>
 <ZH3f2abyRU1l/dq6@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH3f2abyRU1l/dq6@corigine.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 05, 2023 at 03:15:05PM +0200, Simon Horman wrote:
> On Mon, Jun 05, 2023 at 11:43:13AM +0000, Wei Hu wrote:
> > Add EQ interrupt support for mana ib driver. Allocate EQs per ucontext
> > to receive interrupt. Attach EQ when CQ is created. Call CQ interrupt
> > handler when completion interrupt happens. EQs are destroyed when
> > ucontext is deallocated.
> > 
> > The change calls some public APIs in mana ethernet driver to
> > allocate EQs and other resources. Ehe EQ process routine is also shared
> > by mana ethernet and mana ib drivers.
> > 
> > Co-developed-by: Ajay Sharma <sharmaajay@microsoft.com>
> > Signed-off-by: Ajay Sharma <sharmaajay@microsoft.com>
> > Signed-off-by: Wei Hu <weh@microsoft.com>
> 
> ...
> 
> > @@ -368,6 +420,24 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
> >  	qp->sq_id = wq_spec.queue_index;
> >  	send_cq->id = cq_spec.queue_index;
> >  
> > +	if (gd->gdma_context->cq_table[send_cq->id] == NULL) {
> > +
> > +		gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
> > +		if (!gdma_cq) {
> > +			pr_err("failed to allocate gdma_cq\n");
> 
> Hi wei Hu,
> 
> I think 'err = -ENOMEM' is needed here.

And no prints like that in drivers.

Jason
