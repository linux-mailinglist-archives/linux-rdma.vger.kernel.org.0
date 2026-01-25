Return-Path: <linux-rdma+bounces-15955-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCHaLFy8dWnFIAEAu9opvQ
	(envelope-from <linux-rdma+bounces-15955-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 07:46:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DC07FE77
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 07:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CD41300E39A
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 06:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D68231691B;
	Sun, 25 Jan 2026 06:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZngNz8Zf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1576922E3E7
	for <linux-rdma@vger.kernel.org>; Sun, 25 Jan 2026 06:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769323582; cv=none; b=qiUsabPTyWClVpdNKOSvzMX1oJ5WclUFZ+CKfGRyZSSLDtzqxHbTw2jSDGykBthWLEPaT+vZcI6pmHmRTpTTcziCRSXlNaQAcBTrKDpaMHTdcR9+0vzSOMkqlFQYIy39EF8ECbMIUSmvGLbHPlzva7c5bwTOgGhia4FP9yOeHXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769323582; c=relaxed/simple;
	bh=LDOrL8XlWQvOL0JePynnRBgKzjJjjdkMvGsbnlKQOGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7UQ2X3o3InjE7ftWmzqxJlLEQRWiB1cqU+7b7mqTFKfkmH2XRNomGLE0NxwFsKMa8ye6rc3VI3OfBXzR2I5XAHVXiva3YOxxHUTyZU9Bkpuo/riuu3bAdwbF9blzrAqd7/WHu6ARTtUPtQ2/w9DQZsCPpnk2SOcgD9dP7Vsf3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZngNz8Zf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4801d98cf39so25538945e9.1
        for <linux-rdma@vger.kernel.org>; Sat, 24 Jan 2026 22:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769323578; x=1769928378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LUe25BLM5rjKQ7ExOwmVjq1ZKK3cmoNWIWE22T5uU3Y=;
        b=ZngNz8ZfORwY6BSQOfqICrj9sedgpqqyBdrdNajPFEMUBWVmLRM5pqPoVMd6/FKK/L
         UyOcZrsoOolKYFDVGeRcITz9lPBl0W6fs2vSSe7rWF/93pjjU+tSE/QbNkM5+CYh3F8v
         puVcOvYH0Czc01YZ0AYqsZQ8N5iQP93BbG9lC3UknBEpXeS7PEmBXXt3qC9FlcGv5h1f
         7bO+RNJmhoSAmQX/mVtO/uMmJSX2nvfiLwJ9BMZMoftp/y8VENO1kMh4xXChtVuq4tKC
         5rmTnthmawio9NCCeL5GoYcpQjwFLPcAKXkMhLT+cXLip2fJRYIM7OcBpsDua9fCyALk
         2Qdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769323578; x=1769928378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUe25BLM5rjKQ7ExOwmVjq1ZKK3cmoNWIWE22T5uU3Y=;
        b=J2sWCwRXQLByNf8cZD/+LgAj6nTcpbJyKmff65joAYuoiZRj+oqdEaVgkMEh42DEbW
         HKVdnlE+wbvs4GIX1s8Sb2NjouSmQagGLfjIoHjlo9pLAUWq21P1AxubULClWlucsLLb
         faeg70t6KHoS6IwkuMZmXexDEjZfhV4y0b3LnUXk8+EamaQjf6JNtG7p9Opyh9AHbJ7/
         x3FHo8YsLVj476av79LX0F+jFjSx3fnHGPQDwqtHG1Tz73lp5VTJxaI6acC3figycWq2
         8V7joKSSp09R7CE2Gg1WteJ2kes1ew3hmSjBlx26gztmksVV6DQWapqePoRmVzS80BGY
         +/Rw==
X-Forwarded-Encrypted: i=1; AJvYcCW79G0mqZyKEiA28prmhKkDWP96tehZzWaYVOp81vEL1tb52L/Lik4PjABVKuzG2T+BY174Rw97Oqax@vger.kernel.org
X-Gm-Message-State: AOJu0YxZXdzSoCpnC8YZ0EVjqClXfbqntUuVKzdY+8g5yoYa//MP7JkO
	/kk8U9RrDCABbLPWrYP4YrV/ZqRYFPKKQU899HRIQ0v1mBkgeAt2bSfl
X-Gm-Gg: AZuq6aJ+NisQmDFg2V5IF1iISgULRGW/KPuANwFkF+1vGPZsCHOh2ubLKgpl5yMOtjr
	YUAINFCeZE7G8UBQueg1fAACJZdsMX2zTzDrDliese6cpQiw/ZucP3KXTMVtt3QimPgAL2ZdB0+
	RY8qezOVRARxnoy/HxhSI71fYHq/B8SQDvlaox5440b3tVBisSB9iwX2Kf3pT7P9PrO4ByxQjF8
	ghunIM8c6WED1WBWr9v9EYeTZY2L64/OaRRdhVeet34xi4Mn/p/AG5iIn+pFVCn3bjvdD0D8nT2
	dLnitRHpn98HV5rOcq0SNdMwqUVu4yX1VKke8xSdtYdeVcB7OMvEhhB8snA0UGjAzhZOXCl8+Vq
	g18lohM3oz6zetFRkzQHUYHRMJMEWiXOKCvu1W7NhoWp8BML+d6P+vYbK+QEXzdYjFsio7cff/3
	Gy5xHy2v5xd8FWTFujqoQaQxW79UZYrLQn7Tc=
X-Received: by 2002:a05:600c:621a:b0:47a:81b7:9a20 with SMTP id 5b1f17b1804b1-4805ce42517mr13353345e9.9.1769323578100;
        Sat, 24 Jan 2026 22:46:18 -0800 (PST)
Received: from [10.221.200.179] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804dbd4630sm65540735e9.17.2026.01.24.22.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jan 2026 22:46:17 -0800 (PST)
Message-ID: <56f850d0-efbe-462d-9034-d1c11453cff2@gmail.com>
Date: Sun, 25 Jan 2026 08:46:23 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net] net/mlx5: Fix return type mismatch in
 mlx5_esw_vport_vhca_id()
