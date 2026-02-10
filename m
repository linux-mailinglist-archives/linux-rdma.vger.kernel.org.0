Return-Path: <linux-rdma+bounces-16695-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLzAG5bLimmbNwAAu9opvQ
	(envelope-from <linux-rdma+bounces-16695-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 07:09:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24874117487
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 07:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADD803033256
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 06:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4657932ABE1;
	Tue, 10 Feb 2026 06:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nN1q30Lc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C0126A1AC
	for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 06:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770703750; cv=none; b=DiRD2sVjbwWQPm0MoFq57r/dgOTkgf1LIFIxSs2QetalAEBJL0Ij50JB/dstUleR90ACI/P4ZhZoivkSJR4KYkWagtBb1dUCbJKIJsKxaggFw+rfpZxoiZwNCGVvfyCXurHgiqPGVCKnXHu8RjZm29wO5CNsNniD9ZcKjJ6lqM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770703750; c=relaxed/simple;
	bh=eyDjIBG7hfEhRuYrIjZHAJ0n1jwhXYzNByFDefcW8b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFZLkGkYTCrkCOPlBjKs76k8LN4prJN7AZ1o8OmZdC4zSrKtP6cNRVn+GaazQRyUXcXIyASTOAw4LgzRHXgaKCTlyad2e8odOm1TqUlmON21WORlNW0k6RRH4KlcyEDCeHxQ0pAI+mImIALtlB25L6kOK/63c3NlLlRWMGAeBeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nN1q30Lc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4362507f0bcso3185362f8f.0
        for <linux-rdma@vger.kernel.org>; Mon, 09 Feb 2026 22:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770703746; x=1771308546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wQ1jQtZTg9NmtE39KxvfhgMIzdFgti3yzkMdp/kLIq0=;
        b=nN1q30Lcz9e3IHQmZ5iKy2lkDK5ziWUd++EguFVcR4tOsFAQLSl+mRJFaA0Gmcivkn
         d6Etfni+07NhnYE+k7joM4pdvGUslITIuR4u6XvZO/bFT+6pRIu8VitEjIJiijxrxsxV
         8/0eWeHFJCiHGIQBk9PVtUquLcPm0hwTBoY+pz8SfcafU5+3kGkweHbJQLOjndQKsXo6
         2xGWUXVlSMM2f7sn23nJrwQLIb6CQNmkjNm0I5CeBluRa2mn3YOC41COLnhntoBda5yI
         S6bt8t1JEdj0U2BUtEdl20/sny3lzesMaahOPBXzKqQ5+5HF57YncPnsV1e0XSspy1mI
         SpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770703746; x=1771308546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQ1jQtZTg9NmtE39KxvfhgMIzdFgti3yzkMdp/kLIq0=;
        b=MlOMPgAauZtCWoXMcMmDNQZG/aC7GoT/c/9G5MG+2+pCkdnEhu6wSo3GJQB/fCGFtS
         eQS7evRFsbbA1HFsA5MZPhNVocklhneOHvFFB+0q+JP7ri9vwNpxdjmkcga0+WmP0tyJ
         mBkpLEMT3yhzY1krpqineN91dGIEQnbTr0pFZzuODrnaBWGT4qzAbOhrd6QA2cWBMvwB
         xAjJw7sQE3mBMbW7Q72PSmfFTN17VC27rEb+3mu/9oTraJ1Z2wz7ZZt33FtpjWjJZCnz
         auhBhXCRONGZXLmUMia3DBKC5BlJhoKeubRTNccUNCizBr+XJFotxdwgLN5mvBTYPaU2
         P3pg==
X-Forwarded-Encrypted: i=1; AJvYcCWS0xs/FarrM1YfRhVxOwUPDByi9+Q7pbNgR5d1L0W2WTgiNuRWPYEOoBMIj0i9TrLx8NQQzwpPAn1n@vger.kernel.org
X-Gm-Message-State: AOJu0YzVUem0PUSH/vbZqFB1yCB+q2Zoz7CtFFdMdn+qIn99/ggHRNgb
	xtIGBeufw0IlUp/Q2BT+iDrBoRnvqopUkJueRqbrGw4yNuakU9H5GDuz
X-Gm-Gg: AZuq6aLPr+HZEs0pXVtBPLA+3OXM9vjEOuWhwKLuJB4fJaQ7vohsz4Hv1RBpc/qVeSw
	liSmenvNxg09YWJcbwCAZoQ+BvnZDkbdvUtJJfNlExNIEa017IVXm4D0TbfcwLaomJA12Zr8+A/
	Xzc+/SB5wRzQlzW4R6nqHj3YeXEG0cCd2aH9WLm/VzA9x7so0j5WqUH+c/Jyc+REyaucmiNhGLD
	Pr9cPzuYzHERhqfZG2hXur2bNnArZmIWvLiJUfNn+/QF77eG1xtv0xkT1pjWnhYAek24z2mf/xT
	7NcmckdEj4hBIJaV5A92JkiJPJuAi57Fjg8vykfNmFu2Z4dwS/cZWgawdipKp6Euur5MoJp4aMY
	2te4osRgtSoMLM70Aypc/R6IDdjwl/OVxRcjrQp8CTmCGUjkWLkb6N++8euZWbK48ehdWAU+/YN
	X32DOEgl/5Vvf9NyWp7zOvnGLbyDaxx9XbSSulAZf1qg5wNA==
X-Received: by 2002:a5d:5f92:0:b0:436:339a:9a9f with SMTP id ffacd0b85a97d-43779fe26damr1912794f8f.10.1770703746074;
        Mon, 09 Feb 2026 22:09:06 -0800 (PST)
Received: from [10.221.203.72] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43768d07fa7sm19108386f8f.35.2026.02.09.22.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 22:09:05 -0800 (PST)
Message-ID: <a36c490a-0fcc-4fc5-b73a-6d6e0eba4e70@gmail.com>
Date: Tue, 10 Feb 2026 08:09:05 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: remove declarations of
 mlx5e_shampo_{fill_umr,dealloc_hd}
To: Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20260206-shampo-v1-1-75b20c6657e5@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260206-shampo-v1-1-75b20c6657e5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16695-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 24874117487
X-Rspamd-Action: no action



On 06/02/2026 13:18, Simon Horman wrote:
> These functions were recently removed by commit 24cf78c73831
> ("net/mlx5e: SHAMPO, Switch to header memcpy"), however,
> their declarations were left behind.
> 
> This patch removes those declarations.
> 
> Flagged by review-prompts while I was exercising Orc mode locally.
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> index 843f732e4eedb005eba58b9a9ebe48c6703906e5..a7de3a3efc49f6c237ea42b0b932fbe1f5aca847 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -1034,8 +1034,6 @@ void mlx5e_build_ptys2ethtool_map(void);
>   bool mlx5e_check_fragmented_striding_rq_cap(struct mlx5_core_dev *mdev, u8 page_shift,
>   					    enum mlx5e_mpwrq_umr_mode umr_mode);
>   
> -void mlx5e_shampo_fill_umr(struct mlx5e_rq *rq, int len);
> -void mlx5e_shampo_dealloc_hd(struct mlx5e_rq *rq);
>   void mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats);
>   void mlx5e_fold_sw_stats64(struct mlx5e_priv *priv, struct rtnl_link_stats64 *s);
>   
> 
> 
> 
> 

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Thanks for your patch.

