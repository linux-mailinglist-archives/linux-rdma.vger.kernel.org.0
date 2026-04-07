Return-Path: <linux-rdma+bounces-19099-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ExMDGwb1Wli0wcAu9opvQ
	(envelope-from <linux-rdma+bounces-19099-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 16:57:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 700123B079B
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 16:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 434F83018297
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 14:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F71833AD9B;
	Tue,  7 Apr 2026 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ivY6AZaS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FB0328B62
	for <linux-rdma@vger.kernel.org>; Tue,  7 Apr 2026 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573505; cv=none; b=OE1YIVEfETZLcr+tKKUOxpKn/MpObusJf8KqeqHQGwNj2yDwx5dn2XVKIGTGcvaR66jypFAv3CMKeq1G6dmMitSJoQOQksMrEPjz5iwf0/K9pYrfR8nRp+HaGSyiKcM1ky9JsyZNdQ86NnRBIdVwz/8TBIBGOddQTsRcvSx6Wvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573505; c=relaxed/simple;
	bh=hPzP6FPBI+v51e9jMZwhfv5eRxOWnEE+ZBzGiZMDf2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFrPLtb7lNrLZuiiIZJ92T4zJ2uZbCwXg0QdwmdEeizTESaTgDRn0YJbzUIvIyCMtSjCZzbwcQCbLYOCgb/Qjw6SsQr0fIq/nOX1uZT1INJBzZUUYnuDygOZQfdfh/5w7CjRahKohuWoN6Mhm9+8lRDFvVa1V2FsWp3OyyZBz2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ivY6AZaS; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50d9436f2adso21671371cf.3
        for <linux-rdma@vger.kernel.org>; Tue, 07 Apr 2026 07:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775573503; x=1776178303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffmlkS1J4vKNnNQPds9pMEBt93EMdhr93/BmsfLpcAw=;
        b=ivY6AZaSWDkweSvuoViAqe/GP8a2p4k6mn7AuE7MI46H5bMpLa9hDomCmgszGwKhsv
         PwV7av9hHTvNTsT1ruZa2L5q34UuK26PseEL38dUg+qSug+GHmcrcr9qr3Ok1FBiTe39
         I5EPWGb5uQTjgaW5W2aVC4sPVuFXpLad5g3LE6/1vzsb1m0UNkRMBWPoEXhKdVT/CsBE
         eGqzY+3gG/idP1eZ5XKsipvkYE9kLzw8VFpgLY7bWM74tQY+Kim4JkXAAv0Afjh10Ycy
         GfWpX1zv4razHYfp6FHz6H9hBM+0Ulc+97E6jjdZF4GZ+8Uf8cs0TLuSNuZCO90FnNJM
         WXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775573503; x=1776178303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffmlkS1J4vKNnNQPds9pMEBt93EMdhr93/BmsfLpcAw=;
        b=ZyN9pp3EtTJ6uoSwCxC5FyZo0peZvqXa5bflThWvPygxK41dHXlj/Su6P2I4JS6dV5
         TwZbC464N+e3FkPFEUIYxuZjIqnRQomY+QQcxzqmwIh7dCiG10YS5mruZKosrW8rzcXM
         cyER9BmBCC/Xkqe9u5WRd0zHA6Cwyn1SBTI18991dNim8p1UEWAeBm6ivxXc0tWv54pj
         k7IHJh1ZsvC9qOPR+hejU+pkZFrwTgiJbSIoKvy/90bsSRKY3LxsYnjQ7+nrc6jNsBmC
         9Flbq0Vwwr6eey1OWCHpSShy31eEfzXxk6eX96g7/P3YqekNV1+T8rWNPhwR5SLJWdVD
         Hvzg==
X-Forwarded-Encrypted: i=1; AJvYcCU8cj/qUNREYQvCNKhMSfF2iuWJJJsLHWS8LEs8Z9MczkHTf+PSXVNR9SoxYbTS3bW+dMIqMhgVt5zM@vger.kernel.org
X-Gm-Message-State: AOJu0YyXgGytBwfYxM31TTSDpIX4UDCgrDGcVaYgWLqk6DP1CVAOMX/5
	490jlvlxjhRzlb7NnjmiohH+o4erA3KpGN4CmsuPRPwyrL3pGf28LlOkiAs2CnlAWO4=
X-Gm-Gg: AeBDietG0DXZDg1KcJkWNDXoqNOnjsjYKDH/mJq9La6M2W+poO6Mo8IBVr51TIk69vO
	NrEkHd2wExvrxQhwJjG9PAhLm2Up3dsWXHD2gxaGJMCnlfwpkCzoFNpPit31vt7ApqKnBCzySrd
	UzBP/FT/1ft3OyifB6KidZP1b/MpPHr9xCJbw9s1NLrF8RoCSqX1h15TVvMs1YKKtVCetJbdv9f
	MKw+uo/bv6tG1S4LAB+PBpwKnKGEmtxezMvt0dWb7kYyVxdFCu0IV6GzDJt0sUQ6C/ICXV8F8jC
	QVYNJIEtCZPC6jMLjRt6NM/SBvXubGF+txjRHmrhzEFaDDmc73kD0NKbBgSxccAyLgw4G9DBzpy
	YD02oz95WjCRvLFRsakX/Cmy0WBO2nPBhlYeBZ+Hlcm3+DzK86cqg637faE10+RmRRbGek7f95m
	TnNPDHWgSsKfSQZ/LYIzyILSB15gigHV8RIsNsZlVd2dqovdx5r081yDmaipYamaZLNUWAGg==
X-Received: by 2002:ac8:5813:0:b0:50b:551d:ca7a with SMTP id d75a77b69052e-50d62d18253mr254520441cf.52.1775573502689;
        Tue, 07 Apr 2026 07:51:42 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d63962a65sm109809501cf.8.2026.04.07.07.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:51:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wA7mE-0000000EQQV-2yYW;
	Tue, 07 Apr 2026 11:51:38 -0300
Date: Tue, 7 Apr 2026 11:51:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: zhenwei pi <zhenwei.pi@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	zyjzyj2000@gmail.com, leon@kernel.org
Subject: Re: [PATCH v4 1/4] RDMA/core: Fix memory free for GID table
Message-ID: <20260407145138.GP2551565@ziepe.ca>
References: <20260406132830.435381-1-zhenwei.pi@linux.dev>
 <20260406132830.435381-2-zhenwei.pi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406132830.435381-2-zhenwei.pi@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-19099-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid,linux.dev:email]
