Return-Path: <linux-rdma+bounces-16047-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIZhDPtaeGkupgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16047-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 07:28:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8254790630
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 07:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8DE6303D709
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 06:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259A832AAAA;
	Tue, 27 Jan 2026 06:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MD2gHp1h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE9D17D2
	for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 06:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769495212; cv=none; b=TWvQUNyluPw3KpZ2eJEW5R0q91BJoC0Y9/p2eMdzL6uZZkvo7x7rt9e/U3I6NsOKnu6tLMFabpiOgdfy2XSc6TK91bpJqnJUPF0F58mQYeeJS0OWWd4aOuAEjDIqwmAJliCeIE91295+lix+sOUvilydW22uSM8dXOEJ286XtsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769495212; c=relaxed/simple;
	bh=3ZMwlMDdcZOeFSfV+NKz7u07M2f8knHtILiYPoeGklM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6ifEAFav1bOIeFQAKHT4TOL5TaxeOFQ2y7Sj5kLEvQzFTKRHNU5ED2I0nRUmIUekFD3sTkGoKyrd8DsH1jFEA3JFaB5hPchB1Jf4hFMG7ddgfoeJhfiuy+oYuIgv0l/BGdRRNXP39EVyd/G9JCrhbpJPJ6Sb3i/QJhZ/dVJ9IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MD2gHp1h; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee4338e01so29950835e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 26 Jan 2026 22:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769495210; x=1770100010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SWD55duaNuQRMmraETqUDpWummec5E+B5H4qqlJvJhs=;
        b=MD2gHp1hOmczY8b85TcOvXXekJLF/TgM/lINdHzTxvIuHa5eWNjcj6mt3FgXiMnO04
         kEBNAerDLhInEdkhdrXBHgu6SHsb+eZLDAAidXux+OQdBBa0+PZlKFY+4voA4yooGW4M
         ZYOnlf+JZH3pEcaHPcdYaiCnEpVccwsjIGIV0cejUKD1wvkVztfInWQ0H+TqfTBwhdIm
         KWtcUsttNyuJ/vemqG0PBs/sN0R1QnQuUwUyF3xK6u6SAUnwGmHBpvwXNmTRfr5NqYkm
         ndbFPznm2illzItGmOBAUC/R/ypmiZH4qtTpviytxNdBDc/rc8eQzqbhXNRWZMFw2EBG
         yM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769495210; x=1770100010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWD55duaNuQRMmraETqUDpWummec5E+B5H4qqlJvJhs=;
        b=hrxwSfDrlWupA2w9uzaQ7QyiKPBtaEmPBzMe8VPVshDtUfGAsjkczLibA+q0PF7ncX
         uyStgEzStJOfxLs2HB1dw7v/3fsfFBeAwFkmGXQWeRWJjWq8LyzpLIucTR8553jUQuMF
         Nwq3fMIe/+uez0hle6LnliO/SL1zEGaWQ3goj1x25LDdW0i7IGY4xsZm0eVEkWXVEg+n
         3jegQH01PwQMT3jvUWvEvPWto0EwVCr31bs6ZrdXq43ItiZaZou48TUI63sJ7QdKYl9W
         A4M+rMuUb5R8zoAj8igLuVmanBQN0qU/fMgXIm7wZXNdmCkKGKTEtDDgbpbLfGtFuc4v
         AWmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN+KDTZi3+1uTGRL4I2yDkb11riHgq5kWWHy+uIUwb2BdMJ3aopTF6TzEmV2zwsF7y9V5ObIA4+u7k@vger.kernel.org
X-Gm-Message-State: AOJu0YwvbRb85+MmdfebzVKDsfe0EeOl++PAh5tSRB/J8o+T1PREIzv9
	JKUkkhL25UfhT+mCxOLYxvKFsADlpCXfmfgp2qUAF+RPi3uhSgfcL+Nl
