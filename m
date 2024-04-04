Return-Path: <linux-rdma+bounces-1793-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8747A89925A
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Apr 2024 01:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279C51F21FD8
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Apr 2024 23:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC4213C695;
	Thu,  4 Apr 2024 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="g1V0MlKI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D556FE1A
	for <linux-rdma@vger.kernel.org>; Thu,  4 Apr 2024 23:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712275175; cv=none; b=a4MTyoNVlDnK/wNXsfIwqE1kOhaDwmlATs+hW7oCfcfvopdD11VokKCXqtLUAAn7elDoam5y1udO8dVs15ZDf58EItemBc5xdAy/waXyaBNaSGaoOqTS+pfVa495mL7JrSVYYGnqDftcO8tl4lmjbO4UwcBoQc0bAK4dYsLs/Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712275175; c=relaxed/simple;
	bh=MQbbpQB1SDu9nHYBvWu2mX1hvnY3Hh78ccxwnMzjmZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5CwB7DeldPNUAS6e2+tsTCYUCw1FrjFzggHJU35ew9XjWJz5kIsFKUWWLue1mycsj6bDQDCPOaGov0Q7mKwixN8MnVQxefwbQIJH9h5J9JRiQAWs9wdEwPAcrAKLvcG+jtdgWKWnRl/LY009P7hFQlgWkdkwUZxyrKMGYmYAsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=g1V0MlKI; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-430dcd64e58so8888631cf.0
        for <linux-rdma@vger.kernel.org>; Thu, 04 Apr 2024 16:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712275173; x=1712879973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hn1o5IdnjbcN09fJNkUd1Mm0FhvT/ZdOd9a1+fFImsg=;
        b=g1V0MlKIPNuJ1JZq2NLAvOvrNpYa+K4fkaCX3NKzDpjNAsmiK4LH8LQr/rc6goNB2f
         p+/lO9D+3wWiWQC9IFC2TMjwLeP/yGQR6Nhi9bEsgn2WVEp0uEjwGn8IQcZLNrxUxuus
         xfI29e2KE0ghniWmJszXVDxvp2TztfC4HHvbmUeP+59Ek4veN+R7W2+Vd90LVmpPDDCP
         4Irm+JPOsp6ArmggbvGD/ktSZ+oGBVyE99l86hEkwahCyNUJ4/19qq+88ZfBCqn97lqO
         DXAcAy05lDUcH3UW4rbxCQfjUZFeTdckeexyqPm5PvPWF0iwIB5MUhgmtsRIgviTaZ5s
         cStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712275173; x=1712879973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hn1o5IdnjbcN09fJNkUd1Mm0FhvT/ZdOd9a1+fFImsg=;
        b=W1DN+EuMaQp3bLwQMXAr8zfZqFRbMyMhG/aZk0nE28D6uRGkFM8WaFi49F2/mddGWm
         hFt3Ed4V+1p8VKzZ/4wv7Uxt0GJv4XAlkeDM3VuZ9767SSk6YGP1YCYGJX8XKJdU+i7A
         +Jx2YQ897IBIoApnBDJrg6UorFnd89xY8hV0fpNB0V/Y+cQ3VedTEn1Q1wIFrhudhxds
         94/VxO3vIxBCIL6fABKXtnPrIJ4dU6xjBUk/Om1eFpOmV2h6NRpYQwjHcgQ7tUjsY99m
         ofRoO/nZyiAME/Sib0gLx84B3bdfZCgRUyNv24b8NrO+j73eBF0MlRTkkDdfznShWTMc
         zOxw==
X-Forwarded-Encrypted: i=1; AJvYcCVtBoqgINJ5GuWD5D7XdinFiX2boovV/jDlUyZZlE6LbmvW+eKIlaVuCR9z4T3OepXO5gx/biRfRhiOE/DnlwjQvFXSSeuUUcBBIA==
X-Gm-Message-State: AOJu0YwJ8SdnFy1VV5ItT0n4dojPei+8Pam6iTxa9aidYFolebw2aBMF
	fWXzepnPcETOc7mrnc9us4LLfyfNcpY+iBmGwF+L94QOmmPAw9GXc47XtWxTGeROlbyov9hGo1o
	G
X-Google-Smtp-Source: AGHT+IE7g97v/9E5EDVtRElXxiqJGa9C18tXPzB30iB11iKAH25nv1RxA1cbqrw0ZpGcfI1roDjIOg==
X-Received: by 2002:a05:622a:14ce:b0:431:6303:294a with SMTP id u14-20020a05622a14ce00b004316303294amr4313963qtx.37.1712275172830;
        Thu, 04 Apr 2024 16:59:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id dp5-20020a05622a47c500b0043438a061d7sm214077qtb.6.2024.04.04.16.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 16:59:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rsWzT-0001eU-Cc;
	Thu, 04 Apr 2024 20:59:31 -0300
Date: Thu, 4 Apr 2024 20:59:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/rxe: Make pr_fmt work
Message-ID: <20240404235931.GA5792@ziepe.ca>
References: <20240323083139.5484-1-yanjun.zhu@linux.dev>
 <20240327130804.GH8419@ziepe.ca>
 <a9011ab4-6947-4ad4-8d1f-653e129c38b9@linux.dev>
 <20240404145913.GF1363414@ziepe.ca>
 <7a2a41c2-c8ef-402d-933a-2b2d8a956207@linux.dev>
 <be9584b6-85fc-46bb-87b8-18ca6103a5a4@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be9584b6-85fc-46bb-87b8-18ca6103a5a4@linux.dev>

On Thu, Apr 04, 2024 at 08:03:35PM +0200, Zhu Yanjun wrote:
> > > > Because this driver will finally call printk function to output the logs,
> > > > the header file include/linux/printk.h needs be included.
> > > > 
> > > > In include/linux/printk.h, pr_fmt is defined.
> > > This doesn't make sense, printk.h has:
> > > 
> > > #ifndef pr_fmt
> > > #define pr_fmt(fmt) fmt
> > > #endif
> > > 
> > > Before or after printk.h should not have an impact.
> 
> 
> Sorry. The previous mail is not sent successfully. I resend it.
> 
> > #ifndef pr_fmt
> > 
> > ...
> > 
> > #endif
> > 
> > The above will not undefine pr_fmt.
> > 
> > #undef pr_fmt will undefine pr_fmt.
> > 
> > This link explains the above in details.
> > 
> https://www.techonthenet.com/c_language/directives/ifndef.php

Why would you want to undefine it? The point is to #define it to the
rxe specific value. If it is already set to the rxe specific value
before including printk.h then it will work fine?

Jason

