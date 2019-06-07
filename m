Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7DE039628
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 21:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbfFGTud (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 15:50:33 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44569 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729715AbfFGTuc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 15:50:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so2735229ljc.11
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 12:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L4/BQvJwRH8pzYfkzs4GJ1WfF93VEGjPp4jeBLqlphY=;
        b=YCUY4mO48TpdXn4RiwPHgCrMGugdvwDHB8vyFdr/XROShWBDsWdsngRPoLfJD9TPR6
         IslwjkUAlLZPxElG6sFIGiVn1uv3FRFGVyRaFXPMK5vmCt1W40kS47ohKbJ/jiKGG2gD
         8xIuMivNI+7pZ0OMS0ULxhKEDTfL4NJS7PagdqHIAfmkR8n1pXPYeMBFwpCpmIoVjfd8
         Df2lK+rDqvVayMAoPzfdoqP8M4+AH53wN1R8WDXlrurqH/S8CqYCCePsYhJEnE5bNzH7
         ztKCZIFRg4gjihqAxZ1NPDjn8QRL6/fHYc3lwedsD8Tc5vVDKVwvGnvWkc7kmFNHUG2y
         cYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4/BQvJwRH8pzYfkzs4GJ1WfF93VEGjPp4jeBLqlphY=;
        b=JQ71AkeY/EWqNLAduXY+aqgk0sxRtQ+FYmEx2IfJnCqYXWgyW8BdLmOZXtRFf2WJrh
         IHgKn81HIROGTK7o2SQOTs6qKjdQEj+432un01fjEPHlg7s4C9P7ulvtyjYZ+43mnU20
         udg8j3rDMhjuQZTzjSvFnbi2oZS3B5qHaJYbs/yxfGUVSNDXUUiZicEsGm8bgLa7H9YJ
         z6BfpYAbdhN460tFJTS/z9TT/jfXEFzpixPMknQwbGplgilzlqJ13JwO1y5N0uQgRpik
         DHxBxhGLRXFvRm8C/4g4YQ2psLib8O/d7vk9WLwT4uktn7NBkpQ2/wqFC7q0WLo05x+d
         +88Q==
X-Gm-Message-State: APjAAAWiww5n5dmcYeZfh2MW6F/bNCK90ZQeofoOa2OLjR709TkU2S/L
        VlkHqCUNY6wFZdOezT/jjgIl1UQSNpTlj5Cn2HU=
X-Google-Smtp-Source: APXvYqz1LzcnbHycWMD3GBKCgKDEZGlCDEysdeWvZ+1mAaMPH6qe+E+wW/6XfWmxUHzeQMloiPf8k1Da89PWu7bXKPA=
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr13678555lja.207.1559937031060;
 Fri, 07 Jun 2019 12:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190523153436.19102-1-jgg@ziepe.ca> <20190523153436.19102-10-jgg@ziepe.ca>
 <CAFqt6zarGTZeA+Dw_RT2WXwgoYhnKP28LGfc+CDZqNFRexEXoQ@mail.gmail.com> <20190607193722.GS14802@ziepe.ca>
In-Reply-To: <20190607193722.GS14802@ziepe.ca>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 8 Jun 2019 01:25:35 +0530
Message-ID: <CAFqt6zbUjFLXWch5jEx5OaC8ag27nBoHKGF5VXtCbvGcPbJ=Aw@mail.gmail.com>
Subject: Re: [RFC PATCH 09/11] mm/hmm: Remove racy protection against double-unregistration
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 8, 2019 at 1:07 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Sat, Jun 08, 2019 at 01:08:37AM +0530, Souptick Joarder wrote:
> > On Thu, May 23, 2019 at 9:05 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > From: Jason Gunthorpe <jgg@mellanox.com>
> > >
> > > No other register/unregister kernel API attempts to provide this kind of
> > > protection as it is inherently racy, so just drop it.
> > >
> > > Callers should provide their own protection, it appears nouveau already
> > > does, but just in case drop a debugging POISON.
> > >
> > > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > >  mm/hmm.c | 9 ++-------
> > >  1 file changed, 2 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/mm/hmm.c b/mm/hmm.c
> > > index 46872306f922bb..6c3b7398672c29 100644
> > > +++ b/mm/hmm.c
> > > @@ -286,18 +286,13 @@ EXPORT_SYMBOL(hmm_mirror_register);
> > >   */
> > >  void hmm_mirror_unregister(struct hmm_mirror *mirror)
> > >  {
> > > -       struct hmm *hmm = READ_ONCE(mirror->hmm);
> > > -
> > > -       if (hmm == NULL)
> > > -               return;
> > > +       struct hmm *hmm = mirror->hmm;
> >
> > How about remove struct hmm *hmm and replace the code like below -
> >
> > down_write(&mirror->hmm->mirrors_sem);
> > list_del_init(&mirror->list);
> > up_write(&mirror->hmm->mirrors_sem);
> > hmm_put(hmm);
> > memset(&mirror->hmm, POISON_INUSE, sizeof(mirror->hmm));
> >
> > Similar to hmm_mirror_register().
>
> I think we get there in patch 10, right?

No, Patch 10 of this series has modified hmm_range_unregister().
>
> When the series is all done the function looks like this:
>
> void hmm_mirror_unregister(struct hmm_mirror *mirror)
> {
>         struct hmm *hmm = mirror->hmm;
>
>         down_write(&hmm->mirrors_sem);
>         list_del(&mirror->list);
>         up_write(&hmm->mirrors_sem);
>         hmm_put(hmm);
>         memset(&mirror->hmm, POISON_INUSE, sizeof(mirror->hmm));
> }
>
> I think this mostly matches what you wrote above, or do you think we
> should s/hmm/mirror->hmm/ anyhow? I think Ralph just added that :)

I prefer, s/hmm/mirror->hmm and remove struct hmm *hmm :)
