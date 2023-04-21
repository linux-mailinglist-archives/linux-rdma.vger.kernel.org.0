Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0108B6EAD65
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Apr 2023 16:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjDUOsb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Apr 2023 10:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjDUOsa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Apr 2023 10:48:30 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A458A4E
        for <linux-rdma@vger.kernel.org>; Fri, 21 Apr 2023 07:48:27 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-443bd60988eso1153940e0c.1
        for <linux-rdma@vger.kernel.org>; Fri, 21 Apr 2023 07:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1682088507; x=1684680507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Busr6qm7YT9dN2ZoieQ5VIQ2S/28WbEFVkn48a2KA8A=;
        b=QdsJFWqkcF0ZtKO9jcW7I4RAGIGlnqC5MEBmMfRxAj6d/mKnqKSSs+6ydhZwJE7VQv
         ZtASd9KTF6spRs+vIL8fioiquCfYnId2GSzaOiVbakwkFcbPSQHOhSoDQ0nDBqrSE3Oj
         NhIVXLHP6NkPcUCPklRhscqsTV41J25q7+q8BV2gu/GHjCMD3W3hqa6bZ0uIeP8m7OnY
         o0+RRzv+mm++/UiCMuoB3chWznPkS3p4+4cxhUS/ZXTT1+HddVV5UdV8L0c0wmetF9xm
         uS5tUY8T3jf6J3wAcF3+fXc48OHibwSWuGGqhW7GIJzqUpoVICpoFvn/54i9JP0aK38s
         2ckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682088507; x=1684680507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Busr6qm7YT9dN2ZoieQ5VIQ2S/28WbEFVkn48a2KA8A=;
        b=VmFeYsceCg+q3O1zuzoJdOmfTDyuj4i00oWj1Aw7KlSAPyHF0CciS/CnpvlkYD3i5N
         WOH1zNh5YarsM9TnCTDpESxKyWe/yXIFwM+ne+I8QJhZ7OKhIXZLnfeZruT2AerRoac1
         ey562j8LfKdh9+xjQNv9niyPXK6umor5lp8IE651LZN7QcRiMt8LPhBvClaDnHZTrDs6
         iOw0G0ePax3Hr8q9NqgVDpfH3fzBDiDJ8LwkE+VW/9QJjRjbV8YTu7TWDv67TuZH+rqS
         PavR0FsKm04R6xwPeht5S8yPZ9TUS10HN8W4d0CrkcjmLnv6tFhL9lxbHgtac8VPzyCn
         KXPw==
X-Gm-Message-State: AAQBX9cz5fG9kMXk/Dp+PMk/hWYsxY8Tf+rz3EM+U127MOR1Wu25z5sZ
        BQ7kfe9v2kBCjt9Bv7humPR69MNZzD+uFE/fIi0=
X-Google-Smtp-Source: AKy350a/G30TMDV5Uf+o4p5lUbnx+Idhuvq2ocYacNFl+/hgBUWciCE1IHftL8Pe4wxOBdERyOv7qg==
X-Received: by 2002:ad4:5f4a:0:b0:5f3:deca:ee3 with SMTP id p10-20020ad45f4a000000b005f3deca0ee3mr10989073qvg.17.1682087965516;
        Fri, 21 Apr 2023 07:39:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id u16-20020a0cf1d0000000b005ef42464646sm1204996qvl.118.2023.04.21.07.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 07:39:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pprv2-000k1o-1f;
        Fri, 21 Apr 2023 11:39:24 -0300
Date:   Fri, 21 Apr 2023 11:39:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     Tejun Heo <tj@kernel.org>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] RDMA/irdma: Drop spurious WQ_UNBOUND from
 alloc_ordered_workqueue() call
Message-ID: <ZEKgHNlykqw7LmKm@ziepe.ca>
References: <ZEGW-IcFReR1juVM@slm.duckdns.org>
 <MWHPR11MB0029F5F9C9AC249F2BC3E981E9609@MWHPR11MB0029.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB0029F5F9C9AC249F2BC3E981E9609@MWHPR11MB0029.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 21, 2023 at 02:29:06PM +0000, Saleem, Shiraz wrote:
> > Subject: [PATCH] RDMA/irdma: Drop spurious WQ_UNBOUND from
> > alloc_ordered_workqueue() call
> > 
> > Workqueue is in the process of cleaning up the distinction between unbound
> > workqueues w/ @nr_active==1 and ordered workqueues. Explicit
> > WQ_UNBOUND isn't needed for alloc_ordered_workqueue() and will trigger a
> > warning in the future. Let's remove it. This doesn't cause any functional
> > changes.
> > 
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > ---
> >  drivers/infiniband/hw/irdma/hw.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > --- a/drivers/infiniband/hw/irdma/hw.c
> > +++ b/drivers/infiniband/hw/irdma/hw.c
> > @@ -1901,8 +1901,8 @@ int irdma_ctrl_init_hw(struct irdma_pci_
> >  			break;
> >  		rf->init_state = CEQ0_CREATED;
> >  		/* Handles processing of CQP completions */
> > -		rf->cqp_cmpl_wq = alloc_ordered_workqueue("cqp_cmpl_wq",
> > -						WQ_HIGHPRI |
> > WQ_UNBOUND);
> > +		rf->cqp_cmpl_wq =
> > +			alloc_ordered_workqueue("cqp_cmpl_wq",
> > WQ_HIGHPRI);
> >  		if (!rf->cqp_cmpl_wq) {
> >  			status = -ENOMEM;
> >  			break;
> 
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>

Tejun, do you want this in your tree too?

Thanks
Jason
