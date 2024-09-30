Return-Path: <linux-rdma+bounces-5166-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D2E98ABC7
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Sep 2024 20:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1CBB1F237CA
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Sep 2024 18:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF42619308C;
	Mon, 30 Sep 2024 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eb3N74ng"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00522192D63
	for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2024 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720183; cv=none; b=DzzhuZKwVt63w1YOJg7WnXKmNN1aQSirUOgXdPgCXLYpKQ/D921EP9+cmkSq1HKBH2z/0HGsHyujHX4nM3atO9bS99ExxaNZoUvGayBewkFlmd8vNFfie0q8MEfFn3kdFxbDRzxTSuDD9Z5q8e1C+X1KFsyoQs05xWbFghqtcJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720183; c=relaxed/simple;
	bh=BctX1l2xXTPLD9uWD9lEE9UN2P7+oKgXcfgD2LjqpEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSMkVqBlIqMZi9bJ9aE7ffu0Tc5UweG/BXCHr8gRpNR2hdQmbpZRrPxlezh1H4DCMiegW7U5rKqyZ/ZNAQacjaP8OFUaEJVV6BRhdWWKn31e76SdzhCzwG1VohUP8M/Pn37sKmflDOA9sqrAEMVxRlLUDgVzXFUUzL+cmK3Tgsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eb3N74ng; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727720180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g70UrLqfz9ieslzzgOkmz08fHuxDPadkSXeHrQ+so08=;
	b=eb3N74ng/B+FQ1DOmM9TCRteNaRx2ThQTeTdniBsqw7NcOMm96RaWkchzKnRi6xLGcnAjb
	sAeXz0eBp5YWaWUDL/GfYdOUOmiHOiLJWhcW/DITl5Z7OPwRbpjoW3Jeb5gqapnFgbPKTv
	4eB+DAirP6ViqHHIjgY3I+MekuuN9XI=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-A5BW5MZOOO2xPtdZFIgbkg-1; Mon, 30 Sep 2024 14:16:18 -0400
X-MC-Unique: A5BW5MZOOO2xPtdZFIgbkg-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5e1c72ea68aso3787355eaf.0
        for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2024 11:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727720178; x=1728324978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g70UrLqfz9ieslzzgOkmz08fHuxDPadkSXeHrQ+so08=;
        b=P2Q2TsSq8MfQrCxmBc4c4IqmyzZvjYIa4IqtyjeCEjN0+XRYFfb7Azbfo1MNuQlYZi
         rPnEwXZ5DR8hciKAKywkRcxmD6NkZT/0cGfno1Q1C34yhSQRNQT8PM9p5k9IcNpHGPYE
         KE68Nn9ILdYAtc5XyleQDD4uV/HxgNHPGg5C8WUZSlZpisefd7BHUz98wVqoAU7bbYir
         6PanRuQmUJSFB846DcCG6qz2QBZ7VmUG0kpKX4AR2QSylVcVgaVk5pdZQ18ZscUDLp4x
         2rUtj3ABBS6XRA9HjoMvLlkNiTcLx34OaxQ/ZaEk+KV262UM4wlL9iMQxinJV/Q1bk0D
         9ZtA==
X-Forwarded-Encrypted: i=1; AJvYcCWFl7MzqiX0rpKtyoZtyjkvdXOSO3Dw1UQXEK0K8cCI9r4+/0NVvbAu/a8uJEc8go0hmShrFNTt+oKI@vger.kernel.org
X-Gm-Message-State: AOJu0YwetWFP9nEpc5L5L72P562hS/gYc+PUEXWlRxHXykiRpi05w5zO
	C23ASafm5Kdmi8md8rGQvwmmXns5xl1NYmWC8c5pWeKqLrAfbT6hnJ8FjWXkV8iHUY7GN72yDpC
	rg3V71nARwmNjDsrH5l9ubIZ6F9fkkIzMfVk7iCFQNQRaX3ERmfsskzpLU6E=
X-Received: by 2002:a05:6358:60c7:b0:1b8:2cf8:cf5 with SMTP id e5c5f4694b2df-1becbc261f9mr781333355d.3.1727720177712;
        Mon, 30 Sep 2024 11:16:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBfqZzsABhgfZIZhmer2c2B5PqhU2BpdrwLqd2GTt5QuL/pH5CbvBqdiobgzrukVOd5H6UBw==
