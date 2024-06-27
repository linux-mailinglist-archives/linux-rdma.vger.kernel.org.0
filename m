Return-Path: <linux-rdma+bounces-3549-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C62791AD65
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 19:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49E128142C
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 17:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB03433B3;
	Thu, 27 Jun 2024 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="M0qfVKXq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6643819538B
	for <linux-rdma@vger.kernel.org>; Thu, 27 Jun 2024 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508042; cv=none; b=hVOidL7lUGuSdS/HibPLmLm8fdgE8hot/5aNe5vZWXi8/tiHZ0kLku0z1VgoaIws125BOWVmvTHuHHTULeMpRGAgRVdMq3HxlU9TI45v6lvrDVjc6aa1cQYNA3NolFn7VpYlrDsH1hoG5K6QSl9hSeobtJqkY924TJ4e6B1/jJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508042; c=relaxed/simple;
	bh=MCcKh+Te3MluMt/hBoNCtQN0lNaNkAplmbKTwZRlgkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8ta2O8x8XYVNCVJbwO+rLQnMRKNChP5WJYT6Bk9FotZ+xQver0nwiVKoJ5egOUgSP2eYqXNsgPvAYvtfAdx6OIDVG8fLzKnyZ9QjscDc8UQOEA1vvBISEQhv5SXJ6HgYs8dDdrTs0ZfWhsdrKwSxRJldqxztjhFTF4fpc01lzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=M0qfVKXq; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-706b14044cbso1086701b3a.2
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jun 2024 10:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1719508041; x=1720112841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9itoRg4hkzQHK7gOStndwazEBaHhxM4RVlJuAwijkSU=;
        b=M0qfVKXq78IIZtTkV5/LaxC3UwRa9Kc8doK5uTZOsK+oKlX2ruNDJBSr2RITtzTSNM
         gCD9tszHdzIvZtXXv2P9XTUc6aiTZL3I3CXWjb0PIk7XEP5sMt6tiGwjkd/CeGbVgfPQ
         2RIIK9s9U0oSgLsaC05vsNTgpdV2n+36FJ/0ZAEelv7CXpTeeW7UjqwruFwLMr5jCQnV
         k3DXGxo8ASy6X+oL5qkKOn38zLeFrdpS3jjOz8xSutwqgn5UX4sxfhrDBJb675rGn1XH
         sqmcTnZ8JpFBp3UCytaCVRPHgPE1LLCSN1mQxCeOt+OrkDAFclxfCHGW7+GRpe/BpbFr
         EUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719508041; x=1720112841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9itoRg4hkzQHK7gOStndwazEBaHhxM4RVlJuAwijkSU=;
        b=OYvAsNcaD7GdEDEshSRl/hZqc4zkFcBXaHgp1UB8wLadxFESQDeDVA8Pyj6B0shdjH
         3uI4Y2uHrjZGx2TkBS3uC9Tkq/02nV2cYlZEeKfBpAYeaD6+CaBODDSXqs5i4JiyXDIS
         gYOQ2Dj0yrqP+I0qiquAbtzCce3NURgWAhN3AHPt5RZ9cL9clP1YprkJRPmTpqZ7A9O9
         pLLCtMZmS3/5gU50Nr94H2qEjXaZLusK4f27FNa+JLWbnUwqmJblL1DK45v0w1ba+nqm
         iqB+J03GhlsQ0U6KCoaSppzbBNyoyyQqE0MYvb991mH0kV5V45Gs31ewqpJcpQsM4vsU
         wa2A==
X-Forwarded-Encrypted: i=1; AJvYcCWfqwH68PhS+e8B5e3u0IIBBPfKxcyKz2c8U2l1FQX8CGoQ7zGRMs3+xC3llyKs3kQKUV/vJ9FZ46Jn3xBTuMDLlacGbKTxtKa/2A==
X-Gm-Message-State: AOJu0Yw36jY28J7pSHT2toEMhbGwifv12DLHtrMxkelFL6FTxOWtqy7L
	C2BDxkAZFPmUDtmChlJGgfo0VO8NrzMghIBxaR6WBuk2dJnAd2FdKht1wVIb5xQ=
X-Google-Smtp-Source: AGHT+IFpNuiNgxpmzlSpuqFYbix4luPl2w3Bf0ulkgdIpoHogyqVFmqi8C1JTY0bqbYLbJEb+HBeUw==
X-Received: by 2002:a05:6a20:6521:b0:1bd:2358:8c8d with SMTP id adf61e73a8af0-1bd23588dc9mr7330031637.29.1719508040452;
        Thu, 27 Jun 2024 10:07:20 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac8f268bsm15650425ad.74.2024.06.27.10.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:07:20 -0700 (PDT)
Date: Thu, 27 Jun 2024 08:27:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Leon Romanovsky <leon@kernel.org>, Haiyang Zhang
 <haiyangz@microsoft.com>, Konstantin Taranov
 <kotaranov@linux.microsoft.com>, Wei Hu <weh@microsoft.com>,
 "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, Long Li
 <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, linux-netdev
 <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into ib
Message-ID: <20240627082736.34ded856@hermes.local>
In-Reply-To: <PAXPR83MB05596705E21C2869A4FA6919B4D72@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <1719311307-7920-1-git-send-email-kotaranov@linux.microsoft.com>
	<20240626054748.GN29266@unreal>
	<PAXPR83MB0559F4678E73B0091A8ADFBBB4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
	<20240626121118.GP29266@unreal>
	<20240626082731.70d064bb@hermes.local>
	<20240626153354.GQ29266@unreal>
	<20240626091028.1948b223@hermes.local>
	<PAXPR83MB05592AE537E11C9026E268F7B4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
	<DM6PR21MB14819FB76960139B7027D1EECAD62@DM6PR21MB1481.namprd21.prod.outlook.com>
	<20240627095705.GS29266@unreal>
	<PAXPR83MB05596705E21C2869A4FA6919B4D72@PAXPR83MB0559.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 10:44:02 +0000
Konstantin Taranov <kotaranov@microsoft.com> wrote:

> > 
> > I don't want to be first and only one driver that uses this flag outside of
> > netdev. So please add new function to netdev part of mana driver to return
> > right ndev.
> > 
> > Something like that:
> > struct net_device *mana__get_netdev(struct mana_context *mc) {
> > 	struct net_device *ndev;
> > 
> > 	if (mana_ndev_is_slave(mc->ports[0]))
> > 		ndev = netdev_master_upper_dev_get_rcu(mc->ports[0]);
> > 	else
> > 		ndev = mc->ports[0];
> > 
> > 	return ndev;
> > }
> > 
> > And get Acks from netdev maintainers (Jakub, David, Eric, Paolo).  
> 
> Ok. Makes sense.
> I will just call it more exact:
> mana_get_not_slave_netdev_rcu()

Please don't introduce more usages of the term "slave".
Better to stick to VF.

