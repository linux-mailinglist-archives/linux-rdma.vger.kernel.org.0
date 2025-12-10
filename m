Return-Path: <linux-rdma+bounces-14957-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A955CB3B56
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Dec 2025 19:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95EDE3079E8F
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Dec 2025 18:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35463126CB;
	Wed, 10 Dec 2025 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YJ31wTS/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0301A9F90
	for <linux-rdma@vger.kernel.org>; Wed, 10 Dec 2025 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765389657; cv=none; b=f4CHIzPe6O8HVoDs9H4u+X701nm/HIx/VGaHKuLLCFyXJfmuCAU6Z3TtY97nn0Q5NIwGaDR6Ze1R/jRqeFIrETgdJR3+LH3UAUqm4ge5gSKJh13KdOr9nqdjqR74s7/XijzI9gIeJEfZzBm1aT3gG2zfDx6jHjQbke8NAnLJtAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765389657; c=relaxed/simple;
	bh=7bGSfXkdTZAnaPp04d/PLuT285nKhfqKl75IF7+tbAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHfdf04wwJHiUHhfA71UF5UbbbWV+itOrqoDzaNE4OXlgmgRWU9wy52BVGh9FQoQ/dGFr0pUS+Orl9LLYzJPwWZ6w69+1Iogi2gwu6u8+MLeGcr1yGMN0n1SQuvHrnAns+stkOFFWlGMgInyefKGDL39uTJ0Bx1SEJS2PEsTg6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YJ31wTS/; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8a514f12-0b67-408f-ac6d-5f9e346c76f0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765389652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ky7q5PwMoMHKtYPjKwTCW+L0r7TGulwFR64owqSjHqc=;
	b=YJ31wTS/NfLYL2rDosh6IK0vkhiddFTO3IEECfBoEpykyK4as7pFc9/OZfWM+F/KLwgr3k
	JoqMwXBTq1TNm6hOcXgm9Goemc8goz+98QVgiZI3GgFHNnKsIUwDbhC1Krc8/k68XQyC77
	D4P7TTYY63oBZFgGvlsuIBYxS4MdwlU=
Date: Wed, 10 Dec 2025 20:00:50 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/efa: Remove possible negative shift
To: Michael Margolin <mrgolin@amazon.com>, jgg@nvidia.com, leon@kernel.org,
 linux-rdma@vger.kernel.org
Cc: sleybo@amazon.com, matua@amazon.com, Tom Sela <tomsela@amazon.com>,
 Yonatan Nachum <ynachum@amazon.com>
References: <20251210173656.8180-1-mrgolin@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
Content-Language: en-US
In-Reply-To: <20251210173656.8180-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/12/2025 19:36, Michael Margolin wrote:
> The page size used for device might in some cases be smaller than
> PAGE_SIZE what results in a negative shift when calculating the number
> of host pages in PAGE_SIZE for a debug log. Remove the debug line
> together with the calculation.
> 
> Reviewed-by: Tom Sela <tomsela@amazon.com>
> Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>

Reviewed-by: Gal Pressman <gal.pressman@linux.dev>

I don't know if you target this to -rc or -next, but this probably
deserves a Fixes tag.

