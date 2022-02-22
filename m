Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42804BF558
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Feb 2022 11:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiBVKFA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Feb 2022 05:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiBVKE7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Feb 2022 05:04:59 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDFF70060
        for <linux-rdma@vger.kernel.org>; Tue, 22 Feb 2022 02:04:34 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id d23so23643832lfv.13
        for <linux-rdma@vger.kernel.org>; Tue, 22 Feb 2022 02:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xfF9N3OmFd+6P47AWhMijcXnt+InU/M3lOL8JwbVWZs=;
        b=edeyeJfN6yfBuASAy1hgwCefMNALgcdXX6fL/ryZv69CNX6yLIlzhzk7sQ709H44n9
         hz6Z/KObMuI5hrSNwDUZIIHD2H59E2GF7F4zM3Qlc7h9nn0OGe1NLfECG6AcYTdWIwnt
         wjC+Vd3Nsc3i0j8AUberUzEHefUg6mw4VvOoIrzYPf27SV6KKYFqeii/1/dWtUsuXhIG
         pu6T58XommLGf2/CWl2J68GJfdMBCVHWKV2noZy1pp6ahgPJBgum1E9LXckhXVB7INpl
         3JaXbCxauC6YuCtRXpupPPjWWG6GyskxvVYg+OyYnvtBZTpNTQBXyUONQj0v50mcVtA+
         XVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xfF9N3OmFd+6P47AWhMijcXnt+InU/M3lOL8JwbVWZs=;
        b=vwdE3WjsgewjJ6/+TbNhSToJr4yN9JeCiLZPOQ4AEvcgkmeNTWzVPHmtcswGU5pFWa
         7qwSfCn/OdVDc/EoEhX6WlVTRjp8raGglDE1NXRf1oldXuHld/8/vJFu/mrdIz8eis7R
         83wIS7lzjMFQCwCLGqXrgtPIb2YB/jboL869GjzBaCQ+0v9YwH26GZjAZijy9jDWL1FZ
         xsiFlepIgwRXDawjPf9ZELa+UnhTFEVi7HgTh9nTnkFCw13DZ9uqBKlb4IJVYbwgFGNx
         5HZC1ixeKyJ+cf4ssC9PltOpppDEU56TuxvvK4r+1VynYR+4pzd8ZcVpfMDtm/lAe5bP
         wu0w==
X-Gm-Message-State: AOAM530zCisMhsJJmdpZzDKCosTm6AMLKtPOPAFV0MX4bbPhbNymYoS7
        ikFvrSwAc9hhuLERleik9pIxzbR8lToM6aHMPLs=
X-Google-Smtp-Source: ABdhPJwC2DCYgb7EwrbDwTehSUszarR9gnmNtYtaE88+kjod1WvrFh5fzp9O8iiSVCU9MTfmNJNbvYxMVn3JV4kJKaY=
X-Received: by 2002:a05:6512:1697:b0:443:7f7a:e60a with SMTP id
 bu23-20020a056512169700b004437f7ae60amr16746135lfb.281.1645524272422; Tue, 22
 Feb 2022 02:04:32 -0800 (PST)
