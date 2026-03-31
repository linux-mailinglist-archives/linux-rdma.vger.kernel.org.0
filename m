Return-Path: <linux-rdma+bounces-18836-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPFjJvu8y2kwKwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18836-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 14:24:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB033696ED
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 14:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 087F23067A2C
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 12:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FDD3E1CE4;
	Tue, 31 Mar 2026 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YPMhh1+x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010004.outbound.protection.outlook.com [52.101.193.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D466E378812;
	Tue, 31 Mar 2026 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959649; cv=fail; b=SM6C7+1TyHtDMS0Ivq285GNsDhiVWBosdbKagSOQNXeEC89b+g7hOqvJvUHo5ub5RDhe6TFOvYuXODL3prO4wwxnz6Ms1wOJOVfkOeVFZe5OQVQsVxVZKC16XK9ysAOOD2zeL45iPcJA5ANZkljBw/D7XZxBHYQ2eWy/G9hOUyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959649; c=relaxed/simple;
	bh=oy1wwBvj7MMl00JBrri7FuhCKbYpLefqNLVNm0s3LTg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qhFyK1c4+T4LWH6JmDYKdoVaeaTytLhF4AoZOAcqLhT27cdLDnYvr4/8OJaVcGlCbPMs71PMb/ETCxp8s1MVbGVB9Vgixj8BhsyQbcPZ48IKwlAqcdy0pzEzjIwBQhp4AMZaN0mJKQp99Q/a3Cbia3szTYdxMyQMLduBIGPTOpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YPMhh1+x; arc=fail smtp.client-ip=52.101.193.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NW/x8rR50AYfPAVBILHhcCygQtBjaOfiPeDPlUS2SHGo1kGn6vkSX7WO+7vgEUAvIw+TZiaQqWJ+EqrPuZzbcbk48LMqc6ZOzpv8qM95UMyCLajvBP+b7kgAVmlth5HDYM6csB4A8nw+1It/No60fTsJSqnVdJHoOnKGRLUEBNAUUUeMrqCDWTGEZfjoElTh0gETUZ7br6pqos2SEzy4PWrReog8QAyy4XtFsL038o/QWXci/NuCyySGl8QQxV2o9ENnnJjQoxSTgJOAGjl6FguKFgHiA18vbRemfgces3rV/O6tRSL9EHe/G7jHmQ8eJIoZytGaw1mmGWZeflB7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oy1wwBvj7MMl00JBrri7FuhCKbYpLefqNLVNm0s3LTg=;
 b=rTRP/mFEaVVc9RLojjiMB4wOMZya9vAYZb7iY/MWRYj6ewzQZcOXV5U1DFsxbJHkcT9h+74zAdR7MmAMybPLq1jJnzOW2aGm6v5WQG4A6+4rbrAPVo7EsCG3rFvPw72QL3s6pXYhwAEJWaBhKPmPrU9u0CtQUouleR/E4op2TRgx1xiGWYuyq0JSBdcE/05rLIMh3NT3MshTGjK/xAQ17mco1AzwtWHzzegQQpk+5lvZAzLzBKPpl25TqUFc3Rt24OM9T3wjVhufsUoy1WVXid7kG54xwHa8Doiet8+yVZy4sZnOdzbNGWAskwdY2VV6AvlMahEdTtB8cmieN1PMLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy1wwBvj7MMl00JBrri7FuhCKbYpLefqNLVNm0s3LTg=;
 b=YPMhh1+x2jxoMmUBxEBtxeyIJdkbgrm0G+qES0trkXNUmimqmtmvw0TuM94Y03E1M+lSGhJnnr54/OhPNogPlHgc4bRqm7A+k6FiKD3qzMfhfXILK7TXb0iW1NJ3Rj97CSsBknTe9/0OPD5IDSCdk4JoCS5irVqHenxGQ3Lx58Ci6EjPeGX+7JDQ1vN9wsmqdVdNN8lAFyqvaI3r3djU+6dmiJWEpfXW66bBIRjC2pSpK7zy0VOPgPwRms8UEuzjhk9ydBpmb+001ohMfroG3gRocdaAQodaP0N0i05P+C4jea0hHPuDrLr5q5JCng4yEtNCBIbcfdZsdYVdAQyeTA==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by DS7PR12MB6023.namprd12.prod.outlook.com
 (2603:10b6:8:85::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 12:20:37 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d8b5:cf72:3e36:3701]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d8b5:cf72:3e36:3701%7]) with mapi id 15.20.9769.006; Tue, 31 Mar 2026
 12:20:37 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: "allison.henderson@oracle.com" <allison.henderson@oracle.com>, Moshe
 Shemesh <moshe@nvidia.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "daniel.zahka@gmail.com"
	<daniel.zahka@gmail.com>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"matttbe@kernel.org" <matttbe@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, Parav Pandit
	<parav@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>, "kees@kernel.org"
	<kees@kernel.org>, "willemb@google.com" <willemb@google.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, "razor@blackwall.org" <razor@blackwall.org>, Adithya
 Jayachandran <ajayachandra@nvidia.com>, Dan Jurgens <danielj@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Mark Bloch <mbloch@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"minhquangbui99@gmail.com" <minhquangbui99@gmail.com>, Nimrod Oren
	<noren@nvidia.com>, "dw@davidwei.uk" <dw@davidwei.uk>,
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, Petr Machata
	<petrm@nvidia.com>, "edumazet@google.com" <edumazet@google.com>,
	"antonio@openvpn.net" <antonio@openvpn.net>, "mst@redhat.com"
	<mst@redhat.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Shay Drori <shayd@nvidia.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>, Gal Pressman <gal@nvidia.com>, "joe@dama.to"
	<joe@dama.to>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next V9 02/14] devlink: Add helpers to lock nested-in
 instances
