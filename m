Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB46A27FC95
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 11:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbgJAJn3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 05:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgJAJn0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Oct 2020 05:43:26 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E147C0613E2
        for <linux-rdma@vger.kernel.org>; Thu,  1 Oct 2020 02:43:24 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a3so6269631ejy.11
        for <linux-rdma@vger.kernel.org>; Thu, 01 Oct 2020 02:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sIL7YWchxQh0HMxDpALUCyXAT9jfaqSYKSJBqEU12Ss=;
        b=fVLu+0jn7T5rBwdmDNKf8bE0Bsw4ZStWEqIcyLsNV390ZFPHbRNkD2GjmQBZhNwbTE
         JH1IloRak1ivqNksytM38M0Gw7HyDjKWXBEL1ETkeDMSMqX4712vJ3MBhIygF+NfscyZ
         kzPuv7N07V79c/oHbjvDvJHSffuICpgHtYt4EfJSmrhGLzVUfmn5I4PVdAj+0bimUBZB
         FCUtRwg/TiYor2W/BPn2jbXKBqGS4Fa95Z0+r5dJgYVISTtTTfYCUoPIDDnG7eENT2MD
         dYaZPc7d2iqH/a98bNokf2ACtFHPns2Iwzc8lGHavcEWeeHSa/SOKHAewDXzA2ayRqnO
         e6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sIL7YWchxQh0HMxDpALUCyXAT9jfaqSYKSJBqEU12Ss=;
        b=Mf2glLrR3fZ0YzwbYlxNWyvc1wADzVLZat8n5advrJttbZ4zk9xy3HLcwNyomu23Up
         l502K6ELjrfQ2oFrcjkXjcKE9TLAZN8vA/os9bvQc4px+nfIU7jBLpKSWGbEVINMrjuy
         Cez570NGNnDo/kT/GS02j4sdtz6oj4wDlVEPZbEblF8442YY18q6MiHTY6c9CnybN3VK
         LCzhvAMUXcABhWqWlMhUEQ+bBzAOlknyQQH2iAA4b9dRxSmf/WTo9sG6jnPw83OCv+Ey
         EGsESyJrUYvZskVgrJH9smwcQp3GJ8MeeqZNQui/wZ9Pp+HYnfvrosoTjEu/fuCE1bHM
         IYHA==
X-Gm-Message-State: AOAM5333a4B84HJ0QHTsgnYxWlbQhwO/pqzn//7ul5Xn3YDtLcft7cOV
        7XXYalJTWybSRKhVZYC25ihzS9Fe6BRnsYMwoGk6vg==
X-Google-Smtp-Source: ABdhPJyfS3hMSmGUeFDKu3RUMiA8MgRN08rPyRRfA7JRMafp+bgvro6i3RO6j6OR+gSRdM7E08ISKHTqrEnYlInjNPU=
X-Received: by 2002:a17:906:364d:: with SMTP id r13mr2193169ejb.521.1601545402554;
 Thu, 01 Oct 2020 02:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201001072637.16121-1-gi-oh.kim@clous.ionos.com>
