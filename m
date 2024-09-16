Return-Path: <linux-rdma+bounces-4974-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E48797A6C3
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 19:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47002827A7
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 17:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143AF15C14B;
	Mon, 16 Sep 2024 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGwMdUur"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD00115B57C;
	Mon, 16 Sep 2024 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507643; cv=none; b=bj1kg92U0HiA/PBs8P7DPprSpxF8GvM0hwi2CIxm8MT327SYAvQId3cgcExufrUo6qSsxEfvgbhfpMJmXevhCcn6UUk+aWBt3kEEaCCP75VR3tZ2HlsoCPXeN98zKMyqXOaLzIwazEDGrFZrcSm639edQWrDIUeW+x2ZSVWz2AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507643; c=relaxed/simple;
	bh=+xc3T+HS3P3D5SkUBrTbv9oBZix8vyeXWqLxN/v37hw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZFXuHKICK/bestFSNws0HN0hgUX84igKEBGPg86d4feg6kPZKjR5IvcGptbT9+yuB1UDpBE6A2pJZmMuKDRVNd+orDGRa47vlOfhDllS5x4ylE1yYGnIMoW44sqTmAFtJpF1KG42WFn5S90mKRv2BJxr0CVx5VPnCAuSN+Tz8Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGwMdUur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A8FC4CECD;
	Mon, 16 Sep 2024 17:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726507643;
	bh=+xc3T+HS3P3D5SkUBrTbv9oBZix8vyeXWqLxN/v37hw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OGwMdUurv25xQUMpqd/gk4EsJohro4XBT+7bFHIO34BMX1rpbQitJb9nr0MSquAqV
	 MTmwSDPscBqwuxU1cuMPj93hSDii+gzmwjsOW80tnNIGuYOrILhnLqQppDy54P+lQi
	 Kt6tzOtNA+/aY+VFHdoDHr24YaCvClB+mwAm1ufMlco34mS245Oj0XmfSAtaVDLrDT
	 vapy64YvVUE7+9uPsnQjAZl+F94b0aFUb8ZAGqYerIsdZ69cCFToD5AB8IXiFlkjHy
	 q3BkqyeMj96iEImOSOfVSOohu4DhJNE92yFjWQo1E7X9i006kxzU2qdKNI3/K9TI+T
	 J9zoxyNKyKukQ==
From: Leon Romanovsky <leon@kernel.org>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Vitaliy Shevtsov <v.shevtsov@maxima.ru>
Cc: Mustafa Ismail <mustafa.ismail@intel.com>, 
 Shiraz Saleem <shiraz.saleem@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org
In-Reply-To: <20240916165817.14691-1-v.shevtsov@maxima.ru>
References: <20240916165817.14691-1-v.shevtsov@maxima.ru>
Subject: Re: [PATCH] RDMA/irdma: fix error message in
 irdma_modify_qp_roce()
Message-Id: <172650763993.4296.6996914379843619777.b4-ty@kernel.org>
Date: Mon, 16 Sep 2024 20:27:19 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 16 Sep 2024 21:58:05 +0500, Vitaliy Shevtsov wrote:
> Use a correct field max_dest_rd_atomic instead of max_rd_atomic for the
> error output.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> 

Applied, thanks!

[1/1] RDMA/irdma: fix error message in irdma_modify_qp_roce()
      https://git.kernel.org/rdma/rdma/c/9f0eafe86ea0a5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


