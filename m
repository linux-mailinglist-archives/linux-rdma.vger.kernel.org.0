Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCCA3A09A8
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 03:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhFIBzN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 21:55:13 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:41971 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbhFIBzM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 21:55:12 -0400
Received: by mail-ot1-f49.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so22362838oth.8
        for <linux-rdma@vger.kernel.org>; Tue, 08 Jun 2021 18:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nY41TAgBhVKuhczQACpzt7y/lcnGINGPUnyeSFOt8iU=;
        b=Q2REMGxB+IGuoZpoGfb7glhHL13M+sGhQ665TcI8MB9N/nkKW1iliFyDTbFt+lwNOY
         dIW6tUyhoTaQgqCVLvHqBN7aSkeSCMCrGeZolIyv0WLwjQSDDLy4Kjle+ArvpRlXU86k
         tATyAwvm9pjoJGFsLyvT3aSJJuVQ4dVilmNKoQQNA1LlBp18r+GC8mPdKea2jIhO6c8l
         Ti6Dd0r19M28IFt08mcSUcEo/A/m1VbfOmbKulfoTZn5y1Dx6tdr0U8t5DhJvzXu4yZH
         G/00kcPtWZYOytmCUpdBnHfkOfnSV0sDgkzdV8UoufUE5QulpWXl9mzCnoLXbK0agnyg
         pBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nY41TAgBhVKuhczQACpzt7y/lcnGINGPUnyeSFOt8iU=;
        b=kDfrR40q88m3AIknN3XcOBRm7BGZOewmVqblJ4pIEvJaZEhAo0wM0oUUB5ZlcpT5M9
         qET9JAkHDOLQRcTi9W+zlWb0fWuDyx9mVetYTs8nz3gIdGiW0VUsuBbW1U74ZbPdh/ym
         C/bDu7EpX2ZRS5/nQY+PyBhsGo3l4+nxDAtMsaHOVJZ850isxfYHlrHeCGrPFlnufVZj
         SqacK/SVCoo3Y9RQSkmYJLA+geh+lcoBv4HL18lbpSQ/0HMW9TJyOKkYzhM/u3M40zpC
         umZxKCttYS8MztHP7k9WJ7pUPjHjQTkMJ12T4mR1Al9LXeifsfkSkZADrbOyPtG/cNtB
         8VRA==
X-Gm-Message-State: AOAM531MtzpbZCCPFNu2PbhIU4HQa6eiSoDFsizhWHrRTCOQGOX6fbmQ
        hXX2+fH3BZ6pQitmu9kwHbt6SkxTS54fzQQeYgI=
X-Google-Smtp-Source: ABdhPJzX+DW0Q0r3DmnhmpkO0kN/LwMRFt9WcUbUM+vV6Yw9/cSSqIAMqVxsh/BCHcPjfSsqxuYd4FtL/ookI5+FkE8=
X-Received: by 2002:a9d:3e8:: with SMTP id f95mr14057531otf.53.1623203522668;
 Tue, 08 Jun 2021 18:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210608042802.33419-1-rpearsonhpe@gmail.com> <20210608042802.33419-3-rpearsonhpe@gmail.com>
 <CAD=hENc53Loz3vF3xDQNQcrorS_gHtjE0psGODuctDn6c+pAMw@mail.gmail.com>
 <d9eae5b5-8866-b932-9b63-b76b670d52a2@gmail.com> <CAD=hENc06piOhuGPA=WTWqk6prhCa0VyorP1JHRh7+uDpjCGtw@mail.gmail.com>
 <bed5deb9-e2d2-ad23-f96b-4952d98c421f@gmail.com>
