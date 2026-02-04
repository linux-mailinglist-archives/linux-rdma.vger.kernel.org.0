Return-Path: <linux-rdma+bounces-16511-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPooLMsXg2mKhgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16511-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 10:56:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70949E4282
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 10:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F814306A283
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 09:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8183C3B961D;
	Wed,  4 Feb 2026 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ADSZ13Tu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137723B95F0
	for <linux-rdma@vger.kernel.org>; Wed,  4 Feb 2026 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770198863; cv=none; b=UG5yn+W4KWxi14SLhVLBXDGzjXVHTjflrrNn4Z5cTZ2OBfFuai/6lrfUSf9wnKRzU2W8jw57SELeJ7svtoE3yAx4mf+vaVcljXfACkEPWBmiXE77AxxvWDJBc2l+4Y1LhNeV1JnwGwKxjTObwwwofEoJVl1L4a/5PRbSARgPonw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770198863; c=relaxed/simple;
	bh=MtgvvUHudAHUoDthEeowTLlr8O4jZULD3ouQz+tl1Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKP+WFTr/VzhX5AdxZoFZerhS0vS0QuRqc17LSWGaFj3a+B7ow5c9QyMyIuWXbQLCCLx3ia6le1f676QN30Iz6FSqbaN+AKhBOTY/WQnTWAdCscZAdFzfpnFCFGTtBuAZHzMbd76VHk0694i38vLgS0Idqx5A0eYCN9/NWwv4ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ADSZ13Tu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-481188b7760so4514705e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 04 Feb 2026 01:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770198861; x=1770803661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NoPrl11NJOoOl9fCyTn7J0ZLB+yKB8/qzDtRhM6Zldk=;
        b=ADSZ13TuFigg6DdgnYxCUxAK9vC2m8Z7etMJZXpOJ8NOTwWa91n8ek7uc843pOMgzT
         4yeptXjwjwyorqcOlk6igbGm3yzx/NCICCM4/0QG+KNZyPHlictJG2h39pl4Ie4YqGDP
         Ef4wacnvyUMz0/5Dzw2al8JSUnAvcIRqJfpldIeWDueKeI004rca5ikzrQTNEOXH52Ya
         MChY14y5QhL+B1dtjWaR4c44fNHPz48DjsmBEm9gPPaMtuh525fwQlxUNdWka03e8DAu
         IhYX1AaseAiYdlU/65u7/nSHBQKEsN1Vl8kL9eA32nmPSD/EKNENm+528mAGkoeGgMna
         TFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770198861; x=1770803661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoPrl11NJOoOl9fCyTn7J0ZLB+yKB8/qzDtRhM6Zldk=;
        b=WrkgNR/jtHxOb7I00fGiLk7Iik8De8AuPu+WDejpHR+zDYDaqptzjWICn1Dt4pQ3eS
         keI/HjHe+pxWk2ycFva8DHDrDmuPmdjfV1uVU5GDhp7/K+fLdVBhywW6eAAgvL2TV5NV
         Qs2i9G8kO5qLJuQu8mZM/ZKZbvyXJCl76xBZPkw9w4vDjt6Ub9Vw+sV1UAdcdAEG8YiW
         51jyg2bwtqhVq5FDNXOvz4JwTopJpV4a65A5RsrZLe7ujvehkJCrJT+opPuMA1IAZtgF
         4miHo9HshRPGfde+3pVKbEFFst2DPabmR/xH4L15JB35FvGQAFTnRUnZe6hlkFTyx3nI
         O1/g==
X-Forwarded-Encrypted: i=1; AJvYcCXnzWujqimqf+Ed2vCG9xEjTeG5NQcIbFLE/9Adl8VUkwO4rkptXz4NBRLiSPDa7vida+9wo3qe0oTq@vger.kernel.org
X-Gm-Message-State: AOJu0YwJa79LRwUBlhw5Qe7bQmTr9kHkZYmASJt4clWjMaMBBaat2pJd
	7jUEGCY0knNgDkmtqe3SR5JI+hjDU6CkqwOqpe9cJGPZl5TeF/39j3IjYSqDOgVzZYc=
X-Gm-Gg: AZuq6aJ/tRu2vr7855Y4icwNfTu9yvgmjOt5+1JghczemgJ3V3dULL+IXVDjxvlk6Q7
	jwXHc5zw2efMjkYfcKARpm8e9zv6DFw2rlmvSfzVq9AliSUGJ/aAuMeqYRuWDuElNdj+XyV21nt
	PsKuwNU0ui+OzSZDhbCRYnbI1paab4QIg2VpPSomiVj2OdxaNvqUsZuKkR1y9n67V8ue3N4Rxg5
	1pbqCSNuclJxu4em9Ea7jlbVloQN4BqVGbmK+GOL/jaiZwmnTYtHpJ1+IQhHFwXVtwxc8gj7u0w
	MOiAfNl1gtNyOhiy242liHKbnIniVU2hDwlZhVpmk5FaOlxaQiqkQ5QMyftWgiWshbA0woFSI1v
	JHyd4dmd/v2aZ1FCDx8UOvNooQ9DEAnyP9YTSuRGNZ0jSGwbr22qxUzNqYDRwNkJPuYdJFRcH0G
	NJird7AHXVk33gg+eVGfI=
