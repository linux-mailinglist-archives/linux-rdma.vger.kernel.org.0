Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69AC2157198
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 10:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgBJJZO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 04:25:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgBJJZO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Feb 2020 04:25:14 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDEC020733;
        Mon, 10 Feb 2020 09:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581326712;
        bh=rTfgD+G92DtyR6YokfxFBCztKzbYIZNwlOwcwyRcK/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=njapfsUpzUD+2o7z2cGdkk0CJFKZtb7sksxLdGMAF/r5GlOX+klkp0zSB9uCdSNC8
         IOf7b1C5Nv+Vc4q0mD3LAAoRbgWz2pMqKezzXkSYo6+6nZ33nUKRZo+N972uiqpKfs
         HweJnIez1mbdO+B2ZWGKh+iCADopyBfPer/oytkQ=
Date:   Mon, 10 Feb 2020 11:25:08 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Optimize eqe buffer allocation flow
Message-ID: <20200210092508.GB495280@unreal>
References: <20200126145835.11368-1-liweihang@huawei.com>
 <20200127055205.GH3870@unreal>
 <10b7a08c-e069-0751-8bde-e5d19521c0b2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10b7a08c-e069-0751-8bde-e5d19521c0b2@huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 05, 2020 at 02:04:09PM +0800, Weihang Li wrote:
