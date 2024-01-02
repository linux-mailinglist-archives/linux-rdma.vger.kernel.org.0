Return-Path: <linux-rdma+bounces-521-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97904821F7F
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jan 2024 17:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95EF51C225B1
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jan 2024 16:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607AF14F83;
	Tue,  2 Jan 2024 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="kUwjLdx1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873ED14F6B
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jan 2024 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9c2db82b0so1902644b3a.1
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jan 2024 08:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704212869; x=1704817669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKUpzcKfJ4CRpQmJoTjvp0nUG7NQRooWJjvPVXnXSsY=;
        b=kUwjLdx1xdJ3nowdkG6Z0dAyL/wzjh/FqV+9FrlK7IOrdGTq1CBZCBHCsxirtLsYZx
         0K6Rx2zmHMfFIBusfnZ3QqYG2X/Xkqi0YzrZ2DI2NzrCCMtVGC5kdUYuQyolyZeN21LB
         MAKtujmKqrLvaNQO1AEjAhexjzS9t6KrH80UHHMTwfOozDL2JnVBL124A7cSpBu6eitf
         ukEPchuVUhbeA0BXqvHFs7kNsumCl171+1KIA9FzkvKKggYovPEF0ocg4fAeF79bJLmM
         YMy+jPBqG2Wm3MQv/NriWkOeixviMl6xQQ+hTG81gTu8f+c2kHkmhNX2wRBcVMw0G7KO
         bcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704212869; x=1704817669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKUpzcKfJ4CRpQmJoTjvp0nUG7NQRooWJjvPVXnXSsY=;
        b=CuUnDzh6Pjd5eimYdxwKe4d6HwwG0UpM0J5Q5RcnwAZjlVGe4zwgMbCh2zL38T7XGn
         90OIg8bjq+1CUhcuY4+3Yaaf48gsVPOFgTvQpfkAVwjXR8xEzO9RA0DJeTtXA0emiBbk
         dYxQZQ4PiVgJgEmATPexU9ghQv2tLgRAuL61teM/i6Wcp2cmD6FqsSfhR6Pl5Q1Mtz/Z
         2vTeA9/QEo9GI/Qm2xqY+P2j6LrBTPmlSiN7rtKjZbLH6tSS7v4sdgl8E/ycagE9ZhW1
         t3KpBssOZ3JerCqwAQTZHVqqIp+jxezmaNXxAXXjOmaMJbje9zoc0t5dZmzpbiryTm2U
         kNBA==
X-Gm-Message-State: AOJu0YxJf6JWwSRxrmR3TFxR69hmUo4gaYIkLo+vH2cIRb2aHioEDZC4
	QI0HfhiOJDHtyVFJpL0aeXdto09v5gvlgQ==
X-Google-Smtp-Source: AGHT+IERWmqUOpbnix5+6fv405QttyAlmxXh+YhYqlFE1PFufsZFlWMWM8SxWy4iZQzC0TxLDhra/A==
X-Received: by 2002:a05:6a00:2d1a:b0:6d9:b569:baba with SMTP id fa26-20020a056a002d1a00b006d9b569babamr6557994pfb.61.1704212868738;
        Tue, 02 Jan 2024 08:27:48 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id fn24-20020a056a002fd800b006d9974a87fcsm17808191pfb.215.2024.01.02.08.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 08:27:48 -0800 (PST)
Date: Tue, 2 Jan 2024 08:27:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Chengchang Tang <tangchengchang@huawei.com>, Junxian Huang
 <huangjunxian6@hisilicon.com>, jgg@ziepe.ca, dsahern@gmail.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH iproute2-rc 1/2] rdma: Fix core dump when pretty is used
Message-ID: <20240102082746.651ff7cf@hermes.local>
In-Reply-To: <20240102122106.GI6361@unreal>
References: <20231229065241.554726-1-huangjunxian6@hisilicon.com>
	<20231229065241.554726-2-huangjunxian6@hisilicon.com>
	<20231229092129.25a526c4@hermes.local>
	<30d8c237-953a-8794-9baa-e21b31d4d88c@huawei.com>
	<20240102083257.GB6361@unreal>
	<29146463-6d0e-21c5-af42-217cee760b3f@huawei.com>
	<20240102122106.GI6361@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jan 2024 14:21:06 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> On Tue, Jan 02, 2024 at 08:06:19PM +0800, Chengchang Tang wrote:
