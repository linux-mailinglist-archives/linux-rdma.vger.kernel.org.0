Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE95037924A
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 17:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241798AbhEJPQh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 11:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241106AbhEJPOy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 May 2021 11:14:54 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678D1C06125C
        for <linux-rdma@vger.kernel.org>; Mon, 10 May 2021 07:36:26 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso14552200otb.13
        for <linux-rdma@vger.kernel.org>; Mon, 10 May 2021 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VJjD8vvpttQtcv61IAPhFVbxPquTld4Hm8xW7uH+oRs=;
        b=kgU4j8jvDL/bg4EWDOKPhGOz1EzIji01d9Bd4VbbU9pw/++ZkpIZHLeLnltXbk6Zbc
         nrDNgHKcTYvMTvqO0M071uLdKqHLBtQnVsO57zAKi85a+vEUpUpxOfQ/Xkc0st4FFIMq
         pDfSil61eKKzqaq1rjYHKYbex0asNSXLpka0YghKNkfeal9OoBLpP65nyVoYDvOJh0uQ
         CtH06bgSWxwe5VVn+461CW4uUfnu9h130RsXiQ99fjDFL75S9Y4pcDFVNMjshpnmxgBJ
         ChychZiW5yEgHRj2SlWgaA1Cl/lHDiz0UKGLuoygtBSJaAzD++ANRQJdSzjTxJEfKv9I
         VlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VJjD8vvpttQtcv61IAPhFVbxPquTld4Hm8xW7uH+oRs=;
        b=aqDx1sK3To3QaR9tN7GVMZxIzWz7LhxoDU+6ZzBrBnC1eD2UG9Mv4bjdix8iiW2HOK
         PLeVL012Qy8VG0v5+T0SKHCT/v3LDMGzC2Z312YvQsuTxz+Y/otuZwnmu3ld8ixqpv0Z
         ckJyPdbtG/NDDN+t8zD/LLXxzSTHhec8hKNgzWCrhVkKW/7s7G3PR6DkNJIxEoP7oTy9
         DKJOCKMe3xpci87fBJ4f/wcEzVw8DIAIa9kgOvphcwJq3pbNio3fTV45HKjdNEp7Pfd3
         og01Zmb7Pvv06lhLbumAUZJVsXhbABVG0uiWObNrrt5sXenbYM8OZWc608clx9ceuhFm
         WSGg==
X-Gm-Message-State: AOAM533LIoj/DH1p2BbFf89oR7EnpkGrC5kT2kBIbELM5Z4wNGsUXgd2
        AEDcg19oRsGWqKbuga8tPTQRWuW5UcatS2HutkgIh7Rg
X-Google-Smtp-Source: ABdhPJwqC11lrs9D+dMeCrFhR0wVuYVtkp2ZR+RHvOcLkc7gc+2u613UF/PM7wZGe7U2wKCc0nKTyWPPH6dJp9lI7dI=
X-Received: by 2002:a05:6830:3495:: with SMTP id c21mr21406670otu.53.1620657385718;
 Mon, 10 May 2021 07:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <1620650889-61650-1-git-send-email-liweihang@huawei.com> <1620650889-61650-4-git-send-email-liweihang@huawei.com>
In-Reply-To: <1620650889-61650-4-git-send-email-liweihang@huawei.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 10 May 2021 22:36:14 +0800
Message-ID: <CAD=hENdxY0u5bYYf8GXGQNiB-1-fh8h=ocKM=WKBUOmSO+tBgQ@mail.gmail.com>
Subject: Re: [PATCH for-next 3/7] RDMA/hns: Configure DCA mode for the
 userspace QP
