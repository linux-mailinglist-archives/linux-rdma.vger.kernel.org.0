Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF56739EF5D
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 09:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhFHHT4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 03:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHHT4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 03:19:56 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D19EC061574
        for <linux-rdma@vger.kernel.org>; Tue,  8 Jun 2021 00:18:03 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id d27-20020a4a3c1b0000b029024983ef66dbso1995072ooa.3
        for <linux-rdma@vger.kernel.org>; Tue, 08 Jun 2021 00:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RTayCiCJ0JeIdSSM8GeKCXPRKUITIcEqfncDrttAZ0c=;
        b=qEEKFHQSVtlaBMrxigfQ0d7CgJuaHlauoqWJ0a2tiNKygK6osyvk+hd+nng9BDIGaA
         xN1hUnpUAOgNGIPnhiEWcj907QgIqlq6eaSDJeTkRX0YmNN2qrDCQqDbZ2DPFjnlk4Vf
         xgDbpIkyYLotT6RQebSAkp3RkfaeGwe6OO64xjpKIh5tgu+Bo7BWhL2Dvi8TeqWtmb8p
         hFFcUsAcMVdvsyYhx+6uOasLjj1E5rfE4+WYl9sNj3CEwLt2Fe/TkRmPwXl+KaF9lETf
         3EMOKandfJ3itmhb81z3DGJQK2yL5PoLSE75dy0r2gtmJNXU8aIVRE1XlC0p1TOkYop9
         PnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RTayCiCJ0JeIdSSM8GeKCXPRKUITIcEqfncDrttAZ0c=;
        b=bp2sdpyysJ0v5fuWT2D7uVxY9lCfO9ip5QK2MI5zmsZ1pGF4fJeQV0/G/oezHO9A5C
         hKcvX7ycC/I61j0gyt0NGOFLawgMcx/SXJjWX4pB5PQjb6PUqAa1KaFmyeBAkGH3MDZ1
         Gcd2Am2eaC7fQdk8U8/MpTkMV29WcJUBpdcrL4eQELoQXOEOi/Kgu6hV9xGCWw5TeebP
         I5HgeePauxn4IMOU03osNgiySdYMMGhCPnq39dbNIkIw0JKOmWZgSOt7/6nhnhSYpcif
         20ZpafVlytoxiMinxE6onE9RAvCIcsRX53ci00oLxP55RdendNyrsTV/sqojJJx4tZ1b
         uGOQ==
X-Gm-Message-State: AOAM531vJNU4e4yTw8ofFYuSPsY2bL6AH9nKV02rPsSZy1kHH9H3OHk6
        6r9Ot0oeNKMLeIvu7/CfKwrv4DZC49/t3pTuxiY=
X-Google-Smtp-Source: ABdhPJw9dXSIoBh6N4TgTIYwxiD/eGB5BQKujFMdQfaO0kbXW/fL7qjfC38/dO7uKy41sQWaC8NAwB35VW1DQJ0qBx4=
X-Received: by 2002:a4a:b202:: with SMTP id d2mr16267863ooo.13.1623136683020;
 Tue, 08 Jun 2021 00:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210608042802.33419-1-rpearsonhpe@gmail.com> <20210608042802.33419-3-rpearsonhpe@gmail.com>
 <CAD=hENc53Loz3vF3xDQNQcrorS_gHtjE0psGODuctDn6c+pAMw@mail.gmail.com> <d9eae5b5-8866-b932-9b63-b76b670d52a2@gmail.com>
