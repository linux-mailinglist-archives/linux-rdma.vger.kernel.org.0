Return-Path: <linux-rdma+bounces-2800-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F188D88C7
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 20:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C5A287EE6
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 18:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6461386DF;
	Mon,  3 Jun 2024 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ca7B5HyH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F781CD38;
	Mon,  3 Jun 2024 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717440173; cv=none; b=jp5ccXD3ah5LAsXGt3DK/4EdF4RyiOpp8s77ouwq1PE0fWMfuE4XofexgLtbxKM5AzAirf8zeRXw1a0v3DC0xTAi/50HeamwiBXO0JhPdIDN1K/AUKz30QBtWWOdPgvy1xZrEobIAt+Oq16tfI1rNofs4fN8lpqtV68GPGyuQCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717440173; c=relaxed/simple;
	bh=nW1jlc/m9thV6uF+r0tV6tWnOtpg0higsRLy7TBagJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZE7Bxmn0A8c9uURNcHAJ1ouw30dCPKFQhXqbv6mdBop9qphr5F8gepTnwdJVrZuT1tf2Dort8/QCpszLXLCpRoco7ZgpFSN16MmB6KOtyeki5WDOucrZ+1M2JUdxdcDBRZsFm4X1gIuNV+Vuu0njDNhwFuPUWTixnKtBOrTDaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ca7B5HyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6FFC2BD10;
	Mon,  3 Jun 2024 18:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717440172;
	bh=nW1jlc/m9thV6uF+r0tV6tWnOtpg0higsRLy7TBagJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ca7B5HyH9cEPGGyTQxh10LS2F4upi3uZuqCrsvjzvbvUBqaHBJf3zgZQ3ve8h5zCx
	 Yufh4XpPuC78dKOD/g/70o3il1Auw/7LM0gRmoUfq31dG9NLsjQnTp/ITfUYc9d/g+
	 PvnenDfdBZxHm4w2/N2j3wTfTq+pABCE54hjTLbTJPk+Qha6b2u3E6rK5hU+d/7gk4
	 20QdFDQJa27PXBGubHm+yvsbakYoAcHaU6uHQV3doq+VJF/7pO4yWqC2CHhWvXxhle
	 slW9G/u+ConSfHoIjTT0Fw5Rec/VESNCEYsLCDZtBlYsUfurSnbMbwc2Y5LVxK34dA
	 hbHpP/582vefQ==
Date: Mon, 3 Jun 2024 11:42:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron
 Silverton <aron.silverton@oracle.com>, Dan Williams
 <dan.j.williams@intel.com>, David Ahern <dsahern@kernel.org>, Christoph
 Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
 <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <20240603114250.5325279c@kernel.org>
In-Reply-To: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Jun 2024 12:53:16 -0300 Jason Gunthorpe wrote:
> fwctl is a new subsystem intended to bring some common rules and order to
> the growing pattern of exposing a secure FW interface directly to
> userspace. Unlike existing places like RDMA/DRM/VFIO/uacce that are
> exposing a device for datapath operations fwctl is focused on debugging,
> configuration and provisioning of the device. It will not have the
> necessary features like interrupt delivery to support a datapath.

If you have debug problems in your subsystem, put the APIs in your
subsystem. Don't force your choices on all the subsystems your device
interacts with:

Nacked-by: Jakub Kicinski <kuba@kernel.org>

Somewhat related, I saw nVidia sells various interesting features in
its DOCA stack. Is that Open Source?

