Return-Path: <linux-rdma+bounces-13933-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA3DBEE374
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Oct 2025 13:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AFBAC349E3B
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Oct 2025 11:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4B529E0F7;
	Sun, 19 Oct 2025 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTywhJv2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3121E51FA
	for <linux-rdma@vger.kernel.org>; Sun, 19 Oct 2025 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760871739; cv=none; b=BYxFKqkEL5P3s1JKTVyXx9WcscU9R3PZ/xFjVoQK4fKm79sXe++vPjSFwZ0kURL8t18A3BJkpYXme8Zdcum7lK8/hvKmn8bpBDc/C4SLg8eHCfQDa/DW9HWGaIB7754kbdPvslo+PQ6LEmyb0ExkdF7PITNnQd4dun6RTGh1XPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760871739; c=relaxed/simple;
	bh=JCUfKx7QRZjTakdjfqqL3FjhQ0X7DMhYbBG83XHhS+Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=vDHVGikprjplOOA6jq2KLQyCHjeJAAPqqZBH4OAsuiTZjsV2LYTXILtAysyM2ZoATirNpbf5fE00xHgYDo8bERx6SNH4Ln2lN/OBE9xwAq+MJQ2p5BSUk7SjdYBC1sn2c4Qhi8Qc9M8Bj5vLkXwTJ3qRb6e8Ny3qA72x1v7xswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTywhJv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971F6C4CEE7;
	Sun, 19 Oct 2025 11:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760871739;
	bh=JCUfKx7QRZjTakdjfqqL3FjhQ0X7DMhYbBG83XHhS+Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rTywhJv2zqAi4FkeR6vFb4kePxN33BCE4q/rHvBkyAnrdYFOBRxh1m8j+zKMD6z00
	 LF2HNHUsWGy7zX47XJhGPwK3CfBfPDXRKyeMXBLpUXpZr8mn80hGFlAe+W8kCXqJmP
	 e1ZG+eZWFpV7YULDVQS/5fUxDRtMgBFeMeNAQz03VAbMIrhQYTpOx+m9IgG9C2PRgu
	 IxUce3hujGA3eZY+FwC2vV/xZIzEyw4Uf8ie1hy3J4dseaRx9PFsFqTJWCc4ArUG8g
	 JMG7cIynFmyVmrAaft4cJvvcJ9PAN9JiSohR6yqGUzTk2HyteV2CMbzc3deLYyKiPw
	 u9aat/dayZiGA==
From: Leon Romanovsky <leon@kernel.org>
To: tatyana.e.nikolova@intel.com, Jacob Moroni <jmoroni@google.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
In-Reply-To: <20250923142439.943930-1-jmoroni@google.com>
References: <20250923142439.943930-1-jmoroni@google.com>
Subject: Re: [PATCH rdma-next] RDMA/irdma: Set irdma_cq cq_num field during
 CQ create
Message-Id: <176087173603.149060.15947701378166814156.b4-ty@kernel.org>
Date: Sun, 19 Oct 2025 07:02:16 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Tue, 23 Sep 2025 14:24:39 +0000, Jacob Moroni wrote:
> The driver maintains a CQ table that is used to ensure that a CQ is
> still valid when processing CQ related AEs. When a CQ is destroyed,
> the table entry is cleared, using irdma_cq.cq_num as the index. This
> field was never being set, so it was just always clearing out entry
> 0.
> 
> Additionally, the cq_num field size was increased to accommodate HW
> supporting more than 64K CQs.
> 
> [...]

Applied, thanks!

[1/1] RDMA/irdma: Set irdma_cq cq_num field during CQ create
      https://git.kernel.org/rdma/rdma/c/5575b7646b94c0

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


