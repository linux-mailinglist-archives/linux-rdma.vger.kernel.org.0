Return-Path: <linux-rdma+bounces-14655-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FE6C74AEC
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 15:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 008C129F18
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 14:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D90340A70;
	Thu, 20 Nov 2025 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Wv0H1UzQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE5D306D2A
	for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650521; cv=none; b=ShgdMmEtM2aQK2YSEKxT4JoOba9bOCQKYKKVsHIBjwgcxZL6xYSlYqLe5/qY3HNMfkf8aim9ByAj2X/et5tCh4iCImGYvSRk4gsHElZGz74Irx+Jj/VSz+GoqBt49rS1YNiMOOW67s8uOlGkD1aKURGZbkptwG8K8abOmnfaeX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650521; c=relaxed/simple;
	bh=IYKfCs3i0v02S1nziPd8Oz7+F3sngphV+VccYH5t6I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVRZ8yg9iTP5rqi2Y8d4ZixfaGc8Xzg1ZZgpBeIqu8m6TpMCH5vLAB58l3kd3PyVagzh3bAQbrK3jKA0SaKvEOeRG5Mg8Ex/rIhEY0xC4zksSlN5G5UlVDz41IHeccWTT7IPfwo/mrwPzw1xTEienetMCgeix5mSlvfZ+/+MRm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Wv0H1UzQ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64312565c10so1352275a12.2
        for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 06:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1763650518; x=1764255318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IYKfCs3i0v02S1nziPd8Oz7+F3sngphV+VccYH5t6I0=;
        b=Wv0H1UzQWEoKiXKbq6WEYoPYNnT3wIK0V/RgJjk7Jb7/YDPKZ02ZItAUh9ek682lkF
         J5zYk2oOz1JthW0BaAsKd/5awaatlRy4qKk08lWbHKzH+AkwNj9cCWCzcWUuFnX8uZJg
         wqJFMDc1He9WfqW0+oq644ini3fMEHCgi7xtauUYbqVcluvPVwi61GlrRc720TvGuoMF
         1FefV2wJLVmSml06m0OMBuEYeUytqJfZmIydHw3wOhIprcBXwgVYlqIS0zLrFs7DDiZC
         i0MU88S7CTxi72tpgAtTuOFNaAwMuOSG1EAxF/ko1RNuQY4hyLfHjzMo0GyXh4Ptity/
         wfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650518; x=1764255318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYKfCs3i0v02S1nziPd8Oz7+F3sngphV+VccYH5t6I0=;
        b=nnQZuRTeWTSvYcQP4u7yC5phZPqATg9aF/GRglbJQtl3Hgj2lvUFyMMQNCCHPNvuRZ
         cv22XeoHTLWuj3+77A32XSzJCTI+83HJLasPoruucvbdyT6qr6ujv3PU9s7se2Sdu3vx
         WY8F0bNR+VCkadn+LtaAU3m2cW42k2dKGBP3lFoBDbe1KTY+WH2oWg13LwPg0LQsU8Lx
         m+18haAftQgvYJ+1Rs3Zz4d59p9XyozwPgdX2rUalrnRoLw3gAMg0H8zUTCR/AERPLKp
         qI5ZGoPNKgdn5TBps3/WlLXWvhOwzfUhzp2y8NfhwRz78FlflPMxmb9ZBBcAcnm2PH3t
         WIng==
X-Forwarded-Encrypted: i=1; AJvYcCWosSsk8nXHZ8xE3yWauT01+vg2+IiaVqDibKByCWnU9Z7cN5zdTQTXdGS1unkGkiEtm6eURAulW8pf@vger.kernel.org
X-Gm-Message-State: AOJu0YzbviiIDP8va7rB1rjLNCUbcOJu+ThmG4SU3bENTVUJ08eUoUdo
	FU/yc/NevsR8vi1S535J6r4FUTOCydWybzojDN5QHRdK+VTJUIGl8ADcRJ0mLq53CJ8=
X-Gm-Gg: ASbGncvBoZdryybdiWOM+SwmCinqqgKdkBXhtoXOafO1YUXOQaH73GyA3QBph6QmaI9
	XrYgDAY9rWicvpRnmr/FXTTybqmV2P0Te5lfcj2tDOeC0nTiv/STm51MrnLYdal3p+EtdzFefV6
	Cva308bpgLLhahHmdkwKgD81JSzQDqDuk1xCLLwtPHrZUUWl7VT2Zlsa6AIi/F0+GNLfpQ2R2p/
	aAD6PVWituI+GwbGSYOPeNUT0cehwHAulw50nzj7xYonh4fn1JZOFJcUAry79TyGiA8N4+f4fOa
	ardTLhfS5t9az/t1BMAWnHM5g4hwiyChbSxvzWk/hQBTNLZtZ+cwtzTF9QbeptzFNVh42FJI2u1
	hlggwkB2D879Xddl4YQ4ulG7qs3BLU5cA7xwzTt3XkHxeQa6akamwqOU1mv7nCMTanzJ+8Za0dY
	2KdmWSvnnFGZ1XrloENZg=
X-Google-Smtp-Source: AGHT+IEPtM6EIIGo4193tVNdZEj2yltOmNHgf2oexFbhFB6uocPPBppvPF2J67DDaWgxEDBcuxOxZw==
X-Received: by 2002:a17:907:3f1f:b0:b73:6534:5984 with SMTP id a640c23a62f3a-b7654dd66d1mr355087566b.16.1763650518326;
        Thu, 20 Nov 2025 06:55:18 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd4f59sm217338366b.36.2025.11.20.06.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:55:17 -0800 (PST)
Date: Thu, 20 Nov 2025 15:55:16 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 05/14] devlink: Decouple rate storage from
 associated devlink object
Message-ID: <3yvpa2ni6sq5wymlvesp3xdoigc4dlvhbtrixz465mr3k6y7hw@buvno7yetqma>
References: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
 <1763644166-1250608-6-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1763644166-1250608-6-git-send-email-tariqt@nvidia.com>

Thu, Nov 20, 2025 at 02:09:17PM +0100, tariqt@nvidia.com wrote:
>From: Cosmin Ratiu <cratiu@nvidia.com>
>
>Devlink rate leafs and nodes were stored in their respective devlink
>objects pointed to by devlink_rate->devlink.
>
>This patch removes that association by introducing the concept of
>'rate node devlink', which is where all rates that could link to each
>other are stored. For now this is the same as devlink_rate->devlink.
>
>After this patch, the devlink rates stored in this devlink instance
>could potentially be from multiple other devlink instances. So all rate
>node manipulation code was updated to:
>- correctly compare the actual devlink object during iteration.
>- maybe acquire additional locks (noop for now).
>
>Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
>Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

