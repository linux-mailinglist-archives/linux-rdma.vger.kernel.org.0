Return-Path: <linux-rdma+bounces-14210-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAB0C2C88F
	for <lists+linux-rdma@lfdr.de>; Mon, 03 Nov 2025 16:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3AB34F5AA1
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Nov 2025 14:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D9532C942;
	Mon,  3 Nov 2025 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="by9UlC4f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyaWd2qm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C4732D0F4
	for <linux-rdma@vger.kernel.org>; Mon,  3 Nov 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181420; cv=none; b=OKTm9MbKQzWqfVyTrwEMHOQ+43WaNTSHb2EyRIr4AYFahWzl7HgxkIMbMArCLtV05jGKvBh1GlRdALRT9egu7IpVRvQam7vaD91Ia1cHxiSa8QcW57cH8QtarKc6TOmwGs72LGLHx9kS1Jhzt6GM4dCZWm/gCBRzgABGeOON/lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181420; c=relaxed/simple;
	bh=awDPBHUqeWdiCTx68GRboOT/DtuaFpnsr65AopF29ug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kkz1m8t8Vv0ZywM7oty2EYXf5UJbL18V8c9SaJmDG1E+cB8fvkrQ5ThOnTeNRJluv9221CmuFfxknHuI3ocia8/qiKdKPZwAxNBTxL6/tHfTwEek0NysyxerR4e6Zd1VdKoofvD/3iUevQU+aKiYC9TK6SzunYYaKx8Kyan4x6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=by9UlC4f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RyaWd2qm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762181417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+nMoLQg870a5vLIr0xXAcHBID4BH0thIsNlUoCS1bvw=;
	b=by9UlC4f58KcKtON0qHfnThNHBnkgATF9tGkDpuax+SaXKAXxXR/pokn5hgNG/jeFO4bCe
	1auCuJZ6e1x1h9RXq6DO39WTc1/rtLIBtNV+dpCQvbT0MbdSt2Q57nTCb4X2hJOsSiUL/U
	WYhTmzaIhNYxXA3aGw+eurkhXeYt+6Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-te3z1uFEOzW7PMZ9DElA4Q-1; Mon, 03 Nov 2025 09:50:13 -0500
X-MC-Unique: te3z1uFEOzW7PMZ9DElA4Q-1
X-Mimecast-MFC-AGG-ID: te3z1uFEOzW7PMZ9DElA4Q_1762181412
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-640c4609713so2103964a12.2
        for <linux-rdma@vger.kernel.org>; Mon, 03 Nov 2025 06:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762181412; x=1762786212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nMoLQg870a5vLIr0xXAcHBID4BH0thIsNlUoCS1bvw=;
        b=RyaWd2qmMgLNxTEMP+ty7Hf7+cPTiZbtYEZrbVlO5TCfB5ecEWMIgphfpThCwMzPk2
         CKGLsyeGz4mjIXYVawPbk3kfmpTVVOhno2tLd/+QP9NgFDiOEghCaFaSKI3VREeM7sBf
         0U91Mt2+hDO+jKrv4fXEcY+y0zVHcoGCa10Mo+KzHQ/QvfmUfY6neKC8sx/Be6gE99aV
         JjhLNkdAFVzQBA950JK0ynx+/Ypg1zCaZLz9hwFEAyWFJ4Ki+5oSlrNv/U84tOWOCAAd
         aTWnn/a9ozB6Z4Ktyze8X/yrGYEtRyBxki0m2v1suGKa6BZMw56FewcGoiqvVOfdOS6H
         YTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762181412; x=1762786212;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nMoLQg870a5vLIr0xXAcHBID4BH0thIsNlUoCS1bvw=;
        b=fwRA3NuIusGjwgO4joDD4g36VK/OUhLmIFLCwm/DpHk5b+uE+pngwcxQn7XV0/DYkA
         8eU+QKE68vjXELsmYClM3h/BK+CJjDFzBvuls4+KrzDP/MOuXunxUjpOZTOSv1Fx297k
         UuhAjhTJlzrhARARw927qB7mC6x2Z5kRFFok052CZeLEQzXuNhIoxgEuef0B1DW6YWCU
         eH7e8/CqAzoHu/DNMUdcBMOHQNwzum6gMBunOW3qt9noQgucN07ztpC+dL7cg3B5BHCt
         IQcHJl7b0MWT/PkGd1T2Cspz8ehimwlwtze9I3IZrQhl2G/yCl76DQUAmUpQ/QriaIte
         PbFA==
