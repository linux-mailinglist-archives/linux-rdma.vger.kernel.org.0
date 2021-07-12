Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847583C630D
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jul 2021 20:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbhGLTBM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jul 2021 15:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbhGLTBJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jul 2021 15:01:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02D9C0613DD
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jul 2021 11:58:20 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id o5so36605993ejy.7
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jul 2021 11:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4ZO8u+E+TzLibwpZkzC/1PkoEvhG3uMd5Mx8r41h3c=;
        b=iaC8AkGiaKcl1qo3UW3CMMzhFcKSKIKyrZlsDkec4YW/kgVbn23BTGtRBnpPtlVLv2
         UjqpgRFT+iQYR/aNTv3vW7ae1V+DeJoCNyE8REcjbn3ZTYFj8DLbDv2MmS6J1YAhZpQl
         wI28WnCUXYLct1dQO2w+KoRr/MMxF/8E3cqpap0B9dNuWK7DlXPX5dIpBo65MMjUPmxi
         L1iVrfYUIDp9ouCTqrW1Ue2CdQm5J737kFCs1bqEfC8o2y1qVIsbzXlNOAdQCvJ1xy2/
         r5HyjQ48DXNQ4j3C5p2A+0mSxk0UyBH6g7RFyc81yVxecCnsuq1jfJJmt0AAW+lB1hhA
         LM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4ZO8u+E+TzLibwpZkzC/1PkoEvhG3uMd5Mx8r41h3c=;
        b=Loey9qGyobF+3oSfu2UaEff1CkqQvB0CT7osCq/GJzh3LC6Ml8uehXWpi5FMgNlhe/
         y3Jas/KDjh6e8pzT/tP5zGUyK7ZilvZATjugmRk0tUe0jroC7jAyEw3v427Q3iKuccn5
         E4RfnZHXnRZBwuJUMxx+C6vg54qXiwcJN55v0864O89ROkljFBWyDCVIRvjAXikDtGCu
         oPGnSniLu+fm3rlO0IH1lbGkn+IORlKLK4z4uscRA/Fe9ucbOGz3e8xW8kwMxj47UQiF
         /HOajzL3PagdqlDJWF0WGyMt8u9cbpM+nY2gJew3W8n+9vfzhXe8CK0Lfa/+x/7DJfsk
         uaIA==
X-Gm-Message-State: AOAM530P1gSD+2cJIH59ZW8Ev1ohVO+XjVUmx0BlSsAVAyXe+W/bosOB
        FHKuSOZrS2AszTv5tmXFderVIqA4xv2onvLKsu5CRw==
X-Google-Smtp-Source: ABdhPJxX3slCcyTE/1DTUqUm+CU8VOE815hK4L53mRiWpmz51FaaVcT+pWi4+mApMiiFPzK5GGRumtgbCALr1sZzeWE=
X-Received: by 2002:a17:906:1cd5:: with SMTP id i21mr580234ejh.478.1626116299225;
 Mon, 12 Jul 2021 11:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210712060750.16494-1-jinpu.wang@ionos.com> <20210712173535.GA258722@nvidia.com>
In-Reply-To: <20210712173535.GA258722@nvidia.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 12 Jul 2021 20:58:08 +0200
Message-ID: <CAMGffE=7Ng7Q32EkVSqt8o0wsAHNZCvdz7C4Dc7QWYaJJLStGw@mail.gmail.com>
Subject: Re: [PATCHv2 for-rc 0/6] Bugfixes for send queue overflow by heartbeat
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 12, 2021 at 7:35 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, Jul 12, 2021 at 08:07:44AM +0200, Jack Wang wrote:
> > Hi Jason, hi Doug,
> >
> > Please consider to include following changes to upstream.
> >
> > This patchset fix a regression since b38041d50add ("RDMA/rtrs: Do not signal for heatbeat").
> >
> > In commit b38041d50add, the signal flag is droped to fix the send queue full
> > logic, but introduced a worse bug the send queue overflow on both clt and srv
> > by heartbeat, sorry.
> >
> > The patchset is orgnized as:
> > - patch1 debug patch.
> > - patch2 preparation.
> > - patch3 signal both IO and heartbeat.
> > - patch4 cleanup.
> > - patch5 cleanup
> > - patch6 move sq_wr_avail to account send queue full correctly.
> >
> > The patches are created base v5.14-rc1.
> >
> > Since v1:
> > * rebased to latest v5.14-rc1, target rc instread of for-next.
> >
> > v1: https://lore.kernel.org/linux-rdma/20210629065321.12600-1-jinpu.wang@ionos.com/T/#t
> >
> > Jack Wang (6):
> >   RDMA/rtrs: Add error messages for failed operations.
> >   RDMA/rtrs: move wr_cnt from rtrs_srv_con to rtrs_con
> >   RDMA/rtrs: Enable the same selective signal for heartbeat and IO
> >   RDMA/rtrs: Make rtrs_post_rdma_write_imm_empty static
> >   RDMA/rtrs: Remove unused flags parameter
> >   RDMA/rtrs: Move sq_wr_avail to rtrs_con
>
> This is not really structured well enough for a -rc patch. There
> should be no unncessary changes and each patch should try to be self
> contained. Avoid "cleanup". Carefully describe what user visible
> defect each patch is fixing.
>
> If you really want it to be in -rc then it needs reorganizing,
> otherwise I can put it in -next
>
> Jason
Hi Jason,

Thanks for your suggestion, I think it would be ok to put them in for-next.

Regards!
