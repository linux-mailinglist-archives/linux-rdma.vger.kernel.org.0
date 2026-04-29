Return-Path: <linux-rdma+bounces-19735-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOZ7E1IS8mningEAu9opvQ
	(envelope-from <linux-rdma+bounces-19735-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 16:14:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3D3495755
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 16:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 462123004DC5
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 14:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E3C3FE355;
	Wed, 29 Apr 2026 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="jX1w0o3c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512BF3FE37F;
	Wed, 29 Apr 2026 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472075; cv=fail; b=k1O9KvGOknpJniAQQdtxXbqktqG13+od2lW694HYxr/OcRFQQ8+wNCd5wPZ5drtLvsVPIbHwLalxdYThguOYoQLwUw4z+ueAKqpSIl7P726Qun1gi2vnAwOJesKH06Z+494qogxr4ogrm+vJnuP0r+dMt9x1n7G+73Bq4YV2Uxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472075; c=relaxed/simple;
	bh=iogJviDNkp98IDRChGCAZ4hC2E3xYHIdQb8J15SZCIE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f8l7U4SGV/OaDD+eOZUiJWvOpR9jtq0Xg9zPm3BvhoxiMctX1zknh2a0+KHKQM6LZjrxMV/OuqKQM4Yr/VUvL71hPEs+HvP/1iioY/WP93S9HE+ztkriTEz4+NChCDYecfZ2rw3iZOW1Gb5yGSunbDyFY8VJbeUZFAjYxBfy8UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=fail smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=jX1w0o3c; arc=fail smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T3VXL63902295;
	Wed, 29 Apr 2026 14:30:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=jan2016.eng; bh=6mv3lUbStiDD/WqNUV71YT
	n1HZWmaaEzzLMRPZWKnNs=; b=jX1w0o3cNQ3etDRaFyih3Tk8f9bpgqLlmRFUAO
	F9bEpocXyrlwKGwNePFKsb4q1vrnvulpYuMvDcaIp23KeVWxgnHmm/FUSWHSp8/Z
	ZAA9PQI7EAyx3nS/JtG2D6sKfhv6/mq92OjS6LNGgrFX4i4F1Ntiz9KbMhNxRZju
	uTdh0bQDp5p/GUR5C4fXh+fTw3/WqhSOOn3Wo0JvQAjwe49dpsGcU44/hpw3KB3g
	menRB/8Pi8ReLRcD5CyDu8ln9F0+lUBkhPSrMqXcnVaxHRrMpQZmKHbbY2dj+2kk
	6IX8dHSOoc5Hnr2Lpu3as+5VnBfrxCpRzzwcE2xns09GeHQA==
Received: from prod-mail-ppoint7 (a72-247-45-33.deploy.static.akamaitechnologies.com [72.247.45.33] (may be forged))
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4drnsnac16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 14:30:00 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
	by prod-mail-ppoint7.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 63TDR4SC008401;
	Wed, 29 Apr 2026 09:30:00 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.220])
	by prod-mail-ppoint7.akamai.com (PPS) with ESMTPS id 4drry0b38r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 09:30:00 -0400 (EDT)
