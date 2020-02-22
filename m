Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 018AD168C46
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2020 05:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgBVEGJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Feb 2020 23:06:09 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:46871 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgBVEGJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Feb 2020 23:06:09 -0500
Received: by mail-il1-f193.google.com with SMTP id t17so3349878ilm.13
        for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2020 20:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gEo0c+mtNmDQfz1Rpld+k+e1YtLq1WgwjcH3zh1rpIw=;
        b=DSAl6alh1nSmEJw5U62VKn1XY81mjwU1cSsst2DbSHhR28+dUMY6QuFMfIm588pcUP
         WzNpHM2Xi0hd+E39iEW5+MZF+VeTRHQftK1thLRJQnhaxeYVVXlmY4/MO+sVgOmzKOR3
         Eoob1JiM2/L3D4MFjT4sOJt0ygEiz7rMvZDGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gEo0c+mtNmDQfz1Rpld+k+e1YtLq1WgwjcH3zh1rpIw=;
        b=dXjo5hA/PQTwnpZut9qv1CCLvh8oCaRpRUxqqKKme6dDqzgg0fEjOx+Sx3y49D+cpK
         zWYdW3dF1bUL8e5ZE2mcj+dpa/f5y/hSZIE/h/IeBDnqHp/TOlbvMTwp1pnBb9SfJ/Ye
         jZl9d9A5udGxaw0JVEIrlA4Wv9NRxlFwTpNaWKuevy/3rQgZEfjcbh4PHjkDvsmrWfD6
         h5NDMm9CSp/hsBSv3/PwGeP609nkHbEiVPv2y/MDQdfUo2cFdAjYc1fjiyX07Hh84S5I
         Hv6KGOgLH4yM9quWFSzXGxnC9qzDpQPEcbWkbwnrUtgSNAH5dEh35/uvT5sTNGbZ8DVm
         tlyg==
X-Gm-Message-State: APjAAAUamPuJzPfPy1LolD/pK571dC1pwTJlEGoqoSvb4oU6CS+G2+3U
        gdPDry4ljeNecaOkGyfkCPwN+/Oco5tT3BKGGGxyoA==
X-Google-Smtp-Source: APXvYqz0yx10E9ALk8kbA/wq8nF5BZMrzr3JRROlKh7gT24nnZnYi7cT4fhgjet0vjLH1PNut0fJYR5HV5UWAtzeCec=
X-Received: by 2002:a92:9ac5:: with SMTP id c66mr44023772ill.232.1582344368323;
 Fri, 21 Feb 2020 20:06:08 -0800 (PST)
MIME-Version: 1.0
References: <1581786665-23705-1-git-send-email-devesh.sharma@broadcom.com> <20200222003005.GA21965@ziepe.ca>
In-Reply-To: <20200222003005.GA21965@ziepe.ca>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Sat, 22 Feb 2020 09:35:33 +0530
Message-ID: <CANjDDBgayR==R4E4Z_+Z0kK49VKpgompTj_MdZzqFJ2=f3iMYQ@mail.gmail.com>
Subject: Re: [PATCH V3 for-next 0/8] Refactor control path of bnxt_re driver
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Feb 22, 2020 at 6:00 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Sat, Feb 15, 2020 at 12:10:57PM -0500, Devesh Sharma wrote:
> > This is the first series out of few more forthcoming series to refactor
> > Broadcom's RoCE driver. This series contains patches to refactor control
> > path. Since this is first series, there may be few code section which may
> > look redundant or overkill but those will be taken care in future patch
> > series.
> >
> > These patches apply clean on tip of for-next branch.
> > Each patch in this series is tested against user and kernel functionality.
> >
> > v2->v3
> >
> > v1->v2
> > patch 0001
> > patch 0003
> > patch 0004
> > patch 0008
>
> Seems like something went wrong with this change log
Did "double-minus" (--) before each line played any role here?
>
> > Devesh Sharma (8):
> >   RDMA/bnxt_re: Refactor queue pair creation code
> >   RDMA/bnxt_re: Replace chip context structure with pointer
> >   RDMA/bnxt_re: Refactor hardware queue memory allocation
> >   RDMA/bnxt_re: Refactor net ring allocation function
> >   RDMA/bnxt_re: Refactor command queue management code
> >   RDMA/bnxt_re: Refactor notification queue management code
> >   RDMA/bnxt_re: Refactor doorbell management functions
> >   RDMA/bnxt_re: use ibdev based message printing functions
>
> Applied to for-next
Thanks!
>
> Jason
