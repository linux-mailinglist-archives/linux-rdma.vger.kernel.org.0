Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801D97A866D
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 16:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbjITOYV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 10:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbjITOYT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 10:24:19 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6313AD
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 07:24:12 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1d544a4a2f2so4348965fac.3
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 07:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1695219852; x=1695824652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t68Gb01cCkeIhgPDRTHOrqsBkZdgukhmiH+2OlNwlQo=;
        b=bLNB11yzpwpaxekyQgT3TiCFpIz06Zo1ASUvG2ZqmTIv0yU85j+F2niyzlE3fuZUbW
         EqDFDYkyoPOCLrxaXj+UX3GwxJDf/gYWKNL/TKRe10Wt/7QHDgpJSZz17C3iyZ3GsxJj
         x4y/KU/csM3z07KH1A+qbsfnIFp/q/UC6KkqsGw4IxuDFsasQU/rcpJTN1fak/eZgjeX
         HIU0oef2T/cg9TRlQoP7tD66QfdbgU8EumI3Ert+2MRPRy6feQAVx4aGAUvVZvDqXapn
         n02pruAV9pxOP13GXxOxTLU9ZJPFuEdPh99uFt3T95DIbWvdldDvSUEV1vAB185Zziqu
         zBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695219852; x=1695824652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t68Gb01cCkeIhgPDRTHOrqsBkZdgukhmiH+2OlNwlQo=;
        b=JoPGPEO0N9Elhjqu6TXihppevJ+vmbltb+n7WWa9Z451e3tfbW8TTTmjSaGi+0hwqb
         vIIUNlX4iBpfA5wUSrsy6Sc2RCTNFmWxtb3nCkcZKlbfTpWDCsu2SgxyMcjEWzqyViXU
         3BDMf6ofcSBXhweQmuHeq2zj9u/0wzFfElG6ocpgpIgk7fwW+qwPiRBZKb8DwJu+lL6K
         vL6nf6e8iqW/AyIuUQ4NcnfYikJL9FDoWzSfpzBQlEPphCOfIuQCda6+2a1OSZa54B7E
         8GbnFiNenpFu/X2Aba/lNwFg4i38AQo2xkzquJVjnyGl0Kyc9zzmX8A1T7pzs7cs0XRQ
         vyJw==
X-Gm-Message-State: AOJu0Yy1Z3VGAOTd/aXPko6PJNnbeeFCwibdXnuoDebqa8H/NAYS7CCJ
        TirZAVq8xjNEhItUinsL1Ix4UqWJdu/TFjoW7gXwEg==
X-Google-Smtp-Source: AGHT+IEvreyRHKyQGORoBAP3w8iX2oNTecxH3BXH0LVdE/rnxhOwA5fbGQNH6r5LLFLQpMr1e+PxCNAbTf+cPymEfKU=
X-Received: by 2002:a05:6870:8294:b0:1bb:9907:451e with SMTP id
 q20-20020a056870829400b001bb9907451emr2996943oae.52.1695219851932; Wed, 20
 Sep 2023 07:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230918142700.12745-1-vitaly@enfabrica.net> <20230919072136.GB4494@unreal>
 <CAF0Wxh=YhKCLbOLZ+-b+_rmzRoWQtqoBGn6Bo9X3zR308Vm1zA@mail.gmail.com>
 <CAF0Wxhkxa1Lk76nnkTQbNL6_v_4amczVd=wodPt00iOU2WB6+w@mail.gmail.com>
 <20230920054452.GH4494@unreal> <20230920125507.GU13733@nvidia.com>
 <CAF0WxhkuN0J3K5tUw0rb3-v=zKPKTh5YcCGSciaBXx9yfN-GEw@mail.gmail.com>
 <20230920131032.GY13733@nvidia.com> <CAF0WxhnXDfXE94O7etK8edWGiA+b4D792sNzz8b7w7H7D_=kvQ@mail.gmail.com>
 <20230920135541.GA13733@nvidia.com>
In-Reply-To: <20230920135541.GA13733@nvidia.com>
From:   Vitaly Mayatskikh <vitaly@enfabrica.net>
Date:   Wed, 20 Sep 2023 10:24:00 -0400
Message-ID: <CAF0WxhnkRsTz_K==6jzkWmggpH+aAXRvWz=2i5==h_thqkYzkQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA/core: use rdma_cap_iw_cm() in rdma_resolve_route()
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        linux-rdma@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Roland Dreier <roland@enfabrica.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 20, 2023 at 9:55=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:

> And what happens if one of your non-standard nodes points its IWCM at
> an IP that is actually running iWarp?

IWCM takes an IP and a port, creates a socket and listens or connects
to that endpoint. It's not like we are hijacking, say, a dedicated
RoCE UDP/4791 port and using it for something else. While the user may
try to connect his app to an arbitrary iWarp listener, it would fail
to negotiate. But that could happen even without us. Similarly our
protocol would fail a negotiation if something else tries to connect
to our listening endpoint.

I think the name causes all this confusion.

Thanks.
