Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CAE65C19B
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Jan 2023 15:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbjACOMB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Jan 2023 09:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237787AbjACOL3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Jan 2023 09:11:29 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C94B7EA
        for <linux-rdma@vger.kernel.org>; Tue,  3 Jan 2023 06:11:27 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303BsUvo012306;
        Tue, 3 Jan 2023 14:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=eUNDviBgREZpE2bD0P6oIDw7e0G1KRnixzrfh6bZOaw=;
 b=erMoM0DfXp/+Boss1ufW/kve8GmI57O1F7bIljyHh6VSrnTNtW1CYKirZeDnPm8ZzoA1
 Zd+QLxt/lUJpskld81SjBfz75Pd5sGzeEMaSRSyZpHnPoxp0AvH4cbmTdfGMxCxUiw+E
 gnjG9avzWCife92YDftC3eTqZhlo01eX3ririLOYpNCp4e2teYGb0qBcFUmLmD6WAewg
 bB2u+0Cae9FOSstjdnxrkyG4w9ZM5gxurISTgFNj61S90su5BqX3FoydtSSe38dYb++s
 TzFYT6FF394igNHBhWqlRt2FUbaN9CwBb57tN5wEze34ZwhrNFlKiHo2LzAhyKtdpvvG Lg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvkwctswv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 14:11:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZaHGbmNN1f+ub+Y3nYmye+gStHV3IiHoQoOgen+aalnLN1kEuQWywifxEgF757WMaKKqhVNTguvHaFePWpAqjn42sFQJXW4R4SYFA17u7kFjgkia4XLlojQZzGueWaoGTUsm4In9P3dLmoc1+sAnUBSdethEM+Vd2bxEfX4EsEOCqqsIJJIf9UqGW9JMyZ/Y7aipboVAs0SVMLlctuSe/a37S/UGQnIBrlWfFA7y9fZ3WWo/vxVJYHwF6XQklaW9kUNlyMZOngyFuHCYLC0BBH9HnfycLp3pCNSmi5i61QQ3oP90CInLW7XPrFFqFSmQ4pcgGImT8LCtYU3fE7u0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUNDviBgREZpE2bD0P6oIDw7e0G1KRnixzrfh6bZOaw=;
 b=Z0CgaCIw2EikMfBnUcYQzuRzLacLCDK3gE/BMUJ96VADKsv2R5X/U1JqfqbcJzs3ZFxmAiuy7QsXgI5gpgwp5yZ1Vpay/CAZyTWci7fWK5Gq0wDYGbi0Wg4ZsNDjzgBDOry+FGD3ExLcHmGtci9UMvtRIRgxGlhrF8XkO8FwYPAF7bRuN5jRdfrKw2x10UDlrToXWKoO542kYiDhoeM50QZh0Ri1/8iKlR7R32sJbL/NXrGq3m9UGcRIxdvNFhr0kHysupZCBF3yVWMiQke8BEsG9hcSZp7IMHhZboe6edVzcYVD5bevcYRJ2exD29v9iw21Jk5ucEUF5ErysalLlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by SA0PR15MB4031.namprd15.prod.outlook.com (2603:10b6:806:84::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 14:11:19 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d%7]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 14:11:19 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>
Thread-Topic: [EXTERNAL] Re: Re: [PATCH] RDMA/siw: Fix missing permission
 check in user buffer registration
Thread-Index: AQHZFHpVHTtYK/Rev0KRs40pmkXpwq6Mv82AgAAF5RA=
Date:   Tue, 3 Jan 2023 14:11:19 +0000
Message-ID: <SA0PR15MB39196C05636860B60263FF3599F49@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <20221216183209.21183-1-bmt@zurich.ibm.com>
 <Y5y6OaG4+6kPt9O5@nvidia.com>
 <SA0PR15MB3919045403A59EF36370173599E69@SA0PR15MB3919.namprd15.prod.outlook.com>
 <Y5zRR4KbAFOFIvpU@nvidia.com>
 <SA0PR15MB3919266C672961F49B28C7A499EA9@SA0PR15MB3919.namprd15.prod.outlook.com>
 <Y7QopYj1p4eeLo5N@nvidia.com>
