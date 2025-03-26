Return-Path: <linux-rdma+bounces-8960-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D57FA71248
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 09:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F31A1898F68
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 08:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B141A316C;
	Wed, 26 Mar 2025 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9j1T96q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AE419D884
	for <linux-rdma@vger.kernel.org>; Wed, 26 Mar 2025 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976769; cv=none; b=HoMfhSfoanGrmxz6BPRDySAWiFnffiUVAclLAsVETL3ORah+3y1c5MJhoLAnhOrz2MwpoBxcxhSiR/rsiS0Pq2PESqA4DcjQ0uHwBU/qdHooBOl6y+1BoO6sClIxKox+0ULekjYhkoHTZgkrL8UQDp24EwdiEkvQsaqt87mQ6VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976769; c=relaxed/simple;
	bh=/i5+/BRMZy/oWIkpPBk5bPU1qjbR62bTRHV5eQdywzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JTZCwIQHCkl9hsyO6bqD9Je8WCOe0e6v4iYYn3yEYpqz3BLhq96ieUabKXVcVpcnSdEE89gT6escSyVltxnKvkI9suz1R3eXTXvZRD7mum3u3rr39y6tRSMJrLDbpq/N+U58mDKbR8v3bw1U41aie1bqhWwwrZ6YmD2PqxCrEY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9j1T96q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742976766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/i5+/BRMZy/oWIkpPBk5bPU1qjbR62bTRHV5eQdywzI=;
	b=Y9j1T96qquxNoEuYG5dfrWq9hPaRC12yzI7R0+VSpPwR2x5tih8q9IGP2VjczxP4wqzb0l
	tcpGt51cIBBFs3snUFwYnjC8zmDvBohtx2jMAVBOl4ou9P3ADRcVty6NwEEh/TiunR453t
	WAhOmRwpSkYTZ5lbWlNOOwGVuD09Reg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-QjonPbcjOseq9WX1fH-3ng-1; Wed, 26 Mar 2025 04:12:42 -0400
X-MC-Unique: QjonPbcjOseq9WX1fH-3ng-1
X-Mimecast-MFC-AGG-ID: QjonPbcjOseq9WX1fH-3ng_1742976762
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac297c7a0c2so489018966b.3
        for <linux-rdma@vger.kernel.org>; Wed, 26 Mar 2025 01:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742976761; x=1743581561;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/i5+/BRMZy/oWIkpPBk5bPU1qjbR62bTRHV5eQdywzI=;
        b=NbF1LkpOBfR53qACktUbSXLRzjAGVI3NCReKwd1oMnHeLA7CJJ9mYpBI1T9P98+REQ
         Lna14UK7nbPgXqWnyBMh4FgPr5LWgPNNttPtD7F6PwbEqx45SR+rB1LFqS9vcaIHLRLt
         WqGFAbu+8Te9U2TK/hqVXp2/bWa+EO8RslkIvNRidwRSkDyp7YjmE+iMTk7sgwfUwv9J
         3/S36avB1w9vDtAp8Y0OFovd19tqRkqmTiKYvfEUDf1rwX207QSNLm3dHME27RjaMiju
         DCEd6/6feuB2Jg9aNZld1+/ztYjrn9P2MAeFPZ5mRbDxmHx8FIzpjLN5i5mH3PgdBGVj
         ItpA==
X-Forwarded-Encrypted: i=1; AJvYcCU4sUCShYml4U7JD4WbGLJ5GZoDL636V7X+KCLXjtF5/HMY0qnVAcuWANwlA1teSGu93L8kcU/ooDXF@vger.kernel.org
X-Gm-Message-State: AOJu0YzjuKAvdiRhsQY+2LwWG0v3diGF5yUoe9NRU5OmLMhHMJtePR4F
	zTH4yu7gXvb7dqn4jrUOzGNLnmFE4E9bU4hercbG11t7NRrtkfhUqAGiK2l4Wdv6wC5sMsLuk/A
	qiDMJTeL0SSZg/R0atADxY8WKHQ3VMKcsWjf1LEZsCta7rEbX98hTJ6YkaIU=
X-Gm-Gg: ASbGncvYWoTsSaXZyfZgSLeoXbMVNX2WPagB5+q8BNik9hVdbDPexoV+JnHS2znlzE1
	fobnxY4WnC2LvY6DbYjpZ26/swyjPptXjQq41O0Eb0jziDs9G4M2Dm4suQcGatyMp3S2eF9gD+r
	JNYr5V5wYE13I/jAiOkkVucTtsjLn4Jh0h9pqEikzh0FcFtXWwL23xsmY3IHLRu7PxDeIt5JotL
	YWkrkm2ToltbWt1O/tKJQmdnkbky4Vpi07U7m37Tfx1VTodsUZOSstcN6082JTnqB4UtRgueKhZ
	zRi+JcwsZfn4ZDZL7pDEkd2P4lUpWye7x1CRFCvP
X-Received: by 2002:a17:907:e84c:b0:ac4:751:5f16 with SMTP id a640c23a62f3a-ac407515fefmr1710096066b.30.1742976761516;
        Wed, 26 Mar 2025 01:12:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7tYXUyRnYRid7WXsc4ocXyKGAEp70GrWLAvLlsK1V4El27+8QO6/yVgb6O5atgR4hk9tmqw==
X-Received: by 2002:a17:907:e84c:b0:ac4:751:5f16 with SMTP id a640c23a62f3a-ac407515fefmr1710092166b.30.1742976761087;
        Wed, 26 Mar 2025 01:12:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efda474bsm988606066b.183.2025.03.26.01.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 01:12:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 305D018FC9C4; Wed, 26 Mar 2025 09:12:34 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH net-next v2 2/3] page_pool: Turn dma_sync and
 dma_sync_cpu fields into a bitmap
In-Reply-To: <20250325151743.7ae425c3@kernel.org>
References: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
 <20250325-page-pool-track-dma-v2-2-113ebc1946f3@redhat.com>
 <20250325151743.7ae425c3@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 26 Mar 2025 09:12:34 +0100
Message-ID: <87cye4qkgd.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 25 Mar 2025 16:45:43 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Change the single-bit booleans for dma_sync into an unsigned long with
>> BIT() definitions so that a subsequent patch can write them both with a
>> singe WRITE_ONCE() on teardown. Also move the check for the sync_cpu
>> side into __page_pool_dma_sync_for_cpu() so it can be disabled for
>> non-netmem providers as well.
>
> Can we make them just bools without the bit width?
> Less churn and actually fewer bytes.

Ah! Didn't realise that was possible, excellent solution :)

> I don't see why we'd need to wipe them atomically.
> In fact I don't see why we're touching dma_sync_cpu, at all,
> it's driver-facing and the driver is gone in the problematic
> scenario.

No you're right, but it felt weird to change just one of them, so
figured I'd go with both. But keeping them both as bool, and just making
dma_sync a full-width bool works, so I'll respin with that and leave
dma_sync_cpu as-is.


