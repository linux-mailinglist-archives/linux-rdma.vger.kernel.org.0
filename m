Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D289147498E
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Dec 2021 18:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbhLNRen (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Dec 2021 12:34:43 -0500
Received: from p3plsmtpa08-03.prod.phx3.secureserver.net ([173.201.193.104]:58494
        "EHLO p3plsmtpa08-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229755AbhLNRen (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Dec 2021 12:34:43 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Dec 2021 12:34:43 EST
Received: from [192.168.0.100] ([98.118.115.249])
        by :SMTPAUTH: with ESMTPSA
        id xBaGmBwFwGjADxBaGmMzyz; Tue, 14 Dec 2021 10:27:25 -0700
X-CMAE-Analysis: v=2.4 cv=J41vUCrS c=1 sm=1 tr=0 ts=61b8d3fd
 a=T+zzzuy42cdAS+8Djmhmkg==:117 a=T+zzzuy42cdAS+8Djmhmkg==:17
 a=IkcTkHD0fZMA:10 a=OLL_FvSJAAAA:8 a=y4GNfeEy-qj0uYrA3CwA:9 a=QEXdDO2ut3YA:10
 a=hElz_HbCIN8A:10 a=VbPY3t8NEt0A:10 a=oIrB72frpwYPwTMnlWqB:22
X-SECURESERVER-ACCT: tom@talpey.com
Message-ID: <b80a409d-3404-75d2-449e-7b8f41296f26@talpey.com>
Date:   Tue, 14 Dec 2021 12:27:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/1] RDMA/irdma: Make the source udp port vary
Content-Language: en-US
To:     yanjun.zhu@linux.dev, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
References: <20211214054227.1071338-1-yanjun.zhu@linux.dev>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20211214054227.1071338-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJdoM+OPCW3yXZbwt26IZHsoMv1sfr4criIMr1/wb7VMjUQnXWtmUdNQ/kTJ8ZJL+2QIisqyCs6sCzzTBvKxapVUxCry6aPO1Eb7Vm++kSvAiC351yDX
 sZjPm75WuTiIY1JDQMXazLuAXo673lzI8cUW7fxlKlOKeG810yzXu2mc5yf6DbmiAWzkyRWSPjBkwlUlLOODYknon5kwYdRzGNjxHXh0MmF2bZWgrZH6jM3p
 Lsu8NAuFYEYhJyRsQTkdVukY/cVTxv6iMelvVSd0QPRGCxGankPZauCvxdDozUeOk1owJFXMmPX1w1NIdFAtR/Q+A7r9/xiDEdeBvbeS6T/T+xNAASwCVUO/
 Y51bEkjh
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/14/2021 12:42 AM, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Based on the link https://www.spinics.net/lists/linux-rdma/msg73735.html,
> get the source udp port number for a QP based on the local QPN. This
> provides a better spread of traffic across NIC RX queues.  The method in
> the commit d3c04a3a6870 ("IB/rxe: vary the source udp port for receive
> scaling") is stable. So it is also adopted in this commit.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>   drivers/infiniband/hw/irdma/verbs.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index 102dc9342f2a..2697b40a539e 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -690,6 +690,11 @@ static int irdma_cqp_create_qp_cmd(struct irdma_qp *iwqp)
>   	return status ? -ENOMEM : 0;
>   }
>   
> +static inline u16 irdma_get_src_port(struct irdma_qp *iwqp)
> +{
> +	return 0xc000 + (hash_32_generic(iwqp->ibqp.qp_num, 14) & 0x3fff);
> +}

How do you ensure the resulting port number is not already in use?

Tom.

> +
>   static void irdma_roce_fill_and_set_qpctx_info(struct irdma_qp *iwqp,
>   					       struct irdma_qp_host_ctx_info *ctx_info)
>   {
> @@ -703,7 +708,7 @@ static void irdma_roce_fill_and_set_qpctx_info(struct irdma_qp *iwqp,
>   	udp_info->cwnd = iwdev->roce_cwnd;
>   	udp_info->rexmit_thresh = 2;
>   	udp_info->rnr_nak_thresh = 2;
> -	udp_info->src_port = 0xc000;
> +	udp_info->src_port = irdma_get_src_port(iwqp);
>   	udp_info->dst_port = ROCE_V2_UDP_DPORT;
>   	roce_info = &iwqp->roce_info;
>   	ether_addr_copy(roce_info->mac_addr, iwdev->netdev->dev_addr);
