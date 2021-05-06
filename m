Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E113753C0
	for <lists+linux-rdma@lfdr.de>; Thu,  6 May 2021 14:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhEFMXV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 08:23:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39686 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhEFMXV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 08:23:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 146CKxjp093569;
        Thu, 6 May 2021 12:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ZGyKPcVoB70JCXXMVhvNhQ44s1GCvMd1NgstRs+do50=;
 b=jsiYSjhEIKb6Vz93bStUqYs7efLpsbyjCanSWupZRHjovkeN9cWGzVI8Hn753N3ykQWD
 N0WIy/CW7wdZH/1226SGTg8e8V6eBf3tLaT+efu0PrknFJTVgPIZ5u/9g2MDDDuU+2j/
 UUZO1bRYYoz7yRH1fxT79IZGMwojGgULuM43Ms0I49phPY2/QeXh6ivKwtNNqJ3ua9tG
 FtIHoIOlg0jyEOe/iWhXr7aUTvkCvDwZ1/33yqTwFCsMVIEDkKexQoJX3l6YzGEmN7Lo
 nCTlJjs9yZ7+VPpHf7YK49cYhgdQRw8JfHPeXwOQwe+xFe0r0TOfZzT6PEsphUCALpNC 2w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 38bebc4swt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 May 2021 12:22:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 146CFdwR059748;
        Thu, 6 May 2021 12:22:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 38bfutfgpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 May 2021 12:22:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVanHe/K5T1Xma9ZLqtRiv9Kc/MSXUeJ9gSn27puisAOpRk0j4S3cFkTqbqP4us9GLrW3Xr5Zyogglk5fkeHyWKxHnDD9+AylnPSc1olxEV/LviXFx+uKHi1V56G9cAEUb6Qlh1PMj5ER7yIhPodQ+T/CMTnpkLw4RQZbdFV6Scox0boqvSCjSuOpOKrmuCrxFfF6hUY57S7eOGLg/Fwz6xQdFEjrxmEIY+UBLTvVmMgcFARBijkbpaTZzuwIr8pvQ5NA6303Usp0EslvZp3uKCNU0G7a229wovac5kbNDq5kY7UB1hgWH1NGjx96CBsJYMXXlV7qg9UmbEXpDWutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGyKPcVoB70JCXXMVhvNhQ44s1GCvMd1NgstRs+do50=;
 b=WGZlLgRW6ZdGEpgC9hUDiIuIdV+oW9rmmsUUyNtbkXq/aKDuji0PCz5LDMhCrdn6dpYAbN/YkwR0IjECJKeP4ULMoLkp2NLhHjMoYW/u8lBgyv5yTKebTrWgc+FuM+mG3N+QkfC1G0l0ptTnH/5yGZn1WqkQFpGF7rjpwRVr//Ya4qO7vz1TzozrUMzhCiMmcbxzNoKHggcc58P2DMJeqTSdrjBHyRIssUBUcDJpRqZRxyoYrg0dZf+NwemHD/78d+7Wi1W94/bAvSET8nJMaA9dUkoyXLLtEedVOAgYVGa4+OqF6ApkKM7Tr5xy0H7ndpBavS3/BWN/2ZjgyAQfrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGyKPcVoB70JCXXMVhvNhQ44s1GCvMd1NgstRs+do50=;
 b=DLKFsQZk5ahGciUQa1ByV9yi5DGVGr+kXr7sMLn3ziMtetoacxSUTVJvW8fqLkNhndcuuTHWVdrPlUswbFo16riOE8zkxqI0l9nLP+pe1iIidqA49xPqfHK9tl/ixVCiDaR1VR0q+kEa1cVUy9VMwmCLEPzsV244Y5pJrD4cAfQ=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1254.namprd10.prod.outlook.com (2603:10b6:910:5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 12:22:14 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.4087.044; Thu, 6 May 2021
 12:22:14 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v2] IB/core: Only update PKEY and GID caches on
 respective events
Thread-Topic: [PATCH for-next v2] IB/core: Only update PKEY and GID caches on
 respective events
