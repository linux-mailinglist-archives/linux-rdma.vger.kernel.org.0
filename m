Return-Path: <linux-rdma+bounces-10521-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32EFAC07E8
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 10:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A50B77B2160
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 08:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717252882D5;
	Thu, 22 May 2025 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LV1/ns3t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EF8286881
	for <linux-rdma@vger.kernel.org>; Thu, 22 May 2025 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904161; cv=none; b=W/QbzslP/jafwuZtu0ge6BM9Tx+L0qE8Br4vFSav5PqcOXNR+a8PnxTEM3ZQnQ0Z/Vfr7n+9QdRHN9pa9GLyISiwHitWCGZX4KY8ZPXlqwxpf8vdFewwM31lQMZLw3Pp7I+hXSaHymvhv2ouALMrBN4OrMOqM2fElORNMIjavDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904161; c=relaxed/simple;
	bh=4ASId0JH+VWWZL3IFUBP1dU99/1eNzfiw9x3qfiCG40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwXB6NTL6ayHCbzA2OrKqCIFbEQvFcaZ6C3yH0jCO2BBzwcFNxappTM431mtQu+pgZ8wnAdgu7GxdEh/FEh/wtDYGDeZC32EQQSnUt/edQeSbWMQ+JoF+TzLY/20GtsmOUmkieSDDOAtL0WcTCY4pZUd+3UfOamEQhuoM6BZCu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LV1/ns3t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747904155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6pino5Ai5bwBqjPAZpAdwxhzTr0aiQB3uDnJ8famwHw=;
	b=LV1/ns3tEUTdnQRIhJjnhUS4xwJrOqgOlqbATjRcQ5V2CHfRaA5nRaLPj7C2Hef3zqbg+E
	Lrdr4kbCtX+6JEWqys4Myd8xW2rMi+E+SfyxzwteSGcIKUOseQ2UmGJKWpQK6IJIbUY1/Z
	JqVK1ZVZFNtpQvSHIoh7xDQDm54cIqU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-THp-QkH0PlmRlfbc3_UwHA-1; Thu, 22 May 2025 04:55:52 -0400
X-MC-Unique: THp-QkH0PlmRlfbc3_UwHA-1
X-Mimecast-MFC-AGG-ID: THp-QkH0PlmRlfbc3_UwHA_1747904151
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442fa43e018so34539405e9.0
        for <linux-rdma@vger.kernel.org>; Thu, 22 May 2025 01:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747904151; x=1748508951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pino5Ai5bwBqjPAZpAdwxhzTr0aiQB3uDnJ8famwHw=;
        b=qmXRTqLAm7JjBmWFNwSVCJmD8arYYp05+qNCivaY2AREpB+aPHGqYBjoFSZQw72Tzq
         uBjxp80PX7Zhq1xu9vFPRdKo5AkcxT/yEhDh9iVSdym+Wxufe/agvt4KPcPv1NNFLqHk
         bXkljJA/PuuMwiIWe2zYdglaBlneiweL94BN4cgN1etTGEk6GLepcAlfKi4FiReUDaWz
         nEcD/04zDmeT9z9kKTsQMce1lpAn48PTDRm98PP/OjezOYKbS/T84qt2Ltg6fcSv5JpE
         Lca7846qthhTi2ruKpyM84mCWmOopmMPbK5K+mYyMyOsa+K+Hr97nXOYqZqKRo7WOwbl
         7R7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOPbA36xbmJbp7ORKleonnGwA4EWzFsbO5QMAlSe1QmaCyDgoVn8ZAkGrY4Usa2Is8V2gAMki1epTO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Dg7GbjpCcNslHiRnuAg2Kw4ymVibQmj6pa3BThIkLUO1DeZP
	0HIMWkrSP21T2TaVi+RtO9WtXkQ4bb9yvo5WfWwWmiba1RGKoIvDFrII0SymjXU082lVtgl8mnU
	+vcs0LVWChX719utsvrrD5fD5iF0FaW1VayBhXPQTLP5crynwp7Pec0apONVYgcY=
