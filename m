Return-Path: <linux-rdma+bounces-13150-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFDBB485A3
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 09:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20CB317F47D
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 07:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027E42E8DEB;
	Mon,  8 Sep 2025 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XQUmheph"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C492022A4D5
	for <linux-rdma@vger.kernel.org>; Mon,  8 Sep 2025 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317123; cv=none; b=RNaeqtiN2oeylN00QTXWL7Eo50lAShzbsQ4geA/LTnN9cPVsIH5Sg7hWqHAFdtvVmhORDBCiSVgHQgKA8HVLA8cWzAvvq7vf8QyNSoM7mbSq6TQQPfNoIWzTvznj6GnSPCUfOQUgGXDSVe0skj/w6Nu3pYIC13i8yc29h1eOIkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317123; c=relaxed/simple;
	bh=ynHxmy5Bo6/pWphwf68s+TXDee817KxkAhEozAQpj5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGCHjfaVNl9u4jufMWHF1r+4DogkqReW1WXZc1likGRpShsWtuRv/eM5fmfVUiqNnxEImrhFBnzNeXmO0836cNa5yxXx0SWpi6kDf54pZHwpxPxrVnruvQc4syZARbNFt1ePiGP0A5ko4gpQMC0R96sMUXvPolqj3Jn2zjvoqqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XQUmheph; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-812bc4ff723so202233085a.0
        for <linux-rdma@vger.kernel.org>; Mon, 08 Sep 2025 00:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757317120; x=1757921920;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6dfm5WZ/0OMoXq45VuqlTaC05aNT0VLR1VHmkQq+85s=;
        b=ioTfAqb43OLs9jNH7OYu8E58O6pWwz1Ge7cqt7xwut8XpO34okF8sgmUsEZcA3Zet7
         bMShvTGZXr0IRsWMwBrkssfycX3n59k2sObXMzXpJLuWwYodW1IaYBQV9l640tR23nue
         sJFVJiD1kId0CAZgL+Uf2mpP18At0J1DWmd6qC1fyv0qBARbyIva7s/gldOEr0XYGG8g
         6hkuqejBELnzdorAj0/fw7KOX5UY5T5NLUahhD8WTDFyNUJXd4eeCv0VL1llSIrs+CqX
         atPpo35Alo6ptbJ/bCEqaw64//OoC2xDnDhjdU37YMk2xZwvOqtAU/55OLlvhqfAjpG1
         IQmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkqiz/wDHdotIo5h9ULsizqGU5Us6atzLs0/85qu/hsokg7/AFmcy2VWr6CLpURdXnuWIr87h6IWO5@vger.kernel.org
X-Gm-Message-State: AOJu0Yz54XrtEFcCkEuV9/o+uBxgQWa3mV8Vw8684lsbNb7InGX5g952
	oCz7doXl0WZilmX/h9YRqWe5brrPNSi0oSkFAeMhdXG9wPj8Ca4LEM4ULfTSag9DbNvjvQrQGdc
	nZhMnxumnhlbhb+lCZZoA2Gfj+5gWqz8rg8gYPYcIg25Ux1uG87qvrZJ82WjS3SSGrmZ5RPbAUc
	Wx9EU0Ll6ZkUCUgV/PqF2S6HAW7Yj+QXpz1F8+xTs9ZFP1rtJAAjO9wYFSKB9jriAO0Z96EdDzh
	jMl8ex4+EzKvEj/OJRBpM3iDrjkOA==
X-Gm-Gg: ASbGncvQmQqHb1zvHZF8+YCej4bEjz74CfSILbY7M51qH1pof7LS+Qyp85SwRSoBt+t
	uCPXEPtEVkWhAtE/MTm2JgZFHUIVklSzkO8wx+mR7SD4VTfwFz3rg1X726Lp5Zj26wNxClQ8Txz
	UctCHVWfRjVnX1viHurbtLM2ntjjyWxP7i6bh1MYOjz1tuloPlrE4+2h/8eAxlXFHBBlsEdWHUE
	Pr3b+RoQAMagZzAgPFKzwIgUc8PnruJGSLolVg8omANl6hHnTee4TNKcwCVxTksJfiFim00C7d5
	MdkygPNWqoJTQ6m5xENYUPKp11oku3/dF2Z108vxm42hS+ovHOqiy1s+NrTeyU4TgHQ3XcfD9mN
	mQXs+O0Ei+k+MA8ZDxRXbfjTyGKVyUhU4qY25
