Return-Path: <linux-rdma+bounces-6816-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7475A0194D
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jan 2025 12:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB653A3426
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jan 2025 11:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65ED13C9D9;
	Sun,  5 Jan 2025 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2IoDUOE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641CA10FD
	for <linux-rdma@vger.kernel.org>; Sun,  5 Jan 2025 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736077929; cv=none; b=MR9APoMwTcGfeKt9n7L55gQbCEYx3uMrsvRTT3qk8s0AyLKoAEr95QLa6WIzR8FzAMjKPQrqwEpIDHpxZqfeoxzmr8X//qmJOsmbONthRgxS4N4mPjxAEJfVvMvW5Z25jE5l/fuRB0yncwaETfg7DLpEC6d4RHolX2ebJGrdz2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736077929; c=relaxed/simple;
	bh=+YIvb0YFd2ECXmbblzceQVVlR5CCDzTQwilByTPlIXE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GFoR4LCtJRH4VuaRfhnj9dq2ORkHoHLJB9r2aWUZE/ejNdSL8dIi9+EAvbVdlQi9bgyzpzg+NyD7jFpMu6uslyWqq8Zz+GxaRw1Z6j8IXlTxFOYAvuQv++KGlmUvAVORRt6f+6hGQ56oefqAhaBCmVjPrPBoDToykVOeVoWR3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2IoDUOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803FDC4CED0;
	Sun,  5 Jan 2025 11:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736077928;
	bh=+YIvb0YFd2ECXmbblzceQVVlR5CCDzTQwilByTPlIXE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W2IoDUOEV103nknit5n74TfERD6/mQ9TAfx/7d5goPwB39qTf4xK03rO+1VPTUnn7
	 KKCaDVv71/mC90KTFVcBM9Fn0iso1/LZwleOB+lvcX8K+4ZVdEb1aCo16KcPcZJuA3
	 pXDluP6vGTupzp4r6AfsPm2dcVupiWORLv1p/zhA27IhOdQJX80rpfLFy+1tdddNik
	 fOUjPmtKb0mJIEskoOkltL8b0MyXqYVBg9jy4ts4nrYA3Nh0z6e9PYQEdmgcs6sL/H
	 WR8fBkMhY1vo30ayOprO3mOI2o4VYAixqFBwCDwYyNDcRdCuTZWjbu25M0uvFOqx7E
	 q2asTIoBHSkMA==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 selvin.xavier@broadcom.com, 
 Saravanan Vajravel <saravanan.vajravel@broadcom.com>, 
 Kashyap Desai <kashyap.desai@broadcom.com>
In-Reply-To: <20250104061519.2540178-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250104061519.2540178-1-kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH for-rc] RDMA/bnxt_re: Fix to drop reference to the mmap
 entry in case of error
Message-Id: <173607792531.164422.2084734322709565074.b4-ty@kernel.org>
Date: Sun, 05 Jan 2025 06:52:05 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sat, 04 Jan 2025 11:45:19 +0530, Kalesh AP wrote:
> In the error handling path of bnxt_re_mmap(), driver should invoke
> rdma_user_mmap_entry_put() to free the reference of mmap entry in case
> the error happens after rdma_user_mmap_entry_get was called.
> 
> 

Applied, thanks!

[1/1] RDMA/bnxt_re: Fix to drop reference to the mmap entry in case of error
      https://git.kernel.org/rdma/rdma/c/c84f0f4f49d816

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


