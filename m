Return-Path: <linux-rdma+bounces-6726-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9438A9FBCC5
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 11:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C384160EE7
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 10:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBCF1B3945;
	Tue, 24 Dec 2024 10:51:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3DA1AF0CE;
	Tue, 24 Dec 2024 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.164.42.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735037492; cv=none; b=hdr5f7PD6KGYe4qjiEnkxtK2VKYEZz7djiDmr2cen1lKQMmjRo5jSRMK8sCzFXZLJ7Pn0Fl7Gvn5aGp4TZOszGV44tIDXFzBMPtxevZNYfjelRfaj4tHHhQlRoIVXEJenccWlbH1BKP/RYd9DbWMDfsn5INuh6RcYsh2Txsb5KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735037492; c=relaxed/simple;
	bh=XWfHCYpGwaz9vLxtProlRg/Hu4G5CO64KbOMNvuPBOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=SDvDoQmRb83EjHar950E8C5ctAEvIhRiBFKX8MocpgvjOjCKaSjG0QEu6xrqx4fhk+nsx9UMuBUM+eInKHsA4Pjnb+eEV8ZHmVhowjrMxcZ6xm39edLNalFMxPe8tUwYu3ZkdWkSnh4P8cPje7ixKDlPqS728MJwzmHphuuQt1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=61.164.42.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from linma$zju.edu.cn ( [10.192.155.25] ) by
 ajax-webmail-mail-app2 (Coremail) ; Tue, 24 Dec 2024 18:51:27 +0800
 (GMT+08:00)
Date: Tue, 24 Dec 2024 18:51:27 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Leon Romanovsky" <leon@kernel.org>
Cc: jgg@ziepe.ca, cmeiohas@nvidia.com, michaelgur@nvidia.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] RDMA/iwpm: reentrant iwpm hello message
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240625(a75f206e) Copyright (c) 2002-2024 www.mailtech.cn zju.edu.cn
In-Reply-To: <20241224092938.GC171473@unreal>
References: <661ee85f.a4a2.193e4b2f91b.Coremail.linma@zju.edu.cn>
 <20241224092938.GC171473@unreal>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <103c061b.e87e.193f84b0840.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID:by_KCgBnB5MvkmpnCtuhAA--.12409W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwIFEmdpbCIakQAAsd
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGVsbG8gTGVvbiwKCj4gCj4gSSdtIG5vdCBmdWxseSB1bmRlcnN0YW5kIHRoZSBsb2NrZGVwIGhl
cmUuIFdlIHVzZSBkb3duX3JlYWQoKSwgd2hpY2ggaXMKPiByZWVudHJ5IHNhZmUuCj4gCgpSZWFs
bHk/IFRvIG15IGtub3dsZWRnZSwgdGhvdWdoIGRvd25fcmVhZCgpIGl0c2VsZiB3aWxsIG5vdCB0
cmlnZ2VyIGxvY2tpbmcKZXJyb3JzLiBCdXQgYmVsb3cgc2NlbmFyaW8gd2lsbCBsZWFkIHRvIGRl
YWRsb2NrLCBhbmQgdGhhdCdzIHdoeSB0aGlzCldBUk5JTkcgaXMgcmFpc2VkLgoKICAgQ1BVMCAg
ICAgICAgICAgICAgICBDUFUxCiAgIC0tLS0gICAgICAgICAgICAgICAgLS0tLQpkb3duX3JlYWQo
KVsxXQogICAgICAgICAgICAgICAgICBkb3duX3dyaXRlKClbMl0KZG93bl9yZWFkKClbM10KCklm
IENQVTEgdGhyZWFkIG5vdCBleGlzdHMsIHRoZSBDUFUwIHdpbGwgcnVuIHNtb290aGx5IChIb3dl
dmVyLCBpdCB3aWxsIGtlZXAKbG9vcGluZyBhbmQgdGhlIFBvQyBjYW5ub3QgYmUga2lsbGVkIGJ5
IGFueSBzaWduYWwsIGNhdXNpbmcgRGVuaWFsLW9mLVNlcnZpY2UpLgoKV2hlbiBDUFUxIGNhbGxz
IGRvd25fd3JpdGUoKSwgaXQgd2lsbCB3YWl0IGZvciBbMV0gdG8gYmUgcmVsZWFzZWQuCkhvd2V2
ZXIsIHdoZW4gWzNdIGlzIGNhbGxlZCwgaXQgd2lsbCB0aGVuIHdhaXQgZm9yIFsyXSB0byBiZSBy
ZWxlYXNlZCwKbGVhZGluZyB0byBhIGRlYWRsb2NrIHNpdHVhdGlvbi4KClBsZWFzZSBsZXQgbWUg
a25vdyBpZiBJIHVuZGVyc3RhbmQgdGhpcyBjb3JyZWN0bHkgb3IgaW5jb3JyZWN0bHk/CgpUaGFu
a3MsCkxpbgo=

