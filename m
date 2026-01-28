Return-Path: <linux-rdma+bounces-16163-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KDBMCJCemmr4wEAu9opvQ
	(envelope-from <linux-rdma+bounces-16163-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 18:06:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E94A6873
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 18:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47F8C30BF9DD
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 16:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B941536922C;
	Wed, 28 Jan 2026 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OEavaoSq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1612F30DED4
	for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619300; cv=pass; b=qOb5UhyV+b4kmkVq6f4i3OI6w5SCMK2pXmtrHZCgEa7sySA7X9OpyH+0/Kl2cHSCMeMtdNIJWTf80yEtcQRIRVUMC4MRAAnAn3b+bCtBYCU34AMVGPgU0NRNpmi75uYjCWbdfFdzVcN5xfmIuFwSxYh0OQEeJmaSly0Y8DPjXBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619300; c=relaxed/simple;
	bh=Jv8XOr3KFQedsw+nSMi8ajvrc6U3nsQ8CsoI1Ff2S3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFcWghCBiajwkIaAjuDaVoNy3gYvKzHq+WvX0kxGGukhWvyyxHfu9zpiNEchCq8R1f+riAyPQmsMXram2vio2MTUaz9tP7lbGN+qJkkz7dObCdUtljWucO5R2wkUYiwzAOfY3SVpgu7cC60dxigULmDByqPKUqbuYMCBTqJfeKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OEavaoSq; arc=pass smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a78e381fc1so31888045ad.3
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 08:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769619298; x=1770224098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZF5008QPXsfLRTW7vjTcazh887wxL2VOcY+EKwddOcU=;
        b=SIMh0+lYNHh2EU7miZL3CXnFLbunJH2L4ugXX6mOG3YL1R0NS0T0us5ttsppHOc97t
         i3pgcAvlCkS2q0NUafD5kr5HJWU4R0PpIE3izQZrUm+9OaI/iVAR9c2KVBpaJ1JIOaDz
         0T5AyJPtlTrQ7rqNPYjrzy/zJJK0NlAjD1FbmFWKH7mgQudr14d6beveW5FKsdrwPqBW
         UTerrvJavra6XTdMOb4C9+piNCNn+AFM99Zchg5CKNDqtuFeU5K+C4YO8Th77ElZgES4
         DHgwlfhLs7RkycE9r0BjslpT7P7W8LSYkGEmaISEWoqCn8YvC9fxqIMCNqyRt3MdFWkx
         HZGg==
X-Forwarded-Encrypted: i=2; AJvYcCXQjjGS/4oJ6JUtt2qEw6m/1sNhiVPgMZDN0PKrtrBYsHh3ZbdOcl7JVAC3PvIZjn8iQUYoJXaNBtfe@vger.kernel.org
X-Gm-Message-State: AOJu0YwEKVyrF0qjLp1XHqmW1aDeL9OZRatgAqUNxrYMGUhT8akqBwPQ
	oxYSTuXB3ZhGWtBQ/KLWJP34QhnbOy93lE684VXK5m1W3HSLHsuIcwR7kl4yZcmE5hU+TL2Aquo
	hSuueqvr7za2tDaYRoWM9122Ts6CMwwRmVgjmaf/fgFjGFHzg5uJQ3JXkNYXgotQIBCqfV7pTMO
	9cwf87BxgLzJGTOwQvCN6+EJyuetuz1ukfjVTow3bN4Ih/bc8G9L4FvJHsIi5Gt4NBYVEHr+X/9
	elbpaGcsFyn+CTb/rYfbOtWjJJ1
X-Gm-Gg: AZuq6aJV5HlJCDtCY4FXk7KuCIGlMUGCYHsQDmC9vPX2Vf7IA4IHRCIn0svnfJcHY6L
	ZS7CmeCbMl5p/wzmH8+n1o30HgrOp39SWgt1J/lu/fcXYc0BT4zGNn3Xv5UWUN8NaMjX6Hc43Ew
	F2SWQnxVzei5dpJ67jnCZ18L80ZvhCbmDtJkR0Jjzaz5tULLsqUwFGxlzc2Hor2yA/9Xs0qgC2f
	DURHFeLZ3N5vkF3U8ZlrZtDOggeJ3PUPQf9TgzxMpDypSsRnj8P6K5qNMEd8lyUUXiRVHp/ba0l
	3HHF8NR3G1tzTLa/jhKPQwWvFt9HcCZMzV9gzmEaGQ+SzSwvoF9WJS9GTAxY3x+DEzOQXRQqG35
	+8WnN0UGenB0Ca003EcM66j2kRlN1sGr7XY2jntk4JE9BYPMqTvZaYD9rzHsyVPngb5bQuty8Wx
	FINEEgTXzotzK0NriKJq9d5tpDwd4AvfpyxvGP2mbQ4KBzR73dePaAuA==
X-Received: by 2002:a17:903:138a:b0:2a7:6cd5:b48 with SMTP id d9443c01a7336-2a870dc865emr69069115ad.29.1769619298164;
        Wed, 28 Jan 2026 08:54:58 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a88b6e5c88sm3473945ad.42.2026.01.28.08.54.57
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jan 2026 08:54:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48025e12b5bso492995e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 08:54:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769619296; cv=none;
        d=google.com; s=arc-20240605;
        b=XPt9HCoLaktPmiRrfb63L/pG1My2ANkxZvSdaiNlBM5sTilCBxjGOlHtdH0/tv7Lel
         sMq3c40Y6DEx80LMrVfcsbvXwgVT7v+ZUrMjxD45rdxcRMaNHk3c+1s/7xsHETaVK8Vv
         wG95QxVzAxx7obYd0mx4WTbNYgr8A/Mf+XcQ9amgIIRFBRCwKvNiKb3TPxnOr8Z0fzEz
         yqdhNJQ7mKE8YGgo4uRzTbvmSolodIRmsIVpnU9tESnVoEhc/sLb1K7xhjz0jSZc4era
         /5W5KgCtxR2BxddD0XR6pB5rdvGztCpcT1NqIawL4M3LSWkqSELO5P0mSG3gZJghC1Nw
         2nUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZF5008QPXsfLRTW7vjTcazh887wxL2VOcY+EKwddOcU=;
        fh=+6Y78iTDGhio0RGWbny/ae0YRmATqAQEFJfNYYcjUPw=;
        b=bn8JB73NfZERmoVSSHkB+yg/s7mkyJ4DMZbDALxHUX9/AW3TSVbdAGFlrApxfU6pnf
         uKffaD/rRq1Ri4ax5rrsIPIFcVi9WKmtoFOp3DxOHn7UXYpKQ6JYMna81dMs11VAu8lV
         HrUveVUMMlCfJaabRS/2wMexoC6BVzW1RWdL3vbahzq+SdPu6n2Wtud8/AN7EmFc0Bhz
         4khGPyOR0yFuBJkdUNqfJJPGexYbna27NSNJAa+pCS6zg/kwnBaFKz63kwR6iC2tfoo/
         dLSNeL+4qyzOrGyL8TJtIkurx746yLvy/w/xi4yPy+5Y28wrdiyV6ZwBREthymGaxwvf
         ejKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769619296; x=1770224096; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZF5008QPXsfLRTW7vjTcazh887wxL2VOcY+EKwddOcU=;
        b=OEavaoSq2W1nyFQlrhOYE2ETOxa/D0pj2Cg7nyZCVIRomR37mQinUAWs1aG+ju0uZJ
         Ue6PAwN8Bl2RXKDNLBQ2GO/u4O3/KaqpVZxNX1jIeCy/JWrzpRpbkeds8laS5UKBh0nS
         DZr4B6Ghgc+SuQHwYce7eOQhRJs4I+BCBZhDM=
X-Forwarded-Encrypted: i=1; AJvYcCVQq+3I6LYvfzGbd/LbbVfW7EBpWp43UtmOzHmJP6FgGbwWxU0+vr10YvNUTerdMtvZjUXjjfOZ7h+G@vger.kernel.org
X-Received: by 2002:a05:600c:3553:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-48069c20e4cmr83791295e9.10.1769619296039;
        Wed, 28 Jan 2026 08:54:56 -0800 (PST)
X-Received: by 2002:a05:600c:3553:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-48069c20e4cmr83790975e9.10.1769619295617; Wed, 28 Jan 2026
 08:54:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
 <20260127103109.32163-6-sriharsha.basavapatna@broadcom.com> <20260128153248.GK1641016@ziepe.ca>
In-Reply-To: <20260128153248.GK1641016@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Wed, 28 Jan 2026 22:24:44 +0530
X-Gm-Features: AZwV_QgpsVvQWYIOpg0hO_XFTc6SEbm4LMbbCHGDgxg8rteNfjGvV_Mne-0hxdU
Message-ID: <CAHHeUGVLi8ZxK3qpJ+nk6DcDd8365fdru-vPmkKtF6k-P4FAcw@mail.gmail.com>
Subject: Re: [PATCH rdma-next v9 5/5] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008d4abe06497599d1"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16163-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,ziepe.ca:email]
X-Rspamd-Queue-Id: 44E94A6873
X-Rspamd-Action: no action

--0000000000008d4abe06497599d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 9:02=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Jan 27, 2026 at 04:01:09PM +0530, Sriharsha Basavapatna wrote:
>
> >  struct bnxt_re_cq_resp {
> > @@ -121,6 +124,7 @@ struct bnxt_re_resize_cq_req {
> >
> >  enum bnxt_re_qp_mask {
> >       BNXT_RE_QP_REQ_MASK_VAR_WQE_SQ_SLOTS =3D 0x1,
> > +     BNXT_RE_QP_DV_SUPPORT =3D 0x2,
> >  };
>
> This is set on the response but there are no new response fields? That se=
ems
> backwards?
This is set on the response field so that the library can figure out
if its request for DV QP creation (set through req->comp_mask), was
successfully executed by the kernel driver or not. If there is an
older kernel, the resp->comp_mask bit for DV would be 0 and so the new
library would know its request failed.
>
> >  struct bnxt_re_qp_req {
> > @@ -129,11 +133,22 @@ struct bnxt_re_qp_req {
> >       __aligned_u64 qp_handle;
> >       __aligned_u64 comp_mask;
> >       __u32 sq_slots;
> > +     __u32 pd_id;
> > +     __u32 sq_wqe_sz;
> > +     __u32 sq_psn_sz;
> > +     __u32 sq_npsn;
> > +     __u32 rq_slots;
> > +     __u32 rq_wqe_sz;
> > +};
>
> How does compatablity work here? Old userspace will send a short
> structure, the new kernel should effectively see 0 at all these fields
> is that OK? Sizes of 0 sound bad don't they?
New kernel won't even look at the new fields if the DV bit is not set
in req->comp_mask, since bnxt_re_dv_create_qp() won't be called; i.e
if the request comes from old userspace.
>
> New userspace will send a long structure and old kernels will ignore
> the new bits. Is that OK?
Yes, this is ok, since these new fields are added specifically for the
DV use-case and a new kernel is required for this functionality.
>
> I would expect you to set QP_REQ_MASK_SIZES in the *req* comp_mask. If
> old kernel then the kernel fails the creation and userspace can do
> something else.
>
> If the userspace passes QP_REQ_MASK_SIZES and the ioctl succeeds then
> everthing is OK. Delete the comp_maks in the rep structure.
As decisions are made based on DV bit in comp_mask (explained above),
this is not needed right?
>
> Also, what is "pd_id"? The other users of pd_id in prior patches seem
> to be actual RDMA PDs. Why is something like this being passed here?
> The QP already gets a PD from the core interface, why do you need
> another pd?
Let me take a closer look at this and get back to you.
>
> Also the old kernels have a bug:
>
>         struct bnxt_re_qp_req ureq;
>
>                 if (ib_copy_from_udata(&ureq, udata,  min(udata->inlen, s=
izeof(ureq))))
>                         return -EFAULT;
>
> It should have been "ureq =3D {};". Those sorts of things must be fixed
> or this compatability stuff is really broken/security problem! Please
> audit all your ib_copy_from_udata()s!!
Sure, will audit this.
Thanks,
-Harsha
>
> Jason

--0000000000008d4abe06497599d1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVfQYJKoZIhvcNAQcCoIIVbjCCFWoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLqMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGszCCBJug
AwIBAgIMPiCpKhlPGjqoQ++SMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTQwNVoXDTI3MDYyMTEzNTQwNVowgfIxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEUMBIGA1UEBBMLQmFzYXZhcGF0bmExEjAQBgNVBCoTCVNyaWhhcnNoYTEWMBQGA1UEChMN
QlJPQURDT00gSU5DLjErMCkGA1UEAwwic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNv
bTExMC8GCSqGSIb3DQEJARYic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNvbTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKS3kXt4zVFK0i5F3y88WV5rV0rr2S3nOVTaCGMB
o6Se8pIb2HJcdpQ4rMiJuIRSyG2XDWv6OB+66eM/6cD2oklFcdzpC4/eYOQFWJ/XM8+ms6HT7P5e
uE7sY6CeUzLzHNjcRwVgZRWlELghY7DIW9fbMzRNDFsbxuIN/7eSofavP1q7PF3+DqhHZpmrVkDu
vcEBTRZSn8NWZ0Xhy4a+Y3KN2W55hh6pWQWO0lt2TtpyaqYp95egJGqDUPtqydci+qrBzXbL05Q0
gcK0NfqGJwLsEVqxHwzz/jRrzKBYKQEK4Bpau91oxVGLmxy1nQDiyI1121xyvsJBDctKH245XZkC
AwEAAaOCAeYwggHiMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSB
hjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3Nn
Y2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5j
b20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgw
QgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9y
ZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMy5jcmwwLQYDVR0RBCYwJIEic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJy
b2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3b
oCOFGLCgkjAdBgNVHQ4EFgQU9Dwqof/Zp1ZdK6zi7XdRGdBWQt0wDQYJKoZIhvcNAQELBQADggIB
AKzx/6ognUMhNv+rh7iQOeHdGA7WMDixk+zrD7TZL6O5DPqXfFqaTLpswyruTymA3AVxZkMJyF6D
zOAsRfU23BjVlgC95zl1glr7DorZW7B/CQDwbLHlkFy92Oa3E+gBzwdiDMjnq6tOW5p83zoVqiV4
qm4OwC9JILEkslV4uZVXHPm5cZoOQURTECE2BN34Qhg5qD3EKYqOTeMVRed1qQiIPqQv1b4xjPVS
qBwNPl7/4TJGiZGnRB7FsNnNUQRJONnEFifM3KGqjbqA4F8BhLXCYjqtBxxCGA5506StNfsjT8UU
28E6lcuJXC4hQXau+xXQ5GWqS4ecWwm22FAVy/i8FJVfXPTJnZeixmqaadbIU3fOJs5+XfyNkU2T
mlCafSr7KgV570M6tITSyminW/7rc8hdznGYypCNa+45JYJTaK4x1+Ejptaxc7TCS12B1zQNCxa7
AHX5PZra3SpDb7g1p1i1Ax0JVJTkThiCSNDbiauVn7xIJpf+H8HC6O2ddGmtKUxe6NseFnSGJsi6
7lO/cU+TpduV7w3weUy+nHhp+GsbClfvAGhFAs/GkyONExCwwIEVlFp9Mj5JLAgB+ceMbojBIoaO
d5rOzdIII5FDwKAAqyjHuniYLrP0xIH4L5kWOAy+LudP4PSze7uAxTiCiSJg5AaNBTa5NuwTnSX6
MYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEo
MCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMPiCpKhlPGjqoQ++SMA0G
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCG/RUzijbza9G1DKMU8LEfskuX05H+4DNU
GJuILMvmyzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMjgx
NjU0NTZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQCXxTAvwdraS9/L37CfPpBMpBFqEooJgJQ6byPyus+zv/EHefvvUOEPhszOc9Zn4dFgO7MA
uxUBQYOj5H7uTY2ZUV7Es34WqKhfvHGIBtAZO3sSaWd5qp+7Ib4zMIanJjHZhxhNzheBw29UQEWp
8IQMMtwq5YAPNaBN2Nl+iOY70fQ1u9dyve8MFOQjhDENJf1jFsjFZs4Hey2ogDJAH/X4P2g7A6C+
tq7L+lJfXBe5SgtG3Ujcxg+LYUQixxqDJyx41mWOD3bwv0Q6mJjNSH44Kl8cSspbKFQKnVdEhe7Y
xsIvDNm+ubOCkflVeWFeclPy7PRIzW3dqq6o4xmkQVvQ
--0000000000008d4abe06497599d1--

