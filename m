Return-Path: <linux-rdma+bounces-17019-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AMjHVUol2kzvQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17019-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 16:12:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CADCA15FF8B
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 16:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF80230A1B04
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 15:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A50342C93;
	Thu, 19 Feb 2026 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUuf7ZQk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxrYFPR0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FA3342173
	for <linux-rdma@vger.kernel.org>; Thu, 19 Feb 2026 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513546; cv=none; b=XkrLuPwnFFfY6a8ib0OzfF3Oom07akuPsskFjrAQGsUnykdYD2JV0KDHfV2uXInICx++TAYvYFP6SqtxxSSMRLjm4tx5kM1R/hqC1UM7jGwCGGVmESVh4SjYQIImRs6897CoUZG0QDugPw8utZiLLknpmq/NOyjvNqGIOwho6no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513546; c=relaxed/simple;
	bh=cce/zifKfmgKjVV6lwdn39OJsFMeWZN04HUOFS0vPgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mk7RkuAAZCYQq9QjhffPpUYnRTLVbqg8sjOBdL6VrDhGZ6/+1pWMLgk0n8MAoJjoYYJGrVmLagvENM+PgQlZvTKHgwwAD1hOaNEEc6R9ustwSU2NAvocfOCDQSsesLTls5qRAfbuSoS5YluCqfhkQHRn+haXLyMD7vRSxVWS/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dUuf7ZQk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxrYFPR0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771513544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBfP4rTXp5LfAA6VjireIexSouTNu/Wt3OlChivmV3k=;
	b=dUuf7ZQkC1cczuM0KZ0RIhMWX4vj8ZNZ4CouaYYgMn8Oj3VK71kMPKZcwsvw3OB36YEIS9
	e6FFndj7uYqTMdr1AyfH//vNrC8f3Db9ksuPnE1Dl8EsPdGTe+4YAWx2SvRSFdyosSLsOp
	w4nS/FBmn6PY3F+8ZU4bRpU4bKfT+zc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-HazwuDATPViwZEQU_bT3pw-1; Thu, 19 Feb 2026 10:05:41 -0500
X-MC-Unique: HazwuDATPViwZEQU_bT3pw-1
X-Mimecast-MFC-AGG-ID: HazwuDATPViwZEQU_bT3pw_1771513540
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4837907ec88so16708705e9.0
        for <linux-rdma@vger.kernel.org>; Thu, 19 Feb 2026 07:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771513540; x=1772118340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zBfP4rTXp5LfAA6VjireIexSouTNu/Wt3OlChivmV3k=;
        b=CxrYFPR0g6lNcDnDFEUik3cStyWmQgEvoR418Dxpe03RXIj0qkpoPkjp0n4m0Nlquk
         WbIHiSTQlBGn4xzEVwpP5jtsiLHR/FnxlpUgMtdpCUBrRXeC2DwlqSq0HZFiO6ACw9pT
         HH8Suv+jAnpfO41ud77Pzo6E9pChL9QVPeFpAAhdLFpPjKE/C0ZKnxFKaBzAG3/aKNIy
         GF/uoYQddyuky+mfMTITLOhz2wgIVI+SeYeWfKUfyNxEpG4hXKqnyXuVIPupV4ybtDuS
         QKVGkPZf3GDhV6cFhvhIzSduOqycyqEtDy52VXD8BoMvTTk5+q/smXa5qKgLGQH5Ht+H
         IKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771513540; x=1772118340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBfP4rTXp5LfAA6VjireIexSouTNu/Wt3OlChivmV3k=;
        b=cFbif2pegkx36SjgolIM+i6PSQyFOmb1zUpkRpUm7Ugu+qkUai5jLOG3y983FXBhyK
         p30e1j9HLidOpDiGc63GZoRcwwfYg0Tzqw6lFfDd6ex9xsT69+OnNsm2MeSMg2ZZXBJL
         bzd6iJY4g49w/zc9O61RkxgizbA7F9yWVtKI92zd6hvYoqj5P1l6bB595FzHZRjUUfWD
         6wjTrZD54z5hO3BT5/tP9BtqGMj44Ucye7O1piR5QU79H5fSx/Ur9L3NPxoDev8hX/xJ
         3nhqki+vY/fD8rCJq/UXQ7fnJJVvE7QMvLhL7vfUe3E2/O/gkAYj1w7aX5Mk0ycSlpjr
         z5gg==
