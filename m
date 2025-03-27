Return-Path: <linux-rdma+bounces-9012-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C75BA73DA9
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Mar 2025 18:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E0A87A3907
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Mar 2025 17:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAA7219A8D;
	Thu, 27 Mar 2025 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEu0YeFD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC801B6D18;
	Thu, 27 Mar 2025 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743098318; cv=none; b=Fbxb5/WEea2pPhRzfqBMH6O5Zq8c6ZLP450iAvRB6wnwpPx0lwTJG/JXOnRIjRp8HK3PE/dEq3pU3lZbrBrDNC91X8Qa9eW4V7eWm/7XpEDYmFC0oq42zBy2lotPMlKO6Gy8xiwmfRvfp4QNcI61z7j4T8VLCs1HrR731OLUVhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743098318; c=relaxed/simple;
	bh=Mrrsr3fGnwTT6iJ6kMjdrgIfTMBV32KTwyyigzONlOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zrtzq4mWIRqRUhpUgAQ5uR6Q8FO72JSNfVdqPc7vNmPHqSZ0Lu/WNi+tk++XXqEKOpZuzkI/kVQrLTkBfPmgPBrsToxcS1YlbS6AEK4kFXxWC6r5aG1k1Q2A+7wyj2KHugseRDw6EMMer0oMmPrma7Xd4KAi9CIvuHkx/szQnzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEu0YeFD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso10588335e9.2;
        Thu, 27 Mar 2025 10:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743098314; x=1743703114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNFPKRqMQqLZ9Eg05/SyM0SNg2unRMSrNmUUeu7DAM4=;
        b=jEu0YeFDBCNjEkfFgIHKfChvLeFf673g9UoX7Ikf/KNlM6eH8eFB6xfjGTNMldFtF1
         CxG1d5BXF+F537NWQr6CqclNmfrvQTAQNCpzNIXfxXW/I0CPmIOD2hjJ5azSP9Q4y/Cj
         KgpP76cKR2v/MTn9ZZ2y2mkJWP+CF4O+E7n3XtmR2igobCW/Li/wgfAh4piSbBWxN9Q8
         OMxugg2sB7uI7+g/SItD9odB5dIdG7jGGHRAdj04SK5Jv3YUhjPh0J0pHD/q6AZB4N54
         m65s8qFOukqBMtbf8TstBEMcdZNFR0WUv9VBTMmzRuCulngF6DDBA2bEGUTxW/t1F1n+
         rilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743098314; x=1743703114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNFPKRqMQqLZ9Eg05/SyM0SNg2unRMSrNmUUeu7DAM4=;
        b=qZ45NfFN8k+Rz0/xZP0ypktCNkn5s36kHhlb/yG8MXC3ZuSmdsTEuPFfbewu4kcsND
         0KDPuQXtFiJrq7FSVlBrGzBBLL5knMpqQBML/2Mxc8MnLfZrd2fgEZE1z2gGGC+nXrv+
         kOEwBLBT5OhZY9jZtYwjQoBhPRG2nwd6K2xdCXsZOlbg1yz93zG0C+p54hr1p7BA5M03
         5gcl3aKENvqUdnZP0BDwFfPVyz4fnWkN9Srto3mB+fZR2GeG3wN5PSR/wE0CqSVpX0SU
         o6A1XE/oGlmtBRmU8KCIDrPMoqrvp6WQzWg3fxPYPVg8Noy0sm57te6cA6TKBPDY9xMf
         uovA==
X-Forwarded-Encrypted: i=1; AJvYcCW5zIwFq1bOvHVN2fDlpNVa1w0A+ukYdTg5MHkUTknixJst3jm+seBb2nsBz1EWksYwDqCjVhpG6Qkmbg==@vger.kernel.org, AJvYcCWgF7n33ykmZh1rW5gLPquJVmWHpYsldjcwAtqdbnI0+Y3q7yD5VB4UhS3WgP6hJiKMGr6eoOBu@vger.kernel.org, AJvYcCXH1tXe6lF/ectf9vA1RfD6/nEHvGb+F5tflA6YQdgLfPk5fnnkdfQEhwqLhcFAqptogTX/bI3AZiqH32U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrpMVJz//rBQ4q+a6RNDhgmWeiQrZL4DDYWms+Jsr1d3H88agy
	nF/CJSjDZXpS0f3qcfq7XO/lPjuQBVv4+Fzmor+aFsQQmoRSoRku
