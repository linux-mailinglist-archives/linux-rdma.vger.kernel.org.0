Return-Path: <linux-rdma+bounces-14707-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9608C7E2F6
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 16:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5EF84E1BE0
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 15:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD7D2D593D;
	Sun, 23 Nov 2025 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="X9iLrPZd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80443212F98
	for <linux-rdma@vger.kernel.org>; Sun, 23 Nov 2025 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763913273; cv=none; b=JgB4+RZXfTrYdEenHYT+vmwcl1fuwDXCexshjhWZ1mUAY+VVaYk70ufAzkx3U6RCR4FmfLcSSO2NSPD9FMfwiXTfteC7WXnMQzEAwzZQ6Le4igJFTHLDI06X+QY5BNdun/bfupBoJtWFVIATGHTWqANYm0j6BxjEehYp3jLFDEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763913273; c=relaxed/simple;
	bh=Slp0CDEF7G02XWQScXnahPXav0/o+zCHrSvQZh8EG64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ez8XdWKAFcoZaxSEI61yRoWkz462x7U7kfeY/VuiSCv1BWx+BqyKuiKjz7dewQ7jmOFF/m2aveYrbdHQUAcvBWBvN6IKSTjz2hEySs85P+OjyzKGap9myh2AaZU5GI29L3EcDqjsxx8EzTrnVTui0LmYtrNN6AcYcskVKjqJalc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=X9iLrPZd; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3720e58eso2720830f8f.3
        for <linux-rdma@vger.kernel.org>; Sun, 23 Nov 2025 07:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1763913270; x=1764518070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Slp0CDEF7G02XWQScXnahPXav0/o+zCHrSvQZh8EG64=;
        b=X9iLrPZdIdKQgqty4X7Ln3HZOk9xVqUYOpFTGn2cZcGJQXnC+s77nt1d5uxVYljnxO
         JdJqmi4te2BVOddOGkuuOoi5QXGlEGOKD+qMem5c4GNJXGrl/4H9oDJZf/vE/jz/WxYv
         qoq9vwwdfTIpwYYd7LJ8uwv+ZMtKm43ESGuZceNozQYhX3NMXy4b13YGVeIP9h7dO1Ch
         +cyBfSczQqs7VyCNV+u7CRBOn55y14nhneMU2VKqg9yJSxbCahkn+SYLTtFHkmLnFtml
         wFJy8bBeIy53kVQE8YOno7yCbUwaqzkbgyOeoTeL/MOF5iIS9/bEEFRKhHirZkYw4cpU
         UebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763913270; x=1764518070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Slp0CDEF7G02XWQScXnahPXav0/o+zCHrSvQZh8EG64=;
        b=lezaisQb8ItK91HG4k9zN9oc8TlkatrnLKJ6Zq1i523PlWgBCpNtLZHWS05gUYlsD/
         Wry32YjPVFMv9LXoL0QtIr+kLmOCcGLw6x3uxwyzzLuu5b/IuohDKOWckYFFNjAmY1xP
         MPtaVYIJuHX/8ThenWdT/Q2j5rlUcH7NN2AS5Ki8zPYEdOBKQzraXBDvAPZry2PMS6qE
         87F/oiXy54JKuOc8+c4/E/WXh28b2JJMGzijGZAX44T/+D98OGMaHFebrvetvnM+FcB1
         xCnF+v4IosMhIrBHUP6HcywT9NyOPD4/TqTPOq7VEHeOILVerAj3JZ6hFFjQOPakoPv5
         sCYA==
X-Forwarded-Encrypted: i=1; AJvYcCUqQMYyvD6G7xe1tHzYGFIurdDf6h01LgTP/wOqKbMf7mPoKPEEU3tJ5qo6i9+wSkklc+4TkvWrCQTP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx25Q+AnnW9m1ZX7Adsbdvfbh2sIHZ58N838Nctk0S9/OdQRemb
	sh1jU/Od8L8lKoh8PtqyGi+E6zd3y/9l8hVzeane8filkLrcDLJJyUAZCCfQPL4N3a7puEqKnda
	5XC2I
X-Gm-Gg: ASbGncu/w+qMpf7cYDHqIdHho+9RyHksNOWSrsksMw8Lruhc56E2waVyFWeCTbiNRD2
	/C9bDArighIWbWwEUOKuDnz992Yl2168LuEO35mgK4HUCiWOxF7/6Vi6Rrfh1VEABHP9DXMVnwG
	3k4ebI5AUovwycnuL2QSirWwzLK6tLvnnHeNhSnM8RRZAGGy8pSjUMnG95MYaspGsxtQIkPACUp
	AvtrbOZ2NVE0QrFvzdi4TR4maukWvXx81mM1uOeWSRLyxqFC5BsPxu9hZ5lCY0Q+5K5obEZq8gq
	6Cd0Hcuazjn1fVYr6hQyfQPmmZb4IqwKCv9Pnnx7zRuRHJo5n4pIp4H6affoiqEHNam/u//ap4c
	SH+bmLc6pOq1EvZ1ei0Hz4s7llLiqa+Sb4isXBNHZcYnsus9TaOsXUJIgVE0XpjlRPoC5Xi0s0D
	qP4RB3hGWjN9pVYP3F1Ei2iQ==
X-Google-Smtp-Source: AGHT+IE1gIYZcGblkEjcjzhGPx7ekSZ38Z4/YRTJKsqSyw+yFbUgOc/+hKm7kUfLUBU5JT1QbWfp6g==
X-Received: by 2002:a05:6000:2004:b0:3f7:b7ac:f3d2 with SMTP id ffacd0b85a97d-42cc1d3209amr9257644f8f.43.1763913269369;
        Sun, 23 Nov 2025 07:54:29 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8e54sm23722980f8f.40.2025.11.23.07.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 07:54:28 -0800 (PST)
Date: Sun, 23 Nov 2025 16:54:25 +0100
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
Subject: Re: [PATCH net-next V2 05/14] devlink: Decouple rate storage from
 associated devlink object
Message-ID: <nc6irnyr3vk5gkrdcn25uqm62yfl2yohhixz524inc2jk5czfg@zipw3kl462uy>
References: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
 <1763882580-1295213-6-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1763882580-1295213-6-git-send-email-tariqt@nvidia.com>

Sun, Nov 23, 2025 at 08:22:51AM +0100, tariqt@nvidia.com wrote:
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

