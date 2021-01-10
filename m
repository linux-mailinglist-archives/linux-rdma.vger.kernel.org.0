Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E9E2F06AF
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Jan 2021 12:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbhAJLh2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Jan 2021 06:37:28 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1490 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbhAJLh1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Jan 2021 06:37:27 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffae6cf0001>; Sun, 10 Jan 2021 03:36:47 -0800
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 10 Jan
 2021 11:36:47 +0000
Date:   Sun, 10 Jan 2021 13:36:43 +0200
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <jgg@nvidia.com>, <sagi@grimberg.me>, <oren@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH 2/3] IB/isert: remove unneeded semicolon
Message-ID: <20210110113643.GI31158@unreal>
References: <20210110111903.486681-1-mgurtovoy@nvidia.com>
 <20210110111903.486681-2-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210110111903.486681-2-mgurtovoy@nvidia.com>
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610278607; bh=FD+krmhqjjYit8+zMsgvPLanYKuN623MODLrjRKs6Xc=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy;
        b=n/h5YZJu+sMEyR1kBKS+vEWJ6CWBBomnm7tMyK2RWZ5kOw7/68NYkV8/slpr+UziP
         sdW3WKf4PuWhN/YDXrjLBfwpgX+9jM0ENv7C/ZMfpJlOGvyBV4X3EOBVLpRblQbDAL
         qNkP+nWUeu3jbAeQH33Guo4t9ebMECtISjal5i9YJag4lQnwMSAj/3hTRA7rtPLZ9d
         cntIC9SapQUhm6uGpCBEg09SaEzO5OYIGvWa+1pvTpiO5S8iAHQ4XvohnqYcuQ46Nf
         L4CPhvr04qDrao0p010x46b1fgSw3j4nehvuIQOKNTmlmIbUInWRKz8Q2m5EgniDz9
         P6D2eR6yVl6SA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 10, 2021 at 11:19:02AM +0000, Max Gurtovoy wrote:
> No need to add semicolon after closing bracket.
>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/infiniband/ulp/isert/ib_isert.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
> index 5958929b7dec..96514f675427 100644
> --- a/drivers/infiniband/ulp/isert/ib_isert.c
> +++ b/drivers/infiniband/ulp/isert/ib_isert.c
> @@ -1991,7 +1991,7 @@ isert_set_dif_domain(struct se_cmd *se_cmd, struct ib_sig_domain *domain)
>  	if (se_cmd->prot_type == TARGET_DIF_TYPE1_PROT ||
>  	    se_cmd->prot_type == TARGET_DIF_TYPE2_PROT)
>  		domain->sig.dif.ref_remap = true;
> -};
> +}

The same goes for iser_set_dif_domain() and iser_cleanup_handler().

Thanks

>
>  static int
>  isert_set_sig_attrs(struct se_cmd *se_cmd, struct ib_sig_attrs *sig_attrs)
> --
> 2.25.4
>
