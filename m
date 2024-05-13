Return-Path: <linux-rdma+bounces-2456-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D678C42BB
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 15:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5235D1C20C29
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 13:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786E41474BB;
	Mon, 13 May 2024 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcT1eoBF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE45B153572;
	Mon, 13 May 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608791; cv=none; b=PeeBchTsgxvASjvUF4MBpOO1ySh4sSZwINJNDkBopWo9j+Sz8XPZR6/LQT8NMnk7wjc1vsvblmTj0rIYV70IlL1PzXLOeBlzjjTH+CAQj/VHsYPD3sz4d+YY8ithLsqGgV2YeVJ6kLygD7++2y/Oc/JNiXoIm+cierZ5gNfbufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608791; c=relaxed/simple;
	bh=Z/pI+oNbnfobc1hNlFJip6csGjxhtE1gQhREADsN0ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GK2fBIBtvdvREOf9fiQO09okYdKi+Aq/PPUTzjXqnqfet5wr1LIFSLEJqn8mdInWYPMAVXjjw4Kuh7qbT50q3QPcarilvJzpkgt+75FeO6CnuNQcBtrsI2VfWwB21m1UYPsUetzM88x3W2x4+cTaFkPj7t/ixOqmn6BpEHP+/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcT1eoBF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42016c8db2aso6257105e9.0;
        Mon, 13 May 2024 06:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715608788; x=1716213588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HuXC6mCoMwVpLgRnknSensg0pfcnshMHI8xLSlaCCSc=;
        b=NcT1eoBFPM+eTKQ+vW+F14xhdwTKBlz1I9ipI9mTicwuqY4IqPv2ay0XnP5d+lefvm
         pnlPAQp5kQwvsJ42H5yn66N1M/UPZU9mj6lUmkfW0ryYDqaLdZlBqIDMzwqycWXXk3Ou
         MBhYBbMuk908gqn9DVTwkjnDQBJym+XONG+cpXpBuqoCY1xFluhU9gIJaimgE8OgC/3p
         8EyX6xolTvUijFFV11stjXg5e0QPE9s5xLR7NJR6NnziEfWvSop0NPCxOT2nlRSjqzk4
         BLSFcfA46bKsmSh2+PTORCdivBNYYVOhRj3pW2OLQRBNxz7ZEaOjIyE1pi4J4TsvIH27
         WCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715608788; x=1716213588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HuXC6mCoMwVpLgRnknSensg0pfcnshMHI8xLSlaCCSc=;
        b=mx/EsPUwtV5ylcpwUTgM1n0XX766oeQ8EAv6UHWfqUA+zTxAPBXNwMr9h5Sd4GPzJO
         WoJx2UeyieBG+PnNva9Xi8/kaV/Pv6GcbiGmPpVDHp7qSD9KhAjQWzAFbDehYDzVFmR2
         Z3d5yykROWu+rzN9LM4ACHwsYnp3nYCpChalSq5GY3cdY+QpjQzTN67FykOsa5ypF6a6
         cUY53uTfRVIh0/UIwq+pkdTh2phqQvbZjRQyA/KBvcMrx7aczPzkqYNXksk/X9SrDuI8
         /atchXuf9WFm67QGb8YXtaoWT26XTX0gxH4tts1ZVFVqIPXfshUWe+XaqC3qX+uoPwc+
         CJqg==
X-Forwarded-Encrypted: i=1; AJvYcCXxk2Db3iLLSljZqq+Hy6oKwdPbC+6nnv/gOEwHXCjKrArqHsyqnLzB8Y8AJCCzzDbB7CUNb0JUqwhLNvbzi7fvQf0XMj/nfkytum6TJjEN8U0MkdNQkO2abgy1ya9zU2C8ag==
X-Gm-Message-State: AOJu0Yz66XESoe2IdJ11cIxke1MDsn7kpR46Q7eV4iP0HoFaJD1stGM2
	wtXa6g9blahjZ9C92El7Q9MKoUaGPE4x/jog3/5EQGjqoAleY44o
X-Google-Smtp-Source: AGHT+IE4Nf2DOyX6Yyj6BK9+gnKzFGoeOzmW7EjHr0TK09uQouoFbcX+f8WjrzYMhIBtPavzPb7VUQ==
X-Received: by 2002:adf:cf06:0:b0:343:efb7:8748 with SMTP id ffacd0b85a97d-3504aa62cf5mr6823243f8f.66.1715608787787;
        Mon, 13 May 2024 06:59:47 -0700 (PDT)
