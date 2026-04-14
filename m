Return-Path: <linux-rdma+bounces-19337-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF+jHc9E3mnYpwkAu9opvQ
	(envelope-from <linux-rdma+bounces-19337-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 15:44:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8283FAA49
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 15:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7F0730470E0
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 13:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADF22DB79E;
	Tue, 14 Apr 2026 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="alUHv3zO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CF9217723
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174060; cv=pass; b=isVhK5wczNyUwWBeeiDpc11LTQ6afvaOzOFgHoaBu6LZo5HtSmGuqSeUg6MxNeleRFmwObD1qOXsj8A2Jh/9ojWP4ODVPf8V3ZTSnrMEdQsChiSgM6A6ytnyzcgaxJfwAkkar2iOnsHOBsltd6mOqMlbIOLetFI8h7OFnQJsUNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174060; c=relaxed/simple;
	bh=4V9jgsfjQBwqWRFNhgpH4zGdEhv4g4q4CfPoCcVmU9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JORqGPMah4AHMApgdux5jFOdDOppSQrmLAZC4i9oyY5UFOuvhKJ1uBC/CumNaANeUJwNNAKozLiF9ByRR1ADETzYepTUJF31LV4sltj+wsKrrvDuwtwEY0TvL7Q9Wa+YuTMdqusQMMEHcIhEJJxM7775j6J8RuaAvyNsbLaSvoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=alUHv3zO; arc=pass smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-89fc349b5ceso87947826d6.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 06:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776174058; x=1776778858;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZI4XdQBT5cz7B341ILQmkwFFFJT8TZMGzNzCg3pZvQk=;
        b=PHBlanQMhUAMZzX95AT0LWCuEB9vDuT10D4RqRuc3FUxNQxfyKYCfADXTeuoCR4lwp
         o4KtpzPc19Jwpc6zNuEIOc3GhuCJZtZglIJjykJkkX61i+abaBgFYa9l+xqhEpVxX7h5
         ps92nF9HTUHTRsvLauKE0LdMWfvLn2oQtwZ50CSDn97PZLnV0+TvYgLz1DGvjP5R4uPU
         Qg03aMiOpyfbcZwjqC3GsBB7pmV/pS9B/Am/Kt8gARp/U7FFIoYT09L2Yl4HBJ5m9Msm
         NWqHngPXKQnZaoREJEm1sKaoDIu14EUZtlW1dmLaRnZsrzmcBjxmwC6z51hoc5pRh7y6
         ijYA==
X-Forwarded-Encrypted: i=2; AFNElJ8TzXXVrP4Q+v0t9GY+7El7LOQZV/R+PfQl8zTloaPSizHkpU2KjLUcL1VwDZilHNh858PkC2axhNLa@vger.kernel.org
X-Gm-Message-State: AOJu0YxKBVO+V+BmmTlqyOtJM14MiS8fF6bcK91sCPpBLXoUKWKxghpy
	4Rzq5+cc57AX3aCocdFXTL2vD9TEhQM+pCOlvEhvbsBjbabF6kcrKZMtebLnLv6TTllFk+i8Q5t
	YZkwAag/8REBFQu3KwxVty9uKpE8zbmEgj2UkAFCrxfCaMFnrm++W659B9e8XoMSR78CSTj3ex/
	i2HR7nOQUDZ8dHzuJ7dFDNYggAG89r9zeILCk03drJ+ix2GNU7cr+LQw433hbIfXR4QevbUXxLq
	YSn0eYq0W1jEusXBQ6B7b9KOobS
X-Gm-Gg: AeBDiesOyD/ov1CYNSyqKKuDLEKEgPggqLumO26rTATgX+XV+LmoTuHey2S7Rn/G2Qf
	z+y/jaV3BhXeUzWGTut+2AcbU5V25rwmKzNGuObGRxI44J4IW/aHZFGtC81/O0/l+A0odFkApoJ
	G2glsZqkgwUYa3LDqyyfCuj9PcFD5cF+z9HJh9gEHfJy8yehoffAO98w89H6LVJJUyQ9Go661xF
	VPiPDy9fuliV99Ck/vVOX47dzp7NExCZoVE6TR2s3px4MGqklCq/dFCezaJPQtK6rOoCfxaJWbX
	tMrsnRTHvoV67OCr4Vn99vfqcbI+1bK/QpC+b1IFBKnOhkjnRp3/sni0sFyYpu69LZZ2aLdYhfE
	MgPX9uzP0wOB9XVEIzhoM936ABjS0Vtskjmh4nbFwB8rKtgYwBznQ3eHsyQZlTrwOQnWO6JiS8+
	tCQAOVtssO4diHfJdPWe5qCDWI0hgBoyQrqSmLOv+fB7qsDSOuIEadJt9PHqNSaeElQCQe
X-Received: by 2002:a0c:f118:0:b0:89c:5c57:98c with SMTP id 6a1803df08f44-8ac861b003cmr220311326d6.18.1776174057401;
        Tue, 14 Apr 2026 06:40:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8ac84ab83d8sm10365686d6.9.2026.04.14.06.40.56
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2026 06:40:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d03db814eso5760827f8f.2
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 06:40:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776174055; cv=none;
        d=google.com; s=arc-20240605;
        b=WPfJ70UgoT1CDs8fDtd86kJsp/wJZEmJglAFatufjqE5M7xRKID4SWXAk9v/B5H33e
         taV0H+hzd/doce4sdYNFk26/AFU3xtmEDOYIintHIoubeBQiVx/Fytw3bUYWoJVIcjBY
         X1aTQC4+81ZXkls2LGOzlm3dmoam+DP1K5MXk+EeEZ4ijIsEORuN8k15LLmBUQ+vJMeM
         l2dY8j39M9CvPZyEeHl0dpXhVrQioRqy7r07FcnJha7b/ry0ERSazA11Z1OO58obj6y0
         Bck7ZCRyRnwP2G2kPErY42xZ4NIgCZhqIeUSbYYXs8pHJ6fcQ11lfRyQpP2K1AU8QK6E
         xFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZI4XdQBT5cz7B341ILQmkwFFFJT8TZMGzNzCg3pZvQk=;
        fh=XAfDwrjVF8irUeyu9J+C0EIdQWX0HXQBlWiOR6ZOWuU=;
        b=daXbS4LGVE3RVpin4BwODEKSopO9LKzu4sxUnyPz0TCKi2AWUDaO7+iTo80q4cKdvh
         L5YduBCSHN41eBA/4Cd8xdrNFDDpGyhPFbszZFRMkGsLzUTsAw+MZzMCha7N6+qC95QW
         EPgFmERzx/d79Q7zgmV4wVLCeVhDYuW2X6O+0DwTA0vU3DMcMkdL4meI8y8zniFStpup
         JB2qLdI4mAbQMeFlQArxehvapmc8qphujb/p/HxszyRDBP6GrMSHCLj5i0DCeJVR5UYf
         vC3Iksm0+wb9sSirV1gMIAY8PlQyWi1zd7hbnkj0LeyTSBsSlIKzry/hLtCwo/+QIwmC
         NJ7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776174055; x=1776778855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZI4XdQBT5cz7B341ILQmkwFFFJT8TZMGzNzCg3pZvQk=;
        b=alUHv3zOfk/DlfGLMOFFFF6y0AzhEm5j2tRYY4SDTc/ODmj6lVnQMiMfRFw8BPukwo
         5OVyIvTsTeIpo0nnSFmxUYKaU281iCCeEzcXb9iZdrxI6E8s3g/N+UGaykqJVQT/TFZk
         TSj5lwkvSQbVitq5DSQs5K0pr5QIpObyh4rVU=
X-Forwarded-Encrypted: i=1; AFNElJ/sev0T4pHCqRHwepNs3QfhhdfNU99P5AgI0uq0Z4jInOQPh1gyxcr1vUpHtLsn45PEOi+dGIgTf2bT@vger.kernel.org
X-Received: by 2002:a05:6000:605:b0:43d:7b90:fa2a with SMTP id ffacd0b85a97d-43d7b90fe46mr10758613f8f.3.1776174054893;
        Tue, 14 Apr 2026 06:40:54 -0700 (PDT)
X-Received: by 2002:a05:6000:605:b0:43d:7b90:fa2a with SMTP id
 ffacd0b85a97d-43d7b90fe46mr10758560f8f.3.1776174054372; Tue, 14 Apr 2026
 06:40:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327091755.47754-1-sriharsha.basavapatna@broadcom.com>
 <20260327091755.47754-9-sriharsha.basavapatna@broadcom.com>
 <20260410152752.GY2551565@ziepe.ca> <CAHHeUGUwCBjho3oJLJdOeTSF3cp1U_DYsN_satsCo4_aEKLWOQ@mail.gmail.com>
 <20260414123434.GX3694781@ziepe.ca>
In-Reply-To: <20260414123434.GX3694781@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Tue, 14 Apr 2026 19:10:41 +0530
X-Gm-Features: AQROBzBFdt9wbGI51PID4JKmBJ3BWFDbTMjg8sXoJ5nKBSMx29Dd0K_3l-j3lwc
Message-ID: <CAHHeUGVTsMSCrVQ2uSa4_1DfctNYL7Cy2y2QRPF67nW0mPFXzQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next v2 8/8] RDMA/bnxt_re: Enable app allocated QPs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a0e741064f6bbf8f"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19337-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ziepe.ca:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA8283FAA49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000a0e741064f6bbf8f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 6:04=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Apr 14, 2026 at 11:43:51AM +0530, Sriharsha Basavapatna wrote:
> > On Fri, Apr 10, 2026 at 8:57=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> > >
> > > On Fri, Mar 27, 2026 at 02:47:55PM +0530, Sriharsha Basavapatna wrote=
:
> > > > The driver supports a new comp_mask: APP_ALLOCATED_QP_ENABLE.
> > > > The application sets this comp_mask bit in the CREATE_QP ureq
> > > > to indicate direct control of the QP. The driver goes through
> > > > the required processing for app allocated QPs. Only variable
> > > > WQE mode is supported for these QPs.
> > >
> > > I thought we talked about this, no weird names like this.
> > Are you talking about the comp_mask name or the wqe_mode (VARIABLE)
> > name? We used the comp_mask name (APP_ALLOCATED_QP) because the
> > application allocates (and owns/manages) this QP memory instead of the
> > library.
> > If it is the comp_mask, how about one of these alternatives?
> > - USER_MEMORY_QP
> > - USER_MANAGED_QP
> > - USER_CONFIGURABLE_QP
> > - EXTERNAL_MEMORY_QP
> > - DIRECT_ACCESS_QP
> >
> > For the WQE variable mode, please see my response below.
>
> Still no, make the flags reflect micro functionality relative to the
> kernel operation. None of the above in any way explain what the flag
> is doing to the ioctl.
>
> The only thing the flag does is this:
>
> > > > @@ -1734,6 +1734,8 @@ static int bnxt_re_init_qp_attr(struct bnxt_r=
e_qp *qp, struct bnxt_re_pd *pd,
> > > >               return qptype;
> > > >       qplqp->type =3D (u8)qptype;
> > > >       qplqp->wqe_mode =3D bnxt_re_is_var_size_supported(rdev, uctx)=
;
> > > > +     if (app_qp && qplqp->wqe_mode !=3D BNXT_QPLIB_WQE_MODE_VARIAB=
LE)
> > > > +             return -EOPNOTSUPP;
> > >
> > > Give a sensible name for whatever this is and use it only for
> > > this.
>
> So what is this even? FORCE_WQE_MODE_TO_VARIABLE?
It ensures the user/app can only operate in VARIABLE wqe_mode when
app_qp is configured. Static WQE mode is unsupported for app_qps;
therefore, we reject it here. Logic in other parts of the code
subsequently uses wqe_mode.
>
> > > I kind of thinking you can just fully drop it? What is the point in
> > > checking userspace set VARIABLE? It isn't signalling HW and it isn't
> > > protecting anything.
> > VARIABLE wqe_mode is not something that we introduced in this series.
> > It already exists and is understood by the FW/HW. In
> > bnxt_qplib_create_qp(), hardware is signaled through flags.
>
> Yes, and it's fine, you added app_qp and the only thing it does is
> check that userspace set VARIABLE. Why?
No, app_qp (boolean) is used to make other decisions too. It is passed
down to other routines and all that logic is in earlier patches (2-7).
This patch just enables it.

Thanks,
-Harsha
>
> Jason

--000000000000a0e741064f6bbf8f
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAnwbHNVw/rb82jL93tXbHJYb7bmSP5xe8r
r6SB0LKPeTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA0MTQx
MzQwNTVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQAbWtRl90JttYR4rnSH6wzfgR5oUNp4nY+bHYTjINzE7yGnAz3H2aaekunBwgfrJqB36f0L
FCzXfylt93Y7+89icqorQJ4Gyj9T1DUEdZyT9vUvP6quH842vwtB9wdU1i9GThOfgF2++W1D+kVa
MURK36InzJmfiLazGvlkPv32PCVHi79eCC6F52TrHZRLGjOMmKmhzDgfXY3R6Y2UPZvwayAHk68s
NBa34R1/fIdKq1hPGkTH3QaE0wqQjzCXEopUAqdlqHDO8R1ncL3jYhLBC0/7G7NN+BM67bDsMIhv
aPYgCcTUCSyYEaZt3PlebSmhwncPGzGMPXHk5/S0+kiW
--000000000000a0e741064f6bbf8f--

