Return-Path: <linux-rdma+bounces-463-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5298199CF
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Dec 2023 08:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0824B21B7D
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Dec 2023 07:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A929C16430;
	Wed, 20 Dec 2023 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEnF6omt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C901D520
	for <linux-rdma@vger.kernel.org>; Wed, 20 Dec 2023 07:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B27C433C8;
	Wed, 20 Dec 2023 07:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703058387;
	bh=LI7CAK05uWBueT60Aa3P3mZgG3ZxIyjSe5rYTK414dI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UEnF6omtY/7azChFGsVlfzZVU+ASu1E9sT0ncalnv5uSe7Aq3+Tf4Yo28+38E+EgF
	 o8m+Zmuq9ZgEEag3mVhR/vgIS3R5nopOebg+iHMbKhkGz0uzyH65QUOY7BkQXW1sfP
	 KCGESWDuVL+6k25DaLBeXcz1AlpBkj2kiprYhyBHOZ2OdzMKSpaajcWO71tVxViiDH
	 oBa8oGOnGYNER9kLgPCdEWqXRDoLL3b8DWTvDblSD4sJ4oCzJz0fTyGe23jvBpDRtE
	 f5cc8w4djDx/deFEONTouxUQmrLrc4W7MBQAqinRHyQgKw8K6yMqJ/R15gT863QRkf
	 NrP9IT2MKHP5g==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
In-Reply-To: <1702987900-5363-1-git-send-email-selvin.xavier@broadcom.com>
References: <1702987900-5363-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next] RDMA/bnxt_re: Fix the offset for GenP7 adapters
 for user applications
Message-Id: <170305838350.138961.11550074306925387615.b4-ty@kernel.org>
Date: Wed, 20 Dec 2023 09:46:23 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Tue, 19 Dec 2023 04:11:40 -0800, Selvin Xavier wrote:
> User Doorbell page indexes start at an offset for GenP7 adapters.
> Fix the offset that will be used for user doorbell page indexes.
> 
> 

Applied, thanks!

[1/1] RDMA/bnxt_re: Fix the offset for GenP7 adapters for user applications
      https://git.kernel.org/rdma/rdma/c/9248f363d0791a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

