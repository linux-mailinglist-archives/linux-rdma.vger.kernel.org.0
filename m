Return-Path: <linux-rdma+bounces-20038-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FDl2DkuZ+mmqQAMAu9opvQ
	(envelope-from <linux-rdma+bounces-20038-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 03:28:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F40B4D5429
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 03:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F953301C51D
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 01:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88F325F7B9;
	Wed,  6 May 2026 01:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnrukEmN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC68246BBA;
	Wed,  6 May 2026 01:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778030915; cv=none; b=RZQqT3kmQ3gY/WcMfCKE7AVp4HR7+Wfa7FwcaRglgA/EN+RDt4w+A7cO5CsPjrtX0i+gP+8q0Fja6HTN5XVhuONnGyOgLpjiDoF6zMC9QgVmBouwUfH+EBM9/YziKU86dWp2ZdVhrUKqMTxd582HqsdSsS3P6/nSPvck6hb3vUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778030915; c=relaxed/simple;
	bh=VQUC57fO+osALstZz2wYTzkFvOH4NzOFCjxh0tFqSH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sedzp/0uI8vUBL1PFvfwY5QZ4wW24NAVnA70offCw61OMNS3cuLF/sUtefEZUwP1aOwONfC4sdQdMOIfVFF4QxBt64P9US/lLK+fzbLF/iSxZ5hcZMpIt/mzXEGUJCVwELAyJQITZjwx2j9edFoMVqz+zlyk8hCBjq2IdoBm+E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnrukEmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BCCC2BCB4;
	Wed,  6 May 2026 01:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778030915;
	bh=VQUC57fO+osALstZz2wYTzkFvOH4NzOFCjxh0tFqSH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cnrukEmN8j1iWqLkR+9ueP62bKvElyimsh21fTiETV2QYzH+iVIZCeciTFRQuIFWJ
	 9s5n2j9dWEUgtuLsph5i2SjZm4akfNnBlcCrWwCLjfLxyk07kEf543aGT5e+s4SJTU
	 lCyMnDq9uKtUxr9A0e9OW/imHPjNkM+Thj8PgjYbaz0awST1Ew2Tz1JHNCPJQjK16x
	 UBLDsWwQPHPHAEhxreaSpwhQCCDQbJ5pg/l/7UCbqwmcNy4GtzcMxpjK168nZ4M1Gq
	 4Llu15xtBmC19wCcqkwxPWQda1VQd91NaI+eYSyOZtwyUkIEbONruwEe41BzDaHox0
	 XBHN2bXrAda9A==
From: Jakub Kicinski <kuba@kernel.org>
To: kotaranov@linux.microsoft.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	shirazsaleem@microsoft.com,
	kotaranov@microsoft.com,
	pabeni@redhat.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	edumazet@google.com,
	davem@davemloft.net,
	decui@microsoft.com,
	wei.liu@kernel.org,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v3] net/mana: Fix auxiliary device double-delete race
Date: Tue,  5 May 2026 18:28:33 -0700
Message-ID: <20260506012833.1607543-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504142704.159035-1-kotaranov@linux.microsoft.com>
References: <20260504142704.159035-1-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5F40B4D5429
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20038-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/mana: Fix auxiliary device double-delete race

This commit modifies remove_adev() to use xchg() to atomically claim the
auxiliary device pointer. This change is intended to prevent a double-free
race between the PCI eject path and the service reset workqueue.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index a654b3699c4c5..dd4f4215ab434 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -3465,14 +3465,19 @@ static void adev_release(struct device *dev)
>  
>  static void remove_adev(struct gdma_dev *gd)
>  {
> -	struct auxiliary_device *adev = gd->adev;
> -	int id = adev->id;
> +	struct auxiliary_device *adev;
> +	int id;
> +
> +	adev = xchg(&gd->adev, NULL);
> +	if (!adev)
> +		return;

Does this xchg() operation act as an ad-hoc synchronization gate rather
than properly synchronizing the concurrent teardown paths?

While using xchg() ensures the adev pointer itself is only freed once, the
rest of the teardown sequence appears to remain unprotected. If the PCI
remove path and the service reset workqueue run concurrently, one thread
might successfully claim and process the adev, causing the other thread to
return early from remove_adev().

However, the thread returning early will then continue its execution into
the rest of mana_remove() or mana_rdma_remove(). This could allow the first
thread to proceed and free critical structures:

mana_remove() {
    ...
    remove_adev(gd);
    ...
    free_netdev(ndev);
    ...
    kfree(ac);
}

while the second thread concurrently iterates and accesses those same
structures.

Could this concurrent execution lead to a use-after-free on ndev or ac?
Should the teardown sequence be synchronized using a proper lock, such as
the device lock, or by synchronously canceling the service work in the
remove path, instead of relying on an atomic operation?

[ ... ]
-- 
pw-bot: cr

