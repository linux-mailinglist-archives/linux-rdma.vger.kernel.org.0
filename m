Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0812153D4
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 10:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgGFIQN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 04:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgGFIQN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 04:16:13 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5A1C061794
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jul 2020 01:16:13 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l17so38263640wmj.0
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jul 2020 01:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AEKKvRBK7FroNmPa19mpt0kjxJgUwlLuPIn+AJFHt/4=;
        b=n7ECp31bUAN2VzVaSt83Z2qn25X9416g7HVCAeurZDPagKabSUdRPgkeFzSSMvAI/m
         LY5vz5/XSJ3H5mk4TXKTN7Cy4SXIOAtj+iwe4HcdPs9FBOlfgdX4iCbrcQ5FaxlEds/V
         FwtBvhDjvo6dWLnM8xde9FIbXjR+qpgM7ZDGiUqNFCGGVtKtEq2QmwxOVDrMO0GGP7Au
         5d6rNbzvNBSoww8/kU0WhEUA+kDWliCYEVtbnPrIsokVNheU9ZNUBoQXFtv8zEKgSc/n
         vnWk3EVrQV5Cha3SVIkVIn1ncXnlAViWqarm2LK3FDK+9az1JUKeUQXkP0bNlWoxAAsE
         NT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AEKKvRBK7FroNmPa19mpt0kjxJgUwlLuPIn+AJFHt/4=;
        b=ob1AIJ+h39HhEAYsRAyB5QEv7n6eFUUELh2yefH8jJT1iTtoxMNeUZcpoNjI3bTpAx
         t1TBstVOF+2JKqdwkrYPITeQzHd0nvBMcKtDLsCcxEDlvg/IEAzeBK0Q3NMmE4Mh9TvB
         xwimQZIPmYAivo64Y3+BqzhzZP+SDTKKntaw61Gv0h8ppgDDgT2YDgUwMncgJWJMyGZx
         3KiYaIz7LN7OYdipjUunY2SrttbMkf+neGzgyG6Mar88wmkANvHFYM1TvVaVGBJa+jin
         ozIMiotWgvlfECWs7gQDv0ZvmpBV4MIEaysILxiEEP2pcklk8/K6YaLIOWXvAFw1z9y/
         kxxw==
X-Gm-Message-State: AOAM531VVcnuxk+x/A284enXSUOCTkzkYS+GVNPGS7NqcIaDsJ36fsOt
        Q4SLq+jhnNRWhfas4xdhCeU=
X-Google-Smtp-Source: ABdhPJxAX6epaMXiJpcFZgJGymiVhFErDGBjSsz4oRquu1Uu2N7DcjAsoU7SeL34TBGrNvSf4RbMew==
X-Received: by 2002:a1c:2d4b:: with SMTP id t72mr47245110wmt.105.1594023371909;
        Mon, 06 Jul 2020 01:16:11 -0700 (PDT)
Received: from kheib-workstation ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id s15sm22916987wmj.41.2020.07.06.01.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 01:16:11 -0700 (PDT)
Date:   Mon, 6 Jul 2020 11:16:09 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next 2/5] RDMA/efa: Set max_pkeys attribute
Message-ID: <20200706081609.GA363413@kheib-workstation>
References: <20200706075419.361484-1-kamalheib1@gmail.com>
 <20200706075419.361484-3-kamalheib1@gmail.com>
 <864f9e35-5223-db52-1c6e-ac1b2a4079ed@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <864f9e35-5223-db52-1c6e-ac1b2a4079ed@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 06, 2020 at 10:58:34AM +0300, Gal Pressman wrote:
> On 06/07/2020 10:54, Kamal Heib wrote:
> > Make sure to set the max_pkeys attribute to indicate the maximum number
> > of partitions supported by the efa device.
> > 
> > Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > Cc: Gal Pressman <galpress@amazon.com>
> > ---
> >  drivers/infiniband/hw/efa/efa_verbs.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> > index 08313f7c73bc..7dd082441333 100644
> > --- a/drivers/infiniband/hw/efa/efa_verbs.c
> > +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> > @@ -212,6 +212,7 @@ int efa_query_device(struct ib_device *ibdev,
> >  	props->max_send_sge = dev_attr->max_sq_sge;
> >  	props->max_recv_sge = dev_attr->max_rq_sge;
> >  	props->max_sge_rd = dev_attr->max_wr_rdma_sge;
> > +	props->max_pkeys = 1;
> >  
> >  	if (udata && udata->outlen) {
> >  		resp.max_sq_sge = dev_attr->max_sq_sge;
> > 
> 
> Thanks Kamal, a similar patch was already merged:
> f25022a53ef3 ("RDMA/efa: Set maximum pkeys device attribute")

Correct, Now I see it with diff commit id under the for-rc branch,
while I did my work on top of the for-next branch.

I'll send a v2 that drops this patch.

0133654d8eb8 RDMA/efa: Set maximum pkeys device attribute

Thanks,
Kamal
