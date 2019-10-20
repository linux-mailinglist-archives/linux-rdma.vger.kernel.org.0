Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 242FFDDD12
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Oct 2019 08:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfJTGnM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 02:43:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32960 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfJTGnL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Oct 2019 02:43:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9K6dD5F103015;
        Sun, 20 Oct 2019 06:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=pqL1cgydyHTfhAhqrypiJz6ja1bHXZbszme2mOE3ofs=;
 b=UxBlAfRPKUUpfvz0XwU3p8pYhRB40jksQ3KgEiwL9qct7e8RDcBMm9/11DSfqJ1GM7+l
 sPTrpDFbZJHnOkvMyd4miuWUfNrgFXZQElu0UPZc8rrI3wMSDbhz/6RoEjgCGnWfEb5D
 b9xclzEH/eyLryXum1c2PHCIajVAOWWhOMBpXMV1qf7pAA3uz+OnAdfxN8QhMP2WbdQe
 B9SyzJELzbk6yEseN0rdIJKsLwLDbuVY1ro3dyp44MbDn0A0w3H+U2mQunJ92kosomqs
 1jf5GFm7cjDiDPG0aIlWuRJsS+QghfWzs3JrEoNCZDPC8HHA8SWBUR+b7/AMy4/g6a6L mQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vqu4qadwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 20 Oct 2019 06:43:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9K6h3lC139952;
        Sun, 20 Oct 2019 06:43:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vrbxqdmh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 20 Oct 2019 06:43:03 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9K6grkq010088;
        Sun, 20 Oct 2019 06:42:53 GMT
Received: from lap1 (/88.128.80.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 20 Oct 2019 06:42:52 +0000
Date:   Sun, 20 Oct 2019 09:42:46 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/rxe: Remove useless rxe_init_device_param
 assignments
Message-ID: <20191020064245.GA4980@lap1>
References: <20191020055724.7410-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191020055724.7410-1-leon@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9415 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910200066
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9415 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910200065
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 20, 2019 at 08:57:24AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> IB devices are allocated with kzalloc and don't need explicit zero
> assignments for their parameters. It can be removed safely.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c       | 13 -------------
>  drivers/infiniband/sw/rxe/rxe_param.h | 13 -------------
>  2 files changed, 26 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index a8c11b5e1e94..0946a301a5c5 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -77,12 +77,8 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
>  {
>  	rxe->max_inline_data			= RXE_MAX_INLINE_DATA;
>  
> -	rxe->attr.fw_ver			= RXE_FW_VER;
>  	rxe->attr.max_mr_size			= RXE_MAX_MR_SIZE;
>  	rxe->attr.page_size_cap			= RXE_PAGE_SIZE_CAP;
> -	rxe->attr.vendor_id			= RXE_VENDOR_ID;

So RXE_VENDOR_ID definition is no longer needed, right? we can remove it
too.

> -	rxe->attr.vendor_part_id		= RXE_VENDOR_PART_ID;
> -	rxe->attr.hw_ver			= RXE_HW_VER;

Ditto.

>  	rxe->attr.max_qp			= RXE_MAX_QP;
>  	rxe->attr.max_qp_wr			= RXE_MAX_QP_WR;
>  	rxe->attr.device_cap_flags		= RXE_DEVICE_CAP_FLAGS;
> @@ -94,22 +90,13 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
>  	rxe->attr.max_mr			= RXE_MAX_MR;
>  	rxe->attr.max_pd			= RXE_MAX_PD;
>  	rxe->attr.max_qp_rd_atom		= RXE_MAX_QP_RD_ATOM;
> -	rxe->attr.max_ee_rd_atom		= RXE_MAX_EE_RD_ATOM;

Also here.
Didn't checked the rest but it might be worth.

>  	rxe->attr.max_res_rd_atom		= RXE_MAX_RES_RD_ATOM;
>  	rxe->attr.max_qp_init_rd_atom		= RXE_MAX_QP_INIT_RD_ATOM;
> -	rxe->attr.max_ee_init_rd_atom		= RXE_MAX_EE_INIT_RD_ATOM;
>  	rxe->attr.atomic_cap			= IB_ATOMIC_HCA;
> -	rxe->attr.max_ee			= RXE_MAX_EE;
> -	rxe->attr.max_rdd			= RXE_MAX_RDD;
> -	rxe->attr.max_mw			= RXE_MAX_MW;
> -	rxe->attr.max_raw_ipv6_qp		= RXE_MAX_RAW_IPV6_QP;
> -	rxe->attr.max_raw_ethy_qp		= RXE_MAX_RAW_ETHY_QP;
>  	rxe->attr.max_mcast_grp			= RXE_MAX_MCAST_GRP;
>  	rxe->attr.max_mcast_qp_attach		= RXE_MAX_MCAST_QP_ATTACH;
>  	rxe->attr.max_total_mcast_qp_attach	= RXE_MAX_TOT_MCAST_QP_ATTACH;
>  	rxe->attr.max_ah			= RXE_MAX_AH;
> -	rxe->attr.max_fmr			= RXE_MAX_FMR;
> -	rxe->attr.max_map_per_fmr		= RXE_MAX_MAP_PER_FMR;
>  	rxe->attr.max_srq			= RXE_MAX_SRQ;
>  	rxe->attr.max_srq_wr			= RXE_MAX_SRQ_WR;
>  	rxe->attr.max_srq_sge			= RXE_MAX_SRQ_SGE;
> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
> index fe5207386700..353c6668249e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> @@ -60,12 +60,8 @@ static inline enum ib_mtu eth_mtu_int_to_enum(int mtu)
>  
>  /* default/initial rxe device parameter settings */
>  enum rxe_device_param {
> -	RXE_FW_VER			= 0,
>  	RXE_MAX_MR_SIZE			= -1ull,
>  	RXE_PAGE_SIZE_CAP		= 0xfffff000,
> -	RXE_VENDOR_ID			= 0,
> -	RXE_VENDOR_PART_ID		= 0,
> -	RXE_HW_VER			= 0,
>  	RXE_MAX_QP			= 0x10000,
>  	RXE_MAX_QP_WR			= 0x4000,
>  	RXE_MAX_INLINE_DATA		= 400,
> @@ -87,21 +83,12 @@ enum rxe_device_param {
>  	RXE_MAX_MR			= 256 * 1024,
>  	RXE_MAX_PD			= 0x7ffc,
>  	RXE_MAX_QP_RD_ATOM		= 128,
> -	RXE_MAX_EE_RD_ATOM		= 0,
>  	RXE_MAX_RES_RD_ATOM		= 0x3f000,
>  	RXE_MAX_QP_INIT_RD_ATOM		= 128,
> -	RXE_MAX_EE_INIT_RD_ATOM		= 0,
> -	RXE_MAX_EE			= 0,
> -	RXE_MAX_RDD			= 0,
> -	RXE_MAX_MW			= 0,
> -	RXE_MAX_RAW_IPV6_QP		= 0,
> -	RXE_MAX_RAW_ETHY_QP		= 0,
>  	RXE_MAX_MCAST_GRP		= 8192,
>  	RXE_MAX_MCAST_QP_ATTACH		= 56,
>  	RXE_MAX_TOT_MCAST_QP_ATTACH	= 0x70000,
>  	RXE_MAX_AH			= 100,
> -	RXE_MAX_FMR			= 0,
> -	RXE_MAX_MAP_PER_FMR		= 0,
>  	RXE_MAX_SRQ			= 960,
>  	RXE_MAX_SRQ_WR			= 0x4000,
>  	RXE_MIN_SRQ_WR			= 1,
> -- 
> 2.20.1
> 
