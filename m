Return-Path: <linux-rdma+bounces-8617-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749F6A5E394
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 19:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440AC189B90D
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 18:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43154253322;
	Wed, 12 Mar 2025 18:22:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B8E1BD01F;
	Wed, 12 Mar 2025 18:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741803737; cv=none; b=Js82dWkO53Qkh2DvaMTHHJWfRjLYwf12v9ZcvPuaJcjBjrFbfkZxnOXftyaCaBDQWNOoIGhy71O4cG2ldQjjfQ2D/6piHfg6mTkwLtHq7Ah7n8HYA//iCPGloOyz8ECedSuwIu0KPxLQkGydMpbe8bkFqhpGSSjOngf/OpCDKkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741803737; c=relaxed/simple;
	bh=+XmwuY6/CBHGuQ/W4kAUVu5xgOl0jsxahV22FRaF9cU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PjRtGdrHROGEjEBMy65M5vXD/Cm3hxmEFFmaH6IaodAkbOFeZQrBEOTliuwo1jpS6AAesaIlwT7dxJA+sy3Um4zFW+8IO9+t945ceMokUpIdsu0SdCagEHxS61wp6Rlxy2VakW54rkgQHuFLGDAVMxJHvN6JwQu+KG9kz187s9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZCf6b4JD9z6J9tr;
	Thu, 13 Mar 2025 02:19:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 83C631400D3;
	Thu, 13 Mar 2025 02:22:11 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Mar
 2025 19:22:10 +0100
Date: Wed, 12 Mar 2025 18:22:08 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Shannon Nelson <shannon.nelson@amd.com>
CC: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <kuba@kernel.org>, <lbloch@nvidia.com>,
	<leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>,
	<brett.creeley@amd.com>
Subject: Re: [PATCH v3 3/6] pds_core: add new fwctl auxiliary_device
Message-ID: <20250312182208.000031ad@huawei.com>
In-Reply-To: <20250307185329.35034-4-shannon.nelson@amd.com>
References: <20250307185329.35034-1-shannon.nelson@amd.com>
	<20250307185329.35034-4-shannon.nelson@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 7 Mar 2025 10:53:26 -0800
Shannon Nelson <shannon.nelson@amd.com> wrote:

> Add support for a new fwctl-based auxiliary_device for creating a
> channel for fwctl support into the AMD/Pensando DSC.
> 
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
FWIW LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



