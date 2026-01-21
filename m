Return-Path: <linux-rdma+bounces-15856-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDiiKG4lcWl8eQAAu9opvQ
	(envelope-from <linux-rdma+bounces-15856-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 20:13:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB775BEA0
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 20:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A8DEE84E0CD
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 17:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6DB341657;
	Wed, 21 Jan 2026 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WNNkw8Wr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6AC364E9F
	for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016909; cv=pass; b=Q4EfKdRWGKjmqk3v/6HKJ8mPED8yWjvlWFm7VVPu7W4lolj6G9EJDqGzDqllJkmqh3NeGy9XuH1PZIGGcijHcpIRmNgj6d71sb1aAM3kxPKzJzl8beCJ190TkDYZKGBuncjm98huNX6eNNVsPcCV7bx7nXmgIrVDjy5qdW1J6wM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016909; c=relaxed/simple;
	bh=yFyVcoQx+BizZ15ZE8vTsdmIF6jNSm8lcO1e68uJMBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=US6T46+LKI9nJrLERiHz0ayCznn8aNGUzODBKMbVWa/t1gVY7KVY6l+4P8chSQXIqxH1JMUyG7plA4sbWw03Sj2A1r817T92DKZyGW1uBdfGFvU08m1GcDiCx9/gxd71F/WQNUT6it8seiHRLmz0+2MMC+4cqyx9LEwcP/cx8Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WNNkw8Wr; arc=pass smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-35334ea1f98so40301a91.1
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 09:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769016906; x=1769621706;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haPPj1RAtp5d5y2z3CMCjaSwEMylQJ1roaSkZT2/tpA=;
        b=WVDqxAhxWbmqgNqh9+IjBv24mdYR9qkIL0qSWdSmOh3rbuZir+QydnIy3rLjcrIUh/
         /yFaqbxOnkM0//98l3ac3QJimyXe0+hAHdgY6RWMj8HRHaOlBmvvga6WYFOx7TUTImgi
         MUjylnMT8xzOhYAKAz9qAIZNixf8BjTSgDmZCfUBCwnXn6IDksvBKp68FTTFBgqFLreN
         zqejAIBTBi4iTQIrAUv+bFseCkzwKzwNbDv/oBD8vxsXTL6LSMmLfkr2MZkAA+QpQ2Ri
         SgJ8TgqGSqcNFfXTq/rnMZaKyCmtx+u9JRDyeIizewOr0/BGtuUfoti79eRGjBA62hDs
         eUCw==
X-Forwarded-Encrypted: i=2; AJvYcCWH14/wFV/SUAAklan+nxrm43MNIYIazii+yL6KzlEWEtYvk8x/WFKM14nz9EFmGQDukZ7T2tvH+RsP@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj1tBUksnLNzlzuAnx4IwE2PPXOpOQw/iaW4d+l9lFRKzthhbK
	jfz7SrpVTG/M30sH1WCNPMrIBj8gsRNK6SAKFiamlSBKDxqjuMekEb5embiqvPiENqiWz3oqecg
	0QFjV6LmIyg7GawSjNtotfIszi34KJtt+pKxtVpVbWmOH3gtZ30oPI8pXLmctpEkqfFLLIfPkM1
	TRCRvvhjlZXfTs2jU8Bik42BuNWlmhm+tLKvB4mgLA4rxHUPnpPCztzi6jFNWnLxLXf00zGyD3J
	Ua1+zqHLOaiq9Pc1Vi3hbOXXPgO
X-Gm-Gg: AZuq6aIcyZ5xadAlKJRZrKpL7H+qUboXPst+nN0h4+vNeFRl4xBMY6m0xVWnZ53ZjTO
	ig5u1N46mbPrvv2Mw1OLslKJF7RxSyT7luqxAwpHW70+t7Y6EafngTK8oXh5k1ZwnrI7YOHmmim
	DwJxRBus/3iQI05pRp7XxlK3z7JzxeynjXIGl0PCN5GFEGax78OrNNtAxOQt/lmyNxrUG8z1GK5
	JuxxQNKKIf5BhDGBAnniGcWE+eAlbKUoWfC87QWE1XmxEEcFSoaw1Rn0cT2ELZQr2Pe4kBjHAJp
	VUfLa/FNZunmHyRTicBO62tKznoO8l9TqiERqO346ZSMakogrhaWo86WjKafWhmWO/1Uvrl3dHj
	p9NjpiXyi6ZF7S3/x2Hux9Z+3nXTuNQpvvzVkAumE0qg3s83a4aGJS6jfopXFZ4ApuZhLQrb7OH
	Ixc+hxp4MiAC4k7sIwRjhMK37strgmbhlGNvfyeyvrvfEDfZNf5jNhhI03S3U=
X-Received: by 2002:a17:90b:33c8:b0:340:2f48:b51a with SMTP id 98e67ed59e1d1-352c3e4eb74mr5086118a91.15.1769016905414;
        Wed, 21 Jan 2026 09:35:05 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35334b30843sm21582a91.0.2026.01.21.09.35.04
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jan 2026 09:35:05 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47ee868f5adso1056585e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 09:35:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769016903; cv=none;
        d=google.com; s=arc-20240605;
        b=KxDRzvvwGNYLmd2j4O0uIUHumEckkE2hQhFBw4hKL+yIVM3lx+B1wHTEOhYClR3xWz
         kgCEOthCqcnVYCLzZR0TEzh9xufWgA9jp/EDMA9NrGrmy1ZG29ZWb6DeWwwEgjUmg7GF
         g3urQMQPUqAmA3ks9fsmYHxsbklQztcp/YhoxEMIM5fcujuSev1gpqRbx+/S9OnD50uo
         wTQTMHSSlc0Uh3ws5Rov7fSTZ49eyzrb4Us2lM4Hwuelhlv8Pi6SAXRC669Aq2xBOAuc
         /Y4W21wr3Vh3Mwb8iod7OGiLCzR7tQYJN2jzO5wM/J5ricJd7ZcSKYp7gfaL4/VIonEF
         6M9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=haPPj1RAtp5d5y2z3CMCjaSwEMylQJ1roaSkZT2/tpA=;
        fh=Ep082zBOZu8bFSxcRb3GeNHws77i/VYvMgHbPMVNn14=;
        b=R61gUslT0A18MkJ+QvUDHLWsVe0xQhPWWHNRqfnbLAdRBRmLeF1jg7LkKkEbRWFMQV
         2a0CGhTH8LlbHbqN66JuApg/OvLGX+2Q/8dl3Uc+MyDQB+O2XjPYyvxsNH6kSYmNb0sF
         tR+5cnTHWu4lq8Lyf3fbWxtbv+zw4QVG7kbMY6OtvwMu7wc8k6D4aOcq8FMSyikgey+B
         Is1ig/8K4FxeSkP4LjP3XW+0poKxkCVo2olazynbZrPI1gK8UZBaemTv7n54P7QZfVWX
         Gbefbk8EOcJyfxYw1IhMQu91itE5SB+PRKBctsAuIej2RdsS5J7IXtp/FivemtsuN4Cr
         P9yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769016903; x=1769621703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=haPPj1RAtp5d5y2z3CMCjaSwEMylQJ1roaSkZT2/tpA=;
        b=WNNkw8WrOhjHq63mlOzUwLA1wJ/5kVoNZqQhoSf39G3YdE6qQsdcOnkptL2Yg1g7bC
         pMJtfPwq0L/4nt6/M4h9CbOe20WfVHIB/1ij9/HKw3Gt6GAtugeD1biyBwGXfskJRXex
         PrLj6Jfzfnb754vH5dG8U0dT3vGiohdViCGVg=
X-Forwarded-Encrypted: i=1; AJvYcCVVOPjQChCRCS5K45iy229cS4RG52UhSt1Kt2aC7E3bpnLSABvaV1+xF6Vem7cjls4wHwmgCbT27FS4@vger.kernel.org
X-Received: by 2002:a05:6000:2f88:b0:435:97b4:b699 with SMTP id ffacd0b85a97d-43597b4b7b4mr6527219f8f.51.1769016902974;
        Wed, 21 Jan 2026 09:35:02 -0800 (PST)
X-Received: by 2002:a05:6000:2f88:b0:435:97b4:b699 with SMTP id
 ffacd0b85a97d-43597b4b7b4mr6527178f8f.51.1769016902564; Wed, 21 Jan 2026
 09:35:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260117080052.43279-1-sriharsha.basavapatna@broadcom.com>
 <20260117080052.43279-4-sriharsha.basavapatna@broadcom.com>
 <20260120185419.GU961572@ziepe.ca> <CAHHeUGXtiDezOVwmFJ3y-0daHD_3ENayqtDJUSHnDE9rVRiAKA@mail.gmail.com>
 <20260121165216.GH961572@ziepe.ca>
In-Reply-To: <20260121165216.GH961572@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Wed, 21 Jan 2026 23:04:48 +0530
X-Gm-Features: AZwV_QhJtsSus7GugdmYk-0ohQ7b-DyRNyf4D8NEbdHYsxt1-EYWuUr0MOeYYuc
Message-ID: <CAHHeUGUGGQHRySzgwM5Orjgj3GYLUQHB2LCzZDj1CBGyZJX3wg@mail.gmail.com>
Subject: Re: [PATCH rdma-next v8 3/4] RDMA/bnxt_re: Direct Verbs: Support DBR verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000020e8510648e95827"
X-Spamd-Result: default: False [-4.06 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[broadcom.com,reject];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15856-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 4DB775BEA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000020e8510648e95827
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 10:22=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Wed, Jan 21, 2026 at 07:32:36AM +0530, Sriharsha Basavapatna wrote:
> > > For instance CQ did it in the above function:
> > >
> > > static int uverbs_free_cq(struct ib_uobject *uobject,
> > >                           enum rdma_remove_reason why,
> > >                           struct uverbs_attr_bundle *attrs)
> > > {
> > >         ret =3D ib_destroy_cq_user(cq, &attrs->driver_udata);
> > >         if (ret)
> > >                 return ret;
> > >
> > > int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
> > > {
> > >         if (atomic_read(&cq->usecnt))
> > >                 return -EBUSY;
> > >
> > > So this patch should be doing the usecnt check as well, otherwise it
> > > won't work right.
> > The consumer of dbr, which is qp, is in the next patch. So the actual
> > usecnt logic (incr/decr) is in the next patch.
>
> I saw that, but nothing in the next patch *reads* it. This is the
> point it should be read.

It is in the next patch, you probably missed it? Pasted below for reference=
.

#include "roce_hsi.h"
@@ -398,6 +399,9 @@ static int bnxt_re_dv_dbr_cleanup(struct
ib_uobject *uobject,
  struct bnxt_re_dbr_obj *obj =3D uobject->object;
  struct bnxt_re_dev *rdev =3D obj->rdev;

+ if (atomic_read(&obj->usecnt))
+ return -EBUSY;
+

Thanks,
-Harsha

>
> Jason

--00000000000020e8510648e95827
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCwqYP70ArXeL2sTb5W+1HMIhixLS7xuJby
t2ssia8gdTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMjEx
NzM1MDNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBnKVn62sPLIHIrRBu7rG5dr4pgjEv+PFnDIgTIqa3f3tIqu/PiWyEznBHsQcyIQ8dkUiF9
Me3wNReQIGg2kOBREeTBk6B+HLMbk9AxxQZTmkS7VzZWwEyox1mT3QnSgvv8IXX8i1MzI0M1sPiW
tG4JgGWahsWqUY61A2K0xC9V+0YP2bk+G8K0ugqkvjQez9m9AwJcs8NCqv3U23jX6LQSbh4jC1Sn
okIh54DiNnRrsgIo/UBROBs2oLyS6AqNp5OKPLSG0cMisBBBp5KUjK+9TmDBJASJKWG1WLoQq+pf
63S7C69GB752VU+GqckLJ8zam3EPL2cKDOsFIDZOTvkN
--00000000000020e8510648e95827--

