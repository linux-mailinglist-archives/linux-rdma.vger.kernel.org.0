Return-Path: <linux-rdma+bounces-6544-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A579F3199
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 14:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D7616880C
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 13:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130A1205E2F;
	Mon, 16 Dec 2024 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kbw4RJkn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1584204F9D
	for <linux-rdma@vger.kernel.org>; Mon, 16 Dec 2024 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734356047; cv=none; b=NiaufLwBfJhHAv4GAky7hjJBLfLE24k5U6dZgneXkVUmA2zyjERW/kAf8CCOLLuIeHIuInFGwTFwEs3BJOleD1dctn8TRE5PjoKGTjU5MyaJrGzGmP9xWrMbMdds+7g+hpN3olUgqeXkRWSP5rwhd37j0aLA1U6yKP7Q1E//Akc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734356047; c=relaxed/simple;
	bh=aHFspQXAL041jP6EsID14HyF2GfkTGTND+hd2Q3EKLs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lFiI4lNWfK3Vugcxl26/xYqbIZQWPq8ivWa1ZejOHQJhC8gHtl7c2Na32nMNFfk3Wj/Ovo5P+Y1QnkfFQKhRS9plVo3kjI/0VR1RH1UlhL9mtGj9jQWi14XIY07pdwbcyEbubIGT7dgDpwbYKV7SvSmebVErp3ugvCuOkzOAu6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kbw4RJkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1A2C4CED3;
	Mon, 16 Dec 2024 13:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734356047;
	bh=aHFspQXAL041jP6EsID14HyF2GfkTGTND+hd2Q3EKLs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Kbw4RJknji5EB61avgZPqnEQl7ApY7kEzCRSRx/ZogkCOFBbgOFlivymzIRDXqn5d
	 /w81ej6DM7mHa6Jp75qX9j9skojmEBhBacE78SXeYSbFT+ZuCp2XRNKcpQgcrrKwSQ
	 4fxj/Ws7+OE4Q02W+2ze6n4E/oyIHmgapyutUpIjiVizWPUI/eI+97v5WrrWeS85SS
	 h2dwPNapYLWBdhCPPWkHSThl5OfaBu+T7F773SaxuvHCE4WYNEpvK8t2zZuJ6hieze
	 uriFi/X0BOU48PB3ix65SchtNWZMSnObMAWNDfBRg9mJr/pX7M3trcIf0G1kbeBqR3
	 SnMmMfIpsZ5LQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 selvin.xavier@broadcom.com
In-Reply-To: <20241211083931.968831-1-kalesh-anakkur.purayil@broadcom.com>
References: <20241211083931.968831-1-kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH for-rc 0/5] bnxt_re Bug fixes
Message-Id: <173435604428.184777.10942641262119798141.b4-ty@kernel.org>
Date: Mon, 16 Dec 2024 08:34:04 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 11 Dec 2024 14:09:26 +0530, Kalesh AP wrote:
> This series contains some bug fixes for bnxt_re.
> Please review and apply.
> 
> Regards,
> Kalesh
> 
> Damodharam Ammepalli (1):
>   RDMA/bnxt_re: Fix setting mandatory attributes for modify_qp
> 
> [...]

Applied, thanks!

[1/5] RDMA/bnxt_re: Fix the check for 9060 condition
      https://git.kernel.org/rdma/rdma/c/38651476e46e08
[2/5] RDMA/bnxt_re: Add check for path mtu in modify_qp
      https://git.kernel.org/rdma/rdma/c/798653a0ee30d3
[3/5] RDMA/bnxt_re: Fix setting mandatory attributes for modify_qp
      https://git.kernel.org/rdma/rdma/c/da2132e683954e
[4/5] RDMA/bnxt_re: Fix to export port num to ib_query_qp
      https://git.kernel.org/rdma/rdma/c/34db8ec931b84d
[5/5] RDMA/bnxt_re: Fix reporting hw_ver in query_device
      https://git.kernel.org/rdma/rdma/c/7179fe0074a3c9

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


