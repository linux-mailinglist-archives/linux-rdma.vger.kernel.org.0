Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324156EAD51
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Apr 2023 16:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjDUOnd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Apr 2023 10:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjDUOnR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Apr 2023 10:43:17 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F011446D;
        Fri, 21 Apr 2023 07:42:50 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b733fd00bso1965021b3a.0;
        Fri, 21 Apr 2023 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682088121; x=1684680121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A77N0RoQju0/+WBmbiYrDl9vGswgrIXZW0NW2bQRQcY=;
        b=EuI9Ezxqbz2cDGEmyUiWu4U5AjOatkeSkb9piDGzZLt9HE396LAHKTgtLlr7l6wki9
         7VRqNyLKpu9JepX7OV3pIUblo9k7Dy6e51Aw8/vr1dqwqO4WVIlpH+L6ytnJ8b0dgzuJ
         wXudwvtnRpnMcAuN7Q7wSgWtTZyvrm3PKMWQtg1X+MDzSAXAfLhrrf2oES+pa9RAiYfG
         ggwWX8rvnuNhkyPD2SSkqUiKhLFQU+uoISx1++a31Ez+nrlrhjsqYFJ/7FvWBmYP3+Bl
         /fSpytHZ3fUBoyCxbHiZxyECSUVIRDWAYAFIEGc3hO2pRBUtzK2z5M4HT8/SxRaxxVQp
         DIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682088121; x=1684680121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A77N0RoQju0/+WBmbiYrDl9vGswgrIXZW0NW2bQRQcY=;
        b=KYlKMEidx77BJs+wVBA8yYy1j7Dc8cTRSeN1hCcwgNpTeefhr/PtBxnnjDMedDiFW0
         JvPAsyQlhmimDLrwu4OEvJNf5SzyJTZdjkS5IDvnzIvHUrp0Xv4CtWabjwA7CqHT7znT
         56NbIWpSDLPmreN5aoqyOurpW+17MYy5bnm0Q0TcNBe7It6aEtsSiTRbrKw6h6DEaO7H
         Djf2CoJs2bmW9AlgG9kCd9yi/o3ppE55Gj/be9/sSbJAo+CdDX6T7TJo6LKKRFm50hx7
         hBMsRMiv04H/yij6jIF+Y51mvmV1rqfyVsOalxxH1HR+usCI4AZS+IFxYrjONlffzu+t
         6hcQ==
X-Gm-Message-State: AAQBX9e3zPpQ5hKoNgrNxqQfctBhnk4WEEhncA3cLj4yI46RMKWJy6CD
        cNpZCthqvlwc8G5ckWTwZ4I=
X-Google-Smtp-Source: AKy350aiNN3o64moz/Be6GjsiYzFMxsPgfZDCO3H4dtjDs3rjnfhsml0eUV+gi9fnJf4SwsQ+PnDkA==
X-Received: by 2002:a05:6a00:2da4:b0:623:5880:98cd with SMTP id fb36-20020a056a002da400b00623588098cdmr7311455pfb.5.1682088120459;
        Fri, 21 Apr 2023 07:42:00 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id a22-20020a056a000c9600b00628e9871c24sm3083776pfv.183.2023.04.21.07.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 07:42:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 21 Apr 2023 04:41:58 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] RDMA/irdma: Drop spurious WQ_UNBOUND from
 alloc_ordered_workqueue() call
Message-ID: <ZEKgtoJaozAHFjV1@slm.duckdns.org>
References: <ZEGW-IcFReR1juVM@slm.duckdns.org>
 <MWHPR11MB0029F5F9C9AC249F2BC3E981E9609@MWHPR11MB0029.namprd11.prod.outlook.com>
 <ZEKgHNlykqw7LmKm@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEKgHNlykqw7LmKm@ziepe.ca>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

On Fri, Apr 21, 2023 at 11:39:24AM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 21, 2023 at 02:29:06PM +0000, Saleem, Shiraz wrote:
> > > Subject: [PATCH] RDMA/irdma: Drop spurious WQ_UNBOUND from
> > > alloc_ordered_workqueue() call
> > > 
> > > Workqueue is in the process of cleaning up the distinction between unbound
> > > workqueues w/ @nr_active==1 and ordered workqueues. Explicit
> > > WQ_UNBOUND isn't needed for alloc_ordered_workqueue() and will trigger a
> > > warning in the future. Let's remove it. This doesn't cause any functional
> > > changes.
> > > 
> > > Signed-off-by: Tejun Heo <tj@kernel.org>
> > > ---
> > >  drivers/infiniband/hw/irdma/hw.c |    4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > --- a/drivers/infiniband/hw/irdma/hw.c
> > > +++ b/drivers/infiniband/hw/irdma/hw.c
> > > @@ -1901,8 +1901,8 @@ int irdma_ctrl_init_hw(struct irdma_pci_
> > >  			break;
> > >  		rf->init_state = CEQ0_CREATED;
> > >  		/* Handles processing of CQP completions */
> > > -		rf->cqp_cmpl_wq = alloc_ordered_workqueue("cqp_cmpl_wq",
> > > -						WQ_HIGHPRI |
> > > WQ_UNBOUND);
> > > +		rf->cqp_cmpl_wq =
> > > +			alloc_ordered_workqueue("cqp_cmpl_wq",
> > > WQ_HIGHPRI);
> > >  		if (!rf->cqp_cmpl_wq) {
> > >  			status = -ENOMEM;
> > >  			break;
> > 
> > Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
> 
> Tejun, do you want this in your tree too?

This one doesn't create any dependency and can go through any tree. So, I
guess routing through RDMA is better?

Thanks.

-- 
tejun