To:     Weihang Li <liweihang@huawei.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        linuxarm@huawei.com, Xi Wang <wangxi11@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 10, 2021 at 9:28 PM Weihang Li <liweihang@huawei.com> wrote:
>
> From: Xi Wang <wangxi11@huawei.com>
>
> If the userspace driver assign a NULL to the field of 'buf_addr' in
> 'struct hns_roce_ib_create_qp' when creating QP, this means the kernel
> driver need setup the QP as DCA mode. So add a QP capability bit in
> response to indicate the userspace driver that the DCA mode has been
> enabled.
>
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_dca.c    |  17 +++++
>  drivers/infiniband/hw/hns/hns_roce_dca.h    |   3 +
>  drivers/infiniband/hw/hns/hns_roce_device.h |   5 ++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  23 +++++-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   2 +
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 110 ++++++++++++++++++++++------
>  include/uapi/rdma/hns-abi.h                 |   1 +
>  7 files changed, 137 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.c b/drivers/infiniband/hw/hns/hns_roce_dca.c
> index 604d6cf..5eec1fb 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_dca.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_dca.c
> @@ -386,6 +386,23 @@ static void free_dca_mem(struct dca_mem *mem)
>         spin_unlock(&mem->lock);
>  }
>
> +int hns_roce_enable_dca(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
> +{
> +       struct hns_roce_dca_cfg *cfg = &hr_qp->dca_cfg;
> +
> +       cfg->buf_id = HNS_DCA_INVALID_BUF_ID;
> +
> +       return 0;

The returned value is always 0?

> +}
> +
> +void hns_roce_disable_dca(struct hns_roce_dev *hr_dev,
> +                         struct hns_roce_qp *hr_qp)
> +{
> +       struct hns_roce_dca_cfg *cfg = &hr_qp->dca_cfg;
> +
> +       cfg->buf_id = HNS_DCA_INVALID_BUF_ID;
> +}
> +
>  static inline struct hns_roce_ucontext *
>  uverbs_attr_to_hr_uctx(struct uverbs_attr_bundle *attrs)
>  {
> diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.h b/drivers/infiniband/hw/hns/hns_roce_dca.h
> index 97caf03..419606ef 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_dca.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_dca.h
> @@ -26,4 +26,7 @@ void hns_roce_register_udca(struct hns_roce_dev *hr_dev,
>  void hns_roce_unregister_udca(struct hns_roce_dev *hr_dev,
>                               struct hns_roce_ucontext *uctx);
>
> +int hns_roce_enable_dca(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp);
> +void hns_roce_disable_dca(struct hns_roce_dev *hr_dev,
> +                         struct hns_roce_qp *hr_qp);
>  #endif
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 28fe33f..d1ca142 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -332,6 +332,10 @@ struct hns_roce_mtr {
>         struct hns_roce_hem_cfg  hem_cfg; /* config for hardware addressing */
>  };
>
> +struct hns_roce_dca_cfg {
> +       u32 buf_id;
> +};
> +
>  struct hns_roce_mw {
>         struct ib_mw            ibmw;
>         u32                     pdn;
> @@ -633,6 +637,7 @@ struct hns_roce_qp {
>         struct hns_roce_wq      sq;
>
>         struct hns_roce_mtr     mtr;
> +       struct hns_roce_dca_cfg dca_cfg;
>
>         u32                     buff_size;
>         struct mutex            mutex;
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index edcfd39..9adac50 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -350,6 +350,11 @@ static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
>         return 0;
>  }
>
> +static inline bool check_qp_dca_enable(struct hns_roce_qp *hr_qp)
> +{
> +       return !!(hr_qp->en_flags & HNS_ROCE_QP_CAP_DCA);
> +}
> +
>  static int check_send_valid(struct hns_roce_dev *hr_dev,
>                             struct hns_roce_qp *hr_qp)
>  {
> @@ -4531,6 +4536,21 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
>         roce_set_field(qpc_mask->byte_140_raq, V2_QPC_BYTE_140_TRRL_BA_M,
>                        V2_QPC_BYTE_140_TRRL_BA_S, 0);
>
> +       /* hip09 reused the IRRL_HEAD fileds in hip08 */
> +       if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
> +               if (check_qp_dca_enable(hr_qp)) {
> +                       roce_set_bit(context->byte_196_sq_psn,
> +                                    V2_QPC_BYTE_196_DCA_MODE_S, 1);
> +                       roce_set_bit(qpc_mask->byte_196_sq_psn,
> +                                    V2_QPC_BYTE_196_DCA_MODE_S, 0);
> +               }
> +       } else {
> +               /* reset IRRL_HEAD */
> +               roce_set_field(qpc_mask->byte_196_sq_psn,
> +                              V2_QPC_BYTE_196_IRRL_HEAD_M,
> +                              V2_QPC_BYTE_196_IRRL_HEAD_S, 0);
> +       }
> +
>         context->irrl_ba = cpu_to_le32(irrl_ba >> 6);
>         qpc_mask->irrl_ba = 0;
>         roce_set_field(context->byte_208_irrl, V2_QPC_BYTE_208_IRRL_BA_M,
> @@ -4688,9 +4708,6 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
>         roce_set_field(qpc_mask->byte_212_lsn, V2_QPC_BYTE_212_LSN_M,
>                        V2_QPC_BYTE_212_LSN_S, 0);
>
> -       roce_set_field(qpc_mask->byte_196_sq_psn, V2_QPC_BYTE_196_IRRL_HEAD_M,
> -                      V2_QPC_BYTE_196_IRRL_HEAD_S, 0);
> -
>         return 0;
>  }
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> index a2100a6..eecf27c 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> @@ -853,6 +853,8 @@ struct hns_roce_v2_qp_context {
>  #define        V2_QPC_BYTE_196_IRRL_HEAD_S 0
>  #define V2_QPC_BYTE_196_IRRL_HEAD_M GENMASK(7, 0)
>
> +#define V2_QPC_BYTE_196_DCA_MODE_S 6
> +
>  #define        V2_QPC_BYTE_196_SQ_MAX_PSN_S 8
>  #define V2_QPC_BYTE_196_SQ_MAX_PSN_M GENMASK(31, 8)
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> index 230a909..a8740ef 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -39,6 +39,7 @@
>  #include "hns_roce_common.h"
>  #include "hns_roce_device.h"
>  #include "hns_roce_hem.h"
> +#include "hns_roce_dca.h"
>
>  static void flush_work_handle(struct work_struct *work)
>  {
> @@ -589,8 +590,21 @@ static int set_user_sq_size(struct hns_roce_dev *hr_dev,
>         return 0;
>  }
>
> +static bool check_dca_is_enable(struct hns_roce_dev *hr_dev, bool is_user,
> +                               unsigned long addr)
> +{
> +       if (!(hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_DCA_MODE))
> +               return false;
> +
> +       /* If the user QP's buffer addr is 0, the DCA mode should be enabled */
> +       if (is_user)
> +               return !addr;
> +
> +       return false;
> +}
> +
>  static int set_wqe_buf_attr(struct hns_roce_dev *hr_dev,
> -                           struct hns_roce_qp *hr_qp,
> +                           struct hns_roce_qp *hr_qp, bool dca_en,
>                             struct hns_roce_buf_attr *buf_attr)
>  {
>         int buf_size;
> @@ -637,6 +651,19 @@ static int set_wqe_buf_attr(struct hns_roce_dev *hr_dev,
>         buf_attr->page_shift = HNS_HW_PAGE_SHIFT + hr_dev->caps.mtt_buf_pg_sz;
>         buf_attr->region_count = idx;
>
> +       if (dca_en) {
> +               /*
> +                * When enable DCA, there's no need to alloc buffer now, and
> +                * the page shift should be fixed to 4K.
> +                */
> +               buf_attr->mtt_only = true;
> +               buf_attr->page_shift = HNS_HW_PAGE_SHIFT;
> +       } else {
> +               buf_attr->mtt_only = false;
> +               buf_attr->page_shift = HNS_HW_PAGE_SHIFT +
> +                                      hr_dev->caps.mtt_buf_pg_sz;
> +       }
> +
>         return 0;
>  }
>
> @@ -735,12 +762,53 @@ static void free_rq_inline_buf(struct hns_roce_qp *hr_qp)
>         kfree(hr_qp->rq_inl_buf.wqe_list);
>  }
>
> -static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
> +static int alloc_wqe_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
> +                        bool dca_en, struct hns_roce_buf_attr *buf_attr,
> +                        struct ib_udata *udata, unsigned long addr)
> +{
> +       struct ib_device *ibdev = &hr_dev->ib_dev;
> +       int ret;
> +
> +       if (dca_en) {
> +               /* DCA must be enabled after the buffer size is configured. */
> +               ret = hns_roce_enable_dca(hr_dev, hr_qp);

ret is always 0. The following will not be reached.

Zhu Yanjun

> +               if (ret) {
> +                       ibdev_err(ibdev, "failed to enable DCA, ret = %d.\n",
> +                                 ret);
> +                       return ret;
> +               }
> +
> +               hr_qp->en_flags |= HNS_ROCE_QP_CAP_DCA;
> +       }
> +
> +       ret = hns_roce_mtr_create(hr_dev, &hr_qp->mtr, buf_attr,
> +                                 HNS_HW_PAGE_SHIFT + hr_dev->caps.mtt_ba_pg_sz,
> +                                 udata, addr);
> +       if (ret) {
> +               ibdev_err(ibdev, "failed to create WQE mtr, ret = %d.\n", ret);
> +               if (dca_en)
> +                       hns_roce_disable_dca(hr_dev, hr_qp);
> +       }
> +
> +       return ret;
> +}
> +
> +static void free_wqe_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
> +                        struct ib_udata *udata)
> +{
> +       hns_roce_mtr_destroy(hr_dev, &hr_qp->mtr);
> +
> +       if (hr_qp->en_flags & HNS_ROCE_QP_CAP_DCA)
> +               hns_roce_disable_dca(hr_dev, hr_qp);
> +}
> +
> +static int alloc_qp_wqe(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
>                         struct ib_qp_init_attr *init_attr,
>                         struct ib_udata *udata, unsigned long addr)
>  {
>         struct ib_device *ibdev = &hr_dev->ib_dev;
>         struct hns_roce_buf_attr buf_attr = {};
> +       bool dca_en;
>         int ret;
>
>         if (!udata && hr_qp->rq_inl_buf.wqe_cnt) {
> @@ -755,16 +823,16 @@ static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
>                 hr_qp->rq_inl_buf.wqe_list = NULL;
>         }
>
> -       ret = set_wqe_buf_attr(hr_dev, hr_qp, &buf_attr);
> +       dca_en = check_dca_is_enable(hr_dev, !!udata, addr);
> +       ret = set_wqe_buf_attr(hr_dev, hr_qp, dca_en, &buf_attr);
>         if (ret) {
> -               ibdev_err(ibdev, "failed to split WQE buf, ret = %d.\n", ret);
> +               ibdev_err(ibdev, "failed to set WQE attr, ret = %d.\n", ret);
>                 goto err_inline;
>         }
> -       ret = hns_roce_mtr_create(hr_dev, &hr_qp->mtr, &buf_attr,
> -                                 HNS_HW_PAGE_SHIFT + hr_dev->caps.mtt_ba_pg_sz,
> -                                 udata, addr);
> +
> +       ret = alloc_wqe_buf(hr_dev, hr_qp, dca_en, &buf_attr, udata, addr);
>         if (ret) {
> -               ibdev_err(ibdev, "failed to create WQE mtr, ret = %d.\n", ret);
> +               ibdev_err(ibdev, "failed to alloc WQE buf, ret = %d.\n", ret);
>                 goto err_inline;
>         }
>
> @@ -775,9 +843,10 @@ static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
>         return ret;
>  }
>
> -static void free_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
> +static void free_qp_wqe(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
> +                       struct ib_udata *udata)
>  {
> -       hns_roce_mtr_destroy(hr_dev, &hr_qp->mtr);
> +       free_wqe_buf(hr_dev, hr_qp, udata);
>         free_rq_inline_buf(hr_qp);
>  }
>
> @@ -835,7 +904,6 @@ static int alloc_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
>                                 goto err_out;
>                         }
>                         hr_qp->en_flags |= HNS_ROCE_QP_CAP_SQ_RECORD_DB;
> -                       resp->cap_flags |= HNS_ROCE_QP_CAP_SQ_RECORD_DB;
>                 }
>
>                 if (user_qp_has_rdb(hr_dev, init_attr, udata, resp)) {
> @@ -848,7 +916,6 @@ static int alloc_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
>                                 goto err_sdb;
>                         }
>                         hr_qp->en_flags |= HNS_ROCE_QP_CAP_RQ_RECORD_DB;
> -                       resp->cap_flags |= HNS_ROCE_QP_CAP_RQ_RECORD_DB;
>                 }
>         } else {
>                 if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
> @@ -1027,18 +1094,18 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
>                 }
>         }
>
> -       ret = alloc_qp_buf(hr_dev, hr_qp, init_attr, udata, ucmd.buf_addr);
> -       if (ret) {
> -               ibdev_err(ibdev, "failed to alloc QP buffer, ret = %d.\n", ret);
> -               goto err_buf;
> -       }
> -
>         ret = alloc_qpn(hr_dev, hr_qp);
>         if (ret) {
>                 ibdev_err(ibdev, "failed to alloc QPN, ret = %d.\n", ret);
>                 goto err_qpn;
>         }
>
> +       ret = alloc_qp_wqe(hr_dev, hr_qp, init_attr, udata, ucmd.buf_addr);
> +       if (ret) {
> +               ibdev_err(ibdev, "failed to alloc QP buffer, ret = %d.\n", ret);
> +               goto err_buf;
> +       }
> +
>         ret = alloc_qp_db(hr_dev, hr_qp, init_attr, udata, &ucmd, &resp);
>         if (ret) {
>                 ibdev_err(ibdev, "failed to alloc QP doorbell, ret = %d.\n",
> @@ -1060,6 +1127,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
>         }
>
>         if (udata) {
> +               resp.cap_flags = hr_qp->en_flags;
>                 ret = ib_copy_to_udata(udata, &resp,
>                                        min(udata->outlen, sizeof(resp)));
>                 if (ret) {
> @@ -1088,10 +1156,10 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
>  err_qpc:
>         free_qp_db(hr_dev, hr_qp, udata);
>  err_db:
> +       free_qp_wqe(hr_dev, hr_qp, udata);
> +err_buf:
>         free_qpn(hr_dev, hr_qp);
>  err_qpn:
> -       free_qp_buf(hr_dev, hr_qp);
> -err_buf:
>         free_kernel_wrid(hr_qp);
>         return ret;
>  }
> @@ -1105,7 +1173,7 @@ void hns_roce_qp_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
>
>         free_qpc(hr_dev, hr_qp);
>         free_qpn(hr_dev, hr_qp);
> -       free_qp_buf(hr_dev, hr_qp);
> +       free_qp_wqe(hr_dev, hr_qp, udata);
>         free_kernel_wrid(hr_qp);
>         free_qp_db(hr_dev, hr_qp, udata);
>
> diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
> index bcca5be..99da481 100644
> --- a/include/uapi/rdma/hns-abi.h
> +++ b/include/uapi/rdma/hns-abi.h
> @@ -77,6 +77,7 @@ enum hns_roce_qp_cap_flags {
>         HNS_ROCE_QP_CAP_RQ_RECORD_DB = 1 << 0,
>         HNS_ROCE_QP_CAP_SQ_RECORD_DB = 1 << 1,
>         HNS_ROCE_QP_CAP_OWNER_DB = 1 << 2,
> +       HNS_ROCE_QP_CAP_DCA = 1 << 4,
>  };
>
>  struct hns_roce_ib_create_qp_resp {
> --
> 2.7.4
>
