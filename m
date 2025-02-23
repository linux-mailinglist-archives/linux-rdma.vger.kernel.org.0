Return-Path: <linux-rdma+bounces-8024-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853F8A40F1E
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2025 14:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2A518982E2
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2025 13:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295D720764C;
	Sun, 23 Feb 2025 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3lnN2Co"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F1C204F92;
	Sun, 23 Feb 2025 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740317701; cv=none; b=MXPhgMh1Ma0IIy5KDQxVB7OZpRaekseqUjclaKMbiQzZJ4M/kHjvgWBMTGf9JX8fnjEkWyEw8dK/yweHacbnEA5eJk0nuI1pi/qipPpLXDRoYPLCxg+9E5FI7Yu6B+0aLPa1F6PJPIUUd7Wkyb55odJBGbxsQrtLbz8QKHV7ys8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740317701; c=relaxed/simple;
	bh=74Cc+0R0bITAwz4r/9tbjxRHeduVzR4HH5WQ0M1yIv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwiXtzNwYnt/px8wLAvyfM29+HyeyVXiae0cSyy0Ywu4RwbSuYkORhjYIO0xA+/iDw+uieigCAplTU1ov3HpJrDMa1DJnr8vFXxrZNi0Yjkn04rBj6K8HPyXhCOBleW3pQPcxPcac+uHXr/YgDaQlyG/wVuCTjIQaGj2H2RrjJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3lnN2Co; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734B6C4CEDD;
	Sun, 23 Feb 2025 13:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740317701;
	bh=74Cc+0R0bITAwz4r/9tbjxRHeduVzR4HH5WQ0M1yIv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O3lnN2CouiVwA2zmHrG/VZU0Z+5lmKLmzUBSaIPpiGxYDvcW2mwQmE15xLJV60zJB
	 xuyKYk892LGBH7TkfQnCjMB0MfbtAlFD8Ec2Vn88NCx9jv/zSFu6J2jCyArWreaZXd
	 m+9O8s/oIiUOIJKH53DfdA3Zr0fjhsHl40Sr0t+ePAc24/XrrbiGkAWmablG99fruY
	 DR0Rozwf+tVKpYo28aOJfkliwRR3NH6F8h9xQwVG87/ZpieDk7Y1WTks8UoGUBm/2l
	 m5fY9x1ujahS9cGO5s1L07VFsbEa0MSDiQJJpM1fqF0Sj7MgPwmo7Eh0RgHL/cUnRn
	 GY7MpErmIZ2vw==
Date: Sun, 23 Feb 2025 15:34:56 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, abeni@redhat.com, horms@kernel.org,
	michael.chan@broadcom.com
Subject: Re: [PATCH rdma-next 0/9] RDMA/bnxt_re: Driver Debug Enhancements
Message-ID: <20250223133456.GA53094@unreal>
References: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>

On Thu, Feb 20, 2025 at 10:34:47AM -0800, Selvin Xavier wrote:
> For debugging issues in the field, we need to track some of
> the resources destroyed in the past. This is primarily required
> for tracking certain QPs that encountered errors, leading to
> application exits. A framework has been implemented to
> save this information and retrieve it during coredump collection.
> 
> The Broadcom bnxt L2 driver supports collecting driver dumps
> using the ethtool -w option. This feature now also supports
> collecting coredump information from the bnxt_re auxiliary driver.
> Two new callbacks have been implemented to exchange dump
> information supported by the auxbus bnxt_re driver.
> 
> The bnxt_re driver caches certain hardware information before
> resources are destroyed in the HW.

Unfortunately, no. The idea that you will cache kernel objects and they
live beyond their HW counterpart doesn't fit RDMA object model.

I'm aware that you are not keeping objects itself, but their shadow
copy. So if you want, your FW can store these failed objects and you
will retrieve them through existing netdev side (ethtool -w ...).

Thanks

