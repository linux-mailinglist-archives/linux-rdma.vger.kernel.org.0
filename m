Return-Path: <linux-rdma+bounces-16389-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLs9C0aCgWlNGwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16389-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 06:06:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 512A3D48D3
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 06:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA78B3007282
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 05:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEA530EF83;
	Tue,  3 Feb 2026 05:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QwtZXSfX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5072D2493
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 05:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770095166; cv=pass; b=nJsRGllcw0CsZMSn6IhvoDvrVk89c0e1kHvRE2GLJhHGiulOmGjQ8i59YpmyhAAcclXW15EqaaXK4D1U6kmFxLKswkPNhWBJxGpht/q3oGh10l14Us5y3n76pS2WyngjZ4fdPWxxoxgxvwc2qzzosIESU87sShY90lubNI/TnPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770095166; c=relaxed/simple;
	bh=euswlGbyCSaIgT6awUHE3esTnGzss1Ud2qLkivxveXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItVuTq5ZM0g6VJUVeZkr1m4xQKESWqrCMKBvBYKwsYub2953zmqQXNu5yiRtlIDpdkKQc+7RiJZyG8tEA+OX3snEdD0nqObc0Hyq+0L0F0C6pojv7Jdg5UsDAj97m14a2vzLehEpnu95xMncPq/pszB+EcT2NeqmAm84e5BBcf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QwtZXSfX; arc=pass smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-8946e0884afso87742476d6.1
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 21:06:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770095163; x=1770699963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLmmYOIUNEkwi7Fx3ftf9TcTe+2V5AaddfqTtMxKHys=;
        b=Uc4p5Eeolay+roWr7ZbnLOBhvxyDSSK9HDLKqlBUnpam85foaG3A5eD9Wf0fPkrdI3
         w6/P6L7bQiCOCJ3+Yc5nIgbwCD0Gfq3qdxgTMEU48EYaVm731i7XWpY+OHfJHzCAQx0d
         glRpeSomFwKZjEyP3v5WC+PR0TyhaAPKTEYVPDZg91Jf/Eja76zVg5sfF8H+mQqZL2ie
         hkodwZtfVDxpSPld/IvOBRlCa9NcE8DU708KPD+HCLw74m6v1hISdiHdtFC+nGGhKCfB
         x+kCKqXt4uTLKjciI2W8PMoVJknTqWhwsiUw1kTtC3xPXeOWwLRQMl4Ia/L/v5ingDk3
         DlGA==
X-Forwarded-Encrypted: i=2; AJvYcCW6G0wu7zJbKRwKdGTfHD+GA7PuKH88eOYL9cZsYe8tP6bbE9cs191oRW5YiJKn71EGoPphFqiyGkgW@vger.kernel.org
X-Gm-Message-State: AOJu0YxPCpUFmQLuVfDOSYxm8LS7JkBY6CeGKyYmZ+QmnflXOve8fgfj
	nnMz48B8iEpeALpqONB0OgTejWoYSXGSJawVJumPRAsB5SR0IIE5JroFlQ7fH8Qn/wkbbdcPEsO
	0KXemBtBLuybexWvwM1z00tzih2aIbKfgSS2hnjnRLE7r27JINZWp3J/Y61BWyv3YKufhCaKAW2
	cm7wmB8RbofXP5ZWOD/H3vsnXCCHWGXtwcvpmghXdVgcjyoYmWI6i1Wi2t1ykbClszGiQn0/cgL
	0NFso5aE4hpxQI+ypeDnvC8ouQ4
