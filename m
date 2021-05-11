Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6899379C60
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 04:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhEKCBZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 10 May 2021 22:01:25 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5098 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhEKCBY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 May 2021 22:01:24 -0400
Received: from dggeme705-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FfLfP53WQzYgmJ;
        Tue, 11 May 2021 09:57:49 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggeme705-chm.china.huawei.com (10.1.199.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 11 May 2021 10:00:16 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Tue, 11 May 2021 10:00:16 +0800
From:   liweihang <liweihang@huawei.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "wangxi (M)" <wangxi11@huawei.com>
Subject: Re: [PATCH for-next 3/7] RDMA/hns: Configure DCA mode for the
 userspace QP
Thread-Topic: [PATCH for-next 3/7] RDMA/hns: Configure DCA mode for the
 userspace QP
Thread-Index: AQHXRZr4owEwRkDRMkCfKblqmxpQuQ==
Date:   Tue, 11 May 2021 02:00:16 +0000
Message-ID: <e065c3f3fbec46b7b88c83e5c9d62244@huawei.com>
References: <1620650889-61650-1-git-send-email-liweihang@huawei.com>
 <1620650889-61650-4-git-send-email-liweihang@huawei.com>
 <CAD=hENdxY0u5bYYf8GXGQNiB-1-fh8h=ocKM=WKBUOmSO+tBgQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/5/10 22:36, Zhu Yanjun wrote:
> On Mon, May 10, 2021 at 9:28 PM Weihang Li <liweihang@huawei.com> wrote:
>> From: Xi Wang <wangxi11@huawei.com>
>>
>> If the userspace driver assign a NULL to the field of 'buf_addr' in
>> 'struct hns_roce_ib_create_qp' when creating QP, this means the kernel
>> driver need setup the QP as DCA mode. So add a QP capability bit in
>> response to indicate the userspace driver that the DCA mode has been
>> enabled.
>>
>> Signed-off-by: Xi Wang <wangxi11@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_dca.c    |  17 +++++
>>  drivers/infiniband/hw/hns/hns_roce_dca.h    |   3 +
>>  drivers/infiniband/hw/hns/hns_roce_device.h |   5 ++
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  23 +++++-
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   2 +
>>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 110 ++++++++++++++++++++++------
>>  include/uapi/rdma/hns-abi.h                 |   1 +
>>  7 files changed, 137 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.c b/drivers/infiniband/hw/hns/hns_roce_dca.c
>> index 604d6cf..5eec1fb 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_dca.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_dca.c
>> @@ -386,6 +386,23 @@ static void free_dca_mem(struct dca_mem *mem)
>>         spin_unlock(&mem->lock);
>>  }
>>
>> +int hns_roce_enable_dca(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
>> +{
>> +       struct hns_roce_dca_cfg *cfg = &hr_qp->dca_cfg;
>> +
>> +       cfg->buf_id = HNS_DCA_INVALID_BUF_ID;
>> +
>> +       return 0;
> The returned value is always 0?

You're right, I will change it to void, thank you.

> 
>> +}
>> +
>> +void hns_roce_disable_dca(struct hns_roce_dev *hr_dev,
>> +                         struct hns_roce_qp *hr_qp)
>> +{
>> +       struct hns_roce_dca_cfg *cfg = &hr_qp->dca_cfg;
>> +
>> +       cfg->buf_id = HNS_DCA_INVALID_BUF_ID;
>> +}
>> +
>>  static inline struct hns_roce_ucontext *
>>  uverbs_attr_to_hr_uctx(struct uverbs_attr_bundle *attrs)
>>  {
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.h b/drivers/infiniband/hw/hns/hns_roce_dca.h
>> index 97caf03..419606ef 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_dca.h
>> +++ b/drivers/infiniband/hw/hns/hns_roce_dca.h
>> @@ -26,4 +26,7 @@ void hns_roce_register_udca(struct hns_roce_dev *hr_dev,
>>  void hns_roce_unregister_udca(struct hns_roce_dev *hr_dev,
>>                               struct hns_roce_ucontext *uctx);
>>
>> +int hns_roce_enable_dca(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp);
>> +void hns_roce_disable_dca(struct hns_roce_dev *hr_dev,
>> +                         struct hns_roce_qp *hr_qp);
>>  #endif
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>> index 28fe33f..d1ca142 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>> @@ -332,6 +332,10 @@ struct hns_roce_mtr {
>>         struct hns_roce_hem_cfg  hem_cfg; /* config for hardware addressing */
>>  };
>>
>> +struct hns_roce_dca_cfg {
>> +       u32 buf_id;
>> +};
>> +
>>  struct hns_roce_mw {
>>         struct ib_mw            ibmw;
>>         u32                     pdn;
>> @@ -633,6 +637,7 @@ struct hns_roce_qp {
>>         struct hns_roce_wq      sq;
>>
>>         struct hns_roce_mtr     mtr;
>> +       struct hns_roce_dca_cfg dca_cfg;
>>
>>         u32                     buff_size;
>>         struct mutex            mutex;
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index edcfd39..9adac50 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -350,6 +350,11 @@ static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
>>         return 0;
>>  }
>>
>> +static inline bool check_qp_dca_enable(struct hns_roce_qp *hr_qp)
>> +{
>> +       return !!(hr_qp->en_flags & HNS_ROCE_QP_CAP_DCA);
>> +}
>> +
>>  static int check_send_valid(struct hns_roce_dev *hr_dev,
>>                             struct hns_roce_qp *hr_qp)
>>  {
>> @@ -4531,6 +4536,21 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
>>         roce_set_field(qpc_mask->byte_140_raq, V2_QPC_BYTE_140_TRRL_BA_M,
>>                        V2_QPC_BYTE_140_TRRL_BA_S, 0);
>>
>> +       /* hip09 reused the IRRL_HEAD fileds in hip08 */
>> +       if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
>> +               if (check_qp_dca_enable(hr_qp)) {
>> +                       roce_set_bit(context->byte_196_sq_psn,
>> +                                    V2_QPC_BYTE_196_DCA_MODE_S, 1);
>> +                       roce_set_bit(qpc_mask->byte_196_sq_psn,
>> +                                    V2_QPC_BYTE_196_DCA_MODE_S, 0);
>> +               }
>> +       } else {
>> +               /* reset IRRL_HEAD */
>> +               roce_set_field(qpc_mask->byte_196_sq_psn,
>> +                              V2_QPC_BYTE_196_IRRL_HEAD_M,
>> +                              V2_QPC_BYTE_196_IRRL_HEAD_S, 0);
>> +       }
>> +
>>         context->irrl_ba = cpu_to_le32(irrl_ba >> 6);
>>         qpc_mask->irrl_ba = 0;
>>         roce_set_field(context->byte_208_irrl, V2_QPC_BYTE_208_IRRL_BA_M,
>> @@ -4688,9 +4708,6 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
>>         roce_set_field(qpc_mask->byte_212_lsn, V2_QPC_BYTE_212_LSN_M,
>>                        V2_QPC_BYTE_212_LSN_S, 0);
>>
>> -       roce_set_field(qpc_mask->byte_196_sq_psn, V2_QPC_BYTE_196_IRRL_HEAD_M,
>> -                      V2_QPC_BYTE_196_IRRL_HEAD_S, 0);
>> -
>>         return 0;
>>  }
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>> index a2100a6..eecf27c 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>> @@ -853,6 +853,8 @@ struct hns_roce_v2_qp_context {
>>  #define        V2_QPC_BYTE_196_IRRL_HEAD_S 0
>>  #define V2_QPC_BYTE_196_IRRL_HEAD_M GENMASK(7, 0)
>>
>> +#define V2_QPC_BYTE_196_DCA_MODE_S 6
>> +
>>  #define        V2_QPC_BYTE_196_SQ_MAX_PSN_S 8
>>  #define V2_QPC_BYTE_196_SQ_MAX_PSN_M GENMASK(31, 8)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
>> index 230a909..a8740ef 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
>> @@ -39,6 +39,7 @@
>>  #include "hns_roce_common.h"
>>  #include "hns_roce_device.h"
>>  #include "hns_roce_hem.h"
>> +#include "hns_roce_dca.h"
>>
>>  static void flush_work_handle(struct work_struct *work)
>>  {
>> @@ -589,8 +590,21 @@ static int set_user_sq_size(struct hns_roce_dev *hr_dev,
>>         return 0;
>>  }
>>
>> +static bool check_dca_is_enable(struct hns_roce_dev *hr_dev, bool is_user,
>> +                               unsigned long addr)
>> +{
>> +       if (!(hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_DCA_MODE))
>> +               return false;
>> +
>> +       /* If the user QP's buffer addr is 0, the DCA mode should be enabled */
>> +       if (is_user)
>> +               return !addr;
>> +
>> +       return false;
>> +}
>> +
>>  static int set_wqe_buf_attr(struct hns_roce_dev *hr_dev,
>> -                           struct hns_roce_qp *hr_qp,
>> +                           struct hns_roce_qp *hr_qp, bool dca_en,
>>                             struct hns_roce_buf_attr *buf_attr)
>>  {
>>         int buf_size;
>> @@ -637,6 +651,19 @@ static int set_wqe_buf_attr(struct hns_roce_dev *hr_dev,
>>         buf_attr->page_shift = HNS_HW_PAGE_SHIFT + hr_dev->caps.mtt_buf_pg_sz;
>>         buf_attr->region_count = idx;
>>
>> +       if (dca_en) {
>> +               /*
>> +                * When enable DCA, there's no need to alloc buffer now, and
>> +                * the page shift should be fixed to 4K.
>> +                */
>> +               buf_attr->mtt_only = true;
>> +               buf_attr->page_shift = HNS_HW_PAGE_SHIFT;
>> +       } else {
>> +               buf_attr->mtt_only = false;
>> +               buf_attr->page_shift = HNS_HW_PAGE_SHIFT +
>> +                                      hr_dev->caps.mtt_buf_pg_sz;
>> +       }
>> +
>>         return 0;
>>  }
>>
>> @@ -735,12 +762,53 @@ static void free_rq_inline_buf(struct hns_roce_qp *hr_qp)
>>         kfree(hr_qp->rq_inl_buf.wqe_list);
>>  }
>>
>> -static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
>> +static int alloc_wqe_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
>> +                        bool dca_en, struct hns_roce_buf_attr *buf_attr,
>> +                        struct ib_udata *udata, unsigned long addr)
>> +{
>> +       struct ib_device *ibdev = &hr_dev->ib_dev;
>> +       int ret;
>> +
>> +       if (dca_en) {
>> +               /* DCA must be enabled after the buffer size is configured. */
>> +               ret = hns_roce_enable_dca(hr_dev, hr_qp);
> ret is always 0. The following will not be reached.
> 
> Zhu Yanjun
> 

Thanks for the reminder, I will fix this.

Weihang

>> +               if (ret) {
>> +                       ibdev_err(ibdev, "failed to enable DCA, ret = %d.\n",
>> +                                 ret);
>> +                       return ret;
>> +               }
>> +
>> +               hr_qp->en_flags |= HNS_ROCE_QP_CAP_DCA;
>> +       }

