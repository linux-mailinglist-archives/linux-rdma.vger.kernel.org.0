Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46857E6222
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Nov 2023 03:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjKICZK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Nov 2023 21:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKICZJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Nov 2023 21:25:09 -0500
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DC28E;
        Wed,  8 Nov 2023 18:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1699496708; x=1731032708;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TQ6lHEOhufO9u7B7OxtOBP4dmHkaqnc15OO1zsBnTpQ=;
  b=WTfHhAxZSJChCaabzKmFDrjRuMQYKMr7qz/1KyHSHKduzK4jux/7s+6D
   pbot18TmiiTL9FVPp6g9dqf7ApebKtJdU9MouOIAnJBBOvcitV/ZAj/Dn
   Oxb5kInbgK+XUWW31mFJLlmAcM5h3g90NbFfFi+l73qX2/u81P7zEVeG8
   XMBFBzJXfLG6yfrBXZcOiEZxtagQL5j2W5dYepsb55wOXXiXLXMc3wFZs
   LFMuSQBFa9s48N08qq9s7fPRFdNuW5queW3k5+lQT249aaC9CeNqFNMNU
   9/BSNLRqbtlT8ZViKT1oGM9MTC/C4yA18XgepZpvNnJpnUMi4dp7VJH0V
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="101439082"
X-IronPort-AV: E=Sophos;i="6.03,288,1694703600"; 
   d="scan'208";a="101439082"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 11:25:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3qRsbTNqMTihKh7hA/jbxcVgQkEX8VDKJ6CkNgvnuO945cpOfKjP/I/uEkcBdtBqNzqGuhB2GC0n33uM2GpeFVOb2ol2+YlgzWeSnEtjumua+wiUFzD785MxXWGEicBdEKhNEA4k4AUwGkUI1u0XMcXnWdofRrDwfF2qOabGmyp1Du6gir3EZoee0NUuvQcBPsIx6GKnjrbEeOoR49aYYMqUyt0DBYxz1hwu7K+R2b97oWaHf9m1mu7RmtlEAwlVRRjZc/wnrT1CAgfhwMcFO5s4HEkGnS/FhbzffjCXcYxFIV6HsG90nkH4UmvYQlmyhEbH/S3mHVhXk7d+BcpfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQ6lHEOhufO9u7B7OxtOBP4dmHkaqnc15OO1zsBnTpQ=;
 b=HBIo8GH/i1n+p3W6tETkc39Vm3BydQT/1K5fez+mx15Cm7OZ/VPKzVHLdI3vZjIovrqFEAv/5tdJVqE+vNFjnXXW21gpnrHc70n0zCgvqVNa5Bcl/GfDQEDzlcpBuAl6izRhmj/H8CRjwpw7IK+YiUD80HmgV3017ybtjxanWcqJmoize7HJ8OaTUeaSM5ZFnozH+MESLWlzZnV9ECjSrm/peFhGnuI8WIkc1xXzXlWHQ8WUmqhq5jpfGVHO/vUQ1Y5K8DnayQJMTcRZ2pEmUa4QXgbstaZ44AiMF3Gw0yvH3n/1eTOOHSWDgDqkGaBGwU7k6LHKxGqPUaw+fDSzNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYWPR01MB9327.jpnprd01.prod.outlook.com (2603:1096:400:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 02:24:59 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::16d1:f1e:a08:dd5c]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::16d1:f1e:a08:dd5c%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 02:24:59 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>
Subject: Re: [PATCH RFC V2 0/6] rxe_map_mr_sg() fix cleanup and refactor
Thread-Topic: [PATCH RFC V2 0/6] rxe_map_mr_sg() fix cleanup and refactor
Thread-Index: AQHaDjvxgnGsUlf/nk+PthrgEoRwxrBojwMAgAQh+4CAAKUOgIAD9VmA
Date:   Thu, 9 Nov 2023 02:24:59 +0000
Message-ID: <037148c3-c15b-4859-9b82-8349fcb54d0a@fujitsu.com>
References: <20231103095549.490744-1-lizhijian@fujitsu.com>
 <d838620b-51df-4216-864e-1c793dae7721@linux.dev>
 <a256a01d-1572-427a-80df-46f2079af967@fujitsu.com>
 <c736ddff-8523-463a-aa9a-3c8542486d69@linux.dev>
