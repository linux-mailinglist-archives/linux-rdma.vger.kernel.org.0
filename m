Return-Path: <linux-rdma+bounces-21248-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOPNN5+CFGqnNwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21248-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 19:10:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 892425CD323
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 19:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 279233028ED7
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 17:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E923D3F86F9;
	Mon, 25 May 2026 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GQr1PYm1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F603F58C1
	for <linux-rdma@vger.kernel.org>; Mon, 25 May 2026 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729011; cv=none; b=qmLe/2+PqR02EQaja4yOOaO/R2Wm4PNsJyURnSXpVVCzei52iLjmvBJH3ywuV/itH02YBUzaP1X57dNTC6f4kWUs02Bj2yKYwwq7yF/OvdO2bC4oaejPefCpqLAMF9jIQUQ/+4ijQe/PIc1F25VuQz8sT21UmyWzmLjWH0vgxJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729011; c=relaxed/simple;
	bh=PTNg3RyBjtWL4NnI8O0q7hXUoY8uPF4RaVnZMbEInR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K473DSweVzCAiFdlBfVDXebvFZvizbvnINNoIIbOitJp+qY9GlUx0n96Z2Aq1+/tMTnH63dwJKb80Hk2VrSiDaKIYOk8hJrFQBdM0g7dJwac8uARA72FwYAOldVwbiA7jYeTydpfn75/Y/ytdzlcrVQNyVypQJDECGACF3mFGm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GQr1PYm1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso41525885e9.0
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2026 10:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779729007; x=1780333807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=izugkSqOYsBmSyQ8jfD9m1SVj73YG14U78pRBc6Lai0=;
        b=GQr1PYm1QRIrfgBC/EILAtR9O17tFRT933ldDJCayUjXIyRMiDnumrFP9i4iPLQuP/
         bWYj6u/50hd5AlTl8fnNFXZxscNWQsfvT08lWT2g7USA76CFTeDeB9CAGnGBLt+Jk5Kd
         lX3x9dDR55Y2wg8pVl8cBGmVyZoFj8APvHLhilXEkRN6z7J5HsqQkRDuiJpcpmZ76bBE
         nunnNO0efpqrh3Mg+srvekhGI13bTspzjyxHMZeoT7BQvRd6lyijtBc2rfmKjAaENr6C
         i+8SY1MRgNki/ClY1lWgGG4FXSsH+ZhGYZ0VK7FSfIVhFbKqAWGdmu0VyhcviooSpQ7X
         9jYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779729007; x=1780333807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izugkSqOYsBmSyQ8jfD9m1SVj73YG14U78pRBc6Lai0=;
        b=g7rxWQn4THGm8+DKl3IMVLL4oqAdIm7uVcInO8nVDLDhOoM/TxXXgcvRT/QchDGG1c
         /U3COawu/9OSVMCWs2EiSap96M+jB4noEATvL/I7HmqflJKJAtz33/FO8848D4oUOZbL
         G5LUXNTUZQqLXeStgpXcgTU7tgf/xz6f+InD4KZS2QMS2BPxK/t8jMRMsNBnYeAl7Hp0
         bk2tAI4pBaT4lPonHVqUIkNps+jRkyQW2UyLdQ/LPMVLXznAunGB25jeFow/5uluffM4
         ORo3V1dR/FdWN1ZsPCmx5ULkexkMEKJfnUi9xJvFXyIxfuhz/BSlIneeaikJDkJidP0T
         75BA==
X-Forwarded-Encrypted: i=1; AFNElJ85OwnS8rAb+R+RQOYZzeOeLL5VEGp+DNH2W0UAaXTw+wB5HLGNVE82GVdyMRj+RwaOYxH37K5nPrIb@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzb4X7cgOUlyOniy7HDywGo2Ndu2pYHh5F63les9MhL8IJQ3Vx
	E7bQNOt+43mCPJKNLd5/qsyv2eymu36rgiEZV699mZ6ISGYJjH2H2ES/poYuDh0QvBQ=
