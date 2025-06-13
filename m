Return-Path: <linux-rdma+bounces-11291-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BD4AD85D5
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jun 2025 10:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8BA13A7779
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jun 2025 08:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7CA272806;
	Fri, 13 Jun 2025 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAXsxcQj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90593272802
	for <linux-rdma@vger.kernel.org>; Fri, 13 Jun 2025 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749804080; cv=none; b=sggk9J8jUc2z6D44go7B+SdEK5hiCrRSNXUDCWsyeIUW6JBurRogciP8dxXrfFJ5ZM3AGkg7UVAct4Rk7P8EjHajGHcD1gj4g2tLjS7vVRw9z0ZNCSIXaMWdm2UFUypZ7MN1PFx0j2vwa2oG/K8nz19oqp0DzT9rRvYhB+0UQrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749804080; c=relaxed/simple;
	bh=BLmTKI+Q9DOfOhx4cbhUvOqosks41IEI7ecv711gzTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m4Y8ie164QzEenLIg0UzWWozsawOchx3ZUgrk7NUuEKMtseMe49xfXxcfytC5kkHD04wsnEkkItMEFXgMp5UjN0KUap9nCbOPC8su1QdWAW8TqZWrl7T3/KOHSaUMhiism+9sh5gCiqMwD9TwnVDbG+dqRMd9FK78QEfkAy1LRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAXsxcQj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749804077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLmTKI+Q9DOfOhx4cbhUvOqosks41IEI7ecv711gzTA=;
	b=FAXsxcQjS4v+YKg2f66eGUlXel26Ytr1+U8rSVeMf+1DubIcHtZX9WO9HeXXQM5i4pl8nH
	F3S9/GFJ1g3WLdNnpBsGqDTrtnz861zFGiX94/ZESjVKHdY2bY6pMyNFeMI4uhX0tEyeNp
	RduZ6CiN0SL4A3iJBeJs7DZ5aPFnVQg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-xUmtNZgmPLWDYPUX7KQszw-1; Fri, 13 Jun 2025 04:41:16 -0400
X-MC-Unique: xUmtNZgmPLWDYPUX7KQszw-1
X-Mimecast-MFC-AGG-ID: xUmtNZgmPLWDYPUX7KQszw_1749804075
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-553af0e0247so566030e87.0
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jun 2025 01:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749804075; x=1750408875;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLmTKI+Q9DOfOhx4cbhUvOqosks41IEI7ecv711gzTA=;
        b=d3ViSDC7tgISncgn9szU3/cAtatZhenwrI8hWOmkoZ1U92DPNOA1cpo7A+f+rtAGAw
         CRNZNrGmxU8hwE9+nSFt/lr56QkFS4IxGxPiLOVWY4eGJe2hklA5LPz+CyGbzt4Lj8v5
         Qhl40KW1CHvhgHPRGIhhNluSiTj+cLgrRymGPckeQtORKA4a4MuLmPBTLGayF+Zp/+eS
         55QNGtTYWlPjIT8FDAZUCJ2DWXdyNnihwS5iifSLi4mWjQ2XDs1vuO2H/VfBrTI76ayy
         9/pW5538ZKPbZAOOwtrlC+NHRrpgy2wSTMysBHSOUZ1ibZ+aoG09yjoOHRasPUVsNXG+
         NRMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr9NB2Rey5HFjR43mUi4JJ+vNOJDhx2+bZWd88vZ2r8carxGSP/mTAfXkbUzUkuD15sVM/Yt9Rm+GQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzKdUv7LgnhcEhfGalCqL7NTGIt/qssMalpWrZUfsoBNkPxn5JA
	Br8XK5UwaXmOwPnbrfVhMfZ6+VDw3TsSsLN++rJ17+WPrgPkIFfdobwHnWlEb52F+lC3ndEeyAw
	xFjJaMLr0Mkxq7Y+YTAbT1ihW2W4vJnJvB2Bt2Pnm15DFgV0kvpwt/3ShnxdfEeo=
X-Gm-Gg: ASbGncubreUq/K887koaT29Go5H5PcTbkWBZ02hLEfyuL34oOBwNSFajlv78Hspiqyo
	v56NANAJkI8x5E1t5/R5MMjDZV4uwzI2BFhPBovWP5P9z/EPImJzQt9mristDcrInvApoKDi+Bd
	fslnHM7WiisVsX/eI5ru+w1ZduzXcquuw8YPlLPSInP6RfzRVO5+LeAwvcvQAu8DaiHVcZDHGJi
	5c84BB/kdnlzy4heoYxJ3/ZjQGFSVdyfq+gA6UCOuEjdfFSsFEGZlTY73e12hbkR9hr4k6mEQf/
	XEiDezAak9kpGa/6GVc=
X-Received: by 2002:a05:6512:1590:b0:553:2969:1d54 with SMTP id 2adb3069b0e04-553b0e7db36mr492380e87.8.1749804074730;
        Fri, 13 Jun 2025 01:41:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8IpMdUtTgJ3Dn5a0CMKZlpCnJMUPmS8+a17CagSgy2Cpy4kjX5FwqO1WhjH05IZnnYmmi5g==
X-Received: by 2002:a05:6512:1590:b0:553:2969:1d54 with SMTP id 2adb3069b0e04-553b0e7db36mr492364e87.8.1749804074236;
        Fri, 13 Jun 2025 01:41:14 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1f76fesm370344e87.226.2025.06.13.01.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 01:41:12 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 708031AF6DCC; Fri, 13 Jun 2025 10:41:10 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Jesper Dangaard Brouer <hawk@kernel.org>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mina Almasry
 <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>, Yunsheng
 Lin <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org,
 Qiuling Ren <qren@redhat.com>, Yuying Ma <yuma@redhat.com>,
 gregkh@linuxfoundation.org, sashal@kernel.org
Subject: Re: [PATCH net-next v9 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <20250612070518.69518466@kernel.org>
References: <20250409-page-pool-track-dma-v9-0-6a9ef2e0cba8@redhat.com>
 <20250409-page-pool-track-dma-v9-2-6a9ef2e0cba8@redhat.com>
 <aEmwYU/V/9/Ul04P@gmail.com> <20250611131241.6ff7cf5d@kernel.org>
 <87jz5hbevp.fsf@toke.dk> <20250612070518.69518466@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 13 Jun 2025 10:41:10 +0200
Message-ID: <87zfecrq3d.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 12 Jun 2025 09:25:30 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Hmm, okay, guess we should ask Sasha to drop these, then?
>>=20
>> https://lore.kernel.org/r/20250610122811.1567780-1-sashal@kernel.org
>> https://lore.kernel.org/r/20250610120306.1543986-1-sashal@kernel.org
>
> These links don't work for me?

Oh, sorry, didn't realise the stable notifications are not archived on
lore. Here are the patches in the stable queue:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.12/page_pool-move-pp_magic-check-into-helper-functions.patch
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.12/page_pool-track-dma-mapped-pages-and-unmap-them-when.patch
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.15/page_pool-move-pp_magic-check-into-helper-functions.patch
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.15/page_pool-track-dma-mapped-pages-and-unmap-them-when.patch

-Toke


