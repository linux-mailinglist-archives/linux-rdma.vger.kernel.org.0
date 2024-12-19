Return-Path: <linux-rdma+bounces-6645-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 569B19F7966
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 11:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC5816ED1F
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 10:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EE0222D44;
	Thu, 19 Dec 2024 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcyY2043"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AD7221DA0;
	Thu, 19 Dec 2024 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734603564; cv=none; b=TX+84VVwRHLuF8rEu27TA6Rus4xuI36kAg52srwBysYDEy49ye2KYlXh5PcUAZj45m/5fp7l6qT9MIX8+zPeELV+AOE+FQvzvzx9GosnOw/S0M7+iMfFUQdmqJMiKQRImjfF/WVJmm73e/2ESuj5evb3yO8SpcbyVsYgVlKigbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734603564; c=relaxed/simple;
	bh=YARuEnKCY3DjNkFjefNtHIJtCVS0Uy8rwW6nb5xs85s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jptBmZ2OSDfUNjBvu5TJsdGYIhl+Zwrx+KIiWFGxwV2Od4D4GhNYRCvlt7iq2GRXxsS35n65u2RqwZLm7bFuTcPX+CZT2kgJAMGweVfbimttJ/1/vWOdDJgjI4Ra5XdAurXByQLGH1z7pFYRG226J1HDhGMH0AWy1b+D+f9aoRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcyY2043; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127B0C4CECE;
	Thu, 19 Dec 2024 10:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734603563;
	bh=YARuEnKCY3DjNkFjefNtHIJtCVS0Uy8rwW6nb5xs85s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fcyY2043vkv0GTcHBmAWP5Gi/Y9QOSAyqXCKXn/fL//POSSDU+J1oAjbmSXAvfUiL
	 9k2B+y7zUV6HoRifF10RddsIWCx2M59H8/8sww6/zlrlKHwddFVcsMg3jUt8Hw5Dj5
	 y6dcvNCuOj+EcLV+I2LFpEFpUHMMiE9lSo8qFLJXbdlKjRAB4zP0BnldX2nioCM+wg
	 T6Y2xgZm02eug257TrSWRzT98/A+YDanZ+7Bi8x4C5tVAXkz2DxtLvPZwaJsdj+2Mn
	 elQulv1pvwXWvzSCEQOh/IA9OSBe4DByuuCyr/vh8xojrsS4GJWQjIEUKnHfJdUakl
	 SLBqJhzh0XY8w==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Bernard Metzler <bmt@zurich.ibm.com>
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com, zyjzyj2000@gmail.com, 
 syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
In-Reply-To: <20241212151848.564872-1-bmt@zurich.ibm.com>
References: <20241212151848.564872-1-bmt@zurich.ibm.com>
Subject: Re: [PATCH RESEND v2] RDMA/siw: Remove direct link to net_device
Message-Id: <173460356012.346747.2939412852773263195.b4-ty@kernel.org>
Date: Thu, 19 Dec 2024 05:19:20 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 12 Dec 2024 16:18:48 +0100, Bernard Metzler wrote:
> Do not manage a per device direct link to net_device. Rely
> on associated ib_devices net_device management, not doubling
> the effort locally. A badly managed local link to net_device
> was causing a 'KASAN: slab-use-after-free' exception during
> siw_query_port() call.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/siw: Remove direct link to net_device
      https://git.kernel.org/rdma/rdma/c/16b87037b48889

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


