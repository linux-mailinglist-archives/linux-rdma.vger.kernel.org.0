Return-Path: <linux-rdma+bounces-7852-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5817EA3C037
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 14:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83DED3AC7B3
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 13:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC351EA7C2;
	Wed, 19 Feb 2025 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YRdx01fP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B141E833F
	for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2025 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972330; cv=none; b=rVDoHkLki2nlbsZo67vUGnR1yZP2F1VJ36w99foMZ9im/cuh/jXSPQ6gROvpEFih7SUqS+Rb9QSubaeJFitjhatsjVb+jYR+1Xh1QqxBfz9ngoG9bOYs4OugFnpbBgVjGnMztcydbE9LT051npoOJYG2TZgi5K0LlF8MoBoVjM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972330; c=relaxed/simple;
	bh=ww8qhd750yM/3V9soiIqSvERrd7hLK08TNlxdBwyh1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHknAydr6TxQQwqN52PEZg4zczeFp+WApWWneEu1C5v/5Paf/exIAL1a1NX89pc+TcwidMMHpNIEP3FH7KFT7Lu/3AbZQC97erEXOxRal5dEFfGoPO9cC0DRBfvVkVOHhTafw0PT7KNvFLqTFvTo0zDNK81d5OWIOpjRnSB8vd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YRdx01fP; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47210a94356so2073271cf.3
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2025 05:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1739972328; x=1740577128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qmFgtXmk2eQOZz5aocdhBV3sp36pVIgMFye7f82uT/E=;
        b=YRdx01fPrA06dLWOByy7Iyj7An5yKwm7iwNjpeVM7bZeTfa4Jr7/VUFhtjC9MIRqCF
         2cEgMJUXWS8rkV+BdbWbYAU/VL4emmD7fRETcfWZJZ4QArKr2nh8E76sibrU+2e9Xlwi
         r9554nfnAuK/+S9pkapCJ8829hl+sGES+LfD1o9Vuklh24SgrUXEiN8n6ziP5URnsWKn
         WY85RMZyJkDEQC0yrYdRIesDmI9cbHL5zJW/NVZ/H3KIlev1h9l7LIlN3PjHrLCltVjK
         nPnfLM1tPif/dHOn3sFD+ymWR7GyPJ26oeOzFovAs1/oyVNuYtPWUJJX6trSPaxxXVNQ
         8bBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739972328; x=1740577128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmFgtXmk2eQOZz5aocdhBV3sp36pVIgMFye7f82uT/E=;
        b=HHY9hRuepV3p1eqAKOJ9qISodyhoX+W89SEtf+ICSLQjc6fV14PtkGEqBn8JIjBCfk
         gbBLNvfO5Vpvy7ikqUoPUpbCdmN1CUNYyUDIYJEgHPcUcAM6SVymwMBPvFuZh/GFU8In
         XZwzbaIa8crnYTed8KrFy9y682De6NdDrIf1Ezf/fINvAP0Qqko4Pgx0H3FVSRl2xON6
         Hs++H8+8J9mEWoyxTz501nyf93+hVZCbBwl5CMumwsDRAHu0awrTM/cfgFNKg7kVzzcV
         SAgbNT/SGc2Qrc8DL8VmqgwzNt+SYAYQeJ3mAcAdIthGQldIUMHCbSq+I07SimTRtnpH
         h7VA==
X-Gm-Message-State: AOJu0YwQXW5Cq161tIa5WhtNePoUYRPRWnqkpsvW5+nFegWAhCGtfTq5
	mTzXItlAlrAKleWkKeCdRo1eNUGf02BBO9w9sekTcXYz3lY6s87AZboA/nX7vyc=
