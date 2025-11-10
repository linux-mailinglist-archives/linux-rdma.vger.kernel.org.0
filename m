Return-Path: <linux-rdma+bounces-14352-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BC3C4551C
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 09:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF121881EED
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 08:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A4E2EBBAA;
	Mon, 10 Nov 2025 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4OLONsy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B0D22FE11;
	Mon, 10 Nov 2025 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762228; cv=none; b=uaF+xfwqXzD7dvYzDN2e7qsfCkM4YkDEVbT8TQPbiM6cUa1TGDuYqpIH5/t/Dxn4mmGtgWOEne4F86ndr9TI3oIHryEyIEv/oWc2G7lB4yjvDIUxHP8hupLOqdenbAPIXblJCobVTRjLw4w5qkyfX0qaYkKZDq7k1VD7eEYjFcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762228; c=relaxed/simple;
	bh=Ag1s7X620Y9+P0m1jSsHDN52z63oe1kW3oQHlhxhJGU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Excwjvt5sUgJmwIHh2c3z4kQHfvsgqvi48NYFSPb+6K854inDbrA3iu0ydFTISI6KeswCeAklIQrJlM4SkVjlkqpCOKB3PKxYqJHoljZ+RJKxEmqPoZn752gVkN463koHH7/zjIFxz/632eojSy9u5xbigNDIdjirpPuTyelOGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4OLONsy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3471AC19421;
	Mon, 10 Nov 2025 08:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762762227;
	bh=Ag1s7X620Y9+P0m1jSsHDN52z63oe1kW3oQHlhxhJGU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=L4OLONsyqIa3nK9PtfbxTggqB47FfdKrpwN+9mNT1EUEyZrUAazJsqOBj3gg6qEQl
	 ll5s1p4RFzaHUuZBDXjzOBdKhwfAUvnM3P2B2cYX2sSRhxk05VtnxJrAS85GXk4zFf
	 bxJ7biFlM1i1v3QWqDLBLFMP+u0Zf41whxiVLWdqRuLV6pT+o+lW6YPc8lDVd1ikYe
	 WvyKjJJc9kcocCedl1NcmncH4VHN1UANzNruijxsUeFDgl34RtpcrTcHgT/93FfYl0
	 qVGp/CtyxTptfgcH2pNFWHQLh+6+tcjPzAw9PSNQ32h41uhH5IShcyEk5B1oa6jI2b
	 1rTxYpqkIwKtg==
From: Leon Romanovsky <leon@kernel.org>
To: haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca, 
 danil.kipnis@cloud.ionos.com, Ma Ke <make24@iscas.ac.cn>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 akpm@linux-foundation.org
In-Reply-To: <20251110005158.13394-1-make24@iscas.ac.cn>
References: <20251110005158.13394-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v2] RDMA/rtrs: server: Fix error handling in
 get_or_create_srv
Message-Id: <176276222435.591117.6507088531657710731.b4-ty@kernel.org>
Date: Mon, 10 Nov 2025 03:10:24 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-3ae27


On Mon, 10 Nov 2025 08:51:58 +0800, Ma Ke wrote:
> After device_initialize() is called, use put_device() to release the
> device according to kernel device management rules. While direct
> kfree() might work in some cases, using put_device() ensures proper
> device lifecycle management.
> 
> Found by code review.
> 
> [...]

Applied, thanks!

[1/1] RDMA/rtrs: server: Fix error handling in get_or_create_srv
      https://git.kernel.org/rdma/rdma/c/a338d6e849ab31

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


