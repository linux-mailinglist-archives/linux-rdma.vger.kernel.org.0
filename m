Return-Path: <linux-rdma+bounces-9310-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBDBA82D09
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 19:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96521B66BD6
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 17:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2673F277003;
	Wed,  9 Apr 2025 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7G8/6fR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A48270ED1;
	Wed,  9 Apr 2025 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744217975; cv=none; b=MKaeWc2jKrTL3gMdnIgJn+PQSng9YAXiitErDK8ydGNAA1NQB7mhUzvpaVC0zp4c75T8m1bRhOQJW3Md250P+dmWmFBawXkFNBBituv1jO0d60V45u39Z1LjS76dXdBTPdUnMQ7+jrXkYmz496XsDXwtalYkwLBoJ/W2jjDFZdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744217975; c=relaxed/simple;
	bh=9QXExmAjFUtXSiQTPtE5Ni91+YdXOohUOM2bbIVyKDc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iLMN98goQBppRAiQQJ/plPtsuhut2tuX23Q237obYdPz8r/4LRtpA0rz3Pgh8p13GXS+dWSX1eO7lfB3rqzF7m5lPLZDTrgCEiG5f411QLIZkeCggtm0HR6qWLtISptOCHxXvoMKogDfW/usgmX5Md3ZjTCLegysq/1fivBreSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7G8/6fR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61EFC4CEE2;
	Wed,  9 Apr 2025 16:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744217975;
	bh=9QXExmAjFUtXSiQTPtE5Ni91+YdXOohUOM2bbIVyKDc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=L7G8/6fRTWuUjPhMKf93Ls1/fdUetWQEDQG1LD/apVvkM0F0HyXBpGlhikN3ojpkx
	 NHOJYkxCU1zL+vSWSJApXARgT1DYukIVlXdlkUdHLMN93a+gSBEyZOUrLGS9z8X3Zw
	 GaW1g3QdGrKLq7b329cvMBbiDfAPwJOSHQaQR2zBvUcaGtmCwfl5TfrBVf4EzThVG+
	 PiILqrue4TmxuDUqu2+CME/a9Q1vjpjxEwidhe46IksCgviS0U5De9Z5Swd8M4BN1M
	 GQOgQKhki/Bos9vUnUz2wUaEpbnMwHps+iWQvm/PWoRJtRHX+AR4SbSzX4RHD7BpNM
	 sAdU4c0E79IXQ==
From: Leon Romanovsky <leon@kernel.org>
To: Mustafa Ismail <mustafa.ismail@intel.com>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Christian Benvenuti <benve@cisco.com>, 
 Nelson Escobar <neescoba@cisco.com>, Bernard Metzler <bmt@zurich.ibm.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250407-restricted-pointers-infiniband-v1-1-22b20504b84d@linutronix.de>
References: <20250407-restricted-pointers-infiniband-v1-1-22b20504b84d@linutronix.de>
Subject: Re: [PATCH] RDMA: Don't use %pK through printk
Message-Id: <174421797237.375783.9150188033078370474.b4-ty@kernel.org>
Date: Wed, 09 Apr 2025 12:59:32 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-37811


On Mon, 07 Apr 2025 10:25:09 +0200, Thomas Weißschuh wrote:
> In the past %pK was preferable to %p as it would not leak raw pointer
> values into the kernel log.
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> the regular %p has been improved to avoid this issue.
> Furthermore, restricted pointers ("%pK") were never meant to be used
> through printk(). They can still unintentionally leak raw pointers or
> acquire sleeping looks in atomic contexts.
> 
> [...]

Applied, thanks!

[1/1] RDMA: Don't use %pK through printk
      https://git.kernel.org/rdma/rdma/c/9452c85b58d315

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


