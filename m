Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAE05A40B5
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 03:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiH2BgW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Aug 2022 21:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiH2BgV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Aug 2022 21:36:21 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152B02DAAF;
        Sun, 28 Aug 2022 18:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1661736980; x=1693272980;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J4RQCuWPV9WDXIQumOaE9HJByO3PhTR2ifhpAZjeTes=;
  b=QCrTAW79QFUJ+3ROKWWqNOKP+LGTuxhqgtkUFUMlGDeDjGr28JnFETcm
   9cThwUbhelfqiQiZ8A9vHfYDvsZYuWzeq9PpeRqmO28ZLnCiHGZWWiZ8t
   X7X3n0KqkJ2nQCdQu/gROxGO0nQqY+0stM/AYoaArviQnhOX7YVaA60N/
   jhVS1dL2mbBQTA4cQfbUPr1qxt9rLtS899Eb8SZ0KaR5DimY1UJ3e14bO
   u7YGCZYGJKlXbXFJVWSZG5qj4DFOzP6QDM7Xt23UCu+AnrF2n7unjvu87
   dtIvaiSD2wxcULhx+Vt+c7BEuHBe71gRPANOFvIVRoPhTLne25NiXCk2k
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="63815672"
X-IronPort-AV: E=Sophos;i="5.93,271,1654527600"; 
   d="scan'208";a="63815672"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 10:36:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvLDNOg3TKiM0fQGk5X7AbUagQGAZA06bkxJuHFN4L2UuJzqGfawLqT/AyCiKcmjiXlC61zbVPNb7DsvZCd8hdeBEN0VWelndtZ+bq6u2eyYLk+zctmJnRk2f/+JhijerXp1YMIv7feN2DwGCsEP7DqM3bRBIgJamrQrrtmUY8Gqy9FD644SKIJiKRMumdvrEdYcABp7uIa5yh1uQsC7vQWjJsp51+hNZ6ULg2zMlu5f9SFBiWOjVIXgsGCvspuerzEegFn/aWi+7Rhy+tiMHG/sXJlG5bbX1RAOCvPdHpT77UN36jMQqea8jyCq5EXBdlxutXh83459ZYP5gj4qLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4RQCuWPV9WDXIQumOaE9HJByO3PhTR2ifhpAZjeTes=;
 b=TfKRNme70UcejqOiPEbYRQiXRKbeNGm90RlRT8FgaWioB4+BPBe03teBe+OmuziKKI6d42+tH9xOnjal106Trc7NpbKUn954MamG/7qPF6PzjqApEpnsDfIHrhl/oWNRm6PB+8sO5WIOR779kY5lQXAghT+uN4Ngdsd1/0mgaOKRvtUOC5cjzQrOIGuc3VLBqXNttzLFCAKSkXWF3g59W6n2TAU9ICi70Vy/8Hm/pNR4Y7Ry+0tSmz1tgyGc/jXdyZ2AsGswbpdnsqKvvcuR7cqA5EPi2X8OYKP7mxYTYSupPURZzFypfzdoPuyHTox2VTy20MRbrjFwHFvMxDDuAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OSBPR01MB1736.jpnprd01.prod.outlook.com (2603:1096:603:7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 01:36:10 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::9d81:6e2:6f1:e08e]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::9d81:6e2:6f1:e08e%8]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 01:36:10 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
CC:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wenpeng Liang <liangwenpeng@huawei.com>
Subject: Re: [PATCH v4 0/6] RDMA/rxe: Add RDMA FLUSH operation
Thread-Topic: [PATCH v4 0/6] RDMA/rxe: Add RDMA FLUSH operation
Thread-Index: AQHYqJ6RXCLE07oY+UeunYbJo1eZUK3BUNqAgAPtQIA=
Date:   Mon, 29 Aug 2022 01:36:10 +0000
Message-ID: <78a9b911-a762-ad1c-8b6d-ee0a9e124a05@fujitsu.com>
References: <1659685579-2-1-git-send-email-lizhijian@fujitsu.com>
 <YwjMs4wKm7CHzTuf@ziepe.ca>