X-Gm-Gg: ASbGncugy1sFsWxxXPhjyYIUv4suvM4FDBsRjB9ftNO1ZvONElLx9dSsR//wVmYuCOA
	OxPwOzQ1i/Q8HzJA6VRUqIsPz0OliNtDp17m1usVeMPzRdhoA5Eu1V5gAHKtkD+l6zUwjLC6qbi
	rad+jkrUNju4QwS2vC5mNQMhYzOzBR7M1iC/w+ognlciibgY67aOMa/+rb1BBgjFtalfNzjbZFd
	hxGXrxy18TLGRfSJXlHPrDg8xHpSU/hFb8Gyki4/1tN5gG3auv2wPY5iwRsoY7NTgK7GF/HDNwS
	aQ5j3D0vttrqj8cpbS9A4KgUejoXdk/vqCWfTTClkd5qb5MtXodyeeNyRUYsyBlm
X-Google-Smtp-Source: AGHT+IGe+fO3k/hUtSTw1kQddphoKox1ngHNckiz5XU+GRYnYWcN3popRgflLMJK4dFjjHqz9YutFA==
X-Received: by 2002:a05:622a:148d:b0:471:9721:7482 with SMTP id d75a77b69052e-471dbd5616bmr269631021cf.27.1739972328059;
        Wed, 19 Feb 2025 05:38:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471fdf8ac21sm22421101cf.19.2025.02.19.05.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 05:38:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkkHn-0000000067m-05Qh;
	Wed, 19 Feb 2025 09:38:47 -0400
Date: Wed, 19 Feb 2025 09:38:47 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>,
	"zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
	"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
	Joe Klein <joe.klein812@gmail.com>
Subject: Re: [PATCH for-next v9 0/5] On-Demand Paging on SoftRoCE
Message-ID: <20250219133847.GM3696814@ziepe.ca>
References: <20241220100936.2193541-1-matsuda-daisuke@fujitsu.com>
 <CAHjRaAeXCC+AAV+Ne0cJMpZJYxbD8ox28kp966wkdVJLJdSC_g@mail.gmail.com>
 <OS3PR01MB98654FDD5E833D1C409B9C2CE5022@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <OS3PR01MB9865F967A8BE67AE332FC926E5032@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <20250103150546.GD26854@ziepe.ca>
 <CAHjRaAfuTDGP9TKqBWVDE32t0JzE3jpL8WPBpO_iMhrgMS6MFQ@mail.gmail.com>
 <CAHjRaAd+x1DapbWu0eMXdFuVru5Jw8jzTHyXo2-+RSZYUK9vgg@mail.gmail.com>
 <20250113201611.GI26854@ziepe.ca>
 <OS3PR01MB98659E07C0DAA1838FFBC70DE5E92@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <OS3PR01MB98651D06FEFF22AD1CFBABF8E5C52@OS3PR01MB9865.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB98651D06FEFF22AD1CFBABF8E5C52@OS3PR01MB9865.jpnprd01.prod.outlook.com>

On Wed, Feb 19, 2025 at 10:48:25AM +0000, Daisuke Matsuda (Fujitsu) wrote:
> On Thu, Jan 30, 2025 7:52 PM Daisuke Matsuda (Fujitsu):
> > On Tue, Jan 14, 2025 5:16 AM Jason Gunthorpe:
> > > On Mon, Jan 13, 2025 at 02:15:27PM +0100, Joe Klein wrote:
> > >
> > > > > > > Possibly, there was a regression in libibverbs between v39.0-1 and v50.0-2build2.
> > > > > > > We need to take a closer look to resolve the malfunction of rxe on Ubuntu 24.04.
> > > > > >
> > > > > > That's distressing.
> > 
> > I am going to start bisecting the root cause to fix it.
> > It may take a while, so please stay patient.
> 
> On Ubuntu 22.04.5, both v50.0 branch and master branch pass the pyverbs testcases,
> so it is not a regression of libibverbs. However, on Ubuntu 24.04.1, the test causes
> segmentation fault with both branches. The issue looks specific to Ubuntu 24.04.
> 
> Could it be possible the update of python version leads to the
> failure? 

Or a cython update? It certainly could..

So maybe there is nothing to worry about kernel side if the test case
passes on older OS userspace

Jason

