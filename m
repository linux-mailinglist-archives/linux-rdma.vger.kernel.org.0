Return-Path: <linux-rdma+bounces-16341-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMNnLTq0gGl3AgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16341-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 15:27:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 492F3CD545
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 15:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77CEF301E210
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 14:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D401B36C0CD;
	Mon,  2 Feb 2026 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g1pV+oi2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0E01F3B85
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770041985; cv=pass; b=leigE8VJVTwVYuG9Of1hNDLVdRS74nXepdptOyV0yacrscr1ivEjZHPt+i1scwizX1Dqoo5f++266N3OKBgknk9omj6dBRlzLYmbNiswE9Y/76NKHfHORJpUjb9+Ranch2BjCiBOeyCvxUGCaYXm2/fYbP3zKe9600G1zt+OgmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770041985; c=relaxed/simple;
	bh=EvBNKkZsI16ACLSIyZLgRsSkv+l2NFmj17i0TmHJPkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxVaaxcKapgWFo22IssUZzoFeA484PMoIJT5oUxWf1TdVACEj8rdY5912A+PZMdkgkcJYOGobCtgkQ9mdD0TZQeS+GHTPobjOpognwSmTBjdkSerGukmNa8j2NMS34D+oajgw9F4m5GVaZmgldwXiQQMJ+PxOpINeYuqGZgOuTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=g1pV+oi2; arc=pass smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-352c414bbbeso3422673a91.0
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 06:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770041984; x=1770646784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGXCvNL1dYZCEjyH838ArokizpJs4nv/Zr7jz0CmQwc=;
        b=GVHwNBSJn+z3UGr6BC8IEJbAIOJamFG32M8JGZWMl45c9OzO7uZfCR2I0h2RD8ikHk
         8ar6HSEaW2LJZK9QSyEeXf9o7bJB09Sbot1EuECWrCUmgGGwTdR7Nw20Rv1dn/EVo91h
         pGbpXiOvacfuoDql80PHdzMXfCLsjON1Wql26kxywEK2uU/a0JNInTYbUxpPIRkOL/g3
         92i95MMbe8G0nJQsH0c9u64zNhjTGsISOjc/KAu4mqQGGwBmz/p+OKX53R1F7SU26zFV
         1+KENb4JsVeeJtnlzBUDw4qgHJ0IXRxKnDEp8Y1udAQj594yAc/aPhCW4l2XYA50AM4W
         Lgbg==
X-Forwarded-Encrypted: i=2; AJvYcCUhtLGArGtKE8cNAarDLf5ZfFz/aEHUN9JnjAzRprsDL9dspkeUYsxCbvTW+pVOGZfcXZbTjaO+MqZ1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf4IfilCoVXPd4UukRYfcpmIFGG/9tbzae4czvQUMmu0HfFqip
	2a8K7J3KEZaHrla1t8dKcsUB38LNvWxa/b6xVHLptL0croFaCH0F6frXmivNsJvIQIqQNhfqOtT
	hRxfNijD0PcIu6dguHI0ziXaudMAKcd81ObNONk9psS4hLXFR+uwZodW2a1NetcAJSlZPrIoD4G
	igUsIo7CBJOHzbD3fYiN3ZDbRwvBNjgylI5KD03ZVEHM6gRAt+aZiquPj/dUWqOMj8mT+8hL12Y
	IEtSJ3xAC2x0XySuZNrIDPCH7dY
X-Gm-Gg: AZuq6aJx1F8jTsTU+tHMdNC6FuLqukfLVvSqdkDE5vsSpagaSB0PcYA6jNMmC0dlP+8
	tmblhF2Bfs12LcyaNZ/Sy7iP4AmQ4Geer8EgFYPzDtSRgJMM9msa/xcVEgnbptT+glZPHly56DX
	pnUmOeIDeifd73SAD8cKTy2pOzCtuatHURzS/pruelU1926jxbvPgBzoDrteAhJaBCpAzcroc/X
	fxowsqaJbTfyzJ8QArG3ZsMcz5RKYn2q+UqnRPH3HJs4Tp3oPsxXSQLeMJ/BjFHrhsAkjsj1FQg
	2PMbxXca8CxIDMwUswJlWFY1GxIO+qd130Q34GbSrLrDAIhz+qFRjnO667YcK0YB1btpdmplfuD
	Nba3n6G4ssgUyNT4ZIPP7kH/TgLHa7VUxAmVz5L8J6HBnWNvMmb+/f/nQh29yNM6VFYtNYXEd6n
	qZxIKFgFQOmwqRsC7Tp7q7+xncX6x9VIL8uD566dRiQLp7LEW033vOZg==
