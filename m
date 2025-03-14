Return-Path: <linux-rdma+bounces-8712-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BF8A61D37
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 21:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF0219C6692
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 20:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BF01A83E7;
	Fri, 14 Mar 2025 20:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU7XlhFO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9FF1957E4;
	Fri, 14 Mar 2025 20:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741985496; cv=none; b=SFybvlOQNcdipz3pi9WhHtAa1W9r4WTCcJzZ0ZSeloIPKCJGN3vZwByrBjp2rvu1lInKkHiQybANUYmqwozJ9DJSeHO/VtffFwJcagi0LmiNQMwKM9ksoJqEc7YxUUPlhrtKqC9X5aKiO7FQQWQ/VRyd3SWhzQNmH2hA07H97M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741985496; c=relaxed/simple;
	bh=7wPDF8XCRPKCwzKn3ad2J2Qifrdj0bdFCB05gJBKiSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGcxx6F1gNETcrF7jtxrYcJj+iftwyAgvTrtmZDT+Pf09mcRgxCcWPDgGRkKDT00vqGmdtvIoOIq2BApN1aakPr9TjMkB0j3WwH/YHhrVFGRP+DMkfAxJ5yD/hxVTDopetAN8ISEtoYNxejwhCErBZKHz6pz4laXBbCKK/x+/0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PU7XlhFO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-225a28a511eso45400175ad.1;
        Fri, 14 Mar 2025 13:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741985494; x=1742590294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CEhhILD5jrVFtwvEuGt4w/B9mS86890kR7Mo9D2Y2+4=;
        b=PU7XlhFO626bY2H12t49Z8+tBGSN2Wp+JXG0ff/PIwnG0OG7XT9p8VwaobgR1EGSzr
         pb0do0a5bGbitmUCbNsIDbJqORnTEznI2kpVTi7fUY/cWbF6xyi1MYpxNRuBD9zbo0l4
         6HYg/tw6bZ7lVmPWoAL0MxoYTSMb9/tMeYlvLKSaF9KLhkLk/dLEDQ3TEFG/SXcplI7C
         laSEatY9UsKUs4S1Y7RbuXFbU8BIbls0PXb9seEjc25hCIldy1DSpbuvpyRF40euH1Lj
         Oh7kywlLWCDNkvXZgwhHNrhTuHKJ/jAhEFYmdwZbPxR0Owe4FqJJQc7Vf2BK6klKcrIk
         B03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741985494; x=1742590294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEhhILD5jrVFtwvEuGt4w/B9mS86890kR7Mo9D2Y2+4=;
        b=SwlhIUtYg7jh5XVR80PtGmJrQpmhh8b69meECYDfJE74HWIwaRQyD1/V2BomU1xsPQ
         JScaas2Cylrj5dba32W75fpfOUl6nyFngqICukyrjriI9i0/n59/eLnNPmUlzERG3z5D
         I/hB7NNPczTeNy98e64wUxgMD0loasJXkb7qaBcHfl/rvrarKo5Txc0ZQiixMIfGEyb5
         UYirExL2W63jkLbCiittDfSk1C56neX515vUmnkIhoZU9wp6fhLU6vi1Ltc0q1VZTtzM
         o0eMVYyDt+/OBHeBcI66xixIbVw4Ff0CI6HnT3y6NhSqBIHlmZqLPB8ZXyzFtYivn7de
         O56A==
X-Forwarded-Encrypted: i=1; AJvYcCUAUpbOOhQpyofqU13OEifwHyjQJJJ69wQkNc1H85yO0utnjIEwaM6kg6Hf2suy6FAfDWhi/4qjIu5T@vger.kernel.org, AJvYcCVLADS6Fe+mBro6c/an4B3gOQLySlyXUboUnFhb2bRa2npkK+lhaSSpfvzS4re5b+lCadhSOQ1z@vger.kernel.org
X-Gm-Message-State: AOJu0YzeDT4lf20/eYed3N5/jxBSETBmXMRLdvYB7GOHh3q8bDifN9hm
	E0lq+OaU7BYebkvzbATAgsku/jm1kSAvFgM7U/5j7KkBZAX/Y4U=
