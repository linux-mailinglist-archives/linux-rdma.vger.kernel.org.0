Return-Path: <linux-rdma+bounces-12255-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7ACB08BD0
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 13:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979E1565639
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 11:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23CE29A9FA;
	Thu, 17 Jul 2025 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fm5e9OeD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4BB1F9F73;
	Thu, 17 Jul 2025 11:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752752201; cv=none; b=n0R5ECsL0lctqobI5WDYKcc04qsg05sSdUpOQomupkJ/cPxmAwrvNmkaJ/kHrG4jJsaxDRoZFg3eag1P9oeZLiS3H5chMEHbqyDnQZ+Ae0R1DxlsSQLD/gtFM4B2XXl0o2SLY26CJaYsR5Br4CmfBWtIdqF91vHnPxuHLj7Dd4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752752201; c=relaxed/simple;
	bh=CopaLqgtv7vy5sHCEwuoWUoEfpGYaEd/LRi2DZof3f0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=cgkQHJhRyF6HoSKNQRgF3KKVCI4bd9HL8kj3YNombMB/ahT1xEX1sfiFvKk6ppZA4MM1fmt4AKrqAD1ILWlC7Q6K5IOOJOK7mg0SjRr7uYJKCfl2AEwNOUxrsTR8GVELjSMSDcn6nJt48SO0ng2BPojmFFzEB3hlIUwHJtbAl6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fm5e9OeD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451d6ade159so5823895e9.1;
        Thu, 17 Jul 2025 04:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752752198; x=1753356998; darn=vger.kernel.org;
        h=autocrypt:subject:from:cc:to:content-language:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CopaLqgtv7vy5sHCEwuoWUoEfpGYaEd/LRi2DZof3f0=;
        b=fm5e9OeD73v6zJLWbyL61SQEYleWolaOHxvaOjk6FbVvYidD95U9jMjyOIYlT49UsA
         xwXlcP6dhyZ78vRwmzSk8LWiJ4IPqWYVm8A3z7FWmV0CyVXbEMlRh2IC/0yJahl1EA5L
         jwyMKRZc4/v67F1P4hE57qPd6vHJhOvZXV5Gp34fCWIsYb+h+QtL5nd4rGMnFt0kQr22
         X6I55lz6bePi9sP2//mEVonR4keaxwwc29oNSj//DK4XY75itGcz207LNAjI9kNw2PeY
         6pHjhGBiA/q6+ssY7u6al8NbjfV2SUA56pB7HDJqbIy+91e5GS4lMtjPP7NbZMmtIaqE
         HlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752752198; x=1753356998;
        h=autocrypt:subject:from:cc:to:content-language:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CopaLqgtv7vy5sHCEwuoWUoEfpGYaEd/LRi2DZof3f0=;
        b=W2sYW7wcX2uk1ZezQETCSmyNi527+qqFh5T5hii//eB4DAQvLE14NiAW6rjtbkY0S9
         wSrK2yBXMhWdZGDdZnOMgOUs9Xehmgd16/saE/s6p35ycp9ByFDJ9TyQKG0pQFU6ezhy
         A+87LzyLg2B1Wo34ThyC8X+A3lxnv+r46wfmnPalseB5T/wvQRsfaSAapKx/u2dDbqCP
         1zUhaWPkWbtq0sA2c9ImtJQbxV9W7BdCPni5FLHDnTY9pvSee+Pq/qK4uPh/NBdeBPKd
         xXl5/uQnEiEfJt5mbPSptVGMHal4oWy1LJ1tgUVDKF6LZi9tG5OKjj9gyoR0selN4jLx
         yJLA==
X-Forwarded-Encrypted: i=1; AJvYcCWP47RsjlpPUI7jaaqy2WnhBMDuhsDCG+hlSPfT7PeFn0tc2YR4zju9bPgrtpVdH5OvTO1Q568vvHhknw==@vger.kernel.org, AJvYcCWvuzaaicd/Th/grPNyjRXpI98kXL43nF5tA7j4B6o8tvJEbEH6QtL5xAveVV+RwNE3wq5IBSE6iH3ZxEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweneb5kowzjRg7ZyKd4jET/LMH5Gzyh8jJhoTMC1stoxgViCAk
	ylJpcN0pre58m9ZY1O1rK8b+NBTzaUsjilIHXLXp5PYfFCGSqnddPUHw
