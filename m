Return-Path: <linux-rdma+bounces-12702-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A49B247E7
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 13:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DB597B00F3
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 11:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3077B2F6586;
	Wed, 13 Aug 2025 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVSKa7XL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBDF2F657D;
	Wed, 13 Aug 2025 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082972; cv=none; b=itkyHQTn7us9BUhavDLS7MSXKAOWWaBUvs6woWT7Af19VP45zbiLCxkuB4ChuQpiNNVuR9xGq9kKg+BXsput3VYBPcUAcBdXNXWDdpMDsOEySJQWG+FD3s5KEzr8RQMjOtmGMf+HnLtxAihDGUPjyvUzJz5YyUt0EUmfBHrwzf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082972; c=relaxed/simple;
	bh=VF+8hq4bkXa+A5pCGm7VgTReGjczHteGXGp0VIRjfc0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZgibI2TG/4gNmmOLPpPAJv9g02BS+A7RQRhMCg10sahuP0SOD72LjdQQk42KwO0vedDKKlgS0PGr6KtdKfJZayy2+vU/vM0+gKFDLBWjIqg6s/Pq6GnH1izOQRffS8bSch0Y1kShTl+/rifdBGbsxV2tIeeQel+VyhyfZbHneH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVSKa7XL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD5FC4CEEB;
	Wed, 13 Aug 2025 11:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755082971;
	bh=VF+8hq4bkXa+A5pCGm7VgTReGjczHteGXGp0VIRjfc0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BVSKa7XL3BXIn0DeWji49/OI3xIMxxlDMXoYhiSHyZ2py6O31VRIPerpQtJVzlpqO
	 UbWoDwaOj/c30rfiSTqUv4GRB6aoPWO5phK8nZuB1LmaxLEPDD+rY+u8V6RPYE3uHR
	 NvZfgrLuN3nozVlDgm7S+R1dVAtloGO6CNjC90Evrhw++V+ap3eNzZ4gtYanJ+DJdD
	 L+rg7qxbHeO9J1XbPjcC/wlHq1znKFJo1r4NWdN4cjZglMCCrjrnNAb9597fBgt7LI
	 HSY8RZ2efm1ltSK4TX1Sto1cSjVEiOVJw1nbQiKIbRp1wUPmP1evfSLBUtpNTrP7wT
	 whvYMUtZ7OH5A==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, michaelgur@nvidia.com, ohartoov@nvidia.com, 
 shayd@nvidia.com, dskmtsd@gmail.com, hch@infradead.org, 
 Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
In-Reply-To: <aJjcPjL1BVh8QrMN@bhairav-test.ee.iitb.ac.in>
References: <aJjcPjL1BVh8QrMN@bhairav-test.ee.iitb.ac.in>
Subject: Re: [PATCH] RDMA/core: fix memory alloc/free for pfn_list
Message-Id: <175508296763.200362.3314419784184530983.b4-ty@kernel.org>
Date: Wed, 13 Aug 2025 07:02:47 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sun, 10 Aug 2025 23:21:58 +0530, Akhilesh Patil wrote:
> Ensure memory allocated for umem_odp->map->pfn_list using kvcalloc()
> is freed using corresponding kvfree() to avoid potential memory
> corruption. Match memory allocation and free routines kvcalloc -> kvfree
> 
> 

Applied, thanks!

[1/1] RDMA/core: fix memory alloc/free for pfn_list
      https://git.kernel.org/rdma/rdma/c/111aea0464c20f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


