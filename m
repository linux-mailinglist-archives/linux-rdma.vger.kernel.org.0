Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC91B66D3D2
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 02:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbjAQBgT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Jan 2023 20:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbjAQBgR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Jan 2023 20:36:17 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D23241E1
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 17:36:16 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id v6so28904825ejg.6
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 17:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=suwy5QoNK436p3pS/105E8Jlfb0WTn0t0px3vla2uf0=;
        b=ZGPts6sHCSw593szpyAYr+dhaW6CnJaiU//ncOCBUcGvT4djl1GigBCp3rOa0rUx30
         V+Y4j0DfEXnn8iD1W3ugjK2JIvO/bYM3jhP8Uk0Has5ynQ7fUP8plPBP7ptDy8rApkmp
         eMDXNWwxNliVW7DexoYYNupt4msy1im79lXobrVFwu2t+KK4R4ZZBDo1P78B2vRCfE+a
         m44Nz0o6p9/8vYIbxDMJzKEj/aDRtfCVpEklvucbbeZ6pBVX9RSvAwKk6SM/KpoYbREE
         qZZwQPjdaK2wSLgij9YFz1r7HlrlTANMX03pZm6e2mZ+wuT5E6/f7Zu8Xx8Ah47k8VJP
         UNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suwy5QoNK436p3pS/105E8Jlfb0WTn0t0px3vla2uf0=;
        b=3mX89e06BH0WfHC7lanNDVBZKhZuFaEHMs8f6rIEtt8CBS6qt6O6d5bEvESX5GdEKm
         uanRHlFJFO9ZpwPV65wGJlPhMLE7EamUPP1u/cU2eRxFo3n0rgEea1Nx/E9S0BilXcLB
         71sGwKLXaV85PyAmnR4Ilk474EmlJTsUYLxmOlb2Axd5ulibAoC6lYj+iR0NeUxKB1AW
         lOhNafucAWvcilQxY/eOKJdjo4NVRd3QTckvStJUXHVpDr2QN/HV4xOjQL9KgG9t9Xi/
         fMdQIxGtQvqSwBaSh17Uu+rO8CfX1k4cmYrQGMk/8w1LXeg4PzWdDgzYPWcUeADkMQ8h
         WwGg==
X-Gm-Message-State: AFqh2kpAX1+7AIcjLUyY1bweS83SCARc6AA2L0Lc8RyaLOzovoCxxwgC
        cFcMobKGwr40p5CA7aH3N/FgBE24SjJtUuDPH50=
X-Google-Smtp-Source: AMrXdXvvVhdNFYqo20jQim9i42U2MYEFDeZpbEY0ANU3AOtVZFn7OsYPLcyrkQ7+Ea4GlsVGm65WqZZ4Ikqw3BiIcRM=
X-Received: by 2002:a17:906:2f10:b0:871:fe55:c5da with SMTP id
 v16-20020a1709062f1000b00871fe55c5damr129923eji.189.1673919374774; Mon, 16
 Jan 2023 17:36:14 -0800 (PST)
