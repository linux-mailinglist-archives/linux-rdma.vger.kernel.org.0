Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B2E557A68
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jun 2022 14:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiFWMfl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Jun 2022 08:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiFWMfk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Jun 2022 08:35:40 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86B441338
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jun 2022 05:35:37 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u189so4933678oib.4
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jun 2022 05:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9C2GQ9Ulp1b6YnCrEsaBjrJIIvHLrjIzeIsR+q3+W/4=;
        b=uWwKxXBkCKRdx3iYwLJ/8ZDvrYVoB+1GHBLAzaHcLIFDftA2voxjLWE9fOvlF7hbWf
         V+RwaoZPlnBsfdKY8Vdj2DVWDnkjakZVkXl3OXUYsLvIyXCIGjxF8xk8sEYHPVbaxvfX
         eP/6ABzpV+q1emtfZ9G1ACl5C5E3nM3X7Vy6CZaB1Wev1WP22+6Zuf1I/NNfu8WF6nmX
         qGCLzFghklGXlb7vsEmczfxpG6SLdNpMt1wSiiiP7wCpaJKyb7L7LSbDcecxHU+lr2Hz
         y4NFkZSVH9FwZ+tfLwliZaH6dNe4puApGNDUTMLT9gRn32wTabaVFBbaBvGWWun6wVi7
         zkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9C2GQ9Ulp1b6YnCrEsaBjrJIIvHLrjIzeIsR+q3+W/4=;
        b=TuQ6fP46kCqrMIzZcZGRZqQOoHsF9WEJSQddP6jaRuqJTTBPQgj88nHJ0lNw8TYBab
         MM3D2ZfQzRHLRGFXQOT2dPHxsRjluZDD6KovqI3ZEsn4Cm3sG069QZg5+LzfBnA5VLon
         61s/J7sOLPefCWRDT5Q16D02Z3izn4mAvOp++fIgk3rnxRDJid9607GxECP6HBXYKUmY
         mDUaJZFtGvyZZhTrw6UctYyN617RGqdfjSaVKll8h1ArllKrCGhTwxlhxHpuUJ0YRaqx
         2OwHIE8mTJBD5v/uxpfDjck3uV7I18rNtRuLSrDgxgG+v6BW+QpsD+GoMsIOYschKWbT
         s6tQ==
X-Gm-Message-State: AJIora8+YdSSpY4/blD3MAlXQ47iOk73ldZYhS9YU6SqZK2ATfKN9klM
        COU7CCKNUWKSm0a4Q/J/+VNmUDJzEn3T3yroIMnpFQ==
X-Google-Smtp-Source: AGRyM1secqzIdgl7cxbYNYLOKT6GhxiDbyKH487w1NGSVALpBPVoYlvm20+0dnzElQ/psyzuKl8Fae9I+yA8danUhUU=
X-Received: by 2002:a05:6808:1a06:b0:32f:1a3b:69d6 with SMTP id
 bk6-20020a0568081a0600b0032f1a3b69d6mr2015631oib.202.1655987737098; Thu, 23
 Jun 2022 05:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <1655810143-67784-1-git-send-email-john.garry@huawei.com> <1655810143-67784-4-git-send-email-john.garry@huawei.com>
In-Reply-To: <1655810143-67784-4-git-send-email-john.garry@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Jun 2022 14:35:00 +0200
Message-ID: <CAPDyKFqRzOceWJUODP0YEu348S4=OHdQA-3c3tEMAJshCQN+Qg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] blk-mq: Drop blk_mq_ops.timeout 'reserved' arg
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        bvanassche@acm.org, hch@lst.de, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com, linux-doc@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 21 Jun 2022 at 13:22, John Garry <john.garry@huawei.com> wrote:
>
> With new API blk_mq_is_reserved_rq() we can tell if a request is from
> the reserved pool, so stop passing 'reserved' arg. There is actually
> only a single user of that arg for all the callback implementations, which
> can use blk_mq_is_reserved_rq() instead.
>
> This will also allow us to stop passing the same 'reserved' around the
> blk-mq iter functions next.
>
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC

Kind regards
Uffe


