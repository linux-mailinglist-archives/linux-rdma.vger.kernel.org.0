Return-Path: <linux-rdma+bounces-7008-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D3FA10585
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 12:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C124E167153
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 11:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE42234CFC;
	Tue, 14 Jan 2025 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8cBzuCv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE627234CF5
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jan 2025 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736854373; cv=none; b=MbDKhniPM9ByWssz1RZiTjtSe7A3g9jU7y648MzfnWJy3UP7Htqg0MxA0Zbw9zQGkqulCXB1VcGRLVjJ1Xndnz7fEmWpBn1Sg6mddDNAe4DUpsvnSbmUUVbE7hbBqKDd6ZoBnLOLNtJTPRBxfge/yUK1YmpixnultWGuJzgd8/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736854373; c=relaxed/simple;
	bh=fUbzdf1+F4Y76HPN9ow9COrYHvGe80nVMo61M9yEvNI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YJxYQ/KF9IO207OaqloHGrDq9D917tURnzZv/H3WqL3ialUq1lxKv0K6i7All03IwzmMwQS/LC8c+IsgT9lwjN5EqJaOI2FWK32WlZ7lw3lnj4YwlVcfNn7VxFGNZXSPsl6FmJOOxxWtY48HzptyzuUW9DpkJRSAqQ9/VfrMskA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8cBzuCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEF7C4CEE5;
	Tue, 14 Jan 2025 11:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736854372;
	bh=fUbzdf1+F4Y76HPN9ow9COrYHvGe80nVMo61M9yEvNI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=S8cBzuCvjUleSpxrpJIVUNqSZKajIZv3YPcTWE/4RZQUZ2w9dEvFgJIDra/LX/tko
	 BjyAufxt87uz1eBwyPISBZIV9o9M1b1U1m6+pUR8DqPVm2hhOZLsz+/3iOP51Y7TSN
	 jVOkY01URDFRxZigpK/mKp28RrcOHjQxQVZjmYbTkzZbgxBzVfmaFEXbc7X5ZoeJMr
	 Rnf6DNKCKifOONGpIYArdWKudqM5ypIF4Olr6IaUuHbgMzGGVwuRmGngCBEz/tssVp
	 Iv72XogN0tbqWtu7avjJ1PKuJHTGAI4ihm+SbL3C5FFQN7a+Uo8csmMPZxRlIEKNDm
	 XHwzT8+StePCg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Anumula Murali Mohan Reddy <anumula@chelsio.com>
Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com
In-Reply-To: <20250107095053.81007-1-anumula@chelsio.com>
References: <20250107095053.81007-1-anumula@chelsio.com>
Subject: Re: [PATCH for-rc v2] RDMA/cxgb4: notify rdma stack for
 IB_EVENT_QP_LAST_WQE_REACHED event
Message-Id: <173685436861.1202230.9578949419995793384.b4-ty@kernel.org>
Date: Tue, 14 Jan 2025 06:32:48 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 07 Jan 2025 15:20:53 +0530, Anumula Murali Mohan Reddy wrote:
> This patch sends IB_EVENT_QP_LAST_WQE_REACHED event on a QP that is in
> error state and associated with an SRQ. This behaviour is incorporated
> in flush_qp() which is called when QP transitions to error state.
> Supports SRQ drain functionality added by commit 844bc12e6da3 ("IB/core:
> add support for draining Shared receive queues")
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/cxgb4: notify rdma stack for IB_EVENT_QP_LAST_WQE_REACHED event
      https://git.kernel.org/rdma/rdma/c/42e6ddda4c17fa

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