X-Gm-Gg: AZuq6aJ0fN0B5oHPP/5kw2wwGX0Gl8bI1147HxEG3atISI9FseSJAh7xRPDF4MQ+khY
	Irm3RVSzMljaPrHymGN5JzfQkWsIrgMyqcD9XZpAOgZiQ/NtBWHBlyyZSQzesfptY0BMK7SRqur
	yharqahQq+tT9xilb/3OlDima5eoRKKZ07howCOCWc+KrK74Grp9Ci4N2RKqgsZsK+LcLCdR/ve
	91OCa2Tqi5JofKJ+IAHRoM8ZOz2Q7f1DXkToh883VNyiyArf+onEPjQZjr57i3GbLMcj7c2eKXY
	HdizuXria6oq6H1phg4NFVJC2g02l5PAmJJMt1IAEQieosF/DWxUG/sFa3NkPSrD2d9TCuIxu1H
	Wfo5Adx0/v6U6bQcZz1t0Yk5Y5lHiQwSJAKwtompzoSTr+38JmmiPHnJ29mzhcUZxVvYElSBKPB
	EPAEbNHRzcA0IWKfjFeiH1o2ckp0KmPNWOCNk=
X-Received: by 2002:a05:600c:8719:b0:480:1aae:676c with SMTP id 5b1f17b1804b1-48069c78706mr7026885e9.18.1769495209781;
        Mon, 26 Jan 2026 22:26:49 -0800 (PST)
Received: from [10.221.205.245] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c37420sm42358365e9.9.2026.01.26.22.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 22:26:49 -0800 (PST)
Message-ID: <85b9a197-9957-4646-8f97-5aa4d90eb415@gmail.com>
Date: Tue, 27 Jan 2026 08:26:49 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx4: fix MAC table total count corruption in
 __mlx4_unregister_mac()
To: Kery Qi <qikeyu2017@gmail.com>, tariqt@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: jackm@dev.mellanox.co.il, ogerlitz@mellanox.com, monis@mellanox.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260122183906.2015-2-qikeyu2017@gmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260122183906.2015-2-qikeyu2017@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-16047-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8254790630
X-Rspamd-Action: no action



On 22/01/2026 20:39, Kery Qi wrote:
> In __mlx4_unregister_mac(), when operating in mf_bonded mode
> (SR-IOV with bonding), it appears that the code might be incorrectly
> decrementing table->total instead of dup_table->total when cleaning
> up the duplicate table entry.
> 
> If this is the case, it would cause the primary table's total counter
> to be decremented twice (once for itself and once when it should
> decrement the duplicate table), leading to counter corruption.
> Over time, table->total could become negative, which would
> break the "table->total == table->max" fullness check in
> __mlx4_register_mac().
> 
> The registration path correctly increments both counters:
>    ++table->total;
>    if (dup) {
>        ...
>        ++dup_table->total;
>    }
> 
> However, the unregistration path seems to have a typo:
>    --table->total;
>    if (dup) {
>        ...
>        --table->total; // Should this be --dup_table->total?
> 
> Fixes: 5f61385d2ebc2 ("net/mlx4_core: Keep VLAN/MAC tables mirrored in multifunc HA mode")
> Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
> ---

Hi Kery,

1. Commit message is phrased as an RFC, with questions and uncertainty.
Please re-phrase.
2. Do you hit an actual failure here? What are the steps? What error do 
you see?

Other than that, code LGTM.

>   drivers/net/ethernet/mellanox/mlx4/port.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/port.c b/drivers/net/ethernet/mellanox/mlx4/port.c
> index e3d0b13c1610..6d0295c471da 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/port.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/port.c
> @@ -410,7 +410,7 @@ void __mlx4_unregister_mac(struct mlx4_dev *dev, u8 port, u64 mac)
>   		if (mlx4_set_port_mac_table(dev, dup_port, dup_table->entries))
>   			mlx4_warn(dev, "Fail to set mac in duplicate port %d during unregister\n", dup_port);
>   
> -		--table->total;
> +		--dup_table->total;
>   	}
>   out:
>   	if (dup) {


