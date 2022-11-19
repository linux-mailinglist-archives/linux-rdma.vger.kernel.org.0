Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2396308D7
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Nov 2022 02:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbiKSBxl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 20:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbiKSBw4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 20:52:56 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Nov 2022 17:36:28 PST
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6881AC622E
        for <linux-rdma@vger.kernel.org>; Fri, 18 Nov 2022 17:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1668821789; x=1700357789;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=pfqVO0Tc9hXuTRhxkhDUwjc8aeopcQSV5tkKoKbpGZA=;
  b=O+E/8cgn2zI8apFxegW0MPoFL1ub0wr2HN5X6vzHYL40oPRdjYQa4oVJ
   uK6cHprd1O4yFbv5XN77aAIuqLS7eEi4Mv+/jztZLoIL86WLBcuq8cLWo
   f9ZY1GZy7WBDkdG9wm2nwzLYrctl913SBAstBBUXl5ZHSwMaMBJ0haBu1
   lEbnL7BBWQ0MhKNmNEY92z8S4fUgUZIb2+39pB3QivLke53gUYtKofkgg
   nuF0bXKE0t1zh528+jLIAseVKNdTDQG45wAtU/usHzx1phOEuHIep0euo
   c1/xV0quKPL5TqQtqTOehQrNj1Tb+v9QOzxBZ3MyGXvZDZpRL+3A3ob20
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="78681779"
X-IronPort-AV: E=Sophos;i="5.96,175,1665414000"; 
   d="scan'208";a="78681779"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2022 10:35:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URKTCR/pJtoKqLwJfYF/dsdKMI0QYnnUcK1CuLpoODk4dDcl7PlegIF+gOfXX/h2lQbOd6Mv9NsS9y/QDtAop1GAvqVP6WM2lL8LPu4k2L966G1ODZRBG38DLeEMwjVlVSnmBbChv1LfWMsIwpp2LuyOhn+LuTcRJBFmiDoB7O5BGco5dEE0Qdirck4TWAz9xLx1NNRTMC/Msqn+9Nsn9dDH2LhZ0P42B0hw2QhM90SEcvgGOUei3Plk03kkelCDIHTrfE3wNyGBJXFBV7vKS8M8fYos4v9SEZgTeSMDIt8ysVI9ADFkYBHllW3B3S7+xS/YIdOql2nYRZzxV0xr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfqVO0Tc9hXuTRhxkhDUwjc8aeopcQSV5tkKoKbpGZA=;
 b=YW6WcU2Ak5lSaUZKzDcoUB3gCem7wuGbafYC8lEcri54xr3uKfYgx2zbaohrWg01Kwovhz3q4mt43pob3PRYr6Af01Iiam+aw396FrjuVVoFI0NnrgHj5RpjU04ly8s5gPQAiFP0prulsUI52tWZaZ97/YIJUnJtNPJ85OWcAwQxiI4W3zeQvyp26jJO73NzNqt/zslE/CK4vK5lI1r78YJqU1yWZCjtMkiwKEUpjn4gAkDcH5tpDkvN79dvk4Y1JZsBmwP+hcX8LIo6WpO9sWTz2tqz/ZBQ3NnqRcVnl7FDWA8PIx6CJwlSFRYODcaoDMdwFkQqdrgD/5Iri1Fzog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TYWPR01MB8348.jpnprd01.prod.outlook.com
 (2603:1096:400:177::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Sat, 19 Nov
 2022 01:35:18 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9%9]) with mapi id 15.20.5834.009; Sat, 19 Nov 2022
 01:35:18 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "monis@mellanox.com" <monis@mellanox.com>
Subject: Re: [PATCH] RDMA/rxe: Fix double-free in __rxe_cleanup() when MR
 allocate failed
Thread-Topic: [PATCH] RDMA/rxe: Fix double-free in __rxe_cleanup() when MR
 allocate failed
