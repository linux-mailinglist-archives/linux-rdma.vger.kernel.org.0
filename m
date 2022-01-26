Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFBA49CBA9
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jan 2022 14:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiAZN4o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jan 2022 08:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbiAZN4o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jan 2022 08:56:44 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22DCC06161C
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jan 2022 05:56:43 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b9so14102171lfq.6
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jan 2022 05:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0CP07NJDfA56jMdBeJt5jTXRvbItGIdDjvqsnKOcIaM=;
        b=PiPkJZXZH29JVBYrBw/RB2zddWBoLRT5/QLnayl9M+m3Ix0V25URQl+gIMdAjzmqrV
         XH4/fZV6EtOaKI80rTPNqFGomFz4UVcfNUO+tJsK6+72JTgRJKyfcO+gskDNSHOBaG5P
         JR6slVXl3h6tixN8zfgfe/rb40h/IqYJWARk1Cs3H1iZblQoMCwJiEHGnipWfMfL+rwu
         sQJM/+l2tBaExPdI47b1VKntmlza3BWwJh608Anz944V8DSF/Dvx9tm93kKXj8gX9COe
         GFZmr36RRTXbSHktL/46dSJIPt0VhfWPIbf3Jd+VBHeaZoZLIgk1Zm/jFBsg98pNqfec
         GT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0CP07NJDfA56jMdBeJt5jTXRvbItGIdDjvqsnKOcIaM=;
        b=UGW+DNdO+lKRR4n7EUhDO5BMCn947ocCHk5RabII+nzhGURuiwmgQODHTwt98DP6hH
         l7/mSHH0zTU+rMQX3K49ZdVeEKPOQQHGtZ3rkSqT3+yCl6BtS8fVNWv8egKhrMnSRHAl
         MMuQdbrLuGVhfo5gDWReJmcTxJ8v9vngCBFVrUyZEJBym2p41A/uBgdnvXDysl/LNn6L
         QwtYbr45CQ5VpH5oAi78rqdg7+okSgJ+mKcevP20VDXKbhEraN4u8Xf4retamR3dbT3I
         YaUOPSkp9PSZpK8XTTLCQXgHxnNEuJrOWJ/Tl3CV+fm+YkpZayzUmySAtCVkHPpxvkQG
         hC6w==
X-Gm-Message-State: AOAM5302HBUfe10YzYKnae1sXFMehYeIOMEXj2V57XT4j+gSn7Ddu5QK
        jS+U2W/N4O1+ygvD9gWDCFsU2KU209SjavhRB8u3OttpLmI=
X-Google-Smtp-Source: ABdhPJy42jkB3JP8j2KEmistXFY3vGNkXyemr3mfmfihsg8mNZ2RcI/ItXv2H8KgGuZEhDIwRZkc5DK+OAjhcpgpkns=
X-Received: by 2002:ac2:5f4f:: with SMTP id 15mr11101746lfz.321.1643205401942;
 Wed, 26 Jan 2022 05:56:41 -0800 (PST)
MIME-Version: 1.0
References: <20220114154753.983568-1-haris.iqbal@ionos.com>
In-Reply-To: <20220114154753.983568-1-haris.iqbal@ionos.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Wed, 26 Jan 2022 14:56:31 +0100
Message-ID: <CAJpMwyhEK8gKNebu91da+1=GzvKAktxbt2D9hrqRyxFOULvRgQ@mail.gmail.com>
Subject: Re: [PATCH for-next 0/5] Misc update for RTRS
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, jinpu.wang@ionos.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 14, 2022 at 4:48 PM Md Haris Iqbal <haris.iqbal@ionos.com> wrote:
>
> Hi Jason, hi Doug,
>
> Please consider to include following changes to the next merge window.

Ping.

>
> The patchset is organized as:
> - patch1, patch2, patch3 fixes warnings generated from checkpatch
> - patch4 updates a comment.
> - patch5 In case of error, performs failover earlier & avoids deadlock
>
> Gioh Kim (3):
>   RDMA/rtrs: fix CHECK:BRACES type warning
>   RDMA/rtrs-clt: fix CHECK type warnings
>   RDMA/rtrs-clt: fix CHECK type warnings
>
> Jack Wang (2):
>   RDMA/rtrs-clt: Update one outdated comment in path_it_deinit
>   RDMA/rtrs-clt: Do stop and failover outside reconnect work.
>
>  drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c |  3 +-
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 91 ++++++++++----------
>  drivers/infiniband/ulp/rtrs/rtrs-clt.h       |  1 +
>  drivers/infiniband/ulp/rtrs/rtrs.c           |  1 -
>  4 files changed, 47 insertions(+), 49 deletions(-)
>
> --
> 2.25.1
>
