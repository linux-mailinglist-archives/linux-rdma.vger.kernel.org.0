Return-Path: <linux-rdma+bounces-421-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2BF812739
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Dec 2023 06:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3430AB20E36
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Dec 2023 05:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC066AC0;
	Thu, 14 Dec 2023 05:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="hT8JPG9T"
X-Original-To: linux-rdma@vger.kernel.org
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Dec 2023 21:57:02 PST
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2A310DD;
	Wed, 13 Dec 2023 21:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1702533423; x=1734069423;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MdAo+9ahCd0oUkTSioIjz6oijj/m6uU1rB6YE6lUGvw=;
  b=hT8JPG9TfMqXniIx9b7n+M498tStW5EAt/7QDq7lKsaNAQF06rtHhtVs
   FB1pzZyqxw6j5+I/DiJYRpcznBppCir3C+Y+1Gu3zBrNPV4F6uup+1FIM
   8szzqzAKqHxPtVkrygpVT+Ze7xOU0IGZqv5eBn30V9nhmgdmysdgGfyU1
   PtYuqpd5tCE605F9eKJ5mF30LM4wia1VLAsn+s/Fs7tKPpc/d47vWXHRn
   ZVCIbb5P9QIHNfIxhUKZv0XGKbLSHm8XnETUn3rjxfX7XRq4pJyz3P680
   C4a4axQEXZDVcZC9TjozFHzgsm01FFFzEixgHlJwAqg8583JcYf81m7+c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="106406740"
X-IronPort-AV: E=Sophos;i="6.04,274,1695654000"; 
   d="scan'208";a="106406740"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 14:55:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l82W77cCDd2TUGxqVdhuXxDEVeBhK0IPTBGzjdMJxXFKN1O/83gXsxHrs/0SGKc+4ucn8bo6hLnAGqBQ/vQUp7WDazS318ONsUXxFP8FbQCLLJKw54s9Wbu635/W4pewOVyXAb/Dh6ptGKzExKjv5faW3KYbLBZ6gjTrQhVlOvTEfWDr/1NBoYUNNH+b2FrQWpo6JKP/SuC+p305wXvSJvua1PD0ilkIPEVjyDcYH8GPbomdXA3rmXQXInZ7mU0NLWBrCFpi6YiAQcmJE+i5YEQeZrAIQifQmeT5sh4sZbnvY09wTQIgtZChJvpZ+Lh+z0PSEwVYgOsCmLWF905aTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdAo+9ahCd0oUkTSioIjz6oijj/m6uU1rB6YE6lUGvw=;
 b=HnjG5MAgUddIy8s/f3f7vz3C5KeMFuzk3s+q7Q0YNNdVdWc+MN00x6j7q+rBJT4cDY+v11LXhv/aDik8rCZ2c14lvtkCPudMzJIjrxtcf7E+tK/vYe6eTL9Nl0d51b5PvNQ8gjt5X/2Job3V8k9xCTo6LIjmnQlhRQvX01bOc7zY+4ac0X9Z0IbYSFJXYk42frZvjU7mojgC5PwKZNIRyeQFN+xs0Gch5raFzVedxcKRni3EkD0FVevVXQMY8VejDJzqnSKQkAcFqZkdGhHfWgXbd6tHqOSvwx7RRbfT2cgf36AmCmCq1euaPervkGB2sdAQjiiPHvTfm01Fr2pDaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by TYWPR01MB11397.jpnprd01.prod.outlook.com (2603:1096:400:402::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.8; Thu, 14 Dec
 2023 05:55:52 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::67df:3a4a:c6e9:4a6e]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::67df:3a4a:c6e9:4a6e%2]) with mapi id 15.20.7113.008; Thu, 14 Dec 2023
 05:55:52 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Zhu Yanjun' <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@nvidia.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>, "zyjzyj2000@gmail.com"
	<zyjzyj2000@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rpearsonhpe@gmail.com"
	<rpearsonhpe@gmail.com>, "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>,
	"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, "Yasunori Gotou (Fujitsu)"
	<y-goto@fujitsu.com>