In-Reply-To: <bed5deb9-e2d2-ad23-f96b-4952d98c421f@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 9 Jun 2021 09:51:51 +0800
Message-ID: <CAD=hENeAHdeUVKF=4AW59nF0Y8Gdkp_-PJgKQq94XnW_0itNeg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Providers/rxe: Implement memory windows
To:     "Pearson, Robert B" <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Moni Shoua <monis@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 9, 2021 at 7:18 AM Pearson, Robert B <rpearsonhpe@gmail.com> wr=
ote:
>
>
> On 6/8/2021 2:17 AM, Zhu Yanjun wrote:
> > On Tue, Jun 8, 2021 at 3:01 PM Bob Pearson <rpearsonhpe@gmail.com> wrot=
e:
> >> On 6/8/21 1:54 AM, Zhu Yanjun wrote:
> >>> On Tue, Jun 8, 2021 at 12:28 PM Bob Pearson <rpearsonhpe@gmail.com> w=
rote:
> >>>> This patch makes the required changes to the rxe provider to support=
 the
> >>>> kernel memory windows patches to the rxe driver.
> >>>>
> >>>> The following changes are made:
> >>>>    - Add ibv_alloc_mw verb
> >>>>    - Add ibv_dealloc_mw verb
> >>>>    - Add ibv_bind_mw verb for type 1 MWs
> >>>>    - Add support for bind MW send work requests through the traditio=
nal
> >>>>      QP API and the extended QP API.
> >>>>
> >>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >>>> ---
> >>>> v2:
> >>>>    Added support for extended QP bind MW work requests.
> >>> I got the following errors.
> >>> Is it a known issue?
> >>>
> >>> # ./bin/run_tests.py --dev rxe0
> >>> .............sssssssss.............ssssssssssssssssssssssssssssssssss=
ssssssssssssssssssssssssssssssssssssssssssssssss........sssssssssssssssssss=
....ssss.........s...s.....E.......ssssssssss..ss
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> ERROR: test_qp_ex_rc_bind_mw (tests.test_qpex.QpExTestCase)
> >>> Verify bind memory window operation using the new post_send API.
> >>> ---------------------------------------------------------------------=
-
> >>> Traceback (most recent call last):
> >>>    File "/root/rdma-core/tests/test_qpex.py", line 292, in test_qp_ex=
_rc_bind_mw
> >>>      u.poll_cq(server.cq)
> >>>    File "/root/rdma-core/tests/utils.py", line 538, in poll_cq
> >>>      raise PyverbsRDMAError('Completion status is {s}'.
> >>> pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Memory
> >>> window bind error. Errno: 6, No such device or address
> >>>
> >>> ---------------------------------------------------------------------=
-
> >>> Ran 193 tests in 2.544s
> >>>
> >>> FAILED (errors=3D1, skipped=3D128)
> >>>
> >>> Zhu Yanjun
> >> Yes. It is because the test is not setting the BIND_MW access for the =
MR. It is not permitted to bind an MW to a MR that does not have the BIND_M=
W access flag set. But this test mistakenly thinks it is going to work. The=
 other MW tests in test_mr.py do set the BIND_MW access flag.
> > Thanks a lot.
> > If the root cause to this problem is correct, and setting the BIND_MW
> > access for the MR can fix this problem,
> >
> > Please file a commit to fix this problem.
> >
> > I am fine with this MW patch series if all the problems (including
> > rdma-core and rxe in kernel) are fixed.
> >
> > Thanks for your effort.
> >
> > Zhu Yanjun
>
> Zhu,
>
> There was a second test bug, now fixed. And all the python tests are
> passing or skipped. No errors. There is a message to the liux-rdma list
> from Edward Srouji indicating that the patch is upstream at github or
> you can use the one in my email to him. It will be a while until his PR
> goes up stream I would guess.
>
> I sent a fresh set of patches last night for both the kernel and user
> space provider.

Thanks a lot for your effort.

I applied your commits for rdma-core and rxe in kernel, and the following d=
iff.

 All the python tests in rdma-core pass or skipped. No errors

Thanks again.

"
diff --git a/tests/test_qpex.py b/tests/test_qpex.py
index 20288d45..41028e2d 100644
--- a/tests/test_qpex.py
+++ b/tests/test_qpex.py
@@ -146,10 +146,10 @@ class QpExRCAtomicFetchAdd(RCResources):

 class QpExRCBindMw(RCResources):
     def create_qps(self):
-        create_qp_ex(self, e.IBV_QPT_RC, e.IBV_QP_EX_WITH_BIND_MW)
+        create_qp_ex(self, e.IBV_QPT_RC,
e.IBV_QP_EX_WITH_BIND_MW|e.IBV_QP_EX_WITH_RDMA_WRITE)

     def create_mr(self):
-        self.mr =3D u.create_custom_mr(self, e.IBV_ACCESS_REMOTE_WRITE)
+        self.mr =3D u.create_custom_mr(self,
e.IBV_ACCESS_REMOTE_WRITE|e.IBV_ACCESS_MW_BIND)
"

Zhu Yanjun

>
> Bob
>
> >> Bob
> >>>> ---
> >>>>   providers/rxe/rxe.c | 157 ++++++++++++++++++++++++++++++++++++++++=
+++-
> >>>>   1 file changed, 155 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
> >>>> index a68656ae..bb39ef04 100644
> >>>> --- a/providers/rxe/rxe.c
> >>>> +++ b/providers/rxe/rxe.c
> >>>> @@ -128,6 +128,95 @@ static int rxe_dealloc_pd(struct ibv_pd *pd)
> >>>>          return ret;
> >>>>   }
> >>>>
> >>>> +static struct ibv_mw *rxe_alloc_mw(struct ibv_pd *ibpd, enum ibv_mw=
_type type)
> >>>> +{
> >>>> +       int ret;
> >>>> +       struct ibv_mw *ibmw;
> >>>> +       struct ibv_alloc_mw cmd =3D {};
> >>>> +       struct ib_uverbs_alloc_mw_resp resp =3D {};
> >>>> +
> >>>> +       ibmw =3D calloc(1, sizeof(*ibmw));
> >>>> +       if (!ibmw)
> >>>> +               return NULL;
> >>>> +
> >>>> +       ret =3D ibv_cmd_alloc_mw(ibpd, type, ibmw, &cmd, sizeof(cmd)=
,
> >>>> +                                               &resp, sizeof(resp))=
;
> >>>> +       if (ret) {
> >>>> +               free(ibmw);
> >>>> +               return NULL;
> >>>> +       }
> >>>> +
> >>>> +       return ibmw;
> >>>> +}
> >>>> +
> >>>> +static int rxe_dealloc_mw(struct ibv_mw *ibmw)
> >>>> +{
> >>>> +       int ret;
> >>>> +
> >>>> +       ret =3D ibv_cmd_dealloc_mw(ibmw);
> >>>> +       if (ret)
> >>>> +               return ret;
> >>>> +
> >>>> +       free(ibmw);
> >>>> +       return 0;
> >>>> +}
> >>>> +
> >>>> +static int next_rkey(int rkey)
> >>>> +{
> >>>> +       return (rkey & 0xffffff00) | ((rkey + 1) & 0x000000ff);
> >>>> +}
> >>>> +
> >>>> +static int rxe_post_send(struct ibv_qp *ibqp, struct ibv_send_wr *w=
r_list,
> >>>> +                        struct ibv_send_wr **bad_wr);
> >>>> +
> >>>> +static int rxe_bind_mw(struct ibv_qp *ibqp, struct ibv_mw *ibmw,
> >>>> +                       struct ibv_mw_bind *mw_bind)
> >>>> +{
> >>>> +       int ret;
> >>>> +       struct ibv_mw_bind_info *bind_info =3D &mw_bind->bind_info;
> >>>> +       struct ibv_send_wr ibwr;
> >>>> +       struct ibv_send_wr *bad_wr;
> >>>> +
> >>>> +       if (!bind_info->mr && (bind_info->addr || bind_info->length)=
) {
> >>>> +               ret =3D EINVAL;
> >>>> +               goto err;
> >>>> +       }
> >>>> +
> >>>> +       if (bind_info->mw_access_flags & IBV_ACCESS_ZERO_BASED) {
> >>>> +               ret =3D EINVAL;
> >>>> +               goto err;
> >>>> +       }
> >>>> +
> >>>> +       if (bind_info->mr) {
> >>>> +               if (ibmw->pd !=3D bind_info->mr->pd) {
> >>>> +                       ret =3D EPERM;
> >>>> +                       goto err;
> >>>> +               }
> >>>> +       }
> >>>> +
> >>>> +       memset(&ibwr, 0, sizeof(ibwr));
> >>>> +
> >>>> +       ibwr.opcode             =3D IBV_WR_BIND_MW;
> >>>> +       ibwr.next               =3D NULL;
> >>>> +       ibwr.wr_id              =3D mw_bind->wr_id;
> >>>> +       ibwr.send_flags         =3D mw_bind->send_flags;
> >>>> +       ibwr.bind_mw.bind_info  =3D mw_bind->bind_info;
> >>>> +       ibwr.bind_mw.mw         =3D ibmw;
> >>>> +       ibwr.bind_mw.rkey       =3D next_rkey(ibmw->rkey);
> >>>> +
> >>>> +       ret =3D rxe_post_send(ibqp, &ibwr, &bad_wr);
> >>>> +       if (ret)
> >>>> +               goto err;
> >>>> +
> >>>> +       /* user has to undo this if he gets an error wc */
> >>>> +       ibmw->rkey =3D ibwr.bind_mw.rkey;
> >>>> +
> >>>> +       return 0;
> >>>> +err:
> >>>> +       errno =3D ret;
> >>>> +       return errno;
> >>>> +}
> >>>> +
> >>>>   static struct ibv_mr *rxe_reg_mr(struct ibv_pd *pd, void *addr, si=
ze_t length,
> >>>>                                   uint64_t hca_va, int access)
> >>>>   {
> >>>> @@ -715,6 +804,31 @@ static void wr_atomic_fetch_add(struct ibv_qp_e=
x *ibqp, uint32_t rkey,
> >>>>          advance_qp_cur_index(qp);
> >>>>   }
> >>>>
> >>>> +static void wr_bind_mw(struct ibv_qp_ex *ibqp, struct ibv_mw *ibmw,
> >>>> +                      uint32_t rkey, const struct ibv_mw_bind_info =
*info)
> >>>> +{
> >>>> +       struct rxe_qp *qp =3D container_of(ibqp, struct rxe_qp, vqp.=
qp_ex);
> >>>> +       struct rxe_send_wqe *wqe =3D addr_from_index(qp->sq.queue, q=
p->cur_index);
> >>>> +
> >>>> +       if (check_qp_queue_full(qp))
> >>>> +               return;
> >>>> +
> >>>> +       memset(wqe, 0, sizeof(*wqe));
> >>>> +
> >>>> +       wqe->wr.wr_id =3D ibqp->wr_id;
> >>>> +       wqe->wr.opcode =3D IBV_WR_BIND_MW;
> >>>> +       wqe->wr.send_flags =3D qp->vqp.qp_ex.wr_flags;
> >>>> +       wqe->wr.wr.mw.addr =3D info->addr;
> >>>> +       wqe->wr.wr.mw.length =3D info->length;
> >>>> +       wqe->wr.wr.mw.mr_lkey =3D info->mr->lkey;
> >>>> +       wqe->wr.wr.mw.mw_rkey =3D ibmw->rkey;
> >>>> +       wqe->wr.wr.mw.rkey =3D rkey;
> >>>> +       wqe->wr.wr.mw.access =3D info->mw_access_flags;
> >>>> +       wqe->ssn =3D qp->ssn++;
> >>>> +
> >>>> +       advance_qp_cur_index(qp);
> >>>> +}
> >>>> +
> >>>>   static void wr_local_inv(struct ibv_qp_ex *ibqp, uint32_t invalida=
te_rkey)
> >>>>   {
> >>>>          struct rxe_qp *qp =3D container_of(ibqp, struct rxe_qp, vqp=
.qp_ex);
> >>>> @@ -1106,6 +1220,7 @@ enum {
> >>>>                  | IBV_QP_EX_WITH_ATOMIC_CMP_AND_SWP
> >>>>                  | IBV_QP_EX_WITH_ATOMIC_FETCH_AND_ADD
> >>>>                  | IBV_QP_EX_WITH_LOCAL_INV
> >>>> +               | IBV_QP_EX_WITH_BIND_MW
> >>>>                  | IBV_QP_EX_WITH_SEND_WITH_INV,
> >>>>
> >>>>          RXE_SUP_UC_QP_SEND_OPS_FLAGS =3D
> >>>> @@ -1113,6 +1228,7 @@ enum {
> >>>>                  | IBV_QP_EX_WITH_RDMA_WRITE_WITH_IMM
> >>>>                  | IBV_QP_EX_WITH_SEND
> >>>>                  | IBV_QP_EX_WITH_SEND_WITH_IMM
> >>>> +               | IBV_QP_EX_WITH_BIND_MW
> >>>>                  | IBV_QP_EX_WITH_SEND_WITH_INV,
> >>>>
> >>>>          RXE_SUP_UD_QP_SEND_OPS_FLAGS =3D
> >>>> @@ -1162,6 +1278,9 @@ static void set_qp_send_ops(struct rxe_qp *qp,=
 uint64_t flags)
> >>>>          if (flags & IBV_QP_EX_WITH_ATOMIC_FETCH_AND_ADD)
> >>>>                  qp->vqp.qp_ex.wr_atomic_fetch_add =3D wr_atomic_fet=
ch_add;
> >>>>
> >>>> +       if (flags & IBV_QP_EX_WITH_BIND_MW)
> >>>> +               qp->vqp.qp_ex.wr_bind_mw =3D wr_bind_mw;
> >>>> +
> >>>>          if (flags & IBV_QP_EX_WITH_LOCAL_INV)
> >>>>                  qp->vqp.qp_ex.wr_local_inv =3D wr_local_inv;
> >>>>
> >>>> @@ -1275,9 +1394,10 @@ static int rxe_destroy_qp(struct ibv_qp *ibqp=
)
> >>>>   }
> >>>>
> >>>>   /* basic sanity checks for send work request */
> >>>> -static int validate_send_wr(struct rxe_wq *sq, struct ibv_send_wr *=
ibwr,
> >>>> +static int validate_send_wr(struct rxe_qp *qp, struct ibv_send_wr *=
ibwr,
> >>>>                              unsigned int length)
> >>>>   {
> >>>> +       struct rxe_wq *sq =3D &qp->sq;
> >>>>          enum ibv_wr_opcode opcode =3D ibwr->opcode;
> >>>>
> >>>>          if (ibwr->num_sge > sq->max_sge)
> >>>> @@ -1291,11 +1411,26 @@ static int validate_send_wr(struct rxe_wq *s=
q, struct ibv_send_wr *ibwr,
> >>>>          if ((ibwr->send_flags & IBV_SEND_INLINE) && (length > sq->m=
ax_inline))
> >>>>                  return -EINVAL;
> >>>>
> >>>> +       if (ibwr->opcode =3D=3D IBV_WR_BIND_MW) {
> >>>> +               if (length)
> >>>> +                       return -EINVAL;
> >>>> +               if (ibwr->num_sge)
> >>>> +                       return -EINVAL;
> >>>> +               if (ibwr->imm_data)
> >>>> +                       return -EINVAL;
> >>>> +               if ((qp_type(qp) !=3D IBV_QPT_RC) &&
> >>>> +                   (qp_type(qp) !=3D IBV_QPT_UC))
> >>>> +                       return -EINVAL;
> >>>> +       }
> >>>> +
> >>>>          return 0;
> >>>>   }
> >>>>
> >>>>   static void convert_send_wr(struct rxe_send_wr *kwr, struct ibv_se=
nd_wr *uwr)
> >>>>   {
> >>>> +       struct ibv_mw *ibmw;
> >>>> +       struct ibv_mr *ibmr;
> >>>> +
> >>>>          memset(kwr, 0, sizeof(*kwr));
> >>>>
> >>>>          kwr->wr_id              =3D uwr->wr_id;
> >>>> @@ -1326,6 +1461,18 @@ static void convert_send_wr(struct rxe_send_w=
r *kwr, struct ibv_send_wr *uwr)
> >>>>                  kwr->wr.atomic.rkey             =3D uwr->wr.atomic.=
rkey;
> >>>>                  break;
> >>>>
> >>>> +       case IBV_WR_BIND_MW:
> >>>> +               ibmr =3D uwr->bind_mw.bind_info.mr;
> >>>> +               ibmw =3D uwr->bind_mw.mw;
> >>>> +
> >>>> +               kwr->wr.mw.addr =3D uwr->bind_mw.bind_info.addr;
> >>>> +               kwr->wr.mw.length =3D uwr->bind_mw.bind_info.length;
> >>>> +               kwr->wr.mw.mr_lkey =3D ibmr->lkey;
> >>>> +               kwr->wr.mw.mw_rkey =3D ibmw->rkey;
> >>>> +               kwr->wr.mw.rkey =3D uwr->bind_mw.rkey;
> >>>> +               kwr->wr.mw.access =3D uwr->bind_mw.bind_info.mw_acce=
ss_flags;
> >>>> +               break;
> >>>> +
> >>>>          default:
> >>>>                  break;
> >>>>          }
> >>>> @@ -1348,6 +1495,8 @@ static int init_send_wqe(struct rxe_qp *qp, st=
ruct rxe_wq *sq,
> >>>>          if (ibwr->send_flags & IBV_SEND_INLINE) {
> >>>>                  uint8_t *inline_data =3D wqe->dma.inline_data;
> >>>>
> >>>> +               wqe->dma.resid =3D 0;
> >>>> +
> >>>>                  for (i =3D 0; i < num_sge; i++) {
> >>>>                          memcpy(inline_data,
> >>>>                                 (uint8_t *)(long)ibwr->sg_list[i].ad=
dr,
> >>>> @@ -1363,6 +1512,7 @@ static int init_send_wqe(struct rxe_qp *qp, st=
ruct rxe_wq *sq,
> >>>>                  wqe->iova       =3D ibwr->wr.atomic.remote_addr;
> >>>>          else
> >>>>                  wqe->iova       =3D ibwr->wr.rdma.remote_addr;
> >>>> +
> >>>>          wqe->dma.length         =3D length;
> >>>>          wqe->dma.resid          =3D length;
> >>>>          wqe->dma.num_sge        =3D num_sge;
> >>>> @@ -1385,7 +1535,7 @@ static int post_one_send(struct rxe_qp *qp, st=
ruct rxe_wq *sq,
> >>>>          for (i =3D 0; i < ibwr->num_sge; i++)
> >>>>                  length +=3D ibwr->sg_list[i].length;
> >>>>
> >>>> -       err =3D validate_send_wr(sq, ibwr, length);
> >>>> +       err =3D validate_send_wr(qp, ibwr, length);
> >>>>          if (err) {
> >>>>                  printf("validate send failed\n");
> >>>>                  return err;
> >>>> @@ -1579,6 +1729,9 @@ static const struct verbs_context_ops rxe_ctx_=
ops =3D {
> >>>>          .dealloc_pd =3D rxe_dealloc_pd,
> >>>>          .reg_mr =3D rxe_reg_mr,
> >>>>          .dereg_mr =3D rxe_dereg_mr,
> >>>> +       .alloc_mw =3D rxe_alloc_mw,
> >>>> +       .dealloc_mw =3D rxe_dealloc_mw,
> >>>> +       .bind_mw =3D rxe_bind_mw,
> >>>>          .create_cq =3D rxe_create_cq,
> >>>>          .create_cq_ex =3D rxe_create_cq_ex,
> >>>>          .poll_cq =3D rxe_poll_cq,
> >>>> --
> >>>> 2.30.2
> >>>>
