Return-Path: <linux-rdma+bounces-18370-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHC3JktJu2kliQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18370-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 01:54:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE002C43BA
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 01:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70A3830B770B
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 00:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1C926A1AC;
	Thu, 19 Mar 2026 00:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwPSYSk/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F72257ACF;
	Thu, 19 Mar 2026 00:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881626; cv=none; b=IlMwbYmkuYU51H2G124aYZ4PnrTaoHz160MsQBW9v3gbrIq4Bei+LTF6NbNaLRa2AOCu1kY48Y6Er0nhmKNN06gM0jtYLIUk7OJVxwcru1nAkDySyhU7SKk0r13msK0KGbo4h6AzGeqcj0rH01fHM6zJYa79P4aW1+0Aq1awlDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881626; c=relaxed/simple;
	bh=u9QalOV1V5ov4JnuagFUKqF3SQqeysCweWbwxjCwLv8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oo/kUUB7E/I2fS9rpXStBQssNfxpB0LEr6KPT2bQEyu7fcgKAHvYKZv7NqCaoiIyj6AD8IsMvZ2CXNT9sMYj08EkdVfm8Ru7gjUxmyWuFPxojizVZ4zH2YZ5alqcsVf/EMNDyPbPab7+138hAKowonUbY7/dOxIscQIAxck0gXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwPSYSk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E98C19421;
	Thu, 19 Mar 2026 00:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773881626;
	bh=u9QalOV1V5ov4JnuagFUKqF3SQqeysCweWbwxjCwLv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZwPSYSk/QSD0K0qVxXpiF3sP8NbwFj4vwaFFXQPDYAndlrrdAcQbzdIc9Pf1/uUKV
	 pUqF0SYvxi2bhpCIl9+8ONBUwNoh8vmY6lgHitsVr5KXIzlJVfFyUWLZgijhBJ5wfQ
	 SwEVuGFdJhrNnaj7RisqngizH69ucFxGfhJocemi9hMxjXK4T5Qy3z3X5VRmQrO/5N
	 ptubNHMq5PGBX0ZzinkMyQOZbqbx4JJ92Pw/zqcH+4/ycVNBMxhUm/BNANIXwBkeJ7
	 Gt2+ZGs7c62QselK56V8RpxV3zQwX7UPoH1OfCV+rWNPqhKCddUUpLDgNhlZvVGnZ5
	 Itk4KCpPetqMA==
Date: Wed, 18 Mar 2026 17:53:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: shirazsaleem@microsoft.com, kotaranov@microsoft.com, pabeni@redhat.com,
 haiyangz@microsoft.com, kys@microsoft.com, edumazet@google.com,
 davem@davemloft.net, decui@microsoft.com, wei.liu@kernel.org,
 longli@microsoft.com, jgg@ziepe.ca, leon@kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net/mana: Fix auxiliary device double-delete
 race
Message-ID: <20260318175344.7ed206d7@kernel.org>
In-Reply-To: <20260317143943.1329271-1-kotaranov@linux.microsoft.com>
References: <20260317143943.1329271-1-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18370-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3BE002C43BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 07:39:43 -0700 Konstantin Taranov wrote:
> Make remove_adev() safe to call concurrently from the service reset
> and PCI eject paths by using xchg() to atomically claim the adev
> pointer. This prevents double auxiliary_device_delete/uninit when
> hv_eject_device_work races with the service reset workqueue.

Really seems like you should add proper locking to these paths
instead. Are the accesses to is_suspended, rdma_teardown etc
really safe as is?

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 9017e806e..9ae5f01d8 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -3410,14 +3410,18 @@ static void adev_release(struct device *dev)
>  
>  static void remove_adev(struct gdma_dev *gd)
>  {
> -	struct auxiliary_device *adev = gd->adev;
> -	int id = adev->id;
> +	struct auxiliary_device *adev = xchg(&gd->adev, NULL);

nit: avoid falling functions with side effects as variable init

> +	int id;
> +
> +	if (!adev)
> +		return;

