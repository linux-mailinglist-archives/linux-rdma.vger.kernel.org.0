Return-Path: <linux-rdma+bounces-14480-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C78C5BA05
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Nov 2025 07:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D026353C2F
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Nov 2025 06:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0532F5473;
	Fri, 14 Nov 2025 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FiFkOqgv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E6F2F1FDE
	for <linux-rdma@vger.kernel.org>; Fri, 14 Nov 2025 06:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763103111; cv=none; b=G8j8rIpqEDQyZkk5neGAIgOfCi0QfksgeMabg9OaIMY/FVBMVLoJQMEem8sB9+HhRhbZ/oC69NRTt3C9KipC8JzCR5lLKcF+mC0ovUPMOUp/h0gjBCLDcKfxNWh5KSpO0EgtYV4SQfigKhqa5n3sx7qGjUc5U5eL4mJvxhGr89s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763103111; c=relaxed/simple;
	bh=qy1H1NgW1ze88h/rotc/26vU9qqbvo/0G8WYxjaxoS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpIVx4mXzKRC8BgEEwpHaF0ento1XFokxFic8eL9UXR4nDxun2QBYnENY9CBxPMdGevu19uIjdKFMGg3d+ZF+rjkKZ+JzpMEPCTAZ/uqJb7UvzscX2U6G7iCQVKIzMNnZ/SpJnKUQjnCmlqJBURFr6qHJuwTzKWiKo1H4B3L7ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FiFkOqgv; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso1923470b3a.3
        for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 22:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763103108; x=1763707908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aU7bxcMOkucHC3X4c+h1EhVKMXxUUNmIsCk1ha4lo10=;
        b=CNRFL3RPlF5LA7+VkFzBheMieg+aQ1OCKgMxykZyA38M5YTjMMOWITS59tmIq5wKRm
         1VGjDKmWxv083YXGqKMbGotpzorp7DO3DBBPohtAgB7BpldqNHDWvx82u8dfq8VhLhya
         xiJV0SgDKQ3k5abuf0hpKPvix71j7y7/J2K0EXRFUYUDZS8yGyh0W9ijYFDsDySjVCrr
         eEqcX9O1l1/j/C3MV01q6F05a0z+R+4hQH3i4GNPhknkR5REPket713BmJ/MUcBerHsv
         CB3lo4FnX7RNLm5IQBTXwacv4ZoefNlNnvcnx3A8n6gxGJTXcFEzd+AzD8vMZbqDMTJG
         08Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUdQVaf3MPHEVBAmYZOSpFJmbHxz9yCK7Oqt4H/eVDfFv2aGoCqiYr2dfw531CxULFyXpUJaKcdExph@vger.kernel.org
X-Gm-Message-State: AOJu0YxC7r6GoZ/PuFlEg5li2iTlcrFHW210GxZM2Yn31v8B7GHdf4Dq
	J4RK94tjNeJqAHtw/LG7DN4KGOUU3UEuBmUjS3sDdw6+2qMebBqIfQ2lavQC2A/pWlRZz9dBdLH
	9yb17T1fjKTqIuakS2B4fSfJIsmIRvnGOwheHb5G6xbncBCwmUB8/9C+r8rwh2nJnIzTzk8gBUs
	n9n1FujtmhAoBH2bmsFkL7DKvgvhKqWXK2qqVPHOb7kEUBMTz5WSAZu4O/EVCXUmTZbUSJLca6d
	LXK/oMozBI3snc=
X-Gm-Gg: ASbGnctE1RIKvFJNgj+fPt/t2QzfO9WthvIWA04OKvovqrAlsCRXLZOnuRZx+77qWKM
	B4cdzHAnoNe5ajZBkIJX/H1Ns3Rfyz54fkZxp6lteqP7vJ+L3agzc/V0G/ifYDf+QeQqPjdXgZ7
	irU/OKd9G/B/DZGsGYAROwNwlOzPD8GNzhnzLnqp2D39sUPwwf3omFvUWRiAX+6DSoSpaSOZxfA
	CjK7q6QUwnWdD1iqjehmk7mTwmeABYVG2amneVEJTGjYY5XPeW+6FDLplV/3QDB0F/tbqhZsfed
	MprD3UA+Y1XDbyjM6c2RT8p0on5kVEFz5dTk+70fxPzoOb16s2u/EAqNgCBa2NaIqmbZ5hkuBpY
	LRvT1tzmJ5LusAs56xuLVbsdD0XKZPvcZFq5nbKgCSIMNZYkY7QgsAumeFaz9XgCgiYAxixTMvh
	c3Hf/jnxyje67gCDsIT3LhzM9UGs/RIW/4rXY=