Thread-Topic: [PATCH net-next V9 02/14] devlink: Add helpers to lock nested-in
 instances
Thread-Index: AQHcvO5QLSguTHJDkEyNqzlfoJexP7XH7JAAgACrG4A=
Date: Tue, 31 Mar 2026 12:20:36 +0000
Message-ID: <ff5b2ec46d6cb639872318bdde429c46cac77f5b.camel@nvidia.com>
References: <20260326065949.44058-3-tariqt@nvidia.com>
	 <20260331020807.3524811-1-kuba@kernel.org>
In-Reply-To: <20260331020807.3524811-1-kuba@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|DS7PR12MB6023:EE_
x-ms-office365-filtering-correlation-id: 0624228f-4894-4872-adb1-08de8f1fea5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 P+wlVBgeDtJJqACBEK9yCwavUoVzTJoRZGaNAUWPgtabPi/a4jSrrGB+WEKY9kQlmfWDOVf/YQtSRAvt4MW4SwSgBLCrCUGyf8aCeF1q9tnm+G6Eqap1GtecJhIamXdd/iMzaQqYq0puSA/4ug49KrQ5nz5XTrRJ0HGwcROohASvOAEKUe/4VQ1QZIqsCdF7ZM1/rFEGmBnZDUTfKdJdd0NUN97Zpwp+oN1dJH72asnoRPtb/adjMfKmybpV4p6U2O7Ge1A5hiZLPFI1ZWoIDrsDGBgNYFZe8IRDmWKUf9oNINPeLdFj2+0kitbRDyCvKkuI4XpKrDNLPwVnyqtzsZvUNLR75qQxFxGksWf51NyqkVMoaPVjWmyHKt2gg2MUWYowLAVCiC1JlrXbYWEmW2E0jObG0ImOEH0ZFOQa/Xhdcmq5mPzBNOq9haUU0U5pNgF6bhVa7Apmg53h87Dr+s0INWnMav7tqEvt9G9LeChA1oKlRBn73vqnkS6N1gcp/WOFxG6k+q+8WriyeOBSOeu6zsPqFUoA0SRlxu41llXKwPWjmNbkpJBPqFbnliPd+j0eYN9Q4H+YVwdbzv/XCWtqz+crURXaROz/HDrxeegD6PO7yLFhybd1G7n8n4KdyCDpu7EeYolAP8mtFT1CrhGLNugkBKrFiqS84wphVvfR0z3156qWmAAmYqxnJtGmnkf7esru8pBvQi7Aop4cRH0xD835EXIceqLBft+dxz9iJNIOMLFVkco++S7SPcf0jugIqaR5JHvKVO0Ds3o1m2DCcbdF+vKKrLk1aAUBjmg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QWJQRzNsQmJrajRJRFlCNFRwOUFIb3R2TjAyTisySUhyODBtUVFxdmw2MzVv?=
 =?utf-8?B?OEhBTklzUy9ocjhnbGZKcGN1U2lrajRaaWxSSFVvWjJuQ2VSbFdSaXE4amhT?=
 =?utf-8?B?TjRpa3htbEJ5bmowVzZTaE5nVUlLR3B3bUVvRXhaTjUvR2kvb1dXN0NMeS9w?=
 =?utf-8?B?MzEzVDFZV2lIbWpNbUtRRy9ReVZMclRPK2pNZ0w3MkEwemFDRW1wSjZpWTV4?=
 =?utf-8?B?Z0UyOVdkQTZuWGZEeVNMaDBQMVZlR0kvZHd4QWhsd2JkZEFIRUNVT3hRU3ky?=
 =?utf-8?B?dyt1TW1POTUyM1g2Y2QvVEx3SGkyUWxzWHNpS0JpVStsK1RQTEdGNk16RTho?=
 =?utf-8?B?ejcvdFVqMVhqaTFEeUR5QWRCL01FbytNekRCM25XS3Y5bXV6dmcwdmd3aTRN?=
 =?utf-8?B?cW5rRERpSll0bFZKdytJclIzVkt5SEVWeGI5VUh4RUk2T0ZIU2QvTTNYNk92?=
 =?utf-8?B?TkNnZGp6N3ZRcG9ycEhud2h6di9abTNCOXlvaWNPaEFlczhQZnY3OW9uYWpk?=
 =?utf-8?B?U1Mzb3llREk1blJSY0FiS0VGVzRwTDVhU3Y3TEd6bXpvL3RpdExLY1gxeVd2?=
 =?utf-8?B?Ymd0bllLYWVtWHVZNjhTdkxjNGhaK213SnRVSmkrZWVSMURTNHZxSzRlTDZu?=
 =?utf-8?B?MFlqUDU3MEgrdXRRSXdmaTRteUllV1F1WTFGLzU2bmxIUUZCSHArdS9Dbk90?=
 =?utf-8?B?dWlodW5PVE01amZjbks4Wkg2QkVINlpOZUhzU2xiZk9vK1ZVU0VlbmVGTC9p?=
 =?utf-8?B?bVZ0NWlpdk5GeStwZDJINXZISXlQL3hZeVVZNjZwZUVsa2VUZ2pKMkdxbEJT?=
 =?utf-8?B?VDJxM0hnMVg1UXVBNjlTTTdKRy9Ic29PYzg4aGFqTmwwbWloZGxnb2QvMk5X?=
 =?utf-8?B?RmpkOGZxNWRBUEVCWnNpcnRETGU5UVlWQTdxUjY4eVE0Mk5OUTJlN1ZSSGlu?=
 =?utf-8?B?Y1MxY1ZaOUhURkRmbFNEWjkwdHVZTXh1OTBkYURVVGNCSWNUQVRBQWpBc29Q?=
 =?utf-8?B?bnpTN3lrKzRtS0dieGlNWHIzRWVvV1U2K2t1WDNQUkFpUmlRQ0xScVVwcXBh?=
 =?utf-8?B?NzF6YTNvWFoyWmc2OC9iMFgzUTlXYkU1TjRsTFl4VCtHOVpLTGFaeit1L1Nt?=
 =?utf-8?B?NFlqNDJWS2JnalYzY3o0WWNPcHBDdVVMc05KaXdrKzZwYmRDSlB4WE81bUZG?=
 =?utf-8?B?YjNiZnBSVHJ5MHRtclNoREcrNmRUam9INnUyN2xCYWJxWThnWWw5eVBaUExP?=
 =?utf-8?B?cXFnUVhqVC9nMDMzY1VkbXRWcndzMkMyeFB1RFJHR2lFdGVwcTRvMkFTZlAr?=
 =?utf-8?B?SVZzZC9VS1cyVy9hVTREa0V4YUlyd0FmUlVGdHRBeDRGTXRad2xHY1JlMTFC?=
 =?utf-8?B?VGk2VURtWUJickwrYVh2N3h6N0VVNDlwSXNFVzRqSFpnd1BFWUNxd2tZZDZr?=
 =?utf-8?B?SHhSY0IzYStuQnRIMFZUN0JiaEowRHdaUmVMZ2dvZHR1VU55aXVKQVg2Z1Iz?=
 =?utf-8?B?YTdKWDl0UzJqQXRHN3ROeVBsd2tSVHgvOTNzQ2cwd0c1Umw5UjhLMGxBYVZL?=
 =?utf-8?B?em5ZRmR5MElvTkZ1elNDcnl5elZJL3JPdVdEVmU4S0FONFNNWCtOS1M1NGUr?=
 =?utf-8?B?WG1YanFPQkh2aWVpaGZJUzBMcXFVWHE1Z3hFaXo5RHNUNWZrTHhGZXZvejJP?=
 =?utf-8?B?dEdxcEpsd2p1OEtJWFJ3VHk1c0lyREVEZGw4UHJGMzdGbGFGT3Z6OVZ1RXB6?=
 =?utf-8?B?VVZGRjhWcFFSNWo3K2RBdEt3TXRFS051aTFadkd6d0F4Nk9ONVdYVFlEdE1r?=
 =?utf-8?B?azhxYjZDQ1ByK1UvQTRrWXZKdkw2SGpDOURtMU5CNWo3ZnFJSFdrdXdVcVo3?=
 =?utf-8?B?RE04NGtxQ2dtcXZhZmpTMDc3bmNJQWRUMGp6SnpNcGwyRXZNTnBOb0YvTHpX?=
 =?utf-8?B?NkY4Smwwa3VtRUFidzIwdWpIc015NVJTcUV6d0k2V2YzaDhzM0tjR0VJU1Yv?=
 =?utf-8?B?N243anlKOWVzUGw1eWI2Y2FWVjd1bXVVVHA0WENWWjNnL1p2Rk9ocW1aL1g5?=
 =?utf-8?B?RDNzayt6MHJtNlBWbEczRktRaU54cExHYlE0MUdpZThOT1FYdnZxa0N3OFQ5?=
 =?utf-8?B?Z1kvR09mZTZtbFFnWXdtNzBsYWdaanpaQlo2d0owQU93a3ZDRkREVnpjdVNQ?=
 =?utf-8?B?OW5PZUlwNWMveWp6MGRzMVZyRUpIL044NHNaOUo4TExnRnV4VDBsQlNyME5C?=
 =?utf-8?B?M1h4c2k4U3BNMWJ1by9aTjBvWksxRFBscTZJNE9TUmhON0N0QzhNYUY3UE9k?=
 =?utf-8?B?ZTBld0tKQzF3SXRKU0pYNkhzdlNDcnppb0FURlVLdnRnQWxjNFA5QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F02ACCFEB945C341AD46AFB5D6E3B6F2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0624228f-4894-4872-adb1-08de8f1fea5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 12:20:37.1580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7pSt1lF+VHx81rRVixXW6+6VGGgDHsS1G6XQk9C3ROrOZcGOP6jbh+e3CMqeyJYj7YP+9vzs5OpSPtoa8W0rKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	TAGGED_FROM(0.00)[bounces-18836-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oracle.com,nvidia.com,resnulli.us,davemloft.net,gmail.com,vger.kernel.org,kernel.org,redhat.com,lwn.net,google.com,blackwall.org,linux.dev,lunn.ch,iogearbox.net,davidwei.uk,intel.com,linuxfoundation.org,openvpn.net,fomichev.me,dama.to];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:replyto,nvidia.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: EBB033696ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDE5OjA4IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gVGhpcyBpcyBhbiBBSS1nZW5lcmF0ZWQgcmV2aWV3IG9mIHlvdXIgcGF0Y2guIFRoZSBodW1h
