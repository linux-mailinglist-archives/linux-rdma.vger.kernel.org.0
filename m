Return-Path: <linux-rdma+bounces-1849-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB2E89C65C
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 16:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7071C22572
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 14:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F058175F;
	Mon,  8 Apr 2024 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KsmEh3VN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3814181729
	for <linux-rdma@vger.kernel.org>; Mon,  8 Apr 2024 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585299; cv=none; b=jYxS5S24WaGQPKYxovu2eSDsJ4BS/I0LoZI0oOu9Jsa3OZR5bRl3/SdMv9v7vOwqqO2XcC5yZgZSG9J+ZiGv3PmeYQtCDF9wvKFFb7O5n8bqbW50RPmwTeDWM8lAZTNvryoVt04GbqZVX89C+8ygk+d1GJQx9bLXvhWDWEBBsJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585299; c=relaxed/simple;
	bh=aNaAiaPsLQoFxFVUSN2sTScX6D8kGjyawet3xKsYAdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCjcUS9gpGFSD81SxdMsbsH91nEsSyF6d+b65zNdxJuWkHIqWwj6IMvWYCSliJLWAgIvGAmJCcZkZhkBeYvPWGPXNIHpRyGkibwynLaamLN/6EJjNaEFyWPpPyFcYaQLeeAgXVgFcP705Iry/9S2Tkjq4t9BlgEcu7zDwLDKlqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KsmEh3VN; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43444a599d0so26772911cf.3
        for <linux-rdma@vger.kernel.org>; Mon, 08 Apr 2024 07:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712585296; x=1713190096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aNaAiaPsLQoFxFVUSN2sTScX6D8kGjyawet3xKsYAdM=;
        b=KsmEh3VN0VWigo8YmgEvFWDO61fn9fSGE3OEk+QoW6YlHcupt6lIA37eJHRaHmStx2
         Wtlun2kXJE/C+zzsxd6jmMpNCMYqb8gi6TxHgGCkjGslbD2es3l8Aa2mtAGqPbue/dZg
         /ddg/oYlWEHlTpRfhP8Sp5nvqJtlV5m+sxtImXDZTcg9tiI45Opb6urAQ3V5jzOGzzPq
         WTAwvAvQfOfrE6LkiqbgiM/dChpbwi9cohh7+YTbGPGNwjN0jIHltEWJQXPGyVUYixoI
         pejsrInCY2D+3IxNFTIQVvpT3jMScGgg2mQczEeGFjS47X/F3qIFCt0JguP6ByrhiSAb
         wKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712585296; x=1713190096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNaAiaPsLQoFxFVUSN2sTScX6D8kGjyawet3xKsYAdM=;
        b=nKwKOZ7leWMoNE8WSaGN0WPhiiX6+Zc9C/KCTuV2oaOcFObgJWC2K5lcuv8cVw/DBa
         nWjHqhhh3F2tBJUkaQyhBuunwRdlyj6oMnHCQl/e7Mu6FByPgFMD/j8Il9BtYyJOwccR
         fSOKVmeW/LYW1LCFA3fGHJ6bpdIVfpeCwyL2jzBCiPcyrTZPfqUhXtmEYpn4znIvwIIV
         TSsehs+R+Fv7cQB3/267akbgrG8H1Il1Xqsxy6UkaNLqXsyjBBWCglxMkJGj+bEZsnOp
         UitlldQdRbzwRYArjeDlqFhxns6zMEG/Z6IHG2Wki0O0sqmZmZ2tYpB+mOTkKxzzkTvF
         AzGw==
X-Forwarded-Encrypted: i=1; AJvYcCX5KkQ59lGz256LkshxV0ptT70GlPT0ixBAuZKhl1hN4oG8pzb9rBFL9zmPd57BaHeJEtJES+QSBqfgN9aPjOzEq6SydDNaOPC1UA==
X-Gm-Message-State: AOJu0YxFrPQnO3I2KNDfZBkhE3M4doJN2Iiefapzy/Vz8MGIPpD5wna1
	TPA0jWoTsKCPtNwb99ODsztHp7FF1905Ty4XgPrqnI9vyO/Iby0Cp0yVBnLNn28=
X-Google-Smtp-Source: AGHT+IEACb0TZxNCWa5D09kzHnXgZKbSJ+J6CSClq+wsF25mlhvZDwVLJvU2uUGVJrxYk1oQfmX/Hw==
X-Received: by 2002:a05:622a:1ba4:b0:431:3af9:1c7d with SMTP id bp36-20020a05622a1ba400b004313af91c7dmr9688251qtb.36.1712585295957;
        Mon, 08 Apr 2024 07:08:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id b8-20020ac86bc8000000b00434cc487759sm3064qtt.96.2024.04.08.07.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 07:08:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rtpfS-005FZM-MC;
	Mon, 08 Apr 2024 11:08:14 -0300
Date: Mon, 8 Apr 2024 11:08:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/rxe: Make pr_fmt work
Message-ID: <20240408140814.GA223006@ziepe.ca>
References: <20240323083139.5484-1-yanjun.zhu@linux.dev>
 <20240327130804.GH8419@ziepe.ca>
 <a9011ab4-6947-4ad4-8d1f-653e129c38b9@linux.dev>
 <20240404145913.GF1363414@ziepe.ca>
 <7a2a41c2-c8ef-402d-933a-2b2d8a956207@linux.dev>
 <be9584b6-85fc-46bb-87b8-18ca6103a5a4@linux.dev>
 <20240404235931.GA5792@ziepe.ca>
 <ed9e2b80-0e0f-4628-9a57-e061acf9f4d5@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed9e2b80-0e0f-4628-9a57-e061acf9f4d5@linux.dev>

On Sat, Apr 06, 2024 at 06:35:21PM +0200, Zhu Yanjun wrote:

> Got your point. There are about more 130 header files that define pr_fmt in
> the kernel include directory. And these header files are included one
> another. Is there any tool to clarify the including relationship between
> these header files?

No tool I am aware of, but if headers define it then they should be
local to a subsystem and never included outside it. Such as what rxe
is doing.

Ideally they would be private headers not under include/

Jason

