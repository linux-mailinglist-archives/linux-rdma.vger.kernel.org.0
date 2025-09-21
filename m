Return-Path: <linux-rdma+bounces-13533-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD97B8DA4E
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 13:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D407189D906
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 11:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81BB2BEFFD;
	Sun, 21 Sep 2025 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6laAfbO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4659B13B284;
	Sun, 21 Sep 2025 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758454507; cv=none; b=Gf2TpD3klhItG94UNUp2HRX/2dvvB1qWYYPphf8le/V3EeXCAJnkDGLNjnXw8IRXNBwLc6otGylcAQhGtuVxKmYWFjg6/FSqew1bh0+7lmjSxQIUonZcEl/otLFsRX0OBsWeuIrJHN8XQzsdCTiz5VS7dBOKzywzoIzvq5/cGvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758454507; c=relaxed/simple;
	bh=9RirVJ+oRinL3Yqw4bpLEbY0lfsulX8n+ssxtmmcVzc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XlW5wE1/96YN9IVyEUbmHKOmmRuR5jlip8aJynsiwN5FzeGkP5WLPyMiu6L55pavh4ELkGnR6gNWIVdrKH/tpIgIKZZl7rE+7lMEhliMyjgo21LNUFBRpuIwmq8ue6webZocitLDIISl+yfdyL8622HyMSALQh0You/J8aEHrkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6laAfbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A913C4CEE7;
	Sun, 21 Sep 2025 11:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758454506;
	bh=9RirVJ+oRinL3Yqw4bpLEbY0lfsulX8n+ssxtmmcVzc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=I6laAfbOW3d0FfhmJOxLNiOQnSE74AZCo27nOatD3m5G62yC8RoAPvHMjAAn1ddRM
	 /hD5c0BrfHIJ8BRwTtdgtZ4lwuo5s4Bp1MTxsEJOrzBIpxgIyY8HwxJ5sJ3tnSJBRL
	 oRsiIkLO5f8GLTERCmGSu7v8KOKcTcI+HgpF2csxRI2NSqsFhJSmZa8YzmPHMT5pU1
	 EBzAwwp5mg9vh5Nlz9CtlyVUtGMDoEtpq5p1bic0h6/aKNR02hLAUxLihe2XWY+DqY
	 zVuLAzgF4pwtWvr56C79tZWeZL8EWJkoqMJhsoPPLQlIOvilEOj5hhVn5d3q8zShdn
	 +5kkhj3a0dE4g==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>, 
 Allen Hubbe <allen.hubbe@amd.com>, Bart Van Assche <bvanassche@acm.org>, 
 Chengchang Tang <tangchengchang@huawei.com>, 
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Junxian Huang <huangjunxian6@hisilicon.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Konstantin Taranov <kotaranov@microsoft.com>, linux-rdma@vger.kernel.org, 
 Long Li <longli@microsoft.com>, Michael Margolin <mrgolin@amazon.com>, 
 Mustafa Ismail <mustafa.ismail@intel.com>, 
 Potnuri Bharat Teja <bharat@chelsio.com>, 
 Selvin Xavier <selvin.xavier@broadcom.com>, target-devel@vger.kernel.org, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>, 
 Yishai Hadas <yishaih@nvidia.com>, Leon Romanovsky <leon@kernel.org>
In-Reply-To: <e81ec02df1e474be20417fb62e779776e3f47a50.1758217936.git.leon@kernel.org>
References: <e81ec02df1e474be20417fb62e779776e3f47a50.1758217936.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA: Use %pe format specifier for error
 pointers
Message-Id: <175845450356.2104816.4462663406652713808.b4-ty@kernel.org>
Date: Sun, 21 Sep 2025 07:35:03 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 18 Sep 2025 20:53:41 +0300, Leon Romanovsky wrote:
> Convert error logging throughout the RDMA subsystem to use
> the %pe format specifier instead of PTR_ERR() with integer
> format specifiers.
> 
> 

Applied, thanks!

[1/1] RDMA: Use %pe format specifier for error pointers
      https://git.kernel.org/rdma/rdma/c/4b6b6233f50f72

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


