Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0BB328D8
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2019 08:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfFCGwN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jun 2019 02:52:13 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35458 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfFCGwN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jun 2019 02:52:13 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x536hqiN175132;
        Mon, 3 Jun 2019 06:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=FQv9oY9NkEy7LeWY79PDvOhUMbeGWERkR6oIO/sjwnU=;
 b=Uho7t/tU9koqjpet86PZ+VcNdY+Ts6ma+Nd/H3HdLAJgLEVsfX2eZddpJf6tgV1L/yEm
 Bjdq+nfr9XNiRPDSof0c92pO259UTf3h9++5ackFWlvdCcWrgpUvMedO/EIgoHMAHTVB
 jL5OpKf7x2Z7unvWU70tDIFH2Y4wbv5BOOdc4uFO+OZrU994GNFRWNFic7EwmDW1XEz1
 ayYdEIS/MntHhDs0oEnVhHoWPzSiq7KRX5fnzLIovYKPYl09A8e2tIwirtFdfVdjRxlN
 OiLcKByEuVIbTVClJjLZ1vw+EByg6WNWpJOmObXu8wNtgmlua+am1sLoDZyAh0C3AonZ cQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2suevd56hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jun 2019 06:51:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x536oa5F154335;
        Mon, 3 Jun 2019 06:51:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2sv36s2ebd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jun 2019 06:51:38 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x536pZch030478;
        Mon, 3 Jun 2019 06:51:35 GMT
Received: from srabinov-laptop (/109.186.248.99)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 02 Jun 2019 23:51:34 -0700
Date:   Mon, 3 Jun 2019 09:51:26 +0300
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     leonro@mellanox.com, linux-rdma@vger.kernel.org, jgg@mellanox.com,
        dledford@redhat.com, sagi@grimberg.me, hch@lst.de,
        bvanassche@acm.org, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: Re: [PATCH 06/20] RDMA/mlx5: Implement mlx5_ib_map_mr_sg_pi and
 mlx5_ib_alloc_mr_integrity
