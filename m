Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDD52CEE9
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 20:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfE1Srs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 14:47:48 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:39502 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfE1Srs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 May 2019 14:47:48 -0400
Received: by mail-vk1-f195.google.com with SMTP id l13so574356vkk.6
        for <linux-rdma@vger.kernel.org>; Tue, 28 May 2019 11:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Akfxw6+llH5fHWprKxKa9n9eV19fM2CKTrGDsFRYRhc=;
        b=XQ6WCFj/i106voLzi+8VUxCUoItYSw2cQWj5laacVMbDGyCyUDkTbvGOl6mJTPOPgW
         QAy/TMckKbUuuI1iEC/eG1kdrylQ5KYp4qzXFS8XEzi8pXbrY6Tl88jFFNnr5a/oAZga
         rjvJpMW8TKS5bP5xSWjCbvQS2V3JLQLJdnourMbEsoZwmC9jgtKUJcS2kxGtlWGgE+iR
         r+yw+rbuZrV56pB5DxFU7dyIub0XHWn5sH8Cn10M+aGUGfGuhPkJeXefu2SgIeReyUgV
         LqH/+KMm3gNH490Qy693NtuDBBPxEkWqlmgy1QWnhxkbZGLuuIBZL2R4fd9RbONbvBTf
         J1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Akfxw6+llH5fHWprKxKa9n9eV19fM2CKTrGDsFRYRhc=;
        b=IGtAWlWowpVXFb/THC0pTYYaAvMjfOoxvUgBrTjPzb4AaVqGtiMUzOCIG8objJDHc9
         3H7ENOFaQNwLexNMUPj4T/8r0XWj3Fyyxsc9RCMDw91CKMtWpHArmMEzRVi1+ldZyQR2
         DzJQSV13zpmYaEHnQ2wVqCs9anXwrDqvn+gghZVh5RSn88GFnBW3RsjmaCHqk5Ur36jH
         KbsqfwTJmuG9srdSCzh8WQB1VHXLWizCa/YHiCq2ZsDpsf6m9lLWgWcw2zHi+8f5cXgF
         0jBB0JXHL+z5ZUit/p1QG3yao6s//1clPGCd9F3laRNH0EDCIqBNIzBOZ2GNkA3j199r
         7/oQ==
X-Gm-Message-State: APjAAAVAuT6MmJNUNtt1efA4LTZy+oMKGIEZAMMqFR+oGJ35BGKUmwXi
        mvgtOeQI2rNZxgHbX4hT2rmCLw==
X-Google-Smtp-Source: APXvYqxC+aLf3j30AzilJRbiAfuonv++dGZlNAP5dRtToBPjQYa5JxPMiHEb1cTLYG7h5HRUEZ6HPg==
X-Received: by 2002:a1f:5581:: with SMTP id j123mr12843932vkb.13.1559069266882;
        Tue, 28 May 2019 11:47:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id j8sm16925634vsd.0.2019.05.28.11.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 11:47:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVh8T-0001f7-Pk; Tue, 28 May 2019 15:47:45 -0300
Date:   Tue, 28 May 2019 15:47:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Ariel Elior <aelior@marvell.com>, "jgg@zeipe.ca" <jgg@zeipe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v2 rdma-next 1/2] RDMA/qedr: Add doorbell
 overflow recovery support
Message-ID: <20190528184745.GD31301@ziepe.ca>
References: <20190528112401.14958-1-michal.kalderon@marvell.com>
 <20190528112401.14958-2-michal.kalderon@marvell.com>
 <20190528161624.GB31301@ziepe.ca>
 <MN2PR18MB318249A0D35E51A5B4E30131A11E0@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB318249A0D35E51A5B4E30131A11E0@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 28, 2019 at 06:41:28PM +0000, Michal Kalderon wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Tuesday, May 28, 2019 7:16 PM
> > 
> > On Tue, May 28, 2019 at 02:24:00PM +0300, Michal Kalderon wrote:
> > 
> > > +static int qedr_init_user_db_rec(struct ib_udata *udata,
> > > +				 struct qedr_dev *dev, struct qedr_userq *q,
> > > +				 u64 db_rec_addr, int access, int dmasync) {
> > > +	/* Aborting for non doorbell userqueue (SRQ) */
> > > +	if (db_rec_addr == 0)
> > > +		return 0;
> > > +
> > > +	q->db_rec_addr = db_rec_addr;
> > > +	q->db_rec_umem = ib_umem_get(udata, q->db_rec_addr,
> > PAGE_SIZE,
> > > +				     access, dmasync);
> > > +
> > > +	if (IS_ERR(q->db_rec_umem)) {
> > > +		DP_ERR(dev,
> > > +		       "create user queue: failed db_rec ib_umem_get, error
> > was %ld, db_rec_addr was %llx\n",
> > > +		       PTR_ERR(q->db_rec_umem), db_rec_addr);
> > > +		return PTR_ERR(q->db_rec_umem);
> > > +	}
> > > +
> > > +	q->db_rec_page = sg_page(q->db_rec_umem->sg_head.sgl);
> > > +	q->db_rec_virt = kmap(q->db_rec_page);
> > 
> > Is this something new? You are much better to use user-triggered mmap to
> > get a shared page than to use long term kmap.
>
> This was the fix for previously using sg_virt which as you stated won't always work.
> Just to make sure I understand, by user-triggered mmap do you mean allocating the
> memory in kernel and passing the physical pointer to user to mmap it
> ?

Yes, if the ABI allows for it, this is a better choice for this kind
of long lived usage.

> > >  		cq->ibcq.cqe = chain_entries;
> > > +		cq->q.db_addr = (void __iomem *)(uintptr_t)ctx->dpi_addr +
> > > +			db_offset;
> > 
> > Seems like something has gone wrong here if you have to type __iomem like
> > this
> The dpi_addr is an io address to the doorbell-bar received from the qed module,
> the qed/qedr interface passes it as a u64 ( it is casted from u8 __iomem * to u64)
> so I need to cast it back.

Don't cast __iommem * to u8. Make a patch to fix it.

Jason
