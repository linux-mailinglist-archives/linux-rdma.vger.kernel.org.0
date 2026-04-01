Return-Path: <linux-rdma+bounces-18892-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBiqGl30zGl9YQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18892-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 12:33:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB88D3788DD
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 12:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C0C830363B4
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 10:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82523C3BE3;
	Wed,  1 Apr 2026 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dLjRSfHI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207D436164A;
	Wed,  1 Apr 2026 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775038982; cv=fail; b=bCdNpzAvND8qF6LFTf9J/Gxq/Z12iReRgkS12XJUnvoDf7sTtLK9JIF0fxxgbdZ07ONKA+M3deHcvhmHUWwTiGvZs6Ih0SjCzF0NDIDIHPZdDq58WYbFnkDvCqjBPm1LHinTA38IoZIas/XlEkthTEHTXksjbhy4Ek+SWY4haqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775038982; c=relaxed/simple;
	bh=T39xuC109rr0lnFsr5YuSP/1zaW247DdHsFPcvlxLRs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i0HlRrhFcwH/f2n+3+0URO3t1Cvp6fO37Bpnu/LW/kTtslqz86S0PX8r0CrgUPM7WNxrfFzjhYrgY8veRPLgBE1WmV1i/VJXJl/Qj61GKJ2+0hDXajRPqV8zkypOxiVJsIc2iOhg0qrXNaYa2xsa5wzwh8CLVtsi2K5Yh1PtOHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dLjRSfHI; arc=fail smtp.client-ip=40.107.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oogpezU20CrLsOU+3E//xa2VSsiyKDQy/BdHpcuoNqNDoPgaDv4uEZqBskCjpBaYh3PUD47jH+U7gsJnKp0kOsAOQ+Uejy2gA00mH0I23Ydev6pOyLf316cwNw2BvDvKNyuvuT1D6Cs29MI+Sw/FmYDb7EOpWG9PqDuAHuv2mzuszhLKMCds72WAC8vuOS3s9bO34V1BnjdjowPPSmOmQjjEIdrdD22eb2Hpcel3UKiTgxVq/Tcg4bJ9ZrqzUdUfxJCup7qPBTRZLrBNROPlyNsmFuw6g9KbyxKKxrRlQYehiSwTc6V/Z8jdCIhhGeawNCFKj2aXrzGCKEGYVNVF7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T39xuC109rr0lnFsr5YuSP/1zaW247DdHsFPcvlxLRs=;
 b=dQTmc7x0mM82wq3c30S463c/uD8sk66WnijkZ0r34tOd5ZzA9FY1A+BRFMHp0BoPO8bV+GVZbYWWJBrzSmzGLzZ7WaCa/5YF/DbiffNrAfM/r/t0M1zPXvERlb7KP8Vb9ldJ0elb4AiOo+RO4ehK8nFeRrqIqAMsCENpQ8QViSiwtCU60OXvAzIw/msY9dcteNtXDWU5tLYR+aZPrhJSWhL82DZREtj1Iv/SVXBW26ykk/AVyDRDGF1L4Yh6RexR5M/2Dqum9BnduW9DLNq2oB4Om/e21DDQjEbsIcTRE6MxjDMhkuWQisOACHBK3j8Zy/VJf9ykADUT99ngjGCTOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T39xuC109rr0lnFsr5YuSP/1zaW247DdHsFPcvlxLRs=;
 b=dLjRSfHI/4HRsHYi2I3GCxvCNr3q98pfg7RAFBe5G7kdYKvhcAbFY63lKFPIq48w7UciNPNHVzZsf6GBQ4wVy3mobC9SBBYewFLNaI3+Gv79Li3iKynPHkvJZoZ4IQHXX2ya9hok6V+mnSgQTslQi0DK/5BRT7L7KRy6MoEiPZH0Ldlrve3/M1/CzWO+mZEb7GHqGhhjWT5sNFRZN75iJGq/PU8TL0u7pAhX2GvBlfkPCnPmSku+A0TfxqU7Z6W0GOrWlJrU+sEepXUDmpnBIWwnmVdjol4Wmjf3ZfkECB60jMLxK+3CA9atMHbeQ0IgQxJ9KDy4ej6ztDYaFWNSRg==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by PH8PR12MB6676.namprd12.prod.outlook.com
 (2603:10b6:510:1c3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 1 Apr
 2026 10:22:54 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d8b5:cf72:3e36:3701]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d8b5:cf72:3e36:3701%7]) with mapi id 15.20.9769.006; Wed, 1 Apr 2026
 10:22:54 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>, Tariq Toukan
	<tariqt@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>
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
Thread-Index: AQHcvO5QLSguTHJDkEyNqzlfoJexP7XH7JAAgACrG4CAAMIhAIAAr1UA
Date: Wed, 1 Apr 2026 10:22:53 +0000
Message-ID: <4fcbf36799b5bfd5c0b68b0127f4f67aef00fdde.camel@nvidia.com>
References: <20260326065949.44058-3-tariqt@nvidia.com>
	 <20260331020807.3524811-1-kuba@kernel.org>
	 <ff5b2ec46d6cb639872318bdde429c46cac77f5b.camel@nvidia.com>
	 <c547be19-adaf-4442-be2b-debcbafa4191@intel.com>