>
>
> On 2020/1/27 13:52, Leon Romanovsky wrote:
> > On Sun, Jan 26, 2020 at 10:58:35PM +0800, Weihang Li wrote:
> >> From: Xi Wang <wangxi11@huawei.com>
> >>
> >> The eqe has a private multi-hop addressing implementation, but there is
> >> already a set of interfaces in the hns driver that can achieve this.
> >>
> >> So, simplify the eqe buffer allocation process by using the mtr interface
> >> and remove large amount of repeated logic.
> >>
> >> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> >> Signed-off-by: Weihang Li <liweihang@huawei.com>
> >> ---
> >>  drivers/infiniband/hw/hns/hns_roce_device.h |  10 +-
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 481 ++++++----------------------
> >>  2 files changed, 108 insertions(+), 383 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> >> index a4c45bf..dab3f3c 100644
> >> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> >> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> >> @@ -757,14 +757,8 @@ struct hns_roce_eq {
> >>  	int				eqe_ba_pg_sz;
> >>  	int				eqe_buf_pg_sz;
> >>  	int				hop_num;
> >> -	u64				*bt_l0;	/* Base address table for L0 */
> >> -	u64				**bt_l1; /* Base address table for L1 */
> >> -	u64				**buf;
> >> -	dma_addr_t			l0_dma;
> >> -	dma_addr_t			*l1_dma;
> >> -	dma_addr_t			*buf_dma;
> >> -	u32				l0_last_num; /* L0 last chunk num */
> >> -	u32				l1_last_num; /* L1 last chunk num */
> >> +	struct hns_roce_mtr		mtr;
> >> +	struct hns_roce_buf		buf;
> >>  	int				eq_max_cnt;
> >>  	int				eq_period;
> >>  	int				shift;
> >> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> index c462b19..88f2e76 100644
> >> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> @@ -5287,44 +5287,24 @@ static void set_eq_cons_index_v2(struct hns_roce_eq *eq)
> >>  	hns_roce_write64(hr_dev, doorbell, eq->doorbell);
> >>  }
> >>
> >> -static struct hns_roce_aeqe *get_aeqe_v2(struct hns_roce_eq *eq, u32 entry)
> >> +static inline void *get_eqe_buf(struct hns_roce_eq *eq, unsigned long offset)
> >>  {
> >>  	u32 buf_chk_sz;
> >> -	unsigned long off;
> >>
> >>  	buf_chk_sz = 1 << (eq->eqe_buf_pg_sz + PAGE_SHIFT);
> >> -	off = (entry & (eq->entries - 1)) * HNS_ROCE_AEQ_ENTRY_SIZE;
> >> -
> >> -	return (struct hns_roce_aeqe *)((char *)(eq->buf_list->buf) +
> >> -		off % buf_chk_sz);
> >> -}
> >> -
> >> -static struct hns_roce_aeqe *mhop_get_aeqe(struct hns_roce_eq *eq, u32 entry)
> >> -{
> >> -	u32 buf_chk_sz;
> >> -	unsigned long off;
> >> -
> >> -	buf_chk_sz = 1 << (eq->eqe_buf_pg_sz + PAGE_SHIFT);
> >> -
> >> -	off = (entry & (eq->entries - 1)) * HNS_ROCE_AEQ_ENTRY_SIZE;
> >> -
> >> -	if (eq->hop_num == HNS_ROCE_HOP_NUM_0)
> >> -		return (struct hns_roce_aeqe *)((u8 *)(eq->bt_l0) +
> >> -			off % buf_chk_sz);
> >> +	if (eq->buf.nbufs == 1)
> >> +		return eq->buf.direct.buf + offset % buf_chk_sz;
> >>  	else
> >> -		return (struct hns_roce_aeqe *)((u8 *)
> >> -			(eq->buf[off / buf_chk_sz]) + off % buf_chk_sz);
> >> +		return eq->buf.page_list[offset / buf_chk_sz].buf +
> >> +		       offset % buf_chk_sz;
> >>  }
> >>
> >>  static struct hns_roce_aeqe *next_aeqe_sw_v2(struct hns_roce_eq *eq)
> >>  {
> >>  	struct hns_roce_aeqe *aeqe;
> >>
> >> -	if (!eq->hop_num)
> >> -		aeqe = get_aeqe_v2(eq, eq->cons_index);
> >> -	else
> >> -		aeqe = mhop_get_aeqe(eq, eq->cons_index);
> >> -
> >> +	aeqe = get_eqe_buf(eq, (eq->cons_index & (eq->entries - 1)) *
> >> +			   HNS_ROCE_AEQ_ENTRY_SIZE);
> >>  	return (roce_get_bit(aeqe->asyn, HNS_ROCE_V2_AEQ_AEQE_OWNER_S) ^
> >>  		!!(eq->cons_index & eq->entries)) ? aeqe : NULL;
> >>  }
> >> @@ -5417,44 +5397,12 @@ static int hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
> >>  	return aeqe_found;
> >>  }
> >>
> >> -static struct hns_roce_ceqe *get_ceqe_v2(struct hns_roce_eq *eq, u32 entry)
> >> -{
> >> -	u32 buf_chk_sz;
> >> -	unsigned long off;
> >> -
> >> -	buf_chk_sz = 1 << (eq->eqe_buf_pg_sz + PAGE_SHIFT);
> >> -	off = (entry & (eq->entries - 1)) * HNS_ROCE_CEQ_ENTRY_SIZE;
> >> -
> >> -	return (struct hns_roce_ceqe *)((char *)(eq->buf_list->buf) +
> >> -		off % buf_chk_sz);
> >> -}
> >> -
> >> -static struct hns_roce_ceqe *mhop_get_ceqe(struct hns_roce_eq *eq, u32 entry)
> >> -{
> >> -	u32 buf_chk_sz;
> >> -	unsigned long off;
> >> -
> >> -	buf_chk_sz = 1 << (eq->eqe_buf_pg_sz + PAGE_SHIFT);
> >> -
> >> -	off = (entry & (eq->entries - 1)) * HNS_ROCE_CEQ_ENTRY_SIZE;
> >> -
> >> -	if (eq->hop_num == HNS_ROCE_HOP_NUM_0)
> >> -		return (struct hns_roce_ceqe *)((u8 *)(eq->bt_l0) +
> >> -			off % buf_chk_sz);
> >> -	else
> >> -		return (struct hns_roce_ceqe *)((u8 *)(eq->buf[off /
> >> -			buf_chk_sz]) + off % buf_chk_sz);
> >> -}
> >> -
> >>  static struct hns_roce_ceqe *next_ceqe_sw_v2(struct hns_roce_eq *eq)
> >>  {
> >>  	struct hns_roce_ceqe *ceqe;
> >>
> >> -	if (!eq->hop_num)
> >> -		ceqe = get_ceqe_v2(eq, eq->cons_index);
> >> -	else
> >> -		ceqe = mhop_get_ceqe(eq, eq->cons_index);
> >> -
> >> +	ceqe = get_eqe_buf(eq, (eq->cons_index & (eq->entries - 1)) *
> >> +			   HNS_ROCE_CEQ_ENTRY_SIZE);
> >>  	return (!!(roce_get_bit(ceqe->comp, HNS_ROCE_V2_CEQ_CEQE_OWNER_S))) ^
> >>  		(!!(eq->cons_index & eq->entries)) ? ceqe : NULL;
> >>  }
> >> @@ -5614,90 +5562,11 @@ static void hns_roce_v2_destroy_eqc(struct hns_roce_dev *hr_dev, int eqn)
> >>  		dev_err(dev, "[mailbox cmd] destroy eqc(%d) failed.\n", eqn);
> >>  }
> >>
> >> -static void hns_roce_mhop_free_eq(struct hns_roce_dev *hr_dev,
> >> -				  struct hns_roce_eq *eq)
> >> +static void free_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
> >>  {
> >> -	struct device *dev = hr_dev->dev;
> >> -	u64 idx;
> >> -	u64 size;
> >> -	u32 buf_chk_sz;
> >> -	u32 bt_chk_sz;
> >> -	u32 mhop_num;
> >> -	int eqe_alloc;
> >> -	int i = 0;
> >> -	int j = 0;
> >> -
> >> -	mhop_num = hr_dev->caps.eqe_hop_num;
> >> -	buf_chk_sz = 1 << (hr_dev->caps.eqe_buf_pg_sz + PAGE_SHIFT);
> >> -	bt_chk_sz = 1 << (hr_dev->caps.eqe_ba_pg_sz + PAGE_SHIFT);
> >> -
> >> -	if (mhop_num == HNS_ROCE_HOP_NUM_0) {
> >> -		dma_free_coherent(dev, (unsigned int)(eq->entries *
> >> -				  eq->eqe_size), eq->bt_l0, eq->l0_dma);
> >> -		return;
> >> -	}
> >> -
> >> -	dma_free_coherent(dev, bt_chk_sz, eq->bt_l0, eq->l0_dma);
> >> -	if (mhop_num == 1) {
> >> -		for (i = 0; i < eq->l0_last_num; i++) {
> >> -			if (i == eq->l0_last_num - 1) {
> >> -				eqe_alloc = i * (buf_chk_sz / eq->eqe_size);
> >> -				size = (eq->entries - eqe_alloc) * eq->eqe_size;
> >> -				dma_free_coherent(dev, size, eq->buf[i],
> >> -						  eq->buf_dma[i]);
> >> -				break;
> >> -			}
> >> -			dma_free_coherent(dev, buf_chk_sz, eq->buf[i],
> >> -					  eq->buf_dma[i]);
> >> -		}
> >> -	} else if (mhop_num == 2) {
> >> -		for (i = 0; i < eq->l0_last_num; i++) {
> >> -			dma_free_coherent(dev, bt_chk_sz, eq->bt_l1[i],
> >> -					  eq->l1_dma[i]);
> >> -
> >> -			for (j = 0; j < bt_chk_sz / BA_BYTE_LEN; j++) {
> >> -				idx = i * (bt_chk_sz / BA_BYTE_LEN) + j;
> >> -				if ((i == eq->l0_last_num - 1)
> >> -				     && j == eq->l1_last_num - 1) {
> >> -					eqe_alloc = (buf_chk_sz / eq->eqe_size)
> >> -						    * idx;
> >> -					size = (eq->entries - eqe_alloc)
> >> -						* eq->eqe_size;
> >> -					dma_free_coherent(dev, size,
> >> -							  eq->buf[idx],
> >> -							  eq->buf_dma[idx]);
> >> -					break;
> >> -				}
> >> -				dma_free_coherent(dev, buf_chk_sz, eq->buf[idx],
> >> -						  eq->buf_dma[idx]);
> >> -			}
> >> -		}
> >> -	}
> >> -	kfree(eq->buf_dma);
> >> -	kfree(eq->buf);
> >> -	kfree(eq->l1_dma);
> >> -	kfree(eq->bt_l1);
> >> -	eq->buf_dma = NULL;
> >> -	eq->buf = NULL;
> >> -	eq->l1_dma = NULL;
> >> -	eq->bt_l1 = NULL;
> >> -}
> >> -
> >> -static void hns_roce_v2_free_eq(struct hns_roce_dev *hr_dev,
> >> -				struct hns_roce_eq *eq)
> >> -{
> >> -	u32 buf_chk_sz;
> >> -
> >> -	buf_chk_sz = 1 << (eq->eqe_buf_pg_sz + PAGE_SHIFT);
> >> -
> >> -	if (hr_dev->caps.eqe_hop_num) {
> >> -		hns_roce_mhop_free_eq(hr_dev, eq);
> >> -		return;
> >> -	}
> >> -
> >> -	dma_free_coherent(hr_dev->dev, buf_chk_sz, eq->buf_list->buf,
> >> -			  eq->buf_list->map);
> >> -	kfree(eq->buf_list);
> >> +	if (!eq->hop_num || eq->hop_num == HNS_ROCE_HOP_NUM_0)
> >> +		hns_roce_mtr_cleanup(hr_dev, &eq->mtr);
> >> +	hns_roce_buf_free(hr_dev, eq->buf.size, &eq->buf);
> >>  }
> >>
> >>  static void hns_roce_config_eqc(struct hns_roce_dev *hr_dev,
> >> @@ -5705,6 +5574,8 @@ static void hns_roce_config_eqc(struct hns_roce_dev *hr_dev,
> >>  				void *mb_buf)
> >>  {
> >>  	struct hns_roce_eq_context *eqc;
> >> +	u64 ba[MTT_MIN_COUNT] = { 0 };
> >> +	int count;
> >>
> >>  	eqc = mb_buf;
> >>  	memset(eqc, 0, sizeof(struct hns_roce_eq_context));
> >> @@ -5720,10 +5591,23 @@ static void hns_roce_config_eqc(struct hns_roce_dev *hr_dev,
> >>  	eq->eqe_buf_pg_sz = hr_dev->caps.eqe_buf_pg_sz;
> >>  	eq->shift = ilog2((unsigned int)eq->entries);
> >>
> >> -	if (!eq->hop_num)
> >> -		eq->eqe_ba = eq->buf_list->map;
> >> -	else
> >> -		eq->eqe_ba = eq->l0_dma;
> >> +	/* if not muti-hop, eqe buffer only use one trunk */
> >> +	if (!eq->hop_num || eq->hop_num == HNS_ROCE_HOP_NUM_0) {
> >> +		eq->eqe_ba = eq->buf.direct.map;
> >> +		eq->cur_eqe_ba = eq->eqe_ba;
> >> +		if (eq->buf.npages > 1)
> >> +			eq->nxt_eqe_ba = eq->eqe_ba + (1 << eq->eqe_buf_pg_sz);
> >> +		else
> >> +			eq->nxt_eqe_ba = eq->eqe_ba;
> >> +	} else {
> >> +		count = hns_roce_mtr_find(hr_dev, &eq->mtr, 0, ba,
> >> +					  MTT_MIN_COUNT, &eq->eqe_ba);
> >> +		eq->cur_eqe_ba = ba[0];
> >> +		if (count > 1)
> >> +			eq->nxt_eqe_ba = ba[1];
> >> +		else
> >> +			eq->nxt_eqe_ba = ba[0];
> >> +	}
> >>
> >>  	/* set eqc state */
> >>  	roce_set_field(eqc->byte_4, HNS_ROCE_EQC_EQ_ST_M, HNS_ROCE_EQC_EQ_ST_S,
> >> @@ -5821,220 +5705,97 @@ static void hns_roce_config_eqc(struct hns_roce_dev *hr_dev,
> >>  		       HNS_ROCE_EQC_NXT_EQE_BA_H_S, eq->nxt_eqe_ba >> 44);
> >>  }
> >>
> >> -static int hns_roce_mhop_alloc_eq(struct hns_roce_dev *hr_dev,
> >> -				  struct hns_roce_eq *eq)
> >> +static int map_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq,
> >> +		      u32 page_shift)
> >>  {
> >> -	struct device *dev = hr_dev->dev;
> >> -	int eq_alloc_done = 0;
> >> -	int eq_buf_cnt = 0;
> >> -	int eqe_alloc;
> >> -	u32 buf_chk_sz;
> >> -	u32 bt_chk_sz;
> >> -	u32 mhop_num;
> >> -	u64 size;
> >> -	u64 idx;
> >> +	struct hns_roce_buf_region region = {};
> >> +	dma_addr_t *buf_list = NULL;
> >>  	int ba_num;
> >> -	int bt_num;
> >> -	int record_i;
> >> -	int record_j;
> >> -	int i = 0;
> >> -	int j = 0;
> >> -
> >> -	mhop_num = hr_dev->caps.eqe_hop_num;
> >> -	buf_chk_sz = 1 << (hr_dev->caps.eqe_buf_pg_sz + PAGE_SHIFT);
> >> -	bt_chk_sz = 1 << (hr_dev->caps.eqe_ba_pg_sz + PAGE_SHIFT);
> >> +	int ret;
> >>
> >>  	ba_num = DIV_ROUND_UP(PAGE_ALIGN(eq->entries * eq->eqe_size),
> >> -			      buf_chk_sz);
> >> -	bt_num = DIV_ROUND_UP(ba_num, bt_chk_sz / BA_BYTE_LEN);
> >> +			      1 << page_shift);
> >> +	hns_roce_init_buf_region(&region, hr_dev->caps.eqe_hop_num, 0, ba_num);
> >>
> >> -	if (mhop_num == HNS_ROCE_HOP_NUM_0) {
> >> -		if (eq->entries > buf_chk_sz / eq->eqe_size) {
> >> -			dev_err(dev, "eq entries %d is larger than buf_pg_sz!",
> >> -				eq->entries);
> >> -			return -EINVAL;
> >> -		}
> >> -		eq->bt_l0 = dma_alloc_coherent(dev, eq->entries * eq->eqe_size,
> >> -					       &(eq->l0_dma), GFP_KERNEL);
> >> -		if (!eq->bt_l0)
> >> -			return -ENOMEM;
> >> -
> >> -		eq->cur_eqe_ba = eq->l0_dma;
> >> -		eq->nxt_eqe_ba = 0;
> >> +	/* alloc a tmp list for storing eq buf address */
> >> +	ret = hns_roce_alloc_buf_list(&region, &buf_list, 1);
> >> +	if (ret) {
> >> +		dev_err(hr_dev->dev, "alloc eq buf_list error\n");
> >
> > The same comment like we gave for bnxt driver, no dev_* prints inside
> > driver, use ibdev_*.
> >
> > Thanks
> >
>
> Hi Leon,
>
> map_eq_buf() is called before ib_register_device(), so we can't use
> ibdev_* here.

As long as map_eq_buf() is called after ib_alloc_device(), you will be fine.

Thanks

>
> Thanks for your reminder, another patch that replace other dev_* in
> hns driver with ibdev_* is on preparing.
>
> Weihang
>
> > .
> >
>
