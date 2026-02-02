Return-Path: <linux-rdma+bounces-16315-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIAFFZ0YgGma2gIAu9opvQ
	(envelope-from <linux-rdma+bounces-16315-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 04:23:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB803C8090
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 04:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C03F8300639E
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 03:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCB1233D85;
	Mon,  2 Feb 2026 03:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="abu/eq+P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210FD1EDA2C
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 03:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770002584; cv=pass; b=OEoGkNmOFSwKo9ksL/Gq4DoYhszx9DDDpk3ki73oGNoDjR1tByMT0KP+sQc7tbq6OpRT0OHrLAw3MRqGQRiOywsK6M182UlAMwZQniYqhR0ICRY2HCWja4IMUeKmyYsQKi0yJkOAn26p2EkH0ppj7LTfY6tDkwTPH69FILBGpUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770002584; c=relaxed/simple;
	bh=I9tTVYISilSOQu/cYWLuY4s7wJddwWKs/7IWxkEKAgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaAubT9xEGlvQ8vk3HHkyT5Gs+dFwsmJmlLx/1O809vAsargVXtHh2alNQrEWucZE0Jz1LlvyK+0DkpQtGvYr7OTHNmTITcBadWV3BBxUWcx+H34HDKVLZVGQfHg0QKznr+wiZAjeQFN63MuJFB/3K2MfDTt2u0y9RU2dMQUm6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=abu/eq+P; arc=pass smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8c7199e7f79so645880185a.0
        for <linux-rdma@vger.kernel.org>; Sun, 01 Feb 2026 19:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770002582; x=1770607382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNmbbijMWqVL9cqQCadgJLxREBviXdaG97X0vW0rEP8=;
        b=dY6VlweIF6vIFkHAhG1i98ntM/YGb/cF/vOLxPt6CUOls98Hx9/EQXsaeY4weeHleB
         fJAvqMqxqeJRXq0PMLbtxNDNSEAdoVbfTuwBC2yzdi+/swNXLGoRECsxcU4gDYjfZvY1
         Ff2+lCtbgmt8C7o2cpkVyN61UY7wrlW3q3ONFSsZzH3CYPFp8b79vSxPZ6CzKVK5YKf8
         VjKfHh2SZb/eY8FX87abiNdPAxGnTIbITxxZHCHcPZ5wuTRahFZ3B1ngf6AV1l2xW70X
         z0BQx/fYawMI14/lqoqFoemBNTYbYE3qkhQ6vQJ+UxK1AK4XujoHJZCrWG7BfZWmljX6
         az/w==
X-Forwarded-Encrypted: i=2; AJvYcCVhxHRVjkT8tatfqRYC3iXvujgJy0efZp9Wi/6eXT6qg46DZXXDF5GvyuKJwiLa4OwCat4PR3ezNyvC@vger.kernel.org
X-Gm-Message-State: AOJu0YzdlvEBqZvU673FzLbIei6uU5nx/0xoBgNidHEacmVtvJXu90hh
	Pk/22rNxWrz8d3OgylQN7dvCpn4ZcRPpQAQWbQ3r9OH5SPa0nWAvuQsNpOi0tAOLr9JH+8V38Sw
	Ma/L1Mcc3kyqFarbWb3A4PnPpc5tjYbvHtnM/o1sOqrrcw21HUeAp1RnluHQCed3C2ALhpKsFRU
	JI5yeZG/sBDnX9Uv2KmpVtbZ5GKS518DeTsz6bS4wM34xpMMs4bKVtvvUnXPg080fDH1hVHgoqZ
	Fde9GV7LwSP8n0q7rUvgv+W1NURtg==
X-Gm-Gg: AZuq6aIoBH03mXAfQG20qqpzhhPjzD0zemANvqV/mYF5g7bdf5LY7bwXq9i+/zJwxBR
	m8uy3HdhP2RjRBZtLqxGh5uY/MhrR3JT9vXhvPOQeO0XHlLtfhxWEugs2Z4xxmlg5eST6j0UTBq
	3e//dC7PM2+XvSyvgFI807oKEJLl7gjT+jKVs+68P/1b/2vG8ytqYjUm7gzzOrhZ3aUF1cGLB1r
	SWqh+oG7czuEEQ8PtHSgZKIXkpGJaNkC8YWlds/qW3Erx1QpjiZPanAMeWYCH+7JHnjkuzj8rY/
	t5vtPl3JWNJmUYFVHTSe6nF+rLd0c0CtvCHo+9DJn7QqNtXQD7JvHXAVWsoUKS3TzDm/lTkNLNy
	7yEgy6oboylkIkTcl+XLRaDPu4ks72ahdoM61sE6rVO/SKA3+FlfWkppIYq9cG+GSBg/6IOJGkh
	xzhoH/qVneA8OtOBOB6zy42j2jPApAgMjcpiFqVqC7XsphStKacxwT/G0=
X-Received: by 2002:a05:620a:25c8:b0:8c6:de9c:bda8 with SMTP id af79cd13be357-8c9eb22f02dmr1498430585a.11.1770002581975;
        Sun, 01 Feb 2026 19:23:01 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-894d36c1262sm21081306d6.8.2026.02.01.19.23.01
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Feb 2026 19:23:01 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35464d7c539so695389a91.0
        for <linux-rdma@vger.kernel.org>; Sun, 01 Feb 2026 19:23:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770002580; cv=none;
        d=google.com; s=arc-20240605;
        b=arKHzeYp3MIO2TKYWPwqG8QxFRaFcY3u1ebZwLeTvTXEf6d72W+q+0svocB40EOIZS
         WYEXQz3A/jwOf3eW5EmWqQGPO5CtzGZvi2PJh/KD3eUl6oZk4Q17KzgN8sItAHM1LsfE
         cV8/CBWLhK/qEp+r6AhXvlHaYdeX7xUIWlR5/IzaQwfUNfbttblanbzeHlFxDT7MM9o7
         A3KP2K7R4eVpLsxlw+otW/wwxuKcx4hHDLm7mfQ4OJeETPm4C1bOcjfySxRoEG8Ewp0r
         4Uhyi2MlFAnbfq4MW5iftPvyF2Kq6/0fICUyXn5CLqli2oH6xW0EVIIz6gWiK5L4a7QQ
         +2CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kNmbbijMWqVL9cqQCadgJLxREBviXdaG97X0vW0rEP8=;
        fh=z3a6KCbRtssBp06pIPesd2tWu+zodhAAVDuCcqyVk4g=;
        b=ZV1rsP4UBmH/KbVgnVqB451ohHwGGx3pOOxocyuvtUmHykqOmN0YxmbCXO0URaXRRg
         5G6rELUoVBYTML/EO/c2SDz3kngBzlZXtHrC6AUwSY1zAIIOzHst0qEHYzABhEEqrt4E
         oB5/Qy2DZT8TAyOjYcQHuNg1XDbjm3qYWMYFZ8OBhJmh354YJ6R+EEJ1YUZakB5Pod+z
         Z4MWAnaKwrcBEWMA1IK4PSNIJvfk7xYccevRohOMskPzXjfr/8hOHDoNPEdGv4IqNuwi
         pIBpO/2WhDWhe+Ec2WvTrIapMZuXh1ftmQD1ADJQL71jfqr57rDARTazULrNxW1ZQBKn
         0txQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770002580; x=1770607380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kNmbbijMWqVL9cqQCadgJLxREBviXdaG97X0vW0rEP8=;
        b=abu/eq+PDCmXvJHClix80XAWB+r3IWd0GIWWLPvSkN+M4ZWjWY3H+qzrSPyyI4dbsW
         QbLFqA1MqsWkJhFaehtQpu8fpUQVgkMfzbKn3FjlZj9Hyxh3YPYa/B6iafFsXJ32IrRb
         b15b8Jz25bpvVfGeAkpIAk6ke51+b21Q5nI+Q=
X-Forwarded-Encrypted: i=1; AJvYcCVZqISnYsq46Zs0A4ZGhos+WUIYa7sYq6jwNaHPe0wAvQwrrRZ82EgPTXxGZNC7UrdOqMzImMEwHwrC@vger.kernel.org
X-Received: by 2002:a17:90b:5446:b0:340:9cf1:54d0 with SMTP id 98e67ed59e1d1-3543b2ebd00mr9931898a91.1.1770002580448;
        Sun, 01 Feb 2026 19:23:00 -0800 (PST)
X-Received: by 2002:a17:90b:5446:b0:340:9cf1:54d0 with SMTP id
 98e67ed59e1d1-3543b2ebd00mr9931888a91.1.1770002580118; Sun, 01 Feb 2026
 19:23:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129102133.2878811-1-kalesh-anakkur.purayil@broadcom.com>
 <20260129102133.2878811-2-kalesh-anakkur.purayil@broadcom.com> <20260201125125.GB34749@unreal>
In-Reply-To: <20260201125125.GB34749@unreal>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 2 Feb 2026 08:52:51 +0530
X-Gm-Features: AZwV_QhYKDA1Ta8juu26tYDw_OSfhhmiHTOHabKLVUgk4hBRLyrxsj8IiQvtCqw
Message-ID: <CAH-L+nP1Ba74Nx5k24RUE27=37153e07PGAe963wrPLc+=M1Vw@mail.gmail.com>
Subject: Re: [PATCH rdma-rext V2 1/5] IB/core: Extend rate limit support for
 RC QPs
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com, 
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001474bd0649ced707"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16315-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kalesh-anakkur.purayil@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:email,broadcom.com:dkim]
X-Rspamd-Queue-Id: AB803C8090
X-Rspamd-Action: no action

--0000000000001474bd0649ced707
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 1, 2026 at 6:21=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Thu, Jan 29, 2026 at 03:51:29PM +0530, Kalesh AP wrote:
> > Broadcom devices supports setting the rate limit while changing
> > RC QP state from INIT to RTR, RTR to RTS and RTS to RTS.
> >
> > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> > ---
> >  drivers/infiniband/core/verbs.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
>
> This patch should be the last in the series. We must first add driver
> support, then address the required fixes in the mlx5 driver, and only
> after that expose this functionality to users.
ACK
>
> Thanks
>
> >
> > diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/=
verbs.c
> > index 8b56b6b62352..02ebc3e52196 100644
> > --- a/drivers/infiniband/core/verbs.c
> > +++ b/drivers/infiniband/core/verbs.c
> > @@ -1537,7 +1537,8 @@ static const struct {
> >                                                IB_QP_PKEY_INDEX),
> >                                [IB_QPT_RC]  =3D (IB_QP_ALT_PATH        =
         |
> >                                                IB_QP_ACCESS_FLAGS      =
       |
> > -                                              IB_QP_PKEY_INDEX),
> > +                                              IB_QP_PKEY_INDEX        =
       |
> > +                                              IB_QP_RATE_LIMIT),
> >                                [IB_QPT_XRC_INI] =3D (IB_QP_ALT_PATH    =
         |
> >                                                IB_QP_ACCESS_FLAGS      =
       |
> >                                                IB_QP_PKEY_INDEX),
> > @@ -1585,7 +1586,8 @@ static const struct {
> >                                                IB_QP_ALT_PATH          =
       |
> >                                                IB_QP_ACCESS_FLAGS      =
       |
> >                                                IB_QP_MIN_RNR_TIMER     =
       |
> > -                                              IB_QP_PATH_MIG_STATE),
> > +                                              IB_QP_PATH_MIG_STATE    =
       |
