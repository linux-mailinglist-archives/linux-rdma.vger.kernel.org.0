Return-Path: <linux-rdma+bounces-6890-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDD7A04472
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 16:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6518165DF7
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 15:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ED71DFE00;
	Tue,  7 Jan 2025 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGHPCA/R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8AB1F2C59
	for <linux-rdma@vger.kernel.org>; Tue,  7 Jan 2025 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263786; cv=none; b=rTGNWdPh4KK84i1gwE+9x816Zsexgh9NlLUin9Bs36Ml6PS+pYB4BvKDoYhXQTfTYTdW5MgKEAARcAZ0fGRByFMT7bdwNSMRBkYILc6kkttTSbskxNkG6F/q9w5bTiBeAZZzm+v1gMyUIUSeUoCyOQHxRlbCU3N3CdR6OsQVKpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263786; c=relaxed/simple;
	bh=K6nLYtUsNuEnV3j3lak6ilZF1xxIwYVfk6+ha2gEPUk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WYhIorw/syiLFa7/6iPI+lP9Hm/rxFprHakxqGoHu7/0xc2JG33OZiojofXQBWWBKTZiPaUEi465zeU9aMPb/TaTeDWOObYE5RjMJGSUn4WW8ok744p9iXAeZpHpzSwJUccAc5gFGQ6Ub6hc7FKR4uJJOlX9lwHPLfF8znxNzfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGHPCA/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8793C4CED6;
	Tue,  7 Jan 2025 15:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736263786;
	bh=K6nLYtUsNuEnV3j3lak6ilZF1xxIwYVfk6+ha2gEPUk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fGHPCA/R9jgLGIevrSSdgcqds/hSyh38qkS2XuAt7YzPFWQA2LqwaENLAHzz6hHpW
	 pmSbYIamMQEEd6MFw0qa3j3frlZOQzsEIjxnvo12CZhgMsf6o7mzZ/zi9VlyevfzdM
	 Tpmm8coZSKbqVzsWbi5A5+/XC0U3ixY47l6JV+Qrcn6ofrstpJG11H4+1h/HyFoaJt
	 +2PEjSaRFJmh+vM0NmpwpbR1XIM+zVBzu9o+5sC7ftiUXNodJ/u4nZUJA/OTpzyJeQ
	 ds/XvWopgkrhtt9TPjlh8AoorRxCYWTT6PiHzlnprU/SxSJFNTnwLpZim6RtLy/ojX
	 qEIKsesm/R73w==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 kalesh-anakkur.purayil@broadcom.com
In-Reply-To: <1736240519-2491-1-git-send-email-selvin.xavier@broadcom.com>
References: <1736240519-2491-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next] MAINTAINERS: Update the bnxt_re maintainers
Message-Id: <173626378279.662109.18296053209767846235.b4-ty@kernel.org>
Date: Tue, 07 Jan 2025 10:29:42 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 07 Jan 2025 01:01:59 -0800, Selvin Xavier wrote:
> Adding Kalesh to the bnxt_re maintainers list
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Update the bnxt_re maintainers
      https://git.kernel.org/rdma/rdma/c/76b26917e4ff95

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


