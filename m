Return-Path: <linux-rdma+bounces-1011-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADC0852C37
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Feb 2024 10:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62547287126
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Feb 2024 09:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326D4224CE;
	Tue, 13 Feb 2024 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CU941zOC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C2321A0A
	for <linux-rdma@vger.kernel.org>; Tue, 13 Feb 2024 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816499; cv=none; b=Tr3TkOm6CNIFyPEE7Ud89NUeXOv1JHk/pGxvqGvrU7+9nTtG8CzCx/tF8p/Kpvqb6gIBHUn/C2t7Md4zCGH0fqpl6yJNTaNCxV3hvOtlwTA8kRAI4d85iJzHdw3pHc+OGp+PfmTGa6KYzwR+jFm5wOT1jrk0dPDkxrD/PN2OsD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816499; c=relaxed/simple;
	bh=wMD7EJy86DezkdM6K7P2Tk4zuLu3caa/90UIsk8AazE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b8rp6KVomybserx/aiiq8lZm6hxJIwv05SjcXfTGbpNGTtOvnFzTx8he/b9Zapc+ZKjJ71nbGEUQEymJgEYgC9yKwjRnDUJAsG/9keQsQsc5e+rJptcpdPLujmUJD0RLXt48vBqwTlRe86SNxrurvUxUxtj0zExZSa3L5FatTzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CU941zOC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707816496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wMD7EJy86DezkdM6K7P2Tk4zuLu3caa/90UIsk8AazE=;
	b=CU941zOCfa+hM/hgoHf8A3g0FOtI24CL1o7Vdte7brui6O51xYSTjj5eKCQf7lj7KJmF1r
	kTpEmybJ5pfnB9fd8iJ1o8P6Q0yf3OMzR+/92eqIfj2Glx+H0LgF0vQDXgDMkcIOWa8aJP
	nYsfVD1uoziDxXARGV/wxHYxoqKzDVU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-JqagcSQDN2SeuJK4fCXsnQ-1; Tue, 13 Feb 2024 04:28:14 -0500
X-MC-Unique: JqagcSQDN2SeuJK4fCXsnQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7830635331bso178355785a.1
        for <linux-rdma@vger.kernel.org>; Tue, 13 Feb 2024 01:28:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707816494; x=1708421294;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMD7EJy86DezkdM6K7P2Tk4zuLu3caa/90UIsk8AazE=;
        b=UqgOzuOdYf8gojescuAJewo+M52JSD5UKchtU/sKN3e8OLRMxjecMFM2nicwk3kH1M
         vZcTqQhzZHfPn3E1NE8sSWUfVJgpxIe/36XxBs7Uhid3rUv9gi1FUejMi/sJOZyNt8mE
         i7mxSdPawRPzkQwLK3zpeYXXpRT6Q5gQVY3TMSJvreChD1vNSsrwnxHqzbRbj0ihg5r8
         bst5Z+Zfeodn4od+pK5nlzE0vU5LvRkxtEafm4j3+K9XtwYIf2Z0Z3cYrtY8jMnW6VIP
         PZJRfMPwh/BkQzbyEkVWHCkWTyH3kDkUF1WXw45pU7Y+R/EwZNPjWBhR39rTLFb3iKrz
         24zw==
X-Forwarded-Encrypted: i=1; AJvYcCVlqsUzUTWk/j0DLLyqRCJgwjEVXQIIGADigEnrm4j6TLlKDtQjHn+p58mBJrCv8DWL42iaUlLOCCN7L8FusfyRquvmU60wBI7lrw==
X-Gm-Message-State: AOJu0Yxo44VgUrOEc9cmOJ8W6+E5z9T77UZZo0lru8rdH1VHyDcBJx5s
	mVKwMhJolaO/caFsNNx2WQSu4JyVKdz2UoIphB5X1JJsMwTxRU2Z9FPFwrX06hILPug2USDz3Sw
	0Bap5ItTc639aMj0+HAGct7X0stb8A6JNg8HXR4V5PWS4DFP7cIbjjOzDILapqB7OYM4=
X-Received: by 2002:ac8:5904:0:b0:42c:51d5:cc4d with SMTP id 4-20020ac85904000000b0042c51d5cc4dmr11325979qty.1.1707816493847;
        Tue, 13 Feb 2024 01:28:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqbvgsahW/VxUHmxt3cfVh12ISuHxifU0aLNLwf0JNLeqsLjmuPRH1Zf2/hUBVWCPgt3/ldw==
X-Received: by 2002:ac8:5904:0:b0:42c:51d5:cc4d with SMTP id 4-20020ac85904000000b0042c51d5cc4dmr11325957qty.1.1707816493478;
        Tue, 13 Feb 2024 01:28:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWjCxyYsBqDybpkxGTcY2eh14M3uMOqlaDcaLctS8+HU50qJDPtHJ0DovOkul2/JVduRzmGCnhG5OyTMlhgnznVphqYUquitaMfbuFxD0tAfeYtKmWN2IH+lS0S+GhO9x8/g861hXxgdKCrWBsqs/N7+ItL2jQIK/GmumPUsC5xK2nO99bsuDIwu1tb83jhibAOKuaQcxWMalmoYxta8Oo2yHxxvJ9TtNHDAvZLk31OBIKVf1vd45pV/IIk
Received: from gerbillo.redhat.com (146-241-230-54.dyn.eolo.it. [146.241.230.54])
        by smtp.gmail.com with ESMTPSA id f7-20020ac84987000000b0042c41f05622sm975348qtq.27.2024.02.13.01.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:28:13 -0800 (PST)
Message-ID: <a2d34a4d3934c8bf755a9f7fafb0e695829b150a.camel@redhat.com>
Subject: Re: [PATCH v4 1/1] net:rds: Fix possible deadlock in rds_message_put
From: Paolo Abeni <pabeni@redhat.com>
To: allison.henderson@oracle.com, netdev@vger.kernel.org
Cc: rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, kuba@kernel.org, 
	edumazet@google.com, davem@davemloft.net, santosh.shilimkar@oracle.com
Date: Tue, 13 Feb 2024 10:28:10 +0100
In-Reply-To: <20240209022854.200292-1-allison.henderson@oracle.com>
References: <20240209022854.200292-1-allison.henderson@oracle.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-08 at 19:28 -0700, allison.henderson@oracle.com wrote:
> From: Allison Henderson <allison.henderson@oracle.com>
>=20
> Functions rds_still_queued and rds_clear_recv_queue lock a given socket
> in order to safely iterate over the incoming rds messages. However
> calling rds_inc_put while under this lock creates a potential deadlock.
> rds_inc_put may eventually call rds_message_purge, which will lock
> m_rs_lock. This is the incorrect locking order since m_rs_lock is
> meant to be locked before the socket. To fix this, we move the message
> item to a local list or variable that wont need rs_recv_lock protection.
> Then we can safely call rds_inc_put on any item stored locally after
> rs_recv_lock is released.
>=20
> Fixes: bdbe6fbc6a2f ("RDS: recv.c")
> Reported-by: syzbot+f9db6ff27b9bfdcfeca0@syzkaller.appspotmail.com
> Reported-by: syzbot+dcd73ff9291e6d34b3ab@syzkaller.appspotmail.com
>=20

Note that you must avoid empty lines in the tag area. The patch LGTM,
I'll fix this while applying it, no additional actions required.

Cheers,

Paolo


