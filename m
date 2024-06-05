Return-Path: <linux-rdma+bounces-2880-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 498538FC8E5
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 12:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618951C20EB4
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 10:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AF0190485;
	Wed,  5 Jun 2024 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S00LGw9l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A061946D2
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583015; cv=none; b=tLEW2AY01M4nTBnswG9Pa5E3jBPbvuiTGbvEYT7wDl2Offb1ABR8/GvT7h/oEUWy2zlu1nF8GxOlot8OnbsL0SpvMG55JR+YyPFQXdd2T1RRKhBsQDK0nYnbuHbLOxem9iTjqviLNawjLSScorYCYRNwDaBE6EVirB4nbJ1DwWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583015; c=relaxed/simple;
	bh=YTCRqJb056lXZGzUysonC0/LJOeRIT6URiPjldQS5Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kfh5NEVLi8U+HmyfxUBlTxgtKkyZWItkAECYTozfi5ssZ4f32MvuRcWMPXYOIJ9vKfXdHPRPyDpve9+EgAh0viAGNwjTaF6MqSKIoBPcJJs/iUa3yGgBGK2ImnNnNoNpLrQFAjG19dz6R6wPturkgNi4zEcnSCSmNwQU+DJ8g8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S00LGw9l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717583012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=klsynvVKW5DTrmtKye+CioTAaTuFcNWDg8W+GFHUKSM=;
	b=S00LGw9lPoqg6bsF3XDCxzFat/0kfKtfgkFUo+7r/cT+JtBE+N8dl9IELIgQyUPs652/Er
	BLMsYuC3i9ZeqnEwIZGLLykh/9F1+rQE2hWpVa4Ka08YePh8T2qJdHYVD2CtdejGb3ZdTa
	uegGJUqqGRnuUJyWt8/8E2Di9eM+HPc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-Plmny3kcOYKGGPvTvPRLPQ-1; Wed, 05 Jun 2024 06:23:31 -0400
X-MC-Unique: Plmny3kcOYKGGPvTvPRLPQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52b98d73cf9so2440907e87.1
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2024 03:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717583010; x=1718187810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klsynvVKW5DTrmtKye+CioTAaTuFcNWDg8W+GFHUKSM=;
        b=n8kOz4W6cdpDueR8wodC8aKToMCBo8V+ztIc+dVNid+E023WZRF8k2KMq/+H5OF2jv
         faGsmukbgHChrLAAr9jXgGZzREJlRz0D5JOOkrP3DiOXqnZ3HvfUoEoZImj1AOGp9367
         iEHhTVDuUj4pcNO8AKMh9LYTNYQhds7+Tljq30xpb7U3EHB3i/YHfysSLZ7JuICLED24
         gahforYNTRq6kz1aKyRiLRjN190Bi3tb9QzoVV7Vk3G/wdvVia3bu6G1KT4oCPg/dCD3
         d1ajM4YEdTL8MKsj1IxzQav5MtHU+ZDLImWLdAU3spD4Og5b1M0zdT2gd1zA+iLzcVRi
         JjzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy6WynaBAIuT7jxmaik84jr95JPpuRm2QnxuoQL47WTgjfrcygOcHRY5jD6n0eNxlmpnh06603IqkREEguIrCIlpYlrftlWCwfTg==
X-Gm-Message-State: AOJu0YzGecpjlFW0kXvSiTHha5Rk1fDcHw1oFswE1FEfhYKmd8G/D14v
	XSL/ikeom6im9dJ/4DFMqOFWmONb7iFLc8UR6pDLeYn0yFfYU4izGybanY9CWIxVdAhUg80DO9W
	uuUvzsjU2OM7EPvoVo8cDSL3kei8ZTkZSGL0bMyhuOPgs+y70BANiHgR2Q7c=
X-Received: by 2002:a05:6512:3481:b0:52b:8ad9:cf0a with SMTP id 2adb3069b0e04-52bab4fca86mr1550272e87.51.1717583009772;
        Wed, 05 Jun 2024 03:23:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI1EJwq+5iigab/2MhCGWa1YF9sou6D3GeBKs8zG0mx052UsuPFS2c2AdvBSeo1GOQhTitJA==
X-Received: by 2002:a05:6512:3481:b0:52b:8ad9:cf0a with SMTP id 2adb3069b0e04-52bab4fca86mr1550248e87.51.1717583009169;
        Wed, 05 Jun 2024 03:23:29 -0700 (PDT)