In-Reply-To: <c547be19-adaf-4442-be2b-debcbafa4191@intel.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|PH8PR12MB6676:EE_
x-ms-office365-filtering-correlation-id: ba03e585-5c7e-4e93-5454-08de8fd8a2d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 XMHSwGfPJdez4cIjf/k74Yyi/SsVqLLSDXRzyB9zODX4z2DTI2pCiWgk+PT72DK8j43xUon5dCTxyXWL4xQAS2bZ00+5ln5936UwoYkKzbu4RqLKLT2azMd9mF8Y8svIy5PrOGELGdrm+Dd6cVM0QBdBhnx2Vf4QirODCeFYdxASNGTFIs2/vSJNXpNRLcM7HcE2erQje931bS1tPqRh+89udSBhCdhnToPiHKwJuthkuzCHhdrDNMtLTBVQccAJ7ZcjqMOeCMLxqGIwOtau04/s1L2ca2NfHVCAuMSlngMUZf9vyhqQaUNxUNCcfF2gg9bhYy3J+XY0UbjW8035O5m0VJfWBS/dy6CAI/k2cZfnLPXpN/v0GUyh4Ll9xXlz2f6LeLgg0JWzGTYNJyOdC6EZ9AX4B98TV/cSlPzoYrj+kOoL+cMLUeZuUgTBwTHUlojJ4FQlJTxSOpOJJEcJL3T9slUo++yQgiK34MBHVrm/5L88b3gzHFIBaaAFS0hahvPEf31CE1DCXJlrcFZYHpjlZhw5q2dPyyt1Pz/+cYcoEYmIxQRaib2toquuE/StT7H4X7IrWaKcbS16EJ7O8OeQ/aNKZrcLmma1Z3UrTYPwNmeSqWnRmLUZ3Jr8Osbvc8z8bUo5cW1juILvpkmeKMPHkyKfLhH7NvaUdd1WLUMbXV9sH9vhll+irjSKHM5MOqLhqlX6opcTn7nXjDrfqVoF1xvjrMRTZw7M6S7Yb9NLZAXEuf8+1GW3Iwz6rHtnfFiHtHay+N1qV5NcGuHB92+0OOBDQoKm9ZiD0rXajdc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aDMrSzZaaGxCZnpyZUN2Q2ZZUUdmdGlJb2trS05keTd1OVd6UkphSlVDZlp2?=
 =?utf-8?B?M2FSS05wOVFuQ1RIaUx2K2hjeXNiMVMrWjlOTkk1YitUZzJWc2t5NW1oQ3pi?=
 =?utf-8?B?cWx0SjhXZ0JRTmJVemsxRzIyNm1aaU9uL0N1dWtpZkorbG5GcFBXdmlvblB4?=
 =?utf-8?B?d3E2ZnRjeWVMbTh1UjJ4N3Y2czZwcjBYTHI3bEgwQkpHYnJJTy9HNUp6ZkxZ?=
 =?utf-8?B?MnZRaFpiVlNrOFUxZkJCb0xOVTZ1eXRNaDNEdDAyMmRWZmlDZEgvMklyMlVx?=
 =?utf-8?B?R2NNb2lJMHdWTVd6QnF5dDJiQ21uMFVuYlg2bjBtNWkvdmtQUUk4R2xvTDhs?=
 =?utf-8?B?TVVQM29ZeGVhQjlkSnlWOXlhWmwvenpzcS8zS25qWkVuNy82MWE4RXV3dm00?=
 =?utf-8?B?SVBEcnM1SDMya3k3Rks4NmZoeFM1TFlrcS84Ui83MkdMWElDOGIvYnlPRitT?=
 =?utf-8?B?bTA2RElWWnhTV1VXcWFhd2FKbnVLTnJXTEJkdERidjltYUdTeSszZjAvZ2VJ?=
 =?utf-8?B?T3lUWmU2dEV1Qm9McnczMGV5cFRMbVNsMUpUUElybTlEUDFyTGJOYkNUdm9J?=
 =?utf-8?B?QmFZY0VraEo5WWNoMGtGU1RwS3JQRUNrUjFaT2hlZzNrOEdOSTAwWmxYL09W?=
 =?utf-8?B?Yi9lZG5kb3FSc2pEV3A1UUlJSzVKRExid0dIUFJlRmc3WXJpSEx0c09IaDlO?=
 =?utf-8?B?OFh3OEhudEFUdTY0WkxRMTZsN2s3UE96VzFFVHhBdnROZTJUWnVNSGZTTGF5?=
 =?utf-8?B?aTB2eGUyWUxKdGt5TU0wOXp6VTJmUDNTTFZmUzVrZlJqWEc2VXAwK0NLanE2?=
 =?utf-8?B?YWJEdnpvM1RuK1dEK09JUGdycC9oNjg2V1FtSzV0c0JmMWxwR1FLRnRCR3BI?=
 =?utf-8?B?S3dQUU1PU0F3bWlnYVR6cUtZdENuTm55dk92Nmw5RUR4L1ZQRlVyMGdlZDhD?=
 =?utf-8?B?VmV3VGdia0dKRDN6OWF4Z3Y4TnF6RllrYXdBdkJRSDFiRk1Nci9KQmhmWlhQ?=
 =?utf-8?B?S3FhVUY4VFQvOEVoVXBpWnZHRC9UZkFGdklmdEpLQ3NnaVd0WElENkJZMHNU?=
 =?utf-8?B?dWdvZGhodTg2c2l4dUo3VFBvODVhQ1NKSjkwVHdVbHl0YkpvcmpLeGVDY0hX?=
 =?utf-8?B?QWlVaXhBWkpSYmpHRW1xYXF4bytCTEZac1VlQmcyT3dadTY2UXg1Y3d4UzdU?=
 =?utf-8?B?ejNoUSs4QUx4UUFLckFucStMMm9mS1hUeGg1NFNFZ3NiQ3RTS0lYUTJ1Y0lm?=
 =?utf-8?B?azJacENIT0hmekRtaWdiRXFrMTBIYThJbmZWZis1L2h6ZUE3RUlZSk9sMkIz?=
 =?utf-8?B?V2Nrckx1dDgwWkIwREMxN3VBdlA4QXpUT3ViZGpKLy92eWZIQzJmeTRYM3Q4?=
 =?utf-8?B?dlBSWFZ3Wmp5SVpyQU4yaXJMYS9aT09mZFQxZGhObkxwekhRNUVSa2t0NFVX?=
 =?utf-8?B?Wi9NVkhmVG9xVmpZRGRLYzBNbngzTU44cm45bW0wQmRMVkgwT1dUYS94QTJr?=
 =?utf-8?B?Z3hRODgrOG9oNzFBU1dwY2R5NkdiTE5DVGNzUG1Tb3ZuOWtqcXkzdGovQXZp?=
 =?utf-8?B?Tm5neUxPYkt3d1dqbUVPeTJLYjNVR2llMVBQSUdlcXcxMGxXTnBwNi9DeFhR?=
 =?utf-8?B?TzJOdXNlMjZXYzhWdVMraVlrUnEwQzlmUlEwVW1zV3pBYmtYQURhd2ZyYUdk?=
 =?utf-8?B?aTlZYmM1Sm1KS0kzUEk0eUdCeWhQUTFYRFhqRloxckczL3lWZEw0WldVcDd3?=
 =?utf-8?B?cnVYQTZHclBOTjR5ZTc3eDhEVWVNTnJzZmdXUURlNTg2N08reGM4S1RrMFN4?=
 =?utf-8?B?Q0ZZbm9YNDB3dW5wNnNZR3F2WUZTVmVVRUtnclltSjVNSnArVkRRUXVjbEYz?=
 =?utf-8?B?bDg2MStLM202QW13Yy9hVE44STBNTEZ0SUk5aXRrVm9sVGJybVBnSGdBOExa?=
 =?utf-8?B?TGg1Qm9BdFNnWDB6VTd4Q1o1UHJPYzRHOFJIZmRzVUxod001Y3dEempLNkpS?=
 =?utf-8?B?WXRCdnZCK0pGUHdWR29vNzlRZ0k4Z0Y2K3ZiVUdmMkJaSm1vU1RaUThrTE5h?=
 =?utf-8?B?UktMVlMrTTZTNkJ6QmNUdnpHR0VOMjJaODkrbFBPTVVkYmhabGpwbXVWbitt?=
 =?utf-8?B?aE9JKzFydEVyMEd0Q2NUZndoSWwrMGViY08vSUdUYnFOZ3VUYzZTQkFKSUtY?=
 =?utf-8?B?aWVsYzN3eWxycmV1ZnYwbnN2c2xHWjA2ZGNLd3lQRHZQbHRybTZhT2doRnR1?=
 =?utf-8?B?U2ZIQVlvMTBiMSt5ZmI1b2dZa3JDbk9jclhxUkpYMEg1VFJ0Q3h3SUFrRXZC?=
 =?utf-8?B?bVA5NjFqZmRjQVdhRWNhU0JZczFicW9YRkw5a3h6ODMrOUxraEs2QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7E8995CB826C74695E4FEF3E730EEB5@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ba03e585-5c7e-4e93-5454-08de8fd8a2d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 10:22:54.0440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p522w+VtrpejoYVnVq/47rVegEMKBFHwPmd6N/FZ0l0wW5OR7S7qqpIEPwFztzR9L8u5o5ouXyUcOTK3Ypy84A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,resnulli.us,nvidia.com,davemloft.net,gmail.com,vger.kernel.org,kernel.org,redhat.com,lwn.net,blackwall.org,google.com,linux.dev,lunn.ch,iogearbox.net,davidwei.uk,linuxfoundation.org,openvpn.net,fomichev.me,dama.to];
	RCPT_COUNT_TWELVE(0.00)[48];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-18892-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:replyto,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: DB88D3788DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDE2OjU1IC0wNzAwLCBKYWNvYiBLZWxsZXIgd3JvdGU6DQo+
