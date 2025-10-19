Return-Path: <linux-rdma+bounces-13930-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F38BEE359
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Oct 2025 12:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC87189BD5D
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Oct 2025 10:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6232620D2;
	Sun, 19 Oct 2025 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2bCWT2z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F501DE4F1;
	Sun, 19 Oct 2025 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760870910; cv=none; b=Uez2lsPJJZDrQ0M1InUSVPX+IY4U5Gx0fBXoAcDiMmpJ2dLxVDUqpCs8N/m2suXzPTN2e8g4roimqJ8dSDfTrWOdn9QRBKI0hcpXwVjK53sME5dYas8tmoGHweSt9SNiEtLUdMoGRTwx4MpvSrZgNlN7GzvwGAPaJY8wQXKgFDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760870910; c=relaxed/simple;
	bh=wWBuY/vPq4XsHmyLF6H1yi/E6js2B80wVQOVluBQEVA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qJsZaX0vBOUwsOyg59RYi2r+3nzeiem2pAMNfqmw/pA43FruAE+CEJHW3iVTGrblOYgyXjjQ94kFCRmgLKo6yX5sK8L8cS3peCHoTApRp4roK2+SlFVAhl8VUxLIdoaxQE1GNMofmcI0t806TdNH952Kt62oNnnF4KTEdFLtxwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2bCWT2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E79FC4CEE7;
	Sun, 19 Oct 2025 10:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760870909;
	bh=wWBuY/vPq4XsHmyLF6H1yi/E6js2B80wVQOVluBQEVA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=g2bCWT2zpHdyYOXUm61ik50M5S2FfNznI/S4cbrBa3mlcpinNSeiPDcOSq0m4OEI5
	 I+NLRCGGfzzxmAGUKZivuTmFi8E8PE9an+zzYfTJdUpR9BuSYwS1ULYMjFswG9sG/H
	 lnEQu1G/DbsuAB4775WFxBKhVIMJshjGtWgBfG7Lmv2GOpHYZNz9LpqobW7U48Sh3l
	 xuta0UXeARnv7Y97E1XavyvLMZcWqVT14bsnRN5vobtyAw9CKlkzzbcb6J/c16/SIQ
	 fyXVaL2RmmuExutcDlZwMGxwIBxR/twWOrF67KEF/5aWg4pVqw5lIh3s8+y9rIMWbf
	 Vp+TSVf9bO6KQ==
From: Leon Romanovsky <leon@kernel.org>
To: kalesh-anakkur.purayil@broadcom.com, 
 YanLong Dai <daiyanlong@kylinos.cn>
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 selvin.xavier@broadcom.com, dyl_wlc@163.com
In-Reply-To: <20250924061444.11288-1-daiyanlong@kylinos.cn>
References: <20250924061444.11288-1-daiyanlong@kylinos.cn>
Subject: Re: [PATCH v2 rdma-rc] RDMA/bnxt_re: Fix a potential memory leak
 in destroy_gsi_sqp
Message-Id: <176087090639.147630.2015406926663956214.b4-ty@kernel.org>
Date: Sun, 19 Oct 2025 06:48:26 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-3ae27


On Wed, 24 Sep 2025 14:14:44 +0800, YanLong Dai wrote:
> The current error handling path in bnxt_re_destroy_gsi_sqp() could lead
> to a resource leak. When bnxt_qplib_destroy_qp() fails, the function
> jumps to the 'fail' label and returns immediately, skipping the call
> to bnxt_qplib_free_qp_res().
> 
> Continue the resource teardown even if bnxt_qplib_destroy_qp() fails,
> which aligns with the driver's general error handling strategy and
> prevents the potential leak.
> 
> [...]

Applied, thanks!

[1/1] RDMA/bnxt_re: Fix a potential memory leak in destroy_gsi_sqp
      https://git.kernel.org/rdma/rdma/c/88de89f184661e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


