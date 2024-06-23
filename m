Return-Path: <linux-rdma+bounces-3411-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 496A6913ABD
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jun 2024 15:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED12B1F2185B
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jun 2024 13:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4FE17FAD2;
	Sun, 23 Jun 2024 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vXJShoiB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC31884D11
	for <linux-rdma@vger.kernel.org>; Sun, 23 Jun 2024 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719147821; cv=none; b=giNv3pZmUFXS/tlmwjD3lt6OTWYk3hnfUiV28a5QSvkZ5db3QIqUuNXLShC906MltFqLnPq1aE7KRTt5qUFtdfmrADiqBAZdY5Gg4uEnOKzPttizFjT6LvVYbbd8KwRezmRneIsHaCbRhxuUaDvkQz0s8cD2+VbGcJMQN6KESmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719147821; c=relaxed/simple;
	bh=Bj5FnBF4i2sihrGlLuzD5IsOpC/3tWciQWS86QJgc3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdLmEctp5QeZ/r6iPFCsYUSPJWswrPwNh1iD8rahw0uVD47gQDMmuq4VervvFbFlV+zsCwtMcfjq8txyrae0bSRw76fj4M9S5IztCpH2I1rUkz2r54eR3fjEii9jA8/jvABrX1NyaD/t2516sbGLBQasYiZv3YyaQSe+xRzXdFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vXJShoiB; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mgurtovoy@nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719147815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZpMlVJ+jaIKNfbBuiKZlvKVWDvGFGqrDWEQvknRsjU=;
	b=vXJShoiB6Kl8C6LDFDQf21XiOgU0xnzje9Rg27Lk8JkSB4jwlgxlNxFCxVWMuNFUR7u9G0
	nvYiTPZmjYFWordThzh/QcB8YnLcQw46rpK+D0kGFfSqMVWU4IlE4fmVeN+cAm5u6bi88m
	uYUDwLoBEV65Hv4JuSFjDym6vdNCQcE=
X-Envelope-To: leonro@nvidia.com
X-Envelope-To: jgg@nvidia.com
X-Envelope-To: linux-nvme@lists.infradead.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: chuck.lever@oracle.com
X-Envelope-To: oren@nvidia.com
X-Envelope-To: israelr@nvidia.com
X-Envelope-To: maorg@nvidia.com
X-Envelope-To: yishaih@nvidia.com
X-Envelope-To: hch@lst.de
X-Envelope-To: bvanassche@acm.org
X-Envelope-To: shiraz.saleem@intel.com
X-Envelope-To: edumazet@google.com
Message-ID: <9a23267e-3d63-44d2-8f06-ca8cbbf2567a@linux.dev>
Date: Sun, 23 Jun 2024 21:03:24 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 0/6] Last WQE Reached event treatment
To: Max Gurtovoy <mgurtovoy@nvidia.com>, leonro@nvidia.com, jgg@nvidia.com,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 chuck.lever@oracle.com
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com,
 yishaih@nvidia.com, hch@lst.de, bvanassche@acm.org, shiraz.saleem@intel.com,
 edumazet@google.com
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240618001034.22681-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/6/18 8:10, Max Gurtovoy 写道:
> Hi Jason/Leon/Sagi,
> 
> This series adds a support for draining a QP that is associated with a
> SRQ (Shared Receive Queue).
> Leakage problem can occur if we won't treat Last WQE Reached event.
> 
> In the series, that is based on some old series I've send during 2018, I

The old series is as below. It had better to post the link.

https://www.spinics.net/lists/linux-rdma/msg59633.html

Zhu Yanjun

> used a different approach and handled the event in the RDMA core, as was
> suggested in discussion in the mailing list.
> 
> I've updated RDMA ULPs. Most of them were trivial except IPoIB that was
> handling the Last WQE reached in the ULP.
> 
> I've tested this series with NVMf/RDMA on RoCE.
> 
> Max Gurtovoy (6):
>    IB/core: add support for draining Shared receive queues
>    IB/isert: remove the handling of last WQE reached event
>    RDMA/srpt: remove the handling of last WQE reached event
>    nvmet-rdma: remove the handling of last WQE reached event
>    svcrdma: remove the handling of last WQE reached event
>    RDMA/IPoIB: remove the handling of last WQE reached event
> 
>   drivers/infiniband/core/verbs.c          | 83 +++++++++++++++++++++++-
>   drivers/infiniband/ulp/ipoib/ipoib.h     | 33 +---------
>   drivers/infiniband/ulp/ipoib/ipoib_cm.c  | 71 ++------------------
>   drivers/infiniband/ulp/isert/ib_isert.c  |  3 -
>   drivers/infiniband/ulp/srpt/ib_srpt.c    |  5 --
>   drivers/nvme/target/rdma.c               |  4 --
>   include/rdma/ib_verbs.h                  |  2 +
>   net/sunrpc/xprtrdma/svc_rdma_transport.c |  1 -
>   8 files changed, 92 insertions(+), 110 deletions(-)
> 


