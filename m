Return-Path: <linux-rdma+bounces-18853-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJQzO+wAzGk8NQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18853-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 19:14:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9746B36E43A
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 19:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE8AD3265173
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 16:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6A442EED6;
	Tue, 31 Mar 2026 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ebish2p5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013000.outbound.protection.outlook.com [40.93.196.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD7C423A8B;
	Tue, 31 Mar 2026 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975054; cv=fail; b=mPRDtJBMMq8gw6qOPWrAQTxjt1DCZTnhR0219Ij8kbIkumaj/fRA3bApTgM+WbJHSfLvbyTGZFJYyrs5xbJGo/Zf/FuTcLeowpZ9pG//wi3hfP7QwzAZ/6pRSpDjQs5Qd07ZPc7cJk8pRd4I+qxBpgiu7mlKjiBMrxpytoIB1zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975054; c=relaxed/simple;
	bh=CyFTi82G4i9FRIqbDxg/Lf3zbatSUIBnc+8Hmd1F1hw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=roNAlkkkogSsW6cxoAgGdMAqbgtsTaV9exP6QZeXzIf8X56HKs26W0YMukWv4mraz+AQlW4s/v1qoRlJQ8/1Elk3bvyBaoirkhYaq6LOnXI6xCv5clbK6Hhg/nywFDqeybXz4GIqMU68mcPlnyv9nbWW1SOKuMX3az/IEN40L40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ebish2p5; arc=fail smtp.client-ip=40.93.196.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSNCD5xViH7zAACCCALx32hntre6Zp7XFKoMtzGzIQURLNbVMQ2MHhTwXryLQC1bpLhDhALtStfHawsiipRIw4wRXrcK/o8VPep9+m6nv8HIvQP+ejgFRYQwsOLk0OAHnqAugFSrllLksQgIkEGaZ+/ctLF80tODngpJaIpm6ba5kqoqoiEQ49NLT4JRCxxufADfMhmyKDGfKGAITB0X4qxx9YC3kNZTsUpUVSx+8bAYQVFTm0SgBVi1FWVHfcIcm+qslWgb6HURUK85IqEnQ1nQ7llPmlGGVz7892D250a86tMp2ccij+d9+3bttcfiSbmokjYna1N4TwlHCMzkbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyFTi82G4i9FRIqbDxg/Lf3zbatSUIBnc+8Hmd1F1hw=;
 b=jimDjKKU9PTe+KQ2CzmzoKHJ5Q/WVfkXhAwU447+eu5SzDFwau0O7SOC/0ylwPzSbXqQ4VRLaXHXjaNp2FsiHkmsozXgqLR6pYOQ0xc5kI3u7fLQdbe0QugMqfdvu9uuM87Day+Nqs5K02e/5MjBip7K+AKpDG6m4VGobqe8EcIY6JIV/8BF2Q2wt/jwNVOae/B7TkIgd7sn0kkCIpAs1p7oPpPfNJn3o+yYWvaWuvOKerjPfGp6InOS+fYjUmE7uUf0tZzJFc4VD1gcjP+dacxXaaDt+Xwa0irSH0Ncm9jq8TDs8rANlwFPsbzHCbsBZvn2LU3vRLpblpqS5tR1Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyFTi82G4i9FRIqbDxg/Lf3zbatSUIBnc+8Hmd1F1hw=;
 b=ebish2p5Nj3eEBITrWpZY10MV/tlth8P7GiNGmd8fp36gZVHBXLmLnfm6q7kuLFIhCf0hUwkAHSbDNC9MWkfke2SF1WRZDTjWAMYDHPX3A8TgrvD2/4qTtxBi7ZXOWJJfoMlQ7PIe8txDDpGzuRx1PNfdoI4r88SANdWDkMCFVFIwlp8c8IpPElFwhEfm/kIYANUhJyb/xQ4mxQM0nnipTm97jqR9N7sih8U6+fwgVMkncB7fVBO++djHEum9LE8pB9aY0rUMOXOZaaoZydOJdeeAGWhULHaghnFFtA8ohpQ0OVYsMYATLBy2ynaREheUel0TDjw62kFDf3b/xEKiQ==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by MW4PR12MB7167.namprd12.prod.outlook.com
 (2603:10b6:303:225::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Tue, 31 Mar
 2026 16:37:26 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d8b5:cf72:3e36:3701]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d8b5:cf72:3e36:3701%7]) with mapi id 15.20.9769.006; Tue, 31 Mar 2026
 16:37:26 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: "allison.henderson@oracle.com" <allison.henderson@oracle.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, Moshe Shemesh <moshe@nvidia.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "daniel.zahka@gmail.com"
	<daniel.zahka@gmail.com>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"matttbe@kernel.org" <matttbe@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, Parav Pandit
	<parav@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>, "razor@blackwall.org"
	<razor@blackwall.org>, Dragos Tatulea <dtatulea@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"willemb@google.com" <willemb@google.com>, Jiri Pirko <jiri@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>, Dan Jurgens
	<danielj@nvidia.com>, "leon@kernel.org" <leon@kernel.org>, "kees@kernel.org"
	<kees@kernel.org>, "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	Saeed Mahameed <saeedm@nvidia.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, Mark Bloch
	<mbloch@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Nimrod Oren <noren@nvidia.com>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "minhquangbui99@gmail.com"
	<minhquangbui99@gmail.com>, "dw@davidwei.uk" <dw@davidwei.uk>,
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
Subject: Re: [PATCH net-next V9 11/14] net/mlx5: qos: Remove qos domains and
 use shd lock
