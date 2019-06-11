Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B71443D000
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 16:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfFKO57 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 11 Jun 2019 10:57:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729205AbfFKO57 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jun 2019 10:57:59 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BEtJti080366
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2019 10:57:58 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.91])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2cvae3kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2019 10:57:58 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 Jun 2019 14:57:57 -0000
Received: from us1a3-smtp04.a3.dal06.isc4sb.com (10.106.154.237)
        by smtp.notes.na.collabserv.com (10.106.227.143) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 Jun 2019 14:55:10 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp04.a3.dal06.isc4sb.com
          with ESMTP id 2019061114550915-730072 ;
          Tue, 11 Jun 2019 14:55:09 +0000 
In-Reply-To: <20190610060423.GD6369@mtr-leonro.mtl.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 11 Jun 2019 14:55:08 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190610060423.GD6369@mtr-leonro.mtl.com>,<20190526114156.6827-1-bmt@zurich.ibm.com>
 <20190526114156.6827-6-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 17575
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19061114-9951-0000-0000-00000CD9BD0A
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.042026
X-IBM-SpamModules-Versions: BY=3.00011247; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216471; UDB=6.00639610; IPR=6.00997571;
 BA=6.00006331; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027264; XFM=3.00000015;
 UTC=2019-06-11 14:57:56
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-06-11 10:58:48 - 6.00010036
x-cbparentid: 19061114-9952-0000-0000-00003CFBD8C4
Message-Id: <OF699B5295.774BDD4E-ON00258416.004EFC98-00258416.0051F3F9@notes.na.collabserv.com>
Subject: Re:  Re: [PATCH for-next v1 05/12] SIW application interface
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 06/10/2019 08:04AM
>Cc: linux-rdma@vger.kernel.org
>Subject: [EXTERNAL] Re: [PATCH for-next v1 05/12] SIW application
>interface
>
>On Sun, May 26, 2019 at 01:41:49PM +0200, Bernard Metzler wrote:
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> ---
>>  drivers/infiniband/sw/siw/siw_verbs.c    | 1778
>++++++++++++++++++++++
>>  drivers/infiniband/sw/siw/siw_verbs.h    |  102 ++
>>  include/uapi/rdma/rdma_user_ioctl_cmds.h |    1 +
>>  include/uapi/rdma/siw-abi.h              |  186 +++
>>  4 files changed, 2067 insertions(+)
>>  create mode 100644 drivers/infiniband/sw/siw/siw_verbs.c
>>  create mode 100644 drivers/infiniband/sw/siw/siw_verbs.h
>>  create mode 100644 include/uapi/rdma/siw-abi.h
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>b/drivers/infiniband/sw/siw/siw_verbs.c
>> new file mode 100644
>> index 000000000000..e0e53d23d9de
>> --- /dev/null
>> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
>> @@ -0,0 +1,1778 @@
>> +// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
>> +
>> +/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
>> +/* Copyright (c) 2008-2019, IBM Corporation */
>> +
>> +#include <linux/errno.h>
>> +#include <linux/types.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/vmalloc.h>
>> +#include <linux/xarray.h>
>> +
>> +#include <rdma/iw_cm.h>
>> +#include <rdma/ib_verbs.h>
>> +#include <rdma/ib_smi.h>
>> +#include <rdma/ib_user_verbs.h>
>> +#include <rdma/uverbs_ioctl.h>
>> +
>> +#include "siw.h"
>> +#include "siw_verbs.h"
>> +#include "siw_mem.h"
>> +#include "siw_cm.h"
>> +#include "siw_debug.h"
>> +
>> +static int ib_qp_state_to_siw_qp_state[IB_QPS_ERR + 1] = {
>> +	[IB_QPS_RESET] = SIW_QP_STATE_IDLE,
>> +	[IB_QPS_INIT] = SIW_QP_STATE_IDLE,
>> +	[IB_QPS_RTR] = SIW_QP_STATE_RTR,
>> +	[IB_QPS_RTS] = SIW_QP_STATE_RTS,
>> +	[IB_QPS_SQD] = SIW_QP_STATE_CLOSING,
>> +	[IB_QPS_SQE] = SIW_QP_STATE_TERMINATE,
>> +	[IB_QPS_ERR] = SIW_QP_STATE_ERROR
>> +};
>> +
>> +static char ib_qp_state_to_string[IB_QPS_ERR + 1][sizeof("RESET")]
>= {
>> +	[IB_QPS_RESET] = "RESET", [IB_QPS_INIT] = "INIT", [IB_QPS_RTR] =
>"RTR",
>> +	[IB_QPS_RTS] = "RTS",     [IB_QPS_SQD] = "SQD",   [IB_QPS_SQE] =
>"SQE",
>> +	[IB_QPS_ERR] = "ERR"
>> +};
>> +
>> +static u32 siw_create_uobj(struct siw_ucontext *uctx, void *vaddr,
>u32 size)
>> +{
>> +	struct siw_uobj *uobj;
>> +	struct xa_limit limit = XA_LIMIT(0, SIW_UOBJ_MAX_KEY);
>> +	u32 key;
>> +
>> +	uobj = kzalloc(sizeof(*uobj), GFP_KERNEL);
>> +	if (!uobj)
>> +		return SIW_INVAL_UOBJ_KEY;
>> +
>> +	if (xa_alloc_cyclic(&uctx->xa, &key, uobj, limit,
>&uctx->uobj_nextkey,
>> +			    GFP_KERNEL) < 0) {
>> +		kfree(uobj);
>> +		return SIW_INVAL_UOBJ_KEY;
>> +	}
>> +	uobj->size = PAGE_ALIGN(size);
>> +	uobj->addr = vaddr;
>> +
>> +	return key;
>> +}
>> +
>> +static struct siw_uobj *siw_get_uobj(struct siw_ucontext *uctx,
>> +				     unsigned long off, u32 size)
>> +{
>> +	struct siw_uobj *uobj = xa_load(&uctx->xa, off);
>> +
>> +	if (uobj && uobj->size == size)
>> +		return uobj;
>> +
>> +	return NULL;
>> +}
>> +
>> +static void siw_delete_uobj(struct siw_ucontext *uctx, unsigned
>long index)
>> +{
>> +	struct siw_uobj *uobj = xa_erase(&uctx->xa, index);
>> +
>> +	kfree(uobj);
>> +}
>> +
>> +int siw_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma)
>> +{
>> +	struct siw_ucontext *uctx = to_siw_ctx(ctx);
>> +	struct siw_uobj *uobj;
>> +	unsigned long off = vma->vm_pgoff;
>> +	int size = vma->vm_end - vma->vm_start;
>> +	int rv = -EINVAL;
>> +
>> +	/*
>> +	 * Must be page aligned
>> +	 */
>> +	if (vma->vm_start & (PAGE_SIZE - 1)) {
>> +		pr_warn("siw: mmap not page aligned\n");
>> +		goto out;
>> +	}
>> +	uobj = siw_get_uobj(uctx, off, size);
>> +	if (!uobj) {
>> +		siw_dbg(&uctx->sdev->base_dev, "mmap lookup failed: %lu, %u\n",
>> +			off, size);
>> +		goto out;
>> +	}
>> +	rv = remap_vmalloc_range(vma, uobj->addr, 0);
>> +	if (rv)
>> +		pr_warn("remap_vmalloc_range failed: %lu, %u\n", off, size);
>> +out:
>> +	return rv;
>> +}
>> +
>> +int siw_alloc_ucontext(struct ib_ucontext *base_ctx, struct
>ib_udata *udata)
>> +{
>> +	struct siw_device *sdev = to_siw_dev(base_ctx->device);
>> +	struct siw_ucontext *ctx = to_siw_ctx(base_ctx);
>> +	struct siw_uresp_alloc_ctx uresp = {};
>> +	int rv;
>> +
>> +	if (atomic_inc_return(&sdev->num_ctx) > SIW_MAX_CONTEXT) {
>> +		rv = -ENOMEM;
>> +		goto err_out;
>> +	}
>> +	xa_init_flags(&ctx->xa, XA_FLAGS_ALLOC);
>> +	ctx->uobj_nextkey = 0;
>> +	ctx->sdev = sdev;
>> +
>> +	uresp.dev_id = sdev->vendor_part_id;
>> +
>> +	if (udata->outlen < sizeof(uresp)) {
>> +		rv = -EINVAL;
>> +		goto err_out;
>> +	}
>> +	rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
>> +	if (rv)
>> +		goto err_out;
>> +
>> +	siw_dbg(base_ctx->device, "success. now %d context(s)\n",
>> +		atomic_read(&sdev->num_ctx));
>> +
>> +	return 0;
>> +
>> +err_out:
>> +	atomic_dec(&sdev->num_ctx);
>> +	siw_dbg(base_ctx->device, "failure %d. now %d context(s)\n", rv,
>> +		atomic_read(&sdev->num_ctx));
>> +
>> +	return rv;
>> +}
>> +
>> +void siw_dealloc_ucontext(struct ib_ucontext *base_ctx)
>> +{
>> +	struct siw_ucontext *uctx = to_siw_ctx(base_ctx);
>> +	void *entry;
>> +	unsigned long index;
>> +
>> +	/*
>> +	 * Make sure all user mmap objects are gone. Since QP, CQ
>> +	 * and SRQ destroy routines destroy related objects, nothing
>> +	 * should be found here.
>> +	 */
>> +	xa_for_each(&uctx->xa, index, entry) {
>> +		kfree(xa_erase(&uctx->xa, index));
>
>Thanks, it is good example why obfuscation is bad, a couple of lines
>above, you added siw_delete_uobj() which does exactly the same, but
>you already don't remember about that function.
>

Absolutely! Removed siw_delete_uobj().

>> +		pr_warn("siw: dropping orphaned uobj at %lu\n", index);
>> +	}
>> +	xa_destroy(&uctx->xa);
>> +	atomic_dec(&uctx->sdev->num_ctx);
>> +}
>> +
>> +int siw_query_device(struct ib_device *base_dev, struct
>ib_device_attr *attr,
>> +		     struct ib_udata *udata)
>> +{
>> +	struct siw_device *sdev = to_siw_dev(base_dev);
>> +
>> +	memset(attr, 0, sizeof(*attr));
>> +
>> +	/* Revisit atomic caps if RFC 7306 gets supported */
>> +	attr->atomic_cap = 0;
>> +	attr->device_cap_flags =
>> +		IB_DEVICE_MEM_MGT_EXTENSIONS | IB_DEVICE_ALLOW_USER_UNREG;
>> +	attr->max_cq = sdev->attrs.max_cq;
>> +	attr->max_cqe = sdev->attrs.max_cqe;
>> +	attr->max_fast_reg_page_list_len = SIW_MAX_SGE_PBL;
>> +	attr->max_fmr = sdev->attrs.max_fmr;
>> +	attr->max_mr = sdev->attrs.max_mr;
>> +	attr->max_mw = sdev->attrs.max_mw;
>> +	attr->max_mr_size = ~0ull;
>> +	attr->max_pd = sdev->attrs.max_pd;
>> +	attr->max_qp = sdev->attrs.max_qp;
>> +	attr->max_qp_init_rd_atom = sdev->attrs.max_ird;
>> +	attr->max_qp_rd_atom = sdev->attrs.max_ord;
>> +	attr->max_qp_wr = sdev->attrs.max_qp_wr;
>> +	attr->max_recv_sge = sdev->attrs.max_sge;
>> +	attr->max_res_rd_atom = sdev->attrs.max_qp * sdev->attrs.max_ird;
>> +	attr->max_send_sge = sdev->attrs.max_sge;
>> +	attr->max_sge_rd = sdev->attrs.max_sge_rd;
>> +	attr->max_srq = sdev->attrs.max_srq;
>> +	attr->max_srq_sge = sdev->attrs.max_srq_sge;
>> +	attr->max_srq_wr = sdev->attrs.max_srq_wr;
>> +	attr->page_size_cap = PAGE_SIZE;
>> +	attr->vendor_id = SIW_VENDOR_ID;
>> +	attr->vendor_part_id = sdev->vendor_part_id;
>> +
>> +	memcpy(&attr->sys_image_guid, sdev->netdev->dev_addr, 6);
>> +
>> +	return 0;
>> +}
>> +
>> +int siw_query_port(struct ib_device *base_dev, u8 port,
>> +		   struct ib_port_attr *attr)
>> +{
>> +	struct siw_device *sdev = to_siw_dev(base_dev);
>> +
>> +	memset(attr, 0, sizeof(*attr));
>> +
>> +	attr->active_mtu = attr->max_mtu;
>> +	attr->active_speed = 2;
>> +	attr->active_width = 2;
>> +	attr->gid_tbl_len = 1;
>> +	attr->max_msg_sz = -1;
>> +	attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
>> +	attr->phys_state = sdev->state == IB_PORT_ACTIVE ? 5 : 3;
>> +	attr->pkey_tbl_len = 1;
>> +	attr->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_DEVICE_MGMT_SUP;
>> +	attr->state = sdev->state;
>> +	/*
>> +	 * All zero
>> +	 *
>> +	 * attr->lid = 0;
>> +	 * attr->bad_pkey_cntr = 0;
>> +	 * attr->qkey_viol_cntr = 0;
>> +	 * attr->sm_lid = 0;
>> +	 * attr->lmc = 0;
>> +	 * attr->max_vl_num = 0;
>> +	 * attr->sm_sl = 0;
>> +	 * attr->subnet_timeout = 0;
>> +	 * attr->init_type_repy = 0;
>> +	 */
>> +	return 0;
>> +}
>> +
>> +int siw_get_port_immutable(struct ib_device *base_dev, u8 port,
>> +			   struct ib_port_immutable *port_immutable)
>> +{
>> +	struct ib_port_attr attr;
>> +	int rv = siw_query_port(base_dev, port, &attr);
>> +
>> +	if (rv)
>> +		return rv;
>> +
>> +	port_immutable->pkey_tbl_len = attr.pkey_tbl_len;
>> +	port_immutable->gid_tbl_len = attr.gid_tbl_len;
>> +	port_immutable->core_cap_flags = RDMA_CORE_PORT_IWARP;
>> +
>> +	return 0;
>> +}
>> +
>> +int siw_query_pkey(struct ib_device *base_dev, u8 port, u16 idx,
>u16 *pkey)
>> +{
>> +	/* Report the default pkey */
>> +	*pkey = 0xffff;
>> +	return 0;
>> +}
>> +
>> +int siw_query_gid(struct ib_device *base_dev, u8 port, int idx,
>> +		  union ib_gid *gid)
>> +{
>> +	struct siw_device *sdev = to_siw_dev(base_dev);
>> +
>> +	/* subnet_prefix == interface_id == 0; */
>> +	memset(gid, 0, sizeof(*gid));
>> +	memcpy(&gid->raw[0], sdev->netdev->dev_addr, 6);
>> +
>> +	return 0;
>> +}
>> +
>> +int siw_alloc_pd(struct ib_pd *pd, struct ib_udata *udata)
>> +{
>> +	struct siw_device *sdev = to_siw_dev(pd->device);
>> +
>> +	if (atomic_inc_return(&sdev->num_pd) > SIW_MAX_PD) {
>> +		atomic_dec(&sdev->num_pd);
>> +		return -ENOMEM;
>> +	}
>> +	siw_dbg_pd(pd, "now %d PD's(s)\n", atomic_read(&sdev->num_pd));
>> +
>> +	return 0;
>> +}
>> +
>> +void siw_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
>> +{
>> +	struct siw_device *sdev = to_siw_dev(pd->device);
>> +
>> +	siw_dbg_pd(pd, "free PD\n");
>> +	atomic_dec(&sdev->num_pd);
>> +}
>> +
>> +void siw_qp_get_ref(struct ib_qp *base_qp)
>> +{
>> +	siw_qp_get(to_siw_qp(base_qp));
>> +}
>> +
>> +void siw_qp_put_ref(struct ib_qp *base_qp)
>> +{
>> +	siw_qp_put(to_siw_qp(base_qp));
>> +}
>> +
>> +/*
>> + * siw_create_qp()
>> + *
>> + * Create QP of requested size on given device.
>> + *
>> + * @pd:		Protection Domain
>> + * @attrs:	Initial QP attributes.
>> + * @udata:	used to provide QP ID, SQ and RQ size back to user.
>> + */
>> +
>> +struct ib_qp *siw_create_qp(struct ib_pd *pd,
>> +			    struct ib_qp_init_attr *attrs,
>> +			    struct ib_udata *udata)
>> +{
>> +	struct siw_qp *qp = NULL;
>> +	struct siw_base_qp *siw_base_qp = NULL;
>> +	struct ib_device *base_dev = pd->device;
>> +	struct siw_device *sdev = to_siw_dev(base_dev);
>> +	struct siw_ucontext *uctx =
>> +		rdma_udata_to_drv_context(udata, struct siw_ucontext,
>> +					  base_ucontext);
>> +	struct siw_cq *scq = NULL, *rcq = NULL;
>> +	unsigned long flags;
>> +	int num_sqe, num_rqe, rv = 0;
>> +
>> +	siw_dbg(base_dev, "create new QP\n");
>> +
>> +	if (atomic_inc_return(&sdev->num_qp) > SIW_MAX_QP) {
>> +		siw_dbg(base_dev, "too many QP's\n");
>> +		rv = -ENOMEM;
>> +		goto err_out;
>> +	}
>> +	if (attrs->qp_type != IB_QPT_RC) {
>> +		siw_dbg(base_dev, "only RC QP's supported\n");
>> +		rv = -EINVAL;
>> +		goto err_out;
>> +	}
>> +	if ((attrs->cap.max_send_wr > SIW_MAX_QP_WR) ||
>> +	    (attrs->cap.max_recv_wr > SIW_MAX_QP_WR) ||
>> +	    (attrs->cap.max_send_sge > SIW_MAX_SGE) ||
>> +	    (attrs->cap.max_recv_sge > SIW_MAX_SGE)) {
>> +		siw_dbg(base_dev, "QP size error\n");
>> +		rv = -EINVAL;
>> +		goto err_out;
>> +	}
>> +	if (attrs->cap.max_inline_data > SIW_MAX_INLINE) {
>> +		siw_dbg(base_dev, "max inline send: %d > %d\n",
>> +			attrs->cap.max_inline_data, (int)SIW_MAX_INLINE);
>> +		rv = -EINVAL;
>> +		goto err_out;
>> +	}
>> +	/*
>> +	 * NOTE: we allow for zero element SQ and RQ WQE's SGL's
>> +	 * but not for a QP unable to hold any WQE (SQ + RQ)
>> +	 */
>> +	if (attrs->cap.max_send_wr + attrs->cap.max_recv_wr == 0) {
>> +		siw_dbg(base_dev, "QP must have send or receive queue\n");
>> +		rv = -EINVAL;
>> +		goto err_out;
>> +	}
>> +	scq = to_siw_cq(attrs->send_cq);
>> +	rcq = to_siw_cq(attrs->recv_cq);
>> +
>> +	if (!scq || (!rcq && !attrs->srq)) {
>> +		siw_dbg(base_dev, "send CQ or receive CQ invalid\n");
>> +		rv = -EINVAL;
>> +		goto err_out;
>> +	}
>> +	siw_base_qp = kzalloc(sizeof(*siw_base_qp), GFP_KERNEL);
>> +	if (!siw_base_qp) {
>> +		rv = -ENOMEM;
>> +		goto err_out;
>> +	}
>> +	qp = kzalloc(sizeof(*qp), GFP_KERNEL);
>> +	if (!qp) {
>> +		rv = -ENOMEM;
>> +		goto err_out;
>> +	}
>> +	siw_base_qp->qp = qp;
>> +	qp->ib_qp = &siw_base_qp->base_qp;
>> +
>> +	init_rwsem(&qp->state_lock);
>> +	spin_lock_init(&qp->sq_lock);
>> +	spin_lock_init(&qp->rq_lock);
>> +	spin_lock_init(&qp->orq_lock);
>> +
>> +	qp->kernel_verbs = !udata;
>
>Are you sure that you absolutely need kernel_verbs flag inside QP and
>can't do like all other drivers did to understand it dynamically?
>

Yes I need it for the CQE creation, deciding if I should provide the qpn
or the struct ib_qp *. I also need it to prevent the user to post a SQ/RQ
wqe via the IB_USER_VERBS_CMD_POST_SEND/RECV command.

>> +	ibv_post_send qp->xa_sq_index = SIW_INVAL_UOBJ_KEY;
>> +	qp->xa_rq_index = SIW_INVAL_UOBJ_KEY;
>> +
>> +	rv = siw_qp_add(sdev, qp);
>> +	if (rv)
>> +		goto err_out;
>> +
>> +	num_sqe = roundup_pow_of_two(attrs->cap.max_send_wr);
>> +	num_rqe = roundup_pow_of_two(attrs->cap.max_recv_wr);
>> +
>> +	if (qp->kernel_verbs)
>> +		qp->sendq = vzalloc(num_sqe * sizeof(struct siw_sqe));
>> +	else
>> +		qp->sendq = vmalloc_user(num_sqe * sizeof(struct siw_sqe));
>> +
>> +	if (qp->sendq == NULL) {
>> +		siw_dbg(base_dev, "SQ size %d alloc failed\n", num_sqe);
>> +		rv = -ENOMEM;
>> +		goto err_out_xa;
>> +	}
>> +	if (attrs->sq_sig_type != IB_SIGNAL_REQ_WR) {
>> +		if (attrs->sq_sig_type == IB_SIGNAL_ALL_WR)
>> +			qp->attrs.flags |= SIW_SIGNAL_ALL_WR;
>> +		else {
>> +			rv = -EINVAL;
>> +			goto err_out_xa;
>> +		}
>> +	}
>> +	qp->pd = pd;
>> +	qp->scq = scq;
>> +	qp->rcq = rcq;
>> +
>> +	if (attrs->srq) {
>> +		/*
>> +		 * SRQ support.
>> +		 * Verbs 6.3.7: ignore RQ size, if SRQ present
>> +		 * Verbs 6.3.5: do not check PD of SRQ against PD of QP
>> +		 */
>> +		qp->srq = to_siw_srq(attrs->srq);
>> +		qp->attrs.rq_size = 0;
>> +		siw_dbg(base_dev, "QP [%u]: [SRQ 0x%p] attached\n",
>> +			qp->qp_num, qp->srq);
>> +	} else if (num_rqe) {
>> +		if (qp->kernel_verbs)
>> +			qp->recvq = vzalloc(num_rqe * sizeof(struct siw_rqe));
>> +		else
>> +			qp->recvq =
>> +				vmalloc_user(num_rqe * sizeof(struct siw_rqe));
>> +
>> +		if (qp->recvq == NULL) {
>> +			siw_dbg(base_dev, "RQ size %d alloc failed\n", num_rqe);
>> +			rv = -ENOMEM;
>> +			goto err_out_xa;
>> +		}
>> +		qp->attrs.rq_size = num_rqe;
>> +	}
>> +	qp->attrs.sq_size = num_sqe;
>> +	qp->attrs.sq_max_sges = attrs->cap.max_send_sge;
>> +	qp->attrs.rq_max_sges = attrs->cap.max_recv_sge;
>> +
>> +	/* Make those two tunables fixed for now. */
>> +	qp->tx_ctx.gso_seg_limit = 1;
>> +	qp->tx_ctx.zcopy_tx = zcopy_tx;
>> +
>> +	qp->attrs.state = SIW_QP_STATE_IDLE;
>> +
>> +	if (udata) {
>> +		struct siw_uresp_create_qp uresp = {};
>> +
>> +		uresp.num_sqe = num_sqe;
>> +		uresp.num_rqe = num_rqe;
>> +		uresp.qp_id = qp_id(qp);
>> +
>> +		if (qp->sendq) {
>> +			qp->xa_sq_index =
>> +				siw_create_uobj(uctx, qp->sendq,
>> +					num_sqe * sizeof(struct siw_sqe));
>> +		}
>> +		if (qp->recvq) {
>> +			qp->xa_rq_index =
>> +				 siw_create_uobj(uctx, qp->recvq,
>> +					num_rqe * sizeof(struct siw_rqe));
>> +		}
>> +		if (qp->xa_sq_index == SIW_INVAL_UOBJ_KEY ||
>> +		    qp->xa_rq_index == SIW_INVAL_UOBJ_KEY) {
>> +			rv = -ENOMEM;
>> +			goto err_out_xa;
>> +		}
>> +		uresp.sq_key = qp->xa_sq_index << PAGE_SHIFT;
>> +		uresp.rq_key = qp->xa_rq_index << PAGE_SHIFT;
>> +
>> +		if (udata->outlen < sizeof(uresp)) {
>> +			rv = -EINVAL;
>> +			goto err_out_xa;
>> +		}
>> +		rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
>> +		if (rv)
>> +			goto err_out_xa;
>> +	}
>> +	qp->tx_cpu = siw_get_tx_cpu(sdev);
>> +	if (qp->tx_cpu < 0) {
>> +		rv = -EINVAL;
>> +		goto err_out_xa;
>> +	}
>> +	INIT_LIST_HEAD(&qp->devq);
>> +	spin_lock_irqsave(&sdev->lock, flags);
>> +	list_add_tail(&qp->devq, &sdev->qp_list);
>> +	spin_unlock_irqrestore(&sdev->lock, flags);
>> +
>> +	return qp->ib_qp;
>> +
>> +err_out_xa:
>> +	xa_erase(&sdev->qp_xa, qp_id(qp));
>> +err_out:
>> +	kfree(siw_base_qp);
>> +
>> +	if (qp) {
>> +		if (qp->xa_sq_index != SIW_INVAL_UOBJ_KEY)
>> +			siw_delete_uobj(uctx, qp->xa_sq_index);
>> +		if (qp->xa_rq_index != SIW_INVAL_UOBJ_KEY)
>> +			siw_delete_uobj(uctx, qp->xa_rq_index);
>> +		if (qp->sendq)
>> +			vfree(qp->sendq);
>> +		if (qp->recvq)
>> +			vfree(qp->recvq);
>> +		kfree(qp);
>> +	}
>> +	atomic_dec(&sdev->num_qp);
>> +
>> +	return ERR_PTR(rv);
>> +}
>> +
>> +/*
>> + * Minimum siw_query_qp() verb interface.
>> + *
>> + * @qp_attr_mask is not used but all available information is
>provided
>> + */
>> +int siw_query_qp(struct ib_qp *base_qp, struct ib_qp_attr
>*qp_attr,
>> +		 int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr)
>> +{
>> +	struct siw_qp *qp;
>> +	struct siw_device *sdev;
>> +
>> +	if (base_qp && qp_attr && qp_init_attr) {
>> +		qp = to_siw_qp(base_qp);
>> +		sdev = to_siw_dev(base_qp->device);
>> +	} else {
>> +		return -EINVAL;
>> +	}
>> +	qp_attr->cap.max_inline_data = SIW_MAX_INLINE;
>> +	qp_attr->cap.max_send_wr = qp->attrs.sq_size;
>> +	qp_attr->cap.max_send_sge = qp->attrs.sq_max_sges;
>> +	qp_attr->cap.max_recv_wr = qp->attrs.rq_size;
>> +	qp_attr->cap.max_recv_sge = qp->attrs.rq_max_sges;
>> +	qp_attr->path_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
>> +	qp_attr->max_rd_atomic = qp->attrs.irq_size;
>> +	qp_attr->max_dest_rd_atomic = qp->attrs.orq_size;
>> +
>> +	qp_attr->qp_access_flags = IB_ACCESS_LOCAL_WRITE |
>> +				   IB_ACCESS_REMOTE_WRITE |
>> +				   IB_ACCESS_REMOTE_READ;
>> +
>> +	qp_init_attr->qp_type = base_qp->qp_type;
>> +	qp_init_attr->send_cq = base_qp->send_cq;
>> +	qp_init_attr->recv_cq = base_qp->recv_cq;
>> +	qp_init_attr->srq = base_qp->srq;
>> +
>> +	qp_init_attr->cap = qp_attr->cap;
>> +
>> +	return 0;
>> +}
>> +
>> +int siw_verbs_modify_qp(struct ib_qp *base_qp, struct ib_qp_attr
>*attr,
>> +			int attr_mask, struct ib_udata *udata)
>> +{
>> +	struct siw_qp_attrs new_attrs;
>> +	enum siw_qp_attr_mask siw_attr_mask = 0;
>> +	struct siw_qp *qp = to_siw_qp(base_qp);
>> +	int rv = 0;
>> +
>> +	if (!attr_mask)
>> +		return 0;
>> +
>> +	memset(&new_attrs, 0, sizeof(new_attrs));
>> +
>> +	if (attr_mask & IB_QP_ACCESS_FLAGS) {
>> +		siw_attr_mask = SIW_QP_ATTR_ACCESS_FLAGS;
>> +
>> +		if (attr->qp_access_flags & IB_ACCESS_REMOTE_READ)
>> +			new_attrs.flags |= SIW_RDMA_READ_ENABLED;
>> +		if (attr->qp_access_flags & IB_ACCESS_REMOTE_WRITE)
>> +			new_attrs.flags |= SIW_RDMA_WRITE_ENABLED;
>> +		if (attr->qp_access_flags & IB_ACCESS_MW_BIND)
>> +			new_attrs.flags |= SIW_RDMA_BIND_ENABLED;
>> +	}
>> +	if (attr_mask & IB_QP_STATE) {
>> +		siw_dbg_qp(qp, "desired IB QP state: %s\n",
>> +			   ib_qp_state_to_string[attr->qp_state]);
>> +
>> +		new_attrs.state = ib_qp_state_to_siw_qp_state[attr->qp_state];
>> +
>> +		if (new_attrs.state > SIW_QP_STATE_RTS)
>> +			qp->tx_ctx.tx_suspend = 1;
>> +
>> +		siw_attr_mask |= SIW_QP_ATTR_STATE;
>> +	}
>> +	if (!siw_attr_mask)
>> +		goto out;
>> +
>> +	down_write(&qp->state_lock);
>> +
>> +	rv = siw_qp_modify(qp, &new_attrs, siw_attr_mask);
>> +
>> +	up_write(&qp->state_lock);
>> +out:
>> +	return rv;
>> +}
>> +
>> +int siw_destroy_qp(struct ib_qp *base_qp, struct ib_udata *udata)
>> +{
>> +	struct siw_qp *qp = to_siw_qp(base_qp);
>> +	struct siw_base_qp *siw_base_qp = to_siw_base_qp(base_qp);
>> +	struct siw_ucontext *uctx =
>> +		rdma_udata_to_drv_context(udata, struct siw_ucontext,
>> +					  base_ucontext);
>> +	struct siw_qp_attrs qp_attrs;
>> +
>> +	siw_dbg_qp(qp, "state %d, cep 0x%p\n", qp->attrs.state, qp->cep);
>> +
>> +	/*
>> +	 * Mark QP as in process of destruction to prevent from
>> +	 * any async callbacks to RDMA core
>> +	 */
>> +	qp->attrs.flags |= SIW_QP_IN_DESTROY;
>> +	qp->rx_stream.rx_suspend = 1;
>> +
>> +	if (uctx && qp->xa_sq_index != SIW_INVAL_UOBJ_KEY)
>> +		siw_delete_uobj(uctx, qp->xa_sq_index);
>> +	if (uctx && qp->xa_rq_index != SIW_INVAL_UOBJ_KEY)
>> +		siw_delete_uobj(uctx, qp->xa_rq_index);
>> +
>> +	down_write(&qp->state_lock);
>> +
>> +	qp_attrs.state = SIW_QP_STATE_ERROR;
>> +	(void)siw_qp_modify(qp, &qp_attrs, SIW_QP_ATTR_STATE);
>
>Where is no need to do (void) casting.

Right....removed.

>
>> +
>> +	if (qp->cep) {
>> +		siw_cep_put(qp->cep);
>> +		qp->cep = NULL;
>> +	}
>> +	up_write(&qp->state_lock);
>> +
>> +	kfree(qp->rx_stream.mpa_crc_hd);
>> +	kfree(qp->tx_ctx.mpa_crc_hd);
>> +
>> +	/* Drop references */
>> +	qp->scq = qp->rcq = NULL;
>> +
>> +	siw_qp_put(qp);
>> +	kfree_rcu(siw_base_qp, rcu);
>
>I would say that RCU over base QP can't be right and proper locking
>is needed.
>
Good catch! No need to rcu protect the base_qp.