Received: from ?IPV6:2001:861:5861:ab30:2dfa:2b38:fb4d:22aa? ([2001:861:5861:ab30:2dfa:2b38:fb4d:22aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbc7easm11119136f8f.110.2024.05.13.06.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 06:59:47 -0700 (PDT)
Message-ID: <6dc1d533-122b-475d-a908-c15026c8b345@gmail.com>
Date: Mon, 13 May 2024 15:59:45 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Excessive memory usage when infiniband config is enabled
To: "Saleem, Shiraz" <shiraz.saleem@intel.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Konstantin Taranov <kotaranov@microsoft.com>,
 Leon Romanovsky <leon@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "florent.fourcot@wifirst.fr" <florent.fourcot@wifirst.fr>,
 "brian.baboch@wifirst.fr" <brian.baboch@wifirst.fr>
References: <2b4f7f6e-9fe5-43a4-b62e-6e42be67d1d9@gmail.com>
 <20240507112730.GB78961@unreal>
 <8992c811-f8d9-4c95-8931-ee4a836d757e@gmail.com>
 <PAXPR83MB0557451B4EA24A7D2800DF6AB4E42@PAXPR83MB0557.EURPRD83.prod.outlook.com>
 <fa606d14-c35b-4d27-95fe-93e2192f1f52@linux.dev>
 <20240507163759.GF4718@ziepe.ca>
 <IA1PR11MB7317B56B84421912ED6E856CE9E52@IA1PR11MB7317.namprd11.prod.outlook.com>
Content-Language: en-US
From: Brian Baboch <brian.baboch@gmail.com>
In-Reply-To: <IA1PR11MB7317B56B84421912ED6E856CE9E52@IA1PR11MB7317.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Thank you for your answers.

It's unfortunate that by default the irdma module uses an extra 5Gb of
RAM, which is huge (more than 30% of the available RAM) and that there's
practically no way of reducing it without deactivating the module since
the limits_sel parameter is not available in the in-tree driver, as
mentioned by Shiraz (I can confirm that gen1_limits_sel=0 works on
my x722 card, I tested it, but it looks out of topic for me since it's
not in the tree).

For my case, since I don't need the irdma module, I will just blacklist
it as suggested, but I think that it would be better to change the
default value of the resource limit selector so it doesn't consume this
much RAM if it's not used.


On 5/8/24 03:24, Saleem, Shiraz wrote:
>> Subject: Re: Excessive memory usage when infiniband config is enabled
>>
>> On Tue, May 07, 2024 at 05:24:51PM +0200, Zhu Yanjun wrote:
>>> 在 2024/5/7 15:32, Konstantin Taranov 写道:
>>>>> Hello Leon,
>>>>>
>>>>> I feel that it's a bug because I don't understand why is this
>>>>> module/option allocating 6GB of RAM without any explicit configuration or
>> usage from us.
>>>>> It's also worth mentioning that we are using the default
>>>>> linux-image from Debian bookworm, and it took us a long time to
>>>>> understand the reason behind this memory increase by bisecting the
>> kernel's config file.
>>>>> Moreover the documentation of the module doesn't mention anything
>>>>> regarding additional memory usage, we're talking about an increase
>>>>> of 6Gb which is huge since we're not using the option.
>>>>> So is that an expected behavior, to have this much increase in the
>>>>> memory consumption, when activating the RDMA option even if we're
>>>>> not using it ? If that's the case, perhaps it would be good to
>>>>> mention this in the documentation.
>>>>>
>>>>> Thank you
>>>>>
>>>>
>>>> Hi Brian,
>>>>
>>>> I do not think it is a bug. The high memory usage seems to come from these
>> lines:
>>>> 	rsrc_size = irdma_calc_mem_rsrc_size(rf);
>>>> 	rf->mem_rsrc = vzalloc(rsrc_size);
>>>
>>> Exactly. The memory usage is related with the number of QP.
>>> When on irdma, the Queue Pairs is 4092, Completion Queues is 8189, the
>>> memory usage is about 4194302.
>>>
>>> The command "modprobe irdma limits_sel" will change QP numbers.
>>> 0 means minimum, up to 124 QPs.
>>>
>>> Please use the command "modprobe irdma limits_sel=0" to make tests.
>>> Please let us know the test results.
>>
>> It seems like a really unfortunate design choice in this driver to not have dynamic
>> memory allocation.
>>
>> Burning 6G on every server that has your HW, regardless if any RDMA apps are
>> run, seems completely excessive.
>>
> 
> So the driver requires to pre-allocate backing pages for HW context objects during device initialization. At least for the x722 and e800 series product lines.
> 
> And the amount of memory allocated is proportional to the max QP (primarily) setup for the function.
> 
> One option is to set a lower default profile upon driver loading; which will reduce the memory footprint; but exposes lower QP and other verb resources per ib_device.
> And provide users with a devlink knob to choose a larger/smaller profile as they see fit.
> 
> This is sort of what limits_sel module parameter Yanjun suggested realizes, but it is not available in the in-tree driver.
> 
> Between, what is the specific Intel NIC model in use?
> lspci -vv | grep -E 'Eth.*Intel|Product'
> 
> Shiraz
> 