X-Gm-Gg: ASbGncsz0yvF6tWJ7FXfe2Ku9l+pql2WoXHGmyVH/8K/W+tnVFhqUmxouQmP/hRuJli
	MWN6E468s6AeEZI13KRv+tFCZxjdiTsejxvt0nm0ofvo/bm09oMhuvpq2f+zcZwOTjhALOuh4U+
	6lizUzUa5/oTHD6DLIvff2yZw++mq9Om/NtvI1Re+vuPQXC/ETjXJixiscprBWleGjBRhy22nU0
	A6Lb8UXshWqmx0kkmljJrcW2/CHlVtX7kupHqgK2/p8i8PIR9uFmVTXmfkcX1hCiCkJoB59nR/T
	2g7sn/479RetABlC9Kk=
X-Received: by 2002:a05:600c:c1c8:10b0:441:d228:3a07 with SMTP id 5b1f17b1804b1-442f8524304mr174238705e9.13.1747904150763;
        Thu, 22 May 2025 01:55:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZZWLfHYdYPfwzdbwFycNAp7aliAoZubbXRRwKwS5IPvqLZEKoM1L6RvMRd6G8MB4cd63apg==
X-Received: by 2002:a05:600c:c1c8:10b0:441:d228:3a07 with SMTP id 5b1f17b1804b1-442f8524304mr174238455e9.13.1747904150355;
        Thu, 22 May 2025 01:55:50 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d3d6csm99616195e9.19.2025.05.22.01.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 01:55:49 -0700 (PDT)
Message-ID: <7a965a97-a6d0-462f-b7dd-8833605ea7c9@redhat.com>
Date: Thu, 22 May 2025 10:55:47 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 4/6] socket: Remove kernel socket conversion
 except for net/rds/.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, Steve French <sfrench@samba.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Matthieu Baerts <matttbe@kernel.org>,
 MPTCP Linux <mptcp@lists.linux.dev>
References: <20250517035120.55560-1-kuniyu@amazon.com>
 <20250517035120.55560-5-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250517035120.55560-5-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/17/25 5:50 AM, Kuniyuki Iwashima wrote:
> Since commit 26abe14379f8 ("net: Modify sk_alloc to not reference
> count the netns of kernel sockets."), TCP kernel socket has caused
> many UAF.
> 
> We have converted such sockets to hold netns refcnt, and we have
> the same pattern in cifs, mptcp, nvme, rds, smc, and sunrpc.
> 
>   __sock_create_kern(..., &sock);
>   sk_net_refcnt_upgrade(sock->sk);
> 
> Let's drop the conversion and use sock_create_kern() instead.
> 
> The changes for cifs, mptcp, nvme, and smc are straightforward.
> 
> For sunrpc, we call sock_create_net() for IPPROTO_TCP only and still
> call __sock_create_kern() for others.
> 
> For rds, we cannot drop sk_net_refcnt_upgrade() for accept()ed
> sockets.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

This LGTM, but is touching a few other subsystems, it would be great to
collect acks from the relevant maintainers: I'm adding a few CCs.

Direct link to the series:

https://lore.kernel.org/all/20250517035120.55560-1-kuniyu@amazon.com/#t

> diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
> index 37a2ba38f10e..c7b4f5a7cca1 100644
> --- a/fs/smb/client/connect.c
> +++ b/fs/smb/client/connect.c
> @@ -3348,21 +3348,14 @@ generic_ip_connect(struct TCP_Server_Info *server)
>  		socket = server->ssocket;
>  	} else {
>  		struct net *net = cifs_net_ns(server);
> -		struct sock *sk;
>  
> -		rc = __sock_create_kern(net, sfamily, SOCK_STREAM,
> -					IPPROTO_TCP, &server->ssocket);
> +		rc = sock_create_kern(net, sfamily, SOCK_STREAM,
> +				      IPPROTO_TCP, &server->ssocket);
>  		if (rc < 0) {
>  			cifs_server_dbg(VFS, "Error %d creating socket\n", rc);
>  			return rc;
>  		}
>  
> -		sk = server->ssocket->sk;
> -		__netns_tracker_free(net, &sk->ns_tracker, false);
> -		sk->sk_net_refcnt = 1;
> -		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
> -		sock_inuse_add(net, 1);

AFAICS the above implicitly adds a missing net_passive_dec(net), which
in turns looks like a separate bugfix. What about adding a separate
patch introducing that line? Could be in the same series to simplify the
processing.

Thanks,

Paolo


