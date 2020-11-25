Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD9F2C3A73
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Nov 2020 09:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgKYIDh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Nov 2020 03:03:37 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16173 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgKYIDg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Nov 2020 03:03:36 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbe0fd50005>; Wed, 25 Nov 2020 00:03:33 -0800
Received: from [172.27.12.45] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 25 Nov
 2020 08:03:23 +0000
Subject: Re: [PATCH rdma-core v2 2/6] verbs: Support dma-buf based memory
 region
To:     Jianxin Xiong <jianxin.xiong@intel.com>
CC:     <linux-rdma@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        "Doug Ledford" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Leon Romanovsky" <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Yishai Hadas <yishaih@nvidia.com>
References: <1606253934-67181-1-git-send-email-jianxin.xiong@intel.com>
 <1606253934-67181-3-git-send-email-jianxin.xiong@intel.com>
From:   Yishai Hadas <yishaih@nvidia.com>
Message-ID: <127ec96d-5f13-f1c6-145a-f2aa87839284@nvidia.com>
Date:   Wed, 25 Nov 2020 10:03:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1606253934-67181-3-git-send-email-jianxin.xiong@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606291413; bh=+X15ow+nQ+XuXioAF/crzpfl/WDbne2xdavTnKNf1qY=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=KdI9sETFzq/oojuQK+gWIrentSSrU09OD5A5uU7PMK0s1Mg+19jJT/IRngI/dq9uW
         p++4P3ICcuq6zxwAhljsviPDFhLc5eCGlsR+MHY767iebw1JhysMJdQO8znH0y2IcS
         AWxqdAiMiTf6M5kFdC8nzgvbBrb9yyyXwpWo78VYxqJw7qTRJGGJZge4n1nhbfKu6y
         4YGk4eOESuRg7NAEjoT+xMvZJmbO/zAJXqvjMXBsyEYi3wAYU18MhnsFqKLmoPI+IG
         6++64WnseGHHHI9Lb8FerzLLgMolJuuj7zai3pTIm5+ZT7lxe9+dzAX04zSYGXcaXm
         1inVSJwy4w/Yw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/24/2020 11:38 PM, Jianxin Xiong wrote:
> Add new API function and new provider method for registering dma-buf
> based memory region. Update the man page and bump the API version.
>
> Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>

I don't see that this=C2=A0 V2 fixes the notes that I published on V1 (fork=
=20
handling , man page fix).