X-Received: by 2002:a05:6358:60c7:b0:1b8:2cf8:cf5 with SMTP id e5c5f4694b2df-1becbc261f9mr781330455d.3.1727720177390;
        Mon, 30 Sep 2024 11:16:17 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b67f23csm41656496d6.108.2024.09.30.11.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:16:16 -0700 (PDT)
Date: Mon, 30 Sep 2024 14:16:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Galaxy <mgalaxy@akamai.com>
Cc: Sean Hefty <shefty@nvidia.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
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
Message-ID: <Zvrq7nSbiLfPQoIY@x1n>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zs4z7tKWif6K4EbT@x1n>
 <20240827165643-mutt-send-email-mst@kernel.org>
 <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com>
 <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com>
 <ZvQnbzV9SlXKlarV@x1n>
 <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com>

On Sat, Sep 28, 2024 at 12:52:08PM -0500, Michael Galaxy wrote:
> On 9/27/24 16:45, Sean Hefty wrote:
> > !-------------------------------------------------------------------|
> >    This Message Is From an External Sender
> >    This message came from outside your organization.
> > |-------------------------------------------------------------------!
> > 
> > > > > I have met with the team from IONOS about their testing on actual IB
> > > > > hardware here at KVM Forum today and the requirements are starting
> > > > > to make more sense to me. I didn't say much in our previous thread
> > > > > because I misunderstood the requirements, so let me try to explain
> > > > > and see if we're all on the same page. There appears to be a
> > > > > fundamental limitation here with rsocket, for which I don't see how it is
> > > possible to overcome.
> > > > > The basic problem is that rsocket is trying to present a stream
> > > > > abstraction, a concept that is fundamentally incompatible with RDMA.
> > > > > The whole point of using RDMA in the first place is to avoid using
> > > > > the CPU, and to do that, all of the memory (potentially hundreds of
> > > > > gigabytes) need to be registered with the hardware *in advance* (this is
> > > how the original implementation works).
> > > > > The need to fake a socket/bytestream abstraction eventually breaks
> > > > > down => There is a limit (a few GB) in rsocket (which the IONOS team
> > > > > previous reported in testing.... see that email), it appears that
> > > > > means that rsocket is only going to be able to map a certain limited
> > > > > amount of memory with the hardware until its internal "buffer" runs
> > > > > out before it can then unmap and remap the next batch of memory with
> > > > > the hardware to continue along with the fake bytestream. This is
> > > > > very much sticking a square peg in a round hole. If you were to
> > > > > "relax" the rsocket implementation to register the entire VM memory
> > > > > space (as my original implementation does), then there wouldn't be any
> > > need for rsocket in the first place.
> > > 
> > > Yes, some test like this can be helpful.
> > > 
> > > And thanks for the summary.  That's definitely helpful.
> > > 
> > > One question from my side (as someone knows nothing on RDMA/rsocket): is
> > > that "a few GBs" limitation a software guard?  Would it be possible that rsocket
> > > provide some option to allow user opt-in on setting that value, so that it might
> > > work for VM use case?  Would that consume similar resources v.s. the current
> > > QEMU impl but allows it to use rsockets with no perf regressions?
> > Rsockets is emulated the streaming socket API.  The amount of memory dedicated to a single rsocket is controlled through a wmem_default configuration setting.  It is also configurable via rsetsockopt() SO_SNDBUF.  Both of those are similar to TCP settings.  The SW field used to store this value is 32-bits.
> > 
> > This internal buffer acts as a bounce buffer to convert the synchronous socket API calls into the asynchronous RDMA transfers.  Rsockets uses the CPU for data copies, but the transport is offloaded to the NIC, including kernel bypass.
> Understood.
> > Does your kernel allocate > 4 GBs of buffer space to an individual socket?
> Yes, it absolutely does. We're dealing with virtual machines here, right? It
> is possible (and likely) to have a virtual machine that is hundreds of GBs
> of RAM in size.
> 
> A bounce buffer defeats the entire purpose of using RDMA in these cases.
> When using RDMA for very large transfers like this, the goal here is to map
> the entire memory region at once and avoid all CPU interactions (except for
> message management within libibverbs) so that the NIC is doing all of the
> work.
> 
> I'm sure rsocket has its place with much smaller transfer sizes, but this is
> very different.

Is it possible to make rsocket be friendly with large buffers (>4GB) like
the VM use case?

I also wonder whether there're other applications that may benefit from
this outside of QEMU.

Thanks,

-- 
Peter Xu


