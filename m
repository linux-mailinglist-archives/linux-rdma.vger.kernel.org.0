Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F73F39308
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 19:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbfFGRX5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 13:23:57 -0400
Received: from mail-it1-f172.google.com ([209.85.166.172]:39281 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730717AbfFGRX5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 13:23:57 -0400
Received: by mail-it1-f172.google.com with SMTP id j204so3915459ite.4
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 10:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xD2kr1NRPPCTgnHKdbbrWJtgF05Fn/3EG0cGVN1BQjw=;
        b=ijuxxk9o2FVRb/ON9wwFcuY7VHEG0S22lLODa3cyDdcX01N3a9qWfNZC8MjPNfn0Br
         wnt4EXGtVSM6TWHfvjdzDAAQfs4SaooMpDHyNHvgveS9S8pc11ZCRSRa2RYQFLNwdeT2
         alD9yGfaBEnTxdLzgloVeaV6TfQMJVRJkXBmuNFX9rR3Uzs+MncSaU0nSSpzw4kuP0e/
         7zzQJxaiDtpo+Lo+Qxd8rozlW92iGDuLKFogM28ZeWIGNlG2MyBIiDryxGOxSXDs9DKm
         GkEu9jeebQszwO+LBCOWd0RTrtHOZWGM/X8NpUCr5I6TZXzxn+RCIYgorMEu0PuJ9dVI
         uIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xD2kr1NRPPCTgnHKdbbrWJtgF05Fn/3EG0cGVN1BQjw=;
        b=p8wbU6Mp40+6HcYo56reaDB0qCCyIyn98ZUnDfiM4YBz91mNGm+CAA0nHuZB4yIb8Y
         ZqxGyplfohL6svT9DEWuwog5p6FgXN6LJM86+o3WT/Qdb6DzHLuaFHhntAVsmN7a1Dbm
         aUVOL4j9K48+TkpaxsPMLzWVdxY/KUUXvQcamQdHaKWSX5Mp0+IXtSIVLyi9pCc7gpsv
         jzXQnoHhGCOqdY928Qqn9i/Uezqyiu0W5+j1ggyWUU9lOlod0V1ybYrvCMq329+Wi1Sr
         IeQ6WyYUX4yL78K95lFbm6MRuCfF0WM9P775HBz0r0cveNeypMavPDBmKPH5Jp7ivGZv
         fydA==
X-Gm-Message-State: APjAAAUeTBZb/BrzX9SpNuvYEtsBn82ljwHJUAovOym+3b/yNyBsEEIk
        fD420RvA3NiEcfLDyTQCVpVhrbwVtGzJbZWlpcM=
X-Google-Smtp-Source: APXvYqwIzKLs/HqkbBGZerPr+tDxPB0ZxwhtztucHfjocksYKMyZ4OplKfBgDgTpntfeOssgYmHD2kCKSdVvR1cWDdk=
X-Received: by 2002:a24:f34a:: with SMTP id t10mr4718900iti.129.1559928236467;
 Fri, 07 Jun 2019 10:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190607162430.GL14802@ziepe.ca>
In-Reply-To: <20190607162430.GL14802@ziepe.ca>
From:   Steve Wise <larrystevenwise@gmail.com>
Date:   Fri, 7 Jun 2019 12:23:45 -0500
Message-ID: <CADmRdJfDLp_C+rVuRqDVfDahtcwSDb8HGgR2_SHmbxD3AUghfw@mail.gmail.com>
Subject: Re: RFC: Remove nes
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 7, 2019 at 11:24 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> Since we have gained another two (EFA, SIW) drivers lately, I'd really
> like to remove NES as we have in the past for other drivers.
>
> This hardware was proposed to be removed at the last purge, but I
> think that Steve still wanted to keep it for some reason. I suppose
> that has changed now.
>
> If I recall the reasons for removal were basically:
>  - Does not support modern FRWR, which is now becoming mandatory for ULPs
>  - Does not support 64 bit physical addresses, so is useless on modern
>    servers
>  - Possibly nobody has even loaded the module in years. Wouldn't be
>    surprised to learn it is broken with all the recent churn.
>
> Remarkably there still seem to be cards in ebay though..
>
> Jason

It wasn't me.  Perhaps we were discussing cxgb3 removal?  Anyway, are
you certain it doesn't support REG_MR?    I see support for it in
nes_post_send().