IE9uIDMvMzEvMjAyNiA1OjIwIEFNLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+ID4gT24gTW9uLCAy
MDI2LTAzLTMwIGF0IDE5OjA4IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToNCj4gPiA+IFRo
aXMgaXMgYW4gQUktZ2VuZXJhdGVkIHJldmlldyBvZiB5b3VyIHBhdGNoLiBUaGUgaHVtYW4gc2Vu
ZGluZw0KPiA+ID4gdGhpcw0KPiA+ID4gZW1haWwgaGFzIGNvbnNpZGVyZWQgdGhlIEFJIHJldmll
dyB2YWxpZCwgb3IgYXQgbGVhc3QgcGxhdXNpYmxlLg0KPiA+ID4gLS0tDQo+ID4gPiBkZXZsaW5r
OiBBZGQgaGVscGVycyB0byBsb2NrIG5lc3RlZC1pbiBpbnN0YW5jZXMNCj4gPiA+IA0KPiA+ID4g
VXBjb21pbmcgY29kZSB3aWxsIG5lZWQgdG8gb2J0YWluIGEgcmVmZXJlbmNlIHRvIGxvY2tlZCBu
ZXN0ZWQtaW4NCj4gPiA+IGRldmxpbmsgaW5zdGFuY2VzLiBBZGQgaGVscGVycyB0byBsb2NrLCBv
YnRhaW4gYW4gYWxyZWFkeSBsb2NrZWQNCj4gPiA+IHJlZmVyZW5jZSBhbmQgdW5sb2NrL3VucmVm
IHRoZSBuZXN0ZWQtaW4gaW5zdGFuY2UuDQo+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL25l
dC9kZXZsaW5rL2NvcmUuYyBiL25ldC9kZXZsaW5rL2NvcmUuYw0KPiA+ID4gPiBpbmRleCBlZWI2
YTcxZjVmNTZlLi5kYjExMjQ4ZGY3MTIwIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9uZXQvZGV2bGlu
ay9jb3JlLmMNCj4gPiA+ID4gKysrIGIvbmV0L2RldmxpbmsvY29yZS5jDQo+ID4gPiANCj4gPiA+
IFsgLi4uIF0NCj4gPiA+IA0KPiA+ID4gPiArLyogUmV0dXJucyB0aGUgbmVzdGVkIGluIGRldmxp
bmsgb2JqZWN0IGFuZCB2YWxpZGF0ZXMgaXRzIGxvY2sNCj4gPiA+ID4gaXMNCj4gPiA+ID4gaGVs
ZC4gKi8NCj4gPiA+ID4gK3N0cnVjdCBkZXZsaW5rICpkZXZsaW5rX25lc3RlZF9pbl9nZXRfbG9j
a2VkKHN0cnVjdA0KPiA+ID4gPiBkZXZsaW5rX3JlbA0KPiA+ID4gPiAqcmVsKQ0KPiA+ID4gPiAr
ew0KPiA+ID4gPiArCXN0cnVjdCBkZXZsaW5rICpkZXZsaW5rOw0KPiA+ID4gPiArCXVuc2lnbmVk
IGxvbmcgaW5kZXg7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlpZiAoIXJlbCkNCj4gPiA+ID4gKwkJ
cmV0dXJuIE5VTEw7DQo+ID4gPiA+ICsJaW5kZXggPSByZWwtPm5lc3RlZF9pbi5kZXZsaW5rX2lu
ZGV4Ow0KPiA+ID4gPiArCWRldmxpbmsgPSB4YV9maW5kKCZkZXZsaW5rcywgJmluZGV4LCBpbmRl
eCwNCj4gPiA+ID4gREVWTElOS19SRUdJU1RFUkVEKTsNCj4gPiA+ID4gKwlpZiAoZGV2bGluaykN
Cj4gPiA+ID4gKwkJZGV2bF9hc3NlcnRfbG9ja2VkKGRldmxpbmspOw0KPiA+ID4gDQo+ID4gPiBD
YW4gdGhpcyBkZXJlZmVyZW5jZSBhIGZyZWVkIHBvaW50ZXIgaWYgdGhlIGxvY2sgaXMgbm90IGFj
dHVhbGx5DQo+ID4gPiBoZWxkPw0KPiA+ID4gDQo+ID4gPiB4YV9maW5kKCkgYWNxdWlyZXMgYW5k
IHJlbGVhc2VzIHRoZSBSQ1UgcmVhZCBsb2NrIGludGVybmFsbHkuDQo+ID4gPiBXaGVuIGl0DQo+
ID4gPiByZXR1cm5zLA0KPiA+ID4gdGhlIGRldmxpbmsgcG9pbnRlciBpcyBubyBsb25nZXIgcHJv
dGVjdGVkIGJ5IFJDVSBvciBhIHJlZmVyZW5jZQ0KPiA+ID4gY291bnQuDQo+ID4gPiANCj4gPiA+
IElmIGEgY2FsbGVyIGludm9rZXMgdGhpcyBoZWxwZXIgd2l0aG91dCBob2xkaW5nIHRoZSBkZXZs
aW5rIGxvY2sNCj4gPiA+ICh3aGljaCBpcyB0aGUNCj4gPiA+IGV4YWN0IHNjZW5hcmlvIHRoZSBh
c3NlcnRpb24gaXMgZGVzaWduZWQgdG8gZGV0ZWN0KSwgYW5vdGhlcg0KPiA+ID4gdGhyZWFkDQo+
ID4gPiBjb3VsZA0KPiA+ID4gY29uY3VycmVudGx5IHVucmVnaXN0ZXIgYW5kIGZyZWUgdGhlIGRl
dmxpbmsuDQo+ID4gPiANCj4gPiA+IElmIHRoZSBSQ1UgZ3JhY2UgcGVyaW9kIGV4cGlyZXMgYmVm
b3JlIHRoZSBhc3NlcnRpb24gZXhlY3V0ZXMsDQo+ID4gPiBkZXZsX2Fzc2VydF9sb2NrZWQoKSB3
b3VsZCBkZXJlZmVyZW5jZSBmcmVlZCBtZW1vcnkuIFNob3VsZCB0aGUNCj4gPiA+IGxvb2t1cCBh
bmQNCj4gPiA+IGFzc2VydGlvbiBiZSBlbmNsb3NlZCB3aXRoaW4gYW4gZXhwbGljaXQgcmN1X3Jl
YWRfbG9jaygpIGJsb2NrIHRvDQo+ID4gPiBzYWZlbHkNCj4gPiA+IGFzc2VydCB0aGUgbG9jaz8N
Cj4gPiANCj4gPiBUaGlzIGZ1bmN0aW9uIGlzIG1lYW50IHRvIGJlIGludm9rZWQgYnkgY2FsbGVy
cyBhbHJlYWR5IGhvbGRpbmcgYWxsDQo+ID4gbG9ja3MgZnJvbSBhIGdpdmVuIGluc3RhbmNlIHVw
IHRoZSBuZXN0aW5nIHRyZWUuIENhbGxpbmcgaXQgb3V0c2lkZQ0KPiA+IHRoaXMgY29udGV4dCBj
b3VsZCBpbmRlZWQgbGVhZCB0byBhIHJhY2UgYXMgZGVzY3JpYmVkLCB3aGVyZQ0KPiA+IGFub3Ro
ZXINCj4gPiBlbnRpdHkgdW5yZWdpc3RlcnMgYSBkZXZsaW5rIGFib3V0LXRvLWJlLWFzc2VydGVk
IG9uLg0KPiA+IA0KPiANCj4gSG1tLiBJJ20gc3RydWdnbGluZyB0byBmb2xsb3cgdGhpcy4gSWYg
eW91IGFscmVhZHkgZXhwZWN0IHRoZSBwYXJlbnQNCj4gdG8NCj4gaG9sZCB0aGUgbmVzdGVkIGRl
dmxpbmsncyBsb2NrLCBpdCBtdXN0IGhhdmUgYSBwb2ludGVyIHRvIHRoaXMNCj4gZGV2bGluaw0K
PiBpbnN0YW5jZS4gSW4gdGhhdCBjYXNlLCB3aHkgd291bGQgeW91IGV2ZW4gbmVlZA0KPiBkZXZs
aW5rX25lc3RlZF9pbl9nZXRfbG9ja2VkIGluIHRoZSBmaXJzdCBwbGFjZT8NCg0KQWZ0ZXIgc29t
ZSBtb3JlIGludGVuc2Ugc3RhcmluZywgSSByZWFsaXplZCB0aGF0IGludGVybWVkaWF0ZSBpbnN0
YW5jZXMNCmRvbid0IGFjdHVhbGx5IG5lZWQgdG8gYmUgbG9ja2VkLCBvbmx5IHRoZSBhbmNlc3Rv
ciBuZWVkcyB0by4gV2l0aCB0aGF0DQppbiBtaW5kLCB0aGUgY29kZSBnZXQgc2ltcGxpZmllZDoN
Ci0gZGV2bGlua19uZXN0ZWRfaW5fZ2V0X2xvY2tlZCBhbmQgZGV2bGlua19uZXN0ZWRfaW5fcHV0
X3VubG9jayBjYW4gYmUNCnJlbW92ZWQuDQotIHJlY3Vyc2l2ZSB1bmxvY2tpbmcgaW4gZGV2bF9y
YXRlX3VubG9jayBpcyBnb25lLg0KDQo+IA0KPiA+IEFsbCBjdXJyZW50IGNhbGxlcnMgaG9sZCB0
aGUgbG9ja3MsIGJ1dCB0byBtYWtlIGl0IG1vcmUgcm9idXN0LCBJDQo+ID4gd2lsbA0KPiA+IGFk
ZCB0aGUgcmN1X3JlYWRfbG9jay91bmxvY2sgc2VjdGlvbiBhcm91bmQgdGhlIGZpbmQrYXNzZXJ0
Lg0KPiA+IA0KPiANCj4gWW91IHNob3VsZCBhdCBsZWFzdCBkbyB0aGF0LiBJdCBpcyB0aGUgY29y
cmVjdCBwYXR0ZXJuIHdoZW4gZGVhbGluZw0KPiB3aXRoDQo+IHJlZmVyZW5jZSBjb3VudGluZyBk
YXRhIHN0cnVjdHVyZXMgZnJvbSB0aGUgeGFycmF5LiBUaGF0J3MgYWxyZWFkeQ0KPiBob3cNCj4g
ZGV2bGlua3NfeGFfZ2V0KCkgaXMgaW1wbGVtZW50ZWQuDQo+IA0KPiA+ID4gDQo+ID4gPiA+ICsJ
cmV0dXJuIGRldmxpbms7DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3ZvaWQgZGV2
bGlua19uZXN0ZWRfaW5fcHV0X3VubG9jayhzdHJ1Y3QgZGV2bGlua19yZWwgKnJlbCkNCj4gPiA+
ID4gK3sNCj4gPiA+ID4gKwlzdHJ1Y3QgZGV2bGluayAqZGV2bGluayA9DQo+ID4gPiA+IGRldmxp
bmtfbmVzdGVkX2luX2dldF9sb2NrZWQocmVsKTsNCj4gPiA+IA0KPiA+ID4gQ291bGQgdGhpcyBj
b3JydXB0IHRoZSBtdXRleCBzdGF0ZSBhbmQgY2F1c2UgYSByZWZjb3VudA0KPiA+ID4gdW5kZXJm
bG93Pw0KPiA+ID4gDQo+ID4gPiBUaGlzIGhlbHBlciB0YWtlcyBhIGRldmxpbmtfcmVsIHBvaW50
ZXIgaW5zdGVhZCBvZiB0aGUgZGV2bGluaw0KPiA+ID4gcG9pbnRlcg0KPiA+ID4gYWNxdWlyZWQg
YnkgZGV2bGlua19uZXN0ZWRfaW5fZ2V0X2xvY2soKSwgYW5kIHBlcmZvcm1zIGENCj4gPiA+IHNl
Y29uZGFyeQ0KPiA+ID4gZ2xvYmFsDQo+ID4gPiBsb29rdXAgdG8gZmluZCB0aGUgZGV2bGluay4N
Cj4gPiA+IA0KPiA+ID4gSWYgYSBjYWxsZXIgbWlzdGFrZW5seSBjYWxscyB0aGlzIGluIGFuIGVy
cm9yIGNsZWFudXAgcGF0aCB3aGVyZQ0KPiA+ID4gdGhleQ0KPiA+ID4gZGlkIG5vdA0KPiA+ID4g
YWN0dWFsbHkgYWNxdWlyZSB0aGUgbG9jaywgdGhlIGdsb2JhbCB4YV9maW5kKCkgd2lsbCBzdGls
bCBsb2NhdGUNCj4gPiA+IHRoZQ0KPiA+ID4gcmVnaXN0ZXJlZCBkZXZsaW5rLiBUaGlzIHdvdWxk
IGV4ZWN1dGUgZGV2bF91bmxvY2soKSBhbmQNCj4gPiA+IGRldmxpbmtfcHV0KCkgb24gYQ0KPiA+
ID4gZGV2bGluayB0aGUgY3VycmVudCB0aHJlYWQgZG9lcyBub3Qgb3duLg0KPiA+ID4gDQo+IA0K
PiBJZiB0aGUgY2FsbGVyIGFscmVhZHkgaGVsZCB0aGUgbG9jaywgd2h5IGlzDQo+IGRldmxpbmtf
bmVzdGVkX2luX3B1dF91bmxvY2sNCj4gY2FsbGluZyB0aGUgZGV2bF91bmxvY2sgaW5zdGVhZCBv
ZiB0aGUgY2FsbGVyIGFueXdheXM/IFRoYXQgc2VlbXMNCj4gY29uZnVzaW5nLiBXb3VsZG4ndCB0
aGUgbm9ybWFsIHBhdHRlcm4gYmUgdG8NCj4gZGV2bGlua19uZXN0ZWRfaW5fZ2V0X2xvY2soKT8g
T2gsIHRoYXQgaXMgYSBzZXBhcmF0ZSBmdW5jdGlvbi4gT2sgSQ0KPiBzZWUuDQo+IA0KPiA+ID4g
V291bGQgaXQgYmUgc2FmZXIgZm9yIHVubG9jay9wdXQgaGVscGVycyB0byB0YWtlIHRoZSBleGFj
dA0KPiA+ID4gcG9pbnRlcg0KPiA+ID4gcmV0dXJuZWQgYnkNCj4gPiA+IHRoZSBsb2NrL2dldCBo
ZWxwZXIgdG8gZW5zdXJlIHNhZmUgcmVzb3VyY2UgY2xlYW51cD8NCj4gPiANCj4gPiAyIGlzc3Vl
cyBoZXJlOg0KPiA+IDEpIE1pc3Rha2VubHkgY2FsbGluZyB0aGlzIHdpdGhvdXQgaGF2aW5nIGFj
cXVpcmVkIHRoZSBsb2NrLiBUaGlzDQo+ID4gaXMNCj4gPiBha2luIHRvIHNheWluZyBtdXRleF91
bmxvY2sgaXMgZGFuZ2Vyb3VzIGlmIHRoZSBsb2NrIGlzbid0IGhlbGQuDQo+ID4gVGVjaG5pY2Fs
bHkgdHJ1ZSwgYnV0IG1vb3QuDQo+ID4gMikgVGhlIHJlbCBhcmd1bWVudDogSXQgaXMgaW50ZW50
aW9uYWwsIHNvIHRoYXQgYWxsIDMgZnVuY3Rpb25zIGFyZQ0KPiA+IHN5bW1ldHJpY2FsLg0KPiA+
IA0KPiANCj4gSU1PIGl0IHdvdWxkIG1ha2UgbW9yZSBzZW5zZSBmb3IgdGhlIHB1dCB2ZXJzaW9u
IHRvIGJlIGEgcHV0IG9uIHRoZQ0KPiByZXR1cm5lZCBkZXZsaW5rIHBvaW50ZXIuIEkgZ3Vlc3Mg
aXRzIG5vdCBzeW1tZXRyaWNhbCwgYnV0IGl0IHJlbW92ZXMNCj4gdGhlIG5lZWQgdG8gcGVyZm9y
bSB0aGUgc2Vjb25kIGxvb2t1cCBhbmQgaXQgbWFrZXMgaXQgZWFzaWVyIHRvDQo+IHJlYXNvbg0K
PiBhYm91dCB0aGUgcG9pbnRlciB5b3UncmUgcmVsZWFzaW5nIGJlaW5nIHRoZSBzYW1lIG9uZS4N
Cj4gDQo+IEhhdmluZyBwdXQgdGFrZSBkaWZmZXJlbnQgYXJndW1lbnRzIGZyb20gZ2V0IGlzIHRo
ZSB1c3VhbCBwYXR0ZXJuIGZvcg0KPiBzdWNoIGEgYmVoYXZpb3IuDQo+IA0KPiBBbHNvIGRldmxp
bmtfbmVzdGVkX2luX2dldF9sb2NrZWQoKSBkb2Vzbid0IGluY3JlYXNlIHRoZSByZWYgY291bnQg
c28NCj4gaXQNCj4gaXMgc29ydCBvZiAicmVseWluZyIgb24gdGhlIGNhbGxlciBhbHJlYWR5IGhh
dmluZyBhIHJlZmVyZW5jZSB0byBpdCwNCj4gd2hpY2ggbWFrZXMgbWUgdGhpbmsgaXRzIG5vdCB2
ZXJ5IHVzZWZ1bC4gVGhlIG9ubHkgdmFsaWQgd2F5IHRvIGNhbGwNCj4gdGhpcyBmdW5jdGlvbiBh
cyBpdCBleGlzdHMgbm93IHNhZmVseSBpcyB0byBhbHJlYWR5IGhvbGQgYSByZWZlcmVuY2UNCj4g
dG8NCj4gdGhlIG9iamVjdCwgd2hpY2ggYWxzbyBhbHJlYWR5IHJlcXVpcmVzIHlvdSB0byBoYXZl
IGEgdmFsaWQgcG9pbnRlcg0KPiBtYWtpbmcgbWUgd29uZGVyIHdoeSB5b3UnZCBldmVyIG5lZWQg
dG8gY2FsbCBpdCBpbiB0aGUgZmlyc3QgcGxhY2UuDQo+IA0KPiBUaGUgb25seSBleGFtcGxlIHlv
dSBoYXZlIGlzIHRvIG1ha2UgZGV2bGlua19uZXN0ZWRfaW5fcHV0X3VubG9jaygpDQo+IHRha2UN
Cj4gYSBkZXZsaW5rX3JlbCBwb2ludGVyIGFzIGl0cyBhcmd1bWVudCBpbnN0ZWFkIG9mIGp1c3Qg
Y2FsbGluZyBpdCBvbg0KPiB0aGUNCj4gcG9pbnRlciByZXR1cm5lZCBieSBkZXZsaW5rX25lc3Rl
ZF9pbl9nZXRfbG9jaygpLg0KPiANCj4gVGhpcyBpbXBsZW1lbnRhdGlvbiBzZWVtcyBjb25mdXNp
bmcgYW5kIGxpa2VseSB0byBsZWFkIHRvIGVycm9ycy4NCg0KSSBob3BlIHRoZSBuZXh0IHZlcnNp
b24gd2lsbCBiZSBtb3JlIHN1aXRhYmxlLg0KVGhhbmsgeW91IGZvciB0aGUgY29tbWVudHMgYW5k
IHN1Z2dlc3Rpb25zLg0KDQo+IA0KPiBUaGFua3MsDQo+IEpha2UNCg0K