Message-ID: <20190603065125.GA7534@srabinov-laptop>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-7-git-send-email-maxg@mellanox.com>
 <20190602091335.GA18026@srabinov-laptop>
 <4daaef16-eb1d-e55b-9923-39345cf34a5b@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4daaef16-eb1d-e55b-9923-39345cf34a5b@mellanox.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9276 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906030049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9276 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906030049
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 02, 2019 at 05:22:18PM +0300, Max Gurtovoy wrote:
> 
> On 6/2/2019 12:13 PM, Shamir Rabinovitch wrote:
> > On Thu, May 30, 2019 at 04:25:17PM +0300, Max Gurtovoy wrote:
> > > mlx5_ib_map_mr_sg_pi() will map the PI and data dma mapped SG lists to the
> > > mlx5 memory region prior to the registration operation. In the new
> > > API, the mlx5 driver will allocate an internal memory region for the
> > > UMR operation to register both PI and data SG lists. The internal MR
> > > will use KLM mode in order to map 2 (possibly non-contiguous/non-align)
> > > SG lists using 1 memory key. In the new API, each ULP will use 1 memory
> > > region for the signature operation (instead of 3 in the old API). This
> > > memory region will have a key that will be exposed to remote server to
> > > perform RDMA operation. The internal memory key that will map the SG lists
> > > will stay private.
> > > 
> > > Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> > > Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> > > ---
> > >   drivers/infiniband/hw/mlx5/main.c    |   2 +
> > >   drivers/infiniband/hw/mlx5/mlx5_ib.h |  11 +++
> > >   drivers/infiniband/hw/mlx5/mr.c      | 184 ++++++++++++++++++++++++++++++++---
> > >   3 files changed, 186 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> > > index abac70ad5c7c..b6588cdef1cf 100644
> > > --- a/drivers/infiniband/hw/mlx5/main.c
> > > +++ b/drivers/infiniband/hw/mlx5/main.c
> > > @@ -6126,6 +6126,7 @@ static void mlx5_ib_stage_flow_db_cleanup(struct mlx5_ib_dev *dev)
> > >   static const struct ib_device_ops mlx5_ib_dev_ops = {
> > >   	.add_gid = mlx5_ib_add_gid,
> > >   	.alloc_mr = mlx5_ib_alloc_mr,
> > > +	.alloc_mr_integrity = mlx5_ib_alloc_mr_integrity,
> > >   	.alloc_pd = mlx5_ib_alloc_pd,
> > >   	.alloc_ucontext = mlx5_ib_alloc_ucontext,
> > >   	.attach_mcast = mlx5_ib_mcg_attach,
> > > @@ -6155,6 +6156,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
> > >   	.get_dma_mr = mlx5_ib_get_dma_mr,
> > >   	.get_link_layer = mlx5_ib_port_link_layer,
> > >   	.map_mr_sg = mlx5_ib_map_mr_sg,
> > > +	.map_mr_sg_pi = mlx5_ib_map_mr_sg_pi,
> > >   	.mmap = mlx5_ib_mmap,
> > >   	.modify_cq = mlx5_ib_modify_cq,
> > >   	.modify_device = mlx5_ib_modify_device,
> > > diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > > index 40eb8be482e4..07bac37c3450 100644
> > > --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > > +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > > @@ -587,6 +587,9 @@ struct mlx5_ib_mr {
> > >   	void			*descs;
> > >   	dma_addr_t		desc_map;
> > >   	int			ndescs;
> > > +	int			data_length;
> > > +	int			meta_ndescs;
> > > +	int			meta_length;
> > >   	int			max_descs;
> > >   	int			desc_size;
> > >   	int			access_mode;
> > > @@ -605,6 +608,7 @@ struct mlx5_ib_mr {
> > >   	int			access_flags; /* Needed for rereg MR */
> > >   	struct mlx5_ib_mr      *parent;
> > > +	struct mlx5_ib_mr      *pi_mr; /* Needed for IB_MR_TYPE_INTEGRITY */
> > >   	atomic_t		num_leaf_free;
> > >   	wait_queue_head_t       q_leaf_free;
> > >   	struct mlx5_async_work  cb_work;
> > > @@ -1148,8 +1152,15 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
> > >   int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
> > >   struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
> > >   			       u32 max_num_sg, struct ib_udata *udata);
> > > +struct ib_mr *mlx5_ib_alloc_mr_integrity(struct ib_pd *pd,
> > > +					 u32 max_num_sg,
> > > +					 u32 max_num_meta_sg);
> > >   int mlx5_ib_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
> > >   		      unsigned int *sg_offset);
> > > +int mlx5_ib_map_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist *data_sg,
> > > +			 int data_sg_nents, unsigned int *data_sg_offset,
> > > +			 struct scatterlist *meta_sg, int meta_sg_nents,
> > > +			 unsigned int *meta_sg_offset);
> > >   int mlx5_ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
> > >   			const struct ib_wc *in_wc, const struct ib_grh *in_grh,
> > >   			const struct ib_mad_hdr *in, size_t in_mad_size,
> > > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> > > index 5f09699fab98..6820d80c6a7f 100644
> > > --- a/drivers/infiniband/hw/mlx5/mr.c
> > > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > > @@ -1639,16 +1639,22 @@ static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
> > >   int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
> > >   {
> > > -	dereg_mr(to_mdev(ibmr->device), to_mmr(ibmr));
> > > +	struct mlx5_ib_mr *mmr = to_mmr(ibmr);
> > > +
> > > +	if (ibmr->type == IB_MR_TYPE_INTEGRITY)
> > > +		dereg_mr(to_mdev(mmr->pi_mr->ibmr.device), mmr->pi_mr);
> > > +
> > > +	dereg_mr(to_mdev(ibmr->device), mmr);
> > > +
> > >   	return 0;
> > >   }
> > > -struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
> > > -			       u32 max_num_sg, struct ib_udata *udata)
> > > +static struct mlx5_ib_mr *mlx5_ib_alloc_pi_mr(struct ib_pd *pd,
> > > +				u32 max_num_sg, u32 max_num_meta_sg)
> > >   {
> > >   	struct mlx5_ib_dev *dev = to_mdev(pd->device);
> > >   	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
> > > -	int ndescs = ALIGN(max_num_sg, 4);
> > > +	int ndescs = ALIGN(max_num_sg + max_num_meta_sg, 4);
> > >   	struct mlx5_ib_mr *mr;
> > >   	void *mkc;
> > >   	u32 *in;
> > > @@ -1670,8 +1676,72 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
> > >   	MLX5_SET(mkc, mkc, qpn, 0xffffff);
> > >   	MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
> > > +	mr->access_mode = MLX5_MKC_ACCESS_MODE_KLMS;
> > > +
> > > +	err = mlx5_alloc_priv_descs(pd->device, mr,
> > > +				    ndescs, sizeof(struct mlx5_klm));
> > > +	if (err)
> > > +		goto err_free_in;
> > > +	mr->desc_size = sizeof(struct mlx5_klm);
> > > +	mr->max_descs = ndescs;
> > > +
> > > +	MLX5_SET(mkc, mkc, access_mode_1_0, mr->access_mode & 0x3);
> > > +	MLX5_SET(mkc, mkc, access_mode_4_2, (mr->access_mode >> 2) & 0x7);
> > > +	MLX5_SET(mkc, mkc, umr_en, 1);
> > > +
> > > +	mr->ibmr.pd = pd;
> > > +	mr->ibmr.device = pd->device;
> > > +	err = mlx5_core_create_mkey(dev->mdev, &mr->mmkey, in, inlen);
> > > +	if (err)
> > > +		goto err_priv_descs;
> > > +
> > > +	mr->mmkey.type = MLX5_MKEY_MR;
> > > +	mr->ibmr.lkey = mr->mmkey.key;
> > > +	mr->ibmr.rkey = mr->mmkey.key;
> > > +	mr->umem = NULL;
> > > +	kfree(in);
> > > +
> > > +	return mr;
> > > +
> > > +err_priv_descs:
> > > +	mlx5_free_priv_descs(mr);
> > > +err_free_in:
> > > +	kfree(in);
> > > +err_free:
> > > +	kfree(mr);
> > > +	return ERR_PTR(err);
> > > +}
> > > +
> > > +static struct ib_mr *__mlx5_ib_alloc_mr(struct ib_pd *pd,
> > > +					enum ib_mr_type mr_type, u32 max_num_sg,
> > > +					u32 max_num_meta_sg)
> > > +{
> > > +	struct mlx5_ib_dev *dev = to_mdev(pd->device);
> > > +	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
> > > +	int ndescs = ALIGN(max_num_sg, 4);
> > > +	struct mlx5_ib_mr *mr;
> > > +	void *mkc;
> > > +	u32 *in;
> > > +	int err;
> > > +
> > > +	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
> > > +	if (!mr)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	in = kzalloc(inlen, GFP_KERNEL);
> > > +	if (!in) {
> > > +		err = -ENOMEM;
> > > +		goto err_free;
> > > +	}
> > > +
> > > +	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
> > > +	MLX5_SET(mkc, mkc, free, 1);
> > > +	MLX5_SET(mkc, mkc, qpn, 0xffffff);
> > > +	MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
> > > +
> > >   	if (mr_type == IB_MR_TYPE_MEM_REG) {
> > >   		mr->access_mode = MLX5_MKC_ACCESS_MODE_MTT;
> > > +		MLX5_SET(mkc, mkc, translations_octword_size, ndescs);
> > >   		MLX5_SET(mkc, mkc, log_page_size, PAGE_SHIFT);
> > >   		err = mlx5_alloc_priv_descs(pd->device, mr,
> > >   					    ndescs, sizeof(struct mlx5_mtt));
> > > @@ -1682,6 +1752,7 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
> > >   		mr->max_descs = ndescs;
> > >   	} else if (mr_type == IB_MR_TYPE_SG_GAPS) {
> > >   		mr->access_mode = MLX5_MKC_ACCESS_MODE_KLMS;
> > > +		MLX5_SET(mkc, mkc, translations_octword_size, ndescs);
> > >   		err = mlx5_alloc_priv_descs(pd->device, mr,
> > >   					    ndescs, sizeof(struct mlx5_klm));
> > > @@ -1689,11 +1760,13 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
> > >   			goto err_free_in;
> > >   		mr->desc_size = sizeof(struct mlx5_klm);
> > >   		mr->max_descs = ndescs;
> > > -	} else if (mr_type == IB_MR_TYPE_SIGNATURE) {
> > > +	} else if (mr_type == IB_MR_TYPE_SIGNATURE ||
> > > +		   mr_type == IB_MR_TYPE_INTEGRITY) {
> > >   		u32 psv_index[2];
> > >   		MLX5_SET(mkc, mkc, bsf_en, 1);
> > >   		MLX5_SET(mkc, mkc, bsf_octword_size, MLX5_MKEY_BSF_OCTO_SIZE);
> > > +		MLX5_SET(mkc, mkc, translations_octword_size, 4);
> > >   		mr->sig = kzalloc(sizeof(*mr->sig), GFP_KERNEL);
> > >   		if (!mr->sig) {
> > >   			err = -ENOMEM;
> > > @@ -1714,6 +1787,14 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
> > >   		mr->sig->sig_err_exists = false;
> > >   		/* Next UMR, Arm SIGERR */
> > >   		++mr->sig->sigerr_count;
> > > +		if (mr_type == IB_MR_TYPE_INTEGRITY) {
> > > +			mr->pi_mr = mlx5_ib_alloc_pi_mr(pd, max_num_sg,
> > > +							max_num_meta_sg);
> > > +			if (IS_ERR(mr->pi_mr)) {
> > > +				err = PTR_ERR(mr->pi_mr);
> > > +				goto err_destroy_psv;
> > > +			}
> > > +		}
> > >   	} else {
> > >   		mlx5_ib_warn(dev, "Invalid mr type %d\n", mr_type);
> > >   		err = -EINVAL;
> > > @@ -1727,7 +1808,7 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
> > >   	mr->ibmr.device = pd->device;
> > >   	err = mlx5_core_create_mkey(dev->mdev, &mr->mmkey, in, inlen);
> > >   	if (err)
> > > -		goto err_destroy_psv;
> > > +		goto err_free_pi_mr;
> > >   	mr->mmkey.type = MLX5_MKEY_MR;
> > >   	mr->ibmr.lkey = mr->mmkey.key;
> > > @@ -1737,6 +1818,11 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
> > >   	return &mr->ibmr;
> > > +err_free_pi_mr:
> > > +	if (mr->pi_mr) {
> > > +		dereg_mr(to_mdev(mr->pi_mr->ibmr.device), mr->pi_mr);
> > > +		mr->pi_mr = NULL;
> > > +	}
> > >   err_destroy_psv:
> > >   	if (mr->sig) {
> > >   		if (mlx5_core_destroy_psv(dev->mdev,
> > > @@ -1758,6 +1844,19 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
> > >   	return ERR_PTR(err);
> > >   }
> > > +struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
> > > +			       u32 max_num_sg, struct ib_udata *udata)
> > > +{
> > > +	return __mlx5_ib_alloc_mr(pd, mr_type, max_num_sg, 0);
> > > +}
> > > +
> > > +struct ib_mr *mlx5_ib_alloc_mr_integrity(struct ib_pd *pd,
> > > +					 u32 max_num_sg, u32 max_num_meta_sg)
> > > +{
> > > +	return __mlx5_ib_alloc_mr(pd, IB_MR_TYPE_INTEGRITY, max_num_sg,
> > > +				  max_num_meta_sg);
> > > +}
> > > +
> > >   struct ib_mw *mlx5_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
> > >   			       struct ib_udata *udata)
> > >   {
> > > @@ -1890,13 +1989,16 @@ static int
> > >   mlx5_ib_sg_to_klms(struct mlx5_ib_mr *mr,
> > >   		   struct scatterlist *sgl,
> > >   		   unsigned short sg_nents,
> > > -		   unsigned int *sg_offset_p)
> > > +		   unsigned int *sg_offset_p,
> > > +		   struct scatterlist *meta_sgl,
> > > +		   unsigned short meta_sg_nents,
> > > +		   unsigned int *meta_sg_offset_p)
> > >   {
> > >   	struct scatterlist *sg = sgl;
> > >   	struct mlx5_klm *klms = mr->descs;
> > >   	unsigned int sg_offset = sg_offset_p ? *sg_offset_p : 0;
> > >   	u32 lkey = mr->ibmr.pd->local_dma_lkey;
> > > -	int i;
> > > +	int i, j = 0;
> > >   	mr->ibmr.iova = sg_dma_address(sg) + sg_offset;
> > >   	mr->ibmr.length = 0;
> > > @@ -1911,12 +2013,36 @@ mlx5_ib_sg_to_klms(struct mlx5_ib_mr *mr,
> > >   		sg_offset = 0;
> > >   	}
> > > -	mr->ndescs = i;
> > >   	if (sg_offset_p)
> > >   		*sg_offset_p = sg_offset;
> > > -	return i;
> > > +	mr->ndescs = i;
> > > +	mr->data_length = mr->ibmr.length;
> > > +
> > > +	if (meta_sg_nents) {
> > > +		sg = meta_sgl;
> > > +		sg_offset = meta_sg_offset_p ? *meta_sg_offset_p : 0;
> > > +		for_each_sg(meta_sgl, sg, meta_sg_nents, j) {
> > > +			if (unlikely(i + j >= mr->max_descs))
> > > +				break;
> > > +			klms[i + j].va = cpu_to_be64(sg_dma_address(sg) +
> > > +						     sg_offset);
> > > +			klms[i + j].bcount = cpu_to_be32(sg_dma_len(sg) -
> > > +							 sg_offset);
> > > +			klms[i + j].key = cpu_to_be32(lkey);
> > > +			mr->ibmr.length += sg_dma_len(sg) - sg_offset;
> > > +
> > > +			sg_offset = 0;
> > > +		}
> > > +		if (meta_sg_offset_p)
> > > +			*meta_sg_offset_p = sg_offset;
> > > +
> > > +		mr->meta_ndescs = j;
> > > +		mr->meta_length = mr->ibmr.length - mr->data_length;
> > > +	}
> > > +
> > > +	return i + j;
> > >   }
> > >   static int mlx5_set_page(struct ib_mr *ibmr, u64 addr)
> > > @@ -1933,6 +2059,41 @@ static int mlx5_set_page(struct ib_mr *ibmr, u64 addr)
> > >   	return 0;
> > >   }
> > > +int mlx5_ib_map_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist *data_sg,
> > > +			 int data_sg_nents, unsigned int *data_sg_offset,
> > > +			 struct scatterlist *meta_sg, int meta_sg_nents,
> > > +			 unsigned int *meta_sg_offset)
> > > +{
> > > +	struct mlx5_ib_mr *mr = to_mmr(ibmr);
> > > +	struct mlx5_ib_mr *pi_mr = mr->pi_mr;
> > > +	int n;
> > > +
> > > +	WARN_ON(ibmr->type != IB_MR_TYPE_INTEGRITY);
> > > +
> > > +	pi_mr->ndescs = 0;
> > > +	pi_mr->meta_ndescs = 0;
> > > +	pi_mr->meta_length = 0;
> > > +
> > > +	ib_dma_sync_single_for_cpu(ibmr->device, pi_mr->desc_map,
> > > +				   pi_mr->desc_size * pi_mr->max_descs,
> > > +				   DMA_TO_DEVICE);
> > > +
> > > +	n = mlx5_ib_sg_to_klms(pi_mr, data_sg, data_sg_nents, data_sg_offset,
> > > +			       meta_sg, meta_sg_nents, meta_sg_offset);
> > > +
> > > +	/* This is zero-based memory region */
> > > +	pi_mr->ibmr.iova = 0;
> > Are you aware that Yuval enabled zero based mr from rdma-core with the
> > follow patch?
> > 
> > https://marc.info/?l=linux-rdma&m=155919637918880&w=2
> 
> Well, AFAIU, his API uses user space reg-mr that mapped to some
> device->ops.reg_user_mr.
> 
> This series is kernel only. In user-land there is no MR mappings and all the
> MTTs are set during reg-mr.
> 
> In kernel we just allocate the mkey tables and update the addresses in
> runtime using UMR operation.
> 
> what is your concern here ?
> 
> 

Reading this comment from prior patch in this series gave the impression
that you deal with user MR: "Also introduce new mr types IB_MR_TYPE_USER" .

If we need (user) zero based MR, Yuval patch (rdma-core) can help.

Just wanted to know if you are aware to this change.

