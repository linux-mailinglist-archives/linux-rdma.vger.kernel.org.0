Return-Path: <linux-rdma+bounces-13875-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECB8BDFC08
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 18:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C843E3B90AC
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 16:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1245333A003;
	Wed, 15 Oct 2025 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WGWnwrxE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CEF324B1D
	for <linux-rdma@vger.kernel.org>; Wed, 15 Oct 2025 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546972; cv=none; b=H4ml8pFwDXEOHGxRYRxFQUkYrFMaC97lr4fR4bOZtVU7XHFQHftqTfy9N19e5XR3EouDPw+bGxw+TUVTaX+QtbxMhONVca8Gl7H+vKlHwdVwdsS80aFNUtFBLRQw4j4h9CwY+k16ttwAVTgpWLit5grICYrSSvA5jClf8gG0SlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546972; c=relaxed/simple;
	bh=TCZeHuv6Pjsy9fegpMdRUcS8sHFaN8cg5UnQkRiajwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HU5MOc0LQRSJsR6k3oOFc3n3t7Uu55YorZOpppXbGASBTSuCB8U+JrkojewQiguocsfrYv34+iD6cx4gJY5XNY+tC62rq/p4nMvk2oXhdY4FCUmMFK0bMOdKC5DKqYgDX0xmmLLs67VHD+6avXGDih/g4LAFNx+t9Dnn8kjjqxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WGWnwrxE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-271d1305ad7so106839675ad.2
        for <linux-rdma@vger.kernel.org>; Wed, 15 Oct 2025 09:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760546970; x=1761151770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TCZeHuv6Pjsy9fegpMdRUcS8sHFaN8cg5UnQkRiajwA=;
        b=WGWnwrxEMjYXIDDchjN0kiL4A12pYiz6ZFBOghvdQMr/jZaReaO9a40ooWJDU1aKNL
         DSHUTOgyo2Ggk1qf7B/JlMBELG9ljl0+iYoZSXJUnGwNeInJSSflW9QhBPT+kfeO3J9Y
         3ldba1VXO9lD5ACvfiwMYfKuFb7X/ifVVh8fl4c4kIRFcqXkP0EtZV0N/lS7lRUvG7s8
         mIPPdsLTsjfB+a1tRf0z3WAQuyJj2jz1Xtinr/w9RvlvqepXCMQiJn7/OJeNv7v4DQpX
         ByfZ8bdlp7lFoRGyBSOtTfeIcF73Fl8E/vMFPdmdyXOr9WNVJKKn8XzTcHypNO2CNtW1
         uSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760546970; x=1761151770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCZeHuv6Pjsy9fegpMdRUcS8sHFaN8cg5UnQkRiajwA=;
        b=mr42rjuvJQ6Ao454nqksoR/l8XWj8QYscEg6MKdmFzLcu2KWuN0Oqiv8dqEo/RsrHT
         BoQctBXF087ThpaUasAZOj1Go7RiUSzgriH03Sfjf6vq9NZcMxjk0+XfF8ZXnbyW0t48
         Bv5PWQgvN3rQ1NPZ/bi4D1OPm57wtJD2pjRxdZz9PNAk+L+ob9WjW4T2Nm8+ZUUlFKkR
         PNWQ+9oIq4m7+0cOn6vkHqHSAktG442hxchtE4tDWm44YdoL7WCc0Eh5CyxySPZ5urej
         cLtfvqN2drSrOTVrg1/hfg6p3AihfYkCjX1fSF5L4OOVCSc5laftI4r1q9MQJQPpx58h
         GPPg==
X-Forwarded-Encrypted: i=1; AJvYcCWeDWGVQBbzpLiiHc3G+X+OC5Oo7DhEYb0dH/Qwbd8BfYZO1ykmvb/e23F94FP3R/joJ/JQecdAmniL@vger.kernel.org
X-Gm-Message-State: AOJu0YzOprxFCn0pBDJh0HhMmHREzqsAO/4r+oGzzkSxX6Uo4FBTsnHl
	XWGfe6De0l1xpb4F08/KEAmTVN8CW1s920GjTQFxYydzN1o2dnEA8M5owko9Rm1Qq2HWk6iJ4nk
	NL+8z
X-Gm-Gg: ASbGncs1vte/I1g8bi4U38xtmytaueLXkaamZLY43gg3xsaZDSj09k4HM4yGXHPqMRD
	7uFWenrdO0ttH2jkIxvEmVGz9FoX51JuA421hhpmKpZMllkLyvbZbrvSYJpArwiCfMEqsEkdUxr
	JYK/3tOrzICTXBE4E6VsKPwHEk2QkkvNxwMpGub71hvRTj0jhOzfxvR2fZDkYVm7FgRIpSb8/9Z
	1LO57p0rg4/y2SPYeT8O5do8Rx+LAxmsQfLGCveGul/2P7jCakTD/XgE17WGpcQwhfPLPM4TBcY
	A27meqa69tVNKlmwKZ7jDmQJ0RrvEokbwgiRIXZL9y8mJ4BxGmv0vl7vrB200LffruZVmrJ1NJe
	Lf/4vTdTMLcOuDgo=
X-Google-Smtp-Source: AGHT+IGFHdp/Htwv0bzE8x/j+OgvneedlOjctqYdJUlPqsUPgdIFtAyyDYV0ITQapRii8sWEriy12w==
X-Received: by 2002:a17:902:d607:b0:269:8f2e:e38 with SMTP id d9443c01a7336-29027356528mr375808965ad.6.1760546970533;
        Wed, 15 Oct 2025 09:49:30 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099afdcc2sm1193335ad.115.2025.10.15.09.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 09:49:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v94gq-0000000HSF5-3X3l;
	Wed, 15 Oct 2025 13:49:28 -0300
Date: Wed, 15 Oct 2025 13:49:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Jacob Moroni <jmoroni@google.com>, Leon Romanovsky <leon@kernel.org>,
	Sean Hefty <shefty@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>,
	OFED mailing list <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error
 message
Message-ID: <20251015164928.GJ3938986@ziepe.ca>
References: <20250912100525.531102-1-haakon.bugge@oracle.com>
 <20250916141812.GP882933@ziepe.ca>
 <CAHYDg1Rd=meRaF=AJAXJ+5_hDaJckaZs7DJUtXAY_D2z_a6wsw@mail.gmail.com>
 <D2E28412-CC9F-497E-BF81-2DB4A8BC1C5E@oracle.com>
 <ABD64250-0CA0-4F4F-94D3-9AA4497E3518@oracle.com>
 <07DE3BC6-827E-4311-B68B-695074000CA3@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07DE3BC6-827E-4311-B68B-695074000CA3@oracle.com>

On Wed, Oct 15, 2025 at 11:38:10AM +0000, Haakon Bugge wrote:
> With this hack, running cmtime with 10.000 connections in loopback,
> the "cm_destroy_id_wait_timeout: cm_id=000000007ce44ace timed
> out. state 6 -> 0, refcnt=1" messages are indeed produced. Had to
> kill cmtime because it was hanging, and then it got defunct with the
> following stack:

Seems like a bug, it should not hang forever if a MAD is lost..

Jason

