Return-Path: <linux-rdma+bounces-15935-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JMkKVXEc2kpygAAu9opvQ
	(envelope-from <linux-rdma+bounces-15935-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 19:56:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB41A79E3C
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 19:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 41433300721A
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 18:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDF526B2D2;
	Fri, 23 Jan 2026 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbX3Hzxm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CA8254B03
	for <linux-rdma@vger.kernel.org>; Fri, 23 Jan 2026 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194525; cv=none; b=SNBLoJpGMa1mK3jRHvEYKxASL2m2L0w8pQn2H/YN+3JbiO8/7usm/McZf1d21tI9p792YtdpaxmhYvXyrqWLz/qnkH2C0eLSCeD2HubhKKF69tlIQPFbizdT203w32o9ckBM7qd/60aniP+SlG5fr6+ZcFtswr0gtkW2Jbs6mU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194525; c=relaxed/simple;
	bh=DC9rNWfCiMVA2t6yQSZiMua5nMrtCbgvS3iX2Q0nBVQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ii9ZKanRe9DvHw7A7Dmc+AVz/rUZgUoAhwrSl2yIPdN6MHFj0PuaRUHDhmutMBHXRcDKp/3lwpbKugMGzplcNndGXpv/jJiHdmmIbDT1DSjyNgrwnFH+d+8hu7MHPc7rKahp8n5Taa3pdZ/p6JL7WrqoIQhXfC+lLAkYdd85C8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbX3Hzxm; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59ddf02b00aso2619193e87.0
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jan 2026 10:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769194521; x=1769799321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sEFLsQyzoxdu1YcF2YnABjIcE2WnszBPzD975tlZq2A=;
        b=hbX3HzxmSjZs0kxJC1leAATZIT/Xoow9itXABRslTbdvWKXxVbf9FgACKRAUohART5
         c+/KhLstQptagdMm2+dVRSj99UJALMJqu6aElKnKrlIfQKcSnm9n6M+x8xL0NEDZVNBc
         BHvy4cNui71qy62OsGzU0LlW75bXUqIkwb0mg/sok1rGBPGqWitCbFfl8tl8fW37AhLY
         zORwkg21YCxcEUST5orrzEn4/zyXDJcPks80p83e47ceQjlUIJFmH6Q2QBZ+A0hv6WIg
         lXspZkbair7Hlq595gu1EBJ+yN5zIeaN2E3rej8T2yjmsE/jK7lRAc4JRZW5BtMYhOMo
         ZIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769194521; x=1769799321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEFLsQyzoxdu1YcF2YnABjIcE2WnszBPzD975tlZq2A=;
        b=nStB0LKcY/a44iLuzikGUbhDYoosRTaKzZEXjZRpXJz0PfdGoH45MeoSQCMf2Z6e7h
         ww0ZO3llz1qBWpZ3Bf0U6ZRo7lD5SQG7i6xbpAI+tY5BWMf6kHkN8vaaJtUAbEdNCG0U
         /lr/k9imsEYSBEcoZo46H4fyh1MnQtImYPfp7rp2O50TxMz1sYo8dBAWmlDD8c3X+nYO
         jd/Ga7UdmEJ/E8F+LyvAr+fKguX27xxBiVIknTwH4s205Rz97OlOsWBRfPGKzxff2ZqB
         6aYEMS7uJABFqH86oTJPzVnZx8B49id7aq0trlesAdtVS/5YNLUBJrZYJrly2o7rRxyA
         zi+A==
X-Forwarded-Encrypted: i=1; AJvYcCXZvf/BpcwnDTQhPQoWzYPUX5fJNsrQF0CS4igQkP2lLe8OIx2lhlSgKi5C177Uh8QMFr110RMi4GvS@vger.kernel.org
X-Gm-Message-State: AOJu0YyX12bNnqrYO+NKFwkdkSRBwCV5CjhdKf4JQNjldPmjpBLx7UAk
	tTXy0HfmTNXYG9Z4gLrOX+hTfz7R73ayMD1k40lOv9QAkKBMtYI3ePpO
X-Gm-Gg: AZuq6aIWTdNhR7QqL+Lrvzb9zvJuFBuC64qEfdYQIWRgo/k0O21n+WqUuXHLJbOdWsg
	0UnU0sUTOcL8AKnm3f5RxIOkuFjpYSr/z6H0AWekmlOsWKhqEKFfrjQ3x5ulkR+dFUQLWwdNTlz
	hARjSEGsumGphGLZzwwiwV0K+ZPWWa72fU3PZlgnt+cZOYLEpojsyAZSnbNOvyaaD+EsZo5ux01
	Dl3W9jckKHMuJuIsCvfY8RLQepTC52BS3bqh10sX5T+BUqlpe3ux79sO6fMlCvg3l1YTmmjiGGh
	Tn8SHMtP3OMqCvMHeVC6vXnecNMi4slynlqbCwzMXwqctLJ1U7/wzlTA63NsU5RSL3jwwDDJ7Qg
	DliyxvN+Ivl8NwCwPjWvelxxKDR2roxw739VXVOQ4cukSGu0wluY3
X-Received: by 2002:a05:6512:2254:b0:59d:e7b0:cfc with SMTP id 2adb3069b0e04-59de7d7309dmr849185e87.15.1769194521113;
        Fri, 23 Jan 2026 10:55:21 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de48e6023sm848831e87.32.2026.01.23.10.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 10:55:19 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Fri, 23 Jan 2026 19:55:17 +0100
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH net-next 2/3] mm: vmalloc: export find_vm_area()
Message-ID: <aXPEFdEdtSmd6AzF@milan>
References: <20260123082349.42663-1-alibuda@linux.alibaba.com>
 <20260123082349.42663-3-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123082349.42663-3-alibuda@linux.alibaba.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15935-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,linux-foundation.org,linux.alibaba.com,google.com,kernel.org,redhat.com,linux.ibm.com,gmail.com,vger.kernel.org,kvack.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[urezki@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB41A79E3C
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 04:23:48PM +0800, D. Wythe wrote:
> find_vm_area() provides a way to find the vm_struct associated with a
> virtual address. Export this symbol to modules so that modularized
> subsystems can perform lookups on vmalloc addresses.
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>  mm/vmalloc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ecbac900c35f..3eb9fe761c34 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3292,6 +3292,7 @@ struct vm_struct *find_vm_area(const void *addr)
>  
>  	return va->vm;
>  }
> +EXPORT_SYMBOL_GPL(find_vm_area);
>  
This is internal. We can not just export it.

--
Uladzislau Rezki

