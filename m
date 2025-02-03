Return-Path: <linux-rdma+bounces-7367-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69EAA26025
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 17:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2759F162526
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 16:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A325520AF98;
	Mon,  3 Feb 2025 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dNoKx26u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01182063C4
	for <linux-rdma@vger.kernel.org>; Mon,  3 Feb 2025 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600379; cv=none; b=YTQDTRyMtWDSqYGwy3jOHWk+QAlbKBPCpCoXuiniPYmr/7fxlY3JVrKyLWx3uD8xY+9C8lvPU/BHhwLE7G+bYodKyUuBT05JsGxzTKeVfvBhcqdDnNYPUYKt1dgfvdZjpo56gCoetfqHzzc1/TR4TyxMw0Yr2Y6tvdaLQLKV2VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600379; c=relaxed/simple;
	bh=psme0VaIIhjLKce46d38tZjzdqnc0vcgoTsX/wa/3Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eH/umsmcZZNGSESiPsnb6qjF6g7SeHiUWhunXWrUcFqiqsJdYrLf41RroWRwV8AbM9EwmuKdxjmp2nb7weMHx0Zvf0gbMFVWT2MolxyYx8/LIQ0k6WsmwUYekpHKstir8zVhQWi+6lzlv9TE4JgXfl0CewyQqCRVBJc8dGKVVWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dNoKx26u; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467725245a2so42263841cf.3
        for <linux-rdma@vger.kernel.org>; Mon, 03 Feb 2025 08:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1738600377; x=1739205177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xa+KehmHCdO7ws33puD503ZY+SFlPD5TNxEbLB/jkew=;
        b=dNoKx26uG0x154ao34L9ktpgpp8MFcEc7XNXnxVHSukZflsRfhYXLPL1hsgJO+K5+z
         EpoDBo2wm9ia3T6QeSvLqsjDaD/rKSPeLbfh4pghQHyxQd5I6lQnwPPdCEs+MhOX4+8f
         rZyKYxEp7D8d07BmdpJ/2utcDzEqcWLJ9O+5roA4FWrskZjrIqxQLZuYG2UvbK3s/jGz
         mG+rt35zI+Y2iZrmP3HQlhqnz/W9Owxe5FbYcTIqNZViKlXzdivAIsl4he+fRJqOGtYm
         IYYW/1ppAAMt5jmtT+xRHIcwg13+Qv7yiKRfF0W747MlIPwleXnkdhzErBZG2ZQ5vS3v
         V7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738600377; x=1739205177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xa+KehmHCdO7ws33puD503ZY+SFlPD5TNxEbLB/jkew=;
        b=S5Bpouv3dSem1LFt3Eb4IBaDF8QSIpbET4Byyo78j2xwlBYLivDvRBSNT8fT920k4z
         UOQ0HsTw6Qq5eyikCiUQ4BTcGJo/Q7A20/T6L7+ambUmWGsDBMrEoeoaY+7IJXXEPhxM
         7MmAEnl235xxm5K1is+QdFK4Z7MRgMnsCHVWWgBHHj35cH/N0w7qRpC3lh4/nDH32RY6
         0N0OLfPBi3We8F17TAVdGC5xcbPpLII3JLvhC9bam3ePcVwUZ4I9nqFLMqAd1yROze/I
         gbxId2qNzQVLhUaAbZ81qRwWv/VIJsOGQcXHj6HtqKff1WG8qv7EHGWQOQ7FWA3xC+TL
         3Znw==
X-Forwarded-Encrypted: i=1; AJvYcCXAgVq2OvhO6QBoo8rHWCt6xfbEoq76tMmH3XU0k/mbbRtEbW8bI7MqvpgAYNQ6x3a4PAkATmKtxDSI@vger.kernel.org
X-Gm-Message-State: AOJu0YyEcuKchUpFQTmwo9SZhMXtDp/+k9P0EAios7qDg019PSFc8cfs
	Ra7hoRWk77naZqHEHU/DQAabRtHUM9CvZogLjGj3dcNH4CmNdHJwrKQyXH2g60g=
X-Gm-Gg: ASbGncs/FsqTLGQ5cRr3ds0iC2TWYTRsjLFb3k0BqKv2cICvpQ9nRAOSqxxcfI2l6BJ
	XXreYWfE5P0mnIT7+D2TuV63psfRPLSGiEtGiyOyyCWTDA/WvPEag/QUnz83e4q+/1Vp3eK3ayi
	XoygUBg7UMZTuGpMuu5RGA7mYF7skKGNVr8nzxJix/gZNB7KNkYuzQz+nj+nMfYQKQfJtrZf7VA
	DmnaS8Uoe668naCIi8fA9HDUMLuy5esrHQHlcT7vaWR55fNJlx8B2gEr6a9IuaJrNV2J6wlpVf8
	1aVD3GxlVOlm9tD4aPiPoQuMXx36xoAhNJM7Ds7gCTUVfZCvyhPDJeUepJ0+xlQL
X-Google-Smtp-Source: AGHT+IHJeum439RmIFr9FXgOIQUKfCXniHSnRf0z51bI9P10KDm1UkVD+AzLPEv8lPXna3iL1oMiyA==
X-Received: by 2002:ac8:59ce:0:b0:467:6dd9:c961 with SMTP id d75a77b69052e-46fd0b317f2mr301268431cf.48.1738600376789;
        Mon, 03 Feb 2025 08:32:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf0a7547sm50263121cf.4.2025.02.03.08.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:32:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tezNX-0000000B68y-2tjd;
	Mon, 03 Feb 2025 12:32:55 -0400
Date: Mon, 3 Feb 2025 12:32:55 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
Cc: Joe Klein <joe.klein812@gmail.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>,
	"zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
	"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: Re: [PATCH for-next v9 0/5] On-Demand Paging on SoftRoCE
Message-ID: <20250203163255.GD2296753@ziepe.ca>
References: <20241220100936.2193541-1-matsuda-daisuke@fujitsu.com>
 <CAHjRaAeXCC+AAV+Ne0cJMpZJYxbD8ox28kp966wkdVJLJdSC_g@mail.gmail.com>
 <OS3PR01MB98654FDD5E833D1C409B9C2CE5022@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <OS3PR01MB9865F967A8BE67AE332FC926E5032@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <20250103150546.GD26854@ziepe.ca>
 <CAHjRaAfuTDGP9TKqBWVDE32t0JzE3jpL8WPBpO_iMhrgMS6MFQ@mail.gmail.com>
 <CAHjRaAd+x1DapbWu0eMXdFuVru5Jw8jzTHyXo2-+RSZYUK9vgg@mail.gmail.com>
 <20250113201611.GI26854@ziepe.ca>
 <OS3PR01MB98659E07C0DAA1838FFBC70DE5E92@OS3PR01MB9865.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB98659E07C0DAA1838FFBC70DE5E92@OS3PR01MB9865.jpnprd01.prod.outlook.com>

On Thu, Jan 30, 2025 at 10:51:58AM +0000, Daisuke Matsuda (Fujitsu) wrote:

> However, to be honest, I do not think Joe's report is valid. It is not normal to
> complain other's patches without providing any details. It makes difficult to 
> assess the validity of the claim, and blocks any further discussions forever.

Yes, I agree, let's move past anything without concrete actionable
details.

Jason

