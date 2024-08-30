Return-Path: <linux-rdma+bounces-4671-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27920966894
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 20:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1380285423
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 18:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26BF1BBBF3;
	Fri, 30 Aug 2024 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WIdXrmX1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94321BA89B
	for <linux-rdma@vger.kernel.org>; Fri, 30 Aug 2024 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040884; cv=none; b=NGZ3l+tb6PwVSee9CFtoxhwlHbAetxTpfqWYVTIWY+B7n5PMnSiSCTs6skSGIHjZ7L3oc4pqTTNHPJMcDZb5wvj1gOjxsQ2LOJjWS1OZyrB0G9Mtvp0DjzzRcr/i/UyF/uJwBWrKM425SYTceVf2E3h/XVCYZKn33Dswh7//XDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040884; c=relaxed/simple;
	bh=iONqyQ/8IRXyxLGbP8yDXUNOn1rmtSVFD3P6Y5gH4Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzwRoD2B2znnD5+Fvx+QFY5ClIwoGZMxv1XAu5Q09S2zcl7C4hdal4IXCuIINLdJV07eRmTf+7ntmubOpYqlgem+KHkGo6b81hv+6PCCgb7xrAnfAqquqNr54wSQQNgay1A9Sf60252Xn/XJKzqJMZsEvaHTWb7y7IHSaoL4p0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WIdXrmX1; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7140ff4b1e9so1841218b3a.3
        for <linux-rdma@vger.kernel.org>; Fri, 30 Aug 2024 11:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1725040882; x=1725645682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WHX2e16HhFXHNyVsyMjV+wt66b4YFtJkCjB0C7Pos18=;
        b=WIdXrmX1GUazbBuDiYqieW+IyGllXuGQglxoZDp9R4TnSr7irujhZbbeNsnX7VvcWE
         O+VzpdzjRPo+QSwx1i20hQoGf0cPQCvPOwOobEudxvs1SscITYMpvYTNyUf3FDs6yd8c
         GEKySrHNJ3Al92gQYqf2jpBvL9Th6Upl71txkzLxcZ72vA2qqya61qrikfVbuwBSSxHJ
         jSRk1z24X6ateLvjgLOZ3GjgSGvoQzr5KNksSEDd1yV+OfNBRIvhS9qmuJZFm76fCL2X
         ZDEckrZ0560knSxJmNN3piIJXBk55b47LXY8oUbYcBi9CyOmtauZJYBkMMCIk0YG+bKz
         RbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725040882; x=1725645682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHX2e16HhFXHNyVsyMjV+wt66b4YFtJkCjB0C7Pos18=;
        b=sWbfgQSO2WRaCmHHn56+346OLe7a5BslvmhUOeQZ97g/VLCp251fV8HEyOsnNVNHPU
         ZUrwk6IFFF+e7lohpLWx/eghswGSulcuQ0Yk+LK9h03c3z+Iho+7s/CNUd3d4MfNIQ6l
         H/bOT3F+h4f/vprXLherSgiGGPjL+2an0m/fo9i20Mh04zYwdXHZcKjaAJn3LULwHAGl
         VZ+vigCi/okDYgBp1ezRPsClxnNA/pJmbMfTKINKSJNaTLQionRX1afpVn3jiXmI3D3v
         HAhqcMmZHSbb754Uuay3mRm5G2e7Ni3djwOTCXUvYVwynFSpOf3Wos8qU/640IM+Lax6
         7CdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSrdIp60Q+Xg99VjwaqLK/2QUXv/Adr+xztlO5im4vqF8Jl/zw/Qs7aflWDrG2cTeidIOgRj2BfRwh@vger.kernel.org
X-Gm-Message-State: AOJu0YzpdJx10fgj8oI7sYtiTdSVu7SRZ2ZgEV4ZD1qgk2+BHhk4rFlA
	nN4pwANjshHtHTjLKYkTfesouqabYVFoCZS3vvAvwx9PTzQ1LaiE+iGdtjPAgj4=
X-Google-Smtp-Source: AGHT+IEFG8jRDeUE2XzEv/D/mcMBxmEig6pfl17gyEOiCPD1MBq5+4FIl0XovF0o+BsUsWuJ23oV4w==
X-Received: by 2002:a05:6a20:d494:b0:1c4:8da5:21a4 with SMTP id adf61e73a8af0-1cce10aed82mr5375029637.41.1725040881940;
        Fri, 30 Aug 2024 11:01:21 -0700 (PDT)
Received: from medusa.lab.kspace.sh (c-98-207-191-243.hsd1.ca.comcast.net. [98.207.191.243])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-715e569e9a9sm3046256b3a.117.2024.08.30.11.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 11:01:21 -0700 (PDT)
Date: Fri, 30 Aug 2024 11:01:19 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	yzhong@purestorage.com, Tariq Toukan <tariqt@nvidia.com>,
	Shay Drori <shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] net/mlx5: Added cond_resched() to crdump
 collection
Message-ID: <ZtII7_XLo2i1aZcj@ceto>
References: <20240829213856.77619-1-mkhalfella@purestorage.com>
 <20240829213856.77619-2-mkhalfella@purestorage.com>
 <cbec42b2-6b9f-4957-8f71-46b42df1b35c@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbec42b2-6b9f-4957-8f71-46b42df1b35c@intel.com>

On 2024-08-30 15:07:45 +0200, Alexander Lobakin wrote:
> From: Mohamed Khalfella <mkhalfella@purestorage.com>
> Date: Thu, 29 Aug 2024 15:38:56 -0600
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> > index 6b774e0c2766..bc6c38a68702 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> > @@ -269,6 +269,7 @@ int mlx5_vsc_gw_read_block_fast(struct mlx5_core_dev *dev, u32 *data,
> >  {
> >  	unsigned int next_read_addr = 0;
> >  	unsigned int read_addr = 0;
> > +	unsigned int count = 0;
> >  
> >  	while (read_addr < length) {
> >  		if (mlx5_vsc_gw_read_fast(dev, read_addr, &next_read_addr,
> > @@ -276,6 +277,9 @@ int mlx5_vsc_gw_read_block_fast(struct mlx5_core_dev *dev, u32 *data,
> >  			return read_addr;
> >  
> >  		read_addr = next_read_addr;
> > +		/* Yield the cpu every 128 register read */
> > +		if ((++count & 0x7f) == 0)
> > +			cond_resched();
> 
> Why & 0x7f, could it be written more clearly?
> 
> 		if (++count == 128) {
> 			cond_resched();
> 			count = 0;
> 		}
> 
> Also, I'd make this open-coded value a #define somewhere at the
> beginning of the file with a comment with a short explanation.

What you are suggesting should work also. I copied the style from
mlx5_vsc_wait_on_flag() to keep the code consistent. The comment above
the line should make it clear.

> 
> BTW, why 128? Not 64, not 256 etc? You just picked it, I don't see any
> explanation in the commitmsg or here in the code why exactly 128. Have
> you tried different values?

This mostly subjective. For the numbers I saw in the lab, this will
release the cpu after ~4.51ms. If crdump takes ~5s, the code should
release the cpu after ~18.0ms. These numbers look reasonable to me.