In-Reply-To: <c736ddff-8523-463a-aa9a-3c8542486d69@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYWPR01MB9327:EE_
x-ms-office365-filtering-correlation-id: ea5f65ad-6de1-43da-7d12-08dbe0cb122c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eoGPUpgLOkn6W6gDROnWL01/cQy8/AYna1IYRrXvuwL+KvP0+c4PgeiA4ofvV3w9XfaiKwgLSr0/tLn7yuNpmtEQ4t0ZMtlQMXXOg6DpT0ayWNyhRD7jfCRA/8mWNcD1r/gK1RzpGgtQTzOhbV+v8cIpfFcOxMdbNJnnlLAC4AUQ7FQMttvalTjPUe+cxs8RWTGD8DobrPfb5BmflFsBEItZBHyAj9r6g43PvV8zHDrtz+9PUHiECGF587R5E+49vurN/w8I5A5unLift377as8HJRGP0R3V5e73J/C79Gh8wluJB3uQOLSOG0jNISDUQu+Hq+N9weenG5QI2vI5CkjmdIfmbUdEnwfVyo1L0aoZ3GHbWpKRtYmr4aSa12Lkp26W0wdWX/DIulPVseB8WoMjqiXWrxWNA6AFkQWsVql9O/Zx5aq8rE0AG6HhvB/DWWHi/twu7oiS1CF4PP/1U9XcOBl8v55jky25PgSpuo6Yl7UsODD01IbPAM1230m28Ln7uG8QSEII4t+9aZ8dcIPATW5Mg3PX4aR1/mYC5akykOsTX58BPiz+sJeeFt8peou47A+oaiGTuo2gDR73XDv6ln5uTzTdcwj4QICXTXDBeZ0yoW3dTbPzuq3G/GP60neqnXG0q/luAMhNjVEU5e7mD1PnUAcq/fyKCjxrF/AM5zEfCkpC7YRxJjfZQsc+ws4vE8fl+KEIOB5gaNaDbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1590799021)(1800799009)(451199024)(71200400001)(83380400001)(122000001)(6512007)(6506007)(53546011)(26005)(82960400001)(2616005)(966005)(478600001)(6486002)(31686004)(38100700002)(8936002)(66556008)(316002)(66476007)(66446008)(66946007)(64756008)(76116006)(110136005)(54906003)(91956017)(4326008)(1580799018)(2906002)(31696002)(86362001)(5660300002)(41300700001)(8676002)(85182001)(38070700009)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wk43S0c3Uk1POForWmpPOVdpQXcwM0xLMFMvQTRISXB0UUhFa2tkcldGdEJG?=
 =?utf-8?B?ZTNacm9HNE1sZHB1cE56R1EzRllteVpEek11Mkx0ekNoSnFQOE9HYmhWbHhK?=
 =?utf-8?B?WlRBRmVrKzJ0K0hvMGFpOEpkOFUwd3FCMXlyQXhuNEhnSFUvZXBXUG5wMDFw?=
 =?utf-8?B?Vi81MVI0bnNxcGlPSllvc0ZEVzNleDhPMWVNdEQ2SWRQMWRjWnZxcTkrSEVn?=
 =?utf-8?B?cGtQN1hjdWQzTy9lUWF2T0pCMHUzN2NDYVNWWFpKMjJOSkF4QWRmSEdIZjcr?=
 =?utf-8?B?ZGNUb1QwamVyYTU3Vmg2Uys3UWR5KytaM2pVSzErNHRhUjZoVUN5WnNCaUZj?=
 =?utf-8?B?UGxYRW4xS0tScGI1TXBiUVpIQ1lSWWdGMmdXTEt1TmdnUENBUVMyZEd2Z0ZS?=
 =?utf-8?B?UkJIZndlRzJkN21ONUpGVmxRVUpLWkt5dzZxSFFYN0FZUzBvVDI3Nzg0QW5D?=
 =?utf-8?B?NFVQQmkzQ3BpUW1Ick5YYkROMzF0bGNWT3FmQ2RBNlBGRk9FVHluNFNQSGJq?=
 =?utf-8?B?YXNrOTRLeWJHQkl0elRic05vTzhYWmI5NUVJbnJ2YmVpcW9McGRNVzYrZ3RZ?=
 =?utf-8?B?ZmI4NFpNRmo4WXNwQjZMbWRZSnFDSGpRS0VIUEYzNlZ5eUFIUGoxUEhmd2Jo?=
 =?utf-8?B?QlhVbzhweEZTMXlSN1Btc3EwRTZhZjM0enhZejFjNXp1bGgyMDNWbUo2a2xB?=
 =?utf-8?B?Q3RHa1pPTkpTUkh5NVNVRzg0YnRJWFZRMUtPUkMrRWJ3bi9TUlJ5VDFHbXRR?=
 =?utf-8?B?UjNYL0VZdVZUL2I2UGNqOUZYRGFhTkxZNDNycVpYc1F2dlZSZE9lZzRwOHlE?=
 =?utf-8?B?WWYvenIzZGV1YUpZKzl1bGhYMzdhZlNRSzlnbGQ3QmoxeGRSTDlBQzNuVFlH?=
 =?utf-8?B?eXdwOUpiWG9LSmxnMzBhTWxqaTJTRXhid1FDWXpMelYweHMxemMwL2d4WG9n?=
 =?utf-8?B?dHdPTU9GOWhYb3NBZ05TN3hrMlJvNkVTZ2Z0WU9vUDJOMlNPa0g3RmUxejdN?=
 =?utf-8?B?NWlpZlpPM0IxZTFhK0J4VjdxKzRiSVZ6Q3B3aGhrOVA5N3B5eTMrTVFyR1l3?=
 =?utf-8?B?Z2VvYTBlNzBtRDdRcXF1V3hUL3loV0NxNGFZTVk3cFUzbEtlbVIzUjg5RUc0?=
 =?utf-8?B?cXI0R0ZNVFpTSVVZWVhjdWcwc3YrbUxOTUVpSnlZaXl1Vm04V01mWEVRaTRy?=
 =?utf-8?B?aEUyV2tIZTA4eHM0T2ZvRnlKeUVZclZZZ2c3aVJmbHVSc1ozUE5aVG5TOXhZ?=
 =?utf-8?B?Rk5CVmkvdFNNWGV5ZFlGSUVaT2ttUkpPNkR1Mk1MS005RHRmTHNCZWd1MmJC?=
 =?utf-8?B?alNxeDFJU2NqTEtJMWx5aHR6TEREOTNRN1R3QUh4ZWtkRk1ZbWZoeFlDd1Nq?=
 =?utf-8?B?YU1zRktZL2xIeTN6U2dXWWtEOGx0Sm1LTVZzY01ORWtKYVk2L3h3WE8rZFY5?=
 =?utf-8?B?ZEpGb3RIS2RkVjViaUhhWGc4ckRwS2NrZFpEc0U0cjVDQUUvUlc2YmVJaURE?=
 =?utf-8?B?MU1KRkNrelQ4WVZMQWhMY2hIS3dBb2RibDdiMURLZ3orbkRGZGVSdTAxZ0Zs?=
 =?utf-8?B?TVhjQjVpaGp5VXJLU0dxRzFoallUdXBxM0phNCtXVVpDSmM2U0lpdFFoelhU?=
 =?utf-8?B?OEtXZjhhKzE1TjRiTjBBQU5iRjdxWHFMdVhuclYxWTZNcll0NHNGRVQ1U2RE?=
 =?utf-8?B?WmQxNWVWUzZYUSs4ZENOTk9TaE1hazdFMm16VkxDbGRGSWhBN0tLRXpzM09O?=
 =?utf-8?B?NFgyd0dzbTRRQVlpYTVvWHpwUDYzd2lIT0tqcHo4dWYzVkVyM005bko4RjNU?=
 =?utf-8?B?T0pHRTNVaHZGczBIdmJFQmJXNkdUSkZxTC9UQ2hOclhuMDQxOGVhRWxIc1lY?=
 =?utf-8?B?YlRWQlR6RjlWYzdJRk5sTGJIU0tTV1N5MEtKditqaFlGYnNFVkJFV3ZWaTZ6?=
 =?utf-8?B?aEhQNlRPRmw4NUZybHF0bDZLNTFSaWhJcld4bW5kYmJpc0F1cXNLQTlZYWp2?=
 =?utf-8?B?QVV6OTYwU2JDVXcwZVhQK1pUNnJscmRPZEpvc2pTZVpkNjBYSGZjSDQzY2pj?=
 =?utf-8?B?YmZiZHZnYVYvV0trM09TS1l2bVc5b3N0dmVIeWpGRVVhS1gzd0xxS0I5Mmta?=
 =?utf-8?B?RWIrYmtQWWpWM2c4OUxRNUdydzVlcml1WlRqUXltdmxtNkNzRjdqbzJ6dWhQ?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1ADA4FA61D68144489A4A6AA253566B1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lLz2LNkttEKftBanfVaNoEeN0kbSYNnewIbN/hoh/u9v7cTv9X3w7+URmTW4cC2etm8Yc/fTrVLNcxq+suxyR4EaNdw0ZhEgano+Rgc/cgkbdPv9Q0rMUMZg4+PTLzKdE5NJ3gJHYgTS4jUAZ0XCHk6dsKpm74aaq9cX010h1EfiZDGLkJ2I2T0NMcGI7+plrOzJMFMpWMBn15M5byJlL2LAOfkoXXqZ0Jr+6Q6DffMvprpFAxPvwsMX+DBawY0mWr9H8+jscoibSF565kogF68mNHNcFexobJE4tZE978pdB4ktsI2AM3QZyWuymLzCwCvfilIlAd0vftXw7xAKEV7mSLiH/s3/C2Lt1LmeSgA1DmpGNKW6JOosNrc97ci3OMdZKUIidxA3OYy995FcLkfqSDAiOt7o+mLRX0vsdK2SK2W+4x04jQPvkAyxihZJj33Wr+2wHCbvDLHCGjlvGLke6eHNKgzNe93uPafBDCqT5zA7+Cii6KkiXlEZ5JuNxhORAYUqLPpryw6nf9QDJ1kHQMWuiHx7jOhI0ELn8TEPJSbGpZxpfAjOGbcvQuEi5nqUT7iRqa8/sE26kjsWPcXX791H5zi9ynklkQ77GjPC1h8DVAui3+tDjUgufSbXju++xvQZ5PB1hUnmqNUKaDb6D3xLy8iw4rMsSFgTnmJpGMFJQA6v2goY28VlB/Rpi6/s7J4Pc7lDQ6Jat7zPCiS3rilkYPY9XfpvP+cpVuDutlJNgw6EKlUr82LnBaQyfpTY3Ac0m2Tbpf58ZlqxbSomqGbckdrFgFEDotlIvhnGT4W2xaNccXqn5lBSXFJB7QD6qsNvNAMAzulTzMvdP2Vtdlo9pFxH2c/tlk6X62IIV4YbmPehLBZ3itYflo4zS547HcHi4IoV7JZ/wCctB+gSdC0/A//uTqIxoAfTrII=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5f65ad-6de1-43da-7d12-08dbe0cb122c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 02:24:59.0886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fMetR4UuJMpJv20X535iHf/E8uKvenvckyo/kGzjn53Xw4T9fVlo2vtuMTynfztBuyRIAjN5LXSrPf2y8v7BFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9327
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDA2LzExLzIwMjMgMjE6NTgsIFpodSBZYW5qdW4gd3JvdGU6DQo+IOWcqCAyMDIzLzEx
LzYgMTI6MDcsIFpoaWppYW4gTGkgKEZ1aml0c3UpIOWGmemBkzoNCj4+DQo+Pg0KPj4gT24gMDMv
MTEvMjAyMyAyMTowMCwgWmh1IFlhbmp1biB3cm90ZToNCj4+PiDlnKggMjAyMy8xMS8zIDE3OjU1
LCBMaSBaaGlqaWFuIOWGmemBkzoNCj4+Pj4gSSBkb24ndCBjb2xsZWN0IHRoZSBSZXZpZXdlZC1i
eSB0byB0aGUgcGF0Y2gxLTIgdGhpcyB0aW1lLCBzaW5jZSBpDQo+Pj4+IHRoaW5rIHdlIGNhbiBt
YWtlIGl0IGJldHRlci4NCj4+Pj4NCj4+Pj4gUGF0Y2gxLTI6IEZpeCBrZXJuZWwgcGFuaWNbMV0g
YW5kIGJlbmlmaXQgdG8gbWFrZSBzcnAgd29yayBhZ2Fpbi4NCj4+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBBbG1vc3Qgbm90aGluZyBjaGFuZ2UgZnJvbSBWMS4NCj4+Pj4gUGF0Y2gzLTU6IGNs
ZWFudXBzICMgbmV3bHkgYWRkDQo+Pj4+IFBhdGNoNjogbWFrZSBSWEUgc3VwcG9ydCBQQUdFX1NJ
WkUgYWxpZ25lZCBtciAjIG5ld2x5IGFkZCwgYnV0IG5vdCBmdWxseSB0ZXN0ZWQNCj4+Pj4NCj4+
Pj4gTXkgYmFkIGFybTY0IG1lY2hpbmUgb2ZmdGVuIGhhbmdzIHdoZW4gZG9pbmcgYmxrdGVzdHMg
ZXZlbiB0aG91Z2ggaSB1c2UgdGhlDQo+Pj4+IGRlZmF1bHQgc2l3IGRyaXZlci4NCj4+Pj4NCj4+
Pj4gLSBudm1lIGFuZCBVTFBzKHJ0cnMsIGlzZXIpIGFsd2F5cyByZWdpc3RlcnMgNEsgbXIgc3Rp
bGwgZG9uJ3Qgc3VwcG9ydGVkIHlldC4NCj4+Pg0KPj4+IFpoaWppYW4NCj4+Pg0KPj4+IFBsZWFz
ZSByZWFkIGNhcmVmdWxseSB0aGUgd2hvbGUgZGlzY3Vzc2lvbiBhYm91dCB0aGlzIHByb2JsZW0u
IFlvdSB3aWxsIGZpbmQgYSBsb3Qgb2YgdmFsdWFibGUgc3VnZ2VzdGlvbnMsIGVzcGVjaWFsbHkg
c3VnZ2VzdGlvbnMgZnJvbSBKYXNvbi4NCj4+DQo+PiBPa2F5LCBpIHdpbGwgcmVhZCBpdCBhZ2Fp
bi4gSWYgeW91IGNhbiB0ZWxsIG1lIHdoaWNoIHRocmVhZCwgdGhhdCB3b3VsZCBiZSBiZXR0ZXIu
DQo+Pg0KPj4NCj4+Pg0KPj4+IMKgIEZyb20gdGhlIHdob2xlIGRpc2N1c3Npb24sIGl0IHNlZW1z
IHRoYXQgdGhlIHJvb3QgY2F1c2UgaXMgdmVyeSBjbGVhci4NCj4+PiBXZSBuZWVkIHRvIGZpeCB0
aGlzIHByb2xlbS4gUGxlYXNlIGRvIG5vdCBzZW5kIHRoaXMga2luZCBvZiBjb21taXRzIGFnYWlu
Lg0KPj4+DQo+Pg0KPj4gTGV0J3MgdGhpbmsgYWJvdXQgd2hhdCdzIG91ciBnb2FsIGZpcnN0Lg0K
Pj4NCj4+IC0gMSkgRml4IHRoZSBwYW5pY1sxXSBhbmQgb25seSBzdXBwb3J0IFBBR0VfU0laRSBN
Ug0KPj4gLSAyKSBzdXBwb3J0IFBBR0VfU0laRSBhbGlnbmVkIE1SDQo+PiAtIDMpIHN1cHBvcnQg
YW55IHBhZ2Vfc2l6ZSBNUi4NCj4+DQo+PiBJJ20gc29ycnkgaSdtIG5vdCBmYW1pbGlhciB3aXRo
IHRoZSBsaW51eCBNTSBzdWJzeXN0ZW0uIEl0IHNlZW0gaXQncyBzYWZlL2NvcnJlY3QgdG8gYWNj
ZXNzDQo+PiBhZGRyZXNzL21lbW9yeSBhY3Jvc3MgcGFnZXMgc3RhcnQgZnJvbSB0aGUgcmV0dXJu
IG9mIGttYXBfbG9jYV9wYWdlKHBhZ2UpLg0KPj4gSW4gb3RoZXIgd29yZHMsIDIpIGlzIGFscmVh
ZHkgbmF0aXZlIHN1cHBvcnRlZCwgcmlnaHQ/DQo+IA0KPiBZZXMuIFBsZWFzZSByZWFkIHRoZSBj
b21tZW50cyBmcm9tIEphc29uLCBMZW9uIGFuZCBCYXJ0LiBUaGV5IHNoYXJlZCBhIGxvdCBvZiBn
b29kIGFkdmljZS4gDQoNCkkgcmVhZCB0aGUgd2hvbGUgZGlzY3Vzc2lvbiBhZ2FpbiwgYnV0IEkg
YmVsaWV2ZWQgaSBzdGlsbCBtaXNzZWQgYSBsb3N0Lg0KDQoNCj4gRnJvbSB0aGVtLCB3ZSBjYW4g
a25vdyB0aGUgcm9vdCBjYXVzZSBhbmQgaG93IHRvIGZpeCB0aGlzIHByb2JsZW0uDQoNCkkgZG9u
J3QgdGhpbmsgaSBtaXN1bmRlcnN0b29kIHRoZSByb290IGNhdXNlOg0KUlhFIHNwbGl0cyBtZW1v
cnkgaW50byBQQUdFX1NJWkUgdW5pdHMgaW4gdGhlIHhhcnJheS4gQXMgYSByZXN1bHQsIHdoZW4g
d2UgZXh0cmFjdCBhbiBhZGRyZXNzIGZyb20gdGhlIHhhcnJheSwNCndlIHNob3VsZCBub3QgYWNj
ZXNzIGFkZHJlc3MgYmV5b25kIGEgUEFHRV9TSVpFIHdpbmRvdy4NCg0KSUlVQywgdGhlbiBob3cg
dG8gZml4IGl0Pw0KLSBJJ20gbm90IGdvaW5nIHRvICJyZW1vdmluZyBwYWdlX3NpemUgc2V0Iiwg
aXQncyBvdXQgb2YgdGhpcyBwYXRjaCBzY29wZS4NCiAgIEZlZWwgZnJlZSB0byBkbyB0aGUgY2xl
YW51cCBzZXBhcmF0ZWx5Lg0KLSBJJ20gbm90IGdvaW5nIHRvIGZpeCB0aGUgTlZNZS9ydHJzIGV0
YyBwcm9ibGVtcyBpbiB0aGlzIHBhdGNoIHNldCB3aGVuIDY0SyBwYWdlIGlzIGVuYWJsZWQuDQog
ICBCdXQgUlhFIHdpbGwgdGVsbCBpdHMgY2FsbGVycyBleHBsaWNpdGx5ICJSWEUgZG9uJ3QgZG9u
J3Qgc3VwcG9ydCBzdWNoIHBhZ2Vfc2l6ZSINCi0gSSBkaWRuJ3Qgc3RhdGUgUlhFIHN1cHBvcnRz
IFBBR0VfU0laRSBhbGlnbmVkIHBhZ2Vfc2l6ZSBNUiBiZWZvcmUgcmVmYWN0b3JpbmcgcnhlX21h
cF9tcl9zZygpLA0KICAgYmVjYXVzZSBJIHdvcnJ5IGFib3V0IGl0IHdhcyBub3QgY29ycmVjdCB0
byBhY2Nlc3MgYWRkcmVzcyBiZXlvbmQgdGhlIFBBR0VfU0laRSB3aW5kb3cuDQoNCldoYXQgSSBz
aG91bGQgZG8gbmV4dD8NCkp1c3Qgc3RhdGUgIlJYRSBzdXBwb3J0IFBBR0VfU0laRSBhbGlnbmVk
IE1SIiA/IFRoZW4gcGF0Y2hlcyBiZWNvbWUNClJETUEvcnhlOiBSRE1BL3J4ZTogZG9uJ3QgYWxs
b3cgcmVnaXN0ZXJpbmcgIVBBR0VfU0laRSBhbGlnbmVkIE1SDQpSRE1BL3J4ZTogc2V0IFJYRV9Q
QUdFX1NJWkVfQ0FQIHRvIHN0YXJ0aW5nIGZyb20gUEFHRV9TSVpFDQoNCk9yIGp1c3Qga2VlcCB3
ZSBoYXZlIGRvbmUgaW4gdGhlIFYxDQoNClRoYW5rcw0KDQoNCj4gDQo+IEdvb2QgTHVjay4NCj4g
DQo+IFpodSBZYW5qdW4NCj4gDQo+Pg0KPj4gSSBnZXQgdG90YWxseSBjb25mdXNlZCBub3cuDQo+
Pg0KPj4NCj4+DQo+Pj4gWmh1IFlhbmp1bg0KPj4+DQo+Pj4+DQo+Pj4+IFsxXSBodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvQ0FIajRjczlYUnFFMjVqeVZ3OXJqOVl1Z2ZmTG41K2Y9MXpuYUJF
bnUxdXNMT2NpRCtnQG1haWwuZ21haWwuY29tL1QvDQo+Pj4+DQo+Pj4+IExpIFpoaWppYW4gKDYp
Og0KPj4+PiDCoMKgwqAgUkRNQS9yeGU6IFJETUEvcnhlOiBkb24ndCBhbGxvdyByZWdpc3Rlcmlu
ZyAhUEFHRV9TSVpFIG1yDQo+Pj4+IMKgwqDCoCBSRE1BL3J4ZTogc2V0IFJYRV9QQUdFX1NJWkVf
Q0FQIHRvIFBBR0VfU0laRQ0KPj4+PiDCoMKgwqAgUkRNQS9yeGU6IHJlbW92ZSB1bnVzZWQgcnhl
X21yLnBhZ2Vfc2hpZnQNCj4+Pj4gwqDCoMKgIFJETUEvcnhlOiBVc2UgUEFHRV9TSVpFIGFuZCBQ
QUdFX1NISUZUIHRvIGV4dHJhY3QgYWRkcmVzcyBmcm9tDQo+Pj4+IMKgwqDCoMKgwqAgcGFnZV9s
aXN0DQo+Pj4+IMKgwqDCoCBSRE1BL3J4ZTogY2xlYW51cCByeGVfbXIue3BhZ2Vfc2l6ZSxwYWdl
X3NoaWZ0fQ0KPj4+PiDCoMKgwqAgUkRNQS9yeGU6IFN1cHBvcnQgUEFHRV9TSVpFIGFsaWduZWQg
TVINCj4+Pj4NCj4+Pj4gwqDCoCBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jwqDC
oMKgIHwgODAgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+Pj4+IMKgwqAgZHJpdmVycy9p
bmZpbmliYW5kL3N3L3J4ZS9yeGVfcGFyYW0uaCB8wqAgMiArLQ0KPj4+PiDCoMKgIGRyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmggfMKgIDkgLS0tDQo+Pj4+IMKgwqAgMyBmaWxl
cyBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspLCA0MyBkZWxldGlvbnMoLSkNCj4+Pj4NCj4g
