Return-Path: <linux-rdma+bounces-7673-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04406A3258E
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 13:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9662C1672B7
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 12:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9283720B21F;
	Wed, 12 Feb 2025 12:03:59 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9562046BD;
	Wed, 12 Feb 2025 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739361839; cv=none; b=Uda+3YzOitKV2jos2wXvbBSuvIrftHcPKpr24sX0/QCnnq4ywwOoXjnFl+Ro4iN4onMjbxlA7UmZa2TpznWapQj9Yi3Tjjb9MaiwbVj1WkPIGQunoejEIKy1ZEUK8zdt5WKTz6ZzDxX3GgL1krnNR2742Hqe3sVmEM5/ItmHeyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739361839; c=relaxed/simple;
	bh=G7fPA8lA5/yQZ2LOHOSc+Ks2QauoKsA/EKQji6xdeMg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0Los2xKupjBY2F0M786GnRx/RAJIfSAeCHEawJTWvZQ/hGd7AsBD8G24VTwUM/E1vC6d6KvCysvCfO2+4p+DRGCsX5C464j59pID4WBc8Vlb0a54JrMhi3lwDp8P99QPYATc2WNAVoT0tIIskdr6BPLdMQ9KGP5Ui4bUBn2ACw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YtH2b1X6mz6L5H9;
	Wed, 12 Feb 2025 20:00:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F5291402A4;
	Wed, 12 Feb 2025 20:03:55 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Feb
 2025 13:03:54 +0100
Date: Wed, 12 Feb 2025 12:03:53 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Shannon Nelson <shannon.nelson@amd.com>
CC: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gospo@broadcom.com>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <kuba@kernel.org>, <lbloch@nvidia.com>,
	<leonro@nvidia.com>, <saeedm@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<brett.creeley@amd.com>
Subject: Re: [RFC PATCH fwctl 2/5] pds_core: add new fwctl auxilary_device
Message-ID: <20250212120353.00006f22@huawei.com>
In-Reply-To: <20250211234854.52277-3-shannon.nelson@amd.com>
References: <20250211234854.52277-1-shannon.nelson@amd.com>
	<20250211234854.52277-3-shannon.nelson@amd.com>
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

On Tue, 11 Feb 2025 15:48:51 -0800
Shannon Nelson <shannon.nelson@amd.com> wrote:

> Add support for a new fwctl-based auxiliary_device for creating a
> channel for fwctl support into the AMD/Pensando DSC.

auxiliary_device in title.