X-Google-Smtp-Source: AGHT+IF8lSbhJg6NWareXReloPk53nr4C4bQhOD0L2yHAGlFyUQYWDJJ/aZdca8GycL3Iu1EPn8xRb2Jwlhu
X-Received: by 2002:a05:7022:6b8a:b0:119:e569:fba6 with SMTP id a92af1059eb24-11b410f46d1mr875582c88.21.1763103107462;
        Thu, 13 Nov 2025 22:51:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-11b0609138asm173917c88.6.2025.11.13.22.51.47
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Nov 2025 22:51:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-341aec498fdso2664790a91.2
        for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 22:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763103105; x=1763707905; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aU7bxcMOkucHC3X4c+h1EhVKMXxUUNmIsCk1ha4lo10=;
        b=FiFkOqgvwtUjUG4QupfpBo5x4XD0ap4mpjnTtFVaCFOyebEqbvNogMdy6RInRXFhVl
         8/MOoNUjYohgzkKiKQba1xp8cfjapkXD25Zdw0g1tPJXWwObIl/2+WhWAmPkCwYYss+n
         lIvUnZyH4LI6A4DyMaB7jebq0TtvxqUAyaekE=
X-Forwarded-Encrypted: i=1; AJvYcCXz+bklE3euZxNves6fjv/ueHPZmsfCC2tDTJxkTNRLLdIpGVWiYzYnfJ4G6lHkC04e36znxv7yJOpQ@vger.kernel.org
X-Received: by 2002:a17:90b:2b48:b0:32c:2cd:4d67 with SMTP id 98e67ed59e1d1-343f9ec8fe5mr2125230a91.13.1763103105613;
        Thu, 13 Nov 2025 22:51:45 -0800 (PST)
X-Received: by 2002:a17:90b:2b48:b0:32c:2cd:4d67 with SMTP id
 98e67ed59e1d1-343f9ec8fe5mr2125210a91.13.1763103105211; Thu, 13 Nov 2025
 22:51:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922154303.246809-1-siva.kallam@broadcom.com> <20251113114348.GC10544@unreal>
In-Reply-To: <20251113114348.GC10544@unreal>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Fri, 14 Nov 2025 12:21:33 +0530
X-Gm-Features: AWmQ_blynz3VTHTgCy7gBRkSNijZUVCCfLqGKZEZ-qJNOtGDjbdQoZ4REubWFZE
Message-ID: <CAMet4B5SjY-6_dGU8g1tGcnkoxasi3LafJkeYR+QPTCETJWv7g@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Introducing Broadcom BNG_RE RoCE Driver
To: Leon Romanovsky <leonro@nvidia.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	vikas.gupta@broadcom.com, selvin.xavier@broadcom.com, 
	anand.subramanian@broadcom.com, usman.ansari@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000054d2460643886e1a"

--00000000000054d2460643886e1a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 5:14=E2=80=AFPM Leon Romanovsky <leonro@nvidia.com>=
 wrote:
>
> On Mon, Sep 22, 2025 at 03:42:55PM +0000, Siva Reddy Kallam wrote:
> > Hi,
>
> <...>
>
> > Siva Reddy Kallam (7):
> >   RDMA/bng_re: Add Auxiliary interface
> >   RDMA/bng_re: Register and get the resources from bnge driver
> >   RDMA/bng_re: Allocate required memory resources for Firmware channel
> >   RDMA/bng_re: Add infrastructure for enabling Firmware channel
> >   RDMA/bng_re: Enable Firmware channel and query device attributes
> >   RDMA/bng_re: Add basic debugfs infrastructure
> >   RDMA/bng_re: Initialize the Firmware and Hardware
> >
> > Vikas Gupta (1):
> >   bng_en: Add RoCE aux device support
>
> There are some nitpicks which I wanted to fix while applying,
> but it doesn't apply to rdma-next.
>
> ...
> Applying: bng_en: Add RoCE aux device support
> Patch failed at 0001 bng_en: Add RoCE aux device support
> error: patch failed: drivers/net/ethernet/broadcom/bnge/bnge_core.c:296
> error: drivers/net/ethernet/broadcom/bnge/bnge_core.c: patch does not app=
ly
> error: patch failed: drivers/net/ethernet/broadcom/bnge/bnge_resc.h:72
> error: drivers/net/ethernet/broadcom/bnge/bnge_resc.h: patch does not app=
ly
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abo=
rt".
> hint: Disable this message with "git config set advice.mergeConflict fals=
e"
> Press any key to continue...
>
> Thanks
Thanks Leon. We will fix it in the next version of the patchset.
>
>
> >
> >  MAINTAINERS                                   |   7 +
> >  drivers/infiniband/Kconfig                    |   1 +
> >  drivers/infiniband/hw/Makefile                |   1 +
> >  drivers/infiniband/hw/bng_re/Kconfig          |  10 +
> >  drivers/infiniband/hw/bng_re/Makefile         |   8 +
> >  drivers/infiniband/hw/bng_re/bng_debugfs.c    |  39 +
> >  drivers/infiniband/hw/bng_re/bng_debugfs.h    |  12 +
> >  drivers/infiniband/hw/bng_re/bng_dev.c        | 539 ++++++++++++
> >  drivers/infiniband/hw/bng_re/bng_fw.c         | 767 ++++++++++++++++++
> >  drivers/infiniband/hw/bng_re/bng_fw.h         | 211 +++++
> >  drivers/infiniband/hw/bng_re/bng_re.h         |  86 ++
> >  drivers/infiniband/hw/bng_re/bng_res.c        | 279 +++++++
> >  drivers/infiniband/hw/bng_re/bng_res.h        | 215 +++++
> >  drivers/infiniband/hw/bng_re/bng_sp.c         | 131 +++
> >  drivers/infiniband/hw/bng_re/bng_sp.h         |  47 ++
> >  drivers/infiniband/hw/bng_re/bng_tlv.h        | 128 +++
> >  drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
> >  drivers/net/ethernet/broadcom/bnge/bnge.h     |  10 +
> >  .../net/ethernet/broadcom/bnge/bnge_auxr.c    | 258 ++++++
> >  .../net/ethernet/broadcom/bnge/bnge_auxr.h    |  84 ++
> >  .../net/ethernet/broadcom/bnge/bnge_core.c    |  18 +-
> >  .../net/ethernet/broadcom/bnge/bnge_hwrm.c    |  40 +
> >  .../net/ethernet/broadcom/bnge/bnge_hwrm.h    |   2 +
> >  .../net/ethernet/broadcom/bnge/bnge_resc.c    |  12 +
> >  .../net/ethernet/broadcom/bnge/bnge_resc.h    |   1 +
> >  25 files changed, 2907 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/infiniband/hw/bng_re/Kconfig
> >  create mode 100644 drivers/infiniband/hw/bng_re/Makefile
> >  create mode 100644 drivers/infiniband/hw/bng_re/bng_debugfs.c
> >  create mode 100644 drivers/infiniband/hw/bng_re/bng_debugfs.h
> >  create mode 100644 drivers/infiniband/hw/bng_re/bng_dev.c
> >  create mode 100644 drivers/infiniband/hw/bng_re/bng_fw.c
> >  create mode 100644 drivers/infiniband/hw/bng_re/bng_fw.h
> >  create mode 100644 drivers/infiniband/hw/bng_re/bng_re.h
> >  create mode 100644 drivers/infiniband/hw/bng_re/bng_res.c
> >  create mode 100644 drivers/infiniband/hw/bng_re/bng_res.h
> >  create mode 100644 drivers/infiniband/hw/bng_re/bng_sp.c
> >  create mode 100644 drivers/infiniband/hw/bng_re/bng_sp.h
> >  create mode 100644 drivers/infiniband/hw/bng_re/bng_tlv.h
> >  create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
> >  create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_auxr.h
> >
> > --
> > 2.34.1
> >
> >

--00000000000054d2460643886e1a
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
QSAyMDIzAgxoOshI0IGR+aGCCXkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIEUp
txHROlq8MTApbhe+7PT6ftQlNB4VY803AATHgS/iMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI1MTExNDA2NTE0NVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBABigcxkgMQ3o2J1/2/Xa+niVRAcS3AcAlsjamCQE
baWEXdpA8Ztq3gJdVKgS2BWQsY0WIYhVIJj+nzNcuWrfB/nIKzbLBsXzrnJHVEWmyiZFCH7geXYE
qewSq6trGoeBtLj+dB3Vc8zZ5u7lMWPirZT9/JzBS3DUX11ABk1lq8dLQjM0FCeZ4e6OPH8VcrO5
RjdFQmHk2YuKgY7HiU5R+bBdhKBOrPyh4tp3p7YieMlzSBqhPrg5aUUGnufuZd9ei66nhGirSfy4
t02Q1zjf2Cj0RbZV7d8Atee6/5J5QwKj8DS6fWv/Zc3KirZE+2jJpDt546KoTIk1K2uoHYqRL6I=
--00000000000054d2460643886e1a--

