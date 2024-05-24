Return-Path: <linux-rdma+bounces-2607-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FDB8CE8F4
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2024 18:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B30CB216A4
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2024 16:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123F012E1E7;
	Fri, 24 May 2024 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EVVWgz9R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44AB12C464
	for <linux-rdma@vger.kernel.org>; Fri, 24 May 2024 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716569829; cv=none; b=OTU32+t2J7ccvUYYN6TlYMtNKtRFkSeUDqA7n0yZAEWBL2cIo+2fDUTaKmYhbkbuJy+/D/Kq6XEn1jz6+geaBvV7QgZciZJ0DhRDax98fFixa99QO/tqx1R6LCieeXsLnSiZZJIVLn2qkdV3kjV3QIRHhsZmJrKfzyAmmxbPUb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716569829; c=relaxed/simple;
	bh=l1aJJdsrXWHmCnIX127TQOP0VSwnaeYP5xdZxXkZzhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBmdIiQKdai5syYoM0G099VpKkEXSO//yeaaYWjSN+23LtfXcx4hWOEh9jESXmfpPgHntlOGwZGOMIKh4O46wIstVOpt0/SGKRL443t9k1NtO7cXrW4wllkVRT2u59nOgFg+jXhfAxoWIwVyMzFG0xxZcq1b8l0HUkUaxBhqgEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EVVWgz9R; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-43f87f93b5fso20445881cf.0
        for <linux-rdma@vger.kernel.org>; Fri, 24 May 2024 09:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716569826; x=1717174626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TBWoEuiPCoyhitNUeh7DyFdGol0fdOT1fF6AN3MxmO8=;
        b=EVVWgz9RLw1P4/SZygJHLXQCn3btGM7cMtzrrMUIlSkFynT9LOsDcTiNecuzxAGzEn
         zmW/AQk2fkRdc47KToM207lPQ7vfKPx9+SEbqwiroWXFCGDWn6RLn36SEtAsiIoLfulS
         uby3Ogu6fx7RbBw6NqmnO9T6v/RO7zl3NA54oEBa6xSGiNBe6+KbhluHAXPCJuw1kjBD
         fPPAqAu7qmWwYqCzpeRAP7d/l+ZbcIZCFqEkNKuaQf9EmDo+S4hARmg+PbRjL09SW4et
         Tnh+vR6BKE8OFSThvDDDv2o10S+5D9IoSwxP3t4QDEsyTvyeM22lP+VoWRbBkm5+iafD
         XyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716569826; x=1717174626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBWoEuiPCoyhitNUeh7DyFdGol0fdOT1fF6AN3MxmO8=;
        b=Ged+h8Ixnr86U688Sx7kieTLhhQmydi2UPkF+rIjUSUGpNpT4A23ToHCH6TAD0W32E
         jLJ3LgV/DKsMTtLai9DDGW26SWF61vXJPHT1Pm9cqoJTMnNM9P760vRng5cAJBsEkM9P
         baBtNAiG0dYt05oINeUu1In/eMnK5BKvKjrUszCs3KQ2cOSYBkmXLvK2v+KSZqDlJ+l4
         SdS6YObkJhQQQfBsQ0BQt//OD0PweLGHiDuoEbfnifNktSHSNbFtBmNAs29yc1/TvVYI
         7PL15uTS2h2v+WZduCnT5HNZ1SJZNzvMwOZwWwFdjV4yhfdD6Yh/ZQzG2QoZOTWYLbv4
         LGDg==
X-Gm-Message-State: AOJu0YzBMM3rbmVl9fVccbJ81W2/zNDlA3l4wp/KY+k39tDOyKHBigHy
	S8GH6YD7pTxRr2J+sJinG5GSmKueOKzi0jD8+VAr6LM3SxrM20/saJZL+CXCdm8=
X-Google-Smtp-Source: AGHT+IHhfEoToqWOauUqNy9+07fo1jiVQVScObacERk4fUToryZcKjAaltgvard/+oZT3oYkDWkRIQ==
X-Received: by 2002:ac8:7c45:0:b0:43f:95c3:cefe with SMTP id d75a77b69052e-43fb0eeeac0mr31566621cf.57.1716569826484;
        Fri, 24 May 2024 09:57:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb16becffsm9543491cf.20.2024.05.24.09.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 09:57:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sAYE4-001uQC-5B;
	Fri, 24 May 2024 13:57:04 -0300
Date: Fri, 24 May 2024 13:57:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"kheib@redhat.com" <kheib@redhat.com>,
	"edwards@nvidia.com" <edwards@nvidia.com>
Subject: Re: [bug-report]rdma-core v51.0 build error with Rocky Linux 8.8
Message-ID: <20240524165704.GS69273@ziepe.ca>
References: <SA1PR11MB68950882F65EE948009BF33986ED2@SA1PR11MB6895.namprd11.prod.outlook.com>
 <20240523151902.GJ69273@ziepe.ca>
 <SA1PR11MB68959864102CC0DA683FA28E86F52@SA1PR11MB6895.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR11MB68959864102CC0DA683FA28E86F52@SA1PR11MB6895.namprd11.prod.outlook.com>

On Fri, May 24, 2024 at 04:40:20PM +0000, Marciniszyn, Mike wrote:
> > > /home/mmarcini/rpmbuild/BUILDROOT/rdma-core-51.0-1.el8.x86_64/usr/shar
> > > e/doc/rdma-core/tests/*.py
> > >
> > > Earlier in the build this is seen:
> > > -- Found Python: /usr/bin/python3.9 (found version "3.9.16") found
> > > components: Interpreter
> > > -- Could NOT find cython (missing: CYTHON_EXECUTABLE
> > > CYTHON_VERSION_STRING)
> > >
> > > The issue appears to have been introduced by:
> > > 1462a8737 build: Fix cmake warning
> > >
> > > cmake appears to find the 3.9 python despite having:
> > > -DPYTHON_EXECUTABLE:PATH=%{__python3}
> > 
> > I looked at this briefly but didn't guess what the issue really was?
> > Do you know more?
> > 
> > Jason
> 
> I looks like the above commit changes the cmake to use a new >= 3.12 code path:
> 
>   # FindPython looks preferably for Python3. If not found, version 2 is searched
>   FIND_PACKAGE(Python COMPONENTS Interpreter REQUIRED)
>   set(PYTHON_EXECUTABLE ${Python_EXECUTABLE})
>   if (NOT NO_PYVERBS AND Python_VERSION_MAJOR EQUAL 3)
>     FIND_PACKAGE(cython)
>   endif()
> 
> There is an additional refinement from:
> 5dcc1f402 Improve python searching logic in buildscripts.
> 
> That patch does NOT fix the issue.
> 
> The rhel 8.10 cython requires the 3.6.8 Python, but the FIND_PACKAGE() for python
> returns the python3.11 required by valgrind dependency resolution.
> 
> The issue happens on any system where the cython required interpreter is older than the most recent python.
> 
> This can be reproduced by loading a newer python and rebuilding the 51.0 rdma-core from a git clone using either 51.0 or master.
> 
> An RPM based RHEL build can replace the existing PYTHON_EXECUABLE
> with Python_EXECUTABLE.

You mean at some point we lost that PYTHON_EXECUTABLE works and it got
renamed to Python_EXECUTABLE ?

Jason