X-Gm-Gg: AZuq6aKPxXdPBWRQrnqs+BSP6yUvKPhR7GKMyacRIq6Ort5vnwgjSliW1dSbvB71Zbe
	eDBoN7n6a/oPi2F/zHcEi5gdR+NyJME2i0N4NXFDG10ckBkhJZY5BOgR5Ee6HUdsieD+aKHIx8Y
	8FEg3sBN6qV45argm2Qe2VIFaeX1FavVnVFAgtesqLdmW+jXmC383edlGkjly6GMHFt7fBlDjCd
	W0+ivuu6XA1Bm/4dYvWS36udQE/rnylvXTnmbCt/8rknbm50r5dXOy78RygilImqgvBphQqVL9V
	T/fwn+al3tGdZWBUYfcVXQu9IDY3iDSOBifo3aLx4Z3USAOXpkNFmT16/oMaPVz9I2JGIPzQZoM
	udOUr4wIO8jLMHBb8dUWKr87tGavtTy8JP+1Zy02UoMUSqC4Dkt9K4VgtDB6lm0Vm3yKClckn5h
	1BSyTooeRcePll5OxX59pElozY+b2CfuxMGt+PIvak5cKdXZXkef7Jfg==
X-Received: by 2002:ad4:5f8a:0:b0:894:3cde:f81e with SMTP id 6a1803df08f44-894ea0905f6mr214812996d6.41.1770095163307;
        Mon, 02 Feb 2026 21:06:03 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-894d36a99f5sm26553826d6.7.2026.02.02.21.06.02
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Feb 2026 21:06:03 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4803e8b6007so42559135e9.0
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 21:06:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770095161; cv=none;
        d=google.com; s=arc-20240605;
        b=Id8tnZ7/oevCrZ3R/LgUItd5eDpz+dI3EiV5bD92waqGRkLcS1RHjpJqH/nNCuUOf3
         FPU9pFnz9n0k+ejSYdSH3HLY7JBCYhCzghph/96oFg0iFHU9fTJLXVnpvkYlZNt6Jkqn
         o5GGujXFnoMv4lVDll5HI+lZsiykHKqhbFQDyFqha9QkYvbFehFJdcK4RvgG/piwYvwI
         UqE6t6xfTmPNeWy7cgWdnuSPifUN4Y5Zh/LIU0cmEv4WXid+ASZWL2sioe2XciGDAfnV
         s2/pYeezLh2D2KINQDCLZWD+A3ZdVGYdsXS42Wg4jMlo8jFTUGvIDXhFQxDLpBmvZJOy
         WjcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bLmmYOIUNEkwi7Fx3ftf9TcTe+2V5AaddfqTtMxKHys=;
        fh=TEliDx3YoFTpMG3c3x90HFbLIVCh4yArtnlnCZne3mk=;
        b=S4u9gvBATDWSxygaj3QnXbB7mQxbWOz1dHc++6GDb9L3hrvqAdQgqj1PKZK/Js8VVJ
         5MGu5H4r0hJX+yqLL3O2w+D1qzKpPjA8GjLzyj7u/GxowE1nXJmWNGsM8CIV5rZBS05x
         7ttJpiVrytBQkgyWx8KGc8upet3N95HYFP8Xrr4foYJfRzFdc28OMuawHFY8wkQw8i+8
         p5vIrysmO+89pIQQkGkUI05mLirwPZCbFDsTRS/5lKfczN8jH4kU+bqVIo/bs4k96SBd
         aHdd0+g5HM4u5Nwrtp6uFGnFSsczX2tCiNy4kXjDNuWchO7riimxL07kDDnR5WhWk5zU
         mQHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770095160; x=1770699960; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bLmmYOIUNEkwi7Fx3ftf9TcTe+2V5AaddfqTtMxKHys=;
        b=QwtZXSfXql3qsxqTSNTq299wMCr478q5hLGl164WpwgWK+MO0E7gPxDoYzG0zMmgQe
         5e3yYlHomQ0oy7sBf+bJHgv/KO6ztFKEeWF7vctHStU7OAll0AtaiTeJJLNqNyMyfqY0
         druxboLiCamJew2AePUsTChhw+yL6eIWBUc74=
