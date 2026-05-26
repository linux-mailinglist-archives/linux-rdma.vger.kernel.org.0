Return-Path: <linux-rdma+bounces-21273-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPV/CoBPFWpMUQcAu9opvQ
	(envelope-from <linux-rdma+bounces-21273-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 09:45:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3145D1D9C
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 09:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75DC130125EB
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 07:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACC53CC315;
	Tue, 26 May 2026 07:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="B62lJTWu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91463CBE7D
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781499; cv=none; b=lqsJb2v5saHK3G8bax/yf+S44r+807esPOmR47CIlB6rqcvrD8ZRj2xF4G+0dEPVm1aXVGmpaO9e1LIRfbXFevv9c6rYQ3EVZuRNOxIS+e5sbXKaVgOZKr0r+16gYPYa5nvhic4z1oP6FdtPzhwnZuVWvdfU4S+bhEoEbDQDY3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781499; c=relaxed/simple;
	bh=HOIrj5sgGXq3c+j31QIdduCco4yj8GtAwZ85IMokvdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0ANZMoBDQUzHG03C1ornVWMaFe9cyobkucU4eyBI6hS+P31ZhCKelgZFLAgEGhgTApPE6A/3DBGiYeGyPOdDCv8mvmeu7bA98P9TgMErTmeDID4u1mzTYEzYw9yPhSza80/9/D5lBhwFnZLtafaYBklzJ3EEb8haZvv+B46DZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=B62lJTWu; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ea19f412aso2855793f8f.3
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 00:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779781496; x=1780386296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=meQXJPGH/eSRep/h9BO6zFwy/e970wDOwhGQTQCudGw=;
        b=B62lJTWuXw+j/rjl9d2vdf1PQlB9LhWCYyJSGP0OmkcmwHP1rhVO+nWHNWBvbNCtYU
         v9A6vmaZFI40/kj4kFl5egR8L8rB583INKQej7us+23x7TyhHxOrGdjUJrkT8SOqpDoI
         4yN4bCFicyf1jr7wOwCt3Gj2RE2peSDCn0wU8a7xy3QpkschwG0StKQW81ho/GMtVqQf
         4DpI38GAl/ezkfJ6FcaOvzC3K2O7S2MYOHYnqq3VNvTsoM3O9A14YhucDRkSJmCQl6Ie
         ExNH4kCGxdcZBqfmfrKzGCWJ570e/WpI2SPUGv5VnJ1t1gl0FtMJsgWRc+EV2bGhkq1Y
         vAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779781496; x=1780386296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meQXJPGH/eSRep/h9BO6zFwy/e970wDOwhGQTQCudGw=;
        b=qotnsrbNs6QRIOvvnnZKzvF8r8d4/eaMO4XkNjcfysppzDS44Eh5+8CtbzACw8lyQU
         Edxu9Xq/cRFY0Cg3xyv34O+FJnaVSPIfO31Abs8dLcduHzFUVgMDLdsqtYyceqNuTF/u
         nJfSoowrZZ8sQh6tHknwYxnAYWvbuTutl3dbsr0eEAm2UwWvSRj0dICIrksqTeEcdQz1
         INGovSBVNxfL8frEDOviwEn1AaMwdGFasSI22K0ixrt8Yz0dHiOpo/hLlYrdONhfmbRX
         zxj+1zSQf0sMeEKvdrjwCueqU3eYqRxVkWH9iYTjSbUfU3yQK/E7L9l/NfuchIAlS33S
         J/yA==
X-Forwarded-Encrypted: i=1; AFNElJ/O6EdCAG9wl+D/WNuhAwHi/Pi9bDB1ME2OPB5a1Lm29V62cHRXc8ZBwbZ324Wy8DSYt39Cs63EPzSs@vger.kernel.org
X-Gm-Message-State: AOJu0YzTnBjhzGngcKmoXxZXQ+AZghXpp6IRqcVxt1JHSsSP2i+tVG8C
	VU9y2QWX7+94Wox1/OzHr9C1ba0cVTc701Mj/lyJR7AhJRoOQUr4B5zO/+lQv2Pu4D4=
X-Gm-Gg: Acq92OGQB/j7YkIcvh6RPP1/GuJt1y+u7wViyu0HAuIyP66ajqZug5cD/Fpx8T6cmd3
	K/1W+mUf3OgH79mFwDU4v0yCu46VzHOAwPLXA+QkgwZGRvoqU3epNdywiy8Aiz7vOA4Y40kJ38D
	eaAKbRqO45xbINaa79lQF9b3ARLh/1nwzfyzPjOd213VTIzMAO483JAcPJvyJoUNbD8vTBq0vzS
	ve4KrwnCbjiND3noSdnBPASY5mlS7Z9a/1DdnKx+rwzQ8quoqp3kAsn2mj0XBPB+/1ZEiM0m6Du
	HITptANLpmuLwF9mTMqGkKTi54Qv04F80x/Rmr2D+p/iq8ElFjDEu+DyuQZ+9riqHMoppFaKiRy
	1dMm84SaSfdqL073mH4RRPCiLioYLv/N9RiLEDRnndVPkgQZriyyRjZ8V0Yz+Fcl8uCaCR/tDTq
	ig9814Bhg2RdhaxgQQzAIZJTYyMSUpm4AY
X-Received: by 2002:a05:6000:1a87:b0:43f:dd91:b022 with SMTP id ffacd0b85a97d-45eb38d7d0emr29705304f8f.35.1779781496236;
        Tue, 26 May 2026 00:44:56 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6cd151asm32668426f8f.13.2026.05.26.00.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 00:44:55 -0700 (PDT)
Date: Tue, 26 May 2026 09:44:52 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Mark Bloch <mbloch@nvidia.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>, 
	Li RongQing <lirongqing@baidu.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Shay Drori <shayd@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next 3/3] net/mlx5: Apply devlink default eswitch
 mode during init
