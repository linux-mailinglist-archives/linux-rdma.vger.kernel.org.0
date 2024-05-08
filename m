Return-Path: <linux-rdma+bounces-2357-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A758C07A1
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 01:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9BB3B21773
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 23:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A6D131E41;
	Wed,  8 May 2024 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="IF/p+zAw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9230B4502D
	for <linux-rdma@vger.kernel.org>; Wed,  8 May 2024 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715210654; cv=none; b=Fk/a8JjUzS8uAt8FqRFom38DmLTfoA1XzqBLqvkwfj6oO6/5E2P5eyRfyO9cpVhz/aBGqHEs4BdoM29BsHaboSiCCwEk9Ou09PP1Xwq+anB5gZmMT/fY5UFhLeh6e3KCUpEhvfRlS16VInsw9Uu6s6AVol6lRbPCWjBTHsTPUgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715210654; c=relaxed/simple;
	bh=m/nCFqHe0a+bSNrZTvPd++SPHNeMCq8hpEDrrkoK4xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6TM9mkh8jNC5cC+StRk4f9D/4iW0dVEZFcWdC0fWWOSGArkAax/pQvflHcNeQwqR4U8JV9xw2dNXXkMQ44kJK6HCuH1Uxs5/HDzqkyiGXw+tWVHihRnZcKfx3f4VdgMAyVwTw8AuZ5WTd3JY7rrT1pxip78Yi4Lp+7Fr1GdL2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=IF/p+zAw; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a484f772e2so248561a91.3
        for <linux-rdma@vger.kernel.org>; Wed, 08 May 2024 16:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715210652; x=1715815452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u+AO/FgdbXB/WPpRvASJSNtkz6kd+Jn2U53cQAsPW9M=;
        b=IF/p+zAwHPkMRzw1HTFZX6gOBmC0zTnpqZe3u4v0ryFb19omSxjusTy+aS6ZNqhToM
         aYNp0oXxJdcOItHtqIO/pky28HtV7NOaNiAK1LTq5F2sjDxQ8Rbq9rZ2V7Hj6CDa/+zA
         b4ioCBQkS7GZ2CrdvKXX+AF+vHItG+uPj1qEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715210652; x=1715815452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+AO/FgdbXB/WPpRvASJSNtkz6kd+Jn2U53cQAsPW9M=;
        b=Z7LPPZ/RbyAQVfgeFCGI3mMVg9d01F2RpAhWCIckB/L5AUu/cwQ8wpYxJ9xx0V38PV
         MyMK68GYsQM8HclAwSVTuS9SHqV5utOFTcCMqaOg5yPc/NjqI3c8MMUOPsmFzSCQxKA7
         ixhjfL9xCwZ5tCrrYut7dtxdiV6eHmzu/sizS0I7OY3UCq6guXWRS9OsQQDoEUaJe3W5
         a6eBhQ/D8eGHwXqyMY+X/a+kSPqjonFysXBZdJoR63DDf0ngpd5ppT3q/1Ie8xXjbDSE
         vxwg2k+I1LJWlztKDN3os9MToJZy2ouxTPGCbxyOF0x006CREPkbVvl/DXEKUAXKOAbS
         Fc6w==
X-Forwarded-Encrypted: i=1; AJvYcCXczCy8k46880P2aHGkwpEA8L6Q0GaJE4nNcqhf6L2DVI1ryyfh0tMjtoq34i0fC/N5qwiNfuOAvvp03u0behnE+Od1/UaIBPLlxQ==
X-Gm-Message-State: AOJu0Yz7ZGziefLoAGIF6EXPDxpfy3scfKIZmSRl0WRY9H3j2RHxknFI
	TtkSsalfeKFmRYM5x87UyKEHNhdQlrhK7EbBlu5slH2VLQUUCDRdtB1yZQyO4so=
X-Google-Smtp-Source: AGHT+IH/X19jWdrcIa2RfuVEDUbUdZo5O//bofdSllbZHHS/yCmARd5qOQe8x9IzsnVULm5gwIrQxw==
X-Received: by 2002:a17:90a:1c8f:b0:2b2:a607:ea4a with SMTP id 98e67ed59e1d1-2b616be46bdmr3944849a91.44.1715210651863;
        Wed, 08 May 2024 16:24:11 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62863a1d4sm2024316a91.8.2024.05.08.16.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 16:24:11 -0700 (PDT)
