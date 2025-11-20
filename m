Return-Path: <linux-rdma+bounces-14654-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E72E9C74B3F
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 16:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96F9F356F94
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 14:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEBA33BBB6;
	Thu, 20 Nov 2025 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EaEoyWdu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8895334C04
	for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650392; cv=none; b=SqcBM9Wvw9qL2fnT5AMniRdsSFMVuIwqOBofD9gsFcl02RrlM33eMLrqzXKmQa3w7h8SvxPFLnR0cYlZkmi41AmjRwakcVRMBl4miIvyaH4/kUiXrbyWIwFiaQoeeLUr/fcFND8B0Sc4Y6vs+mLaOYKpWWibJ7QlmYpq1zpmAwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650392; c=relaxed/simple;
	bh=Hs8Y4srjRXSDmflQe1JQvRGbJo0svHHlH0JZJV2BibQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTMT1RWZJJY3VCV5HJM++1bJwGqUUIGhnNsKU0AYdIK9LuIHpVBgfx2wVq+1BLlTpyyTPBfHzAgz51TwRtdNWQacqcfXwrpf0Mn0qhKXRvmgvq+zP4Nrj7EN6zp1S3dVMCuntpsxxpfTqUaBSUMF3PQq115OQAP8Ejd5vL/a/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=EaEoyWdu; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so1655548a12.1
        for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 06:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1763650389; x=1764255189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hs8Y4srjRXSDmflQe1JQvRGbJo0svHHlH0JZJV2BibQ=;
        b=EaEoyWduEzmqyPeavUzgsFNnUa7ir9Ss7/cVWRn4tjus4OhJKWgyF+0XIXHnu1PKd4
         ZkzflYIgmcJDHZ0qX5Npw7D6wHNNxqPV44h7J7tIyCjH5ZImw4jcvi2k991pzmkZEvrO
         OnWUy3G25q0tA4OuOcOwvtGJIwlta9AygvQT/w1Z7xYEaQKop0p/1qUInMDgwNBqcQg4
         CzQu1QIjvb6Vu2d9sSpRb8IZqOe/09zCLS7uKkue3xlvCwZJhU4CyVOyaxfFQy5MuoTR
         /0uX0b048r9IcFkw1BjYGdNbM7f6zy0t/mY94T60GiTjfgl8Op7PQJFk69vz+eekH8l6
         uSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650389; x=1764255189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hs8Y4srjRXSDmflQe1JQvRGbJo0svHHlH0JZJV2BibQ=;
        b=Q3EOBTwStrebUKG6zzkdP3olLur+vKkRKTkpsIeh5RA2cLMmstDkCBGCDcqIQALUcj
         XnBjLWxC70jE1slgZJNpTo+G7vzMMWBplaXoh9RZUnhGX4y6LhYu3hGgyEvXJdDRprpQ
         j1pgDhe47awx7+6RkTd4ZbveLjwG1o6kpjjymlaOxWFTHIBnxjvNNT4LifwUQUzpAW+d
         XB4fwHVj68KDA8qh4vlSsuo8T/CtxKYdfujoWmF2Vx1NG/g7OpqJLdinWMyooy4wl5Su
         Say/pkI4T3w1eHfmmdvFb4lEj3lOyHPJa6D5Qx2LGy0CBHApFyLqGGBrgXddllg8xqeB
         gUdw==
X-Forwarded-Encrypted: i=1; AJvYcCVPKe8osSPMmq1vh7dLSfEDnmeqKvHoHPqRLeA6Ml4FNpRu9RhDIDZ+AoDPuoA/tKg/RQ5OvtGsuyOi@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9DhTtyZ/g0vQ3+HFXSA4/LvAtyuFyDkXTmzDy4YgC56TdFZsb
	KjH7G2uxlnjXyDf2I2/nMfDeqbOPTEqbt0pP+xwcDRqhJEd9FV7TufPeyConlc4t2h4=
X-Gm-Gg: ASbGnct+5si+8DMu4022dRNBP+w4p/OGpBX4p09Za5x5P3PFxrIoJaZOkqhRb0zTThd
	JWccZ2o4zNLhm6GOHVdkZSiAtA9QTXmztsbFewkaKaCY+bnPydiEc2pVPyxmo6n1u+u9PFowBJJ
	q5vebHN3u87ui++5EV2s6QIzvrvibH4SaMJgzTQon57HUT+/6Fz8qGSSR90583bLmbD0CkLA1au
	UBdAOsMiVYppUKScfvfdGuCSkavajONKH0eKKKdi67HJFtD4hfIvXrHQkD4Jsb09eIipEPA6P2q
	RaWbfXH4hGKqMq7J/Pd5j3y9F4Xhn5bIcDBwTQcYqUNmLpOoRxj4da0w8+NhaqQ8w1Gv7k+Ys3B
	uzhsnG3oDUq4eI04R3xnFE0uR+syGyijQJwTFC+FPsYvC5KCat0IGWzGrdFLdjWgRKNIRp+Up2Q
	GZx6XLCakazWEQoY0vgVU=
X-Google-Smtp-Source: AGHT+IH7CoEyCVFu/qkrb/nXh2Nvt6ZT+I/QXVymMAmlXeUbqUpzFWKvc2NGr9Yw1jk0rVm9T4o5hQ==
X-Received: by 2002:a05:6402:27d3:b0:640:ebca:e66c with SMTP id 4fb4d7f45d1cf-64538227960mr2444296a12.23.1763650389157;
        Thu, 20 Nov 2025 06:53:09 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64536443a9csm2243827a12.29.2025.11.20.06.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:53:08 -0800 (PST)
Date: Thu, 20 Nov 2025 15:53:07 +0100
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
Subject: Re: [PATCH net-next 04/14] devlink: Refactor devlink_rate_nodes_check
Message-ID: <jpxxt7vxoltrf6r636rch4cd7tbharffrlgunsjfgnlud2lmx4@em5lcb5zhmcl>
References: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
 <1763644166-1250608-5-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1763644166-1250608-5-git-send-email-tariqt@nvidia.com>

Thu, Nov 20, 2025 at 02:09:16PM +0100, tariqt@nvidia.com wrote:
>From: Cosmin Ratiu <cratiu@nvidia.com>
>
>devlink_rate_nodes_check() was used to verify there are no devlink rate
>nodes created when switching the esw mode.
>
>Rate management code is about to become more complex, so refactor this
>function:
>- remove unused param 'mode'.
>- add a new 'rate_filter' param.
>- rename to devlink_rates_check().
>- expose devlink_rate_is_node() to be used as a rate filter.
>
>This makes it more usable from multiple places, so use it from those
>places as well.
>
>Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
>Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

