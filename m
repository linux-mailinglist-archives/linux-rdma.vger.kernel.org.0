Return-Path: <linux-rdma+bounces-3038-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B7E9026BE
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 18:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6331F22331
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 16:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C850142E8B;
	Mon, 10 Jun 2024 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xd+x/5oB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAAA84E1F
	for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2024 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037075; cv=none; b=lnqktucGbdp1JT3vYKKPNPIj+XbRDxVtaSaWv6qCAO1zeFremC027Dc9DJw/fuDvMc/lxaDcCjSrFFD6Ny5taYZ5tSzWVO56OHXbuecWyIr+xl6W98pH9tSgKaAXJfXvA3dFydfY0NEDHQ8iIJr552bsldRevpcG9NDOwCi9wYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037075; c=relaxed/simple;
	bh=fq3RBRv3ZrLc+IDlRT9wwXfD7go1gfLizFWyfKU/zBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBbK2ap32Scu/Z2amdaJkiL2YYv91KGHkaqEucFmrlmwvOBT3+vSLhFFiqSuj4x3kJ+V/iZu3r6QHmIvNao3QXQmn8R2LrIAzCSpZbl42TdI58FvAuUstCr5AfQLhD9nWlSy3yLsAoxfjvhsk4WA5Cqqljs0I6C7qFgzPyIJgP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xd+x/5oB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718037073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kEPnFYShNOfW6Go38hlXjO2BpMJrNG7XS+knedTSyz4=;
	b=Xd+x/5oBbco1SDUXhxeN37KgifC9urqk9tp+Kta3oIZl+l3OOFo4Pn63oMX3qvXZjLZhQr
	Y7KyotkSCZiOEzlU2ldMn1xktsq0WgjtGOdGjVd1NTd+viCe94TZFmmgfGUSa6ZVUU6iLE
	CVSMKKesLCYrNyqS3/Uovtw7tJDMIgM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-J7n43G3oPLu-PRcvpbkJGA-1; Mon, 10 Jun 2024 12:31:11 -0400
X-MC-Unique: J7n43G3oPLu-PRcvpbkJGA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b067843eb8so5678386d6.0
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2024 09:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718037071; x=1718641871;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kEPnFYShNOfW6Go38hlXjO2BpMJrNG7XS+knedTSyz4=;
        b=pP4ZrhZs6d3vXzDMOH/EWATPmYGecQD9bdXRDkyQh49P9yvAF0jThdoMFggxsp7F7R
         ezObOOApH8X24mLOsSnPe2Sh1/mxtY+gP+iOmziPQI976jG9V5hpyygQKdj8oJjXKMiK
         MbQNrv2mgY0KoSp5ynY5h+jCrrIlCl+VwFQHTJaALl8/ZO5NyvEsZVPKgVtNKxYK3i4S
         0xYUIGbL9QkM+s7RyBUQEhmDoZBPcSy9WetFIslq8dWy966hcxIgBl9HtIiL3AXuXtca
         H6HW7VDDntyZmnNwL24sXWo6tGJ9CAOHresp2vAM1PWJysq5nIcs7QAHJ4ZD+1dpb1Mn
         ckAA==
X-Forwarded-Encrypted: i=1; AJvYcCUAXQReiW5jT3JR+ZguunJGb9lIeMAChR3axzlBfmrcGNmG3uYqz7uaFtP3+5eRA3pkW1htT1z6crArw/vBf3z5SrSgg4eOpml88g==
X-Gm-Message-State: AOJu0YxedfBz0RB5eQ9Jr6frN3Uey8WK/buTEOPyzyJZ+NeA6nzi1rWX
	jaS38btGw7y3YLE2P8bmbWC7NPVElMTlVL6KcQ1EqOA0ioheLoCejwjjZ2LKlm47L2Oxsvgwdih
	1nHfaqjokS7/0H2s39aCNUWlXPAzJzP6zDs3cPS8w/c0Sx2lWH5rOb774F9M=
