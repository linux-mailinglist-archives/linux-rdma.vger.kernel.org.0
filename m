Return-Path: <linux-rdma+bounces-4202-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4C3947A28
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Aug 2024 13:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85D00B21F97
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Aug 2024 11:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31BD15574F;
	Mon,  5 Aug 2024 11:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtOgHeGV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E0E155735
	for <linux-rdma@vger.kernel.org>; Mon,  5 Aug 2024 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855647; cv=none; b=Ih4Z4to5lSpQ5oUWBmKATi/O3Ym+/3cPAQDQyUL19J7B4pzWdmzIUQgilTzGxrsdUeaCifwl2I/IJZEbxU5GTkxWi3aUDdPBctPECgmQ52VZK2aEV9Ikn4M+FflrnmkqPbLhRRvS+NL+i0py6gKo0qKS1wFZWJvCf1dnvWZ6B8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855647; c=relaxed/simple;
	bh=HykqMY8WvWXHFD1mPF3Xyt04GaEaRr2sq08IxUyDANM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q32Ic7CQHYhArDPghhUI+4CM1mXjQoyMD9n38g8T2wUuwLytjdoR9rFCW5diuO4WtpeyF4m2waEiSmNxOQ44lBgJJPlK3C3Q05syW6c54Z/Q7S1OZe7x9i7hc21N7/B2vg5poyp0y3aD6WQDel/PVRIptgtq6Vguo32Y9cL0KSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtOgHeGV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A454AC4AF0D;
	Mon,  5 Aug 2024 11:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722855646;
	bh=HykqMY8WvWXHFD1mPF3Xyt04GaEaRr2sq08IxUyDANM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XtOgHeGV+cBOv6S0RLLZgeAUQ2OdFa2hPvOBWEDHQB0Q2VfwBbWI3S5AarU8r8xu9
	 epj5RuY5b8ho0ulnAgoJNniNaJpSwRcOPhqPLhBfeMiS15McXzYlTtP6BvYP8vu+QR
	 yp2MX0ewYjedc5LxIYx/H7AuUjvCOlljyNgxSlnhl6t5/bXY+NXFPN5Oof8L3iT87T
	 kai7GeP8ZHQiP74EgAPCokdK4WHYCo3ZNJAZcuhKhAlPVkNISXDD4JeG7/6ajI6+jn
	 eBGsHuSaifpIYS1dxWNpxfBYOEfkAN21Shrkjl4ROOjnd2jFbDoC93X3Yk1XGXdK8W
	 JTcYz2tTfxWkg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>, linux-rdma@vger.kernel.org, 
 Michael Guralnik <michaelgur@nvidia.com>
In-Reply-To: <f633a979a49db090d05c24a3ba83d30727bb777b.1722331020.git.leon@kernel.org>
References: <f633a979a49db090d05c24a3ba83d30727bb777b.1722331020.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/nldev: Enhance netlink message parsing
 and validation
Message-Id: <172285564183.428749.6683888628240240627.b4-ty@kernel.org>
Date: Mon, 05 Aug 2024 14:00:41 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 30 Jul 2024 12:17:25 +0300, Leon Romanovsky wrote:
> Use strict parsing validation for set commands, and liberal
> validation for get commands. Additionally, remove all usage of
> nlmsg_parse_depricate().
> 
> Strict parsing validation fails when encountering unrecognized
> attributes in the Netlink message, while liberal parsing
> validation ignores them.
> 
> [...]

Applied, thanks!

[1/1] RDMA/nldev: Enhance netlink message parsing and validation
      https://git.kernel.org/rdma/rdma/c/3573826ab50619

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


