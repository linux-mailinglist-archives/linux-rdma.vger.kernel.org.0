Return-Path: <linux-rdma+bounces-2209-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC328B9CCB
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 16:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 686C2B23B56
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA554153803;
	Thu,  2 May 2024 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mixePdvr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36405160781;
	Thu,  2 May 2024 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661219; cv=none; b=oOETRNa9y5VWKGvSXm2uZaQm8tkIf4EPe91LbWO82j+n+dpDM5LvTmFnUasFyHziRstEJVKua41lIqfcLXePb1mmq9WlC6TeNrdfQAtIHsSaaxddJ/hJfPE6sX8Jj/j+HPplhtdUr4gmlxutBGkaROlKgvBXFpfJh9LQP7rtnjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661219; c=relaxed/simple;
	bh=V5gXs6TvijArdQBXrnEsdGKdWOcmg2X3CXITyzJl0/A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NhAt7O/LB6o/Cv80Rk63HeXngEVMYSRxmChRoAGtopzvDT8ErSQVLIpxS90jOQ97S18TXQLntnqITYzS0WDWyxQfsUBm1qxgfHS76k4kxoLTd8aNV+kpaE43DR4cxm59HEGzV1qBuNW5rBoiipDY+a8SDp9Go2M+53nG6JyhQzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mixePdvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABFEC113CC;
	Thu,  2 May 2024 14:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714661218;
	bh=V5gXs6TvijArdQBXrnEsdGKdWOcmg2X3CXITyzJl0/A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mixePdvr2FIBmbXuS5uAXeHQHbtcWJ0ks9Wj4YukUtFztdOUN9Ab3UJisIMLXvw3i
	 YTsl7GF6WAlS7s9FEnw23EMjfGKMtrzpR0dBaRrsMSdmkhAph0Z+wOKj508ZVDCOfe
	 wEjWSOR32YUWCoJpP5ZQYXLLk+8FWOI1oA7/q1g4K3qtSzMctk/3PQZKzltvYZ/5pu
	 ttP13Bf/8VN1mHE0Dq6Tjgzko90UQMlrNtt3w9oQYZiPodwhlJrPYQI/GMy3kxYyeB
	 O1qsIgDafkSOz4JUwSaOdKUB26RdrHfVl+EJEO7E5eTANqALz1eUdJuG8oDblPtcNM
	 uiX8iIXzCkSmw==
From: Leon Romanovsky <leon@kernel.org>
To: Jules Irenge <jbi.octave@gmail.com>
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 lishifeng@sangfor.com.cn, gustavoars@kernel.org
In-Reply-To: <ZjGC4qXrOwZE0aHi@octinomon.home>
References: <ZjGC4qXrOwZE0aHi@octinomon.home>
Subject: Re: [PATCH] RDMA/mlx5: Remove NULL check before dev_{put, hold}
Message-Id: <171466121283.1638184.16945329377468449493.b4-ty@kernel.org>
Date: Thu, 02 May 2024 17:46:52 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Wed, 01 May 2024 00:46:42 +0100, Jules Irenge wrote:
> Coccinelle reports a warning
> 
> WARNING: NULL check before dev_{put, hold} functions is not needed
> 
> The reason is the call netdev_{put, hold} of dev_{put,hold} will check NULL
> There is no need to check before using dev_{put, hold}
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Remove NULL check before dev_{put, hold}
      https://git.kernel.org/rdma/rdma/c/82e966130ddd67

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


