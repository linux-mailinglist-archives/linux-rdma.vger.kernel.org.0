Return-Path: <linux-rdma+bounces-7341-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0F3A22E3E
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 14:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1F9165B58
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 13:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42401E3775;
	Thu, 30 Jan 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Cny256E3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116DC1D9320
	for <linux-rdma@vger.kernel.org>; Thu, 30 Jan 2025 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245145; cv=none; b=j5Snxq/X4aWb8yERMZrYjMnax660gnOZRCssyO4Nugat3D9KW+6VeNyuePipm3TfFqFl6umUpj4sr+dTP5gAFaXBWUc27X57pzjM6s3tgOkJrc+ZzOcifKa4sW1I0iY9EYumgJqig1wIAI7ngPQDtslntbWsqYGD0n07nfQhuSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245145; c=relaxed/simple;
	bh=ls9P0i/GRWtBwGhsWvhdGH07tsy5ngv1cNRvnDQoBhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSFzTDydSphMRrdvDI+PZkJnP2Ox4VU9rThoJPwiuIx0J2k0LTvk9T6sp4eKhI1VuDMACWz6iMeSDZb0BbORL6fB/68Mq431G4qYYnfaGCimaX+LJYha0KgamdR2L+8shWS9+M96cIgw9Ut+HMfuZYVDjY7Ljl7HrjhmNlM0zRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Cny256E3; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b6f95d2eafso86349085a.3
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jan 2025 05:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1738245143; x=1738849943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dronaurD70UfCsj5vY2MdRtwONKnWgd6meaR5gvRCPA=;
        b=Cny256E33eSCjmKueOVCaei4LQffwLniRCGskAKXCobYZSkKy6JSlPBi/3fkpP87vB
         ajQR5SD19O/NPmIxpfoIkOcPtpVVbFqw3IMlii/lSVRX/mWOOWi6WqZAMDfQ+y/WagL3
         9sGWUcCEIu1ZvWiAVfVaIV7U5P2RCql3Nm6yk9OTn++vOB+nTPWivQraKVa0pDWxQmiv
         c6FR8rK+YWFFRLF3u5D5W1G/z3ggOk3JLrKkUrwl+pGEha3MxHOeNeq54hYIRLl3FylO
         TMaudGmU7/SVOggVLz7cFp6SJ6GjNSTFvmOYW8penCvZWp6TPilK8p1Zcgci8m6GdYwo
         UKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738245143; x=1738849943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dronaurD70UfCsj5vY2MdRtwONKnWgd6meaR5gvRCPA=;
        b=Cb9ks0TvIHDJy9I7jA5FTHaB1yh+pRqX+sbhhEeXYaYlvVk63QEc5kQ8GTh9s7rjDh
         AYFSCVfGJvkv7jezOt5dAQuyZW051IgsGueK2SkLqVqOiddAINV/9VGgl1A9oKx5NebB
         uC+XG4gLNnPxCUmxyWQWS+wKRyN1d4W2CBRmB136Ty4pUVK6ZQ5qxjWWiwrpfMLsA1ox
         vthWBgDK+ncpSL31cv+m3795fMRjHhZ/wKw6mVZ9mLX6wH/NL5YXsgja0EJeTJYv+vXa
         znAYupolvKUgtWaxDUJbVN2iOen5RQIFMq6fzuPv3ZQLoIWlFiNc/oO5C+wdlkXd6sBv
         Sjiw==
X-Forwarded-Encrypted: i=1; AJvYcCWFGZadR0+OPcPKYxb28Bimh36rBonaPvziGT8AQNYcpaoXThrpoHrm5zfX4sK32rfHRNkk4746IJDs@vger.kernel.org
X-Gm-Message-State: AOJu0YzNm5OyeK1AfH4sHU8vGP/9V4nDQtFyvLQ4PxT+yt5T8tARIxb2
	0GTqhzxpQWv8RKQpKlck71lRGXsm0tCHpEMQwoj8gpX4q2kLILoCFE8vSQF01C0=
X-Gm-Gg: ASbGncvaKBLZ5vyfg/IJnlfwPfBa39qYQ+RbajsmNChjMv5RI05VJcrlOwOjCzSkwBC
	zs3Wqhg1tTwKpqoWLgV1xVoNbnknhIMXolpTT1B1Sq/uAPB1GZSDIg2t1xhJbfqa1GcYVrREo+O
	2c/XZ7opS8qTAR74iToWxPg58omyLIdyIUa0KJipdKF2k0U2vTU2+KYNCASo0MFGEbYOwV2u7Kn
	xziS6/HvctiK4nCjFsArdRyMHVjiqyeZLUSKFC8k3Mh4ZKsIEO+sDb9GiD979p5Lcsn44ZEWyOY
	yFE2QH11rdp27hGFuiZQhbEUtvdV9MY79NecMLma8FSvxowaL/yct+FDJURDTGwq
X-Google-Smtp-Source: AGHT+IFofaCbYRRD8xzlZNxnfbRD/rF9UdWbu/0/YCSq+I8ZkCQdGDfrRjYIkRD3w76XWM43R4/A8A==
X-Received: by 2002:a05:620a:8f07:b0:7bf:ff64:336a with SMTP id af79cd13be357-7bfff643509mr655590485a.38.1738245143001;
        Thu, 30 Jan 2025 05:52:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a906518sm74801785a.84.2025.01.30.05.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 05:52:20 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tdUxv-00000009cxB-1aP1;
	Thu, 30 Jan 2025 09:52:19 -0400
Date: Thu, 30 Jan 2025 09:52:19 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, linux-rdma@vger.kernel.org,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] RDMA/rxe: handle ICRC correctly on big endian systems
Message-ID: <20250130135219.GH2120662@ziepe.ca>
References: <20250127223840.67280-2-ebiggers@kernel.org>
 <ae41a37e-3ee4-484e-ba53-1cad9225df7a@linux.dev>
 <20250129183009.GC2120662@ziepe.ca>
 <20250129185115.GA2619178@google.com>
 <20250129194344.GD2120662@ziepe.ca>
 <20250129202537.GA66821@sol.localdomain>
 <20250129211651.GE2120662@ziepe.ca>
 <20250129222147.GC2619178@google.com>
 <20250130012951.GF2120662@ziepe.ca>
 <20250130020403.GC66821@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130020403.GC66821@sol.localdomain>

On Wed, Jan 29, 2025 at 06:04:03PM -0800, Eric Biggers wrote:
> > From a spec perspective is *total nonsense* to describe something the
> > spec explicitly says is big endian as little endian.
> 
> The spec also says "The least significant bit, most significant byte first
> ordering of the packet does not apply to the ICRC field."

I'm pretty sure this is text trying to explain the Remainder -> ICRC
transformation in Figure 57.

Jason

