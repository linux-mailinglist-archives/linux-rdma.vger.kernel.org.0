Return-Path: <linux-rdma+bounces-13161-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 615EDB493B0
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 17:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0641BC0262
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 15:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6826B30C616;
	Mon,  8 Sep 2025 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtEkztQJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0877D10E0;
	Mon,  8 Sep 2025 15:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345866; cv=none; b=jsJh+BJxj63a6ijqB5j2UO0ur++HLeoamf42isH7+j7z0oQf6a9IsBxmkVRN3ZhBeZFEy5Np3VpCTZAgm7rB6bCZPV5snShsaQKkcryXTIbOcP9AfJp02ExwcHFVDdayVmd9t3SjV0CW90w9utcuyZh0dSKJAQfqd9ebjYT3NPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345866; c=relaxed/simple;
	bh=BixgHBXmN4yCcd3c+/x2OzMY9yovr69fIJhaRBffAmQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LvfTdg+SkeQzIQYCEAKsWGaidNpSRc+wGsNycPDnvoHOCGAz/7L9FkT35qtRZ8wMkM3AC6HhZqIAkNlJfXfEkHgrQ77rTGkHMKqzxVOAoAQw0rF6FzP7VMycDinOgLx7VlFIC87QLR0KpcS6o9jYkFbMlkTCbShnWVnOfvJep8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtEkztQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B3EC4CEF1;
	Mon,  8 Sep 2025 15:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757345865;
	bh=BixgHBXmN4yCcd3c+/x2OzMY9yovr69fIJhaRBffAmQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CtEkztQJ5vrO9d/3kZJ9JBz9QQf/snmwyyPy2JKvTxMAOsiPx5KfdycWJdLDURFzt
	 b6hKEhJjUDU4Y8yUqtmiIhhdGXlXtZ/w/g4Mb4Ul5TjCy3kuM+6l2K3TtU5sb3rnZL
	 xf+oGpD7fAIt46E7NXPrMrJCeZ5/Uxz5+Ctsvi3aApbS7RlmGXI7xCt7Jr1JBfLLO8
	 ptCFrwftgTmUIRyKBBSHiUTVrlx5+ZyBQAD9w2W/tUocvSQBE7PCjS6332FI5LhkRW
	 eYPkk1nJsIueTBrsTQEfaT+5ToVbJOUWlzXYmqx6OrxMVP8K+w0Vm/5+XbDuddpP0p
	 MHI0msXeaUW3g==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
 andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
 michael.chan@broadcom.com
In-Reply-To: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH rdma-next 00/10] RDMA/bnxt_re: Add receive flow
 steering support
Message-Id: <175734586236.468086.14323497345307202416.b4-ty@kernel.org>
Date: Mon, 08 Sep 2025 11:37:42 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 22 Aug 2025 09:37:51 +0530, Kalesh AP wrote:
> The RDMA stack allows for applications to create IB_QPT_RAW_PACKET
> QPs, which receive plain Ethernet packets. This patch adds ib_create_flow()
> and ib_destroy_flow() support in the bnxt_re driver. For now, only the
> sniffer rule is supported to receive all port traffic. This is to support
> tcpdump over the RDMA devices to capture the packets.
> 
> Patch#1 is Ethernet driver change to reserve more stats context to RDMA device.
> Patch#2, #3 and #4 are code refactoring changes in preparation for subsequent patches.
> Patch#5 adds support for unique GID.
> Patch#6 adds support for mirror vnic.
> Patch#7 adds support for flow create/destroy.
> Patch#8 enables the feature by initializing FW with roce_mirror support.
> Patch#9 is to improve the timeout value for the commands by using firmware provided message timeout value.
> Patch#10 is another related cleanup patch to remove unnecessary checks.
> 
> [...]

Applied, thanks!

[01/10] bnxt_en: Enhance stats context reservation logic
        https://git.kernel.org/rdma/rdma/c/47bd8cafcbf007
[02/10] RDMA/bnxt_re: Add data structures for RoCE mirror support
        https://git.kernel.org/rdma/rdma/c/a99b2425cc6091
[03/10] RDMA/bnxt_re: Refactor hw context memory allocation
        https://git.kernel.org/rdma/rdma/c/877d90abaa9eae
[04/10] RDMA/bnxt_re: Refactor stats context memory allocation
        https://git.kernel.org/rdma/rdma/c/bebe1a1bb1cff3
[05/10] RDMA/bnxt_re: Add support for unique GID
        https://git.kernel.org/rdma/rdma/c/b8f4e7f1a275ba
[06/10] RDMA/bnxt_re: Add support for mirror vnic
        https://git.kernel.org/rdma/rdma/c/c23c893e3a02a5
[07/10] RDMA/bnxt_re: Add support for flow create/destroy
        https://git.kernel.org/rdma/rdma/c/525b4368864c7e
[08/10] RDMA/bnxt_re: Initialize fw with roce_mirror support
        https://git.kernel.org/rdma/rdma/c/d1dde88622b99c
[09/10] RDMA/bnxt_re: Use firmware provided message timeout value
        https://git.kernel.org/rdma/rdma/c/d7fc2e1a321cf7
[10/10] RDMA/bnxt_re: Remove unnecessary condition checks
        https://git.kernel.org/rdma/rdma/c/dfc78ee86d8f50

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


