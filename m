Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2035A3D56
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Aug 2022 13:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiH1L1W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Aug 2022 07:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiH1L1V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Aug 2022 07:27:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB0333E0B;
        Sun, 28 Aug 2022 04:27:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41AA8B80A3B;
        Sun, 28 Aug 2022 11:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B24C433D6;
        Sun, 28 Aug 2022 11:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661686037;
        bh=+T+VXCGbqcBRZkqPbzhVG8FDgyxjHHnZyu1jX1FLrZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJV+UzqVph2EbNWP6xyq5NiGmcim8Yj9PXeyaS92cE+p+Q4w87U+xAXjihUsmdrRK
         ITbdzTmyW3OOMw+zG4XcBLpFVq6dLJdb+3FaeFJJqmqhUGb96a77YuuC8YM20C1XdD
         9OqAua7OYcy6L4WMBoLLhTiKQRJASgV/3WWl/JV2jM9wmWKFzy+DTWHD3bnkBv9aSd
         LQzRFsl3jdCEerakggkNsSRGMKQV+omUEowH2F+fvjxbbPFw3sp/YApY+LAHfpcBdq
         +fXPYSGJJ1qF9ryD6XW3opYZnDD2ItNHSZjGgqSK0ICi/4bFCpyl4F5gFeVM5NAb+m
         U4T/OCncka22A==
Date:   Sun, 28 Aug 2022 14:27:13 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>, haris.iqbal@ionos.com,
        axboe@kernel.dk, jgg@ziepe.ca, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] rnbd-srv: remove 'dir' argument from rnbd_srv_rdma_ev
Message-ID: <YwtREWKudJ9gVe3t@unreal>
References: <20220826081117.21687-1-guoqing.jiang@linux.dev>
 <CAMGffEku8H3RubkQGq1Cjy8pP8B+95coT+b2J6VxSAQx-kKmmg@mail.gmail.com>
 <aa3a4d50-2e71-a185-09ac-79bd34f9c8e6@linux.dev>
 <CAMGffEkRo104Cp6+KX8NtS0ud+DHM6ftjmHyxjiQa=zJ7tFzog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGffEkRo104Cp6+KX8NtS0ud+DHM6ftjmHyxjiQa=zJ7tFzog@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 26, 2022 at 01:29:28PM +0200, Jinpu Wang wrote:
> On Fri, Aug 26, 2022 at 1:26 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
> >
> >
> >
> > On 8/26/22 6:48 PM, Jinpu Wang wrote:
> > > On Fri, Aug 26, 2022 at 10:11 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
> > >> Since all callers (process_{read,write}) set id->dir, no need to
> > >> pass 'dir' again.
> > >>
> > >> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> > >> ---
> > >>   drivers/block/rnbd/rnbd-srv.c          | 9 ++++-----
> > >>   drivers/block/rnbd/rnbd-srv.h          | 1 +
> > >>   drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
> > >>   drivers/infiniband/ulp/rtrs/rtrs.h     | 3 +--
> > >>   4 files changed, 8 insertions(+), 9 deletions(-)

<...>

> > >>   #include <rtrs.h>
> > >> +#include <rtrs-srv.h>
> > > why do we need this?
> >
> > Otherwise, compiler complains
> >
> > drivers/block/rnbd/rnbd-srv.c: In function ‘rnbd_srv_rdma_ev’:
> > drivers/block/rnbd/rnbd-srv.c:400:33: error: invalid use of undefined
> > type ‘struct rtrs_srv_op’
> >    400 |                         type, id->dir, srv_sess->sessname);
> >
> > Thanks,
> > Guoqing
> ah, okay, this reminds me, why we have dir there, we don't want to
> export too much detail regarding the rtrs_srv_op to
> rnbd-server, it is supposed to be transparent  to rnbd-srv.

So decouple it from rtrs-srv.h and hide everything that not-needed to be
exported to separate header file.

Thanks
