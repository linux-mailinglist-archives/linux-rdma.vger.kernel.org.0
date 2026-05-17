Return-Path: <linux-rdma+bounces-20810-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LnXbBrJYCWp7WAQAu9opvQ
	(envelope-from <linux-rdma+bounces-20810-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 07:57:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 590DA55F5B2
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 07:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CBF6300CE61
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 05:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBB130F55F;
	Sun, 17 May 2026 05:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="rjQP7vfp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616E7F9C0
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 05:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778997421; cv=none; b=XKTc+yTpuC/1HPXa+qofprOFeJP/e0KF2gU47vYgGZ14yHUjwF0s6ZVY8gJ2cRJmBIN4jClx9n/1eDUPzXTToeopA+ZQG4jPsM+fTrH6jCoeOnmsiK5HNpTCCntkvjclsCLTtNkgmEtdbwGaURQJJaXIi4Lqxy69Xr+jBzS18rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778997421; c=relaxed/simple;
	bh=z5iKw7knCqvhosp6SwEAcvPLpVQIuOAThPus+wqKUcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlEbXbnT64JJy8GN0+waB+COH6rEBWQw2dCp3ADq4aZWOWnsYnmsQU1DJNNit+6XbW/lJ+YLgDv1es/RTzqXGOph+EHYHYzI3IzxSelKhvVUfgNuAxeJ4TIc9+M5J4QEj+PXjt4+oBz7cnDJt9llvxfl4zY6jQaFLic2/XXQgqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=rjQP7vfp; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so922063f8f.2
        for <linux-rdma@vger.kernel.org>; Sat, 16 May 2026 22:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778997415; x=1779602215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTNBKqww0E/Ss/YTsCa1J9TnzG+c7rqJLWELtZ0os+o=;
        b=rjQP7vfp81LRBcgcg3qj0tN4f/X+kv8LRUyMfhMwHHNQDJ/Teu3ah2ds53M5u4wksY
         yTqTi262ofncjybAlDLZTqth4bYEXlxApUR0F0jWYA8UpZ3WBuS5Pz5F/asWDrrDtCjN
         /NVtE73TXz3RkqQ8SKJGYi5R90oYd4H8EsEc1jc8Tuy1X1QrMy53epdELDgKuhWqfwBx
         Gs2HOY55/nJI9Af3qQe009VIyfekNu/0SiGA/kq2jMbEFeuWv1YwawZoNbER1fC5vGia
         bZdxGPD1ihtUcvZfHTb9YPg8ehP98fGKEwuVGHQF6TOzQ3Tkc7rqWXFfIrDMM6NWpLpD
         Vm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778997415; x=1779602215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTNBKqww0E/Ss/YTsCa1J9TnzG+c7rqJLWELtZ0os+o=;
        b=oHep0O8CSFkIzIzfJtqKD76sA+umr6F4kN5Sf5VnEnT15RqEHA9hiKOmdk19/N+TSu
         8dSkONVo11G/fK2p8MtDbQjfE/9ij3fUxN48eexHeLF7k1DBOiLkxQV6l2DrXSxCpEs6
         FWvkEWBVfWzsAvs0OlPilkdmQR22I9w850RkTLqKCKxEppAQPfdizVF/3zO7w3iBVZfQ
         NhjAxHKbEDRY9ZuAuxhmq2hlyhxj30s47PYLy1ER2Iz2b1zzZXPWe/vsoF3O/fks0xVi
         i5+gY8YXLlef1Ozk0YvKxY0+Co1Vq7X3i3zTsTtC2gd44AZ7Px6/q/aSgFB0nD88iYjD
         J5Yw==
X-Forwarded-Encrypted: i=1; AFNElJ/RRa32o+N6wNuF8tM/cSx73Z/J7Pnh2QJ+0ufNCUOpM40UnQbzsO6AgUsKZK5kIjr/XXBpceQ47P4i@vger.kernel.org
X-Gm-Message-State: AOJu0YxGgan+XJX41bITOX7AwvDPT8pgxhSzk4hQbuNY/qAXpAnKLDdF
	H301oIHea9jJb/bhpsV+7IoKH1jnZgO5/pOMO76DK+r3xCNlMr+UbHuGG+vkThK9id4=
X-Gm-Gg: Acq92OHgaGButsQXN824hgf7LyNPOnY7Ru+rk56z6GSpK0/GR/fOS8LfTVvwKyst2Cb
	ZqhYlzTI1fO1JX3yGhUW19PGT6DkLEBXg2Z/8NafJ9q/FYfRaDAZvRrlObYOSBq504Gy2a8wayt
	KhI+FfhIMrAN4jo9sMkisZAldzgzdZiUXmDyKcbkiwqo723a90bkYkfYx3a6IV4tbyL/fUECbLa
	wV5H8SAX6FyxVuqPfa2JF8Ak9OyYWcGFJSpw/6J1DAgQ42ua9D1wxVwJZZAu6CZxB34b1pQn9AL
	lkQfnI3/oY9VNu294fRu6wu7qOuEuP9JIswbzHt9X5ZzOnDiKHug+LS3lSVUgHRMEW7XkGg7ZXC
	xlBBWQ0xETiLXIrUvYqvwBKDYiftVkuRM3Yg8Ib92Uav3EF/9LFGIWeN0Yv9PeaKdiQELOPs6Hn
	ZhG5EOheVusL3k5x3xXi5iCukW4Kicy+5dr896h5Q47WUYmNuBXnZqVQ==
X-Received: by 2002:a5d:588f:0:b0:43d:77e1:6a69 with SMTP id ffacd0b85a97d-45e5c5a4dbdmr14164907f8f.38.1778997415401;
        Sat, 16 May 2026 22:56:55 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:7168:3127:200b:5d86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768c4fsm27443706f8f.8.2026.05.16.22.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 22:56:54 -0700 (PDT)
Date: Sun, 17 May 2026 07:56:52 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, 
	patches@lists.linux.dev, Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: Re: [PATCH 5/6] RDMA/core: Move ucaps into ib_uverbs_support.ko
Message-ID: <aglX-m1INAy_MfTh@FV6GYCPJ69>
References: <0-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
 <5-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
X-Rspamd-Queue-Id: 590DA55F5B2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20810-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Wed, May 13, 2026 at 07:33:27PM +0200, jgg@nvidia.com wrote:
>mlx5 uses these move them into the support module from ib_uverbs.ko.
>
>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

This breaks the build:

  drivers/infiniband/core/ucaps.c:59:3: error: non-void function 'ib_cleanup_ucaps' should return a value [-Wreturn-mismatch]
     59 |                 return;
        |                 ^

The signature was changed from void to int and a "return 0;" was added
at the tail, but the early return inside the !ucaps_class_is_registered
branch was missed:

	static int ib_cleanup_ucaps(void)
	{
		mutex_lock(&ucaps_mutex);
		if (!ucaps_class_is_registered) {
			mutex_unlock(&ucaps_mutex);
			return;             /* <-- needs to be "return 0;" */
		}

[..]


>@@ -265,3 +266,6 @@ int ib_get_ucaps(int *fds, int fd_count, uint64_t *idx_mask)
> 	mutex_unlock(&ucaps_mutex);
> 	return ret;
> }
>+EXPORT_SYMBOL_NS_GPL(ib_get_ucaps, "rdma_core");
>+
>+module_init(ib_cleanup_ucaps);

Shouldn't this be module_exit()?

[..]

