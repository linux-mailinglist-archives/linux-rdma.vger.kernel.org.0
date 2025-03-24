Return-Path: <linux-rdma+bounces-8924-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FB9A6E43B
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 21:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DBDB1893CC2
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 20:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C54F1DB548;
	Mon, 24 Mar 2025 20:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="gdMjH774"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBC51DB13E
	for <linux-rdma@vger.kernel.org>; Mon, 24 Mar 2025 20:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742847747; cv=none; b=Y9kCARejpTxEEjA7LqM67nW5nIuVuXgldHaDbAOLuOY07estHTMts5mAviPfUHNBkZxesFbIyAvTsF+ZBBLj/hJo5LUteWAbHvPU5ipBOjrtmZzmVi73QcBjympVTdLRZhyPbwlMEuB9TRTdR6pavbsPsBpCNiayTLMMydCyof0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742847747; c=relaxed/simple;
	bh=3RR1O3uUwyHLDS/Xwp5C4DZHeykQuZTNOZ+9Xqxk888=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7dCIMzXu1wOx2qVx0EBgex6EXGMz2s0f6it4JSISfYr0dT/vhg7R2nQ0JI6v11OhfwDgipOx/JQ3o/oDHOxJNMTRjCpf4uzGNqdbdwbE1At/jdsGpPM17YK2GRPmd5H1S4IEf6tWkEfzydZ8rrLlHy7sM/tUkZORb5D36E6agk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=gdMjH774; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2260c91576aso82042455ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 24 Mar 2025 13:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1742847745; x=1743452545; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nFsxp/63iCUPOqWDu6A9el5he2EWYciacAN2mVUJ8jM=;
        b=gdMjH774clX5npPNlthSwRcNPQi2vVgbiCeqFa4VN1ib96/7gKn0lgZon9bf6SSZ/0
         EqKcL3GGGlmDnm9/Ivn5cnexyhxXAtIyTmmMWib5VpeEAEdVopWPlPAMxPl+uX2nsV/E
         CvSPbbh1CiPmB8PuClyT2Q+g7oBOSmeCII4vu+Veq0jD+EDcGv/OPJB1SKDZMo7NHjA+
         DXxC7MRcmgB7p3aGjZUxEizct0WkZh7o6p8mgEm9nE3LPDJeSDk01Qtb8BEzEJzZj3os
         N0peMyV/OHekXSvwooZKU3Zwi+cr0VzyI2pBhZXoYuekdjL07WjeLVzDTciJqmJtA6xh
         lTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742847745; x=1743452545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFsxp/63iCUPOqWDu6A9el5he2EWYciacAN2mVUJ8jM=;
        b=YkZCti39z+heNM0VVAGOUbkEKBPx15z0gHRo6WGoNZDex5pO8FyEtBKPPqLZhDB/wL
         ESi+y4ebFDBDL9lMu90NqWx7NHo/q3lhalxuvQxKuTQHWoeVtZkcoqJrRgh2MTFH7JsZ
         R8lRxjPWEpvbbKhVXzXsSjoAj+8mjrufOnrlXHCchedznB8clpccED8QPY2lX/F//Reb
         5MEl2fiYtM+5v2gLf6E2oTNXmuqlXsUhm7XjB5I5WFylpEKuQ83XWJyAmaid42GeKLXl
         ZADIgmnlUfHNtn54ud9T8lt3ogzHsxggq6ZlgZZMvlxG5368ovpuv0YEIWOygEcSBBYR
         kwRA==
X-Forwarded-Encrypted: i=1; AJvYcCWUbIkPl3lNYM1H46m1+4Auc4wxh1PMkM7QhAncJt2ZoYn948aFfQTGbDwFG8gFfmGT/Ny7accOckzG@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq+cnbNUHw2BvulLj+vXu+MN1Zc1M3mfhA0Hhx1vrfhHBd5dfs
	sDk93ir84wRIQOmCYAVYzyHkh/L0cWXl34EJ0tztUfEllmpPgkrioAiW4+9UM6mEnRYC0G/4QnI
	fce9an9Xpt7KCtF8tvykbSSh1f9HtKqodFjyPWQ==
X-Gm-Gg: ASbGncvuUUD93V6ski4AhiOkAttLnD6zdTAjp79fElKaBoS8bLpmDDWb/56Zdqj1oJY
	ZMiklWvYa9jwcNXbNIDe59dXG6j4gOn/mXI+yF0YnQN2Fr1LyiLx78AC6bqGaEAwClKHDGoudsk
	inNH85dvXnKoxw/76T+TaRk4SGNA==
