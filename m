Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D242DBE04
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Dec 2020 10:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgLPJwn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Dec 2020 04:52:43 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:11857 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725862AbgLPJwm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Dec 2020 04:52:42 -0500
X-IronPort-AV: E=Sophos;i="5.78,424,1599494400"; 
   d="scan'208";a="102461583"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Dec 2020 17:51:54 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 720ED4CE4BCB;
        Wed, 16 Dec 2020 17:51:50 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 16 Dec 2020 17:51:46 +0800
Message-ID: <5FD9D8B2.1020208@cn.fujitsu.com>
Date:   Wed, 16 Dec 2020 17:51:46 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
CC:     <linux-rdma@vger.kernel.org>, <leon@kernel.org>
Subject: Re: [PATCH v2] librdmacm: Make some functions report proper errno
References: <20201216092252.155110-1-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20201216092252.155110-1-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 720ED4CE4BCB.AA46D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon,

Thanks for your quick reply. :-)
I have done the same change on three
functions(ucma_get_device,ucma_create_cqs, rdma_create_qp_ex).

On 2020/12/16 17:22, Xiao Yang wrote:
> Some functions reports fixed ENOMEM when getting any failure, so
> it's hard for user to know which actual error happens on them.
>
> Fixes(ucma_get_device):
> 2ffda7f29913 ("librdmacm: Only allocate verbs resources when needed")
> 191c9346f335 ("librdmacm: Reference count access to verbs context")
> Fixes(ucma_create_cqs):
> f8f1335ad8d8 ("librdmacm: make CQs optional for rdma_create_qp")
> 9e33488e8e50 ("librdmacm: fix all calls to set errno")
> Fixes(rdma_create_qp_ex):
> d2efdede11f7 ("r4019: Add support for userspace RDMA connection management abstraction (CMA)")
> 4e33a4109a62 ("librdmacm: returns errors from the library consistently")
> 995eb0c90c1a ("rdmacm: Add support for XRC QPs")
For every function, I am not sure which one is an exact commit so just
attach all related commits ids.

Best Regards,
Xiao Yang
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  librdmacm/cma.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/librdmacm/cma.c b/librdmacm/cma.c
> index 8c820ccf..a2575156 100644
> --- a/librdmacm/cma.c
> +++ b/librdmacm/cma.c
> @@ -635,7 +635,7 @@ static int ucma_get_device(struct cma_id_private *id_priv, __be64 guid,
>  	if (!cma_dev->pd)
>  		cma_dev->pd = ibv_alloc_pd(cma_dev->verbs);
>  	if (!cma_dev->pd) {
> -		ret = ERR(ENOMEM);
> +		ret = -1;
>  		goto out;
>  	}
>  
> @@ -1490,7 +1490,7 @@ static int ucma_create_cqs(struct rdma_cm_id *id, uint32_t send_size, uint32_t r
>  	return 0;
>  err:
>  	ucma_destroy_cqs(id);
> -	return ERR(ENOMEM);
> +	return -1;
>  }
>  
>  int rdma_create_srq_ex(struct rdma_cm_id *id, struct ibv_srq_init_attr_ex *attr)
> @@ -1662,7 +1662,7 @@ int rdma_create_qp_ex(struct rdma_cm_id *id,
>  		attr->srq = id->srq;
>  	qp = ibv_create_qp_ex(id->verbs, attr);
>  	if (!qp) {
> -		ret = ERR(ENOMEM);
> +		ret = -1;
>  		goto err1;
>  	}
>  



