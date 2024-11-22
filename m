Return-Path: <linux-rdma+bounces-6071-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 681619D5FAF
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 14:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217A0284910
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 13:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D64F1632C2;
	Fri, 22 Nov 2024 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsJBXRZF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796682309BF
	for <linux-rdma@vger.kernel.org>; Fri, 22 Nov 2024 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732281879; cv=none; b=MWcAJs7k1PahfgPB/zF9MCyzRA4IQnBPwSzLRg9jgMqM4FNUZmxpHWh4s7AL7+Cu7upJZ1ICaqDsC/s0VgywGme7oooCA9aQtqlH6krUchn2QUpk2sR7QPHaC7Fx5hNOa+kCsBxKKVTlhay0mqcmTLdgAQkSKZK46mNR1sNMLac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732281879; c=relaxed/simple;
	bh=v71kLM1lsPuJs3MLHiTD/qKWuwxvD0Wc4PnEXeveoZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+Z5gca0vy3Mk4sEtuBh7fs7esrhu5L92OXZqja3yh55+SsK9PHMnynQR15ZgNAwlos6WYW2WoKlEcRzva8/D3MIjLy+rsve+Cd0zgXOAfery71ZOn9oCfuCsFu1oaRnreMpxcqVHj691WnHAcgAjVjHqJCKiuMx8ykD2XpbT9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XsJBXRZF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732281876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y94t5t7vInyK/PjeMwY/7bcTLfnfeBf7keyh0B4oN9M=;
	b=XsJBXRZFaIOyajMcsmBeqCGnb1vKqN8ljaNlRU+rmeOoviyuX3TtzfIDZuehctH/8pd19F
	3Gn7AyCzwx2n6IlWqEzLf7QyTLHcNht5QXBdAgr7St1Aqx6pWNxDqUQycpAqf8dVj4boRU
	ZYgzY0XS5Y9EOGip9CxujgUay6fj3jQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-92szrkZRPnmFQ3QrwafUBw-1; Fri, 22 Nov 2024 08:24:35 -0500
X-MC-Unique: 92szrkZRPnmFQ3QrwafUBw-1
X-Mimecast-MFC-AGG-ID: 92szrkZRPnmFQ3QrwafUBw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43151e4ef43so14777115e9.3
        for <linux-rdma@vger.kernel.org>; Fri, 22 Nov 2024 05:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732281874; x=1732886674;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y94t5t7vInyK/PjeMwY/7bcTLfnfeBf7keyh0B4oN9M=;
        b=gSIWf9hcdPK4sVHGk9Gs8/T2JykOArL6Slt4CrcHDRkkBxb+8fY2TcP3VAXRQln7da
         S4i9zr7CGJgit6zf/NgPx6Coiw9p+6qY7mzkkxm5U5kHD6sEJuL4wxei23bYD0R4Uxwp
         JNX3xfZbtfTj7mkCceo7YlXRUPuSiJNqQ8HWoKGMYoLhjSXuQ4pS9SPFPIV8eXXtvHb1
         CEk2bTtgch+xWgXEnn1/6CEAE64mm6KF5s7Cf5Gx0gKAbGovXN0L9BDs4Pj6TPIEfyYu
         Q8nUi3G/TF+JQjjzdX+ysSw159mfgUcNBq0nX6rCFFm+ZnOQ8mwUylGdqa+DPpoClRKq
         9dew==
X-Forwarded-Encrypted: i=1; AJvYcCV3ZSTX8f3vfkLnM50uE0uTYn1eD/Es1cAI5XGMBhTrFek3Hf2Z10cLCR3e9wxTA5X60Wd/uT3ZR1WH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx643pr43BkYLoFb0+9uGB/jLdhrSxaUOm5l1bir/y3v0PZiRDJ
	brB0hwFuVGaNPsgZxZxVZebQ5wlR1xo6AjkdL88fpd/4xQyVcABSxaUf/OFfpxYoCHxn9TzZceW
	RxMtlbG9+8y9y9GeaZep4gwUpP+97ffRiNBHO6+aYPDlBPa8RPMJmBG4MFRQ=
X-Gm-Gg: ASbGncsejTYHwQZmBKssI803/a1IbC6AR152eFYQT03770zBv5JT7mhQpY88ZNmjztB
	ub8/TcGoL1LyPCCjEUOHRGCweoBYj37aF+2ILM11LiJLZwRzrEl8H8B9LsG1TueciwO92neLDlS
	1McFHSFL+jLqDCN+F214jsm1FfWTlilRa8XkgHurdZkVX01YZ14RRFzffwHQ29aQUWwC0AHx2fk
	0m3bcdKQqrajyCWdqd9y0ryRBP0BmIVwOCU4Ot2
