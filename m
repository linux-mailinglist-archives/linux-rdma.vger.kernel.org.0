Return-Path: <linux-rdma+bounces-13200-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E067B4C761
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 14:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4F23A3D5E
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C0F322DB4;
	Tue,  9 Sep 2025 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrOlud5E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133F7285C9F;
	Tue,  9 Sep 2025 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419694; cv=none; b=ug5ARiCx1p0WX0j8+sVkuwPX60uMDEXlzq7Lzy5wzCM89pCBeeRIX8iDmy1q3X/cFECQWT6OrgM+BkvUBcqPrl+zsJwZfz1S/KkY1kTx5qXVRlBEFPHGSCinZMh2li0U5G2QnuJ1R3Zf+wxrYGKu7k3yChE10Vhq5TjAmnA4FPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419694; c=relaxed/simple;
	bh=IneL+1jgIRyie8JLebCxAkevbz1wxvaKWFo7LA4OXPw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NLYTlmyQeTKDfHRTs0y5/fAapF6OfyR8hvwSRixdOaLu5zKFK8CrZcwwxLIK47TGo5vf2hbnbtm2DBzJ995YkYg4mla/ZAJWhSkjAWXnSvkGgmBT7vZDv34+cv8yv3OdMFANrpcpioZtuapsrwjBG1xlUS6Lv5LW9J/lGoVLBbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrOlud5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C919C4CEF4;
	Tue,  9 Sep 2025 12:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757419693;
	bh=IneL+1jgIRyie8JLebCxAkevbz1wxvaKWFo7LA4OXPw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hrOlud5EKreZlekCvC0nzsLIPsYNxuNiSqiKFMFD2DZZJQTDHAzDHi62auXcSuGAO
	 OivSdT1UkhgLPQM6kGeDF9W2VkeXN/P2743r0pQf6hvUMWWgN7aGC2wxsdgIMn/K/K
	 oQ06XUWVE8joNVeRIICFNdE3ci5Ss8zP5VhTV2yuRuUAJmnNLTO/WbOPahZt7wBLBw
	 zZoe7Nu+Vmnu6WZDLVJvv76zhAiC1Z74VXh0YCaXB5He6nDF3/JqcJideipcZc6VLm
	 xZtDZV5bj53dabz9lsLpivF9PUO+R5pCmc/ry8+9fxxdyRU1Z8EHSak5Z/oHnCzTIw
	 z64KmLI5nVZ2w==
From: Leon Romanovsky <leon@kernel.org>
To: brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com, 
 kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, jgg@ziepe.ca, 
 andrew+netdev@lunn.ch, Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: sln@onemain.com, allen.hubbe@amd.com, nikhil.agarwal@amd.com, 
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250903061606.4139957-1-abhijit.gangurde@amd.com>
References: <20250903061606.4139957-1-abhijit.gangurde@amd.com>
Subject: Re: [PATCH v6 00/14] Introduce AMD Pensando RDMA driver
Message-Id: <175741969032.708989.6392082330340269023.b4-ty@kernel.org>
Date: Tue, 09 Sep 2025 08:08:10 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 03 Sep 2025 11:45:52 +0530, Abhijit Gangurde wrote:
> This patchset introduces an RDMA driver for the AMD Pensando adapter.
> An AMD Pensando Ethernet device with RDMA capabilities extends its
> functionality through an auxiliary device.
> 
> The first 6 patches of the series modify the ionic Ethernet driver
> to support the RDMA driver. The ionic RDMA driver implementation is
> split into the remaining 8 patches.
> 
> [...]

Applied, thanks!

[01/14] net: ionic: Create an auxiliary device for rdma driver
        https://git.kernel.org/rdma/rdma/c/82677c31466120
[02/14] net: ionic: Update LIF identity with additional RDMA capabilities
        https://git.kernel.org/rdma/rdma/c/a61164443aa1d4
[03/14] net: ionic: Export the APIs from net driver to support device commands
        https://git.kernel.org/rdma/rdma/c/9aabab47b73fa8
[04/14] net: ionic: Provide RDMA reset support for the RDMA driver
        https://git.kernel.org/rdma/rdma/c/4660ce92944ec5
[05/14] net: ionic: Provide interrupt allocation support for the RDMA driver
        https://git.kernel.org/rdma/rdma/c/e587f088137882
[06/14] net: ionic: Provide doorbell and CMB region information
        https://git.kernel.org/rdma/rdma/c/833e384b2fff35
[07/14] RDMA: Add IONIC to rdma_driver_id definition
        https://git.kernel.org/rdma/rdma/c/f8e85db1702851
[08/14] RDMA/ionic: Register auxiliary module for ionic ethernet adapter
        https://git.kernel.org/rdma/rdma/c/8b265da071f707
[09/14] RDMA/ionic: Create device queues to support admin operations
        https://git.kernel.org/rdma/rdma/c/1c2d35074d9675
[10/14] RDMA/ionic: Register device ops for control path
        https://git.kernel.org/rdma/rdma/c/57c6622844742b
[11/14] RDMA/ionic: Register device ops for datapath
        https://git.kernel.org/rdma/rdma/c/6cada62ba14f25
[12/14] RDMA/ionic: Register device ops for miscellaneous functionality
        https://git.kernel.org/rdma/rdma/c/ca6704a04c36e4
[13/14] RDMA/ionic: Implement device stats ops
        https://git.kernel.org/rdma/rdma/c/8de04ae7bfe0b8
[14/14] RDMA/ionic: Add Makefile/Kconfig to kernel build environment
        https://git.kernel.org/rdma/rdma/c/59804cf2d906df

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


