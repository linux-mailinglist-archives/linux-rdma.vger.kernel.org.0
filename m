Return-Path: <linux-rdma+bounces-14981-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B233DCB8AD4
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Dec 2025 12:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5381B300E92E
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Dec 2025 11:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4725631AA9E;
	Fri, 12 Dec 2025 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="iauBTHPB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F96A30ACEB
	for <linux-rdma@vger.kernel.org>; Fri, 12 Dec 2025 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765537906; cv=none; b=EzfuLdvW/UdnNBXxAmvdnL4TbkfQoQplLKpGXOXqKfxZOShoa88KjColteaouO7LFdXI9zAfmRZtPZpO1j9d1YKsCIvGm3t2JUqPGUhf2dVlknVXIpUWN3sIvkr96ly2rJIwd3nfE7C90taYx0LFZQto+EeIrB+SDgLYdhrDA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765537906; c=relaxed/simple;
	bh=Qi0kf4DHgZSF0itXehy4M1IigW5Ye60xVK7z3FqTfn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ledHr+2BzCXSH5emz1dRDgKkyeX1RgZ6Ryq5DxeRkgQsJvz1fcJw18YETzdv0ZEV5Da1J2KcltNcdH9XQJBX7b8hbFwjgh5NUG0IsPjiBYIKJcO2B1VOx4YcFIrVDrdoGapazNzM0GYLk3dwZF5Val0vwCN+YyaFYfdSltIXWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=iauBTHPB; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b79f98adea4so171093366b.0
        for <linux-rdma@vger.kernel.org>; Fri, 12 Dec 2025 03:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1765537902; x=1766142702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qi0kf4DHgZSF0itXehy4M1IigW5Ye60xVK7z3FqTfn4=;
        b=iauBTHPB/kYvCWaG+gZXix1aKPd5pH1a65a7kwwJ6jP83aNhh3NmmIqkNHieaJlPxy
         CHHRuGYMn80P9NSMicWru9MAm/JK+VgWsnvpeKN7RryKoIt2GRY/wMO4I9dPwc6HJ3em
         TLRhesGA2nCcanFaS6HPCBfFeZ5fiQr+Tm3JhCtLi8thlKri5u7WFSLiBFFkFjC76KI/
         60auXu7YE+369LsABH6c52p1jgLXPmvp/icXVNXKjeCNawb/Jm4/sI7Zemk1frAZzDBC
         /+G4GMq2lqqtJ7ll5bDqP/Co2IwwLb8aWl1sddFx7sTyxec2qNU9ri/d6Vw5oLdgfkGO
         h8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765537902; x=1766142702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qi0kf4DHgZSF0itXehy4M1IigW5Ye60xVK7z3FqTfn4=;
        b=vYbAd+LSMhHGbfIuVEPAD7WiQcZpMtcQblF5QX9eM+Atb/dEZpw3LGdIVwr9JK6v4n
         lyh6vfMw/U8BXo3a4i8MG0ZeMxHt43TYoUw+Rc/ejrGQOyHvfONW55/D8lHO5ssqOMFh
         V5lnbGAdJSP/f70Y34kjmwOz53/HN5fjkqq8nJirXp0vgDtnfMrrp4QNb9BnvTktLBzQ
         jZZup6xNAvUeMTDPI6fh7/Kl3x/ZLfi5hoqcNW5bxle9E0ewQDcvg6ocn5HxnTxQ7OzC
         Cd0epkIYnRkPwk8NgBvv+M8t+PU0BuKlO3GBDRGQeG4DymeN04FWgx3T3Fy8CRstWlad
         3ysQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpEsRc6jCoYmBYY8uvQwpako/QWH4XBsl+ezmdLRQyfwrWIMJtca+Ba7fydzo2/peJ4hT+HHt9rEgc@vger.kernel.org
X-Gm-Message-State: AOJu0YwRCx7F+SIFPo2k3q9udUwAfUFcrChtAfD8lyn/L78cAyInIg1R
	MedOHkNnE4bkWp4xs36VIRW+HaG333te8ZeYJtUJeNnu2jEro9m23YFHOwtV4pvzM8s=
X-Gm-Gg: AY/fxX5b49KTa2CbxJcb+1bmthSYz1k5p8MKm6TciPbQ6fAXvLuaKPycoFZzgjncheZ
	QwmM0MsLhmpSLhlpdgfoecnqbe5fr0gPZt1cZUuUd8Hdpf52oM/BdHv+lZ+8kIN8Jtx8P++GJnh
	Sxs3vwQ2HhZpxaHdZD9hy1PIGBA/OSckM2q91v+dWH8z8c7l1RLfWiXmfjn6Icg6STL2U93iDk2
	LpASX7utKgBpZJvyiKsI0AbitrPvkbDbgkc52JTzSDXQuwq/gQg9V2ruHZnxNj0tBDbXjhXCxqH
	kMsmE5YKNxeBI0EZOWyUrhShi+WVEElfE3YZnSGbbBlJZTCJ1hZ9iYzORXmiWV3DBqqgHhO7C5p
	Qo9+gxrF6OfrTlkHRCe7jaqWRcwLC0AR6UmpYkI99CitrpTMgnZN/Xzi12SxP1LRjmxluK1G9iG
	rmN1Q+Ocpq0mS0zrbb0Ao=
X-Google-Smtp-Source: AGHT+IFmv5COMcmA4FT2YaOWuFJZ5E1bCiuQtdXozfcy670hljn+VWTpNS9TuLAE+vRQXNnfHH9yBw==
X-Received: by 2002:a17:907:960d:b0:b72:ddfd:bca7 with SMTP id a640c23a62f3a-b7d23c1b1a9mr146070066b.35.1765537902376;
        Fri, 12 Dec 2025 03:11:42 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa570174sm530693266b.55.2025.12.12.03.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 03:11:41 -0800 (PST)
Date: Fri, 12 Dec 2025 12:11:38 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
	Michal Schmidt <mschmidt@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Richard Cochran <richardcochran@gmail.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Simon Horman <horms@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Willem de Bruijn <willemb@google.com>, Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH RFC net-next 11/13] dpll: zl3073x: Enable reference count
 tracking
Message-ID: <utlzkss7sj6xgur4aysi3wpt2v4ssxmh5rxsrk7hiqitjlx2qi@btkzluwtapsb>
References: <20251211194756.234043-1-ivecera@redhat.com>
 <20251211194756.234043-12-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211194756.234043-12-ivecera@redhat.com>

Thu, Dec 11, 2025 at 08:47:54PM +0100, ivecera@redhat.com wrote:
>Update the zl3073x driver to utilize the DPLL reference count tracking
>infrastructure.
>
>Add dpll_tracker fields to the driver's internal device and pin
>structures. Pass pointers to these trackers when calling
>dpll_device_get/put() and dpll_pin_get/put().
>
>This allows a developer to inspect the specific references held by this
>driver via debugfs when CONFIG_DPLL_REFCNT_TRACKER is enabled, aiding
>in the debugging of resource leaks.
>
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Care to do this for the rest of the users? Not so many of them...