Received: from redhat.com ([2.55.8.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68e1201a89sm547324066b.32.2024.06.05.03.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 03:23:28 -0700 (PDT)
Date: Wed, 5 Jun 2024 06:23:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"peterx@redhat.com" <peterx@redhat.com>,
	"yu.zhang@ionos.com" <yu.zhang@ionos.com>,
	"mgalaxy@akamai.com" <mgalaxy@akamai.com>,
	"elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>,
	zhengchuan <zhengchuan@huawei.com>,
	"berrange@redhat.com" <berrange@redhat.com>,
	"armbru@redhat.com" <armbru@redhat.com>,
	"lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	Xiexiangyou <xiexiangyou@huawei.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"lixiao (H)" <lixiao91@huawei.com>,
	"jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
	Wangjialin <wangjialin23@huawei.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Message-ID: <20240605062209-mutt-send-email-mst@kernel.org>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <20240605035622-mutt-send-email-mst@kernel.org>
 <e39d065823da4ef9beb5b37c17c9a990@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e39d065823da4ef9beb5b37c17c9a990@huawei.com>

On Wed, Jun 05, 2024 at 10:00:24AM +0000, Gonglei (Arei) wrote:
> 
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Wednesday, June 5, 2024 3:57 PM
> > To: Gonglei (Arei) <arei.gonglei@huawei.com>
> > Cc: qemu-devel@nongnu.org; peterx@redhat.com; yu.zhang@ionos.com;
> > mgalaxy@akamai.com; elmar.gerdes@ionos.com; zhengchuan
> > <zhengchuan@huawei.com>; berrange@redhat.com; armbru@redhat.com;
> > lizhijian@fujitsu.com; pbonzini@redhat.com; Xiexiangyou
> > <xiexiangyou@huawei.com>; linux-rdma@vger.kernel.org; lixiao (H)
> > <lixiao91@huawei.com>; jinpu.wang@ionos.com; Wangjialin
> > <wangjialin23@huawei.com>
> > Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
> > 
> > On Tue, Jun 04, 2024 at 08:14:06PM +0800, Gonglei wrote:
> > > From: Jialin Wang <wangjialin23@huawei.com>
> > >
> > > Hi,
> > >
> > > This patch series attempts to refactor RDMA live migration by
> > > introducing a new QIOChannelRDMA class based on the rsocket API.
> > >
> > > The /usr/include/rdma/rsocket.h provides a higher level rsocket API
> > > that is a 1-1 match of the normal kernel 'sockets' API, which hides
> > > the detail of rdma protocol into rsocket and allows us to add support
> > > for some modern features like multifd more easily.
> > >
> > > Here is the previous discussion on refactoring RDMA live migration
> > > using the rsocket API:
> > >
> > > https://lore.kernel.org/qemu-devel/20240328130255.52257-1-philmd@linar
> > > o.org/
> > >
> > > We have encountered some bugs when using rsocket and plan to submit
> > > them to the rdma-core community.
> > >
> > > In addition, the use of rsocket makes our programming more convenient,
> > > but it must be noted that this method introduces multiple memory
> > > copies, which can be imagined that there will be a certain performance
> > > degradation, hoping that friends with RDMA network cards can help verify,
> > thank you!
> > 
> > So you didn't test it with an RDMA card?
> 
> Yep, we tested it by Soft-ROCE.
> 
> > You really should test with an RDMA card though, for correctness as much as
> > performance.
> > 
> We will, we just don't have RDMA cards environment on hand at the moment.
> 
> Regards,
> -Gonglei

Until it's tested on real hardware it is probably best to tag this
series as RFC in the subject.

> > 
> > > Jialin Wang (6):
> > >   migration: remove RDMA live migration temporarily
> > >   io: add QIOChannelRDMA class
> > >   io/channel-rdma: support working in coroutine
> > >   tests/unit: add test-io-channel-rdma.c
> > >   migration: introduce new RDMA live migration
> > >   migration/rdma: support multifd for RDMA migration
> > >
> > >  docs/rdma.txt                     |  420 ---
> > >  include/io/channel-rdma.h         |  165 ++
> > >  io/channel-rdma.c                 |  798 ++++++
> > >  io/meson.build                    |    1 +
> > >  io/trace-events                   |   14 +
> > >  meson.build                       |    6 -
> > >  migration/meson.build             |    3 +-
> > >  migration/migration-stats.c       |    5 +-
> > >  migration/migration-stats.h       |    4 -
> > >  migration/migration.c             |   13 +-
> > >  migration/migration.h             |    9 -
> > >  migration/multifd.c               |   10 +
> > >  migration/options.c               |   16 -
> > >  migration/options.h               |    2 -
> > >  migration/qemu-file.c             |    1 -
> > >  migration/ram.c                   |   90 +-
> > >  migration/rdma.c                  | 4205 +----------------------------
> > >  migration/rdma.h                  |   67 +-
> > >  migration/savevm.c                |    2 +-
> > >  migration/trace-events            |   68 +-
> > >  qapi/migration.json               |   13 +-
> > >  scripts/analyze-migration.py      |    3 -
> > >  tests/unit/meson.build            |    1 +
> > >  tests/unit/test-io-channel-rdma.c |  276 ++
> > >  24 files changed, 1360 insertions(+), 4832 deletions(-)  delete mode
> > > 100644 docs/rdma.txt  create mode 100644 include/io/channel-rdma.h
> > > create mode 100644 io/channel-rdma.c  create mode 100644
> > > tests/unit/test-io-channel-rdma.c
> > >
> > > --
> > > 2.43.0


