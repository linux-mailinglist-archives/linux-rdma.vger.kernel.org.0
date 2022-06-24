Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F38F55A24C
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jun 2022 22:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiFXUCz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jun 2022 16:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiFXUCy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jun 2022 16:02:54 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12472E1
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jun 2022 13:02:52 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id k10so2649277qke.9
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jun 2022 13:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2KuDrUGfC0NyhxoJcZ2k1B1TtEnyHemTa91iZtRfz4E=;
        b=ZsOpPlHevv0NiqmAGBY3OjaytNAJl0C/+WAf6u8gBYwEirFX98ok6HrZ1cAXEILaA7
         CFMsOf6R1CnmHUVihv6ll5nxlpoVlaNuqIBN9BFOz+rOjpjnOf84Ey9Cn0HxpG0k0XR2
         tvb7sefiCiZdhExa3D0fcXd94PnZXA4s70zJPeZ6GaUGkseMKBpxlDNnpElyXuOWRfiG
         tK26FmL7Ge/KcJQookKdQxec4nsNsVo6Fv/Zv4DoERFXR5Qvgm3ijZwJZ53RZ6MUfCDC
         o/ij+AFGXhXiaxGeYp7ExExu2mDTDk1s88PpJIl+V4Qfdp0kL9wUmd7eqpHhV5nUcpWG
         tS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2KuDrUGfC0NyhxoJcZ2k1B1TtEnyHemTa91iZtRfz4E=;
        b=tmxYw5uAYQIoaQVERgG4rs13hqVq+1YXKc38KhKwUTJyFAIIE8MhDM2CX/ZdqCHzk9
         ZUNxNrMApUHLXWPfajtdkJWNRF+ITCS3IC6FvHBzJ2J9T9tzbB5EIGrPSX+D6Ci/4z6V
         hU2+XweEe5kiIXXsRu3PMxlf/Yi/Hr0sRLW4FHyN4tNjYwsMJoLrJJussRxhsMVzlRUV
         B0bQe4ttl4MPCHlSdu9ONj14YRsKgEqcCgFIVnOWH6g/45z3Z0k+SH63kQVYT1raNffA
         O4v39iqO9538OKXafIUiGmQQpaHDga8MNytmNCAYF4lTZObyy47j8tYwciUfPQmbWJt/
         ayyQ==
X-Gm-Message-State: AJIora8HU1RsS2Yh15VLEB4DkLXzbPL6sHfbHCQWILgtsP1kmreHoc2v
        7F1vT8TECgHY9nmf02voeLM8aw==
X-Google-Smtp-Source: AGRyM1tgKkFj2VGE4eJ7hCld1VdIScG93fbL2P5rf1O3nalHYr1i3axwe8uknbnEoONQW4ZeEjK1/g==
X-Received: by 2002:a05:620a:4502:b0:6a6:deef:75ac with SMTP id t2-20020a05620a450200b006a6deef75acmr735476qkp.69.1656100971504;
        Fri, 24 Jun 2022 13:02:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id g1-20020ac87f41000000b002f93554c009sm2002629qtk.59.2022.06.24.13.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 13:02:50 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o4pVy-001Bmx-1x; Fri, 24 Jun 2022 17:02:50 -0300
Date:   Fri, 24 Jun 2022 17:02:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     haris iqbal <haris.phnx@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        zyjzyj2000@gmail.com, haris.iqbal@ionos.com,
        Jinpu Wang <jinpu.wang@ionos.com>, aleksei.marov@ionos.com,
        rpearsonhpe@gmail.com
Subject: Re: [PATCH v2] RDMA/rxe: Split rxe_invalidate_mr into local and
 remote versions
Message-ID: <20220624200250.GC23621@ziepe.ca>
References: <20220616140908.666092-1-haris.phnx@gmail.com>
 <CAE_WKMypM1pTCpQV_yJUwa9DzVZnB9grCM=kiVt_6m3HD98eiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE_WKMypM1pTCpQV_yJUwa9DzVZnB9grCM=kiVt_6m3HD98eiA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 22, 2022 at 04:12:01PM +0200, haris iqbal wrote:
> On Thu, Jun 16, 2022 at 4:09 PM Md Haris Iqbal <haris.phnx@gmail.com> wrote:
> >
> > Currently rxe_invalidate_mr does invalidate for both local ops, and remote
> > ones. This means that MR being invalidated is compared with rkey for both,
> > which is incorrect. For local invalidate, comparison should happen with
> > lkey, and for the remote one, it should happen with rkey.
> >
> > This commit splits the rxe_invalidate_mr into local and remote versions.
> > Each of them does comparison the right way as described above (with lkey
> > for local, and rkey for remote).
> >
> > Fixes: 3902b429ca14 ("RDMA/rxe: Implement invalidate MW operations")
> > Cc: rpearsonhpe@gmail.com
> > Signed-off-by: Md Haris Iqbal <haris.phnx@gmail.com>

> ping.

The commit message makes sense to me - is anyone else working on rxe
going to test or review this patch?

There are now many patches for rxe that I would like the rxe community
to mutually review/test/ack.

Jason
