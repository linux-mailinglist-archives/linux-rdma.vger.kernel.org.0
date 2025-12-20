Return-Path: <linux-rdma+bounces-15117-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23066CD2F82
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Dec 2025 14:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B74C300DB8F
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Dec 2025 13:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9F521A457;
	Sat, 20 Dec 2025 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="Zyr/FCeG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B481A9B24;
	Sat, 20 Dec 2025 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766235921; cv=none; b=e2qH4zg0im/Ps2PqmWzFWr6r2cLZB1GN52NOCQKYjVZty5t5cPAk5b9KaFdoIl1G6fVDmDiyzQX3USoZ/HJEjm1ZOHV2AJcq3JHiIgsgtfg/bLuz+E7TGR9GV119121E1Eb8+9eZ+seokWMA8fQBB/ADcRJltYy2lhCMyd9uU0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766235921; c=relaxed/simple;
	bh=EKSxeKKeUxtFjBveaxit83pYY3iBq1Mr71XoeIU99JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LzgPXUnamZltCMMQ5uIs4iHxgUiXPyv70SwWchG0MKZMEdlDO2zonynU1Db0QL9V8a/vJmLbSTemGqoxVOVdCA9YSj2ZpBPdxBENclvKcmfVO1+uzgXsQig/02PK6Zfa+dWENXVN+tMU1fIHdk0UZxZqx+hekHLr9rJHf9mLNUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=Zyr/FCeG; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=ltw4PPLkBzZKBc0c2B7F4qJxiL52Rko3SLEkYnUCIag=; b=Zyr/FCeGqUDQY0rOUkdL0TNMbk
	y7v9w3FlfUhYxDV+gz8YbVxX53Jm6mYZx8/ZNaUiBDgaLiW/8EV+Zay3Tu2YzeqObFGfRPdTVJBgw
	QEJZsQVUeYriaewVbLXk+65bsIcrKObQtgIiZiIISO9zFX0tiSerunn72NxwPcu5V8KuUBgyjXF9/
	tDBko8dYP8lCpH64XziA+QNvHAPFMHPRdOC+ICgImyDBbyKAL6FZg5yDvy4SxbJD3HAS4WU+yKxJg
	LcVeXbBE8ZKJO+3eOLdbfq2+f+fc70vDBukzhWfbGIWiMnzur2+MS6COn1nxTdRWoDRiDVqa+PTZB
	Sr5pLL9dLgVCO838EpRIz69TIfWiEe06JtSrDae39ekWla8Tap88uA5fRZwZ3kwxUT6ju54ybE3Fb
	canlOvR5ozF4TWyKLaIuSwnmzCID8SWve1kvx+CMSbE5sgbLGOf0gXr6cI4CwhXapRwhFQ9YItvjv
	eq8QHddopsDsn4EI6mTzQGLg;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vWwe3-001TtL-2G;
	Sat, 20 Dec 2025 13:05:15 +0000
Message-ID: <01cd3f5a-2976-45ad-8a2d-32b3e39c6317@samba.org>
Date: Sat, 20 Dec 2025 14:05:15 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/rxe: let rxe_reclassify_recv_socket() call
 sk_owner_put()
To: Zhu Yanjun <yanjun.zhu@linux.dev>, linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, netdev@vger.kernel.org,
 linux-cifs@vger.kernel.org
References: <20251219140408.2300163-1-metze@samba.org>
 <9ccc0635-7c0e-4a18-8469-9c5b6d9b268f@linux.dev>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <9ccc0635-7c0e-4a18-8469-9c5b6d9b268f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.12.25 um 04:51 schrieb Zhu Yanjun:
> 在 2025/12/19 6:04, Stefan Metzmacher 写道:
>> On kernels build with CONFIG_PROVE_LOCKING, CONFIG_MODULES
>> and CONFIG_DEBUG_LOCK_ALLOC 'rmmod rdma_rxe' is no longer
>> possible.
>>
>> For the global recv sockets rxe_net_exit() is where we
>> call rxe_release_udp_tunnel-> udp_tunnel_sock_release(),
>> which means the sockets are destroyed before 'rmmod rdma_rxe'
>> finishes, so there's no need to protect against
>> rxe_recv_slock_key and rxe_recv_sk_key disappearing
>> while the sockets are still alive.
>>
>> Fixes: 80a85a771deb ("RDMA/rxe: reclassify sockets in order to avoid false positives from lockdep")
>> Cc: Zhu Yanjun <zyjzyj2000@gmail.com>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: Leon Romanovsky <leon@kernel.org>
>> Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> Cc: linux-rdma@vger.kernel.org
>> Cc: netdev@vger.kernel.org
>> Cc: linux-cifs@vger.kernel.org
>> Signed-off-by: Stefan Metzmacher <metze@samba.org>
> 
> Thanks a lot. IIRC, there is a similar commit for SIW driver. Thus, I am not sure if there is a similar problem in SIW driver or not.

I don't think so, siw and the other place in rxe  are attached to specific connections
and there the reference is ok and needed.

The problem was only related to the two global sockets with the lifetime
the rdma_rxe is loaded.

metze

