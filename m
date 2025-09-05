Return-Path: <linux-rdma+bounces-13115-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F14B45AF6
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 16:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2EE179D9D
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 14:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B6B3728AE;
	Fri,  5 Sep 2025 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="k8HCIN4c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FD3371E82;
	Fri,  5 Sep 2025 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083911; cv=none; b=O6uHl/6NHnXgG+bUwoKqPyMpuZ4EypiojdRYVCGOTF5pXXTgJPys6cdhJNPnEdI56qKYnS9HnrPf6QteRAPPRiP67ol79Jk41ljDECPwmHDz6pYIuWd+AtVq7sSiqRKQiOjVCXIGaWdjqvRmP+JAIYpPt72j+esa1HWlPk+hrNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083911; c=relaxed/simple;
	bh=NINthk2Vb5S+39FpwzP6GkKDoawCYgVCOooHYiXLYts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NROM1/BqQqs5LV2rxsRRIcvotXEgwXy6hTBgnON3yGjdx5vXVb69+BMhxAkgm9hLNYGQUMdaMxB8hLQ8RmKLOEwJ6xH8aB134OLXPFKtfUNp0xQ4rWXgwTtUJBmwcQKOguU5hUGWFUQhuHywCaXFkNil/fvR9dPRwwy/nUUG9kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=k8HCIN4c; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757083898; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=8toPA74+StY+xnHhFcZe0zsBV8eIr3WqRFPMCw6KEcU=;
	b=k8HCIN4c4kvTmAVDqrOwCEFCtOSuNesT14ySY0LgMxKJKoYdg6eCgUltAocALi0rJ8Hr/7e9sweWeAqiD149ZtNNJalGnHj+j7q8B9kc+ozszBFq7dJ2HU6SNYS9RXyxBbDJa8b5V7VZNSsoUggbD5a0Lmuv/DPMRVze1dKXQtU=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WnKvOJQ_1757083897 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 05 Sep 2025 22:51:37 +0800
Date: Fri, 5 Sep 2025 22:51:37 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net/smc: make wr buffer count configurable
Message-ID: <aLr4-V8V1ZWGMrOj@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250904211254.1057445-1-pasic@linux.ibm.com>
 <20250904211254.1057445-2-pasic@linux.ibm.com>
 <aLpc4H_rHkHRu0nQ@linux.alibaba.com>
 <20250905110059.450da664.pasic@linux.ibm.com>
 <20250905140135.2487a99f.pasic@linux.ibm.com>
 <aLryOL-fahUINVg0@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLryOL-fahUINVg0@linux.alibaba.com>

On 2025-09-05 22:22:48, Dust Li wrote:
>On 2025-09-05 14:01:35, Halil Pasic wrote:
>>On Fri, 5 Sep 2025 11:00:59 +0200
>>Halil Pasic <pasic@linux.ibm.com> wrote:
>>
>>> > 1. What if the two sides have different max_send_wr/max_recv_wr configurations?
>>> > IIUC, For example, if the client sets max_send_wr to 64, but the server sets
>>> > max_recv_wr to 16, the client might overflow the server's QP receive
>>> > queue, potentially causing an RNR (Receiver Not Ready) error.  
>>>
>>> I don't think the 16 is spec-ed anywhere and if the client and the server
>>> need to agree on the same value it should either be speced, or a
>>> protocol mechanism for negotiating it needs to exist. So what is your
>>> take on this as an SMC maintainer?
>
>Right — I didn't realize that either until I saw this patch today :)
>But since the implementation's been set to 16 since day one, bumping it
>up might break things.
>
>>>
>>> I think, we have tested heterogeneous setups and didn't see any grave
>>> issues. But let me please do a follow up on this. Maybe the other
>>> maintainers can chime in as well.
>
>I'm glad to hear from others.
>
>>
>>Did some research and some thinking. Are you concerned about a
>>performance regression for e.g. 64 -> 16 compared to 16 -> 16? According
>>to my current understanding the RNR must not lead to a catastrophic
>>failure, but the RDMA/IB stack is supposed to handle that.
>
>No, it's not just a performance regression.
>If we get an RNR when going from 64 -> 16, the whole link group gets
>torn down — and all SMC connections inside it break.
>So from the user’s point of view, connections will just randomly drop
>out of nowhere.

I double-checked the code and noticed we set qp_attr.rnr_retry =
SMC_QP_RNR_RETRY = 7, which means "infinite retries."
So the QP will just keep retrying — we won't actually get an RNR.
That said, yeah, just performance regression.

So in this case, I would regard it as acceptable. We can go with this.

Best regards,
Dust