Message-ID: <ahVPASuh4BZGOfx0@FV6GYCPJ69>
References: <20260521072434.362624-1-tariqt@nvidia.com>
 <20260521072434.362624-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521072434.362624-4-tariqt@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	TAGGED_FROM(0.00)[bounces-21273-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[38];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 7C3145D1D9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thu, May 21, 2026 at 09:24:34AM +0200, tariqt@nvidia.com wrote:
>From: Mark Bloch <mbloch@nvidia.com>
>
>Apply devlink default eswitch mode for mlx5 devices after successful
>device initialization while holding the devlink instance lock.
>
>At this point the devlink instance is registered and the mlx5 devlink
>operations are available, so the default eswitch mode can be applied to
>the matching PCI devlink handle.
>
>Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>Reviewed-by: Shay Drori <shayd@nvidia.com>
>Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>---
> drivers/net/ethernet/mellanox/mlx5/core/main.c | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)
>
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>index 0c6e4efe38c8..4528097f3d84 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>@@ -1391,6 +1391,21 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
> 	mlx5_free_bfreg(dev, &dev->priv.bfreg);
> }
> 
>+static void mlx5_devl_apply_default_esw_mode(struct mlx5_core_dev *dev)
>+{
>+	struct devlink *devlink = priv_to_devlink(dev);
>+	int err;
>+
>+	if (!MLX5_ESWITCH_MANAGER(dev))
>+		return;
>+
>+	devl_assert_locked(devlink);
>+	err = devl_apply_default_esw_mode(devlink);
>+	if (err)
>+		mlx5_core_warn(dev, "Couldn't apply default eswitch mode, err %d\n",
>+			       err);
>+}
>+
> int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
> {
> 	bool light_probe = mlx5_dev_is_lightweight(dev);
>@@ -1437,6 +1452,7 @@ int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
> 		mlx5_core_err(dev, "mlx5_hwmon_dev_register failed with error code %d\n", err);
> 
> 	mutex_unlock(&dev->intf_state_mutex);
>+	mlx5_devl_apply_default_esw_mode(dev);

I wonder how we can make this work for all. I mean, other driver would
silently ignore this command like arg, right? Any idea how to make all
drivers follow the arg from very beginning?


> 	return 0;
> 
> err_register:
>@@ -1538,6 +1554,7 @@ int mlx5_load_one_devl_locked(struct mlx5_core_dev *dev, bool recovery)
> 		goto err_attach;
> 
> 	mutex_unlock(&dev->intf_state_mutex);
>+	mlx5_devl_apply_default_esw_mode(dev);
> 	return 0;
> 
> err_attach:
>-- 
>2.44.0
>

