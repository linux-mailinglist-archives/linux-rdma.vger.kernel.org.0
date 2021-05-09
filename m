Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12610377642
	for <lists+linux-rdma@lfdr.de>; Sun,  9 May 2021 12:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhEIKvM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 May 2021 06:51:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhEIKvL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 9 May 2021 06:51:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0653461424;
        Sun,  9 May 2021 10:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620557408;
        bh=GngOjC6k8lCrzwT8wRaDWgh3sX8bZvsp0XPX4FZfRwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ullut+s0iLthN42nUHHKrYyZX5dOhD54zy6JuX4/ylmlKkwbfBiNEJ9Naasw3KW4U
         j7C+uxZGpjRNoMfeeBRaCKvZSmZIFcVlwbcYZfaANMn2j4NLNU7dV5op5w1PqW+N47
         9m0T7WE0FzgMd1iExBlIGHPE2t9yPnpJsO3JGfdUsPo8wm2B/X9YvKMuYt83PwCidL
         35N99+h9mzJnf0A6HBBvPytOCEsfU39pBXBmNpiTGz49DHWx88WtmCF6GQTkS0dVnf
         Ql38tD580+v96lNvBYKKeBZGgkBc9SVKGhjV+QnjF7Xb067OS+4Okt2CkB+Zv1t0/r
         csoO9HwVYzunw==
Date:   Sun, 9 May 2021 13:50:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Wei Ming Chen <jj251510319013@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] i40iw: Use fallthrough pseudo-keyword
Message-ID: <YJe+XDO5PEr4SF0l@unreal>
References: <20210509083135.14575-1-jj251510319013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210509083135.14575-1-jj251510319013@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 09, 2021 at 04:31:35PM +0800, Wei Ming Chen wrote:
> Add pseudo-keyword macro fallthrough[1]
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> 
> Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw_ctrl.c | 1 +
>  drivers/infiniband/hw/i40iw/i40iw_uk.c   | 1 +
>  2 files changed, 2 insertions(+)

What exactly are you fixing?
"case" without any code doesn't need "fallthrough".

Thanks

> 
> diff --git a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
> index eaea5d545eb8..c6081283217c 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
> +++ b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
> @@ -2454,6 +2454,7 @@ static enum i40iw_status_code i40iw_sc_qp_init(struct i40iw_sc_qp *qp,
>  			return ret_code;
>  		break;
>  	case 5: /* fallthrough until next ABI version */
> +		fallthrough;
>  	default:
>  		if (qp->qp_uk.max_rq_frag_cnt > I40IW_MAX_WQ_FRAGMENT_COUNT)
>  			return I40IW_ERR_INVALID_FRAG_COUNT;
> diff --git a/drivers/infiniband/hw/i40iw/i40iw_uk.c b/drivers/infiniband/hw/i40iw/i40iw_uk.c
> index f521be16bf31..e1c318c291c0 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_uk.c
> +++ b/drivers/infiniband/hw/i40iw/i40iw_uk.c
> @@ -1004,6 +1004,7 @@ enum i40iw_status_code i40iw_qp_uk_init(struct i40iw_qp_uk *qp,
>  			i40iw_get_wqe_shift(info->max_rq_frag_cnt, 0, &rqshift);
>  			break;
>  		case 5: /* fallthrough until next ABI version */
> +			fallthrough;
>  		default:
>  			rqshift = I40IW_MAX_RQ_WQE_SHIFT;
>  			break;
> -- 
> 2.25.1
> 
