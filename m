Return-Path: <linux-rdma+bounces-19734-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIuFIc4P8mkwngEAu9opvQ
	(envelope-from <linux-rdma+bounces-19734-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 16:03:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9AB4954B1
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 16:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C08230EF876
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 13:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEBC37A4BA;
	Wed, 29 Apr 2026 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SVWZxGpq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F151385507
	for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2026 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471083; cv=none; b=QsWffLK+51n4i4vXlk6KxHIKZG4ai9tL6LS/VRrgpntg4DO1mXMcZUJB+S/lx+tpoIqdT73H6+kanhshFyLvWA6sHlVdboVhPX8GfoNhjJADAS4EjUF3VQbjc9rAA+Bc0JoxmIEB4DLqxA+fZbmtjtQ1G+jzqjGltcnX7ztqj3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471083; c=relaxed/simple;
	bh=o4O58H0ZGeMt4V3P8tjk3QfVGS9Kf3VFG+pAg5emku4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFxb9kl2Za2sg3Hr4T5WKn74HAsfzaQVZv33BZWgP0asRxKKH6BTfP1mZNZL+RlPA1Jx0IPv+rYfzRXvf/Lm3aoIr4W+z+6sysNky1uZVVKe3hCWETY+PflB7ylZsCaZhSD2hd4m1XiP0RnW30ve1HvuMDf28wn0OZO6MbkiDMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SVWZxGpq; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8eae9229110so130754785a.1
        for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2026 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777471078; x=1778075878; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J6W1snzMfnG2kF8GHWkTZnhxIV7cNBkRRyyxoL8MT8M=;
        b=SVWZxGpqR3DJlrYfXH442PQicZd9yIjAmDRRCuCRQbvMZqMPIG1RhmX7nLcwxZ8eZA
         R2Lif7IKicCBVrVz6q3g6dOyPJ9g/HVZXsVuC/tzm/coXBf07JFSGI+t4OKfe7BMPgIa
         1+yVfhIeopml7CTObzE64ppoLQQwAjN/WqZgHr0RkURSgXvqQobTNhqAnQmYVnJwXTbT
         Af4wNLvHZwf9NLm+8t1Z8oimtzqDggiA7ucXaR1nXqB1BHbMCc3Olh2BMZQaqX7tYvq6
         oa9GF7WSV9S1f2MzNfDw2dCCXM+NlYNEtXswVNTyDVBaWOZweDchykLM3YMnQ9/7BCEA
         f1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471078; x=1778075878;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6W1snzMfnG2kF8GHWkTZnhxIV7cNBkRRyyxoL8MT8M=;
        b=bleUkGIt1g9RJzFFJShoKQ1qYyZAelLRfpbeStLxU9Kkvt8AXNCGturF9QMxNx7C8U
         s1Nlj1uGXlVQgS57sB36lNqw8qgigM6x/aGFDfH4Li/aTVwflYOkAkkP8P1tpMUlwnhv
         7qlh6HNB4jNCvC7h8KkuMwiQut1raz/bP7ZdZACBope7dhJhLsXk1pdhNAwj4k3xoITF
         jU4IC3KdQ6WYI0mBalLifi7KhsFP3fwV/x9DRolzoC9mJxOKCE6GKREgfH7MYfC2dBcn
         nMk+lIFcMYXme1bwIpSi1QgcprwjDc1BkFyqD1kZBSAeEYNCZvPMAkR9NR/TjzK6c+Zb
         7mwg==
X-Forwarded-Encrypted: i=1; AFNElJ/o03cduvj5muA3b57R24/7LvArimpD4xF+3Ynh8U/u/1Zpb4TQvbSxLigoUtGCc1Ck/PclWfC+ef1J@vger.kernel.org
X-Gm-Message-State: AOJu0YydMC8J7kdxIYiibe4fmwQyJGpDVcThfYcnHYtjnEEKCjQ18mgk
	jbcwK42tvyA9W9Omo5Z6L0twmqbvmOlCoUzAYVaV783qGsaa/nxoKi2Ievk3uRUdbts=
X-Gm-Gg: AeBDiesjYADIB6+ZZR7KGTTqff9TGVJW0yJf/2ZHS9tKx2BntbdBWb5MoBWBxUOJxZa
	tX7fyKTQ7/79V+Lw5tGEOV46F/MYWZR9vLyTua7gOvtJYqayIVI4B5KBAa58JeBrvy9q/MPwKPv
	SR96erwqW9TTKdCqO0zxmxXfu/Bv0QtE6Gl3ubUhDp+CwV4/0aiTKOrKSHbOHSwufrOsZrfJuxA
	EVWA1GoQeuz9h4kbtNKAMC1FKy+5NLKBoSd205CKi9O5cSeFqrB1r9ygobSQ/ZWZTA8T946Rp/B
	bLH1+aA45fyzaSIMvvP4CIvVyZn6j1KOfaoW/8Sgzy0k5Guk6I+sdhIE0vnZqfDvskXJ4FsKcGt
	ITNEePYK5Kw5kmPFecjUOpZSNkUc4780k/jdB8gVhzft9l2IgGzoXl4uCgg0x5KeNjTXq0MqLXu
	7wMRtvWwn2T3A6JyAhLg1CNM8ngfmaOzOXteYg19DdDNFUyVT8DJCiYsrHXv0DR6KZIdra6ChoP
	IaxsZ23IoeOeCe0
X-Received: by 2002:a05:620a:414a:b0:8cf:dd63:fae7 with SMTP id af79cd13be357-8f7d8f0e191mr1047242485a.34.1777471078348;
        Wed, 29 Apr 2026 06:57:58 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f939a93224sm206336285a.0.2026.04.29.06.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:57:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wI5QL-000000007E8-1fxt;
	Wed, 29 Apr 2026 10:57:57 -0300
Date: Wed, 29 Apr 2026 10:57:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Boone, Max" <mboone@akamai.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] net/mlx5: check whether VFs are assigned before
 disabling SR-IOV
Message-ID: <20260429135757.GO849557@ziepe.ca>
References: <20260428-mlx5-sriov-in-use-check-v1-1-c7b9e18c99a8@akamai.com>
 <20260429123833.GM849557@ziepe.ca>
 <DB8CFC33-0929-40F5-86CA-39D1CD84D415@akamai.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB8CFC33-0929-40F5-86CA-39D1CD84D415@akamai.com>
X-Rspamd-Queue-Id: 0F9AB4954B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-19734-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[]

On Wed, Apr 29, 2026 at 01:29:57PM +0000, Boone, Max wrote:

> > On Tue, Apr 28, 2026 at 08:04:14PM +0200, Max Boone via B4 Relay wrote:
> >> From: Max Boone <mboone@akamai.com>
> >> 
> >> When MLX5 cards are passed through to a VM, disabling SR-IOV by
> >> setting the sriov_numvfs to 0 will render the machine unstable.
> > 
> > What? How does that happen?
> 
> Unstable is maybe a bit confusing phrasing on my part, “locks up”
> might be a better description?
> 
> In short:
> - Enable by setting sriov_numvfs to positive
> - vfio-pci passthrough to QEMU (or other process)
> - Disable by setting sriov_numvfs to zero
> - QEMU processes freeze, shell that was writing to sysfs freezes
> - SIGKILL doesn’t seem to have much effect, shutdown never completes

I'm not surprised, but this is definately a bug in VFIO that should be
researched.

And is it right that pci_vfs_assigned() doesn't fix this anyhow since
only Xen activates it?

> Python script to reproduce without QEMU:
> - https://github.com/akamaxb/repro-vfio-sriov-removal/blob/main/vfio-sriov-bind.py
> 
> Does:
>   1. Require sriov_numvfs == 0 on the PF (report any existing users and exit if not)
>   2. Add one SR-IOV VF
>   3. Bind the VF to vfio-pci via driver_override + drivers_probe
>   4. Open VFIO container + group, get device fd
>   5. Create a KVM VM (registers an MMU notifier — required to trigger the race)
>   6. Hold and wait for user input
> 
> To trigger the bug while the script is waiting, in another terminal:
>     echo 0 > /sys/bus/pci/devices/<pf_device>/sriov_numvfs
> 
> On the vfio-pci end of it all, it prints these two lines to dmesg before it hangs:
> - https://elixir.bootlin.com/linux/v7.0.1/source/drivers/vfio/pci/vfio_pci_core.c#L1826

The VFIO protocol requires userspace to implement this event channel
and immediately close the VFIO FD when the driver is removed. The vfio
driver unbind sleeps and waits for this. It should not hang the
userspace vfio user, but you will get an unkillable process writing to
the sriov_numvfs sysfs waiting on this.

The above logging shows your test program doesn't implement the
protocol so I don't expect it to work.

vfio currently does not support a kernel lead isolation of its fds.

> - https://elixir.bootlin.com/linux/v7.0.1/source/drivers/vfio/vfio_main.c#L421

And this is the above driver remove is waiting for the FD to close in
response to the event.

qemu is supposed to implement the event protocol, so I don't have a
guess how you get a qemu to become unkillable - that seems to be the
primary bug here. Would be good to know what system call qemu is stuck
inside.

I'd modify your test to implement the event protocol, setup an event
fd to receive an interrupt on VFIO_PCI_REQ_IRQ_INDEX then trigger the
teardown sequence when the eventfd triggers. That would clean out the
basic flow.

Jason

