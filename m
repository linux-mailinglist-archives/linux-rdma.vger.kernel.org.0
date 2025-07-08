Return-Path: <linux-rdma+bounces-11950-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FACAFC0D1
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 04:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853D21AA442B
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 02:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8C621D5BB;
	Tue,  8 Jul 2025 02:27:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5FA202F9F
	for <linux-rdma@vger.kernel.org>; Tue,  8 Jul 2025 02:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751941676; cv=none; b=ayllZBz4ckFK1AqHj5gvE/TuzYGErHLRK45UXz+xCJtccgH2WnZDarnlqsYKGdZ9ewGjpyLW/j/FXdNqgM99bVSJAqmC5lQetiEzug8xrGiH1Gyt69rOG5TxQpi2iZAUJGU+Cm1TrlIQFq4fYY8heUhnJmBp6DtH+M6H6YDJRy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751941676; c=relaxed/simple;
	bh=x3stsEdh9QVCnXi268ds53CzMPxKZlVTz7cWmsRdz2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eiby8ppLGDvKo4ypUNNMCbckUdHDtSb8uWhC1n4WQwn1RGAj1kZPIiNqMtWVk6vaT89PXgV7g8eNVepggt0UPhcqH5C46kaFnh8N2fDkkXhxEDwjy3o18P7hNUJiUqKI8sUaT/uAIcOgSLXT6llNVB09u3zYpBXwmgz507KANi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bblK90kwpz2Cfb5;
	Tue,  8 Jul 2025 10:23:41 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 5965D140276;
	Tue,  8 Jul 2025 10:27:44 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Jul 2025 10:27:43 +0800
Message-ID: <4e151293-76f5-b44d-5045-d699e16a316d@hisilicon.com>
Date: Tue, 8 Jul 2025 10:27:42 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH rdma-next 7/8] IB: Extend UVERBS_METHOD_REG_MR to get DMAH
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Yishai Hadas <yishaih@nvidia.com>, Bernard Metzler <bmt@zurich.ibm.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>, Chengchang Tang
	<tangchengchang@huawei.com>, Cheng Xu <chengyou@linux.alibaba.com>, Christian
 Benvenuti <benve@cisco.com>, Dennis Dalessandro
	<dennis.dalessandro@cornelisnetworks.com>, Edward Srouji
	<edwards@nvidia.com>, Kai Shen <kaishen@linux.alibaba.com>, Kalesh AP
	<kalesh-anakkur.purayil@broadcom.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, <linux-rdma@vger.kernel.org>, Long Li
	<longli@microsoft.com>, Michael Margolin <mrgolin@amazon.com>, Michal
 Kalderon <mkalderon@marvell.com>, Mustafa Ismail <mustafa.ismail@intel.com>,
	Nelson Escobar <neescoba@cisco.com>, Potnuri Bharat Teja
	<bharat@chelsio.com>, Selvin Xavier <selvin.xavier@broadcom.com>, Tatyana
 Nikolova <tatyana.e.nikolova@intel.com>, Vishnu Dasa
	<vishnu.dasa@broadcom.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
References: <cover.1751907231.git.leon@kernel.org>
 <dede37bca92e66fcb2744ea68b629649d1b57517.1751907231.git.leon@kernel.org>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <dede37bca92e66fcb2744ea68b629649d1b57517.1751907231.git.leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2025/7/8 1:03, Leon Romanovsky wrote:
