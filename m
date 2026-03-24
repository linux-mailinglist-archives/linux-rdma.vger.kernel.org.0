Return-Path: <linux-rdma+bounces-18578-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G9vKXOPwmn/ewQAu9opvQ
	(envelope-from <linux-rdma+bounces-18578-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 14:19:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A410A30935C
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 14:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2C3D306B81E
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39303EC2EB;
	Tue, 24 Mar 2026 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EFzEjqL1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FC23BC680
	for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2026 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774357536; cv=none; b=RkSbOD+1tnNc9DWswqweR9DhWJ0NjKGA6ZK1w/IJC6i7ZjzwNan6rsS8eDbIRfOFVg3r5aYjlZRR+o2/0iZLNAKYf4Tgz3vWM/ILrVQGeJSFOZHwhbK/EHnfYn4BkI5LixUuTAyxBytXJAv3j9xIG0tAb/y5ZPssBrFj8XhiMlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774357536; c=relaxed/simple;
	bh=c5ob8x+63Jafk7vg3P7eaQn2ve59Nggw5TcAv/2m3zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQdokeMRKq5zxfLVKF7VtI13EKGCWO6mUPGZewW7wSMDEwr4eu18sk5We9JpR2khUXtIbmcnCpQa5zNCx9nLlNnWjE5EyugcMNOlanNKU50BxXoa9KEZoa8X+i953bqwpnKphcVaerR1eTAcDUVG62Zq0HmAzpv3Dzq4Yb7pW/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=EFzEjqL1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so37787975e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2026 06:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774357534; x=1774962334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c5ob8x+63Jafk7vg3P7eaQn2ve59Nggw5TcAv/2m3zw=;
        b=EFzEjqL1CrH9+xTEQCCpzA5wU2vTa0ZY3RcosBio97hIDcHZBskxxAceCFYxV67SFM
         PsTcBXmJJvz4+0zHWTzSrknsIRvi1p7y9gYNNDPeAy6cBzEUo4GHYGzSilSFRbUdOhBY
         shUTABQWxsLpoSzpCZFYP6G9GqGEMj90LW9rmoQwemQ6I9/otaeFCWu9SP/rKdtOcV2N
         RvyJsoJ+5I/0lFD5fi+ZjIej+CX+layGDTrr9dJUmgQdQVZwYcZafg8XEa/nZSkm45a2
         MXtwhLewzXFRS37telw/QsZrlr9R1w/prdiV7ebHrNdCbRvSWCdfyMihQCLi4MxiZtni
         bT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774357534; x=1774962334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5ob8x+63Jafk7vg3P7eaQn2ve59Nggw5TcAv/2m3zw=;
        b=jvXnHtlX/KUC99M4TgrIyroi3yJ/dsbhyAHufqo8bEYRf5PI0rSyIQn29J4o27dOeB
         66kULp3qJOqXAG1Lf/UWWNJpn2sIapkpJQtv9d7YbA8uvcC6/5S7TbGj81xjnmyQpVc7
         xhwvwCCBAyqfNvdgs6UH5Q6vT2uiaPbukhBsqI9QKP48PfVVXVsFgS9t+iVOAXvXwhV8
         WwbLjYeqULYl3LHhPv6Bh2pd8PmcM2DMBgcl8mD/m+6r2nY2S5PVJ6/UBu12qwFeSaYH
         I7p1xYQ5jFhsMfmgmvgUlPRJWchmvyVIwUvfNGbWJRzsu7tOfwnC3rJWBPhWoE9sfMGA
         d34g==
X-Forwarded-Encrypted: i=1; AJvYcCUXkCcXKDGxgJtfAFdCLYkabmTR2wlmvqmKwZlKu9KXI1akquSU1Wh3FnvbcJm9YuIcwAmC+UyDo5OP@vger.kernel.org
X-Gm-Message-State: AOJu0YySUMTMTjKFTmOrSN6y0I4G4GbnVRIUrfplKo7OM53zOmowBplt
	U5Im4/gQPBWXdKquLkQhvlINpFBLIcu8WSs26rALOf3Xz08mvNwJ0pAqoZ38bIhGLTY=
X-Gm-Gg: ATEYQzzf3KUq0Q8W3CJYJsNmf9XRCniCfHj5FLr5S0A6HIBGJ8BbZKhAbamF9FAJC2i
	NT3kT9mhW6jpCzGyRMsnVaLzIbCJ9jmnA0G6kSyg+D5TEHMCqYWPldk5afT0AcfhQ4fWSRjPNOc
	4WTqhlYkSflMTvCvjsWRy1/FpmR3E76aq0WJiqYXChHuMnLxeqjGt4ihLYVU4thURkZyEfTSIKn
	k6lbY8dd1o2rasnAgZrhQfpL/GUfKvFO4EX4phAhCzGLRXiQnEHAie/tdUmrw7RaNRgSOyzj5Xo
	e5kRSj4Tu+88V/YDpss5Vkm9g3gvG8SLWoKftFpofRO27KN+7LweVG7aBDs3WecPrBmNCUNGTWz
	KIQbN3Qwkbc3BGw7Wm8a4oyVdrCJWhK+5zlYLKuilpFpdZKqImjdpYeLXaXYbsiidqpe02YYB6G
	SnQeStCKl6oD0VypQ3SpQzltFO7pWjOt7Q2ZY=
X-Received: by 2002:a05:600c:4f10:b0:487:2e8:69c5 with SMTP id 5b1f17b1804b1-48702e86a88mr205126035e9.15.1774357533835;
        Tue, 24 Mar 2026 06:05:33 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48710fa0e35sm46182275e9.3.2026.03.24.06.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 06:05:33 -0700 (PDT)
Date: Tue, 24 Mar 2026 14:05:30 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, 
	Chuck Lever <chuck.lever@oracle.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, 
	Daniel Zahka <daniel.zahka@gmail.com>, Shay Drory <shayd@nvidia.com>, Kees Cook <kees@kernel.org>, 
	Daniel Jurgens <danielj@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Willem de Bruijn <willemb@google.com>, 
	David Wei <dw@davidwei.uk>, Petr Machata <petrm@nvidia.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V8 03/14] devlink: Migrate from info->user_ptr
 to info->ctx
Message-ID: <yfpepx63i2om7y62kspzizq7a3xxknfnzrg7j27ppt2oxpeou2@kfbomamxpdo4>
References: <20260324122848.36731-1-tariqt@nvidia.com>
 <20260324122848.36731-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324122848.36731-4-tariqt@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18578-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,davidwei.uk,fomichev.me,linux.dev,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: A410A30935C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tue, Mar 24, 2026 at 01:28:37PM +0100, tariqt@nvidia.com wrote:
>From: Cosmin Ratiu <cratiu@nvidia.com>
>
>Replace deprecated info->user_ptr[0]/[1] with a typed
>devlink_nl_ctx struct stored in info->ctx. The struct aliases
>the same union memory, so the migration is safe.
>
>There are no functionality changes here.
>
>Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

