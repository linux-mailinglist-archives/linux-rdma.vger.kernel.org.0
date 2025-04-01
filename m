Return-Path: <linux-rdma+bounces-9087-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B4BA77F14
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 17:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9636518900AC
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 15:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C9120B204;
	Tue,  1 Apr 2025 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="m3AUBxx3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1F9205E2E
	for <linux-rdma@vger.kernel.org>; Tue,  1 Apr 2025 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521778; cv=none; b=QuLxE9UmY8sDR5URsauQyoxmabj7ORcsMLIyfWeRsih6MG1tNMSOyjAnccQbc3l3qmLgUPjojh556oYq8hmccGSITCiVx+Jst4N+zYMqfEYRMxWYLUh80pMi5oyX2gYVy0a7CrWZwicy87yj3JWZ/vizJajc6jRXCfQg/uJtgr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521778; c=relaxed/simple;
	bh=WjBgEYRtDf+VXzdcMzZI5eDklNvn6/aE6Z39PTjvRE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdWWNozBbXygzFda/AKq6/wrAgm3dKYIoqrot3v69L1st8/ZReryRSPj2P4BkYTdcHun+xp0ZAKtsJENFNpHCmoVpAbHjvqLDWqH0QQ1PABCFKaJ+nRkXDJqcaV7WP0AiAPUXeV6LKSQLqBWFoVd6K7B3SmwIcNZn5zbzolN3Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=m3AUBxx3; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c592764e24so597768485a.0
        for <linux-rdma@vger.kernel.org>; Tue, 01 Apr 2025 08:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1743521774; x=1744126574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WjBgEYRtDf+VXzdcMzZI5eDklNvn6/aE6Z39PTjvRE8=;
        b=m3AUBxx3xhRDmxtypLM4Pt54pD7o/KygxmczlsZH9r98bh7nljPrapMxgz3x8DxeOg
         z4k10ulbzkffTBYiEGEL/FL9mg63VEG4uJlwdJeWBDUkysZAY0bxadyqOrulZzuSnbqK
         0A/kYbYZoDqvZG36C9XlQ4VxVcBUnt0lKueY7/mmAidCSmEG4xrsQZbiKoIt3bem+HZq
         H79/1SGoBMhSCVZYyWHkXf4RFTU6RwgIbd8gGIrfpU9y5N7073mQrmWhAcQtB3jPJT+F
         82VdDRTZZWF6yWcppe0gRD4MucCkwjuhFCSA+daUx4KyrL7kQf1OOWAuZyELEV2s3ytO
         fMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743521774; x=1744126574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjBgEYRtDf+VXzdcMzZI5eDklNvn6/aE6Z39PTjvRE8=;
        b=vs75wZElWYPUjwKF3GUqUtJOwEwPle+UincmDFOw6Dy6e+PLP19+OY3UBQO10DGkzz
         eedwCZfoIglHUg7yzUQfbHoG4SxO9ybyT/BjDmWwzKr6oCKjCO0OK76ZXf2TDEuZPK+O
         y2eboZcczrkHcl3YaWK76yAcIIQkqWvKF2uenR+XRMagPyEUYfhtNq8rfz9O8nasbVDP
         2cLPzsRfdAOSpdJS1Xfu/tOJkm6KXsO5N8EP6FWBxMmWzT0tuHq1gnjo3hQYWHh6deOH
         gfy4lDe+GmsqsiujXeGmFkE+qE9qXJ2m6kFRgkFNvKIFFFzXlMVJu+sTkgfoHLRrA09Y
         h8sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgqg32MYVwGxaleiXWJMCMa0n9WxbNKbm4wnggl5UnQQosyHubwwDMMD6XRNZnDvKaRYao+cub6jtX@vger.kernel.org
X-Gm-Message-State: AOJu0YylqQurvRGQtBOm1V5NCaHtt4eLAmUvT35guRW3Vpex3up/k31H
	xalFRdRzSzaLBjzJ05AWJlTwixHi+0FCj41Yq+IWkd88ui0/N30GJa23RDSZQf8=
X-Gm-Gg: ASbGnct4fF60yw0M3NXDaO5metovtX69sLNOp3yfOnCCUsJ/8MfuHSGgdfd+vx5OFMs
	6dk3Rk742uIv6ZCbCTArC03atUx0bCUuR6+4WB+rt8xo/1PN9KKqZd2PchozUPeBFW3LNyJEG7t
	2ky4MDUki92Jdt7qONI5ooa5wpCYKwrwl09qnoQYcUGMysNJSbaZehT3ux0RZMPMxF/oNW46uGd
	BemejkRJqPmdnyBbJC6pZ+nduSCdZ5PLdK5fm8XZLRarf7rtvdpSR0r04NRkWhAhLPb0pkM61YV
	j9qtfg64xujpCvgwK2ABFsUG7Y+xSO+DM/lgOgK8UIx4MqYOez88VBDHeAqQDMM7ArGjkPV5Uck
	l2A3BCbgGlOkWg1P8lM0JYKuLfJ8UJz9YqQ==
X-Google-Smtp-Source: AGHT+IEZcbbkp6FMant09E2KObVJvCKVBbin+tpe470FPzBoJeASmhbh4JQZP0IGWuOjBWsuWH+nzQ==
X-Received: by 2002:a05:620a:44c2:b0:7be:73f6:9e86 with SMTP id af79cd13be357-7c762a3f294mr49012785a.20.1743521774336;
        Tue, 01 Apr 2025 08:36:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f7684ff6sm668661585a.33.2025.04.01.08.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 08:36:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tzdev-00000001M65-1n6W;
	Tue, 01 Apr 2025 12:36:13 -0300
Date: Tue, 1 Apr 2025 12:36:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Patrisious Haddad <phaddad@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>, Arnd Bergmann <arnd@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Tariq Toukan <tariqt@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	Moshe Shemesh <moshe@nvidia.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: hide unused code
Message-ID: <20250401153613.GH186258@ziepe.ca>
References: <20250328131022.452068-1-arnd@kernel.org>
 <20250328131513.GB20836@ziepe.ca>
 <a754f37e-d9ea-4fba-820e-cc56204d954f@nvidia.com>
 <84bf60b7-2d7e-4549-8e81-bc35efeef069@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84bf60b7-2d7e-4549-8e81-bc35efeef069@nvidia.com>

On Tue, Apr 01, 2025 at 06:20:09PM +0300, Patrisious Haddad wrote:

> > > #ifdefing away half the file seems ugly.
> agreed, which is why I think mark bloch suggestion makes more sense, do you
> think it is okay ? or you think there is issues with it ?

I think you should split the file so we get the proper level of code
elimination.

But Mark's is small and sane enough to fix the build problems.

Jason

