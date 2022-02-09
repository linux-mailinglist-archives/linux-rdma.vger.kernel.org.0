Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DEB4AF12A
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Feb 2022 13:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiBIMPM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Feb 2022 07:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiBIMPD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Feb 2022 07:15:03 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE7CE02E501
        for <linux-rdma@vger.kernel.org>; Wed,  9 Feb 2022 04:00:45 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m18so3710358lfq.4
        for <linux-rdma@vger.kernel.org>; Wed, 09 Feb 2022 04:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ngSWrl/bllQeQ+OMI30aGiKId41OJoWMFfrtOUdR15w=;
        b=Tshpw5pSHJOX8g60p9rB1nUbWaQFumfsHD1jCU9DLhpDOm8EFfvtc0mxqoXVgmZZ5w
         8G/XKVdq/almjQR2Ig1VZm8K4b4VdpKwBGnqIf7OWYyBSVDJcNAb3iJSPhpASmpyZCYS
         AntxMpncSa5vu7QP9/7q29vFtXfe1fxcfvhfzF9lYikU9JiPAL76XHjcNqjGH2EqZdHt
         9qTIgWu0Fr5jwEAS323Eg8avtp/3CJ00lGjlcDrpw3UDzyZi6eiMD+nDhQ5QJ1HOuXQp
         Cfq6uEdNf2E1rvsEKfHWgp+eEhWXQRY2fCez/zJK7+0acAGittUpevoBbhzrqL53tX9e
         IvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ngSWrl/bllQeQ+OMI30aGiKId41OJoWMFfrtOUdR15w=;
        b=okEJYMU1IhVumXxAsrTic8HiMuuoq3sg/kppuuRvyeGYf6YyDzVPvg6ylvAYgOFfL4
         5sNLcbJAVAKtUSmSw5nkBut627i5/nBwZqRVryJ07ciJMOEWhvfa5CbrjBzrLTs5l9WI
         jTjL9hR+kP3quIdAs8TE7FGVZ0ln8oZWrSC/DtviKkjq+stXBzVtYUq3t24b+6nG6i9h
         0mbE+ULi47/Z/J8JyuaH4Hqvj2hpsnp2q1B0WptnaJ77S0sVxUSEL4zZFpJBFeFzF9GZ
         ePGQIOIosn1tFCJhW27sxSAVN46jkNPdMkzzHiW68z8O6KMHb7zorUlIzIB6Ft9+ufoy
         zPlA==
X-Gm-Message-State: AOAM531QClJHs7ZpKe5ZPjPKe4VyXP2bT1h0S5jjR7VTYQ4ux8hevqyx
        LfMTuPnb49lCRiRCZTXzOh7kAt2bXuTWmpQ6OZSCT/4X9jl3pA==
X-Google-Smtp-Source: ABdhPJwNZobM2f/m6TFPoVziGlvoJBhSdmEkrk4r9w8qpRRHJWWJjpg94TiIdCfZMnM3TAtC7Vj2UQ54GCH2A9IJhok=
X-Received: by 2002:a19:6f0b:: with SMTP id k11mr1383699lfc.303.1644408043429;
 Wed, 09 Feb 2022 04:00:43 -0800 (PST)
MIME-Version: 1.0
References: <20220202150855.445973-1-haris.iqbal@ionos.com> <20220208164835.GA180654@nvidia.com>
In-Reply-To: <20220208164835.GA180654@nvidia.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Wed, 9 Feb 2022 13:00:32 +0100
Message-ID: <CAJpMwyiU_yxgQXugRMF+ifGz3mH=GNherqKDCMVXax6jUp6hdA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] RDMA/rtrs-clt: Fix possible double free in error case
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        jinpu.wang@ionos.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 8, 2022 at 5:48 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Feb 02, 2022 at 04:08:54PM +0100, Md Haris Iqbal wrote:
> > Callback function rtrs_clt_dev_release() for put_device() calls kfree(clt)
> > to free memory. We shouldn't call kfree(clt) again, and we can't use the
> > clt after kfree too.
> >
> > Replace device_register with device_initialize and device_add so that
> > dev_set_name can be used appropriately.
> >
> > Move mutex_destroy to release function so it can be called in alloc_clt err
> > path.
> >
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 37 ++++++++++++++------------
> >  1 file changed, 20 insertions(+), 17 deletions(-)
>
> These patches don't apply, please resend them

Hi Jason,

I tried these 2 patches over wip/jgg-for-next (commit
2f1b2820b546c1eef07d15ed73db4177c0cf6d46) and it applies. Can you
check once more if there is some other issue? Thanks.

>
> Jason
