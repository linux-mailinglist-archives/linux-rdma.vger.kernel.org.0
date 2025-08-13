Return-Path: <linux-rdma+bounces-12699-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E445B24778
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 12:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBBCA2A1DF9
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 10:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C5D2F49F1;
	Wed, 13 Aug 2025 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvkB0lRG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367B52F290A
	for <linux-rdma@vger.kernel.org>; Wed, 13 Aug 2025 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081355; cv=none; b=UkZxJaQ31r84YcXqrFvucS+XBy9Qt/Ph2ugHwhr+KzpgUBFJWP01zUhNmegGpX/LRxQ+j8ZPfjLQ1zyDk4xn0zdqesf1sT9fwZ4ME70GRMJU6QxcMU/jon5bKPnoN4F5s4Raj8aokNfd4tM6p8qKRds/XgewQfW3uyLzEk3xjLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081355; c=relaxed/simple;
	bh=SqRt8yBzSsxbJM9foOdPNRghb7KO13P5LLv/G/WMV/Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hlMjLohc4yskZD698z+g921xwl74S62idsvtcBsl2tSO24IdN4YUL8j2CdZ8775PKjXjIFSRfAO/nVQB8N0RyzqCvAJoflhPKXQurCndwjztFFalfgV126+R1J3T9WbxASSN+LkZwj/UKc4al12SU6DFYLaQga4sTYNbii7hxHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvkB0lRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C80C4CEEB;
	Wed, 13 Aug 2025 10:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755081354;
	bh=SqRt8yBzSsxbJM9foOdPNRghb7KO13P5LLv/G/WMV/Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RvkB0lRGbLw/D1FJPzSkOz5QHAF6iaIn2GzS0EPfsLP0u/CMM7oZ83o1u9BlpL+qS
	 zPVQRltiGqeMnO/cicVgkzXjyE1J3hwmeUlLGCC7hSjmza078v/bKR5yd0kJW5q105
	 wcKDAAGP2jHa9C6fSgdUnGl0X6GjSNg1KhWdob3rKDywFMDJ0t5q/6BI8OKSJS0ozR
	 oEn1lS2CRhpRgXVDbPxjrq/LMn4lb0L/7wrRBtUpupAuDj+mXWOgdT/vwlYnBvaYNR
	 nMphNK8e6nNEGBZWskkd2ene9uYDlLbfvM+1s7I3NsRi5V5IXn3OQ47TUBLH8sI9kt
	 ZsrjRI/iIT+hg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 selvin.xavier@broadcom.com
In-Reply-To: <20250805101000.233310-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250805101000.233310-1-kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH rdma-rc 0/4] RDMA/bnxt_re: Bug fixes for bnxt_re driver
Message-Id: <175508135188.199340.16977267980203934260.b4-ty@kernel.org>
Date: Wed, 13 Aug 2025 06:35:51 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 05 Aug 2025 15:39:56 +0530, Kalesh AP wrote:
> This series of patches provides few fixes for the bnxt_re driver.
> A couple of SRQ related fixes, one fix for a possible memory leak.
> 
> Thanks,
> Kalesh AP
> 
> Anantha Prabhu (1):
>   RDMA/bnxt_re: Fix to initialize the PBL array
> 
> [...]

Applied, thanks!

[1/4] RDMA/bnxt_re: Fix to do SRQ armena by default
      https://git.kernel.org/rdma/rdma/c/6296f9a5293ada
[2/4] RDMA/bnxt_re: Fix to remove workload check in SRQ limit path
      https://git.kernel.org/rdma/rdma/c/666bce0bd7e771
[3/4] RDMA/bnxt_re: Fix a possible memory leak in the driver
      https://git.kernel.org/rdma/rdma/c/ba60a1e8cbbd39
[4/4] RDMA/bnxt_re: Fix to initialize the PBL array
      https://git.kernel.org/rdma/rdma/c/806b9f494f6279

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


