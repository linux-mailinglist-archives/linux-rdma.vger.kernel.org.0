Return-Path: <linux-rdma+bounces-8616-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A992BA5E151
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 17:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BB097A5E58
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 15:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD5213635C;
	Wed, 12 Mar 2025 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="FKwB1OJo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2A73D76
	for <linux-rdma@vger.kernel.org>; Wed, 12 Mar 2025 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795223; cv=none; b=cWabAh1JlW7Fs157/Ju4R6h9lufMd5MxGOZWfLNEE4srGYY89f7/6ipcY5oKMEtAKIcfXuD89HaHrnfWf9ImxZcCAr3bGeAJocE1UJoVs8PawfTyxUKVEj3NQbM1dQ/MO7YN7jHQxpE23H4JU7eLdou3vJGp7VDMz1Xl84V4UBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795223; c=relaxed/simple;
	bh=YuZCLLOe74+CbDXV6Qpl+EcrF4BAurI+0vwAQibPmIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPPe7pY5vmiTXCMMbFwGOYOQtc8H3iP+sKUIuXyo7amMa3P5m3rkyP/R4W8IwlLi+QkPzhTkJUgqQvhhBo2GhGlRTUusjr0NZqUJwcFFhDvDHvQmonu+P+n1Z+3xowbawf9A4LeenIJ2egV+VIXrFlTKxCJrlqOS+96cIiRVYWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=FKwB1OJo; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e86b92d3b0so269266d6.2
        for <linux-rdma@vger.kernel.org>; Wed, 12 Mar 2025 09:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1741795220; x=1742400020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vIYof9v88hwRZiv0dm3khNPjBDWTfg5Jw6z157GPEOU=;
        b=FKwB1OJoJTONumQtNL5+BzfcXGFqYffFxvO6YBTkcAQUa/RYjblvlBUzdb9YD+Uqez
         EJm+3MYa1Qz1WfUI6mbVWVW30FUH95PpYH+1kWaUooqDRE5G+flxbigCaGANAjCScOWm
         8WjDfDaWZXIsNWOf4Gob7WUnrS4RH45pnR09zkmqXyukuHi4B+tzY8cWlSeTEU5hGVWf
         9hzAv5SKN+ctvC7ny3cNemGY9cYJW/+SpcbP8IwBHUbelAXs+3XQVqWztTcy4j0Vb+0o
         WQVOogHJwAD33hQti3rL4mJbdz/npEvHyESsx4XUxKWCJs9TIJxqmSNLHmwEKkGa+jcF
         4r9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741795220; x=1742400020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vIYof9v88hwRZiv0dm3khNPjBDWTfg5Jw6z157GPEOU=;
        b=YYD4+JiVkIDIduCgfIcIV5CV0UxfJZl6zpakb5GJ30Fi5T70H0Ag/ZfWufMbSkRq1f
         tiPYPq17+Y/iXJ9cISnvvhsfHPa138YdeOyiWpgVpkN3xDqS/bselLI5aXidsnETyhg/
         JJ/DMiLznn3tTL2/FaufILS2/5ekDLp9eEiiMBklK1IcQHyV9jTRZt2C50OdGmS8bGlU
         2u+IRdxR+IF03eIjfPZuGnRSCTjEcf+ZOZuUsHFJ4JJETsvi41O1YosAjP2TelupJL/r
         hAvJWI9e9LFcnpAfg4yZCDS44hXUgNzNOSGlcbDtbNhVy2bnYk6kMPtm9ib43MFGCNpU
         ZnTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH7uuuIvzuymCakLZ2kdeTSeSJ+QEZ7WS/O44qp/gbvhoCMbdgCd0zakV30qIRSY/pmL4rg07B+V7d@vger.kernel.org
X-Gm-Message-State: AOJu0YxkZTs49jpqJIzWdVIVD7pQpTIiSgV8SFO9M4m1cwqn3Hegn4sF
	eOctDT/m34dLKF6jdiKnuR5WI5WD8W88Yu1jbd7UeffLN2vlvS/uNsSCL1KSy+Y=
X-Gm-Gg: ASbGncuvwWy/pDl6ipmdwHsJ6YcGDm9QosgCMZuj4yjsV0JUTchYj/Pe6LTBMW1lt3X
	GaqPxJut2SN+X3/FULXLPRDdOVbGlSVNxecxEPLLSi18fBHQAbH9I1xe0WK7PR0qkQexN0Hxezx
	ctpJdSGB97HYA8xKAf4gyT0gJDIrxIWa4Ebeoz4notubZ9cJ5McLrLJ2lwa3iq1SOBlX5QEwWms
	yxBYFmYjJWZvCUro7ScT6L04hBo+HBOw/OnSh5ZO75h7zbeBl9tKuC8kkzF3wry3vtTrJGYJdi9
	E/Txm1Zi2J4rzFIEbwUNGxZGKFstwBVCutdSj04iEqTNGLvSjkwM
