Return-Path: <linux-rdma+bounces-16634-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA5YBUC3hWmOFgQAu9opvQ
	(envelope-from <linux-rdma+bounces-16634-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 10:41:20 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D492FC274
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 10:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28BF6304C07D
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 09:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F0235EDA6;
	Fri,  6 Feb 2026 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="zVTY/2R5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501F835EDB6
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770370595; cv=none; b=uSqFxAcQyIaxG72bRB+NEsyuGnp0ZPwKXDfOUPLRWeWTgAaOMWGgI6zOQbQtowU2598LOg0VoHilUhsvsNG8v/ZTdgWyga81vnhETvnjRrpHWUVu8yRdawxb+rs2XRf4KyAZ8+G8uI2o0DQfeO6TyvRpVh7YymdLkt6TEpKnrdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770370595; c=relaxed/simple;
	bh=Lv8uI95dliFeoBdCejcOMOusz6kZTyerXTknQcwPhW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8PmBdlncMPGvx8dtG9x/ICWgGRPCIA99VkyeI7N+2ptajDeu/K2VXjxOjXbDohErm7BvzoewoxgZ5hSoBilgus2J+x4jdfywLL/31ScTpjhHS4s1Pvld7oUrpAh6Z5tRUAxHnp+uGFJssHAQmqUX682muPttvkZyIbHhEngLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=zVTY/2R5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4806f9e61f9so11587805e9.1
        for <linux-rdma@vger.kernel.org>; Fri, 06 Feb 2026 01:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770370594; x=1770975394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pF603AUQdiALGLuf8FGVmdwSpRghR2h7LwnvgLtFhUE=;
        b=zVTY/2R5AWD/9OiCCPIkxL/zp7SyokQsb3PgBTPTL2nJLbxeNJTyAYtMaAKiMr9XHl
         1MsawKAON4NOvrcAAKX27jySAT3eYHoXj1rh8Z+naXele+Ukxa3e48gqt+VFJDdbV2gl
         D+MEEPw6yDZ82N7IOvbnlhsHUram6127pRDfoY/cWN6OP+LfW4XBKJvCgXptTNRsD7F1
         p5KxChnzmVuHAtzHXtUq/+oSlE4mdhwj+mZobui2lJ59AggOXLIL5eiZtU1ruGxYZdOA
         +DnxcbrRkwSIQNlf6sxJzv6TXC13VLUfg0gygzAxBbippCOinkjb3hbAU1giZVR4VPEO
         JVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770370594; x=1770975394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pF603AUQdiALGLuf8FGVmdwSpRghR2h7LwnvgLtFhUE=;
        b=rRh3KNzg9jETsDCLb5FRUg0/2pEgHU238v+sanBNpi2kPYz3et90ysSBrQKnxc80FB
         8Pwmjaj1y8fxT1ype87UDfdNkIskZZ1NaoMXiudMDgkWmGm9qwkpeiVcHGewnYJs6DKG
         OQf9W4P1V0QtxCtPy3y3Ua5NDf/ArF3ukFagyCj5hMigfV4WtIGG/tsVSGsMwCmeSRK8
         E97z95eX+t6jdfAWgHRzWJtX9FBeo+WYMP1RfXhE02fgW6x16bICsivT+S00vF1jc9xS
         p9ihbxjkQrHY2aexmar6KhstV/ktAlvr6Y2YmrcILlT1+e9RSTixXkR3AeKBUGGS3k3Q
         lTdg==
X-Forwarded-Encrypted: i=1; AJvYcCWXYsJ10682zSWsES+pq/K47IjHuuOAFcOjBZlWT3Nhh/8/w2gpUtuZViZIaK0gY5IvFyZPzLy+XL4U@vger.kernel.org
X-Gm-Message-State: AOJu0YwcJM1mdBcg8cV+Pj3c2zkvJFcPGPQO8vQJ7djgDH9zr22YZikW
	zCwx4nSDm9dCClYTJuwMXuZGYSxqQ1hS+1xlBPrfQk6S54l2sFfnJ4tbhLzy3jXHwRg=
X-Gm-Gg: AZuq6aLxOqV6iEKF+EM9amGHAgjXHJTb6qlR+sFCzlgJ2IW9ZI/ad6q6/9wnQ0DsHRe
	SmiJu/Ao3vI6rpEIQWhvKSzG+m1E9SxN27+oa19BK/69UffA+iMQ14BpfYGMGg+TK1H+8GiDcrZ
	MS9fj4fyLhzwVdXXbTfIbHv48Dtl+KLwUfJy51xT57OJH+2yJI0kGYw3kNnHQn8ofNO8PF+T8RP
	3WWlnQmCkuFDhChak6VUZ2rlmmZmBRszSZ+F/CqrcI45bY/Vi9XuGnQngwxKG1dqYUgFmAe7mea
	5NCN3qfXZL81t8KPK3Vk2zaONEXVKHzcAb12S9G8NEfECiXVRn8ksgDK+S/T4GrhpnEtfSsoQf3
	flQNqgcOzzJKmEf9VRmaYrn+ts6UQh51DWluE5pQEVpd7mh7T6cYyVf/votTXW919Jvg6gDpKvc
	elODyS7M8g3rG1mg4kiZXRGa4Cw3OoLQ==
X-Received: by 2002:a05:600c:4449:b0:480:32da:f33e with SMTP id 5b1f17b1804b1-48320216075mr34903245e9.17.1770370593702;
        Fri, 06 Feb 2026 01:36:33 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483179dbdcfsm147111195e9.0.2026.02.06.01.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 01:36:33 -0800 (PST)
Date: Fri, 6 Feb 2026 10:36:31 +0100
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
Subject: Re: [PATCH net-next V2 4/7] net/mlx5: Register SF resource on PF
 port representor
Message-ID: <kmoeavzguajvf67sjwxkh4x5ogbus3cigeatrstagbfcyqyka6@w5ufzb5brkst>
References: <20260205142833.1727929-1-tariqt@nvidia.com>
 <20260205142833.1727929-5-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205142833.1727929-5-tariqt@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16634-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D492FC274
X-Rspamd-Action: no action

Thu, Feb 05, 2026 at 03:28:30PM +0100, tariqt@nvidia.com wrote:
>From: Or Har-Toov <ohartoov@nvidia.com>
>
>The device-level "resource show" displays max_local_SFs and
>max_external_SFs without indicating which port each resource belongs
>to. Users cannot determine the controller number and pfnum associated
>with each SF pool.
>
>Register max_SFs resource on the Host PF representor port to expose
>per-port SF limits. Users can correlate the port resource with the
>controller number and pfnum shown in 'devlink port show'.
>
>Future patches will introduce an ECPF that manages multiple PFs,
>where each PF has its own SF pool.
>
>Example usage:
>
>  $ devlink port resource show
>  pci/0000:03:00.0/196608:
>    name max_SFs size 20 unit entry
>  pci/0000:03:00.1/262144:
>    name max_SFs size 20 unit entry
>
>  $ devlink port resource show pci/0000:03:00.0/196608
>  pci/0000:03:00.0/196608:
>    name max_SFs size 20 unit entry
>
>  $ devlink port show pci/0000:03:00.0/196608
>  pci/0000:03:00.0/196608: type eth netdev pf0hpf flavour pcipf
>    controller 1 pfnum 0 external true splittable false
>    function:
>      hw_addr b8:3f:d2:e1:8f:dc roce enable max_io_eqs 120
>
>We can create up to 20 SFs over devlink port pci/0000:03:00.0/196608,
>with pfnum 0 and controller 1.
>
>Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
>Reviewed-by: Shay Drori <shayd@nvidia.com>
>Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