X-Forwarded-Encrypted: i=1; AJvYcCVkXMKFgWIzy64lHOFikGqGrUrI4YyOFcMaExGLMlZfKtS/sQOeA0PeeP5ureTCPG7dxYnJxnEb4c/J@vger.kernel.org
X-Gm-Message-State: AOJu0YxFvO11QDG1ePvBSuhGkREqp1QgpxV/ZlCvobfw6PrhtQocVrUp
	kJblesECaYJWhXVrfhu6ldqYUIrlaDDm28KZm1O680VNRMY05SDgGIifLduJ2DuFv0Otoa4GGxg
	OGtlCF3MdnF2j8d2CRwaFTxkqXoUKmbd2PZN8q57ELO0U1B1abLeBnVnrJdY2PWM=
X-Gm-Gg: AZuq6aIdo2p+M7p8JXbjOT2L6TrY/dlWNk0BALsYoT0v2wOncv98FePFlGCQbclmvev
	ebl5KUnTqcTdTFkz87614ymguXLtg4n2MeJg7kgq3OmJYCay1wL39SXoW59pRwumm08KfSYOBXa
	8qzY4Gh3rQDClixyAQiSVdHVeGdOK768BDXCgZKyekKC5yWbagDnifyafdGgh3UQlNqlqYPI0cu
	4mSedvEBMQpdoou36Uk7ZgTFAV6hSdMKZTSbPAEnzrlG9jFxluwFn1lavVr2kGgHm8HiUA7SeAf
	Ds92RvpsGqnwF64zlkwBzANX9Mw0x4QvTto08cx5RMhTjMw4wTAfxhEXTmL6KxbF5fvhGYLzfSl
	4CKoa7DpJjAlXMIby8vBzC6VV
X-Received: by 2002:a05:600c:5248:b0:471:1717:411 with SMTP id 5b1f17b1804b1-48373a3f1f4mr377947975e9.24.1771513540053;
        Thu, 19 Feb 2026 07:05:40 -0800 (PST)
X-Received: by 2002:a05:600c:5248:b0:471:1717:411 with SMTP id 5b1f17b1804b1-48373a3f1f4mr377947375e9.24.1771513539498;
        Thu, 19 Feb 2026 07:05:39 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839ea386dasm30256405e9.1.2026.02.19.07.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 07:05:38 -0800 (PST)
Message-ID: <d6c39208-7a7a-4588-b976-941112d6869b@redhat.com>
Date: Thu, 19 Feb 2026 16:05:36 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] rds: tcp: fix uninit-value in __inet_bind
To: Tabrez Ahmed <tabreztalks@gmail.com>, allison.henderson@oracle.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, gerd.rausch@oracle.com, charmitro@posteo.net,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com
References: <20260217135350.33641-1-tabreztalks@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260217135350.33641-1-tabreztalks@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17019-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-rdma,aae646f09192f72a68dc];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: CADCA15FF8B
X-Rspamd-Action: no action

On 2/17/26 2:53 PM, Tabrez Ahmed wrote:
> KMSAN reported an uninit-value access in __inet_bind() when binding
> an RDS TCP socket.
> 
> The uninitialized memory originates from rds_tcp_conn_alloc(),
> which uses kmem_cache_alloc() to allocate the rds_tcp_connection structure.
> 
> Specifically, the field 't_client_port_group' is incremented in
> rds_tcp_conn_path_connect() without being initialized first:
> 
>     if (++tc->t_client_port_group >= port_groups)
> 
> Since kmem_cache_alloc() does not zero the memory, this field contains
> garbage, leading to the KMSAN report.
> 
> Fix this by using kmem_cache_zalloc() to ensure the structure is
> zero-initialized upon allocation.
> 
> Reported-by: syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=aae646f09192f72a68dc
> Tested-by: syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com
> Fixes: a20a6992558f ("net/rds: Encode cp_index in TCP source port")
> 

I'll fix this while applying the patch but for next submissions please
avoid any empty line in the tag area.

/P


