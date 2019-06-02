Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F3332390
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jun 2019 16:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfFBOWe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 2 Jun 2019 10:22:34 -0400
Received: from mail-eopbgr00086.outbound.protection.outlook.com ([40.107.0.86]:37171
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbfFBOWd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 2 Jun 2019 10:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yVTZPCy9A/OBLBC79WjyjTKzMJOejPgjXFf/WzRHXA=;
 b=Ndy5gUQpcAEYVSpKDtP8063U6EzIauk5hYe98eY+EVEzy/Ccw+kF7yqHg0l/cNsDMwN20IRD6cZYSEijiUZteCSkwty5G0znXDXpbkRyz8N3dqyQLie6LElPwCQp2aYM4atcbKUXeqPivmMrNnVUNbdeKuLVne2CF7dviLQpdfs=
Received: from DB6PR0501CA0027.eurprd05.prod.outlook.com (2603:10a6:4:67::13)
 by DB3PR0502MB4058.eurprd05.prod.outlook.com (2603:10a6:8:9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.22; Sun, 2 Jun
 2019 14:22:26 +0000
Received: from DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::208) by DB6PR0501CA0027.outlook.office365.com
 (2603:10a6:4:67::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1943.16 via Frontend
 Transport; Sun, 2 Jun 2019 14:22:26 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 DB5EUR03FT054.mail.protection.outlook.com (10.152.20.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1943.19 via Frontend Transport; Sun, 2 Jun 2019 14:22:26 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 2 Jun 2019 17:22:23
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 2 Jun 2019 17:22:22 +0300
Received: from [10.223.3.162] (10.223.3.162) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Sun, 2 Jun 2019 17:22:18
 +0300
Subject: Re: [PATCH 06/20] RDMA/mlx5: Implement mlx5_ib_map_mr_sg_pi and
 mlx5_ib_alloc_mr_integrity
To:     Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
CC:     <leonro@mellanox.com>, <linux-rdma@vger.kernel.org>,
        <jgg@mellanox.com>, <dledford@redhat.com>, <sagi@grimberg.me>,
        <hch@lst.de>, <bvanassche@acm.org>, <israelr@mellanox.com>,
        <idanb@mellanox.com>, <oren@mellanox.com>,
        <vladimirk@mellanox.com>, <shlomin@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-7-git-send-email-maxg@mellanox.com>
 <20190602091335.GA18026@srabinov-laptop>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <4daaef16-eb1d-e55b-9923-39345cf34a5b@mellanox.com>
Date:   Sun, 2 Jun 2019 17:22:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190602091335.GA18026@srabinov-laptop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.3.162]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(2980300002)(199004)(189003)(5660300002)(6246003)(305945005)(107886003)(86362001)(336012)(64126003)(36756003)(31696002)(2906002)(966005)(126002)(5024004)(11346002)(14444005)(70206006)(26005)(8676002)(23676004)(50466002)(77096007)(446003)(186003)(229853002)(30864003)(486006)(2486003)(65826007)(16526019)(76176011)(53546011)(65806001)(316002)(6306002)(6916009)(65956001)(4326008)(67846002)(478600001)(3846002)(6116002)(16576012)(8936002)(70586007)(7736002)(230700001)(81166006)(47776003)(58126008)(81156014)(356004)(54906003)(2616005)(31686004)(106002)(476003)(3940600001)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0502MB4058;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89b0c801-5ff7-4566-2409-08d6e765bceb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:DB3PR0502MB4058;
X-MS-TrafficTypeDiagnostic: DB3PR0502MB4058:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DB3PR0502MB40589E62B85C3652235EE3F2B61B0@DB3PR0502MB4058.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 005671E15D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: evwaoUOnUPc9e9Ia6DF7rHFolSaIDMisOHBhEau68hVt9t4GKH+xpuPMprNbdxTMpkT9y41gUJgn3Z5tfh5peHA2tTq+sIFcQobOt4uBRfAsfAZf66fp5HlnssWbvrlJ8xTTVsayos04FFufmfojZvDCdkKa3uKaVft5GrqLmvCIxPva0SHydbOLYINmxo6+GcrHvPWhRjqu+ImBgpVcA/Nw2I3ksz/uJ2gSUxSMrvGUUiFOcE+4qqYHADR5HCwQY5bhQRJJpgUrQaCh/eihk4m1+D/fmdzhc0lygWfSaILidtkxCsbGn3qOFmFzijYNoZZwPjimydIyt0Fj00VNm7wif5Pjs0qKlcTGQfdKz35iEgLLlzV2tgdLvdtcpTiq7DFdAXhKlOG1udJqvl4ws4VSfFd/U4BKxUm3MwoyhXo=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2019 14:22:26.0728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b0c801-5ff7-4566-2409-08d6e765bceb
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB4058
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/2/2019 12:13 PM, Shamir Rabinovitch wrote:
> On Thu, May 30, 2019 at 04:25:17PM +0300, Max Gurtovoy wrote:
>> mlx5_ib_map_mr_sg_pi() will map the PI and data dma mapped SG lists to the
>> mlx5 memory region prior to the registration operation. In the new
>> API, the mlx5 driver will allocate an internal memory region for the
>> UMR operation to register both PI and data SG lists. The internal MR
>> will use KLM mode in order to map 2 (possibly non-contiguous/non-align)
>> SG lists using 1 memory key. In the new API, each ULP will use 1 memory
>> region for the signature operation (instead of 3 in the old API). This
>> memory region will have a key that will be exposed to remote server to
>> perform RDMA operation. The internal memory key that will map the SG lists
>> will stay private.
>>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
>> ---
>>   drivers/infiniband/hw/mlx5/main.c    |   2 +
>>   drivers/infiniband/hw/mlx5/mlx5_ib.h |  11 +++
>>   drivers/infiniband/hw/mlx5/mr.c      | 184 ++++++++++++++++++++++++++++++++---
>>   3 files changed, 186 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
>> index abac70ad5c7c..b6588cdef1cf 100644
>> --- a/drivers/infiniband/hw/mlx5/main.c
>> +++ b/drivers/infiniband/hw/mlx5/main.c
>> @@ -6126,6 +6126,7 @@ static void mlx5_ib_stage_flow_db_cleanup(struct mlx5_ib_dev *dev)
>>   static const struct ib_device_ops mlx5_ib_dev_ops = {
>>   	.add_gid = mlx5_ib_add_gid,
>>   	.alloc_mr = mlx5_ib_alloc_mr,
>> +	.alloc_mr_integrity = mlx5_ib_alloc_mr_integrity,
>>   	.alloc_pd = mlx5_ib_alloc_pd,
>>   	.alloc_ucontext = mlx5_ib_alloc_ucontext,
>>   	.attach_mcast = mlx5_ib_mcg_attach,
>> @@ -6155,6 +6156,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
>>   	.get_dma_mr = mlx5_ib_get_dma_mr,
>>   	.get_link_layer = mlx5_ib_port_link_layer,
>>   	.map_mr_sg = mlx5_ib_map_mr_sg,
>> +	.map_mr_sg_pi = mlx5_ib_map_mr_sg_pi,
>>   	.mmap = mlx5_ib_mmap,
>>   	.modify_cq = mlx5_ib_modify_cq,
>>   	.modify_device = mlx5_ib_modify_device,
>> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
>> index 40eb8be482e4..07bac37c3450 100644
>> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
>> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
>> @@ -587,6 +587,9 @@ struct mlx5_ib_mr {
>>   	void			*descs;
>>   	dma_addr_t		desc_map;
>>   	int			ndescs;
>> +	int			data_length;
>> +	int			meta_ndescs;
>> +	int			meta_length;
>>   	int			max_descs;
>>   	int			desc_size;
>>   	int			access_mode;
>> @@ -605,6 +608,7 @@ struct mlx5_ib_mr {
>>   	int			access_flags; /* Needed for rereg MR */
>>   
>>   	struct mlx5_ib_mr      *parent;
>> +	struct mlx5_ib_mr      *pi_mr; /* Needed for IB_MR_TYPE_INTEGRITY */
>>   	atomic_t		num_leaf_free;
>>   	wait_queue_head_t       q_leaf_free;
>>   	struct mlx5_async_work  cb_work;
>> @@ -1148,8 +1152,15 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
>>   int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
>>   struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
>>   			       u32 max_num_sg, struct ib_udata *udata);
>> +struct ib_mr *mlx5_ib_alloc_mr_integrity(struct ib_pd *pd,
>> +					 u32 max_num_sg,
>> +					 u32 max_num_meta_sg);
>>   int mlx5_ib_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
>>   		      unsigned int *sg_offset);
>> +int mlx5_ib_map_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist *data_sg,
>> +			 int data_sg_nents, unsigned int *data_sg_offset,
>> +			 struct scatterlist *meta_sg, int meta_sg_nents,
>> +			 unsigned int *meta_sg_offset);
>>   int mlx5_ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
>>   			const struct ib_wc *in_wc, const struct ib_grh *in_grh,
>>   			const struct ib_mad_hdr *in, size_t in_mad_size,
>> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
>> index 5f09699fab98..6820d80c6a7f 100644
>> --- a/drivers/infiniband/hw/mlx5/mr.c
>> +++ b/drivers/infiniband/hw/mlx5/mr.c
>> @@ -1639,16 +1639,22 @@ static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
>>   
>>   int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>>   {
>> -	dereg_mr(to_mdev(ibmr->device), to_mmr(ibmr));
>> +	struct mlx5_ib_mr *mmr = to_mmr(ibmr);
>> +
>> +	if (ibmr->type == IB_MR_TYPE_INTEGRITY)
>> +		dereg_mr(to_mdev(mmr->pi_mr->ibmr.device), mmr->pi_mr);
>> +
>> +	dereg_mr(to_mdev(ibmr->device), mmr);
>> +
>>   	return 0;
>>   }
>>   
>> -struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
>> -			       u32 max_num_sg, struct ib_udata *udata)
>> +static struct mlx5_ib_mr *mlx5_ib_alloc_pi_mr(struct ib_pd *pd,
>> +				u32 max_num_sg, u32 max_num_meta_sg)
>>   {
>>   	struct mlx5_ib_dev *dev = to_mdev(pd->device);
>>   	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
>> -	int ndescs = ALIGN(max_num_sg, 4);
>> +	int ndescs = ALIGN(max_num_sg + max_num_meta_sg, 4);
>>   	struct mlx5_ib_mr *mr;
>>   	void *mkc;
>>   	u32 *in;
>> @@ -1670,8 +1676,72 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
>>   	MLX5_SET(mkc, mkc, qpn, 0xffffff);
>>   	MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
>>   
>> +	mr->access_mode = MLX5_MKC_ACCESS_MODE_KLMS;
>> +
>> +	err = mlx5_alloc_priv_descs(pd->device, mr,
>> +				    ndescs, sizeof(struct mlx5_klm));
>> +	if (err)
>> +		goto err_free_in;
>> +	mr->desc_size = sizeof(struct mlx5_klm);
>> +	mr->max_descs = ndescs;
>> +
>> +	MLX5_SET(mkc, mkc, access_mode_1_0, mr->access_mode & 0x3);
>> +	MLX5_SET(mkc, mkc, access_mode_4_2, (mr->access_mode >> 2) & 0x7);
>> +	MLX5_SET(mkc, mkc, umr_en, 1);
>> +
>> +	mr->ibmr.pd = pd;
>> +	mr->ibmr.device = pd->device;
>> +	err = mlx5_core_create_mkey(dev->mdev, &mr->mmkey, in, inlen);
>> +	if (err)
>> +		goto err_priv_descs;
>> +
>> +	mr->mmkey.type = MLX5_MKEY_MR;
>> +	mr->ibmr.lkey = mr->mmkey.key;
>> +	mr->ibmr.rkey = mr->mmkey.key;
>> +	mr->umem = NULL;
>> +	kfree(in);
>> +
>> +	return mr;
>> +
>> +err_priv_descs:
>> +	mlx5_free_priv_descs(mr);
>> +err_free_in:
>> +	kfree(in);
>> +err_free:
>> +	kfree(mr);
>> +	return ERR_PTR(err);
>> +}
>> +
>> +static struct ib_mr *__mlx5_ib_alloc_mr(struct ib_pd *pd,
>> +					enum ib_mr_type mr_type, u32 max_num_sg,
>> +					u32 max_num_meta_sg)
>> +{
>> +	struct mlx5_ib_dev *dev = to_mdev(pd->device);
>> +	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
>> +	int ndescs = ALIGN(max_num_sg, 4);
>> +	struct mlx5_ib_mr *mr;
>> +	void *mkc;
>> +	u32 *in;
>> +	int err;
>> +
>> +	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
>> +	if (!mr)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	in = kzalloc(inlen, GFP_KERNEL);
>> +	if (!in) {
>> +		err = -ENOMEM;
>> +		goto err_free;
>> +	}
>> +
>> +	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
>> +	MLX5_SET(mkc, mkc, free, 1);
>> +	MLX5_SET(mkc, mkc, qpn, 0xffffff);
>> +	MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
>> +
>>   	if (mr_type == IB_MR_TYPE_MEM_REG) {
>>   		mr->access_mode = MLX5_MKC_ACCESS_MODE_MTT;
>> +		MLX5_SET(mkc, mkc, translations_octword_size, ndescs);
>>   		MLX5_SET(mkc, mkc, log_page_size, PAGE_SHIFT);
>>   		err = mlx5_alloc_priv_descs(pd->device, mr,
>>   					    ndescs, sizeof(struct mlx5_mtt));
>> @@ -1682,6 +1752,7 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
>>   		mr->max_descs = ndescs;
>>   	} else if (mr_type == IB_MR_TYPE_SG_GAPS) {
>>   		mr->access_mode = MLX5_MKC_ACCESS_MODE_KLMS;
>> +		MLX5_SET(mkc, mkc, translations_octword_size, ndescs);
>>   
>>   		err = mlx5_alloc_priv_descs(pd->device, mr,
>>   					    ndescs, sizeof(struct mlx5_klm));
>> @@ -1689,11 +1760,13 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
>>   			goto err_free_in;
>>   		mr->desc_size = sizeof(struct mlx5_klm);
>>   		mr->max_descs = ndescs;
>> -	} else if (mr_type == IB_MR_TYPE_SIGNATURE) {
>> +	} else if (mr_type == IB_MR_TYPE_SIGNATURE ||
>> +		   mr_type == IB_MR_TYPE_INTEGRITY) {
>>   		u32 psv_index[2];
>>   
>>   		MLX5_SET(mkc, mkc, bsf_en, 1);
>>   		MLX5_SET(mkc, mkc, bsf_octword_size, MLX5_MKEY_BSF_OCTO_SIZE);
>> +		MLX5_SET(mkc, mkc, translations_octword_size, 4);
>>   		mr->sig = kzalloc(sizeof(*mr->sig), GFP_KERNEL);
>>   		if (!mr->sig) {
>>   			err = -ENOMEM;
>> @@ -1714,6 +1787,14 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
>>   		mr->sig->sig_err_exists = false;
>>   		/* Next UMR, Arm SIGERR */
>>   		++mr->sig->sigerr_count;
>> +		if (mr_type == IB_MR_TYPE_INTEGRITY) {
>> +			mr->pi_mr = mlx5_ib_alloc_pi_mr(pd, max_num_sg,
>> +							max_num_meta_sg);
>> +			if (IS_ERR(mr->pi_mr)) {
>> +				err = PTR_ERR(mr->pi_mr);
>> +				goto err_destroy_psv;
>> +			}
>> +		}
>>   	} else {
>>   		mlx5_ib_warn(dev, "Invalid mr type %d\n", mr_type);
>>   		err = -EINVAL;
>> @@ -1727,7 +1808,7 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
>>   	mr->ibmr.device = pd->device;
>>   	err = mlx5_core_create_mkey(dev->mdev, &mr->mmkey, in, inlen);
>>   	if (err)
>> -		goto err_destroy_psv;
>> +		goto err_free_pi_mr;
>>   
>>   	mr->mmkey.type = MLX5_MKEY_MR;
>>   	mr->ibmr.lkey = mr->mmkey.key;
>> @@ -1737,6 +1818,11 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
>>   
>>   	return &mr->ibmr;
>>   
>> +err_free_pi_mr:
>> +	if (mr->pi_mr) {
>> +		dereg_mr(to_mdev(mr->pi_mr->ibmr.device), mr->pi_mr);
>> +		mr->pi_mr = NULL;
>> +	}
>>   err_destroy_psv:
>>   	if (mr->sig) {
>>   		if (mlx5_core_destroy_psv(dev->mdev,
>> @@ -1758,6 +1844,19 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
>>   	return ERR_PTR(err);
>>   }
>>   
>> +struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
>> +			       u32 max_num_sg, struct ib_udata *udata)
>> +{
>> +	return __mlx5_ib_alloc_mr(pd, mr_type, max_num_sg, 0);
>> +}
>> +
>> +struct ib_mr *mlx5_ib_alloc_mr_integrity(struct ib_pd *pd,
>> +					 u32 max_num_sg, u32 max_num_meta_sg)
>> +{
>> +	return __mlx5_ib_alloc_mr(pd, IB_MR_TYPE_INTEGRITY, max_num_sg,
>> +				  max_num_meta_sg);
>> +}
>> +
>>   struct ib_mw *mlx5_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
>>   			       struct ib_udata *udata)
>>   {
>> @@ -1890,13 +1989,16 @@ static int
>>   mlx5_ib_sg_to_klms(struct mlx5_ib_mr *mr,
>>   		   struct scatterlist *sgl,
>>   		   unsigned short sg_nents,
>> -		   unsigned int *sg_offset_p)
>> +		   unsigned int *sg_offset_p,
>> +		   struct scatterlist *meta_sgl,
>> +		   unsigned short meta_sg_nents,
>> +		   unsigned int *meta_sg_offset_p)
>>   {
>>   	struct scatterlist *sg = sgl;
>>   	struct mlx5_klm *klms = mr->descs;
>>   	unsigned int sg_offset = sg_offset_p ? *sg_offset_p : 0;
>>   	u32 lkey = mr->ibmr.pd->local_dma_lkey;
>> -	int i;
>> +	int i, j = 0;
>>   
>>   	mr->ibmr.iova = sg_dma_address(sg) + sg_offset;
>>   	mr->ibmr.length = 0;
>> @@ -1911,12 +2013,36 @@ mlx5_ib_sg_to_klms(struct mlx5_ib_mr *mr,
>>   
>>   		sg_offset = 0;
>>   	}
>> -	mr->ndescs = i;
>>   
>>   	if (sg_offset_p)
>>   		*sg_offset_p = sg_offset;
>>   
>> -	return i;
>> +	mr->ndescs = i;
>> +	mr->data_length = mr->ibmr.length;
>> +
>> +	if (meta_sg_nents) {
>> +		sg = meta_sgl;
>> +		sg_offset = meta_sg_offset_p ? *meta_sg_offset_p : 0;
>> +		for_each_sg(meta_sgl, sg, meta_sg_nents, j) {
>> +			if (unlikely(i + j >= mr->max_descs))
>> +				break;
>> +			klms[i + j].va = cpu_to_be64(sg_dma_address(sg) +
>> +						     sg_offset);
>> +			klms[i + j].bcount = cpu_to_be32(sg_dma_len(sg) -
>> +							 sg_offset);
>> +			klms[i + j].key = cpu_to_be32(lkey);
>> +			mr->ibmr.length += sg_dma_len(sg) - sg_offset;
>> +
>> +			sg_offset = 0;
>> +		}
>> +		if (meta_sg_offset_p)
>> +			*meta_sg_offset_p = sg_offset;
>> +
>> +		mr->meta_ndescs = j;
>> +		mr->meta_length = mr->ibmr.length - mr->data_length;
>> +	}
>> +
>> +	return i + j;
>>   }
>>   
>>   static int mlx5_set_page(struct ib_mr *ibmr, u64 addr)
>> @@ -1933,6 +2059,41 @@ static int mlx5_set_page(struct ib_mr *ibmr, u64 addr)
>>   	return 0;
>>   }
>>   
>> +int mlx5_ib_map_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist *data_sg,
>> +			 int data_sg_nents, unsigned int *data_sg_offset,
>> +			 struct scatterlist *meta_sg, int meta_sg_nents,
>> +			 unsigned int *meta_sg_offset)
>> +{
>> +	struct mlx5_ib_mr *mr = to_mmr(ibmr);
>> +	struct mlx5_ib_mr *pi_mr = mr->pi_mr;
>> +	int n;
>> +
>> +	WARN_ON(ibmr->type != IB_MR_TYPE_INTEGRITY);
>> +
>> +	pi_mr->ndescs = 0;
>> +	pi_mr->meta_ndescs = 0;
>> +	pi_mr->meta_length = 0;
>> +
>> +	ib_dma_sync_single_for_cpu(ibmr->device, pi_mr->desc_map,
>> +				   pi_mr->desc_size * pi_mr->max_descs,
>> +				   DMA_TO_DEVICE);
>> +
>> +	n = mlx5_ib_sg_to_klms(pi_mr, data_sg, data_sg_nents, data_sg_offset,
>> +			       meta_sg, meta_sg_nents, meta_sg_offset);
>> +
>> +	/* This is zero-based memory region */
>> +	pi_mr->ibmr.iova = 0;
> Are you aware that Yuval enabled zero based mr from rdma-core with the
> follow patch?
>
> https://marc.info/?l=linux-rdma&m=155919637918880&w=2

Well, AFAIU, his API uses user space reg-mr that mapped to some 
device->ops.reg_user_mr.

This series is kernel only. In user-land there is no MR mappings and all 
the MTTs are set during reg-mr.

In kernel we just allocate the mkey tables and update the addresses in 
runtime using UMR operation.

what is your concern here ?


