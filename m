Return-Path: <linux-rdma+bounces-2600-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5138CD6E2
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2024 17:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20CADB20B78
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2024 15:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC153E546;
	Thu, 23 May 2024 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mKtSPnaJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69801171A1
	for <linux-rdma@vger.kernel.org>; Thu, 23 May 2024 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716477547; cv=none; b=Uiqw/sCSTRoAOWmFfZAX9iJuWxLSuHMxBeyGH6Dw8wgBViGFFyzzCHDeUVdb3eU5bGwSiFKgMlE+Ti6cKLBzk8CYiq9WFPGwofM9e18+y1xxmIztQ7n3YT/tE3mVpNpjwm6GAxkpbWaof0bzjsTNBKkquEUMCxZXnK0MBLhKGoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716477547; c=relaxed/simple;
	bh=Qd+uM/MA0SyCEUXR+8xZnPonDUK7E+KcbIZEazApuh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwn5eaxCFBFFq5Qn2lt8YLSGG31METwT4Atv0IvzJnEvJw1mZTlKZfXKExKG3b3QPDdvA02NwV2NyR/h4Ox+tk9UQ6B0juMm5oRqXccpPaZ/x2XFlLeQL/p0yBQUdiM6xoXFtPsEOoBIdwAPdaVh8mLD6y1sbONCljRp8W6Lgto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mKtSPnaJ; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36c72dbed20so26511655ab.2
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2024 08:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716477544; x=1717082344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CJm2vaqzB7KtDQFbwjPIFt+DppMOrXnhMvCaxb5xltY=;
        b=mKtSPnaJlasd3gMiH9X9f3Z9z0M3UO9MNdT54iSY685fZ7MaT7G3kWooWxiz4EHz5g
         4DGbRRb9HBAy4XOEG8+od9cEZYixLRV0bD45hrQ1zVIH2WJ8MpiLuaUU1OSUu/2RWkCb
         LdDuD1Lkf41lWhwtPSxGMoZ1JcgLWINt+a35bomzah3mQfh4gXoSfPDRoL8nUJQ7ySPA
         EF6E2Gd9lzvsyNQ0HC4BC5SYtY0ScSWue6BfijLHwn1DX08hGKY8+bxtTPLUAyztJ7ly
         CKPmHysbnSyZB+Z68HFSS3T2ps1R8A2I8ajewyu76Ad7pZWgLV2sv0Ysj1Tm7U87mcw5
         Ap4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716477544; x=1717082344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJm2vaqzB7KtDQFbwjPIFt+DppMOrXnhMvCaxb5xltY=;
        b=EIoZRJnK9rXD9JU9857Kko1joGOP9LE6yeB/4f+l9Xu5UMawOML5HJSuGKiVAXMbYv
         S7j7FAiwGtE0JjU3v89/I5edMFnUo0QVrWK8qD6l1sE3mmhjFVM2chZ1tj+e40DkzcKY
         soL/IQwMEwtwkhBUVanEBWOeIV/VDd8KT1Y1GojMo8Ulp+nzunPLizWFF9S/6eOIVig7
         TJJCOy2v0vOVqqaDBo3w2saI3KzlRoPgtrES2gnmxF/W3BnWzmMPbL/TIWBuEtkx3LRB
         urQWUSCVYARianZVGzuvM7ulqoG3VR1kbWGsqzzYXWSPs8iIZKmMeRLym2xk4ev5UUxb
         1tMg==
X-Gm-Message-State: AOJu0YzmT/+YIpg+sVXwPQEblkUu+Tvi7hmGYyGnJoRgOlpIua5QiAVa
	fZkVxTreKYU2+LJcgd2ZMSQ2kVyKOxNDxPqhbmnK5GmQ4R9U/rJsKw6woJij3fU=