Date: Wed, 8 May 2024 16:24:08 -0700
From: Joe Damato <jdamato@fastly.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	saeedm@nvidia.com, gal@nvidia.com, nalramli@fastly.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
Message-ID: <ZjwJmKa6orPm9NHF@LQ3V64L9R2>
References: <20240503022549.49852-1-jdamato@fastly.com>
 <c3f4f1a4-303d-4d57-ae83-ed52e5a08f69@linux.dev>
 <ZjUwT_1SA9tF952c@LQ3V64L9R2>
 <20240503145808.4872fbb2@kernel.org>
 <ZjV5BG8JFGRBoKaz@LQ3V64L9R2>
 <20240503173429.10402325@kernel.org>
 <ZjkbpLRyZ9h0U01_@LQ3V64L9R2>
 <8678e62c-f33b-469c-ac6c-68a060273754@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8678e62c-f33b-469c-ac6c-68a060273754@gmail.com>

On Thu, May 09, 2024 at 12:40:01AM +0300, Tariq Toukan wrote:
> 
> 
> On 06/05/2024 21:04, Joe Damato wrote:
> > On Fri, May 03, 2024 at 05:34:29PM -0700, Jakub Kicinski wrote:
> > > On Fri, 3 May 2024 16:53:40 -0700 Joe Damato wrote:
> > > > > diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> > > > > index c7ac4539eafc..f5d9f3ad5b66 100644
> > > > > --- a/include/net/netdev_queues.h
> > > > > +++ b/include/net/netdev_queues.h
> > > > > @@ -59,6 +59,8 @@ struct netdev_queue_stats_tx {
> > > > >    * statistics will not generally add up to the total number of events for
> > > > >    * the device. The @get_base_stats callback allows filling in the delta
> > > > >    * between events for currently live queues and overall device history.
> > > > > + * @get_base_stats can also be used to report any miscellaneous packets
> > > > > + * transferred outside of the main set of queues used by the networking stack.
> > > > >    * When the statistics for the entire device are queried, first @get_base_stats
> > > > >    * is issued to collect the delta, and then a series of per-queue callbacks.
> > > > >    * Only statistics which are set in @get_base_stats will be reported
> > > > > 
> > > > > 
> > > > > SG?
> > > > 
> > > > I think that sounds good and makes sense, yea. By that definition, then I
> > > > should leave the PTP stats as shown above. If you agree, I'll add that
> > > > to the v2.
> > > 
> > > Yup, agreed.
> > > 
> > > > I feel like I should probably wait before sending a v2 with PTP included in
> > > > get_base_stats to see if the Mellanox folks have any hints about why rtnl
> > > > != queue stats on mlx5?
> > > > 
> > > > What do you think?
> > > 
> > > Very odd, the code doesn't appear to be doing any magic :S Did you try
> > > to print what the delta in values is? Does bringing the interface up and
> > > down affect the size of it?
> > 
> > I booted the kernel which includes PTP stats in the base stats as you've
> > suggested (as shown in the diff in this thread) and I've brought the
> > interface down and back up:
> > 
> > $ sudo ip link set dev eth0 down
> > $ sudo ip link set dev eth0 up
> > 
> > Re ran the test script, which includes some mild debugging print out I
> > added to show the delta for rx-packets (but I think all stats are off):
> > 
> >    # Exception| Exception: Qstats are lower, fetched later
> > 
> > key: rx-packets rstat: 1192281902 qstat: 1186755777
> > key: rx-packets rstat: 1192281902 qstat: 1186755781
> > 
> > So qstat is lower by (1192281902 - 1186755781) = 5,526,121
> > 
> > Not really sure why, but I'll take another look at the code this morning to
> > see if I can figure out what's going on.
> > 
> > I'm clearly doing something wrong or misunderstanding something about the
> > accounting that will seem extremely obvious in retrospect.
> 
> Hi Joe,
> 
> Thanks for your patch.
> Apologies for the late response. I was on PTO for some time.

No worries, I hope you enjoyed your PTO. I appreciate your response, time,
and energy.

> From first look the patch looks okay. The overall approach seems correct.

Sounds good to me!
 
> The off-channels queues (like PTP) do not exist in default. So they are out
> of the game unless you explicitly enables them.

I did not enable them, but if you saw the thread, it sounds like Jakub's
preference is that in the v2 I include the PTP stats in get_base_stats.

Are you OK with that?
Are there other queue stats I should include as well?

> A possible reason for this difference is the queues included in the sum.
> Our stats are persistent across configuration changes, so they doesn't reset
> when number of channels changes for example.
> 
> We keep stats entries for al ring indices that ever existed. Our driver
> loops and sums up the stats for all of them, while the stack loops only up
> to the current netdev->real_num_rx_queues.
> 
> Can this explain the diff here?

Yes, that was it. Sorry I didn't realize this case. My lab machine runs a
script to adjust the queue count shortly after booting.

I disabled that and re-ran:

  NETIF=eth0 tools/testing/selftests/drivers/net/stats.py

and all tests pass.

