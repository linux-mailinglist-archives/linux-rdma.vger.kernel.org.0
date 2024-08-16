Return-Path: <linux-rdma+bounces-4391-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF369547A0
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 13:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472B7281FF4
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 11:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7A31990BD;
	Fri, 16 Aug 2024 11:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bzSJIscm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1D9197A95
	for <linux-rdma@vger.kernel.org>; Fri, 16 Aug 2024 11:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806749; cv=none; b=u68Smv2GC3JBJUn+TerXu2m9pNofxloeecIexaj7f/DcJHfiquSGQJRzp337B64ZZb1NnoEWkuaoATgv+netpH5rmg5DGkZGmTuFlh/5TbhOoH3qQ6cXF5t5So6oSbnoJJxn9YXV032C+tnTvH8hRlvDQDeN5ltXvlnUdligBdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806749; c=relaxed/simple;
	bh=ev8gItlxT8GfFSSM6MbqNb6Y6y6p896g9CJuhyNyxNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kY+X5wRTWnAMWj+b34bQHRSaCqcACTqPoWWQ2RmBGXoNnJbRJ8sEQDLk94EVbIJy1Ix+C2IDVdK2QHrGteAIF3S7rB/hqv2+he3ob9zHlPJOpKh6MAv3rQNalEJw8LNNx9esYvCyDApzoHB/yGFupexiWvZOVnXwLmtDV0e7moA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bzSJIscm; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135eso2933605a12.0
        for <linux-rdma@vger.kernel.org>; Fri, 16 Aug 2024 04:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723806746; x=1724411546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vu6p4NVjd5a5X5kDuNbFrcpGswZu1Bkp/8WsnSo57I8=;
        b=bzSJIscmpaP6twqCKbKIVaLhtDGmWGORz1qMPcmN5aTxNMK/+WnyN0H8KT4FHNl39w
         Djfj+iuDFg8stp10RdVW7yBVPOTfPH8ul+oC2Z14M9dIGCLZ2goGN8eg7FrWWHRmlSl9
         JgsThPqSDnUm0xVo/MHBW32m50ae1Lktx5EeY2Rxsgdb4scdB70lBoIbSZCk7Gzim69J
         nROz4+QTXGmMUYwUK4a/bfslCg54gY5+1ozPZcKI5PIF6hyI9DRKFhjXE36Y0y7aOMof
         WoJi+NHX4gK03893leh6Y7uGgvJdRQaW22C3ERC8N9t8iOCz70I/uFVIEZidcKjapzRk
         e/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723806746; x=1724411546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vu6p4NVjd5a5X5kDuNbFrcpGswZu1Bkp/8WsnSo57I8=;
        b=kJPMNMIGm475rXD8v9P42QQe76UrpJXF5+sYtyChunUdSMU7ox+rNI+AQmC3LyNc61
         1V/QE4+KNdNWcVazddgb1H7oB5VSCka8IXZP+Jy89ar3jPekNyAU+oBtv0DA20a88aMB
         3HWtPvjyfJSHXI8n3veYMNeXj/tLnBzO2OszvfmT013rYBor8DPeH0nYxSrCjAKsuMr/
         wZjgP93BfRzEWNmsYds6Bgonup0e/l/ygH3e8t3Acle7yfqd+W/wSFvrY+1YgQ8ireGo
         qITPqoMWq2ONkNQcoyuKb28CEGajNtzYZUY3P/xyp2K1IQQv2cWPPMN4VO4FaJTqu4cr
         9B/w==
X-Forwarded-Encrypted: i=1; AJvYcCXS3VQ/42bhm4foBxGvaqBZe03WixRr1iSGc1F0aRap/0bVAvBk9yPWSmLVO5/kM7zQRTdx/bxWtefpOQgNaOyThMu4fxhv6USJhA==
X-Gm-Message-State: AOJu0YzFxi53I939twFslJbRlRIx0F+k/ItOyBK6TDximBPvUeK962Xe
	pIfGabl3Ic8dgveVGrYKZnMEhPdCcoD0ZXlGgoTUmIEczEMSGhDeGQEy70i7cAo=