X-Forwarded-Encrypted: i=1; AJvYcCUxR/ERayGleMFWRn39/aqA3Bjmn+LsXJk45/o/YgUTfZsQCuPRMWtdfYqR+Q7+q6xDSbFoZsemM603@vger.kernel.org
X-Received: by 2002:a05:600c:3e1b:b0:480:32da:f33e with SMTP id 5b1f17b1804b1-482db47ce18mr181473155e9.17.1770095160703;
        Mon, 02 Feb 2026 21:06:00 -0800 (PST)
X-Received: by 2002:a05:600c:3e1b:b0:480:32da:f33e with SMTP id
 5b1f17b1804b1-482db47ce18mr181472955e9.17.1770095160381; Mon, 02 Feb 2026
 21:06:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
 <20260127103109.32163-6-sriharsha.basavapatna@broadcom.com>
 <20260128153248.GK1641016@ziepe.ca> <CAHHeUGVLi8ZxK3qpJ+nk6DcDd8365fdru-vPmkKtF6k-P4FAcw@mail.gmail.com>
 <CAHHeUGVZCojAmjmqm7yPys2N2TYApPnbMN3dcb4dnWDL_sAA0g@mail.gmail.com>
 <20260128194253.GX1641016@ziepe.ca> <CAHHeUGUNzi3x5bAQeHKkMY2Mb3nE7eFJAVF=NHNXoQ3RRLGzcw@mail.gmail.com>
 <20260202174845.GK2328995@ziepe.ca>
In-Reply-To: <20260202174845.GK2328995@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Tue, 3 Feb 2026 10:35:48 +0530
X-Gm-Features: AZwV_QisL_qfnxlokAHLRkbLoCp9BmdlvrU9IxajK5l7G5pWrOfDXNtKN2_Fexk
Message-ID: <CAHHeUGW=Jced=QcFK=7+rZdHmVZkzDKdvOZ7beTK2u_xcQ2hfw@mail.gmail.com>
Subject: Re: [PATCH rdma-next v9 5/5] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jiri Pirko <jiri@nvidia.com>, leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004a2aa10649e4655b"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16389-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim]
X-Rspamd-Queue-Id: 512A3D48D3
X-Rspamd-Action: no action

--0000000000004a2aa10649e4655b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 11:18=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Mon, Feb 02, 2026 at 07:49:29PM +0530, Sriharsha Basavapatna wrote:
> > I have the revised patchset ready. Let me know how you want to proceed
> > -  if I should send it out (without the uverbs kernel patch for QP
> > umem) or if I should wait for the kernel patch and rebase it before
> > sending.
>
> How about change the Author on that patch to youself and some
> co-developed & signed-off for Jiri and send it out, I'd at least like
> to look at the other changes.
>
> Jiri said he would send his series, there is still time I can stitch
> something together.
Ok, I will include that patch as a placeholder for now and this patch
series can be rebased when it is ready.
Thanks,
-Harsha
>
> Jason

--0000000000004a2aa10649e4655b
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDCgYWkAh/kbB2NsxiCtPh5sABFbUsYwqo2
YpFAFOMNjjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMDMw
NTA2MDBaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQCIWSuLRe/vuWbQIu3ZPRDXvD8ykRLpj8KOrvDhNGkR72pX003IL+9HoN8N582JhwoZ+fCI
1fYPTC1SzL6ByZXGBUAnuIWVifHTLevhUBhrc4bYrCx/qyYGGlUS9xIvmgHg4feg5R1pTE7xXoFQ
Law2cdPFZCPo98etkTqRGFzB7C3K2xrWOy5ByoNxgnprg2CTWdzT2v0653gA3pHcUa+VC4MvN8EL
3rUj3Jflr1wa+rn/7a8GFvfNoNOv+oUeJ1DipnqzB3hePINjxuahc+aiJ1PM3iOKqb91ka9400dZ
szFBR59L5gVFzhzsV1iZdcZ/zk+qilY/tAJQc1NVMN8c
--0000000000004a2aa10649e4655b--

