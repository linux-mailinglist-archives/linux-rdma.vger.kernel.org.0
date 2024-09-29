Return-Path: <linux-rdma+bounces-5149-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C89798984E
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Sep 2024 00:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1641F212A5
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Sep 2024 22:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F4814B970;
	Sun, 29 Sep 2024 22:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Db1DCd81"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4266136AEC
	for <linux-rdma@vger.kernel.org>; Sun, 29 Sep 2024 22:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727648810; cv=none; b=NoJgpdFRPC+iOpYcTa8VtLOS/nZXNPXYwugRLHz0NL2JAxK1woG2DdYo0qjhFjxYsOcfUPM8Sm1vrPMUWvbPknUnztq74xg6cxWHmH23JUJ3MQjxXm4Fbm/I7llAlfoMwZwEnTjnZpEta4jps6dALD3NqCVHLYnnAwIuH41mtYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727648810; c=relaxed/simple;
	bh=E3D267Lm1Yh1lQ3ya4rXfk0In8WFuwtIRsP4hs3ZwwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvIg5txEv8b3dizaMQzExe+3IlBi0SXN2q06mMEqEV0gOt7gO8qcpZNyeAjk34WeMzk/keakbpOJddOv1cSbk1Rf9u+SJ95gb4XuBxGKZt7qlYEp56fPoBMFpaBqSuGOoU0AGUTm+7ejSQ6BWZRzayTBERaaQG/q69GQ8cb3QQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Db1DCd81; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727648806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PemBl1hyIBKlSfrjKFuPjoBlVFbCeAta7QU5X0y5gt4=;
	b=Db1DCd81N1lDP3Q7EHg3sHZ7ztWDZwJfq4Xks9BQLPZ1SZkuBbwQJXGx9VlyhIeTVds0eS
	Dse6EJd+8KHFOydniHyEvT1FYJdiJS7m9hGksvDLtRFRFSWjNH0DHFq84QfKROT1fzwazq
	uy866W2X1ZmHueI9jx997Ka3Xetx290=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-NfMAZ5CANE-lTxtubfsO7g-1; Sun, 29 Sep 2024 18:26:45 -0400
X-MC-Unique: NfMAZ5CANE-lTxtubfsO7g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8a8e19833cso338314566b.1
        for <linux-rdma@vger.kernel.org>; Sun, 29 Sep 2024 15:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727648804; x=1728253604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PemBl1hyIBKlSfrjKFuPjoBlVFbCeAta7QU5X0y5gt4=;
        b=U8xtTdbicQ3fbSPBQyP1n+xc8TnKAxAT+L4XgME2BnwTLlFEbhcFsiVEaapvVSlC+B
         ki5SvGHdNe5ivtBWsmjee2NBV9nxvhToZgERlsX9ytRx36UDxOPVLIK2Q+L3TuWEasUu
         UQP+QzUTzgbjI0afQuiuQf2cco6sveyCV0EFQgwdSgfB/EsjnNwANiz+aYbYP2t9GDZR
         npdZf7IU2GeOWLDTUfktwZhXrbzB6gZVSXgWBJh8BGqUwtywl8R/wKj4+eJBFOpzOhkP
         7YPSSPjFaIXdctuBqFZ2m1BbqDSKBkgtKgIP4dMB+ZkanyPXgJXi0IBxPR1plhLR3KUq
         QGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEXPG4KBwCHeLgVh6FjFbZWpMZKmHWx3GzZPcu/yQQdvmWTQGNEa+PxSCEGuSqLvKt4Q8vYLVOfW1U@vger.kernel.org
X-Gm-Message-State: AOJu0YxjkhojlwUSsCsffTma3YM7WLNDqCOzOWsWeyZhewlHCvP8Ebby
	zohAdmIrHQ38V2dyZoY+tq0izu+Wcouz7eBvY26Gn9Fsb26jGSrlIUf9uLhRHe6X0avrChxWLA+
	tX7KgKDFWfETFWXYthyS55jAEPgWgRXFbJnUEO9P6ttjZ8j6MEcMORCYS5f4=
X-Received: by 2002:a17:907:3e1c:b0:a88:b93b:cdcb with SMTP id a640c23a62f3a-a93c4a68305mr937014566b.47.1727648804134;
        Sun, 29 Sep 2024 15:26:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPK76RJL7fWhJqBZ4WIV0xqWHm/oTyDpoUm61pptCrw05Cci/N1M+eFd2v4vtuGKr3jSxwsw==
X-Received: by 2002:a17:907:3e1c:b0:a88:b93b:cdcb with SMTP id a640c23a62f3a-a93c4a68305mr937013966b.47.1727648803738;
        Sun, 29 Sep 2024 15:26:43 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:822e:847c:4023:a734:1389])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c7130sm431617466b.67.2024.09.29.15.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 15:26:42 -0700 (PDT)
Date: Sun, 29 Sep 2024 18:26:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Galaxy <mgalaxy@akamai.com>
Cc: Sean Hefty <shefty@nvidia.com>, Peter Xu <peterx@redhat.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
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
Message-ID: <20240929182538-mutt-send-email-mst@kernel.org>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zs4z7tKWif6K4EbT@x1n>
 <20240827165643-mutt-send-email-mst@kernel.org>
 <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com>
 <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com>
 <ZvQnbzV9SlXKlarV@x1n>
 <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com>
 <20240929141323-mutt-send-email-mst@kernel.org>
 <46f8e54e-64a4-4d90-9b02-4fd699b54e41@akamai.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46f8e54e-64a4-4d90-9b02-4fd699b54e41@akamai.com>

On Sun, Sep 29, 2024 at 03:26:58PM -0500, Michael Galaxy wrote:
> 
> On 9/29/24 13:14, Michael S. Tsirkin wrote:
> > !-------------------------------------------------------------------|
> >    This Message Is From an External Sender
> >    This message came from outside your organization.
> > |-------------------------------------------------------------------!
> > 
> > On Sat, Sep 28, 2024 at 12:52:08PM -0500, Michael Galaxy wrote:
> > > A bounce buffer defeats the entire purpose of using RDMA in these cases.
> > > When using RDMA for very large transfers like this, the goal here is to map
> > > the entire memory region at once and avoid all CPU interactions (except for
> > > message management within libibverbs) so that the NIC is doing all of the
> > > work.
> > > 
> > > I'm sure rsocket has its place with much smaller transfer sizes, but this is
> > > very different.
> > To clarify, are you actively using rdma based migration in production? Stepping up
> > to help maintain it?
> > 
> Yes, both Huawei and IONOS have both been contributing here in this email
> thread.
> 
> They are both using it in production.
> 
> - Michael

Well, any plans to work on it? for example, postcopy does not really
do zero copy last time I checked, there's also a long TODO list.

-- 
MST


