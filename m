Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23442408994
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 12:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239306AbhIMK5I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 06:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238516AbhIMK5H (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 06:57:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F4A061004;
        Mon, 13 Sep 2021 10:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631530552;
        bh=RJDEvBVtpPw57JCtwdInS2rLpe82CwwiKiHmRhYADWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pvNXMP2oUL7l9bB7U8oWxkQUtg7IpvSCSCTCDuHkpYb1Cl3c5NiMPEf9sJpLrPUNC
         eiz/NSCNfkphypN33zIT0kaeelJHymOU5Gfx20/MKhLTdEqUL5wJRpo67V7UHhtwBW
         ES0XF1C5g24dAIRuDbYEU7ksi6p4tU1SddBEy13uE3YNKsILVDqJVWesh1vJ/3ZcT0
         4bXfyzy4VgvCAmDVoK00FFOHZsLT24jm4KQc/mJTwTel82TJRTm8fOfSoFl9Rw3BkN
         BLU8s3/zAIyUKtPmmLNEJW7tWiJLyYBawLhQL9B3e0W6pa6lOqsAyDVa1jyizC3hjg
         5wHWqjGj6Qq1g==
Date:   Mon, 13 Sep 2021 13:55:48 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 07/12] RDMA/bnxt_re: Fix query SRQ failure
Message-ID: <YT8uNPMzuLsBlOTd@unreal>
References: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
 <1631470526-22228-8-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631470526-22228-8-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 12, 2021 at 11:15:21AM -0700, Selvin Xavier wrote:
> Fill the missing parameters for the FW command while
> querying SRQ.
> 
> Fixes: 37cb11acf1f7 ("RDMA/bnxt_re: Add SRQ support for Broadcom adapters")
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> index 539b1a2..e2926dd 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> @@ -713,6 +713,8 @@ int bnxt_qplib_query_srq(struct bnxt_qplib_res *res,
>  	sbuf = bnxt_qplib_rcfw_alloc_sbuf(rcfw, sizeof(*sb));
>  	if (!sbuf)
>  		return -ENOMEM;
> +	req.resp_size = sizeof(*sb) / BNXT_QPLIB_CMDQE_UNITS;
> +	req.srq_cid = cpu_to_le32(srq->id);

You already have this line.

   698 int bnxt_qplib_query_srq(struct bnxt_qplib_res *res,
   699                          struct bnxt_qplib_srq *srq)
   700 {
   ...
   708
   709         RCFW_CMD_PREP(req, QUERY_SRQ, cmd_flags);
   710         req.srq_cid = cpu_to_le32(srq->id);


>  	sb = sbuf->sb;
>  	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
>  					  (void *)sbuf, 0);
> -- 
> 2.5.5
> 
