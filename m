Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91FED1623FC
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 10:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgBRJyJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 04:54:09 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35699 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgBRJyJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 04:54:09 -0500
Received: by mail-vs1-f65.google.com with SMTP id x123so12608145vsc.2
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 01:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MT62FXzJic7E+WpsCIr0F6PxBGATy+t5SE6eK7wPt6Q=;
        b=tomtntZ9f2eYDPlA86XkZ5+oMDNiB8I+PUCdIH80muEbjNxMwxMTAqKbqKRz+N9DwN
         iB1JYlGIBWdMZ9FrSmW6qrVxcOzGYKRUCUkX9mPcJMOuk5j8Wi/kG2NRPZyjTFOR4fMD
         ZtWztj0X6QUE5w/f44w+3J4CHH2lEQTAJFS+8L/CWuhlDC6tfhyrLctR8aOmhWWvoaOf
         bqIaJ758JCwIBk6mMEAVApsfiIHbj0PjaovBXkpwIQTOkRVDuua3LMs6QvS6QwpoJAaN
         bIGTaxtQQzhRGLO3H0248H64Z0WZOV+ax0Uzwba6CkiPFt5l/BGiRFsvtjmxaw4wV1B7
         NtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MT62FXzJic7E+WpsCIr0F6PxBGATy+t5SE6eK7wPt6Q=;
        b=lbZxxi9fxyfLJJS199+nQGo6D6ppQGPSxNlWcCqWIp456rE4JU7uYp2W3a8QTEWrBf
         Fp8HwprQDdDvQCKoC71/vz61Es/Aj/7NsiSBc9ptaq5dQ2lFjjeI9Q1fuWWzlM4HB1CC
         MB+kyfFI2G4aR8jd3mfn86lZcaRpUMmMvg3M/rHIhRv774PngoYOjBcpucP8FqVtY8ts
         wEwnI0SBl/o2YeOKZP2EgDe6bEPvMruCAID2RFM/kzYlG8VAPFFu0oKi/m4MHnlXOnMR
         KgWO+TIHyVe2RT/f43bhpdy3vkQFa9Rgk9+I134p05jBGciZO281Am3RBZpbJRxqZK4P
         f1KA==
X-Gm-Message-State: APjAAAU26Kb3CD/jk3VCJmGBpsjQ1P26DVQcvnkixyX5SKDfSljeVbQ4
        wHUwGh0DmTr3mCnIumUWFcljLyX7Mf3uLnHWTzI=
X-Google-Smtp-Source: APXvYqxPIIuSqDEXwt0125WGyqWxpLkmv3CdMpU/3RHRFsvipzNg4PRw9QB1l6SNyw92nRL623rbEZuz9pSiLpD0rHE=
X-Received: by 2002:a67:fd4e:: with SMTP id g14mr10488292vsr.182.1582019647438;
 Tue, 18 Feb 2020 01:54:07 -0800 (PST)
MIME-Version: 1.0
References: <20200217205714.26937-1-bvanassche@acm.org>
In-Reply-To: <20200217205714.26937-1-bvanassche@acm.org>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 18 Feb 2020 17:53:56 +0800
Message-ID: <CAD=hENff-t-xCrYOnCFLMKYgKDodxEamm-Z++U4W202MprEWDg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Fix configuration of atomic queue pair attributes
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Moni Shoua <monis@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Sorry, when max_rd_atomic will be set to 0?

Thanks,
Zhu Yanjun

On Tue, Feb 18, 2020 at 4:59 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> From the comment above the definition of the roundup_pow_of_two() macro:
>
>      The result is undefined when n == 0.
>
> Hence only pass positive values to roundup_pow_of_two(). This patch fixes
> the following UBSAN complaint:
>
> UBSAN: Undefined behaviour in ./include/linux/log2.h:57:13
> shift exponent 64 is too large for 64-bit type 'long unsigned int'
> Call Trace:
>  dump_stack+0xa5/0xe6
>  ubsan_epilogue+0x9/0x26
>  __ubsan_handle_shift_out_of_bounds.cold+0x4c/0xf9
>  rxe_qp_from_attr.cold+0x37/0x5d [rdma_rxe]
>  rxe_modify_qp+0x59/0x70 [rdma_rxe]
>  _ib_modify_qp+0x5aa/0x7c0 [ib_core]
>  ib_modify_qp+0x3b/0x50 [ib_core]
>  cma_modify_qp_rtr+0x234/0x260 [rdma_cm]
>  __rdma_accept+0x1a7/0x650 [rdma_cm]
>  nvmet_rdma_cm_handler+0x1286/0x14cd [nvmet_rdma]
>  cma_cm_event_handler+0x6b/0x330 [rdma_cm]
>  cma_ib_req_handler+0xe60/0x22d0 [rdma_cm]
>  cm_process_work+0x30/0x140 [ib_cm]
>  cm_req_handler+0x11f4/0x1cd0 [ib_cm]
>  cm_work_handler+0xb8/0x344e [ib_cm]
>  process_one_work+0x569/0xb60
>  worker_thread+0x7a/0x5d0
>  kthread+0x1e6/0x210
>  ret_from_fork+0x24/0x30
>
> Cc: Moni Shoua <monis@mellanox.com>
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index ec21f616ac98..6c11c3aeeca6 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -590,15 +590,16 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
>         int err;
>
>         if (mask & IB_QP_MAX_QP_RD_ATOMIC) {
> -               int max_rd_atomic = __roundup_pow_of_two(attr->max_rd_atomic);
> +               int max_rd_atomic = attr->max_rd_atomic ?
> +                       roundup_pow_of_two(attr->max_rd_atomic) : 0;
>
>                 qp->attr.max_rd_atomic = max_rd_atomic;
>                 atomic_set(&qp->req.rd_atomic, max_rd_atomic);
>         }
>
>         if (mask & IB_QP_MAX_DEST_RD_ATOMIC) {
> -               int max_dest_rd_atomic =
> -                       __roundup_pow_of_two(attr->max_dest_rd_atomic);
> +               int max_dest_rd_atomic = attr->max_dest_rd_atomic ?
> +                       roundup_pow_of_two(attr->max_dest_rd_atomic) : 0;
>
>                 qp->attr.max_dest_rd_atomic = max_dest_rd_atomic;
>
