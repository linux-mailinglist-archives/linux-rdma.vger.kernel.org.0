Return-Path: <linux-rdma+bounces-9232-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0C8A7FF90
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 13:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0803BD3E9
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 11:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766DB268C70;
	Tue,  8 Apr 2025 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDoAGh2x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EF32135CD
	for <linux-rdma@vger.kernel.org>; Tue,  8 Apr 2025 11:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110723; cv=none; b=TVR6UsPac4KSx7ufIqQiToAolBDKsF0cqQC2TeO+Nd0XorRAZJpSTXs2nlF3KyCuTi89R57/WybdyoXPC2egq/x/4wKOfh8u3DtIYy2sKG9GUhAlDJq4RF+ENQXXShMFq14+qUyS+euZW/VwfHmNmJE3C9kR8f82f1kxaYjTVac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110723; c=relaxed/simple;
	bh=F4DiSuRBHSeHi0aP8QeNfnBKlV+bJ5/ZP/GLTA8rnqw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pfRTNUUtBwu3I5SoY/kkztBGwyxQ4Ce9CLmm/IMqYZHd+UwDQJfWQ9ebuPFjK1VFMmCyxFP30Ij8d2HV3Zd+3942KCccaNKlSVXpJziNJtjLNszIVYnVOGyp7kve5ME8oxjFAyjUVV+JnUeJCSv7h1qHOT1ZKF22gpfwNnxE41I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDoAGh2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5E5C4CEEA;
	Tue,  8 Apr 2025 11:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744110722;
	bh=F4DiSuRBHSeHi0aP8QeNfnBKlV+bJ5/ZP/GLTA8rnqw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cDoAGh2xJzM7ur1D008EBrbwt/WYaDZJ/Vicxnf1ii/I5zvKVovU3fusikQHB1/98
	 uZ8aKPPtZcttQoiHTEA1kZcqMe17sKmSYwV9eohpFHS6G4XBo8mnRTyS8S3fKLR16F
	 sQruzge35aWvpkkuoM7Uwm19B4TEzh0jeQF24nrg9i+cXr4A8Nij+/9W6xHhsXL3a2
	 664bRiAIU9eudIobili7MPq5gbCtb4LO1HkkAoXi9H0hz9Pgp77szrfXR5JELyK7QV
	 pAsa5kIhTDz/KX1OLZiTxGkG31NImcPU0/LVAFQjiNaLjFLWXDr/k8FiI0bNCRfEMX
	 c487oA0qzwN8g==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com, 
 Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc: lizhijian@fujitsu.com
In-Reply-To: <20250324075649.3313968-1-matsuda-daisuke@fujitsu.com>
References: <20250324075649.3313968-1-matsuda-daisuke@fujitsu.com>
Subject: Re: [PATCH for-next v3 0/2] RDMA/rxe: RDMA FLUSH and ATOMIC WRITE
 with ODP
Message-Id: <174411071857.217309.12836295631004196048.b4-ty@kernel.org>
Date: Tue, 08 Apr 2025 07:11:58 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 24 Mar 2025 16:56:47 +0900, Daisuke Matsuda wrote:
> RDMA FLUSH[1] and ATOMIC WRITE[2] were added to rxe, but they cannot run
> in the ODP mode as of now. This series is for the kernel-side enablement.
> 
> There are also minor changes in libibverbs and pyverbs. The rdma-core tests
> are also added so that people can test the features.
> PR: https://github.com/linux-rdma/rdma-core/pull/1580
> 
> [...]

Applied, thanks!

[1/2] RDMA/rxe: Enable ODP in RDMA FLUSH operation
      https://git.kernel.org/rdma/rdma/c/32cad6aab9a699
[2/2] RDMA/rxe: Enable ODP in ATOMIC WRITE operation
      https://git.kernel.org/rdma/rdma/c/3e2746e0863f48

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


