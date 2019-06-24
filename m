Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31DBE50CD2
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 15:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfFXNzy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 09:55:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46344 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfFXNzy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jun 2019 09:55:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so13981245wrw.13
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2019 06:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4arsaGDEjSkzwzRA/N3Hrna2lOLzq+94osMUbrje5jk=;
        b=cJBb3LyGWz6a+ZF24Q16t+Jq3jubo4POkzoEuwTFa4igkYIIZ4CrGKhq/VBGSLDgV+
         R7Qz58xlo8mcgCaXGv296xJUBZk0kWkrSICXHD+irx4lidxzIbN8xeAzmwBMImqBYIpY
         eKFlA/0ylT8ZbBmEkDh730eMD4FA8fcWvKTGfH4JHJLvK+2niN/exKVnrdWX/8BhWAz4
         bZ2BbBnoA8Mr6mt2PHPtpxxftqUTUr2xGiNQoaqGGYpEUiqP7/4eyzizTnR9LgxPrsPr
         x8q9l52SIByDD9HRQrHa5Lq2pgJt2cdno3mf8cN1oJgNelLCxmbQs+mZSVmwfkhnre+z
         rPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4arsaGDEjSkzwzRA/N3Hrna2lOLzq+94osMUbrje5jk=;
        b=IcV9HHIa4wV7Hyt7G+UldJ1jD178fcvoLrW1CPgHpsYT8VH7HfofC1cDShGCdX2p6I
         6KkvmRTTFori9Fnqb/DGbPfZs4i3lybv0O58sAbdAgfVg4ANYD3tF4Yg/myfllEVA7zF
         S+Rsdt+ByX9n99Bmys1uurwEs2N4S2cNhk5XM+V1TpWT8hnrZfXy2IclJcKvff0UF6VS
         dGMn5M3Cliswuyax1iPa5Ihi/Fd4w83DzJ2qyXvYL/Rd/3aJEpRA1Soecod025A/HJwe
         gyrWzf5YL3AdM4QgaTZ6bYRsDi/Kgn+jnTBToMLNqq6liTMSykCTC9e/UUBVXufDNKD/
         nm8w==
X-Gm-Message-State: APjAAAVGwY3fuk1K2CFe38l2FAZuH8+WmoqglkgPCjf7Pmaoa4nEeVyg
        d/NBzSphVosfs821jXPz7DXMdQ==
X-Google-Smtp-Source: APXvYqxyF5Zhdd0NS3TPvQio00kP/UH+k9ryunX9HaO9qRhzgHE2KVHkhfUxKG/64BxafxMuhrmCmQ==
X-Received: by 2002:a5d:4008:: with SMTP id n8mr49233669wrp.353.1561384552634;
        Mon, 24 Jun 2019 06:55:52 -0700 (PDT)
Received: from ziepe.ca ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id q20sm25473349wra.36.2019.06.24.06.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 06:55:52 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hfPRm-0002Fc-Bp; Mon, 24 Jun 2019 10:55:50 -0300
Date:   Mon, 24 Jun 2019 10:55:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
Message-ID: <20190624135550.GB8268@ziepe.ca>
References: <20190620161240.22738-1-logang@deltatee.com>
 <CAPcyv4ijztOK1FUjLuFing7ps4LOHt=6z=eO=98HHWauHA+yog@mail.gmail.com>
 <20190620193353.GF19891@ziepe.ca>
 <20190624073126.GB3954@lst.de>
 <20190624134641.GA8268@ziepe.ca>
 <20190624135024.GA11248@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624135024.GA11248@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 24, 2019 at 03:50:24PM +0200, Christoph Hellwig wrote:
> On Mon, Jun 24, 2019 at 10:46:41AM -0300, Jason Gunthorpe wrote:
> > BTW, it is not just offset right? It is possible that the IOMMU can
> > generate unique dma_addr_t values for each device?? Simple offset is
> > just something we saw in certain embedded cases, IIRC.
> 
> Yes, it could.  If we are trying to do P2P between two devices on
> different root ports and with the IOMMU enabled we'll generate
> a new bus address for the BAR on the other side dynamically everytime
> we map.

Even with the same root port if ACS is turned on could behave like this.

It is only a very narrow case where you can take shortcuts with
dma_addr_t, and I don't think shortcuts like are are appropriate for
the mainline kernel..

Jason
