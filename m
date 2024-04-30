Return-Path: <linux-rdma+bounces-2156-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDCE8B7552
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 14:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E868E1C21F0A
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 12:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDBD13D624;
	Tue, 30 Apr 2024 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6cC2kZX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0F213D26D
	for <linux-rdma@vger.kernel.org>; Tue, 30 Apr 2024 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478588; cv=none; b=Cl69WWRWwdNoIT74Y8PsgoqPuuCJgTAjB3MEwgM+vpMYWzJ8EArtOb6FwgORAEcLZBdtXT6Cq0At530fxPo2oDHb8Gl75ii94+MENBOmJXa7l5vbirdeasGSdw0lD/7bceZpEu+BrVQ9f0Wh+ZI9wdo1B0YiErEwTgDGLJFpRjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478588; c=relaxed/simple;
	bh=aYnC5NBr7sjycNODSUAeNUem+knYeDzG22un8xDC5Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQcyyQHhO8xiDohQJLWb2cZFF0W4JCRJ72xi1d0QKPFw6bgJLBwdc252WIUWW/eVSEId3DsIb7sGuVeNHota+GZXCP8pcGlPL1S8/WDrXWTGE6BC1HpHUPp60Fda4vpSZj6YHa4mpbFtJaztnT8pLE+VjJwH+FSGYN3jzz1r3Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6cC2kZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890B3C2BBFC;
	Tue, 30 Apr 2024 12:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714478588;
	bh=aYnC5NBr7sjycNODSUAeNUem+knYeDzG22un8xDC5Uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6cC2kZXMzp/WBgYFz8J2Vo/Rn6dhh5WwQCnDGV8sIxertfj3U478vIuH1mYSqqJz
	 WtXE50Mfe7gQ4caJ3dsBnx1Bfh7rk39FRoxJCsIKbcFKmuali+6jqd6GLS4olxLVYv
	 Wwkp9Z3q4ine5fHfzvHRK/DKDJL6H6soyAyhTXRmPMXq4S31F1tu2YGxfDEeZWPtnX
	 m1td+Oxvu1vkffeUl8kElDR64+PmJmfGPVq3/WG6/VcO9LXnl8vsiiP6tlGDwz3jky
	 urgTAERrWKbJey1U5j+XWLrhdnV9rBBm6HHyzdXqxAklz7euulC5ZHvtdXZ14RaO1I
	 tyx7j3mz5RVYg==
Date: Tue, 30 Apr 2024 15:03:03 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ewen Chan <alpha754293@hotmail.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: SRIOV virtual functions with Linux "inbox" opensm
Message-ID: <20240430120303.GB100414@unreal>
References: <SA1P221MB10184D6002569E274E6630D7B5122@SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1P221MB10184D6002569E274E6630D7B5122@SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM>

On Mon, Apr 22, 2024 at 10:09:15AM +0000, Ewen Chan wrote:
> To Whom It May Concern:
> 
> I am using a few Mellanox ConnectX-4 100 Gbps Infiniband NIC that's connected together via a Mellanox MSB7890 externally managed switch.
> 
> I have a dual Xeon E5-2697A v4, Proxmox 7.4-17 (Debian 11) server that's running opensm, along with two AMD Ryzen 5950X compute nodes, that also have the ConnectX-4 in them, running Proxmox 7.4-17 as well.
> 
> I have enabled SR-IOV on all three systems, and all three systems have 8 virtual functions for said ConnectX-4.
> 
> I read in the Nvidia/Mellanox documentation that I would need to add the parameter "virt_enabled 2" to /etc/opensm/opensm.conf so that the OpenSM subnet manager will know that virtual functions are enabled, but it would appear that the opensm that ships with Debian 11/linux-rdma, either ignores that option or doesn't know what to do with it.
> 
> I would prefer NOT to install the MLNX_OFED drivers for Debian (11) if I can avoid it.
> 
> My two questions are how do I get the linux opensm to:
> 
>     Recognise that I am using virtual functions (so that it would understand that there are multiple traffic streams coming over the wire, via one physical port)?
> 
>     Automatically assign the Node GUID and Port GUID so that I don't have to set those manually.
> 
>     (I've set the Node GUID and Port GUID on the my Ryzen compute node host already, and I can see the Node GUID and Port GUID inside my CentOS 7.7.1908 VM (which I've updated to use the 5.4.247 kernel), but it is still showing "Port 1, State: Down".)
> 
> 
> Your help is greatly appreciated.

Linux opensm is not supporting ConnectX4+ SRIOV.

You can install SM RPM from NVIDIA Web to enable ConnectX4 SRIOV.
https://network.nvidia.com/products/adapter-software/infiniband-management-and-monitoring-tools/

Thanks

> 
> Thank you.
> 