Thread-Topic: [PATCH net-next V9 11/14] net/mlx5: qos: Remove qos domains and
 use shd lock
Thread-Index: AQHcvO6IXLFzSyQsmEqavWdOpaGuYLXH7J2AgAC0WACAAD52gA==
Date: Tue, 31 Mar 2026 16:37:26 +0000
Message-ID: <94418ddbb367595aea7c0f73d97c36ab224a7694.camel@nvidia.com>
References: <20260326065949.44058-12-tariqt@nvidia.com>
	 <20260331020817.3525089-1-kuba@kernel.org>
	 <3bd3caead46d1965d3a7a151d0ef0a54ac78332a.camel@nvidia.com>
In-Reply-To: <3bd3caead46d1965d3a7a151d0ef0a54ac78332a.camel@nvidia.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|MW4PR12MB7167:EE_
x-ms-office365-filtering-correlation-id: 16ba28b6-cd65-4ef8-5584-08de8f43cb26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 Cyd7kKOkQn4ZQUoGLwPfz2CbM/IyuKFO55dFmwVTNuc9jcjxEIVBesxiqELuNvw/MOBP5pjW471gcPj1q1vTNrAdRIfnAGMWoABkVzzYlWM/HZvHPtm1yer4R0eTHw3tnIBiUgBML9bN1S4JtUqSgPYRcWhy7SZE0Jq7ApiqINUTJzs+Ih6IIJSNhtaNS/1as/SKSqHtaJ8zdudFr8nqVkhxwvPvvs463JYa5paW1GK6jIKIX3xraqylPG7Qscb8sT2bNEnlBQRD39k6bfTeE+/peYMOn0DkURWdRWzFF4W2aC8JR6KrGEavcLFTPlAeNAPkpThjORcG4BjOX4LbrSR7QhSNK9iBtsjOdK71zQJ8syy6csC2Bpqyvr0+NyyOcYyMIgpb5BO2kwmQqdXZuEbZj5IxGrRLWmHWfUlrFbES1fDswV3MfsU0TNM8odDQXj4Go/N8d9rQEtDmhTDRf8geZ8OxcbTNcjGXrlehANNhn5giHCqD2QPNSIKMo/AZSY/2a7nNdZQWTrJexLnOmmC8CmfddyrAUU5fCMTZEc3rxyNKfM8A2VcMlts8Q+dajWaIEwNEdv/CHtgMiGm5mIPiYXWqhNQMwz/DE5dBCkh34KyLZylKxpwGC1N8qXcA0l8skIJXvLVsDRuWknhPGjmp1t95x3UrETnlN0njLcpA1GNSSmfTfdz4CBb43SnpoQFh5KDlnQJ8HyBDxkwKr/+vi6wyBvYl5EWg3rQwgaVuEtTqrwi1+fJU9i3f16fI83EudPwTGnWJHSbUrI10twguXodSPckARv3Wiiv4rG8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTcybTB5YW1Td1h4eHRlKzVMbEh1d3Q0VEtKb1g4UnlVME15RHJ5UFJIZndP?=
 =?utf-8?B?cDlaNk5hSUQyekRLc21VRFZiY1VDZzNZdS9ncTF3R3YydUtiNjFEV1hzK3Nj?=
 =?utf-8?B?THdhME5ERVZZRkhZSWpYd0ZKbXE5Q2lVSzFlYWxJUWVubW8xN1c2T2ZMRmFz?=
 =?utf-8?B?TVlZSkg4Tno5NG9KeElrZnFIOStlZmZaUnFUU1FQRUtQT0RBZUlTMXBJSVNH?=
 =?utf-8?B?NHVDS3JrQzRJOFFMTStvNFg5UXMzVTdVRS9nSGFLR0M4dG9zN0FDS1ZWdVJ3?=
 =?utf-8?B?eEZxK0tpT3kwekcrb0lxaU5LQkNmZzZOU0lyVFJpbFExS2M2SVkxUDNSVW1o?=
 =?utf-8?B?VWk0dXowTWJGR3JXYlZTcE0wNlFhVVlrUVM4a1RtRU1kaFJlaGwxemFMbEgr?=
 =?utf-8?B?N1JseTArWnVWcVpUZG50UnZra1lvcjM0Z1ZPK3VvUjd2SEpqcEp0KzAvTGhi?=
 =?utf-8?B?cHFhVUM1cmxTTlh1eksreGs4WEozRDVVa3ZYSXZXZ1Y0eHhXWDFRU3d0cEpY?=
 =?utf-8?B?cndldE9JbU92RFB3akJlNkF0czNzOGpsOUxVci85RGoxTFhrQlVRVmpiNVJJ?=
 =?utf-8?B?c2dvOWZEWDdBMzY3QlY5VVU4L3N3ZjY1WGZFWko4WTBhRVQvc2tXbDFPTlBm?=
 =?utf-8?B?R2ZsZHUwRldYT1JkK3o0dndUcUJ2bFNvK0FLR0lML3JkWHREeGFMazlXU0d0?=
 =?utf-8?B?cG5paWhDaFdHUHdxYTRmWEd6cS9qY2pkREczN3Q0LyszSVJUbEtSeTBVZkdQ?=
 =?utf-8?B?c1VUWHNJSGQ3WnpmeHVsUEdTZ2lDM3dhQlZ6RFNycTZZWVZXU1MrYXZ2ZnUx?=
 =?utf-8?B?bFNoMGNxdWkzYnAvREY0akVpRU9yL3g1SlRhSkZ3cTBUWXNhemRUa3UvdUFV?=
 =?utf-8?B?b1NPQTNVQm40eU43TFBJcFhHVWIxeHFjQ09pcGhrSVdBQzBLcExyTGlvK1lJ?=
 =?utf-8?B?QjNLbGxudjVPdDB6MHJwdkxDNEdRd1NvT3VMR0pkU1lQd1FydUxFN29iZC9z?=
 =?utf-8?B?OFZkSlJVeEY3RFdjQ2o1bUtyVU96UEVVbUkwRktsLytpZjA4SnNWUHQxZ0oz?=
 =?utf-8?B?VGd6UVhHQnI1dUJmVGs2aXVnZE1ka3FOZndhVDk3Wi9KRllrQVl1eU14eWI2?=
 =?utf-8?B?ZXZUeUUwM0hJcmdrMnJUVTNNcG9Mb21hclRvQ1lKckgrNHl4bHJydU9qWmlE?=
 =?utf-8?B?UldsWldrUE02K2JlSHpzMUJ4WFllNE5mcTgyNW41ZkpyYUJjZjNzVy9VdDlj?=
 =?utf-8?B?UE1Gb1pNV3dhNzR5eFN3Z1hsbXBIV0pSVGd0L3R4d016ZG5GUXZKVU1adkdm?=
 =?utf-8?B?Yk14d0ZseWNJY2p3dml4allpSzRZb1cvRGViUEpuVG5Rc2Y1ejRrc0ZpRkZr?=
 =?utf-8?B?MjlObmNkSUZjbU5RYmlNZXhHeHZGUzFCaDZnVHpCc3BmU1d5aTFoSE1SUyto?=
 =?utf-8?B?eFJkRCswVm5XTkpSMWFoQ3JKWWFjVGFiR3pENkZvb1AwZTNjakJDLzRtTzZ2?=
 =?utf-8?B?WHNqMUVaQ1NJaUxQYmkzOVJjd01HNlpYWnFMWVVPeUxta0tGYkgwLzFodmUz?=
 =?utf-8?B?VWkxNjM0Y2swY3d5dEhFd1A4ZU1FUk53WmxYdGwyRUxVc21NbVZiYUJSZWpT?=
 =?utf-8?B?QUNUWTZNa0FMOXBOVjYrNnBSTll0bTFGcGlDR0tmYXVIb2xNeTgwcWQrbFN0?=
 =?utf-8?B?NXBYbG5wNk9ORDFUVGNHSnJKRTdXRFBsdjY4ODVKaFNublQ5WEZZWVlVQlZD?=
 =?utf-8?B?eUovZi9UTEJtSlowVXp6Q05wQW5zMktVUVpERjVzZC96MThuTUtNRG0rWHI1?=
 =?utf-8?B?dDhMcmNJQjFOMGpjN1k3MkVtZi9aRWp2amNseGd6Sk9zVHErenVJL1FiVnVs?=
 =?utf-8?B?am5YSlhvWGxGTnVZengvMGVnVW1tWUJpWEFOQTA1ZlNkMWk4V1Q4YXNvRnp1?=
 =?utf-8?B?WlhQaDEyeTNTVXRsUTRrVG5kTmY0NStYSktpaGxBSXk4ejR1SklZN2kzV2NI?=
 =?utf-8?B?ZGszQzVYYVk3clFmNzF5QWJ4bjEzc2E0UFNOR3NLN0Nzb0N4RWkwY1kyVTZF?=
 =?utf-8?B?OUZOR2hiWU0rRERrc0hsYTVwVk5JdmtiZE5WdnZzUjV2TmlnWm1KdE8vOWFX?=
 =?utf-8?B?amVXeE1pdkpOV2NycUx0UW5pbnlJdjJ4WUcwZ2tVZ1YvcDVFZXgzY2wreitH?=
 =?utf-8?B?aUtnRnY2amRqaGRKaGdDZWd5bktxZzFXMFVhSEx4K00vZ25rQ21tdzdMQ3hk?=
 =?utf-8?B?OGdXQVFMNDViZElNV2FzbllIdWk5Wjk5ak9vb0hqeFBwVzhyRVMyTzlKUmNs?=
 =?utf-8?B?UlJrNWZyaUsrN2Y0QktESjBoT0l1TFNCUzh6bWpIa3grZ0lubU14QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7BA9217298E574190A551D820608EE9@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ba28b6-cd65-4ef8-5584-08de8f43cb26
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 16:37:26.6408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rX6OVp8Pab7K76RAtv5cE7BfMHsgOrGneWY1FXLcjDYfJQ4uUEVLtyCZv14AxiEOfX0h0rcHNbUUcKaWCtKSlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,resnulli.us,nvidia.com,davemloft.net,gmail.com,vger.kernel.org,kernel.org,redhat.com,lwn.net,blackwall.org,google.com,linux.dev,lunn.ch,iogearbox.net,davidwei.uk,intel.com,linuxfoundation.org,openvpn.net,fomichev.me,dama.to];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18853-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:replyto,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 9746B36E43A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDEyOjUzICswMDAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+
IE9uIE1vbiwgMjAyNi0wMy0zMCBhdCAxOTowOCAtMDcwMCwgSmFrdWIgS2ljaW5za2kgd3JvdGU6
DQo+ID4gVGhpcyBpcyBhbiBBSS1nZW5lcmF0ZWQgcmV2aWV3IG9mIHlvdXIgcGF0Y2guIFRoZSBo
dW1hbiBzZW5kaW5nDQo+ID4gdGhpcw0KPiA+IGVtYWlsIGhhcyBjb25zaWRlcmVkIHRoZSBBSSBy
ZXZpZXcgdmFsaWQsIG9yIGF0IGxlYXN0IHBsYXVzaWJsZS4NCj4gPiAtLS0NCj4gPiDCoMKgwqAg
bmV0L21seDU6IHFvczogUmVtb3ZlIHFvcyBkb21haW5zIGFuZCB1c2Ugc2hkIGxvY2sNCj4gPiAN
Cj4gPiBUaGlzIGNvbW1pdCByZW1vdmVzIFFvUyBkb21haW5zIGFuZCBzd2l0Y2hlcyB0byB1c2lu
ZyB0aGUgc2hkIGxvY2sNCj4gPiB0bw0KPiA+IHByb3RlY3QgYWdhaW5zdCBjb25jdXJyZW50IFFv
UyBtb2RpZmljYXRpb25zLiBJdCBhbHNvIGVuYWJsZXMgdGhlDQo+ID4gc3VwcG9ydGVkX2Nyb3Nz
X2RldmljZV9yYXRlX25vZGVzIGRldmxpbmsgb3BzIGF0dHJpYnV0ZS4NCj4gPiANCj4gPiBMaW5r
Og0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDI1MDIxMzE4MDEzNC4zMjM5
MjktMS10YXJpcXRAbnZpZGlhLmNvbS8NCj4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZGV2bGluay5jDQo+ID4gPiBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9kZXZsaW5rLmMNCj4gPiA+IGluZGV4
IDY2OThhYzU1YTRiZmEuLmMwNTE2MDVmZWNkMjMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZGV2bGluay5jDQo+ID4gPiArKysgYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZGV2bGluay5jDQo+ID4gPiBA
QCAtMzg1LDYgKzM4NSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2bGlua19vcHMNCj4gPiA+
IG1seDVfZGV2bGlua19vcHMgPSB7DQo+ID4gPiDCoAkucmF0ZV9ub2RlX2RlbCA9IG1seDVfZXN3
X2RldmxpbmtfcmF0ZV9ub2RlX2RlbCwNCj4gPiA+IMKgCS5yYXRlX2xlYWZfcGFyZW50X3NldCA9
DQo+ID4gPiBtbHg1X2Vzd19kZXZsaW5rX3JhdGVfbGVhZl9wYXJlbnRfc2V0LA0KPiA+ID4gwqAJ
LnJhdGVfbm9kZV9wYXJlbnRfc2V0ID0NCj4gPiA+IG1seDVfZXN3X2RldmxpbmtfcmF0ZV9ub2Rl
X3BhcmVudF9zZXQsDQo+ID4gPiArCS5zdXBwb3J0ZWRfY3Jvc3NfZGV2aWNlX3JhdGVfbm9kZXMg
PSB0cnVlLA0KPiA+IA0KPiA+IFRoZSBjb21taXQgbWVzc2FnZSBzdGF0ZXMgdGhhdCBlbmFibGlu
Zw0KPiA+IHN1cHBvcnRlZF9jcm9zc19kZXZpY2VfcmF0ZV9ub2Rlcw0KPiA+IG5vdyBpcyBzYWZl
IGJlY2F1c2UgbWx4NV9lc3dfcW9zX3Zwb3J0X3VwZGF0ZV9wYXJlbnQgcmVqZWN0cyBjcm9zcy0N
Cj4gPiBlc3cNCj4gPiBwYXJlbnQgdXBkYXRlcy4NCj4gPiANCj4gPiBXaGVuIGEgdXNlciBwcm92
aWRlcyBhIERFVkxJTktfQVRUUl9QQVJFTlRfREVWIGJlbG9uZ2luZyB0byBhbg0KPiA+IHVucmVs
YXRlZA0KPiA+IGRldmljZSwgdGhlIGRldmxpbmsgY29yZSAoZGV2bGlua19ubF9yYXRlX3BhcmVu
dF9ub2RlX3NldCkgZHJvcHMNCj4gPiB0aGUNCj4gPiBsb2NrIG9uDQo+ID4gdGhlIHBhcmVudCBk
ZXZsaW5rIGFuZCBjYWxscyBkZXZsaW5rX3JhdGVfbm9kZV9nZXRfYnlfbmFtZSgpLiBUaGlzDQo+
ID4gZnVuY3Rpb24NCj4gPiB0cmF2ZXJzZXMgdGhlIHJhdGVfbGlzdCBvZiB0aGUgdW5sb2NrZWQg
cGFyZW50IGRldmxpbmsgaW5zdGFuY2UuDQo+ID4gDQo+ID4gRG9lcyB0aGlzIGxlYXZlIHRoZSBk
ZXZsaW5rIGNvcmUgZXhwb3NlZCB0byBkYXRhIHJhY2VzIGFuZA0KPiA+IHBvdGVudGlhbA0KPiA+
IHVzZS1hZnRlci1mcmVlIHZ1bG5lcmFiaWxpdGllcywgc2luY2UgdGhlIGRyaXZlcidzIHJlamVj
dGlvbg0KPiA+IGNhbGxiYWNrDQo+ID4gZXhlY3V0ZXMgb25seSBhZnRlciB0aGlzIGxvY2tsZXNz
IGxpc3QgdHJhdmVyc2FsIGhhcyBvY2N1cnJlZD8NCj4gDQo+IEkgd2lsbCBhZGRyZXNzIHRoaXMg
YnkgYWRkaW5nIGNvbW1vbiBhbmNlc3RvciB2YWxpZGF0aW9uIGluIGRldmxpbmsNCj4gcmF0ZSBj
b3JlLCB3aGljaCB3YXMgbWlzc2luZy4NCj4gDQo+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2Vzdy9xb3MuYw0KPiA+ID4gYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZXN3L3Fvcy5jDQo+ID4gPiBp
bmRleCAwYmU1MTYwMDNiY2RlLi5mNjdmOTk0Mjg5NTlmIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2Vzdy9xb3MuYw0KPiA+ID4gKysr
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2Vzdy9xb3MuYw0KPiA+
ID4gQEAgLTExMTAsNyArMTA2OCw3IEBAIHZvaWQgbWx4NV9lc3dfcW9zX3Zwb3J0X2Rpc2FibGUo
c3RydWN0DQo+ID4gPiBtbHg1X3Zwb3J0ICp2cG9ydCkNCj4gPiA+IMKgCXN0cnVjdCBtbHg1X2Vz
d19zY2hlZF9ub2RlICpwYXJlbnQ7DQo+ID4gPiDCoA0KPiA+ID4gwqAJbG9ja2RlcF9hc3NlcnRf
aGVsZCgmZXN3LT5zdGF0ZV9sb2NrKTsNCj4gPiA+IC0JZXN3X3Fvc19sb2NrKGVzdyk7DQo+ID4g
PiArCWRldmxfbG9jayhlc3ctPmRldi0+c2hkKTsNCj4gPiANCj4gPiBDb3VsZCBlc3ctPmRldi0+
c2hkIGJlIE5VTEwgaGVyZT8NCj4gPiANCj4gPiBJbiBtbHg1X3NoZF9pbml0KCksIGluaXRpYWxp
emF0aW9uIGlzIGV4cGxpY2l0bHkgc2tpcHBlZCBmb3Igbm9uLVBGDQo+ID4gZGV2aWNlcywNCj4g
PiBtZWFuaW5nIFN1Yi1GdW5jdGlvbnMgKFNGcykgYWN0aW5nIGFzIEUtU3dpdGNoIG1hbmFnZXJz
IHdpbGwgaGF2ZSBhDQo+ID4gTlVMTA0KPiA+IHNoZCBwb2ludGVyLiBJZiB0aGUgZGV2aWNlIGxh
Y2tzIFZQRCBkYXRhLCBwY2lfdnBkX2FsbG9jKCkgcmV0dXJucw0KPiA+IC0NCj4gPiBFTk9ERVYs
DQo+ID4gY2F1c2luZyBtbHg1X3NoZF9pbml0KCkgdG8gcmV0dXJuIDAgYnV0IGxlYXZpbmcgZGV2
LT5zaGQgYXMgTlVMTC4NCj4gPiANCj4gPiBXaGVuIFFvUyBvcGVyYXRpb25zIGFyZSBhdHRlbXB0
ZWQgb24gdGhlc2UgZGV2aWNlcywgY2FsbGluZw0KPiA+IGRldmxfbG9jaygpDQo+ID4gZGVyZWZl
cmVuY2VzIHRoZSBwb2ludGVyLCB3aGljaCBjb3VsZCBjYXVzZSBhbiBpbW1lZGlhdGUgTlVMTA0K
PiA+IHBvaW50ZXINCj4gPiBkZXJlZmVyZW5jZSBhbmQga2VybmVsIHBhbmljLg0KPiANCj4gUmln
aHQuIFRoaXMgaXMgYSByYWNlIHdpdGggSmlyaSdzIGZpeCAoWzFdKSwgd2hpY2ggY2hhbmdlZCB0
aGUNCj4gYXNzdW1wdGlvbiB0aGlzIGNvZGUgd2FzIGFyY2hpdGVjdGVkIHdpdGggdGhhdCBkZXYt
PnNoZCBpcyBhbHdheXMNCj4gaW5pdGlhbGl6ZWQuIFRoYXQgaXMgbm8gbG9uZ2VyIHRoZSBjYXNl
LCBhbmQgdGhlIGNvbnNlcXVlbmNlIGlzIHRoYXQNCj4gdGhpcyBuZWVkcyB0byAxKSBub3QgdW5j
b25kaXRpb25hbGx5IHVzZSBkZXYtPnNoZCBhbmQgMikgdXNlIGENCj4gZmFsbGJhY2sNCj4gbG9j
ayB3aGVuIGl0IGlzbid0IGF2YWlsYWJsZS4NCg0KRm9yZ290Og0KWzFdDQpodHRwczovL2xvcmUu
a2VybmVsLm9yZy9uZXRkZXYvMjAyNjAzMjUxNTI4MDEuMjM2MzQzLTEtamlyaUByZXNudWxsaS51
cy8NCg0K

