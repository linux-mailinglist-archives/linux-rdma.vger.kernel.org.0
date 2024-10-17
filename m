Return-Path: <linux-rdma+bounces-5451-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E41A9A2DCC
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2024 21:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8809DB24A6B
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2024 19:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6156227B97;
	Thu, 17 Oct 2024 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HT1t46N+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69DD227B96
	for <linux-rdma@vger.kernel.org>; Thu, 17 Oct 2024 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729193283; cv=none; b=VlJId6BthcDNZLyzOH0Fb6qmwv5KiHMWLNbAi+ZFRkV4C7LeCX+UB2VNLLE2dSmV66EWHDrG0YqlTJmwskcqGaX/Vk0j5yTvWbzdYy1NK6EtDnmyGybW+zF3MP5Pqe6/rk7AW9zk2AycJYgc0YG9bZwhcMYF7kDxDR/2Qd7vLTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729193283; c=relaxed/simple;
	bh=DYaBD1smhDImlEtRtnDp1C2vYjtmdoR9Ir7CbYzgY70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piZdGYJTo2R2rOgCdMhpCZg74WSn5mLTVP3kdEKahm94K/I8LPI2a36lu+AvfXHribPkqeAlplm5neEmNtb5G3L5b4gnRhIKV2TsMibR8C5T4BT+kFKKPTPlscPJoGEPn0dwvj/aGN9OfilwHCDoD/GJBOpCByBp5y3J1uXRn4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HT1t46N+; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460414d5250so10124131cf.0
        for <linux-rdma@vger.kernel.org>; Thu, 17 Oct 2024 12:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729193280; x=1729798080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QKztc68P1GiWB5LrK4Q2I6nYf1n+uL5P1Nl/QmLdvZk=;
        b=HT1t46N+c3O+RMDoBhrYPPG2yUaqXVuUHQFwRSibjryDBFZwBXv/p1bVMKqvAyJ3LE
         gQT8OylV6EFXAtnnmRyUiht2VENl41qR+/EuUF/KnTQkrGPeWHSMB75E511CW9W8TmdH
         xmAZYWndiQ9meqq3RT8oFCcCWqj7/Vb6RDgP1W3VzXeQQrSojYlZZOHNvcbhQxjm5LlO
         i0Pxj2bLGJO12I+fbMSWioVwVHUzj1kbCPv09MyQYN2ONkPQL94G2tgARBvtrvgnz3BE
         2cqgp7+cE4Rpm0T4xLOFrXQtfenvegVlEMu0V63bRao/39itqYDRd1t1F41j+2PgSgOp
         Silw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729193280; x=1729798080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKztc68P1GiWB5LrK4Q2I6nYf1n+uL5P1Nl/QmLdvZk=;
        b=FE+rXUgnBfxZ3OOL0BXa1kmNoIe8OfEoNXFtU2laVnZdQs7wcQ5nnO1Hvp6KVR9exn
         NzgoLcfM0ORc/GWlpuf+1ZdUhsYoY9yTuEvNI73hwg3RFPv0e+gRkUapjS1hVyxXry5I
         MHT5Cd8Y+hXmKWtzp7e2RgX7/h2f+Wl71Ob7t322P3u117VzoBkRkAZOWJAPEgEEWsih
         A9YaKimgZpvsxgFTlq3qg5jt1lY5Mz0LTgEphJnpAx9to1vEs6+0KAb/SpfChusacqRN
         82vTMqQAonXwInxetoTQHl7/w7GxTkBXhlsm4LcsM/ZAJTMcUIOuvBtR/nuHLCPpkQTb
         bcfg==
X-Gm-Message-State: AOJu0Yzdzte0yrlgShrlzSMwI/jYB8UyElIBwkKBRb+GS190K0Tsfvwk
	ccQtzt7Bx0gQbKP9cpwrpYIT8er8fLaXw+nQUexTLLrHSEnKGw8VYcoLPZB/rB2SnkPkRMgUjZS
	Q
X-Google-Smtp-Source: AGHT+IGHpRlR1WODf6TO074C3dG1TQmfT7rOPQMZN8r/XlTSeridiVkBkPMiYkzYHJHKcuDMpCqqbw==
X-Received: by 2002:a05:622a:4819:b0:460:9ff9:6b41 with SMTP id d75a77b69052e-4609ff9710amr43875291cf.28.1729193280305;
        Thu, 17 Oct 2024 12:28:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b0a28e2sm30392291cf.1.2024.10.17.12.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:27:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1WAB-004nhW-9m;
	Thu, 17 Oct 2024 16:27:59 -0300
Date: Thu, 17 Oct 2024 16:27:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, zyjzyj2000@gmail.com,
	linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
	lizhijian@fujitsu.com
Subject: Re: [PATCH for-next v8 0/6] On-Demand Paging on SoftRoCE
Message-ID: <20241017192759.GC948948@ziepe.ca>
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>

On Wed, Oct 09, 2024 at 10:58:57AM +0900, Daisuke Matsuda wrote:
> This patch series implements the On-Demand Paging feature on SoftRoCE(rxe)
> driver, which has been available only in mlx5 driver[1] so far.
> 
> This series has been blocked because of the hang issue of srp 002 test[2],
> which was believed to be caused after applying the commit 9b4b7c1f9f54
> ("RDMA/rxe: Add workqueue support for rxe tasks"). My patches are dependent
> on the commit because the ODP feature requires sleeping in kernel space,
> and it is impossible with the former tasklet implementation.
> 
> According to the original reporter[3], the hang issue is already gone in
> v6.10. Additionally, tasklet is marked deprecated[4]. I think the rxe
> driver is ready to accept this series since there is no longer any reason
> to consider reverting back to the old tasklet.

Okay, and it seems we are just ignoring the rxe bugs these days, so
why not? Lets look at it

Jason