In-Reply-To: <20201001072637.16121-1-gi-oh.kim@clous.ionos.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 1 Oct 2020 11:43:11 +0200
Message-ID: <CAMGffE=R=DZ7kDwcp-1NORYAvVwiHj8pX4UEdBa+2rX59Z_W9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] RDMA/rtrs: remove unnecessary argument dir of rtrs_iu_free
To:     Gioh Kim <gi-oh.kim@cloud.ionos.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 1, 2020 at 9:26 AM Gioh Kim <gi-oh.kim@cloud.ionos.com> wrote:
>
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
>
> The direction of DMA operation is already in the rtrs_iu.
>
> Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Looks fine to me!
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 14 ++++++--------
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h |  3 +--
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 14 ++++++--------
>  drivers/infiniband/ulp/rtrs/rtrs.c     | 10 +++++-----
>  4 files changed, 18 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 776e89231c52..7af5f1559451 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1236,8 +1236,7 @@ static void free_sess_reqs(struct rtrs_clt_sess *sess)
>                 if (req->mr)
>                         ib_dereg_mr(req->mr);
>                 kfree(req->sge);
> -               rtrs_iu_free(req->iu, DMA_TO_DEVICE,
> -                             sess->s.dev->ib_dev, 1);
> +               rtrs_iu_free(req->iu, sess->s.dev->ib_dev, 1);
>         }
>         kfree(sess->reqs);
>         sess->reqs = NULL;
> @@ -1605,8 +1604,7 @@ static void destroy_con_cq_qp(struct rtrs_clt_con *con)
>
>         rtrs_cq_qp_destroy(&con->c);
>         if (con->rsp_ius) {
> -               rtrs_iu_free(con->rsp_ius, DMA_FROM_DEVICE,
> -                             sess->s.dev->ib_dev, con->queue_size);
> +               rtrs_iu_free(con->rsp_ius, sess->s.dev->ib_dev, con->queue_size);
>                 con->rsp_ius = NULL;
>                 con->queue_size = 0;
>         }
> @@ -2245,7 +2243,7 @@ static void rtrs_clt_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
>         struct rtrs_iu *iu;
>
>         iu = container_of(wc->wr_cqe, struct rtrs_iu, cqe);
> -       rtrs_iu_free(iu, DMA_TO_DEVICE, sess->s.dev->ib_dev, 1);
> +       rtrs_iu_free(iu, sess->s.dev->ib_dev, 1);
>
>         if (unlikely(wc->status != IB_WC_SUCCESS)) {
>                 rtrs_err(sess->clt, "Sess info request send failed: %s\n",
> @@ -2374,7 +2372,7 @@ static void rtrs_clt_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
>
>  out:
>         rtrs_clt_update_wc_stats(con);
> -       rtrs_iu_free(iu, DMA_FROM_DEVICE, sess->s.dev->ib_dev, 1);
> +       rtrs_iu_free(iu, sess->s.dev->ib_dev, 1);
>         rtrs_clt_change_state(sess, state);
>  }
>
> @@ -2436,9 +2434,9 @@ static int rtrs_send_sess_info(struct rtrs_clt_sess *sess)
>
>  out:
>         if (tx_iu)
> -               rtrs_iu_free(tx_iu, DMA_TO_DEVICE, sess->s.dev->ib_dev, 1);
> +               rtrs_iu_free(tx_iu, sess->s.dev->ib_dev, 1);
>         if (rx_iu)
> -               rtrs_iu_free(rx_iu, DMA_FROM_DEVICE, sess->s.dev->ib_dev, 1);
> +               rtrs_iu_free(rx_iu, sess->s.dev->ib_dev, 1);
>         if (unlikely(err))
>                 /* If we've never taken async path because of malloc problems */
>                 rtrs_clt_change_state(sess, RTRS_CLT_CONNECTING_ERR);
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> index 0a93c87ef92b..63b128c6eb04 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> @@ -288,8 +288,7 @@ struct rtrs_msg_rdma_hdr {
>  struct rtrs_iu *rtrs_iu_alloc(u32 queue_size, size_t size, gfp_t t,
>                               struct ib_device *dev, enum dma_data_direction,
>                               void (*done)(struct ib_cq *cq, struct ib_wc *wc));
> -void rtrs_iu_free(struct rtrs_iu *iu, enum dma_data_direction dir,
> -                 struct ib_device *dev, u32 queue_size);
> +void rtrs_iu_free(struct rtrs_iu *iu, struct ib_device *dev, u32 queue_size);
>  int rtrs_iu_post_recv(struct rtrs_con *con, struct rtrs_iu *iu);
>  int rtrs_iu_post_send(struct rtrs_con *con, struct rtrs_iu *iu, size_t size,
>                       struct ib_send_wr *head);
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index a219bd1bdbc2..b8763fe9152f 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -575,8 +575,7 @@ static void unmap_cont_bufs(struct rtrs_srv_sess *sess)
>                 struct rtrs_srv_mr *srv_mr;
>
>                 srv_mr = &sess->mrs[i];
> -               rtrs_iu_free(srv_mr->iu, DMA_TO_DEVICE,
> -                             sess->s.dev->ib_dev, 1);
> +               rtrs_iu_free(srv_mr->iu, sess->s.dev->ib_dev, 1);
>                 ib_dereg_mr(srv_mr->mr);
>                 ib_dma_unmap_sg(sess->s.dev->ib_dev, srv_mr->sgt.sgl,
>                                 srv_mr->sgt.nents, DMA_BIDIRECTIONAL);
> @@ -680,8 +679,7 @@ static int map_cont_bufs(struct rtrs_srv_sess *sess)
>                         sgt = &srv_mr->sgt;
>                         mr = srv_mr->mr;
>  free_iu:
> -                       rtrs_iu_free(srv_mr->iu, DMA_TO_DEVICE,
> -                                     sess->s.dev->ib_dev, 1);
> +                       rtrs_iu_free(srv_mr->iu, sess->s.dev->ib_dev, 1);
>  dereg_mr:
>                         ib_dereg_mr(mr);
>  unmap_sg:
> @@ -733,7 +731,7 @@ static void rtrs_srv_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
>         struct rtrs_iu *iu;
>
>         iu = container_of(wc->wr_cqe, struct rtrs_iu, cqe);
> -       rtrs_iu_free(iu, DMA_TO_DEVICE, sess->s.dev->ib_dev, 1);
> +       rtrs_iu_free(iu, sess->s.dev->ib_dev, 1);
>
>         if (unlikely(wc->status != IB_WC_SUCCESS)) {
>                 rtrs_err(s, "Sess info response send failed: %s\n",
> @@ -859,7 +857,7 @@ static int process_info_req(struct rtrs_srv_con *con,
>         if (unlikely(err)) {
>                 rtrs_err(s, "rtrs_iu_post_send(), err: %d\n", err);
>  iu_free:
> -               rtrs_iu_free(tx_iu, DMA_TO_DEVICE, sess->s.dev->ib_dev, 1);
> +               rtrs_iu_free(tx_iu, sess->s.dev->ib_dev, 1);
>         }
>  rwr_free:
>         kfree(rwr);
> @@ -904,7 +902,7 @@ static void rtrs_srv_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
>                 goto close;
>
>  out:
> -       rtrs_iu_free(iu, DMA_FROM_DEVICE, sess->s.dev->ib_dev, 1);
> +       rtrs_iu_free(iu, sess->s.dev->ib_dev, 1);
>         return;
>  close:
>         close_sess(sess);
> @@ -927,7 +925,7 @@ static int post_recv_info_req(struct rtrs_srv_con *con)
>         err = rtrs_iu_post_recv(&con->c, rx_iu);
>         if (unlikely(err)) {
>                 rtrs_err(s, "rtrs_iu_post_recv(), err: %d\n", err);
> -               rtrs_iu_free(rx_iu, DMA_FROM_DEVICE, sess->s.dev->ib_dev, 1);
> +               rtrs_iu_free(rx_iu, sess->s.dev->ib_dev, 1);
>                 return err;
>         }
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
> index ff1093d6e4bc..5163e662f86f 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> @@ -31,6 +31,8 @@ struct rtrs_iu *rtrs_iu_alloc(u32 queue_size, size_t size, gfp_t gfp_mask,
>                 return NULL;
>         for (i = 0; i < queue_size; i++) {
>                 iu = &ius[i];
> +               iu->direction = dir;
> +
>                 iu->buf = kzalloc(size, gfp_mask);
>                 if (!iu->buf)
>                         goto err;
> @@ -41,17 +43,15 @@ struct rtrs_iu *rtrs_iu_alloc(u32 queue_size, size_t size, gfp_t gfp_mask,
>
>                 iu->cqe.done  = done;
>                 iu->size      = size;
> -               iu->direction = dir;
>         }
>         return ius;
>  err:
> -       rtrs_iu_free(ius, dir, dma_dev, i);
> +       rtrs_iu_free(ius, dma_dev, i);
>         return NULL;
>  }
>  EXPORT_SYMBOL_GPL(rtrs_iu_alloc);
>
> -void rtrs_iu_free(struct rtrs_iu *ius, enum dma_data_direction dir,
> -                  struct ib_device *ibdev, u32 queue_size)
> +void rtrs_iu_free(struct rtrs_iu *ius, struct ib_device *ibdev, u32 queue_size)
>  {
>         struct rtrs_iu *iu;
>         int i;
> @@ -61,7 +61,7 @@ void rtrs_iu_free(struct rtrs_iu *ius, enum dma_data_direction dir,
>
>         for (i = 0; i < queue_size; i++) {
>                 iu = &ius[i];
> -               ib_dma_unmap_single(ibdev, iu->dma_addr, iu->size, dir);
> +               ib_dma_unmap_single(ibdev, iu->dma_addr, iu->size, iu->direction);
>                 kfree(iu->buf);
>         }
>         kfree(ius);
> --
> 2.20.1
>
