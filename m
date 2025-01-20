Return-Path: <linux-rdma+bounces-7104-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5557BA17056
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2025 17:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13CB718896DE
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2025 16:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB501E9B25;
	Mon, 20 Jan 2025 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aq2a3Tjk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD459BE65
	for <linux-rdma@vger.kernel.org>; Mon, 20 Jan 2025 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737391204; cv=none; b=IIIkye3C50Pqf530mrWTGhIA+rCtEDLbFoA/XRa7wGPdsc3BW42VYEzTMgjpgHmxeWKwIvzr69IEw8nVOIC1FdTjIaxZhWHEgX12M6ObEfva092sy7URfdECxZ2ML0++G9jyB2VMF5w+Hsp19P22FsopXtBdCjOR5thT07/wQjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737391204; c=relaxed/simple;
	bh=AlwjtWZgYjy6OHzhYhahMaUBoYuKqBA1E3oCYGfiQZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Of+hyJ/xkWVPoTAw4E5c+9LwcoXySYnNtrcHRAft/2hgXFmdqdXlJ/cutETjFaVmg+ze87W1rdxp+o25xZFPOkmBN0ZX4+y/Tda2bCM74rZd1blQrh1SmAEnYsbOsLx8potrdDBp463D5TDVBxn8c+BUa/yBTHNXjGsrqT6vRyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aq2a3Tjk; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso71940926d6.2
        for <linux-rdma@vger.kernel.org>; Mon, 20 Jan 2025 08:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1737391201; x=1737996001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lDNornUnHShtIGZIycaK8pbpoPcK8DfapEOMzhM2soo=;
        b=aq2a3Tjk9ohnc+ZSyNzgYgqKRM+XdurqFvMDNBX2R65jfx53SBZEv3ts5+zGkgOvjd
         6HV2OgbJwrHN8oGapOlDc+HWkC0RkCwArPxkIYxCpoCi01j10VWG9VKNQoWT3QL0uDUp
         cEijq9aGiUfygJL3YYtwWaVS7Xz3uUbQqPLs3ZNH6Fx6RL9FAOgqQJMYNzNgPbMyJxkO
         D8qroeuU7wEIOXsWI1geYJ2dcqMC+YFjs+9+yJmbwZI6JJfs+1mrkQ4sMC9XkJRHfwHh
         2vcQrR+4gM1WjP38eeq6Nx7/amF9FmJOQnt/xo6q7D5gdNBlkSrspdBKt8LRR0H62F+Q
         0WUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737391201; x=1737996001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDNornUnHShtIGZIycaK8pbpoPcK8DfapEOMzhM2soo=;
        b=PjE6tCyxWsmLUPdoYQUKjr7gwBMNyR6WRmD49cCOR9PE94/uYTggZqRJajL7fPYBaL
         WwaWXTNm5HCcAqO4O8aACUQx0AbfmamnEsPDt26QnF/YJ3qbdZDaeKxn7+GYn8Je9UIJ
         myKyOFmFwZHfTEOK4+33TceyReOYLGw2aySHvSOvt0pYfokQ5oYkPJDeIF6Uh7b2xvb6
         JSl+8G3gt+i4Po1EWdTIX9ot2acjh82+hybkrNdnH74pc98JEbLuwFDGK9pzOvzNH24X
         7vGGf0iWujzufbt5/NCxXImQO6VDLf4kfc0ZvH+LUXDF7XeZT0JCij24lOGEleiN1u5b
         93CA==
X-Forwarded-Encrypted: i=1; AJvYcCXaYIgvKys9gyXbHhQEMAWn0oxz665s70mJbQ5+iAPHSonzvo//GKJHiZ1Kv9STrSDXBIzALw2LIJYc@vger.kernel.org
X-Gm-Message-State: AOJu0YwwemGmmt8rUyUTM6iGI22/sk1hJax8AmA9YjC2G8lXLahFQJnv
	dCLS4KNgFANoLu141VlVIiZnM45zUv0yww6JkHS5VboSv7q6nJwimdi8261JIKg=
X-Gm-Gg: ASbGncvSF30yDhmS5b20QY6Mp/J2r1BMr+Bc1rHRErMSlJhX47itLqcveNbn6gMfk2M
	yA+udrmbNjJdZ0Gi3sgtevkzBB94lVMWLA94eAPqgsFqSRTgVyEGwqhdKLc4yGoQMSlWJofDj+y
	3oyf3agRnitqecseyeAda4VAEvIqg9yRTTOcwmGUl4+lI7Q2QUL5eKpGN9rkR2EMrE6wGJT/m2z
	r3RHVWqA424ZiaVLkYU9vO++uav4jAF6criWoTWJiT2ka+RbSlkL4GUf8nS1m9+MTNYR/Dc6Z24
	7kAeqHgiZdOUz5XH3HZdkx1m4Cj4nUTdR5jc4yxwgks=
X-Google-Smtp-Source: AGHT+IFqaVAozfFmDGPamm9D+FKfw5SJTDzMEEbwKwj4/H/hCgOFrHupydb7nFodhJe0DlZfuxHJDA==
X-Received: by 2002:a05:6214:3007:b0:6d8:9062:6616 with SMTP id 6a1803df08f44-6e1b216ef7dmr234997036d6.7.1737391201474;
        Mon, 20 Jan 2025 08:40:01 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afbf5e2dsm43033746d6.21.2025.01.20.08.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 08:40:01 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tZuoi-00000003UZV-209x;
	Mon, 20 Jan 2025 12:40:00 -0400
Date: Mon, 20 Jan 2025 12:40:00 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH for-next v2] RDMA/bnxt_re: Congestion control settings
 using debugfs hook
Message-ID: <20250120164000.GO674319@ziepe.ca>
References: <1737301535-6599-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1737301535-6599-1-git-send-email-selvin.xavier@broadcom.com>

On Sun, Jan 19, 2025 at 07:45:35AM -0800, Selvin Xavier wrote:
> Implements routines to set and get different settings  of
> the congestion control. This will enable the users to modify
> the settings according to their network.

Should something like this be in debugfs though?

bnxt_qplib_modify_cc() is just sending a firmware command, seems like
this should belong to fwctl?

Additionally there may be interest in some common way to control CC
for RDMA..

Jason