X-Received: by 2002:a05:600c:5250:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-4830e925fdemr32086895e9.7.1770198861330;
        Wed, 04 Feb 2026 01:54:21 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48310919211sm47113715e9.11.2026.02.04.01.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 01:54:20 -0800 (PST)
Date: Wed, 4 Feb 2026 10:54:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Or Har-Toov <ohartoov@nvidia.com>
Subject: Re: [PATCH net-next 3/5] netdevsim: Add devlink port resource
 registration
Message-ID: <fpvwwvsregusmmqqejkvr6tluurlkr3cj42dbwzkhqpb3ezps5@x3jmpkhmd2i5>
References: <20260203071033.1709445-1-tariqt@nvidia.com>
 <20260203071033.1709445-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203071033.1709445-4-tariqt@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16511-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,nvidia.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 70949E4282
X-Rspamd-Action: no action

Tue, Feb 03, 2026 at 08:10:31AM +0100, tariqt@nvidia.com wrote:
>From: Or Har-Toov <ohartoov@nvidia.com>
>
>Register port-level resources for netdevsim ports to enable testing
>of the port resource infrastructure.
>
>Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
>Reviewed-by: Shay Drori <shayd@nvidia.com>
>Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>---
> drivers/net/netdevsim/dev.c       | 22 +++++++++++++++++++++-
> drivers/net/netdevsim/netdevsim.h |  4 ++++
> 2 files changed, 25 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>index dfd571b22107..ebda1b961664 100644
>--- a/drivers/net/netdevsim/dev.c
>+++ b/drivers/net/netdevsim/dev.c
>@@ -1486,9 +1486,24 @@ static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_typ
> 	if (err)
> 		goto err_port_free;
> 
>+	if (nsim_dev_port_is_pf(nsim_dev_port)) {
>+		u64 parent_id = DEVLINK_RESOURCE_ID_PARENT_TOP;
>+		struct devlink_resource_size_params params = {
>+			.size_max = 100,
>+			.size_granularity = 1,
>+			.unit = DEVLINK_RESOURCE_UNIT_ENTRY
>+		};
>+
>+		err = devl_port_resource_register(devlink_port, "max_sfs", 20,

Two questions:
1) Why you have "max_sfs" here and "max_SFs" in mlx5? Just curious
2) Why you don't have the name made up completely instead, like "test1"
   or something? It does not really affect anything in netdevsim.



>+						  NSIM_PORT_RESOURCE_MAX_SFS,
>+						  parent_id, &params);
>+		if (err)
>+			goto err_dl_port_unregister;
>+	}
>+
> 	err = nsim_dev_port_debugfs_init(nsim_dev, nsim_dev_port);
> 	if (err)
>-		goto err_dl_port_unregister;
>+		goto err_port_resource_unregister;
> 
> 	nsim_dev_port->ns = nsim_create(nsim_dev, nsim_dev_port, perm_addr);
> 	if (IS_ERR(nsim_dev_port->ns)) {
>@@ -1511,6 +1526,9 @@ static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_typ
> 	nsim_destroy(nsim_dev_port->ns);
> err_port_debugfs_exit:
> 	nsim_dev_port_debugfs_exit(nsim_dev_port);
>+err_port_resource_unregister:
>+	if (nsim_dev_port_is_pf(nsim_dev_port))
>+		devl_port_resources_unregister(devlink_port);
> err_dl_port_unregister:
> 	devl_port_unregister(devlink_port);
> err_port_free:
>@@ -1527,6 +1545,8 @@ static void __nsim_dev_port_del(struct nsim_dev_port *nsim_dev_port)
> 		devl_rate_leaf_destroy(&nsim_dev_port->devlink_port);
> 	nsim_destroy(nsim_dev_port->ns);
> 	nsim_dev_port_debugfs_exit(nsim_dev_port);
>+	if (nsim_dev_port_is_pf(nsim_dev_port))
>+		devl_port_resources_unregister(devlink_port);
> 	devl_port_unregister(devlink_port);
> 	kfree(nsim_dev_port);
> }
>diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>index f767fc8a7505..11ea1a52924a 100644
>--- a/drivers/net/netdevsim/netdevsim.h
>+++ b/drivers/net/netdevsim/netdevsim.h
>@@ -224,6 +224,10 @@ enum nsim_resource_id {
> 	NSIM_RESOURCE_NEXTHOPS,
> };
> 
>+enum nsim_port_resource_id {
>+	NSIM_PORT_RESOURCE_MAX_SFS = 1,
>+};
>+
> struct nsim_dev_health {
> 	struct devlink_health_reporter *empty_reporter;
> 	struct devlink_health_reporter *dummy_reporter;
>-- 
>2.40.1
>

