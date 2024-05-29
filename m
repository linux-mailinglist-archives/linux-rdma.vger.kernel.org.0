Return-Path: <linux-rdma+bounces-2672-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FA88D3E63
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 20:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E2928952F
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 18:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94161A38D8;
	Wed, 29 May 2024 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IJxy4oQY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21338181CE2
	for <linux-rdma@vger.kernel.org>; Wed, 29 May 2024 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007598; cv=none; b=YQ4a3hf1AtIFYuSky7EarGKVT+EvDv3o1JXcr0nyBgbssez0pjl65H6moGH90RjS1qw13NlZ1YIX3vYR49zGsJagMsRm90jxtuZuNSHOV6jg2z/NLv12nNczZvaZPmvPhrLqRL6wC/d3ZHSGZ038NawGHAmjj9OzK6QwkwPK7Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007598; c=relaxed/simple;
	bh=it8dbHukhI7yxeNuV4eX9byk8v4t1Lq68EzS8m7z2IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Se1Nlv2lzJa27fFpBmBXgQ14nxIuCmvUoNFXZ5KVSeWiATUpNSW4U4t9FxPi8hdEiWfWhs2On7orYnUw0DCUqClfx1vcjnyxYNQIGx8CJTrBfOcjVC6YzV3n/aXnNnZoKoetF/SpWltF+DsG0O8a84+46vDBlwmdKlAMaZ1RUOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IJxy4oQY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4211e42e362so171625e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 29 May 2024 11:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717007592; x=1717612392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mMGPCLnhQ7gXZpNgtltYtJmd5aNGWy2qAra4VCUw3KE=;
        b=IJxy4oQYQ0N/z5BFjX8ekiz4h32fcgeju45YSEq5s50NKAz0vtnISQVdgaRa5K/zwL
         WiTu0jo1o486gmWlfSo/ebXDw4DrySX8zWkDj40wfPtNPuV1v1JOt0NZqdZIKU/bhlhS
         kn05+yCitYAh2PDTuA2KLYHg/ttprTYGk7ffDFFNdGwhrqd69XwlDCOxGayxCW+Pt+rs
         yed/tKWIizEoQurB/QrzuJF6bp4OhWKU73mOIjzr/A5rJICRlk0lBaiax6Vnb+T41fUU
         42wRcWarA8ShXytf7ve+TEJ80Yt4S2huApSjED/5G8jLWNAi7f8eBK38N47+e03SEuXX
         xrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717007592; x=1717612392;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMGPCLnhQ7gXZpNgtltYtJmd5aNGWy2qAra4VCUw3KE=;
        b=rNgctT6iFiHOBrAqXdm61bNAtdHAZvbuYCXKhX0+3NI66eP3P/Y3z9PI4KWhIUw1iP
         oHL+8vk2mNwmSg/CuWZ36p5s4a6ms6MdxIIqX6T6Q9Q1f9LUtWNyLVqG59tr1M1o0yfU
         A+UCi/7FDjmtUwE7Oa0QBGYRGUUXSe6VtEJ4L74uOi/HsJa3mNMx2aA1kN/IPTFcoLNJ
         8WSTL008huMXtrkLdBJvcjdjPimEq3tRfUzeddx16tp3kJ33YrX6OVoflko1XYS7yPUB
         bYhGzPl7+hcoizVoAnAfHRXirgdPdTQ1Md8j0g6HV90qWVDNSNOfRrXTbz73xMPApcvv
         YYUA==
X-Gm-Message-State: AOJu0Yy2Hnsh1G31FGUZvo9sZr37jwbf8Y/v7pWBr2w2aZgnCEIRLcUm
	5D+sUfFB3r+KhbGYi6iRwHd/CBLOyHtny3Dweuhc5hQ5lgNHrNHcsEepUsGDTa0=
X-Google-Smtp-Source: AGHT+IGCZodf5kTovajFahyOl1/H9P9U5w4U7YtBx3SKCSJ6JAaHzjzmP1bIHOZwQLbfE1IRZJUEXQ==
X-Received: by 2002:a05:600c:4f44:b0:41a:e995:b915 with SMTP id 5b1f17b1804b1-42108a4f6b0mr134421305e9.1.1717007592405;
        Wed, 29 May 2024 11:33:12 -0700 (PDT)
