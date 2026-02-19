Return-Path: <linux-rdma+bounces-17027-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFq6BQ2kl2mf3wIAu9opvQ
	(envelope-from <linux-rdma+bounces-17027-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 01:00:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B94163C0E
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 01:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF7183009380
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 23:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CC032B9A1;
	Thu, 19 Feb 2026 23:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oU3BrviT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272892F4A15;
	Thu, 19 Feb 2026 23:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771545591; cv=none; b=bP2YXFVTb3v67wT1dQWd3BC5kRmHSEihoAsF6JQiQvdA4Jp46qh1g2wQ8excGaMNHOHdMPmOL4GRYQhvF0NtqVMCUJdRobwtDdLUIS1lH8MtAS8mTxv0n4c0T3iqn3EvupG6QlHJBJpk32cYhso8XTVxjht74e390cH/sR0irZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771545591; c=relaxed/simple;
	bh=ZMzYxL94z8q0TJyvNhpiuIgpQ1hKazr0tfXAbomaJd8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=PGgbC9p3CfsS1sX5SyEx0K6C3iooqDZbhDSUCmtmWv/c0sH3unF2sg6RGGf/IhCzhU2WuFl6f1LiHydjQO1G7gFuV0eJaF6/o8/PdEW8nF3mAdVwqwA+bd7JY1fEpTj0fF5ixA6lz6Eq4LJ6VjN/gk5umMxANjFZVoCVnM2DLa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oU3BrviT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3BBC4CEF7;
	Thu, 19 Feb 2026 23:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771545590;
	bh=ZMzYxL94z8q0TJyvNhpiuIgpQ1hKazr0tfXAbomaJd8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=oU3BrviTxQgpucmePP3fA6Qy04sAxAocBTXaGBNbp12HervoLWm+VmBJ5hNq4fzdp
	 dFTDstOoHfXpG9EcQsOBajZN5jYCs56hg535NMq1Z+l95v9+9v5DzsxKn+13hSpW8R
	 7H8I/BKIMsOYmm/8TskUgBgsAxKAvetR9Y0rFWli9JXE9tdVsEJuQ56zNauG3qbA/1
	 TvThSUrlro3U/abDVryk99nkNQZFBvaM918dHud/DPKT/jgcwiDOAJB1NaPpRWVNp4
	 u9Eri/MFKhkKHYx724FyDD5F3d/KvYwlgPU2E8oQSABPQ/iCkI5q1ZN0vOdIJAjgGb
	 wrB7Ulm2y9aBg==
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Feb 2026 00:59:45 +0100
Message-Id: <DGJCHYS3SKIQ.1TIHQCMEOCRC@kernel.org>
Subject: Re: [PATCH V2] driver core: auxiliary bus: Fix sysfs creation on
 bind
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Saeed Mahameed" <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Mark Bloch" <mbloch@nvidia.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, "Gal Pressman" <gal@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, "Amir Tzin" <amirtz@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>
To: "Tariq Toukan" <tariqt@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260219210435.1769394-1-tariqt@nvidia.com>
In-Reply-To: <20260219210435.1769394-1-tariqt@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17027-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40B94163C0E
X-Rspamd-Action: no action

On Thu Feb 19, 2026 at 10:04 PM CET, Tariq Toukan wrote:
> +/**
> + * auxiliary_device_sysfs_irq_dir_init - initialize the IRQ sysfs direct=
ory
> + * @auxdev: auxiliary bus device to initialize the sysfs directory.
> + *
> + * This function should be called by drivers to initialize the IRQ direc=
tory
> + * before adding any IRQ sysfs entries. The driver is responsible for en=
suring
> + * this function is called only once and for handling any concurrency co=
ntrol
> + * if needed.
> + *
> + * Drivers must call auxiliary_device_sysfs_irq_dir_destroy() to clean u=
p when
> + * done.
> + *
> + * Return: zero on success or an error code on failure.
> + */
> +int auxiliary_device_sysfs_irq_dir_init(struct auxiliary_device *auxdev)
>  {
> -	int ret =3D 0;
> -
> -	guard(mutex)(&auxdev->sysfs.lock);
> -	if (auxdev->sysfs.irq_dir_exists)
> -		return 0;
> +	int ret;
> =20
> -	ret =3D devm_device_add_group(&auxdev->dev, &auxiliary_irqs_group);
> +	ret =3D sysfs_create_group(&auxdev->dev.kobj, &auxiliary_irqs_group);
>  	if (ret)
>  		return ret;
> =20
> -	auxdev->sysfs.irq_dir_exists =3D true;
>  	xa_init(&auxdev->sysfs.irqs);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_dir_init);
> +
> +/**
> + * auxiliary_device_sysfs_irq_dir_destroy - destroy the IRQ sysfs direct=
ory
> + * @auxdev: auxiliary bus device to destroy the sysfs directory.
> + *
> + * This function should be called by drivers to clean up the IRQ directo=
ry
> + * after all IRQ sysfs entries have been removed. The driver is responsi=
ble
> + * for ensuring all IRQs are removed before calling this function.
> + */
> +void auxiliary_device_sysfs_irq_dir_destroy(struct auxiliary_device *aux=
dev)
> +{
> +	xa_destroy(&auxdev->sysfs.irqs);
> +	sysfs_remove_group(&auxdev->dev.kobj, &auxiliary_irqs_group);
> +}
> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_dir_destroy);
> =20
>  /**
>   * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
> @@ -45,7 +70,8 @@ static int auxiliary_irq_dir_prepare(struct auxiliary_d=
evice *auxdev)
>   * @irq: The associated interrupt number.
>   *
>   * This function should be called after auxiliary device have successful=
ly
> - * received the irq.
> + * received the irq. The driver must call auxiliary_device_sysfs_irq_dir=
_init()
> + * before calling this function for the first time.

I'm not convinced by this approach. This adds two new sources of bugs for
drivers.

  1. Drivers can now forget to call auxiliary_device_sysfs_irq_dir_init()
     *before* auxiliary_device_sysfs_irq_add().

  2. Drivers can forget to call auxiliary_device_sysfs_irq_dir_destroy().

Instead, I suggest to keep the current approach and just replace
devm_device_add_group() with devm_auxiliary_device_add_group(), which in it=
s
devres callback additionally clears auxdev->sysfs.irq_dir_exists.

In terms of the auxdev->sysfs.lock, I think this can still be removed, as i=
t
wasn't needed in the first place.

auxiliary_device_sysfs_irq_add() must only be called from a scope where the
auxiliary device is guaranteed to be bound, so there can't be a concurrent
unbind.

There may only be multiple concurrent calls to auxiliary_device_sysfs_irq_a=
dd()
itself, and in this case irq_dir_exists can just be an atomic.

Yes, we're still stuck with an atomic for irq_dir_exists, but the driver AP=
I
remains much simpler and less error prone.

- Danilo

