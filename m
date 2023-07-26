Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA28762AC5
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jul 2023 07:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjGZF0n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jul 2023 01:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGZF0l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jul 2023 01:26:41 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020014.outbound.protection.outlook.com [52.101.61.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B2C212D;
        Tue, 25 Jul 2023 22:26:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYG2EG1GHXhfu3ZOaqF36sixQQ+oDPh47KTsITVmacoVPJnIDoB3/RUPkg/6UZHCbq2RyXUyuQ+mCL+20BpRaogUpg40Sp9GbGL4Onnl7YURZ5GDQs/mAL9RM4aUOrYvC99dHSPfUJzFJqrIFmB3nPqsdcRPPOE5puPg1ut78RUKXyzOPmysewgqhTifuUUPi7c1AsErGIof3kONoRBCxb10qotA0fTeAoh6cMTcLyerWOEHM2cImp/D8D3Qufgv2q4aDTLinvXox1IPEoxmKUVFZhnwo3LSZXUQelB9xV3VCrjeooOdtdNnWYvF2GM+DuWL7nYFbgBHMLvqnbn50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNittJLQhpGqdDRc+PAIwr1JOjZWdGS7jtYYVQY7W68=;
 b=YH/aNaaz5jfBu1iGxgtDAeQ8PIddn9jJTy3cjtlKR3oCO3BESsy93NsN/95fA73zGzNg8xZWemPWOd9V+grqW/c0McuRYgZYdo9yw0iqm1tLaohbwfndFzoxPOCXLR8TiLh191t4Yha8R1THgbj/bYhEDnda08rIVNysEtdK985629+WPzd4enqAjvCgq4D5xF+1MSewdystCdCC+jOwHd+IvSPb12aN+4Putu4BP9q6OVGUNMxRnlmvTx+3HS6tugIjZjiLMm294LNhIB6XzjJ/LbcRsq87oA2d6uDbBG12rViHC1XGgdqDPdPF74pxR2S5dX1xceSJBgWCBHZ53A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNittJLQhpGqdDRc+PAIwr1JOjZWdGS7jtYYVQY7W68=;
 b=WtzILiRB3Ccox4yFrxXyUVLyb86ticZioXU3EsgQFW3HkHE4maRbCRztKY7KPreWE/j1Si3CrNvF8qJ/rXWuqcAYSevX+lEys3vo7ao5BMBQucpRuFmvJBlwvcJf/kFek9WrqJfiJLl0Ocv+AX6OpJKE1vLF9+N9GNe6RO4pIww=
Received: from BY5PR21MB1394.namprd21.prod.outlook.com (2603:10b6:a03:21c::20)
 by PH0PR21MB2006.namprd21.prod.outlook.com (2603:10b6:510:48::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3; Wed, 26 Jul
 2023 05:26:37 +0000
Received: from BY5PR21MB1394.namprd21.prod.outlook.com
 ([fe80::9e52:d01f:67f7:2453]) by BY5PR21MB1394.namprd21.prod.outlook.com
 ([fe80::9e52:d01f:67f7:2453%6]) with mapi id 15.20.6652.004; Wed, 26 Jul 2023
 05:26:37 +0000
From:   Ajay Sharma <sharmaajay@microsoft.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Long Li <longli@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH 1/5] RDMA/mana_ib : Rename all mana_ib_dev
 type variables to mib_dev
Thread-Topic: [EXTERNAL] Re: [PATCH 1/5] RDMA/mana_ib : Rename all mana_ib_dev
 type variables to mib_dev
Thread-Index: Adm+bRhehYDMzhzwT9iQuSVhrPzPMAAS8WGAADI4dSA=
Date:   Wed, 26 Jul 2023 05:26:37 +0000
Message-ID: <CCEF05D1-7A87-4F10-B23B-633F77AA7723@microsoft.com>
References: <BY5PR21MB1394FE30BA84A501D4FA72C6D602A@BY5PR21MB1394.namprd21.prod.outlook.com>
 <20230725052839.GJ11388@unreal>
In-Reply-To: <20230725052839.GJ11388@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR21MB1394:EE_|PH0PR21MB2006:EE_
x-ms-office365-filtering-correlation-id: 409b8129-f8a1-4d77-3778-08db8d98e249
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xblH6wOS/1FMEBBehYnuUhNhozI50Rxjv5WOpRi9z+lLbf+vmhLvCNxCfrvNEK+UqkBYx86macetP1X/jP9gxFQAej/zeDEMnUak71HGnwAwJ/dARyO9lMGfgUyxV40zBNZDcPriwgNpL6ZmGfERYXEDEvVHttzLrvu6fbGHZupdUlqDvWKitMvAvxO4eZux5Tfg+MZXyUIkY5arLM1X+4cGmZkQ9S/rNUngkVlGreglsOTh1Ro0RJo96nwN00q+NNzRgOPmoJmvnJLy+077cAtTCwgZmjH8QKeebaqWlLeQKZMuv4ScIgndsgivBsm+U35s/7Q0/EBNLp4zToBHbpXPLfF4D8mTXhc9gXfOL9dB1iTl8ux3tVxVe5YGfVupFhaYrUH+HR+YOnuj3iAoiUzZu6p7UkSaCpHtvH4ZQ7/bQrzsuGlFzOTjlLNxakMgCnkne1yB0rDJrKvL35KauCuq5BGxVHcqtL6y0wQTnn+t5mDrk+IFZJTrAPCnrCECM9E/9yE0TLSm1cSUw/f4v7Xktz6P3M+DU761JPFimY77CSebEvXMXubNX8opcKUTCvtid/L6N8OGYMl0vmCo0CxbLV5s+H37EumtklwgHqzSC2LiU3GSciXZoPJua9ocze5uhQ5wIRQazL5cbuxKr93K6XBFPUn8XkRwobxa7tB6w61bF08SVY2ibp5XWX8otr1DcT68816EYSnvYu+dXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1394.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(10290500003)(2906002)(6486002)(66446008)(478600001)(8676002)(38070700005)(8936002)(316002)(41300700001)(4744005)(6512007)(5660300002)(66476007)(38100700002)(6916009)(122000001)(66556008)(66946007)(4326008)(64756008)(71200400001)(76116006)(54906003)(86362001)(82960400001)(82950400001)(6506007)(53546011)(33656002)(186003)(2616005)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTRucDkrZGQxbmh4NUhxVXAvUTJVbjd2enNMMkNqNVNGdXhha01GVTMwSlhy?=
 =?utf-8?B?UFptMVlhMlBqczZCMnRlT0p6Tm83M28zenlpemNPcWZhdWFFREpIUkg0bDkv?=
 =?utf-8?B?bDRpb1ZlcmYrOFFBNjVNeHZxd3E2VjAwMFBFTTlWZ2tha1ExTFlkZW1UUVJw?=
 =?utf-8?B?V0hrcnVOaUdVcXhVMDFVQ2h4OENQRS8zd1RuN3QwM1JrM2FaamxjUVVUMU5m?=
 =?utf-8?B?cnF2S3hLTlBFRWsrY21QNmczc3RocHdLdmdFNktobWZtYUh3bHB2QW9Oajcy?=
 =?utf-8?B?bmt3aHJXNlczVVpSVnlGSjdKMmU1VU15em9Ya0E5WG5rUE1rV0tmL3gzSHpu?=
 =?utf-8?B?WUhDMWtYUjcyeU84TG1uU09kdnRlN3BOcW05TUdBOHNJM2tvMUhUVE8ySi80?=
 =?utf-8?B?TStXQWx0TFJZUEc1WW12eWNIY0lHVDZLeUJGcHovTnNmNDhMRjJ4Zis4bjlP?=
 =?utf-8?B?WXhqVzhxQjNVNXA2U3RGQXlwVjJBUU03U3FlcUszMXlPbGgvdlYzTkV0Z1Bi?=
 =?utf-8?B?RUpLSkFRNnh4TE9pclhRRmlIbk4zRWIwTExNbkcyNnN1U1FaYlZoZENkYi83?=
 =?utf-8?B?QmRPNnhGTFY2bTN0dVJpVS9sajh3cGc0Z1pNeE1IUUVCeDRLTzJUb3FZS1Ja?=
 =?utf-8?B?eXA4VTdJeDQySjR4K2FEb2hNVm0wZWpOdVcvcm1nS1o3TzFjZ1N2SVN3QWox?=
 =?utf-8?B?RE01bDVrYXQrNmwxNVRBbHYzckpsUjVPTU52QVpmVU90dVNaNFp5QS94WHR3?=
 =?utf-8?B?M1lhVmNrRDVXVWZhSHBmNlZhanl2R0FVUVVlMTUwZ1hmOHVHa0ZGOEpoUEpL?=
 =?utf-8?B?UG8rcmRzYmJkUU16bUJMZDlXOS9RNkd5TXRrNXlLbGIyY3dYSkpCMTRGUUhP?=
 =?utf-8?B?d042YnFkb3BNTlVkdU1HelpEbG1wRjhUVjZ5ZmhOZDBkRXN1UmdjTmM4UDZG?=
 =?utf-8?B?TW9NQTl4L2RDanpocVgzVHBBR0hURGZUajJRWjZXaUxHbXJiYThxRFN6MXJL?=
 =?utf-8?B?aHBZVkdkUUExeW53dnFya21yUWdNZXM0T1RnbDUrNmFmMWRFYjZ1K0VCNzZo?=
 =?utf-8?B?enNvMnJxbkJlaCtqRklEaWRVb3huQzdxOTdTb1BBaG56d1RYVnpHdHhkQ2JL?=
 =?utf-8?B?eG1Dakl6QnFZMHRHQllIQ3hGZEdQdGJtQllwQUxiNnBLUXkyYW9MRElKVmxS?=
 =?utf-8?B?VjdMNUhTTytiMHBxSnl0aUM4OG1FUXYwdkhzR2NCNWVxamVzcUhlSUVyQmIy?=
 =?utf-8?B?YWR6bVM2cHVPRnJ6dUo2c3dCd211ZDY1Tm03cytZOWlpaGhBK0IwUnZaRmp3?=
 =?utf-8?B?eko1SSs1RUZPMGhNd2pmZ2lHekJFaDhrQmoxcGNlNmE5VERsZlA3cHZlaUtR?=
 =?utf-8?B?WDR4eEpNeHdvcWVRd2p1MHBjT0d2VVJPZDhtcHNLeS95Q0NTckZ1YTI3ZWRu?=
 =?utf-8?B?MWd5eUEzVGRiZm93dkZKbXc0ZnZpUVJKdnA1YzlMQ2NZOFBsQURuUmlFVnpQ?=
 =?utf-8?B?YWRiRmJnYlBoOExRWnh0Wjc4cVhMWkNZWmgwSU1jazRsMVZRUmViZjY4Nk8r?=
 =?utf-8?B?NWhPY2FERTdvOWk2QlJNTmIvOGllMlpsWklzaUl3ZDJySlZkV1VDeU9tdlpY?=
 =?utf-8?B?NXhlMEg2YXVQb2oyZkJsWEdhc0RYT2dpb0w3UUhhU1lRazBNY29Hdm45Rk9t?=
 =?utf-8?B?ZFpwdHQ3emROdWZCTmppUlZ6K3dIM0VyVzVhdGpFMnlKWVlmQUEzVjZLUE9H?=
 =?utf-8?B?L2JLeUhrRE5HUENDVUhOMkJaTkVwNmZEQTlPZEFaRHZaTDJTaDJsSkl3Nkpo?=
 =?utf-8?B?MHNmNGt3SXBObjRPbW9KS3loSFcydW1YQTE2YzVsKzBVemZhd1FjTDlIRHBF?=
 =?utf-8?B?b2EzakVGZWdwUkw5c1V4UW14K0hWZ2xZZk0ySVNNN2pZL21JcXFmU0Erc3Uw?=
 =?utf-8?B?eHF6NjJHMGRXUzRiaXh0NGNlOUJ4ZkQ4TUxOZ25VRmRPZEE2YkVSUDlTSE9Y?=
 =?utf-8?B?djJ5WXVTNjZWOFA3eVVxeHYvZFh2b05lMS9tZUUzRHR2NGt6cFVlWDhEcTht?=
 =?utf-8?B?R3dRd1pUTERJTlhEdjY1TVRZNEtsNGtzSkFwOUEzeHFaMjNoUktIWmxLUmc2?=
 =?utf-8?Q?Y6KP2nk5ZnadGKOjly7aiNR+M?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1394.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409b8129-f8a1-4d77-3778-08db8d98e249
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 05:26:37.3692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yBRA6Bu5NNgk2B9SrFQsZwqAnIVpLtE8rYdhXuEbM9A5GXfjsA6VPgiAAUGPt8W4vU0DSZsDORbOXQ2Y9pj0XqYP1p8VoeCMQxngZyknqNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB2006
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

U29ycnkgYWJvdXQgdGhlIG1haWxlciAuIFdpbGwgZml4IGFuZCByZXNlbmQgdGhlIHBhdGNoIHYy
Lg0KDQo+IE9uIEp1bCAyNSwgMjAyMywgYXQgMTI6MjggQU0sIExlb24gUm9tYW5vdnNreSA8bGVv
bkBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IO+7v09uIE1vbiwgSnVsIDI0LCAyMDIzIGF0IDA4
OjI2OjE2UE0gKzAwMDAsIEFqYXkgU2hhcm1hIHdyb3RlOg0KPj4gRnJvbSA4YzQ1ZDFhODk0OTVh
MWJhMTBiYTZiZmJjOGRiYzNjMzc2YjE0ODEyIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KPj4g
RnJvbTogQWpheSBTaGFybWEgc2hhcm1hYWpheUBtaWNyb3NvZnQuY29tPG1haWx0bzpzaGFybWFh
amF5QG1pY3Jvc29mdC5jb20+DQo+PiBEYXRlOiBUaHUsIDQgTWF5IDIwMjMgMTU6Mjk6MTQgLTA3
MDANCj4+IFN1YmplY3Q6IFtQQVRDSCAxLzVdIFJETUEvbWFuYV9pYiA6IFJlbmFtZSBhbGwgbWFu
YV9pYl9kZXYgdHlwZSB2YXJpYWJsZXMgdG8NCj4+IG1pYl9kZXYNCj4+IA0KPj4gUmVuYW1pbmcg
YWxsIG1hbmFfaWJfZGV2IHR5cGUgdmFyaWFibGVzIHRvIG1pYl9kZXYgdG8gaGF2ZQ0KPj4gY2xl
YW4gc2VwYXJhdGlvbiBiZXR3ZWVuIGV0aCBkZXYgYW5kIGliZGV2IHZhcmlhYmxlcy4NCj4+IA0K
Pj4gU2lnbmVkLW9mZi1ieTogQWpheSBTaGFybWEgc2hhcm1hYWpheUBtaWNyb3NvZnQuY29tPG1h
aWx0bzpzaGFybWFhamF5QG1pY3Jvc29mdC5jb20+DQo+PiAtLS0NCj4gDQo+IFBsZWFzZSBmaXgg
eW91ciBtYWlsZXIgYW5kIHNlbmQgcGF0Y2hlcyBhcyBwbGFpbiB0ZXh0Lg0KPiBBbHNvIHlvdXIg
cGF0Y2hlcyBoYXZlIHdyb25nIGVtYWlscyBhbmQgc2hvdWxkIGJlIGdyb3VwZWQgYXMgc2VyaWVz
Lg0KPiANCj4gVGhhbmtzDQo=
