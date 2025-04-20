Return-Path: <linux-rdma+bounces-9614-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FF0A9482E
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 17:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7F43B448D
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0868320B20A;
	Sun, 20 Apr 2025 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lW4HeE/3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BCC13B59B;
	Sun, 20 Apr 2025 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745162535; cv=none; b=sXmDBR7K5Mwu+r8XXar2s2xHXT5hVjr+9Q7CaVOFbE/Q10AHqtW3PP89bT+ZiSU1/DqtX/+Ui0gV6gjnod0mFr9G+TXkPxMI74hW6611uin0HVOz5S6vV3P+O9zcHD/a6QaMxoaaffjzzhAKE0ZJ52GeFvm/gPMYqO+Q+ZSw5t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745162535; c=relaxed/simple;
	bh=OQ20mkTiGknvqf/kHMGluQwjSWZG3iUa228Wigy35JI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d14L3GFrDW2AkOm3iLT8GE5AOf471ypaf7R02Qma4HyijVR/QkLM/22Jspmv+rZXuLZvEwlfzDBV7MpK38EDWOOqopasIn0KMKewL2H2bHCQh3+b44LoErY8MpK8CI0Hu1OmEB8cd8ONmobTMgcduEdWkbldeu43LYkKoxW8JAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lW4HeE/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D8FC4CEE2;
	Sun, 20 Apr 2025 15:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745162534;
	bh=OQ20mkTiGknvqf/kHMGluQwjSWZG3iUa228Wigy35JI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lW4HeE/3MTLX8PiV/8QZ4grtGqi+MHUJ5DVG5oyqjw0KxbOS6AQcGmWqJevCVabjX
	 g7L3LrDigZS68SSPNQfCDJjzEzP5+UJNVmZL0P8cVIhUQzB8sgEqo7jzALOeL2mxUP
	 kX6RXJwhPx2IMWI5cK86E2XrM6j2t7gPG9yUGSsWkYfHPYIWDpjUOh9vof4Z9iX9mG
	 Qhv5qBGRSTVyEMjwppDQCc+CiTxDDy1f/qhT6DYgmO8M4k6gJuxbcYYKnOMXSjVqVC
	 oF0T2Dkk/PWDSt+VsX6L4QLm2JaUnA4JhBh4XaJVtyCNWR6Iho+SGA/ObzZZLAvxRC
	 CjtAzsHAgGsfg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, linux@treblig.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250418165848.241305-1-linux@treblig.org>
References: <20250418165848.241305-1-linux@treblig.org>
Subject: Re: [PATCH] RDMA/cma: Remove unused rdma_res_to_id
Message-Id: <174516252721.721883.15933851274910173867.b4-ty@kernel.org>
Date: Sun, 20 Apr 2025 11:22:07 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 18 Apr 2025 17:58:48 +0100, linux@treblig.org wrote:
> The last use of rdma_res_to_id() was removed in 2020 by
> commi t211cd9459fda ("RDMA: Add dedicated CM_ID resource tracker function")
> 
> Remove it.
> 
> 

Applied, thanks!

[1/1] RDMA/cma: Remove unused rdma_res_to_id
      https://git.kernel.org/rdma/rdma/c/04039390cc3cb3

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