Subject: RE: [PATCH for-next v7 0/7] On-Demand Paging on SoftRoCE
Thread-Topic: [PATCH for-next v7 0/7] On-Demand Paging on SoftRoCE
Thread-Index: AQHaEs/s5mAmNLkVi0evL98pGBTDKLCZ+ZyAgAAbqYCAA24asIAIozEAgAJXFrA=
Date: Thu, 14 Dec 2023 05:55:52 +0000
Message-ID:
 <OS3PR01MB9865474CFAC55AEB91D5A502E58CA@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <cover.1699503619.git.matsuda-daisuke@fujitsu.com>
 <20231205001139.GA2772824@nvidia.com>
 <d639b4e3-e12a-47e8-9b03-2398b076fdbf@linux.dev>
 <OS3PR01MB98659C7691D5DFB98D98D2BDE58BA@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <c2414371-d638-4ac3-9658-30a07bc514e0@linux.dev>
In-Reply-To: <c2414371-d638-4ac3-9658-30a07bc514e0@linux.dev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9NGEwMTkxM2QtMjk2MS00ZGE3LTliYjUtMDkxY2FkZDIy?=
 =?utf-8?B?MjBjO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0xMi0xNFQwNTo1MTo1Mlo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|TYWPR01MB11397:EE_
x-ms-office365-filtering-correlation-id: ed791767-81dc-41c4-6cf1-08dbfc69547e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VPwf4/3gtA4vwHdAOXFlT2ste9CMtnQNPT+71ityv8XUjXryStNIkg97XN5tnnl/sA5KN633tB/ah6Tk+pDpqoVdD3D2YMmLwIXBvPJX1yagW1JT/bcvt7+smOd4UQCJBFOIksTXd5mYFa9pSfk949fLPezQra2kYJCakUyZcJFx7Z/k8/3lSrlVXXinR8g6D6XwpSs+GcHANb3B4uxCyo0hH9KUBEyoW5hQ26yejTbuU8NAfLpicWxjLQOMQyQqC7kFAIEAQ6y3aNUj2DIRmxz/jloSHV/fZh20hZ8H4NqaJDF8s3uT4xqFNsixb+y2ATNq8SIgQ1vGFcV+pXxcB4UN0HRO/8FvaSI63Il7BF4vTqfhbBg9raBCykqB+XU+SYP8CmCbQcloZM3S6hvdkjRcE5AXGoJmB/iYKNwNQUY0cZ0KEAqk2G0JhsI8fh0xjBw1f7JgSiFJgWbRmbjHhQFUl/R3haWfJ4jIzv19/bHT6fsp5YBRoTOG/zkbJtASEQRlo/WZ+140U2xhu55pjT7pjDwyJnzThEbYBV5OiDOWPQRWTK7Xg33MBPGBD988EcTPP5yTirv0bqwmRlNVy2wDEtyrcQDJv2i0V0NIwg3lGXfia742dmlSLf4zfqo+C3+Ma0vnc0XEI1fntz5wdg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(186009)(64100799003)(1590799021)(451199024)(1800799012)(54906003)(66556008)(76116006)(64756008)(66946007)(316002)(66476007)(66446008)(71200400001)(478600001)(110136005)(9686003)(5660300002)(6506007)(7696005)(55016003)(53546011)(966005)(107886003)(4326008)(1580799018)(52536014)(122000001)(86362001)(82960400001)(41300700001)(2906002)(85182001)(8936002)(8676002)(26005)(83380400001)(33656002)(38100700002)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZHRMVitabGdiQ2pHZzlORDdHNm5UNVNvOUdXSWR4OUtpN1NvUi9yS0dBK25H?=
 =?utf-8?B?OGMyVVZOeEZ3SCtNNmJ2WnM5NzBVL3MrTUZkeENaQTl6VW1veXU3WFdGMkpL?=
 =?utf-8?B?eE5vdTk0ZHdoMDMrNmI1R2lCeEc3Q283RGw4bnd0ZlhoeW5wT3FlQmZoMUhG?=
 =?utf-8?B?dlFYZTU4SStMRE5VOVZRNjRSS2hpR3hHZE9RSG9rTVIwaUo2bGFLVENHV09R?=
 =?utf-8?B?TWU4N2orOEVyY0x5WXFQZFRKU0VEZ25wcS9BRXZHaDZFWEI1SVlwSDNSSTFZ?=
 =?utf-8?B?VStBYVlXNEpFOE1pOXVOTmlUaVhUMTdoYWlUSmg2NFNxbHIwT2xuWVZGc2p4?=
 =?utf-8?B?cTNuUm9LeUJuUmZVNnVmeDBhcTNHYUdlcUgvRjVVTStNN0dKRnJibHRKaklJ?=
 =?utf-8?B?aEEzM2lZMGtqUFhwd0ZQeE9STWZ5RTZRMktSRU0vbkFvV0RJSmJoMmhXZzdG?=
 =?utf-8?B?RFZVOVNvcGgxaDJ1NXdxc294U2dhNDY4YW5sRHdZcWZSVU1zdHBiMFdURHk3?=
 =?utf-8?B?cGgyVndmZEljcWJ2akQ1blhYWFdFT1FnclhNVDNRSys1OG9TUjAwcThpV2Jx?=
 =?utf-8?B?V3I2azh0cWtZcUhWaVpXOWxBckY1OTg0M29MZEc3amJVWkhGcEc2cHdIUmx0?=
 =?utf-8?B?S0kvSWhsa2lqN1M0VmFvcm0yUGpEakQvM3RWcnlUbDVBNDZ5amdrbkxUckx4?=
 =?utf-8?B?L1BlalcvQkZwUEl1bTFBZUtMald6WlZSa05QYVRURWJhUE1samc4dzRGcXFN?=
 =?utf-8?B?SUVVZGtNVXBIWnd1eFdwUTB5bmVoYTR3STZaTTk4eUZyMEhQTVV6ZG1hcmJa?=
 =?utf-8?B?TGE2SUVWY1RUTWhUY0k3eGp4d0tQVWdqZjJ4TDZsSGNOZklZSEhvMXpMNlFB?=
 =?utf-8?B?aVBseEJzVm41TjJYZHRJYW5vbXFRMVhkMXlBNmFjd0RLckdmUmhCdHcrSnRr?=
 =?utf-8?B?cTRSY21MOHJLN1dEQjgxelVreVFDZ2lTamhveVpQbXpLZGhNeVZMQWhVTkNn?=
 =?utf-8?B?RFZyendocGd2b3lCeXNGVnovd1NDbVlDbGtMYW5ZMFFxQ2R5ZjluUlUwTTJv?=
 =?utf-8?B?M1htR0tQQ1hGRkZPcWFlVHNjK3E1emdvVWs5c3h4dldQL2Z4UjFROWJOTjlL?=
 =?utf-8?B?OVEwL2xsWUhNMTZ3V2ViN3BodVNUWS8vS1hBU3EybUNTcUNsS3RHUlkvTXJ4?=
 =?utf-8?B?akNJL0tyWHdOK1hVa3U4WkxLeStCbHpSVkhYcVBDU3FJSjN0UW04WmVmSTI2?=
 =?utf-8?B?Slg5cVF0bnNKaERMbnEzUjdBUEZ6TjJWZHpKLzV2M2lJTlRCbUI0cU5FcHBw?=
 =?utf-8?B?R0tBNlI2b1VsbVRuVXUvQVBmZk1PRnhUYURYMkVOaXRKWXFoanltQUlyTXAw?=
 =?utf-8?B?YndBQWlpdG8vRmRad1NzblUvMWwxaTF0cG5DWXZIUGRhQ2V1Z2xLeU0zSzJw?=
 =?utf-8?B?RVRXaEZIQld2QkZkOGEyUDlpaGNNWUd2emVFQjhWQmtMWHNmV0l5UGtIekFw?=
 =?utf-8?B?RmlLZUlMUnVNNWlWN01uMFRQQWE5ZHpIREU0TDY0VmdISzFSUEtXenozTEtk?=
 =?utf-8?B?VE5xc0V4UmFBQXFUSHprYkp4RDVVVEJjeHVWc2dFdllWUUIyNTlLM2Z0dUJV?=
 =?utf-8?B?N2FGSFBkMW1Qb0F4dTZFbkg4U2g4dXp2anlnNG5GRkFmY3RBOUdwWkZkbnVo?=
 =?utf-8?B?aWhVYVlQU1JyMjJCNVdEUkNmbkxrYjk1VVpLeDZFTS9rOExGNUFqRW1YV0Vx?=
 =?utf-8?B?eHZGa2I0ZHZIaTlZTi9DTlRCUFYybTlHM0t5TkJxS3pxQ3B5NXcrMDlqNmFE?=
 =?utf-8?B?QnBCOTdydmx1bmwza2x3VXNKaWEwWm5UUEx6MnNYa09wc3d4WkU5QlVsbExs?=
 =?utf-8?B?SEVMMmlndm1DTzV2SHBtRjlMZFcxRHlXSis0MHdyOWQzT2kxM0crWm0zSXN2?=
 =?utf-8?B?VjBjdThuanU3WHkzZis1SlZtZXdIcjhtclY1SzJsRVVLM2FxT0kxMUhhY2xy?=
 =?utf-8?B?RHVJSzEvTE5qZXArYXhNZjNsRlBrVzRlZUZGRW5DSVhWWUthMWdsVlNENEc1?=
 =?utf-8?B?OU00b3FveXNqU3JHTjhRSmp3REpTWC9DWlgwdG1oZU5vRy9Ld3FyVjN6aDZJ?=
 =?utf-8?B?Q29RUGRZTjNrNyt4VGZ5ZjhTV043NlgxRHhnSWM3dFpoS2UrakpUR2NNZ1kv?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fLaCDqf4zSeBvesPF7VlfoksNt6Rktr10SVOUks6ZFfHDQjHYgd/kBb7AavbYndNFshrAJHTpu3qhMJ48paukJLYII1U90+4b8upDP37+HdU9zYJHgiFLjd8A8TeQF912RBu1L2zCAkLhzXARWi0sqSUQ6uqGLa+4d7TxaJmfhNO9qpMyBniT+t9bajMIt4gQYt3eLrxNvJ1wzv/anr5ohj1mDzjN+vGxd+OfxfAFUdU9jPqXoV59Fzx7glNCSDrW2N6/N05lZt83MXqlRA3ZdaOgeLbDSpefZk5AC3c86NyV3SKVemczQU4z5kSB+ubTOXb/7OaNLVDnXJigukcQJyB4+qszljHjL1zwqe45w2PyUtDcwWPhgKw7BoFlvMrKMmpOwv7tLS2mJxgJlaSpCIegqa2eSDl5oJ6wEKcLD/L4k/atGjEjSpKJfGby7A0P8mc1kS1aoxW+c7xSU1CAcDMZybB5ZfHGTQtXp0Ex7J1yTsAFktyERE2SnRW2yYOc033qxf5l6Euv06zeeUQBhfYxXDLAZEzQnU64FHBZYKdE/aTzfCNKqO1jTY4YDGSN47R+IxnxL+mzGc54PIVsbU7dhc3ufEGMTCqPfvV6DJ87rDRH4YT5GpWGOmSZcqq
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed791767-81dc-41c4-6cf1-08dbfc69547e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 05:55:52.2226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O48+hVbjKIumRpCLlrAQllNPTEamv1Yh6bMcNenOA5u8cBKQUwkKtKw51n3olIaSdSy+m4BaMKiN5OIxlthfdgLElYFZMSwzWK/w0m1byds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11397

