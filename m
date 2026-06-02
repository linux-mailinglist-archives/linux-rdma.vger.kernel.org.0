Return-Path: <linux-rdma+bounces-21622-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OJnjCZXOHmpnVQAAu9opvQ
	(envelope-from <linux-rdma+bounces-21622-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 14:37:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F2662E14E
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 14:37:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=Mjg0KMTz;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21622-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21622-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F7233076B24
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 12:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF9F37FF4E;
	Tue,  2 Jun 2026 12:33:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DE530C637
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2026 12:33:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403629; cv=none; b=WIjVRaYkvv06cnCNfIOtGW90mTPiyG4SO+rU8UHQRpjpsYOvOEBOYVbggiWXJQNMWgXuefFyA9R5NRLyjRdXzIl0mIOsVbQA4exazKyS3zXRyyDbk9BF53/vCl0SBugU/4YHMlj/phcx3EZDrgXZjwJ0ub7JDfvWe1kanJN7YkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403629; c=relaxed/simple;
	bh=Dt7ynl7RjMDm10IwkFbV7yaqQ3XCHkv1Jhl7dMLZbl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WH4MJl8VhXz7pY4lZZVcsfzjkEetCUmdElbsBDhgLjvoV15Xk7aEQ3OxUwlEzSqDc5PGDNpfSm+1xrnyKCHmDDgdJVraCaPosWgB2a30XfPpIlPrZQSi7MJRHvHCsLcHypyIbzTWAll1bikWOdX74qmgsF8wNii0uZmZDCljzfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Mjg0KMTz; arc=none smtp.client-ip=209.85.160.174
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5176465a4a4so13345911cf.2
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jun 2026 05:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780403626; x=1781008426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fuMy8ZTlB4sZmM4SRNfS45Rtpr0e2y/Uhs3uZMD108=;
        b=Mjg0KMTzNzeCi7FV4Cglipctnd4qTRNJBs44FcFTysdYrVy+WlGmP/0GDFu0J+wJ7m
         R/AuPEohevy1QNUE+WUDGubmJcDZZnffsV7i/Zze94JkqRPhbPdy15Qk6yh0s9q2hu1/
         bI7dm1G26H7om23e5xJModDeVrIOi0meO3NUWse+J5lk5WegiPpkj76Qz79IXx4wghAH
         J1I3OvFvwHvZLYWvaUMDTJFwu8CeiZpFpTAa6VbXuL1p2SxsoyL2H/fX/865+UB4pvvq
         PhJR1KIiS2V1O2Xw5dcvwmRIXL5LbfWF9nRanp+5gjV4eMn6+GEiDs6cHaCPjs+09FpH
         tsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780403626; x=1781008426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fuMy8ZTlB4sZmM4SRNfS45Rtpr0e2y/Uhs3uZMD108=;
        b=pSLT19pdEhQmth3bsbYoj/IYIBgu7VQml5POofNYs6Bl/z6gzo/owufHR7pIgdCYVG
         E4Ntij14uvSoUKuxXkAa3cdAXqE1SqsqlG2ohF8/xkiK0dIg6iaHJbrmIKX11bT9vpCi
         8CdafVQrRd4oQKzAfw/84JUZnZ5f+kzhMPNW9r+cfIo1d6ri68YvMHj0CogeCKUGb1bl
         l1A5HZ18kPyYJsndCpAvUF6rVCod4sjV8oB40clwbVjLMsEiPo29o0S4Ua7ByKz2rG0i
         dmqvoEVLp3I/Rf/16Yq2Bd3W822apXxgyRIGseHcN5ls/VJUH4DpK9pxyk7Lp/Zq+tje
         dLYA==
X-Forwarded-Encrypted: i=1; AFNElJ/mlcMGGH2xms21HTkIwGZGXK/4q2gFIJfAWslEN5/L/5kWhoWH0GsQPxQDA9E4b7JJVBnA1ES0Avzz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw66jSEOAUAvEbk7dGPWzol044joEQJheZ9B5DcFeX/1FdWgrUB
	GzCIXKnmjaB4pG8bSWPgsIzENP50kO4FwwqlfqwYUSrtGSgfKBMQX6NP16xV78paMMU=
X-Gm-Gg: Acq92OE7ICe9rIFErbksCkvw/bC/q7V5Lmh8N4sndaepcJUS7jGm2QMLdeKR0y7cIEF
	eE7ZX6E/voxuJOhrxLLvv5nuiil+wkpNpnyxSBg7s1/2BeF3Hv1cp3nTfh8I+UrjobdSCxK83O2
	Y2jszR8rl68B+Ax61bZ0Gr6ysc8pYK9QLa+wceJRfxfb/tdeQM2tfV7YQ1zmtOT47ibU9UU88NY
	ZKBdukph+4OCvOvyc+hZYrDuUgtD8j7hE9oP9ULMViFCHVma3IwVJjnOW4xo/cZv3BjVBvLJQzp
	qFQg3yvuqzb6aMCXT7lJghnlYyoJANGgg4xDvSmRxdigg5LjyGDKl8HQqe7KlEoqOxtlQxxsCys
	Chtv1UvqBolskQDPc/6v6bfr4Owpixi6P5B8TMkyC7ZmAnmH/AWmLm+cBkQzS+tMs2RNOQDPgPC
	aufb6HgVVy80Z+CWilqYOz3ulyYSQAcqbOoGnHEydRBaQ18GUl2OlVLDenc/w9aR3tYNbhzFkyJ
	6/Lu/Nd2O9+VARv
X-Received: by 2002:a05:622a:190a:b0:509:2527:d789 with SMTP id d75a77b69052e-5173a5c05ecmr228232631cf.6.1780403625864;
        Tue, 02 Jun 2026 05:33:45 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741d6a240sm78686221cf.18.2026.06.02.05.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 05:33:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUOJU-00000003m5x-3DKO;
	Tue, 02 Jun 2026 09:33:44 -0300
Date: Tue, 2 Jun 2026 09:33:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>, stable@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>,
	Gabriel Somlo <somlo@cmu.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Bart Van Assche <bvanassche@acm.org>,
	Leon Romanovsky <leon@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org, linux-acpi@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net, qemu-devel@nongnu.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 01/11] params: bound array element output to the caller's
 page buffer