X-Gm-Gg: Acq92OHrbA0kgHApw2QGbS80vmg6IozVXPAK6n8PNhqlkiIuhsGM37Ol6Cof6JphXvV
	XFTAQMQQwmkiAzozxjvh0GWK+lMRn73HpTDH67ldDDs7bbsnafnEM/C+lV9gukKuRrWyVhJ4lmt
	yUSrGCsyfhSBDC42uvYy8UAwRaeNZ4BdVPwdjQWtUVyAu5D0aD4WubNUIhgCg/ARoQ0GGQrWHzc
	NwqfL4DNhGuQYbn2STBAZQA8KjYV3cckQ6RWB1vhXcwzr/uTgiEvHcImaNbAdjBFsiK1xSvq6gP
	E0ffmRXMFpO8fx6dRLh9EJAV/lFqRNdSZ3TYOz48MW8ZMT4a0FlSrPEKsludpTdOc4g0c3vTL+c
	pUNeFrUn0SubaEUPVqY32Q2RpLXtjPfuP9yV7O1v3Is7BQRM4kTiKyJ2POdV0Cntf5bTPZtjaJb
	pfDl+9XXzvf+Fib0OEsR81x0RCk2vX+biPkR34LREMexEMaB5/L37TKdGEYRaUo+1H086bUjovh
	v4lFH1/oRGDvyrqkaroRy+cG4Cav3y1lKTFI91WbCOmgdnaAT60ykNKo5ct4BZHUWSwSrk+zai5
	3bVxkPWCLdNs3u8=
X-Received: by 2002:a05:600c:35cf:b0:490:44eb:c1e5 with SMTP id 5b1f17b1804b1-49044ebc257mr277307095e9.31.1779729006482;
        Mon, 25 May 2026 10:10:06 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904526c926sm456877405e9.1.2026.05.25.10.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 10:10:06 -0700 (PDT)