> ---
>   debian/libibverbs1.symbols   |  2 ++
>   libibverbs/CMakeLists.txt    |  2 +-
>   libibverbs/cmd_mr.c          | 38 +++++++++++++++++++++++++++++++++++++=
+
>   libibverbs/driver.h          |  7 +++++++
>   libibverbs/dummy_ops.c       | 11 +++++++++++
>   libibverbs/libibverbs.map.in |  6 ++++++
>   libibverbs/man/ibv_reg_mr.3  | 21 +++++++++++++++++++--
>   libibverbs/verbs.c           | 17 +++++++++++++++++
>   libibverbs/verbs.h           | 11 +++++++++++
>   9 files changed, 112 insertions(+), 3 deletions(-)
>
> diff --git a/debian/libibverbs1.symbols b/debian/libibverbs1.symbols
> index 9130f41..fcf4d87 100644
> --- a/debian/libibverbs1.symbols
> +++ b/debian/libibverbs1.symbols
> @@ -9,6 +9,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
>    IBVERBS_1.9@IBVERBS_1.9 30
>    IBVERBS_1.10@IBVERBS_1.10 31
>    IBVERBS_1.11@IBVERBS_1.11 32
> + IBVERBS_1.12@IBVERBS_1.12 33
>    (symver)IBVERBS_PRIVATE_33 33
>    _ibv_query_gid_ex@IBVERBS_1.11 32
>    _ibv_query_gid_table@IBVERBS_1.11 32
> @@ -99,6 +100,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
>    ibv_rate_to_mbps@IBVERBS_1.1 1.1.8
>    ibv_rate_to_mult@IBVERBS_1.0 1.1.6
>    ibv_read_sysfs_file@IBVERBS_1.0 1.1.6
> + ibv_reg_dmabuf_mr@IBVERBS_1.12 33
>    ibv_reg_mr@IBVERBS_1.0 1.1.6
>    ibv_reg_mr@IBVERBS_1.1 1.1.6
>    ibv_reg_mr_iova@IBVERBS_1.7 25
> diff --git a/libibverbs/CMakeLists.txt b/libibverbs/CMakeLists.txt
> index 0fe4256..d075225 100644
> --- a/libibverbs/CMakeLists.txt
> +++ b/libibverbs/CMakeLists.txt
> @@ -21,7 +21,7 @@ configure_file("libibverbs.map.in"
>  =20
>   rdma_library(ibverbs "${CMAKE_CURRENT_BINARY_DIR}/libibverbs.map"
>     # See Documentation/versioning.md
> -  1 1.11.${PACKAGE_VERSION}
> +  1 1.12.${PACKAGE_VERSION}
>     all_providers.c
>     cmd.c
>     cmd_ah.c
> diff --git a/libibverbs/cmd_mr.c b/libibverbs/cmd_mr.c
> index 42dbe42..95ed2d1 100644
> --- a/libibverbs/cmd_mr.c
> +++ b/libibverbs/cmd_mr.c
> @@ -1,5 +1,6 @@
>   /*
>    * Copyright (c) 2018 Mellanox Technologies, Ltd.  All rights reserved.
> + * Copyright (c) 2020 Intel Corporation.  All rights reserved.
>    *
>    * This software is available to you under a choice of one of two
>    * licenses.  You may choose to be licensed under the terms of the GNU
> @@ -116,3 +117,40 @@ int ibv_cmd_query_mr(struct ibv_pd *pd, struct verbs=
_mr *vmr,
>   	return 0;
>   }
>  =20
> +int ibv_cmd_reg_dmabuf_mr(struct ibv_pd *pd, uint64_t offset, size_t len=
gth,
> +			  uint64_t iova, int fd, int access,
> +			  struct verbs_mr *vmr)
> +{
> +	DECLARE_COMMAND_BUFFER(cmdb, UVERBS_OBJECT_MR,
> +			       UVERBS_METHOD_REG_DMABUF_MR,
> +			       9);
> +	struct ib_uverbs_attr *handle;
> +	uint32_t lkey, rkey;
> +	int ret;
> +
> +	handle =3D fill_attr_out_obj(cmdb, UVERBS_ATTR_REG_DMABUF_MR_HANDLE);
> +	fill_attr_out_ptr(cmdb, UVERBS_ATTR_REG_DMABUF_MR_RESP_LKEY, &lkey);
> +	fill_attr_out_ptr(cmdb, UVERBS_ATTR_REG_DMABUF_MR_RESP_RKEY, &rkey);
> +
> +	fill_attr_in_obj(cmdb, UVERBS_ATTR_REG_DMABUF_MR_PD_HANDLE, pd->handle)=
;
> +	fill_attr_in_uint64(cmdb, UVERBS_ATTR_REG_DMABUF_MR_OFFSET, offset);
> +	fill_attr_in_uint64(cmdb, UVERBS_ATTR_REG_DMABUF_MR_LENGTH, length);
> +	fill_attr_in_uint64(cmdb, UVERBS_ATTR_REG_DMABUF_MR_IOVA, iova);
> +	fill_attr_in_uint32(cmdb, UVERBS_ATTR_REG_DMABUF_MR_FD, fd);
> +	fill_attr_in_uint32(cmdb, UVERBS_ATTR_REG_DMABUF_MR_ACCESS_FLAGS, acces=
s);
> +
> +	ret =3D execute_ioctl(pd->context, cmdb);
> +	if (ret)
> +		return errno;
> +
> +	vmr->ibv_mr.handle =3D read_attr_obj(UVERBS_ATTR_REG_DMABUF_MR_HANDLE,
> +					   handle);
> +	vmr->ibv_mr.context =3D pd->context;
> +	vmr->ibv_mr.lkey =3D lkey;
> +	vmr->ibv_mr.rkey =3D rkey;
> +	vmr->ibv_mr.pd =3D pd;
> +	vmr->ibv_mr.addr =3D (void *)offset;
> +	vmr->ibv_mr.length =3D length;
> +	vmr->mr_type =3D IBV_MR_TYPE_MR;
> +	return 0;
> +}
> diff --git a/libibverbs/driver.h b/libibverbs/driver.h
> index ab80f4b..d6a9d0a 100644
> --- a/libibverbs/driver.h
> +++ b/libibverbs/driver.h
> @@ -2,6 +2,7 @@
>    * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserve=
d.
>    * Copyright (c) 2005, 2006 Cisco Systems, Inc.  All rights reserved.
>    * Copyright (c) 2005 PathScale, Inc.  All rights reserved.
> + * Copyright (c) 2020 Intel Corporation. All rights reserved.
>    *
>    * This software is available to you under a choice of one of two
>    * licenses.  You may choose to be licensed under the terms of the GNU
> @@ -373,6 +374,9 @@ struct verbs_context_ops {
>   	struct ibv_mr *(*reg_dm_mr)(struct ibv_pd *pd, struct ibv_dm *dm,
>   				    uint64_t dm_offset, size_t length,
>   				    unsigned int access);
> +	struct ibv_mr *(*reg_dmabuf_mr)(struct ibv_pd *pd, uint64_t offset,
> +					size_t length, uint64_t iova,
> +					int fd, int access);
>   	struct ibv_mr *(*reg_mr)(struct ibv_pd *pd, void *addr, size_t length,
>   				 uint64_t hca_va, int access);
>   	int (*req_notify_cq)(struct ibv_cq *cq, int solicited_only);
> @@ -498,6 +502,9 @@ int ibv_cmd_advise_mr(struct ibv_pd *pd,
>   		      uint32_t flags,
>   		      struct ibv_sge *sg_list,
>   		      uint32_t num_sge);
> +int ibv_cmd_reg_dmabuf_mr(struct ibv_pd *pd, uint64_t offset, size_t len=
gth,
> +			  uint64_t iova, int fd, int access,
> +			  struct verbs_mr *vmr);
>   int ibv_cmd_alloc_mw(struct ibv_pd *pd, enum ibv_mw_type type,
>   		     struct ibv_mw *mw, struct ibv_alloc_mw *cmd,
>   		     size_t cmd_size,
> diff --git a/libibverbs/dummy_ops.c b/libibverbs/dummy_ops.c
> index e5af9e4..64ef279 100644
> --- a/libibverbs/dummy_ops.c
> +++ b/libibverbs/dummy_ops.c
> @@ -1,5 +1,6 @@
>   /*
>    * Copyright (c) 2017 Mellanox Technologies, Inc.  All rights reserved.
> + * Copyright (c) 2020 Intel Corporation.  All rights reserved.
>    *
>    * This software is available to you under a choice of one of two
>    * licenses.  You may choose to be licensed under the terms of the GNU
> @@ -452,6 +453,14 @@ static struct ibv_mr *reg_mr(struct ibv_pd *pd, void=
 *addr, size_t length,
>   	return NULL;
>   }
>  =20
> +static struct ibv_mr *reg_dmabuf_mr(struct ibv_pd *pd, uint64_t offset,
> +				    size_t length, uint64_t iova,
> +				    int fd, int access)
> +{
> +	errno =3D EOPNOTSUPP;
> +	return NULL;
> +}
> +
>   static int req_notify_cq(struct ibv_cq *cq, int solicited_only)
>   {
>   	return EOPNOTSUPP;
> @@ -560,6 +569,7 @@ const struct verbs_context_ops verbs_dummy_ops =3D {
>   	query_srq,
>   	read_counters,
>   	reg_dm_mr,
> +	reg_dmabuf_mr,
>   	reg_mr,
>   	req_notify_cq,
>   	rereg_mr,
> @@ -689,6 +699,7 @@ void verbs_set_ops(struct verbs_context *vctx,
>   	SET_PRIV_OP_IC(vctx, set_ece);
>   	SET_PRIV_OP_IC(vctx, unimport_mr);
>   	SET_PRIV_OP_IC(vctx, unimport_pd);
> +	SET_OP(ctx, reg_dmabuf_mr);
>  =20
>   #undef SET_OP
>   #undef SET_OP2
> diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
> index b5ccaca..f67e1ef 100644
> --- a/libibverbs/libibverbs.map.in
> +++ b/libibverbs/libibverbs.map.in
> @@ -148,6 +148,11 @@ IBVERBS_1.11 {
>   		_ibv_query_gid_table;
>   } IBVERBS_1.10;
>  =20
> +IBVERBS_1.12 {
> +	global:
> +		ibv_reg_dmabuf_mr;
> +} IBVERBS_1.11;
> +
>   /* If any symbols in this stanza change ABI then the entire staza gets =
a new symbol
>      version. See the top level CMakeLists.txt for this setting. */
>  =20
> @@ -211,6 +216,7 @@ IBVERBS_PRIVATE_@IBVERBS_PABI_VERSION@ {
>   		ibv_cmd_query_srq;
>   		ibv_cmd_read_counters;
>   		ibv_cmd_reg_dm_mr;
> +		ibv_cmd_reg_dmabuf_mr;
>   		ibv_cmd_reg_mr;
>   		ibv_cmd_req_notify_cq;
>   		ibv_cmd_rereg_mr;
> diff --git a/libibverbs/man/ibv_reg_mr.3 b/libibverbs/man/ibv_reg_mr.3
> index 2bfc955..4975c79 100644
> --- a/libibverbs/man/ibv_reg_mr.3
> +++ b/libibverbs/man/ibv_reg_mr.3
> @@ -3,7 +3,7 @@
>   .\"
>   .TH IBV_REG_MR 3 2006-10-31 libibverbs "Libibverbs Programmer's Manual"
>   .SH "NAME"
> -ibv_reg_mr, ibv_reg_mr_iova, ibv_dereg_mr \- register or deregister a me=
mory region (MR)
> +ibv_reg_mr, ibv_reg_mr_iova, ibv_reg_dmabuf_mr, ibv_dereg_mr \- register=
 or deregister a memory region (MR)
>   .SH "SYNOPSIS"
>   .nf
>   .B #include <infiniband/verbs.h>
> @@ -15,6 +15,9 @@ ibv_reg_mr, ibv_reg_mr_iova, ibv_dereg_mr \- register o=
r deregister a memory reg
>   .BI "                               size_t " "length" ", uint64_t " "hc=
a_va" ,
>   .BI "                               int " "access" );
>   .sp
> +.BI "struct ibv_mr *ibv_reg_dmabuf_mr(struct ibv_pd " "*pd" ", uint64_t =
" "offset" ,
> +.BI "                                 size_t " "length" ", int " "access=
" );
> +.sp
>   .BI "int ibv_dereg_mr(struct ibv_mr " "*mr" );
>   .fi
>   .SH "DESCRIPTION"
> @@ -71,11 +74,25 @@ a lkey or rkey. The offset in the memory region is co=
mputed as 'addr +
>   (iova - hca_va)'. Specifying 0 for hca_va has the same effect as
>   IBV_ACCESS_ZERO_BASED.
>   .PP
> +.B ibv_reg_dmabuf_mr()
> +registers a dma-buf based memory region (MR) associated with the protect=
ion domain
> +.I pd\fR.
> +The MR starts at
> +.I offset
> +of the dma-buf and its size is
> +.I length\fR.
> +The dma-buf is identified by the file descriptor
> +.I fd\fR.
> +The argument
> +.I access
> +describes the desired memory protection attributes; it is similar to the=
 ibv_reg_mr case except that only the following flags are supported:
> +.B IBV_ACCESS_LOCAL_WRITE, IBV_ACCESS_REMOTE_WRITE, IBV_ACCESS_REMOTE_RE=
AD, IBV_ACCESS_REMOTE_ATOMIC, IBV_ACCESS_RELAXED_ORDERING.
> +.PP
>   .B ibv_dereg_mr()
>   deregisters the MR
>   .I mr\fR.
>   .SH "RETURN VALUE"
> -.B ibv_reg_mr() / ibv_reg_mr_iova()
> +.B ibv_reg_mr() / ibv_reg_mr_iova() / ibv_reg_dmabuf_mr()
>   returns a pointer to the registered MR, or NULL if the request fails.
>   The local key (\fBL_Key\fR) field
>   .B lkey
> diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
> index 2b0ede8..b944904 100644
> --- a/libibverbs/verbs.c
> +++ b/libibverbs/verbs.c
> @@ -1,6 +1,7 @@
>   /*
>    * Copyright (c) 2005 Topspin Communications.  All rights reserved.
>    * Copyright (c) 2006, 2007 Cisco Systems, Inc.  All rights reserved.
> + * Copyright (c) 2020 Intel Corperation.  All rights reserved.
>    *
>    * This software is available to you under a choice of one of two
>    * licenses.  You may choose to be licensed under the terms of the GNU
> @@ -367,6 +368,22 @@ void ibv_unimport_mr(struct ibv_mr *mr)
>   	get_ops(mr->context)->unimport_mr(mr);
>   }
>  =20
> +struct ibv_mr *ibv_reg_dmabuf_mr(struct ibv_pd *pd, uint64_t offset,
> +				 size_t length, int fd, int access)
> +{
> +	struct ibv_mr *mr;
> +
> +	mr =3D get_ops(pd->context)->reg_dmabuf_mr(pd, offset, length, offset,
> +						 fd, access);
> +	if (mr) {
> +		mr->context =3D pd->context;
> +		mr->pd      =3D pd;
> +		mr->addr    =3D (void *)offset;
> +		mr->length  =3D length;
> +	}
> +	return mr;
> +}
> +
>   LATEST_SYMVER_FUNC(ibv_rereg_mr, 1_1, "IBVERBS_1.1",
>   		   int,
>   		   struct ibv_mr *mr, int flags,
> diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
> index ee57e05..9194ad2 100644
> --- a/libibverbs/verbs.h
> +++ b/libibverbs/verbs.h
> @@ -3,6 +3,7 @@
>    * Copyright (c) 2004, 2011-2012 Intel Corporation.  All rights reserve=
d.
>    * Copyright (c) 2005, 2006, 2007 Cisco Systems, Inc.  All rights reser=
ved.
>    * Copyright (c) 2005 PathScale, Inc.  All rights reserved.
> + * Copyright (c) 2020 Intel Corporation.  All rights reserved.
>    *
>    * This software is available to you under a choice of one of two
>    * licenses.  You may choose to be licensed under the terms of the GNU
> @@ -1961,6 +1962,10 @@ struct ibv_context_ops {
>   	void *(*_compat_attach_mcast)(void);
>   	void *(*_compat_detach_mcast)(void);
>   	void *(*_compat_async_event)(void);
> +	struct ibv_mr *		(*reg_dmabuf_mr)(struct ibv_pd *pd,
> +						 uint64_t offset, size_t length,
> +						 uint64_t iova, int fd,
> +						 int access);
>   };
>  =20
>   struct ibv_context {
> @@ -2535,6 +2540,12 @@ __ibv_reg_mr_iova(struct ibv_pd *pd, void *addr, s=
ize_t length, uint64_t iova,
>   			  __builtin_constant_p(                                \
>   				  ((access) & IBV_ACCESS_OPTIONAL_RANGE) =3D=3D 0))
>  =20
> +/**
> + * ibv_reg_dmabuf_mr - Register a dambuf-based memory region
> + */
> +struct ibv_mr *ibv_reg_dmabuf_mr(struct ibv_pd *pd, uint64_t offset, siz=
e_t length,
> +				 int fd, int access);
> +
>   enum ibv_rereg_mr_err_code {
>   	/* Old MR is valid, invalid input */
>   	IBV_REREG_MR_ERR_INPUT =3D -1,


