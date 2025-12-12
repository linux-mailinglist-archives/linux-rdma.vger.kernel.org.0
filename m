Return-Path: <linux-rdma+bounces-14982-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F341CCB8B52
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Dec 2025 12:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D485830120E3
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Dec 2025 11:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405EA31BC8F;
	Fri, 12 Dec 2025 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="cMeOE3kA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FADE31AA80
	for <linux-rdma@vger.kernel.org>; Fri, 12 Dec 2025 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765538720; cv=none; b=IAkfaMP2/QNFsg3Fy6wJVgni3WQPZgPKxk7Lf7CWz/doen6DK44UjIhIEuVfD3gaUbtdIPFVH4jVwm+xD6o8b6lhbZFHhYyynWbmlir8kxrHtzm9V8VoVa94DO4QAisK39yyGr3N1QBpCzU4CbdS0dDSnJB58L/ELiBP1RSbzVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765538720; c=relaxed/simple;
	bh=hTO9aQVk1BjsYhwnOVt6ys9wXkYUKex0i/wuCIuc6wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVrurZmwZPNnPWzsvbBawTy8ia1QwEYEI4qLDjqG48aR8ne91n0FyX0Ys6gITuofSNXxWNwR6JATQMToogIXb55Oa5cKqLjG/yk42jzIbks3EDG+RRZIrY/mXRgCuU2fDdkubW0CVWGCafjAAj64/tUUbvVfXupe648tXbZNLvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=cMeOE3kA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477632b0621so8070345e9.2
        for <linux-rdma@vger.kernel.org>; Fri, 12 Dec 2025 03:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1765538716; x=1766143516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gEnn545SHxpJYbhpEqJ4kau8ivvtfD9Ghf76lIvPG6E=;
        b=cMeOE3kACU3Ha23b+to+W7aPNYOihqvQuOjwSqGOXZ0gICe92Db6JhvmQ6BJ8/qtEw
         PR194sicrzJkAYlJ+jmzXgJvZk09uDchh9eOJQWn7xKmHuA34Yt5Hgkalp6DkBvNaIu1
         qCkppwq/uAyrsk4N3Gycwl6RZCj2PZgWbgeUSoBIRRpLNHKNREqryVW18rEw2cDBoZkO
         fQNzhs4ug4EllxjaAewe+1nbz9dsEozWQCM7fnXWMPDozG4Urh8gHbe/161oSoGR2NbI
         e7nXoLcLIKLETzBZByXcCxc/cqa56m0aYBV7XQAtagciJIMul+LBf0PGLxbU27r7A1h0
         74Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765538716; x=1766143516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEnn545SHxpJYbhpEqJ4kau8ivvtfD9Ghf76lIvPG6E=;
        b=DqaBv99474XvwGY5E8mXYTiMDQusR0oatT40YkLVEU+IpVR6GsGlmdRAmcryfoFm50
         W7MiNpEEgeLof3RKkQt0Rp0sfQ6nqTxUaADEXs3GbYjqB+SQxS3nwnvszkOcLdDqzQ1p
         GKtVoVEHUcWQvmBr+D7NW1enWM4Huxa4oknUH5/SekTwi6Cff+oNxhj/FrluWCX4UIjv
         K1yS5P6SzKTRMXWju+NU3gNlRJtf7GEntnByW1bMeObUPOsQnxStxLcNKDjuIGPgOcRJ
         lsoBSo8PMhfIcMGNPD2nv5j8yltuMCike1oN1b7ZAmJiLngTxE89+h2/hX/9UPdZiIMZ
         xviQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTSUYNqrldk33GIuSgNu1BF5rJlMVdBobgaMJ1NEoEA/vJmjOGEoYzE5ulgXhd65Rg3WpoSztpnoHT@vger.kernel.org
X-Gm-Message-State: AOJu0YwUVUnAPeAk2OhFtecC1G/d67FpO/HPwHjioBF1ytqAVpePLreS
	sGNEg8YgXILwJtvToUmckIr/oOikDFNmEGB2P/XCZR1efkitZpV/YLLyx1ArwZFI9Lc=
X-Gm-Gg: AY/fxX5EpUkVh5814/QF2VpkFDzwhrxSREzSIyZl/uMeWXtv6VO1Uv+S9rn4DtYwC2z
	q+vrylJoParhxm8IfrLtEFFHme0/xqyneFOz2Q/UmsGg4WBzV38ABNjIIOx0dStliygray8Cfnn
	OWCcXeGFcJb6f3IFFyCqHxYce15tU9ynatRhoOCrRrZ/Fww60AUCfHDSox0S6C10rtAudyNxGjP
	0qj1AMT0LbC8iS3rIA3STY93WnQjRQ0i5ncdiFR8FQgrzBq75jkS5I57rpS1BkNuqy/kdTYmhta
	BeZFODG8lVdX/0RcT+jIB2yx0NJ/8FCqFPOXkxcaft/Q5pw4jhVVzqh/olIen8oiDhA36smbo6F
	Q5W0WGrVyKbD92BVAMsU/JkbmvdpwJHyZXadup4inM1gGs/cc4TyNgnS4wfIth4IahKG1/8KIHE
	aCDvtFDRe8QKjJ9pODJESUORs=
X-Google-Smtp-Source: AGHT+IHkaay9CDV5kfE74IqgXxI+GzQAfyiag1hnUiI3Kv6EDGuWkv0C2Lwzh9GBMI+h6MNTm6fuig==
X-Received: by 2002:a05:6000:2c09:b0:42b:5406:f289 with SMTP id ffacd0b85a97d-42fb44a24f0mr1717666f8f.3.1765538715596;
        Fri, 12 Dec 2025 03:25:15 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a66761sm11462241f8f.3.2025.12.12.03.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 03:25:15 -0800 (PST)
Date: Fri, 12 Dec 2025 12:25:12 +0100
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
Subject: Re: [PATCH RFC net-next 02/13] dpll: Allow registering pin with
 firmware node
Message-ID: <ahyyksqki6bas5rqngd735k4fmoeaj7l2a7lazm43ky3lj6ero@567g2ijcpekp>
References: <20251211194756.234043-1-ivecera@redhat.com>
 <20251211194756.234043-3-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211194756.234043-3-ivecera@redhat.com>

Thu, Dec 11, 2025 at 08:47:45PM +0100, ivecera@redhat.com wrote:

[..]

>@@ -559,7 +563,8 @@ EXPORT_SYMBOL(dpll_netdev_pin_clear);
>  */
> struct dpll_pin *
> dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
>-	     const struct dpll_pin_properties *prop)
>+	     const struct dpll_pin_properties *prop,
>+	     struct fwnode_handle *fwnode)
> {
> 	struct dpll_pin *pos, *ret = NULL;
> 	unsigned long i;
>@@ -568,14 +573,15 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
> 	xa_for_each(&dpll_pin_xa, i, pos) {
> 		if (pos->clock_id == clock_id &&
> 		    pos->pin_idx == pin_idx &&
>-		    pos->module == module) {
>+		    pos->module == module &&
>+		    pos->fwnode == fwnode) {

Is fwnode part of the key? Doesn't look to me like that. Then you can
have a simple helper to set fwnode on struct dpll_pin *, and leave
dpll_pin_get() out of this, no?


> 			ret = pos;
> 			refcount_inc(&ret->refcount);
> 			break;
> 		}

[..]

