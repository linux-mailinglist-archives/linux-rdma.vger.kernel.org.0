Return-Path: <linux-rdma+bounces-510-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 407948209CD
	for <lists+linux-rdma@lfdr.de>; Sun, 31 Dec 2023 06:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49C01F21FBC
	for <lists+linux-rdma@lfdr.de>; Sun, 31 Dec 2023 05:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1008915AA;
	Sun, 31 Dec 2023 05:28:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E4E139D;
	Sun, 31 Dec 2023 05:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from linma$zju.edu.cn ( [10.192.23.73] ) by ajax-webmail-mail-app3
 (Coremail) ; Sun, 31 Dec 2023 13:27:59 +0800 (GMT+08:00)
Date: Sun, 31 Dec 2023 13:27:59 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Leon Romanovsky" <leon@kernel.org>
Cc: jgg@ziepe.ca, gustavoars@kernel.org, bvanassche@acm.org, 
	markzhang@nvidia.com, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] RDMA/sa_query: use validate not parser in
 ib_nl_is_good_resolve_resp
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20231230154422.GB6849@unreal>
References: <20231230051956.82499-1-linma@zju.edu.cn>
 <20231230154422.GB6849@unreal>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7d95dbb5.63777.18cbe57e107.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cC_KCgB37o3f+5Blea+pAQ--.50048W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGVsbG8gTGVvbiwKCj4gPiBUaGUgYXR0cmlidXRlcyBhcnJheSBgdGJgIGluIGliX25sX2lzX2dv
b2RfcmVzb2x2ZV9yZXNwIGlzIG5ldmVyIHVzZWQKPiA+IGFmdGVyIHRoZSBwYXJzaW5nLiBUaGVy
ZWZvcmUgdXNlIG5sYV92YWxpZGF0ZV9kZXByZWNhdGVkIGZ1bmN0aW9uIGhlcmUKPiA+IGZvciBp
bXByb3ZlbWVudC4KPiAKPiBXaGF0IGRpZCB0aGlzIGNoYW5nZSBpbXByb3ZlPwo+IAoKVG8gbXkg
Y29uY2VybiwgdGhlIG5sYV92YWxpZGF0ZV9kZXByZWNhdGVkLCBjb21wYXJlZCB0byBubGFfcGFy
c2VfZGVwcmVjYXRlZCwKd2lsbCBhdCBsZWFzZSBzYXZlIGEgbWVtc2V0IGluIGZ1bmN0aW9uIG5s
YV9wYXJzZV9kZXByZWNhdGVkCgpgYGAKaWYgKHRiKQogICAgbWVtc2V0KHRiLCAwLCBzaXplb2Yo
c3RydWN0IG5sYXR0ciAqKSAqIChtYXh0eXBlICsgMSkpOwpgYGAKCk1vcmV2ZXIsIGJlY2F1c2Ug
dGhlIGBubGFfdmFsaWRhdGVfZGVwcmVjYXRlZGAganVzdCB2YWxpZGF0ZSB0aGUgYXR0cmlidXRl
cwphcnJheSBhbmQgd2lsbCBub3QgdHJ5IHRvIHJldHJpZXZlIHRoZSBubGEgcG9pbnRlcnMuIEl0
IHNoYWxsIGJlIGZhc3RlcgphbmQgY2xlYW5lciBoZXJlIDpELgoKUmVnYXJkcwpMaW4=

