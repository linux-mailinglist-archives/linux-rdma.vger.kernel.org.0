Return-Path: <linux-rdma+bounces-1794-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 090B789931E
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Apr 2024 04:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A904128406E
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Apr 2024 02:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E788F12B93;
	Fri,  5 Apr 2024 02:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkqJfey2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC3E79C4;
	Fri,  5 Apr 2024 02:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712283669; cv=none; b=IuHSkBcjznGuc7BlsFWx4gagCRS3sx1BxL9Wi7Y/bs/X720GWcm0WTGEsZAPpFlckSqGGU780st+W7RQsUVOqsVXi1zCKT2e2KnPTuJMr32bt207dPcYbLWOo0ve0tWEPTqx6WKCq2P1R1+VcmQ4sjIjWu1pYd5Bt7VJYWUuNvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712283669; c=relaxed/simple;
	bh=UpaoUDY9qOadpJwyb5Y5pkyQyUc+7I9hebJ2WaoDEpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZkqQOITQMlK6xjIu7k1mW158pp8O8jNi6kbwP74+8hAXpEv13yankxekf8PeyeYooqDmmJKyzuY1fc1Prg41yg/NLamJjhEZYtQYoB1m2YiCtshP4AH11kRxpYMVye/adMyrcW3tBLddCoezLZ5hSUVS3jqE2v6Z0Rl7z+a0MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkqJfey2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A75C433F1;
	Fri,  5 Apr 2024 02:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712283669;
	bh=UpaoUDY9qOadpJwyb5Y5pkyQyUc+7I9hebJ2WaoDEpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jkqJfey2mvfD7C/dzUSO9JuMOTPg4l9n/mc+bx4wcePSKzEemlJxmy6xsqXp3lxag
	 gBVCTR26K5PzZF3ZxE4aZ+J67OFkbbxUsj+XXkg8dusGWr20Izz5ERInBEU74oYaFe
	 8iFvVjJdy7SLTYMC4dtG6Q+OQUDX3ZQTJWPKga8tyEXb4U49RXys4sRkBPDV52ONiH
	 m56VOVTFaH7zFC9HrwwdcwGM6DlLo779SOF7R5vwhGFnErexPvnW7j5PClIXiUPAl4
	 vc+cuWNhhdkrg0NnkkxGBuf9mSpa84QHO0KlNNnCmupLSVt0rvzngxk6g/xKW/CPw/
	 brSPc1fKgr36w==
Date: Thu, 4 Apr 2024 19:21:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parav Pandit <parav@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <corbet@lwn.net>,
 <kalesh-anakkur.purayil@broadcom.com>, <saeedm@nvidia.com>,
 <leon@kernel.org>, <jiri@resnulli.us>, <shayd@nvidia.com>,
 <danielj@nvidia.com>, <dchumak@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [net-next v3 1/2] devlink: Support setting max_io_eqs
Message-ID: <20240404192107.667d0f8e@kernel.org>
In-Reply-To: <20240403174133.37587-2-parav@nvidia.com>
References: <20240403174133.37587-1-parav@nvidia.com>
	<20240403174133.37587-2-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Apr 2024 20:41:32 +0300 Parav Pandit wrote:
> Many devices send event notifications for the IO queues,
> such as tx and rx queues, through event queues.
> 
> Enable a privileged owner, such as a hypervisor PF, to set the number
> of IO event queues for the VF and SF during the provisioning stage.

What's the relationship between EQ and queue pairs and IRQs?
The next patch says "maximum IO event queues which are typically
used to derive the maximum and default number of net device channels"
It may not be obvious to non-mlx5 experts, I think it needs to be better
documented.

