Return-Path: <linux-rdma+bounces-18745-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VuThMWhMx2kBVQUAu9opvQ
	(envelope-from <linux-rdma+bounces-18745-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2026 04:35:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE6C34D2DD
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2026 04:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5115304F21D
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2026 03:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37049332634;
	Sat, 28 Mar 2026 03:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NIlE4B6j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F59315C14F
	for <linux-rdma@vger.kernel.org>; Sat, 28 Mar 2026 03:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774668899; cv=pass; b=Z+NI8xek1VM8xeOCQhPZqiT5qWj29fSANtowGBzak6bP9n1dBxEzTsvsywjLlaMQ6GG2K6pIwm/HRci7gYEP5w2MYYJLPWtDKTnHeCiSUiPTt/avRLfnHYuKqJx/OxsN+tv16nLD9ttI5kVokndRywQhJFmhmfPzB9nvRVLyJGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774668899; c=relaxed/simple;
	bh=KcHLMPS5U8DPKnKlqiBiXAcxE8RoNt7hXlhoMJhkKa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fO9kV3WoRlRjDjIzCaHKeJ/GWbtbnplEml2gMXz7Eg3dl424cux4jdNu+QbpvDsUWzGNF2rvWnx5968J6Ny4ZP11T8Sx4vUk3YaKNYxBQOrchIOnIV2jD2MuZOS9XZBeyyNJZq14gLRZY5frqndwuhZid90HSBVWZqZ2L0Wzo5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NIlE4B6j; arc=pass smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-64e8cdafeffso4224223d50.1
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 20:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774668896; x=1775273696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcHLMPS5U8DPKnKlqiBiXAcxE8RoNt7hXlhoMJhkKa0=;
        b=rAnnPvnZdU83o5fSaVuR8rbEMvumXgJcDAqEaV5WWLIPaWF909bxy+o3mThc5Pl8aB
         BtMCugo4eQGwWwZvPWQsTQAv2wMDAAdXrOmzY55FRNIZTFlh015dxOQ7Zbqk8C5HAALd
         KGBYTpckw0jduSyX5krx7Ribbqs0BjSDGxj/xXKmmfBJJ6NXhs+VE5PC9lHpShAfVgoy
         mwncZoXQRMzpSWMPFc3I32kOB+M/Oabtc9pNDvkY7orLljEzXGU/4bHGNQnV+yBpn/0s
         h6iBDII8XhtkPJTaKo/XW0axpmOBnJ1ljH/kf/L/qAgltu/DQkGyiynt348ZwOSSrq06
         VePA==
X-Forwarded-Encrypted: i=2; AJvYcCXE5kl6cDre1Tdcc1qCSgQqCn02gFvt/Pi21gFn5AiDk+zR3t7JkQgXwBCXsajeylXJzsUn6OuqpMkK@vger.kernel.org
X-Gm-Message-State: AOJu0YxtOPtvf6/dp33IXPkDja1IfhPzy9MqM1t6fdddTG1gd3rc9ujP
	bu9a0qZVti1v+O2vuAlSBj6jTGGSjA3R3HVdUGTVbPhc7Np81IJOMeZQ+EvRpegSJ0CfaBPBGyw
	ellfzoryZ2yJu49Cr8rNB6TtYxoxOTPG74jt4s1jvJTDPyu2fvKzm0+5Nk7R0zEjwcZuvVCc3sz
	eOVFk8jxK8d5+qNbpTI+KSc5PfXB443tcdPdJdG/43lHIwhGbX9FPMaot6j3KLnaS2Rkc09GW3h
	unINL/6nxkoop0=
X-Gm-Gg: ATEYQzwMdGrdpJtqokay8FAhFWKF/ewSqNeHLYdWnWdDF5cWTzWMhJUHjvWfT6U2Cbw
	mZo2AQ3vtaR2XE5nEFs7Y6AqLpje9ZA9DtXJrjgcrOx8VIPFQTfHs2vn4v4YLxxz0KmjKTYBxvw
	wY712LduA2LaUdvzuCL3Qi0NacXq3MyZiy3dQ/3oBtasXiP+Vm+mT8pvKuOLLnoD+iE8DdWCe31
	QwEYN5vkX9vcwQKkf/gTIpj0push7v3wvyFbWRATdRxtw3UUr1WHXA6wsEQtDYew0henC5ZzYm3
	mEsv+zUJWyxqcgutgPFScewwmqdjZG0MC/h6PqyCm7eE25Z3eurjoRUujqP+KAk+C48KVhmHFpU
	aFcdI/r5NWuPLy2GDBkb+qGfYO1RmT/L5vlTbGI2P79D8UVOfJmOsYfhnld/ggTzE4eJOe7fG7R
	6yje4EV+kciKZnh3tQty8qrtN4nc9ReuaYUZYEV7mDfDidr2aTviCcjRM=
X-Received: by 2002:a05:690c:f03:b0:79b:e346:9813 with SMTP id 00721157ae682-79be346ad5emr34587057b3.10.1774668896382;
        Fri, 27 Mar 2026 20:34:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79cb7a1177asm731547b3.6.2026.03.27.20.34.55
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2026 20:34:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so3652885b3a.1
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 20:34:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774668894; cv=none;
        d=google.com; s=arc-20240605;
        b=DZ02aeqQVJVBkxlj4XPrS4leJvI4+jkvUXAkNgq12zDIiPrFfvqzzENKI9L0FnHQd+
         c2BczBC+e1eWoY/ME+ZpFlqbv+D5ofv1h+p8+I1QIZfCEyBdYtWNtfIZU/9Is/jBlYY1
         6+xi/3PPMhJ+rpIWoQtUreZfgecn6akjHuDOQdkUEHjy5Gljr/kbQTDZLU8ARSbqzzSb
         MEPxUJlQJxmUe3C3syzqmDcvC6UbCJm3bQJDKXPCls7ms1UxGzF6grNDGo6YnqqEiFRa
         Tt3Y7aDcoKAXUV8dc49V9J/DFKsaA8Vi6V2XNTuNJdhwYY5vhciU43lkw7EUg8wp1Nme
         5ByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KcHLMPS5U8DPKnKlqiBiXAcxE8RoNt7hXlhoMJhkKa0=;
        fh=jdlX+hGlgkNON5LAJG7U80I0PXBUw+et24+iVTrHfkI=;
        b=WnEfYmvbovRCRRTLeD6lgOL7ExTMbqkSFO8MWLka6ScLC3TbcJCv5p8bJ/8mO1vgDu
         mmIhdOpth1kLHB7JfkSI43XlIrpKhNs33KBajSR+uKmDDvM+cOGQUp0XbfJJ6on+bbEF
         +BRRRXLaVr/dB1kLYtjnSWDSsywRvnhj4bn4IdPWZlzFtx23vEvwogVYvHBRtL94AE1k
         CIRHQ4NthBEQU/Vm1ZX4p7fnZcnPrMFgta5c6prhwQkImxsDy3XUPCKa7An4cLIFLsae
         mlkVddfPkohX5l+I8xLD4Amn6RmzcsFEH7dOOD44SOfviOiCnIJcngOQERJno8LOOSK5
         n8PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774668894; x=1775273694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KcHLMPS5U8DPKnKlqiBiXAcxE8RoNt7hXlhoMJhkKa0=;
        b=NIlE4B6jR0Ul9qmhID0lciAXXSteDx90vr4mFNeHdy4B3aO7ZyxkcV39UrOQq4+OxH
         K/3ggNZ4RWeae8257IwbKMAcoe8pdriQtIzN6mvQpNszMwEwflLW+8RqmnjPRR847zId
         c+boGWc3V128zDiq/FYSQQEeaa0/0ZOIYby+g=
X-Forwarded-Encrypted: i=1; AJvYcCWnMUOp+Vi9kgI/UQDRw3lMx9NG3gVAhTkM0TkbIcvis7rWzdTV6o1VkqiQRbQEE1InP1XBf1iQl+7u@vger.kernel.org
X-Received: by 2002:a05:6a00:b81:b0:82a:15a1:14d with SMTP id d2e1a72fcca58-82c9696f5f2mr4524295b3a.14.1774668894594;
        Fri, 27 Mar 2026 20:34:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:b81:b0:82a:15a1:14d with SMTP id
 d2e1a72fcca58-82c9696f5f2mr4524276b3a.14.1774668894030; Fri, 27 Mar 2026
 20:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114100728.484834-1-siva.kallam@broadcom.com>
 <20260114115858.GA10680@unreal> <CAMet4B5RtLYaY=wB_T3fBUGYQk-peaLbLsqXy_0Vhp=mqLDm8g@mail.gmail.com>
 <20260217135209.GA281368@unreal> <CAMet4B5jhJXU8WYmcuw1ba=SuJ2f-YCqnD9fGwQ1MNyjF_u3MQ@mail.gmail.com>
 <20260318161330.GH352386@unreal>
In-Reply-To: <20260318161330.GH352386@unreal>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Sat, 28 Mar 2026 09:04:42 +0530
X-Gm-Features: AQROBzCzIGMqOhC-XYErIjhn8I6EXhY6AxYBo1rU_2uep6pmZitd-eqQj0gJJB8
Message-ID: <CAMet4B5p2pCO5tdnM7A2Rv8xknEp-3FUnX4bwe00+OfOEzAcUw@mail.gmail.com>
Subject: Re: [PATCH] RDMA: Add BNG_RE to rdma_driver_id definition
To: Leon Romanovsky <leonro@nvidia.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001380e1064e0d4dec"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18745-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[siva.kallam@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 3DE6C34D2DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000001380e1064e0d4dec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 9:44=E2=80=AFPM Leon Romanovsky <leonro@nvidia.com>=
 wrote:
>
> On Wed, Feb 18, 2026 at 01:55:05PM +0530, Siva Reddy Kallam wrote:
> > On Tue, Feb 17, 2026 at 7:22=E2=80=AFPM Leon Romanovsky <leonro@nvidia.=
com> wrote:
> > >
> > > On Thu, Jan 15, 2026 at 04:35:20PM +0530, Siva Reddy Kallam wrote:
> > > > On Wed, Jan 14, 2026 at 5:29=E2=80=AFPM Leon Romanovsky <leonro@nvi=
dia.com> wrote:
> > > > >
> > > > > On Wed, Jan 14, 2026 at 10:07:28AM +0000, Siva Reddy Kallam wrote=
:
> > > > > > Define RDMA_DRIVER_BNG_RE in enum rdma_driver_id.
> > > > >
> > > > > This should be accompanied with use of such define, where is the =
call to
> > > > > ib_register_device() in bng_re?
> > > > >
> > > > > Thanks
> > > > Hi Leon,
> > > > I was under the impression that driver_id can be added independentl=
y.
> > > > I am planning to send the next patch series including ib_register_d=
evice.
> > > > So, This change can be sent along with my next series. Thanks for t=
he
> > > > clarification.
> > >
> > > What's the current status of enabling this driver?
> > >
> > > Thanks
> >
> > Hi Leon,
> >
> > Next series of bng_re is in progress. bng_re is dependent on some of
> > the bnge driver's code.
> > Next series of bng_re will be sent once required bnge changes are
> > merged. Internal testing of
> > bng_re with bnge is in progress.
>
> What is the current status here? I think it is reasonable to expect that =
we
> should revert this driver if no progress is made before -rc7.
Hi Leon,

Sorry for the late reply. The required dependent code for BNGE is
under active review. It may take some more time to merge the dependent
code into the BNGE driver.
Integration testing of bng_re with BNGE is in progress. We will share
the stable and functional bng_re driver along with the user library in
the next patch series once we
complete our internal testing.

Thanks.
>
> Thanks
>
> >
> > Thanks
>
>

--0000000000001380e1064e0d4dec
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
fyIFUZVWSBcxHWtNNVK4Oi0mqSJut0p/SwfLg6IMaVBU9VdXgVmw35CgcX/9B1ITmih041Oz+Qyo
wTULsXik3lHJuyhYevN9h4259CoDPt+tpaykVaqa4luUmGv8k3F6aC4+fZl83ywHGVun9fBVk/GE
2hmynyIEon1w6Me72fdjaPht4V1tbZBu/76zGxBiBFc13nAKU0dYrvIGPgKN9j0HDuOVC7UhhdTq
Gw+wN3sPJk9D2VtNAzNGw0sa/eJF1wQiBy4RVYG9r0MCAwEAAaOCAdwwggHYMA4GA1UdDwEB/wQE
AwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5Bggr
BgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUG
A1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDag
NKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIwYD
VR0RBBwwGoEYc2l2YS5rYWxsYW1AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBTNBMIvX7vsfxNYWor1Hxth
tmNmHzANBgkqhkiG9w0BAQsFAAOCAgEAJDoTbZO7LdV1ut7GZK90O0jIsqSEJT1CqxcFnoWsIoxV
i/YuVL61y6Pm+Twv6/qzkLprsYs7SNIf/JfosIRPSFz6S7Yuq9sGXNKpdPyCaALMbWtPQDwdNhT7
uJgZw5Rq9FQRZgAJNC9+HBtCdnzIW5GUmw040YclUNHFEKDfycJMKjSPez044QcDoN0T2mIzOM8O
Dt+sJTrC1YJ6+HI6F2H6igZUL79y9qYUz8FNshyITihg/1VBVCiMU9WRK3tNfUlLFzLBuTTr245d
xMh/e75vypL3qDSF4UG6Mpy++Plsnjfwab70KFFyCvNwB2hT1g/y8MLgslfxJl6fCyGdWqOmUB2J
QiuiqbSy8mlnucIPuGWQqqt8VBQjxKYIHdjXtkvw0uVvOHUC2QJWfGWDhMncxF5LFoaRPer4tlXJ
b5zmz9Mn+uQPQQLYUqYzs+EvX1REmGLGUuzlaNwAC20+8CVPY2EkU1mjU78+aW5Zbb2MyjQrLc6J
5IdkekEtk+xjpM992MC/aNMTpWIWhorGq8NmPXbuoUZf9MSi7WrVCaO69ro68FXPTErr/e13lJ/5
GAkwcxdTC+YVPVa/xpdHyAFW03/Oow/7fV8qjy6PAWfqEV97D2Tspc2aEFkbeuFS6UkPRy1OKjGc
/IUTSY4h9roe7Bh1ecqtofP9XL8E88sxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxoOshI0IGR+aGCCXkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIGwf
MWLDZSXOX8JQIGFLxtPy9iUSB6UBI084hvzM+WAvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDMyODAzMzQ1NFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAAaprP3LyokQPqFOYUUrDBO0qxlK57xU8KD9eSs6
eFL310jQ6kSNHmgRRIMsz6WXNDU+mKdiqyYMBhNBZUetrsHXs4bkkeKorw7uRhrSAbzzVk1noiBB
qXbM+iMSf+dwHRRiPZAokRZBI8B3shzsquUWb9ENBjcbERfCSht/UYWpekfDrG7UewSKlwywS3vc
A+rtcIyyTvEg2+NMum22NvMVAqDsjENQdT7HSrtX4LtOI7ct84y0UujMOJ65jZfOO3vcswjpG0BI
xpk1ekHOAI7jgA7UdJIObUw3/M52oZUvjWJNC+BUUVXClhxwg1vaYSlPcaa/CYL7+NfX66nQUq4=
--0000000000001380e1064e0d4dec--