Thread-Index: AQHXQlJN5+TG4/FSE0Wg1M5qrYY6fKrWURYAgAAPKIA=
Date:   Thu, 6 May 2021 12:22:14 +0000
Message-ID: <D06E6D77-3ADD-4BFB-B198-0A0E51C8AB7B@oracle.com>
References: <1620289904-27687-1-git-send-email-haakon.bugge@oracle.com>
 <YJPSvu5c8K5ACSI+@unreal>
In-Reply-To: <YJPSvu5c8K5ACSI+@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3afebbd2-8a81-4487-7ead-08d910899501
x-ms-traffictypediagnostic: CY4PR10MB1254:
x-microsoft-antispam-prvs: <CY4PR10MB12545FDE6F59A7894D34D690FD589@CY4PR10MB1254.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jCwmSy3kDkW+wLfVRNEXMi9lLvA73t45OvB+0wSktd7BsvcRYWmCk9l0SRqd5Yh/4H622G95aHNw2a9vUbEMCr4H1BDA/V7GDHP97IcjT0mizoYTGA69orzrl3Jq+ueNkDhaDt6YDryVvTc4+pxx2/3vO5LXvEkg7IQq+yrmzLvxwYquTyycjsLn8XK9krY2Xia6MC7CJNdHcHmsXK2WKfpwH3k1c/ucTGM2XSmiELiMjivZCjeOlzW9gLdbIMq63X9gFMVeenJ1sR9J1piMeCC2UUXvQYA3GdlJWQcJW1NEau3fkTt6Az9WaUscBrY2Oq6A3dVLV6pVky4cFsDCYCzbR6Ct4Ik0M15UYnh3h5MMBEUq65r/am1Kk2sYMas8iSuryL36mxWUgPOTO4UqTYtLQD8PgZWpkaHA5imjXViapLR+bvQ30ofe+HpSiCUQ/8ftdBCBbX0EpKefH9XuleEysk6ns4/BVbzzbzCYgC0IHSJEq4jY0hbYlgcfTrEawjBgAbvH/yACvZewdIE9gY+VbT4W11xqs8v9WipqiaayFUt+rsVoCCowdk029AIPpdLISvveiPOtDs8H81EZHE0H1U/0ls4OPNbDiuxOHhmPuCfrreJZ2OCeg6ZJylRGyMEGO8Sp7WTd/zNrX4ZuFFf4BAU/4+Wr6lLv18th/S4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(39860400002)(376002)(396003)(54906003)(66946007)(8936002)(4326008)(5660300002)(66574015)(6512007)(66476007)(478600001)(66556008)(64756008)(66446008)(91956017)(76116006)(26005)(36756003)(186003)(8676002)(33656002)(15650500001)(71200400001)(122000001)(38100700002)(316002)(86362001)(6486002)(44832011)(2906002)(2616005)(53546011)(83380400001)(6506007)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VFhrVmNaUXhnWGljQkFTdlJibEkxU0NBR0JqQW5jb3Z5alRMcnNYNmc1eXhL?=
 =?utf-8?B?RGhQRW9DZ1JGNFJUcDRoaTUrM2VpMTNmbWlVaUpneFJLT3JHRWpQQTM4Q2dB?=
 =?utf-8?B?M0g5TlF5RnBXdjNac0VHU3Zac0FwQVBqeCtQNk10bFNXU1VNZ0xrSnordUZu?=
 =?utf-8?B?a2pQcEVJalBkbmRQRFF6OTAzdVZKS2FYS0VTa3BRWlFOOExDSC9idlNZMUNt?=
 =?utf-8?B?QTM0WlpFODdEdlM0d05pVVlBTEpneUdNUDVBSGdGclVSUzRHRTh5RTVwVGRI?=
 =?utf-8?B?ZVMyOC9iM1N4bjJ1ZmFMa2IzK0ZBUnEwYVlDczFDODZyZm1hN1grMGU4TXRY?=
 =?utf-8?B?VkM1N0RuV2d3QXhETngyUTV0T2JqY00wdXFFUGxiWHBKdWEwSDN6WGNwR1pP?=
 =?utf-8?B?NmhkdGFnSzdVVDN4OXFaUzhXUEZaWlN6ZlQzZEgvUDdhcW82TklmLzJwYmVu?=
 =?utf-8?B?b1JRVjZGV205VTB6TmRlYk5mTGRWWWxpUHE0cUlWQ3EwR01nT3FjalRBZDZr?=
 =?utf-8?B?QS9MWlJEcElPYTFiWE1uOVdLTkhoa3hPN2hkaDlINDhkQTlEUGlzc2dCVk13?=
 =?utf-8?B?VVZjNHM0SmpSMEpMYWlHS2VDTGU0cFJTb2gydlhKbDlVT1ZaTk1HVDZXamFx?=
 =?utf-8?B?aGN6TzJ4bE5kMVhkWmRSbWVHUXRac0hLbTdabE5DQm83Y01pdEVtNXIzZVZY?=
 =?utf-8?B?V09DbnhhQ1pLc0tjMzJ3QmNOa0dMMjFxSS9OUVI5RStMUWpxRUZrZTVmSExQ?=
 =?utf-8?B?Z1R1b2Y3WERQUWlRd0cxVjVlQittRGtybUovVkc3OGVPQlkrL3huNDJ4VVdy?=
 =?utf-8?B?ckpxZTd1cGs1Nmd1NFdDZGdOL0kya2xTaElyUWJvVzJLaklPVGVHT3Rxc29r?=
 =?utf-8?B?UEpuZGtMZjBjaTJxN0dqT3I3ZzRreTlVbTZJQkhVWlFTdW5TVTB4eGNtMzBX?=
 =?utf-8?B?enFKMklpL1ZMdFYzSk1kaTl5MFFjd2tSQ0lhankrWGZ6dUdwdkNwdFg2OXZy?=
 =?utf-8?B?aW1qTkFRNUdybkdtZERvS0h1N2Y0ZG9JVVRjT3hydTlHd3cvZW04a2U5WXY5?=
 =?utf-8?B?ZU1ZVVlHbXVlR1VFMjg2U1RUNHcyUHFLOTJFMGR5ME5UZlFOR0tYOUNxM3Bh?=
 =?utf-8?B?WnRMRUUwRkdmTWJuWmdLOEFaZFlUaGNjVmJZbjlYaENQQ0JTdVpQcjNhZTBy?=
 =?utf-8?B?aU1Qdjg0d0ozZWFzd1M5MlNURE9xMGpnbVNIdEhKNUVxTE84RmMxT3ZQMWlP?=
 =?utf-8?B?VTV2S0FBdjdUSmpJV3lwZG40dXJodmtxemxSc2ZocitaaGJ6M0ZIOG0rNGIx?=
 =?utf-8?B?WWRDRlRvQnlWL09uZlVPci9sTjFYQkdhK0RRM0x0UnF1bTNsT3dVVzNGZkVC?=
 =?utf-8?B?UEQ2QnJmTHRZMjF2MjQrQ1NvdWR5azJTUngzaWZBdVFlNll0Z2w1eUlhZlBB?=
 =?utf-8?B?eTM2VnF3Y0hRaHphV0tpcGFkZFdkRE5jd1ZPMXZYUFFEYnZuUjlKbGo3bnY4?=
 =?utf-8?B?anczaXl4Nkpod2JGQWxJSzJ1cDRmYmhTU21LQXE1OCtRRVZCSUo0Mk1aa0tr?=
 =?utf-8?B?cC9zUyszT094SkFpQThjZEptbkZXUW5tcE9tZFdNZHp4S09OSXJTeGhpSytE?=
 =?utf-8?B?ajFFeU04K25MbWI1YXBtNG1TSkJ2UXFGRzZnSTlDaHJhbFFhdGNpZmYrMjVW?=
 =?utf-8?B?cXRqRUI2QkpxcUVkZG4wS3p0UG1icVFFaHFleGJjV2lBdVozWDJiMDlCbTU1?=
 =?utf-8?B?VElTclYzd2ZISTlSZzkxZzNvVi9KOUYxRUd2Zm1KTXIvTGpXUUdzbTAzdG1U?=
 =?utf-8?B?aU1JUG1RQzFPS0VaMDlFZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBFB5F091F20B241AF585D147A20F573@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afebbd2-8a81-4487-7ead-08d910899501
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2021 12:22:14.4523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pRnOv5mk7by0MtVfxGdbZHA8gZfVAwRHXEr9f8snQcH7WTiCD+gDL0thprBSPsg0xLZOJ819mHKiS2O/H6evRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1254
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105060087
X-Proofpoint-ORIG-GUID: m5vAw5ZtIuFyWCk5YPIRevbHui2H6PXi
X-Proofpoint-GUID: m5vAw5ZtIuFyWCk5YPIRevbHui2H6PXi
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105060087
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gNiBNYXkgMjAyMSwgYXQgMTM6MjcsIExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgTWF5IDA2LCAyMDIxIGF0IDEwOjMxOjQ0QU0g
KzAyMDAsIEjDpWtvbiBCdWdnZSB3cm90ZToNCj4+IEJvdGggdGhlIFBLRVkgYW5kIEdJRCB0YWJs
ZXMgaW4gYW4gSENBIGNhbiBob2xkIGluIHRoZSBvcmRlciBvZg0KPj4gaHVuZHJlZHMgZW50cmll
cy4gUmVhZGluZyB0aGVtIGFyZSBleHBlbnNpdmUuIFBhcnRseSBiZWNhdXNlIHRoZSBBUEkNCj4+
IGZvciByZXRyaWV2aW5nIHRoZW0gb25seSByZXR1cm5zIGEgc2luZ2xlIGVudHJ5IGF0IGEgdGlt
ZS4gRnVydGhlciwgb24NCj4+IGNlcnRhaW4gaW1wbGVtZW50YXRpb25zLCBlLmcuLCBDWC0zLCB0
aGUgVkZzIGFyZSBwYXJhdmlydHVhbGl6ZWQgaW4NCj4+IHRoaXMgcmVzcGVjdCBhbmQgaGF2ZSB0
byByZWx5IG9uIHRoZSBQRiBkcml2ZXIgdG8gcGVyZm9ybSB0aGUNCj4+IHJlYWQuIFRoaXMgYWdh
aW4gZGVtYW5kcyBWRiB0byBQRiBjb21tdW5pY2F0aW9uLg0KPj4gDQo+PiBJQiBDb3JlJ3MgY2Fj
aGUgaXMgcmVmcmVzaGVkIG9uIGFsbCBldmVudHMuIEhlbmNlLCBmaWx0ZXIgdGhlIHJlZnJlc2gN
Cj4+IG9mIHRoZSBQS0VZIGFuZCBHSUQgY2FjaGVzIGJhc2VkIG9uIHRoZSBldmVudCByZWNlaXZl
ZCBiZWluZw0KPj4gSUJfRVZFTlRfUEtFWV9DSEFOR0UgYW5kIElCX0VWRU5UX0dJRF9DSEFOR0Ug
cmVzcGVjdGl2ZWx5Lg0KPj4gDQo+PiBGaXhlczogMWRhMTc3ZTRjM2Y0ICgiTGludXgtMi42LjEy
LXJjMiIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFj
bGUuY29tPg0KPj4gDQo+PiAtLS0NCj4+IA0KPj4gdjEgLT4gdjI6DQo+PiAgICogQ2hhbmdlZCBz
aWduYXR1cmUgb2YgaWJfY2FjaGVfdXBkYXRlKCkgYXMgcGVyIExlb24ncyBzdWdnZXN0aW9uDQo+
PiAgICogQWRkZWQgRml4ZXMgdGFnIGFzIHBlciBaaHUgWWFuanVuJyBzdWdnZXN0aW9uDQo+PiAt
LS0NCj4+IGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NhY2hlLmMgfCAyMyArKysrKysrKysrKysr
KystLS0tLS0tLQ0KPj4gMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDggZGVsZXRp
b25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jYWNo
ZS5jIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY2FjaGUuYw0KPj4gaW5kZXggNWM5ZmFjNy4u
MTQ5M2E2MCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NhY2hlLmMN
Cj4+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NhY2hlLmMNCj4+IEBAIC0xNDcyLDEw
ICsxNDcyLDEyIEBAIHN0YXRpYyBpbnQgY29uZmlnX25vbl9yb2NlX2dpZF9jYWNoZShzdHJ1Y3Qg
aWJfZGV2aWNlICpkZXZpY2UsDQo+PiB9DQo+PiANCj4+IHN0YXRpYyBpbnQNCj4+IC1pYl9jYWNo
ZV91cGRhdGUoc3RydWN0IGliX2RldmljZSAqZGV2aWNlLCB1OCBwb3J0LCBib29sIGVuZm9yY2Vf
c2VjdXJpdHkpDQo+PiAraWJfY2FjaGVfdXBkYXRlKHN0cnVjdCBpYl9kZXZpY2UgKmRldmljZSwg
dTggcG9ydCwgYm9vbCB1cGRhdGVfZ2lkcywNCj4+ICsJCWJvb2wgdXBkYXRlX3BrZXlzLCBib29s
IGVuZm9yY2Vfc2VjdXJpdHkpDQo+PiB7DQo+PiAJc3RydWN0IGliX3BvcnRfYXR0ciAgICAgICAq
dHByb3BzID0gTlVMTDsNCj4+IC0Jc3RydWN0IGliX3BrZXlfY2FjaGUgICAgICAqcGtleV9jYWNo
ZSA9IE5VTEwsICpvbGRfcGtleV9jYWNoZTsNCj4+ICsJc3RydWN0IGliX3BrZXlfY2FjaGUgICAg
ICAqcGtleV9jYWNoZSA9IE5VTEw7DQo+PiArCXN0cnVjdCBpYl9wa2V5X2NhY2hlICAgICAgKm9s
ZF9wa2V5X2NhY2hlID0gTlVMTDsNCj4+IAlpbnQgICAgICAgICAgICAgICAgICAgICAgICBpOw0K
Pj4gCWludCAgICAgICAgICAgICAgICAgICAgICAgIHJldDsNCj4+IA0KPj4gQEAgLTE0OTIsMTQg
KzE0OTQsMTYgQEAgc3RhdGljIGludCBjb25maWdfbm9uX3JvY2VfZ2lkX2NhY2hlKHN0cnVjdCBp
Yl9kZXZpY2UgKmRldmljZSwNCj4+IAkJZ290byBlcnI7DQo+PiAJfQ0KPj4gDQo+PiAtCWlmICgh
cmRtYV9wcm90b2NvbF9yb2NlKGRldmljZSwgcG9ydCkpIHsNCj4+ICsJaWYgKCFyZG1hX3Byb3Rv
Y29sX3JvY2UoZGV2aWNlLCBwb3J0KSAmJiB1cGRhdGVfZ2lkcykgew0KPiANCj4gQ2FuIHlvdSBw
bGVhc2UgZWxhYm9yYXRlIHdoeSBpdCBpcyBzYWZlIHRvIGRvIGZvciBJQl9FVkVOVF9HSURfQ0hB
TkdFIG9ubHk/DQo+IFdoYXQgYWJvdXQgSUJfRVZFTlRfQ0xJRU5UX1JFUkVHSVNURVI/DQoNCkNs
aWVudCBSZXJlZ2lzdGVyIHRlbGxzIGhvc3QgY2xpZW50cyB0byByZS1yZWdpc3RlciBhbGwgc3Vi
c2NyaXB0aW9ucyBmb3Igc2FpZCBwb3J0IHdpdGggdGhlIFNNLiBObyByZWFzb24gdG8gcmUtcmVh
ZCB0aGUgR0lEIHRhYmxlIGluIHRoYXQgY2FzZS4NCg0KT3IgcHV0IGl0IGFub3RoZXIgd2F5LCB3
aGVuIHRoZSBHSUQgdGFibGUgY2hhbmdlcywgdGhlIGNoYW5uZWwgaW50ZXJmYWNlIF9zaGFsbF8g
Z2VuZXJhdGUgYSBHSUQgY2hhbmdlIGV2ZW50LiBUaGlzIHBlciBJQlRBIG8xMS00MC4yLTEuMS4N
Cg0KDQpUaHhzLCBIw6Vrb24NCg0KPiANCj4gVGhhbmtzDQoNCg==