To: Zeng Chi <zeng_chi911@163.com>, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, mbloch@nvidia.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, feliu@nvidia.com, parav@nvidia.com, witu@nvidia.com,
 ajayachandra@nvidia.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zeng Chi <zengchi@kylinos.cn>
References: <20260123085749.1401969-1-zeng_chi911@163.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260123085749.1401969-1-zeng_chi911@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15955-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com,nvidia.com,kernel.org,davemloft.net,lunn.ch,google.com,redhat.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Queue-Id: E8DC07FE77
X-Rspamd-Action: no action



On 23/01/2026 10:57, Zeng Chi wrote:
> From: Zeng Chi <zengchi@kylinos.cn>
> 
> The function mlx5_esw_vport_vhca_id() is declared to return bool,
> but returns -EOPNOTSUPP (-45), which is an int error code. This
> causes a signedness bug as reported by smatch.
> 
> This patch fixes this smatch report:
> drivers/net/ethernet/mellanox/mlx5/core/eswitch.h:981 mlx5_esw_vport_vhca_id()
> warn: signedness bug returning '(-45)'
> 
> Fixes: 1baf30426553 ("net/mlx5: E-Switch, Set/Query hca cap via vhca id")
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
> ---
> v2 -> v3:
> - Shortened the commit ID in the `Fixes:` tag to 12 characters as suggested.
> - Added a `Reviewed-by:` tag from Parav Pandit <parav@nvidia.com>.
> 
> v2:Added the required Fixes tag and specified target branch net in subject prefix
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/eswitch.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> index ad1073f7b79f..e7fe43799b23 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> @@ -1009,7 +1009,7 @@ mlx5_esw_host_functions_enabled(const struct mlx5_core_dev *dev)
>   static inline bool
>   mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id)
>   {
> -	return -EOPNOTSUPP;
> +	return false;
>   }
>   
>   #endif /* CONFIG_MLX5_ESWITCH */

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


