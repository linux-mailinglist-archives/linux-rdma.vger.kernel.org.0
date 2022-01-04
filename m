Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E86483E7B
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 09:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiADIvP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 03:51:15 -0500
Received: from esa2.fujitsucc.c3s2.iphmx.com ([68.232.152.246]:40525 "EHLO
        esa2.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232866AbiADIvO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 03:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641286274; x=1672822274;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7pV1oXMdF3w4Wal00dG9obOcs4ETdm9DT0/XgYcIs+A=;
  b=kk+VpU9sDQaPEBWLLuESPvuNgbUeq4R1j53sNkw+5gWnPe+BiDz7GQoO
   XWZ3sJ7Gl98DDyE3Qsg1k42KqsyMP4EMQNN9g/Ba5BK0ZAOxHzheZjiLS
   RmkC8FTxJuOBheNTrET3P9gjtcPpYOIrfZUOqALXSfIGnDmyaTmEo9jeD
   gtQWcsq/Ot8us68f14RGErMMqfGaR5fnx3kpyKkphwutk95oyPvXvyPzA
   dl5032BNTmTfLxXDAeqa1MvmrqVAm0bBqcINVej7QtYzBv/2sQJo9xlK0
   //gjFJtvBFIHdOin/Q1Yes/U+shj9jhjbB/iWBITKDcLi0Q1hZiM6i8Sx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="55255348"
X-IronPort-AV: E=Sophos;i="5.88,260,1635174000"; 
   d="scan'208";a="55255348"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 17:51:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lj0Bfo1kzf3feJeOw0sMiaURMwAeWExPoyzPmKqYYhWWV5nc1BChjy6rEmMaC0QHqPx6at5+FSLgQzdVuOPXi34+J0kWc3Agh8eJ6Cbd0KX12HVniQwPiFgvOLUSAIbhtgAP9LtlteTdPTeUYX7A+uLxvWHG9+LPDZRkLcMxLmxA3SXSPqv9mXW6vdVdOTStMxz1D1qtnFIDk7chsZFyf2Q/Lqi0cON03h8xgUWclHkZe5rBAVwzraVRi3oEtn54kkYkpVDaYP1FqKysKxejNVCRjmkLIL6ZzXh+s1fbwWwjOD+gn7q49SQFPWZHZXY/14LWInxd5J0uC4HdtA5vpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pV1oXMdF3w4Wal00dG9obOcs4ETdm9DT0/XgYcIs+A=;
 b=Lwykh0BCIWisMNun1vbB75++54t4ogsDQO+eRISispbbeMgR3OkRKx2XRnUlbhJWXloL3WF66HQx4pqlXrZbDWdtdISu19HmcWjwA2SO2P3n1sXuiCgvNXd9yKuGLTfhXqfaGwFPk1878/MOn8ECMI8TsuD9KvOzmPRTjbgUaetCsL/2BT/+REOencaIy23suKo3mLyhGpcGLciZmXLW7dk3xGOEF2DMX7Mn5DQRbgmKeV3rbRJmibww5+tqms/g9XlvD/jeiO2ZkQHFYJoqUEOCKsvD/5Ay/Q0pMkkV50ysEbpwomQZ6LVb0HShDbTDJl51NWW9+5yaqvJL5D3AqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pV1oXMdF3w4Wal00dG9obOcs4ETdm9DT0/XgYcIs+A=;
 b=GU1wHzK1RgMF6GRDEeZ3AW305USJf0YrCOxlR3NTamTZr9wj3nfr6MOJI5cYOEKm+iERHbhn6t/8fIbmNhFhpAmdV6IT/ZwVv7iIeH8ZgPlCow7FqLzHPVIIos/Nh5T+UHwGgMv3sqXTANPtT3sqp3xXI96Xgmsb0XbKI+sZejI=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TYWPR01MB8606.jpnprd01.prod.outlook.com (2603:1096:400:13d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 08:51:06 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8c58:9fce:97f2:ce35]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8c58:9fce:97f2:ce35%9]) with mapi id 15.20.4844.014; Tue, 4 Jan 2022
 08:51:06 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Tom Talpey <tom@talpey.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Thread-Topic: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Thread-Index: AQHX+8ExNgnDPI7BNEiFy0xj9MaxG6xLnrSAgAA33ICAAA8hAIAGs0EA
