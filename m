Return-Path: <linux-rdma+bounces-19344-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJVVHQxd3mlfCQAAu9opvQ
	(envelope-from <linux-rdma+bounces-19344-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 17:28:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E05DF3FBD17
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 17:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EB373093D99
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CF230499A;
	Tue, 14 Apr 2026 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BMOSPVwS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84634313277
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179709; cv=pass; b=lBsbHRS4Fj4kw2KvuXxI8kARdf6RVCwsN8N19LtUkHg7TAJrSZWsAZ+ynI2spldIA7iUKeT90Jko++HEJKG8TmlEglzpm03XzUHH+qFjXNC8JtOCn1iNVlfRXKRTGFbVu2NNbYfiu95U8SImo1KAHsVHY+pu9on+NBqgUiHiiPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179709; c=relaxed/simple;
	bh=geaY2noMYtEB/1s0mV1nX6RGtqCmk3h4dP8Neez/owA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oy4ZwuN1egWgXEpxBynokC1NOgYK3Df/K+7vUG/yY23lE/POxtz8xUeCmj9mYBMm2tkBGH9/aqT9iI0HbKCncw6GfN7yVr9MAV/kxTw5DrCJ4jYSas9a4v5O8a1HJGQ6YV6djD3RWcMhmoy3c8AOWjt+Fq8S+xP+jzaQEm7EclE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BMOSPVwS; arc=pass smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-651c8371ed5so1390725d50.2
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 08:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776179707; x=1776784507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geaY2noMYtEB/1s0mV1nX6RGtqCmk3h4dP8Neez/owA=;
        b=kKDJbkq1SiBZGAh9OxXkh41ZTyrG4llTRxnxOvenHSs5YAOih/MFWZCVFgprfhVz8l
         e7PRkdZEeuJohGhh3i4/FFFpnniIrf8wtBrCK0iBZ0sC2sLlxt0YnoExVMT2Sul3Aqa0
         LZitAioMOYsNZzlXfrLMgLC7UX1nLadDqA2ZUFowxDnNJzlca+ZaEWhQxw9xNIoOSbLq
         6Qh4SxPB1qmAbaPIyWDBNi4mSKFEuRGikPuy6wDWuBGdbvngn0tgG1KWHHXFZ40WJING
         arypqYC4FA3mV4PyAwriXAe0+IdcWjeXYoW9Fhfa9iyE397WRKjluCwokcuwkdBBhC1N
         lLDA==
X-Forwarded-Encrypted: i=2; AFNElJ9T2W8nokgtZQ6KH3G4q/YXGLdfXNkuPBsF59r+nu41zSlri5+ijnLhTDT0y2z9XJewn2gsaTkOZXUs@vger.kernel.org
X-Gm-Message-State: AOJu0YxAEOF3aLkpfuc5UROc0YlTfLoSORXuLZva/sRvxDtXpEKFeKOn
	XnFUPlYQMYzMbheSqkOX5q09QauERu2JyUqk50nlMPFwWbOCcPNLcSqGjB0sMmrT+GVUUFFAfLz
	WHINPdpWd0XeiMR4uB9skaLmpF0vbFAfecOOYcPbtBIgBcv/UKLZksmfLSuNUblCI2r+mqEIHqv
	QIgW/TcvVT8y2pdm8yze5jbqDvQNoGMGt3YetkG+eIKEOFw/Vm05iwCI2MvqPZbGAXP7GoyPHMv
	73M3UD3STqRskWP8TC9OY4gKab7
X-Gm-Gg: AeBDiev/VkfMhu2e047gWTjJB1oZ5NXXx21lspJcR1b6b7ed1ZpzRo/pZVuRKQ21mkJ
	/OxVt3LzTuUlNS7TZeSGC8h0Vk9aQdjTjvVUm1CkeGt/M1KnW2AGjS07dqKN4+5Kpz0Vkmo9Fok
	Buf8iXEcUESnfdUQ7WpHJF+zLVbr8GYlhN22bGYUjCTBNxJA52OharA7h9E4GaxjdTYf0K9n+NX
	lkQ7lBzV3V5qCAt4wPdupsFRTTht9uJnLu4M5D4jpnECCfVXClcNhlI6DlvKd4oYIqs9jm7QUIe
	KLzusN4kB6gScRkUY46wKMXu6isqL9rCHz9IBzRihjBtvwfWY9DpdtxVLNa4+MEn7GV/wI10tTO
	NGz/G/UUAt7m4+JkHIBjuJXL192EId47TV1um/gsUSPisp6v02CaBPkITB+0vtJ6ZECed8/c1ol
	yaPLphTEcdcXm6soefvO+DyNRLknITBaJ1WGJ1lyaYQvvz7o3a8gDMUWFltrmG82LrQOu4
X-Received: by 2002:a05:690e:1287:b0:651:daf6:3d85 with SMTP id 956f58d0204a3-651daf65a34mr4821969d50.30.1776179706867;
        Tue, 14 Apr 2026 08:15:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-651ce5d365esm366844d50.3.2026.04.14.08.15.06
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2026 08:15:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d789cebcfso1191614f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 08:15:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776179705; cv=none;
        d=google.com; s=arc-20240605;
        b=kW3HOn3+bi6zGAMjXX7QfuZFEb8BNc4Cc5ug7FVpnf8ae2jHQYUYnE3aBpz0eRH3kb
         WR4HiEkxz3fjf1ltUOJp5N4faXlEmuIiqKyI75HGQqb63r/tpCtVy4xtZl4Io6E3GPsM
         mCdZmhrAsMfFgCX2woikIk6Fdi67KzPEq0BqKiBCnTuFZtay0b6qbOhotHXOxxE1BtOi
         1pF4usgz2mRl6FDBgIChGnMJqJA94Xm3N3tWmmOIdSwM594O7zD3/KoinLu78XZk80AH
         OINPamQNPTPHXB6/5KzOCc7Syjg4DKUO7ax69bxgYY4aCus/noesJdV/N6H2Y9HukX1t
         Kmxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=geaY2noMYtEB/1s0mV1nX6RGtqCmk3h4dP8Neez/owA=;
        fh=cgjazDFwila/VghqeL98qYjHqCrHWEvCw73pPS7ijK4=;
        b=IzcqSHz/KILCOgcLv2Vj/pH8S1j3I+pun8n63ViafIlawS8lhNWlVGMXQ7JYA55Rsy
         M5uJKKiXRe35BBhzomdITO/vlDXFSSTySPBkC4PQlMKRKLuE2ou1gvJJ/jqmTf2uwlkx
         +bIK6IeQfqdBTgNv1xdxZdbu46SizWOlX0eZ5AUZCxqOZ5g6jf7loiepJWc8Age80uYg
         Qc6rrQnE3XSP5xIHtB4rYtoRlrkOa7N6QUnTHJlNV9yVVEYDKTt9RrypZ1xW56aUYGZo
         RktS2N7waQ0FLotEs32PBU+0hy0kCXYdzMhrvF9PmkZnSnh3En/TKyhX2IO/x9cuczcV
         Q2xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776179705; x=1776784505; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=geaY2noMYtEB/1s0mV1nX6RGtqCmk3h4dP8Neez/owA=;
        b=BMOSPVwSzAVihb7XzbPyVidaXG3DDXOZNASxupy7hHuICKXASOK+b0h1UIK6TH/rL5
         1H7S11yVPph/GLMui+2CKZwO/AP/8k6e7aWF8z19cdC1WCmFbX0OhM1Zx/XEDtvVYbUg
         KyOow1s/CBfv4+y4BaxAptXtyrYW52J0aYwGE=
X-Forwarded-Encrypted: i=1; AFNElJ8kZ2eJ/O8wPaVbHAtup+yXszap/Zw85gX7F2liZjtaWZDfx0yRlOoe922hbKMJOxZPVNwsFrv4Jhlr@vger.kernel.org
X-Received: by 2002:a05:6000:2b0c:b0:43d:2ea7:df30 with SMTP id ffacd0b85a97d-43d595735a8mr20253019f8f.7.1776179704796;
        Tue, 14 Apr 2026 08:15:04 -0700 (PDT)
X-Received: by 2002:a05:6000:2b0c:b0:43d:2ea7:df30 with SMTP id
 ffacd0b85a97d-43d595735a8mr20252988f8f.7.1776179704293; Tue, 14 Apr 2026
 08:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327091755.47754-1-sriharsha.basavapatna@broadcom.com>
 <20260327091755.47754-9-sriharsha.basavapatna@broadcom.com>
 <20260410152752.GY2551565@ziepe.ca> <CAHHeUGUwCBjho3oJLJdOeTSF3cp1U_DYsN_satsCo4_aEKLWOQ@mail.gmail.com>
 <20260414123434.GX3694781@ziepe.ca> <CAHHeUGVTsMSCrVQ2uSa4_1DfctNYL7Cy2y2QRPF67nW0mPFXzQ@mail.gmail.com>
 <20260414135438.GC2577880@ziepe.ca> <CAHHeUGW_be95eHW55tFszfC753Zp2sJFJA781ywsXtSD+6XArQ@mail.gmail.com>
 <20260414141940.GD2577880@ziepe.ca> <CAHHeUGWwQHTfrURo7Afbw7Ec0gCbsO-nq4VpQtMgPbgSJQkP4w@mail.gmail.com>
 <20260414150909.GE2577880@ziepe.ca>
In-Reply-To: <20260414150909.GE2577880@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Tue, 14 Apr 2026 20:44:51 +0530
X-Gm-Features: AQROBzD2pgpRhL_5un0g4e5jc6ubJqdmkwFBMwPhGZM_zQdd-W6R2loi8A7wllE
Message-ID: <CAHHeUGXfWK0EQd3fh3amnVmtAf=DN+uB7yr9Lgx6+KBppi-snw@mail.gmail.com>
Subject: Re: [PATCH rdma-next v2 8/8] RDMA/bnxt_re: Enable app allocated QPs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006333aa064f6d10ff"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19344-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E05DF3FBD17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000006333aa064f6d10ff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 8:39=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Apr 14, 2026 at 08:04:22PM +0530, Sriharsha Basavapatna wrote:
> > On Tue, Apr 14, 2026 at 7:49=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> > >
> > > On Tue, Apr 14, 2026 at 07:36:48PM +0530, Sriharsha Basavapatna wrote=
:
> > > > On Tue, Apr 14, 2026 at 7:24=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.=
ca> wrote:
> > > > >
> > > > > On Tue, Apr 14, 2026 at 07:10:41PM +0530, Sriharsha Basavapatna w=
rote:
> > > > >
> > > > > > > Yes, and it's fine, you added app_qp and the only thing it do=
es is
> > > > > > > check that userspace set VARIABLE. Why?
> > > > > > No, app_qp (boolean) is used to make other decisions too. It is=
 passed
> > > > > > down to other routines and all that logic is in earlier patches=
 (2-7).
> > > > > > This patch just enables it.
> > > > >
> > > > > So list what it actually does?
> > > > That is described in the commit messages of prior patches. To summa=
rize:
> > > > - update rq depth
> > > > - update sq depth
> > > > - update msn table size
> > > > - update hwq depth
> > >
> > > What does "update" mean? All these parameters already exist in the in=
put.
> > Yes, they are existing variables, but they are set differently if
> > app_qp is enabled. We don't need to compute their values (such as
> > adding extra slots or rounding up, etc). The application handles that,
> > and the driver just uses those values. And so we "update them
> > differently for app_qps".
>
> So your comp_mask setting is more like "RAW VALUES" for those existing
> inputs, similar to what you did in CQ
Yes, but CQ was simple and in one place, while QP involves more logic.
Thanks,
-Harsha
>
> Jasoon

--0000000000006333aa064f6d10ff
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCA/3eGsPXJL9NZlDN/tnZJZ0fZpEQ5Dujif
wUduSgv+HTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA0MTQx
NTE1MDVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBqR/4JQMG8Bn2oL7IC3POFweCC2m8mYXfAymx2t+Yae1wrVfi+wccI8FMzKdRCPU61jLSj
PACtyxSjROdfe9Ug6/OUEe22q5lbmamDX30s8fKHfvhL9j7G7U6cml9o2VnrSjeK/9SEleLGl/Fl
3bDZw5DZHWOB0z9uuWqoKvPbu3S7pWYHa0iQYTojMCzkm6DI6JlI4jwVzGDLvPB/HaMguazRN3C7
6QgYdkp6squ/f236HRdj4s2Jhbayfn/w3Y6YRrg2JSzRjvB9gspmx5hQOAtkyJPzRGQpTvvPnckX
rmVKT544jdlUDB3m64U1lYEAgXP09K2MUsW/2yupaYJL
--0000000000006333aa064f6d10ff--

