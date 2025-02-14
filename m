Return-Path: <linux-rdma+bounces-7762-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBF0A35376
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 02:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E333E3AC3EE
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 01:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FCC3596D;
	Fri, 14 Feb 2025 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnFP5BvM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34BF24B26;
	Fri, 14 Feb 2025 01:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739495038; cv=none; b=XOTBGs9sjcrE1Prh9d2T2O0+QAj7cxlwUtArcdFbgCjCRL6CioeYmwqLL1zZrY5n+Luk5jny6Or76DfyNyHw2AQpuJoNdv2lWgHOfPFC/OVjtfahdrNGm+cDUNX5kQ0uqdfT8/JJAx+VTHY4WSWkuYOFQiLuFgcrmQgr5/9WkeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739495038; c=relaxed/simple;
	bh=W/Igzl9uJU8QlVFiiA3nisgq3kjP+eGRHv9tmMqI4ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3tj74D/fxWvqgbc3s3d7iq8Jx/4gX4syKkZr02ilMTpYlZNpHNDh0Rlqh30UEzFR4MnNd6bEfrV4ItE0j14DUl0NkGLpvFZLdlhsKE45kKObw67gzsorSV8PHHUDpKj7d2wh81gjhhFRahG0rsTShWGBxNq9AtvV7EUd6alo6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnFP5BvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBEAC4CED1;
	Fri, 14 Feb 2025 01:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739495037;
	bh=W/Igzl9uJU8QlVFiiA3nisgq3kjP+eGRHv9tmMqI4ZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RnFP5BvMhv7jT/2QdPauaEH0YyLESTgaul4+pbhH/BntLqpnXYzoEH0TaFYKLvOFX
	 Pc8YyQGn1/t+KLXObylwbgfitCmtV3ilc5/DUlop2LQSL/cSdhL8ucNrEUdfdnhd2i
	 NnZOnRpDFfdCC22g8+I3n3Kr/R8jqoUR8IPwP3dX/Kuxb+Tqjxd4qyWfc/X9fHYBC5
	 a3fFeP+NpZF6XQa/0d8irPf6L/9frVTvuAuZ1EsdUdhs6JhYiVN21sJeJGcrpvSteK
	 hXwcDYI/ZJBBrSQIBzI7GTG/Vez6j3Wc4Btzb/1WF4pBgQ0wwFFYJXzJ4b9WdYg820
	 AUOgiLWKtY9ew==
Date: Thu, 13 Feb 2025 17:03:56 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: "Nelson, Shannon" <shannon.nelson@amd.com>,
	Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
Message-ID: <Z66WfMwNpVBeWLLq@x130>
References: <20250206164449.52b2dfef@kernel.org>
 <CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
 <20250207073648.1f0bad47@kernel.org>
 <Z6ZsOMLq7tt3ijX_@x130>
 <20250207135111.6e4e10b9@kernel.org>
 <20250208011647.GH3660748@nvidia.com>
 <20250210170423.62a2f746@kernel.org>
 <20250211075553.GF17863@unreal>
 <b0395452-dc56-414d-950c-9d0c68cf0f4a@amd.com>
 <20250212132229.GG17863@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250212132229.GG17863@unreal>

On 12 Feb 15:22, Leon Romanovsky wrote:
>On Tue, Feb 11, 2025 at 10:36:37AM -0800, Nelson, Shannon wrote:
>> On 2/10/2025 11:55 PM, Leon Romanovsky wrote:
>> >
>> > On Mon, Feb 10, 2025 at 05:04:23PM -0800, Jakub Kicinski wrote:
>> > > On Fri, 7 Feb 2025 21:16:47 -0400 Jason Gunthorpe wrote:
>> > > > On Fri, Feb 07, 2025 at 01:51:11PM -0800, Jakub Kicinski wrote:
>> > > >
>> > > > > But if you agree the netdev doesn't need it seems like a fairly
>> > > > > straightforward way to unblock your progress.
>> > > >
>> > > > I'm trying to understand what you are suggesting here.
>> > > >
>> > > > We have many scenarios where mlx5_core spawns all kinds of different
>> > > > devices, including recovery cases where there is no networking at all
>> > > > and only fwctl. So we can't just discard the aux dev or mlx5_core
>> > > > triggered setup without breaking scenarios.
>> > > >
>> > > > However, you seem to be suggesting that netdev-only configurations (ie
>> > > > netdev loaded but no rdma loaded) should disable fwctl. Is that the
>> > > > case? All else would remain the same. It is very ugly but I could see
>> > > > a technical path to do it, and would consider it if that brings peace.
>> > >
>> > > Yes, when RDMA driver is not loaded there should be no access to fwctl.
>> >
>> > There are users mentioned in cover letter, which need FWCTL without RDMA.
>> > https://lore.kernel.org/all/0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com/
>> >
>> > I want to suggest something different. What about to move all XXX_core
>> > logic (mlx5_core, bnxt_core, e.t.c.) from netdev to some other dedicated
>> > place?
>> >
>> > There is no technical need to have PCI/FW logic inside networking stack.
>> >
>> > Thanks
>>
>> Our pds_core device fits this description as well: it is not an ethernet PCI
>> device, but helps manage the FW/HW for Eth and other things that are
>> separate PCI functions.  We ended up in the netdev arena because we first
>> went in as a support for vDPA VFs.
>>
>> Should these 'core' devices live in linux-pci land?  Is it possible that
>> some 'core' things might be platform devices rather than PCI?
>
>IMHO, linux-pci was right place before FWCTL and auxbus arrived, but now
>these core drivers can be placed in drivers/fwctl instead. It will be natural
+1

Fwctl subsystem is perfect for shared modules that need to initialize the
pci device to a minimal state where fwctl uAPIs are enabled for debug and
bare metal device configs while aux sunsystem can carry out the
spawning of other subsystems.

>place for them as they will be located near the UAPI which provides an access
>to them.
>
>All other components will be auxbus devices in their respective
>subsystems (eth, RDMA ...).
>
>Thanks
>
>>
>> sln
>>
>>
>