MIME-Version: 1.0
References: <20220210073655.42281-1-guoqing.jiang@linux.dev> <473a53b6-9ab2-0d48-a9cf-c84b8dc4c3f3@linux.dev>
In-Reply-To: <473a53b6-9ab2-0d48-a9cf-c84b8dc4c3f3@linux.dev>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 22 Feb 2022 18:04:20 +0800
Message-ID: <CAD=hENeU=cf4_AZPYBDke-kv3Lv3+AUkkEjZm4Drkc6YLJOeLQ@mail.gmail.com>
Subject: Re: bug report for rxe
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 22, 2022 at 5:50 PM Guoqing Jiang <guoqing.jiang@linux.dev> wro=
te:
>
>
>
> On 2/10/22 3:36 PM, Guoqing Jiang wrote:
> > However, seems rnbd/rtrs over rxe still can't work with 5.17-rc3 kernel=
,
> > dmesg reports below.
> >
> > 1. server side
> >
> > [  440.723182] rdma_rxe: qp#17 moved to error state
> > [  440.725300] rtrs_server L1205: <bla>: remote access error (wr_cqe: 0=
00000003b14397c, type: 0, vendor_err: 0x0, len: 0)
> > [  440.845926] rnbd_server L256: RTRS Session bla disconnected
> >
> > 2. client side
> >
> > [  997.817536] rnbd_client L596: Mapping device /dev/loop1 on session b=
la, (access_mode: rw, nr_poll_queues: 0)
> > [  998.968810] rnbd_client L1213: [session=3Dbla] mapped 8/8 default/re=
ad queues.
> > [  999.017988] rtrs_client L610: <bla>: RDMA failed: remote access erro=
r
> > [ 1029.836943] rtrs_client L353: <bla>: Failed IB_WR_LOCAL_INV: WR flus=
he
> >
> > Then I tried 5.16 and 5.15 version, seems 5.15 does work as follows.
> >
> > 1. server side
> >
> > [  333.076482] rnbd_server L800: </dev/loop1@bla>: Opened device 'loop1=
'
> >
> > 2. client side
> >
> > [ 1584.325825] rnbd_client L596: Mapping device /dev/loop1 on session b=
la, (access_mode: rw, nr_poll_queues: 0)
> > [ 1585.268291] rnbd_client L1213: [session=3Dbla] mapped 8/8 default/re=
ad queues.
> > [ 1585.349300] rnbd_client L1607: </dev/loop1@bla> map_device: Device m=
apped as rnbd0 (nsectors: 0, logical_block_size: 512, physical_block_size: =
512, max_write_same_sectors: 0, max_discard_sectors: 0, discard_granularity=
: 0, discard_alignment: 0, secure_discard: 0, max_segments: 128, max_hw_sec=
tors: 248, rotational: 1, wc: 0, fua: 0)
> >
> > I would appreciate if someone shed light on why it doesn't work after 5=
.15,
> > And I am happy to test potential patch for it.
>
> After investigation, seems the culprit is commit 647bf13ce944 ("RDMA/rxe:
> Create duplicate mapping tables for FMRs"). The problem is mr_check_range
> returns -EFAULT after find iova and length are not valid, so connection
> between
> two VMs can't be established.
>
> Revert the commit manually or apply below temporary change,  rxe works ag=
ain
> with rnbd/rtrs though I don't think it is the right thing to do. Could
> experts provide
> a proper solution? Thanks.
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c
> b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 453ef3c9d535..4a2fc4d5809d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -652,7 +652,7 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct
> rxe_send_wqe *wqe)
>          mr->state =3D RXE_MR_STATE_VALID;
>
>          set =3D mr->cur_map_set;
> -       mr->cur_map_set =3D mr->next_map_set;
> +       //mr->cur_map_set =3D mr->next_map_set;
>          mr->cur_map_set->iova =3D wqe->wr.wr.reg.mr->iova;
>          mr->next_map_set =3D set;
>
> @@ -662,7 +662,7 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct
> rxe_send_wqe *wqe)
>   int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr)
>   {
>          struct rxe_mr *mr =3D to_rmr(ibmr);
> -       struct rxe_map_set *set =3D mr->next_map_set;
> +       struct rxe_map_set *set =3D mr->cur_map_set;
>          struct rxe_map *map;
>          struct rxe_phys_buf *buf;
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c
> b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 80df9a8f71a1..e41d2c8612d8 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -992,7 +992,7 @@ static int rxe_map_mr_sg(struct ib_mr *ibmr, struct
> scatterlist *sg,
>                           int sg_nents, unsigned int *sg_offset)
>   {
>          struct rxe_mr *mr =3D to_rmr(ibmr);
> -       struct rxe_map_set *set =3D mr->next_map_set;
> +       struct rxe_map_set *set =3D mr->cur_map_set;

Thanks a lot. Please file a patch for the above changes.

Zhu Yanjun

>
> And the test is pretty simple.
>
> 1.  VM (server)
>
> modprobe rdma_rxe
> rdma link add rxe0 type rxe netdev ens3
> modprobe rnbd-server
>
> 2.  VM (client)
>
> modprobe rdma_rxe
> rdma link add rxe0 type rxe netdev ens3
> modprobe rnbd-client
> echo "sessname=3Dbla path=3Dip:$serverip
> device_path=3D$block_device_in_server" >
> /sys/devices/virtual/rnbd-client/ctl/map_device
>
> BTW, I tried wip/jgg-for-next branch with commit 3810c1a1cbe8f.
>
> Guoqing
