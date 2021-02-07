Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82F93122E8
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Feb 2021 09:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBGIyo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Feb 2021 03:54:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:32848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhBGIyn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 7 Feb 2021 03:54:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7335F64DEC;
        Sun,  7 Feb 2021 08:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612688043;
        bh=z//u+4sRXSdvTLOYd6FE/6KtHODD+DWrQ2rYoNAyzpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hxxgZ6jg4dVdcJyB4eEBuGtNmui5W0KogU01Ss/m7Uk41kySCgJnCp1DCWAyskTEg
         xbH13zuXqFpIcc7TAStH0hLmHNr/9SE0CTTyaVIDRJTM8zGIVj0b2r8lfSE+tERvs0
         fKRWiHTKWB179KDY1jIyHZ90O2oyP2iuvljFDaSSmg8XQw3LAURR6pPkcPyj/atM9l
         5xTV/FysgUDQqPoPf8J6zeDR8Tr+8LZ6DOBm+2CBc1H/Af39d9pbhMjYeqyuIjDGSL
         crzUPhPV9ov8OlUkUX7Ho1UdCZZPvFZMSEQNy+nh68cwGZqJLqkISO5ZmL8XMduBpr
         2G7/D4j43nfPw==
Date:   Sun, 7 Feb 2021 10:53:59 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     liweihang <liweihang@huawei.com>
Cc:     chenglang <chenglang@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH for-next 2/6] RDMA/hns: Remove unsupported CMDQ mode
Message-ID: <20210207085359.GD4656@unreal>
References: <1612419786-39173-1-git-send-email-liweihang@huawei.com>
 <1612419786-39173-3-git-send-email-liweihang@huawei.com>
 <aabcf1a1-1cdf-5d05-cc11-daa36f9f10fa@huawei.com>
 <11e5e5424ad94e329c11e7a7a77f585e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11e5e5424ad94e329c11e7a7a77f585e@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Feb 07, 2021 at 08:15:09AM +0000, liweihang wrote:
> On 2021/2/7 15:52, chenglang wrote:
> >
> > On 2021/2/4 14:23, Weihang Li wrote:
> >> From: Lang Cheng <chenglang@huawei.com>
> >>
> >> HIP08/09 only supports CMDQ in non-interrupt mode, and the firmware always
> >> ignores the flag to indicate the mode. Therefore, remove the dead code.
> >>
> >> Fixes: a04ff739f2a9 ("RDMA/hns: Add command queue support for hip08 RoCE driver")
> >> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> >> Signed-off-by: Weihang Li <liweihang@huawei.com>
> >> ---
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 24 ++++++++----------------
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  2 --
> >>  2 files changed, 8 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> index 7a5a41d..260c17c 100644
> >> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> @@ -1197,8 +1197,7 @@ static void hns_roce_cmq_setup_basic_desc(struct hns_roce_cmq_desc *desc,
> >>  {
> >>  	memset((void *)desc, 0, sizeof(struct hns_roce_cmq_desc));
> >>  	desc->opcode = cpu_to_le16(opcode);
> >> -	desc->flag =
> >> -		cpu_to_le16(HNS_ROCE_CMD_FLAG_NO_INTR | HNS_ROCE_CMD_FLAG_IN);
> >> +	desc->flag = cpu_to_le16(HNS_ROCE_CMD_FLAG_IN);
> >>  	if (is_read)
> >>  		desc->flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_WR);
> >>  	else
> >> @@ -1275,18 +1274,12 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
> >>  	/* Write to hardware */
> >>  	roce_write(hr_dev, ROCEE_TX_CMQ_TAIL_REG, csq->next_to_use);
> >>
> >> -	/*
> >> -	 * If the command is sync, wait for the firmware to write back,
> >> -	 * if multi descriptors to be sent, use the first one to check
> >> -	 */
> >> -	if (le16_to_cpu(desc->flag) & HNS_ROCE_CMD_FLAG_NO_INTR) {
> >> -		do {
> >> -			if (hns_roce_cmq_csq_done(hr_dev))
> >> -				break;
> >> -			udelay(1);
> >> -			timeout++;
> >> -		} while (timeout < priv->cmq.tx_timeout);
> >> -	}
> >> +	do {
> >> +		if (hns_roce_cmq_csq_done(hr_dev))
> >> +			break;
> >> +		udelay(1);
> >> +		timeout++;
> >> +	} while (timeout < priv->cmq.tx_timeout);
> >>
> >>  	if (hns_roce_cmq_csq_done(hr_dev)) {
> >>  		handle = 0;
> >> @@ -1626,8 +1619,7 @@ static int hns_roce_set_vf_switch_param(struct hns_roce_dev *hr_dev, int vf_id)
> >>  	if (ret)
> >>  		return ret;
> >>
> >> -	desc.flag =
> >> -		cpu_to_le16(HNS_ROCE_CMD_FLAG_NO_INTR | HNS_ROCE_CMD_FLAG_IN);
> >
> > The old firmware needs this redundant flag, it is best cleaned up after the
> > firmware version is released.
> >
> > Thanks.
>
> Got it, I will drop this one from the series.

And how will it work new kernel with old FW? Or isn't it possible and all
users must upgrade their kernel/FW at the same time?

Thanks

>
> Thanks
> Weihang
>
> >
> >> +	desc.flag = cpu_to_le16(HNS_ROCE_CMD_FLAG_IN);
> >>  	desc.flag &= cpu_to_le16(~HNS_ROCE_CMD_FLAG_WR);
> >>  	roce_set_bit(swt->cfg, VF_SWITCH_DATA_CFG_ALW_LPBK_S, 1);
> >>  	roce_set_bit(swt->cfg, VF_SWITCH_DATA_CFG_ALW_LCL_LPBK_S, 0);
> >> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> >> index 9f97e32..986a287 100644
> >> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> >> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> >> @@ -128,14 +128,12 @@
> >>  #define HNS_ROCE_CMD_FLAG_OUT_VALID_SHIFT	1
> >>  #define HNS_ROCE_CMD_FLAG_NEXT_SHIFT		2
> >>  #define HNS_ROCE_CMD_FLAG_WR_OR_RD_SHIFT	3
> >> -#define HNS_ROCE_CMD_FLAG_NO_INTR_SHIFT		4
> >>  #define HNS_ROCE_CMD_FLAG_ERR_INTR_SHIFT	5
> >>
> >>  #define HNS_ROCE_CMD_FLAG_IN		BIT(HNS_ROCE_CMD_FLAG_IN_VALID_SHIFT)
> >>  #define HNS_ROCE_CMD_FLAG_OUT		BIT(HNS_ROCE_CMD_FLAG_OUT_VALID_SHIFT)
> >>  #define HNS_ROCE_CMD_FLAG_NEXT		BIT(HNS_ROCE_CMD_FLAG_NEXT_SHIFT)
> >>  #define HNS_ROCE_CMD_FLAG_WR		BIT(HNS_ROCE_CMD_FLAG_WR_OR_RD_SHIFT)
> >> -#define HNS_ROCE_CMD_FLAG_NO_INTR	BIT(HNS_ROCE_CMD_FLAG_NO_INTR_SHIFT)
> >>  #define HNS_ROCE_CMD_FLAG_ERR_INTR	BIT(HNS_ROCE_CMD_FLAG_ERR_INTR_SHIFT)
> >>
> >>  #define HNS_ROCE_CMQ_DESC_NUM_S		3
>
