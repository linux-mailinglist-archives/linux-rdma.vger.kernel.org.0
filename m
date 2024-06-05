Return-Path: <linux-rdma+bounces-2873-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE8D8FC544
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 09:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EAF01C22534
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 07:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F9E18FDA1;
	Wed,  5 Jun 2024 07:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyHggTBe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4749118F2EA
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574252; cv=none; b=G4m4UyLDBH6z14her+jk5y44df60RZXnHqsPMkJFUYXL9PvvFxHuiLgZbYqLQos7JmND6MqccW3+tP/04NOBAUEbXRdgSpu3KJTsl5j/y3ejLNZtEU5j3mPrxQSdqAU1jOsK8GD9jtpd9AvqfwJuELArTcVQXeOFxlO6m77KPTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574252; c=relaxed/simple;
	bh=ctWJc2bJ0qoQEpesyJ1Fu9dzA3/gmBJk4/ce4QdYw0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDicVESteoLxBdjrIRzl3WY5/TXVz9MuiH8E+deSDXLrCEM54j3RHyvBY/CdQSuFNJU+V6GuIcccF4Lxf4PqeTfuB2PzxOGDwKcbaofq9LGRowecnv5D6k77yKIMfgG67h4E6cGeO/Kk4UffxrPWuAjEx6ENISGu8Wamn5PCySU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KyHggTBe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717574250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9AZEdKeDV6It+lG/VoCMIa73B0kziRqa48QTZ9z2H54=;
	b=KyHggTBe7huoTiqgUfPm9YIMV7rVY0207KlqKQmDg4LBIrbcC4CHTuCh27hQlsmiuNbyJp
	j68pNAbozDC2rSI+ozakID6OmHDblrj8gf0iGDVgiKvudtsh573P08mWmZatD2dCPL4tKp
	EOiCGhyMPQyfkV0WAKzsNZhdukXyRxc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-2GSr2alWNSKIWVx1UEVXJQ-1; Wed, 05 Jun 2024 03:57:25 -0400
X-MC-Unique: 2GSr2alWNSKIWVx1UEVXJQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a68b41fb17cso62143366b.0
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2024 00:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717574244; x=1718179044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AZEdKeDV6It+lG/VoCMIa73B0kziRqa48QTZ9z2H54=;
        b=E0nnAb0UbZ86eo4TiIUbRVi74C2y2p5wPPUegHEsUsf0tJk8xgE91iTB8+FBD6oQdh
         o4mlqwPDyG5voyiQI5GLrSeBE/DX6yWhG2K+7gGBOaQ0m4Drt+HUdBjJx21sDAijpVm1
         K6YeQh0fn5fWd0U0oCwvVqTSCiwZS+qbeYL2Szr3LOiHe5Dlie0HAR+UMAbvmZr+2oUu
         BTAAqxWfb8lZkmMEUX/Fy3fFbnIwaYi8qFUknoD2wgcM/GNdCUlq0U8mVtxxeQGW8vsI
         xixvyeH+aht1FxLcsyWqBwmh6sn7h6Ej2N1pJCfr2LChVDPWy+YTBl483LLvZg607PZZ
         fVVg==
X-Forwarded-Encrypted: i=1; AJvYcCUxSIGPedMFS66TpWpl8bFWnjcicoV/8USbRlCJdSVqqcLSlAdrFYs/i2LLfYj31SBFqmyqTdi5cpXwzRTCAkXHagL1QcIHQIpYgQ==
X-Gm-Message-State: AOJu0YyyuF9/MRvr+HnDPcgEfcqbuLxA/ToaANCwnMppc6BM+GNCyh3r
	Ev8tPYGOAbuNXaWSHejtROzZ7NeLF05OYo4/S7NJBY37Es5TskeW5fcSZ0BqAhG6iNabLZEWTOU
	nYJDh8jtaYvyX8E5qkBQ2IGzMFtBtGNteyg40bZtIIDl2uuprgl7QYDzc1Ls=
X-Received: by 2002:a17:906:e293:b0:a68:b073:14a5 with SMTP id a640c23a62f3a-a695425e2e8mr382009066b.9.1717574244304;
        Wed, 05 Jun 2024 00:57:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo86eY/+NYIWpLgLobm7VEbFCXsxnF8uUvdSLuT2MbMA7sHu6ghdGJJjiI3cCrT2mvWig16w==
