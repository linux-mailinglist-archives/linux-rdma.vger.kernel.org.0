Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03453B6E51
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 08:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhF2Gji (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 02:39:38 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:49394 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhF2Gji (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Jun 2021 02:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1624948632; x=1656484632;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=WfbFWTI1JIn3aeCdAgZpb3BqKOBVJUAAvzLF22n+gOk=;
  b=pmBFmwLpTsfm12ehr0poPSFS6fFbQ13ot+hFIPehMS9jNGom7kFpwMas
   ZtuPD0kyOB1eFY6CM8fiZsSDjP1rlCNf1V8g2boE5NtUviBMycSSdco35
   gOVs0zLir5pSTAzJrQap7omr5PJZGwZjeR2/wqPTyYjpo31Pp69lcyvOg
   o=;
X-IronPort-AV: E=Sophos;i="5.83,308,1616457600"; 
   d="scan'208";a="142656408"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-1e-42f764a0.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 29 Jun 2021 06:37:05 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-42f764a0.us-east-1.amazon.com (Postfix) with ESMTPS id F37D4A9765;
        Tue, 29 Jun 2021 06:37:03 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.164) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Tue, 29 Jun 2021 06:37:00 +0000
Subject: Re: [PATCH 1/2] Update kernel headers
To:     Bob Pearson <rpearsonhpe@gmail.com>, <jgg@nvidia.com>,
        <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>
References: <20210628220535.10020-1-rpearsonhpe@gmail.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <45f33f25-d75e-5905-a2ce-bd62573a9a5e@amazon.com>
Date:   Tue, 29 Jun 2021 09:36:50 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628220535.10020-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.164]
X-ClientProxiedBy: EX13D10UWB001.ant.amazon.com (10.43.161.111) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 29/06/2021 1:05, Bob Pearson wrote:
> To commit ?? ("RDMA/rxe: Convert kernel UD post send to use ah_num").
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  kernel-headers/rdma/rdma_user_rxe.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
> index e283c222..e544832e 100644
> --- a/kernel-headers/rdma/rdma_user_rxe.h
> +++ b/kernel-headers/rdma/rdma_user_rxe.h
> @@ -98,6 +98,8 @@ struct rxe_send_wr {
>  			__u32	remote_qpn;
>  			__u32	remote_qkey;
>  			__u16	pkey_index;
> +			__u16	reserved;
> +			__u32	ah_num;
>  		} ud;
>  		struct {
>  			__aligned_u64	addr;
> @@ -148,7 +150,12 @@ struct rxe_dma_info {
>  
>  struct rxe_send_wqe {
>  	struct rxe_send_wr	wr;
> -	struct rxe_av		av;
> +	union {
> +		struct rxe_av av;
> +		struct {
> +			__u32		reserved[0];
> +		} ex;
> +	};
>  	__u32			status;
>  	__u32			state;
>  	__aligned_u64		iova;
> @@ -168,6 +175,11 @@ struct rxe_recv_wqe {
>  	struct rxe_dma_info	dma;
>  };
>  
> +struct rxe_create_ah_resp {
> +	__u32 ah_num;
> +	__u32 reserved;
> +};
> +
>  struct rxe_create_cq_resp {
>  	struct mminfo mi;
>  };
> 

I think the second patch didn't make it to the list.