In-Reply-To: <YwjMs4wKm7CHzTuf@ziepe.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57fe98fa-05e7-4fd1-034e-08da895eda42
x-ms-traffictypediagnostic: OSBPR01MB1736:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b/JddLesZ1HQBYj6lYwiE4BDEFXO9dhLG/7bJGOZwDhOGAjCB1+sjV2OHFNzZjuxftRHx0eUrTuToFBic74yGmb7ha/ydUVCOL17V9ib6und76f+oS00MQEMm2G3ZXkSVbU7Ae6yX1uL9WbJnaD+uz4jJ+q8b3AkgkFhnQFoRVExZVdjEBKtdTCXdtqINM9osNa8bRatudMtoOnFyqdzGlxqCrIVXNIjdzHvfNY396uI1jGp1JtectjPmgkd5l1rLENmPqfT5sSzH62qq9zT0xKTfUNV7bVIsUvyqb5Ya4VnIRjdf37oHyNQ3atsWUUWg8nZB8uttECnHo6rpB3qOXF3MP8hA/Ie3BYAK8PYTWDV4+HKa6z0/6xyEOgNCcsMXhzBtJD9gFVvZuc21Um1DnUACAZi9ukrWeg8Zujr/pbtV6K60rbsILrQrcnr1lhnqMm6uJ3EaSlNRlQPdupf28ZpS9yOrwxCztCNkcz/tyhGFU1mBoaEHjxCkOVLZNeGRnYxR640zq+PPNpb6kMxNV3jH33qBZfe8O0l+S01pezS/DCRxKPcbR9b9jVAeUNVm3dczqIRPPsP7bwTiG0n9p2otNqosoDftUAl5kA9LoM+MsH5wOpDeYoBM5AleY8/+mYplKOeCT+l8WFR1c2ovdCU7FadfEE1r6XH5Ve1fJMloz0J/8il+H0TH3O4BAF9x7kaauiKsdfICkhqCszNFn7Kd/+7bMpmdY3zCNricfCd797ko6prbJP/xrsajqrhHzdgDL4Q80YLhSg40vYRzM9vbtR+cj7Mv9PsvP5HBJiIJN02F0KRlLlFpxPubql793T+m7Kk5/hNkBjyJWqxHV55uv0YLnuEUMoL8BUZ67sYtARgbkkK5QsgtXkCLmeU3SL6UpxXvKt81wyupJ3OtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(1590799006)(122000001)(38070700005)(82960400001)(86362001)(31696002)(38100700002)(54906003)(966005)(76116006)(4326008)(8676002)(64756008)(66946007)(66446008)(66476007)(66556008)(478600001)(7416002)(41300700001)(5660300002)(8936002)(6486002)(110136005)(316002)(71200400001)(6636002)(186003)(2616005)(91956017)(4744005)(6512007)(6506007)(2906002)(26005)(53546011)(85182001)(31686004)(1580799003)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHR0QXR2Tmo5Z3g0dDJVdnRyUWZjYy9vMHNjODF2SGhoemJpblBUenV1RG9J?=
 =?utf-8?B?VUNIOUgvVVo0c1VhTkdTMXBJK2VEa1RJdWU0T3MvbEdYTFhxZCtnV1NPNm9r?=
 =?utf-8?B?ZXdzQ1FSMDZ2TTVOaXJETnBCSG5jZFNyOWF4T21ObzBzVGwvdzlCckdxRm9z?=
 =?utf-8?B?Y3VBTGh3eldUV2ZrU25BclB3VkpvVDNPNDZXQmlacG0xczc3Zk9aZms0cndu?=
 =?utf-8?B?d1dYNyttbjdwY0JtQ1hqVFJmcDhPZUlpMG14L0VaVk42TzF6dmdJYjZieGNV?=
 =?utf-8?B?eHd1RkVYS1p2NXV1WDE4N051M3NFQXFIUUZQYWRMNmZWUnhiWiszVjdIVll1?=
 =?utf-8?B?RHdpc2hjMFRqK3VKZWhyT01JS2EzWFVOR2ZlZW9rTkRpRmg3V3ZzbFc0d1hI?=
 =?utf-8?B?TWVnOEZSa0RvcThjQkQyV3hVbE1qM1lKT3BVN1JmOVlqWFhsY0x5WmZmUGM4?=
 =?utf-8?B?TnQ1YUFMTjZtaFBTWk95dWpKZit0R3hRNlp3QW1HS3g3djkzeG1lNCtZVTlz?=
 =?utf-8?B?TnFidlUvQU1uU1pSQXVBa0Zmd2tiQ2VydnFROTA3amZKdnI4S2lrTWdBVlpm?=
 =?utf-8?B?N1A4MUxIZGJaa2RvbU9adUZkaXZPSnlXV0ZicVRSNkNsZENObzdtN0Y2QnVF?=
 =?utf-8?B?VUt1MVpJM0g4V0E5QVp6STNZVENvYzMveURYaGQrc1VUNnZmUngvVTlZUXRk?=
 =?utf-8?B?YTNuZlVIMHhHdHlCL0dXUTNnMFcxaVlXNnpaSUxkK3NGODR2Tm8zUnUvdzZK?=
 =?utf-8?B?K1MvbGkxYjBJaXQ0M1k4VUpnNjEzZk9zK0NiNmZ5Z1MwQW44amEraFZhbUJP?=
 =?utf-8?B?UFNrL2ZYbVh4V2xwTkFTM2JjY2FDb2pIQ2RVMHE3OHhJYzNnZ24wSGlvWnlN?=
 =?utf-8?B?SHZBRzJaYUtIYU1lRkxnOVpFMjBOcjFId0gzYUQwVDF3UkdKZXViU1pobnJk?=
 =?utf-8?B?S1ZRcHFSbVlmSXordHZsYXdSZm0rSlRtMk56TUh3dVQrRGdOSFAva0VzL2pO?=
 =?utf-8?B?SFNtM2ZIc2hmWmRZN2FCZlV3SVFzVm4rRFNmSXlMQ05paW9qZTRMUm9pQTZU?=
 =?utf-8?B?SDduczZkVXpFSVpSb3kwVFhycVBhdncwTGlldFV1RUdlMDI0SGx6RkUxZ24y?=
 =?utf-8?B?WW9rQ1loUWRoSlBZMFp1eTVhQ2M0SjNGaTVRZHVFLzFHV1l0clYveXJTMjZj?=
 =?utf-8?B?QUhzNWpHK3J4Vmt6WFZlNmlxOS9yQk5GQWhGdlI4eDVsaXdHM1BZdUhjQWhy?=
 =?utf-8?B?ZDRJbnRRamVCQ3I2Y2RNSURlY2FHVVAyZi8rRlVmZFVaRE01ZzZEM1FKbEZ3?=
 =?utf-8?B?M1JaTlFnUDFEcXc1N1U5ZnFsL0ZjcFVML0IzSXljQ2lYQTR5RzFsSERWUzBK?=
 =?utf-8?B?M0FTTTdOdlQ2eFNWQks4Y2I2THNFclJoaUQzRzRaTnBCN2pSOGIvMFAwTkpx?=
 =?utf-8?B?cWNkUlFhUUNUR3g3M3pQSHAvSWFZM3B5NXRWY2tXU1JHTHRzWHdSVFo2WjRh?=
 =?utf-8?B?VExqZlpxb1kzV2FSS05LTk9JYXd4M0k2SEtabUVjNnFhS3hhNmxTZkRZQlpm?=
 =?utf-8?B?SmtZU2F6Zjl0cVBqdHI4NFg4VzVyN2FFMEIrNWJmSStPcHI1MDY2VXE0bDls?=
 =?utf-8?B?cFhHSWZUTVNGWGxvQ3Q2K2tPUmhtY3ZDaGtiU1NXZVRCS0lEU1JwaDVSU1po?=
 =?utf-8?B?TlkzZU5BRHIzK0oxNHF6dktpT25oOEdrNHBzcUlqVXFNaTJYa3QvYS9RdnFY?=
 =?utf-8?B?YnlacW8yeWFEV1VaODVtVUdIdFhSMGZ4ZlJyWG5McHI1TWM2Y1h3dWRkbUdZ?=
 =?utf-8?B?K1k1aFJZK0R4T0dmdmV2cWRrdnh2cHIrck1LN3lYMHZzTU56aHdjWURJUDQv?=
 =?utf-8?B?cVd6a1lMTmNDbGFldHN5bWJ2MzB3VHNEZjF1ckgvUFdSb3pySXZ1VDI5OWov?=
 =?utf-8?B?dEtNREhPeUdmdnp2Q01RU0dFMXl5OFpBM0NmZXNUbnhnK09OT3hwL0xZUjYw?=
 =?utf-8?B?dy95cW9oc3ZVWkM3M3RVUzl2Q2I3cmMvNEVsdHBxOE45aE9KdFpFSUQ4cktZ?=
 =?utf-8?B?Wk1nbDk1WXF4QWcwd1MrNHVNMGxmNHd1QUtZYnpmVHpvQXcwV1BYWkJQd29O?=
 =?utf-8?B?UVVCZVg4bnBKcEUzMktudzV5UDlXZW5JbmxGSVcvTEtwUklERHA1cm4rSEF1?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A9248828C880245BB369FA6C6425EED@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fe98fa-05e7-4fd1-034e-08da895eda42
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 01:36:10.7724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /D9/hRVmAqXoBHS5eohR9L9ZGf2NZt+ABrOLKpPANLhcd2GSRjU7tpnzw6gBlW7cMvf2v48VauHRpKbcuQbUmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1736
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi84LzI2IDIxOjM3LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IEkgdGhpbmsgZW5v
dWdoIHdvcmsgaXMgZG9uZSB0byBzdGFydCBnb2luZyBmb3J3YXJkIHdpdGggbmV3IGZlYXR1cmVz
DQpIaSwNCg0KR29vZCBuZXdzLiBJIGhvcGUgd2UgY2FuIHN0YXJ0IHJldmlld2luZyB0aGUgUkRN
QSBGbHVzaCBhbmQgQXRvbWljIFdyaXRlIA0Kb3BlcmF0aW9ucy4gXl9eDQoNCkJUVywgdGhlIHY1
IG9mIEF0b21pYyBXcml0ZSBoYXMgYmVlbiBzZW50IG9uIDIwMjItMDctMDg6DQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1yZG1hLzIwMjIwNzA4MDQwMjI4LjY3MDMtMi15YW5neC5qeUBm
dWppdHN1LmNvbS8NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXJkbWEvMjAyMjA3MDgw
NDAyMjguNjcwMy0zLXlhbmd4Lmp5QGZ1aml0c3UuY29tLw0KDQpCZXN0IFJlZ2FyZHMsDQpYaWFv
IFlhbmc=
