Return-Path: <linux-rdma+bounces-2861-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808E08FBD3B
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 22:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3708B24741
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 20:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A2914B07E;
	Tue,  4 Jun 2024 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="msbEdG3+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD89314036B
	for <linux-rdma@vger.kernel.org>; Tue,  4 Jun 2024 20:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717532541; cv=none; b=uXr7L4FHJUwnC0+nRk5V5XiB0XknB/KvaEKzdX7U2PUTuBAExrAwd0grVNTyIzTjvYkCSSE1lMHh0nssyvzL42ZTzDaMA5/SqYZ1forIjFRCVnHtf6cIsznVtpFwDAuZY6BcsrHYNaBCUXNwrvzB1miq4Wf9/NnnwgZFaa2+SeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717532541; c=relaxed/simple;
	bh=QkyPeBaq7dP4OtW3UWcZupg2kaYwdwflc/4GYoX/L1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVTDQHsPJjbqSbBHFJWwTnwyfunHJ9mvPgPclye07bfE16XJmmqayjj/6eZYv8Hd7RJcRwLpNAETz/hL9COV4cq1X711ukUI57mZWJUv140yGcm2Or0d7QFtIbD8yWNeoNgWW/JBt/W1o2DleV8ekFQmAPmrtIgAqD3yexf4iKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=msbEdG3+; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-62a2a6a5ccfso61804327b3.3
        for <linux-rdma@vger.kernel.org>; Tue, 04 Jun 2024 13:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1717532539; x=1718137339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DpO0Oedcoyfc1GBxzOP408XHjyjwsGGuTsrK8A0oNlM=;
        b=msbEdG3+K6l8jYz7JZkKG1/bI8T/IjKRp89SaTgcstxBU9eM/ZrFLtWrueqQt+RBBx
         4twouMcL451Sgs2cL4y7+58gANu2cEReTsEtS5wU28IupftT70PwR1SutR242pQd56Lq
         nuMczGCJdyHc43BiWBOVO3R4PoeM4/bo3uoTqEoWh5HSIp5ZK2fZisqCagoDJ4sKN766
         hmwz9epIwJlW5YYOJ612CXCP0W/VEVW57fZex+YoFdQXloT2bpFkuGnUsgepiyyun9rx
         F8xFZhqksRukpku+1iistynu2Sw4WgROTJyh6Ak5exvx1TJ7dwwLO+XRCmakVHBq2ERU
         2/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717532539; x=1718137339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpO0Oedcoyfc1GBxzOP408XHjyjwsGGuTsrK8A0oNlM=;
        b=o3gMOZ1XXYWLmkRmG9z6rExcacUE19D9wLjuaNfOKEKKtN+3Mti10vXQkQX7O7uY6C
         SkUjtcT7QUcmeyMGOGCeM6q970M/hYPs1qYDhmwiWtDCs7ajN9h5xETjxV6whJUB1my2
         Ofghzgz2YraPjABlps9v9aVb5nEsdwPrmPxKNsLfAJjkZ3UkM5NWoi8nGphe8S/wRG6W
         HCnh7LQt0iHoe4+Q6k6PqLBCZJEBKVrjdURh/DlwLuu+jU9XeTZNMrSm+ad/4pRP4W2D
         XmooJvnd56yd65GOn3o0cX8Ds1gsT9cdEiVVhd1opPnx0Dk4zPQQJBrwyslqot3RbDU0
         JibQ==
X-Forwarded-Encrypted: i=1; AJvYcCULRGa0vAcyvMOcTMadT235jouq58r1961+Gvh5Y+JyO7GczXuJTKt+iQgW2BIa8mUDlelQ3vyWkQZXyrOTOw/JJsGgWaa7T6yVjw==
X-Gm-Message-State: AOJu0YznsW1Lims7S6h1SPROpB7MjFp49Gg32PACSV+ghHavMBole2A1
	0auS8KVysQgup7vAf4JVLzGoP6ilPVw25hEFxzofoSeqj04fK5u2o4GPsfEBSmg=
X-Google-Smtp-Source: AGHT+IHAJ4bvcBaw7wRkTLzCjzxNGMcSykOFIH1MytMT4eD4BgJ3oc9AY/rsP/QU6QmkimiKqz9TkQ==
X-Received: by 2002:a05:690c:703:b0:618:ce0e:b915 with SMTP id 00721157ae682-62cbb4e3d2emr4760637b3.27.1717532538766;
        Tue, 04 Jun 2024 13:22:18 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4a745c5fsm42595906d6.36.2024.06.04.13.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 13:22:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sEafh-003O9r-EA;
	Tue, 04 Jun 2024 17:22:17 -0300
Date: Tue, 4 Jun 2024 17:22:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [bug report] KASAN slab-use-after-free at blktests srp/002 with
 siw driver
Message-ID: <20240604202217.GB791043@ziepe.ca>
References: <5prftateosuvgmosryes4lakptbxccwtx7yajoicjhudt7gyvp@w3f6nqdvurir>
 <6bcbe337-c2fe-46ee-8228-a3cff6852c28@linux.dev>
 <a21021bf-6866-466b-a924-2f465fbb2e64@acm.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a21021bf-6866-466b-a924-2f465fbb2e64@acm.org>

On Tue, Jun 04, 2024 at 02:15:44PM -0600, Bart Van Assche wrote:
> On 6/4/24 03:26, Zhu Yanjun wrote:
> > 
> > On 04.06.24 09:25, Shinichiro Kawasaki wrote:
> > > As I noted in another thread [1], KASAN slab-use-after-free is
> > > observed when
> > > I repeat the blktests test case srp/002 with the siw driver [2]. The
> > > kernel
> > > version was v6.10-rc2. The failure is recreated in stable manner
> > > when the test
> > > case is repeated around 30 times. It was not observed with the rxe
> > > driver.
> > > 
> > > I think this failure is same as that I reported in Jun/2023 [3]. The
> > > Call Trace
> > > reported is quite similar. Also, I confirmed that the trial fix
> > > patch that I
> > > created in Jun/2023 avoided the KASAN failure at srp/002.
> > 
> > "the trial fix patch that I created in Jun/2023" that you mentioned is
> > the commit in the link?
> > 
> > https://lore.kernel.org/linux-rdma/20230612054237.1855292-1-shinichiro.kawasaki@wdc.com/
> 
> To me that patch doesn't seem correct. Jason and Leon, is my understanding
> correct that you are the maintainers for the iwcm code? Can you please help
> with reviewing this patch?
>
> Thanks,
> 
> Bart.
> 
> From 879ca4e5f9ab8c4ce522b4edc144a3938a2f4afb Mon Sep 17 00:00:00 2001
> From: Bart Van Assche <bvanassche@acm.org>
> Date: Tue, 4 Jun 2024 12:49:44 -0700
> Subject: [PATCH] RDMA/iwcm: Fix a use-after-free related to destroying CM IDs
> 
> iw_conn_req_handler() associates a new struct rdma_id_private (conn_id) with
> an existing struct iw_cm_id (cm_id) as follows:
> 
>         conn_id->cm_id.iw = cm_id;
>         cm_id->context = conn_id;
>         cm_id->cm_handler = cma_iw_handler;
> 
> rdma_destroy_id() frees both the cm_id and the struct rdma_id_private. Make
> sure that cm_work_handler() does not trigger a use-after-free by delaing
> freeing of the struct rdma_id_private until all pending work has finished.

I didn't try to look in detail but this certainly makes more sense to
me as a possible solution to a UAF

Presumably destroy_cm_id() does something to prevent new work from
being scheduled?

Jason

