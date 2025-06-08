Return-Path: <linux-rdma+bounces-11058-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F94AD11C1
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Jun 2025 11:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF673ABE90
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Jun 2025 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8A21FDA7B;
	Sun,  8 Jun 2025 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDH5tc60"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B086EEBB
	for <linux-rdma@vger.kernel.org>; Sun,  8 Jun 2025 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749376281; cv=none; b=Xqfj+9wIzJ8rNuyze3pqsfDcs/FKwe/JoajILuuZR1GiigmkO99TW644WQwiALzBg88c7g2wsIAVaR+PPQ55rq5jQsFVaxAoC1HZQrVR5GuzSGlNHq80GsRlH51aDjRqZpyca1u94+4mMSoRM0yUK5BiwhT3eBu49p9B7ADrRyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749376281; c=relaxed/simple;
	bh=NEEFQPSJ8v9v9NbusVTfiJsaNQd+UU5lDiCotJ8Ungw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VbJRec3dGNHTI1VJsgOg+mKyFNW+o26Mm7ABxas0LhhUfqIVADWBm/Z0fQmsCoIda63ALZJruKemAUD95UgvhNNg1GYzIyQMcGCWOoqOu0VB/s/Hj4Twq5QR/nDYusQZgys8HgXypibcYXSrnkgJIG4/baxxCEqDwa9kxBrCutE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDH5tc60; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234fcadde3eso41002325ad.0
        for <linux-rdma@vger.kernel.org>; Sun, 08 Jun 2025 02:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749376279; x=1749981079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pHDV2pMMz1S1FkRcZeZBsPlEKLkzy32eg4LCGtXYb3o=;
        b=RDH5tc60ETCDCEqjsr72Lvmei/yTF0JfPQKe0Hg48WKpSpB4uFNg7bosp/MUSKFuwZ
         aEAksHK2rRvZQV2W7cqPw98I7GE5jSDTHT+rM5rRT2XqY9msgDaD9PBacdyNeU6WHDEc
         /JwcF6l3eMbzP6fMHWkH16UBQ8EtdxH422QvndLQcfpKVRsZPbulyZGXwJe0LXRkcowR
         PxTjDfVMX/pSpE5peedVwWqBCtGOPmQFKo2Qx9i1jE6jc4vElho2huIUol6tTSAW9xUW
         3gJAiABXGKZj4DPe1KOfv8nKfxEAAX/cNf1qOXbtypdD8VDtYYUHdbF9kBJgYLX+Agyb
         rDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749376279; x=1749981079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHDV2pMMz1S1FkRcZeZBsPlEKLkzy32eg4LCGtXYb3o=;
        b=qHP8kCmn/mhLxs/7iJINE+o79QEnLYRMLNn3jSYFx/etZ2l+6sLyT6Y8aiEznn/OGh
         jLqBYhJDfG0GZ3HzbN9JNOHDEO4OVY5cK5vBguxxqQ6x7x9mg70fz75V0ZGq+ooa75LW
         oLWZXFiItjwA66cijVliI66weaT9+iGpJA7SYC41ShOFRzaCfKeY9gTaKdythjso1GQT
         xPgTAj+D00+7A72otnIYKY6UZFUJkmmzbqyk4+P57yrE7extNAZzgrUPv/jbHvNwH0+d
         HuzbVVKu3MfuDIBF8wUmTgnSd+BeFpf0uAeD8t2F/1jlBxG3awjWSPz4DBFnVqaRPPFu
         33zQ==
X-Gm-Message-State: AOJu0YxEXeuDMK+bKWS3F2oIhLa9ucwTz8ouQ70asdKSDqypW7Piya9R
	3BJSwkWYqTUYm6bjUnp61QSidJXxOWid4da3J8HeV0InHIAVw0EH25JL895Qlw==
X-Gm-Gg: ASbGncto8f9Cs5f9e9anuduBvX6Xsfmp1HhS/GACidX3XqCzivVtqdzPzDlK1bpN44m
	AKBjHSlvGxA7AlSExpWOdu0mlcIloo7K3seAOWEmcqBeZrTb3XOUc6AXzhiZlnR25IGzTKs4FKB
	6g45XvjHUt4jXd9txP0L6GjGE3HS4cvBC2cIQNEuasfwc7OfOf55lROQDSTNV89teLm658lKlKQ
	sgmzYzpH1O5aiLy+Ja5e0wDPZaFMuDI/xMcXJJ63IOAhsQFYxcMDam8eXKhAPqBMDJ+bq0W7qRr
	jgo/LsnwxTkh/vBCx3rxLF3uNAdwJ1HnOInbwOtNMGC5RtYBIHuaM/LlEaUaV9qr0l+ttLdLmxt
	HDSQjCCfALOlbrONfAQ8zZ6beK4k=
X-Google-Smtp-Source: AGHT+IHqNr9o5IkmbbkBM5jJ5WNcPIZRage11IvwC93Qo4HzZuWeRg/a3gXHLaykbJCgA/PfO/sI/w==
X-Received: by 2002:a17:902:db10:b0:235:f078:4746 with SMTP id d9443c01a7336-23601dc074emr122345645ad.42.1749376279388;
        Sun, 08 Jun 2025 02:51:19 -0700 (PDT)
Received: from [192.168.11.2] (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603092ed7sm37115715ad.86.2025.06.08.02.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jun 2025 02:51:19 -0700 (PDT)
Message-ID: <8a09c0e9-a25b-447c-b201-1b4b40674b99@gmail.com>
Date: Sun, 8 Jun 2025 18:51:16 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v1] RDMA/rxe: Remove redundant page presence
 check
To: linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com
References: <20250608093723.3132-1-dskmtsd@gmail.com>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <20250608093723.3132-1-dskmtsd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry, I mistakenly sent an intermediate work. Please ignore this one and see v2.

On 2025/06/08 18:37, Daisuke Matsuda wrote:
> hmm_pfn_to_page() does not return NULL. ib_umem_odp_map_dma_and_lock()
> should return an error in case the target pages cannot be mapped until
> timeout, so these checks can safely be removed.
> 
> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_odp.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index dbc5a5600eb7..fb88f2901c58 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -203,8 +203,6 @@ static int __rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
>   
>   		page = hmm_pfn_to_page(umem_odp->map.pfn_list[idx]);
>   		user_va = kmap_local_page(page);
> -		if (!user_va)
> -			return -EFAULT;
>   
>   		src = (dir == RXE_TO_MR_OBJ) ? addr : user_va;
>   		dest = (dir == RXE_TO_MR_OBJ) ? user_va : addr;
> @@ -286,8 +284,6 @@ static enum resp_states rxe_odp_do_atomic_op(struct rxe_mr *mr, u64 iova,
>   	idx = rxe_odp_iova_to_index(umem_odp, iova);
>   	page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
>   	page = hmm_pfn_to_page(umem_odp->map.pfn_list[idx]);
> -	if (!page)
> -		return RESPST_ERR_RKEY_VIOLATION;
>   
>   	if (unlikely(page_offset & 0x7)) {
>   		rxe_dbg_mr(mr, "iova not aligned\n");


