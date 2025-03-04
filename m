Return-Path: <linux-rdma+bounces-8297-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2CCA4D79B
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 10:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5047C163112
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 09:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3281FC119;
	Tue,  4 Mar 2025 09:12:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9E71FCD03;
	Tue,  4 Mar 2025 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079566; cv=none; b=KXvaix8ZopaUmS9L3Yb4XaHwCwNHUu8DzzYgsi5tqOA25seQf7Rn6h4uDXjEkuUULlxmS9q+xb6BdmkTKRI0ks4vDTbuDLH/of2MJnsVtV3gtL6bQcOcgtpYp8EeC6ZObsVY0W9Sacy1Og79ovCEmHtm2CUpk9+IlcCqp2t0flg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079566; c=relaxed/simple;
	bh=ZWvuMx2+4EmX6WpVXP/Z928gOwal0g/A3s0y3GM8yUw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkbyxDRsrSO6b8eMx0fLGp9WijKxRCBZW0MEwfz9ifS035QbK9h+CW5imkECvCxIBEM/A94NA0bW0D6JELZYM6jenftoGHNo5wG70ggChvDxVSOd4DZCY/tRdymcFyF95OwHF2RWu2iTXILVCyp1vXdpFTnqMWsninYyy5X1VqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z6VHs2ZF4z6M4Yg;
	Tue,  4 Mar 2025 17:09:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9942C140A86;
	Tue,  4 Mar 2025 17:12:40 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Mar
 2025 10:12:35 +0100
Date: Tue, 4 Mar 2025 17:12:30 +0800
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
Subject: Re: [PATCH v2 6/6] pds_fwctl: add Documentation entries
Message-ID: <20250304171230.00007a5e@huawei.com>
In-Reply-To: <20250301013554.49511-7-shannon.nelson@amd.com>
References: <20250301013554.49511-1-shannon.nelson@amd.com>
	<20250301013554.49511-7-shannon.nelson@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 28 Feb 2025 17:35:54 -0800
Shannon Nelson <shannon.nelson@amd.com> wrote:

> Add pds_fwctl to the driver and fwctl documentation pages.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Really minor stuff inline.

Thanks,

Jonathan

> ---
>  Documentation/userspace-api/fwctl/fwctl.rst   |  1 +
>  Documentation/userspace-api/fwctl/index.rst   |  1 +
>  .../userspace-api/fwctl/pds_fwctl.rst         | 41 +++++++++++++++++++
>  3 files changed, 43 insertions(+)
>  create mode 100644 Documentation/userspace-api/fwctl/pds_fwctl.rst
> 
> diff --git a/Documentation/userspace-api/fwctl/fwctl.rst b/Documentation/userspace-api/fwctl/fwctl.rst
> index 428f6f5bb9b4..72853b0d3dc8 100644
> --- a/Documentation/userspace-api/fwctl/fwctl.rst
> +++ b/Documentation/userspace-api/fwctl/fwctl.rst
> @@ -150,6 +150,7 @@ fwctl User API
>  
>  .. kernel-doc:: include/uapi/fwctl/fwctl.h
>  .. kernel-doc:: include/uapi/fwctl/mlx5.h
> +.. kernel-doc:: include/uapi/fwctl/pds.h
>  
>  sysfs Class
>  -----------
> diff --git a/Documentation/userspace-api/fwctl/index.rst b/Documentation/userspace-api/fwctl/index.rst
> index 06959fbf1547..12a559fcf1b2 100644
> --- a/Documentation/userspace-api/fwctl/index.rst
> +++ b/Documentation/userspace-api/fwctl/index.rst
> @@ -10,3 +10,4 @@ to securely construct and execute RPCs inside device firmware.
>     :maxdepth: 1
>  
>     fwctl
> +   pds_fwctl
> diff --git a/Documentation/userspace-api/fwctl/pds_fwctl.rst b/Documentation/userspace-api/fwctl/pds_fwctl.rst
> new file mode 100644
> index 000000000000..f34645dbf5ea
> --- /dev/null
> +++ b/Documentation/userspace-api/fwctl/pds_fwctl.rst
> @@ -0,0 +1,40 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================
> +fwctl pds driver
> +================
> +
> +:Author: Shannon Nelson
> +
> +Overview
> +========
> +
> +The PDS Core device makes an fwctl service available through an
> +auxiliary_device named pds_core.fwctl.N.  The pds_fwctl driver binds
> +to this device and registers itself with the fwctl bus.  The resulting

fwctl is a class not a bus though here I'd be tempted to say subsystem.

> +userspace interface is used by an application that is a part of the
> +AMD/Pensando software package for the Distributed Service Card (DSC).
> +
> +The pds_fwctl driver has little knowledge of the firmware's internals,
> +only knows how to send commands through pds_core's message queue to the
> +firmware for fwctl requests.  The set of operations available through this
> +interface depends on the firmware in the DSC, and the userspace application
> +version must match the firmware so that they can talk to each other.
> +
> +This set of available operations is not known to the pds_fwctl driver.
> +When a connection is created the pds_fwctl driver requests from the
> +firmware list of endpoints and a list of operations for each endpoint.
requests from the firmware both a list of endpoints and a list of operations for
each endpoint. 

As currently written the sentence suggest that we are asking for something
unspecified from the "firmware list of endpoints..."

> +This list of operations includes a minimum scope level that the pds_fwctl
> +driver can use for filtering privilege levels.
> +
> +pds_fwctl User API
> +==================
> +
> +.. kernel-doc:: include/uapi/fwctl/pds.h
> +
> +Each RPC request includes the target endpoint and the operation id, and in
> +and out buffer lengths and pointers.  The driver verifies the existence
> +of the requested endpoint and operations, then checks the current scope
> +against the required scope of the operation.  The request is then put
> +together with the request data and sent through pds_core's message queue
> +to the firmware, and the results are returned to the caller.