> ---
>  block/blk-mq.c                    | 6 +++---
>  block/bsg-lib.c                   | 2 +-
>  drivers/block/mtip32xx/mtip32xx.c | 5 ++---
>  drivers/block/nbd.c               | 3 +--
>  drivers/block/null_blk/main.c     | 2 +-
>  drivers/mmc/core/queue.c          | 3 +--
>  drivers/nvme/host/apple.c         | 3 +--
>  drivers/nvme/host/fc.c            | 3 +--
>  drivers/nvme/host/pci.c           | 2 +-
>  drivers/nvme/host/rdma.c          | 3 +--
>  drivers/nvme/host/tcp.c           | 3 +--
>  drivers/s390/block/dasd.c         | 2 +-
>  drivers/s390/block/dasd_int.h     | 2 +-
>  drivers/scsi/scsi_error.c         | 3 +--
>  drivers/scsi/scsi_priv.h          | 3 +--
>  include/linux/blk-mq.h            | 2 +-
>  16 files changed, 19 insertions(+), 28 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d38c97fe89f5..81bd39e36e49 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1426,13 +1426,13 @@ bool blk_mq_queue_inflight(struct request_queue *q)
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_queue_inflight);
>
> -static void blk_mq_rq_timed_out(struct request *req, bool reserved)
> +static void blk_mq_rq_timed_out(struct request *req)
>  {
>         req->rq_flags |= RQF_TIMED_OUT;
>         if (req->q->mq_ops->timeout) {
>                 enum blk_eh_timer_return ret;
>
> -               ret = req->q->mq_ops->timeout(req, reserved);
> +               ret = req->q->mq_ops->timeout(req);
>                 if (ret == BLK_EH_DONE)
>                         return;
>                 WARN_ON_ONCE(ret != BLK_EH_RESET_TIMER);
> @@ -1481,7 +1481,7 @@ static bool blk_mq_check_expired(struct request *rq, void *priv, bool reserved)
>          * from blk_mq_check_expired().
>          */
>         if (blk_mq_req_expired(rq, next))
> -               blk_mq_rq_timed_out(rq, reserved);
> +               blk_mq_rq_timed_out(rq);
>         return true;
>  }
>
> diff --git a/block/bsg-lib.c b/block/bsg-lib.c
> index acfe1357bf6c..9570c77b9fe3 100644
> --- a/block/bsg-lib.c
> +++ b/block/bsg-lib.c
> @@ -331,7 +331,7 @@ void bsg_remove_queue(struct request_queue *q)
>  }
>  EXPORT_SYMBOL_GPL(bsg_remove_queue);
>
> -static enum blk_eh_timer_return bsg_timeout(struct request *rq, bool reserved)
> +static enum blk_eh_timer_return bsg_timeout(struct request *rq)
>  {
>         struct bsg_set *bset =
>                 container_of(rq->q->tag_set, struct bsg_set, tag_set);
> diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
> index 27386a572ba4..d5767215840c 100644
> --- a/drivers/block/mtip32xx/mtip32xx.c
> +++ b/drivers/block/mtip32xx/mtip32xx.c
> @@ -3487,12 +3487,11 @@ static int mtip_init_cmd(struct blk_mq_tag_set *set, struct request *rq,
>         return 0;
>  }
>
> -static enum blk_eh_timer_return mtip_cmd_timeout(struct request *req,
> -                                                               bool reserved)
> +static enum blk_eh_timer_return mtip_cmd_timeout(struct request *req)
>  {
>         struct driver_data *dd = req->q->queuedata;
>
> -       if (reserved) {
> +       if (blk_mq_is_reserved_rq(req)) {
>                 struct mtip_cmd *cmd = blk_mq_rq_to_pdu(req);
>
>                 cmd->status = BLK_STS_TIMEOUT;
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 07f3c139a3d7..166303716560 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -393,8 +393,7 @@ static u32 req_to_nbd_cmd_type(struct request *req)
>         }
>  }
>
> -static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
> -                                                bool reserved)
> +static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req)
>  {
>         struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
>         struct nbd_device *nbd = cmd->nbd;
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 6b67088f4ea7..2d815d1eba25 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1578,7 +1578,7 @@ static int null_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>         return nr;
>  }
>
> -static enum blk_eh_timer_return null_timeout_rq(struct request *rq, bool res)
> +static enum blk_eh_timer_return null_timeout_rq(struct request *rq)
>  {
>         struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>         struct nullb_cmd *cmd = blk_mq_rq_to_pdu(rq);
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index fa5324ceeebe..17236340dbd2 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -116,8 +116,7 @@ static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
>         }
>  }
>
> -static enum blk_eh_timer_return mmc_mq_timed_out(struct request *req,
> -                                                bool reserved)
> +static enum blk_eh_timer_return mmc_mq_timed_out(struct request *req)
>  {
>         struct request_queue *q = req->q;
>         struct mmc_queue *mq = q->queuedata;
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index d702d7d60235..495118ce958a 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -862,8 +862,7 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
>         }
>  }
>
> -static enum blk_eh_timer_return apple_nvme_timeout(struct request *req,
> -                                                  bool reserved)
> +static enum blk_eh_timer_return apple_nvme_timeout(struct request *req)
>  {
>         struct apple_nvme_iod *iod = blk_mq_rq_to_pdu(req);
>         struct apple_nvme_queue *q = iod->q;
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 3c778bb0c294..a166c0b1cc33 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2565,8 +2565,7 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
>         nvme_reset_ctrl(&ctrl->ctrl);
>  }
>
> -static enum blk_eh_timer_return
> -nvme_fc_timeout(struct request *rq, bool reserved)
> +static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
>  {
>         struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
>         struct nvme_fc_ctrl *ctrl = op->ctrl;
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c7012e85d035..83b1229a4e36 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1344,7 +1344,7 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
>                  "Try \"nvme_core.default_ps_max_latency_us=0 pcie_aspm=off\" and report a bug\n");
>  }
>
> -static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> +static enum blk_eh_timer_return nvme_timeout(struct request *req)
>  {
>         struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>         struct nvme_queue *nvmeq = iod->nvmeq;
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index f2a5e1ea508a..d2fb8651e49d 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -2013,8 +2013,7 @@ static void nvme_rdma_complete_timed_out(struct request *rq)
>         nvmf_complete_timed_out_request(rq);
>  }
>
> -static enum blk_eh_timer_return
> -nvme_rdma_timeout(struct request *rq, bool reserved)
> +static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
>  {
>         struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
>         struct nvme_rdma_queue *queue = req->queue;
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index bb67538d241b..f21f7b0140f9 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2321,8 +2321,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
>         nvmf_complete_timed_out_request(rq);
>  }
>
> -static enum blk_eh_timer_return
> -nvme_tcp_timeout(struct request *rq, bool reserved)
> +static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
>  {
>         struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>         struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index ba6d78789660..35d6f62ed515 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -3145,7 +3145,7 @@ static blk_status_t do_dasd_request(struct blk_mq_hw_ctx *hctx,
>   * BLK_EH_DONE if the request is handled or terminated
>   *                   by the driver.
>   */
> -enum blk_eh_timer_return dasd_times_out(struct request *req, bool reserved)
> +enum blk_eh_timer_return dasd_times_out(struct request *req)
>  {
>         struct dasd_block *block = req->q->queuedata;
>         struct dasd_device *device;
> diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
> index 83b918b84b4a..333a399f754e 100644
> --- a/drivers/s390/block/dasd_int.h
> +++ b/drivers/s390/block/dasd_int.h
> @@ -795,7 +795,7 @@ void dasd_free_device(struct dasd_device *);
>  struct dasd_block *dasd_alloc_block(void);
>  void dasd_free_block(struct dasd_block *);
>
> -enum blk_eh_timer_return dasd_times_out(struct request *req, bool reserved);
> +enum blk_eh_timer_return dasd_times_out(struct request *req);
>
>  void dasd_enable_device(struct dasd_device *);
>  void dasd_set_target_state(struct dasd_device *, int);
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index a8b71b73a5a5..266ce414589c 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -318,7 +318,6 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
>  /**
>   * scsi_timeout - Timeout function for normal scsi commands.
>   * @req:       request that is timing out.
> - * @reserved:  whether the request is a reserved request.
>   *
>   * Notes:
>   *     We do not need to lock this.  There is the potential for a race
> @@ -326,7 +325,7 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
>   *     normal completion function determines that the timer has already
>   *     fired, then it mustn't do anything.
>   */
> -enum blk_eh_timer_return scsi_timeout(struct request *req, bool reserved)
> +enum blk_eh_timer_return scsi_timeout(struct request *req)
>  {
>         struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(req);
>         enum blk_eh_timer_return rtn = BLK_EH_DONE;
> diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
> index 695d0c83ffe0..6eeaa0a7f86d 100644
> --- a/drivers/scsi/scsi_priv.h
> +++ b/drivers/scsi/scsi_priv.h
> @@ -72,8 +72,7 @@ extern void scsi_exit_devinfo(void);
>
>  /* scsi_error.c */
>  extern void scmd_eh_abort_handler(struct work_struct *work);
> -extern enum blk_eh_timer_return scsi_timeout(struct request *req,
> -                                            bool reserved);
> +extern enum blk_eh_timer_return scsi_timeout(struct request *req);
>  extern int scsi_error_handler(void *host);
>  extern enum scsi_disposition scsi_decide_disposition(struct scsi_cmnd *cmd);
>  extern void scsi_eh_wakeup(struct Scsi_Host *shost);
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 6d81fe10e850..fbb08bdd4618 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -575,7 +575,7 @@ struct blk_mq_ops {
>         /**
>          * @timeout: Called on request timeout.
>          */
> -       enum blk_eh_timer_return (*timeout)(struct request *, bool);
> +       enum blk_eh_timer_return (*timeout)(struct request *);
>
>         /**
>          * @poll: Called to poll for completion of a specific tag.
> --
> 2.25.1
>
