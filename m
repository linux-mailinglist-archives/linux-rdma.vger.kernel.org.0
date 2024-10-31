Return-Path: <linux-rdma+bounces-5676-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6659B8282
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 19:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DAF1F22452
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 18:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30DF1C9DCD;
	Thu, 31 Oct 2024 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MB+JSeOz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2781C8FD7;
	Thu, 31 Oct 2024 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730398964; cv=none; b=Yln9Vj8rbPsiQpQzVb1FIki7nSv/lfqBa+Am6zh4OayIgtFRZRM9OdLpKwrqgy4q9cAfI4jOR4xwtcj8c6Loan/3GgwM6wu6Os9gdbVMRVGzSbjzEpftp9K2+PRTnSSaOkt65WdFmr2/1F7hwZjMYG8lT8T3UNa/pw/7GAnfYYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730398964; c=relaxed/simple;
	bh=W9ptO2AWHJvDBqBcplJ9x7hVH9AqEur0XDGEUTb8INw=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pNWQrB/Uw+v+SRPTWbydT3xQ1BI4bps0e6E/Znt2gTBqauuY9tgD1dCkKVxrs75p2+u5d+QEkZpykKyQGXsICuxcwde5jlNcXaA7+wEX1uOBWF05WRFN2pQmuEGDL7WOJJ8IG6MGyERi1UzEn1D0Ztq9KbzbbJadtYy2spdgtj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MB+JSeOz; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730398963; x=1761934963;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=W9ptO2AWHJvDBqBcplJ9x7hVH9AqEur0XDGEUTb8INw=;
  b=MB+JSeOzCQxKvAEf02S6awjA1Gbmh0Wgxkb3wyddJVLQcyDycp8lVTIa
   4j77XVRpQQAAc1OIm18g006dUj53q+P6XMXxjKpbz2R/puag2D3pwYjQ1
   mgj+3I0KcKWCaEBkYN6rFIiEPJ63bvo52QtulM3c6+7y1fDC6URUVD/Tf
   s=;
X-IronPort-AV: E=Sophos;i="6.11,247,1725321600"; 
   d="scan'208";a="771897177"
Subject: RE: [resend PATCH 1/2] dim: make dim_calc_stats() inputs const pointers
Thread-Topic: [resend PATCH 1/2] dim: make dim_calc_stats() inputs const pointers
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 18:22:33 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:61073]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.2.199:2525] with esmtp (Farcaster)
 id 5b69f371-b19a-4292-b4a0-5c7f596b7e5d; Thu, 31 Oct 2024 18:22:32 +0000 (UTC)
X-Farcaster-Flow-ID: 5b69f371-b19a-4292-b4a0-5c7f596b7e5d
Received: from EX19D005EUA001.ant.amazon.com (10.252.50.159) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 31 Oct 2024 18:22:31 +0000
Received: from EX19D022EUA002.ant.amazon.com (10.252.50.201) by
 EX19D005EUA001.ant.amazon.com (10.252.50.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 31 Oct 2024 18:22:31 +0000
Received: from EX19D022EUA002.ant.amazon.com ([fe80::7f87:7d63:def0:157d]) by
 EX19D022EUA002.ant.amazon.com ([fe80::7f87:7d63:def0:157d%3]) with mapi id
 15.02.1258.034; Thu, 31 Oct 2024 18:22:31 +0000
From: "Kiyanovski, Arthur" <akiyano@amazon.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, Caleb Sander Mateos
	<csander@purestorage.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Brett
 Creeley" <brett.creeley@amd.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	"Arinzon, David" <darinzon@amazon.com>, "David S. Miller"
	<davem@davemloft.net>, Doug Berger <opendmb@gmail.com>, Eric Dumazet
	<edumazet@google.com>, =?utf-8?B?RXVnZW5pbyBQw6lyZXo=?=
	<eperezma@redhat.com>, Felix Fietkau <nbd@nbd.name>, Geetha sowjanya
	<gakula@marvell.com>, hariprasad <hkelam@marvell.com>, Jakub Kicinski
	<kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, Jonathan Corbet
	<corbet@lwn.net>, Leon Romanovsky <leon@kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Louis Peens <louis.peens@corigine.com>, Mark Lee
	<Mark-MC.Lee@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, "Dagan, Noam" <ndagan@amazon.com>, Paolo Abeni
	<pabeni@redhat.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, "Roy
 Pledge" <Roy.Pledge@nxp.com>, "Bshara, Saeed" <saeedb@amazon.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Sean Wang <sean.wang@mediatek.com>, "Shannon
 Nelson" <shannon.nelson@amd.com>, "Agroskin, Shay" <shayagr@amazon.com>,
	Simon Horman <horms@kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>, Tal Gilboa <talgi@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "oss-drivers@corigine.com"
	<oss-drivers@corigine.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
Thread-Index: AQHbKys/FLYzAvitdkSVBoM6s5J6lrKhGqwAgAARw2A=
Date: Thu, 31 Oct 2024 18:22:15 +0000
Deferred-Delivery: Thu, 31 Oct 2024 18:21:26 +0000
Message-ID: <7bf7d713339e4854bfcb80c866aa55fe@amazon.com>
References: <20241031002326.3426181-1-csander@purestorage.com>
 <d9c01354-853c-459b-9da4-3c1d77102749@broadcom.com>
In-Reply-To: <d9c01354-853c-459b-9da4-3c1d77102749@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMTAvMzAvMjQgMTc6MjMsIENhbGViIFNhbmRlciBNYXRlb3Mgd3JvdGU6DQo+IE1ha2UgdGhl
IHN0YXJ0IGFuZCBlbmQgYXJndW1lbnRzIHRvIGRpbV9jYWxjX3N0YXRzKCkgY29uc3QgcG9pbnRl
cnMgdG8gDQo+IGNsYXJpZnkgdGhhdCB0aGUgZnVuY3Rpb24gZG9lcyBub3QgbW9kaWZ5IHRoZWly
IHZhbHVlcy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQ2FsZWIgU2FuZGVyIE1hdGVvcyA8Y3NhbmRl
ckBwdXJlc3RvcmFnZS5jb20+DQoNClJldmlld2VkLWJ5OiBBcnRodXIgS2l5YW5vdnNraSA8YWtp
eWFub0BhbWF6b24uY29tPg0KDQpUaGFua3MsDQpBcnRodXINCg==