In-Reply-To: <Y7QopYj1p4eeLo5N@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|SA0PR15MB4031:EE_
x-ms-office365-filtering-correlation-id: 0cd18d50-5c9d-4748-34e5-08daed9462b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /o+0bGSuCEZVLzvRSZvr6EXxNih91DwfbuUMZUGDChPhjQxUOmAhonz3RlQY/y2hs1oEpdoXEPRGPYCOSWr6E7NcmvHupAt2blgp/o4zwG/WiVx1Vbm7zs0wCbpfAJr1QK9UpUhNfxmGEuQFyTXbJljMEqP0CwVF0lNsX2j5dgpYvMBkK0CX9oIyVCGPFBH758hNVkdzSOMJBErSrhoYpC0xESvXq3o4Ygv55VYEOaLb40KTTE786za+SGoP6vfmJbwOCUvjIgZiSlnI3BlSfpcRM89ySsjDpkqHAtFAOcGigC0uKE72Y/d8XKKzeyVEwqjg1v0NfX0mSm/mThTwhlchIy1Ua/+J+1Mhwt5XfRgJF6t2JwFqCumU9CRlpvo4FH0X66qVO+u01Q/mpG8U6JSXcQ1DAGtOlh2hL+hIegZlHDLMkUbPY5nRrjlrA7tHqeciILtcNcABQn8eBzferRwwR3FgZY6sTxSc5lV3xATZVIRAudwDoUjNuyE3hBR4MEmZ8/VwUFzKjVDw6AxYHMcsbzD3UFD+mvIQabPwGGY93VBkeWm6golYWvN8b2FI/5oBmpvdYBvyhlXCTs0gJwo9caWeAdf4tNrakUO32Oonge9ef0KnxGRSTmQkGv6CrOcFjhxBS2RLS/igAZnFurBuZBc7kjV/+VUOOdRLix9NHSVgxcanpr8yUsvxrJrNZ3bxW5hsO842/3B1w7iyg48/kuXJat19+rfONdGIi4g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199015)(83380400001)(53546011)(186003)(9686003)(55016003)(33656002)(6506007)(7696005)(38070700005)(86362001)(38100700002)(122000001)(8676002)(41300700001)(4326008)(2906002)(5660300002)(8936002)(71200400001)(66556008)(52536014)(478600001)(66946007)(54906003)(66476007)(76116006)(316002)(64756008)(6916009)(66446008)(22166006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGdmZnNXQ1QzMGg1VFdzRS9YdkdMV3JlZmVCU0JlSTZCZmxFTEpLd0U5dXpt?=
 =?utf-8?B?MWhjRlJqRWxqaGNtKzd2RDdERlFVck1lRnNxMTRvbmxhUHZGZ1JJL1hycHJ5?=
 =?utf-8?B?dVczZzZEb1RWb2hjN3d5MFdVWndMdUNFaVpCajg0VithSDR1dnR1L2VuZWJ5?=
 =?utf-8?B?U0lvRCtMMzNJNDhPNHdyRUhWNmZNM1pSYVZxdHBNOUVCd1FtZFpISXN3VjRn?=
 =?utf-8?B?VHk2Z0J3ZUUvNkEwcFpIMkw1S0dEYUlrZlhFUnhHMW1hajFRaUZIV0xLd2dF?=
 =?utf-8?B?S3E5bFZCVjRPY0tPRm1OQm1DVVBaRFNGQm9VK2taSllFbTBlZXFLc09VY1FT?=
 =?utf-8?B?aEZ1NWx6bjNQZWNZRWYwWDhjeExFa01lMnVHZUV2RGxobHBmWjRDbXlROGZh?=
 =?utf-8?B?RXVWRWV2WDdSSS83T0pHYWs5QlcveGdxV2pGL0gzQ0ZqaXhhSURKZVgvMDNq?=
 =?utf-8?B?d21OSUxjOVhKUHBCYnpSR1pxUUdUdFhYSkpkY2VlU1dtT0hycXE2RHlPeDNM?=
 =?utf-8?B?NWNQRmREQjF2OUFEV2RlTCtreDNHRURmd3BhUWw5dVNJNEE3SVY0Tkd3Wk8z?=
 =?utf-8?B?M2NJQUFGYkhJSit4QzBuZWthMlJTcUlDTTZxeHlFR2ZYU3ZZUVFvUW44Rktm?=
 =?utf-8?B?cTJlSlV5RTR0Z3oyejB4ZWluRHYza3VYc3VKbThDR2lVY0c4cjFqRzZQZU5B?=
 =?utf-8?B?dGdBRmNsZGFsdXBneFFobUE4UjZJdEZsZ2dWMnJTRUVDdVdBSUdFaERVM0tr?=
 =?utf-8?B?VjdjeXFQUVpTbFM1OWxyWjRZdkNmbmtLVXVsR0s4QWthLzVaL2NsbWQrTXRD?=
 =?utf-8?B?NVN5YkFQUVpXNUU2WDFsRGpwa0pScFJRWERaWU5jK3JPZDVncEp3NEVESkdO?=
 =?utf-8?B?RHJDYkd5eWZWTDUxY2g2QStpbjBJV2VSd3VYUURtS0hTVkptcko0U1JUV1FZ?=
 =?utf-8?B?TW1ERysrS2xNY1pBQWM0VjRZdmRpbVBmQlFDTFBvWjIvYnJ2OVlsbGxnUGRM?=
 =?utf-8?B?WnJka3NYUFp1STFxRDNZd0ZGcDhBUW5MZXgyWVBiZmJXbVhKRjNRMHlXNEVY?=
 =?utf-8?B?Y0ZmbkZjaHVjaFdrN3lia0lxUmthamJSUDdtVWR2YUhkaytTU21iK2VYeTU0?=
 =?utf-8?B?d1BIUzRLWGJZd3BrcGdhTHlKSThZcXdQTlJvL0c2Ym5VQ01YOGRXWlU0UUMw?=
 =?utf-8?B?Q1FGRFE5cTUycmdrbHpuc3VVSEk5TnVNL3VQUlRpdzA3ZC9Md2UwcFcxamZB?=
 =?utf-8?B?R3hIYkVpanBKdlJ5eDRGRDllejA2ek1xdkFIdFdhQWNzaUV1NEVUMndxOGli?=
 =?utf-8?B?TDBtSTY5K3dVTlVqWjkrMk5CeSszQW42UDg5U3dmMnFzNlh5cVkzTGwvNXNF?=
 =?utf-8?B?OW5STUFxYjRsdUhEem96SmtoNWQ0MzVrTjJSRGpuWm5IVzVsZ25EZm1Bc2xz?=
 =?utf-8?B?U1dndElUOGJvYjZGV3NiT2duU1ZCNEV4aHp5aldJL2FoaHBpczZvcE9MbU96?=
 =?utf-8?B?OFpsTWZucjkrTk8xZmg2RzlkTzhCUnRVdXFEN0JHYWNCZmp4TmhtNXBKdFRy?=
 =?utf-8?B?bnlHYXU4SjBZK00xV1UyY3pXM2dHZjRVVXJrd1l2TmhTT2RoOEdyaVY5bUIr?=
 =?utf-8?B?R3FKNGdOTVZrVEU3ZWV5TmtyZVp1OWZ6Z0xYYzZiY2JIRDd6dTIrRVM2djdC?=
 =?utf-8?B?MzRhRk1CaytBeGJnTmg3WW1xSElkN05KTEF1NVlTY21qK1pmck1MeEpoSHpu?=
 =?utf-8?B?YUxUdFNTZU9QRW04Skc2b1lxLy9yRmFDVlVCSEhMZTREY0pFOWphZ1kzK0k4?=
 =?utf-8?B?QUV4NllsbGpOTmk1bUtHUlFNSjBiWXBlb3ppR2Q4dzRlcnJOMGU4Wjh1RWlJ?=
 =?utf-8?B?bWM3SjF6cUVzcTVIeWM5aGRVUFVteitGSmFGUFcydlNFYUlWZ2ZvWDRtMHZC?=
 =?utf-8?B?a25NNDFhUisvcXV0dW96TmQzRTlvUzE2djBsK0N5eU5TTjJHK1h3TWNNSmFa?=
 =?utf-8?B?TkV4TkZFNXd2MUprZEtYeHQ4TW1PbFU5UHlncWNWSzdFUkFVdC9KQzlrbDJx?=
 =?utf-8?B?UmpDYStqUC9FVEtZUjdDSWI2MkNxVEpQSkF4MitqeUpXOWp6WStLcFY1T1ZK?=
 =?utf-8?B?am1qamFtM1RYUkdTeXFySFN1cjRzTFpZQ2VEWFVCbDcwYUVxNTdNVXNSKzFO?=
 =?utf-8?Q?X8X3DfzoVV25XgjPiCHky/A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd18d50-5c9d-4748-34e5-08daed9462b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 14:11:19.3045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pIEBZ8vBGKRNjD5FOiXathgQKhfKSFAlBXmOf1wjPeYyj4Is0Ny6sJOo54Ke6LWIlrq8FYt8c9oqKACtaugGTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4031
X-Proofpoint-ORIG-GUID: ExOXb3vdZ55Q9e2FkyLTCT-FyAzgBTSN
X-Proofpoint-GUID: ExOXb3vdZ55Q9e2FkyLTCT-FyAzgBTSN
Subject: RE: Re: [PATCH] RDMA/siw: Fix missing permission check in user buffer
 registration
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_04,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030122
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gR3VudGhvcnBl
IDxqZ2dAbnZpZGlhLmNvbT4NCj4gU2VudDogVHVlc2RheSwgMyBKYW51YXJ5IDIwMjMgMTQ6MDgN
Cj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiBDYzogbGludXgt
cmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxlb25yb0BudmlkaWEuY29tOw0KPiBEYXZpZC5MYWlnaHRA
YWN1bGFiLmNvbQ0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBSZTogW1BBVENIXSBSRE1BL3Np
dzogRml4IG1pc3NpbmcgcGVybWlzc2lvbg0KPiBjaGVjayBpbiB1c2VyIGJ1ZmZlciByZWdpc3Ry
YXRpb24NCj4gDQo+IE9uIFR1ZSwgRGVjIDIwLCAyMDIyIGF0IDAxOjUyOjQzUE0gKzAwMDAsIEJl
cm5hcmQgTWV0emxlciB3cm90ZToNCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+ID4gRnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4NCj4g
PiA+IFNlbnQ6IEZyaWRheSwgMTYgRGVjZW1iZXIgMjAyMiAyMToxMw0KPiA+ID4gVG86IEJlcm5h
cmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiA+ID4gQ2M6IGxpbnV4LXJkbWFAdmdl
ci5rZXJuZWwub3JnOyBsZW9ucm9AbnZpZGlhLmNvbTsNCj4gPiA+IERhdmlkLkxhaWdodEBhY3Vs
YWIuY29tDQo+ID4gPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0hdIFJETUEvc2l3OiBG
aXggbWlzc2luZyBwZXJtaXNzaW9uDQo+IGNoZWNrDQo+ID4gPiBpbiB1c2VyIGJ1ZmZlciByZWdp
c3RyYXRpb24NCj4gPiA+DQo+ID4gPiBPbiBGcmksIERlYyAxNiwgMjAyMiBhdCAwODoxMTozMlBN
ICswMDAwLCBCZXJuYXJkIE1ldHpsZXIgd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiBGcm9tOiBKYXNvbiBHdW50
aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiA+ID4gPiA+IFNlbnQ6IEZyaWRheSwgMTYgRGVjZW1i
ZXIgMjAyMiAxOTozNQ0KPiA+ID4gPiA+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2gu
aWJtLmNvbT4NCj4gPiA+ID4gPiBDYzogbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxlb25y
b0BudmlkaWEuY29tOw0KPiA+ID4gRGF2aWQuTGFpZ2h0QGFjdWxhYi5jb20NCj4gPiA+ID4gPiBT
dWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0hdIFJETUEvc2l3OiBGaXggbWlzc2luZyBwZXJt
aXNzaW9uDQo+ID4gPiBjaGVjayBpbg0KPiA+ID4gPiA+IHVzZXIgYnVmZmVyIHJlZ2lzdHJhdGlv
bg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gRnJpLCBEZWMgMTYsIDIwMjIgYXQgMDc6MzI6MDlQ
TSArMDEwMCwgQmVybmFyZCBNZXR6bGVyIHdyb3RlOg0KPiA+ID4gPiA+ID4gVXNlciBjb21tdW5p
Y2F0aW9uIGJ1ZmZlciByZWdpc3RyYXRpb24gbGFja3MgY2hlY2sgb2YgYWNjZXNzDQo+ID4gPiA+
ID4gPiByaWdodHMgZm9yIHByb3ZpZGVkIGFkZHJlc3MgcmFuZ2UuIFVzaW5nIHBpbl91c2VyX3Bh
Z2VzX2Zhc3QoKQ0KPiA+ID4gPiA+ID4gaW5zdGVhZCBvZiBwaW5fdXNlcl9wYWdlcygpIGR1cmlu
ZyB1c2VyIHBhZ2UgcGlubmluZw0KPiBpbXBsaWNpdGVseQ0KPiA+ID4gPiA+ID4gaW50cm9kdWNl
cyB0aGUgbmVjZXNzYXJ5IGNoZWNrLiBJdCBmdXJ0aGVybW9yZSB0cmllcyB0byBhdm9pZA0KPiA+
ID4gPiA+ID4gZ3JhYmJpbmcgdGhlIG1tYXBfcmVhZF9sb2NrLg0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gSHVoPyBXaGF0IGFjY2VzcyBjaGVjaz8NCj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiAg
ICAgICAgIGlmICh1bmxpa2VseSghYWNjZXNzX29rKCh2b2lkIF9fdXNlciAqKXN0YXJ0LCBsZW4p
KSkNCj4gPiA+ID4gICAgICAgICAgICAgICAgIHJldHVybiAtRUZBVUxUOw0KPiA+ID4gPg0KPiA+
ID4gPiBzaXcgbmVlZHMgdG8gY2FsbCBhY2Nlc3Nfb2soKSBkdXJpbmcgdXNlciBidWZmZXIgcmVn
aXN0cmF0aW9uLg0KPiA+ID4NCj4gPiA+IE5vLCBpdCBkb2Vzbid0DQo+ID4gPg0KPiA+ID4gRWl0
aGVyIHBpbl91c2VyX3BhZ2VzIG9yIHBpbl91c2VyX3BhZ2VzX2Zhc3QoKSBhcmUgZXF1aXZhbGVu
dC4NCj4gPiA+DQo+ID4gPiBZb3UgZG8gaGF2ZSBhIGJhZCBidWcgaGVyZSBpZiB0aGlzIGlzbid0
IGhvbGRpbmcgdGhlIG1tYXAgbG9jaw0KPiB0aG91Z2gNCj4gPiA+DQo+ID4NCj4gPiBObywgdGhh
dCBsb2NrIGlzIGhlbGQuIEkgd2FzIHRyaWdnZXJlZCBieSBEYXZpZCdzIGFyZ3VpbmcgYWJvdXQN
Cj4gPiBwcm90ZWN0aW9uLiBJIHdlbnQgZG93biB0aGUgcGF0aCBvZiBwaW5fdXNlcl9wYWdlcygp
IGFuZCBkaWQNCj4gPiBub3QgZmluZCBhIHNpbmdlIHBvaW50IHdoZXJlIGFjY2VzcyByaWdodHMg
dG8gdGhlIGJ1ZmZlciBiZWluZw0KPiA+IHJlZ2lzdGVyZWQgYXJlIGVuZm9yY2VkLiBwaW5fdXNl
cl9wYWdlc19mYXN0KCkgZG8gaGF2ZSBpdCB0aG91Z2guDQo+ID4gU28gSSBwcm9wb3NlZCBhIGNo
YW5nZSBpbiBzaXcgdG8gdXNlIHRoYXQgZnVuY3Rpb24uDQo+IA0KPiBJdCBjaGVja3MgaXQgd2hl
biBpdCByZWFkcyB0aGUgUFRFcw0KPiANCk9oIG9rLCB0aGFua3MuIEl0IGlzIHByb2JhYmx5IGZp
bmRfdm1hKCkgZnVydGhlciBkb3duIHRoZSBjYWxsDQp3aGljaCBtYWtlcyBzdXJlIHRoZSBhZGRy
ZXNzIGlzIHZhbGlkIGZvciB0aGUgdXNlciBjb250ZXh0LiBJDQp0cmllZCByZXNlcnZpbmcgYm9n
dXMgdXNlciBtZW1vcnkgd2l0aCBzaXcgYW5kIGluZGVlZCBnZXQgdGhlDQpyaWdodCBmYWlsdXJl
IGZyb20gdHJ5aW5nIHRvIHBpbiBpdC4NCg0KSXQgbWF5IHN0aWxsIG1ha2Ugc2Vuc2UgdG8gdXNl
IHBpbl91c2VyX3BhZ2VzX2Zhc3QoKSBpbnN0ZWFkPw0KVGFraW5nIHRoZSBtbWFwX3JlYWRfbG9j
aygpIGV4cGxpY2l0bHkgd2l0aGluIHRoZSBkcml2ZXIgY291bGQNCmJlIGF2b2lkZWQuDQoNClRo
YW5rIHlvdSENCkJlcm5hcmQuDQoNCg0K
