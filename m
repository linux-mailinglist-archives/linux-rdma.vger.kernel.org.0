Return-Path: <linux-rdma+bounces-23189-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VXLkKS0mVmpO0AAAu9opvQ
	(envelope-from <linux-rdma+bounces-23189-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 14:06:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 382EF754422
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 14:06:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=xloPNrV3;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23189-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23189-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A3273065E6C
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 12:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2619838C2AE;
	Tue, 14 Jul 2026 12:02:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1428C36F8F3
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 12:02:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030553; cv=none; b=kzmQ7JrtHSz3EAWeUOhs8VEQr7DtN4IaCf6nXyq5azPRIMxGNzOXhAl2E4Hfbb1B2Zl3fenMjPlL6ILMRSJFkgvYx2m28LS+d0s+L5t/ROI/eOjuBu6zydXzofT2roNsMNWEHrDsu58cuzNsx9KQSk31UExNewsdyPqJP29H0rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030553; c=relaxed/simple;
	bh=MxGbzJ1EXIdULAavSutQBPVkV2UhDVudqdZG1CWBmp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9rAdlyxlBy5BbRMLgUSRxLRpXy6DlZtHw2f1WUQWdf3L51Fu9Tg9vnkXLqpIlJ8hPxYFsRbaFqzKgYReeWwTD+YYcMpHZOsP7nXDuKdcyYL6YiK25kvsGdebmE9fpFVbRQGxxl7G4aIm0Ypjw7jwMTD86B97AjmFmKtdcQXOlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=xloPNrV3; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493ec555a26so27143995e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 05:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784030549; x=1784635349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MxGbzJ1EXIdULAavSutQBPVkV2UhDVudqdZG1CWBmp8=;
        b=xloPNrV3q0dsouuiGc5bUzJJ6bnxilhSIXwGOplClvayzzm6Ah2r3bsykgU0U2Os+e
         wOWh+yiGW8fcuU5rky5Evy6iXTIQKcCkSFXY8KZImeB1J8C08m2oKYln9lIIznjY1Zct
         DJX0fzJ6KIV/CB93zTxcQbxy5cryxF3hXYiE/Li2nG8xF4M4cWevWZ1KIRG6WJpccxlI
         wfj9ddFB7N8Z4YP/NXHbxO3jvLO2x3sFRT5C/kD7Gl/jWquGXSRwOWmBIekE8R82irLb
         mvwtasVMxsK6/qlM5kwsHk9QiM+vbfmJsl5eDdtTO9E2m77O18rBN/wyfvOu+wigyu/q
         3tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030549; x=1784635349;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MxGbzJ1EXIdULAavSutQBPVkV2UhDVudqdZG1CWBmp8=;
        b=LwcUXMrV3c8YLazWzsqMIf5TXqFFO0cNYSskEffh9OoLXap3lr0OB6gF3P2jwtCUDQ
         SYqpg53t5uYUMazvNt/FXFVWiE6xg7V+apL4jqlpy2nFU+3cbVMCcpjzJ+i5LhmCX4g2
         UTDnglhpF1pQgB8u/p8xN4nww1zXwZOKF/h6476MoK+NakO3q/q6kzlYKTn/oBzoLxCr
         h47haff807WCxVCxumMmkAAVdk3By6g1a/0SFFM3wv7jkZfsBAqYlUDDUCn/CdHzTIHs
         JDMdFHO0sJn0N1QermC7X9evYOUvhqlChKTuQ69YM4vcFW8dOST2R8IPd6PZPNSHJL6x
         ll/g==
X-Forwarded-Encrypted: i=1; AHgh+RqROLGFSsQUQIF5F8SEcnR32ZcQiWJ4dckvBmYrmLxhQs3BWdPaFcMk3exHpaBmJOugYGoYz68niAWG@vger.kernel.org
X-Gm-Message-State: AOJu0YwxFQC+TOqibuQNk0K9IhIRyLB5Xe+2fiOqc9acDwdLC+QQUuko
	X727eM0y91vYC8QwVajVTe1DnjK5gkFLqluyyRmsBaU6UuWof3P6wcqS54utj0e71aI=
X-Gm-Gg: AfdE7ckA7QqKpm/wmm9aWzulYs9yjI1x1N4nT2yctunWp4vfA25fVbDEc+q3omfBSxi
	JgcZ7ion/AWVswCTNccKRQ7wQsE2tXCwqQjEkrNID6zMB/uBUeVsdTQJujBYJFGC+Vx8O3nOKJ5
	DktPray/yVA2Eyx6IUbmn5P6f62dVUgYvvNDORALrkV/4w3a0fjhEu+o3jlmO6ZcM8+DEu3EKw9
	NawAguA1ZyHIHcKPERhl9P+kl2Xl4Im48BBlbU92XNGt5fuxM1Bw/g9IjICNunFbGLvic+dr6Qw
	PsYD7e8BckesVwMtV0ENSumCKeZJXePYxtBctO56djyJox2xAXw/qEAEiSg3VvzdVHOmB5wvMrD
	oaB4iHUVhfWtPGA9ihS6WMyOJaqcyTpOVx4md3LyPFa7HZ8X7/7zVslObmbnMKGVSazDCQMvRGv
	dR4SHir/CRhvc+yW9onXijCA==
X-Received: by 2002:a05:600c:6b17:b0:492:4a56:690b with SMTP id 5b1f17b1804b1-493f8834e5emr94066915e9.35.1784030548728;
        Tue, 14 Jul 2026 05:02:28 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635ac2esm7854172f8f.13.2026.07.14.05.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:02:28 -0700 (PDT)
Date: Tue, 14 Jul 2026 14:02:24 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next V6 4/4] devlink: Apply eswitch mode boot defaults
Message-ID: <alYkm08MpcIXnFl9@FV6GYCPJ69>
References: <20260714061731.531849-1-mbloch@nvidia.com>
 <20260714061731.531849-5-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714061731.531849-5-mbloch@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mbloch@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-23189-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:email,FV6GYCPJ69:mid,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 382EF754422

Tue, Jul 14, 2026 at 08:17:30AM +0200, mbloch@nvidia.com wrote:
>Apply parsed devlink_eswitch_mode= defaults after devlink registration
>and after successful reload.
>
>Mark the default mode as pending when a devlink instance is allocated.
>Before devl_unlock() releases the instance lock, apply a pending default
>when the instance is registered.
>
>Clear the pending state before calling into the driver so the boot
>default remains a one-shot operation even if the mode change fails.
>
>For successful reloads that performed DRIVER_REINIT, devlink_reload()
>already holds the devlink instance lock and the driver has completed
>reload_up(). Clear the pending state and apply the default directly from
>the reload path.
>
>Treat an explicit user eswitch mode request as consuming the pending
>default mode.
>

Looks fine to me now. One nit below:


[..]

>+void devlink_default_esw_mode_instance_init(struct devlink *devlink)


Forgotten "instance" here. With this fixed, feel free to add my
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

[..]

