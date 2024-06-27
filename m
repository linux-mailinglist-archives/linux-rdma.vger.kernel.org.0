Return-Path: <linux-rdma+bounces-3545-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4ED91AB3C
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 17:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743221F29290
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 15:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59445198E69;
	Thu, 27 Jun 2024 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="HDkrenRc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00F9198A2E
	for <linux-rdma@vger.kernel.org>; Thu, 27 Jun 2024 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502069; cv=none; b=cA7LnBWw9JuA/ATSlP+HQsG5VDgR8gAYI/NJTgc0to3jxfngA0lpLYbYEauKhzk2LmW2LrPrEcAL/9LgJhCNTdXAuzFh1N1VMNG4dwKTLFBuKoAkQM1nGNXcJNPoshqAQ1JUfUaVU8fZFD9FUBj4PbqKP6fFjLAiOX5sCpwHpiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502069; c=relaxed/simple;
	bh=MCcKh+Te3MluMt/hBoNCtQN0lNaNkAplmbKTwZRlgkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDo67Wure3U7jje+LfEotG76bkEhHc1y9SVakUfSffB6XqYxwcSjTVi3csvPxoSYe+BLq0tkS6idFponComkJUS3xNCLFU393L2tztcpd6pmz8yOp+DjpSoQfyQ2hs0/S7+O/3BPK2+vJ+LjjME0ndkPPnA4rZDECvrFLEf60C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=HDkrenRc; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c5362c7c0bso5906107a91.1
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jun 2024 08:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1719502067; x=1720106867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9itoRg4hkzQHK7gOStndwazEBaHhxM4RVlJuAwijkSU=;
        b=HDkrenRcNPZMhMx/GWFDcT9rfC+ph9jmU+aHI4xpM8nRwtfPCtdgqn0MsVCeakEKkn
         uBEJnTUfM/dTbSFnHUdS8Bh6Tf4ItTabqBESpTUeIuH0TdvmMhXn34GhPHZXYJMjjCk2
         LMJp/IKxnWtUCOx1ks1lUq+4390u7vUigOuZfq6/GTlQxKJWzU+UgGXiV3GXXCz1gYDm
         uHLsSLXwmV8g5fNlWPc0QzFV5VdepDTlQK9YWEwo1D6X0Pei61AmsmCZofRczf7RUUdC
         ixXVydiX40J0mTz40edcK4jWlhpQIT0nBp1CedsPb6E46m3NpEcj3FXDQAsQlQ5KBYg0
         svjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719502067; x=1720106867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9itoRg4hkzQHK7gOStndwazEBaHhxM4RVlJuAwijkSU=;
        b=d+SOCCrwuIqeUTIT20MTdCsXvLzkAstHiLuvWtkJLjOVdrt6QHbUnmiIzmwhpnWhA0
         SMUAPH0KAvwLIfqcNMBOxA+A8d52z0KeC3U94CbLr3Swls7GNoMyVDb/m2GJlr13GCfI
         DUEBo/xD00lLb0hPnnohKZlei7VdeTSXt/Fip1ojnC9FUvyF4XrAF8UuW47ptU/8wFIi
         gtvwOQhuRiEqlv0q+s3Q+n0qzxzepfOAMpo9vnC2v49oKhSlderZbgDxgLmiBUkXzEz2
         /3FccxNRMt5ReEipCjPgtBcl/m4SmPJogYr5dB9LLf09/zVk9p/Gb+gplFzdIVNFTrPq
         OnIg==
X-Forwarded-Encrypted: i=1; AJvYcCUYLHLLJiOunjrZBw8mkGvKF+XSmRojKS/SxjuAf86FDNT9EV4GTtV+J/szamI+ohdVWLjxtJoeBGd898SXglfvCnC65xPnCQPVVQ==
X-Gm-Message-State: AOJu0YwNBrLQpPZ8+BL/ShP9NqBTQzJ1pO5OkrspZuY3KJ1BkCmH/QEf
	Y06HqZ+okgC4IgyA3a1Zvf9TDRn2ZBpFXu2OknVh8+yUg3ZSH98I74Qg/a8LQvE=
X-Google-Smtp-Source: AGHT+IEke9+TTjnHY0SqzOq3H8948zV45u3a0yDIPz5OgX6h8hhkaHXP8IkjUcvJX+T+68y/MGmHww==
X-Received: by 2002:a17:90a:d084:b0:2c7:35f6:87e5 with SMTP id 98e67ed59e1d1-2c8612c6c27mr12214771a91.5.1719502067064;
        Thu, 27 Jun 2024 08:27:47 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c906f38b11sm1344533a91.28.2024.06.27.08.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:27:46 -0700 (PDT)
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

