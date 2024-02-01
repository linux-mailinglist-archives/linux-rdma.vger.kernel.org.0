Return-Path: <linux-rdma+bounces-850-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E707844D90
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Feb 2024 01:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3471F24599
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Feb 2024 00:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A857037C;
	Thu,  1 Feb 2024 00:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iuvSVo4N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7ED374
	for <linux-rdma@vger.kernel.org>; Thu,  1 Feb 2024 00:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706745852; cv=none; b=ilr+FB8hcpnMpPshb65PvL09WBcTo9Maq8B47lR5sxSDmpcM7cb4Nlmi+rqidZ6GWzkcK3nVsqKN04GT4e84KUKYlFHMNZ5GmKV0YG5Tl02OvAe8s//W3hqzw4kpMmFETtvsdA0W0a/BRaKlXhe/okK0ENGJr8kPg/b0tyEDl4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706745852; c=relaxed/simple;
	bh=ZTQfjlfKZWpsko9yin8I+YupCTzyBniQOMshlfPT7kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsV6DKEeSZYcGhJD2VioSZkrMS3exGhTCTHP3jE9JAsFdwDmnfnHVBhxmjnlAmNATjdn/joI/vF6gBepakUgsrc1qOnup7bsdR+fNciCqC6UmixN8F7/YFMTKhGozSCdQ2b3QNNWagfMdr0BHEs0vdAfjRDN9DR5YiJvPZapF+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iuvSVo4N; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68c427136b0so1759006d6.1
        for <linux-rdma@vger.kernel.org>; Wed, 31 Jan 2024 16:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706745849; x=1707350649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4l6ETKY5nfjEgAc/txbnxgEJpKhrIm08EBvT3tli3Fs=;
        b=iuvSVo4NkfbiUsfvlovftPoS/Sd2p0VROXV/Lg3NidmqDjYdjC4nK/br0NIVN55Yf5
         8gbk++XxPJWVwDN1gIuue5uup/+h1DrmTQFlsQwPnA22NADSQSvhN06qbgWCXlmFIkF6
         ZBwq0ErRKzful/0mfTogaMfv9S8j4IuZLscKVt7x6zyOEkVEJThunexVoZ0JthAJb3cV
         j2zCqub/OGSXHyAjH1LdAXduTeIVH3KirSG/51fc5sDd62+SqGqmQHQcfi8bOUlc2Mhu
         zxmeeE9O79wBO90qKIS34kNlcKMxSaEUu5CUaxs/kzVmrpMJESTk5eEKvXu0vyCF9hZA
         +Aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706745849; x=1707350649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4l6ETKY5nfjEgAc/txbnxgEJpKhrIm08EBvT3tli3Fs=;
        b=NPOZF1Vmk3Ehex1aM5YKCsay5wtMVH2ydoHC1gJClw9IcmeUZKuqDLXr9ci5BO552D
         LNMoiIxUgGuE8cmcZoGSs3dqEPrVG+Hgr6InTsKWalTeFl0LClJtBsMvENguF8sjg8jx
         q9NWTqFTMGHNZ28AuW1luGM/RN0Y/Cn+2PM5O6+IK6eppVq42iBLZ20BlvGYtXISVi//
         X1JA+SC9+8H8Dwy33dQRmFNtmS9Z+8cW5bnpxcLxkOKFPlx91YETihr57P/354H3oTBs
         wu5fT0iJweRVaZdZxLMGUAI0FQOW5JEyHmdTgHxeW4JS7KVYx55pQCN4vKajImaHNIvS
         e56w==
X-Gm-Message-State: AOJu0Yz/XRJ7kYWJHWop52nyvF1FcBYjnXXh0U2xlYFahqsHSdb0Du3F
	/eGdZS45eRqmf1eVw+hkjkZ5g2Yj6+0xzH7uf+NZGvqTCKyTdL5sYXkRchjx6EUU0sRVnWsCaLd
	A
X-Google-Smtp-Source: AGHT+IFQKX7i+4ESMDPH847KNu8h9oQxu5LUlBSeL3wj46zQiyv7K5BPuhC83CxhMMrx5CEoWutdYg==
X-Received: by 2002:a05:6214:1314:b0:68c:4f54:5bd8 with SMTP id pn20-20020a056214131400b0068c4f545bd8mr3525534qvb.32.1706745849534;
        Wed, 31 Jan 2024 16:04:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ly4-20020a0562145c0400b0068c4d69936bsm475181qvb.119.2024.01.31.16.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 16:04:08 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVKYq-00AhVc-1D;
	Wed, 31 Jan 2024 20:04:08 -0400
Date: Wed, 31 Jan 2024 20:04:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shifeng Li <lishifeng@sangfor.com.cn>
Cc: Ding Hui <dinghui@sangfor.com.cn>, leon@kernel.org,
	wenglianfa@huawei.com, gustavoars@kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shifeng Li <lishifeng1992@126.com>
Subject: Re: [PATCH] RDMA/device: Fix a race between mad_client and cm_client
 init
Message-ID: <20240201000408.GG50608@ziepe.ca>
References: <20240102034335.34842-1-lishifeng@sangfor.com.cn>
 <20240103184804.GB50608@ziepe.ca>
 <80cac9fd-7fed-403e-8889-78e2fc7a49b0@sangfor.com.cn>
 <20240104123728.GC50608@ziepe.ca>
 <e029db0a-c515-e61c-d34e-f7f054d51e88@sangfor.com.cn>
 <20240115134707.GZ50608@ziepe.ca>
 <354e2bf7-a8b4-629d-3d2d-35951a52e8bd@sangfor.com.cn>
 <5bc6ed6d-31e9-4b44-aa91-5f9d0f3d92c8@sangfor.com.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bc6ed6d-31e9-4b44-aa91-5f9d0f3d92c8@sangfor.com.cn>

On Fri, Jan 26, 2024 at 10:25:01AM +0800, Shifeng Li wrote:
> > I believe this modification is effective, rather than expanding the clients_rwsem range,
> > the key point is down_write(&devices_rwsem), which prevents ib_register_client() from
> > being executed in the gap of ib_register_device().
> > 
> > However, this may cause a little confusion, as ib_register_client() does not modify
> > anything related to devices, but it is protected by a write lock.
> > 
> Do you have any differing opinions about above?

I'd rather see the client side have a comment explaining the confusing
lock then disturb the locking on the devices side..

I think the write/read lock scheme there was done for a reason I just
haven't had time to recall exactly why..

Please send a patch with this arrangement

Jason

