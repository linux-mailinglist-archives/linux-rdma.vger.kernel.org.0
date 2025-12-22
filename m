Return-Path: <linux-rdma+bounces-15139-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B463CCD4D86
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 08:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B411300C0F4
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 07:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84393306490;
	Mon, 22 Dec 2025 07:09:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-m49241.qiye.163.com (mail-m49241.qiye.163.com [45.254.49.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A573C27B349;
	Mon, 22 Dec 2025 07:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766387381; cv=none; b=fgIt+T2CsybD96nrFXOkdJrJs2toOhlkVyybX+FMVHkD3+O8UcVTJUvR17PUT+Y0kr9bVQw5e7flIKWBwzeoeFQS+otEqR8RRNShosLgYLpGzoc+KuhnEZsSfMIO/JpdPae9vwc64IdKYsRKrIlDRJlLRRhzlH+OzBnkk6ISr3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766387381; c=relaxed/simple;
	bh=Wdt/tpIJGImroIGfuNWG/Wqs60j5AyvnZXDAhdxdS6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xgov7s4NjIZq0O2uZ9vd9DzRVyZX1VdPfhu0ASvGiglXgvEwmOdbgbB8C19olc3Q1jg/Au4pyRGi6FUR1a2uiSMJkCZMMrDaSdPvVCxVVoPMkAAtqb34ZtHR+22Ljcr0Dg3stjmkXIOIVGtfVE5lTC7JttOs6wwXoGtEIoPA/6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn; spf=pass smtp.mailfrom=sangfor.com.cn; arc=none smtp.client-ip=45.254.49.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from [172.23.68.66] (unknown [43.247.70.80])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2e174c524;
	Mon, 22 Dec 2025 14:34:00 +0800 (GMT+08:00)
Message-ID: <51ecb35a-4caf-43c6-b5ac-bc4b94462577@sangfor.com.cn>
Date: Mon, 22 Dec 2025 14:33:59 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] RDMA/bnxt_re: Fix OOB write in
 bnxt_re_copy_err_stats()
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: selvin.xavier@broadcom.com, jgg@ziepe.ca, leon@kernel.org,
 saravanan.vajravel@broadcom.com, vasuthevan.maheswaran@broadcom.com,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhengyingying@sangfor.com.cn
References: <20251208072110.28874-1-dinghui@sangfor.com.cn>
 <CAH-L+nMzQ9Xcm0WukZjJM4owJ5+wXoF31arRxPs=5-k=Y5LQfQ@mail.gmail.com>
Content-Language: en-US
From: Ding Hui <dinghui@sangfor.com.cn>
In-Reply-To: <CAH-L+nMzQ9Xcm0WukZjJM4owJ5+wXoF31arRxPs=5-k=Y5LQfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b44c3c90e09d9kunmf60c7e3a9bdfc7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQkwfVk4fSkgfSk0fTB8eSFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlPSFVJT0xVTEtVQ0tZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
	pCS0tZBg++

On 2025/12/21 23:47, Kalesh Anakkur Purayil wrote:
> On Mon, Dec 8, 2025 at 12:52 PM Ding Hui <dinghui@sangfor.com.cn> wrote:
>>
>> Recently we encountered an OOB write issue on BCM957414A4142CC with outbox
>> NetXtreme-E-235.1.160.0 driver from broadcom. After a litte research,
>> we found the inbox driver from upstream maybe have the same issue.
>>
>> The commit ef56081d1864 ("RDMA/bnxt_re: RoCE related hardware counters
>> update") introduced 3 counters, and appended after BNXT_RE_OUT_OF_SEQ_ERR.
>>
>> However, BNXT_RE_OUT_OF_SEQ_ERR serves as a boundary marker for allocating
>> hw stats with different num_counters for chip_gen_p5_p7 hardware.
>>
>> For BNXT_RE_NUM_STD_COUNTERS allocated hw_stats, leading to an
>> out-of-bounds write in bnxt_re_copy_err_stats().
>>
>> It seems like that the BNXT_RE_REQ_CQE_ERROR, BNXT_RE_RESP_CQE_ERROR,
>> and BNXT_RE_RESP_REMOTE_ACCESS_ERRS can be updated for generic hardware,
>> not only for p5/p7 hardware.
>>
>> Fix this by moving them before BNXT_RE_OUT_OF_SEQ_ERR so they become
>> part of the generic counter.
>>
>> Compile tested only.
>>
>> Fixes: ef56081d1864 ("RDMA/bnxt_re: RoCE related hardware counters update")
>> Reported-by: Yingying Zheng <zhengyingying@sangfor.com.cn>
>> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> 
> Thank you Ding, the fix looks good to me and I have verified it locally.
> 

Thanks for confirming.

Do I need to resend the patch without RFC prefix and update some commit log,
such as getting rid of the first paragraph about the outbox driver?

> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Tested-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 

-- 
Thanks,
- Ding Hui


