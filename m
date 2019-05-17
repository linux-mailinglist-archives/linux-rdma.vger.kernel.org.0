Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B11D21DF8
	for <lists+linux-rdma@lfdr.de>; Fri, 17 May 2019 21:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfEQTD7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 May 2019 15:03:59 -0400
Received: from mail-it1-f181.google.com ([209.85.166.181]:54386 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfEQTD7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 May 2019 15:03:59 -0400
Received: by mail-it1-f181.google.com with SMTP id a190so13609904ite.4
        for <linux-rdma@vger.kernel.org>; Fri, 17 May 2019 12:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Z2UMLOtpdiz9do+FLYX1QXd3L5MOiV5c/7qryhjyeM=;
        b=Lx9ONK94YdrR4obSFs3oWkw9vnuv+HV73Hmit6uvtsVZhUix+0TcxvwcW4F/3YNH00
         yVGbRkabQjJLbUK1SdFwCP+S/F8yj+0JS9kqDp5CRPShMUjjNACJsSgZJ8f42t3RhXNQ
         gpMXiXm3lCI0KMxBfBGkWuXY//wgDSpUm2776Y9UTCd4WIgUseubUa0bGS4ROdGBsT8q
         45gIvJI65gRDbBNsVZod6LgiLoIa4ya+/eRbunAlioCAXmKJ+cRKclMZwlUS7JXHJ4Ge
         s25aZ6Tpamz1Gw/Oqxmfa6IHQtdCehEV0zr2GL0IKPdjOcLP2t14C3si3OHoiMbHco3e
         0OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Z2UMLOtpdiz9do+FLYX1QXd3L5MOiV5c/7qryhjyeM=;
        b=cbJA+CR3VphpsvkJ1KiwS06QDJnNe/LZh+TBj2QwK7RiUxuV321iCOz22CkynfYFtZ
         S8mJBIhWu1mpcw89pEGQ5BGNc7Rk55XYQNkK5IbrYHdAD7LYQ2O15UbRdyK66/HDubvA
         DU73njVnkaMV/PDSF4T8yjrVCWN+OMjQ1bGtBdlOjHcOSCTBEftR8R5RWb+6l1fLEONZ
         6quvSY1KL59oou1p/Kv3pyh78Iywi2c4ZI0Bms5OwgJ5iG/ivV7EuZJgmVlrfZb056gf
         XYL3oA20fTKWvXXxPHOMETCC4KqBMwTaTzouRdFKRbWYIHtZgvSeeISvVubuRzCOB+YH
         AE3A==
X-Gm-Message-State: APjAAAXOvH+5jI2AC0fC/4xcCmS8zvsRtyKSdxz83J+G20WlVeFPLBbc
        T4kIGCPkJ16Bj5f01qnoUCgzDIsoKz2gD/C5Fww=
X-Google-Smtp-Source: APXvYqyQJCgYpgtKt87Y37U3fdzdmBfyBsVKaQFC0ZR6X3KJ6NSXsc+zfB4z+Cif8K2XLWRPTOIQNwLmyjngfPFfg3g=
X-Received: by 2002:a02:3f0c:: with SMTP id d12mr38871838jaa.9.1558119837876;
 Fri, 17 May 2019 12:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <CADmRdJdS8EF99MprTPBmcQwjwB0sV29iHTk4C+eCPDwifAyEBw@mail.gmail.com>
 <20190517182129.GA5822@mtr-leonro.mtl.com>
In-Reply-To: <20190517182129.GA5822@mtr-leonro.mtl.com>
From:   Steve Wise <larrystevenwise@gmail.com>
Date:   Fri, 17 May 2019 14:03:47 -0500
Message-ID: <CADmRdJc+49GY8ACvPKJWHL2OR4q_+JP0qTdjrR-0JhaBHKew3A@mail.gmail.com>
Subject: Re: rdma-core debian packages
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 17, 2019 at 1:21 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, May 17, 2019 at 09:14:13AM -0500, Steve Wise wrote:
> > Hey,
> >
> > Is there a how-to somewhere on building the Debian rdma-core packages?
>
> There buildlib/cbuild script exactly for that.
>
> 0. Install docker.
> 1. Commit your changes which you want to package.
> 2. ./buildlib/cbuild build-images supported_os_from_the_list
> 3. ./buildlib/cbuild make supported_os_from_the_list
> 4. ./buildlib/cbuild pkg supported_os_from_the_list
> 5. See RPMs or DEBs in ../
>
> Repeat 3 and 4 till you will be satisfied with result.
>
> Thanks
>

Great, thanks Leon.
