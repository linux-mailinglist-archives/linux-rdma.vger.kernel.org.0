Return-Path: <linux-rdma+bounces-8619-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A654A5E3A9
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 19:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635F717AC43
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 18:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449A92528E3;
	Wed, 12 Mar 2025 18:29:42 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AF81C3BE9;
	Wed, 12 Mar 2025 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741804182; cv=none; b=jd41s8ijLhGlxrYsmj5paqMSN7Q94nvmGN6yVyjzAt+jeEK1RSC+USVL0ZSYVjmbi4RrCb9TQpOcIGwvwfm0vHipjPPc9r+owpAhwK4LGUMn2RBr/lhPLEY3UJOZ4n+j+XLdngQ00n5AZW+NXVHSAt6VYwj7DzMneKTUldVC2cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741804182; c=relaxed/simple;
	bh=PYlpPJU0rTAjzg14cckvJhKxsxB9tVoWv24PR0KgHko=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6tmTLRwlQKnyV6naiklE3dpi5OFranSPXfAADXMLo3quTMUAf07cfAMJEXciOSL7hzamhFS4WWU3nWAtHIO+b6QZIqQhMQd6qbF3lbiLC3wgiA5bObty41OVuGe0vEO4KCEtphVpPKH9uWAIRB0AGr7DBN+Gu3Mhq3IZ+ukNTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZCfH96Q1lz6J9vP;
	Thu, 13 Mar 2025 02:27:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BCEF7140736;
	Thu, 13 Mar 2025 02:29:37 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Mar
 2025 19:29:36 +0100
Date: Wed, 12 Mar 2025 18:29:35 +0000
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
Subject: Re: [PATCH v3 5/6] pds_fwctl: add rpc and query support
Message-ID: <20250312182935.00002f49@huawei.com>
In-Reply-To: <20250307185329.35034-6-shannon.nelson@amd.com>
References: <20250307185329.35034-1-shannon.nelson@amd.com>
	<20250307185329.35034-6-shannon.nelson@amd.com>
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

On Fri, 7 Mar 2025 10:53:28 -0800
Shannon Nelson <shannon.nelson@amd.com> wrote:

> From: Brett Creeley <brett.creeley@amd.com>
> 
> The pds_fwctl driver doesn't know what RPC operations are available
> in the firmware, so also doesn't know what scope they might have.  The
> userland utility supplies the firmware "endpoint" and "operation" id values
> and this driver queries the firmware for endpoints and their available
> operations.  The operation descriptions include the scope information
> which the driver uses for scope testing.
> 
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
(obviously with bitfield.h!)