MIME-Version: 1.0
References: <20230113232704.20072-1-rpearsonhpe@gmail.com> <20230113232704.20072-5-rpearsonhpe@gmail.com>
In-Reply-To: <20230113232704.20072-5-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 17 Jan 2023 09:36:02 +0800
Message-ID: <CAD=hENc4W7ZXCa73oOnKbspf9TeVdZ096AYwHGp-HEtoT+m86g@mail.gmail.com>
Subject: Re: [PATCH for-next v3 4/6] RDMA-rxe: Isolate mr code from atomic_write_reply()
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, leonro@nvidia.com, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jan 14, 2023 at 7:28 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> Isolate mr specific code from atomic_write_reply() in rxe_resp.c into
> a subroutine rxe_mr_do_atomic_write() in rxe_mr.c.
> Check length for atomic write operation.
> Make iova_to_vaddr() static.
>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v3:
>   Fixed bug reported by kernel test robot. Ifdef'ed out atomic 8 byte
>   write if CONFIG_64BIT is not defined as orignally intended by the
>   developers of the atomic write implementation.
> link: https://lore.kernel.org/linux-rdma/202301131143.CmoyVcul-lkp@intel.com/
>
>  drivers/infiniband/sw/rxe/rxe_loc.h  |  1 +
>  drivers/infiniband/sw/rxe/rxe_mr.c   | 50 ++++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_resp.c | 58 +++++++++++-----------------
>  3 files changed, 73 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index bcb1bbcf50df..fd70c71a9e4e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -74,6 +74,7 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
>  void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
>  int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>                         u64 compare, u64 swap_add, u64 *orig_val);
> +int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, void *addr);
>  struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
>                          enum rxe_mr_lookup_type type);
>  int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 791731be6067..1e74f5e8e10b 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -568,6 +568,56 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>         return 0;
>  }
>
> +/**
> + * rxe_mr_do_atomic_write() - write 64bit value to iova from addr
> + * @mr: memory region
> + * @iova: iova in mr
> + * @addr: source of data to write
> + *
> + * Returns:
> + *      0 on success
> + *     -1 for misaligned address
> + *     -2 for access errors
> + *     -3 for cpu without native 64 bit support
> + */
> +int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, void *addr)
> +{
> +#if defined CONFIG_64BIT

IS_ENABLED is better?

Zhu Yanjun

> +       u64 *vaddr;
> +       u64 value;
> +       unsigned int length = 8;
> +
> +       /* See IBA oA19-28 */
> +       if (unlikely(mr->state != RXE_MR_STATE_VALID)) {
> +               rxe_dbg_mr(mr, "mr not valid");
> +               return -2;
> +       }
> +
> +       /* See IBA A19.4.2 */
> +       if (unlikely((uintptr_t)vaddr & 0x7 || iova & 0x7)) {
> +               rxe_dbg_mr(mr, "misaligned address");
> +               return -1;
> +       }
> +
> +       vaddr = iova_to_vaddr(mr, iova, length);
> +       if (unlikely(!vaddr)) {
> +               rxe_dbg_mr(mr, "iova out of range");
> +               return -2;
> +       }
> +
> +       /* this makes no sense. What of payload is not 8? */
> +       memcpy(&value, addr, length);
> +
> +       /* Do atomic write after all prior operations have completed */
> +       smp_store_release(vaddr, value);
> +
> +       return 0;
> +#else
> +       rxe_dbg_mr(mr, "64 bit integers not atomic");
> +       return -3;
> +#endif
> +}
> +
>  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
>  {
>         struct rxe_sge          *sge    = &dma->sge[dma->cur_sge];
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 02301e3f343c..1083cda22c65 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -762,26 +762,33 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
>         return RESPST_ACKNOWLEDGE;
>  }
>
> -#ifdef CONFIG_64BIT
> -static enum resp_states do_atomic_write(struct rxe_qp *qp,
> -                                       struct rxe_pkt_info *pkt)
> +static enum resp_states atomic_write_reply(struct rxe_qp *qp,
> +                                          struct rxe_pkt_info *pkt)
>  {
> +       u64 iova = qp->resp.va + qp->resp.offset;
> +       struct resp_res *res = qp->resp.res;
>         struct rxe_mr *mr = qp->resp.mr;
> +       void *addr = payload_addr(pkt);
>         int payload = payload_size(pkt);
> -       u64 src, *dst;
> -
> -       if (mr->state != RXE_MR_STATE_VALID)
> -               return RESPST_ERR_RKEY_VIOLATION;
> +       int err;
>
> -       memcpy(&src, payload_addr(pkt), payload);
> +       if (!res) {
> +               res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_WRITE_MASK);
> +               qp->resp.res = res;
> +       }
>
> -       dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
> -       /* check vaddr is 8 bytes aligned. */
> -       if (!dst || (uintptr_t)dst & 7)
> -               return RESPST_ERR_MISALIGNED_ATOMIC;
> +       if (res->replay)
> +               return RESPST_ACKNOWLEDGE;
>
> -       /* Do atomic write after all prior operations have completed */
> -       smp_store_release(dst, src);
> +       err = rxe_mr_do_atomic_write(mr, iova, addr);
> +       if (unlikely(err)) {
> +               if (err == -3)
> +                       return RESPST_ERR_UNSUPPORTED_OPCODE;
> +               else if (err == -2)
> +                       return RESPST_ERR_RKEY_VIOLATION;
> +               else
> +                       return RESPST_ERR_MISALIGNED_ATOMIC;
> +       }
>
>         /* decrease resp.resid to zero */
>         qp->resp.resid -= sizeof(payload);
> @@ -794,29 +801,8 @@ static enum resp_states do_atomic_write(struct rxe_qp *qp,
>
>         qp->resp.opcode = pkt->opcode;
>         qp->resp.status = IB_WC_SUCCESS;
> -       return RESPST_ACKNOWLEDGE;
> -}
> -#else
> -static enum resp_states do_atomic_write(struct rxe_qp *qp,
> -                                       struct rxe_pkt_info *pkt)
> -{
> -       return RESPST_ERR_UNSUPPORTED_OPCODE;
> -}
> -#endif /* CONFIG_64BIT */
> -
> -static enum resp_states atomic_write_reply(struct rxe_qp *qp,
> -                                          struct rxe_pkt_info *pkt)
> -{
> -       struct resp_res *res = qp->resp.res;
>
> -       if (!res) {
> -               res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_WRITE_MASK);
> -               qp->resp.res = res;
> -       }
> -
> -       if (res->replay)
> -               return RESPST_ACKNOWLEDGE;
> -       return do_atomic_write(qp, pkt);
> +       return RESPST_ACKNOWLEDGE;
>  }
>
>  static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
> --
> 2.37.2
>
