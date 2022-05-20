Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9BF52EEF1
	for <lists+linux-rdma@lfdr.de>; Fri, 20 May 2022 17:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiETPVI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 May 2022 11:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350771AbiETPU7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 May 2022 11:20:59 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947066328
        for <linux-rdma@vger.kernel.org>; Fri, 20 May 2022 08:20:57 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id br17so2581165lfb.2
        for <linux-rdma@vger.kernel.org>; Fri, 20 May 2022 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lfWFCD/MLCq3QolmFfwEH/wdeT7OeQ4Rl+jDXfnY9mQ=;
        b=HPl+FAPN4qTKcyyr2nboQlnck1zhrIwNuNLwTmT9BcLCRvKUKwAD2RdJ1DW4WaZfeS
         /CGstbS/PtcIEiWHVUM85q/quaMhW85U4g9fIN8VfYzyWrzUPIvexgOn/+ZmLKMCK79X
         KKofif8nFZq/4gtXQ5oPDAqw8VH6CZL30PGwXlZIahs4WAaoTxaslePB+8xUKqGRgqZc
         QASNcsJ+zharrlK6QbI7xwVtZ5IaftmJwZ6DAdmdeFUzCXaV5puPoqd46Tq6FFmVWUta
         iF+q4beXaoNcVX7TNVMmN/M2dUFAGqFwefMNjlkgO4mk1h+3C8IwxKpCbqQTXerkHZEG
         Huqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lfWFCD/MLCq3QolmFfwEH/wdeT7OeQ4Rl+jDXfnY9mQ=;
        b=cQsWQ7/lm+rmawmyqySZZcDRNK5GrgW5JzF+MoNdPYR3tNg0whmrArNJqN0cqg5oPn
         ObOAxcPb+pPW5t1lYeY0uG05ssM6AphxvdFoLIbZMbTq2xPRuvvSLHXNGBnPrw96uwUU
         cnmms7skhcpqMlq/dWcB0Iitxtch1/sKh59bxPmI7BdLYDtKGBGlBbz+/zIUsPhmHZAl
         O2/WhkpixcCQjwmuXK5BY95pbEd3NQLz/AbEjrtwFgh/ZGZe0j3QuE5cKTLLmp3Fja9Y
         vnNPz9TRQbBBzzv+/IYmOJh2jBKd8iJOwzJqo3QAFp/pbP6zpYi9yBgFlTT8vS0FOcIc
         zmjA==
X-Gm-Message-State: AOAM530OoufwzpPb7qEYhRM1flr1FfducCDS8KHx2tLbymezcC1TqgLT
        UuIQJSCWrmWITnfTkzaQxWKGbSYhGeSEvRLw0KH3Te4jCmA+Ig==
X-Google-Smtp-Source: ABdhPJz1lSH37fpSxZUXpquesKDqIDKYO+EkSk0cR7PDGX1u0TIjvB/TZnzZOCmKQyYu5sMmotGObTtJE+2kUCG0bmo=
X-Received: by 2002:a05:6512:2254:b0:477:a0e6:ea02 with SMTP id
 i20-20020a056512225400b00477a0e6ea02mr7252919lfu.181.1653060055920; Fri, 20
 May 2022 08:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220520151926.2616318-1-haris.iqbal@ionos.com>
In-Reply-To: <20220520151926.2616318-1-haris.iqbal@ionos.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Fri, 20 May 2022 17:20:44 +0200
Message-ID: <CAJpMwyhKt4rmuTRPMbxkEe1qB6C5Xv==nYz76xvuqdH-u=gOkw@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: For fast memory reg wr set both lkey and rkey
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, jinpu.wang@ionos.com,
        aleksei.marov@ionos.com, danil.kipnis@ionos.com,
        rpearsonhpe@gmail.com
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

On Fri, May 20, 2022 at 5:19 PM Md Haris Iqbal <haris.iqbal@ionos.com> wrote:
>
> Fixes: 001345339f4c ("RDMA/rxe: Separate HW and SW l/rkeys")
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Signed-off-by: Aleksei Marov <aleksei.marov@ionos.com>
> ---
> Cc: rpearsonhpe@gmail.com
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index fc3942e04a1f..04eb804efb23 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -648,7 +648,7 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
>
>         mr->access = access;
>         mr->lkey = (mr->lkey & ~0xff) | key;
> -       mr->rkey = (access & IB_ACCESS_REMOTE) ? mr->lkey : 0;
> +       mr->rkey = mr->lkey;
>         mr->state = RXE_MR_STATE_VALID;
>
>         set = mr->cur_map_set;
> --
> 2.25.1

