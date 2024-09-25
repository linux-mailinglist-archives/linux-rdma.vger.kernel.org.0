Return-Path: <linux-rdma+bounces-5093-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A433F98636D
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2024 17:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334FC1F277DF
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2024 15:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBDE175D37;
	Wed, 25 Sep 2024 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YfAV/M8g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D4215C12F
	for <linux-rdma@vger.kernel.org>; Wed, 25 Sep 2024 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276922; cv=none; b=k29UkNBihIgPLTjRU943U0r7bM+kAP/i1A5ccJpZQUp7uQTX/lh1MfMv+cHlnELaI/LfAFfCZf8UyULHqXMSe2u8ZdSh3IYJic2KsuJ1rxz2USAAMFnQ46EgXnV6+P8zZfXtTmByE4lSgBsrtZc50JWLc032np/b4vLdy0pBmNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276922; c=relaxed/simple;
	bh=ndtD7ZBZIqyVN2VUHYyzDUvtkUNfW7vt8CXUGz8n+ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJfZZS3qG7bTqlhi485xEo0yzhKU8CmNPEw6ZUjQDcyyKsMQbuav7fVOYQfIl+uSqMspwhAdkNxp//PsCH9TZVPPnx52ZdT598vhGHaG1aX3D5Pn9SqEft+jjODHmGzURM4TXKJDYtevBNvyODF2ZbnR+45hxTpcK67PyZ84FCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YfAV/M8g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727276919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vw4+VOZtZ5/QPeqIgByRwRB8leOllhKEDoiZi7+/ZGo=;
	b=YfAV/M8grVuRmU1H2AlKfkm5zWHiS9hytmHTn5fFeEWU31NSAhS5qJC+dfxEQC/UDyPtHQ
	xcPPY0rP1uiKRjilbsJclVC+/bZWuAtWGoadfq36kBTxA4omTSGPgWwbZu4wY0xrU6d+X/
	5WBrN5l9autFl5m3bceNvppoAPbygaI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-xijWJ8LXNsWlrk-IFdJiNQ-1; Wed, 25 Sep 2024 11:08:38 -0400
X-MC-Unique: xijWJ8LXNsWlrk-IFdJiNQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-71923d87da2so6627414b3a.3
        for <linux-rdma@vger.kernel.org>; Wed, 25 Sep 2024 08:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276917; x=1727881717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vw4+VOZtZ5/QPeqIgByRwRB8leOllhKEDoiZi7+/ZGo=;
        b=p7pI35Qqd+/r84ETtE3wGVsyfI4GYRyLfF1pKxx/Y6frWV7jl+jwGdSF0+PykVQRm5
         YOLBJjc/577W1BhC3lgNX2nrDdNfKzuHtMSgMRvPHAG/7f/81rrSHDm5uTaTi35kns/p
         exdc5SkmkNnzcJxfuwEbubfIjQOzkHX/FjdoVOMGCR5MUNclE10BRmPZW6RdAG1KTYAg
         NB/JVxbAnxIacCnewLgvDWsaUOdCoJ/gX6/J4dHEihbm2yaM9FffANLwCkydwbS6A7F2
         lZkw/gWiR+JL1JEaAdS18neaPH3yOnirgz3mZAA/Idudd2VXobamlyIMnTmudxhfjKDp
         aROA==
X-Forwarded-Encrypted: i=1; AJvYcCXgOW2A2ZFwPRFlQpa+lWmikTDOeTpAPZtFdCZG3JQMzFp3PDqt2mpc+3gyaFb8ZH4EPLXXsjCuZrsj@vger.kernel.org
X-Gm-Message-State: AOJu0YzY518PSIGmaF6CuEkNJ/cgZW4hObkUZNGPm/TcJTb80Y9B4e0g
	yCz7sMgUJjtuxHWabJEZ8kBMX7X/cwB8scYFPEeNMS5diLvbvb0jLQjnrnpvoH1TGYn52ppeiWi
	OqqUiW4T+seiUsrL3/il+CDHtKOERuKYQh3AQHisXuWDETUSC6VfMkAWa7XU=
X-Received: by 2002:a05:6a21:1690:b0:1cf:339e:a8d1 with SMTP id adf61e73a8af0-1d4c6f3445amr2455054637.10.1727276917206;
        Wed, 25 Sep 2024 08:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGedfQRbqZkQZ06e8nfB7irxihaWzOA2L9hYXFn6e1zxT4gAqUZRz1ZT9CrCxz7bwn9cbpSWQ==
X-Received: by 2002:a05:6a21:1690:b0:1cf:339e:a8d1 with SMTP id adf61e73a8af0-1d4c6f3445amr2455009637.10.1727276916841;
        Wed, 25 Sep 2024 08:08:36 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c5c06fsm2895016a12.55.2024.09.25.08.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 08:08:36 -0700 (PDT)
