Return-Path: <linux-rdma+bounces-6501-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B076C9F040C
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 06:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8D916A172
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 05:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B371684AC;
	Fri, 13 Dec 2024 05:15:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D30A80B;
	Fri, 13 Dec 2024 05:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734066934; cv=none; b=ZIEM88/FGK0/5/y9uYXeoEVmkCI27j2F4K9xJLlBqq2S8GgBf6Zd6Px5Skjtoi2ZDKFLQ67IbMH+PG0SqkMlptu9lkmc84wVm7gsYdyLPQLGSvB3znZ6ZJSw6/aWMbXAxEeab7gZ+gs249Q+aZlt1sFsrT9xxJ/Z7R1N86Qy6RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734066934; c=relaxed/simple;
	bh=RNegVMeUzmHjlB1Zs2yb8+wR3Yav6ylxo9nkvxy0vTA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D1HR2KOWGgr4KEMdTsAMJA85I6sqkJBpBpnAJ9hw+Mo2K8IWxmr0JSXLBgtY1eUvE7L3Gz6WDHnPUmyzw/GVkxVaVWPdNEJGExuQKNL0irB1oD5kJjuzFgXpmMgdQ++bVeMtsW2ZkrKifnZIFpw6kQ2LI2nHZm6HwjfHOo8Z930=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: "saeedm@nvidia.com" <saeedm@nvidia.com>, "leon@kernel.org"
	<leon@kernel.org>, "tariqt@nvidia.com" <tariqt@nvidia.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXVtuZXQtbmV4dF0gbmV0L21seDU6IFBpY2sgdGhlIGZp?=
 =?gb2312?B?cnN0IG1hdGNoZWQgbm9kZSBvZiBwcml2LmZyZWVfbGlzdCBpbiBhbGxvY180?=
 =?gb2312?Q?k?=
Thread-Topic: [PATCH][net-next] net/mlx5: Pick the first matched node of
 priv.free_list in alloc_4k
Thread-Index: AQHa9SQKbu2MLSbO/UqzPRUr7o8sl7LkSHtw
Date: Fri, 13 Dec 2024 04:43:45 +0000
Message-ID: <e2a50fa8fd79488cb047018713e14731@baidu.com>
References: <20240823061648.17862-1-lirongqing@baidu.com>
In-Reply-To: <20240823061648.17862-1-lirongqing@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.56
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 52:10:53:SYSTEM

DQo+IFBpY2sgdGhlIGZpcnN0IG5vZGUgaW5zdGVhZCBvZiBsYXN0LCB0byBhdm9pZCB1bm5lY2Vz
c2FyeSBpdGVyYXRpbmcgb3ZlciB3aG9sZQ0KPiBmcmVlIGxpc3QNCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IExpIFJvbmdRaW5nIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvcGFnZWFsbG9jLmMgfCAxICsNCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9wYWdlYWxsb2MuYw0KPiBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9wYWdlYWxsb2MuYw0KPiBpbmRleCA5NzJl
OGU5Li5jZDIwZjExIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5v
eC9tbHg1L2NvcmUvcGFnZWFsbG9jLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVs
bGFub3gvbWx4NS9jb3JlL3BhZ2VhbGxvYy5jDQo+IEBAIC0yMjgsNiArMjI4LDcgQEAgc3RhdGlj
IGludCBhbGxvY180ayhzdHJ1Y3QgbWx4NV9jb3JlX2RldiAqZGV2LCB1NjQNCj4gKmFkZHIsIHUz
MiBmdW5jdGlvbikNCj4gIAkJaWYgKGl0ZXItPmZ1bmN0aW9uICE9IGZ1bmN0aW9uKQ0KPiAgCQkJ
Y29udGludWU7DQo+ICAJCWZwID0gaXRlcjsNCj4gKwkJYnJlYWs7DQo+ICAJfQ0KPiANCj4gIAlp
ZiAobGlzdF9lbXB0eSgmZGV2LT5wcml2LmZyZWVfbGlzdCkgfHwgIWZwKQ0KPiAtLQ0KDQoNCnBp
bmcNCg0KPiAyLjkuNA0KDQo=