X-Gm-Gg: ASbGncvxWS/OROq+cj8fAk1EDAqxHHlzimn35rTW1SMT9VYP+rKosI+Q5MXe3Uww2zs
	NtJMxgoz/GGLNo0mzcSVvaOazV9xJXppMtzGGOrvnFnPaUQiPXuPwMgLy2rLI4V9kfNhyq5HIaT
	GDMJmG908mOtiogdOf8zReqAGqrz/JVWPw+KTPwY3HUyL7FzCtdOKfqnIkQqqInUp8p5OW07H6u
	/xtFxJTFbvW0rwlo0DPWKWFI4AN8wgc2JxjqcnFi95dQ+0XNkLhLj9kcwOQuBUND/qpKeg2WA6h
	XBAsUX5m5yHnGaXEdPbgj1CtyEamcYHJcDouSFmCfQkpT86eGEmFzSRhE5v+EBiGqjnk8Ik+uAk
	ILefWHJkTFalbDrAiAeZYktepysCB
X-Google-Smtp-Source: AGHT+IHA4U1/M+N12o2Y+P/Ies2yrf6SWS2E6KMVPy57JBYNEI8QWjxpIadMm79F+4BsbDfYG0P83w==
X-Received: by 2002:a05:600c:35cd:b0:456:1a87:a6cb with SMTP id 5b1f17b1804b1-4562e38aa91mr64634155e9.19.1752752197931;
        Thu, 17 Jul 2025 04:36:37 -0700 (PDT)
Received: from [192.168.1.248] ([87.254.0.133])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2d4fsm49780145e9.4.2025.07.17.04.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:36:37 -0700 (PDT)
Message-ID: <79166fb1-3b73-4d37-af02-a17b22eb8e64@gmail.com>
Date: Thu, 17 Jul 2025 12:36:06 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Edward Srouji <edwards@nvidia.com>,
 Michael Guralnik <michaelgur@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-rdma@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: RDMA/mlx5: issue with error checking
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------mOTXFpSu00dRdQYx0aZMQOvq"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------mOTXFpSu00dRdQYx0aZMQOvq
Content-Type: multipart/mixed; boundary="------------OZ6mM97AD65Cz3rVTTan5rjv";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Edward Srouji <edwards@nvidia.com>,
 Michael Guralnik <michaelgur@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-rdma@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <79166fb1-3b73-4d37-af02-a17b22eb8e64@gmail.com>
Subject: RDMA/mlx5: issue with error checking

--------------OZ6mM97AD65Cz3rVTTan5rjv
Content-Type: multipart/mixed; boundary="------------ySe1UfZVhYZbzGbNs72NYxI3"