> > 
> > 
> > On 2024/1/2 16:32, Leon Romanovsky wrote:  
> > > On Tue, Jan 02, 2024 at 03:44:29PM +0800, Chengchang Tang wrote:  
> > > > 
> > > > On 2023/12/30 1:21, Stephen Hemminger wrote:  
> > > > > On Fri, 29 Dec 2023 14:52:40 +0800
> > > > > Junxian Huang <huangjunxian6@hisilicon.com> wrote:
> > > > >   
> > > > > > From: Chengchang Tang <tangchengchang@huawei.com>
> > > > > > 
> > > > > > There will be a core dump when pretty is used as the JSON object
> > > > > > hasn't been opened and closed properly.
> > > > > > 
> > > > > > Before:
> > > > > > $ rdma res show qp -jp -dd
> > > > > > [ {
> > > > > >       "ifindex": 1,
> > > > > >       "ifname": "hns_1",
> > > > > >       "port": 1,
> > > > > >       "lqpn": 1,
> > > > > >       "type": "GSI",
> > > > > >       "state": "RTS",
> > > > > >       "sq-psn": 0,
> > > > > >       "comm": "ib_core"
> > > > > > },
> > > > > > "drv_sq_wqe_cnt": 128,
> > > > > > "drv_sq_max_gs": 2,
> > > > > > "drv_rq_wqe_cnt": 512,
> > > > > > "drv_rq_max_gs": 1,
> > > > > > rdma: json_writer.c:130: jsonw_end: Assertion `self->depth > 0' failed.
> > > > > > Aborted (core dumped)
> > > > > > 
> > > > > > After:
> > > > > > $ rdma res show qp -jp -dd
> > > > > > [ {
> > > > > >           "ifindex": 2,
> > > > > >           "ifname": "hns_2",
> > > > > >           "port": 1,
> > > > > >           "lqpn": 1,
> > > > > >           "type": "GSI",
> > > > > >           "state": "RTS",
> > > > > >           "sq-psn": 0,
> > > > > >           "comm": "ib_core",{
> > > > > >               "drv_sq_wqe_cnt": 128,
> > > > > >               "drv_sq_max_gs": 2,
> > > > > >               "drv_rq_wqe_cnt": 512,
> > > > > >               "drv_rq_max_gs": 1,
> > > > > >               "drv_ext_sge_sge_cnt": 256
> > > > > >           }
> > > > > >       } ]
> > > > > > 
> > > > > > Fixes: 331152752a97 ("rdma: print driver resource attributes")
> > > > > > Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> > > > > > Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>  
> > > > > This code in rdma seems to be miking json and newline functionality
> > > > > which creates bug traps.
> > > > > 
> > > > > Also the json should have same effective output in pretty and non-pretty mode.
> > > > > It looks like since pretty mode add extra object layer, the nesting of {} would be
> > > > > different.
> > > > > 
> > > > > The conversion to json_print() was done but it isn't using same conventions
> > > > > as ip or tc.
> > > > > 
> > > > > The correct fix needs to go deeper and hit other things.
> > > > >   
> > > > Hi, Stephen,
> > > > 
> > > > The root cause of this issue is that close_json_object() is being called in
> > > > newline_indent(), resulting in a mismatch
> > > > of {}.
> > > > 
> > > > When fixing this problem, I was unsure why a newline() is needed in pretty
> > > > mode, so I simply kept this logic and
> > > > solved the issue of open_json_object() and close_json_object() not matching.
> > > > However, If the output of pretty mode
> > > > and not-pretty mode should be the same, then this problem can be resolved by
> > > > deleting this newline_indent().  
> > > Stephen didn't say that output of pretty and not-pretty should be the
> > > same, but he said that JSON logic should be the same.
> > > 
> > > Thanks  
> > 
> > Hi, Leon,
> > 
> > Thank you for your reply. But I'm not sure what you mean by JSON logic? I
> > understand that
> > pretty and not-pretty JSON should have the same content, but just difference
> > display effects.
> > Do you mean that they only need to have the same structure?
> > 
> > Or, let's get back to this question. In the JSON format output, the
> > newline() here seems
> > unnecessary, because json_print() can solve the line break problems during
> > printing.
> > So I think the newline() here can be removed at least when outputting in
> > JSON format.  
> 
> I think that your original patch is correct way to fix the mismatch as
> it is not related to pretty/non-pretty.
> 
> Thanks

Part of the problem is the meaning of pretty mode is different in rdma
than all of the other commands. The meaning of the flags should be the
same across ip, devlink, tc, and rdma; therefore pretty should mean
nothing unless json is enabled.

I can do some of the rework here, but don't have any rdma hardware
to test on.

