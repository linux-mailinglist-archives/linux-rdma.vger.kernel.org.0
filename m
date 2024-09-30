Return-Path: <linux-rdma+bounces-5168-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EFC98AD34
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Sep 2024 21:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24FC2281535
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Sep 2024 19:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22AE19D8A3;
	Mon, 30 Sep 2024 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1kq0Vas"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FFD19D8A4
	for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2024 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727725664; cv=none; b=sZmIEtP2VNZnlbbdGwsKqDBFQK3MjXKYAZIT4MbdThhxNzg8wWwU3Aosib+oR4jpOSX5ANL34okjXxAkgqi9LemsBn2yATPL91cIkB3NPpR0NrImqHwdeew4WRkF/jqgvAB2gYsLotpk5rgN0SXK/UhZqlzj3NJce+7BZVtAm1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727725664; c=relaxed/simple;
	bh=Kp6ep8+IcLLHOCDlk6fAHpgCyxIPfMQxXh0HHEzCr5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOWEjTPB5P2wfqAopQMDOLnEgzsko2ZY88cidL4V9EXAug0wM9kQgoIe92/kTMAlSJHkPlwy5HkB9y4yYLwN2P7v9seaYIGg0q5VFJlL6P+qMKoa13YcL8WI0WMv6PI45/fYQ9IrOF9CY/aCwrwgskaL1L7B18rCvzLV9qocfic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g1kq0Vas; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727725661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prGBeKA86QLhKRADp0eTX+tNoVAx4dt5Wv+6p9pM42E=;
	b=g1kq0VasC+vS3c9pj02GuGpNm6Prn2igFXmqdqqG9bUjXifIQmfWJrxmwbJUOwXJsSlntl
	sO1DCqZcfAnqzQ1r8BRQJo3k6FNr624M9QeRyq9j8HylyVFze4xTdf5JqtYHX4/Cq90YlK
	3YT9bmBPRyObZIp/qvgJyYm7bGfPVF4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-sIZ7js4INJW7eux9N2ptLA-1; Mon, 30 Sep 2024 15:47:40 -0400
X-MC-Unique: sIZ7js4INJW7eux9N2ptLA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7ac8d3dbe5bso550499085a.3
        for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2024 12:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727725660; x=1728330460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prGBeKA86QLhKRADp0eTX+tNoVAx4dt5Wv+6p9pM42E=;
        b=p4o9UrkXXR3XmmDmpPtYRbai4+PRYHJzw2MtH4/6DVw4E0v8Us6Vr2lLj3pLOhaqYM
         nWbCHa5YZlPi2Ncwu5RZxu8F6dbJRp1QgLx7h2gmRNMUzx049aam5J6p2xq33TzXF0Ao
         9ecC3+xwTcPUX9IWajp8SBlAYLhaSGH0j7gaSuoWHcQ3+PFYL9OB84niKSmme3wmMOiU
         QwmyGN1ICBzbhsRq5LM8n8c7JDO6ck+sQzoFTOx4W4uxqnPCH4Hl7sq+BeLoO4gjP83T
         OTEYUH1ImHo78RMEpUaOqK3WE9+PrLeO7HZa4ejFrbzZUU7L64NP6pOvcXjg0oQTwJM8
         tzbA==
X-Forwarded-Encrypted: i=1; AJvYcCVGmrZ/zJIWfojVkuryo7ITN2Oca8IQtI7s+QWnHzsQKTxDs+cq15/x/8ThUvZEA4PR69KCHBayhEzW@vger.kernel.org
X-Gm-Message-State: AOJu0YzRiSJFw+BAjfICdw0P529KdBpXRtNP4EL7cpqbRm0k3arWIxNz
	0+x+Csi1ZwnXNd7ZrnMUQbDlowYpbmMTK68OZDx1JdWLk92ah4M6mtnnjeJZven5UiO4jXEtXxB
	e7MAVq42pIn5S12ijLU/EKZKJdIvnf06Xz2PkC34qBFIyh0ujsdS7SXm9Sv4=
X-Received: by 2002:a05:620a:450c:b0:7a9:b04a:b324 with SMTP id af79cd13be357-7ae378ddb4cmr1930912085a.64.1727725659747;
        Mon, 30 Sep 2024 12:47:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX81kf1iR/0lZtJ1lFzJzUc0+892Dm3hNPAy43+5BBqc4BJnAj900bLjAI/dH3V8YZuNyxIg==
X-Received: by 2002:a05:620a:450c:b0:7a9:b04a:b324 with SMTP id af79cd13be357-7ae378ddb4cmr1930908785a.64.1727725659234;
        Mon, 30 Sep 2024 12:47:39 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377d8a68sm441384785a.37.2024.09.30.12.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 12:47:38 -0700 (PDT)
Date: Mon, 30 Sep 2024 15:47:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Sean Hefty <shefty@nvidia.com>
Cc: Michael Galaxy <mgalaxy@akamai.com>,
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
Message-ID: <ZvsAV0MugV85HuZf@x1n>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zs4z7tKWif6K4EbT@x1n>
 <20240827165643-mutt-send-email-mst@kernel.org>
 <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com>
 <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com>
 <ZvQnbzV9SlXKlarV@x1n>
 <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com>
 <Zvrq7nSbiLfPQoIY@x1n>
 <DM6PR12MB4313D6BA256740DE1ACA29E9BD762@DM6PR12MB4313.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR12MB4313D6BA256740DE1ACA29E9BD762@DM6PR12MB4313.namprd12.prod.outlook.com>

On Mon, Sep 30, 2024 at 07:20:56PM +0000, Sean Hefty wrote:
> > > I'm sure rsocket has its place with much smaller transfer sizes, but
> > > this is very different.
> > 
> > Is it possible to make rsocket be friendly with large buffers (>4GB) like the VM
> > use case?
> 
> If you can perform large VM migrations using streaming sockets, rsockets is likely usable, but it will involve data copies.  The problem is the socket API semantics.
> 
> There are rsocket API extensions (riowrite, riomap) to support RDMA write operations.  This avoids the data copy at the target, but not the sender.   (riowrite follows the socket send semantics on buffer ownership.)
> 
> It may be possible to enhance rsockets with MSG_ZEROCOPY or io_uring extensions to enable zero-copy for large transfers, but that's not something I've looked at.  True zero copy may require combining MSG_ZEROCOPY with riowrite, but then that moves further away from using traditional socket calls.

Thanks, Sean.

One thing to mention is that QEMU has QIO_CHANNEL_WRITE_FLAG_ZERO_COPY,
which already supports MSG_ZEROCOPY but only on sender side, and only if
when multifd is enabled, because it requires page pinning and alignments,
while it's more challenging to pin a random buffer than a guest page.

Nobody moved on yet with zerocopy recv for TCP; there might be similar
challenges that normal socket APIs may not work easily on top of current
iochannel design, but I don't know well to say..

Not sure whether it means there can be a shared goal with QEMU ultimately
supporting better zerocopy via either TCP or RDMA.  If that's true, maybe
there's chance we can move towards rsocket with all the above facilities,
meanwhile RDMA can, ideally, run similiarly like TCP with the same (to be
enhanced..) iochannel API, so that it can do zerocopy on both sides with
either transport.

-- 
Peter Xu


