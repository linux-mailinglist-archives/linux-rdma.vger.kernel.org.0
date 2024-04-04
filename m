Return-Path: <linux-rdma+bounces-1781-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DD5898A85
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Apr 2024 16:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73A1DB274AF
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Apr 2024 14:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA881BF47;
	Thu,  4 Apr 2024 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="l0yltRVa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66151C696
	for <linux-rdma@vger.kernel.org>; Thu,  4 Apr 2024 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242757; cv=none; b=RtmPrBCXOgKA8KTj5yNnr/Q6dftWTawZg6+YTx26cBXPixWP0u88ftJVnVRDKW+s53yV4xzV9uHaU5Yr32E+OAtYss5B8mgXt14EhdPPO7hl4MV4DzCAqpqs2+9jqCmevV5kqCWXh3KC85JAWPEz6DgNIIN1lQPo0tGCSTsao+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242757; c=relaxed/simple;
	bh=8do81uvv6Nn7H6RTtLh3DzZq5gqrGMl4JFejDvGxkmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewKmmXQ5+vVMSLqM8s/HMDy18geaJnOrT78FKjj2xp/6emUc0gCf0lvdNnDj5pxYmPK050tOYRMYjSbhTlpvoneCnpz3lW5+XDnUX74SYKSn7tFcj+dALdGF3U9qTHCe3hMLdeXDl5SnZIK8qkAUSKOqVLc33kN/eePcvNLF1AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=l0yltRVa; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-22e8652090aso635827fac.2
        for <linux-rdma@vger.kernel.org>; Thu, 04 Apr 2024 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712242755; x=1712847555; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GxY0curuOJ9XTquhUQPrk9atEsOqwkrsjUBEfLAwtqw=;
        b=l0yltRVaAoX2VYaHLfJsul99otbh5lJP80ddzWwvGBIEcIvV1i6S0nxrIxqbx+KLl/
         SH26aWt4Ky3bO+GYY7twvr3wgtxvgkurrId0VsClbbIYuFt6a+h4G2D7RYAB8SNx6m70
         vZzROKLDaePO4SYcXiMsImRGNMr1LNraRAzzwpzYAYRDpW78mIHvsyYV+JRKPlrI0vqg
         k8FV4ZmnWe7SJ8GYIbALE6EGzF8J22TZ+/qOgJY2rlg22WrGzCM1xcw0urfhrpDKYzqa
         SC3vS34zKDSeyaZp8R5feyxUN+vkXpY9z8Z2FklPuex5YP9mRJnexsyleOaEqJKXhXHg
         5diA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712242755; x=1712847555;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GxY0curuOJ9XTquhUQPrk9atEsOqwkrsjUBEfLAwtqw=;
        b=qUBhAs5iBr/n3rnSER/pWJbw4hup4+rZ+TLNEgzAkdZ/4neeyh+/c4R8290aIz2Fk2
         H4n0Nfs4Hruwc10POgRaq0nfDxOoTTvwDXzY1RSgd0+d+5aj8XtIAuO4CsnkEo9VHAT5
         6ZPsVhH3Ys49J1jzbubCZu3uteUo4bbmCRk2TdLwJ2IdHib2ZV+PsmQeU380lXKBx6Hw
         qCvbkhwliz+9OTjYR9vY67wtEKQkvqWjEwE8oZyvTpt711h/P8/g7zU3BYwH/kD19rPO
         TzcsqKwu2hJOEgrUxcmtDKC/reufERqTWeVej4W49noAMHlgyTqT+maIURkD45LkR2q6
         S9yg==
X-Forwarded-Encrypted: i=1; AJvYcCUMiB0J8Yhe8FX9Te4dyYSdREXI5TAFHf6+3nRzNkXRVLrUGAQfHT3kdYkFnR1PuZc077NMDBS+a9+K/dGOOyW+I83rMCjSTXUFGw==
X-Gm-Message-State: AOJu0Yx0RCrMOI6Ubgz1WP1sQyBMa56TQpEj5VUlO2iSXDup3A/olS9w
	kNnZ56gr9TA72niaOLFIfsqa0PXG5cgsRKWRxz5KZsk3p8JitATRg49OIAGY0Bc=
X-Google-Smtp-Source: AGHT+IFDlJZMiC/wuDrOTwJDh4FtO6fCFQzn0TdCS+465hcHsFINnD8ePoW9Fc0ag29j7GX6ZONT5w==
X-Received: by 2002:a05:6870:8086:b0:21e:8938:9091 with SMTP id q6-20020a056870808600b0021e89389091mr2931077oab.27.1712242754752;
        Thu, 04 Apr 2024 07:59:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d25-20020a056830005900b006e6ff75a1c3sm2972272otp.27.2024.04.04.07.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 07:59:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rsOYb-00AVU3-52;
	Thu, 04 Apr 2024 11:59:13 -0300
Date: Thu, 4 Apr 2024 11:59:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/rxe: Make pr_fmt work
Message-ID: <20240404145913.GF1363414@ziepe.ca>
References: <20240323083139.5484-1-yanjun.zhu@linux.dev>
 <20240327130804.GH8419@ziepe.ca>
 <a9011ab4-6947-4ad4-8d1f-653e129c38b9@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9011ab4-6947-4ad4-8d1f-653e129c38b9@linux.dev>

On Wed, Mar 27, 2024 at 08:40:54PM +0100, Zhu Yanjun wrote:
> 
> 在 2024/3/27 14:08, Jason Gunthorpe 写道:
> > On Sat, Mar 23, 2024 at 09:31:39AM +0100, Yanjun.Zhu wrote:
> > > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > 
> > > If the definition of pr_fmt is before the header file. The pr_fmt
> > > will be overwritten by the header file. So move the definition of
> > > pr_fmt to the below of the header file.
> > what header file?
> 
> include/linux/printk.h
> 
> Because this driver will finally call printk function to output the logs,
> the header file include/linux/printk.h needs be included.
> 
> In include/linux/printk.h, pr_fmt is defined.

This doesn't make sense, printk.h has:

#ifndef pr_fmt
#define pr_fmt(fmt) fmt
#endif

Before or after printk.h should not have an impact.

Jason

