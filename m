Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0F4D4A959
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 20:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfFRSEZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 14:04:25 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:32881 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729981AbfFRSEZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jun 2019 14:04:25 -0400
Received: by mail-qk1-f193.google.com with SMTP id r6so9210093qkc.0
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2019 11:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=okyRjZf9B5dx07ohdH8HMJVvyCKHxrwwt6GBfDyhnYI=;
        b=jk6is7nSmkWA4Mc6UVjL/PYCTdkXKQ2ikA9XsaXq/PVjcroLlHZkg7ij4JP4DcORqH
         mz8lBKypK4EhTBlTjipdOVoZzqs0gooV5BD71kqo+EzYxmAiZwcr3ZQj3Jc5ivJVFMB3
         SRH/D9/kqYfRYwCCtFBsV7hlq6/6O+dR1xHwPPtPvVT+3sHCHfJTkoXL6OJ7Nqg43IOp
         f3/QmIYWWGqf0baTFPWhHh7bvk25F0pqfrvx58LZl/dY4EtGWcfVbqRSn7iaWy2yh6Ru
         MY2y2SfyB7BxsCkTQT3M4PYdMaeNVflw3viT0XZ7VJ1d216JuQ8nS/UHNPCLcOBws+l9
         inpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=okyRjZf9B5dx07ohdH8HMJVvyCKHxrwwt6GBfDyhnYI=;
        b=Fa15yggAezP7yzpNKTnVrRKGEC7snfRx5+f5y8ilQTy9ngcn8wRxtkTuZQCEkUXoRp
         SLK8MUCPdN61mgUGlqeZNbFN3Po35MG/RdpXAmbO+YwTRTDIJtW4033VcNtn5p7ea+NR
         fOG2az7xr6WPDLDipRWeXnyDDPW3tu+ElF+tOpOtPUVmLTIT2VPDOVvfsf9v8bVScCoz
         YPqMIvPBR14bk6rIH2EBQ2hO2dLcbpAky0nMnPIlZziOMbH0JIrtJ+SMtB+GSSM7DL/E
         R5/hHuerNxyTOCx4NQdlAAWzWow8AtCx6t7kxI6EPjL8je2zdOdEcZG0ZEIly6FFMnN9
         HLnw==
X-Gm-Message-State: APjAAAUipj8TgqwdrCBMEEwUUJhk/+HI20h9uxle3sZBUq3YYjOjRbVo
        RMS+7jEsbTTfihVTRIdpsInbdg==
X-Google-Smtp-Source: APXvYqxWj2mDmFVY7ZvaCukxL5n3PqpZ3GEOoAN38QvZ41wgpTgMsHaVHbX3mqFkOs2ObrlkBJP2FA==
X-Received: by 2002:a37:aa0d:: with SMTP id t13mr94831459qke.167.1560881063938;
        Tue, 18 Jun 2019 11:04:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id v9sm7988792qti.60.2019.06.18.11.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 11:04:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdIT0-0003OU-LC; Tue, 18 Jun 2019 15:04:22 -0300
Date:   Tue, 18 Jun 2019 15:04:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 09/12] mm/hmm: Poison hmm_range during unregister
Message-ID: <20190618180422.GK6961@ziepe.ca>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-10-jgg@ziepe.ca>
 <20190615141726.GI17724@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615141726.GI17724@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 15, 2019 at 07:17:26AM -0700, Christoph Hellwig wrote:
> > -	/* Sanity check this really should not happen. */
> > -	if (hmm == NULL || range->end <= range->start)
> > -		return;
> > -
> >  	mutex_lock(&hmm->lock);
> >  	list_del_rcu(&range->list);
> >  	mutex_unlock(&hmm->lock);
> >  
> >  	/* Drop reference taken by hmm_range_register() */
> > -	range->valid = false;
> >  	mmput(hmm->mm);
> >  	hmm_put(hmm);
> > -	range->hmm = NULL;
> > +
> > +	/*
> > +	 * The range is now invalid and the ref on the hmm is dropped, so
> > +         * poison the pointer.  Leave other fields in place, for the caller's
> > +         * use.
> > +         */
> > +	range->valid = false;
> > +	memset(&range->hmm, POISON_INUSE, sizeof(range->hmm));
> 
> Formatting seems to be messed up.  But again I don't see the value
> in the poisoning, just let normal linked list debugging do its work.
> The other cleanups looks fine to me.

tabs vs spaces, I fixed it. This one is more murky than the other - it
is to prevent the caller from using any of the range APIs after the
range is unregistered, but we could also safely use NULL here, I
think.

Jason