T24gV2VkLCBEZWMgMTMsIDIwMjMgMzowOCBBTSBaaHUgWWFuanVuIHdyb3RlOg0KPiDlnKggMjAy
My8xMi83IDE0OjM3LCBEYWlzdWtlIE1hdHN1ZGEgKEZ1aml0c3UpIOWGmemBkzoNCj4gPiBPbiBU
dWUsIERlYyA1LCAyMDIzIDEwOjUxIEFNIFpodSBZYW5qdW4gd3JvdGU6DQo+ID4+DQo+ID4+IOWc
qCAyMDIzLzEyLzUgODoxMSwgSmFzb24gR3VudGhvcnBlIOWGmemBkzoNCj4gPj4+IE9uIFRodSwg
Tm92IDA5LCAyMDIzIGF0IDAyOjQ0OjQ1UE0gKzA5MDAsIERhaXN1a2UgTWF0c3VkYSB3cm90ZToN
Cj4gPj4+Pg0KPiA+Pj4+IERhaXN1a2UgTWF0c3VkYSAoNyk6DQo+ID4+Pj4gICAgIFJETUEvcnhl
OiBBbHdheXMgZGVmZXIgdGFza3Mgb24gcmVzcG9uZGVyIGFuZCBjb21wbGV0ZXIgdG8gd29ya3F1
ZXVlDQo+ID4+Pj4gICAgIFJETUEvcnhlOiBNYWtlIE1SIGZ1bmN0aW9ucyBhY2Nlc3NpYmxlIGZy
b20gb3RoZXIgcnhlIHNvdXJjZSBjb2RlDQo+ID4+Pj4gICAgIFJETUEvcnhlOiBNb3ZlIHJlc3Bf
c3RhdGVzIGRlZmluaXRpb24gdG8gcnhlX3ZlcmJzLmgNCj4gPj4+PiAgICAgUkRNQS9yeGU6IEFk
ZCBwYWdlIGludmFsaWRhdGlvbiBzdXBwb3J0DQo+ID4+Pj4gICAgIFJETUEvcnhlOiBBbGxvdyBy
ZWdpc3RlcmluZyBNUnMgZm9yIE9uLURlbWFuZCBQYWdpbmcNCj4gPj4+PiAgICAgUkRNQS9yeGU6
IEFkZCBzdXBwb3J0IGZvciBTZW5kL1JlY3YvV3JpdGUvUmVhZCB3aXRoIE9EUA0KPiA+Pj4+ICAg
ICBSRE1BL3J4ZTogQWRkIHN1cHBvcnQgZm9yIHRoZSB0cmFkaXRpb25hbCBBdG9taWMgb3BlcmF0
aW9ucyB3aXRoIE9EUA0KPiA+Pj4NCj4gPj4+IFdoYXQgaXMgdGhlIGN1cnJlbnQgc2l0dWF0aW9u
IHdpdGggcnhlPyBJIGRvbid0IHJlY2FsbCBzZWVpbmcgdGhlIGJ1Z3MNCj4gPj4+IHRoYXQgd2Vy
ZSByZXBvcnRlZCBnZXQgZml4ZWQ/DQo+ID4NCj4gPiBXZWxsLCBJIHN1cHBvc2UgSmFzb24gaXMg
bWVudGlvbmluZyAiYmxrdGVzdHMgc3JwLzAwMiBoYW5nIi4NCj4gPiBjZi4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtcmRtYS9kc2c2cmQ2NnR5aWVpMzJ6YXhzNmRkdjVlYmVmcjV2dHhq
d3o2ZDJld3FyY3dpc29nbEBnZTdqemFuN2RnNXUvVC8NCj4gPg0KPiA+IEl0IGlzIGxpa2VseSB0
byBiZSBhIHRpbWluZyBpc3N1ZS4gQm9iIHJlcG9ydGVkIHRoYXQgInNpdyBoYW5ncyB3aXRoIHRo
ZSBkZWJ1ZyBrZXJuZWwiLA0KPiA+IHNvIHRoZSBoYW5nIGxvb2tzIG5vdCBzcGVjaWZpYyB0byBy
eGUuDQo+ID4gY2YuIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC81M2VkZTc4YS1mNzNkLTQ0
Y2QtYTU1NS1mOGZmMzZiZDljNTVAYWNtLm9yZy9ULw0KPiA+IEkgdGhpbmsgd2UgbmVlZCB0byBk
ZWNpZGUgd2hldGhlciB0byBjb250aW51ZSB0byBibG9jayBwYXRjaGVzIHRvIHJ4ZSBzaW5jZSBu
b2JvZHkgaGFzIHN1Y2Nlc3NmdWxseSBmaXhlZCB0aGUgaXNzdWUuDQo+ID4NCj4gPg0KPiA+IFRo
ZXJlIGlzIGFub3RoZXIgaXNzdWUgdGhhdCBjYXVzZXMga2VybmVsIHBhbmljLg0KPiA+IFtidWcg
cmVwb3J0XVtiaXNlY3RlZF0gcmRtYV9yeGU6IGJsa3Rlc3RzIHNycCBsZWFkIGtlcm5lbCBwYW5p
YyB3aXRoIDY0ayBwYWdlIHNpemUNCj4gPiBjZi4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
L0NBSGo0Y3M5WFJxRTI1anlWdzlyajlZdWdmZkxuNStmPTF6bmFCRW51MXVzTE9jaUQrZ0BtYWls
LmdtYWlsLmNvbS9ULw0KPiA+DQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9q
ZWN0L2xpbnV4LXJkbWEvbGlzdC8/c2VyaWVzPTc5ODU5MiZzdGF0ZT0qDQo+ID4gWmhpamlhbiBo
YXMgc3VibWl0dGVkIHBhdGNoZXMgdG8gZml4IHRoaXMsIGFuZCBoZSBnb3Qgc29tZSBjb21tZW50
cy4NCj4gPiBJdCBsb29rcyBoZSBpcyBpbnZvbHZlZCBpbiBDWEwgZHJpdmVyIGludGVuc2l2ZWx5
IHRoZXNlIGRheXMuDQo+ID4gSSBndWVzcyBoZSBpcyBzdGlsbCB3b3JraW5nIG9uIGl0Lg0KPiA+
DQo+ID4+DQo+ID4+IEV4YWN0bHkuIEEgcHJvYmxlbSBpcyByZXBvcnRlZCBpbiB0aGUgbGluaw0K
PiA+PiBodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1yZG1hL21zZzEyMDk0Ny5o
dG1sDQo+ID4+DQo+ID4+IEl0IHNlZW1zIHRoYXQgYSB2YXJpYWJsZSAnZW50cnknIHNldCBidXQg
bm90IHVzZWQNCj4gPj4gWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdDQo+ID4NCj4gPiBZZWFo
LCBJIGNhbiByZXZpc2UgdGhlIHBhdGNoIGFueXRpbWUuDQo+ID4NCj4gPj4NCj4gPj4gQW5kIE9E
UCBpcyBhbiBpbXBvcnRhbnQgZmVhdHVyZS4gU2hvdWxkIHdlIHN1Z2dlc3QgdG8gYWRkIGEgdGVz
dCBjYXNlDQo+ID4+IGFib3V0IHRoaXMgT0RQIGluIHJkbWEtY29yZSB0byB2ZXJpZnkgdGhpcyBP
RFAgZmVhdHVyZT8NCj4gPg0KPiA+IFJ4ZSBjYW4gc2hhcmUgdGhlIHNhbWUgdGVzdHMgd2l0aCBt
bHg1Lg0KPiA+IEkgYWRkZWQgdGVzdCBjYXNlcyBmb3IgV3JpdGUsIFJlYWQgYW5kIEF0b21pYyBv
cGVyYXRpb25zIHdpdGggT0RQLA0KPiA+IGFuZCB3ZSBjYW4gYWRkIG1vcmUgdGVzdHMgaWYgdGhl
cmUgYXJlIGFueSBzdWdnZXN0aW9ucy4NCj4gPiBDZi4gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4
LXJkbWEvcmRtYS1jb3JlL2Jsb2IvbWFzdGVyL3Rlc3RzL3Rlc3Rfb2RwLnB5DQo+IA0KPiBUaGFu
a3MgYSBsb3QuDQo+IERvIHlvdSBtYWtlIHRlc3RzIHdpdGggYmxrdGVzdHMgYWZ0ZXIgeW91ciBw
YXRjaGVzIGFyZSBhcHBsaWVkIHdpdGggdGhlDQo+IGxhdGVzdCBrZXJuZWw/DQoNCkkgaGF2ZSBu
b3QgZG9uZSB0aGF0IHlldCwgYnV0IEkgYWdyZWUgSSBzaG91bGQgZG8gaXQuDQpJIHdpbGwgdHJ5
IHRvIHRha2UgdGltZSBmb3IgdGhlIHRlc3QgYmVmb3JlIHN1Ym1pdHRpbmcgdjgNCg0KVGhhbmtz
LA0KRGFpc3VrZSBNYXRzdWRhDQoNCg0KPiANCj4gWmh1IFlhbmp1bg0KPiANCj4gPg0KPiA+IFRo
YW5rcywNCj4gPiBEYWlzdWtlIE1hdHN1ZGENCj4gPg0KPiA+Pg0KPiA+PiBaaHUgWWFuanVuDQo+
ID4+DQo+ID4+Pg0KPiA+Pj4gSSdtIHJlbHVjdGFudCB0byBkaWcgYSBkZWVwZXIgaG9sZCB1bnRp
bCBpdCBpcyBkb25lPw0KPiA+Pj4NCj4gPj4+IFRoYW5rcywNCj4gPj4+IEphc29uDQo+ID4NCj4g
DQoNCg==

