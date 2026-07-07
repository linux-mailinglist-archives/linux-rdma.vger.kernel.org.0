Return-Path: <linux-rdma+bounces-22859-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VrvhH5pYTWrAygEAu9opvQ
	(envelope-from <linux-rdma+bounces-22859-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 21:50:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 791C671F66B
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 21:50:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=p7CHO8t+;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22859-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22859-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C1CB300A5BA
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 19:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA173B27FE;
	Tue,  7 Jul 2026 19:49:42 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A052317D6
	for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2026 19:49:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453782; cv=none; b=qXImjuJf34H0tPgfLehfMhKW+qCz0Q4rkS6xjQWXTyKjaNLh/KeIFLkYwpfSlrULfgTOoj3sQt0jaJ9Izm9TKBr60LlzAFKaRCP1HI64ES2ueCdP/pcH0JRmwdE0a6BejPCkxewKEENY6krnDM5fLrcVs3CFntrytMTi4pZjPdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453782; c=relaxed/simple;
	bh=cWUDemI2fy2468Rcc9hA4tMRSKDMQfvaEw9RCKkrqaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5geZ/A7oy2sOSrjiCYV9PWQg2ewUnTjinmDh1Nf8C8F0PdGYcQgQzoDp14ni5tmKJ3zTL8Eehcd1hkIkGo9iI/LOq4JkHiKZIUm8pl7LYcLyqNyXYkRfdB7iYRLL1owcXTS2JNErKL/T+c+z+u5pDcRujUeqFxLoiiazgopWLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p7CHO8t+; arc=none smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso1783017f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2026 12:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783453779; x=1784058579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F7TEXP25/oGnwFyrCpdS4x0e3KbTeuTKFgjnVzacGG8=;
        b=p7CHO8t+ngkbTlk6SqV5aC3s1O1EXgcx9lqvtL59ws2LCl8KvQ+uSrtfD3rDNwyL//
         9mNqeENsDqNAbl6jaWlJNlflIijcYNgmHb/CBtZ59ngpvVI85Vm551MygoLf8P/ms/8m
         vUiA28SA139tU42HoeTbXF9KbWoAmYkvYNj7mdqnYuudhb70xHLO08ScaO8FKzVfYn7o
         4AExCPFLqQiZPPBUBcgTsAmejVSXtdsplbxFVTp3bvHqqcqJT3OFkZwx+C7puxAMuzLI
         LpgKzDj+B7DSjEb4JSj2CFax0SWYOhQPeuU7QyyVnOJSsrcxMKwjS9UjhbT3uSwG0bsL
         6g6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783453779; x=1784058579;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F7TEXP25/oGnwFyrCpdS4x0e3KbTeuTKFgjnVzacGG8=;
        b=oFNNoCOCAxUP9sE8cLzG5ptg6bw+RQutybZnYDC1XJydZYX54I49i5DKjvqXSLflAZ
         Jc55O3zuoxXnWtgXwaHBVUL12z6OzCA4iGFkhLroS5ecziBbn9KyoKMWEIGQ/tve4CqA
         XmhqC6fdbhTPWulFs/HgOzYDIym7+P/bHfhj+tNBHSBrunSm/sWgNGFGjuHJ6mPGgLoI
         wqJm4uqh/6ZgC/xDHnufgY0IrOWIqqnVtykQD29HXfc7CTybb4Wac/X5FIwQIuK7kPRX
         YGtNBgdVRuyWckvGp46VQSioaGxHbvEwXTjSFIOHvgkeKh2rNcy7P8/7u87pu8K/hi+X
         +XDQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro3MtYDOPbUw2wPxFKw0t2IIPTtGef2UZSqVCtM1LHe5Mn4LiKt3s0WzraXDot3pQYEs6366GSJiZ/V@vger.kernel.org
X-Gm-Message-State: AOJu0YzPa1wtolZWZdKJ95swEGyiEj5g7wTO374J0mL20YJV55t6HLo4
	eLcvX4cm5/fVSKWt8ixWpNO51ql3b+DQCh77SmCjADRrlBQcZBw+BfWT
X-Gm-Gg: AfdE7cm1QLDFP/pia4h8Ulpf/9pMh2k0OgqzccgFhA49ahJ1IIsE0bJBL/tD4+rmlfp
	jSgO2NgJ1abJ1aYmItJuGI61KquAtXkiiM806xzmC2vQochQVi9bOkqy6hP2ta5D5ZpRjpm9KT7
	/Z6kbtExSqWe6TSNeX36JGoQ5+VxkOe75r4qji4V4OytUNYraKFE5dHbMgJrabg+sApG2Gglbmq
	50erjoPvSh2GtP1OxVr2zp0HGHPZuF4Bk7Ph/o9l5Qcx9NS54Dl3dmWBsVw7w6n0ovL93ST3uBR
	ArbSSH8JivkVGPgi23uvzGYfVagzy5X7/OKP428tRO/EqjfbV9caxJQKI7tMozMx5LAurS49JUJ
	a1CpHyNyczINZB5///YZl3GwovFh0l/uSy3lf33NdHb9WF2HOEn22uZatanHsb7ptY7DHFo6iAy
	oPFcj9x3jPfxm+pJGwNJkAjM3daBkPYKunVCkd30M7u+pIDA==
X-Received: by 2002:a05:600c:8b6e:b0:493:a5d4:3798 with SMTP id 5b1f17b1804b1-493df0663fdmr71499135e9.1.1783453778982;
        Tue, 07 Jul 2026 12:49:38 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f294a6sm153839565e9.1.2026.07.07.12.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 12:49:38 -0700 (PDT)
Date: Tue, 7 Jul 2026 20:49:36 +0100
From: David Laight <david.laight.linux@gmail.com>
To: <Alexander.Chesnokov@kaspersky.com>
Cc: <xuhaoyue1@hisilicon.com>, <lvc-project@linuxtesting.org>,
 <Oleg.Kazakov@kaspersky.com>, <Pavel.Zhigulin@kaspersky.com>,
 <stable@vger.kernel.org>, Wenpeng Liang <liangwenpeng@huawei.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Xi Wang
 <wangxi11@huawei.com>, Weihang Li <liweihang@huawei.com>,
 <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/hns: Fix arithmetic overflow in
 hns_roce_v2_set_hem()
Message-ID: <20260707204936.6a8e5c35@pumpkin>
In-Reply-To: <20260707140938.3106919-1-Alexander.Chesnokov@kaspersky.com>
References: <20260707140938.3106919-1-Alexander.Chesnokov@kaspersky.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Alexander.Chesnokov@kaspersky.com,m:xuhaoyue1@hisilicon.com,m:lvc-project@linuxtesting.org,m:Oleg.Kazakov@kaspersky.com,m:Pavel.Zhigulin@kaspersky.com,m:stable@vger.kernel.org,m:liangwenpeng@huawei.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:wangxi11@huawei.com,m:liweihang@huawei.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22859-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,pumpkin:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 791C671F66B

On Tue, 7 Jul 2026 17:09:38 +0300
<Alexander.Chesnokov@kaspersky.com> wrote:

> From: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
> 
> If hop_num is 2 or 1, then the expressions like
> i * chunk_ba_num + j are computed in 32-bit
> arithmetic before being assigned to a u64 index field,
> which can lead to overflow.
> 
> Cast the first operand to u64 to ensure the arithmetic
> is performed in 64-bit.

If the values can be 64bit it would be better to just make i/j/k u64.

	David

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: a81fba28136d ("RDMA/hns: Configure BT BA and BT attribute for the contexts in hip08")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 1c180a6b1c07..b62513b4db09 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -4257,11 +4257,11 @@ static int hns_roce_v2_set_hem(struct hns_roce_dev *hr_dev,
>  	chunk_ba_num = mhop.bt_chunk_size / 8;
>  
>  	if (hop_num == 2) {
> -		hem_idx = i * chunk_ba_num * chunk_ba_num + j * chunk_ba_num +
> +		hem_idx = (u64)i * chunk_ba_num * chunk_ba_num + (u64)j * chunk_ba_num +
>  			  k;
> -		l1_idx = i * chunk_ba_num + j;
> +		l1_idx = (u64)i * chunk_ba_num + j;
>  	} else if (hop_num == 1) {
> -		hem_idx = i * chunk_ba_num + j;
> +		hem_idx = (u64)i * chunk_ba_num + j;
>  	} else if (hop_num == HNS_ROCE_HOP_NUM_0) {
>  		hem_idx = i;
>  	}