X-Forwarded-Encrypted: i=1; AJvYcCWUtc9cFhg+Ja4afw59nmCkXE3yrrlfuPuryUbTPkEPpYZ3rDKL3YBodsx91qsUu6cVWuHto5YlkGJl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6D2lJ6Y9YKPJIVT9CTqoPgnkwd16el3Oqq5jTeja7X1b73dli
	+ZE1CRh0kIuoLETxhh+/jg7DLvVgR4uZadv9ZuIzQfMio8hsz8kR+z+g6BJNxt4KqLtcstdX7+Z
	bgM7UVnl5huuxCpTzcrCmFeC1psOg1VEoSIcPUmaqBawQ9DnN+FPuWCyuiaQubp8=
X-Gm-Gg: ASbGncuxn9uSp44kPc3ByrTqVrJce/1f2X3FoVNgtF0TQWJMG//vf8u93nCKTfEiBiL
	fsYDy4X30yp5mSUdC9mdJu8mga9fGTv3ec6CSi6R8TP4WkD+KVSnaLUV7OW7yl7Fn0a6fH3wANg
	YaESwjffQiCTXct1hezaOIcxGldBb7Z3BbNvBPzZwOGeyyUL2TGwczrEXUGDxFH4kuoJ3w+9rT/
	hem/DBNiyRMWQp2xbbO39hVbUm/gJs8hqixNtcHr1wFm6wSCn6JS+h1ehWjK0byT8iD8U5RvtDp
	MraHl0RNOmZkoUdL4ZK8rVZ8NGzfgJxBcFldLH8fpiFXElvrimhujfD/e/HA/6AX7zBUP7gt9zZ
	S4Vs/KUhUqANZlcFG0MS2rkQ=
X-Received: by 2002:a05:6402:34ca:b0:640:b497:bf71 with SMTP id 4fb4d7f45d1cf-640b497c2admr4755516a12.8.1762181411915;
        Mon, 03 Nov 2025 06:50:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNHHGCfan3xN8hz0VQLwH+oMIT11J2vhXom0DZu1MBhk6Duw5v6C2YzkNLZvnmt+vEeRS3LQ==
X-Received: by 2002:a05:6402:34ca:b0:640:b497:bf71 with SMTP id 4fb4d7f45d1cf-640b497c2admr4755480a12.8.1762181411457;
        Mon, 03 Nov 2025 06:50:11 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640b977e6acsm4056741a12.25.2025.11.03.06.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 06:50:10 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B7D07328476; Mon, 03 Nov 2025 15:50:09 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, horms@kernel.org, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, ilias.apalodimas@linaro.org,
 willy@infradead.org, brauner@kernel.org, kas@kernel.org,
 yuzhao@google.com, usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, asml.silence@gmail.com, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk,
 ap420073@gmail.com, dtatulea@nvidia.com
Subject: Re: [RFC mm v5 2/2] mm: introduce a new page type for page pool in
 page type
In-Reply-To: <20251103123942.GA64460@system.software.com>
References: <20251103075108.26437-1-byungchul@sk.com>
 <20251103075108.26437-3-byungchul@sk.com> <87jz07pajq.fsf@toke.dk>
 <20251103123942.GA64460@system.software.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 03 Nov 2025 15:50:09 +0100
Message-ID: <87h5vbp3vi.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> On Mon, Nov 03, 2025 at 01:26:01PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Byungchul Park <byungchul@sk.com> writes:
>>=20
>> > Currently, the condition 'page->pp_magic =3D=3D PP_SIGNATURE' is used =
to
>> > determine if a page belongs to a page pool.  However, with the planned
>> > removal of ->pp_magic, we should instead leverage the page_type in
>> > struct page, such as PGTY_netpp, for this purpose.
>> >
>> > Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(=
),
>> > and __ClearPageNetpp() instead, and remove the existing APIs accessing
>> > ->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
>> > netmem_clear_pp_magic().
>> >
>> > This work was inspired by the following link:
>> >
>> > [1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@g=
mail.com/
>> >
>> > While at it, move the sanity check for page pool to on free.
>> >
>> > Suggested-by: David Hildenbrand <david@redhat.com>
>> > Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
>> > Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> > Signed-off-by: Byungchul Park <byungchul@sk.com>
>> > Acked-by: David Hildenbrand <david@redhat.com>
>> > Acked-by: Zi Yan <ziy@nvidia.com>
>> > Acked-by: Mina Almasry <almasrymina@google.com>
>>=20
>> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>=20
>> IIUC, this will allow us to move the PP-specific fields out of struct
>> page entirely at some point, right? What are the steps needed to get to
>> that point after this?
>
> Yes, it'd be almost done once this set gets merged :-)
>
> Will check if I can safely remove pp fields from struct page, and do
> it!

Sounds good, thanks!

-Toke