X-Google-Smtp-Source: AGHT+IF1JOwCv1HaIFDtvO06w4XVZYmHFe3lxzlkwOzdDc0rbg7YI/broUnzEJIMCBzMgYr+4vmuMeylvcUVfz9Iqs4=
X-Received: by 2002:a17:903:22c4:b0:223:f9a4:3fa8 with SMTP id
 d9443c01a7336-22780c7d8b4mr216170885ad.19.1742847745223; Mon, 24 Mar 2025
 13:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306230203.1550314-1-nikolay@enfabrica.net> <20250319164802.GA116657@nvidia.com>
In-Reply-To: <20250319164802.GA116657@nvidia.com>
From: Roland Dreier <roland@enfabrica.net>
Date: Mon, 24 Mar 2025 13:22:13 -0700
X-Gm-Features: AQ5f1JoBu9VUTrd7Dl1ppOeRVs6Mkzrwf4SdIwj1dYyeU4Ssu5JmPf4LNMUsUs0
Message-ID: <CALgUMKhB7nZkU0RtJJRtcHFm2YVmahUPCQv2XpTwZw=PaaiNHg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nikolay Aleksandrov <nikolay@enfabrica.net>, netdev@vger.kernel.org, shrijeet@enfabrica.net, 
	alex.badea@keysight.com, eric.davis@broadcom.com, rip.sohan@amd.com, 
	dsahern@kernel.org, bmt@zurich.ibm.com, winston.liu@keysight.com, 
	dan.mihailescu@keysight.com, kheib@redhat.com, parth.v.parikh@keysight.com, 
	davem@redhat.com, ian.ziemba@hpe.com, andrew.tauferner@cornelisnetworks.com, 
	welch@hpe.com, rakhahari.bhunia@keysight.com, kingshuk.mandal@keysight.com, 
	linux-rdma@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi Jason,

I think we were not clear on the overall discussion and so we are much
closer to agreement than you might think, see below.

 > I was away while this discussion happened so I've gone through and
 > read the threads, looked at the patches and I don't think I've changed
 > my view since I talked to Enfabrica privately on this topic almost a
 > year ago.

First, want to clarify that this patchset is collaborative development
within the overall Ultra Ethernet Consortium. That's not to take away
from the large effort that Nik from Enfabrica put into this but simply
to give a little more context.

 > I do not agree with creating a new subsystem (or whatever you are
 > calling drivers/ultraeth) for a single RDMA protocol and see nothing
 > new here to change my mind. I would likely NAK the direction I see in
 > this RFC, as I have other past attempts to build RDMA HW interfaces
 > outside of the RDMA subystem.

UEC is definitely not trying to create anything new beyond adding
support for Ultra Ethernet. By far the bulk of this patchset is adding
a software model of the specific Ultra Ethernet transport's protocol /
packet handling, and that code is currently in drivers/ultraeth. I
don't feel that pathnames are particularly important, and we could
move the code to something like drivers/infiniband/ultraeth, but that
seems a bit silly. But certainly we are open to suggestions.

 >    So, this RFC is woefully incomplete. I think you greatly underestimate
 >    how much work you are looking at to duplicate and re-invent the
 >    existing RDMA infrastructure. Frankly I'm not even sure why you
 >    sent this RFC when it doesn't show enough to even evaluate..

Total agreement that this RFC is incomplete! We are trying to get
something out early, exactly to get the discussion started and agree
on the best way to add kernel support for UE.

To be clear - we are not trying to reinvent or bypass uverbs, and
there is complete agreement within UEC that we should reuse the uverbs
infrastructure so that we get the advantages of solid, mature
mechanisms for memory pinning, resource tracking / cleanup ordering,
etc.

With that said, Ultra Ethernet devices likely will not have interfaces
that map well onto QPs, MRs, etc. so we will be sending patches to
drivers/infiniband/uverbs* that generalize things to allow "struct
ib_device" objects that do not implement "required verbs."

 >    Ie you said:
 >
 >     > I should've been more specific - it is not an issue for UEC and the way
 >     > our driver's netlink API is designed. We fully understand the pros and
 >     > cons of our approach.
 >
 >    Which is exactly the kind of narrow thinking that creates long term
 >    trouble in uAPI design. Do your choices actually work for *ALL*
 >    future HW designs and others drivers not just "our drivers
 >    netlink"? I think not.
 >
 >    Given UE spec doesn't even have something pretending to be a
 >    kernel/user interface standard I think we will see an extreme
 >    variety of HW implementations here.

I think the netlink API and job handling overall is the area where the
most discussion is probably required. UE is somewhat novel in
elevating the concept of a "job" to a standard object with specific
properties that determine the values in packet headers. But I'm open
to making "job" a top-level RDMA object... I guess the idea would be
to define an interface for creating a new type of "job FD" with a
standard ABI for setting properties?

 - Roland

