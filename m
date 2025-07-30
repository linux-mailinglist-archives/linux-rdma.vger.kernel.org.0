Return-Path: <linux-rdma+bounces-12549-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A34B16674
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jul 2025 20:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F961AA8165
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jul 2025 18:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214D82E11A5;
	Wed, 30 Jul 2025 18:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aQl4E173"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A915F2BCFB
	for <linux-rdma@vger.kernel.org>; Wed, 30 Jul 2025 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753900964; cv=none; b=FRJwCoMToHqX90GsfDFSLig9H7Kgp3oLRl7prl9L8oJu/heSOjfIJCi+5xB5qMT8kecUmEhi6mtmXsfbjmxLOAfxPgMxahRRuw1GcbpqetRclgrq9q62fkPu1v2AVMY3vRiVwzcIlwOS3EvUVG7IEuWPcurt+eimmY5aRhJUaKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753900964; c=relaxed/simple;
	bh=Yo2DQQIGPajUqfGHx5XY0tjMbqxTiqf501AHB+aiPrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgRzrxAfu9svh5Pl3je6e+QOcCROSpfQn33Evu8aXyzTB8Nnun4+YYPwx6u7nczqSLI87jLcQrl6rt4Z4SW/WpYFt0MKzYgQ4oVLT3dOrvWCC3/5ecVTkp8QMQjR0CAv4/1KCJOM8Zl3m6c8Ysu0NUS3gWpWAnwN3fVX5QRw9QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aQl4E173; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6153a19dddfso112920a12.1
        for <linux-rdma@vger.kernel.org>; Wed, 30 Jul 2025 11:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753900961; x=1754505761; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e/8KJCdai8KrtDfwinWM/LaJFRv4FrevPGL+R/XtgR8=;
        b=aQl4E173o69/fvoaSViC0iecaik7BhQKZeFwBPW9QK8P7ejw4cKa0hYhy+o7K1860a
         ECy+HeIY50klDBxnad+v5EEesE4T4hzibmpPl63HninudCAechnZujjoBfb/z5WdfOqg
         JFVfvso9Cr8okWVD2W8irx6nuaU0FARYT+Osk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753900961; x=1754505761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/8KJCdai8KrtDfwinWM/LaJFRv4FrevPGL+R/XtgR8=;
        b=cS+JwWQhwuswBq72+K27ybYMzEVGb1QX5Ih7y+U5eo1b7UPZtTGEqtS1nExlpNlnjM
         lOHwH2tHehbY1E6yn/nO+1T30UCNwN8QhT0h3+ZFRC3Qv1mpSsl6Xk07JHajw9uao7GZ
         sx+esd/VV93vPg3gMs8DiQTYZ7PWbx1qhViQLi+js2fnJJwFvB7ypCgC0NVIqkKTb6Zo
         XfqPDDRRPWFnAWfUBoetovtnxPTf2vcjglIYv2KtShv91rsS3ixTlevfsydvTVAVfLEP
         HGNbrqHesdueyXKirzKRswOl7d7ciKG7UyInhFv5ndM+s2n70J0Pbn05auISzZHr1rbj
         m7AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSQq2rfjjRCop1t6Hb5Kuo/HwZtaH9QHsNEq9Y0lKq3GAPHgFSm74A2vvedKdYl38aLmUeRMF5Orod@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Rb+Bmw+M4erdeIz8wVJ0Z2VxgdOIxhWOPa8PIBtQCuKXDIm0
	+todvjU4gDy8VpEkk0qPKDUe08RmEEg0GTAjAB/oZedoikcXzwKiB2BTCmoNcZ+NZTt8MH7bDfR
	fDdSWkoo=
