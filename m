Return-Path: <linux-rdma+bounces-5199-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C204298F91D
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 23:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38C81C21837
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 21:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA6F1BDAB9;
	Thu,  3 Oct 2024 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HoPNPpaK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC1A1BFE01
	for <linux-rdma@vger.kernel.org>; Thu,  3 Oct 2024 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727991804; cv=none; b=kR9JSPu7eL14atH8Le32GDSs3/NPdw+gkyrdDhkfHgbaSoyToWU5z9PAS0kmPhKQBntnNJJpcNXJgdpeciFPNLAN1oDJBBtr9qeurJrdfHtZFWDjXFwDj/nSPC75A6iqlcRA7IiH7Znvajyc7oWuxsph5FdaUPgmAk0Llh5nuPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727991804; c=relaxed/simple;
	bh=uW5hvuoP3XB0THpD3pnYsA7Eon9I7B0E/UGjgxrbqew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ush8noSKbCP8TPoHfJZvUw05n6h/GoFnRXTuZHIud55oxuvmBvBxUarwLBKiiCjpmUmnD9usJ2pDhE+XNd0QlYYTdL0Uja5zNbKpjfqdOb53hUrglVLVFXFaP3ATiTvRAmJCvpR+zE03V6ufRWKTgp2evpnt8t54bC7gluKwWDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HoPNPpaK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727991801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nR3gvsTeUeSK+aIRUGB28gwBzBHYFQhEYR+AW9GuXQQ=;
	b=HoPNPpaKyLcfFr8gcIBb/I/S0QuX1HfCyJBCAfnIMI4eHNm7dfxHdGBEONPtjhRhKFACLw
	tGBaB/RF6iAsjwpS0rIWMuC8O98erfnayW0P7NVXVXWA1nHsZLYNUMkUWR73hvuDq9Xseh
	hP5SHTEMRZpg5nkPbfbLEvUIIko6q9A=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-5flGjd06PbKaSfdjAkNsPQ-1; Thu, 03 Oct 2024 17:43:20 -0400
X-MC-Unique: 5flGjd06PbKaSfdjAkNsPQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7ae5c5ba98bso231420885a.0
        for <linux-rdma@vger.kernel.org>; Thu, 03 Oct 2024 14:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727991800; x=1728596600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nR3gvsTeUeSK+aIRUGB28gwBzBHYFQhEYR+AW9GuXQQ=;
        b=gHfhw4McpHauTRc5AWbmcRNImwKrNPrJrgPgmtsi4eGj6G3sZl0VreKbSi1zwn2yq8
         kicQq9BnlJ8bzgz4u/tar1nnPyLiQt1WiCiu4GYnxQGnLPjct/EWQW4Gweieq0hXMnNk
         UnEgjLujbztHDTMh3gDi8xow2+9m1DYcflSwQ0qo6ytwHEJZ/PbBNYQ1/dZClQbaR7JP
         1g86zsKE34tIS22IuhguL4wLE5BKh+vQODEjRBNWDKvOV3Qijdg8YUEEmajw1zEZzeMv
         RWE9caCK4OsvgG6Xx6jhwgTW5fdrWwtPJfPtXbOAy+J+3c6xeWXNNrJHwSDnC67/cJo3
         TB8g==
X-Forwarded-Encrypted: i=1; AJvYcCW61QQFZrlH5RQq7bzC9NQskZW9BcAfvLSPyMy5ngkwOKtE1AuXlTVuk4z8uQ0R1c7LXSnvneezvAph@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+frurm7g0cyGBeVAWzXH4EN5dKnTaGa1poIQqhvJa0D7Sueyw
	dKKigYdDy0AGiE9zMvwJ4XGiokzk9e4+4TynOAqUYz0rvLf3cCaLYMBVjMwjRg+bsNfBYIMxx6C
	fdw+6F9WyD7qbVqNZYA5hhlM+bOm4JgdDBfigkzzW60crzzJn9+8unb2ph28=
X-Received: by 2002:a05:620a:2697:b0:7a1:e2d4:4ff3 with SMTP id af79cd13be357-7ae6f4219b9mr96791985a.3.1727991800166;
        Thu, 03 Oct 2024 14:43:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/53UMHwmSM1e7BOlwpHt+KhS5OF0e43lF0H85i9xfKHdWbLE/c2fnEfAVmGp683vIAUKDlA==
X-Received: by 2002:a05:620a:2697:b0:7a1:e2d4:4ff3 with SMTP id af79cd13be357-7ae6f4219b9mr96787885a.3.1727991799857;
        Thu, 03 Oct 2024 14:43:19 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b3dae76sm80824085a.113.2024.10.03.14.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:43:17 -0700 (PDT)
Date: Thu, 3 Oct 2024 17:43:14 -0400
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
Message-ID: <Zv8P8uQmSowF8sGl@x1n>
References: <20240827165643-mutt-send-email-mst@kernel.org>
 <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com>
 <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com>
 <ZvQnbzV9SlXKlarV@x1n>
 <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com>
 <Zvrq7nSbiLfPQoIY@x1n>
 <DM6PR12MB4313D6BA256740DE1ACA29E9BD762@DM6PR12MB4313.namprd12.prod.outlook.com>
 <ZvsAV0MugV85HuZf@x1n>
 <c24fa344-0add-477d-8ed3-bf2e91550e0b@akamai.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c24fa344-0add-477d-8ed3-bf2e91550e0b@akamai.com>

On Thu, Oct 03, 2024 at 04:26:27PM -0500, Michael Galaxy wrote:
> What about the testing solution that I mentioned?
> 
> Does that satisfy your concerns? Or is there still a gap here that needs to
> be met?

I think such testing framework would be helpful, especially if we can kick
it off in CI when preparing pull requests, then we can make sure nothing
will break RDMA easily.

Meanwhile, we still need people committed to this and actively maintain it,
who knows the rdma code well.

Thanks,

-- 
Peter Xu


