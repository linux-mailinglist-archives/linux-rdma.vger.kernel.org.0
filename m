Return-Path: <linux-rdma+bounces-15062-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51142CCA10C
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 03:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BBF8301D585
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 02:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA222F5331;
	Thu, 18 Dec 2025 02:16:20 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-m49208.qiye.163.com (mail-m49208.qiye.163.com [45.254.49.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0878A285419;
	Thu, 18 Dec 2025 02:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766024180; cv=none; b=QVA1hL4pVu5UVCUH31Yc2pWlFs34oObTYWl6rwNUf14/5NTPfX8Cl45f2/KINmzHsWIGuewnDd1MVMuTGzD/m4sCamitpJVCpb20uKs0vaCRwDqIAMz9Qzz8zQpll578/usd0EtjHCNEh3G8cOCPTjJ9BwocWbWMdcotlOM67gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766024180; c=relaxed/simple;
	bh=r0tAt0Q+hwWm6ntETI8t4DAHnIMp8PQ6OaYJKpf5CUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jh1NZytfhwQsrlWFWBM8fi/BGJJUVnFZuCCaBR7nWsD3K+F0RRxfcwfid8R+P6dQDKLuSXORkDOHULTLGt49ijz6FnEtNc4YdoTL8NY2IuzBbwGEDChxRWLJSxfXMpMJ7lmwEhpbXPDwbG2wxQOnyC94Tc4MptK1kyKu2313DOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn; spf=pass smtp.mailfrom=sangfor.com.cn; arc=none smtp.client-ip=45.254.49.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from [172.23.68.66] (unknown [43.247.70.80])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dabaf0bb;
	Thu, 18 Dec 2025 10:16:03 +0800 (GMT+08:00)
Message-ID: <022b32b6-6ed5-465d-af01-a52deea16d62@sangfor.com.cn>
Date: Thu, 18 Dec 2025 10:16:02 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] RDMA/bnxt_re: Fix OOB write in
 bnxt_re_copy_err_stats()
To: selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
 jgg@ziepe.ca, leon@kernel.org, saravanan.vajravel@broadcom.com,
 vasuthevan.maheswaran@broadcom.com
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhengyingying@sangfor.com.cn
References: <20251208072110.28874-1-dinghui@sangfor.com.cn>
Content-Language: en-US
From: Ding Hui <dinghui@sangfor.com.cn>
In-Reply-To: <20251208072110.28874-1-dinghui@sangfor.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9b2f3e311009d9kunm77d2462c672470
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZThgYVklCHhkfTEhISxlJTVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlPSFVJT0xVTEtVQ0tZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
	pCS0tZBg++

Friendly ping.

On 2025/12/8 15:21, Ding Hui wrote:
> Recently we encountered an OOB write issue on BCM957414A4142CC with outbox
> NetXtreme-E-235.1.160.0 driver from broadcom. After a litte research,
> we found the inbox driver from upstream maybe have the same issue.
> 
> The commit ef56081d1864 ("RDMA/bnxt_re: RoCE related hardware counters
> update") introduced 3 counters, and appended after BNXT_RE_OUT_OF_SEQ_ERR.
> 
> However, BNXT_RE_OUT_OF_SEQ_ERR serves as a boundary marker for allocating
> hw stats with different num_counters for chip_gen_p5_p7 hardware.
> 
> For BNXT_RE_NUM_STD_COUNTERS allocated hw_stats, leading to an
> out-of-bounds write in bnxt_re_copy_err_stats().
> 
> It seems like that the BNXT_RE_REQ_CQE_ERROR, BNXT_RE_RESP_CQE_ERROR,
> and BNXT_RE_RESP_REMOTE_ACCESS_ERRS can be updated for generic hardware,
> not only for p5/p7 hardware.
> 
> Fix this by moving them before BNXT_RE_OUT_OF_SEQ_ERR so they become
> part of the generic counter.
> 
> Compile tested only.
> 
> Fixes: ef56081d1864 ("RDMA/bnxt_re: RoCE related hardware counters update")
> Reported-by: Yingying Zheng <zhengyingying@sangfor.com.cn>
> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> ---
>   drivers/infiniband/hw/bnxt_re/hw_counters.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.h b/drivers/infiniband/hw/bnxt_re/hw_counters.h
> index 09d371d442aa..cebec033f4a0 100644
> --- a/drivers/infiniband/hw/bnxt_re/hw_counters.h
> +++ b/drivers/infiniband/hw/bnxt_re/hw_counters.h
> @@ -89,6 +89,9 @@ enum bnxt_re_hw_stats {
>   	BNXT_RE_RES_SRQ_LOAD_ERR,
>   	BNXT_RE_RES_TX_PCI_ERR,
>   	BNXT_RE_RES_RX_PCI_ERR,
> +	BNXT_RE_REQ_CQE_ERROR,
> +	BNXT_RE_RESP_CQE_ERROR,
> +	BNXT_RE_RESP_REMOTE_ACCESS_ERRS,
>   	BNXT_RE_OUT_OF_SEQ_ERR,
>   	BNXT_RE_TX_ATOMIC_REQ,
>   	BNXT_RE_TX_READ_REQ,
> @@ -110,9 +113,6 @@ enum bnxt_re_hw_stats {
>   	BNXT_RE_TX_CNP,
>   	BNXT_RE_RX_CNP,
>   	BNXT_RE_RX_ECN,
> -	BNXT_RE_REQ_CQE_ERROR,
> -	BNXT_RE_RESP_CQE_ERROR,
> -	BNXT_RE_RESP_REMOTE_ACCESS_ERRS,
>   	BNXT_RE_NUM_EXT_COUNTERS
>   };
>   

-- 
Thanks,
- Ding Hui


