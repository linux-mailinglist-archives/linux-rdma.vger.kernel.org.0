Return-Path: <linux-rdma+bounces-13176-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F55B4A19D
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 07:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED22E4E5FB1
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 05:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4B02FC030;
	Tue,  9 Sep 2025 05:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmRdyYgg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DF1235345;
	Tue,  9 Sep 2025 05:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757397158; cv=none; b=YzxvE3S1dJin5gzrN4MSEOilG1RSwrw7XA90rz9V4xcLlH7USqFVrJEPnZ6dms01mXe9wGtq01LE6e/e5gk+iKxvuW8va1pypJkgW3T2RCf3k7M2oebRlkx4pbUpTACO1jir/Vmtl+srWKWtXMvzm7X/lLIYu7IvP8ie8CB2/H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757397158; c=relaxed/simple;
	bh=VQQ1lN513RELz1RBuncnSXiG7shY2pPI+qGAdfdX+rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hESIao04Q03uksdlMDqJ8zjRIyjTVShWoPfl0bB3ostlYRN05upqBEa/6+vG7MjU7ogWUBUtuY06cQVQH5MDalCQ/JqzBJ4jmukM5V01Vo1VHCHr2CvZuBA32w/XuWWQqWM1q/bEnUjONmQVI7r71heK2VPFXdEHvfGf3hMmjtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmRdyYgg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso31073395e9.3;
        Mon, 08 Sep 2025 22:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757397155; x=1758001955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8GQtuEM9KVeO11wzE/KB3+A4EoaPaCi2T85wynCWuLQ=;
        b=hmRdyYgg2Ek3+B/r4nQoLSsptF0GlAqGhfIV4l+0t25bh9YviDZXQ0UgeEucd7FKQh
         8j0d+a3WXzBTJOy/Sz1OYikuQ8wgTUR0mnBbCYvnmDysSUvZ4DsDijVJ+rfnBx7iKDnp
         hBcNwha8VecKmPYqp+jpW3XbNWvwWfpul6E7OxI5MKVZpRt0PT5CEQLvHHM9vnAgpN4z
         lA1+B2f8aOoiFXqcEp0j7iM7eGHTTg/154isHoIwIh5wHb/WQoCzZxHyKwPXMmLcuzNt
         2ht2lwtfzT2XGmdUrxxCQVBlBmedZsxIsm3uOVvOGXI+d6tKeOajwdjjdtutdji8ZKss
         /V6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757397155; x=1758001955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8GQtuEM9KVeO11wzE/KB3+A4EoaPaCi2T85wynCWuLQ=;
        b=LZ3SbFn7XI8eO5fqjRmEfjVwZE10WgZ2VxmGVFaYFw0bA9iOrA0YT6gc7/AP7lcoGs
         pxR8tVg6l37jUjFYYNugqZehvizw8uGYc/dnd+cnPwNLV4/RM/PlfqT0yAxFDWy89JTj
         J0uopPZMiHXciMnKY3rJXP5D6oTdV00zirCIpshkPGcl44640BhBgo9hd44tjHEB0bRH
         sEKqaaqc5IAcL8pHnj/PS1kjLxoKRYFboVBOtYpAwlXIpiOWlu/s9IHjC/vXtsLiNRKF
         KtpCkQxKfXFOwBWC9Jlv8pTpFUOKjxshMi+fJrSy61rFA3Y00xAHy5q9OleWhK3J4YkI
         ACow==
X-Forwarded-Encrypted: i=1; AJvYcCVXPnk3Kpy9HZrHSvrnm9zhHa0O84bZILa9HpPuVqmXT03Eq+b3PxQ2UpMt4QPQbDGFk9mB+RQTt8PKx5o=@vger.kernel.org, AJvYcCWM7lzsxEpyHA8eRZzTGQSr7jqlZj8R83s/NRqhk2qO1KAgAsqu9F9+4iCTPnD5P/ftwoaBqQik@vger.kernel.org, AJvYcCXodlf6VPHPa5CvkewIbMKDE5Kc5KnB6VjDqOwyDE8gOF9G/3A9/AzoBfzFZ9t8b1lmfH4VNU8ghxk3dQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2v0VA8TROafVmLsxY5EwwnOaqrRXJ63J3YZsVC3DO9HtiDFMI
	pOW5Ebmsx88i7BCBQ0dmvu/SDqSI/ycOwaHR4C9utj0vLDoUU6nxh0j/
