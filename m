Return-Path: <linux-rdma+bounces-6794-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5BEA00B76
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 16:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24EE160678
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 15:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146FA1FBCB7;
	Fri,  3 Jan 2025 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oYMH+sa7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EBE1FA8D7
	for <linux-rdma@vger.kernel.org>; Fri,  3 Jan 2025 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735918308; cv=none; b=K5H3k0s5e1opLiC3VRO/bryjehTpT/vm4lWDyrE5Io7KG6ciuhVaMdhD3kchuECivIXCh+bK08iR/g/MuyEjeLvoAdjlDxnYQfB28OXaoMYYVhyjEhPo6Lg0FDAwUpnC8QzIzlVxEjG3kX5TGPVgiDJGYr55YLY0vxAxg0VHe+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735918308; c=relaxed/simple;
	bh=zhL6B/F6IJvl55yDzVTfZTnD5kNIU58Yiz2yT9h1oIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6Jr3hQXLzPNpsr0QFXQBPs9kVPYBjWGnei1wA+Zki/zOc7ox0bZs8iR+x/dep9oR3/Dhz7a6hrUi8G4LP4PDDfTZoMFzJkGFp0L2Ttuy1nRylY8XDDV73ZBZQXRM43Ir597qlw+bjs5Jj/IgLLihXw60ENYaybNd4I1thIzwv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oYMH+sa7; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46b1d40abbdso1538931cf.2
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2025 07:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1735918305; x=1736523105; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zhL6B/F6IJvl55yDzVTfZTnD5kNIU58Yiz2yT9h1oIo=;
        b=oYMH+sa7IIZn5gesamn1VZqPo+vNjeYVPU5Oi+qvKaHgoaGQTzCv63MzRsADVfR8mq
         oNs/OEKfR8fc8fTh+BthODVRGYb8SOOoGADh9xP7orujzNjWwKGQ9dfQNGFtDs3ymDDM
         6GJD2ILvom/L0R6aWEtEdA8nE7tBF5Z2oy+A9m5Wspct+xnMafZ2ZiwMSiBfqHBWTiTO
         6BzqTnkBe32IGHJkoV/KaxFLcH7zW1/OWbAZTSyhiPeVOkjI6ZEF/qnLCkhjQr53sZP7
         FstaZ2wiJisk9Cu+3jsmBGTqpzX7S058rO1guHHElG2zLt3HzgAhYYY8itmIJjf0+kGy
         tp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735918305; x=1736523105;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhL6B/F6IJvl55yDzVTfZTnD5kNIU58Yiz2yT9h1oIo=;
        b=hlYOVO2cqmPO9krpL6O+Gm+qrCDaJJR18LssLmZegZxbGNIOBUJTEknVeQFUuXjwcX
         wiWLAEULXHZGTwvT8BGCOQvn1nBi/xAJBX7yoEzbQZO0TRIlppnvSyFM1sd2dnr1gq+3
         0jIUKEFxAKVXxwG73qcwioSjd7/hEZtAzIq+5NjKFtNfeL/P0CmqnX3QePX7n2YNXqbh
         63rwVstBphHLt9mrjrHwa3CcobB1RtSahLbS9y+c233XjrtPV5lrhljoXs1VzmZA8uHC
         fr8OTMilkwHDfcCaoC1J6ho9ZuEEBG+ySUw7hYb/bxoFwWcFi5zSUAAXHoFgn7qi31y2
         tSwg==
X-Forwarded-Encrypted: i=1; AJvYcCXXmJVN+s5pzzIimIfEEXIe67bLRV8F1NxZcphnVhE6q7yiT+fxujdqRyyJDFs6+wOAkWSLM3MKFGtR@vger.kernel.org
X-Gm-Message-State: AOJu0YwhNld3zAytsPp/++P3R2Ego5J9JWX4w86YvQl9tJ2qR4UPU7dj
	X6ehmHAIot/aYP4Sywfnhxb5Mg6tZhL1N966iSjdkIMQZgN02bYU749iK/kZJHo=
X-Gm-Gg: ASbGnct6y015Ti32hP6VbmWkVIX09q5zlKbKqK5cK8vArEruXZKuNJyOvjLCmHr78cx
	wel8mqgxGuw8b0TO++MGiRVtjisosbC0RpzahlKCQ/SZoiBoePZ39NjJtE8jfzB6MlCs9PYtJkt
	lKV4mkXW0ASn1Y8dv4q2bxFTAR2wWKkRBKshq/we3lvb4dZRJ70Bmy9uJxDoWS0xkWGlOQgLXuk
	mo8QPGIP1NvmObbrIe4n7RxYLCvTNqLwouNlbeMxb0O+EBYVGo54M2ZMiAEKZP3DSVr4SJxezfZ
	0bdw40nGNw3DjCVmpToQ1dOob0nKFQ==
X-Google-Smtp-Source: AGHT+IHLKH/Qkpd3ineas86woJtpW9dqgaHH8lI5LWDDkQuIsCv/4PrdU/YrEijFsXEAJMoI/tHNlw==
X-Received: by 2002:ac8:5a86:0:b0:466:a091:aa3f with SMTP id d75a77b69052e-46a4a9a28fcmr805071131cf.51.1735918304858;
        Fri, 03 Jan 2025 07:31:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb175eesm146697171cf.55.2025.01.03.07.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 07:31:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tTjeJ-00000000j2m-0UUS;
	Fri, 03 Jan 2025 11:31:43 -0400
Date: Fri, 3 Jan 2025 11:31:43 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zelong Yue <yuezelong@bytedance.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] RDMA/core: Fix IPv6 loopback dst MAC address lookup logic
Message-ID: <20250103153143.GF26854@ziepe.ca>
References: <20241110123532.37831-1-yuezelong@bytedance.com>
 <b044faad-1e3f-4c65-b2e6-fc418aebd22e@bytedance.com>
 <20241121135332.GB773835@ziepe.ca>
 <ab960175-d1f8-402e-9200-d47a7761315c@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab960175-d1f8-402e-9200-d47a7761315c@bytedance.com>

On Thu, Nov 28, 2024 at 05:21:42PM +0800, Zelong Yue wrote:

> 1. IPv6 addresses must be in the same subnet
> 2. The 'local' routing table must have lower priority than our custom policy
> routes
> 3. When IPv6 addresses are in different subnets, enabling RDMA loopback
> breaks TCP loopback
>    functionality unless packet forwarding is enabled (which isn't feasible
> in our DC
>    environment). We're still investigating a more elegant solution that
> wouldn't require
>    packet forwarding or impact TCP loopback functionality.

What do you mean by packet forwarding?

For multi-NIC RDMA loopback to work the network must forward packets
externally from one NIC to another. Internal-to-the-node loopback is
not possible. If that forwarding works for RDMA I would expect it to
work for TCP too.

For single-NIC, I believe you can use lo to trigger an internal NIC
RDMA loopback as well.

In all cases TCP and RDMA traffic should be aligned, otherwise it
becomes impossible to use normal IP tools to debug the RDMA traffic.

> Given that RDMA loopback has different requirements from TCP/UDP
> loopback, maybe they should follow distinct routing logic.

It cannot, things must be consisent.

Jason

