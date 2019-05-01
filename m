Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 275D310B72
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 18:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfEAQjP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 12:39:15 -0400
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:33230
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726101AbfEAQjO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 May 2019 12:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF19STGBNOA0WMn0VU4UiIjJ05KHCGTlriVUMnzkouM=;
 b=ah3FC24cUzrz4NRDPBykb/462cqT7IbPrLBwpy6ijJWQT15BMidfbY/ifxOtwTP0tvtJkm09ai9eTRT6xPK1sn0YcmvZafp97BJURy6Wgg6m+r2x8fDk+misXkveg2kaPF2v3CuELwaIY3X5x1dicptdtD6X6nsdukG7cp6Gqlw=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3168.eurprd05.prod.outlook.com (10.170.237.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Wed, 1 May 2019 16:38:58 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1835.018; Wed, 1 May 2019
 16:38:58 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Sean Hefty <sean.hefty@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
Thread-Topic: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
Thread-Index: AQHVADxft6YhcNgq2U2bxKGl+U/wYQ==
Date:   Wed, 1 May 2019 16:38:58 +0000
Message-ID: <20190501163852.GA18049@mellanox.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-11-git-send-email-galpress@amazon.com>
In-Reply-To: <1556707704-11192-11-git-send-email-galpress@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR01CA0010.prod.exchangelabs.com (2603:10b6:208:10c::23)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [173.228.226.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a73ffd8a-849f-488b-a0b9-08d6ce5381d1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3168;
x-ms-traffictypediagnostic: VI1PR05MB3168:
x-microsoft-antispam-prvs: <VI1PR05MB3168D273A29C4749B4E72804CF3B0@VI1PR05MB3168.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 00246AB517
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(366004)(396003)(376002)(199004)(189003)(6116002)(3846002)(6512007)(6916009)(1076003)(99286004)(66066001)(52116002)(14444005)(64756008)(71190400001)(66476007)(66556008)(86362001)(256004)(71200400001)(73956011)(66446008)(229853002)(36756003)(6486002)(54906003)(30864003)(66946007)(6436002)(316002)(4326008)(6246003)(25786009)(8676002)(81156014)(81166006)(5660300002)(76176011)(386003)(6506007)(102836004)(53946003)(53936002)(2906002)(68736007)(11346002)(2616005)(476003)(446003)(33656002)(486006)(186003)(26005)(8936002)(7416002)(478600001)(7736002)(14454004)(305945005)(559001)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3168;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZaYEZ37cee27WCRpxDtAhR8PsusjieMwmHN67zGxsCaQac6CDXjbbCcBl2McB1RIKUIKmKCObb1ID8ty0QtZZEnOyJsmjhcZook6Jw/NVCCoKcpy8hCTYw2bfHyzjPogmceMk7Ak6lAGnikfkbi9DKVbT9epTml2jmohafUxIsuyG81UnIbgTV0/7WJedCujBVV9Sc7zuWWYteEHptuq7LAZfl+a0c/RGhzBaVkxmLb/aBHI1bPYlisDVVrCImvvGCY8KNolroQq41I4jFIXzfDpDKv1KnLINLiPol/jNUTp+ieYVtTt2I6/mT060MxWAaMoOTKPzqEr1SFx0ye6ojytpdB1dbsyKF8QiD0F5WhVRLj5zJlIlGFWDY87Art4EelkMxBqoJu3rvlVs1EKKpq8F0o9YJQRnfz9ff2qmzk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <63C3A964ED2D94429A82DE32119D726C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73ffd8a-849f-488b-a0b9-08d6ce5381d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2019 16:38:58.1714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3168
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 01, 2019 at 01:48:22PM +0300, Gal Pressman wrote:
> Add a file that implements the EFA verbs.
>=20
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> Reviewed-by: Steve Wise <swise@opengridcomputing.com>
>  drivers/infiniband/hw/efa/efa_verbs.c | 1873 +++++++++++++++++++++++++++=
++++++
>  1 file changed, 1873 insertions(+)
>  create mode 100644 drivers/infiniband/hw/efa/efa_verbs.c
>=20
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/h=
w/efa/efa_verbs.c
> new file mode 100644
> index 000000000000..15d306748565
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -0,0 +1,1873 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights re=
served.
> + */
> +
> +#include <linux/vmalloc.h>
> +
> +#include <rdma/ib_addr.h>
> +#include <rdma/ib_umem.h>
> +#include <rdma/ib_user_verbs.h>
> +#include <rdma/ib_verbs.h>
> +#include <rdma/uverbs_ioctl.h>
> +
> +#include "efa.h"
> +
> +#define EFA_MMAP_FLAG_SHIFT 56
> +
> +enum {
> +	EFA_MMAP_DMA_PAGE =3D 0,
> +	EFA_MMAP_IO_WC,
> +	EFA_MMAP_IO_NC,
> +};
> +
> +static void set_mmap_flag(u64 *mmap_key, u8 mmap_flag)
> +{
> +	*mmap_key |=3D (u64)mmap_flag << EFA_MMAP_FLAG_SHIFT;
> +}
> +
> +static u8 get_mmap_flag(u64 mmap_key)
> +{
> +	return mmap_key >> EFA_MMAP_FLAG_SHIFT;
> +}
> +
> +#define EFA_AENQ_ENABLED_GROUPS \
> +	(BIT(EFA_ADMIN_FATAL_ERROR) | BIT(EFA_ADMIN_WARNING) | \
> +	 BIT(EFA_ADMIN_NOTIFICATION) | BIT(EFA_ADMIN_KEEP_ALIVE))
> +
> +struct efa_mmap_entry {
> +	struct list_head list;
> +	void  *obj;
> +	u64 address;
> +	u64 length;
> +	u64 key;
> +};
> +
> +#define EFA_CHUNK_PAYLOAD_SHIFT       12
> +#define EFA_CHUNK_PAYLOAD_SIZE        BIT(EFA_CHUNK_PAYLOAD_SHIFT)
> +#define EFA_CHUNK_PAYLOAD_PTR_SIZE    8
> +
> +#define EFA_CHUNK_SHIFT               12
> +#define EFA_CHUNK_SIZE                BIT(EFA_CHUNK_SHIFT)
> +#define EFA_CHUNK_PTR_SIZE            sizeof(struct efa_com_ctrl_buff_in=
fo)
> +
> +#define EFA_PTRS_PER_CHUNK \
> +	((EFA_CHUNK_SIZE - EFA_CHUNK_PTR_SIZE) / EFA_CHUNK_PAYLOAD_PTR_SIZE)
> +
> +#define EFA_CHUNK_USED_SIZE \
> +	((EFA_PTRS_PER_CHUNK * EFA_CHUNK_PAYLOAD_PTR_SIZE) + EFA_CHUNK_PTR_SIZE=
)
> +
> +#define EFA_SUPPORTED_ACCESS_FLAGS IB_ACCESS_LOCAL_WRITE
> +
> +struct pbl_chunk {
> +	dma_addr_t dma_addr;
> +	u64 *buf;
> +	u32 length;
> +};
> +
> +struct pbl_chunk_list {
> +	struct pbl_chunk *chunks;
> +	unsigned int size;
> +};
> +
> +struct pbl_context {
> +	union {
> +		struct {
> +			dma_addr_t dma_addr;
> +		} continuous;
> +		struct {
> +			u32 pbl_buf_size_in_pages;
> +			struct scatterlist *sgl;
> +			int sg_dma_cnt;
> +			struct pbl_chunk_list chunk_list;
> +		} indirect;
> +	} phys;
> +	u64 *pbl_buf;
> +	u32 pbl_buf_size_in_bytes;
> +	u8 physically_continuous;
> +};
> +
> +static inline struct efa_dev *to_edev(struct ib_device *ibdev)
> +{
> +	return container_of(ibdev, struct efa_dev, ibdev);
> +}
> +
> +static inline struct efa_ucontext *to_eucontext(struct ib_ucontext *ibuc=
ontext)
> +{
> +	return container_of(ibucontext, struct efa_ucontext, ibucontext);
> +}
> +
> +static inline struct efa_pd *to_epd(struct ib_pd *ibpd)
> +{
> +	return container_of(ibpd, struct efa_pd, ibpd);
> +}
> +
> +static inline struct efa_mr *to_emr(struct ib_mr *ibmr)
> +{
> +	return container_of(ibmr, struct efa_mr, ibmr);
> +}
> +
> +static inline struct efa_qp *to_eqp(struct ib_qp *ibqp)
> +{
> +	return container_of(ibqp, struct efa_qp, ibqp);
> +}
> +
> +static inline struct efa_cq *to_ecq(struct ib_cq *ibcq)
> +{
> +	return container_of(ibcq, struct efa_cq, ibcq);
> +}
> +
> +static inline struct efa_ah *to_eah(struct ib_ah *ibah)
> +{
> +	return container_of(ibah, struct efa_ah, ibah);
> +}
> +
> +#define field_avail(x, fld, sz) (offsetof(typeof(x), fld) + \
> +				 sizeof(((typeof(x) *)0)->fld) <=3D (sz))
> +
> +#define is_reserved_cleared(reserved) \
> +	!memchr_inv(reserved, 0, sizeof(reserved))
> +
> +static void *efa_zalloc_mapped(struct efa_dev *dev, dma_addr_t *dma_addr=
,
> +			       size_t size, enum dma_data_direction dir)
> +{
> +	void *addr;
> +
> +	addr =3D alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
> +	if (!addr)
> +		return NULL;
> +
> +	*dma_addr =3D dma_map_single(&dev->pdev->dev, addr, size, dir);
> +	if (dma_mapping_error(&dev->pdev->dev, *dma_addr)) {
> +		ibdev_err(&dev->ibdev, "Failed to map DMA address\n");
> +		free_pages_exact(addr, size);
> +		return NULL;
> +	}
> +
> +	return addr;
> +}
> +
> +static void mmap_obj_entries_remove(struct efa_dev *dev,
> +				    struct efa_ucontext *ucontext,
> +				    void *obj,
> +				    bool free)
> +{
> +	struct efa_mmap_entry *entry;
> +	unsigned long mmap_page;
> +
> +	xa_for_each(&ucontext->mmap_xa, mmap_page, entry) {
> +		if (entry->obj !=3D obj)
> +			continue;
> +
> +		xa_erase(&ucontext->mmap_xa, mmap_page);
> +		ibdev_dbg(&dev->ibdev,
> +			  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
> +			  entry->obj, entry->key, entry->address,
> +			  entry->length);
> +		if (free)
> +			kfree(entry);
> +	}
> +}
> +
> +/*
> + * Since we don't track munmaps, we can't know when a user stopped using=
 his
> + * mmapped buffers.
> + * This should be called on dealloc_ucontext in order to drain the mmap =
entries
> + * and free the (unmapped) DMA buffers.
> + */
> +static void mmap_entries_remove_free(struct efa_dev *dev,
> +				     struct efa_ucontext *ucontext)
> +{
> +	struct efa_mmap_entry *entry;
> +	unsigned long mmap_page;
> +
> +	xa_for_each(&ucontext->mmap_xa, mmap_page, entry) {
> +		xa_erase(&ucontext->mmap_xa, mmap_page);
> +		ibdev_dbg(&dev->ibdev,
> +			  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
> +			  entry->obj, entry->key, entry->address, entry->length);
> +		if (get_mmap_flag(entry->key) =3D=3D EFA_MMAP_DMA_PAGE)
> +			/* DMA mapping is already gone, now free the pages */
> +			free_pages_exact(phys_to_virt(entry->address),
> +					 entry->length);
> +		kfree(entry);
> +	}
> +}
> +
> +static struct efa_mmap_entry *mmap_entry_get(struct efa_dev *dev,
> +					     struct efa_ucontext *ucontext,
> +					     u64 key,
> +					     u64 len)
> +{
> +	struct efa_mmap_entry *entry;
> +	u32 mmap_page;
> +
> +	mmap_page =3D lower_32_bits(key >> PAGE_SHIFT);
> +	entry =3D xa_load(&ucontext->mmap_xa, mmap_page);
> +	if (!entry || entry->key !=3D key || entry->length !=3D len)
> +		return NULL;
> +
> +	ibdev_dbg(&dev->ibdev,
> +		  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
> +		  entry->obj, key, entry->address,
> +		  entry->length);
> +
> +	return entry;
> +}
> +
> +static int mmap_entry_insert(struct efa_dev *dev,
> +			     struct efa_ucontext *ucontext,
> +			     struct efa_mmap_entry *entry,
> +			     u8 mmap_flag)
> +{
> +	u32 mmap_page;
> +	int err;
> +
> +	err =3D xa_alloc(&ucontext->mmap_xa, &mmap_page, entry, xa_limit_32b,
> +		       GFP_KERNEL);
> +	if (err) {
> +		ibdev_dbg(&dev->ibdev, "mmap xarray full %d\n", err);
> +		return err;
> +	}
> +
> +	entry->key =3D (u64)mmap_page << PAGE_SHIFT;
> +	set_mmap_flag(&entry->key, mmap_flag);
> +
> +	ibdev_dbg(&dev->ibdev,
> +		  "mmap: obj[0x%p] addr[%#llx], len[%#llx], key[%#llx] inserted\n",
> +		  entry->obj, entry->address, entry->length, entry->key);
> +
> +	return 0;
> +}
> +
> +int efa_query_device(struct ib_device *ibdev,
> +		     struct ib_device_attr *props,
> +		     struct ib_udata *udata)
> +{
> +	struct efa_com_get_device_attr_result *dev_attr;
> +	struct efa_ibv_ex_query_device_resp resp =3D {};
> +	struct efa_dev *dev =3D to_edev(ibdev);
> +	int err;
> +
> +	if (udata && udata->inlen &&
> +	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
> +		ibdev_dbg(ibdev,
> +			  "Incompatible ABI params, udata not cleared\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_attr =3D &dev->dev_attr;
> +
> +	memset(props, 0, sizeof(*props));
> +	props->max_mr_size =3D dev_attr->max_mr_pages * PAGE_SIZE;
> +	props->page_size_cap =3D dev_attr->page_size_cap;
> +	props->vendor_id =3D dev->pdev->vendor;
> +	props->vendor_part_id =3D dev->pdev->device;
> +	props->hw_ver =3D dev->pdev->subsystem_device;
> +	props->max_qp =3D dev_attr->max_qp;
> +	props->max_cq =3D dev_attr->max_cq;
> +	props->max_pd =3D dev_attr->max_pd;
> +	props->max_mr =3D dev_attr->max_mr;
> +	props->max_ah =3D dev_attr->max_ah;
> +	props->max_cqe =3D dev_attr->max_cq_depth;
> +	props->max_qp_wr =3D min_t(u32, dev_attr->max_sq_depth,
> +				 dev_attr->max_rq_depth);
> +	props->max_send_sge =3D dev_attr->max_sq_sge;
> +	props->max_recv_sge =3D dev_attr->max_rq_sge;
> +
> +	if (udata && udata->outlen) {
> +		resp.max_sq_sge =3D dev_attr->max_sq_sge;
> +		resp.max_rq_sge =3D dev_attr->max_rq_sge;
> +		resp.max_sq_wr =3D dev_attr->max_sq_depth;
> +		resp.max_rq_wr =3D dev_attr->max_rq_depth;
> +
> +		err =3D ib_copy_to_udata(udata, &resp,
> +				       min(sizeof(resp), udata->outlen));
> +		if (err) {
> +			ibdev_dbg(ibdev,
> +				  "Failed to copy udata for query_device\n");
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int efa_query_port(struct ib_device *ibdev, u8 port,
> +		   struct ib_port_attr *props)
> +{
> +	struct efa_dev *dev =3D to_edev(ibdev);
> +
> +	props->lmc =3D 1;
> +
> +	props->state =3D IB_PORT_ACTIVE;
> +	props->phys_state =3D 5;
> +	props->gid_tbl_len =3D 1;
> +	props->pkey_tbl_len =3D 1;
> +	props->active_speed =3D IB_SPEED_EDR;
> +	props->active_width =3D IB_WIDTH_4X;
> +	props->max_mtu =3D ib_mtu_int_to_enum(dev->mtu);
> +	props->active_mtu =3D ib_mtu_int_to_enum(dev->mtu);
> +	props->max_msg_sz =3D dev->mtu;
> +	props->max_vl_num =3D 1;
> +
> +	return 0;
> +}
> +
> +int efa_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
> +		 int qp_attr_mask,
> +		 struct ib_qp_init_attr *qp_init_attr)
> +{
> +	struct efa_dev *dev =3D to_edev(ibqp->device);
> +	struct efa_com_query_qp_params params =3D {};
> +	struct efa_com_query_qp_result result;
> +	struct efa_qp *qp =3D to_eqp(ibqp);
> +	int err;
> +
> +#define EFA_QUERY_QP_SUPP_MASK \
> +	(IB_QP_STATE | IB_QP_PKEY_INDEX | IB_QP_PORT | \
> +	 IB_QP_QKEY | IB_QP_SQ_PSN | IB_QP_CAP)
> +
> +	if (qp_attr_mask & ~EFA_QUERY_QP_SUPP_MASK) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "Unsupported qp_attr_mask[%#x] supported[%#x]\n",
> +			  qp_attr_mask, EFA_QUERY_QP_SUPP_MASK);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	memset(qp_attr, 0, sizeof(*qp_attr));
> +	memset(qp_init_attr, 0, sizeof(*qp_init_attr));
> +
> +	params.qp_handle =3D qp->qp_handle;
> +	err =3D efa_com_query_qp(&dev->edev, &params, &result);
> +	if (err)
> +		return err;
> +
> +	qp_attr->qp_state =3D result.qp_state;
> +	qp_attr->qkey =3D result.qkey;
> +	qp_attr->sq_psn =3D result.sq_psn;
> +	qp_attr->sq_draining =3D result.sq_draining;
> +	qp_attr->port_num =3D 1;
> +
> +	qp_attr->cap.max_send_wr =3D qp->max_send_wr;
> +	qp_attr->cap.max_recv_wr =3D qp->max_recv_wr;
> +	qp_attr->cap.max_send_sge =3D qp->max_send_sge;
> +	qp_attr->cap.max_recv_sge =3D qp->max_recv_sge;
> +	qp_attr->cap.max_inline_data =3D qp->max_inline_data;
> +
> +	qp_init_attr->qp_type =3D ibqp->qp_type;
> +	qp_init_attr->recv_cq =3D ibqp->recv_cq;
> +	qp_init_attr->send_cq =3D ibqp->send_cq;
> +	qp_init_attr->qp_context =3D ibqp->qp_context;
> +	qp_init_attr->cap =3D qp_attr->cap;
> +
> +	return 0;
> +}
> +
> +int efa_query_gid(struct ib_device *ibdev, u8 port, int index,
> +		  union ib_gid *gid)
> +{
> +	struct efa_dev *dev =3D to_edev(ibdev);
> +
> +	memcpy(gid->raw, dev->addr, sizeof(dev->addr));
> +
> +	return 0;
> +}
> +
> +int efa_query_pkey(struct ib_device *ibdev, u8 port, u16 index,
> +		   u16 *pkey)
> +{
> +	if (index > 0)
> +		return -EINVAL;
> +
> +	*pkey =3D 0xffff;
> +	return 0;
> +}
> +
> +static int efa_pd_dealloc(struct efa_dev *dev, u16 pdn)
> +{
> +	struct efa_com_dealloc_pd_params params =3D {
> +		.pdn =3D pdn,
> +	};
> +
> +	return efa_com_dealloc_pd(&dev->edev, &params);
> +}
> +
> +int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
> +{
> +	struct efa_dev *dev =3D to_edev(ibpd->device);
> +	struct efa_ibv_alloc_pd_resp resp =3D {};
> +	struct efa_com_alloc_pd_result result;
> +	struct efa_pd *pd =3D to_epd(ibpd);
> +	int err;
> +
> +	if (udata->inlen &&
> +	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "Incompatible ABI params, udata not cleared\n");
> +		err =3D -EINVAL;
> +		goto err_out;
> +	}
> +
> +	err =3D efa_com_alloc_pd(&dev->edev, &result);
> +	if (err)
> +		goto err_out;
> +
> +	pd->pdn =3D result.pdn;
> +	resp.pdn =3D result.pdn;
> +
> +	if (udata->outlen) {
> +		err =3D ib_copy_to_udata(udata, &resp,
> +				       min(sizeof(resp), udata->outlen));
> +		if (err) {
> +			ibdev_dbg(&dev->ibdev,
> +				  "Failed to copy udata for alloc_pd\n");
> +			goto err_dealloc_pd;
> +		}
> +	}
> +
> +	ibdev_dbg(&dev->ibdev, "Allocated pd[%d]\n", pd->pdn);
> +
> +	return 0;
> +
> +err_dealloc_pd:
> +	efa_pd_dealloc(dev, result.pdn);
> +err_out:
> +	atomic64_inc(&dev->stats.sw_stats.alloc_pd_err);
> +	return err;
> +}
> +
> +void efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
> +{
> +	struct efa_dev *dev =3D to_edev(ibpd->device);
> +	struct efa_pd *pd =3D to_epd(ibpd);
> +
> +	if (udata->inlen &&
> +	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
> +		ibdev_dbg(&dev->ibdev, "Incompatible ABI params\n");
> +		return;
> +	}
> +
> +	ibdev_dbg(&dev->ibdev, "Dealloc pd[%d]\n", pd->pdn);
> +	efa_pd_dealloc(dev, pd->pdn);
> +}
> +
> +static int efa_destroy_qp_handle(struct efa_dev *dev, u32 qp_handle)
> +{
> +	struct efa_com_destroy_qp_params params =3D { .qp_handle =3D qp_handle =
};
> +
> +	return efa_com_destroy_qp(&dev->edev, &params);
> +}
> +
> +int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
> +{
> +	struct efa_dev *dev =3D to_edev(ibqp->pd->device);
> +	struct efa_qp *qp =3D to_eqp(ibqp);
> +	int err;
> +
> +	if (udata->inlen &&
> +	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
> +		ibdev_dbg(&dev->ibdev, "Incompatible ABI params\n");
> +		return -EINVAL;
> +	}
> +
> +	ibdev_dbg(&dev->ibdev, "Destroy qp[%u]\n", ibqp->qp_num);
> +	err =3D efa_destroy_qp_handle(dev, qp->qp_handle);
> +	if (err)
> +		return err;
> +
> +	if (qp->rq_cpu_addr) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "qp->cpu_addr[0x%p] freed: size[%lu], dma[%pad]\n",
> +			  qp->rq_cpu_addr, qp->rq_size,
> +			  &qp->rq_dma_addr);
> +		dma_unmap_single(&dev->pdev->dev, qp->rq_dma_addr, qp->rq_size,
> +				 DMA_TO_DEVICE);
> +	}
> +
> +	kfree(qp);
> +	return 0;
> +}
> +
> +static int qp_mmap_entries_setup(struct efa_qp *qp,
> +				 struct efa_dev *dev,
> +				 struct efa_ucontext *ucontext,
> +				 struct efa_com_create_qp_params *params,
> +				 struct efa_ibv_create_qp_resp *resp)
> +{
> +	struct efa_mmap_entry *rq_db_entry =3D NULL;
> +	struct efa_mmap_entry *sq_db_entry =3D NULL;
> +	struct efa_mmap_entry *rq_entry =3D NULL;
> +	struct efa_mmap_entry *sq_entry =3D NULL;
> +	int err;
> +
> +	sq_db_entry =3D kzalloc(sizeof(*sq_db_entry), GFP_KERNEL);
> +	sq_entry =3D kzalloc(sizeof(*sq_entry), GFP_KERNEL);
> +	if (!sq_db_entry || !sq_entry)
> +		goto err_free_sq;
> +
> +	if (qp->rq_size) {
> +		rq_entry =3D kzalloc(sizeof(*rq_entry), GFP_KERNEL);
> +		rq_db_entry =3D kzalloc(sizeof(*rq_db_entry), GFP_KERNEL);
> +		if (!rq_entry || !rq_db_entry)
> +			goto err_free_rq;
> +
> +		rq_db_entry->obj =3D qp;
> +		rq_entry->obj =3D qp;
> +
> +		rq_entry->address =3D virt_to_phys(qp->rq_cpu_addr);
> +		rq_entry->length =3D qp->rq_size;
> +		err =3D mmap_entry_insert(dev, ucontext, rq_entry,
> +					EFA_MMAP_DMA_PAGE);
> +		if (err)
> +			goto err_free_rq;
> +		resp->rq_mmap_key =3D rq_entry->key;
> +		resp->rq_mmap_size =3D qp->rq_size;
> +
> +		rq_db_entry->address =3D dev->db_bar_addr +
> +				       resp->rq_db_offset;
> +		rq_db_entry->length =3D PAGE_SIZE;
> +		err =3D mmap_entry_insert(dev, ucontext, rq_db_entry,
> +					EFA_MMAP_IO_NC);
> +		if (err)
> +			goto err_remove_entries;
> +		resp->rq_db_mmap_key =3D rq_db_entry->key;
> +		resp->rq_db_offset &=3D ~PAGE_MASK;
> +	}
> +
> +	sq_db_entry->obj =3D qp;
> +	sq_entry->obj =3D qp;
> +
> +	sq_db_entry->address =3D dev->db_bar_addr + resp->sq_db_offset;
> +	resp->sq_db_offset &=3D ~PAGE_MASK;
> +	sq_db_entry->length =3D PAGE_SIZE;
> +	err =3D mmap_entry_insert(dev, ucontext, sq_db_entry,
> +				EFA_MMAP_IO_NC);
> +	if (err)
> +		goto err_remove_entries;
> +	resp->sq_db_mmap_key =3D sq_db_entry->key;
> +
> +	sq_entry->address =3D dev->mem_bar_addr + resp->llq_desc_offset;
> +	resp->llq_desc_offset &=3D ~PAGE_MASK;
> +	sq_entry->length =3D PAGE_ALIGN(params->sq_ring_size_in_bytes +
> +				      resp->llq_desc_offset);
> +	err =3D mmap_entry_insert(dev, ucontext, sq_entry, EFA_MMAP_IO_WC);
> +	if (err)
> +		goto err_remove_entries;
> +	resp->llq_desc_mmap_key =3D sq_entry->key;
> +
> +	return 0;
> +
> +err_remove_entries:
> +	mmap_obj_entries_remove(dev, ucontext, qp, false);
> +err_free_rq:
> +	kfree(rq_entry);
> +	kfree(rq_db_entry);
> +err_free_sq:
> +	kfree(sq_entry);
> +	kfree(sq_db_entry);
> +	return -ENOMEM;
> +}
> +
> +static int efa_qp_validate_cap(struct efa_dev *dev,
> +			       struct ib_qp_init_attr *init_attr)
> +{
> +	if (init_attr->cap.max_send_wr > dev->dev_attr.max_sq_depth) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "qp: requested send wr[%u] exceeds the max[%u]\n",
> +			  init_attr->cap.max_send_wr,
> +			  dev->dev_attr.max_sq_depth);
> +		return -EINVAL;
> +	}
> +	if (init_attr->cap.max_recv_wr > dev->dev_attr.max_rq_depth) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "qp: requested receive wr[%u] exceeds the max[%u]\n",
> +			  init_attr->cap.max_recv_wr,
> +			  dev->dev_attr.max_rq_depth);
> +		return -EINVAL;
> +	}
> +	if (init_attr->cap.max_send_sge > dev->dev_attr.max_sq_sge) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "qp: requested sge send[%u] exceeds the max[%u]\n",
> +			  init_attr->cap.max_send_sge, dev->dev_attr.max_sq_sge);
> +		return -EINVAL;
> +	}
> +	if (init_attr->cap.max_recv_sge > dev->dev_attr.max_rq_sge) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "qp: requested sge recv[%u] exceeds the max[%u]\n",
> +			  init_attr->cap.max_recv_sge, dev->dev_attr.max_rq_sge);
> +		return -EINVAL;
> +	}
> +	if (init_attr->cap.max_inline_data > dev->dev_attr.inline_buf_size) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "qp: requested inline data[%u] exceeds the max[%u]\n",
> +			  init_attr->cap.max_inline_data,
> +			  dev->dev_attr.inline_buf_size);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int efa_qp_validate_attr(struct efa_dev *dev,
> +				struct ib_qp_init_attr *init_attr)
> +{
> +	if (init_attr->qp_type !=3D IB_QPT_DRIVER &&
> +	    init_attr->qp_type !=3D IB_QPT_UD) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "Unsupported qp type %d\n", init_attr->qp_type);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (init_attr->srq) {
> +		ibdev_dbg(&dev->ibdev, "SRQ is not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (init_attr->create_flags) {
> +		ibdev_dbg(&dev->ibdev, "Unsupported create flags\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
> +			    struct ib_qp_init_attr *init_attr,
> +			    struct ib_udata *udata)
> +{
> +	struct efa_com_create_qp_params create_qp_params =3D {};
> +	struct efa_com_create_qp_result create_qp_resp;
> +	struct efa_dev *dev =3D to_edev(ibpd->device);
> +	struct efa_ibv_create_qp_resp resp =3D {};
> +	struct efa_ibv_create_qp cmd =3D {};
> +	struct efa_ucontext *ucontext;
> +	struct efa_qp *qp;
> +	int err;
> +
> +	ucontext =3D rdma_udata_to_drv_context(udata, struct efa_ucontext,
> +					     ibucontext);
> +
> +	err =3D efa_qp_validate_cap(dev, init_attr);
> +	if (err)
> +		goto err_out;
> +
> +	err =3D efa_qp_validate_attr(dev, init_attr);
> +	if (err)
> +		goto err_out;
> +
> +	if (!field_avail(cmd, driver_qp_type, udata->inlen)) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "Incompatible ABI params, no input udata\n");
> +		err =3D -EINVAL;
> +		goto err_out;
> +	}
> +
> +	if (udata->inlen > sizeof(cmd) &&
> +	    !ib_is_udata_cleared(udata, sizeof(cmd),
> +				 udata->inlen - sizeof(cmd))) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "Incompatible ABI params, unknown fields in udata\n");
> +		err =3D -EINVAL;
> +		goto err_out;
> +	}
> +
> +	err =3D ib_copy_from_udata(&cmd, udata,
> +				 min(sizeof(cmd), udata->inlen));
> +	if (err) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "Cannot copy udata for create_qp\n");
> +		goto err_out;
> +	}
> +
> +	if (cmd.comp_mask) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "Incompatible ABI params, unknown fields in udata\n");
> +		err =3D -EINVAL;
> +		goto err_out;
> +	}
> +
> +	qp =3D kzalloc(sizeof(*qp), GFP_KERNEL);
> +	if (!qp) {
> +		err =3D -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	create_qp_params.uarn =3D ucontext->uarn;
> +	create_qp_params.pd =3D to_epd(ibpd)->pdn;
> +
> +	if (init_attr->qp_type =3D=3D IB_QPT_UD) {
> +		create_qp_params.qp_type =3D EFA_ADMIN_QP_TYPE_UD;
> +	} else if (cmd.driver_qp_type =3D=3D EFA_QP_DRIVER_TYPE_SRD) {
> +		create_qp_params.qp_type =3D EFA_ADMIN_QP_TYPE_SRD;
> +	} else {
> +		ibdev_dbg(&dev->ibdev,
> +			  "Unsupported qp type %d driver qp type %d\n",
> +			  init_attr->qp_type, cmd.driver_qp_type);
> +		err =3D -EOPNOTSUPP;
> +		goto err_free_qp;
> +	}
> +
> +	ibdev_dbg(&dev->ibdev, "Create QP: qp type %d driver qp type %#x\n",
> +		  init_attr->qp_type, cmd.driver_qp_type);
> +	create_qp_params.send_cq_idx =3D to_ecq(init_attr->send_cq)->cq_idx;
> +	create_qp_params.recv_cq_idx =3D to_ecq(init_attr->recv_cq)->cq_idx;
> +	create_qp_params.sq_depth =3D init_attr->cap.max_send_wr;
> +	create_qp_params.sq_ring_size_in_bytes =3D cmd.sq_ring_size;
> +
> +	create_qp_params.rq_depth =3D init_attr->cap.max_recv_wr;
> +	create_qp_params.rq_ring_size_in_bytes =3D cmd.rq_ring_size;
> +	qp->rq_size =3D PAGE_ALIGN(create_qp_params.rq_ring_size_in_bytes);
> +	if (qp->rq_size) {
> +		qp->rq_cpu_addr =3D efa_zalloc_mapped(dev, &qp->rq_dma_addr,
> +						    qp->rq_size, DMA_TO_DEVICE);
> +		if (!qp->rq_cpu_addr) {
> +			err =3D -ENOMEM;
> +			goto err_free_qp;
> +		}
> +
> +		ibdev_dbg(&dev->ibdev,
> +			  "qp->cpu_addr[0x%p] allocated: size[%lu], dma[%pad]\n",
> +			  qp->rq_cpu_addr, qp->rq_size, &qp->rq_dma_addr);
> +		create_qp_params.rq_base_addr =3D qp->rq_dma_addr;
> +	}
> +
> +	err =3D efa_com_create_qp(&dev->edev, &create_qp_params,
> +				&create_qp_resp);
> +	if (err)
> +		goto err_free_mapped;
> +
> +	resp.sq_db_offset =3D create_qp_resp.sq_db_offset;
> +	resp.rq_db_offset =3D create_qp_resp.rq_db_offset;
> +	resp.llq_desc_offset =3D create_qp_resp.llq_descriptors_offset;
> +	resp.send_sub_cq_idx =3D create_qp_resp.send_sub_cq_idx;
> +	resp.recv_sub_cq_idx =3D create_qp_resp.recv_sub_cq_idx;
> +
> +	err =3D qp_mmap_entries_setup(qp, dev, ucontext, &create_qp_params,
> +				    &resp);
> +	if (err)
> +		goto err_destroy_qp;
> +
> +	qp->qp_handle =3D create_qp_resp.qp_handle;
> +	qp->ibqp.qp_num =3D create_qp_resp.qp_num;
> +	qp->ibqp.qp_type =3D init_attr->qp_type;
> +	qp->max_send_wr =3D init_attr->cap.max_send_wr;
> +	qp->max_recv_wr =3D init_attr->cap.max_recv_wr;
> +	qp->max_send_sge =3D init_attr->cap.max_send_sge;
> +	qp->max_recv_sge =3D init_attr->cap.max_recv_sge;
> +	qp->max_inline_data =3D init_attr->cap.max_inline_data;
> +
> +	if (udata->outlen) {
> +		err =3D ib_copy_to_udata(udata, &resp,
> +				       min(sizeof(resp), udata->outlen));
> +		if (err) {
> +			ibdev_dbg(&dev->ibdev,
> +				  "Failed to copy udata for qp[%u]\n",
> +				  create_qp_resp.qp_num);
> +			goto err_mmap_remove;
> +		}
> +	}
> +
> +	ibdev_dbg(&dev->ibdev, "Created qp[%d]\n", qp->ibqp.qp_num);
> +
> +	return &qp->ibqp;
> +
> +err_mmap_remove:
> +	mmap_obj_entries_remove(dev, ucontext, qp, true);
> +err_destroy_qp:
> +	efa_destroy_qp_handle(dev, create_qp_resp.qp_handle);
> +err_free_mapped:
> +	if (qp->rq_size) {
> +		dma_unmap_single(&dev->pdev->dev, qp->rq_dma_addr, qp->rq_size,
> +				 DMA_TO_DEVICE);
> +		free_pages_exact(qp->rq_cpu_addr, qp->rq_size);
> +	}
> +err_free_qp:
> +	kfree(qp);
> +err_out:
> +	atomic64_inc(&dev->stats.sw_stats.create_qp_err);
> +	return ERR_PTR(err);
> +}
> +
> +static int efa_modify_qp_validate(struct efa_dev *dev, struct efa_qp *qp=
,
> +				  struct ib_qp_attr *qp_attr, int qp_attr_mask,
> +				  enum ib_qp_state cur_state,
> +				  enum ib_qp_state new_state)
> +{
> +#define EFA_MODIFY_QP_SUPP_MASK \
> +	(IB_QP_STATE | IB_QP_CUR_STATE | IB_QP_EN_SQD_ASYNC_NOTIFY | \
> +	 IB_QP_PKEY_INDEX | IB_QP_PORT | IB_QP_QKEY | IB_QP_SQ_PSN)
> +
> +	if (qp_attr_mask & ~EFA_MODIFY_QP_SUPP_MASK) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "Unsupported qp_attr_mask[%#x] supported[%#x]\n",
> +			  qp_attr_mask, EFA_MODIFY_QP_SUPP_MASK);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!ib_modify_qp_is_ok(cur_state, new_state, IB_QPT_UD,
> +				qp_attr_mask)) {
> +		ibdev_dbg(&dev->ibdev, "Invalid modify QP parameters\n");
> +		return -EINVAL;
> +	}
> +
> +	if ((qp_attr_mask & IB_QP_PORT) && qp_attr->port_num !=3D 1) {
> +		ibdev_dbg(&dev->ibdev, "Can't change port num\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if ((qp_attr_mask & IB_QP_PKEY_INDEX) && qp_attr->pkey_index) {
> +		ibdev_dbg(&dev->ibdev, "Can't change pkey index\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +int efa_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
> +		  int qp_attr_mask, struct ib_udata *udata)
> +{
> +	struct efa_dev *dev =3D to_edev(ibqp->device);
> +	struct efa_com_modify_qp_params params =3D {};
> +	struct efa_qp *qp =3D to_eqp(ibqp);
> +	enum ib_qp_state cur_state;
> +	enum ib_qp_state new_state;
> +	int err;
> +
> +	if (udata->inlen &&
> +	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "Incompatible ABI params, udata not cleared\n");
> +		return -EINVAL;
> +	}
> +
> +	cur_state =3D qp_attr_mask & IB_QP_CUR_STATE ? qp_attr->cur_qp_state :
> +						     qp->state;
> +	new_state =3D qp_attr_mask & IB_QP_STATE ? qp_attr->qp_state : cur_stat=
e;
> +
> +	err =3D efa_modify_qp_validate(dev, qp, qp_attr, qp_attr_mask, cur_stat=
e,
> +				     new_state);
> +	if (err)
> +		return err;
> +
> +	params.qp_handle =3D qp->qp_handle;
> +
> +	if (qp_attr_mask & IB_QP_STATE) {
> +		params.modify_mask |=3D BIT(EFA_ADMIN_QP_STATE_BIT) |
> +				      BIT(EFA_ADMIN_CUR_QP_STATE_BIT);
> +		params.cur_qp_state =3D qp_attr->cur_qp_state;
> +		params.qp_state =3D qp_attr->qp_state;
> +	}
> +
> +	if (qp_attr_mask & IB_QP_EN_SQD_ASYNC_NOTIFY) {
> +		params.modify_mask |=3D
> +			BIT(EFA_ADMIN_SQ_DRAINED_ASYNC_NOTIFY_BIT);
> +		params.sq_drained_async_notify =3D qp_attr->en_sqd_async_notify;
> +	}
> +
> +	if (qp_attr_mask & IB_QP_QKEY) {
> +		params.modify_mask |=3D BIT(EFA_ADMIN_QKEY_BIT);
> +		params.qkey =3D qp_attr->qkey;
> +	}
> +
> +	if (qp_attr_mask & IB_QP_SQ_PSN) {
> +		params.modify_mask |=3D BIT(EFA_ADMIN_SQ_PSN_BIT);
> +		params.sq_psn =3D qp_attr->sq_psn;
> +	}
> +
> +	err =3D efa_com_modify_qp(&dev->edev, &params);
> +	if (err)
> +		return err;
> +
> +	qp->state =3D new_state;
> +
> +	return 0;
> +}
> +
> +static int efa_destroy_cq_idx(struct efa_dev *dev, int cq_idx)
> +{
> +	struct efa_com_destroy_cq_params params =3D { .cq_idx =3D cq_idx };
> +
> +	return efa_com_destroy_cq(&dev->edev, &params);
> +}
> +
> +int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
> +{
> +	struct efa_dev *dev =3D to_edev(ibcq->device);
> +	struct efa_cq *cq =3D to_ecq(ibcq);
> +	int err;
> +
> +	if (udata->inlen &&
> +	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
> +		ibdev_dbg(&dev->ibdev, "Incompatible ABI params\n");
> +		return -EINVAL;
> +	}
> +
> +	ibdev_dbg(&dev->ibdev,
> +		  "Destroy cq[%d] virt[0x%p] freed: size[%lu], dma[%pad]\n",
> +		  cq->cq_idx, cq->cpu_addr, cq->size, &cq->dma_addr);
> +
> +	err =3D efa_destroy_cq_idx(dev, cq->cq_idx);
> +	if (err)
> +		return err;
> +
> +	dma_unmap_single(&dev->pdev->dev, cq->dma_addr, cq->size,
> +			 DMA_FROM_DEVICE);
> +
> +	kfree(cq);
> +	return 0;
> +}
> +
> +static int cq_mmap_entries_setup(struct efa_dev *dev, struct efa_cq *cq,
> +				 struct efa_ibv_create_cq_resp *resp)
> +{
> +	struct efa_mmap_entry *cq_entry;
> +	int err;
> +
> +	cq_entry =3D kzalloc(sizeof(*cq_entry), GFP_KERNEL);
> +	if (!cq_entry)
> +		return -ENOMEM;
> +
> +	cq_entry->obj =3D cq;
> +
> +	cq_entry->address =3D virt_to_phys(cq->cpu_addr);
> +	cq_entry->length =3D cq->size;
> +	err =3D mmap_entry_insert(dev, cq->ucontext, cq_entry, EFA_MMAP_DMA_PAG=
E);
> +	if (err) {
> +		kfree(cq_entry);
> +		return err;
> +	}
> +
> +	resp->q_mmap_key =3D cq_entry->key;
> +	resp->q_mmap_size =3D cq_entry->length;
> +
> +	return 0;
> +}
> +
> +static struct ib_cq *do_create_cq(struct ib_device *ibdev, int entries,
> +				  int vector, struct ib_ucontext *ibucontext,
> +				  struct ib_udata *udata)
> +{
> +	struct efa_ibv_create_cq_resp resp =3D {};
> +	struct efa_com_create_cq_params params;
> +	struct efa_com_create_cq_result result;
> +	struct efa_dev *dev =3D to_edev(ibdev);
> +	struct efa_ibv_create_cq cmd =3D {};
> +	struct efa_cq *cq;
> +	int err;
> +
> +	ibdev_dbg(ibdev, "create_cq entries %d\n", entries);
> +
> +	if (entries < 1 || entries > dev->dev_attr.max_cq_depth) {
> +		ibdev_dbg(ibdev,
> +			  "cq: requested entries[%u] non-positive or greater than max[%u]\n",
> +			  entries, dev->dev_attr.max_cq_depth);
> +		err =3D -EINVAL;
> +		goto err_out;
> +	}
> +
> +	if (!field_avail(cmd, num_sub_cqs, udata->inlen)) {
> +		ibdev_dbg(ibdev,
> +			  "Incompatible ABI params, no input udata\n");
> +		err =3D -EINVAL;
> +		goto err_out;
> +	}
> +
> +	if (udata->inlen > sizeof(cmd) &&
> +	    !ib_is_udata_cleared(udata, sizeof(cmd),
> +				 udata->inlen - sizeof(cmd))) {
> +		ibdev_dbg(ibdev,
> +			  "Incompatible ABI params, unknown fields in udata\n");
> +		err =3D -EINVAL;
> +		goto err_out;
> +	}
> +
> +	err =3D ib_copy_from_udata(&cmd, udata,
> +				 min(sizeof(cmd), udata->inlen));
> +	if (err) {
> +		ibdev_dbg(ibdev, "Cannot copy udata for create_cq\n");
> +		goto err_out;
> +	}
> +
> +	if (cmd.comp_mask || !is_reserved_cleared(cmd.reserved_50)) {
> +		ibdev_dbg(ibdev,
> +			  "Incompatible ABI params, unknown fields in udata\n");
> +		err =3D -EINVAL;
> +		goto err_out;
> +	}
> +
> +	if (!cmd.cq_entry_size) {
> +		ibdev_dbg(ibdev,
> +			  "Invalid entry size [%u]\n", cmd.cq_entry_size);
> +		err =3D -EINVAL;
> +		goto err_out;
> +	}
> +
> +	if (cmd.num_sub_cqs !=3D dev->dev_attr.sub_cqs_per_cq) {
> +		ibdev_dbg(ibdev,
> +			  "Invalid number of sub cqs[%u] expected[%u]\n",
> +			  cmd.num_sub_cqs, dev->dev_attr.sub_cqs_per_cq);
> +		err =3D -EINVAL;
> +		goto err_out;
> +	}
> +
> +	cq =3D kzalloc(sizeof(*cq), GFP_KERNEL);
> +	if (!cq) {
> +		err =3D -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	cq->ucontext =3D to_eucontext(ibucontext);
> +	cq->size =3D PAGE_ALIGN(cmd.cq_entry_size * entries * cmd.num_sub_cqs);
> +	cq->cpu_addr =3D efa_zalloc_mapped(dev, &cq->dma_addr, cq->size,
> +					 DMA_FROM_DEVICE);
> +	if (!cq->cpu_addr) {
> +		err =3D -ENOMEM;
> +		goto err_free_cq;
> +	}
> +
> +	params.uarn =3D cq->ucontext->uarn;
> +	params.cq_depth =3D entries;
> +	params.dma_addr =3D cq->dma_addr;
> +	params.entry_size_in_bytes =3D cmd.cq_entry_size;
> +	params.num_sub_cqs =3D cmd.num_sub_cqs;
> +	err =3D efa_com_create_cq(&dev->edev, &params, &result);
> +	if (err)
> +		goto err_free_mapped;
> +
> +	resp.cq_idx =3D result.cq_idx;
> +	cq->cq_idx =3D result.cq_idx;
> +	cq->ibcq.cqe =3D result.actual_depth;
> +	WARN_ON_ONCE(entries !=3D result.actual_depth);
> +
> +	err =3D cq_mmap_entries_setup(dev, cq, &resp);
> +	if (err) {
> +		ibdev_dbg(ibdev,
> +			  "Could not setup cq[%u] mmap entries\n", cq->cq_idx);
> +		goto err_destroy_cq;
> +	}
> +
> +	if (udata->outlen) {
> +		err =3D ib_copy_to_udata(udata, &resp,
> +				       min(sizeof(resp), udata->outlen));
> +		if (err) {
> +			ibdev_dbg(ibdev,
> +				  "Failed to copy udata for create_cq\n");
> +			goto err_mmap_remove;
> +		}
> +	}
> +
> +	ibdev_dbg(ibdev,
> +		  "Created cq[%d], cq depth[%u]. dma[%pad] virt[0x%p]\n",
> +		  cq->cq_idx, result.actual_depth, &cq->dma_addr, cq->cpu_addr);
> +
> +	return &cq->ibcq;
> +
> +err_mmap_remove:
> +	mmap_obj_entries_remove(dev, to_eucontext(ibucontext), cq, true);
> +err_destroy_cq:
> +	efa_destroy_cq_idx(dev, cq->cq_idx);
> +err_free_mapped:
> +	dma_unmap_single(&dev->pdev->dev, cq->dma_addr, cq->size,
> +			 DMA_FROM_DEVICE);
> +	free_pages_exact(cq->cpu_addr, cq->size);
> +err_free_cq:
> +	kfree(cq);
> +err_out:
> +	atomic64_inc(&dev->stats.sw_stats.create_cq_err);
> +	return ERR_PTR(err);
> +}
> +
> +struct ib_cq *efa_create_cq(struct ib_device *ibdev,
> +			    const struct ib_cq_init_attr *attr,
> +			    struct ib_udata *udata)
> +{
> +	struct efa_ucontext *ucontext =3D rdma_udata_to_drv_context(udata,
> +								  struct efa_ucontext,
> +								  ibucontext);
> +
> +	return do_create_cq(ibdev, attr->cqe, attr->comp_vector,
> +			    &ucontext->ibucontext, udata);
> +}
> +
> +static int umem_to_page_list(struct efa_dev *dev,
> +			     struct ib_umem *umem,
> +			     u64 *page_list,
> +			     u32 hp_cnt,
> +			     u8 hp_shift)
> +{
> +	u32 pages_in_hp =3D BIT(hp_shift - PAGE_SHIFT);
> +	struct sg_dma_page_iter sg_iter;
> +	unsigned int page_idx =3D 0;
> +	unsigned int hp_idx =3D 0;
> +
> +	ibdev_dbg(&dev->ibdev, "hp_cnt[%u], pages_in_hp[%u]\n",
> +		  hp_cnt, pages_in_hp);
> +
> +	for_each_sg_dma_page(umem->sg_head.sgl, &sg_iter, umem->nmap, 0) {
> +		if (page_idx % pages_in_hp =3D=3D 0) {
> +			page_list[hp_idx] =3D sg_page_iter_dma_address(&sg_iter);
> +			hp_idx++;
> +		}
> +
> +		page_idx++;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct scatterlist *efa_vmalloc_buf_to_sg(u64 *buf, int page_cnt)
> +{
> +	struct scatterlist *sglist;
> +	struct page *pg;
> +	int i;
> +
> +	sglist =3D kcalloc(page_cnt, sizeof(*sglist), GFP_KERNEL);
> +	if (!sglist)
> +		return NULL;
> +	sg_init_table(sglist, page_cnt);
> +	for (i =3D 0; i < page_cnt; i++) {
> +		pg =3D vmalloc_to_page(buf);
> +		if (!pg)
> +			goto err;
> +		sg_set_page(&sglist[i], pg, PAGE_SIZE, 0);
> +		buf +=3D PAGE_SIZE / sizeof(*buf);
> +	}
> +	return sglist;
> +
> +err:
> +	kfree(sglist);
> +	return NULL;
> +}
> +
> +/*
> + * create a chunk list of physical pages dma addresses from the supplied
> + * scatter gather list
> + */
> +static int pbl_chunk_list_create(struct efa_dev *dev, struct pbl_context=
 *pbl)
> +{
> +	unsigned int entry, payloads_in_sg, chunk_list_size, chunk_idx, payload=
_idx;
> +	struct pbl_chunk_list *chunk_list =3D &pbl->phys.indirect.chunk_list;
> +	int page_cnt =3D pbl->phys.indirect.pbl_buf_size_in_pages;
> +	struct scatterlist *pages_sgl =3D pbl->phys.indirect.sgl;
> +	int sg_dma_cnt =3D pbl->phys.indirect.sg_dma_cnt;
> +	struct efa_com_ctrl_buff_info *ctrl_buf;
> +	u64 *cur_chunk_buf, *prev_chunk_buf;
> +	struct scatterlist *sg;
> +	dma_addr_t dma_addr;
> +	int i;
> +
> +	/* allocate a chunk list that consists of 4KB chunks */
> +	chunk_list_size =3D DIV_ROUND_UP(page_cnt, EFA_PTRS_PER_CHUNK);
> +
> +	chunk_list->size =3D chunk_list_size;
> +	chunk_list->chunks =3D kcalloc(chunk_list_size,
> +				     sizeof(*chunk_list->chunks),
> +				     GFP_KERNEL);
> +	if (!chunk_list->chunks)
> +		return -ENOMEM;
> +
> +	ibdev_dbg(&dev->ibdev,
> +		  "chunk_list_size[%u] - pages[%u]\n", chunk_list_size,
> +		  page_cnt);
> +
> +	/* allocate chunk buffers: */
> +	for (i =3D 0; i < chunk_list_size; i++) {
> +		chunk_list->chunks[i].buf =3D kzalloc(EFA_CHUNK_SIZE, GFP_KERNEL);
> +		if (!chunk_list->chunks[i].buf)
> +			goto chunk_list_dealloc;
> +
> +		chunk_list->chunks[i].length =3D EFA_CHUNK_USED_SIZE;
> +	}
> +	chunk_list->chunks[chunk_list_size - 1].length =3D
> +		((page_cnt % EFA_PTRS_PER_CHUNK) * EFA_CHUNK_PAYLOAD_PTR_SIZE) +
> +			EFA_CHUNK_PTR_SIZE;
> +
> +	/* fill the dma addresses of sg list pages to chunks: */
> +	chunk_idx =3D 0;
> +	payload_idx =3D 0;
> +	cur_chunk_buf =3D chunk_list->chunks[0].buf;
> +	for_each_sg(pages_sgl, sg, sg_dma_cnt, entry) {
> +		payloads_in_sg =3D sg_dma_len(sg) >> EFA_CHUNK_PAYLOAD_SHIFT;
> +		for (i =3D 0; i < payloads_in_sg; i++) {
> +			cur_chunk_buf[payload_idx++] =3D
> +				(sg_dma_address(sg) & ~(EFA_CHUNK_PAYLOAD_SIZE - 1)) +
> +				(EFA_CHUNK_PAYLOAD_SIZE * i);
> +
> +			if (payload_idx =3D=3D EFA_PTRS_PER_CHUNK) {
> +				chunk_idx++;
> +				cur_chunk_buf =3D chunk_list->chunks[chunk_idx].buf;
> +				payload_idx =3D 0;
> +			}
> +		}
> +	}
> +
> +	/* map chunks to dma and fill chunks next ptrs */
> +	for (i =3D chunk_list_size - 1; i >=3D 0; i--) {
> +		dma_addr =3D dma_map_single(&dev->pdev->dev,
> +					  chunk_list->chunks[i].buf,
> +					  chunk_list->chunks[i].length,
> +					  DMA_TO_DEVICE);
> +		if (dma_mapping_error(&dev->pdev->dev, dma_addr)) {
> +			ibdev_err(&dev->ibdev,
> +				  "chunk[%u] dma_map_failed\n", i);
> +			goto chunk_list_unmap;
> +		}
> +
> +		chunk_list->chunks[i].dma_addr =3D dma_addr;
> +		ibdev_dbg(&dev->ibdev,
> +			  "chunk[%u] mapped at [%pad]\n", i, &dma_addr);
> +
> +		if (!i)
> +			break;
> +
> +		prev_chunk_buf =3D chunk_list->chunks[i - 1].buf;
> +
> +		ctrl_buf =3D (struct efa_com_ctrl_buff_info *)
> +				&prev_chunk_buf[EFA_PTRS_PER_CHUNK];
> +		ctrl_buf->length =3D chunk_list->chunks[i].length;
> +
> +		efa_com_set_dma_addr(dma_addr,
> +				     &ctrl_buf->address.mem_addr_high,
> +				     &ctrl_buf->address.mem_addr_low);
> +	}
> +
> +	return 0;
> +
> +chunk_list_unmap:
> +	for (; i < chunk_list_size; i++) {
> +		dma_unmap_single(&dev->pdev->dev, chunk_list->chunks[i].dma_addr,
> +				 chunk_list->chunks[i].length, DMA_TO_DEVICE);
> +	}
> +chunk_list_dealloc:
> +	for (i =3D 0; i < chunk_list_size; i++)
> +		kfree(chunk_list->chunks[i].buf);
> +
> +	kfree(chunk_list->chunks);
> +	return -ENOMEM;
> +}
> +
> +static void pbl_chunk_list_destroy(struct efa_dev *dev, struct pbl_conte=
xt *pbl)
> +{
> +	struct pbl_chunk_list *chunk_list =3D &pbl->phys.indirect.chunk_list;
> +	int i;
> +
> +	for (i =3D 0; i < chunk_list->size; i++) {
> +		dma_unmap_single(&dev->pdev->dev, chunk_list->chunks[i].dma_addr,
> +				 chunk_list->chunks[i].length, DMA_TO_DEVICE);
> +		kfree(chunk_list->chunks[i].buf);
> +	}
> +
> +	kfree(chunk_list->chunks);
> +}
> +
> +/* initialize pbl continuous mode: map pbl buffer to a dma address. */
> +static int pbl_continuous_initialize(struct efa_dev *dev,
> +				     struct pbl_context *pbl)
> +{
> +	dma_addr_t dma_addr;
> +
> +	dma_addr =3D dma_map_single(&dev->pdev->dev, pbl->pbl_buf,
> +				  pbl->pbl_buf_size_in_bytes, DMA_TO_DEVICE);
> +	if (dma_mapping_error(&dev->pdev->dev, dma_addr)) {
> +		ibdev_err(&dev->ibdev, "Unable to map pbl to DMA address\n");
> +		return -ENOMEM;
> +	}
> +
> +	pbl->phys.continuous.dma_addr =3D dma_addr;
> +	ibdev_dbg(&dev->ibdev,
> +		  "pbl continuous - dma_addr =3D %pad, size[%u]\n",
> +		  &dma_addr, pbl->pbl_buf_size_in_bytes);
> +
> +	return 0;
> +}
> +
> +/*
> + * initialize pbl indirect mode:
> + * create a chunk list out of the dma addresses of the physical pages of
> + * pbl buffer.
> + */
> +static int pbl_indirect_initialize(struct efa_dev *dev, struct pbl_conte=
xt *pbl)
> +{
> +	u32 size_in_pages =3D DIV_ROUND_UP(pbl->pbl_buf_size_in_bytes, PAGE_SIZ=
E);
> +	struct scatterlist *sgl;
> +	int sg_dma_cnt, err;
> +
> +	BUILD_BUG_ON(EFA_CHUNK_PAYLOAD_SIZE > PAGE_SIZE);
> +	sgl =3D efa_vmalloc_buf_to_sg(pbl->pbl_buf, size_in_pages);
> +	if (!sgl)
> +		return -ENOMEM;
> +
> +	sg_dma_cnt =3D dma_map_sg(&dev->pdev->dev, sgl, size_in_pages, DMA_TO_D=
EVICE);
> +	if (!sg_dma_cnt) {
> +		err =3D -EINVAL;
> +		goto err_map;
> +	}
> +
> +	pbl->phys.indirect.pbl_buf_size_in_pages =3D size_in_pages;
> +	pbl->phys.indirect.sgl =3D sgl;
> +	pbl->phys.indirect.sg_dma_cnt =3D sg_dma_cnt;
> +	err =3D pbl_chunk_list_create(dev, pbl);
> +	if (err) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "chunk_list creation failed[%d]\n", err);
> +		goto err_chunk;
> +	}
> +
> +	ibdev_dbg(&dev->ibdev,
> +		  "pbl indirect - size[%u], chunks[%u]\n",
> +		  pbl->pbl_buf_size_in_bytes,
> +		  pbl->phys.indirect.chunk_list.size);
> +
> +	return 0;
> +
> +err_chunk:
> +	dma_unmap_sg(&dev->pdev->dev, sgl, size_in_pages, DMA_TO_DEVICE);
> +err_map:
> +	kfree(sgl);
> +	return err;
> +}
> +
> +static void pbl_indirect_terminate(struct efa_dev *dev, struct pbl_conte=
xt *pbl)
> +{
> +	pbl_chunk_list_destroy(dev, pbl);
> +	dma_unmap_sg(&dev->pdev->dev, pbl->phys.indirect.sgl,
> +		     pbl->phys.indirect.pbl_buf_size_in_pages, DMA_TO_DEVICE);
> +	kfree(pbl->phys.indirect.sgl);
> +}
> +
> +/* create a page buffer list from a mapped user memory region */
> +static int pbl_create(struct efa_dev *dev,
> +		      struct pbl_context *pbl,
> +		      struct ib_umem *umem,
> +		      int hp_cnt,
> +		      u8 hp_shift)
> +{
> +	int err;
> +
> +	pbl->pbl_buf_size_in_bytes =3D hp_cnt * EFA_CHUNK_PAYLOAD_PTR_SIZE;
> +	pbl->pbl_buf =3D kzalloc(pbl->pbl_buf_size_in_bytes,
> +			       GFP_KERNEL | __GFP_NOWARN);
> +	if (pbl->pbl_buf) {
> +		pbl->physically_continuous =3D 1;
> +		err =3D umem_to_page_list(dev, umem, pbl->pbl_buf, hp_cnt,
> +					hp_shift);
> +		if (err)
> +			goto err_continuous;
> +		err =3D pbl_continuous_initialize(dev, pbl);
> +		if (err)
> +			goto err_continuous;
> +	} else {
> +		pbl->physically_continuous =3D 0;
> +		pbl->pbl_buf =3D vzalloc(pbl->pbl_buf_size_in_bytes);
> +		if (!pbl->pbl_buf)
> +			return -ENOMEM;
> +
> +		err =3D umem_to_page_list(dev, umem, pbl->pbl_buf, hp_cnt,
> +					hp_shift);
> +		if (err)
> +			goto err_indirect;
> +		err =3D pbl_indirect_initialize(dev, pbl);
> +		if (err)
> +			goto err_indirect;
> +	}
> +
> +	ibdev_dbg(&dev->ibdev,
> +		  "user_pbl_created: user_pages[%u], continuous[%u]\n",
> +		  hp_cnt, pbl->physically_continuous);
> +
> +	return 0;
> +
> +err_continuous:
> +	kfree(pbl->pbl_buf);
> +	return err;
> +err_indirect:
> +	vfree(pbl->pbl_buf);
> +	return err;
> +}
> +
> +static void pbl_destroy(struct efa_dev *dev, struct pbl_context *pbl)
> +{
> +	if (pbl->physically_continuous) {
> +		dma_unmap_single(&dev->pdev->dev, pbl->phys.continuous.dma_addr,
> +				 pbl->pbl_buf_size_in_bytes, DMA_TO_DEVICE);
> +		kfree(pbl->pbl_buf);
> +	} else {
> +		pbl_indirect_terminate(dev, pbl);
> +		vfree(pbl->pbl_buf);
> +	}
> +}
> +
> +static int efa_create_inline_pbl(struct efa_dev *dev, struct efa_mr *mr,
> +				 struct efa_com_reg_mr_params *params)
> +{
> +	int err;
> +
> +	params->inline_pbl =3D 1;
> +	err =3D umem_to_page_list(dev, mr->umem, params->pbl.inline_pbl_array,
> +				params->page_num, params->page_shift);
> +	if (err)
> +		return err;
> +
> +	ibdev_dbg(&dev->ibdev,
> +		  "inline_pbl_array - pages[%u]\n", params->page_num);
> +
> +	return 0;
> +}
> +
> +static int efa_create_pbl(struct efa_dev *dev,
> +			  struct pbl_context *pbl,
> +			  struct efa_mr *mr,
> +			  struct efa_com_reg_mr_params *params)
> +{
> +	int err;
> +
> +	err =3D pbl_create(dev, pbl, mr->umem, params->page_num,
> +			 params->page_shift);
> +	if (err) {
> +		ibdev_dbg(&dev->ibdev, "Failed to create pbl[%d]\n", err);
> +		return err;
> +	}
> +
> +	params->inline_pbl =3D 0;
> +	params->indirect =3D !pbl->physically_continuous;
> +	if (pbl->physically_continuous) {
> +		params->pbl.pbl.length =3D pbl->pbl_buf_size_in_bytes;
> +
> +		efa_com_set_dma_addr(pbl->phys.continuous.dma_addr,
> +				     &params->pbl.pbl.address.mem_addr_high,
> +				     &params->pbl.pbl.address.mem_addr_low);
> +	} else {
> +		params->pbl.pbl.length =3D
> +			pbl->phys.indirect.chunk_list.chunks[0].length;
> +
> +		efa_com_set_dma_addr(pbl->phys.indirect.chunk_list.chunks[0].dma_addr,
> +				     &params->pbl.pbl.address.mem_addr_high,
> +				     &params->pbl.pbl.address.mem_addr_low);
> +	}
> +
> +	return 0;
> +}
> +
> +static void efa_cont_pages(struct ib_umem *umem, u64 addr,
> +			   unsigned long max_page_shift,
> +			   int *count, u8 *shift, u32 *ncont)
> +{
> +	struct scatterlist *sg;
> +	u64 base =3D ~0, p =3D 0;
> +	unsigned long tmp;
> +	unsigned long m;
> +	u64 len, pfn;
> +	int i =3D 0;
> +	int entry;
> +
> +	addr =3D addr >> PAGE_SHIFT;
> +	tmp =3D (unsigned long)addr;
> +	m =3D find_first_bit(&tmp, BITS_PER_LONG);
> +	if (max_page_shift)
> +		m =3D min_t(unsigned long, max_page_shift - PAGE_SHIFT, m);
> +
> +	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, entry) {
> +		len =3D DIV_ROUND_UP(sg_dma_len(sg), PAGE_SIZE);
> +		pfn =3D sg_dma_address(sg) >> PAGE_SHIFT;
> +		if (base + p !=3D pfn) {
> +			/*
> +			 * If either the offset or the new
> +			 * base are unaligned update m
> +			 */
> +			tmp =3D (unsigned long)(pfn | p);
> +			if (!IS_ALIGNED(tmp, 1 << m))
> +				m =3D find_first_bit(&tmp, BITS_PER_LONG);
> +
> +			base =3D pfn;
> +			p =3D 0;
> +		}
> +
> +		p +=3D len;
> +		i +=3D len;
> +	}
> +
> +	if (i) {
> +		m =3D min_t(unsigned long, ilog2(roundup_pow_of_two(i)), m);
> +		*ncont =3D DIV_ROUND_UP(i, (1 << m));
> +	} else {
> +		m =3D 0;
> +		*ncont =3D 0;
> +	}
> +
> +	*shift =3D PAGE_SHIFT + m;
> +	*count =3D i;
> +}
> +
> +struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
> +			 u64 virt_addr, int access_flags,
> +			 struct ib_udata *udata)
> +{
> +	struct efa_dev *dev =3D to_edev(ibpd->device);
> +	struct efa_com_reg_mr_params params =3D {};
> +	struct efa_com_reg_mr_result result =3D {};
> +	unsigned long max_page_shift;
> +	struct pbl_context pbl;
> +	struct efa_mr *mr;
> +	int inline_size;
> +	int npages;
> +	int err;
> +
> +	if (udata->inlen &&
> +	    !ib_is_udata_cleared(udata, 0, sizeof(udata->inlen))) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "Incompatible ABI params, udata not cleared\n");
> +		err =3D -EINVAL;
> +		goto err_out;
> +	}
> +
> +	if (access_flags & ~EFA_SUPPORTED_ACCESS_FLAGS) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "Unsupported access flags[%#x], supported[%#x]\n",
> +			  access_flags, EFA_SUPPORTED_ACCESS_FLAGS);
> +		err =3D -EOPNOTSUPP;
> +		goto err_out;
> +	}
> +
> +	mr =3D kzalloc(sizeof(*mr), GFP_KERNEL);
> +	if (!mr) {
> +		err =3D -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	mr->umem =3D ib_umem_get(udata, start, length, access_flags, 0);
> +	if (IS_ERR(mr->umem)) {
> +		err =3D PTR_ERR(mr->umem);
> +		ibdev_dbg(&dev->ibdev,
> +			  "Failed to pin and map user space memory[%d]\n", err);
> +		goto err_free;
> +	}
> +
> +	params.pd =3D to_epd(ibpd)->pdn;
> +	params.iova =3D virt_addr;
> +	params.mr_length_in_bytes =3D length;
> +	params.permissions =3D access_flags & 0x1;
> +	max_page_shift =3D fls64(dev->dev_attr.page_size_cap);
> +
> +	efa_cont_pages(mr->umem, start, max_page_shift, &npages,
> +		       &params.page_shift, &params.page_num);
> +	ibdev_dbg(&dev->ibdev,
> +		  "start %#llx length %#llx npages %d params.page_shift %u params.page=
_num %u\n",
> +		  start, length, npages, params.page_shift, params.page_num);
> +
> +	inline_size =3D ARRAY_SIZE(params.pbl.inline_pbl_array);
> +	if (params.page_num <=3D inline_size) {
> +		err =3D efa_create_inline_pbl(dev, mr, &params);
> +		if (err)
> +			goto err_unmap;
> +
> +		err =3D efa_com_register_mr(&dev->edev, &params, &result);
> +		if (err)
> +			goto err_unmap;
> +	} else {
> +		err =3D efa_create_pbl(dev, &pbl, mr, &params);
> +		if (err)
> +			goto err_unmap;
> +
> +		err =3D efa_com_register_mr(&dev->edev, &params, &result);
> +		pbl_destroy(dev, &pbl);
> +
> +		if (err)
> +			goto err_unmap;
> +	}
> +
> +	mr->ibmr.lkey =3D result.l_key;
> +	mr->ibmr.rkey =3D result.r_key;
> +	mr->ibmr.length =3D length;
> +	ibdev_dbg(&dev->ibdev, "Registered mr[%d]\n", mr->ibmr.lkey);
> +
> +	return &mr->ibmr;
> +
> +err_unmap:
> +	ib_umem_release(mr->umem);
> +err_free:
> +	kfree(mr);
> +err_out:
> +	atomic64_inc(&dev->stats.sw_stats.reg_mr_err);
> +	return ERR_PTR(err);
> +}
> +
> +int efa_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
> +{
> +	struct efa_dev *dev =3D to_edev(ibmr->device);
> +	struct efa_com_dereg_mr_params params;
> +	struct efa_mr *mr =3D to_emr(ibmr);
> +	int err;
> +
> +	if (udata->inlen &&
> +	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
> +		ibdev_dbg(&dev->ibdev, "Incompatible ABI params\n");
> +		return -EINVAL;
> +	}
> +
> +	ibdev_dbg(&dev->ibdev, "Deregister mr[%d]\n", ibmr->lkey);
> +
> +	if (mr->umem) {
> +		params.l_key =3D mr->ibmr.lkey;
> +		err =3D efa_com_dereg_mr(&dev->edev, &params);
> +		if (err)
> +			return err;
> +		ib_umem_release(mr->umem);
> +	}
> +
> +	kfree(mr);
> +
> +	return 0;
> +}
> +
> +int efa_get_port_immutable(struct ib_device *ibdev, u8 port_num,
> +			   struct ib_port_immutable *immutable)
> +{
> +	struct ib_port_attr attr;
> +	int err;
> +
> +	err =3D ib_query_port(ibdev, port_num, &attr);
> +	if (err) {
> +		ibdev_dbg(ibdev, "Couldn't query port err[%d]\n", err);
> +		return err;
> +	}
> +
> +	immutable->pkey_tbl_len =3D attr.pkey_tbl_len;
> +	immutable->gid_tbl_len =3D attr.gid_tbl_len;
> +
> +	return 0;
> +}
> +
> +static int efa_dealloc_uar(struct efa_dev *dev, u16 uarn)
> +{
> +	struct efa_com_dealloc_uar_params params =3D {
> +		.uarn =3D uarn,
> +	};
> +
> +	return efa_com_dealloc_uar(&dev->edev, &params);
> +}
> +
> +int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *=
udata)
> +{
> +	struct efa_ucontext *ucontext =3D to_eucontext(ibucontext);
> +	struct efa_dev *dev =3D to_edev(ibucontext->device);
> +	struct efa_ibv_alloc_ucontext_resp resp =3D {};
> +	struct efa_com_alloc_uar_result result;
> +	int err;
> +
> +	/*
> +	 * it's fine if the driver does not know all request fields,
> +	 * we will ack input fields in our response.
> +	 */
> +
> +	err =3D efa_com_alloc_uar(&dev->edev, &result);
> +	if (err)
> +		goto err_out;
> +
> +	ucontext->uarn =3D result.uarn;
> +	xa_init_flags(&ucontext->mmap_xa, XA_FLAGS_ALLOC);
> +
> +	resp.cmds_supp_udata_mask |=3D EFA_USER_CMDS_SUPP_UDATA_QUERY_DEVICE;
> +	resp.cmds_supp_udata_mask |=3D EFA_USER_CMDS_SUPP_UDATA_CREATE_AH;
> +	resp.sub_cqs_per_cq =3D dev->dev_attr.sub_cqs_per_cq;
> +	resp.inline_buf_size =3D dev->dev_attr.inline_buf_size;
> +	resp.max_llq_size =3D dev->dev_attr.max_llq_size;
> +
> +	if (udata && udata->outlen) {
> +		err =3D ib_copy_to_udata(udata, &resp,
> +				       min(sizeof(resp), udata->outlen));
> +		if (err)
> +			goto err_dealloc_uar;
> +	}
> +
> +	return 0;
> +
> +err_dealloc_uar:
> +	efa_dealloc_uar(dev, result.uarn);
> +err_out:
> +	atomic64_inc(&dev->stats.sw_stats.alloc_ucontext_err);
> +	return err;
> +}
> +
> +void efa_dealloc_ucontext(struct ib_ucontext *ibucontext)
> +{
> +	struct efa_ucontext *ucontext =3D to_eucontext(ibucontext);
> +	struct efa_dev *dev =3D to_edev(ibucontext->device);
> +
> +	mmap_entries_remove_free(dev, ucontext);
> +	efa_dealloc_uar(dev, ucontext->uarn);
> +}
> +
> +static int __efa_mmap(struct efa_dev *dev,
> +		      struct efa_ucontext *ucontext,
> +		      struct vm_area_struct *vma,
> +		      struct efa_mmap_entry *entry)
> +{
> +	u8 mmap_flag =3D get_mmap_flag(entry->key);
> +	u64 pfn =3D entry->address >> PAGE_SHIFT;
> +	u64 address =3D entry->address;
> +	u64 length =3D entry->length;
> +	unsigned long va;
> +	int err;
> +
> +	ibdev_dbg(&dev->ibdev,
> +		  "Mapping address[%#llx], length[%#llx], mmap_flag[%d]\n",
> +		  address, length, mmap_flag);
> +
> +	switch (mmap_flag) {
> +	case EFA_MMAP_IO_NC:
> +		err =3D rdma_user_mmap_io(&ucontext->ibucontext, vma, pfn, length,
> +					pgprot_noncached(vma->vm_page_prot));
> +		break;
> +	case EFA_MMAP_IO_WC:
> +		err =3D rdma_user_mmap_io(&ucontext->ibucontext, vma, pfn, length,
> +					pgprot_writecombine(vma->vm_page_prot));
> +		break;
> +	case EFA_MMAP_DMA_PAGE:
> +		for (va =3D vma->vm_start; va < vma->vm_end;
> +		     va +=3D PAGE_SIZE, pfn++) {
> +			err =3D vm_insert_page(vma, va, pfn_to_page(pfn));
> +			if (err)
> +				break

This loop doesn't bound the number of pfns it accesses, so it is a
security problem.

The core code was checking this before

Jason
