Return-Path: <linux-rdma+bounces-2858-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2057C8FBC9B
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 21:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5DE1F22CEA
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 19:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DCD14AD38;
	Tue,  4 Jun 2024 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dumDalFb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B1AB644
	for <linux-rdma@vger.kernel.org>; Tue,  4 Jun 2024 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717529548; cv=none; b=Am7Km6tsieWnGakf+BZj3ZWFwSewyBZYKPNlo5Jgv7IifjdCH5O7cuALQI4CKoKGFfGB/nrcBvXPPqW/ROzYLTnU2zHeh+jwD6NSKnnu6iNiZrboKaVEazs7gyT5CqNS2daQcEzCny1+6JIcYeDFmJRCF0jjDaAM+S3HkfJyyR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717529548; c=relaxed/simple;
	bh=7b/xWPrxRuwlwbc0IkQjtNVkj9hnADYTKG/4JmGAn/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfkOnxwSB5DuwNk/ldB2KsqmBOhIp3BEtKRSVyudcduvCvhJpIhIbIV/vylQ6dcz4r5J3oqK0Gjua+I52eqz1dV5VmCdYZ/CPjMFGEhGL2UfI1pUvIPpBaqYAMM5TmvVT+tZMjBAppF49Dl1QtNHVRAtwyRnISWrypbLEaEVgoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dumDalFb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717529545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nn8VVvMg5S3LrLJ8kYp1BIeEBqdiypMdX4uLq+yvay8=;
	b=dumDalFbO3/mTTicyfpkBmO0VQEN36GWY3PYLGcVOIc1jxTHGEpxG8S/OtbLjC0b0FWI7U
	gZ0CY52aJvBEVYibQg8EkgatKZkImlox/pqpHcqx9BwwwvSPIV/4yxi8lxQgCfiJF98R3U
	A2s6eZQUKA1wF1vEUx4i5MXJT0/WsPc=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-qykLbvAsOvSXoOkpK_wQTw-1; Tue, 04 Jun 2024 15:32:24 -0400
X-MC-Unique: qykLbvAsOvSXoOkpK_wQTw-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5ba647cd986so228140eaf.2
        for <linux-rdma@vger.kernel.org>; Tue, 04 Jun 2024 12:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717529543; x=1718134343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nn8VVvMg5S3LrLJ8kYp1BIeEBqdiypMdX4uLq+yvay8=;
        b=NjcrOZEqCjmxY0211wGAFRVNAqIjwKshgPiNiDRhqYykD83ZSpaayIArQtJ9933WvW
         WxfLnoWdm+H6Kepkqt5JTRU9z+IfFjLyBJbdWFNpIiRAIoY1PcgELLe0xYoJSTcTHno+
         yODDl3ZVXHNBFBZmoLq9z6DDPjKfLhT2C6rdaPDbUp8kFw+IKstSTL2w+4ts6I1Rn+dl
         LZ7/AMZHDwcxunA0dW9+O5uHvnEii+EERe9t/dBNcRMtkfxhXfgbA7CkbzustzNOS/8d
         mnQf8EB9TU3QPSHdEWeYH/rhVK6heNe2WeIOBDt5khvRKtc/5K0cFOkBVNM+Iqvtjtxx
         2jHw==
X-Forwarded-Encrypted: i=1; AJvYcCXFCLdGiLM+Nz9fNUhQYE+/2yJy84yc+lnInCvek4PsmN7Zk5g3SGODtz+M/P6pVg8cVyGXpkuZHJTHc2Mknp6kr0U7DUCFZoW1vg==
X-Gm-Message-State: AOJu0YwKpj5ws99FyJFE8BXdZjBOl7S1JOcUZ1NPbe927qaN/dJEkiuT
	Ob2as0AwUhzulIQlgQnyFUJ3EsR2B7rYPkoVe0tfb97GGSl5HRiqorNASpXcK1bJ0LwskWvHHks
	27HUR5dYwKtBR4gFhqxxy3kfMKSlqbpaOOyKzTEfcs9BWRzV24LLZNK8xepo=
X-Received: by 2002:a05:6870:55ca:b0:24f:ee85:2c9e with SMTP id 586e51a60fabf-251222b7943mr498795fac.5.1717529543054;
        Tue, 04 Jun 2024 12:32:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1gB4iI0JHGmExhph7ALHiOFQaV0SHQGCAABO67v817/arMccef/BuXa4ll/7UITsy6Fjpzw==
X-Received: by 2002:a05:6870:55ca:b0:24f:ee85:2c9e with SMTP id 586e51a60fabf-251222b7943mr498722fac.5.1717529542415;
        Tue, 04 Jun 2024 12:32:22 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795183f9dbesm74190685a.132.2024.06.04.12.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 12:32:21 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:32:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, yu.zhang@ionos.com, mgalaxy@akamai.com,
	elmar.gerdes@ionos.com, zhengchuan@huawei.com, berrange@redhat.com,
	armbru@redhat.com, lizhijian@fujitsu.com, pbonzini@redhat.com,
	mst@redhat.com, xiexiangyou@huawei.com, linux-rdma@vger.kernel.org,
	lixiao91@huawei.com, jinpu.wang@ionos.com,
	Jialin Wang <wangjialin23@huawei.com>,
	Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Message-ID: <Zl9rw3Q9Z9A0iMYV@x1n>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>

Hi, Lei, Jialin,

Thanks a lot for working on this!

I think we'll need to wait a bit on feedbacks from Jinpu and his team on
RDMA side, also Daniel for iochannels.  Also, please remember to copy
Fabiano Rosas in any relevant future posts.  We'd also like to know whether
he has any comments too.  I have him copied in this reply.

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

It'll be good to elaborate if you tested it in-house. What people should
expect on the numbers exactly?  Is that okay from Huawei's POV?

Besides that, the code looks pretty good at a first glance to me.  Before
others chim in, here're some high level comments..

Firstly, can we avoid using coroutine when listen()?  Might be relevant
when I see that rdma_accept_incoming_migration() runs in a loop to do
raccept(), but would that also hang the qemu main loop even with the
coroutine, before all channels are ready?  I'm not a coroutine person, but
I think the hope is that we can make dest QEMU run in a thread in the
future just like the src QEMU, so the less coroutine the better in this
path.

I think I also left a comment elsewhere on whether it would be possible to
allow iochannels implement their own poll() functions to avoid the
per-channel poll thread that is proposed in this series.

https://lore.kernel.org/r/ZldY21xVExtiMddB@x1n

Personally I think even with the thread proposal it's better than the old
rdma code, but I just still want to double check with you guys.  E.g.,
maybe that just won't work at all?  Again, that'll also be based on the
fact that we move migration incoming into a thread first to keep the dest
QEMU main loop intact, I think, but I hope we will reach that irrelevant of
rdma, IOW it'll be nice to happen even earlier if possible.

Another nitpick is that qio_channel_rdma_listen_async() doesn't look used
and may prone to removal.

Thanks,

-- 
Peter Xu


