Return-Path: <linux-rdma+bounces-3467-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A83C915EEF
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 08:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405161F22109
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 06:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E759145FEC;
	Tue, 25 Jun 2024 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rz5cTeSu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F1F1CFB6
	for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2024 06:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719297174; cv=none; b=diFhA/TwNcFstY51LLtlHfECoSCVdPnQyqtCzIYoUBsgF+8CCdQDvNcUvoKgBC9kgJWSNA9nBx3hFJ155vosh6UFTRzg1+fUNuUxIxoquVA/yct6Sef1EXTWVPZgbCu6rz94E5fYOsD32Js6Y8gTi96UP8ICIRLdNo6ka3Re2aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719297174; c=relaxed/simple;
	bh=m7IvyucWAMlfX6TPHtwmzEMwgAsG7sac56y7jVdqKMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMYr/eYpQ4Pp+hDIQIdpg4KiYpisrJgi+MufqLpwV7T++9B1tWYgWNUL6lxD94xLrMB3CFvNVW4y5aiL/Z6pKcKhEpTxOQaEJkxcbV2nr7z4q/TyBaItJswfo1/XJlZPmsYxSaHAxWtj7gPhdvMZOYI7OoWpei51j6TBJuaS07Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rz5cTeSu; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mrgolin@amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719297170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sL0qtLhq1fZdv0K+6pk4jCK1/c47ra+KiRI5hNTENb8=;
	b=Rz5cTeSu55IwyMh8QmB5nwvp9RkXdjItvRLcUctjIa8vJvevHaCIpq7yuy77pUGE/2a9Fj
	tYIbQJhEPMYCGMRfbPDkPZv4kYJCK0P/ZTEUpdTq28ONnoh3GKbf2LWDnL7OcJui8YjCuP
	OOcP55pfB33z/9EpEwptfo6O3JR2ba0=
X-Envelope-To: jgg@nvidia.com
X-Envelope-To: leon@kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: sleybo@amazon.com
X-Envelope-To: matua@amazon.com
X-Envelope-To: galpress@amazon.com
X-Envelope-To: firasj@amazon.com
Message-ID: <8bbaea95-c1c8-4f46-9daf-4ec087615cd1@linux.dev>
Date: Tue, 25 Jun 2024 09:32:45 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next 1/5] RDMA/efa: Use offset_in_page() function
To: Michael Margolin <mrgolin@amazon.com>, jgg@nvidia.com, leon@kernel.org,
 linux-rdma@vger.kernel.org
Cc: sleybo@amazon.com, matua@amazon.com, Gal Pressman <galpress@amazon.com>,
 Firas Jahjah <firasj@amazon.com>
References: <20240624160918.27060-1-mrgolin@amazon.com>
 <20240624160918.27060-2-mrgolin@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
Content-Language: en-US
In-Reply-To: <20240624160918.27060-2-mrgolin@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 24/06/2024 19:09, Michael Margolin wrote:
> From: Gal Pressman <galpress@amazon.com>
> 
> Use offset_in_page() instead of open-coding it.
> 
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>

Looks good Gal!

