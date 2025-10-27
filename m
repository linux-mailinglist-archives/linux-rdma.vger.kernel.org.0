Return-Path: <linux-rdma+bounces-14061-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7F8C0CBCA
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 10:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C0A74E2B31
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 09:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE3E2F12B3;
	Mon, 27 Oct 2025 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1bKrTA2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6D32E7631
	for <linux-rdma@vger.kernel.org>; Mon, 27 Oct 2025 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558294; cv=none; b=Fk6qMtNPl0Gomp+7ue+EHf2o5sVR5XXEW/1TctnOhSMDnwxZE0bl+wCcYjw/aec/AKfaFQHHwMstZz21nYwRwDc0SLkdrje7hag7EhBklHPe9WK/kjOfQ0J1QHsP7IFJDAQeJ5p0rCRudO2ABtRzeHetHF5GACOCGvcG5keT2AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558294; c=relaxed/simple;
	bh=LF0g+6NfyhMaXwWr+Ygslug3itW6gSzOrBW/lNJX1vc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iQf2leiC9dM46eDgY3rhZbyC+sVGZXI/ccpVN5w+jIf9IL+/G+b6uqdeZtlYTB5/l9b0GEuOwGo9Kbshy3ON6vQgWlFcTszCLiDQV57rYY05Lu1VW8b4ekapeAcsFGIigeeju5fDQQDSODyvDKEK+dUD6S38vb2RAEu1YBTuawg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1bKrTA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764D6C4CEF1;
	Mon, 27 Oct 2025 09:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761558293;
	bh=LF0g+6NfyhMaXwWr+Ygslug3itW6gSzOrBW/lNJX1vc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=H1bKrTA29AutUAgP2qqKrzE2nzrIEfVxPM5l+AY2Ovkp3PzBVM3BzlktRPDKsUXo8
	 5BUDVwxpoYuaWFGIJPXpYKQxYo2rr9ZWb4tv9uq9oDZgwcK1ysX9V+e2nwsAJVspG3
	 2NvzOvfAsVLPx64TNMcRo9y0f3eaUlZkOzsBZeJNNhL555hLsxQk0IWQAsdQVNmd1M
	 vnwRqJd9jFomopZSz5xaoaiXSH7AbPJ5uTjz4KziRaFSNBUFDymOFU1uxOhhIZC4CK
	 eNj2FUVTdyssnasFj/piftIWMc5mUBqj4xMe1r8qn3w+fkK5tMIGE+WvdiKqkJ0kKj
	 U3rnie2mMAHBA==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 tangchengchang@huawei.com
In-Reply-To: <20251016114051.1963197-1-huangjunxian6@hisilicon.com>
References: <20251016114051.1963197-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-rc 0/4] RDMA/hns: Bugfixes and cleanup
Message-Id: <176155829077.449365.2084158174292030158.b4-ty@kernel.org>
Date: Mon, 27 Oct 2025 05:44:50 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Thu, 16 Oct 2025 19:40:47 +0800, Junxian Huang wrote:
> This patchset contains three fixes and one blank line cleanup.
> 
> Chengchang Tang (1):
>   RDMA/hns: Fix recv CQ and QP cache affinity
> 
> Guofeng Yue (1):
>   RDMA/hns: Remove an extra blank line
> 
> [...]

Applied, thanks!

[1/4] RDMA/hns: Fix recv CQ and QP cache affinity
      https://git.kernel.org/rdma/rdma/c/c4b67b514af8c2
[2/4] RDMA/hns: Fix the modification of max_send_sge
      https://git.kernel.org/rdma/rdma/c/f5a7cbea541166
[3/4] RDMA/hns: Fix wrong WQE data when QP wraps around
      https://git.kernel.org/rdma/rdma/c/fe9622011f955e
[4/4] RDMA/hns: Remove an extra blank line
      https://git.kernel.org/rdma/rdma/c/b8c9aab4c738e5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


