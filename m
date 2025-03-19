Return-Path: <linux-rdma+bounces-8840-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2233A698C0
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 20:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1615189CD5F
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 19:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FB7211715;
	Wed, 19 Mar 2025 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCu0vqZg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5A51DF987;
	Wed, 19 Mar 2025 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411540; cv=none; b=CZPXITwZZdUOEdgwXvGAiUlXDV1lqgwk+x6MxHc/RwGS0ZCoPodV8mGAlhFKu1hTVhrD3YnNl7cWwVumA+ixV6BzmrnQN2jayq26v+ZLnqd8VlVxfsZkrK9m8eJn7WcmNzM/sNRH58bPPZnTZAMa2uizmSaUZVSZOqEp61EKnb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411540; c=relaxed/simple;
	bh=7n00JSWH6XaJTPSCJbAv8jEhtAOiCIEOtd3HmP2bb8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FniFLcCjArrIWdxJ7yydMI80AtY+gzFBG764pUoZ2E8FYwO4eTUm193kkRZHltjLJGzFyFbVkfZhVd0NcxWHrc7wCDeEL7SmYxB8Fj08Ff5UOIS+0V8TSmW/7sTUPPiDug7XhbgAOylMyTaWLeSlwY0gNpzUpT+XJ7PR5XVqjKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCu0vqZg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2255003f4c6so134441035ad.0;
        Wed, 19 Mar 2025 12:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742411538; x=1743016338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LKrgSmm4BejccnDyOMdC57n4QZe8vv+A8bIPNXgyZFc=;
        b=UCu0vqZgYCLO+S1+AiOMQ7O4udP0pMXfhKzeLUSexFvygGq6iyH8/EISguDBuJ3vtW
         53hBBD2LqKPOOH6K//jkJLkXjLF2063iZa8B/KnsknpZTU5w99SUehpsFWqH/knjso6f
         e2XvJKQnd41uBSqoLtoxecZXsWJNBDYAxQNKxyl018iDsLoUyBT6a2Tk9x8F3rZDpcD7
         kkD7eWqxjGgyjP4GHFPfGvtIxtxjwsYf1wqwzH2afCX0vQMOHtjc+E7qRkdO2wlII1v6
         oRfeKh0ScLxSrqiQyfmrkc2J05/ceXZqtFcDiZtLMD7sw6LOWgumSc96kfFJzfHcDgEl
         8I1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742411538; x=1743016338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKrgSmm4BejccnDyOMdC57n4QZe8vv+A8bIPNXgyZFc=;
        b=OfIkWuxrFyqdv87IHoIOv7RJaaqKU0ro6wLIu2KQpc/rHf5PfxaM3LtSSM5A4iBUqf
         +RLE1gdycEGQVsIxWZGnE9OM5QyFnvhNK67kua7lfNJ2EoEw/b5ANNcqLQMcCWJerrvB
         IT4ybwpA2T8C8k/I5OTskZn4mY7vg3b7Smddkm4/6iNUQWQwHJqx4gp3KeREAN2A1ihh
         uMdf4YVyNLXdvUzDRQXJq20y3grKET1mR+X/u3H1gHND6Icf3xkoO4QXPw81wUsyu1CL
         YyA+YkSbIMDpJZWsJlbVvHxk8dpn9sEy/BsIf9HjfASW099rQeaRAQ28bd/Nauz1Wcaf
         NXgg==
X-Forwarded-Encrypted: i=1; AJvYcCVEr9xCEwZx6jRJ2m/4Rq1PP0FeqdVRzDhf4THoD0UG90wzy7cNeZG3ffuAYwPc7cqQLAcc9sQsUlGn@vger.kernel.org, AJvYcCVQyfHAqxoO6kRGAsOE2bkxEu+YRvRwFu3ihEuCpi6k7176CFrij0iMKPvUOXhvICJicVHVqa2s@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/FCP3DYtuiGNCJGrCISiqyv2W8ZCrslXlxaO1EUixrIpkdoJ8
	AJ9xAK4XHzS6xXI5yV1O+N0l449F3rDpEhVFJHHudqublsoDo7U=
X-Gm-Gg: ASbGncusIdg901CCyfgjlty4TYR+/8VeeEqWvPvDRWaMp48ngNRaKSYNsPfE7uf0iBm
	nCNmM9aJSvf6A2Q14XeGuLSd+5iL6tKnb9cvi0R48d4BN+goSLg4jTAV8+wsGHKpgOel2IWrkG7
	0qzHVsg648mCgUhl2+dfvKqiBy8foalWYnxXxhQHWRwQptJmB9rM+8bsuoPZPtuDKOaV8ufCXT1
	nSC/esTNTbr2OPMRneBT1SEUySrUgYyatvZ8u0U/mH5vLq4NF/N6vUFAd3tLkdNB9UKFQ7J67Q+
	JE/LtujirB8QgVDEA4Pg1+s8TRfSR1e3a+xZbL+OcpRtve4HqVxyQ14=
