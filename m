Return-Path: <linux-rdma+bounces-1390-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5CF87842B
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 16:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EBE2B215ED
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 15:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6B344393;
	Mon, 11 Mar 2024 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="uvhuxONZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7698446B3
	for <linux-rdma@vger.kernel.org>; Mon, 11 Mar 2024 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172197; cv=none; b=GZRa7+/yxmdjT9jIdJh2B3Rij9INCJXTreE+EuTIoLp306WPckN2/7443NfKzgU26PvS8TcT6tBo3kSXCNsCdQnCScSaQBpWonfpl5dXKCGPAQ2qLa87bADAjapU3wv7n1MPs9sgqzE0KA7dgYQwPWQHjlX1drtSQs51fw2pfzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172197; c=relaxed/simple;
	bh=540orTLqH26liId0CGC0Q/FWP36fwWOz7fNBb2i9ZjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2oA3vY/5M0VNIdBCZrYJUgQwQlIS9zu0APnU7y1YeVw69LyBULvJl6jPRTv1DIhURIUkFyBPaZlFE8rJEV3iY8gXdv+fHt3Su5bmywOfDrXEEMPf2JP9GRxyeHOlndYAyriIDok+kkNp2r/LAKiLUDzILGjJdDAk7Vm3nkPsnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=uvhuxONZ; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bbbc6e51d0so2257464b6e.3
        for <linux-rdma@vger.kernel.org>; Mon, 11 Mar 2024 08:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710172195; x=1710776995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+Wtwgm/ud4Teqcm7McoWzRYdR5joosf5QXB8q6Nk6I=;
        b=uvhuxONZedNAo3GtDxK6XQvovopD1Ijh+J/vIb3ZBiqmUccQhKBatJbWSpR5kwqkBA
         JSjTWLqNc7z6WZmFjhAGmNXr4PrYPQJfEUtMQXbNiBHHEaY9zHnUx8jAiPyKC5SD5Zr+
         YxVZX5XpADeS+HqOthRmlOlpj03iZAyxN74IwxAcCMPDfSwGQq0PTwgeEpmr+sEClimm
         VOhVjGrPUx+USHJOzmre8LagfPio2IsZb9JhmcBXp1dz0NrljxrH8x6M/X2MttUPX8wX
         E3U2Kl5uTojOt0Dy1EOLn4taPG7obOwct0HX5JOH6POlCu51F5IStcN3X7nNgjr+iRaF
         2bHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710172195; x=1710776995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+Wtwgm/ud4Teqcm7McoWzRYdR5joosf5QXB8q6Nk6I=;
        b=fhtnRX/EDrqm+8LgotD1M2i4ntEkLuc+CK/8XGQ4PXoSn2NkSEeWMPLYK3Qkmydtzw
         AA5E7i1MtNX5x8LlKVeG9GlInAOd+ErfoC2ZU1vVKAckrAQJ1MpTOPhoiECzmij1L9FH
         aFabZSoClNr77kXSJP9k2bm9IHI2l4YmLhXenBK+HNu5Ujp4BVfIwrb/WtaLhSffMr5t
         75alfl69GFSYEiW7oNaba0N+TDr1MXiNQrxgigADPIj6dO5HbpNli3E0mwKsRonpUe60
         ffHVw6TDTUthVS6hQ//MiydSrccLGxnneuxcdeuYU/G+Iv4Mz31PCRUne9/bDQAtj6Z4
         8jRw==
X-Forwarded-Encrypted: i=1; AJvYcCULARH/WPdT1jxV43sPCsj1wSghqGcbIbsRKu2/NTq1g5qcpZ5SQQunN1TIaVvY8yolg9arWoFtdnSCmKaieuDqkO8KUE5++svw5A==
X-Gm-Message-State: AOJu0Yx72WCs9sBwmOVc05HkefF6OhJnQFLEc8m9Eg34RUwFs8neQmy0
	YDwQaSgb9SGTTqwPvDiOlOHs5lfpNH5RdZjoO3z6MuCAa2K+ygKLrW04gzp7CFs=
X-Google-Smtp-Source: AGHT+IGn/4xKoBd1SYHfu6mVj6p5jAAE0MdJYK4ZZdUXmc3Vj7qqayvCjJPox671NbLnFAYatzWyPg==
X-Received: by 2002:a05:6808:1406:b0:3c2:2cd7:2417 with SMTP id w6-20020a056808140600b003c22cd72417mr8036293oiv.36.1710172194760;
        Mon, 11 Mar 2024 08:49:54 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id b17-20020a637151000000b005cfbf96c733sm4509856pgn.30.2024.03.11.08.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 08:49:54 -0700 (PDT)
Date: Mon, 11 Mar 2024 08:49:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Haiyang Zhang
 <haiyangz@microsoft.com>, Shradha Gupta <shradhagupta@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ajay Sharma
 <sharmaajay@microsoft.com>, Leon Romanovsky <leon@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, KY Srinivasan <kys@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
 <longli@microsoft.com>, Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] net :mana : Add per-cpu stats for MANA device
Message-ID: <20240311084952.643dba6e@hermes.local>
In-Reply-To: <20240311041950.GA19647@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
	<20240307072923.6cc8a2ba@kernel.org>
	<DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
	<20240307090145.2fc7aa2e@kernel.org>
	<CH2PR21MB1480D3ACADFFD2FC3B1BB7ECCA272@CH2PR21MB1480.namprd21.prod.outlook.com>
	<20240308112244.391b3779@kernel.org>
	<20240311041950.GA19647@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Mar 2024 21:19:50 -0700
Shradha Gupta <shradhagupta@linux.microsoft.com> wrote:

> On Fri, Mar 08, 2024 at 11:22:44AM -0800, Jakub Kicinski wrote:
> > On Fri, 8 Mar 2024 18:51:58 +0000 Haiyang Zhang wrote:  
> > > > Dynamic is a bit of an exaggeration, right? On a well-configured system
> > > > each CPU should use a single queue assigned thru XPS. And for manual
> > > > debug bpftrace should serve the purpose quite well.    
> > > 
> > > Some programs, like irqbalancer can dynamically change the CPU affinity, 
> > > so we want to add the per-CPU counters for better understanding of the CPU 
> > > usage.  
> > 
> > Do you have experimental data showing this making a difference
> > in production?  
> Sure, will try to get that data for this discussion
> > 
> > Seems unlikely, but if it does work we should enable it for all
> > devices, no driver by driver.  
> You mean, if the usecase seems valid we should try to extend the framework
> mentioned by Rahul (https://lore.kernel.org/lkml/20240307072923.6cc8a2ba@kernel.org/)
> to include these stats as well?
> Will explore this a bit more and update. Thanks.
> 

Remember, statistics aren't free, and even per-cpu stats end up taking cache space.

