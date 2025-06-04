Return-Path: <linux-rdma+bounces-10994-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EBDACE2B5
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 19:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D28168FAE
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 17:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AAE1F4199;
	Wed,  4 Jun 2025 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zn4hnpY+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8B61EF39E
	for <linux-rdma@vger.kernel.org>; Wed,  4 Jun 2025 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056572; cv=none; b=vAv/T2v831tkwNHkxXuRYdcAG0h29OoPodmQA8anQvmTNcsB+RU9czfrKwTAtbkTcfc3fDP03hC1ax+2ddoNxmU0UFFfCxiYh3o1qTPCjo/EITWCiDzkRGKq6Tw19c3d5lsq14w2i31RhBG1+s8x6VKoOmU7XJzisKDLXO6KFpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056572; c=relaxed/simple;
	bh=P92Z/lDShPFdDV0ba/bd+B1EUgMMMMP1rDAJOEmCppY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uSz0WT0I3Wiq4F+HLbgrmPMtQEegwikKNVA5oR6SoD11nbV0Z9GHdsC/fqopVLnENhm3261EYuIw/zZEzNrBbky29tOfvsqkw9eIctAwm2Av9vkgTysSkcTd2LuutgcqgunB2J5+/VdckUUKAKs80KD26SWbQGyqh3t5Ug/S36k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zn4hnpY+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P92Z/lDShPFdDV0ba/bd+B1EUgMMMMP1rDAJOEmCppY=;
	b=Zn4hnpY+1dmX0bdbUpIZMnvaJ/25MpMCwmKysbBUv0Ck9wn8E0ZCHonwXYiV0PmQ3MOcTr
	TYPHAPkMmuMQrcgS462Q5ZxEImW/gN2ViMV7dhZq6bsSAZgyF1ZY/n96qhf8IgZi1c9ypR
	36Jx+MAMBqzdCmeBockU/4i9QqdQAio=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-DqVb8W32NRWCNNNloqTfrg-1; Wed, 04 Jun 2025 13:02:47 -0400
X-MC-Unique: DqVb8W32NRWCNNNloqTfrg-1
X-Mimecast-MFC-AGG-ID: DqVb8W32NRWCNNNloqTfrg_1749056566
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-602df3e7adcso7873859a12.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 Jun 2025 10:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056566; x=1749661366;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P92Z/lDShPFdDV0ba/bd+B1EUgMMMMP1rDAJOEmCppY=;
        b=CSovgzeaY+squs3krnjN3Jz4DtyPNYXsRwApW1i5SXg7pBcQHFdYFCGYVZEgpIzDWR
         +Viz+EgYP5/Zx0LSQp9aLKKHqEhojTOiQgCQml7eiOCwE2N++pIFo/Z/hp8Yk5XC49QT
         8YbSDKwQZ3CVUiwAkKCZ6rZ2oxr7Td9oCHd3p7yWwQq3YUta/+IBbqEfoUUPmMZv9aZ9
         oIW0dZDJcGwQIsTBU6rpITHwWcoPl7hM42XcTeZGxGTndSU+xP5F7yJ444WZHfQHBsC4
         QumySLcq7KrNAqa7FbH2Rql5mxH0IvvxJxvyAsKAybRKzExD2uNIlrjvpuamsBkzvQHr
         kLfg==
X-Forwarded-Encrypted: i=1; AJvYcCUok5dgfVpKldSLvjS87xfA48gF72wS+2mEuqP4iEtCATOGdfjep2A+LmUwrKNpErvtL3nOsfDMt+DK@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2aOT5NYwYOMW+78x6K/GKOAvVWkmOQy+8DXW+lNrkpR3zumIe
	56B/NY9UfHr8fQXzpfiW/I8UjEl6tZAj3T2Y008+tmTvRJ6zUODcwmr1h8ItGS0XCNuQWoHsNvF
	h5DMU1O2D1hhnO9rnPn8XnBlewJG1ZtOhiQK6eIAoC6ern1nPMCHeChYFSqO5DDY=
X-Gm-Gg: ASbGnct/XykbO6Yg8NgKh0EsUPjlISKO8osZ8px4Ks953kEMCe5ZnGcrbyd1647BfM6
	oGChOGN53A+/SLchyRfXE8B9uJmDgHetgpqTHY2Oa+FXo1DDXjfF/MNAqytVsuqI9c7OHuRPKOG
	TPZdc4w4kkXTj+c/QIxJogREIw2cm+B+Nd8ycQoRHweXJL3ljfrDlZXh+Qri8ICG59qtqNAqysX
	yMdjyDm7Ec1n9Evt54ZNDcsv4j5dMtyqJU0tC3XhHD0rORa1QUwCEbcfrXgtFYNLM9EMmqYYRkE
	Hq81cCgP
X-Received: by 2002:a05:6402:348e:b0:601:f3f1:f10e with SMTP id 4fb4d7f45d1cf-606e98b0c7fmr3783617a12.5.1749056566247;
        Wed, 04 Jun 2025 10:02:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAdY6lpY2ygDLbTrWvUQe7gwiHA2y3sjXZHMWjovtfZAcIj8f4Ly3/xK0aa9hY0kNARvcHRw==
X-Received: by 2002:a05:6402:348e:b0:601:f3f1:f10e with SMTP id 4fb4d7f45d1cf-606e98b0c7fmr3783554a12.5.1749056565710;
        Wed, 04 Jun 2025 10:02:45 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-606da099aebsm1673134a12.63.2025.06.04.10.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:02:45 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 39C481AA916F; Wed, 04 Jun 2025 19:02:44 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
 leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [RFC v4 05/18] page_pool: use netmem alloc/put APIs in
 __page_pool_alloc_pages_slow()
In-Reply-To: <20250604025246.61616-6-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-6-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 19:02:44 +0200
Message-ID: <87bjr3v3rf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Use netmem alloc/put APIs instead of page alloc/put APIs in
> __page_pool_alloc_pages_slow().
>
> While at it, improved some comments.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


