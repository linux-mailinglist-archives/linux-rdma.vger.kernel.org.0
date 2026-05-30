Return-Path: <linux-rdma+bounces-21537-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFqhFc2tGmqU7QgAu9opvQ
	(envelope-from <linux-rdma+bounces-21537-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2026 11:28:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFC460BDB7
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2026 11:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16FC03011BC8
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2026 09:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476D6381B01;
	Sat, 30 May 2026 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEiIiZ8g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B311A399342
	for <linux-rdma@vger.kernel.org>; Sat, 30 May 2026 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780133310; cv=none; b=Dy6WznTnzXnwd9/6fcCH8sQcIZt3rqv0bPTRiZ8kbDKPxWFufH4kkjxyS4+ivzY6k0EbPAxq2tDhzSQ0R3gg0ZwMtfdR3+KvnW3zi/hRBrOMuXjZa6cuWbGF9WaWiOh5Y1Qse1ndlJHzLaGj9tqHoFREa27BtgsRYbzm/XVWMPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780133310; c=relaxed/simple;
	bh=Axu2q9OiQlW7NrUR5/tN+MxVX+YXj5nOsIeGUL7II+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmVBL0F10IKiPY+ecvGQQ9IF9qeiFU2fR2dpcC2OWD3j9+77689EtUToarn9LymQILOhF4YnpjY4gc6X+fjcqXg2bbFJzumj5wcEbGHmhrS73nRSYM3+bUCqeH306IrjylwGt5fzhUuySM1aoiiJqO/kx6l6w5Zle7Yue7TDFxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEiIiZ8g; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49039a8851fso89384995e9.2
        for <linux-rdma@vger.kernel.org>; Sat, 30 May 2026 02:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780133307; x=1780738107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVGWNyN/0YK3gFgYNwL3zKk91DjUbWVPzRQNZkauQoA=;
        b=aEiIiZ8g0hy0yB/O+bDn7Qw4lOfN43CRMMIOFofGOKWKSLeutjNpsZecxl1PpF6dGq
         XUr13spfzUEBtwv04kv+5AwqvczVql4/rFzglnoFDWJiGLSUG9LMAKcVLLAPgsa/kU9t
         zluLvPFhdhGFedsiuZiYQhWDrDHb6RPbzb+RIt1hN1uaQ4DaUE4c2eOFaiBq+m6UXu62
         vqjV0taBTZDPRazx4yOVz0wossMHj2fIJMBAmv/mXMjZ1WgM365BRb+3Zxn9aYNcpHXd
         0Zcst7R72wcLfComJvvpx853k9BfRth+OczB8+jks6+1OILp1F2ltb7V2sIbLEMprH8k
         Me6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780133307; x=1780738107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AVGWNyN/0YK3gFgYNwL3zKk91DjUbWVPzRQNZkauQoA=;
        b=kwubp3SaYIWJexq1MEWTP0m7xhePE9pHYT7GNdlPY8gp7alwCgL6zuQYUwfNNtzcjW
         DFfbpS+yR8IgBkwR+OA+7yXbJwdeoMCTKJ1bleUmOuT6vS4K2JrUuA0PDPCOrVa/jhFI
         YZBUyYoznX5/fBBU/KJne+E65h5lbjgUzNBwyk0yMjG9xXSqvVbOJMHFT9PResADemu6
         xSMECu//0eF0783c+9sb9wwSMf39pfed8WirlAfrnmmLoPU3NWi0LbDTC/UbWfqyQh5p
         p9GYS9nreZf8IgHmHbaPH4AMYyqrJOrYINTFDEs7NzKIPczepryUoDKEAiisqs6YhxTQ
         6E5w==
X-Forwarded-Encrypted: i=1; AFNElJ9PXaASId9F1H3HJhaS5HiwHhovANj4STBR1ceMOzHD/dGY+LmoXHO3YZQbGkvTyObkwFy2P5xha9Kn@vger.kernel.org
X-Gm-Message-State: AOJu0YyEj1xyXA4gnSXkKocLdoxfXgvwcP1xYolAVCHuIuXVaRQj7itR
	lFC3g8OcNY85oMDuV2dyjpYN4vnwshtFfVajJ+9b5wzcW6ivifby2HI3
X-Gm-Gg: Acq92OFGHRfWAvhw8a4KUqP2CBmOOu3EbW4KCrSfWwzdq2qVDhDWrL7RGISEF+ITsgR
	gy8zp1sK9kKiOdXkhcToIuNJ3BJ4WsoyDIOL2tMnnFXdcWUK7rCKX5htuRq+l8ec5ah7SdHIoY9
	ak1XKDunPvS05Zcsn5L0J1tio1nLVsywuFEgKQxDgB1g5OTCDhXSH6eLL1yMhEQXyoxqSHSK1Rt
	lqBAcymXFXnuJCNKes14gTgJLUfeqy+Yr3K+A7Skflh8d4kyPcv1pHS5JVEpuxpvM5KvDlY7Dsm
	KvStlWZWq+6WOdGhwfeL40WtxaiuUKYQ5l9OyAVsXiJctcp64CAvvGiOz4TN1z0KbvtItYqnQxv
	25zu9MIAVx5Y+cBme96FkEfnd+tSIJYz40ScCiFvVuZDFgzJ3ttP821Z1lt54/c4Ru/Ws5xlAhI
	B+aXB9fOQB/+cqPOr7ttWa+55qvmzRIv38j+OO1oAzQAVFWEGZYS/Ow4mZqe7nVgijtrsP5N0=
X-Received: by 2002:a05:600c:3147:b0:48f:e230:80a3 with SMTP id 5b1f17b1804b1-490a297304bmr47960185e9.33.1780133306950;
        Sat, 30 May 2026 02:28:26 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c09acd3sm30659185e9.4.2026.05.30.02.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 02:28:26 -0700 (PDT)
Date: Sat, 30 May 2026 10:28:24 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>,
 kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org, Mark Bloch
 <mbloch@nvidia.com>, netdev@vger.kernel.org, Saeed Mahameed
 <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 06/11] selftests: Fix arm64 IO barriers to match
 kernel
