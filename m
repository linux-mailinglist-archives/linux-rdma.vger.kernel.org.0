Return-Path: <linux-rdma+bounces-6652-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 432F99F7AD5
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 12:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A764164AFE
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 11:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFCA223E74;
	Thu, 19 Dec 2024 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irHzRYut"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA99223C49
	for <linux-rdma@vger.kernel.org>; Thu, 19 Dec 2024 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734609505; cv=none; b=utO2eA300OnZQEIztAjSkp8mfDUOATuUlSddPFt3vaNV5dSnl7aMXbYRP5Jr4n2gLAxCsNf4vDjHoGMlGGtuqbRbfpR6ZY7py0VjCDwJOD4vv/Gaen+vMgR8cG640gC13CbOS8GlhoJRfxRjTizCp1e9aFGEzXefXUxls195XvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734609505; c=relaxed/simple;
	bh=Ga7EPy+qL1u0DA7nejZSNZLxSKE4+bOSmMU967tKNqo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VQ/MtMulIDZQqJs3z/bOonvkTI/DzZIXA0TVIaiXKjKrO3h6/bLVlGLS0y4mvW26Efd3ZBb3vVOZvWF9N3YbpJn2hoALAvAVp8Z3zSldR8Y5yoiOgFTYTw+q1lw3tg3LgXcIUWStRJeNhDESP2EM80mTwSq0me/Lnf30TiyIvA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irHzRYut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0DCC4CED0;
	Thu, 19 Dec 2024 11:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734609504;
	bh=Ga7EPy+qL1u0DA7nejZSNZLxSKE4+bOSmMU967tKNqo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=irHzRYutYtVdiGNX3WVazPtEcatFpxSwtcQtHwBFuIgcaZnDZDeT7fCrkUqU+RGYU
	 SGlIRvnVQ3QqjClKe9x3CkiIHrB9FXbYSagi5OjbQ6YbenVUyql9qgreCJpputVbX2
	 cza+u3lmjzF49O4gU3nEvdHLfT8AtJafjPPAupLLVhrb7G0fQ24HUgC1N2+0t4jP2o
	 Sq4hR01+2PpSgTrn5fPc1mSJVXluhNbw6lrp2//O8xvIX0kjGIBXezOwNxxLa6pHyw
	 bYjcVku2URnxzjA7kEu2cFNILkMdKrBdTld2in1mJRMpkDrFAxE1V6hVumeFUbdMid
	 /Qe6h5aLYhdkQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 selvin.xavier@broadcom.com
In-Reply-To: <20241217102649.1377704-1-kalesh-anakkur.purayil@broadcom.com>
References: <20241217102649.1377704-1-kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH for-rc 0/5] bnxt_re bug fixes
Message-Id: <173460950150.348922.8636373953699969663.b4-ty@kernel.org>
Date: Thu, 19 Dec 2024 06:58:21 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 17 Dec 2024 15:56:44 +0530, Kalesh AP wrote:
> This series contains bug fixes related to variable WQE
> support in the driver. One fix is for adding a missing
> synchronization in the QP create path.
> 
> Please review and apply.
> 
> Regards,
> Kalesh AP
> 
> [...]

Applied, thanks!

[1/5] RDMA/bnxt_re: Fix max_qp_wrs reported
      https://git.kernel.org/rdma/rdma/c/40be32303ec829
[2/5] RDMA/bnxt_re: Disable use of reserved wqes
      https://git.kernel.org/rdma/rdma/c/d5a38bf2f35979
[3/5] RDMA/bnxt_re: Add send queue size check for variable wqe
      https://git.kernel.org/rdma/rdma/c/d13be54dc18bae
[4/5] RDMA/bnxt_re: Fix MSN table size for variable wqe mode
      https://git.kernel.org/rdma/rdma/c/bb839f3ace0fee
[5/5] RDMA/bnxt_re: Fix the locking while accessing the QP table
      https://git.kernel.org/rdma/rdma/c/9272cba0ded71b

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