--------------ySe1UfZVhYZbzGbNs72NYxI3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KU3RhdGljIGFuYWx5c2lzIGRldGVjdGVkIGFuIGlzc3VlIHdpdGggdGhlIGZvbGxv
d2luZyBjb21taXQ6DQoNCmNvbW1pdCBlNzMyNDJhYTE0ZDJlYzdmNGExYTEzNjg4MzY2YmIz
NmRjMGZlNWI3DQpBdXRob3I6IEVkd2FyZCBTcm91amkgPGVkd2FyZHNAbnZpZGlhLmNvbT4N
CkRhdGU6ICAgV2VkIEp1bCA5IDA5OjQyOjExIDIwMjUgKzAzMDANCg0KICAgICBSRE1BL21s
eDU6IE9wdGltaXplIERNQUJVRiBta2V5IHBhZ2Ugc2l6ZQ0KDQoNClRoZSBpc3N1ZSBpcyBh
cyBmb2xsb3dzOg0KDQppbnQgbWx4NXJfdW1yX2RtYWJ1Zl91cGRhdGVfcGdzeihzdHJ1Y3Qg
bWx4NV9pYl9tciAqbXIsIHUzMiB4bHRfZmxhZ3MsDQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdW5zaWduZWQgaW50IHBhZ2Vfc2hpZnQpDQp7DQogICAgICAgICB1bnNp
Z25lZCBpbnQgb2xkX3BhZ2Vfc2hpZnQgPSBtci0+cGFnZV9zaGlmdDsNCiAgICAgICAgIHNp
emVfdCB6YXBwZWRfYmxvY2tzOw0KICAgICAgICAgc2l6ZV90IHRvdGFsX2Jsb2NrczsNCiAg
ICAgICAgIGludCBlcnI7DQoNCiAgICAgICAgIHphcHBlZF9ibG9ja3MgPSBfbWx4NXJfdW1y
X3phcF9ta2V5KG1yLCB4bHRfZmxhZ3MsIHBhZ2Vfc2hpZnQsDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtci0+ZGF0YV9kaXJlY3QpOw0KICAgICAg
ICAgaWYgKHphcHBlZF9ibG9ja3MgPCAwKQ0KICAgICAgICAgICAgICAgICByZXR1cm4gemFw
cGVkX2Jsb2NrczsNCg0KVGhlIHZhcmlhYmxlIHphcHBlZF9ibG9ja3MgaXMgYSBzaXplX3Qg
dHlwZSBhbmQgaXMgYmVpbmcgYXNzaWduZWQgYSBpbnQgDQpyZXR1cm4gdmFsdWUgZnJvbSB0
aGUgY2FsbCB0byBfbWx4NXJfdW1yX3phcF9ta2V5LiBTaW5jZSB6YXBwZWRfYmxvY2tzIA0K
aXMgYW4gdW5zaWduZWQgdHlwZSwgdGhlIGVycm9yIGNoZWNrIGZvciB6YXBwZWRfYmxvY2tz
IDwgMCB3aWxsIG5ldmVyIGJlIA0KdHJ1ZS4gIEkgc3VzcGVjdCB0b3RhbF9ibG9ja3Mgc2hv
dWxkIGJlIGEgc3NpemVfdCB0eXBlLCBidXQgdGhhdCANCnByb2JhYmx5IGFsc28gbWVhbnMg
dG90YWxfYmxvY2tzIHNob3VsZCBiZSBzc2l6ZV90IHRvbywgYnV0IGRvbid0IGhhdmUgDQp0
aGUgaGFyZHdhcmUgdG8gdGVzdCB0aGlzIGZpeCBhbmQgSSdtIGNvbmNlcm5lZCB0aGF0IHRo
aXMgY2hhbmdlIG1heSANCmJyZWFrIHRoZSBjb2RlLiBIZW5jZSBJJ20gcmVwb3J0aW5nIHRo
aXMgaXNzdWUuDQoNCkNvbGluDQoNCg0K
--------------ySe1UfZVhYZbzGbNs72NYxI3
Content-Type: application/pgp-keys; name="OpenPGP_0x68C287DFC6A80226.asc"
Content-Disposition: attachment; filename="OpenPGP_0x68C287DFC6A80226.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBE6TJCgBEACo6nMNvy06zNKj5tiwDsXXS+LhT+LwtEsy9EnraKYXAf2xwazc
ICSjX06efanlyhB0figzQO0n/tP7BcfMVNG7n1+DC71mSyRK1ZERcG1523ajvdZO
xbBCTvTitYOy3bjs+LXKqeVMhK3mRvdTjjmVpWnWqJ1LL+Hn12ysDVVfkbtuIm2N
oaSEC8Ae8LSSyCMecd22d9PnLR4UeFgrWEkQsqROq6ZDJT9pBLGe1ZS0pVGhkRyB
P9GP65oPev39SmfAx9R92SYJygCy0pPvBMWKvEZS/7bpetPNx6l2xu9UvwoeEbpz
UvH26PHO3DDAv0ynJugPCoxlGPVf3zcfGQxy3otydNTWkP6Wh3Q85m+AlifgKZud
jZLrO6c+fAw/jFu1UMjNuyhgShtFU7NvEzL3RqzFf9O1qM2muj83IeFQ1FZ65QAi
CdTa3npz1vHc7N4uEQBUxyXgXfCI+A5yDnjHwzU0Y3RYS52TA3nfa08yLGPLTf5w
yAREkFYou20vh5vRvPASoXx6auVf1MuxokDShVhxLpryBnlKCobs4voxN54BUO7m
zuERXN8kadsxGFzItAyfKYzEiJrpUB1yhm78AecDyiPlMjl99xXk0zs9lcKriaBy
VUv/NsyJFQj/kmdxox3XHi9K29kopFszm1tFiDwCFr/xumbZcMY17Yi2bQARAQAB
zSdDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT7CwZEEEwEI
ADsCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQRwYtqk8AG5xmFnAM9owoff
xqgCJgUCY8GcawIZAQAKCRBowoffxqgCJtd/EACIWcaxfVt/MH4qqo5ELsjCFPVp
+RhVpQDWy8v9Np2YbTcZ4AY2Zj4Pq/HrZ3F/Bh02v85C6mNv8BDTKev6Qcq3BYw0
iqw6/xLNvRcSFHM81mQI9xtnAWIWfI9k5hpX19QooPIIP3GOMdMc1uRUGTxTgTFA
AsAswRY3kMzo6k7arQnUs9zbiZ9SmS43qWOIxzGnvneekHHDAcomc/oho7kgj6rK
p/f9qRrhForkgVQwdj6iBlW934yRXzeFVF3wr7Lk5GQNIEkJiNQPZs54ojBS/Kx6
3UTLT1HgOp6UY9RPEi9wubmUR+J6YjLRZMr5PCcA86EYmRoysnnJ8Q/SlBVD8npp
GVEcuvrbH3MBfhmwOPDc3RyLkEtKfSTB92k1hsmRkx9zkyuUzhcSnqQnpWGJD+xt
KHvcHRT7Uxaa+SDwUDM36BjkyVcZQy8c+Is2jA55uwNgPpiA7n82pTeT+FRGd+7i
CLQHaryu6FO6DNDv09RbPBjIiC/q814aeKJaSILP1ld9/PEBrLPdm+6lG6OKOt9D
DV6jPmfR96FydjxcmI1cgZVgPomSxv2JB1erOggB8rmX4hhWYsVQl1AXZs3LdEpJ
6clmCPspn/ufZxHslgR9/WR1EvPMQc8XtssF55p8ehRIcVSXDRcMFr3ZuqMTXcL6
8YbDmv5OGS95O1Gs4c0iQ29saW4gS2luZyA8Y29saW4ua2luZ0B1YnVudHUuY29t
PsLBdwQTAQgAIQUCTwq47wIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBo
woffxqgCJo1bD/4gPIQ0Muy5TGHqTQ/bSiQ9oWjS5rAQvsrsVwcm2Ka7Uo8LzG8e
grZrYieJxn3Qc22b98TiT6/5+sMa3XxhxBZ9FvALve175NPOz+2pQsAV88tR5NWk
5YSzhrpzi7+klkWEVAB71hKFZcT0qNlDSeg9NXfbXOyCVNPDJQJfrtOPEuutuRuU
hrXziaRchqmlhmszKZGHWybmPWnDQEAJdRs2Twwsi68WgScqapqd1vq2+5vWqzUT
JcoHrxVOnlBq0e0IlbrpkxnmxhfQ+tx/Sw9BP9RITgOEFh6tf7uwly6/aqNWMgFL
WACArNMMkWyOsFj8ouSMjk4lglT96ksVeCUfKqvCYRhMMUuXxAe+q/lxsXC+6qok
Jlcd25I5U+hZ52pz3A+0bDDgIDXKXn7VbKooJxTwN1x2g3nsOLffXn/sCsIoslO4
6nbr0rfGpi1YqeXcTdU2Cqlj2riBy9xNgCiCrqrGfX7VCdzVwpQHyNxBzzGG6JOm
9OJ2UlpgbbSh6/GJFReW+I62mzC5VaAoPgxmH38g0mA8MvRT7yVpLep331F3Inmq
4nkpRxLd39dgj6ejjkfMhWVpSEmCnQ/Tw81z/ZCWExFp6+3Q933hGSvifTecKQlO
x736wORwjjCYH/A3H7HK4/R9kKfL2xKzD+42ejmGqQjleTGUulue8JRtpM1AQ29s
aW4gSWFuIEtpbmcgKEludGVsIENvbGluIElhbiBLaW5nIGtleSkgPGNvbGluLmtp
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
=3DQKm6
-----END PGP PUBLIC KEY BLOCK-----

