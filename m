Return-Path: <linux-rdma+bounces-6769-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5049FEA13
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2024 19:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1443A7A030F
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2024 18:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83D918660A;
	Mon, 30 Dec 2024 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhAT9t2O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DC9EAD0
	for <linux-rdma@vger.kernel.org>; Mon, 30 Dec 2024 18:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735584195; cv=none; b=HPGtH2612u6IKiI15/Yhy/9dpaiv5ELsjxK94qHvkb5ORBvmS6gyUztcoemnfdMpRYUxXf3kdgv4gSWllmP/yKaXlvcitVpWeYvAT+Vm70rj+6qM92RjbpfU+8xmh9Ac0nVCkuiAI0D6NihdXLdTIEHnHo0NSKUYUVJa56wTmyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735584195; c=relaxed/simple;
	bh=3aWCl9VzR4tnwXov6r8v1Sk4ZQVAy9Yfk8Iw+Gm1aY4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KktyWJhhpYS2lfkCypjKoeO2i936avDtbp29KWYdo9IMzcy/1twdYE7O1ekKD7pJnftBdDtSP4RLIcILmoJW/rEFTsZUEA0TgoJolLVd5Gxw89vfYiVCgNOCikhzsuhoMyHZA18l0TKWxqnRTspIvrISJ4EK5wa0LpbTFXujJcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhAT9t2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D26FC4CED0;
	Mon, 30 Dec 2024 18:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735584194;
	bh=3aWCl9VzR4tnwXov6r8v1Sk4ZQVAy9Yfk8Iw+Gm1aY4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uhAT9t2OIepFUrdoVE8UrfrTvIHrS61J/uIGM9zGxaqLwpMx1KJ6hC2B/ihhyxgh5
	 4uw89y+qt8rhrNSvbgtYnpdWI3Eyk1reRTZO/h3NfYjBlk5vGz+kjkPkf3bypBzQCF
	 Y5F7BqmWAK2s3NRMiEv6VpQV9lEUghg4lzaPbYkBnrMqQLLNLPqEJkqrcq2YWmXPmk
	 JPxwVBn7NSOsLNVfNY07m2VzrjuIMn/7/SJ6H3pEWz9lk3xMYGHjtJM3eCGh7fSLCs
	 U51W5jqBfExV05QFm8tqbnUOeufs/FrPUUn8BUCaJwO5f1TugE7+RMvu97gfvLQkYB
	 QVpX6q6BxvLtQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Boshi Yu <boshiyu@linux.alibaba.com>
Cc: linux-rdma@vger.kernel.org, kaishen@linux.alibaba.com, 
 chengyou@linux.alibaba.com
In-Reply-To: <20241226084141.74823-1-boshiyu@linux.alibaba.com>
References: <20241226084141.74823-1-boshiyu@linux.alibaba.com>
Subject: Re: [PATCH for-next 0/4] RDMA/erdma: Misc fixes for the erdma
 RoCEv2 protocol
Message-Id: <173558419085.96126.13167781930610090062.b4-ty@kernel.org>
Date: Mon, 30 Dec 2024 13:43:10 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 26 Dec 2024 16:41:07 +0800, Boshi Yu wrote:
> This patch series addresses several issues for the erdma RoCEv2 protocol.
> 
> - #1 adds missing fields to the erdma_device_ops_rocev2.
> - #2 fixes incorrect response returned from query_qp.
> - #3~#4 support posting create_ah and destroy_ah commands to the cmdq
>   in polling mode to eliminate the hard lockup issue.
> 
> [...]

Applied, thanks!

[1/4] RDMA/erdma: Add missing fields to the erdma_device_ops_rocev2
      https://git.kernel.org/rdma/rdma/c/67831baff0d7a7
[2/4] RDMA/erdma: Fix incorrect response returned from query_qp
      https://git.kernel.org/rdma/rdma/c/3761e0ad79c137
[3/4] RDMA/erdma: Support non-sleeping erdma_post_cmd_wait()
      https://git.kernel.org/rdma/rdma/c/26981e688ca896
[4/4] RDMA/erdma: Support create_ah/destroy_ah in non-sleepable contexts
      https://git.kernel.org/rdma/rdma/c/a6c346760a52af

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


