Return-Path: <linux-rdma+bounces-2540-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03168C9B88
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2024 12:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10461C21A13
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2024 10:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B507F51033;
	Mon, 20 May 2024 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WHuac8Fy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5F450286
	for <linux-rdma@vger.kernel.org>; Mon, 20 May 2024 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716201808; cv=none; b=sTYtnKtGbaUZSyVgViIGM6eQQN8qRGKjrsqdtCpjKFzEZPWiq3rYLsEplrsN71ryqdWlX04b/80KYou/UzHn+7Y7GbGDs2gDbsTi6K004FDTSL7dlsyiTGZYyJ5SPiY2qy5lbQcrRAqFFECeLb9heKthPzzTj+t22fletH4edwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716201808; c=relaxed/simple;
	bh=yRHXtghe5z89244/S63/0Fd8Y6AKZhJVaSvyKO2WylA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m64L9BYDpDUe4/YvCHJ8rKCW1ruViHonAA0k/DIFTWrHY9vTmYfmdd5G2KKjKfrKWTV5rb1UGWvk5Ydv1vUlq0/4hYcYfhn2FJxvL4dh2Ony+LADGVzU0v7dzHkMjVzVtvcQ59+VI5EfSMcZFiABRcfnkzVJdzAl61IlzyTJWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WHuac8Fy; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mrgolin@amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716201803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=59rIHVpfU/G38JMREWZbmcv7RnxeG71oZNNENCAAOME=;
	b=WHuac8FyFS6+xo2oP+vzSidXygnRgnDYmpqxWKLcNRMTCcbNNtzMxw0Gzj7OxWNkw8i+H3
	tVBT3FJH6D+HFOJFVmp7CkyDWwEFeB80qXJV6bhE0ypHeZQRZQYJnkX4kQKVIZnHcuiUyS
	KpwQFw9w2LFYc1XraJjDCVWpUClDv2I=
X-Envelope-To: jgg@nvidia.com
X-Envelope-To: leon@kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: sleybo@amazon.com
X-Envelope-To: matua@amazon.com
X-Envelope-To: dkkranzd@amazon.com
X-Envelope-To: firasj@amazon.com
Message-ID: <f01a57e9-6281-435b-9b34-8ba9c6b7df15@linux.dev>
Date: Mon, 20 May 2024 13:43:15 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/efa: Fail probe on missing BARs
To: Michael Margolin <mrgolin@amazon.com>, jgg@nvidia.com, leon@kernel.org,
 linux-rdma@vger.kernel.org
Cc: sleybo@amazon.com, matua@amazon.com,
 Daniel Kranzdorf <dkkranzd@amazon.com>, Firas Jahjah <firasj@amazon.com>
References: <20240513081019.26998-1-mrgolin@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
Content-Language: en-US
In-Reply-To: <20240513081019.26998-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/05/2024 11:10, Michael Margolin wrote:
> In case any of PCI BARs is missing during device probe we would like to
> fail as early as possible. Fail if any of the required BARs isn't listed
> as a memory BAR.
> 
> Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>

Reviewed-by: Gal Pressman <gal.pressman@linux.dev>