--------------ySe1UfZVhYZbzGbNs72NYxI3--

--------------OZ6mM97AD65Cz3rVTTan5rjv--

--------------mOTXFpSu00dRdQYx0aZMQOvq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmh44CYFAwAAAAAACgkQaMKH38aoAiZq
SRAAjB4pLLbSOc1YzKsWy5C35c8YTMMhQprUyqfHhJS7ROxVqKqqYh6Bn2DXu3BBTIieR0RhiGqc
kiup3GkvV01yaKZXkEZyGhNtzPQqIhZP4zFuuyT7jHzkg0w5h3zbLm3F+foZ/0dPhvLZwil1jS6B
cim5FRvhlzptZTpaMY1W2mLXt5Rwv8+8BGuGa/UTtBgCJdC98rYd2aypscVSqQ9pEZUKJuewERLT
jpL6hObMZ9V2bW0GZr5vsyanyJzjBn7fJLvAcypOD5nObSKfU+RxGt16wc/AX0AToZWCMgwFMPFo
LwLJbfuLgSwpXybt5FlFC9YOUt75CUboy+GiMGUYn2InH1mmnY8USN5sDjYPjUQAqIlJub7erUoL
AbUaaeSvnYdL5WCREvMDlAP2jtdx7ruM+L8RR5pS/28ahFITwzXgXGNjsqr01iei5gj+oTshD3gF
8+6jk+VVarxP68NVP2HDCSCJlmeHeSy0YyBvSkiFeuo0oh2dbfvZbBFv98pYn88F+pkAXtSi8u/h
KI2nB4ZYyPPzKbBN4qCv1FwbluzIgymOtbvIYETv1osTXveKglyCX5Lyi7OXmUdg/yJq6DWa4lYR
KlzyKpcwol8McnUnm4wt9uPk4VWdZictxlmSeClyjNMepmNjggTU+6w1LJA8BMR8EdSSNUWWm05h
qoc=
=Glto
-----END PGP SIGNATURE-----

--------------mOTXFpSu00dRdQYx0aZMQOvq--

