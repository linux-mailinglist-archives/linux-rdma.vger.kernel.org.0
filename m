Return-Path: <linux-rdma+bounces-5147-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B410A9896B8
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Sep 2024 20:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54790281CE4
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Sep 2024 18:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F82C4204B;
	Sun, 29 Sep 2024 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZUTmNDZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D856022611
	for <linux-rdma@vger.kernel.org>; Sun, 29 Sep 2024 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727633663; cv=none; b=n2iSZrSBdd9Wk4/1gp0MGkYF8vPVu69jLL+Qz3rSSVDcihVY9y+ekKCNoPL9yMxUmSG8MRuPX0b7ULQMHIstT65VDejRHezya2C4aZIILSHxTj7Zp2QEX4sP5EeGipiTpsDgo9oVqoSG2DpYAjCReNfIErSMUJhkYotsGN1al7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727633663; c=relaxed/simple;
	bh=5pHAcsOhWaIbmjCIw9tqrDaeXPcvT6EZc3ShXLcWl/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdZZ4I1QkFaOSfAjMbnWebE1zoX/cNfSng9r4/xgiNbbIQFMJW+bLRHWUGTNMrj6nI4QRliJDPQKk/9NmTPoNfgblVgl0NcqeXhwjyRSTbMWIRlhGz2e4kh9INwkTbWf1LNymlUNOaCpFeHuUJcKcUgmGTLlNxbpv/U/dpwXvNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZUTmNDZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727633660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w7MT4iAPcSuYS0WNQDhSnN5OL6KGtI0jtO/g+U2dGa4=;
	b=UZUTmNDZvqeb5JpBY0eX9uewAfX1VSu0g3NpejA5Qh7umDl/4ox/x+dHHOncQHGLpSDNov
	7lyKfrt+UXN7bWs3SJQmkq5nANSprnOc7wBAIQtJ53IDlirT/e1txxvTs533ZlL+aLJFOP
	23UcJ+sxjt2kxbSRmVrzh2wzR4t5WCk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-NI87f6KTNQaNIDgWUXAonw-1; Sun, 29 Sep 2024 14:14:19 -0400
X-MC-Unique: NI87f6KTNQaNIDgWUXAonw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c88bed5caaso679919a12.1
        for <linux-rdma@vger.kernel.org>; Sun, 29 Sep 2024 11:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727633658; x=1728238458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7MT4iAPcSuYS0WNQDhSnN5OL6KGtI0jtO/g+U2dGa4=;
        b=m9a6U5k3H4WRlshP2a5NFi6v2npXlldkU9vcF7n4YVzijuwJfT0eAVNu8YHqYcz+96
         mPa1Im9Il+mq/APRJGOnf7LIp1qAlOLL/OigJ15DwrwerrxxednaLijnTN/y11wnolYu
         7yYxxlRAkanr2LiZns4H2eA5ZPxSp5U55mJ1/SRCXbus31bbUpHY0SUeNaqtAdJ3vi16
         MlQLVdjuhmYQXl3NxEhLL/n+aYunTwC5D0G3bNqOGnsfRTTuFw4nXZJIr2I28QHZPOX4
         GnZqWQHjqfdBOKF723JftYlAWWDR0ZMIhErYvUm5rMeOXQ896+HgYw17H/g893o51KoK
         3KnA==
X-Forwarded-Encrypted: i=1; AJvYcCVqoiLyonkrGOeqSHFRkt+M99YP19vJig1gpzcIXYY+RsBHfOhjFx0fWNUTZTq9UBjpvJhEqBGDzmmh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy09m7v9XU9zzTVq7tWqMn0unlGF2dDhNrRLi0faH7EqGiWayPL
	V51Vo105TvX6S9SEVNEvs/jHnzW2X6Yrzvxh0eLpp4Ajtd6mKikd3y19v8WjlQhdyq239DAaeWB
	QXK28iwzpOuxZR0AsTG/hRxfqkZPRGU1S0JwVzm93FZWRwQhhqarXC4o9R+8=
X-Received: by 2002:a05:6402:42c2:b0:5c5:da5e:68e with SMTP id 4fb4d7f45d1cf-5c8824cd05fmr16304827a12.3.1727633658305;
        Sun, 29 Sep 2024 11:14:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsBCMaav1yffVzptAr2TDEl7+U/4t+yG7PheIxWQ0FtDlMqAlga+SPFy9Hc18UupZRNnhYkg==
X-Received: by 2002:a05:6402:42c2:b0:5c5:da5e:68e with SMTP id 4fb4d7f45d1cf-5c8824cd05fmr16304783a12.3.1727633657918;
        Sun, 29 Sep 2024 11:14:17 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:822e:847c:4023:a734:1389])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2978beesm417265966b.147.2024.09.29.11.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 11:14:17 -0700 (PDT)
Date: Sun, 29 Sep 2024 14:14:08 -0400
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
Message-ID: <20240929141323-mutt-send-email-mst@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com>

On Sat, Sep 28, 2024 at 12:52:08PM -0500, Michael Galaxy wrote:
> A bounce buffer defeats the entire purpose of using RDMA in these cases.
> When using RDMA for very large transfers like this, the goal here is to map
> the entire memory region at once and avoid all CPU interactions (except for
> message management within libibverbs) so that the NIC is doing all of the
> work.
> 
> I'm sure rsocket has its place with much smaller transfer sizes, but this is
> very different.

To clarify, are you actively using rdma based migration in production? Stepping up
to help maintain it?

-- 
MST