X-Received: by 2002:a17:906:e293:b0:a68:b073:14a5 with SMTP id a640c23a62f3a-a695425e2e8mr382007766b.9.1717574243761;
        Wed, 05 Jun 2024 00:57:23 -0700 (PDT)
Received: from redhat.com ([2.55.8.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68cc45cea7sm548198566b.51.2024.06.05.00.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 00:57:23 -0700 (PDT)
Date: Wed, 5 Jun 2024 03:57:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, yu.zhang@ionos.com,
	mgalaxy@akamai.com, elmar.gerdes@ionos.com, zhengchuan@huawei.com,
	berrange@redhat.com, armbru@redhat.com, lizhijian@fujitsu.com,
	pbonzini@redhat.com, xiexiangyou@huawei.com,
	linux-rdma@vger.kernel.org, lixiao91@huawei.com,
	jinpu.wang@ionos.com, Jialin Wang <wangjialin23@huawei.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Message-ID: <20240605035622-mutt-send-email-mst@kernel.org>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>

On Tue, Jun 04, 2024 at 08:14:06PM +0800, Gonglei wrote:
> From: Jialin Wang <wangjialin23@huawei.com>
> 
> Hi,
> 
> This patch series attempts to refactor RDMA live migration by
> introducing a new QIOChannelRDMA class based on the rsocket API.
> 
> The /usr/include/rdma/rsocket.h provides a higher level rsocket API
> that is a 1-1 match of the normal kernel 'sockets' API, which hides the
> detail of rdma protocol into rsocket and allows us to add support for
> some modern features like multifd more easily.
> 
> Here is the previous discussion on refactoring RDMA live migration using
> the rsocket API:
> 
> https://lore.kernel.org/qemu-devel/20240328130255.52257-1-philmd@linaro.org/
> 
> We have encountered some bugs when using rsocket and plan to submit them to
> the rdma-core community.
> 
> In addition, the use of rsocket makes our programming more convenient,
> but it must be noted that this method introduces multiple memory copies,
> which can be imagined that there will be a certain performance degradation,
> hoping that friends with RDMA network cards can help verify, thank you!

So you didn't test it with an RDMA card?
You really should test with an RDMA card though, for correctness
as much as performance.


> Jialin Wang (6):
>   migration: remove RDMA live migration temporarily
>   io: add QIOChannelRDMA class
>   io/channel-rdma: support working in coroutine
>   tests/unit: add test-io-channel-rdma.c
>   migration: introduce new RDMA live migration
>   migration/rdma: support multifd for RDMA migration
> 
>  docs/rdma.txt                     |  420 ---
>  include/io/channel-rdma.h         |  165 ++
>  io/channel-rdma.c                 |  798 ++++++
>  io/meson.build                    |    1 +
>  io/trace-events                   |   14 +
>  meson.build                       |    6 -
>  migration/meson.build             |    3 +-
>  migration/migration-stats.c       |    5 +-
>  migration/migration-stats.h       |    4 -
>  migration/migration.c             |   13 +-
>  migration/migration.h             |    9 -
>  migration/multifd.c               |   10 +
>  migration/options.c               |   16 -
>  migration/options.h               |    2 -
>  migration/qemu-file.c             |    1 -
>  migration/ram.c                   |   90 +-
>  migration/rdma.c                  | 4205 +----------------------------
>  migration/rdma.h                  |   67 +-
>  migration/savevm.c                |    2 +-
>  migration/trace-events            |   68 +-
>  qapi/migration.json               |   13 +-
>  scripts/analyze-migration.py      |    3 -
>  tests/unit/meson.build            |    1 +
>  tests/unit/test-io-channel-rdma.c |  276 ++
>  24 files changed, 1360 insertions(+), 4832 deletions(-)
>  delete mode 100644 docs/rdma.txt
>  create mode 100644 include/io/channel-rdma.h
>  create mode 100644 io/channel-rdma.c
>  create mode 100644 tests/unit/test-io-channel-rdma.c
> 
> -- 
> 2.43.0


