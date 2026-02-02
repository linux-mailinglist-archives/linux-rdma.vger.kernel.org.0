Return-Path: <linux-rdma+bounces-16361-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDN6MN/XgGnMBwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16361-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:59:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A71DCF45F
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43075301E97A
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 16:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B5D3803F1;
	Mon,  2 Feb 2026 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="CBiDOAHQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011020.outbound.protection.outlook.com [40.107.130.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B605237419D;
	Mon,  2 Feb 2026 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051405; cv=fail; b=UekfWlYvYK/W42McEOeqocGK+BoqoPx/tlFsFumfASZMFKkm5a2Z/aDYjSeKx51ZyZm97bS5okRNNW+E/hp2em0s5+jdr4kkvXILgMaDTrv6ENieXxTw89EUtflNwGOG51nqVtrIrNCBDIdnR7z+HByepqUblLElBZ66DK6BNhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051405; c=relaxed/simple;
	bh=Y1qXTw85FGeSMlR+0WPqObedTtP/0pcuJCf0Q5klE8Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CTVdaDlFPE7j4IAkTISVA3b5fRqZNAG96XYsU35+FaF5aqcdzox0Z/8zVltGw2gFOdly4PbxhyJHx0foD3LSsFgCKoGVpRsziusi9752QJNy+cCvH3SOmH6b6ZFJIibNBs1zNubrSdyhb5ZSwAs5cwPwmZffLUbqFFl9uINsVoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=CBiDOAHQ; arc=fail smtp.client-ip=40.107.130.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qyq3lDgQvUCiK1V2fG2kwg2Xm7b7J72UtFLZJA5vHEMekqL4ehEE7QoOoMI0UYj+HSqSc1wrZ5ppnXK2Gw18JCLlPzxmljUh3Ecdph6nxm09ilEZzJcnPfd0sEnq+tdRHJdcPC+Xe0Pdtix41svO47hgqH7jC3qcZdttkfqOT0RZLaU/Csf3Wr+975cRxYWXV5bRcbMVgDF7mrdVlF2rLJpjFhXFLyrn+7BKfZKFXSQVwOZDkyRUzpuJIEEIC8/HxUB27L3LTCtquOcBOKv/wAuW3zgMdIuy+43ATgd6yv3wDzHvt0T8d+o6Sh29P0MfWc7wFEi34U6QrG5OM010ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2zXMBTjx3O1bYGuFVB2ljdZ9wzbdkis1Iv5vSHStdM=;
 b=xFY8GsKYRD969PzQcRYK767pyXNw50Hmf9XQT8C7qHDw02hinIKY9r4lmw840S5f5Z6fuiMcLn+OIx43TvG5rm7j3FRBhyNlTcQDzG0pkVRnvIYxWHMcP5imsUawVPmfRzKWuzHmbyHH+i2ah33oOCwOK21HYpHp1URcmvdhGdWb9ilieBcbkb3pmeDWTEYncUg2IsPmTthy6/LkbVZF0Q1cUOsM0Aa/RrY5Lt6uXdzWf3iQbewpCSSA75+uDpbxC7Cmprup0Y3DTM+/E727k9eDccB4nk+HuT+5GoBkjrcJXeVEtU4sCo6cmbZ8RgDVPFU+2CJiuPegv6jwznPymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2zXMBTjx3O1bYGuFVB2ljdZ9wzbdkis1Iv5vSHStdM=;
 b=CBiDOAHQNxcUmh7n3rUbq1IZYyPjz9h6KgtqIA7oSk7u3z5CuoCFp87cDjxsSR7Bln8ieAxsCB6c4EvB4H2LyfUkONE3qTtjKhYttGTPuMUrrRNSfxucWAygEFAtbPFo7OM0KMCrRnyTFhYMzQO4SEYOsSsE73eb4m89hUz1bvIdNKlW3toJ8s7Ayjcz7gDeoHVTugZYpig//SI0v86XXs2IJKJl9GTXh5I8UREkzsI3KLthyhZk6Q+ZnAEr7wr+spjvtPFbqOYmS6/jpXn7aGDXxv54GkD5GYUrnCPHKgyVFN/rM8F2msoSEZ1zqYTizxlat83MuwNGDPWdYZSEig==
