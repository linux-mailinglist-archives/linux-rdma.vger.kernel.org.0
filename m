Return-Path: <linux-rdma+bounces-10718-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0F3AC3D16
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 11:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4222C7A2FD6
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 09:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC05F1F1306;
	Mon, 26 May 2025 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ULKLb1Y0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41301D61B7
	for <linux-rdma@vger.kernel.org>; Mon, 26 May 2025 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748252514; cv=none; b=BPR0hOlQgYvLC193Gok6aq86aE5bmp9NlKrG1xUgXlex6x+Gi2/zVwLlo5JCHB5LmKeZ69jvYydPul3E8QnUi/0/7mjj/LYLm+AQx/OjqZG6MTwn2746d4zgpv4hT7XXd5tZZhq87RMY96Izwi/spEBjo5Q4p2xBgCwnJG4jGLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748252514; c=relaxed/simple;
	bh=lJmA+auFBQfr1DUILoMWF+XAhP7fsD7jdarK60rySkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6slaWMkOU+wDwKbT702YW3RbJ5Z5G4i+cFVv/J+iusg0S0tzADDens3BcMXoQXRxYq+b7Qzk0YR7Zln8Hi2HusVlD0YeRiX5F66Dee4FvmRebXdsLZ3pQyeKfViBlMb6qsF7Ck+5mwMNWrL6EsNhnbeV3DdTfPLyG/VTpYEVek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ULKLb1Y0; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-442f5b3c710so19656835e9.1
        for <linux-rdma@vger.kernel.org>; Mon, 26 May 2025 02:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1748252511; x=1748857311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lJmA+auFBQfr1DUILoMWF+XAhP7fsD7jdarK60rySkY=;
        b=ULKLb1Y0ez7RS9jMxEVhsdBLdc0jTgRJGQhUdDJQCk0qrC3ApckvdWLtbZAUGYDk7T
         mo76WYDNhNbfk0Wpkgb+LOzaYgoadbFNRMn0tx8H7pOawpNnJI26UyED5Tr5jn+I9CpR
         nl5UTXtdp2L8sm6rYiC/GrTBXGoX9MUk3KAL9qU9BIeWOfICkgmMXeZtIW3unxgvm8VM
         ls+EFFKG+HhKcB88FJfI8y6Qy/thi8Ye5Le2Ud01UZgPTTIrr5w5RpLRxIMxScOFZIyL
         oprEQ9lP97H6vACxaiifE8TJEt0ElyOiQ5HfSsYXZdvASwYeIUvgmxXv0aTYR5dUwa84
         8bbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748252511; x=1748857311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJmA+auFBQfr1DUILoMWF+XAhP7fsD7jdarK60rySkY=;
        b=Hc+DCkFpywVGthsYEji1NYYsEUf07n662EMVOHzset4HSzMWaADL2z/apRDjBc2s+l
         Mn7Jk8JhZ0qMjeViDZGxfA/uUvZ9RP+mQBOCJz1+3iiHx9xJL/TQrTMThulZhAw+SJUD
         0zAojT12UsZ9/pE9fQ8ejOfqDQla5t7bPIFZxaapTnVLYfiK5xE+XcDWnOR0pGSHsJmb
         DLxFfG304OFlqbzrTnKdaMhnJ3Uy07s3vaz1PYN/JJO1lw0oMEVqIDWtNEOu7lZuQl7m
         DI602Lzb/iQyNfrypkZFtJTIagXs1qsJJWe6SsbdAsmbme1lR3vJHrjH5CvhzS1tfcYo
         /2qA==
X-Forwarded-Encrypted: i=1; AJvYcCW/PD3/yWeZ5JND5DYZRG3XtiPUZexsmF7SCEeCxiPzo4KRtXD7qjoRh1yaJYlfaqkgQpxG/xogFDBk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2I3LNjXZs8OXHfSBCCkzcSeI/FJ1vTyXIrJlrhqSqqzuOtuaw
	IPtLTXq/0SRIBaYQ/zL5up1GDgxqc8+A1Hk87Ao6yqIoZWn6m3CjtA1zN/ZMKQC+lLw=
X-Gm-Gg: ASbGncvoHrXmp81pNs3CtM6cgc0/3L3ej2jNCaHfIZ4h9FuriHMXr8hB610ls2Iv60n
	mhvh8cgeYJZJkt6aZ2FgiiZP/VLp1VJeHjsxat9BgvzSvkwkepRoRUasGppON9BzF3mTIVojPbw
	QIF8sFYa5vGMsicPul5TItfB+i/OBz1l6/6Bg+Gpp+coMacoKUVKCHVAP0nP3y4+3eUnPwQLv2P
	D3eAav+OwKQG4UnleZevQD5K/ky5WCBIPaFfDciZ4KcnQKqh+X457v88tDmHf5eVp5YXAfSi0BU
	YuzcTFik9ygvBe+idHUBbGHasK+XWB9KfZQdPE5Gmq15vukMNpkLzq1/Q3pdj/zKAkzJIw55GTa
	N/UE=
X-Google-Smtp-Source: AGHT+IG8qcPgCe6g3rQUfM8YImSTE9FHiPfLbOy9uip4wVp1I8BHWjPMZtQYgrJU5MVy0rx4F64Wvg==
X-Received: by 2002:a05:6000:25c8:b0:3a4:d0fe:42ae with SMTP id ffacd0b85a97d-3a4d0fe4e5emr6093907f8f.10.1748252511231;
        Mon, 26 May 2025 02:41:51 -0700 (PDT)
Received: from jiri-mlt (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d56641absm3767945f8f.4.2025.05.26.02.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 02:41:50 -0700 (PDT)
Date: Mon, 26 May 2025 11:41:48 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, 
	aleksandr.loktionov@intel.com, corbet@lwn.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org, 
	linux-doc@vger.kernel.org, Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH net-next v4 2/3] dpll: add reference sync get/set
Message-ID: <3csutdtlt43m2jcfs5y6g7ih6hmfb5z63u3m5as2oi33cefkgl@dyk2ayd7anso>
References: <20250523172650.1517164-1-arkadiusz.kubalewski@intel.com>
 <20250523172650.1517164-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523172650.1517164-3-arkadiusz.kubalewski@intel.com>

Fri, May 23, 2025 at 07:26:49PM +0200, arkadiusz.kubalewski@intel.com wrote:
>Define function for reference sync pin registration and callback ops to
>set/get current feature state.
>
>Implement netlink handler to fill netlink messages with reference sync
>pin configuration of capable pins (pin-get).
>
>Implement netlink handler to call proper ops and configure reference
>sync pin state (pin-set).
>
>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Reviewed-by: Milena Olech <milena.olech@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

