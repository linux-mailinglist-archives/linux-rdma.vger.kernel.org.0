Return-Path: <linux-rdma+bounces-5613-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA2F9B6304
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 13:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2E31F219DE
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 12:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2FB1E5722;
	Wed, 30 Oct 2024 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJoVGCLs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBC21D1E7A
	for <linux-rdma@vger.kernel.org>; Wed, 30 Oct 2024 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730291123; cv=none; b=pT0xI8fdM9KOT3TKPdjAwFcn0+e5dLCh/WVuk/f9S6y3vzroQgUPAGKjVqQTKK4FFxkvIl4zs62PetGFtanmsZSA1wYRi/Ro3DhSGLhFAs6NJnzp5YNhu0e29H25RgpEaPJfjCURf6g4siVJNWuY/JcUK25NDpK5h/WPPgM6jUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730291123; c=relaxed/simple;
	bh=WloN/ROkf16dvACEkJzcLRpWt2/dmJXK0MUD20lI6mc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XuUJUXFCE+hTiwZU1t+ntnh3r1j0llaP2sEGjB92VYGeMyYrY6pKafXXHLpWt6myNqUMs6MUkp7+DbBvDkX3fTjyOxp/CzTBjif71RWdtddCszADBqzSDv2ebT8VMejhSaAGUSjJzttHs3Ef7YYIelz8qqGsYjvGPm27JMIhvTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJoVGCLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BBAC4CEE3;
	Wed, 30 Oct 2024 12:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730291122;
	bh=WloN/ROkf16dvACEkJzcLRpWt2/dmJXK0MUD20lI6mc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mJoVGCLsq+rMHJaW/SuzcWQ+FfzpcCpXb3ca2XQ2JJr3k5yP2v+jnL/A6TNP9mNL1
	 PYI/aJzJiRq3cruAk6bqlmPKYW9ZJsxB0Yd3f5Br3lAVOqO3av0ofHhoJNTWBMtWFe
	 FwlC/CfD26CXrt7ZuvZsST2mawOxTYfPTypYvAqSpG7AwfTX1DPetST5Ih9lc/AQ5W
	 kTuOl/l868jH/oCouPWAFif9NvR3uxqr7azWNDRPrxVTLmjIIcjiRwxbZaA6jAzGq6
	 ipOU3yL/EI//zTe814VGT2mrgVqbcen8c6NYY4bqKA+SHq4uiM6uSjcxaInpPmOxAF
	 +bTnYkjpsSsUQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 kalesh-anakkur.purayil@broadcom.com, kashyap.desai@broadcom.com, 
 Jack Wang <jinpu.wang@ionos.com>
In-Reply-To: <1730110014-20755-1-git-send-email-selvin.xavier@broadcom.com>
References: <1730110014-20755-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-rc] RDMA/bnxt_re: Check cqe flags to know imm_data
 vs inv_irkey
Message-Id: <173029111880.62532.4137596423722248472.b4-ty@kernel.org>
Date: Wed, 30 Oct 2024 14:25:18 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 28 Oct 2024 03:06:54 -0700, Selvin Xavier wrote:
> Invalidate rkey is cpu endian and immediate data is in big endian format.
> Both immediate data and invalidate the remote key returned by
> HW is in little endian format.
> 
> While handling the commit in fixes tag, the difference between
> immediate data and invalidate rkey endianness was not considered.
> 
> [...]

Applied, thanks!

[1/1] RDMA/bnxt_re: Check cqe flags to know imm_data vs inv_irkey
      https://git.kernel.org/rdma/rdma/c/808ca6de989c59

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


