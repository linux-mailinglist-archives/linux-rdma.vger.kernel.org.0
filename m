Return-Path: <linux-rdma+bounces-2316-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3358BE34C
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 15:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48D41C23BC1
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 13:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9F715ECCE;
	Tue,  7 May 2024 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNooqCjT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACAC15E81C;
	Tue,  7 May 2024 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087738; cv=none; b=M7iZxLFwCqRy0XbXKaKKI+JyUjHxkDXOOQgE4l7L4Gee+lq3H0mnUymKBBEtmKO8De3hUI6Wj3VVZkPQYTXFDwtzfdXtoFwn48XzSWGSDlq1Ohr3zUtmDcZ1nEPhhsOd1uDUiOwAAuuFVvl5cU0f13HdsSj3OBqZS/fVb3JDnes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087738; c=relaxed/simple;
	bh=jOLu0KOXGWGoH7/XvsTAzdn3haN69TjNK88IZgaxOZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSb1Kg2sHD3emwIWjcxNf8+1UctuVq9iv0LnnDcH0Pj1RmRhO/uD1R/6jFbDHqbscjEM5VWagktxv9goUAwXSCcTUGnNxlxmVO0SdRjcPONSu2Z8YhIXmY1iXfu8hGhqtrZ2EGhowgAfc3OVJ86L4e/lJE3BjWNLipK5uejZSsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNooqCjT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41b79451145so23442665e9.3;
        Tue, 07 May 2024 06:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715087735; x=1715692535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4tJdBDquDozcEqIZjfPcmuvtEe2kBu5kt+olI6SD9Ok=;
        b=jNooqCjTMfvcFXNelOmWykzoeqCXlmgWJcpQDmsXSq8Nhh3ATu4xztTLVTgIXZrdLx
         kLw9e9VkGM8xrhus0v5dw5U/7xUWZP+u6ELq30a7WiLbOhE67fJVZF3yJIqSuiino/5C
         ieYK2KEvg/sQDKI5EmfnAsjlGoSrop7WiIglBq530dYNVWpltQp0XDvdWEAnG29TuW3U
         ahylnzDhgpg5U2CJL0B5IP1KDHU6R8XFVizDBTAUyXqKBHxQtEm91E/VHnHIP2bDg2Vo
         zY9HfO3KX7rdgJ6ydU5STRPYHNvzck7vbxiTsNuKw4gqqF0Zln2nYUiUqqJWJ/6cBwXy
         eUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715087735; x=1715692535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4tJdBDquDozcEqIZjfPcmuvtEe2kBu5kt+olI6SD9Ok=;
        b=fIElP2IpIwOtJgCp1I7ARGwGLnzeEhKGdQsfBpwP0hqUs8GUWUw60NxwNndXA06ixK
         DXsDdfW7lScfvkg7AOKapizoTaBdUMtSXHFK32u6Q3ydSudvCcJmzG8OrA/VDmwfFR6r
         YluQhSQYlQT9H048FySARZuG/NPN6ih/Te/9/vEFX040AeT+KxsoW19vtt/DxwQOvHlJ
         vzDCIyuZ65fOpiejjEs7j/qHDr6LO52J7bl0JDjcHa6mFsW95YAbs3sGSWiLJmIF+Y2j
         88WCjGndIoMVok77t52EH6Opljh28Rugf2y/C03Er778yuyb+EFN66FxWnx8zLws5pNr
         +++g==
X-Forwarded-Encrypted: i=1; AJvYcCUpah+5ZMeE//dtaQYFNiN2xKDzGrnKzeuARFAQzCtiI9VfKkUIQWBgJQ/es6aIf1+QSEV20BY7YmDs4L88q6aO+PgZ7DPA
X-Gm-Message-State: AOJu0YxHX1fzBRAnxbRCJ7dTfuFrladjrf3Mcj51NtyjCDorvRox3O0I
	KO06olcxdr4RO9o8jP76WXERIYKP4Ljit2Y+fsto4L3P5uhSuUoVmbm7ZRyJ2RY=
X-Google-Smtp-Source: AGHT+IGYExJw1hv9fwv1zTgwzdju0ZaBpqteCnLdi+P/Kw/Es+gJWQReMq4qvUri6G4deixdzbLcsg==
X-Received: by 2002:a05:600c:4510:b0:419:f31e:267c with SMTP id t16-20020a05600c451000b00419f31e267cmr10805134wmo.7.1715087735297;
        Tue, 07 May 2024 06:15:35 -0700 (PDT)
Received: from ?IPV6:2001:861:5861:ab30:2dfa:2b38:fb4d:22aa? ([2001:861:5861:ab30:2dfa:2b38:fb4d:22aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f4307ded2sm9027245e9.0.2024.05.07.06.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 06:15:34 -0700 (PDT)
Message-ID: <8992c811-f8d9-4c95-8931-ee4a836d757e@gmail.com>
Date: Tue, 7 May 2024 15:15:34 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Excessive memory usage when infiniband config is enabled
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, stable@vger.kernel.org,
 florent.fourcot@wifirst.fr, brian.baboch@wifirst.fr
References: <2b4f7f6e-9fe5-43a4-b62e-6e42be67d1d9@gmail.com>
 <20240507112730.GB78961@unreal>
Content-Language: en-US
From: Brian Baboch <brian.baboch@gmail.com>
In-Reply-To: <20240507112730.GB78961@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Leon,

I feel that it's a bug because I don't understand why is this 
module/option allocating 6GB of RAM without any explicit configuration 
or usage from us.
It's also worth mentioning that we are using the default linux-image 
from Debian bookworm, and it took us a long time to understand the 
reason behind this memory increase by bisecting the kernel's config file.
Moreover the documentation of the module doesn't mention anything 
regarding additional memory usage, we're talking about an increase of 
6Gb which is huge since we're not using the option.
So is that an expected behavior, to have this much increase in the 
memory consumption, when activating the RDMA option even if we're not 
using it ? If that's the case, perhaps it would be good to mention this 
in the documentation.

Thank you


On 5/7/24 13:27, Leon Romanovsky wrote:
> On Mon, May 06, 2024 at 05:15:55PM +0200, Brian Baboch wrote:
>> Hello,
>>
>>
>> We discovered that the CONFIG_INFINIBAND_IRDMA configuration option in the
>> linux kernel is causing excessive memory usage on idle mode on specific
>> servers like the DELL VEP4600
>> (https://www.dell.com/en-us/shop/ipovw/virtual-edge-platform-4600.
>>
>> By default we were using Debian's linux-image-6.1.0-13-amd64 which is the
>> stable 6.1.55-1 amd64, we then compiled the kernel again with the same
>> config file from the stable 6.1.55 tag and had the same problem. We were
>> able to resolve the memory problem by removing the `CONFIG_INFINIBAND_IRDMA`
>> option from the kernel config.
>>
>> The tag used to reproduce the problem is v6.1.55.
>> adding the following config `CONFIG_INFINIBAND_IRDMA=m` causes the excessive
>> memory usage to go from 1.4Gb to 7Gb.
> 
> Hi Brian,
> 
> Why do you think that this is a bug?
> DELL VEP4600 supports RDMA, so by enabling CONFIG_INFINIBAND_IRDMA, you
> compiled RDMA support for Intel NIC.
> https://dl.dell.com/topicspdf/vep4600_tech_guide_en-us.pdf
> 
> You can unload irdma.ko module and restore memory footprint.
> 
> Thanks

