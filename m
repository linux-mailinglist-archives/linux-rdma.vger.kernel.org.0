Return-Path: <linux-rdma+bounces-7677-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B028EA3264B
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 13:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F5716909D
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 12:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C5220CCED;
	Wed, 12 Feb 2025 12:51:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5971C1E87B;
	Wed, 12 Feb 2025 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364717; cv=none; b=b69f4RS2OgNd9kHnK0dxtRruDUrSBc2mX4ETI3s7W+OOkT2N8UHSC24nVy0+XVg6I20Vq4mx48tSCE9+BoSCITfc1UljqcWkQE3Cd5c/YSTx/Fvk6Mgwgw4aUgLAu7gPHsa1Luhewx7STMCdhJHZLE69WDMxsEBo7B5/E5/Is2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364717; c=relaxed/simple;
	bh=f739d2dmhPkx5OpsbJlmk/luXaGPXX4YyozCGqM6oFc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+9EIaBFvEoQPcSDVLEaBFlP4Vu8+wjGHzlz+mFHkM2NdisUwh1mPQFO0x4hwwWeoLmMZbFZohyGWFrnQtb4GZSmXmcQfiYW0IkoqeOWgC6SNRurlt5ws4ZVgDJEXV4s9CcDYqpTtqWq2PECNR7QJTNmmrTj4XROeTnJ2ienNe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YtJ7w4QtWz6D8YD;
	Wed, 12 Feb 2025 20:50:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B71D1400CB;
	Wed, 12 Feb 2025 20:51:52 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Feb
 2025 13:51:51 +0100
Date: Wed, 12 Feb 2025 12:51:49 +0000
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
Subject: Re: [RFC PATCH fwctl 5/5] pds_fwctl: add Documentation entries
Message-ID: <20250212125149.00004980@huawei.com>
In-Reply-To: <20250211234854.52277-6-shannon.nelson@amd.com>
References: <20250211234854.52277-1-shannon.nelson@amd.com>
	<20250211234854.52277-6-shannon.nelson@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Feb 2025 15:48:54 -0800
Shannon Nelson <shannon.nelson@amd.com> wrote:

> Add pds_fwctl to the driver and fwctl documentation pages.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
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
> index 000000000000..9fb1b4ac0a5e
> --- /dev/null
> +++ b/Documentation/userspace-api/fwctl/pds_fwctl.rst
> @@ -0,0 +1,41 @@
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
> +userspace interface is used by an application that is a part of the
> +AMD/Pensando software package for the Distributed Service Card (DSC).

Jason, where did we get to on the question of a central open repo etc?

> +
> +The pds_fwctl driver has little knowledge of the firmware's internals,
> +only knows how to send adminq commands for fwctl requests.  The set of
> +operations available through this interface depends on the firmware in
> +the DSC, and the userspace application version must match the firmware
> +so that they can talk to each other.
> +
> +This set of available operations is not known to the pds_fwctl driver.
> +When a connection is created the pds_fwctl driver requests from the
> +firmware list of endpoints and a list of operations for each endpoint.
> +This list of operations includes a minumum scope level that the pds_fwctl
> +driver can use for filtering privilege levels.

Ah. Ok. So the scope is provided in the replies to these queries.
Do we have anything to verify that today?
Also, I wasn't sure when reading driver on whether the operations list
is dynamic or something we can read once and cache?

> +
> +pds_fwctl User API
> +==================
> +
> +.. kernel-doc:: include/uapi/fwctl/pds.h
> +
> +Each RPC request includes the target endpoint and the operation id, and in
> +and out buffer lengths and pointers.  The driver verifies the existence
> +of the requested endpoint and operations, then checks the current scope
> +against the required scope of the operation.  The adminq request is then

Spell out admin q (or is that a typo?)

> +put together with the request data and sent to the firmware, and the
> +results are returned to the caller.
> +


