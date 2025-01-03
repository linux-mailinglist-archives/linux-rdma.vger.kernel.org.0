Return-Path: <linux-rdma+bounces-6793-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3319A00B22
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 16:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D7A16411E
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 15:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59C7158553;
	Fri,  3 Jan 2025 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RTaotfxE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923461E0087
	for <linux-rdma@vger.kernel.org>; Fri,  3 Jan 2025 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735916751; cv=none; b=e3iq95VBkdoCOUakUlJj2SVVgCCvVW2fe95TzwoCfWd4tqTci84g22W99vFnNc0s9SdO2YBNvAj9zQe9jpZhjW0NQxBmzZ8FgqnPU+IUjFxBa4bRE1aczUZmQktdiS6LrYygH/mWrr7dbsNI8T4oKlhawQ+Vi2Nr9TiPg86//Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735916751; c=relaxed/simple;
	bh=FS5d3aYzriRjnHm6y73ZVKZVJeP8MQMVEaTCyE3JELs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Isttqte0aSkq3bnaImqALXcQthw1Ihkyaj3u0OdKqQhFPMBnYe2pVk/hyRrtbpwahT3wAf8jmNz5pNCPuVsVVaQ8ZRR8qcq+lrB1BYX2QDf2KejWYhSUpTW+MpaPm0eN+J7EjwgQ8B6Gc4a+qvCjXnLNhKFh8ziAlgJ2Cl6migM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RTaotfxE; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b6e9db19c8so924448285a.3
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2025 07:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1735916748; x=1736521548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n6BKjuq/x7JutnNCU83CQjlr2jbXNUAPtCF2NWZHrUM=;
        b=RTaotfxEr7oX0wShcZaO8T80H1S6dV3/TxwX5jMJlthcQu9SLSg5PwxgXcGs94lQxq
         KeX+8L7iSDgywyEvvpHggLZwhYtpeZkgw1wYiFEjF6KeSrX2cDnuftdskQHK+F1ura96
         6cfzdiKOZctLqDWuKfluFjn7rjG8iDCuzBu+8Z+f09jtW62F2ojBxZCB7eRxJTNR2/AU
         8/+xbOa9OarOGoO0Dtjsc7kh3TstOs4EVViyjDpKDQAjWSl1Qou2AzUqKueiWbGbE0J2
         iCSMTujBU87DOKQl7+SCN7XhelwdITjQmRaUnTvcUYlmMcaJOpoNKH2pAjsdJ7PWuI04
         ovaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735916748; x=1736521548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6BKjuq/x7JutnNCU83CQjlr2jbXNUAPtCF2NWZHrUM=;
        b=UpCZMGVePASzS7t4VxQKU4k73AFj8+8z3Po7mFkE8kRMlUowTvVWDZQD1DoRsTnV2O
         hueClx/cXj4/NGZJ7PoEXC2ha+4GvXedTNHGNu9huntcL10MW3HMjl39jRMiOsOfmIn2
         hNtB1aQ/oZI+kHdj+s327nSMVR4SKsRwzxQP/Ew9IjB56FiCQgCQQWyjOxFIe0iNfZxn
         DfKBj6YNpv7aZKMbSVZq7byIcXfW/3SvZG1CWD0dPBtl8ZdYLqLCLv6zitcPgd5gHioY
         940MEAXT/wsimTAlYMekMMrwOxj6jhQweEHPK0S8x55SfjvZLiDa2cIFL8usnqKK+eX+
         XZBw==
X-Gm-Message-State: AOJu0Yw+nIMDyTcDiSLqZEv2ujmSIePyT22at4bVdvJA9mrskzv58A50
	Niz/LZ+4dIA21Vu+KdlJYpTeEj2ul9Y+FbPYVC0RLZayrGasNh8ClfQneOdqBhk=
X-Gm-Gg: ASbGnctpM2O+ja6XhFIgB1FTCirUZ6wI+H27NwvH6KlLHI8SqPciN36E0Cvh/Ph3Suo
	QlhRiMnKqld1kEFTeJPBZZBpJFqYVbpgBCeeoXe6DDNG3VXtxVZ2jOt1kMTXXx5+yOAm7cHpM2A
	i1+Qyl5m6wQ23PRdyO5qj/z/g53IRxFPMK3Hpe7s8UK91TJxszrvEEwOFoSyVBFQCPjb19TRMy0
	Pmnb+5GZClRsUnJWHoXQ4oA5kaOa2vRokTFAz2A1b6thzv8+yB838u/o09RvwQRwhgvJr3vm+XJ
	XZp2gSmScfiMzgnYaizsGvMiSgrh+g==
