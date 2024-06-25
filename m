Return-Path: <linux-rdma+bounces-3470-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBB1915EF3
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 08:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4351C21B12
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 06:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5E7145FF5;
	Tue, 25 Jun 2024 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XwG8xZFX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E4F1CFB6
	for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2024 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719297212; cv=none; b=s+r8TniqldoqhI9mHH2zvHlrzpJ2sjRPVUdPdjjP1b2JLS4psMKs6V7FOjLap8IAID15T/M8gwU0NJOy18qLAhrpIHOrnLv/DOzr1LCPfyoyxP6K6soNxxKRu/wc7O1DtEnM/ScqM9tWBB3ioj+4XEvxyfFfcOL/+TMu62NV1kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719297212; c=relaxed/simple;
	bh=wCvFZYuKBQj9RW7LBMf5j4EpZfN81b01h/rLMVeX8Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3o5vmCfYHDw97JEtNsTxpqud+jhar6+RV3ixIULF+VR81Z9NwqhNdhthB0VL1ygO2V/R2uTCwCfEDm2UnyGzXyfwDLftHkmw1Emn7WqDwBV7VBNMx0ufBKrNMmMhr8Svoi/refTp3i+Mvc+ThXyC+n8mcBguZkpsH598brhO7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XwG8xZFX; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mrgolin@amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719297209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrVRpVZAtiodUBo1CWVX5RKB0slMEHmmYbvUtdD95EE=;
	b=XwG8xZFXUFsX6refQTmqoYehB8FX49y9n6mu3Muez6G8WJ8/6sFh8ZGfV8kIvBQ0z64Za8
	jfMDF4k6gWjweJeN/KBhkbvwUFgcXPX+U0wU0w/Z3aZg6xbpzYiY7hkA3NvYxgYp4f+aWP
	N/tBSs64tFJHvUOr/Qa6P4pjDa6zzoc=
X-Envelope-To: jgg@nvidia.com
X-Envelope-To: leon@kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: sleybo@amazon.com
X-Envelope-To: matua@amazon.com
X-Envelope-To: ynachum@amazon.com
X-Envelope-To: firasj@amazon.com
Message-ID: <bfd4cbb0-baee-4762-a0d3-8734df36e3d0@linux.dev>
Date: Tue, 25 Jun 2024 09:33:26 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next 3/5] RDMA/efa: Validate EQ array out of bounds
 reach
To: Michael Margolin <mrgolin@amazon.com>, jgg@nvidia.com, leon@kernel.org,
 linux-rdma@vger.kernel.org
Cc: sleybo@amazon.com, matua@amazon.com, Yonatan Nachum <ynachum@amazon.com>,
 Firas Jahjah <firasj@amazon.com>
References: <20240624160918.27060-1-mrgolin@amazon.com>
 <20240624160918.27060-4-mrgolin@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
Content-Language: en-US
In-Reply-To: <20240624160918.27060-4-mrgolin@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 24/06/2024 19:09, Michael Margolin wrote:
> From: Yonatan Nachum <ynachum@amazon.com>
> 
> When creating a new CQ with interrupts enabled, the caller needs to
> specify an EQ index to which the interrupts will be sent on, we don't
> validate the requested index in the EQ array.
> Validate out of bound reach of the EQ array and return an error.
> 
> This is not a bug because IB core validates the requested EQ number when
> creating a CQ.

Then why is this patch needed?

> 
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>

