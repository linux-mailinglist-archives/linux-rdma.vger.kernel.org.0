Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2347189D05
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 14:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgCRNbO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 09:31:14 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41213 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgCRNbN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 09:31:13 -0400
Received: by mail-qk1-f193.google.com with SMTP id s11so27320823qks.8
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=GPKxR7olV5/T1T+od1GxMHemLMz8pRGQCdMpqt03qic=;
        b=FU7QQqy5x9gv96LM4XepCWfdFI2Q0WA/KCqokqiL78snHTZ9c+0AJR8YnQGEZVGeWn
         ceFHynbbvg3Llzj4g/ZgBnrp4rTfgSGCSItJpiljNNIxGzmUbUZ9QE6QwJQ4gLxhiBD1
         7TqxM9R9qqdVq1MUI7KYhhElL1wF2vj5jRH18pDWDmVkdXLbEAD596GV0zoQuOt6+8Qx
         wgfQcPh2TIC6yiTAWh4OKJz6tH9Z+k/wH5Pqd6PnG9nT9OUSXRD+RU7I9C65gZbANZfT
         ECC9eLe9+t48H95CShJvY5ezElS1v9ZTdQ9ARaEsJpdqgXOv6WSRN5w7ss9EDJzgUyLD
         Xxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GPKxR7olV5/T1T+od1GxMHemLMz8pRGQCdMpqt03qic=;
        b=Siu8eJYGIoBuRm/gMOTcI+Cs6DqegfaHkXO7Fi8OT/M2tIDLlHZBWFq1fIHfFgqjsF
         POYk9Kpb9YLKgNZvWrPNdO0H3PcC/QOL4MlhrEpllMoevmw5+JRE5nPtxt6ZXrEJhIMv
         gL4LdGZXwkEotJfMMw3FQ4ejVpjPDmcpmrImnmx6rg97H9HtaRi12Rfe2S6q7hGNktm6
         cRcPB/Ibzs2rpStl76sdgKFbsZNpMybQ/UIrrWGiQrK0DPf7eGaIVGhYTOtfd8Wm5L3k
         5k42JMrZPegF9FTnjsTwLrWotiGQ/JTTLvBQ9FEiDJfTK37wwjUGAMXnYMGO0lcOsZaa
         En6w==
X-Gm-Message-State: ANhLgQ2byxJYey2u0JhwXOq0GYHPnbm6FiaaThDSQB33CAyqRVwoZWtA
        qGKGLet48yJEOyjoj/12N/QFkg==
X-Google-Smtp-Source: ADFU+vtQrH3yS7LDafZaLJQxjijKlKJG01tSYCDrSkAXXm9LXdUOoNx9zB3AdihxGOMvUlNsmUV3Zw==
X-Received: by 2002:a37:a007:: with SMTP id j7mr3937351qke.73.1584538271554;
        Wed, 18 Mar 2020 06:31:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g7sm4371916qtu.38.2020.03.18.06.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 06:31:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jEYms-0006gQ-2L; Wed, 18 Mar 2020 10:31:10 -0300
Date:   Wed, 18 Mar 2020 10:31:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Insure security pkey modify is not lost
Message-ID: <20200318133110.GA25617@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313124704.14982.55907.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 13, 2020 at 08:47:05AM -0400, Mike Marciniszyn wrote:
> The following modify sequence (loosely based on ipoib) will
> lose a pkey modifcation:
> 
> - Modify (pkey index, port)
> - Modify (new pkey index, NO port)
> 
> After the first modify, the qp_pps list will have saved the pkey and the
> unit on the main list.
> 
> During the second modify, get_new_pps() will fetch the port from qp_pps
> and read the new pkey index from qp_attr->pkey_index.  The state will
> still be zero, or IB_PORT_PKEY_NOT_VALID. Because of the invalid state,
> the new values will never replace the one in the qp pps list, losing
> the new pkey.
> 
> This happens because the following if statements will never correct the
> state because the first term will be false. If the code had been executed,
> it would incorrectly overwrite valid values.
> 
> if ((qp_attr_mask & IB_QP_PKEY_INDEX) && (qp_attr_mask & IB_QP_PORT))
> 	new_pps->main.state = IB_PORT_PKEY_VALID;
> 
> 
> if (!(qp_attr_mask & (IB_QP_PKEY_INDEX | IB_QP_PORT)) && qp_pps) {
> 	new_pps->main.port_num = qp_pps->main.port_num;
> 	new_pps->main.pkey_index = qp_pps->main.pkey_index;
> 	if (qp_pps->main.state != IB_PORT_PKEY_NOT_VALID)
> 		new_pps->main.state = IB_PORT_PKEY_VALID;
> }
> 
> Fix by joining the two if statements with an or test to see if qp_pps
> is non-NULL and in the correct state.
> 
> Fixes: 1dd017882e01 ("RDMA/core: Fix protection fault in get_pkey_idx_qp_list")
> Reviewed-by: Kaike Wan <kaike.wan@intel.com>
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>

Leon? Maor?

> diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
> index 2d56083..75e7ec0 100644
> +++ b/drivers/infiniband/core/security.c
> @@ -349,16 +349,11 @@ static struct ib_ports_pkeys *get_new_pps(const struct ib_qp *qp,
>  	else if (qp_pps)
>  		new_pps->main.pkey_index = qp_pps->main.pkey_index;
>  
> -	if ((qp_attr_mask & IB_QP_PKEY_INDEX) && (qp_attr_mask & IB_QP_PORT))
> +	if (((qp_attr_mask & IB_QP_PKEY_INDEX) &&
> +	     (qp_attr_mask & IB_QP_PORT)) ||
> +	    (qp_pps && qp_pps->main.state != IB_PORT_PKEY_NOT_VALID))
>  		new_pps->main.state = IB_PORT_PKEY_VALID;
>  
> -	if (!(qp_attr_mask & (IB_QP_PKEY_INDEX | IB_QP_PORT)) && qp_pps) {
> -		new_pps->main.port_num = qp_pps->main.port_num;
> -		new_pps->main.pkey_index = qp_pps->main.pkey_index;
> -		if (qp_pps->main.state != IB_PORT_PKEY_NOT_VALID)
> -			new_pps->main.state = IB_PORT_PKEY_VALID;
> -	}
> -
>  	if (qp_attr_mask & IB_QP_ALT_PATH) {
>  		new_pps->alt.port_num = qp_attr->alt_port_num;
>  		new_pps->alt.pkey_index = qp_attr->alt_pkey_index;
> 