> > +                                              IB_QP_RATE_LIMIT),
> >                                [IB_QPT_XRC_INI] =3D (IB_QP_CUR_STATE   =
         |
> >                                                IB_QP_ALT_PATH          =
       |
> >                                                IB_QP_ACCESS_FLAGS      =
       |
> > @@ -1619,7 +1621,8 @@ static const struct {
> >                                               IB_QP_ACCESS_FLAGS       =
       |
> >                                               IB_QP_ALT_PATH           =
       |
> >                                               IB_QP_PATH_MIG_STATE     =
       |
> > -                                             IB_QP_MIN_RNR_TIMER),
> > +                                             IB_QP_MIN_RNR_TIMER      =
       |
> > +                                             IB_QP_RATE_LIMIT),
> >                               [IB_QPT_XRC_INI] =3D (IB_QP_CUR_STATE    =
         |
> >                                               IB_QP_ACCESS_FLAGS       =
       |
> >                                               IB_QP_ALT_PATH           =
       |
> > --
> > 2.43.5
> >



--=20
Regards,
Kalesh AP

--0000000000001474bd0649ced707
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGtzCCBJ+g
AwIBAgIMEvVs5DNhf00RSyR0MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNDI1N1oXDTI3MDYyMTEzNDI1N1owgfUxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEYMBYGA1UEBBMPQW5ha2t1ciBQdXJheWlsMQ8wDQYDVQQqEwZLYWxlc2gxFjAUBgNVBAoT
DUJST0FEQ09NIElOQy4xLDAqBgNVBAMMI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20u
Y29tMTIwMAYJKoZIhvcNAQkBFiNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29tLmNvbTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOG5Nf+oQkB79NOTXl/T/Ixz4F6jXeF0+Qnn
3JsEcyfkKD4bFwFz3ruqhN2XmFFaK0T8gjJ3ZX5J7miihNKl0Jxo5asbWsM4wCQLdq3/+QwN/xAm
+ZAt/5BgDoPqdN61YPyPs8KNAQ8zHt8iZA0InZgmNkDcHhnOJ38cszc1S0eSlOqFa4W9TiQXDRYT
NFREznPoL3aCNNbDPWAkAc+0/X1XdV1kt4D9jrei4RoDevg15euOaij9X7stUsj+IMgzCt2Fyp7+
CeElPmNQ0YOba2ws52no4x/sT5R2k3DTPisRieErWuQNhePfW2fZFFXYv7N2LMgfMi9hiLi2Q3eO
1jMCAwEAAaOCAecwggHjMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcB
AQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQv
Z3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2ln
bi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAy
ASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNv
bS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29t
L2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwLgYDVR0RBCcwJYEja2FsZXNoLWFuYWtrdXIucHVyYXlp
bEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUACk2nlx6ug+v
LVAt26AjhRiwoJIwHQYDVR0OBBYEFJ/R8BNY0JEVQpirvzzFQFgflqtJMA0GCSqGSIb3DQEBCwUA
A4ICAQCLsxTSA9ERT90FGuX/UM2ZQboBpTPs7DwZPq12XIrkD58GkHWgWAYS2xL1yyvD7pEtN28N
8d4+o6IcPz7yPrfWUCCpAitaeSbu0QiZzIAZlFWNUaOXCgZmHam8Oc+Lp/+XJFrRLhNkzczcw3zT
cyViuRF/upsrQ3KY/kqimiQjR9BduvKiX/w/tMWDib1UhbVhXxuhuWMr8j8sja2/QR9fk670ViD9
amx7b5x595AulQfiDhcN0qxG4fr7L22Y/RYX8fCoBAGo0SF7IpxSukVsp6z5uZp5ggdNr2Cq88qk
if7GG/Oy1beosYD9I5S5dIRcP25oNbcJkbCb/GuvWegzGfxCCBuirb09mTSZRxaBmb1P6dANmPvh
PdqGqxfFrXagvwbO15DN46GarD9KiHa8QHyTtWghL3q+G6ZHlZUWnyS4YMacrx8Ngy0x7HR4dNdT
pqAqOOsOwDmQFBNRYomMdAaOXm6x6MFDnp51sIWVNGWK2u4le2VI6RJMzEqLzMZKL0vTW+HPqMaT
hWv2s5x6cJdLio1vP63rDxJS7vH++zMaY0Jcptrx6eAhzfcq+y/TkHJaZ4dWrtbof1yw3z5EpCvT
YDxV0XFQiCRLNKuZhkVvQ8dtmVhcpiT/mENrWKWOt0DwNEeC/3Fr1ruoyriggbnRmBQt1bC5uxfv
+CEHcDGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1FIENBIDIwMjMCDBL1bOQzYX9NEUsk
dDANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgj3hPAe+KcWukZNSNrr4QlayutQvD
OuUGGJ/85ykz2wwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
MjAyMDMyMzAwWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAImz7+e1HL5k4R/zvPGYgAcJs4QlIUvHDrgHAWEpGd3SLvmIi19W4k8cP4vpMH2Y+
U2KbK/6VGLwFVpw6kfW8/CPntS8WHgkJ1iWCPk7KBJLxS81OcZTfAEg/g2W4+4YFi5HdT98C3O7Z
GJN4lBD3tCFXEmHctBa+4ckpCYfBNFKU80j4gFSLv0ZmR4uyYy05AIGc1CI7V6nQ2t84yvglHP7j
NUYglb8PH/eA0AOVcWg+5A70MNE4jh2hIyNMOzteSz1lilMK2kY2znhBwS0oZC8eNX8Z8kJmtrpT
zkJqdgX7jghFHImCpRrIhH3NNMz0kq6nIoFIJwSUyVE4cm39Sw==
--0000000000001474bd0649ced707--

