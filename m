Return-Path: <linux-rdma+bounces-465-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1C6819A2B
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Dec 2023 09:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7302827A8
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Dec 2023 08:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BA518637;
	Wed, 20 Dec 2023 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTcSNIGb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87C51DA33
	for <linux-rdma@vger.kernel.org>; Wed, 20 Dec 2023 08:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDAAC433C7;
	Wed, 20 Dec 2023 08:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703059892;
	bh=Up7pwjn6bHMIOFqBjJea0v8a7jTYish1uFJc/RMLABw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tTcSNIGb+LCrWmsCT9pNuh+XdThA+JrBSt3uTzhSKj6/4ZEx0i+1hIx0BEVXsy9py
	 vYO+gRkYi+6Ty64KgGepBnEsQCCk2uxwavN1oKdOap9qefsEpFEVp2cj/+1XsgM4u5
	 btILYU8Q0yFxZaDWmOazxynMvVwLwQik37mbyhUgcYimh1ClTIE4vEz+uCn4SMnHMV
	 hgdnea+aYkmlwZsrEO9wM4d2myOf+6bZYr1FOiegytGKe5j/ATlnnTqfJFnPUtYl3J
	 X2uDbEj4/EEVM4ysD16vU77vIsYbw86bT0M9Nl42wY9pUqK14YrnjBuAQiIXH0G5+u
	 K/PFcXGqxc23Q==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
In-Reply-To: <1703046717-8914-1-git-send-email-selvin.xavier@broadcom.com>
References: <1703046717-8914-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH] RDMA/bnxt_re: Fix the sparse warnings
Message-Id: <170305988642.142815.3070324779441874079.b4-ty@kernel.org>
Date: Wed, 20 Dec 2023 10:11:26 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Tue, 19 Dec 2023 20:31:57 -0800, Selvin Xavier wrote:
> Fix the following warnings reported
> 
> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:909:27: warning: invalid assignment: |=
> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:909:27:    left side has type restricted __le16
> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:909:27:    right side has type unsigned long
> ...
> drivers/infiniband/hw/bnxt_re/qplib_fp.c:1620:44: warning: invalid assignment: |=
> drivers/infiniband/hw/bnxt_re/qplib_fp.c:1620:44:    left side has type restricted __le64
> drivers/infiniband/hw/bnxt_re/qplib_fp.c:1620:44:    right side has type unsigned long long
> 
> [...]

Applied, thanks!

[1/1] RDMA/bnxt_re: Fix the sparse warnings
      https://git.kernel.org/rdma/rdma/c/82a8903a9f9f3f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