X-Google-Smtp-Source: AGHT+IEiMww5SNs/jnfVIKFy2SrzDXI4/FVjRowWGW78oOZStJr+V8B/AGtvw0mhZVHvSiiRxczeZA==
X-Received: by 2002:a05:6e02:1b0c:b0:36b:12f5:14dc with SMTP id e9e14a558f8ab-371fd75d0f7mr58894945ab.32.1716477544381;
        Thu, 23 May 2024 08:19:04 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e07e5865dsm165361071cf.44.2024.05.23.08.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:19:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sAADe-00FqY3-Im;
	Thu, 23 May 2024 12:19:02 -0300
Date: Thu, 23 May 2024 12:19:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"kheib@redhat.com" <kheib@redhat.com>,
	"edwards@nvidia.com" <edwards@nvidia.com>
Subject: Re: [bug-report]rdma-core v51.0 build error with Rocky Linux 8.8
Message-ID: <20240523151902.GJ69273@ziepe.ca>
References: <SA1PR11MB68950882F65EE948009BF33986ED2@SA1PR11MB6895.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR11MB68950882F65EE948009BF33986ED2@SA1PR11MB6895.namprd11.prod.outlook.com>

On Thu, May 16, 2024 at 07:48:06PM +0000, Marciniszyn, Mike wrote:
> Seen on Rocky Linux 8.8 with rdma-core v51.0. 
> 
> I suspect 8.9 shows the same issue and I know the RC for RHEL 8.10 does as well.
> 
> The cmake version is 3.20.2.
> 
> The linux kernel version and hardware is not relevant since this is a cmake/build issue.
> 
> The hardware is also not relevant.
> 
> To reproduce:
> 1. download an untar the v51.0 tar ball to ~
> cd ~
> wget  https://github.com/linux-rdma/rdma-core/releases/download/v51.0/rdma-core-51.0.tar.gz
> tar -zxvf tar -zxvf rdma-core-51.0.tar.gz
> 2. create the following directories
>  mkdir -p ~/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS,OTHER}
> 3. copy the spec file 
> cp cp rdma-core-51.0/redhat/rdma-core.spec ~/rpmbuild/SPECS
> 4. Create SOURCES
> tar -zcvf ~/rpmbuild/SOURCES/rdma-core-51.0.tar.gz rdma-core-51.0
> 5. load build dependencies
> ensure AppStream, BaseOS, PowerTools repos are accessible
> sudo dnf install -y dnf-plugins-core rpm-build
> cd ~/rpmbuild/SPECS
> sudo dnf builddep -y rdma-core.spec
> 6. Load an additional pythion interpreter
> sudo dnf install python39
> 6. do the build
> rpmbuild  -ba rdma-core.spec
> 
> The build gets the following errors:
> error: File not found: /home/mmarcini/rpmbuild/BUILDROOT/rdma-core-51.0-1.el8.x86_64/usr/lib64/python3.6/site-packages/pyverbs
> error: File not found: /home/mmarcini/rpmbuild/BUILDROOT/rdma-core-51.0-1.el8.x86_64/usr/share/doc/rdma-core/tests/*.py
> 
> 
> RPM build errors:
>     File not found: /home/mmarcini/rpmbuild/BUILDROOT/rdma-core-51.0-1.el8.x86_64/usr/lib64/python3.6/site-packages/pyverbs
>     File not found: /home/mmarcini/rpmbuild/BUILDROOT/rdma-core-51.0-1.el8.x86_64/usr/share/doc/rdma-core/tests/*.py
> 
> Earlier in the build this is seen:
> -- Found Python: /usr/bin/python3.9 (found version "3.9.16") found components: Interpreter
> -- Could NOT find cython (missing: CYTHON_EXECUTABLE CYTHON_VERSION_STRING)
> 
> The issue appears to have been introduced by:
> 1462a8737 build: Fix cmake warning
> 
> cmake appears to find the 3.9 python despite having:
> -DPYTHON_EXECUTABLE:PATH=%{__python3}

I looked at this briefly but didn't guess what the issue really was?
Do you know more?

Jason