X-Google-Smtp-Source: AGHT+IEagJaJ9/P4u28wsqnP0eDPHRN1WCYm/5mZ+JS0xQb5otkHExtv4IuoKo7Ot4N6HkCkaM4dMSIMDxw4
X-Received: by 2002:a05:620a:4502:b0:811:f4e7:c7f6 with SMTP id af79cd13be357-813c2741608mr666401785a.48.1757317120398;
        Mon, 08 Sep 2025 00:38:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-720b5b9c923sm12754866d6.42.2025.09.08.00.38.40
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Sep 2025 00:38:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24b2b347073so55487965ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 08 Sep 2025 00:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757317119; x=1757921919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6dfm5WZ/0OMoXq45VuqlTaC05aNT0VLR1VHmkQq+85s=;
        b=XQUmhephveM2wa8JaoepHLBqcQHupDWUL6Z4yWr5eBgSnxHY+pa7IPAZzhC2jpmkBJ
         lAudBxC6Md5AMW0swkS58FYDdpaRP7+uxgrMcQrg6nCzT+HdXc50+m+aNnxtvgQDibTI
         bFG5A0IpvKCXLWGpLsmJ2l7Z6e4/onkuwTde0=
X-Forwarded-Encrypted: i=1; AJvYcCWOIMDQPgDCYDhLnf/dC+zicY1iaNYy+oF2ueGOQZoFj8Eygd195Ystetyw5MylVXVd4TOPFyvss+zR@vger.kernel.org
X-Received: by 2002:a17:902:e551:b0:24b:270e:56cb with SMTP id d9443c01a7336-2516ec70fd2mr87306745ad.27.1757317118616;
        Mon, 08 Sep 2025 00:38:38 -0700 (PDT)
X-Received: by 2002:a17:902:e551:b0:24b:270e:56cb with SMTP id
 d9443c01a7336-2516ec70fd2mr87306425ad.27.1757317118181; Mon, 08 Sep 2025
 00:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com> <20250908071055.GE25881@unreal>
In-Reply-To: <20250908071055.GE25881@unreal>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 8 Sep 2025 13:08:27 +0530
X-Gm-Features: Ac12FXy8v9JftNmQzrfSQownv3__5CNZ-77W1XgjAwRlVc1sbf0trpPWQCwG9Ac
Message-ID: <CAH-L+nM1OTFPCMt+zh_jKMd7EGoYCb72C7FgU=nxt4r1D9vLKQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next 0/9] bnxt_re enhancements
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a4613b063e454654"

--000000000000a4613b063e454654
Content-Type: multipart/alternative; boundary="0000000000009660e2063e4546f8"

--0000000000009660e2063e4546f8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leon,

On Mon, Sep 8, 2025 at 12:41=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:

> On Thu, Aug 14, 2025 at 04:55:46PM +0530, Kalesh AP wrote:
> > Hi,
> >
> > This patchset contains few enhancements in the bnxt_re driver.
> >
> > Please review.
> >
> > Abhishek Mohapatra (1):
> >   RDMA/bnxt_re: Report udp source port for flow_label in
> >     bnxt_re_query_qp
> >
> > Chenna Arnoori (1):
> >   RDMA/bnxt_re: RoCE Driver Dynamic Debug for HWRM's
> >
> > Damodharam Ammepalli (1):
> >   RDMA/bnxt_re: Optimize bnxt_qplib_get_dev_attr function
> >
> > Kalesh AP (2):
> >   RDMA/bnxt_re: Delete always true SGID table check
> >   RDMA/bnxt_re: Enhance a log message when bnxt_re_register_netdev fail=
s
> >
> > Kashyap Desai (1):
> >   RDMA/bnxt_re: show srq_limit in fill_res_srq_entry hook
> >
> > Vasuthevan Maheswaran (1):
> >   RDMA/bnxt_re: RoCE related hardware counters update
> >
>
> Applied to wip/leon-for-next
>

Thank you.

