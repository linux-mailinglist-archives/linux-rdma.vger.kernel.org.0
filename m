Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67AF6295E0
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 11:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiKOKbu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 05:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbiKOKbs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 05:31:48 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF251A83B
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 02:31:47 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d6so23707615lfs.10
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 02:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5uDFbGGKhZ62+GPRWa9/Ll5UJ9P/P/0A7vzrqMy/CeY=;
        b=GtC3jjOrjklsM/k4M0tvN1dap/6pxjeBqbpv1aU9N2lJ6PkZszTiQ5lNcJn4CgPhLd
         HNoRDWt3rlUlCTJpOynPiIkbHe+bnF7F10rJ0ofSOkCXx4nQAXRobpERpx1gVJ6RI8YZ
         sbh9ThUJyoA4YwY6LeWmhVP6yKdAF7CoWRzzSfV3tHnX9ZfXP71tNKMr2uSOpjRZUddZ
         +v/7pl1pMOkeXMRf2BCAg78xwJMO/U750t2TeEKrvsARmtnHjYIbRXAvggA1Gqj5mBbu
         7/TubASxfst1XIPeGyn2S0vmKIkibzyjbtZokdlr+jYIUXwIioba19WiNC/g7/PITZ7m
         82bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5uDFbGGKhZ62+GPRWa9/Ll5UJ9P/P/0A7vzrqMy/CeY=;
        b=D5qisQp/ZwTSPowWABm1R/JyUZDL7ROdTFLGs1UV1wCd60ZmADWJDBnYE+u5p94rAF
         /qtTQJnjzCwW3BtXc4KZh8EjHWrskES/OPdZwCaWFpjn8ojfVVbWLZknQtns4yTA34X8
         ZIdGaJLHI2S98lFelrXaOXajZPqfD2xILM+bNFQRQ/0zpDYg1Mo4SOu4Xs0n/W/uYT0k
         OOH4iECzWtfqQdm+Hp6x3N7YTbBj6E2asQl9fYYiVkpVJiCXQQmZePSX5AeMbaRsKETR
         0NgTCsNVa08QzZnt8TWz0NBeGRTHbqHdasLOGK0UZZxEoXVdlGBa+rTYhdbJRsLqX06a
         fgRw==
X-Gm-Message-State: ANoB5pnLzBx4Rkc07yUasZgibI1wZcVfrwj+ZdepfXruYXJF0BYPA50o
        jpE+uKzxkPhQK7MW3g5Jf9fYb9deLEuslOtjCgVf+Q==
X-Google-Smtp-Source: AA0mqf5lgMxnmHOIhsSdHWeFdti+xl9WvpSYJlk5nNO5scOq4X2wLW0Zkt5kO3WXDXCYGK3rP9WPCQloWpZk1Z1n/vE=
X-Received: by 2002:ac2:4c55:0:b0:4b0:38df:e825 with SMTP id
 o21-20020ac24c55000000b004b038dfe825mr6091315lfk.471.1668508305397; Tue, 15
 Nov 2022 02:31:45 -0800 (PST)
MIME-Version: 1.0
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
 <20221113010823.6436-4-guoqing.jiang@linux.dev> <CAJpMwyhFo2PFMqtz1_BBdNDWyaYYPOMFj7kE0p=16uUQsvmUew@mail.gmail.com>
 <0cea8072-ea26-9031-6f74-8707125e7d15@linux.dev>
In-Reply-To: <0cea8072-ea26-9031-6f74-8707125e7d15@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 15 Nov 2022 11:31:34 +0100
Message-ID: <CAMGffEnNGgXPvh5ESd9SwGG+DM-3J_G-TCSLsw9QK7s_n4zQ-A@mail.gmail.com>
Subject: Re: [PATCH RFC 03/12] RDMA/rtrs-srv: Only close srv_path if it is
 just allocated
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Haris Iqbal <haris.iqbal@ionos.com>, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 15, 2022 at 11:24 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
>
>
> On 11/15/22 12:18 AM, Haris Iqbal wrote:
> > On Sun, Nov 13, 2022 at 2:08 AM Guoqing Jiang<guoqing.jiang@linux.dev>  wrote:
> >> RTRS creates several connections per nr_cpu_ids, it makes more sense
> >> to only close the path when it just allocated.
> >>
> >> Signed-off-by: Guoqing Jiang<guoqing.jiang@linux.dev>
> >> ---
> >>   drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 ++++-
> >>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> >> index 2cc8b423bcaa..063082d29fc6 100644
> >> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> >> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> >> @@ -1833,6 +1833,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
> >>          u16 version, con_num, cid;
> >>          u16 recon_cnt;
> >>          int err = -ECONNRESET;
> >> +       bool alloc_path = false;
> >>
> >>          if (len < sizeof(*msg)) {
> >>                  pr_err("Invalid RTRS connection request\n");
> >> @@ -1906,6 +1907,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
> >>                          pr_err("RTRS server session allocation failed: %d\n", err);
> >>                          goto reject_w_err;
> >>                  }
> >> +               alloc_path = true;
> >>          }
> >>          err = create_con(srv_path, cm_id, cid);
> >>          if (err) {
> >> @@ -1940,7 +1942,8 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
> >>
> >>   close_and_return_err:
> >>          mutex_unlock(&srv->paths_mutex);
> >> -       close_path(srv_path);
> >> +       if (alloc_path)
> >> +               close_path(srv_path);
> > I think the way this is coded is, if there is a problem opening a
> > connection in that srv_path, then it closes that srv_path gracefully,
> > which results in all other connections in that path getting closed,
> > and the IOs being failover'ed to the other path (in case of
> > multipath), and then the client would trigger an auto reconnect.
>
> Could it possible that IO is happening in the previous connection, then
> a later
> failed connection try to close all the connections.

Yes, the idea is if any failure during rdma_connect, we close the full
path and expecting the other healthy path
to take over.
>
> > @Jinpu can shed some more light, what would be the preferred course of
> > action if there is a failure in one connection. To keep the current
> > design or to avoid closing the path in case of a connection issue.
>
> Frankly, I am less confident about this patch and seems it is a rare
> condition.
> Will just drop it for now.
>
> Thanks,
> Guoqing
