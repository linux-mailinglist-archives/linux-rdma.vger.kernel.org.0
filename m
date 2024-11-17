Return-Path: <linux-rdma+bounces-6017-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 716A89D02AC
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2024 10:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052211F23128
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2024 09:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763128172D;
	Sun, 17 Nov 2024 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWxSEvCf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E49DDA8
	for <linux-rdma@vger.kernel.org>; Sun, 17 Nov 2024 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731837428; cv=none; b=WnsuopATS7ln8SQY8N+RRYbp28qda1iKma+2jq2fzKGDjO6B9zCcLJPOAkyBFkIgWffO7Yip5qUC9gIa1s59yKfgAk4axfooazwF+nUsofsfRcLqvyb4ga5rwKF6trML7MkaiMCfWtUAcBofdsrL1wT6S3Vuk4VQb2hS9N1wBYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731837428; c=relaxed/simple;
	bh=2ZxkZYZJlEH1vUNLgDAZbilDjjWkK3kED5iRppBcRAI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lZJ/a0AE36t50Z7ufDrpJvIq3gJ4ZXKAHDve7WVmKPFOwsEV0XtfnP+nHGSuvRU5v7mTHBMbyS9exZN5pOIB8thEmt4go4gN4GpmrI737xs19Edk6cWOpSbLgJXjQHLh9c17XV7NRi/2EpNyen/PJcvRV1B/fSjT1olev8vRRWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWxSEvCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E87CC4CECD;
	Sun, 17 Nov 2024 09:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731837427;
	bh=2ZxkZYZJlEH1vUNLgDAZbilDjjWkK3kED5iRppBcRAI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sWxSEvCf1XNDbSV4V+LNLlRVqW+zyPhw29Wuk6tDVJW204I8R0MKO22PLlcepT6+z
	 Q9/LfkxDmFhszMCfTjtVBGTF/GU+bBEARE+VIbVNe2mANQ9vS79h8eyPLDbHiBK6X6
	 ZsvI3Cn7AFL2vD+ll9TLZ+6lv+8A2NJlVOBgdU39wtahQ5GQ7DOaIEIWfLxBpSCVjT
	 isbGbua1GYsPTGD9ZryB3h5WLlfyifJ4jIcr7/xEznqhIUUuIvDvmYDysBKD25DGF9
	 ehFTd6nVLmEmueXPjy8GNo5Ky7IrXpgLbdTxNq4hooDqeGVwLyNsj0Z9r+o3jFJENJ
	 G/SESR+PQHdQg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 kalesh-anakkur.purayil@broadcom.com
In-Reply-To: <1731660464-27838-1-git-send-email-selvin.xavier@broadcom.com>
References: <1731660464-27838-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH rdma-next 0/3] RDMA/bnxt_re: Driver update for 6.13
Message-Id: <173183742446.243342.1421640206790639766.b4-ty@kernel.org>
Date: Sun, 17 Nov 2024 04:57:04 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 15 Nov 2024 00:47:41 -0800, Selvin Xavier wrote:
> Couple of minor updates and a bug fix for bnxt_re driver.
> Please review and apply.
> 
> Thanks,
> Selvin Xavier
> 
> Chandramohan Akula (1):
>   RDMA/bnxt_re: Support different traffic class
> 
> [...]

Applied, thanks!

[1/3] RDMA/bnxt_re: Support different traffic class
      https://git.kernel.org/rdma/rdma/c/c64b16a37b6d24
[2/3] RDMA/bnxt_re: Use the default mode of congestion control
      https://git.kernel.org/rdma/rdma/c/bfb27ae6d0f9a1
[3/3] RDMA/bnxt_re: Correct the sequence of device suspend
      https://git.kernel.org/rdma/rdma/c/68b3bca2df00f0

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


