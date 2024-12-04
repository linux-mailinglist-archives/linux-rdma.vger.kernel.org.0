Return-Path: <linux-rdma+bounces-6234-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1639E3BD0
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 14:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FBA166D5A
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 13:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9DD1F7061;
	Wed,  4 Dec 2024 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBK8MfFK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD2E1F667B
	for <linux-rdma@vger.kernel.org>; Wed,  4 Dec 2024 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320542; cv=none; b=AppPtFsm7C4nvgXSqVryHarqMcG8/8GlFq4u401p/HXu+safi6LkzLY1j0Wbpv0+2yZmYDdqGw4PoH1XRncqYYDo8laFywh0q9UzSOopvYa+6DbFDMdzmCOE1w1Jx59yFYQ42VZ4h6QjcutFshajN0eCLj8pm/E6Z/ijoPyOR/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320542; c=relaxed/simple;
	bh=+NZH+L9kjEO1VeZVjVeNmYiiekM4HLIeKckwxWwKgaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n9uf/548eAk1UIp+u7hL4KaEES9sICPsShcniRM7D/TV4AO/8KHfZ5G7lP5+XxEl3PySVn0AGpHoe1DVEvyPiPuqjKk7/f89/tFXx5TIiL1r/gP6cXFpfHM5hqd1R8Zu4WBb008LyN+b8FOJXrUUiHZP633vqVvdU0MpfuvyRgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBK8MfFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B67C4CED1;
	Wed,  4 Dec 2024 13:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733320542;
	bh=+NZH+L9kjEO1VeZVjVeNmYiiekM4HLIeKckwxWwKgaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RBK8MfFKPwrttzU+LDLqSsEZJvO1dxOG8NL2zUWeTIeAWMbLLx/EhmJZ2y+M0H8Vw
	 C9fVr/LP07TQHc91CSEbXqXym7Hub0l/gXBkcelKmDLxWSXaluihcVNfs2Xzfjou5J
	 12DNu18HvlOkl5EuPKXSVts2q+S9wm1GTvrbghx5uj7PVDusEcRBI/A0P5VQzaOq3W
	 +B8ZzPyZP9WC7j3nPq1HmKc3KbC+pOyGtx7O3XN6MNWYOUJb555ul4J1w1FOL5DQWf
	 J3jVzAaovljxDokiIWfjA3JBOljX9JfVvcXhOc5HTq0CosBQVYagM0YRLW163EXUJw
	 0wZdDRoo84C5g==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, kernel test robot <lkp@intel.com>, 
 linux-rdma@vger.kernel.org, Selvin Xavier <selvin.xavier@broadcom.com>, 
 Leon Romanovsky <leon@kernel.org>
In-Reply-To: <be0d8836b64cba3e479fbcbca717acad04aae02e.1732626579.git.leonro@nvidia.com>
References: <be0d8836b64cba3e479fbcbca717acad04aae02e.1732626579.git.leonro@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/bnxt_re: Remove always true dattr
 validity check
Message-Id: <173332053820.3892131.2124309671390496420.b4-ty@kernel.org>
Date: Wed, 04 Dec 2024 08:55:38 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 26 Nov 2024 15:10:31 +0200, Leon Romanovsky wrote:
> res->dattr is always valid at this point as it was initialized
> during device addition in bnxt_re_add_device().
> 
> This change is fixing the following smatch error:
> drivers/infiniband/hw/bnxt_re/qplib_fp.c:1090 bnxt_qplib_create_qp()
>      error: we previously assumed 'res->dattr' could be null (see line 985)
> 
> [...]

Applied, thanks!

[1/1] RDMA/bnxt_re: Remove always true dattr validity check
      https://git.kernel.org/rdma/rdma/c/eb867d797d294a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


