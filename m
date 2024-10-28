Return-Path: <linux-rdma+bounces-5586-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E509B39D7
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 20:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B836283629
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 18:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF771DE2DF;
	Mon, 28 Oct 2024 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFS8iUJy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1541D7994
	for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2024 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141995; cv=none; b=aOoGyWArrIhYesZ61efP/76/3vQE+MZXy5o2gEcMUM8rjygdMUrBogChyb2bwhkiUR0XCHp3bLyAwqcfoeaHQv8uRNkDCTFRSubBBA2hVYostOZaClxkd3ah6IVEtgPAN4OkFINxO7SsbNYLAcr15EQNNYYUherane2/6Z0SXgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141995; c=relaxed/simple;
	bh=WzpmYDmq1UALSeKOayuQHa0om2DR0X4g2OYEkVnoXBk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E3cCuyb//jTkk/ZLpKRBmDMIKDUDefrB392sBh9+G06KUdjpGlPpSBYroWV1AH8EI02vXUsNAhPhj5Qa18awgJJONlcRW9YM1WWQLRUQgRXRIULosm5D3Dd12RsVG+zeBB2YJp+SHy++tPKJ2+UJw3ijpxfH8QFOFwSl60J0HiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFS8iUJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3186BC4CEC3;
	Mon, 28 Oct 2024 18:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730141994;
	bh=WzpmYDmq1UALSeKOayuQHa0om2DR0X4g2OYEkVnoXBk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nFS8iUJyBUWw+9IPGlpZkEI65sIRStGvAvbmGEAryPz9QIk4baGqCd0EebVQ9K4Xb
	 U9QSZW0dTSdHSWZcE4H8my1f/kLZhM04TieKpHrU0uuy3bm+I42MYnXtDXM7sOC8IO
	 UCbagkgOnvhnVIHYPM3IQ3TqdTv8tBfFw4rPiTpijuzxBzvg7eNuyOiKGPtBrdZgrh
	 pC35eubrFLy452jBa21skgKKoRUZDiJM1MyOpY1rFEjQ31nwOqGKZmv8LRu4865nwf
	 rJiRyEsGAgYTTfevTL2l0IYSQhNbmEQmpqP2T6Kxlgf+iclk6PlN4jNrRj3bCKG/pX
	 /pif6jn2sGRQQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 kalesh-anakkur.purayil@broadcom.com
In-Reply-To: <1729065346-1364-1-git-send-email-selvin.xavier@broadcom.com>
References: <1729065346-1364-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next v3 0/4] RDMA/bnxt_re: driver update
Message-Id: <173014198973.1928882.18201707494641626018.b4-ty@kernel.org>
Date: Mon, 28 Oct 2024 20:59:49 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 16 Oct 2024 00:55:41 -0700, Selvin Xavier wrote:
> Includes some generic driver updates.
> Please review and apply.
> 
> Thanks,
> Selvin Xavier
> 
> v2 -> v3:
> 	- A bug fix in patch 4
> 
> [...]

Applied, thanks!

[1/4] RDMA/bnxt_re: Add support for optimized modify QP
      https://git.kernel.org/rdma/rdma/c/82c32d219272fc
[2/4] RDMA/bnxt_re: Add support for CQ rx coalescing
      https://git.kernel.org/rdma/rdma/c/9c4927caccf372
[3/4] RDMA/bnxt_re: Add support for modify_device hook
      https://git.kernel.org/rdma/rdma/c/9a420bb2b4ff15
[4/4] RDMA/bnxt_re: Fix access flags for MR and QP modify
      https://git.kernel.org/rdma/rdma/c/52f70dea4201f1

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