In-Reply-To: <d9eae5b5-8866-b932-9b63-b76b670d52a2@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 8 Jun 2021 15:17:51 +0800
Message-ID: <CAD=hENc06piOhuGPA=WTWqk6prhCa0VyorP1JHRh7+uDpjCGtw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Providers/rxe: Implement memory windows
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Moni Shoua <monis@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 8, 2021 at 3:01 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 6/8/21 1:54 AM, Zhu Yanjun wrote:
> > On Tue, Jun 8, 2021 at 12:28 PM Bob Pearson <rpearsonhpe@gmail.com> wro=
te:
> >>
> >> This patch makes the required changes to the rxe provider to support t=
he
> >> kernel memory windows patches to the rxe driver.
> >>
> >> The following changes are made:
> >>   - Add ibv_alloc_mw verb
> >>   - Add ibv_dealloc_mw verb
> >>   - Add ibv_bind_mw verb for type 1 MWs
> >>   - Add support for bind MW send work requests through the traditional
> >>     QP API and the extended QP API.
> >>
> >> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >> ---
> >> v2:
> >>   Added support for extended QP bind MW work requests.
> >
> > I got the following errors.
> > Is it a known issue?
> >
> > # ./bin/run_tests.py --dev rxe0
> > .............sssssssss.............ssssssssssssssssssssssssssssssssssss=
ssssssssssssssssssssssssssssssssssssssssssssss........sssssssssssssssssss..=
..ssss.........s...s.....E.......ssssssssss..ss
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > ERROR: test_qp_ex_rc_bind_mw (tests.test_qpex.QpExTestCase)
> > Verify bind memory window operation using the new post_send API.
> > ----------------------------------------------------------------------
> > Traceback (most recent call last):
> >   File "/root/rdma-core/tests/test_qpex.py", line 292, in test_qp_ex_rc=
_bind_mw
> >     u.poll_cq(server.cq)
> >   File "/root/rdma-core/tests/utils.py", line 538, in poll_cq
> >     raise PyverbsRDMAError('Completion status is {s}'.
> > pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Memory
> > window bind error. Errno: 6, No such device or address
> >
> > ----------------------------------------------------------------------
> > Ran 193 tests in 2.544s
> >
> > FAILED (errors=3D1, skipped=3D128)
> >
> > Zhu Yanjun
> Yes. It is because the test is not setting the BIND_MW access for the MR.=
 It is not permitted to bind an MW to a MR that does not have the BIND_MW a=
ccess flag set. But this test mistakenly thinks it is going to work. The ot=
her MW tests in test_mr.py do set the BIND_MW access flag.

Thanks a lot.
If the root cause to this problem is correct, and setting the BIND_MW
access for the MR can fix this problem,

Please file a commit to fix this problem.

I am fine with this MW patch series if all the problems (including
rdma-core and rxe in kernel) are fixed.

Thanks for your effort.

Zhu Yanjun

> Bob
> >
> >> ---
> >>  providers/rxe/rxe.c | 157 +++++++++++++++++++++++++++++++++++++++++++=
-
> >>  1 file changed, 155 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
> >> index a68656ae..bb39ef04 100644
> >> --- a/providers/rxe/rxe.c
> >> +++ b/providers/rxe/rxe.c
> >> @@ -128,6 +128,95 @@ static int rxe_dealloc_pd(struct ibv_pd *pd)
> >>         return ret;
> >>  }
> >>
> >> +static struct ibv_mw *rxe_alloc_mw(struct ibv_pd *ibpd, enum ibv_mw_t=
ype type)
> >> +{
> >> +       int ret;
> >> +       struct ibv_mw *ibmw;
> >> +       struct ibv_alloc_mw cmd =3D {};
> >> +       struct ib_uverbs_alloc_mw_resp resp =3D {};
> >> +
> >> +       ibmw =3D calloc(1, sizeof(*ibmw));
> >> +       if (!ibmw)
> >> +               return NULL;
> >> +
> >> +       ret =3D ibv_cmd_alloc_mw(ibpd, type, ibmw, &cmd, sizeof(cmd),
> >> +                                               &resp, sizeof(resp));
> >> +       if (ret) {
> >> +               free(ibmw);
> >> +               return NULL;
> >> +       }
> >> +
> >> +       return ibmw;
> >> +}
> >> +
> >> +static int rxe_dealloc_mw(struct ibv_mw *ibmw)
> >> +{
> >> +       int ret;
> >> +
> >> +       ret =3D ibv_cmd_dealloc_mw(ibmw);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       free(ibmw);
> >> +       return 0;
> >> +}
> >> +
> >> +static int next_rkey(int rkey)
> >> +{
> >> +       return (rkey & 0xffffff00) | ((rkey + 1) & 0x000000ff);
> >> +}
> >> +
> >> +static int rxe_post_send(struct ibv_qp *ibqp, struct ibv_send_wr *wr_=
list,
> >> +                        struct ibv_send_wr **bad_wr);
> >> +
> >> +static int rxe_bind_mw(struct ibv_qp *ibqp, struct ibv_mw *ibmw,
> >> +                       struct ibv_mw_bind *mw_bind)
> >> +{
> >> +       int ret;
> >> +       struct ibv_mw_bind_info *bind_info =3D &mw_bind->bind_info;
> >> +       struct ibv_send_wr ibwr;
> >> +       struct ibv_send_wr *bad_wr;
> >> +
> >> +       if (!bind_info->mr && (bind_info->addr || bind_info->length)) =
{
> >> +               ret =3D EINVAL;
> >> +               goto err;
> >> +       }
> >> +
> >> +       if (bind_info->mw_access_flags & IBV_ACCESS_ZERO_BASED) {
> >> +               ret =3D EINVAL;
> >> +               goto err;
> >> +       }
> >> +
> >> +       if (bind_info->mr) {
> >> +               if (ibmw->pd !=3D bind_info->mr->pd) {
> >> +                       ret =3D EPERM;
> >> +                       goto err;
> >> +               }
> >> +       }
> >> +
> >> +       memset(&ibwr, 0, sizeof(ibwr));
> >> +
> >> +       ibwr.opcode             =3D IBV_WR_BIND_MW;
> >> +       ibwr.next               =3D NULL;
> >> +       ibwr.wr_id              =3D mw_bind->wr_id;
> >> +       ibwr.send_flags         =3D mw_bind->send_flags;
> >> +       ibwr.bind_mw.bind_info  =3D mw_bind->bind_info;
> >> +       ibwr.bind_mw.mw         =3D ibmw;
> >> +       ibwr.bind_mw.rkey       =3D next_rkey(ibmw->rkey);
> >> +
> >> +       ret =3D rxe_post_send(ibqp, &ibwr, &bad_wr);
> >> +       if (ret)
> >> +               goto err;
> >> +
> >> +       /* user has to undo this if he gets an error wc */
> >> +       ibmw->rkey =3D ibwr.bind_mw.rkey;
> >> +
> >> +       return 0;
> >> +err:
> >> +       errno =3D ret;
> >> +       return errno;
> >> +}
> >> +
> >>  static struct ibv_mr *rxe_reg_mr(struct ibv_pd *pd, void *addr, size_=
t length,
> >>                                  uint64_t hca_va, int access)
> >>  {
> >> @@ -715,6 +804,31 @@ static void wr_atomic_fetch_add(struct ibv_qp_ex =
*ibqp, uint32_t rkey,
> >>         advance_qp_cur_index(qp);
> >>  }
> >>
> >> +static void wr_bind_mw(struct ibv_qp_ex *ibqp, struct ibv_mw *ibmw,
> >> +                      uint32_t rkey, const struct ibv_mw_bind_info *i=
nfo)
> >> +{
> >> +       struct rxe_qp *qp =3D container_of(ibqp, struct rxe_qp, vqp.qp=
_ex);
> >> +       struct rxe_send_wqe *wqe =3D addr_from_index(qp->sq.queue, qp-=
>cur_index);
> >> +
> >> +       if (check_qp_queue_full(qp))
> >> +               return;
> >> +
> >> +       memset(wqe, 0, sizeof(*wqe));
> >> +
> >> +       wqe->wr.wr_id =3D ibqp->wr_id;
> >> +       wqe->wr.opcode =3D IBV_WR_BIND_MW;
> >> +       wqe->wr.send_flags =3D qp->vqp.qp_ex.wr_flags;
> >> +       wqe->wr.wr.mw.addr =3D info->addr;
> >> +       wqe->wr.wr.mw.length =3D info->length;
> >> +       wqe->wr.wr.mw.mr_lkey =3D info->mr->lkey;
> >> +       wqe->wr.wr.mw.mw_rkey =3D ibmw->rkey;
> >> +       wqe->wr.wr.mw.rkey =3D rkey;
> >> +       wqe->wr.wr.mw.access =3D info->mw_access_flags;
> >> +       wqe->ssn =3D qp->ssn++;
> >> +
> >> +       advance_qp_cur_index(qp);
> >> +}
> >> +
> >>  static void wr_local_inv(struct ibv_qp_ex *ibqp, uint32_t invalidate_=
rkey)
> >>  {
> >>         struct rxe_qp *qp =3D container_of(ibqp, struct rxe_qp, vqp.qp=
_ex);
> >> @@ -1106,6 +1220,7 @@ enum {
> >>                 | IBV_QP_EX_WITH_ATOMIC_CMP_AND_SWP
> >>                 | IBV_QP_EX_WITH_ATOMIC_FETCH_AND_ADD
> >>                 | IBV_QP_EX_WITH_LOCAL_INV
> >> +               | IBV_QP_EX_WITH_BIND_MW
> >>                 | IBV_QP_EX_WITH_SEND_WITH_INV,
> >>
> >>         RXE_SUP_UC_QP_SEND_OPS_FLAGS =3D
> >> @@ -1113,6 +1228,7 @@ enum {
> >>                 | IBV_QP_EX_WITH_RDMA_WRITE_WITH_IMM
> >>                 | IBV_QP_EX_WITH_SEND
> >>                 | IBV_QP_EX_WITH_SEND_WITH_IMM
> >> +               | IBV_QP_EX_WITH_BIND_MW
> >>                 | IBV_QP_EX_WITH_SEND_WITH_INV,
> >>
> >>         RXE_SUP_UD_QP_SEND_OPS_FLAGS =3D
> >> @@ -1162,6 +1278,9 @@ static void set_qp_send_ops(struct rxe_qp *qp, u=
int64_t flags)
> >>         if (flags & IBV_QP_EX_WITH_ATOMIC_FETCH_AND_ADD)
> >>                 qp->vqp.qp_ex.wr_atomic_fetch_add =3D wr_atomic_fetch_=
add;
> >>
> >> +       if (flags & IBV_QP_EX_WITH_BIND_MW)
> >> +               qp->vqp.qp_ex.wr_bind_mw =3D wr_bind_mw;
> >> +
> >>         if (flags & IBV_QP_EX_WITH_LOCAL_INV)
> >>                 qp->vqp.qp_ex.wr_local_inv =3D wr_local_inv;
> >>
> >> @@ -1275,9 +1394,10 @@ static int rxe_destroy_qp(struct ibv_qp *ibqp)
> >>  }
> >>
> >>  /* basic sanity checks for send work request */
> >> -static int validate_send_wr(struct rxe_wq *sq, struct ibv_send_wr *ib=
wr,
> >> +static int validate_send_wr(struct rxe_qp *qp, struct ibv_send_wr *ib=
wr,
> >>                             unsigned int length)
> >>  {
> >> +       struct rxe_wq *sq =3D &qp->sq;
> >>         enum ibv_wr_opcode opcode =3D ibwr->opcode;
> >>
> >>         if (ibwr->num_sge > sq->max_sge)
> >> @@ -1291,11 +1411,26 @@ static int validate_send_wr(struct rxe_wq *sq,=
 struct ibv_send_wr *ibwr,
> >>         if ((ibwr->send_flags & IBV_SEND_INLINE) && (length > sq->max_=
inline))
> >>                 return -EINVAL;
> >>
> >> +       if (ibwr->opcode =3D=3D IBV_WR_BIND_MW) {
> >> +               if (length)
> >> +                       return -EINVAL;
> >> +               if (ibwr->num_sge)
> >> +                       return -EINVAL;
> >> +               if (ibwr->imm_data)
> >> +                       return -EINVAL;
> >> +               if ((qp_type(qp) !=3D IBV_QPT_RC) &&
> >> +                   (qp_type(qp) !=3D IBV_QPT_UC))
> >> +                       return -EINVAL;
> >> +       }
> >> +
> >>         return 0;
> >>  }
> >>
> >>  static void convert_send_wr(struct rxe_send_wr *kwr, struct ibv_send_=
wr *uwr)
> >>  {
> >> +       struct ibv_mw *ibmw;
> >> +       struct ibv_mr *ibmr;
> >> +
> >>         memset(kwr, 0, sizeof(*kwr));
> >>
> >>         kwr->wr_id              =3D uwr->wr_id;
> >> @@ -1326,6 +1461,18 @@ static void convert_send_wr(struct rxe_send_wr =
*kwr, struct ibv_send_wr *uwr)
> >>                 kwr->wr.atomic.rkey             =3D uwr->wr.atomic.rke=
y;
> >>                 break;
> >>
> >> +       case IBV_WR_BIND_MW:
> >> +               ibmr =3D uwr->bind_mw.bind_info.mr;
> >> +               ibmw =3D uwr->bind_mw.mw;
> >> +
> >> +               kwr->wr.mw.addr =3D uwr->bind_mw.bind_info.addr;
> >> +               kwr->wr.mw.length =3D uwr->bind_mw.bind_info.length;
> >> +               kwr->wr.mw.mr_lkey =3D ibmr->lkey;
> >> +               kwr->wr.mw.mw_rkey =3D ibmw->rkey;
> >> +               kwr->wr.mw.rkey =3D uwr->bind_mw.rkey;
> >> +               kwr->wr.mw.access =3D uwr->bind_mw.bind_info.mw_access=
_flags;
> >> +               break;
> >> +
> >>         default:
> >>                 break;
> >>         }
> >> @@ -1348,6 +1495,8 @@ static int init_send_wqe(struct rxe_qp *qp, stru=
ct rxe_wq *sq,
> >>         if (ibwr->send_flags & IBV_SEND_INLINE) {
> >>                 uint8_t *inline_data =3D wqe->dma.inline_data;
> >>
> >> +               wqe->dma.resid =3D 0;
> >> +
> >>                 for (i =3D 0; i < num_sge; i++) {
> >>                         memcpy(inline_data,
> >>                                (uint8_t *)(long)ibwr->sg_list[i].addr,
> >> @@ -1363,6 +1512,7 @@ static int init_send_wqe(struct rxe_qp *qp, stru=
ct rxe_wq *sq,
> >>                 wqe->iova       =3D ibwr->wr.atomic.remote_addr;
> >>         else
> >>                 wqe->iova       =3D ibwr->wr.rdma.remote_addr;
> >> +
> >>         wqe->dma.length         =3D length;
> >>         wqe->dma.resid          =3D length;
> >>         wqe->dma.num_sge        =3D num_sge;
> >> @@ -1385,7 +1535,7 @@ static int post_one_send(struct rxe_qp *qp, stru=
ct rxe_wq *sq,
> >>         for (i =3D 0; i < ibwr->num_sge; i++)
> >>                 length +=3D ibwr->sg_list[i].length;
> >>
> >> -       err =3D validate_send_wr(sq, ibwr, length);
> >> +       err =3D validate_send_wr(qp, ibwr, length);
> >>         if (err) {
> >>                 printf("validate send failed\n");
> >>                 return err;
> >> @@ -1579,6 +1729,9 @@ static const struct verbs_context_ops rxe_ctx_op=
s =3D {
> >>         .dealloc_pd =3D rxe_dealloc_pd,
> >>         .reg_mr =3D rxe_reg_mr,
> >>         .dereg_mr =3D rxe_dereg_mr,
> >> +       .alloc_mw =3D rxe_alloc_mw,
> >> +       .dealloc_mw =3D rxe_dealloc_mw,
> >> +       .bind_mw =3D rxe_bind_mw,
> >>         .create_cq =3D rxe_create_cq,
> >>         .create_cq_ex =3D rxe_create_cq_ex,
> >>         .poll_cq =3D rxe_poll_cq,
> >> --
> >> 2.30.2
> >>
>