Date: Wed, 25 Sep 2024 11:08:31 -0400
From: Peter Xu <peterx@redhat.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Michael Galaxy <mgalaxy@akamai.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"yu.zhang@ionos.com" <yu.zhang@ionos.com>,
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
Message-ID: <ZvQnbzV9SlXKlarV@x1n>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zs4z7tKWif6K4EbT@x1n>
 <20240827165643-mutt-send-email-mst@kernel.org>
 <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com>
 <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com>

On Mon, Sep 23, 2024 at 01:04:17AM +0000, Gonglei (Arei) wrote:
> Hi,
> 
> > -----Original Message-----
> > From: Michael Galaxy [mailto:mgalaxy@akamai.com]
> > Sent: Monday, September 23, 2024 3:29 AM
> > To: Michael S. Tsirkin <mst@redhat.com>; Peter Xu <peterx@redhat.com>
> > Cc: Gonglei (Arei) <arei.gonglei@huawei.com>; qemu-devel@nongnu.org;
> > yu.zhang@ionos.com; elmar.gerdes@ionos.com; zhengchuan
> > <zhengchuan@huawei.com>; berrange@redhat.com; armbru@redhat.com;
> > lizhijian@fujitsu.com; pbonzini@redhat.com; Xiexiangyou
> > <xiexiangyou@huawei.com>; linux-rdma@vger.kernel.org; lixiao (H)
> > <lixiao91@huawei.com>; jinpu.wang@ionos.com; Wangjialin
> > <wangjialin23@huawei.com>
> > Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
> > 
> > Hi All,
> > 
> > I have met with the team from IONOS about their testing on actual IB
> > hardware here at KVM Forum today and the requirements are starting to make
> > more sense to me. I didn't say much in our previous thread because I
> > misunderstood the requirements, so let me try to explain and see if we're all on
> > the same page. There appears to be a fundamental limitation here with rsocket,
> > for which I don't see how it is possible to overcome.
> > 
> > The basic problem is that rsocket is trying to present a stream abstraction, a
> > concept that is fundamentally incompatible with RDMA. The whole point of
> > using RDMA in the first place is to avoid using the CPU, and to do that, all of the
> > memory (potentially hundreds of gigabytes) need to be registered with the
> > hardware *in advance* (this is how the original implementation works).
> > 
> > The need to fake a socket/bytestream abstraction eventually breaks down =>
> > There is a limit (a few GB) in rsocket (which the IONOS team previous reported
> > in testing.... see that email), it appears that means that rsocket is only going to
> > be able to map a certain limited amount of memory with the hardware until its
> > internal "buffer" runs out before it can then unmap and remap the next batch
> > of memory with the hardware to continue along with the fake bytestream. This
> > is very much sticking a square peg in a round hole. If you were to "relax" the
> > rsocket implementation to register the entire VM memory space (as my
> > original implementation does), then there wouldn't be any need for rsocket in
> > the first place.

Yes, some test like this can be helpful.

And thanks for the summary.  That's definitely helpful.

One question from my side (as someone knows nothing on RDMA/rsocket): is
that "a few GBs" limitation a software guard?  Would it be possible that
rsocket provide some option to allow user opt-in on setting that value, so
that it might work for VM use case?  Would that consume similar resources
v.s. the current QEMU impl but allows it to use rsockets with no perf
regressions?

> 
> Thank you for your opinion. You're right. RSocket has encountered difficulties in 
> transferring large amounts of data. We haven't even figured it out yet. Although
> in this practice, we solved several problems with rsocket.
> 
> In our practice, we need to quickly complete VM live migration and the downtime 
> of live migration must be within 50 ms or less. Therefore, we use RDMA, which is 
> an essential requirement. Next, I think we'll do it based on Qemu's native RDMA 
> live migration solution. During this period, we really doubted whether RDMA live 
> migration was really feasible through rsocket refactoring, so the refactoring plan 
> was shelved.

To me, 50ms guaranteed is hard.  I'm personally not sure how much RDMA
helps if that's only about the transport.

I meant, at least I feel like someone would need to work out some general
limitations, like:

https://wiki.qemu.org/ToDo/LiveMigration#Optimize_memory_updates_for_non-iterative_vmstates
https://lore.kernel.org/all/20230317081904.24389-1-xuchuangxclwt@bytedance.com/

I also remember we always have outliers that when save()/load() device
states it can simply be slower (takes 100ms or more on a single device; I
think it's normally has kernel/kvm involved).  That one device can already
break the rule, even if happens rarely.

We also haven't looked into multiple other issues during downtime:

  - vm start/stop will invoke notifiers, and notifiers can (in some cases)
    take quite some time to finish

  - some features may enlarge downtime in an unpredictable way, but so far
    we don't yet have full control of it, e.g. pause-before-switchover for
    block layers

There can be other stuff floating, just to provide some examples.  All
these cases I mentioned above are not relevant to transport on its own.

Thanks,

-- 
Peter Xu