biBzZW5kaW5nIHRoaXMNCj4gZW1haWwgaGFzIGNvbnNpZGVyZWQgdGhlIEFJIHJldmlldyB2YWxp
ZCwgb3IgYXQgbGVhc3QgcGxhdXNpYmxlLg0KPiAtLS0NCj4gZGV2bGluazogQWRkIGhlbHBlcnMg
dG8gbG9jayBuZXN0ZWQtaW4gaW5zdGFuY2VzDQo+IA0KPiBVcGNvbWluZyBjb2RlIHdpbGwgbmVl
ZCB0byBvYnRhaW4gYSByZWZlcmVuY2UgdG8gbG9ja2VkIG5lc3RlZC1pbg0KPiBkZXZsaW5rIGlu
c3RhbmNlcy4gQWRkIGhlbHBlcnMgdG8gbG9jaywgb2J0YWluIGFuIGFscmVhZHkgbG9ja2VkDQo+
IHJlZmVyZW5jZSBhbmQgdW5sb2NrL3VucmVmIHRoZSBuZXN0ZWQtaW4gaW5zdGFuY2UuDQo+IA0K
PiA+IGRpZmYgLS1naXQgYS9uZXQvZGV2bGluay9jb3JlLmMgYi9uZXQvZGV2bGluay9jb3JlLmMN
Cj4gPiBpbmRleCBlZWI2YTcxZjVmNTZlLi5kYjExMjQ4ZGY3MTIwIDEwMDY0NA0KPiA+IC0tLSBh
L25ldC9kZXZsaW5rL2NvcmUuYw0KPiA+ICsrKyBiL25ldC9kZXZsaW5rL2NvcmUuYw0KPiANCj4g
WyAuLi4gXQ0KPiANCj4gPiArLyogUmV0dXJucyB0aGUgbmVzdGVkIGluIGRldmxpbmsgb2JqZWN0
IGFuZCB2YWxpZGF0ZXMgaXRzIGxvY2sgaXMNCj4gPiBoZWxkLiAqLw0KPiA+ICtzdHJ1Y3QgZGV2
bGluayAqZGV2bGlua19uZXN0ZWRfaW5fZ2V0X2xvY2tlZChzdHJ1Y3QgZGV2bGlua19yZWwNCj4g
PiAqcmVsKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgZGV2bGluayAqZGV2bGluazsNCj4gPiArCXVu
c2lnbmVkIGxvbmcgaW5kZXg7DQo+ID4gKw0KPiA+ICsJaWYgKCFyZWwpDQo+ID4gKwkJcmV0dXJu
IE5VTEw7DQo+ID4gKwlpbmRleCA9IHJlbC0+bmVzdGVkX2luLmRldmxpbmtfaW5kZXg7DQo+ID4g
KwlkZXZsaW5rID0geGFfZmluZCgmZGV2bGlua3MsICZpbmRleCwgaW5kZXgsDQo+ID4gREVWTElO
S19SRUdJU1RFUkVEKTsNCj4gPiArCWlmIChkZXZsaW5rKQ0KPiA+ICsJCWRldmxfYXNzZXJ0X2xv
Y2tlZChkZXZsaW5rKTsNCj4gDQo+IENhbiB0aGlzIGRlcmVmZXJlbmNlIGEgZnJlZWQgcG9pbnRl
ciBpZiB0aGUgbG9jayBpcyBub3QgYWN0dWFsbHkNCj4gaGVsZD8NCj4gDQo+IHhhX2ZpbmQoKSBh
Y3F1aXJlcyBhbmQgcmVsZWFzZXMgdGhlIFJDVSByZWFkIGxvY2sgaW50ZXJuYWxseS4gV2hlbiBp
dA0KPiByZXR1cm5zLA0KPiB0aGUgZGV2bGluayBwb2ludGVyIGlzIG5vIGxvbmdlciBwcm90ZWN0
ZWQgYnkgUkNVIG9yIGEgcmVmZXJlbmNlDQo+IGNvdW50Lg0KPiANCj4gSWYgYSBjYWxsZXIgaW52
b2tlcyB0aGlzIGhlbHBlciB3aXRob3V0IGhvbGRpbmcgdGhlIGRldmxpbmsgbG9jaw0KPiAod2hp
Y2ggaXMgdGhlDQo+IGV4YWN0IHNjZW5hcmlvIHRoZSBhc3NlcnRpb24gaXMgZGVzaWduZWQgdG8g
ZGV0ZWN0KSwgYW5vdGhlciB0aHJlYWQNCj4gY291bGQNCj4gY29uY3VycmVudGx5IHVucmVnaXN0
ZXIgYW5kIGZyZWUgdGhlIGRldmxpbmsuDQo+IA0KPiBJZiB0aGUgUkNVIGdyYWNlIHBlcmlvZCBl
eHBpcmVzIGJlZm9yZSB0aGUgYXNzZXJ0aW9uIGV4ZWN1dGVzLA0KPiBkZXZsX2Fzc2VydF9sb2Nr
ZWQoKSB3b3VsZCBkZXJlZmVyZW5jZSBmcmVlZCBtZW1vcnkuIFNob3VsZCB0aGUNCj4gbG9va3Vw
IGFuZA0KPiBhc3NlcnRpb24gYmUgZW5jbG9zZWQgd2l0aGluIGFuIGV4cGxpY2l0IHJjdV9yZWFk
X2xvY2soKSBibG9jayB0bw0KPiBzYWZlbHkNCj4gYXNzZXJ0IHRoZSBsb2NrPw0KDQpUaGlzIGZ1
bmN0aW9uIGlzIG1lYW50IHRvIGJlIGludm9rZWQgYnkgY2FsbGVycyBhbHJlYWR5IGhvbGRpbmcg
YWxsDQpsb2NrcyBmcm9tIGEgZ2l2ZW4gaW5zdGFuY2UgdXAgdGhlIG5lc3RpbmcgdHJlZS4gQ2Fs
bGluZyBpdCBvdXRzaWRlDQp0aGlzIGNvbnRleHQgY291bGQgaW5kZWVkIGxlYWQgdG8gYSByYWNl
IGFzIGRlc2NyaWJlZCwgd2hlcmUgYW5vdGhlcg0KZW50aXR5IHVucmVnaXN0ZXJzIGEgZGV2bGlu
ayBhYm91dC10by1iZS1hc3NlcnRlZCBvbi4NCg0KQWxsIGN1cnJlbnQgY2FsbGVycyBob2xkIHRo
ZSBsb2NrcywgYnV0IHRvIG1ha2UgaXQgbW9yZSByb2J1c3QsIEkgd2lsbA0KYWRkIHRoZSByY3Vf
cmVhZF9sb2NrL3VubG9jayBzZWN0aW9uIGFyb3VuZCB0aGUgZmluZCthc3NlcnQuDQoNCj4gDQo+
ID4gKwlyZXR1cm4gZGV2bGluazsNCj4gPiArfQ0KPiA+ICsNCj4gPiArdm9pZCBkZXZsaW5rX25l
c3RlZF9pbl9wdXRfdW5sb2NrKHN0cnVjdCBkZXZsaW5rX3JlbCAqcmVsKQ0KPiA+ICt7DQo+ID4g
KwlzdHJ1Y3QgZGV2bGluayAqZGV2bGluayA9DQo+ID4gZGV2bGlua19uZXN0ZWRfaW5fZ2V0X2xv
Y2tlZChyZWwpOw0KPiANCj4gQ291bGQgdGhpcyBjb3JydXB0IHRoZSBtdXRleCBzdGF0ZSBhbmQg
Y2F1c2UgYSByZWZjb3VudCB1bmRlcmZsb3c/DQo+IA0KPiBUaGlzIGhlbHBlciB0YWtlcyBhIGRl
dmxpbmtfcmVsIHBvaW50ZXIgaW5zdGVhZCBvZiB0aGUgZGV2bGluaw0KPiBwb2ludGVyDQo+IGFj
cXVpcmVkIGJ5IGRldmxpbmtfbmVzdGVkX2luX2dldF9sb2NrKCksIGFuZCBwZXJmb3JtcyBhIHNl
Y29uZGFyeQ0KPiBnbG9iYWwNCj4gbG9va3VwIHRvIGZpbmQgdGhlIGRldmxpbmsuDQo+IA0KPiBJ
ZiBhIGNhbGxlciBtaXN0YWtlbmx5IGNhbGxzIHRoaXMgaW4gYW4gZXJyb3IgY2xlYW51cCBwYXRo
IHdoZXJlIHRoZXkNCj4gZGlkIG5vdA0KPiBhY3R1YWxseSBhY3F1aXJlIHRoZSBsb2NrLCB0aGUg
Z2xvYmFsIHhhX2ZpbmQoKSB3aWxsIHN0aWxsIGxvY2F0ZSB0aGUNCj4gcmVnaXN0ZXJlZCBkZXZs
aW5rLiBUaGlzIHdvdWxkIGV4ZWN1dGUgZGV2bF91bmxvY2soKSBhbmQNCj4gZGV2bGlua19wdXQo
KSBvbiBhDQo+IGRldmxpbmsgdGhlIGN1cnJlbnQgdGhyZWFkIGRvZXMgbm90IG93bi4NCj4gDQo+
IFdvdWxkIGl0IGJlIHNhZmVyIGZvciB1bmxvY2svcHV0IGhlbHBlcnMgdG8gdGFrZSB0aGUgZXhh
Y3QgcG9pbnRlcg0KPiByZXR1cm5lZCBieQ0KPiB0aGUgbG9jay9nZXQgaGVscGVyIHRvIGVuc3Vy
ZSBzYWZlIHJlc291cmNlIGNsZWFudXA/DQoNCjIgaXNzdWVzIGhlcmU6DQoxKSBNaXN0YWtlbmx5
IGNhbGxpbmcgdGhpcyB3aXRob3V0IGhhdmluZyBhY3F1aXJlZCB0aGUgbG9jay4gVGhpcyBpcw0K
YWtpbiB0byBzYXlpbmcgbXV0ZXhfdW5sb2NrIGlzIGRhbmdlcm91cyBpZiB0aGUgbG9jayBpc24n
dCBoZWxkLg0KVGVjaG5pY2FsbHkgdHJ1ZSwgYnV0IG1vb3QuDQoyKSBUaGUgcmVsIGFyZ3VtZW50
OiBJdCBpcyBpbnRlbnRpb25hbCwgc28gdGhhdCBhbGwgMyBmdW5jdGlvbnMgYXJlDQpzeW1tZXRy
aWNhbC4NCg0KPiANCj4gPiArDQo+ID4gKwlpZiAoZGV2bGluaykgew0KPiA+ICsJCWRldmxfdW5s
b2NrKGRldmxpbmspOw0KPiA+ICsJCWRldmxpbmtfcHV0KGRldmxpbmspOw0KPiA+ICsJfQ0KPiA+
ICt9DQoNCg==

