Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E55284B49
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 14:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgJFMFG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 08:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgJFMFG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Oct 2020 08:05:06 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008FEC061755
        for <linux-rdma@vger.kernel.org>; Tue,  6 Oct 2020 05:05:05 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id y198so9963804qka.0
        for <linux-rdma@vger.kernel.org>; Tue, 06 Oct 2020 05:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J46uYoi137y1aPiibh1zaw5SLjEoUu3ij2cH8Ls1pK8=;
        b=MqzM9/0aO3hZJkXsDYpwnQHRNlGU6DU9bj80N12Dz4Y9QrbAOe1TKDelHVophCI0KW
         nUU/44DAlG7wtz0GxE657/nr0lEm3tFjNO2JBOWIghLnFqjBU6uMdtIfJgDAFrYKUnld
         79uAUt4i6XePad6fKg7tpW21Vh6/Ke/i4q1kB8htgzA7wFm5llqHHvt+nqRln67+gMxS
         JxJWhYwzJrhKIV0wfsq4CmWIJEjZ2ppBzGOA/hXMpsa40irvQ6JayU9+z6BrTsjAtFeI
         wsmK/er7kzc0yTolRISH8hpZjeUd4DSautXaETPJ0/qcBZLd7GkNuI8PzZt3XdPum+I/
         SGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J46uYoi137y1aPiibh1zaw5SLjEoUu3ij2cH8Ls1pK8=;
        b=D63gL+njr4Rg/mGmpDZIGYhHMAplEfOyHiHIDVQE/Uz4kHOozDLUMtvK3k5FdqsfS0
         dhKiPhpnartsa48pgjxBO6R3WQqpZvz5KK9CTedwm7bCnOd5zmImj2xwiF2t0bb+0oW1
         atoUfp25fVxuyWNwFXG0S1Cv4y9Duc7ioKTaKAaBPxhFVyzX9Zmi7m7xI1gj4WilyoBE
         VDprT75kodidxm68YAJzshC1tW+gHKA2T4/2Sn9AAS21MYPJlQb92a96tS8Xv/55wvHp
         5JdrL1wmd/aD6aEti/0aPNcDOos26/Jciosf7nVbJOhQhv5cLHDNgehK9AHDxPvwXdhH
         X+Kg==
X-Gm-Message-State: AOAM53179sO7rfnmVu0MUdLRrDFjMg2sR3BW/puWFUH8kAem20OgvB9j
        Mv3lf3hqVSGD1ey2spOJdHU2hw==
X-Google-Smtp-Source: ABdhPJyBYR5w4DmNjQ1fXG96tHkJkcRJZbGHu+z2scqyDROugMnucvTNKUFKSsoKSKSRpwvdCu7/Dw==
X-Received: by 2002:a05:620a:2213:: with SMTP id m19mr4790838qkh.472.1601985905248;
        Tue, 06 Oct 2020 05:05:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id r187sm2163410qkc.63.2020.10.06.05.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 05:05:04 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kPliJ-000Vqk-6K; Tue, 06 Oct 2020 09:05:03 -0300
Date:   Tue, 6 Oct 2020 09:05:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parav Pandit <parav@nvidia.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next v2] RDMA: Explicitly pass in the dma_device to
 ib_register_device
Message-ID: <20201006120503.GF5177@ziepe.ca>
References: <20201006073229.2347811-1-leon@kernel.org>
 <20201006073554.GA16894@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006073554.GA16894@infradead.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 06, 2020 at 08:35:54AM +0100, Christoph Hellwig wrote:
> > index f904bb34477a..2f117ac11c8b 100644
> > +++ b/drivers/infiniband/sw/rdmavt/vt.c
> > @@ -581,7 +581,11 @@ int rvt_register_device(struct rvt_dev_info *rdi)
> >  	spin_lock_init(&rdi->n_cqs_lock);
> > 
> >  	/* DMA Operations */
> > -	rdi->ibdev.dev.dma_ops = rdi->ibdev.dev.dma_ops ? : &dma_virt_ops;
> > +	rdi->ibdev.dev.dma_ops = &dma_virt_ops;
> > +	rdi->ibdev.dev.dma_parms = rdi->ibdev.dev.parent->dma_parms;
> > +	rdi->ibdev.dev.dma_mask = rdi->ibdev.dev.parent->dma_mask;
> 
> This copies the dma_mask pointer, which seems completely bogus.

And pointless since virt_ops doesn't do anything with it?

Jason
