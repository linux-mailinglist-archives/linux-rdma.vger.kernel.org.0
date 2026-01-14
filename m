Return-Path: <linux-rdma+bounces-15549-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4110D1D968
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 10:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69E123007C28
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 09:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4484389442;
	Wed, 14 Jan 2026 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HcOcfP8T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16163876A1
	for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768383404; cv=none; b=Dn7LpcCShiqQDxGv+vShDhOuKQpxba8Esf4FlXkbtnt+F1npc1EeUfNwKcf0PFqNxVr+R+eJgSmGZOG4vm8kikNCRZAyhnfMB1Ci1+8LQWCuPim3ytlom1DBLwZB5njt4SNE7LAlSboqCcCXRU6bPDdq2D5/Ify0iuk9Vz+TGrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768383404; c=relaxed/simple;
	bh=U9AEc7i1lPW/gbcFLjaX8gtKcaGG24Ld9xSP3kAWcPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HR9RA8UxaNpbSNrw+/wy1RwzRIrmHRriwYQCkIObs04QRgiqAEjiKcXQNsSS2UfuTocptty0IIjEaNaI4bT0wCojK5y7K642yTEnhC1LHgxOgfs/a4CqnOTTI/kE3WMYnDWt6oRFgCd+UyD/46G00CP/pYU9mkqmnnE0GCUWakk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HcOcfP8T; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8b2ea2b9631so984255985a.3
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 01:36:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768383402; x=1768988202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wKELA+Qi0+obe4c6tmJq3y/beq23TQJGHZNTU2TWyM=;
        b=u2jlbZi/FTMvegdJFB7aNxCHa03/Xh/fRT6lmrEPZuCb/dUVhe5BkEjwWUdx00HKDr
         Zkf0RtC02zSQzI+uNcsg+R+pk/VqYR2p6rAwNXTrTLPEO6cxpXva25CJGktEwgGrLuf1
         vYNt0HJhKU9jjF7OZ4yHgSBT2UIJ6qmfxeGLj0uSrc967KXd95VxUsHfWidZf683dSit
         n9ZVMw3+UeotT/IlRpH7/x4EGSJbVkmdeCkwhp5bTzHFu6RMaSYLn0yJXEnIyRr8GP5C
         vPQMu34rsRsZJV1uB2vy5+0Oq6XzoTn6n5PWcMr+qbsrqRAizghKg4IfKX4hF7BMtjxc
         gRTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtzsselQKw0i9JS0u4qZFh6HqmUWeAUXG0LAt0vuxM6dy4Jw4I2xXTc0EIaMh686PLnTj8AySBkgpF@vger.kernel.org
X-Gm-Message-State: AOJu0YwHg2nUWwJfzp2aqEyrUQHqMYbk1rjzCoIIkrdhBnvsqIRe5Hl0
	oCrDFEPZD6jiVBoQ9VDZlLJ7Aw4NJgx4hpB0ItARgKIDtms+6GiKZRRZJF/5hozVHGdBO0fUxkS
	S5Aa6Cz30YTDBZ2rB4Lh0ahfO4J0F+pS3drh+CEkjy4NfKf3LF47nrR2QjnW7zoYmmXcvsFl7ML
	u1iZjQ10G0h8i09pLek4q2dxPE/9sPthJkROLUC3xMoo5Y1acNbQubI2GqfgoN9hvtzGtnzoE/G
	LggL76lT+vpcB+gQgKY7mfK2a4r
X-Gm-Gg: AY/fxX62x9KBDiokgGzl/yoeqr8yWaD+RSZEMOUDRvsuBkT/WUNSuMRsx9NaEZAbVY0
	G61QLkFp276msRuDtC/uM4AG/MPQtwW20+k0cGvHsPrU5KmUP22bQD6tS6KmvRH3dTOB/rsQA4T
	JdL8byqs3m2nKsoasOiq+kAxHmxThl2mCXIiTdaNUIxzR663nIu5znOrcQsM1Lak6yJThARtyGB
	IbeytEBrO+7mjg5tKZaNA0FUJfbLZNsjN9LvxUxTy2eJrfGyQA/7o67x2nOMrG8pl7AWU/vnhPW
	z09neK3a8qne9tobNqMvI6nKnQ06hSnR0k6MtARSafa3AGkn4odYiz04Lr8w0/uZkPjCIV0HVff
	WOK3smHs+o4udXnhEutqxa04VW2dA15rhEwOgY1kzYoLLVOExawKlfXGMsHQUrzCGbr5LzHU9tF
	hmKIBeDpp/PSW3lUAqsJKegdxD9rIrf9eoZMR4lDx6PBShk3cAGMNrcCtLxnA=
