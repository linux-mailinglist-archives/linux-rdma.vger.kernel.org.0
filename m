Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E5F4B199A
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Feb 2022 00:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345734AbiBJXgZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Feb 2022 18:36:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345509AbiBJXgY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Feb 2022 18:36:24 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF69B5F67
        for <linux-rdma@vger.kernel.org>; Thu, 10 Feb 2022 15:36:24 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id x5so7203452qtw.10
        for <linux-rdma@vger.kernel.org>; Thu, 10 Feb 2022 15:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jdc4wttGNx0+uj82g/3cbdbffgxGg6KC2LBxBSLJrgk=;
        b=jRX3EwsKEqLkj5t34Wyy1HXC4YVS1isnrMPVqBC4ixn+0oP2qBipNkgdmlqMVQdT43
         oFKqw7xgqwe9R5L+D7Ssebx1WwzV+x8fcYnrfPNRQioWbF0pVBgIF77MXw72CXw/rBh1
         R03crznZCerFV0VRfsmmSiS0yCBzJbc+1KBCvbYjswrpa2MUDRIufenGKegLtzpUQKOK
         fRuy688UtSf/WYawQ7B98TF8bl4BJHLH3h8PeLmYGlSYA5texJ3n2QbtdG/5nMz5A4sD
         OM6UqY7H9vdsmD/ZtvC73tTJQdCur07s8k4MJdY89xPuA0BhEsqeyrleqRcU8ll1DQCF
         yalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jdc4wttGNx0+uj82g/3cbdbffgxGg6KC2LBxBSLJrgk=;
        b=iHPvqkotIFvNht314OHIK1U9pur77u68mPXJRSUMwXEUoyyiGiWfKbPN5kzr8wizgF
         Zh1ldly1psts/jhjFGswqyP3a3CS6Bkg1byZQgmMgxGIClqIq1OuGCPlTpRVHGKg49nE
         cIU+wA28uSq8j+vdwhGQdAMqvuOuh1dfZK1i4VL4CMJZLOSzzQzixvCSa3STAK/2dTas
         qmCeZtncvosY1V0jNYR1/EczdPg5G3E3kgR3xjWdY5Fgo40FZvKF+TJvRuebSXKhSyNX
         SpoaPijVBWsH8J+iElPWNaaLcZIfnzPLteZrmH0Ao4CAh57J8FgmUscAocPvD60qyYzP
         1UEg==
X-Gm-Message-State: AOAM531ycxH1XAYlVKuPU4LuyQvJdWfKTIM+4bsQfp7QHMAvA7ykRwY4
        CX3VMs+32ncX40rRKZOzm0ezIA==
X-Google-Smtp-Source: ABdhPJzQIa5zPQh2XXzG457f36+iK0e3IhFV7shWUsXDsYa/H80qoTgj6GDIRkxYp7seatNxPqPccQ==
X-Received: by 2002:ac8:588f:: with SMTP id t15mr6728007qta.580.1644536184070;
        Thu, 10 Feb 2022 15:36:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id j15sm9497370qkp.88.2022.02.10.15.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:36:23 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nIIz8-0021OD-JG; Thu, 10 Feb 2022 19:36:22 -0400
Date:   Thu, 10 Feb 2022 19:36:22 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     Victor Erminpour <victor.erminpour@oracle.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trivial@kernel.org" <trivial@kernel.org>
Subject: Re: [PATCH] RDMA/irdma: Fix GCC 12 warning
Message-ID: <20220210233622.GK49147@ziepe.ca>
References: <1644453235-1437-1-git-send-email-victor.erminpour@oracle.com>
 <35240f17968242409a39427c303370df@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35240f17968242409a39427c303370df@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 10, 2022 at 10:09:18PM +0000, Saleem, Shiraz wrote:
> > Subject: [PATCH] RDMA/irdma: Fix GCC 12 warning
> > 
> > When building with automatic stack variable initialization, GCC 12 complains about
> > variables defined outside of switch case statements.
> > Move the variable into the case that uses it, which silences the warning:
> > 
> > ./drivers/infiniband/hw/irdma/hw.c:270:47: error: statement will never be executed [-
> > Werror=switch-unreachable]
> >   270 |                         struct irdma_cm_node *cm_node;
> >       |
> > 
> > ./drivers/infiniband/hw/irdma/utils.c:1215:50: error: statement will never be executed
> > [-Werror=switch-unreachable]
> >   1215 |                         struct irdma_gen_ae_info ae_info;
> >        |
> > 
> > Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
> >  drivers/infiniband/hw/irdma/hw.c    | 2 +-
> >  drivers/infiniband/hw/irdma/utils.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
> > index 89234d04cc65..a41a3b128d0d 100644
> > +++ b/drivers/infiniband/hw/irdma/hw.c
> > @@ -267,8 +267,8 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
> >  		}
> > 
> >  		switch (info->ae_id) {
> > -			struct irdma_cm_node *cm_node;
> >  		case IRDMA_AE_LLP_CONNECTION_ESTABLISHED:
> > +			struct irdma_cm_node *cm_node;
> >  			cm_node = iwqp->cm_node;
> >  			if (cm_node->accept_pend) {
> >  				atomic_dec(&cm_node->listener-
> 
> This doesn't compile.
> 
> drivers/infiniband/hw/irdma/hw.c: In function \u2018irdma_process_aeq\u2019:
> drivers/infiniband/hw/irdma/hw.c:271:4: error: a label can only be part of a statement and a declaration is not a statement
>   271 |    struct irdma_cm_node *cm_node;
> 
> Seems like we are accommodating for gcc12 bug since this C code is
> legit?

It might be legit, but it is nutzo and not our coding style.

If the variable is used by many branches it should be declared at the
top of the function.

If it is used in one branch it should be as above, with the missing {}
added.

Jason
