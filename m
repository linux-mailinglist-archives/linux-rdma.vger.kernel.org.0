Return-Path: <linux-rdma+bounces-2609-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F828CE96C
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2024 20:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B341F21020
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2024 18:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C113BBED;
	Fri, 24 May 2024 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PaMIFMOF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DA21CAA4
	for <linux-rdma@vger.kernel.org>; Fri, 24 May 2024 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716574943; cv=none; b=nDHSsknjWH3l1O9PhQKou8D4N9uYpk+MdDUbKKHSDuglqP8ZlD4Xa87RfW2M0BqZarEYexpVF+m1H+bxit+qWQtThgr7Ss1mA6tWX1lJUUPs0KzwZeMBxZBB+AotyYCz1G94zj5ADz3wbO7F1e0PTKGc1+uxhzATFq4cP4SbfEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716574943; c=relaxed/simple;
	bh=ck9lEuB6iwrRyer0unTIelY0L5zcRHQ9K5UMMCIsP7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3J7JpUH6fbYcGtGDQdswVXkaYkCMV1OA5OKCDWn7+Z2txaPBt1fwbDxomXiOer1N+tSlMsU03Jjs6t3BiPdX1Yplf1Mh7BBK8pqPvMzyJJtxZ5A1YKWHWEiHDDxlS1Y/AZYxRnz330a4lYo+dmPHbgqZb+a0oVBj0R8kMqiek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PaMIFMOF; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b53bb4bebaso3016132eaf.0
        for <linux-rdma@vger.kernel.org>; Fri, 24 May 2024 11:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716574940; x=1717179740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UzK5yfgJpkVhApUrInC2hzpnNTKWefkVcoyK4psXhE4=;
        b=PaMIFMOFggptb8pjLhgd+sfERYnZDP0DH6rACAFiCV7+rEzdHPij13ts/XS8BF7CPj
         tMg+52rHa0RKUgeQmHpBoS+kT0yyFNbYJtPwT/oxs0lOvb2g7B038LXpNrR5YIHEtD6L
         Kwxg38pLQL81YFqHcWsKf8F26r5c+KxZaODoXoUsrWUbLx83qFRwydZr/3VB8KAesAvL
         r+oUcloTqpRWwwwLFwCuwTh7q55CZqV1M4qyThy8q88+6KNXEOu5pISIMJd7KAKQYkW8
         hyFG8Z4LkABs0Jtgdm03gKnM3Ma46qUOB8aN+saS1UkDMGpfaU6rVqZ8AMVe6OI5+RUo
         muCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716574940; x=1717179740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzK5yfgJpkVhApUrInC2hzpnNTKWefkVcoyK4psXhE4=;
        b=sOxE2HYiORHJOY7C8X8mkonqYz5qLcuEbgIyZLxL63YA5wsL/h3uTnAyAIFcE7SRAy
         IZhrsC+sWP3o8uMvQWOmhnLB+rZH9YHjK5gNmBWoI9FzdzMq/gvD9hYxwADTmhDYmfnY
         598R1FZE+tJr/UxrGzBMrUAGWJJFJJf9F+idjhoUnmExutVv+iVp5tj68xyfv7xMkZyn
         ETGz8yPOb2FPHIZ/vdB4N20ttusAezZh88TVYNd8NsPQSiMKN+lER4ZQ6Rpc9ibw89YT
         Pc0uIcgeil/nsM2DMJfg5iM9RVGLl/HCtq72+PCEeRKciS6NzhJshSCombVn1fd6TWh0
         TrLQ==
X-Gm-Message-State: AOJu0YzBHU13p9U7wosn3jse5fVTnwWQw4pS4CZGlzziRH17O6j0wVvS
	SO7WbKY3qDonS0YdhxgjWpZyRoK3LRepsCgCOPnyFHVyzcJoESD7Hgn6MFvPHuE=
X-Google-Smtp-Source: AGHT+IHUJrc/eEkwmMmt+t3Hj/zvdmJm5W/k5+Be9+qKHZng2MajNBdib9TiffGTP6Rel2dSJfM+DQ==
X-Received: by 2002:a05:6358:659b:b0:18f:42fe:267f with SMTP id e5c5f4694b2df-197e50f3362mr346917855d.8.1716574940025;
        Fri, 24 May 2024 11:22:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb17c8a6bsm10116411cf.21.2024.05.24.11.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:22:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sAZYY-0025Bq-4E;
	Fri, 24 May 2024 15:22:18 -0300
Date: Fri, 24 May 2024 15:22:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"kheib@redhat.com" <kheib@redhat.com>,
	"edwards@nvidia.com" <edwards@nvidia.com>
Subject: Re: [bug-report]rdma-core v51.0 build error with Rocky Linux 8.8
Message-ID: <20240524182218.GT69273@ziepe.ca>
References: <SA1PR11MB68950882F65EE948009BF33986ED2@SA1PR11MB6895.namprd11.prod.outlook.com>
 <20240523151902.GJ69273@ziepe.ca>
 <SA1PR11MB68959864102CC0DA683FA28E86F52@SA1PR11MB6895.namprd11.prod.outlook.com>
 <20240524165704.GS69273@ziepe.ca>
 <SA1PR11MB689549B8852C1A337271747286F52@SA1PR11MB6895.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR11MB689549B8852C1A337271747286F52@SA1PR11MB6895.namprd11.prod.outlook.com>

On Fri, May 24, 2024 at 06:01:51PM +0000, Marciniszyn, Mike wrote:
> > >
> > > This can be reproduced by loading a newer python and rebuilding the 51.0
> > rdma-core from a git clone using either 51.0 or master.
> > >
> > > An RPM based RHEL build can replace the existing PYTHON_EXECUABLE with
> > > Python_EXECUTABLE.
> > 
> > You mean at some point we lost that PYTHON_EXECUTABLE works and it got
> > renamed to Python_EXECUTABLE ?
> > 
> > Jason
> 
> The Python_EXECUTABLE is workaround that can be applied to a spec file.

OK, that is clear. If PYTHON_EXECUTABLE no longer works that is a well
understandable issue.

Something like this maybe?

--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -216,6 +216,9 @@ endif()
 
 # Use Python modules based on CMake version for backward compatibility
 set(CYTHON_EXECUTABLE "")
+if (${PYTHON_EXCUTABLE})
+  set(Python_EXECUTABLE ${PYTHON_EXCUTABLE})
+endif()
 if (${CMAKE_VERSION} VERSION_LESS "3.12")
   # Look for Python. We prefer some variant of python 3 if the system has it
   FIND_PACKAGE(PythonInterp 3 QUIET)

Jason