X-Received: by 2002:a05:620a:6c0d:b0:8c5:2ce6:dc8 with SMTP id af79cd13be357-8c52fb2370fmr269907185a.3.1768383401830;
        Wed, 14 Jan 2026 01:36:41 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-890770a4c87sm28768056d6.9.2026.01.14.01.36.40
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jan 2026 01:36:41 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d5c7a2f5dso76944065e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 01:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768383399; x=1768988199; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7wKELA+Qi0+obe4c6tmJq3y/beq23TQJGHZNTU2TWyM=;
        b=HcOcfP8The/w3YhlY2DPhX+fwXf0UMwJ42bmtlmID0ZDLkJ56twa+f2eNYGvgx71cD
         BtGaCg532pRtCo7Vc9K07OjSTfI7J4bTgwmps5Ob0UpKlHWWEMxUxds6Js6XB52aXaNF
         DTGdbx3nk7AdSRzggW/k+AGPyNAmgLgYXce8c=
X-Forwarded-Encrypted: i=1; AJvYcCWPN/vkCuaTpNEQSpRNAiGZknnZtuVlQCPKt+MXND0tmmBGj7qVEvKUzgFrk/wMM51uH4uMfWE3XRXe@vger.kernel.org
X-Received: by 2002:a05:600c:c0c3:20b0:47e:e481:7968 with SMTP id 5b1f17b1804b1-47ee4817d5amr12733165e9.31.1768383399517;
        Wed, 14 Jan 2026 01:36:39 -0800 (PST)
X-Received: by 2002:a05:600c:c0c3:20b0:47e:e481:7968 with SMTP id
 5b1f17b1804b1-47ee4817d5amr12733005e9.31.1768383399131; Wed, 14 Jan 2026
 01:36:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113170956.103779-1-sriharsha.basavapatna@broadcom.com>
 <20260113170956.103779-5-sriharsha.basavapatna@broadcom.com>
 <20260113173247.GT745888@ziepe.ca> <CAHHeUGWErNHmhFX13VHw3V6feswyV6JVzULegGoBNg+2x6O12w@mail.gmail.com>
 <20260113185957.GU745888@ziepe.ca>