> From: Yishai Hadas <yishaih@nvidia.com>
> 
> Extend UVERBS_METHOD_REG_MR to get DMAH and pass it to all drivers.
> 
> It will be used in mlx5 driver as part of the next patch from the
> series.
> 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> Reviewed-by: Edward Srouji <edwards@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c          |  2 +-
>  drivers/infiniband/core/uverbs_std_types_mr.c | 21 ++++++++++++++++---
>  drivers/infiniband/core/verbs.c               |  5 ++++-
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  8 +++++++
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h      |  2 ++
>  drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |  1 +
>  drivers/infiniband/hw/cxgb4/mem.c             |  6 +++++-
>  drivers/infiniband/hw/efa/efa.h               |  2 ++
>  drivers/infiniband/hw/efa/efa_verbs.c         |  8 +++++++
>  drivers/infiniband/hw/erdma/erdma_verbs.c     |  6 +++++-
>  drivers/infiniband/hw/erdma/erdma_verbs.h     |  3 ++-
>  drivers/infiniband/hw/hns/hns_roce_device.h   |  1 +
>  drivers/infiniband/hw/hns/hns_roce_mr.c       |  4 ++++
>  drivers/infiniband/hw/irdma/verbs.c           |  9 ++++++++
>  drivers/infiniband/hw/mana/mana_ib.h          |  2 ++
>  drivers/infiniband/hw/mana/mr.c               |  8 +++++++
>  drivers/infiniband/hw/mlx4/mlx4_ib.h          |  1 +
>  drivers/infiniband/hw/mlx4/mr.c               |  4 ++++
>  drivers/infiniband/hw/mlx5/mlx5_ib.h          |  2 ++
>  drivers/infiniband/hw/mlx5/mr.c               |  8 ++++---
>  drivers/infiniband/hw/mthca/mthca_provider.c  |  6 +++++-
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  6 +++++-
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |  3 ++-
>  drivers/infiniband/hw/qedr/verbs.c            |  6 +++++-
>  drivers/infiniband/hw/qedr/verbs.h            |  3 ++-
>  drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |  4 ++++
>  drivers/infiniband/hw/usnic/usnic_ib_verbs.h  |  1 +
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c  |  5 +++++
>  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  1 +
>  drivers/infiniband/sw/rdmavt/mr.c             |  5 +++++
>  drivers/infiniband/sw/rdmavt/mr.h             |  1 +
>  drivers/infiniband/sw/rxe/rxe_verbs.c         |  4 ++++
>  drivers/infiniband/sw/siw/siw_verbs.c         |  7 ++++++-
>  drivers/infiniband/sw/siw/siw_verbs.h         |  3 ++-
>  include/rdma/ib_verbs.h                       |  3 +++
>  include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
>  36 files changed, 144 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 25f77b1fa773..78ee04a48a74 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -1219,6 +1219,7 @@ int hns_roce_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);
>  struct ib_mr *hns_roce_get_dma_mr(struct ib_pd *pd, int acc);
>  struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
>  				   u64 virt_addr, int access_flags,
> +				   struct ib_dmah *dmah,
>  				   struct ib_udata *udata);
>  struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *mr, int flags, u64 start,
>  				     u64 length, u64 virt_addr,
> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
> index ebef93559225..03af842dd9d3 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
> @@ -231,12 +231,16 @@ struct ib_mr *hns_roce_get_dma_mr(struct ib_pd *pd, int acc)
>  
>  struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
>  				   u64 virt_addr, int access_flags,
> +				   struct ib_dmah *dmah,
>  				   struct ib_udata *udata)
>  {
>  	struct hns_roce_dev *hr_dev = to_hr_dev(pd->device);
>  	struct hns_roce_mr *mr;
>  	int ret;
>  
> +	if (dmah)
> +		return ERR_PTR(-EOPNOTSUPP);
> +

Could you change hns part as below? We have an error counter in the err_out label.

Thanks
Junxian

diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index ebef93559225..e6ad6de97f10 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -237,6 +237,11 @@ struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
        struct hns_roce_mr *mr;
        int ret;

+       if (dmah) {
+               ret = -EOPNOTSUPP;
+               goto err_out;
+       }
+
        mr = kzalloc(sizeof(*mr), GFP_KERNEL);
        if (!mr) {
                ret = -ENOMEM;

>  	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
>  	if (!mr) {
>  		ret = -ENOMEM;

