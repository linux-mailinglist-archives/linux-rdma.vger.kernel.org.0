Return-Path: <linux-rdma+bounces-15026-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3051CC30E7
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 14:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9AB830C9218
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 12:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65A4315D37;
	Tue, 16 Dec 2025 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PSBAGMVD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C2352FBE;
	Tue, 16 Dec 2025 12:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888508; cv=none; b=hrwMMHLkhyHcab/1a4dP9hvri0FV1XamWUY2sGplebnMpjHduwvCK4NgC/7YQLAb/olJY6dcTl50plfjSN3BV2Kz/iO7IY+wgN7aknbHgk8/bnM2Zx5vMRQS1prn5XBN17yIvUheQbtLmrzjub9w+haCL0rnlXyrkBGNU54totY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888508; c=relaxed/simple;
	bh=cgGxVNdlbOGOEB7xHpJICvWAymkybYv1/BLUuSK62mI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DIk/6e3qkJB2gTnLBz3A9alEHSSGApJyBoKvvxWbwfcVCsizwPbLttBVtLtR5tY1gAT86/bSX0RKHWnS1gHAjn7WDk6oub3r+O9Z+VRZLU64WpK6o6uxPYTF4IOBb+CfQMI3vQYr9w3Ge3cZO7z/ixatrMsw5zToysklN//X/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PSBAGMVD; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765888504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFjVtvUuWwOGCFrbIDWKqYAUGKQ80rC+g/IPutxxD9s=;
	b=PSBAGMVDj+NMdaq+gZJ6yeLqIjRyTfFR5BrcshD+wL6P7ymWfzFtipvBBLsU0XCzFlBQHT
	5Fzcsx8Be1bKl0WitAohN3GxaozrNIPdrT3Zwsrw0vqZ+B/N5t4fDLQfSYWBwNE6Wr+9P4
	K2cIbaN1zo+1iOYiYk9LFCZrKERJys0=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] RDMA/ionic: Replace cpu_to_be64 + le64_to_cpu with swab64
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20251216005112.GA31492@ziepe.ca>
Date: Tue, 16 Dec 2025 13:35:02 +0100
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
 Allen Hubbe <allen.hubbe@amd.com>,
 Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <3BC136A4-B5FF-40B1-968C-67BB30C73239@linux.dev>
References: <20251210131428.569187-2-thorsten.blum@linux.dev>
 <aTu7FFofH/ot1A74@ziepe.ca> <66a98775-76f2-683f-77b1-7f5dc991ca14@amd.com>
 <20251216005112.GA31492@ziepe.ca>
To: Jason Gunthorpe <jgg@ziepe.ca>
X-Migadu-Flow: FLOW_OUT

On 16. Dec 2025, at 01:51, Jason Gunthorpe wrote:
> Okay, so Throsten, please don't send patches for changing to swab.

Yeah sorry, I didn't know about the sparse warnings before.

> If you want to improve it then the primitive should be
> 
> le64_to_be64(x)

le64_to_be64() or a similar helper doesn't seem to exist.

Thanks,
Thorsten


