Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293F1408950
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 12:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbhIMKsH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 06:48:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238610AbhIMKsH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 06:48:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D489360F6F;
        Mon, 13 Sep 2021 10:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631530011;
        bh=vXqsFzqSR/PQsX8BEkVhWdCA4DjRFthznHcEH33YIrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IJKLFMcwjPIfzsUeNXuqP+DdMBX5Pu+e0E2UdS8IfDSMgwxZWciTggQnU/YCeSd5b
         W1s3xV8P5Pdq4BhqVr/vAT/KoqCmIR/Ih5hHcKkOfeYH7hFBZJwyKDv/y2UfeeUNAf
         iD5nwoqrfXS7jJHGosjcZgwLunINuTs3j774fl6+SrrJDZAjZXlo4X7dKUv3ItaMjG
         T2CepzlBtNhl193ym7k8cXgBb4a160paFks+HixvP9BLChhOsDl00Gnz8UAzHnaEqq
         bLUdFu312wON/IbfuAmoFXTL7/Dw1GWEXlZKI1jya4plskqnpYUjvZkvNv/E7lNyp2
         5QTZA4LCSc1Pg==
Date:   Mon, 13 Sep 2021 13:46:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        Edwin Peer <edwin.peer@broadcom.com>
Subject: Re: [PATCH for-next 03/12] RDMA/bnxt_re: Use separate response
 buffer for stat_ctx_free
Message-ID: <YT8sF+I8UNX79pQS@unreal>
References: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
 <1631470526-22228-4-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631470526-22228-4-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 12, 2021 at 11:15:17AM -0700, Selvin Xavier wrote:
> From: Edwin Peer <edwin.peer@broadcom.com>
> 
> Use separate buffers for the request and response data. Eventhough
> the response data is not used, providing the correct length is
> appropriate.
> 
> Signed-off-by: Edwin Peer <edwin.peer@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index e4f39d8..4214674 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -525,7 +525,8 @@ static int bnxt_re_net_stats_ctx_free(struct bnxt_re_dev *rdev,
>  				      u32 fw_stats_ctx_id)
>  {
>  	struct bnxt_en_dev *en_dev = rdev->en_dev;
> -	struct hwrm_stat_ctx_free_input req = {0};
> +	struct hwrm_stat_ctx_free_input req = {};
> +	struct hwrm_stat_ctx_free_output resp = {};
>  	struct bnxt_fw_msg fw_msg;
>  	int rc = -EINVAL;
>  
> @@ -539,8 +540,8 @@ static int bnxt_re_net_stats_ctx_free(struct bnxt_re_dev *rdev,
>  
>  	bnxt_re_init_hwrm_hdr(rdev, (void *)&req, HWRM_STAT_CTX_FREE, -1, -1);
>  	req.stat_ctx_id = cpu_to_le32(fw_stats_ctx_id);
> -	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&req,
> -			    sizeof(req), DFLT_HWRM_CMD_TIMEOUT);
> +	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
> +			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);

As far as I remember, you don't need to cast to void.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