Message-ID: <20260530102824.65ceb098@pumpkin>
In-Reply-To: <20260529224442.11d7320d@pumpkin>
References: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
	<6-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
	<ahiFxtmspbETiqWw@google.com>
	<20260529134947.GA128816@nvidia.com>
	<20260529175516.06d5788f@pumpkin>
	<20260529192933.GD3195266@nvidia.com>
	<20260529224442.11d7320d@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21537-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ABFC460BDB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 22:44:42 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> On Fri, 29 May 2026 16:29:34 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Fri, May 29, 2026 at 05:55:16PM +0100, David Laight wrote:  
...
> > I can't say, this is copied from the kernel and Will made it:
> > 
> >     arm64: io: Ensure calls to delay routines are ordered against prior readX()
> >     
> >     A relatively standard idiom for ensuring that a pair of MMIO writes to a
> >     device arrive at that device with a specified minimum delay between them
> >     is as follows:
> >     
> >             writel_relaxed(42, dev_base + CTL1);
> >             readl(dev_base + CTL1);
> >             udelay(10);
> >             writel_relaxed(42, dev_base + CTL2);
> >     
> >     the intention being that the read-back from the device will push the
> >     prior write to CTL1, and the udelay will hold up the write to CTL1 until
> >     at least 10us have elapsed.
> >     
> >     Unfortunately, on arm64 where the underlying delay loop is implemented
> >     as a read of the architected counter, the CPU does not guarantee
> >     ordering from the readl() to the delay loop and therefore the delay loop
> >     could in theory be speculated and not provide the desired interval
> >     between the two writes.
> >     
> >     Fix this in a similar manner to PowerPC by introducing a dummy control
> >     dependency on the output of readX() which, combined with the ISB in the
> >     read of the architected counter, guarantees that a subsequent delay loop
> >     can not be executed until the readX() has returned its result.  
> 
> Hmmm...
> 
> Ok so there is some subtlety with the read of the counter that might
> make it all work.
> 
> It is better to make the delay loop have a data dependency on the result
> of the readl().
> Something like:
> 	u32 z = 0;
> 	OPTIMIZER_HIDE_VAR(z);
> 	writel_relaxed(42, dev_base + CTL1);
> 	udelay(10 + (z & readl(dev_base + CTL1)));
> 	writel_relaxed(42, dev_base + CTL2);
> That avoids the potentially mispredicted branch and only adds instructions
> when a delay follows.
> That sequence is safe for all cpu and doesn't cost much for cpu (like x86)
> where it (probably) isn't needed (maybe unless you patch the scale for udelay
> into the code so there are no memory reads, just code).
> 
> Probably best refactored as udelay_depends(10, readl(dev_base + CTL1)).
> Or maybe udelay_after().

Sleeping on it, all the code can be put in udelay().
You just need a read memory barrier, followed by a memory read (of anywhere
'hot') and then use a data dependency (as above) from the second read
into the delay loop.

-- David


