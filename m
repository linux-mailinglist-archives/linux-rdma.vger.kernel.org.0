Return-Path: <linux-rdma+bounces-8279-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7E5A4D14C
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 02:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8243ACB31
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 01:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D156F149C64;
	Tue,  4 Mar 2025 01:57:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3766113B58C;
	Tue,  4 Mar 2025 01:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741053438; cv=none; b=njWkGUkxEd/XmdaYvMvNBWLbAaa8hwGIZrSiOl89ISQDXExExo151dd0CaApAbXWURXM3VQlvSE8LEjt+fDXBoXuvC/1qXKJnFq0X8LuMLq7XRRgTLrVlJucQ2xyRXE0+yHrZfdPAnhAcIMaWqX2JXie483keK6xJ1mUVUS9jF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741053438; c=relaxed/simple;
	bh=lqmeCo1Qeo7qXgF8Hg0DRegCJevGjd3CucNZZdfkHWk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lduwmrul63AB7yyHmFkRgr3ZxL8+jobTXqW+ZkChvyfMqPBy0zHl6D26iNnBT29NAqTUUCrVYvmGvRjVcPWrqgw6hUF1N/erhLC78E/orLOiarWnDGXu11S0tD6GO3aS0QbaZagmc3GHB5uTk9tnlEQkqibLh4icntz5ar+Y9M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z6JfG6Q7tz6K9Zn;
	Tue,  4 Mar 2025 09:55:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2464B140A79;
	Tue,  4 Mar 2025 09:57:14 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Mar
 2025 02:57:07 +0100
Date: Tue, 4 Mar 2025 09:57:02 +0800
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
Subject: Re: [PATCH v2 1/6] pds_core: make pdsc_auxbus_dev_del() void
Message-ID: <20250304095702.00007d19@huawei.com>
In-Reply-To: <20250301013554.49511-2-shannon.nelson@amd.com>
References: <20250301013554.49511-1-shannon.nelson@amd.com>
	<20250301013554.49511-2-shannon.nelson@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 28 Feb 2025 17:35:49 -0800
Shannon Nelson <shannon.nelson@amd.com> wrote:

> Since there really is no useful return, advertising a return value
> is rather misleading.  Make pdsc_auxbus_dev_del() a void function.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