X-Rspamd-Queue-Id: 700123B079B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 09:28:26PM +0800, zhenwei pi wrote:
> Remove RXE device, kernel shows:
> RIP: 0010:free_large_kmalloc+0xf6/0x140
> Code: 75 28 0f 0b 44 0f b6 2d a5 d6 d1 01 41 80 fd 01 0f 87 7c d1 ad ff 41 83 e5 01 74 3d 41 bc 00 f0 ff ff 45 31 ed e9 61 ff ff ff <0f> 0b 48 c7 c6 af b1 70 83 48 89 df e8 79 0a fa ff 5b 41 5c 41 5d
> RSP: 0018:ffffd038c18074d8 EFLAGS: 00010293
> RAX: 0017ffffc0000000 RBX: fffff86984219d00 RCX: 0000000000000000
> RDX: 00000000000000f0 RSI: ffff899b88674000 RDI: fffff86984219d00
> RBP: ffffd038c18074f0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff899b88674000
> R13: 0000000000000001 R14: ffff899b88674000 R15: ffff899b86180000
> FS:  00007b163c71c740(0000) GS:ffff899c378bf000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007b163c730200 CR3: 0000000106a1d000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  kfree+0x163/0x3a0
>  gid_table_release_one+0xaf/0xf0 [ib_core]
>  ib_cache_release_one+0x66/0x80 [ib_core]
>  ib_device_release+0x48/0xb0 [ib_core]
>  device_release+0x44/0xa0
>  kobject_put+0x9b/0x250
>  put_device+0x13/0x30
>  ib_unregister_device_and_put+0x40/0x60 [ib_core]
>  nldev_dellink+0xd3/0x140 [ib_core]
>  rdma_nl_rcv_msg+0x11d/0x300 [ib_core]
>  ? netlink_bind+0x141/0x3a0
>  rdma_nl_rcv_skb.constprop.0.isra.0+0xba/0x110 [ib_core]
>  rdma_nl_rcv+0xe/0x20 [ib_core]
>  netlink_unicast+0x28d/0x3e0
>  netlink_sendmsg+0x214/0x470
>  __sys_sendto+0x21f/0x230
>  __x64_sys_sendto+0x24/0x40
>  x64_sys_call+0x1888/0x26e0
>  do_syscall_64+0xcb/0x14d0
>  ? _copy_from_user+0x27/0x70
>  ? do_sock_setsockopt+0xbd/0x190
>  ? __sys_setsockopt+0x72/0xd0
>  ? __x64_sys_setsockopt+0x1f/0x40
>  ? x64_sys_call+0x221b/0x26e0
>  ? do_syscall_64+0x109/0x14d0
>  ? exc_page_fault+0x92/0x1c0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> GID table is allocated by *kzalloc_flex* instead of raw *kzalloc_obj*,
> it also should be released in new style.
> 
> Fixes: 74e2711bb2af ("RDMA/core: Use kzalloc_flex for GID table")
> Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
> ---
>  drivers/infiniband/core/cache.c | 1 -
>  1 file changed, 1 deletion(-)

Applied this patch to for-next

Jason