X-Gm-Gg: ASbGncspFDx/TSBg1+f8fu79uIGrDn/MUHIjfdlJxBON0hdZ+DP6JgeDXHzYKybPWaw
	+svgt0kvgXnlzt1+rUTRl91yp7M08HCJTtZkIVpeZyqu59lE40zXasaOn+QzNMosRHInvP5jpM0
	fJ4dFbmBNgnr9GUgpnVnrXxndg+oJIL0EEonsDfH5ryiSG5aVVMkXiGJfA+NbPBwwmIRrPsb+ww
	gC1EjBvCZY0S+cIOIhqyHwFTD3L45q7fAIed+cWtgtyL+9ZzZYwCp0SNr/IWCma6qPoDWgvqUN1
	A7eDVXBHacsJRNQzXh/+ZT6re3rJCEkuiNLBsK2s4S+Kwa/WiJqKLN0=
X-Google-Smtp-Source: AGHT+IFptobMNqPoLFV4CVihpFzJzFveJX3Ywe7j3bxMcE7rijzwvKEXMDvIdtB8uz0qV0pWXT++Ng==
X-Received: by 2002:a17:902:c941:b0:224:2717:7992 with SMTP id d9443c01a7336-225e0afa06dmr38783705ad.33.1741985494459;
        Fri, 14 Mar 2025 13:51:34 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-301539d3f17sm1467159a91.10.2025.03.14.13.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 13:51:33 -0700 (PDT)
Date: Fri, 14 Mar 2025 13:51:33 -0700
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
Message-ID: <Z9SW1WI6EKtA_2KL@mini-arch>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal>
 <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>
 <20250312112921.GA1322339@unreal>
 <86af1a4b-e988-4402-aed2-60609c319dc1@enfabrica.net>
 <20250312151037.GE1322339@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312151037.GE1322339@unreal>

On 03/12, Leon Romanovsky wrote:
> On Wed, Mar 12, 2025 at 04:20:08PM +0200, Nikolay Aleksandrov wrote:
> > On 3/12/25 1:29 PM, Leon Romanovsky wrote:
> > > On Wed, Mar 12, 2025 at 11:40:05AM +0200, Nikolay Aleksandrov wrote:
> > >> On 3/8/25 8:46 PM, Leon Romanovsky wrote:
> > >>> On Fri, Mar 07, 2025 at 01:01:50AM +0200, Nikolay Aleksandrov wrote:
> > [snip]
> > >> Also we have the ephemeral PDC connections>> that come and go as
> > needed. There more such objects coming with more
> > >> state, configuration and lifecycle management. That is why we added a
> > >> separate netlink family to cleanly manage them without trying to fit
> > >> a square peg in a round hole so to speak.
> > > 
> > > Yeah, I saw that you are planning to use netlink to manage objects,
> > > which is very questionable. It is slow, unreliable, requires sockets,
> > > needs more parsing logic e.t.c
> > > 
> > > To avoid all this overhead, RDMA uses netlink-like ioctl calls, which
> > > fits better for object configurations.
> > > 
> > > Thanks
> > 
> > We'd definitely like to keep using netlink for control path object
> > management. Also please note we're talking about genetlink family. It is
> > fast and reliable enough for us, very easily extensible,
> > has a nice precise object definition with policies to enforce various
> > limitations, has extensive tooling (e.g. ynl), communication can be
> > monitored in realtime for debugging (e.g. nlmon), has a nice human
> > readable error reporting, gives the ability to easily dump large object
> > groups with filters applied, YAML family definitions and so on.
> > Having sockets or parsing are not issues.
> 
> Of course it is issue as netlink relies on Netlink sockets, which means
> that you constantly move your configuration data instead of doing
> standard to whole linux kernel pattern of allocating configuration
> structs in user-space and just providing pointer to that through ioctl
> call.

And you still call copy_from_user on that user-space pointer. So how
is it an improvement over netlink? netlink is just a flexible tlv,
if you don't like read/write calls, we can add netlink_ioctl with
a pointer to netlink message...

