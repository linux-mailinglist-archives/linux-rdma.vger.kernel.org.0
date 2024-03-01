Return-Path: <linux-rdma+bounces-1179-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC97086DB57
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Mar 2024 07:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B2F1C2188C
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Mar 2024 06:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D1451C5E;
	Fri,  1 Mar 2024 06:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aetHuEmY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32175026E
	for <linux-rdma@vger.kernel.org>; Fri,  1 Mar 2024 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709273244; cv=none; b=XfiDQ7Vx0+JjHg+E6Oajs16PcfDf25fhFzKx/F9NZ15un2iZ7cgioHzFcLa28SM/s/CPAE+oHhhnSN9/BLStaqqGLfK8+uiFgTos6rBvIy1OVOM4Lo0aYU3AUBFvUeZz1CuS84TLd5KJTxkZdFqfnWcPnHWFUNSO0jkHeiO0Ds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709273244; c=relaxed/simple;
	bh=q+Ra2qyRkkVhmGHFUChr6ZIviumkodpy6nSRwcTaHtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USBRV1pFgb+ZYXVK18VpifdnX4QHRbr9okAhckAR19WAFMfQzlRAog8idoWNcf3glPOf0icLhwDAxo8p5Zc6uRBBYDjtc03+QyvpPteBZnQCzzqAmCRBswni0eXFQDPfePoNj9yUNqol+Gnjw2u6mmGTXeI6JerjMW33BZFahAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aetHuEmY; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so1847374276.1
        for <linux-rdma@vger.kernel.org>; Thu, 29 Feb 2024 22:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709273241; x=1709878041; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ve/z/bERQn8JuW5gHPlM18A/CO24L7UW1ewvHl2gLnE=;
        b=aetHuEmY9L1Ix/AMlw6zE+q4il6ATXt1gnHNUhroVO8rESY+b/dMsyRFyORZGw8KIL
         JKLN7zZymDx35q1SaV4HKYrxwns7RAn/2o4i1M0Gx15PwpHjKmeJWV6VXXYKd33SlIQW
         UC0k5ffl3rB4BYUW6KmoV8VhtEcjNa5ZTAcGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709273241; x=1709878041;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ve/z/bERQn8JuW5gHPlM18A/CO24L7UW1ewvHl2gLnE=;
        b=rlNseNByVp0rD9bbtXeda8LfA3GKHRlnLIxrj9+vY+lVv4JIDgnsNoo4SElpwT9zxX
         8Aj1KV6P95xDLE6eXuVyDMx7ZuPC4a+PaMSnhOGtJ41P1CNjL6Nbs77YmSzY+Rlzr+ZY
         7oThoVrQBNfgx7f7YvvTthK0Yp3gO7fBoKYoK6CQ3Xa7h82IYyhT5gF/4FFKmgKJ+JcU
         UGmAzqcbjWmRb0AUGXkKV742yq1JSwVhcgzf35VWDH15RQ6PeiOh0EL0+EtlVlGwB1mm
         r82IsFJovjfuj1Ua3Q+Aclwys81vroKeyTRLfPt7eRpU2cmUcfRYZdvg8Df7mIlphxKj
         +61A==
X-Forwarded-Encrypted: i=1; AJvYcCWL7MuuPidoKqU93SUe8ZiE0dWngeRzT8raxMOtA5+YoRhiirQl1AJBayuQVvR+FEIHNVde2k3s0pmfRacIcSngDAExexPeE3vmtg==
X-Gm-Message-State: AOJu0YyMkRHq4i9cgS280xm1hf2ZxbfWWbhVDN5WWq4qZpOFF0iF89S7
	jOy5rqGJr3vvcbSuAarDlxRSk0cwwAK76MYY/j/ih1Ygxrqa6KjUHSYQc3WOOPtWn4UVo5kDIh7
	n7wYDSWBMvhgt7AsIT6z4EuJFEclbAG6rkqL4mawL8/l7AosHPQ==
X-Google-Smtp-Source: AGHT+IGHx5ISrZhKCYC4gdL7cBXBh1vjP9AiP8xaa3Ag99CjQ3tP12Y2sDk3KoxjzpIjTkMpGZWGSVbgzgUUhpTa3vk=
X-Received: by 2002:a25:690d:0:b0:dcd:b034:b504 with SMTP id
 e13-20020a25690d000000b00dcdb034b504mr488548ybc.27.1709273241533; Thu, 29 Feb
 2024 22:07:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <febe07de-d57b-4369-b388-caa461c94b6b@windriver.com> <IA1PR11MB6489954AE406151D5F09AFACD85E2@IA1PR11MB6489.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB6489954AE406151D5F09AFACD85E2@IA1PR11MB6489.namprd11.prod.outlook.com>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Fri, 1 Mar 2024 11:37:09 +0530
Message-ID: <CA+sbYW1TnGrhST1eumh5D_4g-vfUt6sZ-rQtdu3tr4PqRfWrmA@mail.gmail.com>
Subject: Re: question about in-tree vs out-of-tree Broadcom ROCE drivers.
To: "Ma, Jiping" <Jiping.Ma2@windriver.com>
Cc: "Friesen, Chris" <Chris.Friesen@windriver.com>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
	"Asselstine, Mark" <Mark.Asselstine@windriver.com>, "Tao, Yue" <Yue.Tao@windriver.com>, 
	"Wang, Linda" <Linda.Wang@windriver.com>, "Bicakci, Vefa" <Vefa.Bicakci@windriver.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000068a4820612933041"