Received: from AM9PR07MB7969.eurprd07.prod.outlook.com (2603:10a6:20b:302::15)
 by GVXPR07MB9751.eurprd07.prod.outlook.com (2603:10a6:150:11c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:56:38 +0000
Received: from AM9PR07MB7969.eurprd07.prod.outlook.com
 ([fe80::b676:5e6b:e3e7:4bbd]) by AM9PR07MB7969.eurprd07.prod.outlook.com
 ([fe80::b676:5e6b:e3e7:4bbd%5]) with mapi id 15.20.9564.007; Mon, 2 Feb 2026
 16:56:38 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "tariqt@nvidia.com" <tariqt@nvidia.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "shaojijie@huawei.com" <shaojijie@huawei.com>,
	"shenjian15@huawei.com" <shenjian15@huawei.com>, "salil.mehta@huawei.com"
	<salil.mehta@huawei.com>, "mbloch@nvidia.com" <mbloch@nvidia.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"eperezma@redhat.com" <eperezma@redhat.com>, "brett.creeley@amd.com"
	<brett.creeley@amd.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "parav@nvidia.com" <parav@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@google.com" <kuniyu@google.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v1 net-next 3/3] virtio_net: Accurate ECN flag in
 virtio_net_hdr
Thread-Topic: [PATCH v1 net-next 3/3] virtio_net: Accurate ECN flag in
 virtio_net_hdr
Thread-Index: AQHckwSvr7yGsOyrpUmxwtqxbyNbCbVtkSqAgAIPIWA=
Date: Mon, 2 Feb 2026 16:56:38 +0000
Message-ID:
 <AM9PR07MB79696F945D8DBEF370CD4DC6A39AA@AM9PR07MB7969.eurprd07.prod.outlook.com>
References: <20260131225510.2946-1-chia-yu.chang@nokia-bell-labs.com>
 <20260131225510.2946-4-chia-yu.chang@nokia-bell-labs.com>
 <20260201035912-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260201035912-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR07MB7969:EE_|GVXPR07MB9751:EE_
x-ms-office365-filtering-correlation-id: db36bcc6-1213-4bed-ef8d-08de627c080b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2xrz1i75qvoslWC9AdEDM2SimC9QpGAv2VpnjdxzExY1bZ6ujjdMWkBpsQJM?=
 =?us-ascii?Q?qlnufJuI0yE9PsRqz4bp49Dc8Rlplr/ELOTpUXS6EdX2gLaHisN1BLgGCJes?=
 =?us-ascii?Q?NInuScAejnzsCN1fx3XhdTbVzfyMULAxn7qRETIleIEQvehgaC9HqrszMyNg?=
 =?us-ascii?Q?XyKfOviKLCCfE/lvytsDUyWUslfwg53c7O/wY2Eye3Cvok8DSkbRyC+5/wFU?=
 =?us-ascii?Q?7DZQwnVZfs+QldIL+kQl5qLsaIpDKTcrDjRR1fb2kpwi4X8NPCtFUh60iJX/?=
 =?us-ascii?Q?q3km284UrAyHRo8ZLUx0nbMAczgfJDfUh04CASxIhaxBzU7V1WbEMT3S19kc?=
 =?us-ascii?Q?RbcrwfFwzYcJ0KL8pF/VT4lPqKeXIbTkDkMkejV76jo8xDPWk50rlAHWByXT?=
 =?us-ascii?Q?N3iv7oRUxrijd8/2hW5WLjcZI1iJhOW4RNHdA7fTzOjU0hYcr+xVjRhuk5sZ?=
 =?us-ascii?Q?wSWUhqAhsXWfYhNjo4G62tm9JOc4twzQlayNFd1p2Zk3mn+03sFfCLz8YqgM?=
 =?us-ascii?Q?uAG6GaF9rjOLydg1rjLuNebzcBbB1WfDMSa9YzCSQAq0PIh+P6kw8/nrVntD?=
 =?us-ascii?Q?uUSzeTBtT5PmNN9/IngwL59/lQoMbpp2jgiu1LaJZKM1fgcanmR+y7pqkKur?=
 =?us-ascii?Q?uupCnquncP7vt/8h2kYTkQb1gq3vYUl2zbwDXT9dUxEBj0Izvv14t/xOjtp7?=
 =?us-ascii?Q?s5A1FMrYOlBb5IeODRWcjdkNN2aSAf+Omx6K4vSHqpZhETl4fa2Aq79oHTwl?=
 =?us-ascii?Q?nJSi5Kxd9dt3Pvj0hG24nNxZ8C4fuZ1kA6ifdsICVrsA2EdJlDpLQD1SRvMT?=
 =?us-ascii?Q?NdqxbCbavNly/lEHp87bRZaL08Bj3C7COqnOhzzqPdt8VQoItqmcYVF6FRq9?=
 =?us-ascii?Q?cR/Hi3VsdN+22Jp8ogwc33IZNoEzc64TxO7CwSEe5zFo3OGGVyXYFXI5DN0K?=
 =?us-ascii?Q?VJDh+bbuoULjtbI76CCxKnmc73xb8Kea6MkN53NP6pFnOuHOXtz90CG187uz?=
 =?us-ascii?Q?SuZavp5MBafgkOzDXKB07zTPHL7ctRR+bn1snaD/SznhNLxmOdfys4ETcdrn?=
 =?us-ascii?Q?IQydA4Ax9NaRO2gXrM2guyarb7tM6akyk/7upDja1XDn98UWUXBcHM8GtWPD?=
 =?us-ascii?Q?AkWPLW0AFfn3C8xpUXj43shz9WcwFcNN3N3E25bpWse1HW5cr+KlyKNM2C9p?=
 =?us-ascii?Q?PAKemzaeVR8ruDkikuVRnbK5b1H9Wqexic2ZsO2CFI2kJUCCn1fugmLPYoiw?=
 =?us-ascii?Q?AJNk3x6Oelt2V1Eg7EdQD1djLP6hzBOKjzmU2XN3pGvmrwhXovE81JmsDf0W?=
 =?us-ascii?Q?4nqrnr9T7OZgfvzJQ/mda9tQZosORmWkWW3fmV6mSHEfuYOPIxYfxyBicrip?=
 =?us-ascii?Q?KIpOjRQC2mtJ601VOxhhY0pv8b9CevzvCtGvAqpj0fnIalgswYmk9lgpG1kL?=
 =?us-ascii?Q?RECHdRhhCMeJxnQftKs5/vgjw+kPJ/h7rJEvNxj1I3Sxv2FrIRzzwr6ZaAMA?=
 =?us-ascii?Q?qjcREaPH/E3zQeXU5gLhvzKBVkB7WydUwk/H66sRSdSdew8t0zQuRgSODt82?=
 =?us-ascii?Q?OjzX6de1YZUcBvGXEoo60qPlFDBIUSPNsW1qhapLlasmBhLKdt9jvTPdj5Jh?=
 =?us-ascii?Q?TVZWPumDG8A9kFtDedznRE0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR07MB7969.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qOr7/WFPBd7DKpVhIlVGKgYJrfuDrs/vd7b5YkLTqR/jjd5ypVewtFrxAzpS?=
 =?us-ascii?Q?WWoxfZLaUxqrk+o61p8IPdYj4/Z8n+7WDrDEupFFRpU53V36u3ZeeHaTsTyd?=
 =?us-ascii?Q?A9L5thwVs5/LOPsJmsKvY8gobUz7ZKWPIxmf4y5po5C+18cVgkschP4uocht?=
 =?us-ascii?Q?n88bIqDdcLJHIGxR8CbV7LVlmJPZHR6Y9scSMpNwBsm5Aq3NFgyrnpsOZl+R?=
 =?us-ascii?Q?cUXUwPmJibNoHVy4ZdPzHIq5DOOfyyFgqKYVUAGoEHUuUjXXuc7bt7xx8Ded?=
 =?us-ascii?Q?p95NvGM1Nwd7g9ztXgVIY/0QToox2VT02e+f12cRTZo/uKRzL9JfPfEyfPur?=
 =?us-ascii?Q?cXyrV4HUpEayL1cxocXyDc2p/gKS1XSBZjqflzip3MhyVe779GBi2R3bhszw?=
 =?us-ascii?Q?7XWSTI0UVmJ7IqaYHqXz4wAykVy0d7SHTMvWMFT+8Mlhfkbw+T0BdsT+v7j6?=
 =?us-ascii?Q?E51wV6ldHJerEMsuO8L6H7ujFuqFyZdWxZzvr/FgJd3Z+qzo6NMbCWOLh8m3?=
 =?us-ascii?Q?wCHqE1fk6sMO6qM9QpRpJfFORCkdu3x5oilS6FkgnQd8t5db4cVGkpJqb4i4?=
 =?us-ascii?Q?8JkZkh8EPoofCbVC9A9uyHfu6xb6dX9CgEZ3wZ5BkuGuAwdAG1uOXMDDalX8?=
 =?us-ascii?Q?HtE6W+c5jI2YdKl9+I/PIT1jDT9p3xd9LZnDX6bPQxz0dpscbN5Dx6HYSQKv?=
 =?us-ascii?Q?IrIfwSYvPWNFU2MbegYA8tinu0cY+amFtkN/jRPSul/NBjTsjvGTGt2n/Pov?=
 =?us-ascii?Q?KoTwJMDmjRuTT3ZLs5aF21mprvlPiwCe6gtNRPlgbhImYcexv2mRKXVmoDhQ?=
 =?us-ascii?Q?hN8KnNU2NxaGnbVoiVihPNdk0reUfkF6OfJw76NFQwPGa4i/G5JB45zPJTqu?=
 =?us-ascii?Q?svOvTpNJjxjW+Oe9jRE+YeswEESn1AsA+lLVr7pQDcMz1nV9IJqSvHlktHxE?=
 =?us-ascii?Q?qTPo2ER2R0vzDZtRtRwntsGxwyD7g6tzm+HAsSARSOxf8RhTPDHr8yZGvye9?=
 =?us-ascii?Q?gjba57qZfi7uW9KRzQeiI0EGqxNyCMOd+oW0JfxCGqgic0QoTLx/9j4Cz/HI?=
 =?us-ascii?Q?V5iRmCOzN3o0c7RGA9Czl3YuwncI6W4n3myH8pQ+b0Xjzw2P0GB4ZRhpxX9y?=
 =?us-ascii?Q?YNq/et2ik+0EzkWo41SobhL7aLhZWJLVjb5An098ZfawCqY9kpg8YgTiZp81?=
 =?us-ascii?Q?YnPZ9MqPyltiSKWokJlMttE9eo7qswOV+OWkIBKDh1zdMAmxjCzC6ok4UrZG?=
 =?us-ascii?Q?wYGzDs2n4GlxjYjUgaVA7cIbuj33HlRd5S0crUIj9PCJlSZNXz3vJ2XoN2cF?=
 =?us-ascii?Q?CyfKjvT5OF1rdMzw2IqhRvZNHReAkwOrtnf6lQx7mPkC8Oo4H/JeUmk64gys?=
 =?us-ascii?Q?623I5sgpdFyROOBNZLfrdiZ7qedV3c/U7SFXNv9108XfgLONO5oCglKCZ5UM?=
 =?us-ascii?Q?0ZOvKww/l/uPciA/w+A23CtAGQD10wowv6KCRkmIiqIh+xbSUL4qbvLoLwZu?=
 =?us-ascii?Q?7cVJxUXJyxeAk98sUT27/Oeo2wm0ItRDviOuLqppMFQctNgEXdF01RLIM6ae?=
 =?us-ascii?Q?cUnA4Lrh2HCd7cGCnP18qoYbT5sXAp8VkHwuUetnqqva4GnYrrdh7koEUIAo?=
 =?us-ascii?Q?ukwLmz/jwl+2LBuCpIFTFTMLLYWZ5kt+PwW2rHq85IYglpsnr7uXmqP3tMRC?=
 =?us-ascii?Q?sUcjFR5m6V7iu6Cm9kZ+/Hqar61FNFfXyrKElTSGaeav01lt5NKP8OrT0yS8?=
 =?us-ascii?Q?IG7cpnd0JoLPNxiDBCQuPsDmqho5vwk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR07MB7969.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db36bcc6-1213-4bed-ef8d-08de627c080b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 16:56:38.3187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Maywnx5SCf32KnGSbZVBSnJWvduGAqCUF5m9WNFIeFfNHVOve6O9KKpZMsMtQWLP6GmN+0B7Vj6BAxyMGXhfok4BT5rehpOunNjo19AWQpPY63rSiPFRmXEAc6Q/tKUr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9751
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[47];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16361-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,huawei.com,kernel.org,redhat.com,amd.com,lists.linux.dev,linux.alibaba.com,google.com,lwn.net,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A71DCF45F
X-Rspamd-Action: no action

> -----Original Message-----
> From: Michael S. Tsirkin <mst@redhat.com>=20
> Sent: Sunday, February 1, 2026 10:18 AM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> Cc: tariqt@nvidia.com; linux-rdma@vger.kernel.org; shaojijie@huawei.com; =
shenjian15@huawei.com; salil.mehta@huawei.com; mbloch@nvidia.com; saeedm@nv=
idia.com; leon@kernel.org; eperezma@redhat.com; brett.creeley@amd.com; jaso=
wang@redhat.com; virtualization@lists.linux.dev; xuanzhuo@linux.alibaba.com=
; pabeni@redhat.com; edumazet@google.com; parav@nvidia.com; linux-doc@vger.=
kernel.org; corbet@lwn.net; horms@kernel.org; dsahern@kernel.org; kuniyu@go=
ogle.com; bpf@vger.kernel.org; netdev@vger.kernel.org; dave.taht@gmail.com;=
 jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumber.org; xiyou.wangc=
ong@gmail.com; jiri@resnulli.us; davem@davemloft.net; andrew+netdev@lunn.ch=
; donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@gmail.com; shuah@ker=
nel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; ncardwell@google.c=
om; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.whit=
e@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsso=
n.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vid=
hi_goel@apple.com
> Subject: Re: [PATCH v1 net-next 3/3] virtio_net: Accurate ECN flag in vir=
tio_net_hdr
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> Thanks for the patch! Yet something to improve:
>=20
> On Sat, Jan 31, 2026 at 11:55:10PM +0100, chia-yu.chang@nokia-bell-labs.c=
om wrote:
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Unlike RFC 3168 ECN, accurate ECN uses the CWR flag as part of the ACE=
=20
> > field to count new packets with CE mark; however, it will be corrupted=
=20
> > by the RFC 3168 ECN-aware TSO. Therefore, fallback shall be applied by=
=20
> > seting NETIF_F_GSO_ACCECN to ensure that the CWR flag should not be=20
> > changed within a super-skb.
> >
> > To apply the aforementieond new AccECN GSO for virtio, new featue bits=
=20
> > for host and guest are added for feature negotiation between driver=20
> > and device. And the translation of Accurate ECN GSO flag between=20
> > virtio_net_hdr and skb header for NETIF_F_GSO_ACCECN is also added to=20
> > avoid CWR flag corruption due to RFC3168 ECN TSO.
> >
> > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>=20
>=20
> To the best of my understanding, this is a new feature - support for VIRT=
IO_NET_F_HOST_ACCECN, VIRTIO_NET_F_GUEST_ACCECN?
> The commit log makes it sound like it fixes some behaviour for existing h=
ardware, but that is not the case.
>=20

Thansk for the feedback, I will update commit message in v3.
>=20
> > ---
> > v2:
> > - Replace VIRTIO_NET_HDR_GSO_ECN with VIRTIO_NET_HDR_GSO_ECN_FLAGS
>=20
> but where is v2? this is v1...

I shall update this version as v2, will do at the next version.

[...]
> > diff --git a/include/uapi/linux/virtio_net.h=20
> > b/include/uapi/linux/virtio_net.h index 1db45b01532b..af5bfe45aa1f=20
> > 100644
> > --- a/include/uapi/linux/virtio_net.h
> > +++ b/include/uapi/linux/virtio_net.h
> > @@ -56,6 +56,8 @@
> >  #define VIRTIO_NET_F_MQ      22      /* Device supports Receive Flow
> >                                        * Steering */
> >  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23        /* Set MAC address */
> > +#define VIRTIO_NET_F_HOST_ACCECN 25  /* Host can handle GSO of AccECN=
=20
> > +*/ #define VIRTIO_NET_F_GUEST_ACCECN 26 /* Guest can handle GSO of=20
> > +AccECN */
> >  #define VIRTIO_NET_F_DEVICE_STATS 50 /* Device can provide=20
> > device-level statistics. */  #define VIRTIO_NET_F_VQ_NOTF_COAL 52 /* De=
vice supports virtqueue notification coalescing */
> >  #define VIRTIO_NET_F_NOTF_COAL       53      /* Device supports notifi=
cations coalescing */
> > @@ -165,6 +167,9 @@ struct virtio_net_hdr_v1 {  #define=20
> > VIRTIO_NET_HDR_GSO_UDP_TUNNEL (VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 | \
> >                                      VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6=
)
> >  #define VIRTIO_NET_HDR_GSO_ECN               0x80    /* TCP has ECN se=
t */
> > +#define VIRTIO_NET_HDR_GSO_ACCECN    0x10    /* TCP AccECN segmentatio=
n */
> > +#define VIRTIO_NET_HDR_GSO_ECN_FLAGS (VIRTIO_NET_HDR_GSO_ECN | \
> > +                                      VIRTIO_NET_HDR_GSO_ACCECN)
> >       __u8 gso_type;
> >       __virtio16 hdr_len;     /* Ethernet + IP + tcp/udp hdrs */
> >       __virtio16 gso_size;    /* Bytes to append to hdr_len per frame *=
/
>=20
>=20
> UAPI changes need to be added to the virtio spec.
> Pls get this approved by the virtio TC.
> Thanks!

There were some discussions last October in virtio-comment@lists.linux.dev =
mailing list.

At that moment, it is suggested to make Linux kernel accept new comments fo=
r SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN first.

So, could virtio-spec colleague give your feedback? (Parav?).

Otherwise, the CWR handling of virtio will be wrong after all Accurate ECN =
commits are merged in Linux.

Chia-Yu

