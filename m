Return-Path: <linux-rdma+bounces-12483-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B69AB12205
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 18:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D960116759C
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 16:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B8A2EF28E;
	Fri, 25 Jul 2025 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chKb92Aw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B98D1F0E26;
	Fri, 25 Jul 2025 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460980; cv=none; b=cpdblyRgqqs7lSmhsu+xSTPyF3inS2Ajw//QIPHHeYqbZOUatVCsfF9ykHbbkW0xsrSDqAiyUaOqIDdw4YgVLygGHhqIQy7hBZNyEHpbtrppA3Z8glOskXY2RiQTqil781czTpsbXy9ZCxR2+BPI1UGY15QtId3BYeX0yDjZWZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460980; c=relaxed/simple;
	bh=42TrrIOPkeb9eA0ooDQCwEToRUoD4yszjtBtK/6JRW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkuOoaW8TIuA08qIMOuYfz3je+n51atav9v4QVJ1PwJQ5SY38IKCL/WQLNPZysjWaMdAb/acCJlJyLHGFhzbO0Q4wiMf+BnNdEQk6M/SVpPLIQGJZwS8AYQtrj9SF0oon+iERw/TrhADvJVzOiT2RnEbzf/4U1/j8Swh7aKc0vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chKb92Aw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A297C4CEE7;
	Fri, 25 Jul 2025 16:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753460979;
	bh=42TrrIOPkeb9eA0ooDQCwEToRUoD4yszjtBtK/6JRW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=chKb92AwoPO45zlhVcarcYPB8vfCinbNToixS1/Gpx/9obKTeVrxyffV2js3zTlgg
	 NdcX9Xytq61pEG2MlJs66jAmC9jHLykkQBXjm76ebRxe0VSvAi1+ImC/EKVF2r5Czp
	 5h3aWYVDrJVoE3/7ENcMdf81QMliBpJ1vlhrF9DkCaDRUT10xsDIE+lBedKhb5vrGC
	 rKHlM6ii5rtMDMAUB2go3hK+kA7B+0yAleHhGQ/3Sapp/h8DGG+ez9o+fF+7x8EMjo
	 k6S+lPOuanAl8a8UTk3rkg6m/2C4b6gtWMxvxH2zNY/okskCbuSlmd9CYLWptW3svR
	 JBKJLfmyILXTg==
Date: Fri, 25 Jul 2025 17:29:34 +0100
From: Simon Horman <horms@kernel.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	corbet@lwn.net, jgg@ziepe.ca, leon@kernel.org,
	andrew+netdev@lunn.ch, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/14] net: ionic: Update LIF identity with additional
 RDMA capabilities
Message-ID: <20250725162934.GH1367887@horms.kernel.org>
References: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
 <20250723173149.2568776-3-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723173149.2568776-3-abhijit.gangurde@amd.com>

On Wed, Jul 23, 2025 at 11:01:37PM +0530, Abhijit Gangurde wrote:
> Firmware sends the RDMA capability in a response for LIF_IDENTIFY
> device command. Update the LIF indentify with additional RDMA
> capabilities used by driver and firmware.
> 
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>


