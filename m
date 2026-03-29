Return-Path: <linux-rdma+bounces-18773-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGsrLPuNyWm1zAUAu9opvQ
	(envelope-from <linux-rdma+bounces-18773-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 22:39:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D61354057
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 22:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B1BA304EA8A
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 20:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A514038228B;
	Sun, 29 Mar 2026 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uW21tUvs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D121EF36E;
	Sun, 29 Mar 2026 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774816517; cv=none; b=ikdJbGgX+ArCOEkK7LZOGMPXDEOcZYAdhTESuCQowpIRY3WCWABSCoy4R7iLgXlJQC4hEhsiZww3UezUzBGlq91c+MNtx9jb5QBF6QmcFXNHXUrgaoajDuqSIz7a5r7Lz5OJGCsiAvdAlpPVg2baBUvcfRL98NZ1+k8fmSt4Qcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774816517; c=relaxed/simple;
	bh=VGwNR6sz5MSPMcw8TPumnldbdd9XU/HxE2Wx7OPTeGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkDHjk94JJGP0k6PRocHmeBGEjV+TOhvcS18ZnqppCp1rhn0jEPhCjRAcQo74WGwnEpn6Gas4Ei5H0dCFnxPU84Ljq+ItM94BxoGO4X91UXk0oCTm2x3Ww1UYziVMnnRLTudG0tCjVWjEY+mfgIExMTeB15mWkYlrHuqs9xq+c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uW21tUvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69548C116C6;
	Sun, 29 Mar 2026 20:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774816517;
	bh=VGwNR6sz5MSPMcw8TPumnldbdd9XU/HxE2Wx7OPTeGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uW21tUvsVfUret2vm/UP9IFsLkZcX9iLr6rhvkIWtpMd9UfY2JTWcHb1cTxKtjpW9
	 vNVauw8wA9wc1iYZRG94M3cdGo+ZSGNMLYT2i0w+QM3RVBeWE9xzJxI+8nJ9rfLRW+
	 G7b7b0hDU6+tfGOvQuMBVLmFaHwdMmZyj5ev1QFYqQo+Wg2U94l+LB1mwyir6dlNI9
	 3aYRO2UtPvr9uYh6Zqdkoxy2f6+fgISPanP16oDCqbqqsywwKxmBx6d3S/hdwOHp6x
	 PBSnwkxQfiRadm7qAPDdGQBUiuLUSH+CaziM5rHPOeEAqmmXv/L+rnlMVWI0FRxxOC
	 fPdfAz8oJgRCg==
From: Jakub Kicinski <kuba@kernel.org>
To: lixiasong1@huawei.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yuehaibing@huawei.com,
	zhangchangzhong@huawei.com,
	weiyongjun1@huawei.com
Subject: Re: [PATCH net 2/2] net/smc: fix potential UAF in smc_pnet_add_ib for smcd device
Date: Sun, 29 Mar 2026 13:35:06 -0700
Message-ID: <20260329203506.2816841-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325110352.3833570-3-lixiasong1@huawei.com>
References: <20260325110352.3833570-3-lixiasong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18773-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50D61354057
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/smc: fix potential UAF in smc_pnet_add_ib for smcd device

This commit fixes a potential use-after-free when accessing an smcd device
in smc_pnet_add_ib(). It resolves the issue by combining the lookup and
apply operations into a single function that holds the smcd_dev_list.mutex
for the duration of both operations.

> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index 91c0b1c473b2..a1603740167b 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c

[ ... ]

> @@ -351,23 +357,39 @@ static bool smc_pnet_find_ib_apply(char *ib_name, u8 ib_port, char *pnet_name)
>  }
>  
>  /* Find an smcd device by a given name. The device might not exist. */
> -static struct smcd_dev *smc_pnet_find_smcd(char *smcd_name)
> +static struct smcd_dev *__smc_pnet_find_smcd(char *smcd_name)
>  {
>  	struct smcd_dev *smcd_dev;
>  
> -	mutex_lock(&smcd_dev_list.mutex);
>  	list_for_each_entry(smcd_dev, &smcd_dev_list.list, list) {
>  		if (!strncmp(dev_name(&smcd_dev->dibs->dev), smcd_name,
>  			     IB_DEVICE_NAME_MAX - 1) ||
>  		    (smcd_dev->dibs->dev.parent &&
>  		     !strncmp(dev_name(smcd_dev->dibs->dev.parent), smcd_name,
>  			      IB_DEVICE_NAME_MAX - 1)))
> -			goto out;
> +			return smcd_dev;
> +	}
> +	return NULL;
> +}
> +
> +/* Find an smcd device by name and apply pnetid under lock. */
> +static bool smc_pnet_find_smcd_apply(char *smcd_name, char *pnet_name)
> +{
> +	struct smcd_dev *smcd_dev;
> +	bool rc = true;
> +
> +	mutex_lock(&smcd_dev_list.mutex);
> +	smcd_dev = __smc_pnet_find_smcd(smcd_name);
> +	if (smcd_dev) {
> +		if (!__smc_pnet_apply_smcd(smcd_dev, pnet_name))

While this prevents the use-after-free in smc_pnet_add_ib() by expanding the
mutex coverage, does the same vulnerability pattern still exist in the
connection handshake paths?

Neither struct smcd_dev nor struct smc_ib_device appear to use reference
counting. During a connection handshake, functions like
smc_pnet_find_ism_resource() and _smc_pnet_find_roce_by_pnetid() find a
device under the mutex, store the raw pointer (e.g., into ini->ism_dev[0]),
and immediately release the mutex.

If a concurrent hot-unplug event triggers smcd_unregister_dev() or
smc_ib_remove_dev() while the handshake process is accessing the device
without holding a lock or reference, could it lead to another use-after-free?

Would a more complete fix require introducing reference counting for both
device structures to ensure they remain valid while pointed to by the
handshake structures?

> +			rc = false;
> +		else
> +			pr_warn_ratelimited("smc: smcd device %s applied user defined pnetid %.16s\n",
> +					    dev_name(&smcd_dev->dibs->dev),
> +					    smcd_dev->pnetid);
>  	}
> -	smcd_dev = NULL;
> -out:
>  	mutex_unlock(&smcd_dev_list.mutex);
> -	return smcd_dev;
> +	return rc;
>  }

