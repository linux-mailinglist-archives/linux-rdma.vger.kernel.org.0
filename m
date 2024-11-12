Return-Path: <linux-rdma+bounces-5924-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1F99C4D00
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 04:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842F228A276
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 03:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C3C204F90;
	Tue, 12 Nov 2024 03:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mv8wTLYb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0612C19DF62;
	Tue, 12 Nov 2024 03:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731380639; cv=none; b=VYhly20WWf1NpBe4jqsKG4VU4tH521DgMMHHpbmlCVWVnZH9kU4Tt27/xIh26SoRk+t9A4MZccHRr1bLTyoiW/v4Vez38KbvZx1dk9OrHIQvTPcOe2RM3aDRjjfH0aIQaXP947nVJxjUhy7HkuoV6/5Bzr7y2kCnIPEkcseagC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731380639; c=relaxed/simple;
	bh=zEuVEOYuXvXUfujcZ5GqwkoABFSLMXkGDWxAsMEEFyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPQ4PKEAcpwzd/38+TCK7clpdu9L2MA3WOG5O6wH8rVAkDSQoG3L0KqNDymsBH8QA5AEHquIOCHv071jFh1PopvEXVmV+X0xoS9oi/YPDud7c0Sw2FztD8pG+Zv+HE0Z/YmyK5GHfiahmVYk6r6ZmJyTX+2Cmw16XTaT3dd16dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mv8wTLYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E022C4CECF;
	Tue, 12 Nov 2024 03:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731380638;
	bh=zEuVEOYuXvXUfujcZ5GqwkoABFSLMXkGDWxAsMEEFyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mv8wTLYbB0/mepIUwLysLWZSQHKkWGgpvMXFU6/G85HdVDVTKuOTFLGFdZ8lHm1PN
	 gjzljxT8jQfbK2oQi4AwJfeNeMe6gcl8LWLwDttcFpDTEysNKxnpOAGAWVp89XLm8R
	 eVuH4Tpzdj1asuMS0pcb8r/DNNY59gjMasG1ZAHzYiJpjDjWdhHOpORXc+gqQEu2Vw
	 3BMkcFunnkZfW232l3DHw+y90hFNBw8+tOiaRSbMHJhrFUcLnijjpLF7Ab+Ul3HN7U
	 AnYMdTA1ZyLFxpPSlf5Ht5f686gvLoH1V0TnzUGdNtZ4cWa4Pp+jOkiMpo1mBq1cMn
	 PDgDB910rl6Bg==
Date: Mon, 11 Nov 2024 19:03:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Abhinav Saxena <xandfury@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, Allison Henderson <allison.henderson@oracle.com>,
 Russell King <linux@armlinux.org.uk>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH 1/2] docs: net: Fix text in eth/intel, mlx5 and
 switchdev docs
Message-ID: <20241111190356.0aefe1b9@kernel.org>
In-Reply-To: <20241108202548.140511-1-xandfury@gmail.com>
References: <20241108202548.140511-1-xandfury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Nov 2024 13:25:47 -0700 Abhinav Saxena wrote:
> diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
> index f355f0166f1b..df4b4c4a15d5 100644
> --- a/Documentation/networking/switchdev.rst
> +++ b/Documentation/networking/switchdev.rst
> @@ -162,7 +162,7 @@ The switchdev driver can know a particular port's position in the topology by
>  monitoring NETDEV_CHANGEUPPER notifications.  For example, a port moved into a
>  bond will see its upper master change.  If that bond is moved into a bridge,
>  the bond's upper master will change.  And so on.  The driver will track such
> -movements to know what position a port is in in the overall topology by
> +movements to know what position a port is in the overall topology by

Are you sure? The first 'in' is for position, the second for topology.
Equivalent to:

 movements to know in what position a port is in the overall topology by
                   ^^                         ^^

We can rephrase to avoid the double in:

  The driver will track such movements to know the position of a port
  within the overall topology by registering for netdevice events and
  acting on NETDEV_CHANGEUPPER.

>  registering for netdevice events and acting on NETDEV_CHANGEUPPER.
-- 
pw-bot: cr