Message-ID: <20260602123344.GG2487554@ziepe.ca>
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-1-kees@kernel.org>
 <ah699hwLxIIOZ0-7@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah699hwLxIIOZ0-7@ashevche-desk.local>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21622-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,iscas.ac.cn,vger.kernel.org,suse.com,nod.at,cambridgegreys.com,sipsolutions.net,minyard.net,cmu.edu,redhat.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,acm.org,ideasonboard.com,google.com,suse.de,hansenpartnership.com,oracle.com,arm.com,linuxfoundation.org,rowland.harvard.edu,linux.alibaba.com,akamai.com,antgroup.com,orcam.me.uk,infradead.org,linux.ibm.com,alien8.de,zytor.com,atomlin.com,linux-foundation.org,canonical.com,paul-moore.com,namei.org,hallyn.com,googlegroups.com,kvack.org,lists.ubuntu.com,lists.infradead.org,lists.sourceforge.net,nongnu.org,lists.freedesktop.org,lists.ozlabs.org,lists.one-eyed-alien.net,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@linux.intel.com,m:kees@kernel.org,m:mcgrof@kernel.org,m:pengpeng@iscas.ac.cn,m:stable@vger.kernel.org,m:petr.pavlu@suse.com,m:richard@nod.at,m:anton.ivanov@cambridgegreys.com,m:johannes@sipsolutions.net,m:rafael@kernel.org,m:lenb@kernel.org,m:corey@minyard.net,m:somlo@cmu.edu,m:mst@redhat.com,m:jani.nikula@linux.intel.com,m:joonas.lahtinen@linux.intel.com,m:rodrigo.vivi@intel.com,m:tursulin@ursulin.net,m:airlied@gmail.com,m:simona@ffwll.ch,m:bvanassche@acm.org,m:leon@kernel.org,m:laurent.pinchart@ideasonboard.com,m:hansg@kernel.org,m:mchehab@kernel.org,m:bhelgaas@google.com,m:hare@suse.de,m:James.Bottomley@hansenpartnership.com,m:martin.petersen@oracle.com,m:daniel.lezcano@kernel.org,m:rui.zhang@intel.com,m:lukasz.luba@arm.com,m:gregkh@linuxfoundation.org,m:jirislaby@kernel.org,m:stern@rowland.harvard.edu,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:jbaron@akamai.com,m:jim.cromie@gmail.com,m:tiwei.btw@antgroup
 .com,m:benjamin.berg@intel.com,m:ilpo.jarvinen@linux.intel.com,m:david.e.box@linux.intel.com,m:macro@orcam.me.uk,m:srinivas.pandruvada@linux.intel.com,m:peterz@infradead.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:seanjc@google.com,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:atomlin@atomlin.com,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:akpm@linux-foundation.org,m:john.johansen@canonical.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:georgia.garcia@canonical.com,m:kvm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-modules@vger.kernel.org,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:apparmor@lists.ubuntu.com,m:linux-security-module@vger.kernel.org,m:linux-um@lists.infradead.org,m:linux-acpi@vger.kernel.org,m:openipmi-developer@lists.sourceforge.net,m:
 qemu-devel@nongnu.org,m:intel-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-rdma@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-serial@vger.kernel.org,m:linux-usb@vger.kernel.org,m:usb-storage@lists.one-eyed-alien.net,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-arch@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-hardening@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[99];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,ziepe.ca:mid,ziepe.ca:from_mime,ziepe.ca:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62F2662E14E

On Tue, Jun 02, 2026 at 02:26:46PM +0300, Andy Shevchenko wrote:
> On Thu, May 21, 2026 at 06:33:14AM -0700, Kees Cook wrote:
> > 
> > param_array_get() appends each element's string representation into the
> > shared sysfs page buffer by passing buffer + off to the element getter.
> > 
> > That works for getters that only write a small bounded string, but
> > param_get_charp() and similar helpers format against PAGE_SIZE from the
> > pointer they receive. Once off is non-zero, an element getter can
> > therefore write past the end of the original sysfs page buffer.
> > 
> > Collect each element into a temporary PAGE_SIZE buffer first and then
> > copy only the remaining space into the caller's page buffer.
> 
> ...
> 
> > +	elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> 
> get_free_page() (or how it is called)?

I thought modern mm guidance was to use kmalloc whenever possible and
not use get_free_page() unless you intend to use the struct page bits?

Jason

