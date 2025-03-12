Return-Path: <linux-rdma+bounces-8608-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2135AA5DCC6
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 13:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 464137A40E4
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 12:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FC02417F0;
	Wed, 12 Mar 2025 12:36:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD161E489
	for <linux-rdma@vger.kernel.org>; Wed, 12 Mar 2025 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783010; cv=none; b=DHqHArdg+aTAYrFpMtoXUSNkUclPb3LLbRXdoPcQvDL4JCNR90e+faw+jmvb9/C8seCc5Svg/vCiV0C370rr2mCIcMj7U1F4ZJHRImCu8iPhPobc0e34Ie3C7tX8IQpQb49ZKqvJFPolhe1t9acivbDoVjxSdD8S5gCF/1oUQTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783010; c=relaxed/simple;
	bh=iGEgBM9qNIGiSJKIHvOybyEbLXkfR46zI4ncPUc0P8A=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=BciwPnT1ZOlIGFehQUXWaczC0XsP6KpSVmHN4Kye0KNyFe9eat+MZH4rxyrzOnweOea82rVbyEftBG+BbTkVNGBWfgnfpeCLYI7Zc5J5nM/ZVNLR8AJ8rwuMuULtR1FOZV5v4IQWuJ/20G5NbhJSSO7exiX30NRL2kuD8ZDIjuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [101.68.65.66])
	by mtasvr (Coremail) with SMTP id _____wBXUA_Mf9FnUAgCAA--.4273S3;
	Wed, 12 Mar 2025 20:36:28 +0800 (CST)
Received: from johnpub$zju.edu.cn ( [101.68.65.66] ) by
 ajax-webmail-mail-app1 (Coremail) ; Wed, 12 Mar 2025 20:36:27 +0800
 (GMT+08:00)
Date: Wed, 12 Mar 2025 20:36:27 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: johnpub@zju.edu.cn
To: linux-rdma@vger.kernel.org
Subject: 
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241206(f7804f05) Copyright (c) 2002-2025 www.mailtech.cn zju.edu.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1ef366c4.35f.1958a5b3474.Coremail.johnpub@zju.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID:yy_KCgBXNTTLf9FnrHICAA--.660W
X-CM-SenderInfo: hmrk01dxe66yvxohv3gofq/1tbiBgwDC2fRbDEIVwADs1
X-CM-DELIVERINFO: =?B?6wcflgXKKxbFmtjJiESix3B1w3v8ArY0zD5Ym3O7o+uypcQ7kdKjAbvXvwwp90u/ZQ
	NZz+aZyuFe2qaqXnIX7saLUHh1k4s8eDdoYYt43zr+QQeC+Sfh/WHUdRYdet5v7cuvdIuH
	1rHax31u3gJPQ+XyFYryRfHUv9Ky9c2hCPDWW8DrjWuII7MTFLJmvUVXv6duKg==
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUGGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280
	aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48Icx
	kI7VAKI48G6xCjnVAKz4kxM4xvF2IEb7IF0Fy264kE64k0F24lFcxC0VAYjxAxZF0Ex2Iq
	xwACY4xI67k04243AVC20s0264xvF2IEb7IF0Fy264kE64k0F2IE4x8a64kEw2IEx4CE17
	CEb7AF67AKxVWUJVWUXwACY4xI67k04243AVC20s026xCjnVAKz4kI6I8E67AF67kF1VAF
	wI0_Jr0_Jrylw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMxCIbckI1I0E14v26Fy26r43JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jr0_JrylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_Gr1l6VACY4xI67k04243AbIYCTnIWIevJa73UjIFyTuYvjxUV1CGUUUUU

dW5zdWJzY3JpYmUgbGludXgtcmRtYQo=


