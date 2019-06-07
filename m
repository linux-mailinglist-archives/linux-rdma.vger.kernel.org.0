Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4E8395DD
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 21:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfFGThY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 15:37:24 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34385 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729809AbfFGThY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 15:37:24 -0400
Received: by mail-qk1-f196.google.com with SMTP id t64so2002121qkh.1
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 12:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/AFA6heE9oFOy80aylD9Y4/+SplGswIERTbj+0KxLSo=;
        b=jmx3ZNaL4sTz0pObXjA8wn8B94r/2MxW32fl93q51ucrdsggzUWgYGMKy+rK+/TuHU
         onsC9PN5EZJYqnLqbzsuy8YZR2LTvgoeL5XaJwPCEmirLz17sndc+hOh1bK1TQoIK7Xv
         qWvbXAV28Rx1ao2Yc0LuzPh97lipLEwcAkw8yXFyw183vKjxvZc+deJejPWAq6nqUNx1
         dsX4G/oG/WHycBeqCDwT0/NTaNV1vSzfHyakQ42g7ll6ouuINgrPCon1MPGqnLp9Vego
         DgqSGQeyMXEz9V0kswHrDy+xjyywbmrAbyJZ7548+kTN4QKWxBLRUwAImUDLZ4ZTjywa
         SO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/AFA6heE9oFOy80aylD9Y4/+SplGswIERTbj+0KxLSo=;
        b=XfBVvhFlYnLkBCiyCk/4eS9PkwOsl78PcLWT+W6NrdMIjRgeOLe9AGj7WV+luLR8Ve
         /tJBn1XmgyIOqWCK/j+bdcm5NUZ6fTF3LkMhD2wU9b52VQkshoAxWWogYIngvtSz4vEh
         xSKgsKysTIvUdujn8G8tRA/I0nrVRM+b0rB5pCxg4CVPAFCzDxEO8pu7eAXO/wGMWZdQ
         AC1qJ/Q2XIEtThti7IMkf8SpGsaV+YjebZeoJDHGOgQf9PxurbKTc/5G88LIIY0nZAWr
         17ZzW1DHQA0GoXD2BZI8JJUVCgCBUoM+Ken130TfV0+KWcRt9xaZksRBQT3X8kBWsnSK
         tCdQ==
X-Gm-Message-State: APjAAAWvu9Xidpa1LH1sHxN90o/Pu5XQbBnjeaqRAXDGwgeKn1p3lWDv
        xiHjaZ7kP00+Z124KFjzfB6x4g==
X-Google-Smtp-Source: APXvYqwPBxzMDVQqMS+XyYznJjqX3ILiIujEhALA//AylcqUHfJMUDx4Sfjwubmu2WrPV+xXb08mFg==
X-Received: by 2002:a37:b501:: with SMTP id e1mr26098442qkf.271.1559936243374;
        Fri, 07 Jun 2019 12:37:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r40sm2076805qtr.57.2019.06.07.12.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 12:37:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZKfy-0005KN-CF; Fri, 07 Jun 2019 16:37:22 -0300
Date:   Fri, 7 Jun 2019 16:37:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 09/11] mm/hmm: Remove racy protection against
 double-unregistration
Message-ID: <20190607193722.GS14802@ziepe.ca>
References: <20190523153436.19102-1-jgg@ziepe.ca>
 <20190523153436.19102-10-jgg@ziepe.ca>
 <CAFqt6zarGTZeA+Dw_RT2WXwgoYhnKP28LGfc+CDZqNFRexEXoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zarGTZeA+Dw_RT2WXwgoYhnKP28LGfc+CDZqNFRexEXoQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 08, 2019 at 01:08:37AM +0530, Souptick Joarder wrote:
> On Thu, May 23, 2019 at 9:05 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > From: Jason Gunthorpe <jgg@mellanox.com>
> >
> > No other register/unregister kernel API attempts to provide this kind of
> > protection as it is inherently racy, so just drop it.
> >
> > Callers should provide their own protection, it appears nouveau already
> > does, but just in case drop a debugging POISON.
> >
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> >  mm/hmm.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index 46872306f922bb..6c3b7398672c29 100644
> > +++ b/mm/hmm.c
> > @@ -286,18 +286,13 @@ EXPORT_SYMBOL(hmm_mirror_register);
> >   */
> >  void hmm_mirror_unregister(struct hmm_mirror *mirror)
> >  {
> > -       struct hmm *hmm = READ_ONCE(mirror->hmm);
> > -
> > -       if (hmm == NULL)
> > -               return;
> > +       struct hmm *hmm = mirror->hmm;
> 
> How about remove struct hmm *hmm and replace the code like below -
> 
> down_write(&mirror->hmm->mirrors_sem);
> list_del_init(&mirror->list);
> up_write(&mirror->hmm->mirrors_sem);
> hmm_put(hmm);
> memset(&mirror->hmm, POISON_INUSE, sizeof(mirror->hmm));
> 
> Similar to hmm_mirror_register().

I think we get there in patch 10, right?

When the series is all done the function looks like this:

void hmm_mirror_unregister(struct hmm_mirror *mirror)
{
        struct hmm *hmm = mirror->hmm;

        down_write(&hmm->mirrors_sem);
        list_del(&mirror->list);
        up_write(&hmm->mirrors_sem);
        hmm_put(hmm);
        memset(&mirror->hmm, POISON_INUSE, sizeof(mirror->hmm));
}

I think this mostly matches what you wrote above, or do you think we
should s/hmm/mirror->hmm/ anyhow? I think Ralph just added that :)

Regards,
Jason
