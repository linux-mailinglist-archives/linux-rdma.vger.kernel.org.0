Return-Path: <linux-rdma+bounces-7590-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421B5A2DBEB
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 10:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04649165A9F
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 09:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B73E15667D;
	Sun,  9 Feb 2025 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFlpJcqX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1B615533F;
	Sun,  9 Feb 2025 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739095123; cv=none; b=Ns3XDCphNk6FV8qcSvesaxbv8tJ8RQMGJM9Yh+cA8cvH3YhvKQ2ZuACyDLOCRKrEUstl2mvXETSp/IKOGQHARf4Awbx0/TTH88JntcfroPhBpIIFqDCanESqAEU28U0JJ+x48VifHsP/QnTjeaMQuHKfqY8Vw1MRm9hr+h0HTzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739095123; c=relaxed/simple;
	bh=L7FwTv+nbIdJL8d3SJiYiMCmiT7OHJiIT96Vv4Q+Qbk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jyhr7sbYxRfQ5vA7TIjpX55aG9e+KQ9Rk/3KZ9517Wf1hEEA9Dr/lQ4cbG4mzsc7kQCHAjURHeyvmTn00fVMPwJuEd+gwSVI7MCx3Y6+60sD5Qm+gxe0iRljy+WJuKxYtSMTzl+BhVHC7eDnIvMCjKML7UCV0YNPrVQirba7ByY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFlpJcqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F6EC4CEDD;
	Sun,  9 Feb 2025 09:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739095122;
	bh=L7FwTv+nbIdJL8d3SJiYiMCmiT7OHJiIT96Vv4Q+Qbk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OFlpJcqX3RrY/Jat/cKRanXNUPbakjiEsQtRpzjOaPbA4BWOYyc+wO2VzHdlu1/qK
	 Q4YFyk5KtpHEtRQKsjLLKCsv2t+23IYtbEfg7ZO7P1AiHkU29Y1BZTYvi/cCwB3Ewn
	 1Ctf8IxBjsNolZRU93IvbFKaWxuLH+L8UOVos3WBWipytuuTJ47BLSQ+UEEapM48Lm
	 dnVRF2oPuL+pLL5KuicKsjm1ftPgFrRHYjgeJAgupnf+QfumdpTzvA67eyetrGLSfg
	 Oh0VE+gZu8VyPMcG4PvYPFx8vZdE6kiiIkyyc+6svOj28thvu/bw1eKZ8HrGuYNGOh
	 rIM10UIo1mf+w==
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <a6b081ab-55fe-4d0c-8f69-c5e5a59e9141@stanley.mountain>
References: <a6b081ab-55fe-4d0c-8f69-c5e5a59e9141@stanley.mountain>
Subject: Re: [PATCH next] RDMA/bnxt_re: Fix buffer overflow in debugfs code
Message-Id: <173909511967.39679.271467641210884194.b4-ty@kernel.org>
Date: Sun, 09 Feb 2025 04:58:39 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 07 Feb 2025 12:16:19 +0300, Dan Carpenter wrote:
> Add some bounds checking to prevent memory corruption in
> bnxt_re_cc_config_set().  This is debugfs code so the bug can only be
> triggered by root.
> 
> 

Applied, thanks!

[1/1] RDMA/bnxt_re: Fix buffer overflow in debugfs code
      https://git.kernel.org/rdma/rdma/c/dbc641ecf1cbd4

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


