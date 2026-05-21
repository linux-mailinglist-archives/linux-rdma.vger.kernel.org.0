Return-Path: <linux-rdma+bounces-21123-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELh9N7ETD2qOFAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21123-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 16:16:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5EA5A706B
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 16:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0649732B874E
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEDC3E9C06;
	Thu, 21 May 2026 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apmH1Wyg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D143E1D01
	for <linux-rdma@vger.kernel.org>; Thu, 21 May 2026 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371110; cv=none; b=Jd7RDreT0ci5IGtybQL+Rv/1K6rmbyJgiR5Ovkt6lHL64JBgk64n+WDjS+TxDlY8b2DJOHecXKq2qFOkmC47sX9OJd920yYX1tc2yPHZ4Nb3NQwtJcrzWmuc55S4BAmseyGeAjYFlvHtS5ZcTlceW2HQT1Rz70E2rTt2MGIoags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371110; c=relaxed/simple;
	bh=JmKBkku/kD8/n/a4gtEJvwwFH5TVoQOZ+eRQ7DUmO1k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V1ZBBqb4NBKerumrWovGMiLunVOojhY0JDfsw7ILjlwRwGiUab37oP6cnEEMxa89V9PZC2FZJJntGmfhSFxX3oSGOuMipaS/EavoFIsQbHSvS62kfuXIKNLaPAn+qy3uZAn26tdEP8ETJkA7O1X/g7KG8bHw8Bm67fXqbPoDphs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=apmH1Wyg; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c829586e894so3199301a12.2
        for <linux-rdma@vger.kernel.org>; Thu, 21 May 2026 06:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779371106; x=1779975906; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dnh9Qdh/Ek2SFmUD3YQQhAJ1lm8lFb5yTi3rkZyIV7s=;
        b=apmH1WyggEos+GYDtmCU6UwvksL1feePBYzSOJ5L95TUjl2IgzIkjsOrlBLhWHn0iK
         0z2UmkKdCTPjIUcJve/SIkIWmc7pd+VdH0jdGlEuQDhSfgRzBXMZl5NMdSsh1g9HmTxu
         nFvuyqPWF9Ya78KJOvIt2VrnPlMzsG2nOuDKsE21diyTstnyCAiW+s5tm7w9z/oIw5DU
         VCZclbGcsvk/fXeq5y9QTq6c+JWo5LZk3+btZNdmusOZU9KeC1tu04gbqiYdj54MBYG+
         ONoLJtIbthd7xCi1A05VbpcJvT4SAp3a2C4Vrib6lmo3pyVIldCWzX9paUqSZahU68s+
         Mnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371106; x=1779975906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dnh9Qdh/Ek2SFmUD3YQQhAJ1lm8lFb5yTi3rkZyIV7s=;
        b=K1kJrEPAyOXYa7vMYPJn+bD+RXjgrP5e2hROUd2WCY4E1YVtdYLPROiQDw8TG4HABJ
         2pqmzYruLTx7n+XYuiUJUF6OdQhiL3CnMXbEpEfD5jO54IrXZ4Xtmi4sdMAIjezGQrH4
         aM9y81GjTvflSwrRMJidnn+BVDJ6deBJSImR3XppI515kZlJjz09mqgIRQQjnr80SRd2
         X1b6Q8HT2i+WTpfzTInp4NrmMoQ/kToY3QfL2AbVyoaEHdVnQW0exFWrA9I9m3nDmMMK
         vIwfo3yvZuHL8kPg5+PGe9WU61gZbohRTm+SUviDzodn8YtkAkZ/b4Mcv0aI10YeqInQ
         5XYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9pdLY8EetaYBMXdbIJUvSx6EFi79wEIyZlBQf/LjUCJ4VlsHbGBmxJUZ6eEwwa3xEAjxb2f/vg4ov4@vger.kernel.org
X-Gm-Message-State: AOJu0YzoXBBG5giCsRAXwq05Ub7WjDM+9lVyJK0RMUnApievE0P6cMDb
	ddopX7aaUS2ZvqRsih8NXbsuIEzy7XnyDn+B3olS3gDeDtuGSb5UP8Kfuz6R05sLbXS6NGKBvrd
	k1LuzoQ==