X-Google-Smtp-Source: AGHT+IG9XG/y3zvmmBs3d/0GcYyqyra3o6NyX+cxELEplG1TxnkxOdYQM8f+ZV6BAaU1du3VwsS6SQ==
X-Received: by 2002:a05:6a20:a126:b0:1f5:77bd:ecbc with SMTP id adf61e73a8af0-1fbeb9991e4mr5921026637.16.1742411538633;
        Wed, 19 Mar 2025 12:12:18 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-737115295f0sm12434084b3a.18.2025.03.19.12.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:12:18 -0700 (PDT)
Date: Wed, 19 Mar 2025 12:12:17 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Nikolay Aleksandrov <nikolay@enfabrica.net>, netdev@vger.kernel.org,
	shrijeet@enfabrica.net, alex.badea@keysight.com,
	eric.davis@broadcom.com, rip.sohan@amd.com, dsahern@kernel.org,
	bmt@zurich.ibm.com, roland@enfabrica.net, winston.liu@keysight.com,
	dan.mihailescu@keysight.com, kheib@redhat.com,
	parth.v.parikh@keysight.com, davem@redhat.com, ian.ziemba@hpe.com,
	andrew.tauferner@cornelisnetworks.com, welch@hpe.com,
	rakhahari.bhunia@keysight.com, kingshuk.mandal@keysight.com,
	linux-rdma@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Message-ID: <Z9sXEXeE1iM5tMcy@mini-arch>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal>
 <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>
 <20250312112921.GA1322339@unreal>
 <86af1a4b-e988-4402-aed2-60609c319dc1@enfabrica.net>
 <20250312151037.GE1322339@unreal>
 <Z9SW1WI6EKtA_2KL@mini-arch>
 <20250317123004.GU1322339@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250317123004.GU1322339@unreal>

On 03/17, Leon Romanovsky wrote:
> On Fri, Mar 14, 2025 at 01:51:33PM -0700, Stanislav Fomichev wrote:
> > On 03/12, Leon Romanovsky wrote:
> > > On Wed, Mar 12, 2025 at 04:20:08PM +0200, Nikolay Aleksandrov wrote:
> > > > On 3/12/25 1:29 PM, Leon Romanovsky wrote:
> > > > > On Wed, Mar 12, 2025 at 11:40:05AM +0200, Nikolay Aleksandrov wrote:
> > > > >> On 3/8/25 8:46 PM, Leon Romanovsky wrote:
> > > > >>> On Fri, Mar 07, 2025 at 01:01:50AM +0200, Nikolay Aleksandrov wrote:
> > > > [snip]
> > > > >> Also we have the ephemeral PDC connections>> that come and go as
> > > > needed. There more such objects coming with more
> > > > >> state, configuration and lifecycle management. That is why we added a
> > > > >> separate netlink family to cleanly manage them without trying to fit
> > > > >> a square peg in a round hole so to speak.
> > > > > 
> > > > > Yeah, I saw that you are planning to use netlink to manage objects,
> > > > > which is very questionable. It is slow, unreliable, requires sockets,
> > > > > needs more parsing logic e.t.c
> > > > > 
> > > > > To avoid all this overhead, RDMA uses netlink-like ioctl calls, which
> > > > > fits better for object configurations.
> > > > > 
> > > > > Thanks
> > > > 
> > > > We'd definitely like to keep using netlink for control path object
> > > > management. Also please note we're talking about genetlink family. It is
> > > > fast and reliable enough for us, very easily extensible,
> > > > has a nice precise object definition with policies to enforce various
> > > > limitations, has extensive tooling (e.g. ynl), communication can be
> > > > monitored in realtime for debugging (e.g. nlmon), has a nice human
> > > > readable error reporting, gives the ability to easily dump large object
> > > > groups with filters applied, YAML family definitions and so on.
> > > > Having sockets or parsing are not issues.
> > > 
> > > Of course it is issue as netlink relies on Netlink sockets, which means
> > > that you constantly move your configuration data instead of doing
> > > standard to whole linux kernel pattern of allocating configuration
> > > structs in user-space and just providing pointer to that through ioctl
> > > call.
> > 
> > And you still call copy_from_user on that user-space pointer. So how
> > is it an improvement over netlink? netlink is just a flexible tlv,
> > if you don't like read/write calls, we can add netlink_ioctl with
> > a pointer to netlink message...
> 
> You need to built that netlink message, which you do by multiple copying
> in the user space.
>
> I understand your desire to see netdev patterns everywhere and agree
> with the position that netlink is a perfect choice for dynamic configurations.
> However I hold a position that it is not good fit to configure strictly dependent
> hardware objects.
> 
> You already have TLB-based API in drivers/infiniband, there is no need
> to invent new one.

Let's revisit this discussion later depending on where ultra eth stuff
lands. If it gets folded into ibv subsystem - keeping the same ibv
conventions makes sense. If not, not sure I understand your "multiple copying
in the user space" argument.

