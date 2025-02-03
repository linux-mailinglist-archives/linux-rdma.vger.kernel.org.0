Return-Path: <linux-rdma+bounces-7354-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F5AA2584F
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 12:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73873A3503
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 11:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2884B202F97;
	Mon,  3 Feb 2025 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obf4mDBe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC09E202F90
	for <linux-rdma@vger.kernel.org>; Mon,  3 Feb 2025 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738582782; cv=none; b=R5JIBQ+RGJMcH47flMcSFD3NsxEPdkNCWN33AGcxfphg31z74o7pB5NV6jiBaGWdDbem3OzXpWWnUEAz4xG0aUVVW7jMLspsDZ3eAaE6DGnFdlc9HMNh2mOQ3lItqY5V1z2ustU+gNZ1BogOank5ph9O59Unj0tkBVbWZ2ro7So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738582782; c=relaxed/simple;
	bh=S96K3KeW7V92pzq+RWykgwUN+5b4LT5IgIC7pVl2r98=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XL7hvSy/cQGEMLJprfek2XZoLkt8ISmH18n8grTDqYql776dqMWQcs0lveXO+JpA+T8gnVHAcKmxUaeye9gnjaSdt/oY9q8lotSJtxQT7SbVB5FoQi/lZoocwsBIN+701o66sF5rdCy3GCrmt/PBEMkUpIW6BMBCkv2H0G4WsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obf4mDBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314A5C4CED2;
	Mon,  3 Feb 2025 11:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738582782;
	bh=S96K3KeW7V92pzq+RWykgwUN+5b4LT5IgIC7pVl2r98=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=obf4mDBeQJ4crb2Y7QKHLU+8SyH+JnA9zej0ENxlQT2NQXh0Dxmh1em4zS65ttrML
	 oJOc4iX3ISGPyxtkLyJ4WU1jy0n/CCGkTpPhP5mgwhbqAiSAmZMn0ot8gDQbSGytTz
	 UzPcNwWCgpwx/CLwebomKU9Th4t02eDkNdXSQpF7se0PYH4YfIA8npAiytUOac0lX3
	 ydYmQSNHK2KsmXA/Pw3apVTAlP4KG0qJ1o/nx6pMAz4j2h7ZFYiExeVZcejvUNWX/v
	 PExEbgNfUW/wrQcIBcoFoWAzEtuk28YWfWlM+hy9ajnSLYoumIVKpDnGLVpmGm2lnz
	 KIuiybl2xyuVw==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org, 
 Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250119172831.3123110-1-yanjun.zhu@linux.dev>
References: <20250119172831.3123110-1-yanjun.zhu@linux.dev>
Subject: Re: [PATCH 0/3] Add the support of tun to RXE
Message-Id: <173858277937.652712.6944685647375531381.b4-ty@kernel.org>
Date: Mon, 03 Feb 2025 06:39:39 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sun, 19 Jan 2025 18:28:28 +0100, Zhu Yanjun wrote:
> Currently the tun device can work well with SIW while it can not work well
> with SoftROCE.
> 
> The RXE device can be attached to the tun device with the command "rdma
> link add ...". But when running rping command over this RXE device, some
> error will occur.
> 
> [...]

Applied, thanks!

[1/3] RDMA/rxe: Replace netdev dev addr with raw_gid
      https://git.kernel.org/rdma/rdma/c/d34d0bdb500e6f
[2/3] RDMA/rxe: Add query_gid support
      https://git.kernel.org/rdma/rdma/c/93486fc96f0e26
[3/3] RDMA/rxe: Make rping work with tun device
      https://git.kernel.org/rdma/rdma/c/190797d47f16d2

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