In-Reply-To: <20260113185957.GU745888@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Wed, 14 Jan 2026 15:06:26 +0530
X-Gm-Features: AZwV_Qha5vOjw_ez2qFzkNcDK0TV9rZYnjwyyMTgzANDkgKCmCqpMAuC0tbDnok
Message-ID: <CAHHeUGUgacV=t6pUJDX_orvxwzv4LEH_cnzyN61mCA-MMY7acA@mail.gmail.com>
Subject: Re: [PATCH rdma-next v7 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000061b697064855d817"

--00000000000061b697064855d817
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 12:29=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Wed, Jan 14, 2026 at 12:06:38AM +0530, Sriharsha Basavapatna wrote:
> > On Tue, Jan 13, 2026 at 11:02=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca>=
 wrote:
> > >
> > > On Tue, Jan 13, 2026 at 10:39:56PM +0530, Sriharsha Basavapatna wrote=
:
> > > > +int bnxt_re_dv_create_qp(struct bnxt_re_dev *rdev, struct ib_udata=
 *udata,
> > > > +                      struct ib_qp_init_attr *init_attr,
> > > > +                      struct bnxt_re_qp *re_qp, struct bnxt_re_qp_=
req *req)
> > > > +{
> > > > +     struct bnxt_re_alloc_dbr_obj *dbr_obj =3D NULL;
> > > > +     struct bnxt_re_cq *send_cq =3D NULL;
> > > > +     struct bnxt_re_cq *recv_cq =3D NULL;
> > > > +     struct bnxt_re_qp_resp resp =3D {};
> > > > +     struct bnxt_re_ucontext *uctx;
> > > > +     int ret;
> > > > +
> > > > +     uctx =3D rdma_udata_to_drv_context(udata, struct bnxt_re_ucon=
text, ib_uctx);
> > > > +     if (init_attr->send_cq) {
> > > > +             send_cq =3D container_of(init_attr->send_cq, struct b=
nxt_re_cq, ib_cq);
> > > > +             re_qp->scq =3D send_cq;
> > > > +     }
> > > > +
> > > > +     if (init_attr->recv_cq) {
> > > > +             recv_cq =3D container_of(init_attr->recv_cq, struct b=
nxt_re_cq, ib_cq);
> > > > +             re_qp->rcq =3D recv_cq;
> > > > +     }
> > > > +
> > > > +     re_qp->rdev =3D rdev;
> > > > +     rcu_read_lock();
> > > > +     if (req->dpi !=3D uctx->dpi.dpi) {
> > > > +             dbr_obj =3D bnxt_re_search_for_dpi(rdev, req->dpi);
> > > > +             if (!dbr_obj) {
> > > > +                     rcu_read_unlock();
> > > > +                     return -EINVAL;
> > > > +             }
> > > > +     }
> > > > +     ret =3D bnxt_re_dv_init_qp_attr(re_qp, uctx, init_attr, req, =
dbr_obj);
> > > > +     rcu_read_unlock();
> > >
> > > So now if dbr is racily freed the QP just keeps using it? That doesn'=
t
> > > make alot of sense.
> > >
> > > I think the reason you having problems with your locking here is
> > > because this is the wrong way to pass a handle to another uverbs
> > > object.
> > >
> > > Pass in the uverbs object ID and use the uverbs object lookup to
> > > acquire *and lock it*. Then refcount the uobject properly for the qp
> > > lifecycle so the underlying DBR record cannot be destroyed. Get rid o=
f
> > > the hash table.
> >
> > I thought about it, but couldn't find a lookup function that can use
> > the ID (idr) passed through a driver specific ABI structure (and not
> > as a uverbs attribute) and find the corresponding uobject.
>
> That's right, we want drivers to pass in attributes like this because
> it triggers alot of core code to handle the locking and lifetime
> details properly.
>
> > In this
> > case I'd have to pass the dbr handle in bnxt_re_qp_req structure
> > instead of the dpi, and then look it up. Is there an example?
>
> Pass the dbr handle in a dedicated attribute, and then get the dpi out
> of the handle once it is converted from a uobject.
>
> Look at how QP releates to its CQ, it is the same relationship.
Thanks for the pointer, I looked at uverbs_cmd.c:
...
                       scq =3D uobj_get_obj_read(cq, UVERBS_OBJECT_CQ,
                                                cmd->send_cq_handle, attrs)=
;
...

I can pass the dbr_handle (idr) from the library, in the driver's
request structure (bnxt_re_qp_req *req) and then try to lookup the dbr
object using the steps below.
For example:
attrp =3D rdma_udata_to_uverbs_attr_bundle(udata);
uobj =3D uobj_get_read(BNXT_RE_OBJECT_DBR, req->dbr_handle, attrp);

But the driver can't see (implicit declaration error) some of the
internal functions (rdma_core: uapi_get_object()) that are called by
the above function. Is this the right example or are you referring to
some other code?

Thanks,
-Harsha
>
> Jason

--00000000000061b697064855d817
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBAStmmls9jYXJKaUaYChVEsAYHx7JfLCGr
9p5GaMnK5DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMTQw
OTM2MzlaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQCaBqocr1Jju9bWSptiOk0ke/e0jT3OBeCDf9bAeDR30t+/LwK9GQk1Ws5MZXQDGshKzauC
uRjlMQlJqqww6MJKAGOcbSHRLNcJ+6Qx6bKuMnSYHYHPzBunHhfdA2YKgJ8su4ev7yCSi7LqgTB3
vefHP5YT3r04/Vyfo5Dr+P0iS6JCAJS+sg+HGqu8w1lwgXz/8eS8jgDhWdAfBcwCbXerB3YKN819
IqCWL9NoXKy0+V1oXsVI8kecTq0wJXhYvOAMpdL/zs1azJcOGw2wRG/GLw1QVfdzXzuEh0c183d2
e22iOsiHn2Ckgfcbgi0n4R1QPrSX0g8wOCH1X34Ge63s
--00000000000061b697064855d817--

