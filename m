Return-Path: <linux-rdma+bounces-4422-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 291A7957476
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 21:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB9E1C23B70
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 19:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011F41DC484;
	Mon, 19 Aug 2024 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XRSltCHU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC531DC46F
	for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2024 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724095688; cv=none; b=pL5wRgA+JSe/A27KS9Cd2WeZ7N0aQXND3yGd/N8BbNw1LbK6KM4ERsR8sFjfg9ehAB1VJikjNRXAcXNJDilN+zhRst/DGPFe+EwS5x+VwcIsBUQcNBmt5oYGIfRq+ai/ZxgsrLXZ5iQSpycmL/hKCZXBvz4zhC88+z7y5rcstWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724095688; c=relaxed/simple;
	bh=o/AlmL3LCoixnvN5da7Ox9kowMNP3xCvq0VVYiOG1JI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acy+WXRCAvsdOzCBw9vrAtVP7zRTn6PieO58hYBLyg2jn2ffeLNVmHCBDhQiH/VLqZYrmgWEZ5t9zqXrmqbc92+zkgVBsL+BZHCXpq3IeYc930G+Cjfuc+YqtMVqtHUYVgZVBggZTcbCmmWiyXaWvpg8aAsyBqeP9lDsCUUNJuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XRSltCHU; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WnjLG3jvlzlgVnN;
	Mon, 19 Aug 2024 19:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1724095684; x=1726687685; bh=Qo5fGZdC2/uFgG2mgi9Df1Oa
	OS3/bMliJWBKD+4ulfE=; b=XRSltCHU3ooHzL2ykbZQFpm8o2Hf/YHL5bRq7+7h
	W5gBrWccWgghAHp8cYxxwoBeSUlrZtI/q1oXFu9QBq/ReuPFy4MNliYZppoWrsqR
	mJoUuNWPZaSiy8a2bKEpUsoHIndOVBElzodikn9Bpb/ali8n8SGiKkhfJnJXwetf
	RRTKb/YhHWOBi3SZ+LhzmsG2AEqfxelbL5V8H1KJtuPIYo3Brre/11MbAt86ndvR
	G6EAlFUikECF1xHJ7/0qfGZ2kMEnnQE1Gb9H0HXsCXmzFNWt3mBF7nmbsr2VUJgT
	o070ZsvGjAEqeUoDOuUyQaxompMZBqBZvNDaT4IDzSJeYw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id t4OLKLBwE_oV; Mon, 19 Aug 2024 19:28:04 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WnjLC5BTDzlgVnK;
	Mon, 19 Aug 2024 19:28:03 +0000 (UTC)
Message-ID: <092913a6-c898-4258-90ca-926d6864d005@acm.org>
Date: Mon, 19 Aug 2024 12:28:02 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] RDMA/iwcm: Fix
 WARNING:at_kernel/workqueue.c:#check_flush_dependency
To: Zhu Yanjun <yanjun.zhu@linux.dev>, leon@kernel.org,
 linux-rdma@vger.kernel.org, shinichiro.kawasaki@wdc.com,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: kernel test robot <oliver.sang@intel.com>
References: <20240817084244.536397-1-yanjun.zhu@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240817084244.536397-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/24 1:42 AM, Zhu Yanjun wrote:
> When workqueue_flush is invoked, WQ_MEM_RECLAIM is checked to avoid
> errors.

This description is too brief and not entirely correct. In the
description of this patch it should be explained that WQ_MEM_RECLAIM 
must be set for workqueues that are flushed from a work item queued on
a WQ_MEM_RECLAIM workqueue or from a memory reclaim context. Otherwise a
deadlock can occur. From kernel/workqueue.c:

/**
  * check_flush_dependency - check for flush dependency sanity
  * @target_wq: workqueue being flushed
  * @target_work: work item being flushed (NULL for workqueue flushes)
  *
  * %current is trying to flush the whole @target_wq or @target_work on it.
  * If @target_wq doesn't have %WQ_MEM_RECLAIM, verify that %current is not
  * reclaiming memory or running on a workqueue which doesn't have
  * %WQ_MEM_RECLAIM as that can break forward-progress guarantee leading to
  * a deadlock.
  */

> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202408151633.fc01893c-oliver.sang@intel.com
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Since this is a fix, please include a "Fixes:" tag.

Thanks,

Bart.