This code was changed in the below mentioned commit.

commit 001345339f4ca85790a1644a74e33ae77ac116be
Author: Bob Pearson <rpearsonhpe@gmail.com>
Date:   Tue Sep 14 11:42:05 2021 -0500

    RDMA/rxe: Separate HW and SW l/rkeys

    Separate software and simulated hardware lkeys and rkeys for MRs and MWs.
    This makes struct ib_mr and struct ib_mw isolated from hardware changes
    triggered by executing work requests.

    This change fixes a bug seen in blktest.

    Link: https://lore.kernel.org/r/20210914164206.19768-4-rpearsonhpe@gmail.com
    Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
    Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>


After the change, mapping for rnbd/rtrs fails with the following error.

Mapping error,
Client

[Fri May 20 20:27:45 2022] rdma_rxe: qp#17 moved to error state
[Fri May 20 20:27:45 2022] rtrs_server L1211: <blya>: remote access
error (wr_cqe: 000000002d27244a, type: 0, vendor_err: 0x0, len: 0)

Server
[Fri May 20 20:27:45 2022] rnbd_client L597: Mapping device
/dev/nullb0 on session blya, (access_mode: rw, nr_poll_queues: 0)
[Fri May 20 20:27:45 2022] rnbd_client L1208: [session=blya] mapped
4/4 default/read queues.
[Fri May 20 20:27:45 2022] rtrs_client L605: <blya>: RDMA failed:
remote access error
[Fri May 20 20:27:45 2022] rtrs_client L346: <blya>: Failed
IB_WR_LOCAL_INV: WR flushed
[Fri May 20 20:27:45 2022] rtrs_client L605: <blya>: RDMA failed:
remote access error
[Fri May 20 20:27:45 2022] rtrs_client L346: <blya>: Failed
IB_WR_LOCAL_INV: WR flushed
[Fri May 20 20:27:45 2022] rnbd_client L413: </dev/nullb0@blya> read
I/O failed with err: -103
[Fri May 20 20:27:45 2022] I/O error, dev rnbd0, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[Fri May 20 20:27:45 2022] rnbd_client L653: </dev/nullb0@blya> Device
disconnected.
[Fri May 20 20:27:45 2022] Buffer I/O error on dev rnbd0, logical
block 0, async page read
[Fri May 20 20:27:45 2022] rnbd_client L1049: </dev/nullb0@blya> RTRS
failed to transfer IO, err: -103
[Fri May 20 20:27:45 2022] I/O error, dev rnbd0, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[Fri May 20 20:27:45 2022] Buffer I/O error on dev rnbd0, logical
block 0, async page read
[Fri May 20 20:27:45 2022] ldm_validate_partition_table(): Disk read failed.
[Fri May 20 20:27:45 2022] rnbd_client L1049: </dev/nullb0@blya> RTRS
failed to transfer IO, err: -103
[Fri May 20 20:27:45 2022] I/O error, dev rnbd0, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[Fri May 20 20:27:45 2022] Buffer I/O error on dev rnbd0, logical
block 0, async page read
[Fri May 20 20:27:45 2022] rnbd_client L1049: </dev/nullb0@blya> RTRS
failed to transfer IO, err: -103
[Fri May 20 20:27:45 2022] I/O error, dev rnbd0, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[Fri May 20 20:27:45 2022] Buffer I/O error on dev rnbd0, logical
block 0, async page read
[Fri May 20 20:27:45 2022]  rnbd0: unable to read partition table

Error on write
Client
[Fri May 20 20:28:39 2022] rdma_rxe: rxe_invalidate_mr: rkey (0x20416)
doesn't match mr->rkey (0x0)
[Fri May 20 20:28:39 2022] rtrs_client L346: <blya>: Failed
IB_WR_LOCAL_INV: local QP operation error

The code for rnbd/rtrs works fine on mlx4 and mlx5.
From the spec perspective, is there a need for the wr access flag to
be set while doing IB_WR_REG_MR?




>
