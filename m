Return-Path: <linux-rdma+bounces-6961-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6893A09929
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 19:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A381631EB
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 18:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58D8213E77;
	Fri, 10 Jan 2025 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tFyTCU+a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE932135A5
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jan 2025 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736532999; cv=none; b=IUbm4/fjLU1d8RSvVecHjJA982fnI+3MkAe99xIpflcxQ5NhL5gHsr5FMVLiHtPMi9AC8G1X2w6B27ruB7oQ/8CbYjpn2q3E77CImDzEFxUxsrSISi5YHWHv3o1cDu6Hapj0wuO7V/sSWKFfT4lmOpOWHy+EVvenMZ2G7vzUmmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736532999; c=relaxed/simple;
	bh=j7+PWSvlOCck/O3Hl20ap/chGFVg17VpKs4g+lNfIns=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojAd2dknlMTWtWqm4cgpohruNZilGhterg+VcFSfBYO6t5ajXea85s0Rvu0AnwBm8dBc9d5KK4WdYUX7Y44dl4zWzUBTG+8ZgjV7sWh57wUbAr+8ywLMgMkwznzXLznjn5GqcvQHIkd7i+N3KBZrddU9uDHME8/3wiPP6szMOns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tFyTCU+a; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21a1e6fd923so52708775ad.1
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jan 2025 10:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736532997; x=1737137797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KbmEUgKglVd5Dz/2kVyTyuSVhcq7AQGwm9hyTCDaD6U=;
        b=tFyTCU+aRnJiPUl2YfCUfsFCzblJzwf49CopVSB86citbrOlOCov6vpOfOooR66Xj/
         jjbVw+6kzVBialyywPGGNiaRawrK0B892Amf/gSxlghDS/gZbsbsXAYZsEXkh82Z4ty5
         uxuPQKXop6ZEXAv5PDOV4/bcNsrBRYckxuHLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736532997; x=1737137797;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KbmEUgKglVd5Dz/2kVyTyuSVhcq7AQGwm9hyTCDaD6U=;
        b=Dk57kHtJJh6HPqhuLJJnr/1a2HxnfpYSMCcFcZ4QGwlkOkyYuyfEjR8Xsx/d9/myAk
         tq97CRguC4tOeWtHnrAyPboLvrz1+aNz3iapytcfOvMcEfGBrTS+FhfdpTImvs8s63aw
         SY7hOMBT2ZQjOtbT/f4g/IXmVmLpyTaR7dRwOgfozwVbyakorHRyqA+DmbEfMY2bFZB4
         c8vE2MDQzpuKtoIBJdilGBIYzFGW8sQTXZ5muOFbWUJLF8kfYDYTbwAjtO4MKMpfIQi6
         Vr4yVrhlvCIoT/dP8Ze84mlNDtdqPvjwuANmmBEBI0gwu724L/ZDhpX4Gau/oOSk0Yu0
         10uA==
X-Forwarded-Encrypted: i=1; AJvYcCWO7JvVngpcH4+xyJUoVvykP2vwuyIt4C6vS0UPNP9xK4oijgp0qpsrgsljBBO5MbRZNg/jH313ja7j@vger.kernel.org
X-Gm-Message-State: AOJu0YxG1MCWAF1v2Nq2215GF8VjEDsXh5YMNPnPF2UhLfKyI+HRnfan
	0C4EzDtsfaNzjZwGJeyNklrKwRdBcNQRIn8Ht4jN90Xvub42lY2ELq/7xEJfOZo=
X-Gm-Gg: ASbGncsm1Oy8H/vISDDYEFwClqiaOdaAEFYWjBVBiEsspYtaaI9uCP3v4yNYXV9GNu0
	bEfhYTK1CN/74bjTi/xGjM142xKVirdbh/2OZGeleyf5YZ4Vl+jNKOD8b/D8jDDdgwaX19J1JWi
	Pcf71zhu1zEweXvuRrlboGKzYn3QHlaRv6F5dudSUah9WW+3sIUdy/p0i3IULuOWXrnJlaKR6IZ
	3r+BOUJB1o6NKN0lzOG6mcB+SltHYioZOh4NJcvM5XJSbebKl9mNKg90UxZYJBEJRnUSRyfXv2T
	7Fd4NYv7wNecUz4YoluBY7M=
