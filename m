Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61D5E198CD9
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2020 09:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgCaHVD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Mar 2020 03:21:03 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45257 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCaHVC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Mar 2020 03:21:02 -0400
Received: by mail-io1-f67.google.com with SMTP id y14so3527036iol.12
        for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2020 00:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=52yap1u5QwMRqsrXFtOjtT2B5QyIT4tucmUPphiOHrI=;
        b=GTEMTjOKXFybxlRKumEuM4V/PfF6eBoKtww0OsO9YQzyVAdmrNJggQ9yvKE3ewczqJ
         F+jPdYQ3iOHbUnaKd5ChLHGybOJzcn5KN9BElQ8ELug4liXs5Deb1SnBHz0eh7KmudSC
         qAB58ESePxjulAy6d3OajZ3wwhsnemHu/wSAtrk6kIu0VVzJN4CN93CPwecH1RwZfRak
         Ak7V7rGQCPkXfNVvBD2cJyMedHJS93EzOT4liUhD0/bHf0cPG+CIru100SXDPHjlvnLm
         9zi/m/0Td1R6AWxbb5CEkSR+rHvnYLP414D8r8PpT8jXhFEKU9D7vxR//2MBRfgl7EEK
         ITjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=52yap1u5QwMRqsrXFtOjtT2B5QyIT4tucmUPphiOHrI=;
        b=sLwcd2WvOYL4fbSrQbrDVG8Oyu490IPa/hmujWliuwT7vX+/HImhiyrI/pGUACtrJ4
         WLLEGOLttRIOqmWavMFielrs6hUk/uBrOO9RJarwTZ75lvSMvAoNN3qIcpXSqbWT/SxI
         3gaK/F1ZdpTCwwa1wCh/XeYLEOeyFJ7EW6ESV+v5LiRsHucHGEOvWYq0tcplbhidV7+D
         /C8G9O5CkFIsdzM9MRZoxrDtSEVHWOIEAZ2UZzt3NFK/R3O175R/QQ3rkRS2WUChjBSt
         Wu5XIbbeV+OLFyOOXr8ZTag+nVqXVo4Obq6VWBebcorhOO/v8HYA3sLkQbOUBAnV6wW6
         QtSQ==
X-Gm-Message-State: ANhLgQ20heYVp+icg1NdXYiXSf5MZuZwB0QDbRYJ49ub8Zuhr6p3FJuu
        C846+lpfMbe65qcdj4uxtDqHxgjYdh285Fzf/yR2yA==
X-Google-Smtp-Source: ADFU+vsGLU/X7G6MrKpVK698XftSrAYv6eZQKIXo1zyQm2wQUl+il0qTmzzzZLjZ6UV6oJNrdPigOZINLrNoZWrkQJg=
X-Received: by 2002:a6b:2d7:: with SMTP id 206mr14110250ioc.42.1585639260339;
 Tue, 31 Mar 2020 00:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-9-jinpu.wang@cloud.ionos.com> <788b815a-913b-5e4e-4023-585407411b5b@acm.org>
In-Reply-To: <788b815a-913b-5e4e-4023-585407411b5b@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 31 Mar 2020 09:20:49 +0200
Message-ID: <CAMGffEnHp51g8dTObhjYZTwrRLRCcZD9nbNQi1X1a08-Tu+ZLQ@mail.gmail.com>
Subject: Re: [PATCH v11 08/26] RDMA/rtrs: client: sysfs interface functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 31, 2020 at 12:28 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-20 05:16, Jack Wang wrote:
> > +static struct kobj_type ktype = {
> > +     .sysfs_ops = &kobj_sysfs_ops,
> > +};
>
> A release method is missing - please fix this.
>
> Thanks,
>
> Bart.
Sure, will fix it.
Thanks Bart!
