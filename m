Return-Path: <linux-rdma+bounces-740-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC2883BE19
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 10:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDBF283E9C
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 09:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F6A1C69A;
	Thu, 25 Jan 2024 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3NXLkPP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553C01BF33;
	Thu, 25 Jan 2024 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176613; cv=none; b=miJFd4jgHdYvj88a6R+g8/nvxK/4laYzwMwKNIOuNRoau2IRnXZRRi/w6JfFb7EpVu1u20IihvrvXCkVJpfGmKCl9xhpAev5CIswYwLSaE4RHSuSfgBIWacwavwwv35Yjnx9F2XfVj0N5surkl6b7jrj4FZkUzGaq0e6LNEJLwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176613; c=relaxed/simple;
	bh=nyvlz6SRusR/COWQ5ImICpj/0AOiXRpWb9Sjjkupgxo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=alrZillo7xy4hZ8bTChG9qo2Xy3stlUoeLAmwS41rjINK9WYmlJysKSO0c9sAOUhhuzvsgk7cfuOhYe8BK9ntDTVqIYrSpdLW8dD01AtYCZ+ccQI0W7R0QuAcrSj6KXIY5+noZwFxSPx0BS939y9HedTNLOQs1JSMziXTiudsmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3NXLkPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42616C433F1;
	Thu, 25 Jan 2024 09:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706176612;
	bh=nyvlz6SRusR/COWQ5ImICpj/0AOiXRpWb9Sjjkupgxo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=G3NXLkPPYUC6LgXJ+FqNhyCm1Vf/bwGwNiZtloHoAmVyyhHn6Yilflejp+kDkZtK9
	 u9v1aLglMAMGd1VQv0HvvnCIOWUQy8WBdP6720+f/fF091duUzq/jx8qE8UVHNhxFj
	 bffYbhOdT7mSwlmS5y96yvd9EblVUg8ajzK0Z8cb2/91b6Iv14IZV3opdQfxY4L4Nd
	 I31meMrEU/Uhc2XjfxqluLmy249PH+2+yGRxhAQNT9slD5qi7pIJkoTLhzxgEmr5I0
	 L/VaqIojDDyN/jKVqw7LWi+0HCE3W6yhEisbxgdABffn5MUTzo9uJucuTrQWuOPM10
	 p23BWVJijdvmw==
From: Leon Romanovsky <leon@kernel.org>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jubin John <jubin.john@intel.com>,
 Mitko Haralanov <mitko.haralanov@intel.com>,
 Ravi Krishnaswamy <ravi.krishnaswamy@intel.com>,
 Harish Chegondi <harish.chegondi@intel.com>,
 Brendan Cunningham <brendan.cunningham@intel.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240112085523.3731720-1-alexious@zju.edu.cn>
References: <20240112085523.3731720-1-alexious@zju.edu.cn>
Subject: Re: [PATCH] IB/hfi1: fix a memleak in init_credit_return
Message-Id: <170617660887.632552.18288740821667270978.b4-ty@kernel.org>
Date: Thu, 25 Jan 2024 11:56:48 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Fri, 12 Jan 2024 16:55:23 +0800, Zhipeng Lu wrote:
> When dma_alloc_coherent fails to allocate dd->cr_base[i].va,
> init_credit_return should deallocate dd->cr_base and
> dd->cr_base[i] that allocated before. Or those resources
> would be never freed and a memleak is triggered.
> 
> 

Applied, thanks!

[1/1] IB/hfi1: fix a memleak in init_credit_return
      https://git.kernel.org/rdma/rdma/c/809aa64ebff51e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

