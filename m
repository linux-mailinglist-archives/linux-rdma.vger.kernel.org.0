Return-Path: <linux-rdma+bounces-4579-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B984960176
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 08:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF570281E28
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 06:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E007DA92;
	Tue, 27 Aug 2024 06:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="bLLVMHSJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15B2D51C
	for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2024 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739672; cv=none; b=piTSZOxq3NhtqlOmTMpuYr+a1irVGc8FYfhx26IPSufnfF3mZsBVReWwk/JzbM+xL2jWMA13amUjECxcFAvc4FOHgxtbty2iHUk216IuCWIvEQZJIhyJ+RtuORt9k+oOyuLFVp1B8rMieO3t1WNFS4FKorv0/EAi9ivL73QOSFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739672; c=relaxed/simple;
	bh=raOB06Ks/mzARgy2vk8b1tkkD8xrAQKbRyka8GUgY+8=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=ToS0Be8SK8AIMgaQQ76ifnxdTTQyr2Ly9Z92tZIDaoPNYwC2UatlDi7Qs9rDFAzt//XLe4DNoKucy8oAiBuOIQxheCYynKrgqLuyy302uDKM+KUjPkzKeOxajOvvB49ODXW2AtBfTWIAY1mFfWj/QfRfhRYaIkhsvIAfUYNylRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=bLLVMHSJ reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=UX4g4XAZ4APZYg8N7oWhcuO4nQUr6m8ma9i5kVLQP9g=; b=b
	LLVMHSJHLQOgjfXWIxoLGeYDW+nd+48l12wLDp98yUQqO/L2npUshufTIrRtdUcR
	3sDCBtLXlNkhiUu3zy5XoPyk6q0xqV3OYFDz83aQth5+OPB4S4uhxcvAolm7MCt4
	FR5q+TPVujyAp4dn+ba52vRljIA/sojG6Tjkv0tPrY=
Received: from jinwenbinxue$163.com ( [125.121.236.12] ) by
 ajax-webmail-wmsvr-40-103 (Coremail) ; Tue, 27 Aug 2024 14:20:59 +0800
 (CST)
Date: Tue, 27 Aug 2024 14:20:59 +0800 (CST)
From: =?UTF-8?B?6Z2z5paH5a6+?= <jinwenbinxue@163.com>
To: linux-rdma@vger.kernel.org
Subject: =?UTF-8?Q?[bug]_rdma-core/librdmacm/cma.c_r?=
 =?UTF-8?Q?dma=5Fcreate=5Fqp=5Fex=EF=BC=9Aadd_id->cq_refer?=
 =?UTF-8?Q?_to_qp=5Fattr->cq,_when_qp=5Fattr->cq?=
 =?UTF-8?Q?_is_not_NULL,_and_id->cq_is_NULL_?=
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2ZBvuYtk4u7yOfYukfmkwXh+87Ucaxs/wi2IRSNpp+jC3p/iQkfFhZPXXO78O0DQqWlAKNWwBA5OJeRql/fKQVqVK2wNqmdzJAxeof8223gA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <f819f8c.52ce.191927ea67c.Coremail.jinwenbinxue@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3X75LcM1mNws1AA--.9190W
X-CM-SenderInfo: 5mlq4vhqel05lxh6il2tof0z/1tbiUBpIQmXAmu6XgQABsG
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgpJIHRoaW5rIHRoZSBmb2xsb3dpbmcgbW9kaWZpY2F0aW9uIGlzIG1vcmUgY29ycmVjdCzC
oAppZiB0aGVyZSBoYXZlIHNvbWV0aGluZyBpIGRvbnQga25vdywgcGxzIHRlbGwgbWUsIHRoeAoK
CgoKCmRpZmYgLS1naXQgYS9saWJyZG1hY20vY21hLmMgYi9saWJyZG1hY20vY21hLmMKaW5kZXgg
N2I5MjRiZDBkLi45ZTcxYmE4NTggMTAwNjQ0Ci0tLSBhL2xpYnJkbWFjbS9jbWEuYworKysgYi9s
aWJyZG1hY20vY21hLmMKQEAgLTE2NTQsMTAgKzE2NTQsMjAgQEAgaW50IHJkbWFfY3JlYXRlX3Fw
X2V4KHN0cnVjdCByZG1hX2NtX2lkICppZCwKwqAgwqAgwqAgwqAgaWYgKHJldCkKwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgcmV0dXJuIHJldDsKCgotwqAgwqAgwqAgwqBpZiAoIWF0dHItPnNlbmRf
Y3EpCivCoCDCoCDCoCDCoGlmICghYXR0ci0+c2VuZF9jcSkgewrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBhdHRyLT5zZW5kX2NxID0gaWQtPnNlbmRfY3E7Ci3CoCDCoCDCoCDCoGlmICghYXR0ci0+
cmVjdl9jcSkKK8KgIMKgIMKgIMKgfSBlbHNlIHsKK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYg
KCFpZC0+cmVjdl9jcSkKK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWQtPnJl
Y3ZfY3EgPSBhdHRyLT5yZWN2X2NxOworwqAgwqAgwqAgwqB9CivCoCDCoCDCoCDCoGlmICghYXR0
ci0+cmVjdl9jcSkgewrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBhdHRyLT5yZWN2X2NxID0gaWQt
PnJlY3ZfY3E7CivCoCDCoCDCoCDCoH0gZWxzZSB7CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlm
ICghaWQtPnJlY3ZfY3EpCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlkLT5y
ZWN2X2NxID0gYXR0ci0+cmVjdl9jcTsKK8KgIMKgIMKgIMKgfQorCivCoCDCoCDCoCDCoArCoCDC
oCDCoCDCoCBpZiAoaWQtPnNycSAmJiAhYXR0ci0+c3JxKQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBhdHRyLT5zcnEgPSBpZC0+c3JxOwrCoCDCoCDCoCDCoCBxcCA9IGlidl9jcmVhdGVfcXBfZXgo
aWQtPnZlcmJzLCBhdHRyKTsKCgoKCgo=