Received: from [10.0.2.128] (anantes-654-1-140-64.w83-204.abo.wanadoo.fr. [83.204.35.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212708a780sm2197965e9.46.2024.05.29.11.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 11:33:11 -0700 (PDT)
Message-ID: <e28e3c73-25e1-4039-8aee-3b4d74b1f307@suse.com>
Date: Wed, 29 May 2024 20:33:11 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] rdma-core: new stable releases
To: Leon Romanovsky <leon@kernel.org>,
 Aron Silverton <aron.silverton@oracle.com>
Cc: linux-rdma@vger.kernel.org
References: <8a4daa40-5702-402c-ae80-3f969ac823e0@suse.com>
 <tax7ypiihhjimf2qvdoqpcwobbm5jwwf742dw5hs3a662orsf5@o4lg3z66sbnp>
 <20240125102509.GC9841@unreal>
Content-Language: en-US
From: Nicolas Morey <nmorey@suse.com>
Autocrypt: addr=nmorey@suse.com; keydata=
 xsBNBFjZETwBCADEkoe7QWAXzd9xpSiPbQK6P2F4wKdxyTp6r0aN4I0O+4fc8xWXvmwOrCjF
 UsuoGZ3CxJaHgdB/3ueW/IhMO5Ldz7pylhKVlG/moUh4CBK2eRUdaG7mHID01GyJMtR3VQqu
 22hJhHPYy0erpYViyr+I4MzQA9QZLoQhSxn4imjZOZPcj20JE+lRfXppNv9g7vQiRLMcXjTi
 KcnrqG5owOi6Cn1sZ201YfdeztGxKA+jvjWO+6absTTlorIlZNGUf85s2+caGDsqa31u2DPs
 hVv5UUTy1g/5aP2wacSWI3Qm4n2MWl1aCnHN2h737PCXXfBk5iGJsgBUnSQULgdgEAt1ABEB
 AAHNH05pY29sYXMgTW9yZXkgPG5tb3JleUBzdXNlLmNvbT7CwI4EEwEIADgWIQRC0lOFwaHA
 K4sbHG+AG924JZiPZAUCY5G8SAIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRCAG924
 JZiPZMZiB/9QkcGfH248qvFUWZig3jssK5IgijfOFDKB0YK4e844M5C8LVSuWpu7Z+lM+cql
 3mbrikW6mlZjPEusrQ/KGvT6TdfOM9VCQWjlshMzt7uiRDdzufHGtE5hhk/67UnkEVjmplpD
 k8cb1O0VsBfGym7e0nySHTlDWqr++9EcwgV3uo4psYYEqm6Aon1yKqjbmj+vfl/C5iW3V4lq
 DhBk8w21AvNS+tdEqJzhruxuXkEDZZ07wYFS7m8OxLNb4sMzn/Nz9x/NXeweBWx2ujIERtAq
 1e/hh0ZAcoPVR3CfO2QTmfTfrzVdpZrZ8F54337ze3+BUNnrFGObQhlNe26NqNYWzsBNBFjZ
 ETwBCAC9zAzCRlTgzyO9siVLQYwbRUhcL1TUJU/FiOQWQTmL3uDdBc6MgVBs+hp82RwPbbXT
 v4W4rghBYPKdmFXvRN+jvGDLq1f2hsuCSiE1ckTMzFV+sKoWRIEC12tEpw5ncEFGm+1k/rJR
 Lk9eHxuqn+yRjPryN8CK6tK4+b4tZ2urKlP29XG+T3l/mbUSoqfjqvyeKaW6xw7ku89EX2Xo
 QWP/pm92RxUd6VDU9vpVW/T7qPZRl0wtUnDnO2wePoZmvUfEr5Osh3MNvm1myG+v4EV2Hgva
 NT6pa27IptrUq06cA6dDsIKwPtMuThJQp8/xumgl5Q9A/ErQoJTrB9rclIm7ABEBAAHCwF8E
 GAECAAkFAljZETwCGwwACgkQgBvduCWYj2QwNwf/eOIpFB67cKoUJvcm3JWcvnagZOuyasCw
 xwH9a0o9jORcq+nsJoynS/DpjUKGyZagy7+F7sBrF7Xx0cXF2f5Bo42XNNiQDE5P/VLwvgn9
 62AJ3q0dp4O7oQI8UgNmdsocQhNaBHHCoOabLGrgNobDTaLBeb9zaOZqz8CBuAiZ0bVABEpg
 50hDEYTHp4jCgWpadhAsp/eCgm93Tc+Y+e1fqtE3FmoOLxyhFa6evhn0Q1iX0kCasMZwlzse
 zqLZjTM1Koqn6+UIHXE3QaULyFKD1GDhisXxyolOB6P2TXsyfvitYdIZ3CCtI7PVDxzmX2Xk
 kvEz9bMtStoMpse9qAsmHQ==
In-Reply-To: <20240125102509.GC9841@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sorry for the very late reply. I missed this thread completely..

There are no official rules at this point. I try to not go too much over 20 branches to maintain.
Even if a lot of it is scripted, I still need to fix conflicts and build all thoses branches and click all over the place on Github to make releases.
As rdma-core is released roughly every 2 months, 20 releases is over 3 years of support. Which is quite reasonable amount of time.

The latest batch has 22 branches, but the oldests have seen some "significant" movement so I'm keeping them for now.

If anyone has a good reason to keep a branch for longer (within reason), I'd be happy to.
Also these decisions are not final. If needed, a branch can be brought back from the last to get a new stable releases.

I would also accept PR and/or backported patches to these branches if Oracle has some needs I haven't met ;)


Nicolas

On 2024-01-25 11:25, Leon Romanovsky wrote:
> On Wed, Jan 24, 2024 at 04:05:08PM -0600, Aron Silverton wrote:
>> Hi Nicolas,
>>
>> What is the rule used to determine when older releases are no longer
>> supported? Can something be added to Documentation/stable.md to explain?
> 
> My guess is that it is Nicolas's desire to keep this list limited in size,
> at the end he handles alone all rdma-core stables.
> 
> ➜  rdma-core git:(master) ✗ git show v29.0
> tag v29.0
> ....
> Date:   Mon Apr 13 14:53:55 2020 +0300
> 
> v29 was released almost 4 years ago.
> 
> Thanks
> 
>>
>> Thanks,
>>
>> Aron
>>
>> On Mon, Jan 22, 2024 at 07:33:36PM +0100, Nicolas Morey wrote:
>>> These version were tagged/released:
>>>  * v29.12 => This will be it's last stable release
>>>  * v30.12
>>>  * v31.13
>>>  * v32.12
>>>  * v33.12
>>>  * v34.11
>>>  * v35.10
>>>  * v36.10
>>>  * v37.9
>>>  * v38.8
>>>  * v39.7
>>>  * v40.6
>>>  * v41.6
>>>  * v42.6
>>>  * v43.5
>>>  * v44.5
>>>  * v45.4
>>>  * v46.3
>>>  * v47.2
>>>  * v48.1
>>>  * v49.1
>>>
>>> It's available at the normal places:
>>>
>>> git://github.com/linux-rdma/rdma-core
>>> https://github.com/linux-rdma/rdma-core/releases
>>>
>>> ---

