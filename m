Return-Path: <linux-rdma+bounces-17463-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A1RDlsEqGkRnQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17463-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 11:07:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D451FE19A
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 11:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 478D93028C05
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 10:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72725372691;
	Wed,  4 Mar 2026 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="IT101ZPF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002D63976AA
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772618788; cv=none; b=k8EDzPl5A/43nF8MFORV3ZsS4kB6EkPJIggJCyl67Y6K3EMYxNAPNHyCFJcfmZUWHI6jQfTqtDZFv6aMwd0uM4Qr+x2ns14RzZODnPsRS/3R84qqIZowzuwdfXvfRGu0KmktXV1oDUvEIwFjv7nhC59CuEo7PxVzz27Ak2eqJbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772618788; c=relaxed/simple;
	bh=ZeXpubh4PPtG9yGE/1RyC93eJnLALxoHAHjlztipjqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCS3jo2VZFqEvzCKQ1fI8Tp1AVnNdiHreus5SKOC6PyM8SEGf2reg2ZURsowaK6koCR7jwy7mvssHTJB99EuLWUQuGYt4dAHK3qy75YJinSZnQIncaRzeTHsVmvgbv3YA5H7sxhZ9EDLoOjrT7LCw91m12bFZQzE9U7WtPHVMI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=IT101ZPF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso56968345e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2026 02:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772618785; x=1773223585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LiDOsrcJRzDUkNqA1ZB1g1zdvhAz8jBlAAYxUsfbSFo=;
        b=IT101ZPFtmi70Ck1RuultjOCCFI05sbCTRV7QaGg6R7kNVxv8XA70142qqkcunQAiM
         w3asd//qp41sPpLBEb27bsMpd49HcZShAlJPAD8m5WF8K81289/4nijyBzyLpyzU9qrw
         Oz0h4EwIIYcp+F42vhKHthsMKAKKrcQz/6gY/xPgNbe3lvP6f1r4rqJDG0iK79fgIgSx
         SDFVK9UZ+V3rIBSrtuHNZsbVTW4v75e2pLDOgO4GfOKZAaaCX9OlUjYwZ2+aWzBd7tn+
         1dWtZKy4Fq79vs51pHY3JxJk3tOJsO/zKPQ0j4nrviIEpSF9n6FAPGcV3LLBNDoRvxF1
         Xh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772618785; x=1773223585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiDOsrcJRzDUkNqA1ZB1g1zdvhAz8jBlAAYxUsfbSFo=;
        b=uPseTtyFAQcrQ7gzgvqtYxG0WsNUl2M2vRdVm/zZjNpPPhqz04kV05wSQtUL55qMkB
         UyawISLDSZVyJh/0MT25JR0SIYW4M9Bt+mvOGDngw1lhieNNd7xGh2i8zt61u5O4hJPs
         TYqhPRyhLmDIAxZq2N9wrEt1ROv20P1y7c3wqQyCib86XkUz9rGLSr0QB4MO3G+XffHq
         9xs+NeRzgns0s1cNsk2LJRcDMJ5DBUQYe87YafT9qT/l+mMy+WjelfqEArKeU4XbuipK
         DqiOlJs+G3DfzipeK8ymZjzjNJHJzLasWjAE4DGGSqNiosHwMJa5sGVD2m5T6Hgu2YK+
         Obhw==
X-Forwarded-Encrypted: i=1; AJvYcCU+L09AlI1T3oFptNAeZKSPtGeunVxvMhO1Mfh1ICkVkNXjrv0BFduFDHrfcwiKHzQ+geUjKxf2OIoy@vger.kernel.org
X-Gm-Message-State: AOJu0YxfQfz/YCFwaMv8fU4W+EeEAETkcRhGa1X5gm4bE0APcIjo/a6m
	u3ZxkSGdwghxRgcON6bSuAsaKfl9G32Hr/kTYU6s5upj14AEYFjx+SuxvbLWc+DfGfo=
X-Gm-Gg: ATEYQzzcOpAIhBoEQXhfYduTHsvZcMdH/j68ucJUR/g8sfKsRpk57x+jYJl79z13Ge2
	PdoSUKPcsBbae1tHnWvNGn7FItMnw84TdX1c8ofo2rew+O9nydQgEg4yFGo35hHyS4kyEq+QQqF
	1pBQndIqRTgx2kDtaI43JAaECR8CT0RMuwZnASMWTM/BFbqkb8LW74QDwyNgcNdtq0Cb9VlTh9q
	BkZHZM3KiDnbNLV6aNO4w9SDwsXrJt2zmLcksMcXuA/6fyX+r7m6SS5swWHp3bYq8vHPp3O495G
	kAkClDzJ/N84dk2BuLbc6f2KfekdPWLFSOnYQ4eLkb4jISsSy1JQ3so7YjasoOD3U4cNpB0RAKX
	KjhJOB4DEr7TjnZZcBnQO2Y6JAiAffy3Ly7PG3bGf0oQQTyEbG3I6FHdwEbX0cazirzhwqg0VqU
	yO4FHZI/lAeUQbOzEnYqdxDFtWptLWTqAfWtc=
X-Received: by 2002:a05:600c:3e18:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-48519862e45mr23898775e9.11.1772618785276;
        Wed, 04 Mar 2026 02:06:25 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485188914ddsm50708685e9.12.2026.03.04.02.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 02:06:24 -0800 (PST)
Date: Wed, 4 Mar 2026 11:06:22 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Shay Drory <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>
Subject: Re: [PATCH net-next V3 10/10] devlink: Document port-level resources
Message-ID: <ypgqsnml2lbtx7jnzpy6rqs2cxij4rmw6elcdvcqnmzgqaqxk6@e2d67qjopryt>
References: <20260226221916.1800227-1-tariqt@nvidia.com>
 <20260226221916.1800227-11-tariqt@nvidia.com>
 <20260302191448.4750a2b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302191448.4750a2b8@kernel.org>
X-Rspamd-Queue-Id: E2D451FE19A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17463-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Tue, Mar 03, 2026 at 04:14:48AM +0100, kuba@kernel.org wrote:
>On Fri, 27 Feb 2026 00:19:16 +0200 Tariq Toukan wrote:
>> +Currently, port-level resources only support the ``GET`` command for viewing
>> +resource information.
>
>In case there is v4, AI says:
>
>> +Currently, port-level resources only support the ``GET`` command for viewing
>                                                         ^^^^^
>
>This isn't a bug, but the terminology here appears inconsistent with the
>rest of the documentation. The document uses user-facing command names
>elsewhere (like "devlink port resource show"), but this line uses "GET
>command" which seems to reference the internal DEVLINK_CMD_PORT_RESOURCE_GET
>netlink command.
>
>Should this be reworded to match the user-facing terminology used throughout
>the rest of the document, perhaps "only support the show command" or
>"only support viewing"?

AI does not see the context here. This is in-line with the rest of the
get commands.