X-Google-Smtp-Source: AGHT+IE/9xv5X1igt6yD3kXyRMvuAsSySnPOjkvdLMDhBbZtwNPc2G33aWO50kIh2RqJtWfK/GhIlA==
X-Received: by 2002:a05:6214:f27:b0:6e8:9535:b00 with SMTP id 6a1803df08f44-6e900621ae6mr239485956d6.12.1741795220383;
        Wed, 12 Mar 2025 09:00:20 -0700 (PDT)
Received: from [172.19.251.166] ([195.29.54.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c733fca8sm9736288a12.4.2025.03.12.09.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 09:00:19 -0700 (PDT)
Message-ID: <1742b7e9-b815-4c12-9c22-aea298afe822@enfabrica.net>
Date: Wed, 12 Mar 2025 18:00:17 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
To: Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, shrijeet@enfabrica.net, alex.badea@keysight.com,
 eric.davis@broadcom.com, rip.sohan@amd.com, dsahern@kernel.org,
 bmt@zurich.ibm.com, roland@enfabrica.net, winston.liu@keysight.com,
 dan.mihailescu@keysight.com, kheib@redhat.com, parth.v.parikh@keysight.com,
 davem@redhat.com, ian.ziemba@hpe.com, andrew.tauferner@cornelisnetworks.com,
 welch@hpe.com, rakhahari.bhunia@keysight.com, kingshuk.mandal@keysight.com,
 linux-rdma@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal>
 <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>
 <20250312112921.GA1322339@unreal>
 <86af1a4b-e988-4402-aed2-60609c319dc1@enfabrica.net>
 <20250312151037.GE1322339@unreal>
Content-Language: en-US
From: Nikolay Aleksandrov <nikolay@enfabrica.net>
In-Reply-To: <20250312151037.GE1322339@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 5:10 PM, Leon Romanovsky wrote:
> On Wed, Mar 12, 2025 at 04:20:08PM +0200, Nikolay Aleksandrov wrote:
>> On 3/12/25 1:29 PM, Leon Romanovsky wrote:
>>> On Wed, Mar 12, 2025 at 11:40:05AM +0200, Nikolay Aleksandrov wrote:
>>>> On 3/8/25 8:46 PM, Leon Romanovsky wrote:
>>>>> On Fri, Mar 07, 2025 at 01:01:50AM +0200, Nikolay Aleksandrov wrote:
>> [snip]
>>>> Also we have the ephemeral PDC connections>> that come and go as
>> needed. There more such objects coming with more
>>>> state, configuration and lifecycle management. That is why we added a
>>>> separate netlink family to cleanly manage them without trying to fit
>>>> a square peg in a round hole so to speak.
>>>
>>> Yeah, I saw that you are planning to use netlink to manage objects,
>>> which is very questionable. It is slow, unreliable, requires sockets,
>>> needs more parsing logic e.t.c
>>>
>>> To avoid all this overhead, RDMA uses netlink-like ioctl calls, which
>>> fits better for object configurations.
>>>
>>> Thanks
>>
>> We'd definitely like to keep using netlink for control path object
>> management. Also please note we're talking about genetlink family. It is
>> fast and reliable enough for us, very easily extensible,
>> has a nice precise object definition with policies to enforce various
>> limitations, has extensive tooling (e.g. ynl), communication can be
>> monitored in realtime for debugging (e.g. nlmon), has a nice human
>> readable error reporting, gives the ability to easily dump large object
>> groups with filters applied, YAML family definitions and so on.
>> Having sockets or parsing are not issues.
> 
> Of course it is issue as netlink relies on Netlink sockets, which means
> that you constantly move your configuration data instead of doing
> standard to whole linux kernel pattern of allocating configuration
> structs in user-space and just providing pointer to that through ioctl
> call.
> 

I should've been more specific - it is not an issue for UEC and the way
our driver's netlink API is designed. We fully understand the pros and
cons of our approach.

> However, this discussion is premature and as an intro it is worth to
> read this cover letter for how object management is done in RDMA
> subsystem.
>
> https://lore.kernel.org/linux-rdma/1501765627-104860-1-git-send-email-matanb@mellanox.com/
> 

Sure, I know how uverbs work, but thanks for the pointer!

> Thanks>

Cheers,
 Nik

>>
>> Cheers,
>>  Nik
>>
>>