X-Google-Smtp-Source: AGHT+IHruBHu1QGg5HyjhzVxD0L/TVoRooPSp2PmMzqzxAYvF3+4hYN4Rj0/zrOgu8RbdwJ9g9q9Rg==
X-Received: by 2002:a05:6a20:918d:b0:1e0:f05b:e727 with SMTP id adf61e73a8af0-1e88d0e63a6mr18792600637.2.1736532997494;
        Fri, 10 Jan 2025 10:16:37 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a5384sm1795023b3a.157.2025.01.10.10.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 10:16:37 -0800 (PST)
Date: Fri, 10 Jan 2025 10:16:33 -0800
From: Joe Damato <jdamato@fastly.com>
To: Alex Lazar <alazar@nvidia.com>,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
	"almasrymina@google.com" <almasrymina@google.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>,
	"bjorn@rivosinc.com" <bjorn@rivosinc.com>,
	Dan Jurgens <danielj@nvidia.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"hawk@kernel.org" <hawk@kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"johannes.berg@intel.com" <johannes.berg@intel.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"leitao@debian.org" <leitao@debian.org>,
	"leon@kernel.org" <leon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>,
	"mkarsten@uwaterloo.ca" <mkarsten@uwaterloo.ca>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"skhawaja@google.com" <skhawaja@google.com>,
	"sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	Gal Pressman <gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
	Dror Tennenbaum <drort@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [net-next v6 0/9] Add support for per-NAPI config via netlink
Message-ID: <Z4FkAZkNnySdjdRb@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Alex Lazar <alazar@nvidia.com>,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
	"almasrymina@google.com" <almasrymina@google.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>,
	"bjorn@rivosinc.com" <bjorn@rivosinc.com>,
	Dan Jurgens <danielj@nvidia.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"hawk@kernel.org" <hawk@kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"johannes.berg@intel.com" <johannes.berg@intel.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"leitao@debian.org" <leitao@debian.org>,
	"leon@kernel.org" <leon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>,
	"mkarsten@uwaterloo.ca" <mkarsten@uwaterloo.ca>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"skhawaja@google.com" <skhawaja@google.com>,
	"sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	Gal Pressman <gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
	Dror Tennenbaum <drort@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
References: <DM8PR12MB5447837576EA58F490D6D4BFAD052@DM8PR12MB5447.namprd12.prod.outlook.com>
 <Z2MBqrc2FM2rizqP@LQ3V64L9R2>
 <Z2WsJtaBpBqJFXeO@LQ3V64L9R2>
 <550af81b-6d62-4fc3-9df3-2d74989f4ca0@nvidia.com>
 <Z3Kuu44L0ZcnavQF@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3Kuu44L0ZcnavQF@LQ3V64L9R2>

On Mon, Dec 30, 2024 at 09:31:23AM -0500, Joe Damato wrote:
> On Mon, Dec 23, 2024 at 08:17:08AM +0000, Alex Lazar wrote:
> > 

[...]

> > 
> > Hi Joe,
> > 
> > Thanks for the quick response.
> > Comments inline, If you need more details or further clarification, 
> > please let me know.
> 
> As mentioned above and in my previous emails: please provide lot
> more detail and make it as easy as possible for me to reproduce this
> issue with the simplest reproducer possible and a much more detailed
> explanation.
> 
> Please note: I will be out of the office until Jan 9 so my responses
> will be limited until then.

Just to follow up on this for anyone who missed the other thread,
Stanislav proposed a patch which _might_ fix the issue being hit
here.

Please see [1], try that patch, and report back if that patch fixes
the issue.

Thanks.

[1]: https://lore.kernel.org/netdev/20250109003436.2829560-1-sdf@fomichev.me/

