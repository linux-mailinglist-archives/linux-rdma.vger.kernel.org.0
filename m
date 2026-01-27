Return-Path: <linux-rdma+bounces-16048-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD2CFTxueGl2pwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16048-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 08:50:20 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCC590D7C
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 08:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B754D30089AC
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 07:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4902848A8;
	Tue, 27 Jan 2026 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0l9RlVJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14251F4181
	for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769500216; cv=none; b=th7ZFKQT0mCkX/0ZWsbZJUEMqp/khsyB3bpk4U/TZDmUeHRtJubN6CCxlknKyFuWCeVu9giPdrMI/TTDoYmDwD5g2vc9ptd90LKMLCe06HB7gSOFE+OwrXIaAnhl0WVD7ySG2j6B6zBSGwHTMtSK2GgFWaKD5E+Wt+t92NNC8uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769500216; c=relaxed/simple;
	bh=jhKN+FIotpia4REEgeIZnDqef/WVtVZ0T34Ox+kFDUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NeRgYPi/4AdfKF3QfqWNHUKvU7Zrkf7tjLDuOX3NqakFvEQKPwe9EebsdCK0Anb6HXepQ2j98lXwLtVNCGOpSRqlyqUXX2b7gUxQmeSBnz2aoemydfdDOp182VrabH4yjRoKHVcMGSzkKUSFlgvklt0tqx98Ek9UuOGEvXCI5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0l9RlVJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so52409825e9.3
        for <linux-rdma@vger.kernel.org>; Mon, 26 Jan 2026 23:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769500213; x=1770105013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1F+pwf4TDg/OxTQCcbJAJWg75eTnF2WjrBMDZZbHuLY=;
        b=W0l9RlVJdLmlLLyoidvWqwuiwrembZwluVDEpncVqR5V1AqgNWJw5YRBT2oNnPG0bc
         njJY3GWyDYt143xTIx2ukz0OS2CTyfhym+97RJFwb3AxLMZ6byhudNrgCEZA3q03RsYT
         5OtGZG5DHBczXKlDxXIe/OK8DNlyoEpsZd4kZtL80wVAgFjEeahzBOhWN6jUoA/RJCbl
         Kd5zlvvd2wF6jVlnDlfmFvpVJBL5tEkAXvbkS5aNgv25lNPCOJwPlg/BOY7c/yBKa3i7
         qQ9vTe6Qc2lUu6tJ71nPaZsnm+7m+vFmMCZYCMGdlmeiC1IaHREWvhul9Noj7MDKsPv2
         9mUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769500213; x=1770105013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1F+pwf4TDg/OxTQCcbJAJWg75eTnF2WjrBMDZZbHuLY=;
        b=wlH6C57yWtoteTlaF0kTRu6EMv3AOb3MXCTW9JIgNP9vOH6N/odQSjVKTRAOzv25zZ
         DR2Qnmi5lgdcnyFfE3kKVUobt6YdV+Tw0NTwLI2zE/zin/580If9kDay7HNLavLXs/Sr
         Ut4XUB4K0vnIoy+n7ySGvYYGvycHWQhQeiGj8u2AzDu7k+rjY42BMIqwoszBotyu0EPZ
         fm16luWyvm+9QmptdORSBZ4znHsE8aW4O5tX8FEKVuEbWuJUG++kk1pb+K/dm7IdZ50f
         7cjAjYiiLkz8YmwjRoNdAdF4+vZLGIiz5IGmlUvCr+RTe3mzfN3kBoFTvbGz0UNipeZE
         +82A==
X-Forwarded-Encrypted: i=1; AJvYcCWzTDxCRPjB6nLd1kyX6C60dERFu1tYaP/f0uLzLTabWqL65xzLtThJJpNuPxWbijRumOf7inDdiI4L@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr4ix3wV+4wDJu5nKMtANtFtlzFZua/Ake/MRB2U41je/fUJio
	a+N7XZaPtFUmXqeRZNixOL8uu8D2kXBgK8EEoaDSuJGAYmIH3YykkqT2
X-Gm-Gg: AZuq6aJI7031pverZIR+PcMnu/sxloyWUvzjbaUMf1kcrcpw0IrPIgAA4yGGneJKOCf
	kvFk0D1CJqALPRzT1VgO8vrUAi2mMjieku9UWMYOkwohbl8KP0x+ixTanxsFdfqKQg+7f5/yw2W
	fHsVxNU7a8uI/8JYgKF7EzhH0blAw/OmXDnaZucIL0nmxMi/b2nodnxiniRbv05W61wlU2sjksm
	MH+aLljttYaJ1T3GyrQINsL1/F1CCdyJO+gp2tNG9kCpV8kbTTLdJswWL4KTru2GiryCYF8EYS1
	v9INQYpIRrdl0Jn1ailKYuIGaXle9b4NVvqyE3/sVxN17noO4Yd4Ci/umRZRoBWKYWJh2S0D3pa
	6Eur6an4L164kb7XV6wz6Gw+ljDAqeU8UnZorBL3nIaOlEnfDCMUfTrOg2/JqByyNMr1UMjeU6L
	LGRn+Q7WVdriNtmZkd6z/zP2L/iS0IddeTtwE=
X-Received: by 2002:a05:6000:1865:b0:435:b020:30ab with SMTP id ffacd0b85a97d-435dd030439mr1215295f8f.15.1769500212866;
        Mon, 26 Jan 2026 23:50:12 -0800 (PST)
Received: from [10.221.205.245] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e717cbsm36432550f8f.24.2026.01.26.23.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 23:50:12 -0800 (PST)
Message-ID: <3b58208d-c2a3-4623-8fc8-e1ad2b71d2f7@gmail.com>
Date: Tue, 27 Jan 2026 09:50:11 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net/mlx5e: Remove redundant UDP length
 adjustment with GSO_PARTIAL
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Cc: Igor Russkikh <irusskikh@marvell.com>, Boris Pismenny
 <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
 linux-rdma@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>
References: <20260125121649.778086-1-gal@nvidia.com>
 <20260125121649.778086-3-gal@nvidia.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260125121649.778086-3-gal@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16048-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: EBCC590D7C
X-Rspamd-Action: no action



On 25/01/2026 14:16, Gal Pressman wrote:
> GSO_PARTIAL now takes care of updating the UDP header length,
> mlx5e_udp_gso_handle_tx_skb() is redundant, remove it.
> 
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---
>   .../mellanox/mlx5/core/en_accel/en_accel.h      | 17 -----------------
>   1 file changed, 17 deletions(-)
> 

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