>
> > Anantha Prabhu (1):
> >   RDMA/bnxt_re: Update sysfs entries with appropriate data
> >
> > Shravya KN (1):
> >   RDMA/bnxt_re: Avoid GID level QoS update from the driver
> >
>
> These need to be resent.
>

Sure, I will resend these 2 patches with the proposed suggestions.

>
> Thanks
>


--=20
Regards,
Kalesh AP

--0000000000009660e2063e4546f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi=C2=A0Leon,</div><br><div class=3D"gmai=
l_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon=
, Sep 8, 2025 at 12:41=E2=80=AFPM Leon Romanovsky &lt;<a href=3D"mailto:leo=
n@kernel.org">leon@kernel.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On Thu, Aug 14, 2025 at 04:55:46PM +0530, Kale=
sh AP wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; This patchset contains few enhancements in the bnxt_re driver.<br>
&gt; <br>
&gt; Please review.<br>
&gt; <br>
&gt; Abhishek Mohapatra (1):<br>
&gt;=C2=A0 =C2=A0RDMA/bnxt_re: Report udp source port for flow_label in<br>
&gt;=C2=A0 =C2=A0 =C2=A0bnxt_re_query_qp<br>
&gt; <br>
&gt; Chenna Arnoori (1):<br>
&gt;=C2=A0 =C2=A0RDMA/bnxt_re: RoCE Driver Dynamic Debug for HWRM&#39;s<br>
&gt; <br>
&gt; Damodharam Ammepalli (1):<br>
&gt;=C2=A0 =C2=A0RDMA/bnxt_re: Optimize bnxt_qplib_get_dev_attr function<br=
>
&gt; <br>
&gt; Kalesh AP (2):<br>
&gt;=C2=A0 =C2=A0RDMA/bnxt_re: Delete always true SGID table check<br>
&gt;=C2=A0 =C2=A0RDMA/bnxt_re: Enhance a log message when bnxt_re_register_=
netdev fails<br>
&gt; <br>
&gt; Kashyap Desai (1):<br>
&gt;=C2=A0 =C2=A0RDMA/bnxt_re: show srq_limit in fill_res_srq_entry hook<br=
>
&gt;<br>
&gt; Vasuthevan Maheswaran (1):<br>
&gt;=C2=A0 =C2=A0RDMA/bnxt_re: RoCE related hardware counters update<br>
&gt;<br>
<br>
Applied to wip/leon-for-next<br></blockquote><div><br></div><div>Thank you.=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Anantha Prabhu (1):<br>
&gt;=C2=A0 =C2=A0RDMA/bnxt_re: Update sysfs entries with appropriate data<b=
r>
&gt; <br>
&gt; Shravya KN (1):<br>
&gt;=C2=A0 =C2=A0RDMA/bnxt_re: Avoid GID level QoS update from the driver<b=
r>
&gt; <br>
<br>
These need to be resent.<br></blockquote><div><br></div><div>Sure, I will r=
esend these 2 patches with the proposed suggestions.</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
Thanks<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr">Regards,<div>Kalesh AP</div></div></div></div>

--0000000000009660e2063e4546f8--

--000000000000a4613b063e454654
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJgMIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcN
AQkEMSIEIKrRNg21VV0ZvKNB2Cg0VgrUqLLexBreH5SaHw34gT0yMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDkwODA3MzgzOVowXAYJKoZIhvcNAQkPMU8wTTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBACXBiLs1yrF8UeWRsOQSw8UYeVI2
jyP22eaSZrS9DsFodBH3E65LvUOYFOYWDZdW2wZgWDEVoDP4tpg/d6ot8TjFNUql4driXr4fBRIM
Vebr12b6jR4zp8YB84kyBvla5eoads+DksayB8BI+ibR7nUImf0zJoXV/yFUqnjTidwlxAxjzo/k
Bd5evGO52icK23B7CGK2+nMj4lmINhD4ogzzogqrEO9Tp5pDkXsMjxsImKpVUZ7U8CVfVaBg/zSW
JWUiiENU40qJPKdMCz4ySoR+jLPbiDKUbugh7ApK0KNJDtkME3wK5VhSpyELKf25yU1hxpiJ3PIt
imG3mtBYxCo=
--000000000000a4613b063e454654--

