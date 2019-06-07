Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A91A38C11
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 15:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfFGN5z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 09:57:55 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33191 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbfFGN5z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 09:57:55 -0400
Received: by mail-qk1-f193.google.com with SMTP id r6so1302629qkc.0
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 06:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=17gadSvJGp+uvcoNC+FfcmshKqVGv1ZUwiPdnI82lOI=;
        b=I+46Zffwelv3FY2kYKGzdobJ6uMmX8zCgsnvKiDTSkfI3HJBa+htk88VkGWM7NSZpi
         /0JCHDpAA7Hsoa4omW1wx1J85SCrH7dgr6RV0StdZtsaWrex1ZOuSIm+Zka617XPTGpN
         X1fcgiH+n0lyWRW1QagWvryyhg9XGrmKSd/F4IVorle0OcarTMiFrJd0Z3r6ZGdD+cmy
         VAiy5ECKzDJ4NQLEc4bwJAM+qICcpqA6QdhJ28xs1+NDe0kplypSuDdQRy0yFtY9sLB3
         MnA8Gv2LBIO0rwR5UIbYCFViG3FrLuek4drM6k3G4h9h5StmR/AX6O3RMQT8pEjmMpLr
         Yz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=17gadSvJGp+uvcoNC+FfcmshKqVGv1ZUwiPdnI82lOI=;
        b=AJOr+isqrwfbUPgY1z0pVqTk+wxW9ndhuDo3Pq8pR6JNAloeGp4K3bXCgrV0kLyaLf
         0EVZ7wWMDOIWodfCCbfpdX3pU2eFoaVYeuimJjLOynK9EWVzuxA4Mf2LgNnYS8vA6lnH
         9QlSpTizNjImojw2lL5/qRt+Saaq979tMnFRzWDLYxKQdB1HQctnw3QYJc+FteievDlb
         lS0IPytcIKxaA0iUEWB8v5A3eXqITM4fqoYQCszH6TvdwcpZUrmfyygiheGWYx/qPj7V
         JIPWsLU4JIZpjLJFsDDbnDK/HO9DMSIObkXW+KlgUhdYx7vQUDNmB+KnKYA72MJ5VRau
         WRKA==
X-Gm-Message-State: APjAAAU/cqxI8D+cUH+pp2+WLPY8CAz1ekzfAR6TkyENoiQHScvYCg3i
        hSwPA1hi4ZFD/TwLkFtzMCsouA==
X-Google-Smtp-Source: APXvYqyXb3YGPBh3lIclsi3PYfUGbJ2uvWrtfDWhG41E8l5j7j4vV139lmCRlFT78OmA7F3xtrX4pg==
X-Received: by 2002:a37:bc03:: with SMTP id m3mr24773704qkf.199.1559915874559;
        Fri, 07 Jun 2019 06:57:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id w30sm1247493qtb.28.2019.06.07.06.57.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 06:57:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZFNR-0001xU-JJ; Fri, 07 Jun 2019 10:57:53 -0300
Date:   Fri, 7 Jun 2019 10:57:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 hmm 08/11] mm/hmm: Remove racy protection against
 double-unregistration
Message-ID: <20190607135753.GH14802@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-9-jgg@ziepe.ca>
 <88400de9-e1ae-509b-718f-c6b0f726b14c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88400de9-e1ae-509b-718f-c6b0f726b14c@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 06, 2019 at 08:29:10PM -0700, John Hubbard wrote:
> On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > 
> > No other register/unregister kernel API attempts to provide this kind of
> > protection as it is inherently racy, so just drop it.
> > 
> > Callers should provide their own protection, it appears nouveau already
> > does, but just in case drop a debugging POISON.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> >  mm/hmm.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index c702cd72651b53..6802de7080d172 100644
> > +++ b/mm/hmm.c
> > @@ -284,18 +284,13 @@ EXPORT_SYMBOL(hmm_mirror_register);
> >   */
> >  void hmm_mirror_unregister(struct hmm_mirror *mirror)
> >  {
> > -	struct hmm *hmm = READ_ONCE(mirror->hmm);
> > -
> > -	if (hmm == NULL)
> > -		return;
> > +	struct hmm *hmm = mirror->hmm;
> >  
> >  	down_write(&hmm->mirrors_sem);
> >  	list_del_init(&mirror->list);
> > -	/* To protect us against double unregister ... */
> > -	mirror->hmm = NULL;
> >  	up_write(&hmm->mirrors_sem);
> > -
> >  	hmm_put(hmm);
> > +	memset(&mirror->hmm, POISON_INUSE, sizeof(mirror->hmm));
> 
> I hadn't thought of POISON_* for these types of cases, it's a 
> good technique to remember.
> 
> I noticed that this is now done outside of the lock, but that
> follows directly from your commit description, so that all looks 
> correct.

Yes, the thing about POISON is that if you ever read it then you have
found a use after free bug - thus we should never need to write it
under a lock (just after a serializing lock)

Normally I wouldn't bother as kfree does poison as well, but since we
can't easily audit the patches yet to be submitted this seems safer
and will reliably cause those patches to explode with an oops in
testing.

Thanks,
Jason
