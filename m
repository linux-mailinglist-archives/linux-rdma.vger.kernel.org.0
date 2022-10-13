Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415315FD7CD
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Oct 2022 12:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiJMKcH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Oct 2022 06:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJMKcG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Oct 2022 06:32:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222F5EE88C
        for <linux-rdma@vger.kernel.org>; Thu, 13 Oct 2022 03:32:04 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DAJcgM025641;
        Thu, 13 Oct 2022 10:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=K0rBOHLLhyk2hRAeTcbvRwU2j4ELucduj0xm2VI2PkI=;
 b=X9JK7/05RX3vdopSttopL5d8FFbu8a/+89we5fxk6yLyAwnqFzBLRKEYJsW09ZJUsRgi
 5BM0QIhezTa3py4i7JzZi+V8mtuKToyWAQCZ7sA79IUssrgoRfc+LEliH1HzwB5TizNx
 nLSaoMfVmIqq+pEQZ4aRi/ibZ0gYUlLj5nnSgEVpt46u/jl2Wgvo2BexuXxEV/zeO7rY
 pz3mToh/+YM31x47LKLLwFyoOqlG7iI1WsbNX4yfkJwjVrztKQrqXq9FAwY0AnPiCfPa
 aMvLQxHW4DfCOoK4NnO4nvmB1VdEoZbN3Izwl/FpgV5xyJAQ4LXqs6/zZVwlUahtS+NI Ug== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k62bshndd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 10:31:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29DAB69S008559;
        Thu, 13 Oct 2022 10:31:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn5rnkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 10:31:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H61vxGhed6XVOjB0p8EX/n4Rgk+H1fpucJ85q0SEGZXspW5vnX0kEDzSDE6ZIc+mVnxfQkvmH9sCmu6wJ3nPaPEtGS2ywRRITJTIh9I8xqTH6eTXZSIHkfyVJbTkEAmAA56FWll1eryLEYje8vT/Po3e8ZjNkT5g4Jb4ZE9L4c5u3e3VWvnkMRbeaYQ60O003pfOAhbYwmiDDdYS+Qhh1PRJoel6QAt2RRM3+xxkaYDC57c16m2QM7viVQaCe8L666OUrw80F/h1yL7BW6n4PuUYhBSkWpSBbVk7JiAVjrOA1kUQpgsSKs+Z7zac08lB14TStk825Ihyme8+g4OHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0rBOHLLhyk2hRAeTcbvRwU2j4ELucduj0xm2VI2PkI=;
 b=QfCamDrtRtm9FhH6L6yVwKFgxPRycxovmmCSAKFPpW+lKizVX+0lyNNCi38RGce8KA8vW8PMa85xFQKegNU02RKRf1NdO6NMzgJrJu23WugMoy+qc0f+jJNqAkNLfOXZJ9/tSpTF/VIpcbbZYi3BeyBbw7f1IkL3ob3pGW1eHJIGURFpin2VPSCIRpnrOINIGYwvS8Q+lZyInE635gOOKa6A4CVcMgRvtcC9agZz7nu8/duS5EOHLW8dSM2FoTh3KwFqGJW6bPaI/pTNRjymG5VhJCbjokV7aIm8pP4t439SjjmekLspaDJcwWHkbL9yPBnPougd1BotWgaL5j7ZAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0rBOHLLhyk2hRAeTcbvRwU2j4ELucduj0xm2VI2PkI=;
 b=YVQdyyhMiAf5rpApKMd3KGkNPyqBcFdnxkQ4wD1V7KYQo9KIJhYM7YxEU6r8WplpO6gsLsr9/1Dt/Ua9LWokw3pDz7UoFpqdpghlgTZyRkYQtTUybY0I5zmxZlhexKkLlqDQgd2GjefIsOc/VQd7wk9US6zkeqp7wK5wIuVp2i4=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by SJ0PR10MB5565.namprd10.prod.outlook.com (2603:10b6:a03:3d2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Thu, 13 Oct
 2022 10:31:55 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::40b7:1489:ba7e:9cfa]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::40b7:1489:ba7e:9cfa%4]) with mapi id 15.20.5709.015; Thu, 13 Oct 2022
 10:31:55 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-rc] RDMA/cma: Use output interface for net_dev check