--00000000000068a4820612933041
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris/Jiping,
 please see my comments below.

Thanks,
Selvin Xavier

On Fri, Mar 1, 2024 at 6:45=E2=80=AFAM Ma, Jiping <Jiping.Ma2@windriver.com=
> wrote:
>
> Hi, Chris
>
> Added the comments inline.
>
> Thanks,
> Jiping
>
> -----Original Message-----
> From: Friesen, Chris <Chris.Friesen@windriver.com>
> Sent: Friday, March 1, 2024 4:31 AM
> To: linux-rdma@vger.kernel.org; selvin.xavier@broadcom.com
> Cc: Asselstine, Mark <Mark.Asselstine@windriver.com>; Ma, Jiping <Jiping.=
Ma2@windriver.com>
> Subject: question about in-tree vs out-of-tree Broadcom ROCE drivers.
>
> Hi,
>
> I got your address from the Linux kernel MAINTAINERS file, I was wonderin=
g if you could clear something up?
>
> As far as I can tell, the in-tree driver at drivers/infiniband/hw/bnxt_re=
 uses a BNXT_RE_ABI_VERSION value of 1, as defined in include/uapi/rdma/bnx=
t_re-abi.h.
>
> On the other hand, the libbnxt_re-228.0.133.0 package and the
> bnxt_re-228.0.133.0 driver embedded within
> https://docs.broadcom.com/docs/NXE_Linux_Installer-228.1.111.0 are using =
a BNXT_RE_ABI_VERSION of 6.
>
> [Jiping] The abi_version of OOT bnxt_re driver is 6.  BNXT_RE_ABI_VERSION=
 of 6 of libbnxt_re is to compatible with OOT driver.  Perhaps libbnxt_re d=
oes not consider the in-tree driver.
>
> This seems to indicate that the in-tree kernel driver cannot be used with=
 the official version of libbnxt_re as distributed by Broadcom.   Is this c=
orrect?   If so, is there a separate version of libbnxt_re intended to be u=
sed with the in-kernel driver?
>
> [Jiping] Yes, it looks like.  But I did RDMA test, the test passed.  So I=
 suggest we can do more full tests for this part,  such as wrcp regression =
test etc.   In addition, I did not do more search if there is other libbnxt=
_re can be used for in-tree driver.  Could we also confirm with Broadcom fo=
r this question?

If you are using an in-tree kernel driver, then you can use the
libbnxt_re coming with the rdma-core/libibverbs packages in the OS
distro. libbnxt_re is part of rdma-core
https://github.com/linux-rdma/rdma-core/tree/master/providers/bnxt_re.
So if you are using the in tree bnxt_re driver, no need to install any
libbnxt_re separately. Please install the rdma-core/libibverbs
package.

If  you are using the OOT driver, please use the OOT libbnxt_re and
bnxt_re/bnxt_en driver from the Broadcom download section.
https://docs.broadcom.com/docs/NXE_Linux_Installer-228.1.111.0

>
> Thanks,
>
> Chris Friesen
>

--00000000000068a4820612933041
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
FYMZp2DojLAq9f4Oi2OBetbnWxo0WGycXpmq/jC4PUx2u9mazQ79i80VLagGRshWniESXuf+SYG8
+zBimjld9ZZnwm7itHAZdtme4YYFxx+EHa4PUxPV8t+hPHhsiIjirPa1pVXPbQIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU3TaH
dsgUhTW3LwObmZ20fj+8Xj8wDQYJKoZIhvcNAQELBQADggEBAAbt6Sptp6ZlTnhM2FDhkVXks68/
iqvfL/e8wSPVdBxOuiP+8EXGLV3E72KfTTJXMbkcmFpK2K11poBDQJhz0xyOGTESjXNnN6Eqq+iX
hQtF8xG2lzPq8MijKI4qXk5Vy5DYfwsVfcF0qJw5AhC32nU9uuIPJq8/mQbZfqmoanV/yadootGr
j1Ze9ndr+YDXPpCymOsynmmw0ErHZGGW1OmMpAEt0A+613glWCURLDlP8HONi1wnINV6aDiEf0ad
9NMGxDsp+YWiRXD3txfo2OMQbpIxM90QfhKKacX8t1J1oAAWxDrLVTJBXBNvz5tr+D1sYwuye93r
hImmkM1unboxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMCsz+XY9utz
Pqd/mnSGR6bWPxWQGFivqLZwtfergRE5MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MDMwMTA2MDcyMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAVrgRoumhPNANQCn9WoavNtuJPA/Ub
GIcWvPLd0o0PpL9brLuXPtHDCtkB2noZDlTB7S5oTiBzNlsWSfLw9CfvKf1ATYVVoWqNwV3wGw+F
P5QGrXiEQ7AlpnT+lHq4PvGgJqWbkw5tqsk/sbtpPPIKkiBtj2qzT4/jWdtfj61dDo02nAPe7KhY
/1PRBxAugdw3BKRyFtlf9Ph4Z/OYzaC4kpYKYAvKTnJLvSyW0rvBEDhfDE0zUuga2jY5Sj10h/GH
qo7BkWsJ0V/71WMnLnIrHLhRIRUu18rfZPbCPv/gQuztswseCFbVEMNozcdBGnx59mKJ5JnEDZhi
W0JKqku1
--00000000000068a4820612933041--

