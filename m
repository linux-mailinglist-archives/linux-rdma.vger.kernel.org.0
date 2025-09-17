Return-Path: <linux-rdma+bounces-13445-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376D6B7E621
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 14:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC0FD7B8EEF
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 12:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723942F260C;
	Wed, 17 Sep 2025 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TdAzRgxe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D81A306B1E
	for <linux-rdma@vger.kernel.org>; Wed, 17 Sep 2025 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113142; cv=none; b=XokB4v8EZS0LOmD73l7LMapwYuXsUvOK+vqhBoLMhzlTCCtMGrlli62TLu1lWzSpdComLrqsRHNBU/trBfIcH1JYnSpn4zEW2JI6bsAxSkNGMVCB7KrLwtK2/1IwIMD8LM90qakAefOFWyenBUMjKGJLd8Ruf7Fe0bGQMIK5Bmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113142; c=relaxed/simple;
	bh=YxDmg1jKrqps1XCrWcHf6Nph6TAAphbfQ3igJXNklEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+hXCvwDMu2sHXFwyBTpFjOwL8B47jm9YrIBkJkgX/QSTSJLo6tWXDKJcqtpG2Y/nW3hAKkLLQrwi4eEncDb0TB9HABxfSw1TdgygyvYKJFFsn6nFYY9li0if/9Tug7WSXOBK42goLUNjmjtBPfxKuZG5D2mEUfmriLJckX9HJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TdAzRgxe; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-80e2c527010so417300085a.1
        for <linux-rdma@vger.kernel.org>; Wed, 17 Sep 2025 05:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758113139; x=1758717939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0wH+ceGKGyNuHnW4Mzcl7LqGu5C+vYLka2lZQEuLsAE=;
        b=TdAzRgxeMZ+ueBN1lxaQyBZ5bSMDpj8X0AzUsCt/5WDBgP7eNMS3B6ZlEWjZCG+fUE
         u0PRpc77pH+zaLLYeuAE6/8PII91Zu9RWdPcx2WmLwXnF0Qpg+Ge+yGv9phq9moRF7k/
         rFalhkAC8bU/E8ukzo0KQ7ecCQ0jXgiHm4TYq50DCQ5DBQCxVZOeH9EdQy1RpWG4rA9O
         39GACPDDEyqXVFTU3GhHAkUXlMIQOeTDVuOmtQUz4RKuYwWYTlJyC/GvKJuI/4W+CJ4T
         X3F6vEoK391T1T6Gfi966J2Nl9R4romnVDwwsFmiSCkAXlBzaj2nh78CFlhzIiMvlbJD
         8GiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758113139; x=1758717939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wH+ceGKGyNuHnW4Mzcl7LqGu5C+vYLka2lZQEuLsAE=;
        b=mCR5+z3uDhMVOxS9qBTSm2NVNRBX/huLOM3h7XrxpNFho64VPxHhLawwlRzu1RJUCd
         xrSV+8MnU0NSJD3EOR0KlUjqXwBsNF45sVrYKPGzEDddu3FK/SYzLph4hLdo2fHGVipo
         YTMq1OTXX6q++XMR5+EQEsqJws/nwH60idqKIilVlj+5WF1n1aaJ3cHB5cYpsL1opMdy
         1K8tVSBmmh84wlBASNDnkfCKnPOpQ0b/JIMGT6p1/TunRRWA0IAF08YnxSY7c9dQ7n3p
         XfQj0+YH+sm/RPmb+ag50UODVw2KGXfI1EbC5ZvfISoEAICPO0civawYGE9G4iCsc3dd
         5yjw==
X-Forwarded-Encrypted: i=1; AJvYcCV8EpvXDmeHQaQvWT8iOdRbhWUfiD2VC9ynZ3XYn15XHhPszVkd70SNuM7PIe7BT/XOLBl5E5iIDOBM@vger.kernel.org
X-Gm-Message-State: AOJu0YzC8+t9yOyYs2N7DuO3IQcWzzaAkjIo03YsIknc/jbgsLjduM69
	yDeG1fIZrzMT20J8dIshvqNGW6bJ1YY1oKamglYJk4n8hQ5tg3bsidOZ72eTqEl7ozw=
X-Gm-Gg: ASbGncu9j4DSk2jBzmxWtknCPM8+N1amru1uADwIT7VRhq1Jlv/+meO7d4nHU32CgPJ
	n2LWChAlT09SQ2DCRK0UvOYOANsE+mH8/2kGIhwQP/mr5tXZbmzCILd7taA/mfqckWuiv5fN85E
	Z0hL78E20XFunl+eIVoXgvTVQSIMdMubigrfbr8QKNH8DKOGpNmnm/gDwjATi4ymlAvI+xO8Eaa
	DOXBgEZOqT/yC3u6vRm1psjJUGI6GiPIA4mA32c6TCsxx8QhOTmkABxmzDxKVtGYYM3H+IR9yAF
	bDt5cR9YxrOWN9y7PhldxtKnXmzxtF+8k+8FguE2UMldWt7B7dJyWxlXpL6dGlWTuYFgcx9njA8
	9gGx6K/Y=
X-Google-Smtp-Source: AGHT+IEZFd6Ciye9ajHh39C9NxMT19QjB09+jHNmDMrNjKMQ1BbOHVaOyXCny3oyij+bcEfEw4hy4g==
X-Received: by 2002:a05:620a:2683:b0:827:d83e:a64d with SMTP id af79cd13be357-8310912bd9cmr227559185a.27.1758113138910;
        Wed, 17 Sep 2025 05:45:38 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c8bb8f46sm1107416185a.10.2025.09.17.05.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:45:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyrXV-00000005jyn-30nQ;
	Wed, 17 Sep 2025 09:45:37 -0300
Date: Wed, 17 Sep 2025 09:45:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
Message-ID: <20250917124537.GB1326709@ziepe.ca>
References: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
 <20250514085421.GO22843@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514085421.GO22843@unreal>

On Wed, May 14, 2025 at 11:54:21AM +0300, Leon Romanovsky wrote:

> According to repro https://syzkaller.appspot.com/x/repro.syz?x=15a08cf4580000, we joined multicast group,
> but never left it. This is how we can get "ref=573".
> 
> write$RDMA_USER_CM_CMD_CREATE_ID(r1, &(0x7f00000001c0)={0x0, 0x18, 0xfa00, {0x3, &(0x7f0000000100)={<r2=>0xffffffffffffffff}, 0x13f, 0x4}}, 0x20)
> write$RDMA_USER_CM_CMD_BIND_IP(r1, &(0x7f0000000180)={0x2, 0x28, 0xfa00, {0x0, {0xa, 0x4e25, 0x10001, @local, 0xb}, r2}}, 0x30)
> write$RDMA_USER_CM_CMD_JOIN_MCAST(r1, &(0x7f0000000900)={0x16, 0x98, 0xfa00, {0x0, 0x5, r2, 0x10, 0x1, @in={0x2, 0x4e23, @loopback}}}, 0xa0)

This should be fine, it is supposed to get cleaned up.

I think it is more likely there is a refcount leak on an error path..

Jason