Thread-Index: AQHY+zZ/+bY2xD0oyE6nUK7JmcmCLq5Fd+oA
Date:   Sat, 19 Nov 2022 01:35:18 +0000
Message-ID: <6e7dd04c-ee56-bbea-22fd-1a88f431bad2@fujitsu.com>
References: <20221118111826.3558230-1-zhangxiaoxu5@huawei.com>
In-Reply-To: <20221118111826.3558230-1-zhangxiaoxu5@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TYWPR01MB8348:EE_
x-ms-office365-filtering-correlation-id: fd20cc01-cda1-4113-d449-08dac9ce50bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mqFspZeqpKbOhtM5rMNklYRdf68g+VHRgMPiDkKqMvkGONHSlBxqMsaBkt/ArolKTbNM+SRQMwGf/2fPcW/Pn5jdhdgvt32HqMuq/m7mZLmdWBpJbfCrCfpSxZMcNK2D6Q4+xyws+98Bq/vWXZ0QVHFwdnCCwf2QIQKER/hDqV51yUXQYO5HDqkBgkdao1sY8zxn65/xUIe6vx+MowXWYU3ZuseVo4vgsZWQHp0u4zMF/BJc9abN9gjreZs40NAsnSqJI49IBc+XBfA2wIqkryZ7IUcBJJILlsUls98WaltssmMU/nsuwI5lP44jxAYY25KNoph0dhpweH+e6vdOVYUrkb1c7zlmi38b3rX6Notf30i5UgCq36CKrTYxwWF1Jt1y33abZNHOTw4ZWyMQfn3a7UJ3XJBhM9kWN+dXAjWq6DWZIe2dJQFZbPLsGqyLrNpooXQyMzfW4wjbYzY2IwZ6Zf6DEwLwGSdimr+RKCiIFiS0xSCU+xHMBm5kgDQ8t1+4TTncX6cZh+id/6n9s0VdJpHsh+wxEoOu/f9xhPMxAblyNoftH4NluJmZIhm/yZXnJuk8mD03NPV1NPF5SrirYQfO27olG+zmKcy35nD3OrrPcrqI/bCyphbI82pLg1OPYa0mOLkhyGzF1orHFo5jkDD4DuoPXl8htoY0N/jAmjDbTZLz9mobDwCV0fASWX/+bSW4kohQGDW28shq0X2yi59FEXBYy3m62iYa5Zzmr71QyrjqsKwvOLIyBLYPyZsLY2ZS9uh/KIW9tQG3d3EsT4N0pn5r4KLXpyCX/TfQYQpsdQ+xBmEPaMxygDXIuHYs6PxINuRE032EiBPDKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199015)(1590799012)(122000001)(31696002)(2616005)(66946007)(38100700002)(8936002)(2906002)(38070700005)(966005)(86362001)(186003)(66476007)(5660300002)(76116006)(66556008)(8676002)(26005)(82960400001)(6506007)(71200400001)(6512007)(53546011)(41300700001)(66446008)(91956017)(64756008)(6486002)(316002)(478600001)(1580799009)(110136005)(31686004)(85182001)(84970400001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2dXVXd4b1FMV0ErVy9jazVmdVUxcWJKb01pK3ExNUh1OFY5Z3IvYmtkc2lH?=
 =?utf-8?B?eDVtRlZ6SEVjNUNWR216LzhPV3FRZWhpMDNYbFZBKy81WHljYjNuc1BnbmJC?=
 =?utf-8?B?SWFiSGgxUExoRlhxM1RSTDNzZWdIZlROWUplOWNNUHVDZVBjU0JiZ0cwRXlH?=
 =?utf-8?B?dEhDTmc4SENYb001NmpmYkQvZWx5K2JZN3pFYk1vQlZJd2xiUW4wcVhmVk5E?=
 =?utf-8?B?TVFYMm50SjM4R1hBR0NUQW83a2ZzSUFzdzlWc0d4U0VPTTNhMUkySXk0Zkpm?=
 =?utf-8?B?OVJTcVFUQXYwSlZleXNLeURjekVjUTFkb2tuVUJ5LzNidU9NajRpeUFWM05H?=
 =?utf-8?B?WlB5YU1qWERSYUhiWWxTSlBYQkNRNWEwa3NuVjRwajJhaHlHZ2JGMS8yb1Zk?=
 =?utf-8?B?cmJWSlRQM1FKU0p4S0k3VkJwTkExK01FTG9jbUNZcHZPY2hKT1diSTdUZ0Ny?=
 =?utf-8?B?amZKa0lKRnhLY283aW5YYm1RaXZDYTkvR0I2NlpQT0ZHdm9mY09ESi9heStn?=
 =?utf-8?B?QTQrOVJmbEcyZGt1SmxhajFybHFUVVNtaitraHgwU3VrU2NZWm1qb1ZBOU85?=
 =?utf-8?B?Umx4MmZVMDJqQXRmUHpZcisvbTJXOWtobjRRaEVtNHgxNDJZeWdNZVo3WDVp?=
 =?utf-8?B?TnNhY05JUEVGa3preWU5aEhiR1hlWW9wZDZJbVJTekJIVkx1ek1lQVJrUFhI?=
 =?utf-8?B?MThBOWROUkN2ek55bTJuZDMwZHU5QkNpMVVmRE90blgzZmFySWpXV2Y3TzZ0?=
 =?utf-8?B?cXdMMmp4ajFqTUZsUjI4RnpaOGQyMEdjUWJZY0tGbkMxK25USlRJRllDRjlw?=
 =?utf-8?B?bmlRbWNoQ3pjbUZ3L0ZhYzdpdHRHbXhGTG9CTWpSUFZRZlBWc1JTdXZZYWNl?=
 =?utf-8?B?TXJCYkdrUThvRE94TVRwVnk0cUI2cUdiY0p4L21iZXVwaFlOdnE0OUZUdktr?=
 =?utf-8?B?TDVFNndVbWo2TVdhcU1PUXRleC9TZlJ0U2ludSs5T3FZTGZFN3cxME9idjBH?=
 =?utf-8?B?alBOYzFtQmhyWFJpdk5OYm9iUjdYNG1ueGdtWXF3WllZNW1sQU4rL21PSFhy?=
 =?utf-8?B?MGExaGIzYzB4cFlBYWhIbXhQZElkcU0vVXcyRUpTbEFDZThzNExZYzRMKzZE?=
 =?utf-8?B?S0tZUHdJbnJ0NHozblkvMHZRQWlQUHVhUnJKblpSdjJSNFVTcXFXMjVkSit0?=
 =?utf-8?B?L0VRU3JBUzJDZGMyMUZNejNSTC83Y2ZXek0rUFpXQVJzVlV1eFVabWU0NWdM?=
 =?utf-8?B?NGh1Rk53WVUvYnRXdWdZbzIvUG9aUmxsVGlpL1l3bmYvSDFRLzhETHF2M0Y0?=
 =?utf-8?B?aVl1NFVGUmpRay9HTTZPQ3ZDSnRzOXNYTEZnMC9lYmJ1N3JIQTRUNG81VlZi?=
 =?utf-8?B?TkpoL0JuSnA1amQzOGdSK0hDMzdmSzRlR1lUVWJNVHR4SEZrNWVSWnkzZlNj?=
 =?utf-8?B?NVlSUE1NMXRnTVBKcUdYdE5DNHVmK2Yvd1QyNnFKRHorYjgzMU9ucXc5U3Zw?=
 =?utf-8?B?ZzV1ZEE2SkROdkxMd2I3S2hreW5BSW9URENCNTFjRGI3VUl6amNkYk1jbWs2?=
 =?utf-8?B?dGZwQkduQjMvbWZRVUEwclBId2FzeE1CeHR1Q0tKVjk2QnFWSjJmd3BKUUxP?=
 =?utf-8?B?UUhqV1hzTG5Gbkt3N3lpbFlXaVFhOXo2Zit3anBZN3R0SmFOdGhhT0kxNEJ0?=
 =?utf-8?B?Unpud3dpWmk3MkM4M2huQmhlZVJvb1cwMkJEOUk3K0lySUNIWHNPRWZVcWlh?=
 =?utf-8?B?aG5NN2FhM05KamR3b1FPcEdpYzIyaTFmanRDM0ROTGRhMEsrSFBxRFgxOWx0?=
 =?utf-8?B?MTJWaDI0YW1nbWc1d2N5MlFBUFVUbXE2MW1Lb2lqNDRONEJ5RTl4WXZKN0h6?=
 =?utf-8?B?eSt1cmVRYSs0WU1JM1BFYVlKMzNyYmsxVDNkd1dxYWVxRVV5emJkbWlBa2ZZ?=
 =?utf-8?B?N3ZmMWZmM3c5am5BbUVxb0RrSDdGOUdkVzVvUDdkOWJCSFlsUGd6empEV2Fn?=
 =?utf-8?B?UmEyK2ZXSU9yN2VQVkhSVSs2N09obHlkSEdkb2NZZldwT0dEakl0K01DcG0x?=
 =?utf-8?B?UUw2N3JOVnJyUkpSRU9qaWh0YTZjaTNMMndRNDlzRUwwQzg5dllYaHVnRHlD?=
 =?utf-8?B?eWJ3UG11bDA0K2cva3BtZFZrVDFqLzRJa3NyNmtwdUlTTy9JTUVkMHFPS2Ji?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38E7DC9CBB547B4CB14290EF8E8A63AC@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hORxE+PdkVF9XwP5u7odJalCTeDT0jrf28iXyJhCn022HPx6a9S+wjRZP1b4Peb67aqB8+/p/YSAPSJD1TNy36OxrilftOdnDr8G09zJisQVQLvf1i5r1t6wmh5m6PhVt9WyzZnmOrkqMfB5yfS/p3gAsz+bMMCxACYlRgHQPc/9EWYkXxz46R5naLG1bI8oJMLDkt9e91fGcaoeiDCzO4V1jEMhyv1EtCG5CokuutTRl73H5OSpUPf+vz0LZNQEoZQbxzR2EC5yh2H1Ya9rfAyKR5GXyPZSALeQkiK0cqVBQrhFf5cVKVLOTtIHlxkDBVN1TYdmNy84ZOezBUDpdDJFnnTvnN0yRev6RHWT5BeGiQI9aeLJ/c/ZiGmzJ3kZCk5RkcHJZaFZ3I+UiqJ5dgr1fUG8DTRgn6oujiLLnJKBLX0psIbnNI/iW2U8XxhrBHOzvVJn61HZqpOKdZ6aarWGBB/eoVjXQQZ5QThLx+lA7xn5zR+v1rd7Ld6tTR16FLbZhAL4fTE4rjHhtiNWab3wryqiHwHd+AzBirjpxnVL4t1s7MmNAFWr8eZ+bQ0qA6PxHT0DbDeYYUMDqwxnveEyFNHtEWCnO5yBeXT8TnJPglBHVmGFeD3RUWgQy/JE56XlXa82H8IzN2eQVQuLiMB76IXRnj8x8MJEuRjDsPH7KaSRHXzKB7OBu53Gf/XBNBMurwGiVrv2FiYd5LYeZPtWmeH0L3yXmJhoRHEW/+WgbgszGviWDIWwfuZ9X2FDEHYDZCiVrSokqzZUryHGEJdB6wqsuG5re8jVvmQmRONubLgMMX302AMASNI6mH2jdDfZpPdfAiQRwuvRhuT+eHz++k48CAUKBAzXwDMhvPXJBRT8nzM/ogHHOkJ7dl5pt6BoIihCEmBeVi5oh4wZGeVbWmBt0h80f2Hjvp3GArs=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd20cc01-cda1-4113-d449-08dac9ce50bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2022 01:35:18.1084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZ7xWmcsNBFQReZjegXwO98hLK8FM4KkMa/9NTxBsTEiPvnwrnfCjEn6jGxCrLazPH41YLaN2y2jW0Eyp3+FJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8348
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

WGlhb3h1DQoNCnRoYW5rcyBmb3IgdGhpcyBmaXgsIGl0J3MgZHVwbGljYXRlZCB3aXRoDQpodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sLzZhM2JhNjJlLTYxMTYtN2YwOS1iMzE0LWQ2ODIzNjcx
YWFhOUBmdWppdHN1LmNvbS9ULw0KDQpUaGFua3MNClpoaWppYW4NCg0KDQpPbiAxOC8xMS8yMDIy
IDE5OjE4LCBaaGFuZyBYaWFveHUgd3JvdGU6DQo+IFRoZXJlIGlzIGEgZG91YmxlIGZyZWUgd2hl
biBtb3VudC5jaWZzIG92ZXIgcmRtYSB3aXRoIE1SIGFsbG9jYXRlIGZhaWxlZDoNCj4gDQo+ICAg
IEJVRzogS0FTQU46IGRvdWJsZS1mcmVlIGluIF9fcnhlX2NsZWFudXArMHgxMDEvMHgxZDAgW3Jk
bWFfcnhlXQ0KPiAgICBGcmVlIG9mIGFkZHIgZmZmZjg4ODE3ZjhmMGEyMCBieSB0YXNrIG1vdW50
LmNpZnMvMjgyMDFDUFU6IDEgUElEOiAyODIwMSBDb21tOiBtb3VudC5jaWZzIE5vdCB0YWludGVk
IDYuMS4wLXJjNSsgIzg0DQo+ICAgIEhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKGk0
NDBGWCArIFBJSVgsIDE5OTYpLCBCSU9TIDEuMTQuMC0xLmZjMzMgMDQvMDEvMjAxNA0KPiAgICBD
YWxsIFRyYWNlOg0KPiAgICAgZHVtcF9zdGFja19sdmwrMHgzNC8weDQ0DQo+ICAgICBwcmludF9y
ZXBvcnQrMHgxNzEvMHg0NzINCj4gICAgIGthc2FuX3JlcG9ydF9pbnZhbGlkX2ZyZWUrMHg4NC8w
eGYwDQo+ICAgICBfX19fa2FzYW5fc2xhYl9mcmVlKzB4MTY2LzB4MWIwDQo+ICAgICBfX2ttZW1f
Y2FjaGVfZnJlZSsweGM4LzB4MzMwDQo+ICAgICBfX3J4ZV9jbGVhbnVwKzB4MTAxLzB4MWQwIFty
ZG1hX3J4ZV0NCj4gICAgIHJ4ZV9hbGxvY19tcisweDg4LzB4OTAgW3JkbWFfcnhlXQ0KPiAgICAg
aWJfYWxsb2NfbXIrMHg1YS8weDFkMA0KPiAgICAgX3NtYmRfZ2V0X2Nvbm5lY3Rpb24rMHgxYzBm
LzB4MjFhMA0KPiAgICAgc21iZF9nZXRfY29ubmVjdGlvbisweDIxLzB4NDANCj4gICAgIGNpZnNf
Z2V0X3RjcF9zZXNzaW9uKzB4OGVmLzB4ZGEwDQo+ICAgICBtb3VudF9nZXRfY29ubnMrMHg2MC8w
eDc1MA0KPiAgICAgY2lmc19tb3VudCsweDEwMy8weGQwMA0KPiAgICAgY2lmc19zbWIzX2RvX21v
dW50KzB4MWRkLzB4Y2IwDQo+ICAgICBzbWIzX2dldF90cmVlKzB4MWQ1LzB4MzAwDQo+ICAgICB2
ZnNfZ2V0X3RyZWUrMHg0MS8weGYwDQo+ICAgICBwYXRoX21vdW50KzB4OWIzLzB4ZGQwDQo+ICAg
ICBfX3g2NF9zeXNfbW91bnQrMHgxOTAvMHgxZDANCj4gICAgIGRvX3N5c2NhbGxfNjQrMHgzNS8w
eDgwDQo+ICAgICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0Ni8weGIwDQo+IA0K
PiAgICBBbGxvY2F0ZWQgYnkgdGFzayAyODIwMToNCj4gICAgIGthc2FuX3NhdmVfc3RhY2srMHgx
ZS8weDQwDQo+ICAgICBrYXNhbl9zZXRfdHJhY2srMHgyMS8weDMwDQo+ICAgICBfX2thc2FuX2tt
YWxsb2MrMHg3YS8weDkwDQo+ICAgICBfX2ttYWxsb2MrMHg1Zi8weDE1MA0KPiAgICAgcnhlX21y
X2FsbG9jKzB4NWQvMHgyNDAgW3JkbWFfcnhlXQ0KPiAgICAgcnhlX21yX2luaXRfZmFzdCsweGZk
LzB4MTgwIFtyZG1hX3J4ZV0NCj4gICAgIHJ4ZV9hbGxvY19tcisweDY0LzB4OTAgW3JkbWFfcnhl
XQ0KPiAgICAgaWJfYWxsb2NfbXIrMHg1YS8weDFkMA0KPiAgICAgX3NtYmRfZ2V0X2Nvbm5lY3Rp
b24rMHgxYzBmLzB4MjFhMA0KPiAgICAgc21iZF9nZXRfY29ubmVjdGlvbisweDIxLzB4NDANCj4g
ICAgIGNpZnNfZ2V0X3RjcF9zZXNzaW9uKzB4OGVmLzB4ZGEwDQo+ICAgICBtb3VudF9nZXRfY29u
bnMrMHg2MC8weDc1MA0KPiAgICAgY2lmc19tb3VudCsweDEwMy8weGQwMA0KPiAgICAgY2lmc19z
bWIzX2RvX21vdW50KzB4MWRkLzB4Y2IwDQo+ICAgICBzbWIzX2dldF90cmVlKzB4MWQ1LzB4MzAw
DQo+ICAgICB2ZnNfZ2V0X3RyZWUrMHg0MS8weGYwDQo+ICAgICBwYXRoX21vdW50KzB4OWIzLzB4
ZGQwDQo+ICAgICBfX3g2NF9zeXNfbW91bnQrMHgxOTAvMHgxZDANCj4gICAgIGRvX3N5c2NhbGxf
NjQrMHgzNS8weDgwDQo+ICAgICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0Ni8w
eGIwDQo+IA0KPiAgICBGcmVlZCBieSB0YXNrIDI4MjAxOg0KPiAgICAga2FzYW5fc2F2ZV9zdGFj
aysweDFlLzB4NDANCj4gICAgIGthc2FuX3NldF90cmFjaysweDIxLzB4MzANCj4gICAgIGthc2Fu
X3NhdmVfZnJlZV9pbmZvKzB4MmEvMHg0MA0KPiAgICAgX19fX2thc2FuX3NsYWJfZnJlZSsweDE0
My8weDFiMA0KPiAgICAgX19rbWVtX2NhY2hlX2ZyZWUrMHhjOC8weDMzMA0KPiAgICAgcnhlX21y
X2FsbG9jKzB4MTZkLzB4MjQwIFtyZG1hX3J4ZV0NCj4gICAgIHJ4ZV9tcl9pbml0X2Zhc3QrMHhm
ZC8weDE4MCBbcmRtYV9yeGVdDQo+ICAgICByeGVfYWxsb2NfbXIrMHg2NC8weDkwIFtyZG1hX3J4
ZV0NCj4gICAgIGliX2FsbG9jX21yKzB4NWEvMHgxZDANCj4gICAgIF9zbWJkX2dldF9jb25uZWN0
aW9uKzB4MWMwZi8weDIxYTANCj4gICAgIHNtYmRfZ2V0X2Nvbm5lY3Rpb24rMHgyMS8weDQwDQo+
ICAgICBjaWZzX2dldF90Y3Bfc2Vzc2lvbisweDhlZi8weGRhMA0KPiAgICAgbW91bnRfZ2V0X2Nv
bm5zKzB4NjAvMHg3NTANCj4gICAgIGNpZnNfbW91bnQrMHgxMDMvMHhkMDANCj4gICAgIGNpZnNf
c21iM19kb19tb3VudCsweDFkZC8weGNiMA0KPiAgICAgc21iM19nZXRfdHJlZSsweDFkNS8weDMw
MA0KPiAgICAgdmZzX2dldF90cmVlKzB4NDEvMHhmMA0KPiAgICAgcGF0aF9tb3VudCsweDliMy8w
eGRkMA0KPiAgICAgX194NjRfc3lzX21vdW50KzB4MTkwLzB4MWQwDQo+ICAgICBkb19zeXNjYWxs
XzY0KzB4MzUvMHg4MA0KPiAgICAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDYv
MHhiMA0KPiANCj4gV2hlbiBhbGxvY2F0ZSBNUiBmYWlsZWQsIHRoZSBNUnMgYW5kIHRoZSBhcnJh
eSBhbHJlYWR5IGZyZWVkLA0KPiBidXQgaW4gdGhlIGNsZWFudXAgcHJvY2VzcywgZnJlZSB0aGVt
IGFnYWluLg0KPiANCj4gTGV0J3Mgc2V0IHRoZSBNUnMgYXJyYXkgdG8gTlVMTCB3aGVuIE1ScyBh
bGxvY2F0ZSBmYWlsZWQgdG8NCj4gYXZvaWQgY2xlYW51cCBwcm9jZXNzIGZyZWUgdGhlbSBhZ2Fp
bi4NCj4gDQo+IEZpeGVzOiA4NzAwZTNlN2M0ODUgKCJTb2Z0IFJvQ0UgZHJpdmVyIikNCj4gU2ln
bmVkLW9mZi1ieTogWmhhbmcgWGlhb3h1IDx6aGFuZ3hpYW94dTVAaHVhd2VpLmNvbT4NCj4gLS0t
DQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYyB8IDEgKw0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5m
aW5pYmFuZC9zdy9yeGUvcnhlX21yLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9t
ci5jDQo+IGluZGV4IDUwMmU5YWRhOTliMy4uODJkZDE0NjU0Njg2IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX21yLmMNCj4gQEAgLTk5LDYgKzk5LDcgQEAgc3RhdGljIGludCByeGVf
bXJfYWxsb2Moc3RydWN0IHJ4ZV9tciAqbXIsIGludCBudW1fYnVmKQ0KPiAgIAkJa2ZyZWUobXIt
Pm1hcFtpXSk7DQo+ICAgDQo+ICAgCWtmcmVlKG1yLT5tYXApOw0KPiArCW1yLT5tYXAgPSBOVUxM
Ow0KPiAgIGVycjE6DQo+ICAgCXJldHVybiAtRU5PTUVNOw0KPiAgIH0=