Date:   Tue, 4 Jan 2022 08:51:06 +0000
Message-ID: <33284887-163e-6d6f-a3b8-c9c9b597d160@fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
 <9f97d902-aad5-db0f-f2dc-badf913777c4@talpey.com>
 <fd561077-358e-e38d-a7d0-5c61593eff6a@fujitsu.com>
 <17122432-1d05-7a88-5d06-840cd69e57e9@talpey.com>
In-Reply-To: <17122432-1d05-7a88-5d06-840cd69e57e9@talpey.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 601cd8e1-d441-4c6e-a143-08d9cf5f58a9
x-ms-traffictypediagnostic: TYWPR01MB8606:EE_
x-microsoft-antispam-prvs: <TYWPR01MB8606C56BD282FF704F4CF783A54A9@TYWPR01MB8606.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6OWaQvB+PE1Lsc6HFBfy0mNuPpSpVtkTOQnLEmKjaupp1vc3AnF1NzpiJFFHEtHQQ0mWJETG73hfZ7E6cpL3iE0feIySaiHpcpjU4sQVhxe+aw+zq/5hOJmSzW6Mn/6okcJT5sYBBzvbEuKiytgZcev3YRaiBIuB+ZKV32fuRpNGS0We/7YLCwbGs+m/xG9y8WaazhLudoVpnDbhZ1SqZnXC6QJg5W66gxu9eMCq389Yiu2B1KWvPaTjAGgXsRTvdyfEmuBeRLZd4hGSDyELV+kJW6Yjc6ah59L3Z8ArxscklfHK7C+K9IwFhtspAoUIrwSGLwUvSadaNhFPIa66ObEu/hLDCOMxEP8eavoefuf7S2DrILh8sWxF2Az3kBzRQSjQrbHUMQxtrGMkjgPvF3Z/yyuLMn8izcsbraa4vFwPurfL3m0ixmVyxr8m5i/ziAvCv4U6Ci306sfYgzHoHNPqYGuHkUPm2BoM3MMso9OEmrGX6OtYFbGOn0sKeWjNOAD9oNzVW5w9F/rOx8WU50OaBCRznJJvHHVwvnBX6mkujAX9gdPqnK5l4GTE31UPS8BE89ksEnzhFZH/FoLQIbOIF4KBdvkFPVIFrSawOYo5tpyZ8VSh1jAscaHsLp68UGKmreTMDidHE/kxppTWq6NbInqvtbVRqOj41eFep7FrB5LS7El+g3FvTrjuC9GGqUiU+S1F1zHmWVrzAZ1//EBJ7ZoXdA4mbcPi0LQpBpbfiFyrI6KNQWVwnUPtAr5YkD8+dmBnP4EVaF8yF8hxzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(38070700005)(5660300002)(86362001)(508600001)(36756003)(31686004)(91956017)(76116006)(66946007)(66556008)(66476007)(64756008)(66446008)(26005)(107886003)(186003)(6512007)(2616005)(83380400001)(53546011)(110136005)(2906002)(316002)(82960400001)(85182001)(8936002)(4326008)(71200400001)(8676002)(38100700002)(122000001)(7416002)(6506007)(31696002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGJycFF5aVdnNkp2NmZqQzBvYXhXQk0zaTIrVjdZU1ZvMGdwL2FSZTJLbjJq?=
 =?utf-8?B?YTNpWGJWOTN0WkYyVW1wNXR4RVN3UzhUZHExcG5jcDJoNEY2RFhzODMzam5O?=
 =?utf-8?B?TW1Dd3hPTEs1RE1FZXdLZ0x5RXNydnZxUk82NmFrOEN2S1NiRjY1Zk5oTSs5?=
 =?utf-8?B?VVhwMWpFNjJUUGQ4VTFNOG1GcnFBV2tqaE4xZXgrZEwzWWo2Q0pkUEEyOEhy?=
 =?utf-8?B?bGc2cmNSZ2d3b1J6YzRGS21WeGF6OXNkbURXalZ3ZmJ0eEtEZlR1RmZJRlJZ?=
 =?utf-8?B?UW90K3krdnI5aW5wUHZkdFB5ZkY1ZHl5N0pveURxUzh2emRZNEZaSEkyWnly?=
 =?utf-8?B?UXRzRzUvcWUrU1dkbmVnRmw4dDV5aXd4SmRBSTdtSnNsVFRMY3V2SVpSOHIr?=
 =?utf-8?B?MFd1Zkd2M0Fkb2JkZWIyZVpzYkpoSlJOWVllVGpwckQ5ZElnQVBlODM5ZzRJ?=
 =?utf-8?B?N2RKdWExUkpFWnQ4YmlPbUxxbjNKcllRUWpFcDBzMmhscWwrb21HaERDZGdp?=
 =?utf-8?B?VnZrZUczVzFFRndTc0l2dDRxS1MvdVNmR1JMRkdYZDBINXdoS2tWQk9XNWha?=
 =?utf-8?B?MmtOSU8zUXFVRUpJNFI1b1hrUU9IdVZabHhDcFRqSXpYR1dvYlI1UTZuOU1y?=
 =?utf-8?B?cXdtb29WOVNtM29BRmtPaVF4Y0dXZVZ6ZWJFd1lNR2JERHZaeVpSZlZNUFFF?=
 =?utf-8?B?cGF1MTVFcCtuVDAvc0dZK1QycjIrbmNtbnlyaHZaQ0k2S3VJYjZaSkh2emcz?=
 =?utf-8?B?bGZHUjRnMHRGQ1NuY29IcGxWQ1NXSVVsREJ0WnM1Z05CS0M3VkZtK1BNT0po?=
 =?utf-8?B?T09RNkI0Vmt0elJrSmtlZ2dVcjdDNXI2VTVyOXl6aVVpRjRvQ3A1OHNnTzhm?=
 =?utf-8?B?NHFxd3Z2bFhuOVNjaWVuM0FOREhsVnVwV2Qvc1REQjNtOEVFdDJmaG9rd1JZ?=
 =?utf-8?B?MjNPREJtRDZkcHUwZWN0cjRBb2JvT0ZWQTUwTnJEand4WFc2UC8yN1R2dEtU?=
 =?utf-8?B?ekRYTUlaUFd3VWRsejlOUjlNemJnMVFZak5oRzYxcUJxRWUrUXdCVlJFSDNP?=
 =?utf-8?B?eEpoS2FXTVhLKzQ2aG9PS2dGOEs5QzFPVlRNVXdRVkpQTHYzV2l1U1F3b2Q4?=
 =?utf-8?B?UDgzdFk4TnM0UWVSUm5rR0t1ZTlZSlc1a3BIT3lOdHovMGxkeW1DcHJDZ0hW?=
 =?utf-8?B?VFh5SE1ranpHLy9zTmRnUWNCRFJzVHBDNE04Vnp6Umdnc21yUGJMYVNFN2M5?=
 =?utf-8?B?QmdYQmhHTHh5a2lFSy9OR01Fb3JZVlFYNDV3cE9ZMTBTeTM1N05YS3Fab0Ir?=
 =?utf-8?B?cGdlT29jWUdzSHpRT0dMcDZsaGdPVUxQU005MVZVbkNaQWRVbGhVL0ZEYWRS?=
 =?utf-8?B?WTFYZk9qaDl6Tm82NEpaN3llVDZGTTRYMExKN0gvY2RDVFVWQ1d2ckFpKzYz?=
 =?utf-8?B?RmZJamZkMTl5TFpWaUtlOFVjOHMzWTcxekwzZCt6MGtHS3BKeFU0MVJtYUw1?=
 =?utf-8?B?N3Y0dVYwTUZVN1hsLzdjUHBhSFlTVVI0eSsvanJGbkJQT3FyTFArazNJaitH?=
 =?utf-8?B?QThESTVpZFZMeGdqWnNjT21EcFNWZVFjMno3Q3A1Q3hGVHNjM3V0SFdQRFdv?=
 =?utf-8?B?QUlUaGpOeWkwaVppL2EwdXUyaUFTYnd1QTIxckdPcjZpVit4M282Q25aeHhM?=
 =?utf-8?B?amJiUU1JL2poNGtjeGpvWmpMbTAzYnNMOUd3cmtKSTl6bW13b2lsQWJKdVNX?=
 =?utf-8?B?U25aWHBWaUEvRHV3anRualpGVHpSd3cxaHprV3lYc3FzV1FHM2g4V3pMSXhG?=
 =?utf-8?B?czU2TWJvV3hKRzI0QU80d2NwbVJKRXI5d0dDTTFqZFovVHJQOXBVd1VUd1VP?=
 =?utf-8?B?VVkrMWNaZ1lZUi9LZGdEUEdxQnFDeVZqRVI5VnpLQVI1SHl0WkxUQUdFcjBI?=
 =?utf-8?B?KzhHM0xtMFJSbkNmeU92ZlVrY0J6NjU0VVErTk9CdjBZYlVXZ081VmVITzVU?=
 =?utf-8?B?MXc0MzdkNlhicGpKL3ZrOVJEV1RVK01vcWYySEdQL1dHSitJaWRYcXFJM1do?=
 =?utf-8?B?cjNGZUlvbzIrbkErRWE4UmZZMVI1d01WakZCaGpuTGcwYXN1cGFOREd5UWR1?=
 =?utf-8?B?MFIrdmIrVnZER2ViN3NjM3RyZWhMdEJzcmVXNkN2bU83ZGJaMjFwWFdHRW5s?=
 =?utf-8?Q?J8eB/YDsFcImK36PxCeP0cc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B0349A7568EEF47A60F820B81297F93@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601cd8e1-d441-4c6e-a143-08d9cf5f58a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 08:51:06.4740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BekgZgiUtUCqSrhCMZtXja8e1RaHTf6MQ2u/RCNRTCXyvrEcsoio1vRSjQMvE38Kj21nUpQjFyyhDNxb0DnIsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8606
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDMxLzEyLzIwMjEgMTA6MzIsIFRvbSBUYWxwZXkgd3JvdGU6DQo+DQo+IE9uIDEyLzMw
LzIwMjEgODozNyBQTSwgbGl6aGlqaWFuQGZ1aml0c3UuY29tIHdyb3RlDQo+Pj4+ICtzdGF0aWMg
aW50IG52ZGltbV9mbHVzaF9pb3ZhKHN0cnVjdCByeGVfbXIgKm1yLCB1NjQgaW92YSwgaW50IGxl
bmd0aCkNCj4+Pj4gK3sNCj4+Pj4gK8KgwqDCoCBpbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVy
cjsNCj4+Pj4gK8KgwqDCoCBpbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ5dGVzOw0KPj4+PiAr
wqDCoMKgIHU4wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqdmE7DQo+Pj4+ICvCoMKgwqAgc3RydWN0
IHJ4ZV9tYXDCoMKgwqDCoMKgwqDCoCAqKm1hcDsNCj4+Pj4gK8KgwqDCoCBzdHJ1Y3QgcnhlX3Bo
eXNfYnVmwqDCoMKgICpidWY7DQo+Pj4+ICvCoMKgwqAgaW50wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBtOw0KPj4+PiArwqDCoMKgIGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaTsNCj4+Pj4gK8Kg
wqDCoCBzaXplX3TCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9mZnNldDsNCj4+Pj4gKw0KPj4+PiAr
wqDCoMKgIGlmIChsZW5ndGggPT0gMCkNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAwOw0K
Pj4+DQo+Pj4gVGhlIGxlbmd0aCBpcyBvbmx5IHJlbGV2YW50IHdoZW4gdGhlIGZsdXNoIHR5cGUg
aXMgIk1lbW9yeSBSZWdpb24NCj4+PiBSYW5nZSIuDQo+Pj4NCj4+PiBXaGVuIHRoZSBmbHVzaCB0
eXBlIGlzICJNZW1vcnkgUmVnaW9uIiwgdGhlIGVudGlyZSByZWdpb24gbXVzdCBiZQ0KPj4+IGZs
dXNoZWQgc3VjY2Vzc2Z1bGx5IGJlZm9yZSBjb21wbGV0aW5nIHRoZSBvcGVyYXRpb24uDQo+Pg0K
Pj4gWWVzLCBjdXJyZW50bHksIHRoZSBsZW5ndGggaGFzIGJlZW4gZXhwYW5kZWQgdG8gdGhlIE1S
J3MgbGVuZ3RoIGluIHN1Y2ggY2FzZS4NCj4NCj4gSSdsbCBkaWcgZGVlcGVyLCBidXQgdGhpcyBp
cyBub3QgaW1tZWRpYXRlbHkgY2xlYXIgaW4gdGhpcyBjb250ZXh0Lg0KPiBBIHplcm8tbGVuZ3Ro
IG9wZXJhdGlvbiBpcyBob3dldmVyIHZhbGlkLCBldmVuIHRob3VnaCBpdCdzIGEgbm8tb3AsDQoN
CklmIGl0J3Mgbm8tb3AsIHdoYXQgc2hhbGwgd2UgZG8gaW4gdGhpcyBjYXNlLg0KDQoNCj4gdGhl
IGFwcGxpY2F0aW9uIG1heSB1c2UgaXQgdG8gZW5zdXJlIGNlcnRhaW4gb3JkZXJpbmcgY29uc3Ry
YWludHMuDQo+IFdpbGwgY29tbWVudCBsYXRlciBpZiBJIGhhdmUgYSBzcGVjaWZpYyBjb25jZXJu
Lg0KDQpraW5kbHkgd2VsY29tZSA6KQ0KDQoNCg0KDQo+DQo+Pj4+ICsNCj4+Pj4gK8KgwqDCoCBp
ZiAobXItPnR5cGUgPT0gSUJfTVJfVFlQRV9ETUEpIHsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGFy
Y2hfd2JfY2FjaGVfcG1lbSgodm9pZCAqKWlvdmEsIGxlbmd0aCk7DQo+Pj4+ICvCoMKgwqDCoMKg
wqDCoCByZXR1cm4gMDsNCj4+Pj4gK8KgwqDCoCB9DQo+Pj4NCj4+PiBBcmUgZG1hbXIncyBzdXBw
b3J0ZWQgZm9yIHJlbW90ZSBhY2Nlc3M/IEkgdGhvdWdodCB0aGF0IHdhcw0KPj4+IHByZXZlbnRl
ZCBvbiBmaXJzdCBwcmluY2lwbGVzIG5vdy4gSSBtaWdodCBzdWdnZXN0IG5vdCBhbGxvd2luZw0K
Pj4+IHRoZW0gdG8gYmUgZmx1c2hlZCBpbiBhbnkgZXZlbnQuIFRoZXJlIGlzIG5vIGxlbmd0aCBy
ZXN0cmljdGlvbiwNCj4+PiBhbmQgaXQncyBhIFZFUlkgY29zdGx5IG9wZXJhdGlvbi4gQXQgYSBt
aW5pbXVtLCBwcm90ZWN0IHRoaXMNCj4+PiBjbG9zZWx5Lg0KPj4gSW5kZWVkLCBJIGRpZG4ndCBj
b25maWRlbmNlIGFib3V0IHRoaXMsIHRoZSBtYWluIGxvZ2ljIGNvbWVzIGZyb20gcnhlX21yX2Nv
cHkoKQ0KPj4gVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4NCj4NCj4gV2VsbCwgYmUgY2FyZWZ1
bCB3aGVuIGZvbGxvd2luZyBzZW1hbnRpY3MgZnJvbSBsb2NhbCBiZWhhdmlvcnMuIFdoZW4geW91
DQo+IGFyZSBwcm9jZXNzaW5nIGEgY29tbWFuZCBmcm9tIHRoZSB3aXJlLCBleHRyZW1lIGNhdXRp
b24gaXMgbmVlZGVkLg0KPiBFU1BFQ0lBTExZIFdIRU4gSVQnUyBBIERNQV9NUiwgV0hJQ0ggUFJP
VklERVMgQUNDRVNTIFRPIEFMTCBQSFlTSUNBTCEhIQ0KPg0KPiBTb3JyeSBmb3Igc2hvdXRpbmcu
IDopDQoNCk5ldmVyIG1pbmQgOikNCg0KDQoNCg0KDQo+DQo+Pj4+ICsNCj4+Pj4gK3N0YXRpYyBl
bnVtIHJlc3Bfc3RhdGVzIHByb2Nlc3NfZmx1c2goc3RydWN0IHJ4ZV9xcCAqcXAsDQo+Pj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcnhlX3Br
dF9pbmZvICpwa3QpDQo+Pj4+ICt7DQo+Pj4+ICvCoMKgwqAgdTY0IGxlbmd0aCA9IDAsIHN0YXJ0
ID0gcXAtPnJlc3AudmE7DQo+Pj4+ICvCoMKgwqAgdTMyIHNlbCA9IGZldGhfc2VsKHBrdCk7DQo+
Pj4+ICvCoMKgwqAgdTMyIHBsdCA9IGZldGhfcGx0KHBrdCk7DQo+Pj4+ICvCoMKgwqAgc3RydWN0
IHJ4ZV9tciAqbXIgPSBxcC0+cmVzcC5tcjsNCj4+Pj4gKw0KPj4+PiArwqDCoMKgIGlmIChzZWwg
PT0gSUJfRVhUX1NFTF9NUl9SQU5HRSkNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGxlbmd0aCA9IHFw
LT5yZXNwLmxlbmd0aDsNCj4+Pj4gK8KgwqDCoCBlbHNlIGlmIChzZWwgPT0gSUJfRVhUX1NFTF9N
Ul9XSE9MRSkNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGxlbmd0aCA9IG1yLT5jdXJfbWFwX3NldC0+
bGVuZ3RoOw0KPj4+DQo+Pj4gSSdtIGdvaW5nIHRvIGhhdmUgdG8gdGhpbmsgYWJvdXQgdGhlc2UN
Cj4+DQo+PiBZZXMsIHlvdSBpbnNwaXJlIG1lIHRoYXQgd2Ugc2hvdWxkIGNvbnNpZGVyIHRvIGFk
anVzdCB0aGUgc3RhcnQgb2YgaW92YSB0byB0aGUgTVIncyBzdGFydCBhcyB3ZWxsLg0KPg0KPiBJ
J2xsIHJldmlldyBhZ2FpbiB3aGVuIHlvdSBkZWNpZGUuDQo+Pj4+ICsNCj4+Pj4gK8KgwqDCoCBp
ZiAocGx0ID09IElCX0VYVF9QTFRfUEVSU0lTVCkgew0KPj4+PiArwqDCoMKgwqDCoMKgwqAgbnZk
aW1tX2ZsdXNoX2lvdmEobXIsIHN0YXJ0LCBsZW5ndGgpOw0KPj4+PiArwqDCoMKgwqDCoMKgwqAg
d21iKCk7IC8vIGNsd2IgZm9sbG93cyBieSBhIHNmZW5jZQ0KPj4+PiArwqDCoMKgIH0gZWxzZSBp
ZiAocGx0ID09IElCX0VYVF9QTFRfR0xCX1ZJUykNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHdtYigp
OyAvLyBzZmVuY2UgaXMgZW5vdWdoDQo+Pj4NCj4+PiBUaGUgcGVyc2lzdGVuY2UgYW5kIGdsb2Jh
bCB2aXNpYmlsaXR5IGJpdHMgYXJlIG5vdCBtdXR1YWxseQ0KPj4+IGV4Y2x1c2l2ZSwNCj4+IE15
IGJhZCwgaXQgZXZlciBhcHBlYXJlZCBpbiBteSBtaW5kLiBvKOKVr+KWoeKVsClvDQo+Pg0KPj4N
Cj4+DQo+Pg0KPj4+IGFuZCBpbiBmYWN0IHBlcnNpc3RlbmNlIGRvZXMgbm90IGltcGx5IGdsb2Jh
bA0KPj4+IHZpc2liaWxpdHkgaW4gc29tZSBwbGF0Zm9ybXMuDQo+PiBJZiBzbywgYW5kIHBlciB0
aGUgU1BFQywgd2h5IG5vdA0KPj4gwqAgwqDCoCBpZiAocGx0ICYgSUJfRVhUX1BMVF9QRVJTSVNU
KQ0KPj4gwqAgwqDCoMKgwqDCoCBkb19zb21ldGhpbmdBKCk7DQo+PiDCoCDCoMKgIGlmIChwbHQg
JiBJQl9FWFRfUExUX0dMQl9WSVMpDQo+PiDCoCDCoMKgwqDCoMKgIGRvX3NvbWV0aGluZ0IoKTsN
Cj4NCj4gQXQgdGhlIHNpbXBsZXN0LCB5ZXMuIEJ1dCB0aGVyZSBhcmUgbWFueSBzdWJ0bGUgb3Ro
ZXIgcG9zc2liaWxpdGllcy4NCj4NCj4gVGhlIGdsb2JhbCB2aXNpYmlsaXR5IGlzIG9yaWVudGVk
IHRvd2FyZCBzdXBwb3J0aW5nIGRpc3RyaWJ1dGVkDQo+IHNoYXJlZCBtZW1vcnkgd29ya2xvYWRz
LCBvciBwdWJsaXNoL3N1YnNjcmliZSBvbiBoaWdoIHNjYWxlIHN5c3RlbXMuDQo+IEl0J3MgbWFp
bmx5IGFib3V0IGVuc3VyaW5nIHRoYXQgYWxsIGRldmljZXMgYW5kIENQVXMgc2VlIHRoZSBkYXRh
LA0KPiBzb21ldGhpbmcgb3JkaW5hcnkgUkRNQSBXcml0ZSBkb2VzIG5vdCBndWFyYW50ZWUuIFRo
aXMgb2Z0ZW4gbWVhbnMNCj4gZmx1c2hpbmcgd3JpdGUgcGlwZWxpbmVzLCBwb3NzaWJseSBmb2xs
b3dlZCBieSBpbnZhbGlkYXRpbmcgY2FjaGVzLg0KPg0KPiBUaGUgcGVyc2lzdGVuY2UsIG9mIGNv
dXJzZSwgaXMgYWJvdXQgZW5zdXJpbmcgdGhlIGRhdGEgaXMgc3RvcmVkLiBUaGlzDQo+IGlzIGVu
dGlyZWx5IGRpZmZlcmVudCBmcm9tIG1ha2luZyBpdCB2aXNpYmxlLg0KPg0KPiBJbiBmYWN0LCB5
b3Ugb2Z0ZW4gd2FudCB0byBvcHRpbWl6ZSB0aGUgdHdvIHNjZW5hcmlvcyB0b2dldGhlciwgc2lu
Y2UNCj4gdGhlc2Ugb3BlcmF0aW9ucyBhcmUgYWxsIGFib3V0IG9wdGltaXppbmcgbGF0ZW5jeS4g
VGhlIGNob2ljZSBpcyBnb2luZw0KPiB0byBkZXBlbmQgZ3JlYXRseSBvbiB0aGUgYmVoYXZpb3Ig
b2YgdGhlIHBsYXRmb3JtIGl0c2VsZi4gRm9yIGV4YW1wbGUsDQo+IGNlcnRhaW4gY2FjaGVzIHBy
b3ZpZGUgcGVyc2lzdGVuY2Ugd2hlbiBiYXR0ZXJpZXMgYXJlIHByZXNlbnQuIFNvLA0KPiBwcm92
aWRpbmcgcGVyc2lzdGVuY2UgYW5kIHByb3ZpZGluZyB2aXNpYmlsaXR5IGFyZSBvbmUgYW5kIHRo
ZSBzYW1lLg0KPiBObyBuZWVkIHRvIGRvIHRoYXQgdHdpY2UuDQo+DQo+IE9uIHRoZSBvdGhlciBo
YW5kLCBzb21lIHN5c3RlbXMgbWF5IHByb3ZpZGUgcGVyc2lzdGVuY2Ugb25seSBhZnRlciBhDQo+
IHNpZ25pZmljYW50IGNvc3QsIHN1Y2ggYXMgd3JpdGluZyBpbnRvIGZsYXNoIGZyb20gYSBEUkFN
IGJ1ZmZlciwgb3INCj4gd2hlbiBhbiBPcHRhbmUgRElNTSBiZWNvbWVzIG92ZXJsb2FkZWQgZnJv
bSBjb250aW51b3VzIHdyaXRlcyBhbmQNCj4gYmVnaW5zIHRvIHRocm90dGxlIHRoZW0uIFRoZSBm
bHVzaCBtYXkgbmVlZCBzb21lIHJhdGhlciBpbnRyaWNhdGUNCj4gcHJvY2Vzc2luZywgdG8gYXZv
aWQgZGVhZGxvY2suDQo+DQo+IFlvdXIgY29kZSBkb2VzIG5vdCBhcHBlYXIgdG8gZW52aXNpb24g
dGhlc2UsIHNvIHRoZSBzaW1wbGUgd2F5IG1pZ2h0DQo+IGJlIGJlc3QgZm9yIG5vdy4gQnV0IHlv
dSBzaG91bGQgY29uc2lkZXIgb3RoZXIgc2l0dWF0aW9ucy4NCg0KVGhhbmtzIGEgbG90IGZvciB5
b3VyIGRldGFpbGVkIGV4cGxhbmF0aW9uLg0KDQoNCg0KPg0KPj4+IFNlY29uZCwgdGhlICJjbHdi
IiBhbmQgInNmZW5jZSIgY29tbWVudHMgYXJlIGNvbXBsZXRlbHkNCj4+PiBJbnRlbC1zcGVjaWZp
Yy4NCj4+IGdvb2QgY2F0Y2guDQo+Pg0KPj4NCj4+PiBXaGF0IHByb2Nlc3Npbmcgd2lsbCBiZSBk
b25lIG9uIG90aGVyDQo+Pj4gcHJvY2Vzc29yIHBsYXRmb3Jtcz8/Pw0KPj4NCj4+IEkgZGlkbid0
IGRpZyBvdGhlciBBUkNIIHlldCBidXQgSU5URUwuDQo+PiBJbiB0aGlzIGZ1bmN0aW9uLCBpIHRo
aW5rIGkganVzdCBuZWVkIHRvIGNhbGwgdGhlIGhpZ2hlciBsZXZlbCB3cmFwcGVyLCBsaWtlIHdt
YigpIGFuZA0KPj4gYXJjaF93Yl9jYWNoZV9wbWVtIGFyZSBlbm91Z2gsIHJpZ2h0ID8NCj4NCj4g
V2VsbCwgaGlnaGVyIGxldmVsIHdyYXBwZXJzIG1heSBzaWduYWwgZXJyb3JzLCBmb3IgZXhhbXBs
ZSBpZiB0aGV5J3JlDQo+IG5vdCBhdmFpbGFibGUgb3IgdW5yZWxpYWJsZSwgYW5kIHlvdSB3aWxs
IG5lZWQgdG8gaGFuZGxlIHRoZW0uIEFsc28sDQo+IHRoZXkgbWF5IGJsb2NrLiBJcyB0aGF0IG9r
IGluIHRoaXMgY29udGV4dD8NCg0KR29vZCBxdWVzdGlvbi4NCg0KTXkgYmFkLCBpIGZvcmdvdCB0
byBjaGVjayB0byByZXR1cm4gdmFsdWUgb2YgbnZkaW1tX2ZsdXNoX2lvdmEoKSBwcmV2aW91c2x5
Lg0KDQpCdXQgaWYgeW91IG1lYW4gd2Ugc2hvdWxkIGd1YXJhbnRlZSBhcmNoX3diX2NhY2hlX3Bt
ZW0oKSBhbmQgd21iKCksIGkgaGF2ZSBub3QNCmlkZWEgeWV0Lg0KDQphcmNoX3diX2NhY2hlX3Bt
ZW0oKSBhbmQgd21iKCksIFdoYXQgaSdtIGN1cnJlbnRseSB1c2luZyBhcmUganVzdCB0byBoaWRl
DQp0aGUgYXNzZW1ibHkgaW5zdHJ1Y3Rpb25zIG9uIGRpZmZlcmVudCBhcmNoaXRlY3R1cmVzLiBB
bmQgdGhleSBhcmUgdm9pZCByZXR1cm4uDQoNCkkgd29uZGVyIGlmIHdlIGNhbiBhbHdheXMgYXNz
dW1lIHRoZXkgd29yayBhbHdheXMgV2hlbiB0aGUgY29kZSByZWFjaGVzIHRoZW0uDQpTaW5jZSBh
bGwgY3VycmVudCBsb2NhbCBmbHVzaGluZyB0byBwbWVtIGRvIHNvbWV0aGluZyBsaWtlIHRoYXQg
QUZBSUsoRmVlbCBmcmVlDQp0byBjb3JyZWN0IG1lIGlmIGknbSB3cm9uZykNCg0KVGhhbmtzDQpa
aGlqaWFuDQoNCj4NCj4gWW91IG5lZWQgdG8gZ2V0IHRoaXMgcmlnaHQgb24gYWxsIHBsYXRmb3Jt
cyB3aGljaCB3aWxsIHJ1biB0aGlzIGNvZGUuDQo+IEl0IGlzIG5vdCBhY2NlcHRhYmxlIHRvIGd1
ZXNzIGF0IHdoZXRoZXIgdGhlIGRhdGEgaXMgaW4gdGhlIHJlcXVpcmVkDQo+IHN0YXRlIGJlZm9y
ZSBjb21wbGV0aW5nIHRoZSBSRE1BX0ZMVVNILiBJZiB0aGlzIGlzIG5vdCBndWFyYW50ZWVkLA0K
PiB0aGUgb3BlcmF0aW9uIG11c3QgcmFpc2UgdGhlIHJlcXVpcmVkIGVycm9yLiBUbyBkbyBhbnl0
aGluZyBlbHNlIHdpbGwNCj4gdmlvbGF0ZSB0aGUgcHJvdG9jb2wgY29udHJhY3QsIGFuZCB0aGUg
cmVtb3RlIGFwcGxpY2F0aW9uIG1heSBmYWlsLg0KDQoNCj4NCj4gVG9tLg0K
