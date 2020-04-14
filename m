Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8497F1A7B7F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2020 14:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502420AbgDNM4G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Apr 2020 08:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2502414AbgDNM4D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Apr 2020 08:56:03 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE08C061A0C
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 05:56:03 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id l60so1511912qtd.8
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 05:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kCnX2dOhqYjGf3FtyAfGCW1zCep3q//ATTdnzuez92s=;
        b=bfMyuvL1DxcHRzuck7wusCS/uUaV/6hqiCm4L+SQfCcj580yfKsSNfi4sS131U0200
         yT3zrt/MIUyP01r79+S8v6NKIlc24dSXRSMCN2+ps/DRaX2/SeImeqEfgcc30U+HCQhF
         H59CEVw4VCnNq3+g1fSXXqLeFFjq67E5n4rXhLXvmn6xgVHDh55Wt36xsfgbYtNF9ZA1
         NOzIcWCe1reLT2Rf+1AC85IXlT5eSb1wALgdS4X6RaKpBz9RgifasRm+sGcUaGvYBvRf
         UNNm55tIzQPa6zKdgrTFXLHiaGxvcIDg36iYsT3CjPbC4Uo8CIjv3S7sJEk6BIvi4z29
         yU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kCnX2dOhqYjGf3FtyAfGCW1zCep3q//ATTdnzuez92s=;
        b=L+EvjfQB5d13/b02fnajMQDq47yss9ID+pDq4JlBN/B87sqOBTdZRgX0sThfQxqpmt
         3oyixLMA4afbxwlh8WRB9OPtsR6VW6XuQrj6kCDsOr+9Mf4IcJAfDCvYGCh4U8Kocmy8
         dkPn378tlJBJKGIpW/obW6QG2XabiuNapvS1Y3fm9tgWoN0jFdey4s+kWcraSoLun2L1
         refMYgMOXdJG9tHQZKctLpnCJV4iAG3ZSA0JdrA70XagwM2RyoRDVDyoHWFGGlPYaI/Q
         8XWkyT0zxsSKPgGMWqKqwGNzoCzRETEHF2xrLzJtGBtPsfGhxvzQ6edWWK/MMGAfG9Ij
         bMaA==
X-Gm-Message-State: AGi0PubiX+CwAy33YgVOtLcgHupYqsNIbOO1+FUGikwMYD2VIF9HKh97
        PAbRbSdnqaaFgEJ5ociJfd9TNw==
X-Google-Smtp-Source: APiQypIGIpzb2v6xvvmYZ4gR9G0mHE72nNFw69gdj3/KrstGhaYJPLGXneVf3b7EbUpUFtij+FBAwg==
X-Received: by 2002:aed:3bf7:: with SMTP id s52mr15995805qte.362.1586868962015;
        Tue, 14 Apr 2020 05:56:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id q13sm10283305qki.136.2020.04.14.05.56.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 05:56:01 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jOL6e-0004Ia-U6; Tue, 14 Apr 2020 09:56:00 -0300
Date:   Tue, 14 Apr 2020 09:56:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 3/6] RDMA/hns: Simplify the qp state convert code
Message-ID: <20200414125600.GB5100@ziepe.ca>
References: <1586760042-40516-1-git-send-email-liweihang@huawei.com>
 <1586760042-40516-4-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586760042-40516-4-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 13, 2020 at 02:40:39PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> Use type map table to reduce the cyclomatic complexity.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 6816278..e938bd8 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -4540,19 +4540,20 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
>  	return ret;
>  }
>  
> -static inline enum ib_qp_state to_ib_qp_st(enum hns_roce_v2_qp_state state)
> -{
> -	switch (state) {
> -	case HNS_ROCE_QP_ST_RST:	return IB_QPS_RESET;
> -	case HNS_ROCE_QP_ST_INIT:	return IB_QPS_INIT;
> -	case HNS_ROCE_QP_ST_RTR:	return IB_QPS_RTR;
> -	case HNS_ROCE_QP_ST_RTS:	return IB_QPS_RTS;
> -	case HNS_ROCE_QP_ST_SQ_DRAINING:
> -	case HNS_ROCE_QP_ST_SQD:	return IB_QPS_SQD;
> -	case HNS_ROCE_QP_ST_SQER:	return IB_QPS_SQE;
> -	case HNS_ROCE_QP_ST_ERR:	return IB_QPS_ERR;
> -	default:			return -1;
> -	}
> +static int to_ib_qp_st(enum hns_roce_v2_qp_state state)
> +{
> +	const enum ib_qp_state map[] = {

Should be static

Jason
