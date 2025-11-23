Return-Path: <linux-rdma+bounces-14702-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3D1C7DE86
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 10:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EFA4534D45C
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 09:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0509B2848A8;
	Sun, 23 Nov 2025 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSslETor"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87A9224B14
	for <linux-rdma@vger.kernel.org>; Sun, 23 Nov 2025 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763888695; cv=none; b=qhMpfa7H0hJpvAeJSwJL+s15OKrvhMn1pkcS8VDNVDc3IGYggq9qRtLZueMxAUjotpYBkAadwsddYPbsoVojc0Cywj6cssdUaRaTzn/GjgqVA7nYF+FYnQWCYiPA2DxHgM9scX31UkxPUtfRXSn9aEngBYlg2GXvdi5rQUv4ZwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763888695; c=relaxed/simple;
	bh=AI8vLesthCpgxvakRMSJjkrIL+XlwDCgpakzWPitqTk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QUMENQQHEvLY/9Ls97OMob0Wzk3h1/dXVsPG7JPvZAAE/2W+uONXAh3JilpTjCfA/4a0hgzNHtZduyswgkAcNotBsCfxKsDpddnBG4TKqZzF8Tu7wqxoW+GWKDMoIRxUqGC2IT/bBJ/5kQ5/bpwt4ZXyJl4drFhyB5F4SfekeKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSslETor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8B6C113D0;
	Sun, 23 Nov 2025 09:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763888695;
	bh=AI8vLesthCpgxvakRMSJjkrIL+XlwDCgpakzWPitqTk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oSslETorROaVyWC6n+j1v9pVOcbvSszGOdAKqBlh2IUeJPEw80mB8gajS1qp6U/FE
	 KpOiq3tJ9Rnza8WOvU4ulwaj5GWahriaWISHbnb8mNd8LU0kjz07PcAEN8yFnmw0Zm
	 OYnFQTS13dWtgIfNRix8ZCDHc4t1crv5ZcC4bnfOItjbjeGVHYSMVE2/BrCr9Y2KG6
	 86uqI1ammiCuPjE8kXsViWlqwg8vnbN7kqmcBjZzwxkd4+er6bC/96QeLNuPrnOtew
	 VJeMLKUHRuXXmY5Y30KVZ+g2rglasgH3fm3GWb3KXyIJLhKUl6LYAnrWLX/fWkJYse
	 u1hZCnJc4CS6A==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
In-Reply-To: <1763624215-10382-1-git-send-email-selvin.xavier@broadcom.com>
References: <1763624215-10382-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH rdma-rc 1/2] RDMA/bnxt_re: Fix the inline size for
 GenP7 devices
Message-Id: <176388869214.1783202.1704915356803875358.b4-ty@kernel.org>
Date: Sun, 23 Nov 2025 04:04:52 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Wed, 19 Nov 2025 23:36:54 -0800, Selvin Xavier wrote:
> Inline size supported by the device is based on the number
> of SGEs supported by the adapter. Change the inline
> size calculation based on that.
> 
> 

Applied, thanks!

[1/2] RDMA/bnxt_re: Fix the inline size for GenP7 devices
      https://git.kernel.org/rdma/rdma/c/431d0339402d01
[2/2] RDMA/bnxt_re: Pass correct flag for dma mr creation
      https://git.kernel.org/rdma/rdma/c/9384e9a6e726cf

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


