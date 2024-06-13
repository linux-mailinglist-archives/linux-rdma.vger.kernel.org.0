Return-Path: <linux-rdma+bounces-3126-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82322907A02
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 19:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02075B241C5
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 17:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DC114A0AD;
	Thu, 13 Jun 2024 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="NtzwmtRz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADED433A4;
	Thu, 13 Jun 2024 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718300321; cv=none; b=eAIycD8BhKfBRQF2R5yTkUjEMHhVLHoqxCZKYla3rZ9gUVYkH2floR+uRSoeDZ1S5GPjEsik8rppY4WrEOHBz1AgT8F0XcVJVY5j0uJycBTmEfghgB+DS0E16CZgK9HY21b4D2EA7yWIkYa887Sn8+Yi36o5fIeCqwy8mhSJ/GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718300321; c=relaxed/simple;
	bh=iHrGBdCbZI2bStSbB8zQUHcxeTKog1kQOycxa6OEd14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTzV9AZlwSvpdaOoLJ0XRBj0QBbo8QT20BsYluuI/0GMPYhu5Le18kBAS6nVzkAblA9O/46x88jZbLagabzCEYw62NBUJEMVW4OyopD8w2MTlINHZdbHPHrZvd12Xn5Lxz5h4u52pkwl7aWL2K1ZGM7rPsnuT4zJApGjE50DxC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=NtzwmtRz; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1718300308;
	bh=iHrGBdCbZI2bStSbB8zQUHcxeTKog1kQOycxa6OEd14=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NtzwmtRzXbCIGztjkGdDShXjrZTC/Ly0c8lotFu2MjMLQqolth5maGlsYhHgYY6Cm
	 i/xFL1Dx5aUezuTk7dASqlDjEf+QuLx8RHz1DGU3LzqAkmtctrSmkPBJrxr41jzKKp
	 lbX3DaolNUJ/+koLsSqUKYFZA5IQftzXkTt6KJWrkirXqQezSnRdocS846urwocawl
	 9ogJKPsL20k6HxWW6QLZUOEbfjkAOhsLctQWpcxozb3B/ymKIz/pXu8j3ta+wUCJNg
	 MtlYOpvnRPM8Wi+lPcdl7SYcbN2EEvYpjTzWIGe4UPjjQRLx33lmAkB0kfN3KeQa19
	 MCodr9xvFjGiw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 9FD2060079;
	Thu, 13 Jun 2024 17:38:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 2C001201EC1;
	Thu, 13 Jun 2024 17:38:18 +0000 (UTC)
Message-ID: <711d788e-14e4-41fe-99ea-4c50be008018@fiberby.net>
Date: Thu, 13 Jun 2024 17:38:17 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] net: flower: validate encapsulation control
 flags
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Martin Habets <habetsm.xilinx@gmail.com>, linux-net-drivers@amd.com,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, linux-rdma@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 Louis Peens <louis.peens@corigine.com>, oss-drivers@corigine.com,
 linux-kernel@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
 i.maximets@ovn.org
References: <20240609173358.193178-1-ast@fiberby.net>
 <20240612180419.391f584d@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20240612180419.391f584d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jakub,

On 6/13/24 1:04 AM, Jakub Kicinski wrote:
> On Sun,  9 Jun 2024 17:33:50 +0000 Asbjørn Sloth Tønnesen wrote:
>> Now that all drivers properly rejects unsupported flower control flags
>> used with FLOW_DISSECTOR_KEY_CONTROL, then time has come to add similar
>> checks to the drivers supporting FLOW_DISSECTOR_KEY_ENC_CONTROL.
> 
> Thanks for doing this work!

Thank you, for maintaining the tree!

> Do you have any more of such series left?

Not at the moment, I only stumbled upon this, because I read the code
with an eye on adding a new IS_JUMBO_FRAME flag (patches for which are
almost ready).

Once this[1] currently RFC patch goes in, I might try to move all
control flags in under FLOW_DIS_F_*, to get rid of the then
FLOW_DIS_(IS_FRAGMENT|FIRST_FRAG|ENCAPSULATION|F_*).

[1] [RFC PATCH net-next 1/9] net/sched: flower: define new tunnel flags
https://lore.kernel.org/netdev/20240611235355.177667-2-ast@fiberby.net/

> Could we perhaps consider
> recording the driver support somewhere in struct net_device and do
> the rejecting in the core?

Sure, it could work for the control flags, and used_keys validation,
but I am not sure if it is worth it, as most of the validation is
very specific to the limitations of the different hardware. An easy
first step in that direction would be to move the used_keys checks
behind a helper, and possibly storing used_keys in struct net_device.

> That's much easier to extend when adding
> new flags than updating all the drivers.

That's how it is now, with the new helpers, as all flags are
unsupported, unless the driver specifically supports it.

Any new flag only needs to be added to the core, and drivers only needs
to be updated when they implement offloading support for a flag.

> This series I think may not be a great first candidate as IIUC all
> drivers would reject so the flag would be half-dead...

Correct. I don't know if there is any hardware support planned for the
tunnel-related encapsulation control flags.

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