Received: from ustx2ex-dag4mb4.msg.corp.akamai.com (172.27.50.203) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 06:29:59 -0700
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag4mb4.msg.corp.akamai.com (172.27.50.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 06:29:59 -0700
Received: from DM2PR04CU003.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 08:29:59 -0500
Received: from CH2PR17MB3797.namprd17.prod.outlook.com (2603:10b6:610:80::18)
 by IA6PR17MB7519.namprd17.prod.outlook.com (2603:10b6:208:5e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 13:29:57 +0000
Received: from CH2PR17MB3797.namprd17.prod.outlook.com
 ([fe80::cf6d:89de:646d:d1a2]) by CH2PR17MB3797.namprd17.prod.outlook.com
 ([fe80::cf6d:89de:646d:d1a2%6]) with mapi id 15.20.9846.021; Wed, 29 Apr 2026
 13:29:57 +0000
From: "Boone, Max" <mboone@akamai.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] net/mlx5: check whether VFs are assigned before
 disabling SR-IOV
Thread-Topic: [PATCH RFC] net/mlx5: check whether VFs are assigned before
 disabling SR-IOV
Thread-Index: AQHc1zlx91HwEcPUlk2jLKUvUy62rrX1+7uAgAAOTwA=
Date: Wed, 29 Apr 2026 13:29:57 +0000
Message-ID: <DB8CFC33-0929-40F5-86CA-39D1CD84D415@akamai.com>
References: <20260428-mlx5-sriov-in-use-check-v1-1-c7b9e18c99a8@akamai.com>
 <20260429123833.GM849557@ziepe.ca>
In-Reply-To: <20260429123833.GM849557@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR17MB3797:EE_|IA6PR17MB7519:EE_
x-ms-office365-filtering-correlation-id: 00808e02-7411-4950-17e7-08dea5f36813
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|6049299003|376014|38070700021|4053099003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: L8P0n2n97KDqn6iji5ggyb3gQOc9E38sHvxSguGlILv3fP9kpjfWyOT0Aprhd69UGV1iTlEH5KE5UmYoYh06CIhcxYUVyMurKftDhXwNQdIT2+SrL41LVJD9j9pBxntxVxngCIrAwSmyz0oIW0gthHtLdv7o/ctA1irz8KughE0jWplxGfYqkgi9Kboh5WOQFeMb9w5BimF7j2Wzrk9jVY2U5jw46vuWUQ6jg45sQD97X16ZKu86MxncSnfN8WaffAx1vPk3kpgtuMV3OMx2bU2lyIMUqsVJH9sVucDTMOD9z2SY8Qf0h6lvBi/glN2neOnfvXhkNr6RLTlwJB1kXPWHJ/oyeHhqKYpzcbUL8sKvA0xvyjMbbZhtePS06dVbqAEwYrAKjErH6BxPVnS3Xm9/46FyXHfwtfATwpcLrdC6e2kOICIA41BcgRTprRNdQO50Vs8oNmUe1ACasVtKMMzAU/eUns4eMOC9a8zgvkZWSlVgY+ndKhxNOoOrqxDZjHFhSbeC1xvnA92zUIhddOOQ5LL0pFk0iUM06XfRhxkXBzlBciJHSThg24qyfAPk1w9hNpyI3A8jwu/JOCAnjZniJYdM7FOpWSCOi1SRHB/rBjvsVd/XC6AnnfPx4psC0fGeGVkNbxn8FO0i/pyU58aHMybYlyTP9Dv7AD9V/OyhYfKJ8yVBGyFKtMW2yLANanUYHNhyDbHrRW+CVSztdPt8Acky/NVeH/qybhYzJAKjbLDENNL2ajomxxdbRX00fZ9wB/UeNlqf7nrYhWNF7x7RCR2MAx0TG8S/KeVOh5s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR17MB3797.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(6049299003)(376014)(38070700021)(4053099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFJib1gxL2pzcU15S2FlWkdnZHVoVzRXTVZJaDNyeGlHOGF1dW8xaXI0SzlM?=
 =?utf-8?B?L2xxK1dQckhuRU4xUkJWZkFIMnY1NUs5MVIwaHVPQURSckVOU2FCMTJkUHZz?=
 =?utf-8?B?UGFZNHg3eHlOZVNqdFlsUWQwQmQ1dFNEaXdScm5wR3grV0FEODEzVTR5Y3No?=
 =?utf-8?B?azZMREpaQ1BDTmZlTXB3ZGtpa3FRckc1bkdvUGk2RWFOU2kvbXgyM1JGWU1R?=
 =?utf-8?B?b09LSHhqbzQ4WDJSVmljODFQbnBHcytuSmtSZHRLYVpzelBtdEc0UVBMM29C?=
 =?utf-8?B?UjBTWXYyaTQwUDZLeHRRclVTaGZ0RWlGaVZsOHZtdEM1VEVERnArbWY1TFRz?=
 =?utf-8?B?blM0MkljU3dBbzdxVHFWSHhOcUFGVjlJQ0NnZmRpdDc3RXd3LzF1N3VMZHFz?=
 =?utf-8?B?SElwM2Qrc2UydGdYdmdGZ3NnSm1UU3VVbHcvTysydGJQMUVWcUZ4TnhPNEdp?=
 =?utf-8?B?YW1GSzk1TXZjY0dCUkVwTXVhYmRiSE82TTNZVVNBNnhhWXJwUFBFM3dpRmw3?=
 =?utf-8?B?RkpkTmxzQlp6L3d3QUxETkxESC9xVFZwSEZ2OVVPb0NuTHNjaldBcDNzSVF3?=
 =?utf-8?B?WExWYW5QT3dTcHRuYWNKbmxncStCbU5oaU9zTHFVV3d1M0o5QkNINElSMWsx?=
 =?utf-8?B?UW9pOXkwTFdPQXVyTmZsb2oraGNHemFxV0o3QzRRZ2Y2Z0t3OHA1YTI2cUsr?=
 =?utf-8?B?T3FtYjNwZ2hzUk1PKzBoSm93dzdsSlVmWXRXTVBJZVgrNVdVK0g3VWRwVTNq?=
 =?utf-8?B?dlRKMDdCczZ6NFFObWhTUW1zdENpV1AzV0xzMWtFQ1lrVUN3QjkxQjNkdXVE?=
 =?utf-8?B?cDZKUW1mVUNET0w5QVZWL1Avb1J6VjNBUGxEYWcvUzVlclNuam9jNGdFSm41?=
 =?utf-8?B?bit4RXo3Kyt6WGE0RGRZS0hmdVFhbmRkWXN5UkZQcWtBeitMUkF0c0tZNEs4?=
 =?utf-8?B?SlN4ZU51VGRuUStZc2NGczU4WWMwai83UXFYUisram83cnQrN2ZyNUNTK3pw?=
 =?utf-8?B?ZWV2cUJxRGQrNGQzYnplUGNoRjZlaTB4ZllFUUNrVUxtaUx3VUF4R2ZHbGFL?=
 =?utf-8?B?VkNnczRhRmZMMjE3S0UvS1o5ZXFtRzZpY0JZdlQzTU1VVS84K0JvYmJldFdt?=
 =?utf-8?B?bjFMaWhVbXJqS2hJaDRhempXNSt4TDI2aEF5aGtwY3pLM3JDdXBmWTNpUURz?=
 =?utf-8?B?bzh4cW9jeEEzcWwwRFg4aVpXRXJGcTE5dllxazJqZUovMnpab2tnbzJNci90?=
 =?utf-8?B?U1JWZ0RZc0FzRXpqQzMvTzMyRStCZ01PVmMxd2Z5bHR4eGQ4SzN1SGxibjV2?=
 =?utf-8?B?TVl6aUR0dmFmMXlTZnp5ZUxENzhBdlMzalg0bi9ZZmR2RGJHbUZvWkdDdi9R?=
 =?utf-8?B?SUU2REtLZklwblA1RWhwZE0rU3BYQ0o1cFM5a24zSGdJMGtnY29kQ3FCU2JY?=
 =?utf-8?B?ZkFwL0JYMTYraExTZ3VVSWlWcGhoblNHbC9iUXpma29lUHBmaENNM2k0QjNS?=
 =?utf-8?B?YzZ1QlJ6VnpQUGpLclFrSmlnaER2Q2FyUTV3c2ZZRzdUMFJqUkVwUlpXTms0?=
 =?utf-8?B?RE5wY1hJN25vT2crejgxREl5WjQ3aTh5bGw2V254ZnF2R2xha29xRXoyZ2hv?=
 =?utf-8?B?eWhVQUVSTWhuV3UwTk15aGdod2R6MlN2V2NuQm1iZkRMMXBTakpNZlpQV1Zs?=
 =?utf-8?B?M1JqbG4zRm9iMzhWY0psWFZPMkxMNHVPK1R0YXp3bjFGRi9tMExWbGR5aDIv?=
 =?utf-8?B?dlRMSGU4VDhkZzF3Qi9jZkdaV0MxdnR1YmJnV2NYYVJQSHBpMXZBTFRGeXlZ?=
 =?utf-8?B?S0s1TThNQzlrWlV2Vm5YZTRvK3AxNXJ6YXBMTkhhRVJGMVJDMFB0T3QvcmxC?=
 =?utf-8?B?VDljdjNtc0hJZkViYVEzVjdtUktaRjc2Mlg0ek0vYk9xVFVIYk1RZUhZOFBO?=
 =?utf-8?B?YjZBYzcxb2VocWVQOUtMUE1hWDk4OW9MZXVZMkdpYVpSbGdacnVTMjZxR2pa?=
 =?utf-8?B?TXFKNTBrVU5UdUFLODd2cjAyam85MS9paXpZSG1mZkVINi8wcDN4TkFUcDNJ?=
 =?utf-8?B?WHNQaFR1NjMzRHpoK3pBa2tndUQyOG01WitSSG5CRVBqSGpyZUxVK2d2VFBy?=
 =?utf-8?B?NzJRYUZMQW80ak1WOHJ6WUxkMWd3UnA0b0MrK1dtNXhqVFYwL3BLMDdXK1dG?=
 =?utf-8?B?TStzRTFxdTh0QmlBQkwrZGF1elRPakU3bHplVEhPRjhTb1RLSVZiOEtVK1E1?=
 =?utf-8?B?VnlvWDBsaHd5d0J4MHhPcXBVSVgyWW9heTJlR3hzZE1wUEVXaE1RYTBLaFlT?=
 =?utf-8?B?K1Vkemd3UEx4ck45NWNwbUdQbllaRk5BZ1NsbUdBOUh4dGdZaUhtZz09?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDwYZnF9i/UUkL1pyI6iTd3k4fkx20XmP3Bs/FDaRa/EQaQuQdLpNZ7YGhux2wg2ATP1tHHQ24ZKw9cy1r9LRi88gGCe0iRgGd2QG5Ua2siw+9fjeQAzoLCJNzNpkiVV6RPo1iIM3Owc83de5BBHAIE1ndTUXds6CvCmlpat/HAMPPzK+b6TqrRRmwe4Z7sXuhi13nbPrfkcJFJgttLso3OrHuYTS5NZM2YSERiybzIEp0IPcVbDRGuMq6eAVSgLoN3qN87O0jVNBDIDhldDdcNp2QE/XpIEZro4g5uuqLd04r3uDoH0S7eXEQorCi0VtMBDS0HFONrLgB3RxgB86A==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=222VZbGZlO9S57gsX5aaC73O7EZPAOPOGz6S724rte4=;
 b=Hgn3ec/QVnybzKAB08Ehck97av2t/ho2YZbuBrA+C3x5bKyJsI9avjI1qyVeGBIHY4BI9qXoIIrYWAy9rTBBF2dOnUaV/c/v6+P5JwSMuq/ktijnK/fsrh06Pia+UXMd9t+13CcIJm7pJg84c8qCnk/8bHV2nG10AGs1AXEqGIe5xl4/fluKkDXQjjJhqZ6rEiDDUZe4dfnqLCh66hvWvZ9PBP82orygbMBRQyAWO3TeoiZdBZ/FFW2v2y4JGlQaDi2ccpvEzR+8tPLtqMMHBUloD9sBpFp3LzxaQA/l5xXJJXYsaf0drz2X+bHl+yi9oCc2iRCoyjTqNmxcBZDwjw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: ZTBcMHt5idEivuVxTYEW5BS4L9K2D3cy/2P5P9IhkeY0ssqooIhkTlhYIzfKHH2mzSbLYdl3coddaWmWuk5YkEzd5SgUiyiLIGVjKtRb4N4jIsP1TvPHjP47BL/CZ0xYLrhOVBT9JfpnaYJZJc6sIy0yaisshxI6/eU7Sh7mlyzAanK/YsrN+L0uu6hz9Qc9qpCYPFQ+0zBCBWbzyatjWseigPFwcZd1NXcc6fnHbceubyFw+iAPL87LBiuq8Cmx6y1N7lk+JuVhcTvlcKaz8JK6A9gsj/AbrUfCMlLV6iSE2zuUJx1/d1EF1hBpGxOXWsm9aZ+3WT0HH96GMD5h4Q==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CH2PR17MB3797.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 00808e02-7411-4950-17e7-08dea5f36813
x-ms-exchange-crosstenant-originalarrivaltime: 29 Apr 2026 13:29:57.4396 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: FzRpif4P73Ec5atSuBR1sQ0G2ZbWI4VK7TlMQXCQW2o4Vks0k72Fue8NepkeGXc/nkN7rtNn5g0tgsfYb+Ki9g==
x-ms-exchange-transport-crosstenantheadersstamped: IA6PR17MB7519
Content-Type: multipart/signed;
	boundary="Apple-Mail=_D4D7DC8F-A7F4-442B-912C-D93B4285305B";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2604290137
X-Proofpoint-ORIG-GUID: XfTRsePcEe1meIa9UuvuL3RmwkZZcErK
X-Authority-Analysis: v=2.4 cv=SLBykuvH c=1 sm=1 tr=0 ts=69f207da cx=c_pps
 a=3lD5tZmBJQAvN++OlPJl4w==:117 a=3lD5tZmBJQAvN++OlPJl4w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=4xFXqd-_BHBjZVyr95gr:22
 a=heWv4vMIAAAA:20 a=P-IC7800AAAA:8 a=9jRdOu3wAAAA:8 a=X7Ea-ya5AAAA:8
 a=uelMd3awxMJUxXymBWIA:9 a=QEXdDO2ut3YA:10 a=aUQEjLJJORIxqg3IqZUA:9
 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10 a=d3PnA9EDa4IxuAV0gXij:22
 a=ZE6KLimJVUuLrTuGpvhn:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: XfTRsePcEe1meIa9UuvuL3RmwkZZcErK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEzNyBTYWx0ZWRfX54LJMBCh2b4a
 tut7dxNcV+kBnljxPRQZ71KLE2xaVbGGfEKvX3BO3ixcniGR58m3Pf2x4j1rfoRiP/GVN33e2so
 XwJGCk4f4fGpNzKwfpk+oZ7uBxzmSixudnqb3Q9VSYQafPY62iAditmJ4tkPQbKujOIObm3ajsT
 8vEPYVvM3YulKWEnnqOlCwp2hTIvbqZ0Uq6i13+ovWboNXCmdiZVLE6HwdA0I/f7hDb54dFSc5x
 +fnmEwg7Ea5qmr5NunrYrbnHsXL74pm7RBjV+/xKPYzIaccoGF2wGk1lNmXhLWYMOuSER9adnb6
 KkUxme+HY1LdjDZtE+Y2aXWEnz4pGmK1azq/zi+zDSKHjNgfdVEBqvqs0R0TcB2GmaoO+TBhRoP
 YnK98Cc5fWaT5RxpACa8duffDE1I87TQWfyCjaFfrutFaiithIVa+P0l5bynfusI4AYdKGby5LW
 Nv1EIwehGfg25hZJoCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2604200000 definitions=main-2604290137
X-Rspamd-Queue-Id: 0C3D3495755
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-19735-lists,linux-rdma=lfdr.de];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mboone@akamai.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_SENDER_MAILLIST(0.00)[]

--Apple-Mail=_D4D7DC8F-A7F4-442B-912C-D93B4285305B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Apr 29, 2026, at 2:38=E2=80=AFPM, Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
>=20
> !-------------------------------------------------------------------|
>  This Message Is =46rom an External Sender
>  This message came from outside your organization.
> |-------------------------------------------------------------------!
>=20
> On Tue, Apr 28, 2026 at 08:04:14PM +0200, Max Boone via B4 Relay =
wrote:
>> From: Max Boone <mboone@akamai.com>
>>=20
>> When MLX5 cards are passed through to a VM, disabling SR-IOV by
>> setting the sriov_numvfs to 0 will render the machine unstable.
>=20
> What? How does that happen?

Unstable is maybe a bit confusing phrasing on my part, =E2=80=9Clocks =
up=E2=80=9D
might be a better description?

In short:
- Enable by setting sriov_numvfs to positive
- vfio-pci passthrough to QEMU (or other process)
- Disable by setting sriov_numvfs to zero
- QEMU processes freeze, shell that was writing to sysfs freezes
- SIGKILL doesn=E2=80=99t seem to have much effect, shutdown never =
completes

Python script to reproduce without QEMU:
- =
https://github.com/akamaxb/repro-vfio-sriov-removal/blob/main/vfio-sriov-b=
ind.py

Does:
  1. Require sriov_numvfs =3D=3D 0 on the PF (report any existing users =
and exit if not)
  2. Add one SR-IOV VF
  3. Bind the VF to vfio-pci via driver_override + drivers_probe
  4. Open VFIO container + group, get device fd
  5. Create a KVM VM (registers an MMU notifier =E2=80=94 required to =
trigger the race)
  6. Hold and wait for user input

To trigger the bug while the script is waiting, in another terminal:
    echo 0 > /sys/bus/pci/devices/<pf_device>/sriov_numvfs

On the vfio-pci end of it all, it prints these two lines to dmesg before =
it hangs:
- =
https://elixir.bootlin.com/linux/v7.0.1/source/drivers/vfio/pci/vfio_pci_c=
ore.c#L1826
- =
https://elixir.bootlin.com/linux/v7.0.1/source/drivers/vfio/vfio_main.c#L4=
21

>> -void mlx5_sriov_disable(struct pci_dev *pdev, bool num_vf_change)
>> +int mlx5_sriov_disable(struct pci_dev *pdev, bool num_vf_change)
>> {
>> struct mlx5_core_dev *dev  =3D pci_get_drvdata(pdev);
>> struct devlink *devlink =3D priv_to_devlink(dev);
>> int num_vfs =3D pci_num_vf(dev->pdev);
>>=20
>> + if (pci_vfs_assigned(dev->pdev)) {
>> + mlx5_core_warn(dev, "can't disable sriov, VFs are assigned\n");
>> + return -EPERM;
>> + }
>=20
> *barf* WTF did this come from?

Hahaha, take your pick:
- https://elixir.bootlin.com/linux/v7.0.1/C/ident/pci_vfs_assigned

I followed the sysfs sriov_numvfs op for a couple drivers and saw
that ixgbe (and others) had it plumbed in, so presumed (sorry)
that this would fix it / was an obvious omission if the rest is doing
it. My bad for cargo culting an artifact from Xen.

> Grep says only Xen makes this true, so this is all working around some
> Xen brokenness in their "assignment" ?

Yeap, I see, looks like it.

> If people care about Xen pci_is_dev_assigned() should be be purged and
> pciback should be fixed to not "make the machine unstable" when it is
> removed during a VF teardown.
>=20
> Or at the very least this nasty Xen intrustion should be placed in the
> PCI core code and removed from the drivers.
>=20
> Also, no, you can't fail mlx5_sriov_disable() it is called during
> driver remove and cannot fail in that flow.

Check. I can do some further digging and build a kernel with lockdep
to try and find what it is hanging on specifically. Unless something =
pops
to mind?

>=20
> Jason


--Apple-Mail=_D4D7DC8F-A7F4-442B-912C-D93B4285305B
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCCcow
ggShMIIESKADAgECAhMxAAAAIa0XYPGypwcKAAAAAAAhMAoGCCqGSM49BAMCMD8xITAfBgNVBAoT
GEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEaMBgGA1UEAxMRQWthbWFpQ29ycFJvb3QtRzEwHhcN
MjQxMTIxMTgzNzUyWhcNMzQxMTIxMTg0NzUyWjA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9n
aWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcD
QgAEjkdeMHsSTytADJ7eJ+O+5mpBfm9hVC6Cg9Wf+ER8HXid3E68IHjcCTNFSiezqYclAnIalS1I
cl6hRFZiacQkd6OCAyQwggMgMBIGCSsGAQQBgjcVAQQFAgMBAAEwIwYJKwYBBAGCNxUCBBYEFOa0
4dX2BYnqjkbEVEwLgf7BQJ7ZMB0GA1UdDgQWBBS2N+ieDVUAjPmykf1ahsljEXmtXDCBrwYDVR0g
BIGnMIGkMIGhBgsqAwSPTgEJCQgBATCBkTBYBggrBgEFBQcCAjBMHkoAQQBrAGEAbQBhAGkAIABD
AGUAcgB0AGkAZgBpAGMAYQB0AGUAIABQAHIAYQBjAHQAaQBjAGUAIABTAHQAYQB0AGUAbQBlAG4A
dDA1BggrBgEFBQcCARYpaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNQUy5wZGYw
bAYDVR0lBGUwYwYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMEBgor
BgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAwkGCSsGAQQBgjcVBQYKKwYBBAGCNxQCATAZBgkr
BgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNV
HSMEGDAWgBStAYfq3FmusRM5lU0PV6Akhot7vTCBgAYDVR0fBHkwdzB1oHOgcYYxaHR0cDovL2Fr
YW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNvcnBSb290LUcxLmNybIY8aHR0cDovL2FrYW1haWNy
bC5kZncwMS5jb3JwLmFrYW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3JsMIHIBggrBgEFBQcB
AQSBuzCBuDA9BggrBgEFBQcwAoYxaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNv
cnBSb290LUcxLmNydDBIBggrBgEFBQcwAoY8aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFr
YW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vYWthbWFp
b2NzcC5ha2FtYWkuY29tL29jc3AwCgYIKoZIzj0EAwIDRwAwRAIgaUoJ7eBk/qNcBVTJW5NC4NsO
6j4/6zQoKeKgOpeiXQUCIGkbSN83n1mMURZIK92KFRtn2X1nrZ7rcNuAQD5bvH1bMIIFITCCBMig
AwIBAgITFwALOJfLRtbGzZc1dwABAAs4lzAKBggqhkjOPQQDAjA8MSEwHwYDVQQKExhBa2FtYWkg
VGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMB4XDTI1MDgyODA3NTYy
OVoXDTI3MDgyODA3NTYyOVowTjEZMBcGA1UECxMQTWFjQm9vayBQcm8tNDZZVDEPMA0GA1UEAxMG
bWJvb25lMSAwHgYJKoZIhvcNAQkBFhFtYm9vbmVAYWthbWFpLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAOX+npfSrX/rwhOySq6aejQMUVslPFpNvXdEnmMlnEjR95gq0Ygp+wQc
Sde+JGBpGHsPMzHT1Nd3V1acm4cW1WB1aRqJOMfSLifg6SLkq2EM9WsftEiA1G4BT4UP0PFZY2Os
6TXvebAuVg6LwhB417rEJ2kuS/DKpiG8trAVDR6Uy9vbSMBp6iIewBc9r0CjW8l1zgRr+uQpXEUP
mF2BV0l3Qo5r0nhPqTWR9oAX4/oTqnhbEhQ3tOFYTjzO1K9DdzX8mVggVSZz/M0v0gtkZVvO4B1t
3Sh+1lla5eMY4hlVHW1/FKqMe4EMXmDH7goTEuXPpelJiNRdBh7ud7xNNFUCAwEAAaOCAsowggLG
MAsGA1UdDwQEAwIHgDApBgNVHSUEIjAgBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcKAwQw
HQYDVR0OBBYEFO0y/xWMpkyOUMuNKmuzNtjXpdtRMEQGA1UdEQQ9MDugJgYKKwYBBAGCNxQCA6AY
DBZtYm9vbmVAY29ycC5ha2FtYWkuY29tgRFtYm9vbmVAYWthbWFpLmNvbTAfBgNVHSMEGDAWgBS2
N+ieDVUAjPmykf1ahsljEXmtXDCBgAYDVR0fBHkwdzB1oHOgcYYxaHR0cDovL2FrYW1haWNybC5h
a2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEpLmNybIY8aHR0cDovL2FrYW1haWNybC5kZncwMS5j
b3JwLmFrYW1haS5jb20vQWthbWFpQ2xpZW50Q0EoMSkuY3JsMIHIBggrBgEFBQcBAQSBuzCBuDA9
BggrBgEFBQcwAoYxaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEp
LmNydDBIBggrBgEFBQcwAoY8aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFrYW1haS5jb20v
QWthbWFpQ2xpZW50Q0EoMSkuY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vYWthbWFpb2NzcC5ha2Ft
YWkuY29tL29jc3AwOwYJKwYBBAGCNxUHBC4wLAYkKwYBBAGCNxUIgs7lOoe41C2BhYsHouMhhtIP
gUmFpcMQmtV/AgFkAgFTMDUGCSsGAQQBgjcVCgQoMCYwCgYIKwYBBQUHAwIwCgYIKwYBBQUHAwQw
DAYKKwYBBAGCNwoDBDBEBgkqhkiG9w0BCQ8ENzA1MA4GCCqGSIb3DQMCAgIAgDAOBggqhkiG9w0D
BAICAIAwBwYFKw4DAgcwCgYIKoZIhvcNAwcwCgYIKoZIzj0EAwIDRwAwRAIgD5UL4MI1RXeg64RR
kifZAeItCnkZ4ecrqSEGpLcXV+ICIAdB9vZdM1WGxtag0rlqG0j0FBrCWixC0cdHNpFrqNx/MYIB
6TCCAeUCAQEwUzA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMT
DkFrYW1haUNsaWVudENBAhMXAAs4l8tG1sbNlzV3AAEACziXMA0GCWCGSAFlAwQCAQUAoGkwGAYJ
KoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwNDI5MTMyOTQ2WjAvBgkq
hkiG9w0BCQQxIgQgZl/J/HhpgnRjwhFxejdAiwNYdD5mwx9yO7eQCyEWCaAwDQYJKoZIhvcNAQEL
BQAEggEAAyrQHNEoKbqKsqy+Dq4jY90gsdy/muUKBDxXW/PDgCMxjTrYUr10ywCgNO9htFseX+d/
nZyKAjWVazAOy2dJRr0U1OTIAC+6JsitU4QCHOgiRGbaQnMnAsvDjAE/rH1mg6JiniAmiYSQLK3Z
Uw0+3nVQXPfxGS0u7TB/RyhCKdZcaG1bN+iOhctWVmEG7gotQJh7SqAJA+YlKNJ0Re3AVsNq3w52
0HzeYRyMDaKFhrlhu4ptuXzdpMUutcTPGUTkXO5oq6hgkTE5uCtP4HrBsdBsSrHoL+dFZtLZGPSB
X/A9IJ01wLKQ/BZ21dwKI/hW0+SWRz8z/uoOq63vluDf0wAAAAAAAA==

--Apple-Mail=_D4D7DC8F-A7F4-442B-912C-D93B4285305B--

