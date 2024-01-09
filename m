Return-Path: <linux-rdma+bounces-572-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F5582830B
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jan 2024 10:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019781F26605
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jan 2024 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023B9224F8;
	Tue,  9 Jan 2024 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtHxUBpo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF331A78;
	Tue,  9 Jan 2024 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6daa822be30so1067445b3a.0;
        Tue, 09 Jan 2024 01:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704792185; x=1705396985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuWSks78Z0o6mI32QotCsxg/ocEMZdYWbJwzCbUnYZA=;
        b=HtHxUBpoXbzoM0LtQiQ0U6EnNOozJZR9lB5oXxMgDIhxLtjA6gXWOfxf/kldlcUndN
         oE3ZAlPm1PRFqxjMmYcPhEdRUc92RiWkHDFzEEwAbdjLSv3W5geNnihHUQ8svV4AGhBF
         PiPaBTv5plBrjeSpgRw8EmhEfj5T1DLEt6ovbdSkpD8U9WDnezuTfYfGV1h7nXp2aVPu
         6Noa5sDnlRYXfDs6afiFmQl+qGQRMSx37dE3gjUVyeOP18rNm6wp9z/VSnyGXCWhIgqU
         fDVkDhYSV7bXRsUT/wx6kYfa9jln29ibQbxCLeQl42Vf7XdfMXNU1xYrIS1OHdedBlPw
         sYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704792185; x=1705396985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuWSks78Z0o6mI32QotCsxg/ocEMZdYWbJwzCbUnYZA=;
        b=loJh1HXVgljm1nkrPsIxhwU9GNYhQgSzpILidqhIs78+a00p85LJ96cMcZlMHFo6au
         GvxhrRzRQM0HZZN/5Ob675OS+B0CmleSEBN6sVZ6S8QcWkZwTEf/OMJwH5yN2BsQHDp/
         Wn+tu9qohF9KH25fTJtJ6MJnlbQ77PNWknZFzZtz27ZLsQXfrkBZdlWU0vuoFxYbmNVP
         X0ocdFEHD6Qwg7R3Kh/WAVVaHFUKG3Sn0U9vKhz62ElfvHQYrzS2nrvR4QO1Qka6LfTE
         w/t0DQ/oSZsxWrEV7nJcv86/iQiCNmnNGMBkVeLQSKpg28OGQ8rfJI/qS4/fhk+ZpGCk
         Mcnw==
X-Gm-Message-State: AOJu0Yx1MCPJAKgPCh9g0HK2cH9byOOYDFKoz16aA33QDRxSIv1vyR41
	K45TKFq6b6qrIXmtLG/U7M2Qlzx3hfedhq40RT0=
X-Google-Smtp-Source: AGHT+IFPeE5hIKwIAfUYx3e2S5ot5XCJ+2YarbwqycwqsD7g67r4P6J2hu3lMYsB2BuNEaphhtVdm28GvIBtPvWb2yk=
X-Received: by 2002:a62:ae0e:0:b0:6d0:8595:ab0c with SMTP id
 q14-20020a62ae0e000000b006d08595ab0cmr2302989pff.52.1704792184886; Tue, 09
 Jan 2024 01:23:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109083253.3629967-1-lizhijian@fujitsu.com>
In-Reply-To: <20240109083253.3629967-1-lizhijian@fujitsu.com>
From: Greg Sword <gregsword0@gmail.com>
Date: Tue, 9 Jan 2024 17:22:52 +0800
Message-ID: <CAEz=LctxCYGuRBgKoGWbGjJVhBwuQika0wYY3k9KeYqNAb74WQ@mail.gmail.com>
Subject: Re: [PATCH for-next v4 1/2] RDMA/rxe: Improve newline in printing messages
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com, jgg@ziepe.ca, 
	leon@kernel.org, linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com, 
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 4:42=E2=80=AFPM Li Zhijian <lizhijian@fujitsu.com> w=
rote:
>
> Previously rxe_{dbg,info,err}() macros are appended built-in newline,
> but some users will add redundant newline sometimes. So remove the
> built-in newline for these macros.

Trivial commits.

