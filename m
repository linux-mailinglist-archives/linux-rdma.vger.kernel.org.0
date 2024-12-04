Return-Path: <linux-rdma+bounces-6219-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5FC9E33A2
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 07:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9822D2840BA
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 06:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B99F18A6C5;
	Wed,  4 Dec 2024 06:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0F7oKRA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E19188737;
	Wed,  4 Dec 2024 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733294706; cv=none; b=TgzwpYb3xPZZoZamnTCJd4jq9MbvsP96l11YCdp9CcLUkS4/8qovjuMjqzFAGzyF5rGKkwdw5U5mSMeeLcGzyQpuRiDiI+S1qqp1kt/LD0y7PTgGH1OGsXIYz7XhoqVym8dZma3du8fNFUtGVaNuQeBPTucnCV71QlBa6QPGDTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733294706; c=relaxed/simple;
	bh=KkcNcl1LQy62uBO4z6Bq1iIEjCeUXfSEBY4ZVwpqI2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ka+aU3OjXS4Y1jgIzQB2atdKKBb7k/Qpd8K17DwsOAkRw5ciV/v8dm/D6YgFLw6Rv82kJeK0v3PMDzcMF+nxj4D0qAR8bJawdLOC8F8pSBoLArICY5vGy2JNee7tIs+1gnrjgX9kaBm466dp0nSduJrndaFNb+InvAw+V/9o/Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0F7oKRA; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso4366641f8f.1;
        Tue, 03 Dec 2024 22:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733294703; x=1733899503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KjlGQXVf7Eo+4if+u3wgUii2FW9w100FoAUk+wz87k4=;
        b=S0F7oKRA4YPhS6BlOKxSESMn2j+u7KsJ6SrlHtokUz0jFAuT9v7gUSMDEYfODc8S4E
         Gp4ieJdJrvtH9VUISCRXSAVw0SIU3CU4jO3/gCOOzCwa61nsaYxcsh54MHxdKmQ5+BeZ
         gLeUtvdkmIkhoFp6jRvOzc/bZWYprTxzLnv2eE7js+CW665cTsWaUk0wCymHfCawwJqt
         Bxwo+LHHK/i0SHSJEnbuyXTYeA4bN8MTx3q6n6C5F+2pKkQvnsASH6fXlj1Eb3RtQjXz
         9Arep9BD3ReCmRdfmX4pONp18qwwdZtfLslNlK4qw+zbAYFzVs/kSSYztJFwsKv5D+o1
         nL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733294703; x=1733899503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KjlGQXVf7Eo+4if+u3wgUii2FW9w100FoAUk+wz87k4=;
        b=Gzp2vHUei9JorQOhdBPFfe2eVtDmhWrUrMFxhBK4ZTKj142QUMxm9rNU4bwy43qyh7
         xOOlIA5o3zXbYLTbeRdiuH387hLkQe6uukFUd3Bgb0JjCgB67IZfLp2kXJK0QsqK6CDn
         7IywnwyTgWwR2JT+Z+3NALj2uRNzMxr7LDmbedIFeikvIOJ8Qawa4msvCy0b0niLV7s+
         9qL69jR71pV7oSj7TofTi5Q9hq5uJ/PuWw/YrZk/dTHXXx6OWMsdgp316YK3GryXo+o/
         CyM18RlDsebH1KjUCjVybjn9LNfGji4WeHxD/QeU66Ev9qvEaK8PLQ8UB4IsRfcznC1q
         itOA==
X-Forwarded-Encrypted: i=1; AJvYcCXodXddGjvQNJjaBOoC76SEEnCy+gqYC0SbXMDPTQ2EaB51zML/DokBEFsDhYaiw6zVDhT940T2/Ocj@vger.kernel.org
X-Gm-Message-State: AOJu0YzBiGhHyMeWneqN/AMV8Xnb+pxzIheZl82Ae9gHDetHnfSR3qLu
	z0siwNujKpcR+y9jzf+UZUFQpqpg4YxyH3k1HsGQsV8rYqpoEvFihyFqGA==
X-Gm-Gg: ASbGncuY8JGo807qLO+UytOzshKy7a2UQrjz3CKLDiYjgrrbi+P0eaK98+ynTORlJ85
	T9l3GyeFr7c4WWKI1Ar2e1bbVck5FMP7ig1xekJ1E7d3Hv7lVmiBggvJNssN4FyMKn+B06VcOxA
	VHcGLQXYS/2J8RB71wvXtHf3Q3+atw48Rqip0yJbQqIRnR84nmSnvJK5phIdoSQVnV71DTLJhwy
	a7LqAHMNrIRD9CQ5Z+Em47BU1G6GXkgQqhKKfkIcTulPP2S+D2SZf5SY20aR0EBYTT1F/4=
X-Google-Smtp-Source: AGHT+IF1K237/R4Mz21kt1ysbS8NSEiJysru5Le0GKxEqBykESt9G5A75s2u663CRGZ9+OMKe0sjJg==
X-Received: by 2002:a5d:6d8d:0:b0:382:4ab4:b428 with SMTP id ffacd0b85a97d-385fd3c6a5fmr4002028f8f.8.1733294702957;
        Tue, 03 Dec 2024 22:45:02 -0800 (PST)
Received: from [172.27.34.104] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e429ebccsm11661312f8f.10.2024.12.03.22.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 22:45:02 -0800 (PST)
Message-ID: <f92c2cdd-187c-4559-8065-8571b5fbf67d@gmail.com>
Date: Wed, 4 Dec 2024 08:44:58 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V4 04/11] net/mlx5: qos: Add ifc support for
 cross-esw scheduling
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-rdma@vger.kernel.org, Cosmin Ratiu <cratiu@nvidia.com>
References: <20241203202924.228440-1-tariqt@nvidia.com>
 <20241203202924.228440-5-tariqt@nvidia.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20241203202924.228440-5-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This IFC patch is targeted to mlx5-next.
Sorry for the confusion.

On 03/12/2024 22:29, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> This adds the capability bit and the vport element fields related to
> cross-esw scheduling.
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   include/linux/mlx5/mlx5_ifc.h | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
> index 8b202521b774..5451ff1d4356 100644
> --- a/include/linux/mlx5/mlx5_ifc.h
> +++ b/include/linux/mlx5/mlx5_ifc.h
> @@ -1095,7 +1095,9 @@ struct mlx5_ifc_qos_cap_bits {
>   	u8         log_esw_max_sched_depth[0x4];
>   	u8         reserved_at_10[0x10];
>   
> -	u8         reserved_at_20[0xb];
> +	u8         reserved_at_20[0x9];
> +	u8         esw_cross_esw_sched[0x1];
> +	u8         reserved_at_2a[0x1];
>   	u8         log_max_qos_nic_queue_group[0x5];
>   	u8         reserved_at_30[0x10];
>   
> @@ -4139,13 +4141,16 @@ struct mlx5_ifc_tsar_element_bits {
>   };
>   
>   struct mlx5_ifc_vport_element_bits {
> -	u8         reserved_at_0[0x10];
> +	u8         reserved_at_0[0x4];
> +	u8         eswitch_owner_vhca_id_valid[0x1];
> +	u8         eswitch_owner_vhca_id[0xb];
>   	u8         vport_number[0x10];
>   };
>   
>   struct mlx5_ifc_vport_tc_element_bits {
>   	u8         traffic_class[0x4];
> -	u8         reserved_at_4[0xc];
> +	u8         eswitch_owner_vhca_id_valid[0x1];
> +	u8         eswitch_owner_vhca_id[0xb];
>   	u8         vport_number[0x10];
>   };
>   