X-Received: by 2002:a17:90b:35d2:b0:352:dbcc:d74c with SMTP id 98e67ed59e1d1-3543c504f9bmr11687039a91.15.1770041983610;
        Mon, 02 Feb 2026 06:19:43 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3543baf79b7sm381849a91.0.2026.02.02.06.19.42
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Feb 2026 06:19:43 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-435a2de6ec0so2776161f8f.0
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 06:19:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770041981; cv=none;
        d=google.com; s=arc-20240605;
        b=Aif3WsS2iSu33UgMN8y5rzHs1Bgc4lZaidq1Unr2eIT/7AEKN0siMSWZpRiAqTb7JH
         rhXDh00wXMQRk/SlNPAISH4PoN3aaM7hOSX4XJYV34zduaWlHyECyRWBFI8wS7H7fHAh
         yoC+2yoiaVOxmYP5TKMc4l4cDDq/PJ0u4LnQ1kUalNJ41ny9O9n+ucMsdphc72Bdb5JP
         blTkwBJMcMZF58Ex6GMY9GFiK2geJMoN9N2+jtil6NB1X9R8HV7vooIkSw+fYh8CpplM
         BCB+MCbBNTf4JitDbt6JvwtnHJfOoxcPCsvkxqk9C3yt1nhmO3WCBtbkkaa5ToAKmKYf
         oOMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HGXCvNL1dYZCEjyH838ArokizpJs4nv/Zr7jz0CmQwc=;
        fh=lvhqbiFNiqIAxit7RcHpV4YLvGRt5z0SY0imUdwrQ3g=;
        b=ei444aPbAVxxQ4AP/Gnw1jhddIxu7cSyGoaXDSayYxP/6pAvuBo3Wt6ifWWdxGdGEZ
         7KUaz0+4aREOQCjhGLHh1FuJ3GdGjancsrOvftqwFrI6MTUEBnvTOP+84JlbpZw6k8sT
         m1bjGCZn3mkvTK06h8+uqEjChfkGI8vT7zDV/zK1mnSRBwFCGCgqos9d0mdcv3pUxCsq
         fuRq+DTbVgQCe7O4gQ05nh9KcWaoRXbh6oXF/KYx2YITcVhAm/bcNLXVnSvInHr1IvII
         a60J4HJyUkSLQ5j4ksSpDRJDCek87gTtltAO7lO2UiLfGBqfeI/V/kcqvKOnbfupT1Xy
         F9KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770041981; x=1770646781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HGXCvNL1dYZCEjyH838ArokizpJs4nv/Zr7jz0CmQwc=;
        b=g1pV+oi2orFyzlkUT5bzV6WCcIsNhDERhdKMHnenLyJMCoOFcqpTYHbRO7HcYDIpRd
         Zx7gAscPrBRM4bGItblpHpBinzXw+klFY6uySaKlcB/S/6g4xcvBneDQ+a6lTcdeDPBT
         pYwG7GlBSHO4C06W9mPlf2phQvgahvMWGOrXw=
X-Forwarded-Encrypted: i=1; AJvYcCXkPZ+328nm9bqFIFelOe6VzaRu85u3Tky9WXjNHDujbodHQAyUL9YK6dpPhGpLWTJ8TZaZmdg02uZe@vger.kernel.org
X-Received: by 2002:a05:6000:61e:b0:435:a2f8:1536 with SMTP id ffacd0b85a97d-435f3ab5008mr15790813f8f.43.1770041981152;
        Mon, 02 Feb 2026 06:19:41 -0800 (PST)
X-Received: by 2002:a05:6000:61e:b0:435:a2f8:1536 with SMTP id
 ffacd0b85a97d-435f3ab5008mr15790774f8f.43.1770041980706; Mon, 02 Feb 2026
 06:19:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
 <20260127103109.32163-6-sriharsha.basavapatna@broadcom.com>
 <20260128153248.GK1641016@ziepe.ca> <CAHHeUGVLi8ZxK3qpJ+nk6DcDd8365fdru-vPmkKtF6k-P4FAcw@mail.gmail.com>
 <CAHHeUGVZCojAmjmqm7yPys2N2TYApPnbMN3dcb4dnWDL_sAA0g@mail.gmail.com> <20260128194253.GX1641016@ziepe.ca>
