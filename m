Return-Path: <linux-rdma+bounces-8290-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2982FA4D54E
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 08:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8D6188D41A
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 07:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E088A1F8EFF;
	Tue,  4 Mar 2025 07:45:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB78E1F8BD0;
	Tue,  4 Mar 2025 07:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074300; cv=none; b=ZetMfmqpr/wAE5ukatvhNgiT3wwBksC7kfc8m1TMf91XajKrwr3OwjTqZddyjY+P7MW4wvJVWcUAaX312CBotcSF//UyfApy8x937ovvUA+trOb89XGW1fiXCzodcq865TFp5EitfP41qwIPf4Nd7ytouHFQUqwnVXaFswncZ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074300; c=relaxed/simple;
	bh=GKW1GzijnNDuoSSABcrM0aY9xwr8OTQf7nql4G1h8ek=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRRA8vYH3yrcZW/jheML0Gbv3iWGYBp3ontMJ2hjRe9VrM5Ki++Qs4j/AH1s4fvG01N3SoElTec28Y7QIpBcKjVZKyiWKpKTf14HiS2OlaHAujVx7VovB61KaFk/g7sm09KRUzZjNaRRhPhf0eUid0cRTshBSDV7SEqsrkYMOzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z6SLZ44f8z6H8W7;
	Tue,  4 Mar 2025 15:41:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D5581140390;
	Tue,  4 Mar 2025 15:44:53 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Mar
 2025 08:44:48 +0100
Date: Tue, 4 Mar 2025 15:44:43 +0800
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
Subject: Re: [PATCH v2 2/6] pds_core: specify auxiliary_device to be created
Message-ID: <20250304154443.00002ae0@huawei.com>
In-Reply-To: <20250301013554.49511-3-shannon.nelson@amd.com>
References: <20250301013554.49511-1-shannon.nelson@amd.com>
	<20250301013554.49511-3-shannon.nelson@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 28 Feb 2025 17:35:50 -0800
Shannon Nelson <shannon.nelson@amd.com> wrote:

> In preparation for adding a new auxiliary_device for the
> PF, make the vif type an argument to pdsc_auxbus_dev_add().
> We also now pass in the address to where we'll keep the new
> padev pointer so that the caller can specify where to save it
> but we can still change it under the mutex and keep the mutex
> usage within the function.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Hi Shannon,

Seems fine to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

