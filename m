Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C93F7F13C9
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Nov 2023 13:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjKTMwr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Nov 2023 07:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjKTMKr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Nov 2023 07:10:47 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D6AD0
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 04:10:43 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c87adce180so17532741fa.0
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 04:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700482242; x=1701087042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBRIuhjrI5GHv1K2E7ov32HooW3Z1zi4ig29FN2E1LM=;
        b=Ifgco8X7Vghgza8pAoI5MalRg0+w3A/g8HGg64OsXBtez/9LgFAqTTVPiPXcinyq5L
         ASd0sZoKRQQ7/LwSGIw70JVhxqlq3iimA/mdbe4lbI96iS1oXl6roiBst3oIWejMeSCE
         e2jxbz717gYKimzq6lS2hRYw6r2dTvn5O+t9MiqjtQhq7+n4fjkq6rRIdBvbqTRp0Wnp
         5PIhzPI2+AboPYB2OviqDQsbzHRDQ1Yak8ARnWu9FoBxvBKmRSWqFe74SyBOZ50sRRA8
         lHYnoAc84gwymde7v8sEYyQQTib2nYbEjqKsFTOdXrhCLQ3mXcqgTJW/PWVi2w7ZWxnC
         DUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700482242; x=1701087042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBRIuhjrI5GHv1K2E7ov32HooW3Z1zi4ig29FN2E1LM=;
        b=IT17yjGh98S7JBcEGyOiQgL6XJamV8UrGdS5qMtKhBdbTTo/RRRg1iEEemYnfBTnwY
         VoEaFrcWTJrP6GJFxbOiJ45a/kmM1xRn7Fy5w8gyVJlbJcT80V5+VjOseahSKwqfeKn+
         Dg/zACVYOHNqkcDCiLkoWIJY+mazzbjmIVa8pqh31B6VDRKDdoZ7qY9rdN0Jqfv9WyBM
         YbjzBvPveCB6RsXn3mqlPA8cayAQQqCgiJxvqoacn3n94nOckmgr/MxXZ2Dtv9CavxYG
         e8q1g2gflAWW8dcVW0jTDmYGwd2RKx9PIOhSpZRXq50Lt32CGjfbNJQyhGKX2PajCu2N
         nwnw==
X-Gm-Message-State: AOJu0Yzsd/EzInfzdkqrvwOfaXB3tlvm5Ycpy8rS9hKgrXo6uc4qgaQA
        SD71HB2GPXVZkcTn8OFygo3sX7VHq8Fx2/LMuStETQ==
X-Google-Smtp-Source: AGHT+IFhOvntOpVIEDqjA3pIioSGGt3Z8RF/2+oPUp2Je+zds7anbGHHqjBjfO5zuDd2n0b5MsrsSWJPhLoaCt7ihOE=
X-Received: by 2002:a2e:9e8f:0:b0:2c5:3261:615e with SMTP id
 f15-20020a2e9e8f000000b002c53261615emr4872648ljk.35.1700482242025; Mon, 20
 Nov 2023 04:10:42 -0800 (PST)
MIME-Version: 1.0
References: <20231115152749.424301-1-haris.iqbal@ionos.com> <20231119130021.GA15293@unreal>
In-Reply-To: <20231119130021.GA15293@unreal>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 20 Nov 2023 13:10:30 +0100
Message-ID: <CAJpMwyjdG0SSA8WhszMuAoyc-VbY6NyrpiMbv_xR1sui1AxDGA@mail.gmail.com>
Subject: Re: [PATCH for-next 0/9] Misc patches for RTRS
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, jgg@ziepe.ca,
        jinpu.wang@ionos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 19, 2023 at 2:00=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Wed, Nov 15, 2023 at 04:27:40PM +0100, Md Haris Iqbal wrote:
> > Hi Jason, hi Leon,
> >
> > Please consider to include following changes to the next merge window.
> >
> > Jack Wang (4):
> >   RDMA/rtrs-srv: Do not unconditionally enable irq
> >   RDMA/rtrs-clt: Start hb after path_up
> >   RDMA/rtrs-clt: Fix the max_send_wr setting
> >   RDMA/rtrs-clt: Remove the warnings for req in_use check
> >
> > Md Haris Iqbal (4):
> >   RDMA/rtrs-clt: Add warning logs for RDMA events
>
> All these patches, except this one, fix errors and should have Fixes line=
.
> Please add and resubmit.

Sure. Will do. Thanks

>
> I took this warning patch to -next.
>
> Thanks
>
> >   RDMA/rtrs-srv: Check return values while processing info request
> >   RDMA/rtrs-srv: Free srv_mr iu only when always_invalidate is true
> >   RDMA/rtrs-srv: Destroy path files after making sure no IOs in-flight
> >
> > Supriti Singh (1):
> >   RDMA/rtrs: use %pe to print errors
> >
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 15 ++++++-----
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 37 +++++++++++++++++++-------
> >  drivers/infiniband/ulp/rtrs/rtrs.c     |  4 +--
> >  3 files changed, 37 insertions(+), 19 deletions(-)
> >
> > --
> > 2.25.1
> >