Thread-Topic: [PATCH rdma-rc] RDMA/cma: Use output interface for net_dev check
Thread-Index: AQHY3kVO6b9JFJSXn0+oma0N0ORZl64MA0AAgAAeOwA=
Date:   Thu, 13 Oct 2022 10:31:55 +0000
Message-ID: <6068AC23-108C-47B2-ACC2-8664040D4C8B@oracle.com>
References: <20221012141542.16925-1-haakon.bugge@oracle.com>
 <Y0fPvlrpapweqrdA@unreal>
In-Reply-To: <Y0fPvlrpapweqrdA@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5593:EE_|SJ0PR10MB5565:EE_
x-ms-office365-filtering-correlation-id: 96a3b5b4-4885-4ce3-4fa6-08daad06268a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QNLOx5LvtN6C3m4txdUYbnkBSNcj7LOyF90T0w58nfXh518NVa1aczwDaKOucHMGSfs8ygLSjOQV0G26+B+DBpyD842LpZfoY565WklXq65lULmNmSU0J625J6fJSwbaFY7EM2ZCoYZeVfoEtF36o4YubTWHgF3r4DQpCjN72DvTByqLcrhaMK3/QsvqcZOn+T32RHLJvRRaFF1mjCjUxGzoZEQxnqBng6twobDj39/V9nfByfobAmWtvH4Z1aUyXB8CO3QpgZGA9Kvq8JvMiT2OBdAFpKL/aNC3vJioj7uaD55IbZIijB1ha7FV/OemGfVqrkJdO3ziAw5a+b3+E8sF7Itogz4qYhcdc1z8tKgOERJpq5m/CCzLRonYhJUtWFrxa4YgWKrFVRNz/imTzOKmhkGYG9Kh6RCF9VxmIfTERghCa5OdVtLNzjGp62MFtMwuogsgWaYHuO31I9av/BRsug+CZ8ttFuTzSbIo8v7XWY9h8ZGPL0hrZoD1KYhzrEtnjVk0B+zH9YJUifE0CgxUVW35AU1rbJWJzGHxldkUa7j8x18s1TXroFD+2lymDgeIFtVDfXWuEnS66mll/QxUyuoAWH1U1Jj8h4+1Dj9wkZtW6+SwvQLvwl5gzxa29tQKQKaQ6J8vCP0twhz/WlBIOw9AVA2lBke1EsVRtzXmOPLrBO2yCa18Dm3IcNhyL9sjEX+qedLlRt56Nl71fJeM6jFjNEwFmYewpn/oBTkfJH+2PTPaWLCRBh/nGwEG76YfrRBPqNxiI01bE6ASrRGp73+/HPn7VJ5UJGc7eD0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199015)(66946007)(8676002)(64756008)(4326008)(76116006)(66446008)(66556008)(91956017)(83380400001)(66476007)(2906002)(86362001)(38100700002)(8936002)(36756003)(33656002)(6486002)(122000001)(5660300002)(41300700001)(44832011)(4744005)(66574015)(478600001)(2616005)(316002)(71200400001)(6512007)(53546011)(186003)(38070700005)(54906003)(6916009)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjJyRXNneVhsUS9nd0VTRGtUOW4rcHdGZUNaMmIzSWpqL2dwV1JWT1ZSUzNh?=
 =?utf-8?B?Nms2VDBWNlk5dmNlYXpzTnhZWW1ZbEpkeGxGNXZVS2VCenpHQjVQRFBoSFNR?=
 =?utf-8?B?aTJiREdSeEZPQnRVL3hxT3FJVUU4OTZVaFBDVi9ML0R0NVBFQTJ1S2QyOXRq?=
 =?utf-8?B?MEQwamhhYkcwb0wweG82M2UzUmdCRUVkaFpUbExIQkx0eUorV2xJVVM1a2FM?=
 =?utf-8?B?TnVjZVNqTDcwMmpzZnl4REs4cFU3UHI2MW9xaWR0ZEVNbmgrckh0MVl4UUta?=
 =?utf-8?B?dVMwL2c1VmhrbU1wTzNtNkZ1bjB0cWpCZjRQVC9EZkFiMisxL1lXS0xITG9z?=
 =?utf-8?B?V0lva3Q3cmNzYW1JV295VUk5T1k1L3ovQ0JNMi9pZlRjM1UwTmpHMHg5cGNz?=
 =?utf-8?B?cTh1bXhNR1VyU2dNelkwU1FRWGNlczdRdjZyQXdtdXRxTmRZdGlBclVLdU05?=
 =?utf-8?B?QlhlV1MvM21YRm5sT1JIc0IvY0pQNGY4WkVxZElyZVM3U3NaL3pQVEtPbDBi?=
 =?utf-8?B?Z0l4QlNyb1ZlcW1TUmtnVzJjYWZzMThCTjkxY3drVzc5a2NzK0RmTWJ0SnJO?=
 =?utf-8?B?RVlIVlE0MWgvMVhDdzlxbjV2L201WHB3Nklkb0dEektxMEdtbHUyU0RKTDVX?=
 =?utf-8?B?OHZRcHhoZ3V1OTIvSE1nNWJobDlkM2ZBNlByakRQZkpwQXdjcllrbjVXbEdT?=
 =?utf-8?B?UnpFQkppYS85amZSbkh0QWF0TXdzVlpBQmIrQ1gzRHFUcXJwZFFhcVUydHJB?=
 =?utf-8?B?UkMxN2JhcTEvcU52VEkyb0tFZ3grcTk1UmlxVVlsVUFqVm1wZENWM3h3bzBj?=
 =?utf-8?B?ZjhSK1JpN0d6c1lZUEdKTFkyUWxKeWx3QmZxUDVQeXpic1dPS1Z1RUR1bXhV?=
 =?utf-8?B?cE5YS2RBMWJEdWlyMjkzVkJQVFJQSlFzckxBd28wNW9NL3VxMVQweCtEbU5w?=
 =?utf-8?B?aHcwbWQxZ2lkN1NFN0txYksySkNJOVlDd012NG5JeGdGWW9TaEo4SGgvOVkw?=
 =?utf-8?B?WTFPQTdGbGhDM2lmdGNUVkYxTVBjYzBGUnlTcldVWGRSRjFyeERFY1BUYzlL?=
 =?utf-8?B?TXFjU2ZNblVaMEx0U2Q3ZGFFcEdHS1R5Z2MrM0lOanFDZnh3NE5UM3Vsb1ls?=
 =?utf-8?B?dnF2dWpSaG8rZzRPY1VNRVZiSDF6bGtWajZtWDhhRGFwaW9ENURyc0taTUZC?=
 =?utf-8?B?MFowS0xLOHp0elRaK2UzZnZOZE1GMkhXWXpHelQ4OFl3QjBVQTBoWmIyNzRG?=
 =?utf-8?B?OUl5YUVFNXVCYnQ3NWN5V0o3cTZyV3pkWktCRktLZi9LTkpKcGNocUs1N0M2?=
 =?utf-8?B?QXF0YW52SUFKS1BIRTl1QUFCZHVxemV0L0ZDekVRcGwxbktDOFdDcEJ5UEdi?=
 =?utf-8?B?R3hsWnNMbDFpVmxFY3NmM3ErbTVXckFKeE1UK2gwcFl2VTFZWHRhSS9icU1B?=
 =?utf-8?B?WG96Vk16ZU9xQ3F1QmhQNHVKSHlRWTJOVE56Q2V0SHExUXlSVHptcWo1WnBC?=
 =?utf-8?B?MHhFYmRJS1AwYnhWRG1STGZCOUpBWlpvL1REODI3REpiaGh3UkxkOGJuR1ow?=
 =?utf-8?B?SWtmQkQ3Z3pQWlhuN3lZMGkveTk0UHdIeUZldHZsRUpvNlZQRS9xeGh1ZnRH?=
 =?utf-8?B?SHRTMVd0dUpsZ3VDNXRmVlJ3ODZWRURGVDZJWFZzVUZ5T3RHUGZoTkE0c0li?=
 =?utf-8?B?RHN3RVhFVmRjWTEwLzgvdEE1UDIvYm9VTmt0ck10MFJ4ZERsUnM1UXZXbGN0?=
 =?utf-8?B?RzVORkZZK25PVFBsa0c5WVRiL3Y3OVVtSFdINE9yMXd6czVOZkpLdk5nYmpU?=
 =?utf-8?B?WTk1eVV3QUQ0WEdkQzExaWl3WnZ2TU5HM2toSC9YQkZQVjdHSU42M3h1dXJr?=
 =?utf-8?B?Ulg0SEVQTEM3NmlGYzFXcnp0U3ZQWVFOYnBFOCsrRlhCVmNONEVVQm1HNXdW?=
 =?utf-8?B?TGQ5MDd5U2ZXcngvNS9HRURCSUVlcjZXZzJ1cFVzejB1ekVDRjFLR1p1Qk50?=
 =?utf-8?B?YlJFVkNTTUxiUXd3eTJjOWtrTU92YUQxaWdZWW9Vem4zU1hpRG9PTURDQ3d2?=
 =?utf-8?B?eE9Ob1UyNTQ0R1hDZEord0RYOTljWmNMTk5ncXVDVXFad0RhQis5bkJJbXRj?=
 =?utf-8?B?dTB6ZlNSNW9lNi9velZaMmxrZ0M4aHVoc3VlNVJPRzZCMHRCYVo0blV6MVVU?=
 =?utf-8?B?eE5pRDNUYlphTlJid2M5ajNuUUxiVitnNTY2Q3JtM0VFUHNSSEdlUmxCdU1W?=
 =?utf-8?B?S1ZCSlk0WHNmVTFvaklYUWxaeW1nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <362D0F485536634DB5124EC442A38938@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a3b5b4-4885-4ce3-4fa6-08daad06268a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 10:31:55.3885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MsFQjU75ywUF/YxU+Ncssy9TidlR8HeBP7xmingL/W03Ults1QF/pt16ACYQpxKaMdxyRpdLvouRusKt0mN4kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5565
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_06,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210130062
X-Proofpoint-GUID: jXMgbrWPfSgYAohrMgEyZWfZKVsEu-OF
X-Proofpoint-ORIG-GUID: jXMgbrWPfSgYAohrMgEyZWfZKVsEu-OF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTMgT2N0IDIwMjIsIGF0IDEwOjQzLCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIE9jdCAxMiwgMjAyMiBhdCAwNDoxNTo0MlBN
ICswMjAwLCBIw6Vrb24gQnVnZ2Ugd3JvdGU6DQo+PiBDb21taXQgMjdjZmRlNzk1YTk2ICgiUkRN
QS9jbWE6IEZpeCBhcmd1bWVudHMgb3JkZXIgaW4gbmV0IGRldmljZQ0KPj4gdmFsaWRhdGlvbiIp
IHN3YXBwZWQgdGhlIHNyYyBhbmQgZHN0IGFkZHJlc3NlcyBpbiB0aGUgY2FsbCB0bw0KPj4gdmFs
aWRhdGVfbmV0X2RldigpLg0KPj4gDQo+PiBBcyBhIGNvbnNlcXVlbmNlLCB0aGUgdGVzdCBpbiB2
YWxpZGF0ZV9pcHY0X25ldF9kZXYoKSB0byBzZWUgaWYgdGhlDQo+PiBuZXRfZGV2IGlzIHRoZSBy
aWdodCBvbmUsIGlzIGluY29ycmVjdCBmb3IgcG9ydCAxIDwtPiAyIGNvbW11bmljYXRpb24NCj4+
IHdoZW4gdGhlIHBvcnRzIGFyZSBvbiB0aGUgc2FtZSBzdWItbmV0LiBUaGlzIGlzIGZpeGVkIGJ5
IGRlbm90aW5nIHRoZQ0KPj4gZmxvd2k0X29pZiBhcyB0aGUgZGV2aWNlIGluc3RlYWQgb2YgdGhl
IGluY29taW5nIG9uZS4NCj4+IA0KPj4gVGhlIGJ1ZyBoYXMgbm90IGJlZW4gb2JzZXJ2ZWQgdXNp
bmcgSVB2NiBhZGRyZXNzZXMuDQo+PiANCj4+IEZpeGVzOiAyN2NmZGU3OTVhOTYgKCJSRE1BL2Nt
YTogRml4IGFyZ3VtZW50cyBvcmRlciBpbiBuZXQgZGV2aWNlIHZhbGlkYXRpb24iKQ0KPj4gU2ln
bmVkLW9mZi1ieTogSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4NCj4+IC0t
LQ0KPj4gZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMgfCAyICstDQo+PiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+IA0KPiANCj4gVGhhbmtzLA0K
PiBSZXZpZXdlZC1ieTogTGVvbiBSb21hbm92c2t5IDxsZW9ucm9AbnZpZGlhLmNvbT4NCg0KVGhh
bmsgeW91IGZvciB5b3VyIHF1aWNrIHJldmlldyBMZW9uIQ0KDQoNCkjDpWtvbg0KDQoNCg==
