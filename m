Return-Path: <linux-rdma+bounces-10986-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B2AACE280
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 18:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5EE93A6E51
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 16:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0C21F4634;
	Wed,  4 Jun 2025 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3svuSBm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E221EBFE0
	for <linux-rdma@vger.kernel.org>; Wed,  4 Jun 2025 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056092; cv=none; b=Xa7yflpsQWh7feNdx7ZBZMPWTh+k4JA99B0wquBA1OteYDBESNDbIfGyriFcy0fESONOkLP+KdsPJLGwygbos2iIKvqjg5X+7uj80FlnbqxsamUDD7/k+2BqS1qnYC50F2ATm8ofvunxTHogwyImwf9hKrjZ+4vs82uQxZpYu5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056092; c=relaxed/simple;
	bh=W01do5wY76nWoxIg5mxKnfoZrGLR+i9S8Z7A2Dc9Ies=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tbRjkMqD0S0yuyABZaxmEDQ4V5tLassGrIdPPHTp/KJVVDu/9/pBbhCsJpDPBgBK0pwELTh6pV/BjPwakuuJ94v8O/eAyAAm+PoKgzv+1A2S1BFLeS5TBPoMBJZ0oLaWRb0fWix5ZfHQvSrJpO5lN5dbQPcihGMkSo+olZvf83o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I3svuSBm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W01do5wY76nWoxIg5mxKnfoZrGLR+i9S8Z7A2Dc9Ies=;
	b=I3svuSBmD0ZYhc8GwaEwWk8eQ37WcUqwoPSTXWPWO+8nJDa+8pA2vU/F3KyLd2tRFSxyaY
	eq/FgzwkfZ9emlUwI5RxQUWqm93oeZuDsi3ukUdI9HT1iizaOuQw0AuzZ2cQ8KZHms8gSn
	EHoVxxpRGfRm5URnHRRMqkXtmAq1zJk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-rjQSUhz9OL6TF9kOkBCedQ-1; Wed, 04 Jun 2025 12:54:48 -0400
X-MC-Unique: rjQSUhz9OL6TF9kOkBCedQ-1
X-Mimecast-MFC-AGG-ID: rjQSUhz9OL6TF9kOkBCedQ_1749056087
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-acbbb00099eso3076966b.2
        for <linux-rdma@vger.kernel.org>; Wed, 04 Jun 2025 09:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056087; x=1749660887;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W01do5wY76nWoxIg5mxKnfoZrGLR+i9S8Z7A2Dc9Ies=;
        b=CeKH5ozsLaaMqO+T/YdWtKKqRhdDTvMzBN+yTMedDk+NnXUZT5qhI1MjwqaIkQTkTO
         XTdkqt/8XpZhO+3R3VduX0NULAslyfuatV7aKpoXAkLCNlxxle97FkFcHAGdMDXYTYVA
         x2WXpFxJf3WSbpL3VPQ2/Rv5Pm0cYry2AJsLQhHRVrL6h/GTuyGLeAzR8LT1TG86zH31
         03yA4/IdgMZKjuDYyfAKOcUBx2UpC70gXMa5ZW0Gc54G792Z695h9/oSGxntpN7RDR4o
         WQP5Gld1n4gDir5KHCLE5Pidm4ooLEXHTGg2KbA5DI6P3eoWkCW54ZQcj4et8oPbd5kY
         DHww==
X-Forwarded-Encrypted: i=1; AJvYcCXKU6aVHIdaDzyDky6Xa8l2gDDV+/b1ZX8SFvmgXJdrzTZAWMdmHorJvSX/VerBzut4izjld3ec9Eom@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4jr7GeQv8k+ZNAk1QhVIsOLWWd8P0f7G0q1Zam8MofIC1VXju
	dM3GLPBGNsq4/xCYPdjzhgRWeMJfNUsEjo0J5W1Vl89v4Rq8LFQOpKbnAZ4JsokpBs6YZj3WvD9
	pbN8oMWw8ckuRQah8aqUzHPzC9xilb2AuWPEe+QxhDRTNntvsYn2sUy5+NLT52WI=
X-Gm-Gg: ASbGncswxQ4GRtODUbrc8XDxxggCFOmcn3QzNuNu1ZvV0n/gBv/MzKveRDlxbN4nHQG
	5aLnH2PHsLgiZIPkcD0vgfh+gubf2Ip05mnhStRmT6RTQbcoLgrDCsgC0tcorJv1G+4Lgst0JTr
	OLZQY75B6P9NB4dID/GNYUu7wbZiNfG2EE9ysKDL6265gzFu8IFffnTec5f5RAZYTGv4x+D5wEW
	hdouxyIQ6MmNKKd1kIA119MPDq7xTwNPD7T3MFFurTL6o18siDR619MQvGBva4jdn3Rmre0V5C0
	jbDVFZmsVERPojBzMr4k+KKLxAiiv/LnTI+c
X-Received: by 2002:a17:907:60ca:b0:adb:469d:2221 with SMTP id a640c23a62f3a-addf8fb3392mr316905166b.45.1749056087016;
        Wed, 04 Jun 2025 09:54:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4qiEZwqMaU8PlogC4zz14GcOUJ6vF7+mDiQZEwc00xgVAfFjugss6CGYBiTVHOcZyOXoQUA==
X-Received: by 2002:a17:907:60ca:b0:adb:469d:2221 with SMTP id a640c23a62f3a-addf8fb3392mr316901966b.45.1749056086612;
        Wed, 04 Jun 2025 09:54:46 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82e7ffsm1136170866b.68.2025.06.04.09.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:54:46 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 286601AA915C; Wed, 04 Jun 2025 18:54:45 +0200 (CEST)
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
Subject: Re: [RFC v4 07/18] page_pool: use netmem put API in
 page_pool_return_netmem()
In-Reply-To: <20250604025246.61616-8-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-8-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:54:45 +0200
Message-ID: <87y0u7v44q.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Use netmem put API, put_netmem(), instead of put_page() in
> page_pool_return_netmem().
>
> While at it, delete #include <linux/mm.h> since the last put_page() in
> page_pool.c has been just removed with this patch.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