X-Google-Smtp-Source: AGHT+IE7tSnjtJxc238CW0Nv+0m7Du5Z0ntR7k8rJ/hiKDcj6QGkysJlx7+kpT6z+7a01T7NF0vlVg==
X-Received: by 2002:a05:620a:394a:b0:7b6:d710:2282 with SMTP id af79cd13be357-7b9ba80ebc6mr8676475285a.49.1735916748505;
        Fri, 03 Jan 2025 07:05:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac4cd53fsm1277146885a.112.2025.01.03.07.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 07:05:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tTjFC-00000000irj-27xw;
	Fri, 03 Jan 2025 11:05:46 -0400
Date: Fri, 3 Jan 2025 11:05:46 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
	'Joe Klein' <joe.klein812@gmail.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>,
	"zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
	"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: Re: [PATCH for-next v9 0/5] On-Demand Paging on SoftRoCE
Message-ID: <20250103150546.GD26854@ziepe.ca>
References: <20241220100936.2193541-1-matsuda-daisuke@fujitsu.com>
 <CAHjRaAeXCC+AAV+Ne0cJMpZJYxbD8ox28kp966wkdVJLJdSC_g@mail.gmail.com>
 <OS3PR01MB98654FDD5E833D1C409B9C2CE5022@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <OS3PR01MB9865F967A8BE67AE332FC926E5032@OS3PR01MB9865.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB9865F967A8BE67AE332FC926E5032@OS3PR01MB9865.jpnprd01.prod.outlook.com>

On Tue, Dec 24, 2024 at 08:52:24AM +0000, Daisuke Matsuda (Fujitsu) wrote:
> On Mon, Dec 23, 2024 10:55 AM Daisuke Matsuda (Fujitsu) <matsuda-daisuke@fujitsu.com> wrote:
> > On Mon, Dec 23, 2024 2:25 AM Joe Klein <joe.klein812@gmail.com> wrote:
> > > We have tested this patcheset and had a lot of problems, even without using the ODP option in softroce. I don't know if
> > others have done similar tests. If we have to merge this patchset into upstream, is it > possible to add a kernel option to
> > enable/disable this patchset?
> > 
> > Hi Joe,
> > 
> > Can you clarify the test and the problems you observed?
> > I wonder if you tried the test with the latest tree WITHOUT my patches.
> > 
> > As far as I know, there is something wrong with the upstream right now.
> > It does not complete the rdma-core testcases, and 'segmentation fault' is observed
> > in the middle of the full test run, which did not happen before October 2024.
> 
> It appears that the root cause of this issue lies within the userspace components.
> My report yesterday was based on experiments conducted on Ubuntu 24.04.1 LTS (x86_64).
> It seems to me that rxe is somehow broken regardless of kernel version
> as long as userspace components are provided by Ubuntu 24.04.1 LTS.
> I built and tried linux-6.11, linux-6.10, and linux-6.8, and they all failed as I reported.
> 
> I switched to Ubuntu 22.04.5 LTS (aarch64) to test with the older libraries.
> All tests available passed using the rdma for-next tree without any problem.
> Then, I applied my ODP patches onto it, and everything is still fine.
> ####################
> ubuntu@rdma-aarch64:~/rdma-core$ git branch -v
> * master fb965e2d0 Merge pull request #1531 from selvintxavier/pbuf_optimization
> ubuntu@rdma-aarch64:~/rdma-core$ ./build/bin/run_tests.py
> ..........ss..........ssssssssss..............ssssssssssssssssssssssssss.sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss........ssssss..ss....s.sssssss....ss....ss..............s......................ss.............sss...ssss
> ----------------------------------------------------------------------
> Ran 321 tests in 3.599s
> 
> OK (skipped=211)
> ubuntu@rdma-aarch64:~/rdma-core$ ./build/bin/run_tests.py -k odp
> sssssssss..ss....s.s
> ----------------------------------------------------------------------
> Ran 20 tests in 0.269s
> 
> OK (skipped=13)
> ####################
> 
> Possibly, there was a regression in libibverbs between v39.0-1 and v50.0-2build2.
> We need to take a closer look to resolve the malfunction of rxe on Ubuntu 24.04.

That's distressing.

> In conclusion, I believe there is nothing in my ODP patches that could cause
> the rxe driver to fail. I would appreciate any feedback on potential improvements.

What am I supposed to do with this though?

Joe, can you please answer Daisuke's questions on what problems you
observed and if you observe them without the ODP patches?

Jason

