Return-Path: <linux-rdma+bounces-12113-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93421B037FC
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 09:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92C13B77F8
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 07:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE4C235355;
	Mon, 14 Jul 2025 07:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBf3X3er"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593553D76;
	Mon, 14 Jul 2025 07:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752478172; cv=none; b=ES//Gd6nQB0CPKFvEhV5tgKyOz/6/aqhsBBSoR+LIuT2l/sH8WJY4fY/oPuFqBLbDN54Kqp10IGJq8MuXPTvki/58sumq2jEtQNs3znUROz80McR95kXBDOkS+xIRt7zbtIuSUJB8T6/vV0VtESVha/35AY6ekdoc55+MbOPdCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752478172; c=relaxed/simple;
	bh=1lsnNAkONw9TDWPkYEtvFbvEU3cLpjPmSE98N3h/Big=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c7XABpo16yqnXP7n5CmmtzHYpcGeW2gHUOiL2jpT24mUnbHf1EXZrOZsTJsgfz5gFXJbQnmX+ig1uJNrpR49F3SWOF/aIXhB/CzDhuCWNd9Yx/ABbFAzUcdagM+dw+h2O0Ab5vrUFy2/QcwCRYI2x4gfJI9JDObN8argz1MMpi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBf3X3er; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso2251017f8f.2;
        Mon, 14 Jul 2025 00:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752478169; x=1753082969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zL1BWSoBAWuDQ4I14p3y5SceqlmmQ/H5Rm2Krj1fU+Q=;
        b=iBf3X3erb1vpoDKf8sezcg7ZXHy4gsEZiEc3vdaSRxdgnyXSZCzO63BS1e+JjRcB8v
         K3woWz+RHw2kU4+/986CYGv/C45euVYfpIqwMD2To2ZcER8n4w7kFajwQKS0PNlyFsNn
         dQKX0eysMLnqPKe5kHBkPMWXhoc3ZrOVlwBL0I0chWQyaPWmCPNhTxCD5DGXlh+DEo01
         eC7Gwpc16PDSXIp/1mub/YGpGPPWZJedG/epD178K9IW+aNn1nBt0JYpQtyLMtUA8deA
         IwX8ZNLa8mKzHmNmnpI1pUS0TTKTh1DpWwJIklbXG6/9uIHOrEVG1NtcVJ/E9TZouOpu
         2b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752478169; x=1753082969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zL1BWSoBAWuDQ4I14p3y5SceqlmmQ/H5Rm2Krj1fU+Q=;
        b=HoUhEERfc6jCgxr6mSuEiKH9Ro/Rzo9yzLmAihhptBQ4rt60zKsLZX2OBrUSFWfpaO
         nRAT+M26HSIpj4ViY8RB4lvYpnJtgjX8ciStNzftfSQl5uJx9GNgO5VScYfnOyZqpAh0
         6Ow3JRRdmSmu7YThqkBsi/L9WDFcEYbxbBXkCBfgWeOZxT4LnAdyCjrvRsFZZeOFgxmi
         UkGM37vtyRD8DBm7zDJrKuq8xI8CRbYc3N/lIeGuugCjHJe8WMZ31WUEdmX7NqhBKzdq
         4jKz52sNH9cyYvPoHsYgyU0h3xurswiPDgla6M8zkq2/MOhlwafJhbCDZpTREPD46LM4
         T4Vw==
X-Forwarded-Encrypted: i=1; AJvYcCU9QWDf5oCKrZ/9xWcKjm6hilebnCtoB0CgqF9xrDX2frmuu9YQk3xoIAQWiLMsqT93/HCvcIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZbLEA/2yaPezEGDv43NE6EKInhY7NJTZOOBR4LmLp3cTrIczZ
	7fKiSUSDHyVqTUfjRwTKYjUxFEfDnmoZsNy+a/Mpvt+Y6VObEiHWrtnC
X-Gm-Gg: ASbGncu5gwdO/wJOs8vz4voPnOGsWoOIY9huoTMdthDU5B9ROQNg6+RreGPbbfrENwM
	bEwtuhAAKNxWYDvjida6XdypNNOgT4fCEJaArIA3nudgcYGnwquN9jrY1lOyBlCBhzk8r3ne7+N
	Ujm3s31REANE21IHGnSqs31RbMd3ArNF0NQP/TL98LEnSP/k9JDuvS0cB7cHA2XCqhO4mHBkgJu
	JRFn7113cF/7T0c89Q/oLfI7bYGYH7vyx87TisiOWk68CXmStTC7dsEQAVin0kfe1oKb8EGiYuW
	bC5iQ+AibVp83Xktp43T6Dmqa8zHMGDtmFW7JIxY82TMzI8zCV6DylGx5u8kJfJPjEdz//mhLpF
	3zRQPIoA4jT3QPSnPIyFuVQpFBkZvy/+WA+e1QJYt/LHXZA==
X-Google-Smtp-Source: AGHT+IFpopB3hK0mGRj+xeB9+XqD5GeatO2oBohUHU5VVD4wIJ5AcS6VGCNxs3/ZNpmKcFX0opNIGg==
X-Received: by 2002:a05:6000:18ab:b0:3b5:dd38:3523 with SMTP id ffacd0b85a97d-3b5f351dd71mr7168623f8f.8.1752478168215;
        Mon, 14 Jul 2025 00:29:28 -0700 (PDT)
