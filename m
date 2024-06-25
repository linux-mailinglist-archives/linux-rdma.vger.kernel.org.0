Return-Path: <linux-rdma+bounces-3468-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F148915EF0
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 08:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3BF1F215CB
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 06:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C07145FED;
	Tue, 25 Jun 2024 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XlYVr7bA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2F61CFB6
	for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2024 06:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719297180; cv=none; b=bjAFiA0g4yIa0pMRtT/urRIT5kLGjik0EYK8ddse6XVGKP+qxtDkuVKZBbrsspIX7/eRsdptVBw6JIKxJlU2nRgaXM6UIDBlSDCUi2KKS4dHlm8/tjYuuv6uw6WtaAxmZ7zsxfG0uBYIyfurbj0kf59zl1tKqOxsZZQYqgZ+EbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719297180; c=relaxed/simple;
	bh=AeZtVyGRTMe80QzpOrQghvr2kcXDYMp9Z/blGcdloko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LYNwBS43ueL2hYF9sfGBPMj8+iiLFiJ2YCR7SqQR58+OfiG8KDK0xW8rC/R6mxNopPOeYDEXJ5NbUpgZIxFpo5ZEiqsCYNXeMaTzm9ZkorGYWIFFnQffK8a5+/GWLOGAof5CyT/IRD9BY2sqjBtm/9I+SygjnmODimQJEoneC2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XlYVr7bA; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mrgolin@amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719297175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Qh8oavJFcMXn5Tn73IWGRuf9cGXaasn1JrBU1Kf6Zk=;
	b=XlYVr7bABTRPFiW8hRPdESl69P9OKvSW7n7E1B7jJMx94+rwjkgMfakTCdDGBGO7u7fx1o
	/s9WWD7PI2a6W6jo3cDbYoINzWfExLaY/2RVo4Js+wkAURgbnnKKA+mI+ZkjeKm6/oAaSR
	+udBkAk17AL/PYKCt34kimULot+sG+g=
X-Envelope-To: jgg@nvidia.com
X-Envelope-To: leon@kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: sleybo@amazon.com
X-Envelope-To: matua@amazon.com
X-Envelope-To: ynachum@amazon.com
Message-ID: <7100f0eb-99c1-4239-a0f6-03797d97590d@linux.dev>
Date: Tue, 25 Jun 2024 09:32:54 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next 2/5] RDMA/efa: Remove duplicate aenq enable macro
To: Michael Margolin <mrgolin@amazon.com>, jgg@nvidia.com, leon@kernel.org,
 linux-rdma@vger.kernel.org
Cc: sleybo@amazon.com, matua@amazon.com, Yonatan Nachum <ynachum@amazon.com>
References: <20240624160918.27060-1-mrgolin@amazon.com>
 <20240624160918.27060-3-mrgolin@amazon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
In-Reply-To: <20240624160918.27060-3-mrgolin@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 24/06/2024 19:09, Michael Margolin wrote:
> From: Yonatan Nachum <ynachum@amazon.com>
> 
> We have the same macro in main and verbs files and we don't use the
> macro in the verbs file, remove it.
> 
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>

Reviewed-by: Gal Pressman <gal.pressman@linux.dev>