X-Google-Smtp-Source: AGHT+IHrZPj0GDl8aLs3V6+bDceZfINTrVKI0dshA6qcSm27LFmTvVpr+cYRN/sN4aTRDpPHirLLag==
X-Received: by 2002:a05:6402:520d:b0:57d:455:d395 with SMTP id 4fb4d7f45d1cf-5beb3a84f4cmr5719044a12.7.1723806745762;
        Fri, 16 Aug 2024 04:12:25 -0700 (PDT)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? (megane.afterburst.com. [2a01:4a0:11::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde7cd4sm2111869a12.39.2024.08.16.04.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 04:12:25 -0700 (PDT)
Message-ID: <2fd48f87-2521-4c34-8589-dbb7e91bb1c8@suse.com>
Date: Fri, 16 Aug 2024 13:12:24 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
To: Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe
 <jgg@nvidia.com>, James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <20240726142731.GG28621@pendragon.ideasonboard.com>
 <66a43c48cb6cc_200582942d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240728111826.GA30973@pendragon.ideasonboard.com>
 <2024072802-amendable-unwatched-e656@gregkh>
 <2b4f6ef3fc8e9babf3398ed4a301c2e4964b9e4a.camel@HansenPartnership.com>
 <2024072909-stopwatch-quartet-b65c@gregkh>
 <206bf94bb2eb7ca701ffff0d9d45e27a8b8caed3.camel@HansenPartnership.com>
 <20240801144149.GO3371438@nvidia.com>
 <66b2ba7150128_c1448294fe@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <66b2ba7150128_c1448294fe@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/24 02:06, Dan Williams wrote:
> Jason Gunthorpe wrote:
>> On Wed, Jul 31, 2024 at 08:33:36AM -0400, James Bottomley wrote:
>>
>>> For the specific issue of discussing fwctl, the Plumbers session would
>>> be better because it can likely gather all interested parties.
>>
>> Keep in mind fwctl is already at the end of a long journey of
>> conference discussions and talks spanning 3 years back now. It now
>> represents the generalized consensus between multiple driver
>> maintainers for at least one side of the debate.
>>
>> There was also a fwctl presentation at netdev conf a few weeks ago.
>>
>> In as far as the cross-subsystem NAK, I don't expect more discussion
>> to result in any change to people's opinions. RDMA side will continue
>> to want access to the shared device FW, and netdev side will continue
>> to want to deny access to the shared device FW.
> 
> As I mentioned before, this is what I hoped to mediate. The on-list
> discussion has seem to hit a deficit of trust roadblock, not a deficit
> of technical merit.
> 
> All I can say is the discussion is worth a try. With respect to a
> precedent for a stalemate moving forward, I point to the MGLRU example.
> That proposal had all of the technical merit on the list, but was not
> making any clear progress to being merged. It was interesting to watch
> that all thaw in real time at LSF/MM (2022) where in person
> collaboration yielded strategy concessions, and mutual understanding
> that email was never going to produce.
> 
Well, my experience does not _quite_ match this, but I fully support
the attempt to resolve it.

FWIW, we (ie 'me' with my SUSE distro hat on) are facing similar issues;
every now and again vendors come along asking us to take this very 
important out-of-tree module to allow them to configure their device.
The SCSI stack is _littered_ with vendor-specific commands allowing them 
to reprogram their devices (had a fun experiment once reflashing a 
megaraid HBA to suddenly show up as mpt2sas ... try to code that in 
command effects ...)

So yes, I'd be in favour having an interface for this kind of stuff.
Less sure if there is a generic interface to be found; what we should
try to avoid is having an too generic one (aka: send command with this 
payload, get this result, and heaven knows what it did to the device).
That would surely be useful, but security and operational aspects of
that are a nightmare.

I'd be happy to participate on the discussion at LPC if and when it happens.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


