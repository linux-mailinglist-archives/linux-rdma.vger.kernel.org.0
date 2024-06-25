Return-Path: <linux-rdma+bounces-3469-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E81B915EF2
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 08:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB0A283A76
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 06:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FE9145FF4;
	Tue, 25 Jun 2024 06:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nSnFJ4b2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC96B1CFB6
	for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2024 06:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719297200; cv=none; b=CHa2y2XgiFNHDRErnJ+I2ljllhlYRmkPj4dP1afwslStFfVJWchA/X36xn0oTkY44bFKXviwzy4W5mn5WfnUnVYgq7mN1nm+SvqlHfKukP0uWdD2jVQ3jZ9o/oBZZLAtls+OvsJD/P6eEL/0HGZMKA8KStADzlay+TacnLPfGeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719297200; c=relaxed/simple;
	bh=wlz5jvb+05u3VWlNA/T4P8jHcv6mC6ONbc33d4JSwRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1sLaXi7TOng+gvLuFDbG+5fMdj4kDDuHIaiY+7HCX2mkipJjT0VmhfqlbtYoS4aQPjl0j9UYRLr5z/GQrldwo+wn34IgIoD3hmyR0vzkDnqF/kIvLVSdMNEAyb+fGNuEPlsNHjClXvrAJTh2V00nLfwtljNza71iFlb5T61O2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nSnFJ4b2; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mrgolin@amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719297197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbEUXGEOyhM+yMwBXLEAOPt4kw9DHiT0+mDlBLUsttQ=;
	b=nSnFJ4b2GzejIKDyjaQwQV3PcPz2c1MIryliM98a0J8WaMSfG8bC2UKrVZ+LGXT8HRtMYp
	Jelh2UDT+N7n5HuLXZIHjzhPz0wpL5z+IwseU+pcZB9fMllGpGfWBuDiRq6NXnCNWclxCV
	AtJYXmBmGF7f/D/s2B0NVi4XYFK0rzU=
X-Envelope-To: jgg@nvidia.com
X-Envelope-To: leon@kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: sleybo@amazon.com
X-Envelope-To: matua@amazon.com
X-Envelope-To: firasj@amazon.com
X-Envelope-To: ynachum@amazon.com
Message-ID: <1c1f22fd-10fb-4fc6-a4a7-f167013b60c3@linux.dev>
Date: Tue, 25 Jun 2024 09:33:14 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next 4/5] RDMA/efa: Move type conversion helpers to
 efa.h
To: Michael Margolin <mrgolin@amazon.com>, jgg@nvidia.com, leon@kernel.org,
 linux-rdma@vger.kernel.org
Cc: sleybo@amazon.com, matua@amazon.com, Firas Jahjah <firasj@amazon.com>,
 Yonatan Nachum <ynachum@amazon.com>
References: <20240624160918.27060-1-mrgolin@amazon.com>
 <20240624160918.27060-5-mrgolin@amazon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
In-Reply-To: <20240624160918.27060-5-mrgolin@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 24/06/2024 19:09, Michael Margolin wrote:
> Move ib_ to efa_ types conversion functions to have them near the types
> definitions and to reduce code in efa_verbs.c.
> 
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>

The idea was to not expose these functions in the h file as they are not
used outside of efa_verbs.c.

