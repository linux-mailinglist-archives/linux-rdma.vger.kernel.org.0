Return-Path: <linux-rdma+bounces-17236-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APEQCK9/oGnukQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17236-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 18:15:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE551AC096
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 18:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEA6E30D570E
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 16:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7384418D8;
	Thu, 26 Feb 2026 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hpdrq1Nt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0445E4D2EDE
	for <linux-rdma@vger.kernel.org>; Thu, 26 Feb 2026 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122015; cv=none; b=YM1Xxbd2RvR0B9NxxVM7d/O63xT46qjIpiL6ewQVnPqs303aqF6Qi1QyeOgeK0r+KVSlDp8pZaVCcGLaNuWGtJs1QgrgDM+yCtf9a1ddxYkgB0JiKLq5esixTx/AUuILe9lEfpRviLtVpD9R42sicmQvlwzChqEElytfTTYUDAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122015; c=relaxed/simple;
	bh=A4tWT1hm0CbORTFvLg6E+s9hkdoc8l+rIbpXcma3jYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f2IVuRoWTNVMTzJ4enlXvHeQ2MBnZIbbmwIVPM/2o0SFiK+EymKZLjY/5ynmMy8PPFSPI1NOwGj0k1d240xFWrB6ByJs4eVgPBZEjTgHs03ITxQ61zqfcPtroeAxSFHyU2llqDmfFC2O/mXR6Uap/vAYqywEtxD26J5PIlCMj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hpdrq1Nt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4182FC116C6;
	Thu, 26 Feb 2026 16:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772122014;
	bh=A4tWT1hm0CbORTFvLg6E+s9hkdoc8l+rIbpXcma3jYw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hpdrq1NtHVdKsZWWPyQwRtlZ90lofyRu4/TsoVtoO3wYpo7kdyhSYzhnxW1+BsFNv
	 mZqc2kyv9BlZk9jdB7gvjImieKrfil5IkL6VyXO/MhuH7ytrxYY9AHo2DC/ZNUQ9OI
	 VUyKhsRsgOLQR7bl4t68x5TMxOlcadSd2BYXjrZIFZxdvxKGOpu8xAapuqykLo5/xR
	 XOIcGHcsXonrpMYcK8BJQBSx/RwiqIQwWIqtCS5BUt0tIWUz2SRAQuX/qsZUbQ5pVa
	 xjrPEqZn2G7M/l3TgPyRzvkfHGvLM9sYi5Nnmwnr7HjkFEjy51ffCDO3HvvtC2wiOj
	 rJ8bVMJqGlmYg==
Message-ID: <8ed32ed9-3931-4b2b-8f44-0023aa998b5c@kernel.org>
Date: Thu, 26 Feb 2026 09:06:53 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/rxe: Add network namespace support
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Leon Romanovsky <leon@kernel.org>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20260225172622.7589-1-dsahern@kernel.org>
 <e87e7871-d35e-4b91-a00f-1491ac5b6dab@linux.dev>
 <18ecbd06-baac-43ee-a455-6b34c716fdfe@kernel.org>
 <88b82e8b-40da-46cf-bb41-2c346bd28c70@linux.dev>
 <20260226064755.GA12611@unreal>
 <cfad2c5c-23a9-4034-ad71-2c1ea21ff597@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <cfad2c5c-23a9-4034-ad71-2c1ea21ff597@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17236-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBE551AC096
X-Rspamd-Action: no action

On 2/26/26 8:51 AM, Zhu Yanjun wrote:
> Thanks a lot for your reply.  I’ve already submitted a similar patch
> earlier.

In Jan 2021, rxe had no network namespace support. We fixed that and
carried a patch (in stealth mode at the time).

In Feb 2026, rxe in Linus' master and rdma-next do not have network
namespace support. I sent our well tested solution that works out of the
box with behavior similar to how init_net works.

If you are interested in your design approach getting merged, then make
it happen for 7.0-next. If you do not have the time to commit to it now,
then step back and let this patch move forward. That is how Linux works
- post ready-to-merge patches, not intentions.


