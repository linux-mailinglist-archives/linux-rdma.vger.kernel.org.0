Return-Path: <linux-rdma+bounces-3039-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D119026D4
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 18:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309E61F22BB3
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 16:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB95143864;
	Mon, 10 Jun 2024 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8z9uLKn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730E61422CF
	for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2024 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037357; cv=none; b=QTSTRjgZl53KXMyEx5lml8LSBPijZyDYAkwkWCKotbu5HWp1oy+m/IdmWZ33ZiIjUdTTDjHG14NbGvk1ApJtV1UAUh0e2ohC9rPd+5FleITlUVKRuI5si1ivfSKlWylylFr76I19ygvkd8eLVakZuDHjB7a+GIGfkgN2d1eVroA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037357; c=relaxed/simple;
	bh=Km3npwmldFRiNtA7XFYTZnXW04FBuzqoUjccJZ1SCts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fU/0i91hGSLq0vDEuwiIOFOlq26Xd5BNixtc13TMOKt0Kq57WWmDTozdVW2dGoxIhkZl3TZ1ICH7ldkfqpRkATRc8k43EdJt7ygfLP1LZWBr/TO3pIkXEiFRvYgk57OaCFueMBMbrWAFLsc0uUS0eRAD0YVfiKZgW1hxa0sEHRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A8z9uLKn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718037354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=90CpXrcFOHQ2T3P1la+HMSUn9j93HTiSwrAvcliDO2A=;
	b=A8z9uLKnMs+vIvcm3Hdq60RbHsdlZk+ayoQ0XAY2pHAPbDxLLw4oIoPzd48OQg9Nv64cvM
	gYCoQxC+Ay1IBy4gTn8PLWkXK3OgLWOOtwi5WexpZ+mXUNCy7JV3j4US76ZU1/Oy0wnJOZ
	tCWBW1AGjPFLQbUp6bOXEfOIDJdwb0U=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-6EAHExKKM1GUGNAXpdf25A-1; Mon, 10 Jun 2024 12:35:53 -0400
X-MC-Unique: 6EAHExKKM1GUGNAXpdf25A-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4409ac6b7f2so341791cf.0
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2024 09:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718037352; x=1718642152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90CpXrcFOHQ2T3P1la+HMSUn9j93HTiSwrAvcliDO2A=;
        b=S/5u3wt2YHIYYfOmNM72LL4wzSXLKzS6s6W/Stv0HjjjEiRFEHNbvGDDREKCWgGsa0
         mNCE4/NVT4yKb/Qqb0vZQ9Fats0fgd2+8Ybu3a0FsGP4m4F0vHt6z7OnQHtnloNrEwnE
         3egK23Aa2FyhAcJ6AysAh1CbY0YQFqEd3m5aIpsC0io8EPdxTV93SuP3ZNbQDlZySYvK
         JABExV/lkoW+uJnjJWUaQZ4qlqp5YsrNC7j8VgC5RTMYD4rydqRjuaMw1G8em4Wh3azH
         V6QmwQormwvmeIGvayj0xVUClc1QXy0ToYUfjT+iHBG2MGVHn5XggfLw34rhza8Rvwid
         gXIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRRmZ/pIixg/QhsnMHETApMcghjVKbwI7kVGRoNvXXV8Z9iBPOBkhQ+JRJUhBssNr9D71RNJp8sTd0uXOds+oDEZOMc9RPuUh7rw==
X-Gm-Message-State: AOJu0YzpohZoTXTlYLsmzqjXTzLGXNLUBLJfJLOOf5GhDEvcJsebnWvO
	KRQadKHW1x0jSBFNLz1ta8uHOlOfzsKGWxDAnuG2tvcykN8smJbSGvlNAZhCRe6HHpG3iqfuD6Z
	x0i67swJlCXKNIcZ9SyIoGRwzytc8AYdchd47Zae/3p6ohScEwL+gjlRCnmU=
X-Received: by 2002:a05:622a:188c:b0:440:61ce:2bf4 with SMTP id d75a77b69052e-44061ce2cf7mr55313401cf.2.1718037352099;
        Mon, 10 Jun 2024 09:35:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBNCinA8eWbXcP6zE75EpF5ME5ru6j0vfSllNpMsbSPtYzt/VcJ3ClLfL9Mx/KUTWync4Zdg==
X-Received: by 2002:a05:622a:188c:b0:440:61ce:2bf4 with SMTP id d75a77b69052e-44061ce2cf7mr55312841cf.2.1718037351277;
        Mon, 10 Jun 2024 09:35:51 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038a80209sm37683341cf.36.2024.06.10.09.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 09:35:50 -0700 (PDT)
Date: Mon, 10 Jun 2024 12:35:48 -0400
From: Peter Xu <peterx@redhat.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
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
	"jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
	Wangjialin <wangjialin23@huawei.com>,
	Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Message-ID: <ZmcrZCe8juVOHzja@x1n>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zl9rw3Q9Z9A0iMYV@x1n>
 <de950e0e2cda4f8dacd15892a6328861@huawei.com>
 <ZmBzusHyxLYqMeQg@x1n>
 <2fa61f902c244211af7d1316b67fe0a1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2fa61f902c244211af7d1316b67fe0a1@huawei.com>

On Fri, Jun 07, 2024 at 08:49:01AM +0000, Gonglei (Arei) wrote:
> Actually we tried this solution, but it didn't work. Pls see patch 3/6
> 
> Known limitations: 
>   For a blocking rsocket fd, if we use io_create_watch to wait for
>   POLLIN or POLLOUT events, since the rsocket fd is blocking, we
>   cannot determine when it is not ready to read/write as we can with
>   non-blocking fds. Therefore, when an event occurs, it will occurs
>   always, potentially leave the qemu hanging. So we need be cautious
>   to avoid hanging when using io_create_watch .

I'm not sure I fully get that part, though.  In:

https://lore.kernel.org/all/ZldY21xVExtiMddB@x1n/

I was thinking of iochannel implements its own poll with the _POLL flag, so
in that case it'll call qio_channel_poll() which should call rpoll()
directly. So I didn't expect using qio_channel_create_watch().  I thought
the context was gmainloop won't work with rsocket fds in general, but maybe
I missed something.

Thanks,

-- 
Peter Xu