X-Received: by 2002:a5d:6d8f:0:b0:382:4f9e:711f with SMTP id ffacd0b85a97d-38260b4724bmr2430553f8f.6.1732281873936;
        Fri, 22 Nov 2024 05:24:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCE9TFGe1n4ztl8iHUlvR8xpmc1ryrRjviOcMmAaQb/htLGXeJ9GvDb0fqPagSNmEFQIvIMA==
X-Received: by 2002:a5d:6d8f:0:b0:382:4f9e:711f with SMTP id ffacd0b85a97d-38260b4724bmr2430535f8f.6.1732281873571;
        Fri, 22 Nov 2024 05:24:33 -0800 (PST)
Received: from fedora ([147.235.219.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde8c8d3sm27215435e9.31.2024.11.22.05.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 05:24:33 -0800 (PST)
Date: Fri, 22 Nov 2024 15:24:31 +0200
From: Mohammad Heib <mheib@redhat.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	kashyap.desai@broadcom.com
Subject: Re: [PATCH rdma] RDMA/bnxt_re: cmds completions handler avoid
 accessing invalid memeory
Message-ID: <Z0CGDwp32NDOsweB@fedora>
References: <20241112134956.1415343-1-mheib@redhat.com>
 <20241114100413.GA499069@unreal>
 <CA+sbYW1cp17tH-p8ffjtgBecyMP_fECmes9RN9Bj=bdNPD_W2g@mail.gmail.com>
 <20241114114521.GF499069@unreal>
 <CA+sbYW13g5f-CW=QEt-SKtpssw1=Qbqp6d=055a=v5N-r2C9sA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sbYW13g5f-CW=QEt-SKtpssw1=Qbqp6d=055a=v5N-r2C9sA@mail.gmail.com>

On Sat, Nov 16, 2024 at 01:33:13PM +0530, Selvin Xavier wrote:
> On Thu, Nov 14, 2024 at 5:15 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Thu, Nov 14, 2024 at 03:37:30PM +0530, Selvin Xavier wrote:
> > > On Thu, Nov 14, 2024 at 3:34 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Tue, Nov 12, 2024 at 03:49:56PM +0200, Mohammad Heib wrote:
> > > > > If bnxt FW behaves unexpectedly because of FW bug or unexpected behavior it
> > > > > can send completions for old  cookies that have already been handled by the
> > > > > bnxt driver. If that old cookie was associated with an old calling context
> > > > > the driver will try to access that caller memory again because the driver
> > > > > never clean the is_waiter_alive flag after the caller successfully complete
> > > > > waiting, and this access will cause the following kernel panic:
> > > > >
> > > > > Call Trace:
> > > > >  <IRQ>
> > > > >  ? __die+0x20/0x70
> > > > >  ? page_fault_oops+0x75/0x170
> > > > >  ? exc_page_fault+0xaa/0x140
> > > > >  ? asm_exc_page_fault+0x22/0x30
> > > > >  ? bnxt_qplib_process_qp_event.isra.0+0x20c/0x3a0 [bnxt_re]
> > > > >  ? srso_return_thunk+0x5/0x5f
> > > > >  ? __wake_up_common+0x78/0xa0
> > > > >  ? srso_return_thunk+0x5/0x5f
> > > > >  bnxt_qplib_service_creq+0x18d/0x250 [bnxt_re]
> > > > >  tasklet_action_common+0xac/0x210
> > > > >  handle_softirqs+0xd3/0x2b0
> > > > >  __irq_exit_rcu+0x9b/0xc0
> > > > >  common_interrupt+0x7f/0xa0
> > > > >  </IRQ>
> > > > >  <TASK>
> > > > >
> > > > > To avoid the above unexpected behavior clear the is_waiter_alive flag
> > > > > every time the caller finishes waiting for a completion.
> Mohammad,
>  We were trying to see the possibility. FW shouldn't be giving an old
> cookie. One possibility
> could be if FW crashes and we are in the recovery routine.
> Adding this check is okay, but may be hiding some other error.
> Is it possible to share your test scripts to repro this problem? Also,
> can you share
> the vmcore-demsg also
> 
> Thanks
> Selvin
> 
I have sent you all the needed data in a separate email. 
Thanks, 
> 
> > > > >
> > > > > Fixes: 691eb7c6110f ("RDMA/bnxt_re: handle command completions after driver detect a timedout")
> > > > > Signed-off-by: Mohammad Heib <mheib@redhat.com>
> > > > > ---
> > > > >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 16 ++++++++--------
> > > > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > > >
> > > > Selvin?
> > > Someone is confirming the fix. Will ack in a day. Thanks
> >
> > Thanks