In-Reply-To: <20260128194253.GX1641016@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Mon, 2 Feb 2026 19:49:29 +0530
X-Gm-Features: AZwV_QhGmqjsX4HpzaijiNcX9db9aru9WKS1tlOSnPnpEKRrncFfVuOIFDh9rSU
Message-ID: <CAHHeUGUNzi3x5bAQeHKkMY2Mb3nE7eFJAVF=NHNXoQ3RRLGzcw@mail.gmail.com>
Subject: Re: [PATCH rdma-next v9 5/5] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008dc7920649d80327"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16341-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 492F3CD545
X-Rspamd-Action: no action

--0000000000008dc7920649d80327
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 1:12=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Wed, Jan 28, 2026 at 11:27:14PM +0530, Sriharsha Basavapatna wrote:
> > On Wed, Jan 28, 2026 at 10:24=E2=80=AFPM Sriharsha Basavapatna
> > <sriharsha.basavapatna@broadcom.com> wrote:
> > >
> > > On Wed, Jan 28, 2026 at 9:02=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca=
> wrote:
> > > >
> > > > On Tue, Jan 27, 2026 at 04:01:09PM +0530, Sriharsha Basavapatna wro=
te:
> > > >
> > > > >  struct bnxt_re_cq_resp {
> > > > > @@ -121,6 +124,7 @@ struct bnxt_re_resize_cq_req {
> > > > >
> > > > >  enum bnxt_re_qp_mask {
> > > > >       BNXT_RE_QP_REQ_MASK_VAR_WQE_SQ_SLOTS =3D 0x1,
> > > > > +     BNXT_RE_QP_DV_SUPPORT =3D 0x2,
> > > > >  };
> > > >
> > > > This is set on the response but there are no new response fields? T=
hat seems
> > > > backwards?
> > > This is set on the response field so that the library can figure out
> > > if its request for DV QP creation (set through req->comp_mask), was
> > > successfully executed by the kernel driver or not. If there is an
> > > older kernel, the resp->comp_mask bit for DV would be 0 and so the ne=
w
> > > library would know its request failed.
> > I will change this to have a separate bit for DV in the response
> > comp_mask, instead of reusing the same value from the req comp_mask.
> > Is that ok?
>
> No. Do not return anything in the response comp_mask, you must fail
> unsupported requests. That is how comp_mask is intended to
> work. Userspace uses the uctx to learn if the request can even be
> sent.
Ack.
- Implemented driver logic to return capability in ucontext for both CQ and=
 QP.
- The library adds comp_mask in its CQ/QP creation request, only if
the driver has exported the capability in ucontext.
- The driver checks the requested comp_mask against supported bitmasks
and returns EOPNOTSUPP if invalid.
- Fixed zero initialization of req/resp structures.

>
> > > > Also, what is "pd_id"? The other users of pd_id in prior patches se=
em
> > > > to be actual RDMA PDs. Why is something like this being passed here=
?
> > > > The QP already gets a PD from the core interface, why do you need
> > > > another pd?
> > > Let me take a closer look at this and get back to you.
> > Agree, we had this earlier in our design, but it is not needed anymore
> > since we are using std QP-extension mechanism now.
>
> Ok great, because you also were not refcounting the PD properly with
> that scheme, that is fixed now too.
Ack. Reverted it back to use the PD object from the QP, deleted pd_id
in the req structure.
>
> Jason
I have the revised patchset ready. Let me know how you want to proceed
-  if I should send it out (without the uverbs kernel patch for QP
umem) or if I should wait for the kernel patch and rebase it before
sending.

Thanks,
-Harsha

--0000000000008dc7920649d80327
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAu7oGTUL1cr0JsZpk39L8DphnZg48lW/rQ
Hi2S7qKfjzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMDIx
NDE5NDFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQB9lQNl7aXMTD1Fo88FYGjdf+fNDhr/EeCcE1uqCOuMSXUirBaKRSrJ2NnNcubCm9ieqNbA
8YGNVoVhe4ZJ2vnh+k8a+oandmOZx2iFmc7sY1VIOjuChDzTRjyJU7FcxbqZa1e/HSUgwTETx0ce
ewSddxD1mw9A8Oz5igLWDNqyvIJ1vr01o10xaCP6ZPHfG89AQ6QOEREyWO72ePXqxPODMzw80dCg
D6wkqhIiQpsUyL5v2atKiTmQ8O+WwgRtQDhBQ6rPLQ0D3/T4m8+pNTQWqi7+TDvlD/na+Y/VW8OB
KrpycStggeW9f5ZVA/VEe0+g48CU9VP+whqwOFwqS6Kr
--0000000000008dc7920649d80327--

