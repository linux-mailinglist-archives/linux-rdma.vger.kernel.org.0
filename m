Return-Path: <linux-rdma+bounces-3014-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723559014F1
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2024 10:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16320281BBB
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2024 08:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A86DEAE9;
	Sun,  9 Jun 2024 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOzdQgA+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47332BE4F
	for <linux-rdma@vger.kernel.org>; Sun,  9 Jun 2024 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717921539; cv=none; b=izH3OzQzKdDHNaFrG4gWK5xUOraa3cuJijxgEDUW1i9oF1SZr3KiPJaM1hYk4Us9TLqsqBUhrh7VnQzsnQzwqrccAPANbEZhCbchNZKmeW+l3bStwFFFtig/q4XlbGxZ6Bh+1C4b/0EmT7LBAtA+S8aXbnR7XD6K+1dcXxysx6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717921539; c=relaxed/simple;
	bh=+pvk7CsuX3fSp6HVKM+V/B/NFJvVAeEIEHGzMnBa02A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V0JR9BRfaORcO9CnF4A3MjikxLC15UjH+j7NjBXurHFDOiqhqItzdJA0gy7SDqDTzIxP2SYIEcTmeojXdlXR63BwU3glweTfEw9Gd9JtdHi4cVsppd97uWMDIw0lHoJdY71+JHaytbsARK1VoECJYu58GzEo8x5N71gVS/ShkUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOzdQgA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C744C2BD10;
	Sun,  9 Jun 2024 08:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717921538;
	bh=+pvk7CsuX3fSp6HVKM+V/B/NFJvVAeEIEHGzMnBa02A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EOzdQgA+uKrWmHUQpRc/IvSjfvHAKeV47k8IbBfmHjWTPL48LxCUN3F000679/nPQ
	 57Evvg3ffYzY+qJMi+OBJ50aGBv+/2JPOOGI5FqPW1c6pOHeT5PJw6LRqNKszXyTBm
	 5/sXRTCrY/Kr678YEQbInLN6XKyWU1xbbxRg9IphzD3n0hW6oMmpHj3soasSpkIjFM
	 i/LUsFhhp8wKN+CNjNffAcBsyQfVumJsyqnaQu/Ew6re9gc6J9WfpxYNTo0c0xVuPC
	 ZMRooVtOUxbI8cyrBzhM1LiP2dYUTF2C8H4FLdFuALiffJEt/cPt73IsEhuQkxm+Ab
	 GMCqu5AHMEbPw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Bart Van Assche <bvanassche@acm.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org
In-Reply-To: <20240605145117.397751-1-bvanassche@acm.org>
References: <20240605145117.397751-1-bvanassche@acm.org>
Subject: Re: [PATCH 0/5] iWARP Connection Manager patches
Message-Id: <171792153388.13016.9924006204063993635.b4-ty@kernel.org>
Date: Sun, 09 Jun 2024 11:25:33 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Wed, 05 Jun 2024 08:50:56 -0600, Bart Van Assche wrote:
> This patch series includes four cleanup and one bug fix patch for the iwcm.
> Please consider this patch series for the next merge window.
> 
> Thanks,
> 
> Bart.
> 
> [...]

Applied, thanks!

[1/5] RDMA/iwcm: Use list_first_entry() where appropriate
      https://git.kernel.org/rdma/rdma/c/b1bc15f8fb5f20
[2/5] RDMA/iwcm: Change the return type of iwcm_deref_id()
      https://git.kernel.org/rdma/rdma/c/fc772e38bce563
[3/5] RDMA/iwcm: Simplify cm_event_handler()
      https://git.kernel.org/rdma/rdma/c/e1168f09b33149
[4/5] RDMA/iwcm: Simplify cm_work_handler()
      https://git.kernel.org/rdma/rdma/c/a1babdb5b61575
[5/5] RDMA/iwcm: Fix a use-after-free related to destroying CM IDs
      https://git.kernel.org/rdma/rdma/c/aee2424246f9f1

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


