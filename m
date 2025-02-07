Return-Path: <linux-rdma+bounces-7516-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4413A2C348
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 14:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75143167EC0
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 13:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22F01E7C02;
	Fri,  7 Feb 2025 13:09:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4DB7FD;
	Fri,  7 Feb 2025 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738933790; cv=none; b=Uj8DXRgNnxy1wc7M8mIblZZItlFeii0czFnTNfZrybkr4/oj+WKRX+rBY4gwmPh+algLYprfLuZkLztsn3Lq3NI5jZWEab1WEgzc/oPAsUcJrk+3HI+c/FMluZnuWmzQKGW7/rP/C2DaegxPQNgCmqmrhWiutlVrYGfnkhbK3U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738933790; c=relaxed/simple;
	bh=sWtdXVwApUDLMddu467r/8NkDwFjBjFHXobyYl0Fbpw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1rv9WKrIeFFwAtX0LKH1ubgxKY4xzjJVx4WR/JqDRZJjRhAM8vVhEXiXHXjYT13BA9CyA2UrhJroa41X1/9HejERYlxUf4APWtYLOb7tyh81W3MtFrl5iouLZwHASubrEeWud+0mLblqohkjjp4/RFXSVHs/83eeSK6+2YrUqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YqDl86Gs9z67MQZ;
	Fri,  7 Feb 2025 21:07:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D3AD140B55;
	Fri,  7 Feb 2025 21:09:45 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Feb
 2025 14:09:44 +0100
Date: Fri, 7 Feb 2025 13:09:43 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton
	<aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Daniel
 Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>, David
 Ahern <dsahern@kernel.org>, Andy Gospodarek <gospo@broadcom.com>, Christoph
 Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Leonid Bloch
	<lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Nelson,
 Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v4 04/10] taint: Add TAINT_FWCTL
Message-ID: <20250207130943.00005b53@huawei.com>
In-Reply-To: <4-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
	<4-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  6 Feb 2025 20:13:26 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Requesting a fwctl scope of access that includes mutating device debug
> data will cause the kernel to be tainted. Changing the device operation
> through things in the debug scope may cause the device to malfunction in
> undefined ways. This should be reflected in the TAINT flags to help any
> debuggers understand that something has been done.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Not something I've ever directly touched before, so more eyes on this
would be good, but FWIW looks inline with other flags and the
general principle seems sensible to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