X-Gm-Gg: ASbGncs9VjOnh2TsxisDvUdofvRM/40bfBS2TyDJcIUIC2mZAu4A60R+cCWTS+CBheH
	QgyQKg2E8GAEir5R/orGMWpNhODKK+dw1dzEydh3Y/H1FkYP+ED1X4EjMtf9cqcFldLW7IFXHYm
	vbK6J9+r5L46EcpDNLRFc8TYx1fPF7NnaIG7gDvt/Ph9tIWCz06i1BDa1K2kARIHacI4O8okhea
	7vsg29Co/JqM5ApOPeC4b9ZfVwiQZKLE7j2CrJQIyCw7Wr2gXRhWKB2GXwy0dxZJqj8m+4knbki
	v4s4/RWru2btb1ClHQWW7oc3sQ5tURNJAaFAUfdvgpQILb/GoEPG+vQzCbMPeNqp2PNgxBStbJp
	D7Oi6D/+/DjFdSGOHGepDdUzvY54uC+YNsN2FHvfLcyu3jaFpARUElr/cGEyliH+bIGtH26ObE5
	Uxn1dKsQ8=
X-Google-Smtp-Source: AGHT+IEd0QVuQMf9hcVCydaZL4Gz0VKAhlI6CBSPbinLFBT6z6bSurd34JLpj+zDmHoa/hAeexUN+w==
X-Received: by 2002:a05:600c:c4ac:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-45dddecdaf1mr76419575e9.21.1757397154320;
        Mon, 08 Sep 2025 22:52:34 -0700 (PDT)
Received: from ?IPV6:2a0d:6fc0:1394:1700:c43f:7c46:8b7f:da00? ([2a0d:6fc0:1394:1700:c43f:7c46:8b7f:da00])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de18f4824sm119956455e9.10.2025.09.08.22.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 22:52:33 -0700 (PDT)
Message-ID: <1f85b803-eeda-4d62-b36b-8fc84390e74f@gmail.com>
Date: Tue, 9 Sep 2025 08:52:33 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 1/3] ptp: Add ioctl commands to expose raw
 cycle counter values
To: Paolo Abeni <pabeni@redhat.com>
Cc: Mark Bloch <mbloch@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>, Jakub Kicinski <kuba@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Richard Cochran <richardcochran@gmail.com>,
 Carolina Jubran <cjubran@nvidia.com>
References: <1755008228-88881-1-git-send-email-tariqt@nvidia.com>
 <1755008228-88881-2-git-send-email-tariqt@nvidia.com>
 <ca8b550b-a284-4afc-9a50-09e42b86c774@redhat.com>
 <1384ef6c-4c20-49fb-9a9f-1ee8b8ce012a@nvidia.com>
 <aLAouocTPQJezuzq@hoboy.vegasvil.org>
 <3f44187b-ce41-47e8-b8b1-1b0435beb779@nvidia.com>
 <aLmQt838Yt-Vu_bL@hoboy.vegasvil.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <aLmQt838Yt-Vu_bL@hoboy.vegasvil.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/09/2025 16:14, Richard Cochran wrote:
> On Thu, Sep 04, 2025 at 03:09:23PM +0300, Carolina Jubran wrote:
>>
>> On 28/08/2025 13:00, Richard Cochran wrote:
>>> On Mon, Aug 25, 2025 at 08:52:52PM +0300, Mark Bloch wrote:
>>>>
>>>> On 19/08/2025 11:43, Paolo Abeni wrote:
>>>>> can we have a formal ack here?
> 
> Looks good to me.
> 
> Thanks,
> Richard
> 

Hi Paolo,
A kind reminder, we got the needed ack here.
Yet patchwork state is still 'Needs ACK'.

Regards,
Tariq


