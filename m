Return-Path: <linux-rdma+bounces-4755-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DF296C369
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 18:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94AA8282EAD
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 16:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F571DFE33;
	Wed,  4 Sep 2024 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OYsZzubX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935181DFE3F
	for <linux-rdma@vger.kernel.org>; Wed,  4 Sep 2024 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465973; cv=none; b=j80I2GLFG4fRjTlvkoxgG/3I2IGs6HujLacN9rPf+d4/XY1eBXBPaSPi3STJktFZqbl2qUPLRz0g6sqK3LHmuTJoOyvOG3oWQJNzBj5b5EQi491lQdrCbw3KYW/IfJPtg2sH/8kPMVqo+mD8fD+DrVTlHy3CCJdPyXaq6hfjzZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465973; c=relaxed/simple;
	bh=nLnnSlH7pOjezaLS9PtUh4A11BKnHjaex6cyF+ngofA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJBP4V0cOk4a2Bv7kJVJ63Cv0paVtbFUFgjbrEz0jdHO8dU4ME6aTYv3nEvdGeuJK1DPfeLwIV9m8Z6oDYOpRYtDDkxs7cNR4p1V+GvhVRm0sD5btcTyDUcQivSuHnj/ub7OI4IE5lqi4rK8acVXQ4ZLMGLxzDfpPPLnzkZ0TBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OYsZzubX; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-45677965a3cso19036861cf.0
        for <linux-rdma@vger.kernel.org>; Wed, 04 Sep 2024 09:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1725465970; x=1726070770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B7+tUQJ84hFnBDqdEneCvm+eprIjG794ZYCpOyBa7Jk=;
        b=OYsZzubXJQnAXcdMY9gJ5Uw5znMpgS6p4pPhHjEISev4rpJmEoSlg91f58gQnWqgRm
         XT9K3fRx+qkIxS2L0Isn1zbyuMpmm/1fZ3sc0N9c2qbxG2OhvzH/cB58ohgZPFi7dqMb
         HYo9sw+IUYWA2Zpsmkak+JEImUBcTlnbxINXSzfLxmsC7FTyuJqx8FtJ1HS29Y6iU4Jp
         9ujw3+sR1LsQwy7om1i/2B5AVIlJ0G9Nwq2CMhDwmvyVsHpzK5YqziFphMQWsoh9LKEb
         biOqdKws5U6ndcyn+E/16FnmJm3tUF1Z3DRBOnpyouWyNyj/Q1SWjwncqsJnrdEQ2xoB
         Hlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725465970; x=1726070770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7+tUQJ84hFnBDqdEneCvm+eprIjG794ZYCpOyBa7Jk=;
        b=f+/4ao9ggzN+fXkl14YgG4OTy3FpOAat58Z2nNvgCX0cAAHrlpTZ/VKHupje2piPEA
         vR4TcQTozLUEtQJ+anmGAhvm4Iwq3TcKW2WxI7Kseb2CFjx7Gf2czw6d21bnwSbNmKbk
         ZXdbXzUp2FzDjh+wgiroBlZmUtGm494Vc/5n1QJ3xaCF4KJXINiLATo3Nzp6QJcj2uYe
         sdQVmvW6r2WyV/rL4fElPI3nRNHdeso87W9BychV2taHrojd52aeqYR/OyUt8xkJdXk0
         Yz80UghV4tyVtEQsA4cebRaVX2xeFNiwTBcGqAnRPHWg7YwqdPnRRxdPmOs+9Ii80k1H
         kTSA==
X-Forwarded-Encrypted: i=1; AJvYcCU09oLz6WPQJ+8QmMMOpe0rhjvA/CG2TRHiOGdrnqYckxuLs95YKsAjl7znkumtOpQhxK+Fcoe16EBP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy26avJ6a/me/q1afVeu28Z3WVodUFO8BdwCrqErJ2OmHN8E/6p
	ZmjAjEVfew8JTZKmKc6k9jwJkyhaTG7OV+sXdlwB6JRGnPX2GSNd2+2ThDtdXSM=
X-Google-Smtp-Source: AGHT+IGcpVAFKlDiZWt07FzCeTXDyLh67jaFzc9KCRztTf21IaO4BgJjKsg6qjhbJEyZdR5Cv1h/WQ==
X-Received: by 2002:a05:622a:2b4a:b0:453:6648:2cb5 with SMTP id d75a77b69052e-4567f4e47d9mr231198841cf.9.1725465970307;
        Wed, 04 Sep 2024 09:06:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340c96804sm64812896d6.93.2024.09.04.09.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 09:06:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1slsWH-004irX-AW;
	Wed, 04 Sep 2024 13:06:09 -0300
Date: Wed, 4 Sep 2024 13:06:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Cheng Xu <chengyou@linux.alibaba.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next v2 1/4] RDMA/erdma: Make the device probe
 process more robust
Message-ID: <20240904160609.GC1909087@ziepe.ca>
References: <20240828060944.77829-1-chengyou@linux.alibaba.com>
 <20240828060944.77829-2-chengyou@linux.alibaba.com>
 <20240829100955.GB26654@unreal>
 <e4649d6d-8265-054c-24fb-ca641716856b@linux.alibaba.com>
 <20240902072133.GC4026@unreal>
 <9cbb54a2-1929-f3d3-5b4a-3c613e6759a6@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cbb54a2-1929-f3d3-5b4a-3c613e6759a6@linux.alibaba.com>

On Mon, Sep 02, 2024 at 05:09:09PM +0800, Cheng Xu wrote:

> The hardware now requires that the former reset (issued in the
> remove routine) must be completed before device init (issued in the
> probe routine). Waiting the reset completed either in the remove
> routine or in the probe routine both can meet the requirement.  This
> patch chose to wait in the probe routine because it can speed up the
> remove process.

But what happens if you attach VFIO or some other driver while this
background reset is occuring? Are you OK with that?

Jason

