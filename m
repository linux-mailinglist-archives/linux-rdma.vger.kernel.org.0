Return-Path: <linux-rdma+bounces-15247-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26742CEA0E3
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Dec 2025 16:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 947F03003FEC
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Dec 2025 15:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7563176E1;
	Tue, 30 Dec 2025 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZQluhHNm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E46269B01
	for <linux-rdma@vger.kernel.org>; Tue, 30 Dec 2025 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767108303; cv=none; b=EPSAhd5uI4L7bCBWnUj80WksUmiUIgFGLiET4N30IWftU/XTD8hM3zMTMs6jE7ykU9jbRE3Igkx5P3h53pogCajeb87DmeUxsBd4+vYDki+6poM4okajP79rQemKIQRD1bNK24IdDF6I30YdQ/u/mFA8kVCXKPPtFEp75eq9wAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767108303; c=relaxed/simple;
	bh=z+19XXzhw7bWiiHumIkzFiOhfkzff2pQZRvcmF0wI1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P8NF9iWYMAODHy5l1v/MN/rpgbxO5SKtwYYGqmCncoaH6VWgJ4o0JFpCVKa9oJaQpSSKlF1QelU4IPD+1jtSUR2a47VkQWcMW6ZJaiTYVysKmmQuYi9YMwP9ECc5r1UYypjCMDmnQF9sb/A0CJ8zriMJPgnFbkUqMb9rr7bWHz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZQluhHNm; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fa30ffed-a048-4ddd-8c2b-c12da46dabe5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767108298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4JNr9LgQmpTYYvMhd7Nd2zUkeGA4t4mbjqiQVwnzTSo=;
	b=ZQluhHNm4+t/g4pVSXwug0celth7+BWsd+sjZBxHkvWmgyy9fdt4stUsVsnM0yheCSIG20
	nc07cb8xqauSimjtRxEA31pCJjIbZY5M/ReTRTrqc5OhSSvTfvjxX/hR5+RdZrKy5dGEma
	cC/akYhwcgsvhHlthk7OS8W14t07tgw=
Date: Tue, 30 Dec 2025 07:24:49 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] IB/rxe: ODP: Fix missing umem_odp->umem_mutex unlock
To: Leon Romanovsky <leon@kernel.org>
Cc: Li Zhijian <lizhijian@fujitsu.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, zyjzyj2000@gmail.com, jgg@ziepe.ca,
 Daisuke Matsuda <dskmtsd@gmail.com>
References: <20251226094112.3042583-1-lizhijian@fujitsu.com>
 <deb756fc-dc58-4689-ac0e-632944830871@linux.dev>
 <20251230092751.GA27868@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20251230092751.GA27868@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/12/30 1:27, Leon Romanovsky 写道:
> I made a few adjustments to the commit message, added a Fixes tag, included
> your Reviewed-by, and applied the patch.


Thanks a lot.

Zhu Yanjun


>
>
>
-- 
Best Regards,
Yanjun.Zhu


