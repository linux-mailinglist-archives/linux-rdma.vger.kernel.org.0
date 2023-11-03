Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C88B7E0064
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Nov 2023 11:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347755AbjKCKRy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Nov 2023 06:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347710AbjKCKRx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Nov 2023 06:17:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F12BD;
        Fri,  3 Nov 2023 03:17:51 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27d0e3d823fso1689732a91.1;
        Fri, 03 Nov 2023 03:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699006670; x=1699611470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhxTJQGMh8ltKKPnPVtqpBjXF5p/wr+ULWRQ+shWLIs=;
        b=lt5HKvyQj6tb1dLamowGMDbzs+Pzo13FDT4fHgNs0kGdM9P+c3G+q43PuyCs+H1364
         QnzkCN3IbRj7Zdv0xpNwNSixv6WzUX1wKv9X0+uOCoGWtySAlYdwdbhtwXBCl57NZMb9
         Irr9N2d0AGkfzFI7sOQFD2zZWAOxpyrcZfFSPyqETyEz+n/WfTlnI1WqSqh494q6RQUx
         5qLxKUD2if6mLV3FtV1T+qYZ2dk+7ypT000lIe9+XA545hsyjYI8G3asRiHjYviMB/LL
         cfoJyHPVHYzg/aabpAb8TmIQl23CeCukTL3y7zME/8MtFh290ySvad6j4l8DJDXollUt
         KtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699006670; x=1699611470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhxTJQGMh8ltKKPnPVtqpBjXF5p/wr+ULWRQ+shWLIs=;
        b=BgNwao285TxlRraB440DtxkLmbOl1yFdJaMgg4Hj9osE8uudZYD0vINUg/8UNmHheQ
         Rywq1QIoPNta+miT2ajbPg6tpVZLkuFk32yZoPXaPtlQWJ+Lnj4W6r84/pixw2cOlVsz
         85YRVK9xGa9fGArrlKIW4Ta0aB4lgyHJsnbKDy2+KzMRhsU5+SRYvRJ33v5Yrb2TCs/j
         TdOsxfMyWFFKnli6O05KH4rrT6Sjtf3Dvu8XvwB8dx1r1xNAKbMpO2Btb7DsVVry1FWC
         j/OVtNyUgG3ZNLcCTLK6Mba551HoLluKyMZV4FRS6MrCqc0VXrtNRqXrOT9qLPx+aMUw
         wP+Q==
X-Gm-Message-State: AOJu0YxwUBbV1iQQQDWdQVe83TXM+1cL4HMCes29jBYnh08Q5lhipcYm
        IDocexVWTaBxzrzuzmOPvH7e7Sw6c4Eb++LYv+k=
X-Google-Smtp-Source: AGHT+IF4Y6zyjw+lVjE6TYLYP5fZ9dRGR/tj0oc+OyQfakp3GSURHGqozYGj/Ftl8MK9cqcBG2P8vlBeMCLvp4joVSo=
X-Received: by 2002:a17:90a:bf07:b0:27d:1df4:26f3 with SMTP id
 c7-20020a17090abf0700b0027d1df426f3mr17225360pjs.15.1699006669939; Fri, 03
 Nov 2023 03:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231103095549.490744-1-lizhijian@fujitsu.com>
In-Reply-To: <20231103095549.490744-1-lizhijian@fujitsu.com>
From:   Greg Sword <gregsword0@gmail.com>
Date:   Fri, 3 Nov 2023 18:17:39 +0800
Message-ID: <CAEz=LcvrztPxSZj5uiaDe-mdC0qD4km07d8aFuVPOb5dgnHNug@mail.gmail.com>
Subject: Re: [PATCH RFC V2 0/6] rxe_map_mr_sg() fix cleanup and refactor
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        rpearsonhpe@gmail.com, matsuda-daisuke@fujitsu.com,
        bvanassche@acm.org, yi.zhang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 3, 2023 at 5:58=E2=80=AFPM Li Zhijian <lizhijian@fujitsu.com> w=
rote:
>
> I don't collect the Reviewed-by to the patch1-2 this time, since i
> think we can make it better.
>
> Patch1-2: Fix kernel panic[1] and benifit to make srp work again.
>           Almost nothing change from V1.
> Patch3-5: cleanups # newly add
> Patch6: make RXE support PAGE_SIZE aligned mr # newly add, but not fully =
tested

Do some work. Do not use these rubbish patch to waste our time.

>
> My bad arm64 mechine offten hangs when doing blktests even though i use t=
he
> default siw driver.
>
> - nvme and ULPs(rtrs, iser) always registers 4K mr still don't supported =
yet.
>
> [1] https://lore.kernel.org/all/CAHj4cs9XRqE25jyVw9rj9YugffLn5+f=3D1znaBE=
nu1usLOciD+g@mail.gmail.com/T/
>
> Li Zhijian (6):
>   RDMA/rxe: RDMA/rxe: don't allow registering !PAGE_SIZE mr
>   RDMA/rxe: set RXE_PAGE_SIZE_CAP to PAGE_SIZE
>   RDMA/rxe: remove unused rxe_mr.page_shift
>   RDMA/rxe: Use PAGE_SIZE and PAGE_SHIFT to extract address from
>     page_list
>   RDMA/rxe: cleanup rxe_mr.{page_size,page_shift}
>   RDMA/rxe: Support PAGE_SIZE aligned MR
>
>  drivers/infiniband/sw/rxe/rxe_mr.c    | 80 ++++++++++++++++-----------
>  drivers/infiniband/sw/rxe/rxe_param.h |  2 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  9 ---
>  3 files changed, 48 insertions(+), 43 deletions(-)
>
> --
> 2.41.0
>