Received: from [10.80.19.106] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4560105be56sm58807215e9.0.2025.07.14.00.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 00:29:27 -0700 (PDT)
Message-ID: <befdca60-f9e5-486d-8df4-eafe4f338d79@gmail.com>
Date: Mon, 14 Jul 2025 10:29:13 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net/mlx5: Avoid copying payload to the skb's
 linear part
To: cpaasch@openai.com, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org
References: <20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-0-ecaed8c2844e@openai.com>
 <20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-2-ecaed8c2844e@openai.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-2-ecaed8c2844e@openai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/07/2025 2:33, Christoph Paasch via B4 Relay wrote:
> From: Christoph Paasch <cpaasch@openai.com>
> 
> mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> bytes from the page-pool to the skb's linear part. Those 256 bytes
> include part of the payload.
> 
> When attempting to do GRO in skb_gro_receive, if headlen > data_offset
> (and skb->head_frag is not set), we end up aggregating packets in the
> frag_list.
> 
> This is of course not good when we are CPU-limited. Also causes a worse
> skb->len/truesize ratio,...
> 
> So, let's avoid copying parts of the payload to the linear part. The
> goal here is to err on the side of caution and prefer to copy too little
> instead of copying too much (because once it has been copied over, we
> trigger the above described behavior in skb_gro_receive).
> 
> So, we can do a rough estimate of the header-space by looking at
> cqe_l3/l4_hdr_type and kind of do a lower-bound estimate. This is now
> done in mlx5e_cqe_get_min_hdr_len(). We always assume that TCP timestamps
> are present, as that's the most common use-case.
> 
> That header-len is then used in mlx5e_skb_from_cqe_mpwrq_nonlinear for
> the headlen (which defines what is being copied over). We still
> allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking stack
> needs to call pskb_may_pull() later on, we don't need to reallocate
> memory.
> 
> This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC and
> LRO enabled):
> 
> BEFORE:
> =======
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>   87380  16384 262144    60.01    32547.82
> 
> (netserver pinned to adjacent core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>   87380  16384 262144    60.00    52531.67
> 
> AFTER:
> ======
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>   87380  16384 262144    60.00    52896.06
> 
> (netserver pinned to adjacent core receiving interrupts)
>   $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>   87380  16384 262144    60.00    85094.90
> 

Nice improvement.

Did you test impact on other archs?

Did you test impact on non-LRO flows?
Specifically:
a. Large MTU, tcp stream.
b. Large MTU, small UDP packets.


> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 33 ++++++++++++++++++++++++-
>   1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index 2bb32082bfccdc85d26987f792eb8c1047e44dd0..2de669707623882058e3e77f82d74893e5d6fefe 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1986,13 +1986,40 @@ mlx5e_shampo_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
>   	} while (data_bcnt);
>   }
>   
> +static u16
> +mlx5e_cqe_get_min_hdr_len(const struct mlx5_cqe64 *cqe)
> +{
> +	u16 min_hdr_len = sizeof(struct ethhdr);
> +	u8 l3_type = get_cqe_l3_hdr_type(cqe);
> +	u8 l4_type = get_cqe_l4_hdr_type(cqe);
> +
> +	if (cqe_has_vlan(cqe))
> +		min_hdr_len += VLAN_HLEN;
> +
> +	if (l3_type == CQE_L3_HDR_TYPE_IPV4)
> +		min_hdr_len += sizeof(struct iphdr);
> +	else if (l3_type == CQE_L3_HDR_TYPE_IPV6)
> +		min_hdr_len += sizeof(struct ipv6hdr);
> +
> +	if (l4_type == CQE_L4_HDR_TYPE_UDP)
> +		min_hdr_len += sizeof(struct udphdr);
> +	else if (l4_type & (CQE_L4_HDR_TYPE_TCP_NO_ACK |
> +			    CQE_L4_HDR_TYPE_TCP_ACK_NO_DATA |
> +			    CQE_L4_HDR_TYPE_TCP_ACK_AND_DATA))
> +		/* Previous condition works because we know that
> +		 * l4_type != 0x2 (CQE_L4_HDR_TYPE_UDP)
> +		 */
> +		min_hdr_len += sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED;
> +
> +	return min_hdr_len;
> +}
> +
>   static struct sk_buff *
>   mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
>   				   struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
>   				   u32 page_idx)

BTW, this function handles IPoIB as well, not only Eth.

>   {
>   	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
> -	u16 headlen = min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
>   	struct mlx5e_frag_page *head_page = frag_page;
>   	struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
>   	u32 frag_offset    = head_offset;
> @@ -2004,10 +2031,14 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>   	u32 linear_frame_sz;
>   	u16 linear_data_len;
>   	u16 linear_hr;
> +	u16 headlen;
>   	void *va;
>   
>   	prog = rcu_dereference(rq->xdp_prog);
>   
> +	headlen = min3(mlx5e_cqe_get_min_hdr_len(cqe), cqe_bcnt,
> +		       (u16)MLX5E_RX_MAX_HEAD);
> +
>   	if (prog) {
>   		/* area for bpf_xdp_[store|load]_bytes */
>   		net_prefetchw(netmem_address(frag_page->netmem) + frag_offset);
> 


