Return-Path: <linux-rdma+bounces-15431-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3690AD0EFED
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jan 2026 14:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDCC930010EC
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jan 2026 13:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DBA33C18C;
	Sun, 11 Jan 2026 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFznhNIy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7AA500947
	for <linux-rdma@vger.kernel.org>; Sun, 11 Jan 2026 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768139099; cv=none; b=BpNQU24JbB/BTaNHH581T4c1kqz0wau0mGmr1IoB8klz7PnOpxrVrfl4b0yj2TnJgDDDtXXSGOtvO/ORnCKDsdZPo0RUDqije2Hcsqa7iPJNJNImXvyAQHwpdGwl7FhCkikixO4qntBX/+e6DvfpVz2HzxJVWrMuwR04lUbtksU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768139099; c=relaxed/simple;
	bh=N9zo/hXVz74yBtiHWwhvqlehSrJGb81KbUAxmqk2y5M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KdQvZakQ9I+j4hT/XLVCznrC5Z1dnqE38KQMq7ICQdnDdxB6nQR190nWEe1sfZUELBI7Vap92Ip6ebaa4fvWJL4IVfyKk/LbvV5U8zuB0SgdLCrpr5buzmIuYaNTxPOcc14P0yiNqab+wB11M42KaO5mtz1L/yD5F/ukVtFOw90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFznhNIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5F2C4CEF7;
	Sun, 11 Jan 2026 13:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768139099;
	bh=N9zo/hXVz74yBtiHWwhvqlehSrJGb81KbUAxmqk2y5M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MFznhNIyESknLyCOKxBjN94DH8jW0GUKDeZge12Be6P8iws0JHi+i99iIheJ3px6A
	 UVqZngljvp1UxXOScBWrSmvCLRe8GsdKqwd1GEh+9Vd9iNpTpzdXa5nSzPANbmALTk
	 DU7Ao1kxZVloHRO6LhaR2zTTLAl/Qo0eKYrjjVt+fNeLtzjeUfDL39JNzhQtMs9NYM
	 XYNikc+CTMyNfX9a7gji8q6VPPFuvJ5JgUUUBRr4DURgSuunmH0JL9krOamIRWOeR3
	 F0y4ogKvg27ApRzUMNZ8fC/DiZQRELpoJE4aNQ+YVNHK1holXGfiLN51WqqGRx/N2A
	 eKPdTk8P9H7kg==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Md Haris Iqbal <haris.iqbal@ionos.com>
Cc: bvanassche@acm.org, jgg@ziepe.ca, jinpu.wang@ionos.com, 
 grzegorz.prajsner@ionos.com
In-Reply-To: <20260107161517.56357-1-haris.iqbal@ionos.com>
References: <20260107161517.56357-1-haris.iqbal@ionos.com>
Subject: Re: [PATCH v2 00/10] Misc patches for RTRS
Message-Id: <176813909590.385203.11259029514828478975.b4-ty@kernel.org>
Date: Sun, 11 Jan 2026 08:44:55 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Wed, 07 Jan 2026 17:15:07 +0100, Md Haris Iqbal wrote:
> Please consider to include following changes to the next merge window.
> 
> Changes:
> 
> v2:
> - Addressed comment for patch 02 to print only error description.
> - Addressed comment for patch 05 to remove additional unused members.
> - Addressed comment for patch 06 to remove internal ticket reference.
> - Added patch 10 which corrects the print for process_info_req.
> 
> [...]

Applied, thanks!

[01/10] RDMA/rtrs-srv: fix SG mapping
        https://git.kernel.org/rdma/rdma/c/01ebdb00045d31
[02/10] RDMA/rtrs: Add error description to the logs
        https://git.kernel.org/rdma/rdma/c/342dfca90e9e7e
[03/10] RDMA/rtrs: Add optional support for IB_MR_TYPE_SG_GAPS
        https://git.kernel.org/rdma/rdma/c/d97780f47de8a2
[04/10] RDMA/rtrs: Improve error logging for RDMA cm events
        https://git.kernel.org/rdma/rdma/c/1c07af708c2264
[05/10] RDMA/rtrs-clt: Remove unused members in rtrs_clt_io_req
        https://git.kernel.org/rdma/rdma/c/6101e43a3b19fe
[06/10] RDMA/rtrs-srv: Add check and closure for possible zombie paths
        https://git.kernel.org/rdma/rdma/c/dfee29ab9bb51c
[07/10] RDMA/rtrs-srv: Rate-limit I/O path error logging
        https://git.kernel.org/rdma/rdma/c/39108b3b746a82
[08/10] RDMA/rtrs: Extend log message when a port fails
        https://git.kernel.org/rdma/rdma/c/309ed174a206d4
[09/10] RDMA/rtrs-clt.c: For conn rejection use actual err number
        https://git.kernel.org/rdma/rdma/c/5f33a5bf21a46e
[10/10] RDMA/rtrs-srv: Fix error print in process_info_req()
        https://git.kernel.org/rdma/rdma/c/8fb792a56b2257

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