X-Received: from pgvm13.prod.google.com ([2002:a65:62cd:0:b0:c85:1159:ffbd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7491:b0:3a0:bc61:62e5
 with SMTP id adf61e73a8af0-3b30883a17bmr3700528637.44.1779371104725; Thu, 21
 May 2026 06:45:04 -0700 (PDT)
Date: Thu, 21 May 2026 06:45:04 -0700
In-Reply-To: <20260521133326.2465264-9-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521133315.work.845-kees@kernel.org> <20260521133326.2465264-9-kees@kernel.org>
Message-ID: <ag8MYC6pOZvvYHMp@google.com>
Subject: Re: [PATCH 09/11] treewide: Convert custom kernel_param_ops .get
 callbacks to seq_buf via cocci
From: Sean Christopherson <seanjc@google.com>
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>, 
	Petr Pavlu <petr.pavlu@suse.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>, 
	Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Eugenio =?utf-8?B?UMOpcmV6?=" <eperezma@redhat.com>, Jason Baron <jbaron@akamai.com>, 
	Jim Cromie <jim.cromie@gmail.com>, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>, 
	"Ilpo =?utf-8?B?SsOkcnZpbmVu?=" <ilpo.jarvinen@linux.intel.com>, 
	"David E. Box" <david.e.box@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
	qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iscas.ac.cn,suse.com,nod.at,cambridgegreys.com,sipsolutions.net,minyard.net,cmu.edu,redhat.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,acm.org,ziepe.ca,ideasonboard.com,google.com,suse.de,hansenpartnership.com,oracle.com,arm.com,linuxfoundation.org,rowland.harvard.edu,linux.alibaba.com,akamai.com,antgroup.com,orcam.me.uk,infradead.org,linux.ibm.com,alien8.de,zytor.com,atomlin.com,linux-foundation.org,canonical.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,googlegroups.com,kvack.org,lists.ubuntu.com,lists.infradead.org,lists.sourceforge.net,nongnu.org,lists.freedesktop.org,lists.ozlabs.org,lists.one-eyed-alien.net,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-21123-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[98];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7C5EA5A706B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026, Kees Cook wrote:
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 07f4c7209ac0..00317774a90b 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -368,12 +368,16 @@ static int vmentry_l1d_flush_set(const char *s, const struct kernel_param *kp)
>  	return ret;
>  }
>  
> -static int vmentry_l1d_flush_get(char *s, const struct kernel_param *kp)
> +static int vmentry_l1d_flush_get(struct seq_buf *s,
> +				 const struct kernel_param *kp)
>  {
> -	if (WARN_ON_ONCE(l1tf_vmx_mitigation >= ARRAY_SIZE(vmentry_l1d_param)))
> -		return sysfs_emit(s, "???\n");
> +	if (WARN_ON_ONCE(l1tf_vmx_mitigation >= ARRAY_SIZE(vmentry_l1d_param))) {
> +		seq_buf_printf(s, "???\n");
> +		return 0;
> +	}
>  
> -	return sysfs_emit(s, "%s\n", vmentry_l1d_param[l1tf_vmx_mitigation].option);
> +	seq_buf_printf(s, "%s\n", vmentry_l1d_param[l1tf_vmx_mitigation].option);
> +	return 0;

For this one, can you manually change it to this?

	if (WARN_ON_ONCE(l1tf_vmx_mitigation >= ARRAY_SIZE(vmentry_l1d_param)))
		seq_buf_printf(s, "???\n");
	else
		seq_buf_printf(s, "%s\n", vmentry_l1d_param[l1tf_vmx_mitigation].option);
	return 0;

>  }
>  
>  /*
> @@ -459,9 +463,11 @@ static int vmentry_l1d_flush_set(const char *s, const struct kernel_param *kp)
>  	pr_warn_once("Kernel compiled without mitigations, ignoring vmentry_l1d_flush\n");
>  	return 0;
>  }
> -static int vmentry_l1d_flush_get(char *s, const struct kernel_param *kp)
> +static int vmentry_l1d_flush_get(struct seq_buf *s,
> +				 const struct kernel_param *kp)
>  {
> -	return sysfs_emit(s, "never\n");
> +	seq_buf_printf(s, "never\n");
> +	return 0;
>  }
>  #endif