>
> In terms of rxe_{dbg,info,err}_xxx() macros, because they don't have
> built-in newline, append newline when using them.
>
> CC: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> Reviewed-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> Feel free to pick this one independently.
>
> I have used below script to verify if all of them are cleanup:
>  git grep -n -E "rxe_info.*\"|rxe_err.*\"|rxe_dbg.*\"" drivers/infiniband=
/sw/rxe/ | grep -v '\\n'
>
> V4: rebase to rdma/for-next 20240109
> V3: rebase to rdma/for-next
> ---
>  drivers/infiniband/sw/rxe/rxe.c       |   6 +-
>  drivers/infiniband/sw/rxe/rxe.h       |   6 +-
>  drivers/infiniband/sw/rxe/rxe_comp.c  |   4 +-
>  drivers/infiniband/sw/rxe/rxe_cq.c    |   4 +-
>  drivers/infiniband/sw/rxe/rxe_mr.c    |  16 +-
>  drivers/infiniband/sw/rxe/rxe_mw.c    |   2 +-
>  drivers/infiniband/sw/rxe/rxe_qp.c    |   8 +-
>  drivers/infiniband/sw/rxe/rxe_resp.c  |  12 +-
>  drivers/infiniband/sw/rxe/rxe_task.c  |   4 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 216 +++++++++++++-------------
>  10 files changed, 139 insertions(+), 139 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/=
rxe.c
> index 54c723a6edda..a086d588e159 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -161,7 +161,7 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int nd=
ev_mtu)
>         port->attr.active_mtu =3D mtu;
>         port->mtu_cap =3D ib_mtu_enum_to_int(mtu);
>
> -       rxe_info_dev(rxe, "Set mtu to %d", port->mtu_cap);
> +       rxe_info_dev(rxe, "Set mtu to %d\n", port->mtu_cap)
>  }
>
>  /* called by ifc layer to create new rxe device.
> @@ -181,7 +181,7 @@ static int rxe_newlink(const char *ibdev_name, struct=
 net_device *ndev)
>         int err =3D 0;
>
>         if (is_vlan_dev(ndev)) {
> -               rxe_err("rxe creation allowed on top of a real device onl=
y");
> +               rxe_err("rxe creation allowed on top of a real device onl=
y\n");
>                 err =3D -EPERM;
>                 goto err;
>         }
> @@ -189,7 +189,7 @@ static int rxe_newlink(const char *ibdev_name, struct=
 net_device *ndev)
>         rxe =3D rxe_get_dev_from_net(ndev);
>         if (rxe) {
>                 ib_device_put(&rxe->ib_dev);
> -               rxe_err_dev(rxe, "already configured on %s", ndev->name);
> +               rxe_err_dev(rxe, "already configured on %s\n", ndev->name=
);
>                 err =3D -EEXIST;
>                 goto err;
>         }
> diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/=
rxe.h
> index d33dd6cf83d3..d8fb2c7af30a 100644
> --- a/drivers/infiniband/sw/rxe/rxe.h
> +++ b/drivers/infiniband/sw/rxe/rxe.h
> @@ -38,7 +38,7 @@
>
>  #define RXE_ROCE_V2_SPORT              (0xc000)
>
> -#define rxe_dbg(fmt, ...) pr_debug("%s: " fmt "\n", __func__, ##__VA_ARG=
S__)
> +#define rxe_dbg(fmt, ...) pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
>  #define rxe_dbg_dev(rxe, fmt, ...) ibdev_dbg(&(rxe)->ib_dev,           \
>                 "%s: " fmt, __func__, ##__VA_ARGS__)
>  #define rxe_dbg_uc(uc, fmt, ...) ibdev_dbg((uc)->ibuc.device,          \
> @@ -58,7 +58,7 @@
>  #define rxe_dbg_mw(mw, fmt, ...) ibdev_dbg((mw)->ibmw.device,          \
>                 "mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARG=
S__)
>
> -#define rxe_err(fmt, ...) pr_err_ratelimited("%s: " fmt "\n", __func__, =
\
> +#define rxe_err(fmt, ...) pr_err_ratelimited("%s: " fmt, __func__, \
>                                         ##__VA_ARGS__)
>  #define rxe_err_dev(rxe, fmt, ...) ibdev_err_ratelimited(&(rxe)->ib_dev,=
 \
>                 "%s: " fmt, __func__, ##__VA_ARGS__)
> @@ -79,7 +79,7 @@
>  #define rxe_err_mw(mw, fmt, ...) ibdev_err_ratelimited((mw)->ibmw.device=
, \
>                 "mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARG=
S__)
>
> -#define rxe_info(fmt, ...) pr_info_ratelimited("%s: " fmt "\n", __func__=
, \
> +#define rxe_info(fmt, ...) pr_info_ratelimited("%s: " fmt, __func__, \
>                                         ##__VA_ARGS__)
>  #define rxe_info_dev(rxe, fmt, ...) ibdev_info_ratelimited(&(rxe)->ib_de=
v, \
>                 "%s: " fmt, __func__, ##__VA_ARGS__)
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw=
/rxe/rxe_comp.c
> index d0bdc2d8adc8..b78b8c0856ab 100644
> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -433,7 +433,7 @@ static void make_send_cqe(struct rxe_qp *qp, struct r=
xe_send_wqe *wqe,
>                 }
>         } else {
>                 if (wqe->status !=3D IB_WC_WR_FLUSH_ERR)
> -                       rxe_err_qp(qp, "non-flush error status =3D %d",
> +                       rxe_err_qp(qp, "non-flush error status =3D %d\n",
>                                 wqe->status);
>         }
>  }
> @@ -582,7 +582,7 @@ static int flush_send_wqe(struct rxe_qp *qp, struct r=
xe_send_wqe *wqe)
>
>         err =3D rxe_cq_post(qp->scq, &cqe, 0);
>         if (err)
> -               rxe_dbg_cq(qp->scq, "post cq failed, err =3D %d", err);
> +               rxe_dbg_cq(qp->scq, "post cq failed, err =3D %d\n", err);
>
>         return err;
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/r=
xe/rxe_cq.c
> index d5486cbb3f10..fec87c9030ab 100644
> --- a/drivers/infiniband/sw/rxe/rxe_cq.c
> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c
> @@ -27,7 +27,7 @@ int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq =
*cq,
>         if (cq) {
>                 count =3D queue_count(cq->queue, QUEUE_TYPE_TO_CLIENT);
>                 if (cqe < count) {
> -                       rxe_dbg_cq(cq, "cqe(%d) < current # elements in q=
ueue (%d)",
> +                       rxe_dbg_cq(cq, "cqe(%d) < current # elements in q=
ueue (%d)\n",
>                                         cqe, count);
>                         goto err1;
>                 }
> @@ -96,7 +96,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe,=
 int solicited)
>
>         full =3D queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
>         if (unlikely(full)) {
> -               rxe_err_cq(cq, "queue full");
> +               rxe_err_cq(cq, "queue full\n");
>                 spin_unlock_irqrestore(&cq->cq_lock, flags);
>                 if (cq->ibcq.event_handler) {
>                         ev.device =3D cq->ibcq.device;
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/r=
xe/rxe_mr.c
> index f54042e9aeb2..bc81fde696ee 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -34,7 +34,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t =
length)
>         case IB_MR_TYPE_MEM_REG:
>                 if (iova < mr->ibmr.iova ||
>                     iova + length > mr->ibmr.iova + mr->ibmr.length) {
> -                       rxe_dbg_mr(mr, "iova/length out of range");
> +                       rxe_dbg_mr(mr, "iova/length out of range\n");
>                         return -EINVAL;
>                 }
>                 return 0;
> @@ -319,7 +319,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *ad=
dr,
>
>         err =3D mr_check_range(mr, iova, length);
>         if (unlikely(err)) {
> -               rxe_dbg_mr(mr, "iova out of range");
> +               rxe_dbg_mr(mr, "iova out of range\n");
>                 return err;
>         }
>
> @@ -477,7 +477,7 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, =
int opcode,
>         u64 *va;
>
>         if (unlikely(mr->state !=3D RXE_MR_STATE_VALID)) {
> -               rxe_dbg_mr(mr, "mr not in valid state");
> +               rxe_dbg_mr(mr, "mr not in valid state\n");
>                 return RESPST_ERR_RKEY_VIOLATION;
>         }
>
> @@ -490,7 +490,7 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, =
int opcode,
>
>                 err =3D mr_check_range(mr, iova, sizeof(value));
>                 if (err) {
> -                       rxe_dbg_mr(mr, "iova out of range");
> +                       rxe_dbg_mr(mr, "iova out of range\n");
>                         return RESPST_ERR_RKEY_VIOLATION;
>                 }
>                 page_offset =3D rxe_mr_iova_to_page_offset(mr, iova);
> @@ -501,7 +501,7 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, =
int opcode,
>         }
>
>         if (unlikely(page_offset & 0x7)) {
> -               rxe_dbg_mr(mr, "iova not aligned");
> +               rxe_dbg_mr(mr, "iova not aligned\n");
>                 return RESPST_ERR_MISALIGNED_ATOMIC;
>         }
>
> @@ -534,7 +534,7 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iov=
a, u64 value)
>
>         /* See IBA oA19-28 */
>         if (unlikely(mr->state !=3D RXE_MR_STATE_VALID)) {
> -               rxe_dbg_mr(mr, "mr not in valid state");
> +               rxe_dbg_mr(mr, "mr not in valid state\n");
>                 return RESPST_ERR_RKEY_VIOLATION;
>         }
>
> @@ -548,7 +548,7 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iov=
a, u64 value)
>                 /* See IBA oA19-28 */
>                 err =3D mr_check_range(mr, iova, sizeof(value));
>                 if (unlikely(err)) {
> -                       rxe_dbg_mr(mr, "iova out of range");
> +                       rxe_dbg_mr(mr, "iova out of range\n");
>                         return RESPST_ERR_RKEY_VIOLATION;
>                 }
>                 page_offset =3D rxe_mr_iova_to_page_offset(mr, iova);
> @@ -560,7 +560,7 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iov=
a, u64 value)
>
>         /* See IBA A19.4.2 */
>         if (unlikely(page_offset & 0x7)) {
> -               rxe_dbg_mr(mr, "misaligned address");
> +               rxe_dbg_mr(mr, "misaligned address\n");
>                 return RESPST_ERR_MISALIGNED_ATOMIC;
>         }
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/r=
xe/rxe_mw.c
> index d9312b5c9d20..379e65bfcd49 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mw.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mw.c
> @@ -198,7 +198,7 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wq=
e *wqe)
>         }
>
>         if (access & ~RXE_ACCESS_SUPPORTED_MW) {
> -               rxe_err_mw(mw, "access %#x not supported", access);
> +               rxe_err_mw(mw, "access %#x not supported\n", access);
>                 ret =3D -EOPNOTSUPP;
>                 goto err_drop_mr;
>         }
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/r=
xe/rxe_qp.c
> index 28e379c108bc..e3589c02013e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -201,7 +201,7 @@ static int rxe_init_sq(struct rxe_qp *qp, struct ib_q=
p_init_attr *init,
>         qp->sq.queue =3D rxe_queue_init(rxe, &qp->sq.max_wr, wqe_size,
>                                       QUEUE_TYPE_FROM_CLIENT);
>         if (!qp->sq.queue) {
> -               rxe_err_qp(qp, "Unable to allocate send queue");
> +               rxe_err_qp(qp, "Unable to allocate send queue\n");
>                 err =3D -ENOMEM;
>                 goto err_out;
>         }
> @@ -211,7 +211,7 @@ static int rxe_init_sq(struct rxe_qp *qp, struct ib_q=
p_init_attr *init,
>                            qp->sq.queue->buf, qp->sq.queue->buf_size,
>                            &qp->sq.queue->ip);
>         if (err) {
> -               rxe_err_qp(qp, "do_mmap_info failed, err =3D %d", err);
> +               rxe_err_qp(qp, "do_mmap_info failed, err =3D %d\n", err);
>                 goto err_free;
>         }
>
> @@ -292,7 +292,7 @@ static int rxe_init_rq(struct rxe_qp *qp, struct ib_q=
p_init_attr *init,
>         qp->rq.queue =3D rxe_queue_init(rxe, &qp->rq.max_wr, wqe_size,
>                                       QUEUE_TYPE_FROM_CLIENT);
>         if (!qp->rq.queue) {
> -               rxe_err_qp(qp, "Unable to allocate recv queue");
> +               rxe_err_qp(qp, "Unable to allocate recv queue\n");
>                 err =3D -ENOMEM;
>                 goto err_out;
>         }
> @@ -302,7 +302,7 @@ static int rxe_init_rq(struct rxe_qp *qp, struct ib_q=
p_init_attr *init,
>                            qp->rq.queue->buf, qp->rq.queue->buf_size,
>                            &qp->rq.queue->ip);
>         if (err) {
> -               rxe_err_qp(qp, "do_mmap_info failed, err =3D %d", err);
> +               rxe_err_qp(qp, "do_mmap_info failed, err =3D %d\n", err);
>                 goto err_free;
>         }
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw=
/rxe/rxe_resp.c
> index da470a925efc..963382f625d7 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -362,18 +362,18 @@ static enum resp_states rxe_resp_check_length(struc=
t rxe_qp *qp,
>                 if ((pkt->mask & RXE_START_MASK) &&
>                     (pkt->mask & RXE_END_MASK)) {
>                         if (unlikely(payload > mtu)) {
> -                               rxe_dbg_qp(qp, "only packet too long");
> +                               rxe_dbg_qp(qp, "only packet too long\n");
>                                 return RESPST_ERR_LENGTH;
>                         }
>                 } else if ((pkt->mask & RXE_START_MASK) ||
>                            (pkt->mask & RXE_MIDDLE_MASK)) {
>                         if (unlikely(payload !=3D mtu)) {
> -                               rxe_dbg_qp(qp, "first or middle packet no=
t mtu");
> +                               rxe_dbg_qp(qp, "first or middle packet no=
t mtu\n");
>                                 return RESPST_ERR_LENGTH;
>                         }
>                 } else if (pkt->mask & RXE_END_MASK) {
>                         if (unlikely((payload =3D=3D 0) || (payload > mtu=
))) {
> -                               rxe_dbg_qp(qp, "last packet zero or too l=
ong");
> +                               rxe_dbg_qp(qp, "last packet zero or too l=
ong\n");
>                                 return RESPST_ERR_LENGTH;
>                         }
>                 }
> @@ -382,7 +382,7 @@ static enum resp_states rxe_resp_check_length(struct =
rxe_qp *qp,
>         /* See IBA C9-94 */
>         if (pkt->mask & RXE_RETH_MASK) {
>                 if (reth_len(pkt) > (1U << 31)) {
> -                       rxe_dbg_qp(qp, "dma length too long");
> +                       rxe_dbg_qp(qp, "dma length too long\n");
>                         return RESPST_ERR_LENGTH;
>                 }
>         }
> @@ -1133,7 +1133,7 @@ static enum resp_states do_complete(struct rxe_qp *=
qp,
>                 }
>         } else {
>                 if (wc->status !=3D IB_WC_WR_FLUSH_ERR)
> -                       rxe_err_qp(qp, "non-flush error status =3D %d",
> +                       rxe_err_qp(qp, "non-flush error status =3D %d\n",
>                                 wc->status);
>         }
>
> @@ -1442,7 +1442,7 @@ static int flush_recv_wqe(struct rxe_qp *qp, struct=
 rxe_recv_wqe *wqe)
>
>         err =3D rxe_cq_post(qp->rcq, &cqe, 0);
>         if (err)
> -               rxe_dbg_cq(qp->rcq, "post cq failed err =3D %d", err);
> +               rxe_dbg_cq(qp->rcq, "post cq failed err =3D %d\n", err);
>
>         return err;
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw=
/rxe/rxe_task.c
> index 1501120d4f52..80332638d9e3 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> @@ -156,7 +156,7 @@ static void do_task(struct rxe_task *task)
>
>                 default:
>                         WARN_ON(1);
> -                       rxe_dbg_qp(task->qp, "unexpected task state =3D %=
d",
> +                       rxe_dbg_qp(task->qp, "unexpected task state =3D %=
d\n",
>                                    task->state);
>                         task->state =3D TASK_STATE_IDLE;
>                 }
> @@ -167,7 +167,7 @@ static void do_task(struct rxe_task *task)
>                         if (WARN_ON(task->num_done !=3D task->num_sched))
>                                 rxe_dbg_qp(
>                                         task->qp,
> -                                       "%ld tasks scheduled, %ld tasks d=
one",
> +                                       "%ld tasks scheduled, %ld tasks d=
one\n",
>                                         task->num_sched, task->num_done);
>                 }
>                 spin_unlock_irqrestore(&task->lock, flags);
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/s=
w/rxe/rxe_verbs.c
> index 48f86839d36a..f0a03b910702 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -23,7 +23,7 @@ static int rxe_query_device(struct ib_device *ibdev,
>         int err;
>
>         if (udata->inlen || udata->outlen) {
> -               rxe_dbg_dev(rxe, "malformed udata");
> +               rxe_dbg_dev(rxe, "malformed udata\n");
>                 err =3D -EINVAL;
>                 goto err_out;
>         }
> @@ -33,7 +33,7 @@ static int rxe_query_device(struct ib_device *ibdev,
>         return 0;
>
>  err_out:
> -       rxe_err_dev(rxe, "returned err =3D %d", err);
> +       rxe_err_dev(rxe, "returned err =3D %d\n", err);
>         return err;
>  }
>
> @@ -45,7 +45,7 @@ static int rxe_query_port(struct ib_device *ibdev,
>
>         if (port_num !=3D 1) {
>                 err =3D -EINVAL;
> -               rxe_dbg_dev(rxe, "bad port_num =3D %d", port_num);
> +               rxe_dbg_dev(rxe, "bad port_num =3D %d\n", port_num);
>                 goto err_out;
>         }
>
> @@ -67,7 +67,7 @@ static int rxe_query_port(struct ib_device *ibdev,
>         return ret;
>
>  err_out:
> -       rxe_err_dev(rxe, "returned err =3D %d", err);
> +       rxe_err_dev(rxe, "returned err =3D %d\n", err);
>         return err;
>  }
>
> @@ -79,7 +79,7 @@ static int rxe_query_pkey(struct ib_device *ibdev,
>
>         if (index !=3D 0) {
>                 err =3D -EINVAL;
> -               rxe_dbg_dev(rxe, "bad pkey index =3D %d", index);
> +               rxe_dbg_dev(rxe, "bad pkey index =3D %d\n", index);
>                 goto err_out;
>         }
>
> @@ -87,7 +87,7 @@ static int rxe_query_pkey(struct ib_device *ibdev,
>         return 0;
>
>  err_out:
> -       rxe_err_dev(rxe, "returned err =3D %d", err);
> +       rxe_err_dev(rxe, "returned err =3D %d\n", err);
>         return err;
>  }
>
> @@ -100,7 +100,7 @@ static int rxe_modify_device(struct ib_device *ibdev,
>         if (mask & ~(IB_DEVICE_MODIFY_SYS_IMAGE_GUID |
>                      IB_DEVICE_MODIFY_NODE_DESC)) {
>                 err =3D -EOPNOTSUPP;
> -               rxe_dbg_dev(rxe, "unsupported mask =3D 0x%x", mask);
> +               rxe_dbg_dev(rxe, "unsupported mask =3D 0x%x\n", mask);
>                 goto err_out;
>         }
>
> @@ -115,7 +115,7 @@ static int rxe_modify_device(struct ib_device *ibdev,
>         return 0;
>
>  err_out:
> -       rxe_err_dev(rxe, "returned err =3D %d", err);
> +       rxe_err_dev(rxe, "returned err =3D %d\n", err);
>         return err;
>  }
>
> @@ -128,14 +128,14 @@ static int rxe_modify_port(struct ib_device *ibdev,=
 u32 port_num,
>
>         if (port_num !=3D 1) {
>                 err =3D -EINVAL;
> -               rxe_dbg_dev(rxe, "bad port_num =3D %d", port_num);
> +               rxe_dbg_dev(rxe, "bad port_num =3D %d\n", port_num);
>                 goto err_out;
>         }
>
>         //TODO is shutdown useful
>         if (mask & ~(IB_PORT_RESET_QKEY_CNTR)) {
>                 err =3D -EOPNOTSUPP;
> -               rxe_dbg_dev(rxe, "unsupported mask =3D 0x%x", mask);
> +               rxe_dbg_dev(rxe, "unsupported mask =3D 0x%x\n", mask);
>                 goto err_out;
>         }
>
> @@ -149,7 +149,7 @@ static int rxe_modify_port(struct ib_device *ibdev, u=
32 port_num,
>         return 0;
>
>  err_out:
> -       rxe_err_dev(rxe, "returned err =3D %d", err);
> +       rxe_err_dev(rxe, "returned err =3D %d\n", err);
>         return err;
>  }
>
> @@ -161,14 +161,14 @@ static enum rdma_link_layer rxe_get_link_layer(stru=
ct ib_device *ibdev,
>
>         if (port_num !=3D 1) {
>                 err =3D -EINVAL;
> -               rxe_dbg_dev(rxe, "bad port_num =3D %d", port_num);
> +               rxe_dbg_dev(rxe, "bad port_num =3D %d\n", port_num);
>                 goto err_out;
>         }
>
>         return IB_LINK_LAYER_ETHERNET;
>
>  err_out:
> -       rxe_err_dev(rxe, "returned err =3D %d", err);
> +       rxe_err_dev(rxe, "returned err =3D %d\n", err);
>         return err;
>  }
>
> @@ -181,7 +181,7 @@ static int rxe_port_immutable(struct ib_device *ibdev=
, u32 port_num,
>
>         if (port_num !=3D 1) {
>                 err =3D -EINVAL;
> -               rxe_dbg_dev(rxe, "bad port_num =3D %d", port_num);
> +               rxe_dbg_dev(rxe, "bad port_num =3D %d\n", port_num);
>                 goto err_out;
>         }
>
> @@ -197,7 +197,7 @@ static int rxe_port_immutable(struct ib_device *ibdev=
, u32 port_num,
>         return 0;
>
>  err_out:
> -       rxe_err_dev(rxe, "returned err =3D %d", err);
> +       rxe_err_dev(rxe, "returned err =3D %d\n", err);
>         return err;
>  }
>
> @@ -210,7 +210,7 @@ static int rxe_alloc_ucontext(struct ib_ucontext *ibu=
c, struct ib_udata *udata)
>
>         err =3D rxe_add_to_pool(&rxe->uc_pool, uc);
>         if (err)
> -               rxe_err_dev(rxe, "unable to create uc");
> +               rxe_err_dev(rxe, "unable to create uc\n");
>
>         return err;
>  }
> @@ -222,7 +222,7 @@ static void rxe_dealloc_ucontext(struct ib_ucontext *=
ibuc)
>
>         err =3D rxe_cleanup(uc);
>         if (err)
> -               rxe_err_uc(uc, "cleanup failed, err =3D %d", err);
> +               rxe_err_uc(uc, "cleanup failed, err =3D %d\n", err);
>  }
>
>  /* pd */
> @@ -234,14 +234,14 @@ static int rxe_alloc_pd(struct ib_pd *ibpd, struct =
ib_udata *udata)
>
>         err =3D rxe_add_to_pool(&rxe->pd_pool, pd);
>         if (err) {
> -               rxe_dbg_dev(rxe, "unable to alloc pd");
> +               rxe_dbg_dev(rxe, "unable to alloc pd\n");
>                 goto err_out;
>         }
>
>         return 0;
>
>  err_out:
> -       rxe_err_dev(rxe, "returned err =3D %d", err);
> +       rxe_err_dev(rxe, "returned err =3D %d\n", err);
>         return err;
>  }
>
> @@ -252,7 +252,7 @@ static int rxe_dealloc_pd(struct ib_pd *ibpd, struct =
ib_udata *udata)
>
>         err =3D rxe_cleanup(pd);
>         if (err)
> -               rxe_err_pd(pd, "cleanup failed, err =3D %d", err);
> +               rxe_err_pd(pd, "cleanup failed, err =3D %d\n", err);
>
>         return 0;
>  }
> @@ -279,7 +279,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
>         err =3D rxe_add_to_pool_ah(&rxe->ah_pool, ah,
>                         init_attr->flags & RDMA_CREATE_AH_SLEEPABLE);
>         if (err) {
> -               rxe_dbg_dev(rxe, "unable to create ah");
> +               rxe_dbg_dev(rxe, "unable to create ah\n");
>                 goto err_out;
>         }
>
> @@ -288,7 +288,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
>
>         err =3D rxe_ah_chk_attr(ah, init_attr->ah_attr);
>         if (err) {
> -               rxe_dbg_ah(ah, "bad attr");
> +               rxe_dbg_ah(ah, "bad attr\n");
>                 goto err_cleanup;
>         }
>
> @@ -298,7 +298,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
>                                          sizeof(uresp->ah_num));
>                 if (err) {
>                         err =3D -EFAULT;
> -                       rxe_dbg_ah(ah, "unable to copy to user");
> +                       rxe_dbg_ah(ah, "unable to copy to user\n");
>                         goto err_cleanup;
>                 }
>         } else if (ah->is_user) {
> @@ -314,9 +314,9 @@ static int rxe_create_ah(struct ib_ah *ibah,
>  err_cleanup:
>         cleanup_err =3D rxe_cleanup(ah);
>         if (cleanup_err)
> -               rxe_err_ah(ah, "cleanup failed, err =3D %d", cleanup_err)=
;
> +               rxe_err_ah(ah, "cleanup failed, err =3D %d\n", cleanup_er=
r);
>  err_out:
> -       rxe_err_ah(ah, "returned err =3D %d", err);
> +       rxe_err_ah(ah, "returned err =3D %d\n", err);
>         return err;
>  }
>
> @@ -327,7 +327,7 @@ static int rxe_modify_ah(struct ib_ah *ibah, struct r=
dma_ah_attr *attr)
>
>         err =3D rxe_ah_chk_attr(ah, attr);
>         if (err) {
> -               rxe_dbg_ah(ah, "bad attr");
> +               rxe_dbg_ah(ah, "bad attr\n");
>                 goto err_out;
>         }
>
> @@ -336,7 +336,7 @@ static int rxe_modify_ah(struct ib_ah *ibah, struct r=
dma_ah_attr *attr)
>         return 0;
>
>  err_out:
> -       rxe_err_ah(ah, "returned err =3D %d", err);
> +       rxe_err_ah(ah, "returned err =3D %d\n", err);
>         return err;
>  }
>
> @@ -358,7 +358,7 @@ static int rxe_destroy_ah(struct ib_ah *ibah, u32 fla=
gs)
>
>         err =3D rxe_cleanup_ah(ah, flags & RDMA_DESTROY_AH_SLEEPABLE);
>         if (err)
> -               rxe_err_ah(ah, "cleanup failed, err =3D %d", err);
> +               rxe_err_ah(ah, "cleanup failed, err =3D %d\n", err);
>
>         return 0;
>  }
> @@ -376,7 +376,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struc=
t ib_srq_init_attr *init,
>         if (udata) {
>                 if (udata->outlen < sizeof(*uresp)) {
>                         err =3D -EINVAL;
> -                       rxe_err_dev(rxe, "malformed udata");
> +                       rxe_err_dev(rxe, "malformed udata\n");
>                         goto err_out;
>                 }
>                 uresp =3D udata->outbuf;
> @@ -384,20 +384,20 @@ static int rxe_create_srq(struct ib_srq *ibsrq, str=
uct ib_srq_init_attr *init,
>
>         if (init->srq_type !=3D IB_SRQT_BASIC) {
>                 err =3D -EOPNOTSUPP;
> -               rxe_dbg_dev(rxe, "srq type =3D %d, not supported",
> +               rxe_dbg_dev(rxe, "srq type =3D %d, not supported\n",
>                                 init->srq_type);
>                 goto err_out;
>         }
>
>         err =3D rxe_srq_chk_init(rxe, init);
>         if (err) {
> -               rxe_dbg_dev(rxe, "invalid init attributes");
> +               rxe_dbg_dev(rxe, "invalid init attributes\n");
>                 goto err_out;
>         }
>
>         err =3D rxe_add_to_pool(&rxe->srq_pool, srq);
>         if (err) {
> -               rxe_dbg_dev(rxe, "unable to create srq, err =3D %d", err)=
;
> +               rxe_dbg_dev(rxe, "unable to create srq, err =3D %d\n", er=
r);
>                 goto err_out;
>         }
>
> @@ -406,7 +406,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struc=
t ib_srq_init_attr *init,
>
>         err =3D rxe_srq_from_init(rxe, srq, init, udata, uresp);
>         if (err) {
> -               rxe_dbg_srq(srq, "create srq failed, err =3D %d", err);
> +               rxe_dbg_srq(srq, "create srq failed, err =3D %d\n", err);
>                 goto err_cleanup;
>         }
>
> @@ -415,9 +415,9 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struc=
t ib_srq_init_attr *init,
>  err_cleanup:
>         cleanup_err =3D rxe_cleanup(srq);
>         if (cleanup_err)
> -               rxe_err_srq(srq, "cleanup failed, err =3D %d", cleanup_er=
r);
> +               rxe_err_srq(srq, "cleanup failed, err =3D %d\n", cleanup_=
err);
>  err_out:
> -       rxe_err_dev(rxe, "returned err =3D %d", err);
> +       rxe_err_dev(rxe, "returned err =3D %d\n", err);
>         return err;
>  }
>
> @@ -433,34 +433,34 @@ static int rxe_modify_srq(struct ib_srq *ibsrq, str=
uct ib_srq_attr *attr,
>         if (udata) {
>                 if (udata->inlen < sizeof(cmd)) {
>                         err =3D -EINVAL;
> -                       rxe_dbg_srq(srq, "malformed udata");
> +                       rxe_dbg_srq(srq, "malformed udata\n");
>                         goto err_out;
>                 }
>
>                 err =3D ib_copy_from_udata(&cmd, udata, sizeof(cmd));
>                 if (err) {
>                         err =3D -EFAULT;
> -                       rxe_dbg_srq(srq, "unable to read udata");
> +                       rxe_dbg_srq(srq, "unable to read udata\n");
>                         goto err_out;
>                 }
>         }
>
>         err =3D rxe_srq_chk_attr(rxe, srq, attr, mask);
>         if (err) {
> -               rxe_dbg_srq(srq, "bad init attributes");
> +               rxe_dbg_srq(srq, "bad init attributes\n");
>                 goto err_out;
>         }
>
>         err =3D rxe_srq_from_attr(rxe, srq, attr, mask, &cmd, udata);
>         if (err) {
> -               rxe_dbg_srq(srq, "bad attr");
> +               rxe_dbg_srq(srq, "bad attr\n");
>                 goto err_out;
>         }
>
>         return 0;
>
>  err_out:
> -       rxe_err_srq(srq, "returned err =3D %d", err);
> +       rxe_err_srq(srq, "returned err =3D %d\n", err);
>         return err;
>  }
>
> @@ -471,7 +471,7 @@ static int rxe_query_srq(struct ib_srq *ibsrq, struct=
 ib_srq_attr *attr)
>
>         if (srq->error) {
>                 err =3D -EINVAL;
> -               rxe_dbg_srq(srq, "srq in error state");
> +               rxe_dbg_srq(srq, "srq in error state\n");
>                 goto err_out;
>         }
>
> @@ -481,7 +481,7 @@ static int rxe_query_srq(struct ib_srq *ibsrq, struct=
 ib_srq_attr *attr)
>         return 0;
>
>  err_out:
> -       rxe_err_srq(srq, "returned err =3D %d", err);
> +       rxe_err_srq(srq, "returned err =3D %d\n", err);
>         return err;
>  }
>
> @@ -505,7 +505,7 @@ static int rxe_post_srq_recv(struct ib_srq *ibsrq, co=
nst struct ib_recv_wr *wr,
>
>         if (err) {
>                 *bad_wr =3D wr;
> -               rxe_err_srq(srq, "returned err =3D %d", err);
> +               rxe_err_srq(srq, "returned err =3D %d\n", err);
>         }
>
>         return err;
> @@ -518,7 +518,7 @@ static int rxe_destroy_srq(struct ib_srq *ibsrq, stru=
ct ib_udata *udata)
>
>         err =3D rxe_cleanup(srq);
>         if (err)
> -               rxe_err_srq(srq, "cleanup failed, err =3D %d", err);
> +               rxe_err_srq(srq, "cleanup failed, err =3D %d\n", err);
>
>         return 0;
>  }
> @@ -536,13 +536,13 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct=
 ib_qp_init_attr *init,
>         if (udata) {
>                 if (udata->inlen) {
>                         err =3D -EINVAL;
> -                       rxe_dbg_dev(rxe, "malformed udata, err =3D %d", e=
rr);
> +                       rxe_dbg_dev(rxe, "malformed udata, err =3D %d\n",=
 err);
>                         goto err_out;
>                 }
>
>                 if (udata->outlen < sizeof(*uresp)) {
>                         err =3D -EINVAL;
> -                       rxe_dbg_dev(rxe, "malformed udata, err =3D %d", e=
rr);
> +                       rxe_dbg_dev(rxe, "malformed udata, err =3D %d\n",=
 err);
>                         goto err_out;
>                 }
>
> @@ -554,25 +554,25 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct=
 ib_qp_init_attr *init,
>
>         if (init->create_flags) {
>                 err =3D -EOPNOTSUPP;
> -               rxe_dbg_dev(rxe, "unsupported create_flags, err =3D %d", =
err);
> +               rxe_dbg_dev(rxe, "unsupported create_flags, err =3D %d\n"=
, err);
>                 goto err_out;
>         }
>
>         err =3D rxe_qp_chk_init(rxe, init);
>         if (err) {
> -               rxe_dbg_dev(rxe, "bad init attr, err =3D %d", err);
> +               rxe_dbg_dev(rxe, "bad init attr, err =3D %d\n", err);
>                 goto err_out;
>         }
>
>         err =3D rxe_add_to_pool(&rxe->qp_pool, qp);
>         if (err) {
> -               rxe_dbg_dev(rxe, "unable to create qp, err =3D %d", err);
> +               rxe_dbg_dev(rxe, "unable to create qp, err =3D %d\n", err=
);
>                 goto err_out;
>         }
>
>         err =3D rxe_qp_from_init(rxe, qp, pd, init, uresp, ibqp->pd, udat=
a);
>         if (err) {
> -               rxe_dbg_qp(qp, "create qp failed, err =3D %d", err);
> +               rxe_dbg_qp(qp, "create qp failed, err =3D %d\n", err);
>                 goto err_cleanup;
>         }
>
> @@ -582,9 +582,9 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct i=
b_qp_init_attr *init,
>  err_cleanup:
>         cleanup_err =3D rxe_cleanup(qp);
>         if (cleanup_err)
> -               rxe_err_qp(qp, "cleanup failed, err =3D %d", cleanup_err)=
;
> +               rxe_err_qp(qp, "cleanup failed, err =3D %d\n", cleanup_er=
r);
>  err_out:
> -       rxe_err_dev(rxe, "returned err =3D %d", err);
> +       rxe_err_dev(rxe, "returned err =3D %d\n", err);
>         return err;
>  }
>
> @@ -597,20 +597,20 @@ static int rxe_modify_qp(struct ib_qp *ibqp, struct=
 ib_qp_attr *attr,
>
>         if (mask & ~IB_QP_ATTR_STANDARD_BITS) {
>                 err =3D -EOPNOTSUPP;
> -               rxe_dbg_qp(qp, "unsupported mask =3D 0x%x, err =3D %d",
> +               rxe_dbg_qp(qp, "unsupported mask =3D 0x%x, err =3D %d\n",
>                            mask, err);
>                 goto err_out;
>         }
>
>         err =3D rxe_qp_chk_attr(rxe, qp, attr, mask);
>         if (err) {
> -               rxe_dbg_qp(qp, "bad mask/attr, err =3D %d", err);
> +               rxe_dbg_qp(qp, "bad mask/attr, err =3D %d\n", err);
>                 goto err_out;
>         }
>
>         err =3D rxe_qp_from_attr(qp, attr, mask, udata);
>         if (err) {
> -               rxe_dbg_qp(qp, "modify qp failed, err =3D %d", err);
> +               rxe_dbg_qp(qp, "modify qp failed, err =3D %d\n", err);
>                 goto err_out;
>         }
>
> @@ -622,7 +622,7 @@ static int rxe_modify_qp(struct ib_qp *ibqp, struct i=
b_qp_attr *attr,
>         return 0;
>
>  err_out:
> -       rxe_err_qp(qp, "returned err =3D %d", err);
> +       rxe_err_qp(qp, "returned err =3D %d\n", err);
>         return err;
>  }
>
> @@ -644,18 +644,18 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struc=
t ib_udata *udata)
>
>         err =3D rxe_qp_chk_destroy(qp);
>         if (err) {
> -               rxe_dbg_qp(qp, "unable to destroy qp, err =3D %d", err);
> +               rxe_dbg_qp(qp, "unable to destroy qp, err =3D %d\n", err)=
;
>                 goto err_out;
>         }
>
>         err =3D rxe_cleanup(qp);
>         if (err)
> -               rxe_err_qp(qp, "cleanup failed, err =3D %d", err);
> +               rxe_err_qp(qp, "cleanup failed, err =3D %d\n", err);
>
>         return 0;
>
>  err_out:
> -       rxe_err_qp(qp, "returned err =3D %d", err);
> +       rxe_err_qp(qp, "returned err =3D %d\n", err);
>         return err;
>  }
>
> @@ -675,12 +675,12 @@ static int validate_send_wr(struct rxe_qp *qp, cons=
t struct ib_send_wr *ibwr,
>         do {
>                 mask =3D wr_opcode_mask(ibwr->opcode, qp);
>                 if (!mask) {
> -                       rxe_err_qp(qp, "bad wr opcode for qp type");
> +                       rxe_err_qp(qp, "bad wr opcode for qp type\n");
>                         break;
>                 }
>
>                 if (num_sge > sq->max_sge) {
> -                       rxe_err_qp(qp, "num_sge > max_sge");
> +                       rxe_err_qp(qp, "num_sge > max_sge\n");
>                         break;
>                 }
>
> @@ -689,27 +689,27 @@ static int validate_send_wr(struct rxe_qp *qp, cons=
t struct ib_send_wr *ibwr,
>                         length +=3D ibwr->sg_list[i].length;
>
>                 if (length > (1UL << 31)) {
> -                       rxe_err_qp(qp, "message length too long");
> +                       rxe_err_qp(qp, "message length too long\n");
>                         break;
>                 }
>
>                 if (mask & WR_ATOMIC_MASK) {
>                         if (length !=3D 8) {
> -                               rxe_err_qp(qp, "atomic length !=3D 8");
> +                               rxe_err_qp(qp, "atomic length !=3D 8\n");
>                                 break;
>                         }
>                         if (atomic_wr(ibwr)->remote_addr & 0x7) {
> -                               rxe_err_qp(qp, "misaligned atomic address=
");
> +                               rxe_err_qp(qp, "misaligned atomic address=
\n");
>                                 break;
>                         }
>                 }
>                 if (ibwr->send_flags & IB_SEND_INLINE) {
>                         if (!(mask & WR_INLINE_MASK)) {
> -                               rxe_err_qp(qp, "opcode doesn't support in=
line data");
> +                               rxe_err_qp(qp, "opcode doesn't support in=
line data\n");
>                                 break;
>                         }
>                         if (length > sq->max_inline) {
> -                               rxe_err_qp(qp, "inline length too big");
> +                               rxe_err_qp(qp, "inline length too big\n")=
;
>                                 break;
>                         }
>                 }
> @@ -747,7 +747,7 @@ static int init_send_wr(struct rxe_qp *qp, struct rxe=
_send_wr *wr,
>                 case IB_WR_SEND:
>                         break;
>                 default:
> -                       rxe_err_qp(qp, "bad wr opcode %d for UD/GSI QP",
> +                       rxe_err_qp(qp, "bad wr opcode %d for UD/GSI QP\n"=
,
>                                         wr->opcode);
>                         return -EINVAL;
>                 }
> @@ -795,7 +795,7 @@ static int init_send_wr(struct rxe_qp *qp, struct rxe=
_send_wr *wr,
>                 case IB_WR_ATOMIC_WRITE:
>                         break;
>                 default:
> -                       rxe_err_qp(qp, "unsupported wr opcode %d",
> +                       rxe_err_qp(qp, "unsupported wr opcode %d\n",
>                                         wr->opcode);
>                         return -EINVAL;
>                 }
> @@ -870,7 +870,7 @@ static int post_one_send(struct rxe_qp *qp, const str=
uct ib_send_wr *ibwr)
>
>         full =3D queue_full(sq->queue, QUEUE_TYPE_FROM_ULP);
>         if (unlikely(full)) {
> -               rxe_err_qp(qp, "send queue full");
> +               rxe_err_qp(qp, "send queue full\n");
>                 return -ENOMEM;
>         }
>
> @@ -922,14 +922,14 @@ static int rxe_post_send(struct ib_qp *ibqp, const =
struct ib_send_wr *wr,
>         /* caller has already called destroy_qp */
>         if (WARN_ON_ONCE(!qp->valid)) {
>                 spin_unlock_irqrestore(&qp->state_lock, flags);
> -               rxe_err_qp(qp, "qp has been destroyed");
> +               rxe_err_qp(qp, "qp has been destroyed\n");
>                 return -EINVAL;
>         }
>
>         if (unlikely(qp_state(qp) < IB_QPS_RTS)) {
>                 spin_unlock_irqrestore(&qp->state_lock, flags);
>                 *bad_wr =3D wr;
> -               rxe_err_qp(qp, "qp not ready to send");
> +               rxe_err_qp(qp, "qp not ready to send\n");
>                 return -EINVAL;
>         }
>         spin_unlock_irqrestore(&qp->state_lock, flags);
> @@ -959,13 +959,13 @@ static int post_one_recv(struct rxe_rq *rq, const s=
truct ib_recv_wr *ibwr)
>         full =3D queue_full(rq->queue, QUEUE_TYPE_FROM_ULP);
>         if (unlikely(full)) {
>                 err =3D -ENOMEM;
> -               rxe_dbg("queue full");
> +               rxe_dbg("queue full\n");
>                 goto err_out;
>         }
>
>         if (unlikely(num_sge > rq->max_sge)) {
>                 err =3D -EINVAL;
> -               rxe_dbg("bad num_sge > max_sge");
> +               rxe_dbg("bad num_sge > max_sge\n");
>                 goto err_out;
>         }
>
> @@ -976,7 +976,7 @@ static int post_one_recv(struct rxe_rq *rq, const str=
uct ib_recv_wr *ibwr)
>         /* IBA max message size is 2^31 */
>         if (length >=3D (1UL<<31)) {
>                 err =3D -EINVAL;
> -               rxe_dbg("message length too long");
> +               rxe_dbg("message length too long\n");
>                 goto err_out;
>         }
>
> @@ -996,7 +996,7 @@ static int post_one_recv(struct rxe_rq *rq, const str=
uct ib_recv_wr *ibwr)
>         return 0;
>
>  err_out:
> -       rxe_dbg("returned err =3D %d", err);
> +       rxe_dbg("returned err =3D %d\n", err);
>         return err;
>  }
>
> @@ -1012,7 +1012,7 @@ static int rxe_post_recv(struct ib_qp *ibqp, const =
struct ib_recv_wr *wr,
>         /* caller has already called destroy_qp */
>         if (WARN_ON_ONCE(!qp->valid)) {
>                 spin_unlock_irqrestore(&qp->state_lock, flags);
> -               rxe_err_qp(qp, "qp has been destroyed");
> +               rxe_err_qp(qp, "qp has been destroyed\n");
>                 return -EINVAL;
>         }
>
> @@ -1020,14 +1020,14 @@ static int rxe_post_recv(struct ib_qp *ibqp, cons=
t struct ib_recv_wr *wr,
>         if (unlikely((qp_state(qp) < IB_QPS_INIT))) {
>                 spin_unlock_irqrestore(&qp->state_lock, flags);
>                 *bad_wr =3D wr;
> -               rxe_dbg_qp(qp, "qp not ready to post recv");
> +               rxe_dbg_qp(qp, "qp not ready to post recv\n");
>                 return -EINVAL;
>         }
>         spin_unlock_irqrestore(&qp->state_lock, flags);
>
>         if (unlikely(qp->srq)) {
>                 *bad_wr =3D wr;
> -               rxe_dbg_qp(qp, "qp has srq, use post_srq_recv instead");
> +               rxe_dbg_qp(qp, "qp has srq, use post_srq_recv instead\n")=
;
>                 return -EINVAL;
>         }
>
> @@ -1065,7 +1065,7 @@ static int rxe_create_cq(struct ib_cq *ibcq, const =
struct ib_cq_init_attr *attr,
>         if (udata) {
>                 if (udata->outlen < sizeof(*uresp)) {
>                         err =3D -EINVAL;
> -                       rxe_dbg_dev(rxe, "malformed udata, err =3D %d", e=
rr);
> +                       rxe_dbg_dev(rxe, "malformed udata, err =3D %d\n",=
 err);
>                         goto err_out;
>                 }
>                 uresp =3D udata->outbuf;
> @@ -1073,26 +1073,26 @@ static int rxe_create_cq(struct ib_cq *ibcq, cons=
t struct ib_cq_init_attr *attr,
>
>         if (attr->flags) {
>                 err =3D -EOPNOTSUPP;
> -               rxe_dbg_dev(rxe, "bad attr->flags, err =3D %d", err);
> +               rxe_dbg_dev(rxe, "bad attr->flags, err =3D %d\n", err);
>                 goto err_out;
>         }
>
>         err =3D rxe_cq_chk_attr(rxe, NULL, attr->cqe, attr->comp_vector);
>         if (err) {
> -               rxe_dbg_dev(rxe, "bad init attributes, err =3D %d", err);
> +               rxe_dbg_dev(rxe, "bad init attributes, err =3D %d\n", err=
);
>                 goto err_out;
>         }
>
>         err =3D rxe_add_to_pool(&rxe->cq_pool, cq);
>         if (err) {
> -               rxe_dbg_dev(rxe, "unable to create cq, err =3D %d", err);
> +               rxe_dbg_dev(rxe, "unable to create cq, err =3D %d\n", err=
);
>                 goto err_out;
>         }
>
>         err =3D rxe_cq_from_init(rxe, cq, attr->cqe, attr->comp_vector, u=
data,
>                                uresp);
>         if (err) {
> -               rxe_dbg_cq(cq, "create cq failed, err =3D %d", err);
> +               rxe_dbg_cq(cq, "create cq failed, err =3D %d\n", err);
>                 goto err_cleanup;
>         }
>
> @@ -1101,9 +1101,9 @@ static int rxe_create_cq(struct ib_cq *ibcq, const =
struct ib_cq_init_attr *attr,
>  err_cleanup:
>         cleanup_err =3D rxe_cleanup(cq);
>         if (cleanup_err)
> -               rxe_err_cq(cq, "cleanup failed, err =3D %d", cleanup_err)=
;
> +               rxe_err_cq(cq, "cleanup failed, err =3D %d\n", cleanup_er=
r);
>  err_out:
> -       rxe_err_dev(rxe, "returned err =3D %d", err);
> +       rxe_err_dev(rxe, "returned err =3D %d\n", err);
>         return err;
>  }
>
> @@ -1117,7 +1117,7 @@ static int rxe_resize_cq(struct ib_cq *ibcq, int cq=
e, struct ib_udata *udata)
>         if (udata) {
>                 if (udata->outlen < sizeof(*uresp)) {
>                         err =3D -EINVAL;
> -                       rxe_dbg_cq(cq, "malformed udata");
> +                       rxe_dbg_cq(cq, "malformed udata\n");
>                         goto err_out;
>                 }
>                 uresp =3D udata->outbuf;
> @@ -1125,20 +1125,20 @@ static int rxe_resize_cq(struct ib_cq *ibcq, int =
cqe, struct ib_udata *udata)
>
>         err =3D rxe_cq_chk_attr(rxe, cq, cqe, 0);
>         if (err) {
> -               rxe_dbg_cq(cq, "bad attr, err =3D %d", err);
> +               rxe_dbg_cq(cq, "bad attr, err =3D %d\n", err);
>                 goto err_out;
>         }
>
>         err =3D rxe_cq_resize_queue(cq, cqe, uresp, udata);
>         if (err) {
> -               rxe_dbg_cq(cq, "resize cq failed, err =3D %d", err);
> +               rxe_dbg_cq(cq, "resize cq failed, err =3D %d\n", err);
>                 goto err_out;
>         }
>
>         return 0;
>
>  err_out:
> -       rxe_err_cq(cq, "returned err =3D %d", err);
> +       rxe_err_cq(cq, "returned err =3D %d\n", err);
>         return err;
>  }
>
> @@ -1202,18 +1202,18 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, str=
uct ib_udata *udata)
>          */
>         if (atomic_read(&cq->num_wq)) {
>                 err =3D -EINVAL;
> -               rxe_dbg_cq(cq, "still in use");
> +               rxe_dbg_cq(cq, "still in use\n");
>                 goto err_out;
>         }
>
>         err =3D rxe_cleanup(cq);
>         if (err)
> -               rxe_err_cq(cq, "cleanup failed, err =3D %d", err);
> +               rxe_err_cq(cq, "cleanup failed, err =3D %d\n", err);
>
>         return 0;
>
>  err_out:
> -       rxe_err_cq(cq, "returned err =3D %d", err);
> +       rxe_err_cq(cq, "returned err =3D %d\n", err);
>         return err;
>  }
>
> @@ -1231,7 +1231,7 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *i=
bpd, int access)
>
>         err =3D rxe_add_to_pool(&rxe->mr_pool, mr);
>         if (err) {
> -               rxe_dbg_dev(rxe, "unable to create mr");
> +               rxe_dbg_dev(rxe, "unable to create mr\n");
>                 goto err_free;
>         }
>
> @@ -1245,7 +1245,7 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *i=
bpd, int access)
>
>  err_free:
>         kfree(mr);
> -       rxe_err_pd(pd, "returned err =3D %d", err);
> +       rxe_err_pd(pd, "returned err =3D %d\n", err);
>         return ERR_PTR(err);
>  }
>
> @@ -1259,7 +1259,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *=
ibpd, u64 start,
>         int err, cleanup_err;
>
>         if (access & ~RXE_ACCESS_SUPPORTED_MR) {
> -               rxe_err_pd(pd, "access =3D %#x not supported (%#x)", acce=
ss,
> +               rxe_err_pd(pd, "access =3D %#x not supported (%#x)\n", ac=
cess,
>                                 RXE_ACCESS_SUPPORTED_MR);
>                 return ERR_PTR(-EOPNOTSUPP);
>         }
> @@ -1270,7 +1270,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *=
ibpd, u64 start,
>
>         err =3D rxe_add_to_pool(&rxe->mr_pool, mr);
>         if (err) {
> -               rxe_dbg_pd(pd, "unable to create mr");
> +               rxe_dbg_pd(pd, "unable to create mr\n");
>                 goto err_free;
>         }
>
> @@ -1280,7 +1280,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *=
ibpd, u64 start,
>
>         err =3D rxe_mr_init_user(rxe, start, length, iova, access, mr);
>         if (err) {
> -               rxe_dbg_mr(mr, "reg_user_mr failed, err =3D %d", err);
> +               rxe_dbg_mr(mr, "reg_user_mr failed, err =3D %d\n", err);
>                 goto err_cleanup;
>         }
>
> @@ -1290,10 +1290,10 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd=
 *ibpd, u64 start,
>  err_cleanup:
>         cleanup_err =3D rxe_cleanup(mr);
>         if (cleanup_err)
> -               rxe_err_mr(mr, "cleanup failed, err =3D %d", cleanup_err)=
;
> +               rxe_err_mr(mr, "cleanup failed, err =3D %d\n", cleanup_er=
r);
>  err_free:
>         kfree(mr);
> -       rxe_err_pd(pd, "returned err =3D %d", err);
> +       rxe_err_pd(pd, "returned err =3D %d\n", err);
>         return ERR_PTR(err);
>  }
>
> @@ -1310,7 +1310,7 @@ static struct ib_mr *rxe_rereg_user_mr(struct ib_mr=
 *ibmr, int flags,
>          * rereg_pd and rereg_access
>          */
>         if (flags & ~RXE_MR_REREG_SUPPORTED) {
> -               rxe_err_mr(mr, "flags =3D %#x not supported", flags);
> +               rxe_err_mr(mr, "flags =3D %#x not supported\n", flags);
>                 return ERR_PTR(-EOPNOTSUPP);
>         }
>
> @@ -1322,7 +1322,7 @@ static struct ib_mr *rxe_rereg_user_mr(struct ib_mr=
 *ibmr, int flags,
>
>         if (flags & IB_MR_REREG_ACCESS) {
>                 if (access & ~RXE_ACCESS_SUPPORTED_MR) {
> -                       rxe_err_mr(mr, "access =3D %#x not supported", ac=
cess);
> +                       rxe_err_mr(mr, "access =3D %#x not supported\n", =
access);
>                         return ERR_PTR(-EOPNOTSUPP);
>                 }
>                 mr->access =3D access;
> @@ -1341,7 +1341,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibp=
d, enum ib_mr_type mr_type,
>
>         if (mr_type !=3D IB_MR_TYPE_MEM_REG) {
>                 err =3D -EINVAL;
> -               rxe_dbg_pd(pd, "mr type %d not supported, err =3D %d",
> +               rxe_dbg_pd(pd, "mr type %d not supported, err =3D %d\n",
>                            mr_type, err);
>                 goto err_out;
>         }
> @@ -1360,7 +1360,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibp=
d, enum ib_mr_type mr_type,
>
>         err =3D rxe_mr_init_fast(max_num_sg, mr);
>         if (err) {
> -               rxe_dbg_mr(mr, "alloc_mr failed, err =3D %d", err);
> +               rxe_dbg_mr(mr, "alloc_mr failed, err =3D %d\n", err);
>                 goto err_cleanup;
>         }
>
> @@ -1370,11 +1370,11 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *i=
bpd, enum ib_mr_type mr_type,
>  err_cleanup:
>         cleanup_err =3D rxe_cleanup(mr);
>         if (cleanup_err)
> -               rxe_err_mr(mr, "cleanup failed, err =3D %d", err);
> +               rxe_err_mr(mr, "cleanup failed, err =3D %d\n", err);
>  err_free:
>         kfree(mr);
>  err_out:
> -       rxe_err_pd(pd, "returned err =3D %d", err);
> +       rxe_err_pd(pd, "returned err =3D %d\n", err);
>         return ERR_PTR(err);
>  }
>
> @@ -1386,19 +1386,19 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, struc=
t ib_udata *udata)
>         /* See IBA 10.6.7.2.6 */
>         if (atomic_read(&mr->num_mw) > 0) {
>                 err =3D -EINVAL;
> -               rxe_dbg_mr(mr, "mr has mw's bound");
> +               rxe_dbg_mr(mr, "mr has mw's bound\n");
>                 goto err_out;
>         }
>
>         cleanup_err =3D rxe_cleanup(mr);
>         if (cleanup_err)
> -               rxe_err_mr(mr, "cleanup failed, err =3D %d", cleanup_err)=
;
> +               rxe_err_mr(mr, "cleanup failed, err =3D %d\n", cleanup_er=
r);
>
>         kfree_rcu_mightsleep(mr);
>         return 0;
>
>  err_out:
> -       rxe_err_mr(mr, "returned err =3D %d", err);
> +       rxe_err_mr(mr, "returned err =3D %d\n", err);
>         return err;
>  }
>
> --
> 2.29.2
>
>

