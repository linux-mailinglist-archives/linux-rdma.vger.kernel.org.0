Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B10AA192178
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2020 08:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgCYHAp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Mar 2020 03:00:45 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40969 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgCYHAp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Mar 2020 03:00:45 -0400
Received: by mail-ed1-f66.google.com with SMTP id v1so1110721edq.8
        for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2020 00:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mellanox-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yz5M6ok0F41qcCpMJnXS/jpaz042QaOHYupAoJk6Vz0=;
        b=BYHNbokyAZCb6ngr1AjUS1YbBA12nyO14LfCwICpaV8CZSYyEE6NFKl9IF5Zwo96Wd
         Mi7MFbNykijlVp6E9by5Zm6GzT1+xy25SIY3eYhQzZTpxxyei9C4RUaDdlwaEoZpxf6h
         dYGNL8UJor1yVEMDxboonMWnHpYBjhxa8VZb3zKJFWC0qF8FzbUonhWyQw7TiM8WXNpU
         mABVphX+oSKkJCiuEySySrifni4RbU1OwE5TnyVXDRo9YQyJGxUOvFpcBLNOBb1FPk22
         GNPb+Ggwa29xd6/bko+hfN5MzkbEcXpv1JeKdGizqBeBbi2l30Y5hfyj3E9o/CRmiLWT
         aqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yz5M6ok0F41qcCpMJnXS/jpaz042QaOHYupAoJk6Vz0=;
        b=pOE/jNyTGHySU69fjbsGF3L1Xnk/tawh0+XKlz8Oq3OkHFfwz5JLhUSviv62IcJO+Y
         jDYlb4Ql7t8RuIlpzHvFZm+d1lNHxFj0xnVXw4CrW4shPOsSc3khMI5tiVCBPT8ZD8Pg
         Zy9zlVF9M0qPqOgk73daQAs+q4zHIXUslXvyXZmDub0Wadyp5hdK9Lh3uF982SyN5A4Z
         4b0KzLWBigOf/7VtkoPA51q7fIS77yaGqnPymBcwSxU577Xqiy6+ppazq8uOEcxuWOm3
         PmIK7QYOUa/js+kiuRqriVLLKRQGxul35H09w8kkuFDNZUS1a0YcVLnadOqZrOWhnYD2
         szhw==
X-Gm-Message-State: ANhLgQ2r7SeR9Ud8oRVH1aOW8EHVjiYnH2nKVQ35yC6n8xO3qDGuRav/
        9Bq5KA0oJ5X0HLi9zdgc/OmSVxeR+s7mY1+fCYE=
X-Google-Smtp-Source: ADFU+vs4/oYOzkXxXMLejN416Dh/jx5J8hhnfKqKcQdMOrgvDD/WopZA37NLgbWdamG9+JhodpeHZjxRpLQ/50SeJi8=
X-Received: by 2002:a17:907:abc:: with SMTP id bz28mr1892815ejc.83.1585119643168;
 Wed, 25 Mar 2020 00:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200312083658.29603-1-leon@kernel.org> <20200318233101.GA18746@ziepe.ca>
In-Reply-To: <20200318233101.GA18746@ziepe.ca>
From:   Moni Shoua <monis@mellanox.com>
Date:   Wed, 25 Mar 2020 09:00:32 +0200
Message-ID: <CAG9sBKNFPmow-DFzVYKVmhYq_hdrn+_Oe6rh7xixS=PUVexU6Q@mail.gmail.com>
Subject: Re: [PATCH rdma-next] MAINTAINERS: Clean RXE section and add Zhu as
 RXE maintainer
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Zhu Yanjun <yanjunz@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Sorry for not responding in time. I was a little bit sick for the last few days.
I Ack this of course.

On Thu, Mar 19, 2020 at 1:32 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Thu, Mar 12, 2020 at 10:36:58AM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Zhu Yanjun contributed many patches to RXE and expressed genuine
> > interest in improve RXE even more. Let's add him as a maintainer.
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > --
> >  MAINTAINERS | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
>
> Moni has moved on to other areas and is having trouble sending plain
> text emails, he gave a verbal:
>
> Acked-by: Moni Shoua <monis@mellanox.com>
>
> Jason