Message-ID: <a192eb5c-5d16-483d-862e-d937fa1b8269@suse.com>
Date: Mon, 25 May 2026 19:10:03 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] params: Convert generic kernel_param_ops .get
 helpers to seq_buf
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Corey Minyard <corey@minyard.net>, Gabriel Somlo <somlo@cmu.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Hannes Reinecke <hare@suse.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
 Tiwei Bie <tiwei.btw@antgroup.com>, Benjamin Berg <benjamin.berg@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
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
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-8-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260521133326.2465264-8-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iscas.ac.cn,nod.at,cambridgegreys.com,sipsolutions.net,minyard.net,cmu.edu,redhat.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,acm.org,ziepe.ca,ideasonboard.com,google.com,suse.de,HansenPartnership.com,oracle.com,arm.com,linuxfoundation.org,rowland.harvard.edu,linux.alibaba.com,akamai.com,antgroup.com,orcam.me.uk,infradead.org,linux.ibm.com,alien8.de,zytor.com,atomlin.com,linux-foundation.org,canonical.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,googlegroups.com,kvack.org,lists.ubuntu.com,lists.infradead.org,lists.sourceforge.net,nongnu.org,lists.freedesktop.org,lists.ozlabs.org,lists.one-eyed-alien.net,lists.linux.dev];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21248-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[98];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 892425CD323
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/21/26 3:33 PM, Kees Cook wrote:
> Convert the generic struct kernel_param_ops .get helpers in
> kernel/params.c directly to the seq_buf signature, drop their legacy
> "char *" form, and refresh prototypes in <linux/moduleparam.h>:
> 
>   param_get_byte/short/ushort/int/uint/long/ulong/ullong/hexint
>   param_get_charp/bool/invbool/string
>   param_array_get
> 
> The STANDARD_PARAM_DEF() macro expands to a seq_buf body for every
> numeric helper. param_array_get() now writes element output directly
> into the parent seq_buf when the element ops provide .get; it only
> allocates the per-call PAGE_SIZE bounce buffer when the element ops
> still use the legacy .get_str path. The common "rewrite the prior
> element's trailing newline as a comma" step lives outside both
> branches so the two paths share it.
> 
> The non-core changes in this commit (arch/x86/kvm, mm/kfence,
> drivers/dma/dmatest, security/apparmor) are the small set of callers that
> directly invoke one of the converted generic helpers from their own .get
> callback (e.g. an apparmor wrapper that adds a capability check and then
> delegates to param_get_bool()). Because the helpers' signature changes
> here, these wrappers must move in lockstep. Each of them is updated
> to take "struct seq_buf *" and pass it through; param_get_debug() in
> apparmor also pulls aa_print_debug_params() (and its val_mask_to_str()
> helper, in security/apparmor/lib.c) over to seq_buf, since that is the
> only consumer. No other behavioural change is intended.
> 
> Custom .get callbacks that do not delegate to a generic helper (and
> therefore still match the .get_str signature) are routed automatically
> to the .get_str field by the DEFINE_KERNEL_PARAM_OPS _Generic dispatcher
> and are deliberately left alone here, to be changed separately within
> their respective subsystems.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> [...]
> @@ -453,36 +457,46 @@ static int param_array_set(const char *val, const struct kernel_param *kp)
>  			   arr->num ?: &temp_num);
>  }
>  
> -static int param_array_get(char *buffer, const struct kernel_param *kp)
> +static int param_array_get(struct seq_buf *s, const struct kernel_param *kp)
>  {
> -	int i, off, ret;
> -	char *elem_buf;
>  	const struct kparam_array *arr = kp->arr;
>  	struct kernel_param p = *kp;
> +	char *elem_buf = NULL;
> +	int i, ret = 0;
>  
> -	elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> -	if (!elem_buf)
> -		return -ENOMEM;
> +	for (i = 0; i < (arr->num ? *arr->num : arr->max); i++) {
> +		size_t before = s->len;
>  
> -	for (i = off = 0; i < (arr->num ? *arr->num : arr->max); i++) {
>  		p.arg = arr->elem + arr->elemsize * i;
>  		check_kparam_locked(p.mod);
> -		ret = arr->ops->get_str(elem_buf, &p);
> -		if (ret < 0)
> -			goto out;
> -		ret = min(ret, (int)(PAGE_SIZE - 1 - off));
> -		if (!ret)
> +
> +		if (arr->ops->get) {
> +			ret = arr->ops->get(s, &p);
> +			if (ret < 0)
> +				goto out;
> +		} else {
> +			if (!elem_buf) {
> +				elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +				if (!elem_buf) {
> +					ret = -ENOMEM;
> +					goto out;
> +				}
> +			}
> +			ret = arr->ops->get_str(elem_buf, &p);
> +			if (ret < 0)
> +				goto out;
> +			seq_buf_putmem(s, elem_buf, ret);
> +		}
> +
> +		/* Nothing got written (e.g. overflow) — stop. */
> +		if (s->len == before)
>  			break;
> +
>  		/* Replace the previous element's trailing newline with a comma. */
> -		if (i)
> -			buffer[off - 1] = ',';
> -		memcpy(buffer + off, elem_buf, ret);
> -		off += ret;
> -		if (off == PAGE_SIZE - 1)
> -			break;
> +		if (i && s->buffer[before - 1] == '\n')
> +			s->buffer[before - 1] = ',';
>  	}
> -	buffer[off] = '\0';
> -	ret = off;
> +	ret = 0;
>  out:
>  	kfree(elem_buf);
>  	return ret;

Since you're almost completely rewriting the logic in param_array_get(),
I suggest tightening it up a bit. The function could warn or return an
error when a kernel_param_ops::get/get_str() call adds a string that
doesn't terminate with '\n', specifically, when the call adds either
a zero-length string or a non-zero-length string that ends with
a different character (unless an overflow occurred).

The updated code silently stops the loop when a get call returns
a zero-length string. Similarly, handling of a string not terminated by
'\n' is halfway there because of the added check
"s->buffer[before - 1] == '\n'".

-- 
Thanks,
Petr

