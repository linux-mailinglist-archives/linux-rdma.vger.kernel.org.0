Return-Path: <linux-rdma+bounces-2123-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEE58B4302
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Apr 2024 02:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50010284798
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Apr 2024 00:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738F3376;
	Sat, 27 Apr 2024 00:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Xhhec6hw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A8C181
	for <linux-rdma@vger.kernel.org>; Sat, 27 Apr 2024 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714176312; cv=none; b=nikZEJ54/IvppvFo1yabTH9pc3wWvkQvLy6stYzFF8QGtHrIU+7OeTBoBOSCB6Bh+PlaMxmfTF/RE8v44zfBE2DkdNKQNlIRx4Rrriw5GWxAqzgx7o2yWE1yQPasclPQXLTSLh0sq24cJteNVi9x79rxG9a2Gz6sUbnWXz3hUfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714176312; c=relaxed/simple;
	bh=/fd/N7v3qro9nza0VrndytUPmzZi7jlSVwjA4rio/DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVeW2f6Lw2RjeICAx2qdwH7yis/2SLJa3FryQistOXGoP26GE+hwKsfOsnUJXJs86LJYjx93BLlAJ3Rg4nM8VWRGo2Eib6kBLlWeEcNaG1hyk/sE4VViNAB4feFCFOOxDTnL52DO776405UJmCX6hOKt9/XgGoNBZgk3curDPPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Xhhec6hw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e9451d8b71so24288925ad.0
        for <linux-rdma@vger.kernel.org>; Fri, 26 Apr 2024 17:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714176309; x=1714781109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lRc2kHVSDrDvqQGDE2B5fMNzoZg6D0PSUdf9JLW6aCI=;
        b=Xhhec6hw769ekVwKoZMZZHsTFAvdFBUYSfIqexVVDLpFIgII/LrTXF5FcVb8HHrbmB
         UBbl8EBptLAhFVL4GYWCZRNBQV0xwUBitta1ci21BI5mspqzLpuYB2SD1QRXGH6WSn6h
         mvrDn6h5Y9Dv6rZn31fqAz0tH306aL90dhdC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714176309; x=1714781109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRc2kHVSDrDvqQGDE2B5fMNzoZg6D0PSUdf9JLW6aCI=;
        b=Xjv9u2S/Mnx1K/6/io3/KfYYXIUtLF30hQkFGIsrsuwu2ffYUzz5r3S+ZYvQSPQ/pB
         Em63g+EpwOsFYYMsR4C6bzwSV/0E5FrUgzkcfrpQmULekcjXqoApFijXyLBTmgLuYlS3
         qUCgHS0A01R4COBuFFq7nuRs3pBPkMBRD3UWHSCmPwLIDHm1R2iKM6R8B3c8kGMdNfT5
         NUg7JxkC1jovVU4OTsl8Uj2G4B6t8MX8nzAhqg7tR7ytUPI1bLBjbUBTgAAbxFDCRrNy
         3O/erQHjloMt5ZnZYhlU93vsn/PSTQO2c30sVO+IGtm2Qe1OIcAc5Y/kyCA7Wj+5+ebC
         G6bA==
X-Forwarded-Encrypted: i=1; AJvYcCV7Mwj8Y6Xgwb16xIjbVrydDOuBF65kb9RMQZg6SoBzHzHanAV3aplQBasRPEnjULyDP+3bYtQLijG4IZJrKsPVWi+ml8CcACUmTA==
X-Gm-Message-State: AOJu0YwDxBuFOECgCsXSZsgQnScJpQlSKgxmybVYc6xhWScBd5EuPki5
	rsV/v3R9dzc5SOGHkI/n65IAsHq3qEZbDNPjID3rxuFhmu85SXk+SaDwojqpGF8=
X-Google-Smtp-Source: AGHT+IFN27qWIbdvnvs9eKXT4KClDm7VytA2q/XzZf3cRRyIQdpg9N4Tfs4AOsINPgBeX9k7ZKTCaQ==
X-Received: by 2002:a17:902:dad2:b0:1e4:9bce:adcf with SMTP id q18-20020a170902dad200b001e49bceadcfmr5001638plx.63.1714176308979;
        Fri, 26 Apr 2024 17:05:08 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id jc14-20020a17090325ce00b001e50dff6527sm15992243plb.269.2024.04.26.17.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 17:05:08 -0700 (PDT)
Date: Fri, 26 Apr 2024 17:05:05 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
	saeedm@nvidia.com, mkarsten@uwaterloo.ca, gal@nvidia.com,
	nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/3] net/mlx4: support per-queue statistics
 via netlink
Message-ID: <ZixBMZLq5nPl9kU9@LQ3V64L9R2>
References: <20240426183355.500364-1-jdamato@fastly.com>
 <20240426183355.500364-4-jdamato@fastly.com>
 <20240426130116.7c265f8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426130116.7c265f8f@kernel.org>

On Fri, Apr 26, 2024 at 01:01:16PM -0700, Jakub Kicinski wrote:
> On Fri, 26 Apr 2024 18:33:55 +0000 Joe Damato wrote:
> > Make mlx4 compatible with the newly added netlink queue stats API.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> 
> Not sure what the "master" and "port_up" things are :) 
> but the rest looks good:

So in mlx4_en_DUMP_ETH_STATS, the driver calls mlx4_en_fold_software_stats
which does the same "port_up" / "master" check and bails out... so I figured
for these stats I should do the same.

Was hoping Mellanox would give us a hint, but glancing at the code where the
MLX4_FLAG_MASTER bit is set, it looks like sriov ? maybe "master" means pf and
"slave" means "vf" ?

Not sure why the stats code bails on is_master but not is_slave, though.

> Reviewed-by: Jakub Kicinski <kuba@kernel.org>

I'll add your reviewed-by to my v3 and wait until sometime mid next week to
send the v3. Hopefully we'll hear back from the Mellanox folks by then if they
have thoughts/opinions on the stats code.

