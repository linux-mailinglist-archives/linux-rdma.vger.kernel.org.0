Return-Path: <linux-rdma+bounces-17810-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHrGEPEhr2n6OQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17810-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 20:39:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A4024035A
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 20:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E57A6303B5EC
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 19:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E350740FDA2;
	Mon,  9 Mar 2026 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSTi12/0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A476040F8DA;
	Mon,  9 Mar 2026 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085067; cv=none; b=G9CTl8abRhupgX5ytok9QSETMXTsinXpVXBeMQk1IzPabLuNxfdOHWWRR3DtytyXAdDumOYUdKor73mvtbpvJFnqVMMHv/3EnOP07zytReAQGrV+A1THZJmunvQfc9hf+gZ5W5ypjKPEG149p8LOP5gHrBgpcWbm5PiPhK06xHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085067; c=relaxed/simple;
	bh=iqRPPESmr5ty0IqgTxtuvw8gCwstpiBh82LmVqQKKlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkjNsA9M6jMBoEU8K5B+qJ8lUUKnwMgFCEBD67i+G61Na3sEmOqdda9lBSxvaxJyDmO2Z6B03odeWrcwt6exPKpJ17bq9mdZfYRg8qXEG3zHYQtG3RNmIcMzG+FL+qCiflWMS6+pgwgR1iKSPWUrcXTPXc5J6lHu7184JNmW2VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSTi12/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64D0C2BC9E;
	Mon,  9 Mar 2026 19:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773085067;
	bh=iqRPPESmr5ty0IqgTxtuvw8gCwstpiBh82LmVqQKKlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LSTi12/0XRAIm2dZo6dE1RifZqrZTZiFCzV8g4gyB658hP0KNO7WoYb8gNEm0igIZ
	 PG9p9RJyosEim4EBtXyajWEI+2cmREX4r/rrYWtRsJo2+qTprMC/MVVsY1MRVHX/1b
	 QLAqrVlZmQHUxKLPBIlyv0q90eWdRlbmoKvQ1NyeMTJbcSO54l0h7qgAPZN1pEg7P0
	 uUZB1qH4+AoIIZcosAJ2PQxfXSlbmeQIheLHpzMhssG+6/DbBF7zUgRpZKNlLb754W
	 2hmLKbTgiiX5EhhoHQlOGNgK7RBGLkXZ29BJ4o/NIe8wgbbPsu1uQHrMUAGbpCvV/e
	 LSp2Da3pfDeaw==
Date: Mon, 9 Mar 2026 21:37:43 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>
Subject: Re: [PATCH 0/3] Firmware LSM hook
Message-ID: <20260309193743.GZ12611@unreal>
References: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
 <CAHC9VhTR9CsBgxRCAHXm5T2NZ5tr+XfmA--zkt=udmk9hPRuZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTR9CsBgxRCAHXm5T2NZ5tr+XfmA--zkt=udmk9hPRuZQ@mail.gmail.com>
X-Rspamd-Queue-Id: 03A4024035A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17810-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,paul-moore.com:url]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 02:32:39PM -0400, Paul Moore wrote:
> On Mon, Mar 9, 2026 at 7:15 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > From Chiara:
> >
> > This patch set introduces a new LSM hook to validate firmware commands
> > triggered by userspace before they are submitted to the device. The hook
> > runs after the command buffer is constructed, right before it is sent
> > to firmware.
> >
> > The goal is to allow a security module to allow or deny a given command
> > before it is submitted to firmware. BPF LSM can attach to this hook
> > to implement such policies. This allows fine-grained policies for different
> > firmware commands.
> >
> > In this series, the new hook is called from RDMA uverbs and from the fwctl
> > subsystem. Both the uverbs and fwctl interfaces use ioctl, so an obvious
> > candidate would seem to be the file_ioctl hook. However, the userspace
> > attributes used to build the firmware command buffer are copied from
> > userspace (copy_from_user()) deep in the driver, depending on various
> > conditions. As a result, file_ioctl does not have the information required
> > to make a policy decision.
> >
> > This newly introduced hook provides the command buffer together with relevant
> > metadata (device, command class, and a class-specific device identifier), so
> > security modules can distinguish between different command classes and devices.
> >
> > The hook can be used by other drivers that submit firmware commands via a command
> > buffer.
> 
> Hi Leon,
> 
> At the link below, you'll find guidance on submitting new LSM hooks.
> Please take a look and let me know if you have any questions.
> 
> https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm-hooks

I assume that you are referring to this part:
 * New LSM hooks must demonstrate their usefulness by providing a meaningful
   implementation for at least one in-kernel LSM. The goal is to demonstrate
   the purpose and expected semantics of the hooks. Out of tree kernel code,
   and pass through implementations, such as the BPF LSM, are not eligible
   for LSM hook reference implementations.

The point is that we are not inspecting a kernel call, but the FW mailbox,
which has very little meaning to the kernel. From the kernel's perspective,
all relevant checks have already been performed, but the existing capability
granularity does not allow us to distinguish between FW_CMD1 and FW_CMD2.

Here we propose a generic interface that can be applied to all FWCTL
devices without out-of-tree kernel code at all.

Thanks

> 
> (If you lose the link, or simply for future reference, you can find it
> in the "SECURITY SUBSYSTEM" MAINTAINERS entry.)
> 
> -- 
> paul-moore.com
> 