X-Gm-Gg: ASbGncu+L7EWuuJ/duwQzdSypQXUvN/JvJWvoA8qM7v/MBar1pBkO9bk2sRs5n+7X4B
	rPRZ4i6+0KMLEDvgIh44ZO75qHU97druufadzioCEeSrl3WK/i7RgBdfEjFtS57Xtv3VHTeDJXA
	3ccU8k59o4TYZfdPu7NZJ4txhbBLbTobYJxjUlXSIZ3TQ2kE7AeWXYCB+/ves5sHIzKVgBuiW4Z
	YIgHGDeAmAahTr8kU98vDPlajIkV3ROkAnAWc4l/PqztcO6Xh7CsTQ/TbJYj86e29dclyMcAd35
	tAnBssAvJ7k6JyIa+YMIWah2uRpPFBeIUBYF9zAxLqXvNfDEpbKHAzCGBGtsSnHuxA==
X-Google-Smtp-Source: AGHT+IGwPvCqvpr/tpWh0Z1pqQBc8JjT9+vNiek0QDxNjWt3pW1vfUneUWjh2F2SC5tL61T5+z6AIA==
X-Received: by 2002:a05:6000:4205:b0:390:f902:f973 with SMTP id ffacd0b85a97d-39ad1742fc3mr4309017f8f.8.1743098314093;
        Thu, 27 Mar 2025 10:58:34 -0700 (PDT)
Received: from [172.27.19.238] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82e6adf6sm44366535e9.15.2025.03.27.10.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 10:58:33 -0700 (PDT)
Message-ID: <ea6a499b-c267-4fa3-8ed6-983ab96b3b9e@gmail.com>
Date: Thu, 27 Mar 2025 19:58:30 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: SHAMPO, Make reserved size independent of
 page size
To: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Lama Kayal <lkayal@nvidia.com>
References: <1742732906-166564-1-git-send-email-tariqt@nvidia.com>
 <20250325140431.GQ892515@horms.kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250325140431.GQ892515@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/03/2025 16:04, Simon Horman wrote:
> On Sun, Mar 23, 2025 at 02:28:26PM +0200, Tariq Toukan wrote:
>> From: Lama Kayal <lkayal@nvidia.com>
>>
>> When hw-gro is enabled, the maximum number of header entries that are
>> needed per wqe (hd_per_wqe) is calculated based on the size of the
>> reservations among other parameters.
>>
>> Miscalculation of the size of reservations leads to incorrect
>> calculation of hd_per_wqe as 0, particularly in the case of large page
>> size like in aarch64, this prevents the SHAMPO header from being
>> correctly initialized in the device, ultimately causing the following
>> cqe err that indicates a violation of PD.
> 
> Hi Lama, Tariq, all,
> 
> If I understand things correctly, hd_per_wqe is calculated
> in mlx5e_shampo_hd_per_wqe() like this:
> 
> u32 mlx5e_shampo_hd_per_wqe(struct mlx5_core_dev *mdev,
>                              struct mlx5e_params *params,                                                    struct mlx5e_rq_param *rq_param)
> {
>          int resv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) * PAGE_SIZE;
>          u16 num_strides = BIT(mlx5e_mpwqe_get_log_num_strides(mdev, params, NULL));
>          int pkt_per_resv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
>          u8 log_stride_sz = mlx5e_mpwqe_get_log_stride_size(mdev, params, NULL);
>          int wqe_size = BIT(log_stride_sz) * num_strides;                                u32 hd_per_wqe;
> 
>          /* Assumption: hd_per_wqe % 8 == 0. */
>          hd_per_wqe = (wqe_size / resv_size) * pkt_per_resv;                             mlx5_core_dbg(mdev, "%s hd_per_wqe = %d rsrv_size = %d wqe_size = %d pkt_per_resv = %d\n",                                                                                    __func__, hd_per_wqe, resv_size, wqe_size, pkt_per_resv);
>          return hd_per_wqe;
> }
> 
> I can see that if PAGE_SIZE was some multiple of 4k, and thus
> larger than wqe_size, then this could lead to hd_per_wqe being zero.
> 
> But I note that mlx5e_mpwqe_get_log_stride_size() may return PAGE_SHIFT.
> And I wonder if that leads to wqe_size being larger than expected by this
> patch in cases where the PAGE_SIZE is greater than 4k.
> 
> Likewise in mlx5e_shampo_get_log_cq_size(), which seems to have a large overlap
> codewise with mlx5e_shampo_hd_per_wqe().
> 
>>

Hi Simon,

Different settings lead to different combinations of num_strides and 
stride_size. However, they affect each other in a way that the resulting 
wqe_size has the expected (~preset) value.

In mlx5e_mpwqe_get_log_num_strides() you can see that if stride_size 
grows, then num_strides decreases accordingly.

In addition, to reduce mistakes/bugs, we have a few WARNs() along the 
calculations, in addition to a verifier function 
mlx5e_verify_rx_mpwqe_strides().

Thanks,
Tariq