X-Gm-Gg: ASbGncvKO6kOGAe22vL3AA11tKjbti14xfXdJosZHZLRWhP2IWEwDNF6Nk567YW0grk
	CUjng1cQ3FkwsaqNyTfLC4XtTQPdImej+tcmNRyvzuGe5010RBsSnAnJJo/2F1XHHRdWWzNpiUa
	YbwsX2QrkhdHNOxpCwl2Dvo3YrV2OBEMpmSisb0y/87HmbV35xXb4nRWJY/lDdrwleMT5bBDitB
	CVCoVK/9vgwn3kUrZB7V9+x8JwAq8IsEv5BAZcVTVMDWpH3XK3LTkjVICBDtA0KKbSlJFSHOXF3
	ArdFKzKlPD/AcorFGQdS5k8vuLamhoymLlJigiDQIFpotOLkgISycP3NF3G6RBlyoo5w3etWeob
	oUn0KELNETQyhGkue9Uie7/QO4rmNgLnaVp3BGIMC6qsWEEoQ4VML9JOPXGsdoIAdWanq0wUMmb
	ur5eMJDL0=
X-Google-Smtp-Source: AGHT+IEswjS+hCk5ZKFl+E+KJPIY6zFV+fybHETXvZ/p4ZNrnm77jqbiFgrTx8lm0Kfu8rpV9KN3fA==
X-Received: by 2002:a17:906:6a26:b0:ae3:b22c:2ee8 with SMTP id a640c23a62f3a-af8fd96fac2mr484439266b.37.1753900960726;
        Wed, 30 Jul 2025 11:42:40 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af6358600b1sm787628466b.7.2025.07.30.11.42.38
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 11:42:38 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso114934a12.2
        for <linux-rdma@vger.kernel.org>; Wed, 30 Jul 2025 11:42:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUM5FUHqpupDGGCrQRQh3z6GQaO3ka2XnulCqe7ALQ8ihOP4zLM2+fKNHD90LJsT5zEVzD+SKrFsick@vger.kernel.org
X-Received: by 2002:a50:8745:0:b0:607:5987:5b90 with SMTP id
 4fb4d7f45d1cf-61586f12581mr2997178a12.11.1753900958279; Wed, 30 Jul 2025
 11:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <450d3876-90a9-4b1c-8d73-62ac19048991@suse.cz>
In-Reply-To: <450d3876-90a9-4b1c-8d73-62ac19048991@suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 11:42:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg70=mihHE3_Te=t1Fmvrh22bcEs8bvH3tDEXZd6q+4_g@mail.gmail.com>
X-Gm-Features: Ac12FXyIEgB8PrPgd0exea9RuFqBlTLaxSkR6vauSlGJKXBn_YJf0vKGTRlMTV0
Message-ID: <CAHk-=wg70=mihHE3_Te=t1Fmvrh22bcEs8bvH3tDEXZd6q+4_g@mail.gmail.com>
Subject: Re: [GIT PULL] slab updates for 6.17
To: Vlastimil Babka <vbabka@suse.cz>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Harry Yoo <harry.yoo@oracle.com>, 
	David Rientjes <rientjes@google.com>, Christoph Lameter <cl@gentwo.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Pedro Falcato <pfalcato@suse.de>, Bernard Metzler <bernard.metzler@linux.dev>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Jul 2025 at 09:56, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> We've hit a last-minute snag last week when lkp reported [1] the commit
> "mm, slab: use frozen pages for large kmalloc" exposed a pre-existing bug
> in siw_tcp_sendpages(). Pedro has been fixing it [2] so hopefully that will
> result in a PR soon, which you can pull before this one - or perhaps take
> the fix directly. If that gets stuck for some reason and taking the fix
> later would be unacceptable, I can do another PR with my commit taken out.
>
> [1] https://lore.kernel.org/all/202507220801.50a7210-lkp@intel.com/
> [2] https://lore.kernel.org/all/20250723104123.190518-1-pfalcato@suse.de/

Thanks for the heads up.

I've pulled this, although I don't see the rdma fix in the rdma tree
(the pull for which is still pending in my inbox - I've merged a big
chunk already, people have been very good about sending their pulls
early - thanks)

Let's hope that gets handled soonish - but I'm adding Jason explicitly
to the cc just so that he sees this.

I'll take the fix directly in the worst case, but prefer for things to
go through the normal subsystem maintainer if at all possible, and
this one seems fairly straightforward.

             Linus

