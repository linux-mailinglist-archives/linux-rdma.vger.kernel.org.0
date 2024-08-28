Return-Path: <linux-rdma+bounces-4615-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F2C96264D
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 13:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F4F284B08
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 11:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5296616D334;
	Wed, 28 Aug 2024 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ef2sV57J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D62115B12F;
	Wed, 28 Aug 2024 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724845684; cv=none; b=lQGYxVXPDDXk11uPE9Pi2e6DMLyakv0gfAU2P5JbtuMeJktfe31R5xlN+8oL/dkquIjMotfefVcBsM+0ohrkmsRTZa8T4XSCvPSF8dxlAOPwu27UjMsk0YPNI0SnKemPHZNF4j6hS0UoGQ9xRfPuzlAGa+UZ6FYhUrtS3SvUdoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724845684; c=relaxed/simple;
	bh=UcbQr3T9talPWUKX3sN4Y4UpWfglVwqdWsncD9N0i3A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r3+5kahy8+jYXtoNHbL8P83iNw04U+0UoPycklwp5pswqqNEfdgd7GcRLFBFq5Xqf4rMtSfl3OJaJ1CRKqSiAIKUdiMVduritiEs8MqYHr8qikUyQuB9LkGKVjogdn+FSvsB2wZVFNY4wt5FT0RKtnpFY9qiA3db3e2hkdMmgq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ef2sV57J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCB4C98EC3;
	Wed, 28 Aug 2024 11:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724845683;
	bh=UcbQr3T9talPWUKX3sN4Y4UpWfglVwqdWsncD9N0i3A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ef2sV57Jfz4QWpP3ZsNj0bpWM5K99C5t1J7Xxm9yncxLXEHEGojDKnrQtTlkVTMKP
	 KwpvRP8/QOLOBTKrUlpwfY2IGocTKLIaIKOYSPjaKU0TDY+QuGdmW5Qf8Q7U6Jrurt
	 AMdz3zyd5dQV0wqtOzShwGd0D3gGIychaxJNOe8gBZULP3bNEM7kFeEZBSKGqZkHFZ
	 21mena2qMnpEnzrZp+32UpQpa3HPOGYkvYF2aqXgr4S6xIZN2nPPS54Oi1G6MLDZ9T
	 E/19DtAHfZnInbUhv2/r35vX9xyEFFK9psYJ4tPMmmXYnbrml/lwilBTZZbW4ftJdf
	 QvFw1UgtBF3wQ==
From: Leon Romanovsky <leon@kernel.org>
To: bharat@chelsio.com, jgg@ziepe.ca, anumula@chelsio.com, 
 Yue Haibing <yuehaibing@huawei.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240824091629.3659565-1-yuehaibing@huawei.com>
References: <20240824091629.3659565-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] RDMA/cxgb4: Remove unused declarations
Message-Id: <172484567995.137827.1459785663222489124.b4-ty@kernel.org>
Date: Wed, 28 Aug 2024 14:47:59 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sat, 24 Aug 2024 17:16:29 +0800, Yue Haibing wrote:
> Since commit be4c9bad9d0e ("MAINTAINERS: Add cxgb4 and iw_cxgb4 entries")
> c4iw_post_terminate() declaration is not used anymore.
> 
> And other declarations were never implenmented since introduction in
> commit cfdda9d76436 ("RDMA/cxgb4: Add driver for Chelsio T4 RNIC").
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/cxgb4: Remove unused declarations
      https://git.kernel.org/rdma/rdma/c/c5558627a3f867

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