X-Received: by 2002:a05:6214:23cc:b0:6a0:cd65:599a with SMTP id 6a1803df08f44-6b059b73fcdmr112353256d6.2.1718037070996;
        Mon, 10 Jun 2024 09:31:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdLxSknR+8WIYDrIdq1gqx5Ivt0FX6ldjE5iVrk2Qw9zbpwv6gfEMzL2vLXatF+5AN68cnHA==
X-Received: by 2002:a05:6214:23cc:b0:6a0:cd65:599a with SMTP id 6a1803df08f44-6b059b73fcdmr112352916d6.2.1718037070341;
        Mon, 10 Jun 2024 09:31:10 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b080015e39sm9518236d6.31.2024.06.10.09.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 09:31:08 -0700 (PDT)
Date: Mon, 10 Jun 2024 12:31:05 -0400
From: Peter Xu <peterx@redhat.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Jinpu Wang <jinpu.wang@ionos.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"yu.zhang@ionos.com" <yu.zhang@ionos.com>,
	"mgalaxy@akamai.com" <mgalaxy@akamai.com>,
	"elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>,
	zhengchuan <zhengchuan@huawei.com>,
	"berrange@redhat.com" <berrange@redhat.com>,
	"armbru@redhat.com" <armbru@redhat.com>,
	"lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"mst@redhat.com" <mst@redhat.com>,
	Xiexiangyou <xiexiangyou@huawei.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"lixiao (H)" <lixiao91@huawei.com>,
	Wangjialin <wangjialin23@huawei.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Message-ID: <ZmcqSai3rU4KuEnO@x1n>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <CAMGffEkUd2EOS3+PQ9Yfp=8V1pZB_emo7gcmxmvOX=iWVG6Axg@mail.gmail.com>
 <b637ce3cac16409c83a3391b05011eec@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b637ce3cac16409c83a3391b05011eec@huawei.com>

On Fri, Jun 07, 2024 at 08:28:29AM +0000, Gonglei (Arei) wrote:
> 
> 
> > -----Original Message-----
> > From: Jinpu Wang [mailto:jinpu.wang@ionos.com]
> > Sent: Friday, June 7, 2024 1:54 PM
> > To: Gonglei (Arei) <arei.gonglei@huawei.com>
> > Cc: qemu-devel@nongnu.org; peterx@redhat.com; yu.zhang@ionos.com;
> > mgalaxy@akamai.com; elmar.gerdes@ionos.com; zhengchuan
> > <zhengchuan@huawei.com>; berrange@redhat.com; armbru@redhat.com;
> > lizhijian@fujitsu.com; pbonzini@redhat.com; mst@redhat.com; Xiexiangyou
> > <xiexiangyou@huawei.com>; linux-rdma@vger.kernel.org; lixiao (H)
> > <lixiao91@huawei.com>; Wangjialin <wangjialin23@huawei.com>
> > Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
> > 
> > Hi Gonglei, hi folks on the list,
> > 
> > On Tue, Jun 4, 2024 at 2:14 PM Gonglei <arei.gonglei@huawei.com> wrote:
> > >
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
> > First thx for the effort, we are running migration tests on our IB fabric, different
> > generation of HCA from mellanox, the migration works ok, there are a few
> > failures,  Yu will share the result later separately.
> > 
> 
> Thank you so much. 
> 
> > The one blocker for the change is the old implementation and the new rsocket
> > implementation; they don't talk to each other due to the effect of different wire
> > protocol during connection establishment.
> > eg the old RDMA migration has special control message during the migration
> > flow, which rsocket use a different control message, so there lead to no way to
> > migrate VM using rdma transport pre to the rsocket patchset to a new version
> > with rsocket implementation.
> > 
> > Probably we should keep both implementation for a while, mark the old
> > implementation as deprecated, and promote the new implementation, and
> > high light in doc, they are not compatible.
> > 
> 
> IMO It makes sense. What's your opinion? @Peter.

Sounds good to me.  We can use an internal property field and enable
rsocket rdma migration on new machine types with rdma protocol, deprecating
both old rdma and that internal field after 2 releases.  So that when
receiving rdma migrations it'll use old property (as old qemu will use old
machine types), but when initiating rdma migration on new binary it'll
switch to rsocket.

It might be more important to address either the failures or perf concerns
that others raised, though.

Thanks,

-- 
Peter Xu


