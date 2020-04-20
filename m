Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CC91B021C
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 09:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgDTHCW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 03:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726006AbgDTHCV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Apr 2020 03:02:21 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A192C061A0C
        for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2020 00:02:20 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z2so5427875iol.11
        for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2020 00:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4A6SxKXFQeFuhZ520Fb1Z9inEFcHWLahAvurgebovF0=;
        b=W+Lw7ol4m5Pp+NIVMJifky+1tJ056gHvBlIzI1UvOcpw8Yumgvyzcvn6nFcbX0LEER
         4fMjbfmI0ptIQDXcBAidLHxY/aCtNggnRh1S3f8/eaaiwmRPXSRuCF/WuC30kAh4UArN
         GSZNpwkC6Zu3V/30Uf7BbKw0qTpeG7BiIAvAZh+LxwJoRTwZ9VsHMo8s5KuXga8TCSAC
         V6S88oFbwUBYh78lEXHzKwrbXir6I4IknN+5PaLhE37DKBv3LC+eQB9c8QCFLcQ2tSRq
         r4WB9ULhz/OUJCfP7bT+4cskcnxNlWXGGo+9tymT11QVCQxs559aGPCS2Js99DEqbPRR
         DN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4A6SxKXFQeFuhZ520Fb1Z9inEFcHWLahAvurgebovF0=;
        b=fzfogwxt9rNobJrINtkCHH6AGHLjDMeqrDWhNBk9RG6hxJAvNoijC/2fadP3QHcfvx
         sFh6SiJ0Jt0mpkQUM5zztQFaxRyxQbRXjjMrN4j6ziaqMIA6Vt+KBLn17uZYUmPr+2jL
         +za35TaT14s44NNuhbRBTM0i6ECjV7nN1H2BePKG9OnyuD9sM9xSyxjljlCp/p8ep0Nu
         Wzn5xRlBd25PkFhiiWi6UelNPdV/Y/HqYg0YIvWI75wuDlCCR+ewgH2Q5XJ8Wzbe9VA4
         Ijc4ZTsXbr0scafA8/I7d602LLXdexzS4e+DwbY6gPqKDH+QJEyfKEt1zbkAUh2Lqktq
         Ibgg==
X-Gm-Message-State: AGi0PuY9W5icGhSKK1smxOJRaw/lwMhojoPG1uqAVDaWrWY4pd5XjCdT
        JeGfrHdddreE0wOVg2FlGNEFEQ7+IBjY7+y3+vSPDw==
X-Google-Smtp-Source: APiQypL3kqmc36Z8nDaWOeggnqdyC0h9bl6lWidbucVAtp/7nrpTjRikTAly3Zvg8/ynoYSstspKecnSjdnY+aEryDM=
X-Received: by 2002:a02:1a82:: with SMTP id 124mr13459829jai.37.1587366139636;
 Mon, 20 Apr 2020 00:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
 <20200415092045.4729-19-danil.kipnis@cloud.ionos.com> <2827b679-70f5-3026-605a-14f2cc89aaab@acm.org>
In-Reply-To: <2827b679-70f5-3026-605a-14f2cc89aaab@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 20 Apr 2020 09:02:11 +0200
Message-ID: <CAMGffEn7JEfoZVopMCZzUEdWWBPG=Y=4P59=5zVm4dy4=agrSg@mail.gmail.com>
Subject: Re: [PATCH v12 18/25] block/rnbd: client: sysfs interface functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 19, 2020 at 1:18 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 4/15/20 2:20 AM, Danil Kipnis wrote:
> > This is the sysfs interface to rnbd block devices on client side:
> >
> >    /sys/class/rnbd-client/ctl/
> >      |- map_device
> >      |  *** maps remote device
> >      |
> >      |- devices/
> >         *** all mapped devices
> >
> >    /sys/block/rnbd<N>/rnbd/
> >      |- unmap_device
> >      |  *** unmaps device
> >      |
> >      |- state
> >      |  *** device state
> >      |
> >      |- session
> >      |  *** session name
> >      |
> >      |- mapping_path
> >         *** path of the dev that was mapped on server
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>
Thanks Bart!
