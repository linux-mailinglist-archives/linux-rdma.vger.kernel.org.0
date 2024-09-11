Return-Path: <linux-rdma+bounces-4883-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0221D975431
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 15:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52772830D4
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 13:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D3A1A00C5;
	Wed, 11 Sep 2024 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ul2Q4jlQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F9F19F136
	for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2024 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061450; cv=none; b=TTjeJcyuV73cmaIkXOeQov+ATiaI+x442KMfCUl+oLnOJABAEge4wWZwVU4U+L3bdsSFxqWLM5kwm9d1BuAjmFLFR4Mm8ByK37O3sjvcdBnaI612fjY1/DH3sWi2jbIFOhHLD/z+KA8Fg7Or8X0BSwRHMHfkEtAzWX13m9tljbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061450; c=relaxed/simple;
	bh=sI6mmp5Ifc9Xmk8LXa/DjMb9X25nY/QAKPuwZJiz48I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Wp9L5TCRfE5UJ9Vhdkbn+yCIAVl8IZCJtKDBd+wpz7E5ULTmypszxCHhWM7Fp4VAY9t8TaRqCf23Smi5Mu5cV6gtSBngI0MKQFi5Gg7+ee6spMq5odpkqrynCX0CsG+6+ZSJedE6eCUGr37gggYUQSN2wkhC9/uldZ8X+Hato+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ul2Q4jlQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBC2C4CEC5;
	Wed, 11 Sep 2024 13:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726061449;
	bh=sI6mmp5Ifc9Xmk8LXa/DjMb9X25nY/QAKPuwZJiz48I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ul2Q4jlQqrK+GxHdHWyg+ywPqV6+N17Gx8yUEBAp9sOSeXp1itBn4B7Wi108aY6Lc
	 bcDFqdbOyd3PMu72PgsOQIgGcTIHm1kz7/xHiXfl2S8Dn+W5Vo5tzZ+T2TI8IMACHY
	 ye+yYw2OLWalPgYZMBpjWCOMrTdr8dZ9sIhIWtZVE2UtkYsB/xLY0qkhd+9uKAJGpO
	 jT5b9D8+8ubB7G0o38ztR5gqCBn6aeUOfuGqT2sWWPfhK4BKUfqyPG0z9zPyNCoyZ/
	 qCSILX56D1zhQYG5cKcMhHgYR6YnTkt/q3a+aGgjVmRHTW+wwUoeK9oVJwKHQMoOa5
	 5E3ZDdhg8ejgw==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 kalesh-anakkur.purayil@broadcom.com
In-Reply-To: <1726027710-2292-1-git-send-email-selvin.xavier@broadcom.com>
References: <1726027710-2292-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next v2 0/4] RDMA/bnxt_re: Device re-initialization
 after Firmware error
Message-Id: <172606144530.3705222.5969212964119784223.b4-ty@kernel.org>
Date: Wed, 11 Sep 2024 16:30:45 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 10 Sep 2024 21:08:26 -0700, Selvin Xavier wrote:
> Add support for complete re-initialization of the device when
> driver detects a firmware reset. Code reorg that updates the
> device handles stored with Auxiliary bus and the bnxt_en driver.
> bnxt_en driver calls suspend and resume hooks upon error recovery.
> Driver destroys and recreates the roce device instance upon receiving
> these calls.
> 
> [...]

Applied, thanks!

[1/4] RDMA/bnxt_re: Change aux driver data to en_info to hold more information
      https://git.kernel.org/rdma/rdma/c/6656fda9d744bd
[2/4] RDMA/bnxt_re: Use the aux device for L2 ULP callbacks
      https://git.kernel.org/rdma/rdma/c/5b93677f520908
[3/4] RDMA/bnxt_re: Group all operations under add_device and remove_device
      https://git.kernel.org/rdma/rdma/c/c1fcf8aff481b6
[4/4] RDMA/bnxt_re: Recover the device when FW error is detected
      https://git.kernel.org/rdma/rdma/c/5d13aa44d9aec1

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


