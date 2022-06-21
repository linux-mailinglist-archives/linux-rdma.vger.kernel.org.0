Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8BD5535C1
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jun 2022 17:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352433AbiFUPTH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jun 2022 11:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352458AbiFUPTA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jun 2022 11:19:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F831836A
        for <linux-rdma@vger.kernel.org>; Tue, 21 Jun 2022 08:18:59 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LEsZTY001314;
        Tue, 21 Jun 2022 15:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=R/jKhvofV9vwg9Fz5iLnpr9JZKh90wHb/lNyhnh7c+s=;
 b=QVoj+tavlK1aee4+WUk/8PjuFch82m/8yMjcCpMHkKXGaDNDwyCGV8/O3HdYfKbU/591
 YqZQp5BkKOz37OXzK46d7PrX6hv8N96IW5oSVm56TMfAHWFjJKWpo+DijW63cX+e7azs
 uLnTNJHyL3b8WtB07QsepmgQGCWyfAjcR7CTbZ0d8KQj6SK8UEz6QPwOvBoevBFbAxyo
 ym4D4CzaNTLOzTpeiMobfz+5lyKgzH1ygqPJRD2wOsJHXEkYw3UHJIWacK9RIy1lZvic
 dnzRtvXwz8yYJ41HgINll3HXToZc80ZVVygQtZDAeIMsrEA87OytIxgPOy/+1gLHar7S mw== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gug5t0s31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 15:18:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c235a4gt+FEjgMjAdX2YbbPoeucdgryJ0qXkKzy1D7mwhRgR6SrRV+RGbN9jl/Y22q75Rx6CfuGSLKCZMf5GHZnd2RxWCBl0H3Q5fHkeEFTatFvh8QrSgXK8WlnvlnEt8IciqGKeuoDLjvFVEV3cLl+XmgnVlX3L9uYoaaPZrp8lIgAU3jXAI1Ws8ZNRMzex4XrwH+q7vxzsXdzDr4HFOPFj1ws1whTWD1XCzlKSCHiTU8mgNkLihDI/IwbNkyWDona4SK4CKmU9Pu/D+bhaAKU6bpguNYhDflnOKvj82MLuN9pbotv/AF/JV2ikwWfW5qxvlXBv4auL0VKSGa2WzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/jKhvofV9vwg9Fz5iLnpr9JZKh90wHb/lNyhnh7c+s=;
 b=kISF+eSuN3vvkMH9TNZpMWryTKOf2CrFpWzUigZBWmXGbbJ6q4ZKQVLynPKXpIuZnFP9PsDIm69ZQptNBYc1utSnYm0iNyHYynkYIgYmVqvphhHTuOOkZVHlD+rUDXh/nvrXDQcyUqa62tSA3gLvRKkufjIw+8hmLVHLsTdci5ZtzTosrA8nJtIs840DuQ2vBuQQV+qH6SGIki+jMJhgZjwGuhdm9K8xOXLx6XgYM4szvetSqg0cj4PEgdfWFjtCASdWNMca1ChQWb+y5+dr/pt4SVuTmq1IBeC0V3IEn7X7qx4go3UoarQ9vDTLeR4+BAj8FHmGFM8Wv+bZjmBezg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by CY4PR15MB1831.namprd15.prod.outlook.com (2603:10b6:910:24::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Tue, 21 Jun
 2022 15:18:44 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8953:534b:e375:a945]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8953:534b:e375:a945%6]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 15:18:44 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Stefan Metzmacher <metze@samba.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v2 11/14] rdma/siw: use error and out logic at the end of
 siw_connect()
Thread-Topic: [PATCH v2 11/14] rdma/siw: use error and out logic at the end of
 siw_connect()
Thread-Index: AdiFgiHgMOy/Ci5TTbWZwg/TL8QMcg==
Date:   Tue, 21 Jun 2022 15:18:44 +0000
Message-ID: <BYAPR15MB26315449E3BA2CEC69E3A57E99B39@BYAPR15MB2631.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c25ac67-0b9f-45aa-e6c8-08da539954ae
x-ms-traffictypediagnostic: CY4PR15MB1831:EE_
x-microsoft-antispam-prvs: <CY4PR15MB1831BEB6BCED2BEE1457080199B39@CY4PR15MB1831.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JnffRiUXUnZ/CoU2wsd19WrAKhu5EWIUBlvMUmA0NkZYmDC7UZAr1KtzSwW1CsO3kITl+kXvM3zz3jPZeZro6uO9IT/5i7wGDFk8NZrssUncwEnrOyguHNQWMoRDlNfvlqJsdr8m93brkkU+zBrJ2luhWz4FLwSsDmKHCx7J7vbcYpoB2i+ANMNyW3SwkVzTKlHScLFQMTaC8n2YM2vCD/yw75D0kuXMuigGyaVW5JSpF2Ya8isYMniTI6zMW3HreiScl7LOaFUxt2Qi/qYFikm4YhgKLkjupnd3/upyYqCur39NEDoy9ZWKBaiHbGzfXF8elVmugEoy7hSpQDtRCqXY0OdHEMm6QnGlVixgEjBSuWXBsRKp3HLE/vatooJh7XDc12Kn8CEkv4139E1AQZq7Y+Z10k/p8BhelvyDEJ3lVtIang1nm7DL1YaKhAL9OmV1yO3Mk4ZE92rbG1vWp241c4YQgaaD/jN0iNhW9utGjw+t2ApR6OxHZPwkQuYQ3Nd8YghHMXw9PolvMdAiGw42eVs50mA2ZJ1gi7kuNUnzvog8DNmoarXax+lboKOsIFBcnUcVitm15MHsu5VqMfXu7k+0E7VxEEYLHrl4iVIJzJQuZi4R5u7PtbijrMQyaYE5TD3kdVk+DWlWrwiPPO5uXNLsZ8QPhYzTlkeVgKITD1EoIEDSA+nyWEmBVapRPep6IKxXu/1MFvjP3PYdrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2631.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(346002)(376002)(136003)(39860400002)(8936002)(52536014)(478600001)(38070700005)(5660300002)(186003)(6506007)(41300700001)(7696005)(53546011)(55016003)(33656002)(66446008)(83380400001)(71200400001)(9686003)(76116006)(316002)(2906002)(110136005)(38100700002)(8676002)(66476007)(86362001)(66556008)(66946007)(122000001)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3QrMUp3N0lTVUhMMUdFWjAyMGRtZmIvWmlUY3BKWStNbXVUcjBCOEdCa1Bv?=
 =?utf-8?B?MnR3MitlS2JRVXJyaFBPd05XbXlSc3o0S2IrYTZoYmUwTXQyekpNazVXZTdq?=
 =?utf-8?B?ZkZ0UFI4bUJWL3p3QkEzY1J4c0FFc21CM01GT0s0eGpHdmlCZ1p0NXhlRm56?=
 =?utf-8?B?VG9rK1N2eGx5Y2l0N2JpS3B2R3QxQmJya2F1SHhSOUY2QUhIQ1NmbFBlR0to?=
 =?utf-8?B?Z3V3Q3lMUlZEV2NrUTFoaDNWdE1VZlNJTDl2cFN2a3A0VWJiS1JXdlR5dm4v?=
 =?utf-8?B?NFBhNGVmVnA3dENLbmZTUVdoa2lCSCt5R3Z4VjNyTmNVVnJDa3ZiZVdlK24z?=
 =?utf-8?B?WGYwcDBvRUFlL1Nkd3pCKzFoY3RMMk9HakVrTlNBV2tqQWp6MFJSTkZIZHU2?=
 =?utf-8?B?S0FodXFmaEZEOXo1WGtNNGZXMWFHYjAvQml3bHE0ZXRmZ3UrMmw2Y0NaSnB4?=
 =?utf-8?B?ZVEyYnhCVFpObk1IOTN1UnlpOUFYZW1FWFk2U0pzU0VJQTZoN290VUdtaEJp?=
 =?utf-8?B?K0FqZjFjb0JkbWNKM2p4MEltV0Y3ZHJZSVlnQmw5NFYwVklLeTBFUGRNZ243?=
 =?utf-8?B?SmVCVVRaeURoT0RBTWlESWlOaldGSEZuTWp1RG9yWmwyWjlWa3dtQWw1dzlG?=
 =?utf-8?B?bE1NaFd6T0lCZmRMZStmMzhnZFpIazRNVGQza3hIdTFlNzNOSVV4N0JYS1pC?=
 =?utf-8?B?RWlHU2E4MFZyNFJjYkFIYW1YWmxVSjIrUjdSMTRkSURZMG0rV0krcFVsbTVn?=
 =?utf-8?B?Z2l1aWNCTERuUy9OaFpHYXZjSXJzRDBsUWxzVDJqaEpsazhJc0xVQVozaFRZ?=
 =?utf-8?B?V2FaWm16ZldtTmFObHMydi95QmlqK1FPYzZ6cGJXZnpRQkFEMGpmblYxK1ll?=
 =?utf-8?B?bm82K0x4WllZSjFCRFZzczJBWW1ha1RnS1dyUnVqVHA5c0NlWEtwZTR3UnhL?=
 =?utf-8?B?ZVMyMkVwSWE1YnJJRm5UcXQxTmtPc0hHQkU1SkNCeHdmNnBWaklZdDZQWHE4?=
 =?utf-8?B?MlFJcndkcWJvN1pTQjJ0U29MenNYL3BHcFlhZTNWc2JFWTB0L09yeWpIaVB6?=
 =?utf-8?B?Qk1aemJXRDRJY0VJamRnUTF4ZE5md04zMDZHQm15UXdURmg5Mm5SU0F2Q1Nz?=
 =?utf-8?B?SWVtWWVSL0x2bFgvK1NqMGdLcHVXSEF3TFhIOEh4OUZhamMxQlBTc1VJa1k1?=
 =?utf-8?B?Ylp3b2tXcWZ4VHdua3N4TDd4anNuZEFoRDR5THFrK1YzNjUvTG0rOTB0aDdy?=
 =?utf-8?B?Z0xwb2xYN2pqUk1QMnVuQ1Axam8vc3FVRmFFcXREWkpXYzVJenZOWTVhcWs3?=
 =?utf-8?B?aFFWY1laSHpHckM5NmxlbkdkWmR0Mk1mdkRKWHYwRnNrR050Wnk5QXBRK3dh?=
 =?utf-8?B?Nm4vTVpJRFhmUlVuVjJkQkUxZ0gya2cwZ2RHT0VFZHYwNEhkQ1BadVd2UjRp?=
 =?utf-8?B?Y0JVbjhzVGIyZ2l1eDBDNTdKTjY2S1BqdU51aVVTcEFmb0FuMVdrQnBiZnp6?=
 =?utf-8?B?UjRHSmg1OTNqenJORHdrN0hLT0EwQmFqOERyWTNNL1VzUzZIcSt4NEoyWTVp?=
 =?utf-8?B?eExBL0ZLSG4rOGJKY3FkZm9kVlNXaW5oR1dPUmdFTnBMeWRTcVJpSEQwMGJR?=
 =?utf-8?B?eGlWcGRmNm9WTTBld016UFc3TW0ya1JuRER0VXVRWDRoanp1alcxUjk0eElV?=
 =?utf-8?B?TzJrWmxkenVJZjcxdXJqMU8vY1NQOTh5OGZPTzNLS1ltbERqa1dYZ3psWTBo?=
 =?utf-8?B?Nys3TmQvK1J2bTQ0cWtiOS9kRHRhZDdtSHdpSXBxcGRYMUFSRm9sWm9mZmNW?=
 =?utf-8?B?TlZUdTQ2SlJ0dGx0N2pQMWlUKzFoQzRwT1h2WmNsTy9vVytGaHJzdytFVHdx?=
 =?utf-8?B?WnYrV3VGK2ZZN1FRUVI4N1hJOXluaStPWUFKNmthV0FBaEgzSFI1MlVtTmJL?=
 =?utf-8?B?V0xiNTl3Q2lwb2wvRkMvVjRHWWk5MVdRbVAxQWY5eUhWQXp6UXJFakp0OS85?=
 =?utf-8?B?TVR6d2F1TFpCdWpuNlIwMk9CN2o0Tjdsd1kzL1ZTcldrVmMwUFo1WDBsL1Q3?=
 =?utf-8?B?MGZ0R09rSFZCcC9Gbm1tcmZmeFhnUHJOVUFPSEVraG1icERIb3VSanZJMmVZ?=
 =?utf-8?B?NDdsNVpvVG9BSDl3eG9FRE9zWnY0d3Bpc252ZFZYK2JVUTh6N2drNHloWFgx?=
 =?utf-8?B?ZnNvRFhubFoxcnZ6VllNb0dSeFQ1ZkdtQ1RHeXJSMEs4Z2F6Q21kdGc2SXJE?=
 =?utf-8?B?M1VhK2FaMStLbGsybFJGaHVBNVRPbHJCdVh4SSthL1ZzK0dhaTZmVmV5SVI4?=
 =?utf-8?B?MW1HVzIycjBWa3Nwa0ZieVk5ZXY0VDVSUWk2d1ZTWVg2eERzdWQ3S3J5QXRX?=
 =?utf-8?Q?d9pKl7Y5YFhCb2H77RmcmnuNkkp2F5krqx0JUgx5oOrhO?=
x-ms-exchange-antispam-messagedata-1: GKzWJU9OO7jz7w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2631.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c25ac67-0b9f-45aa-e6c8-08da539954ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 15:18:44.2040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nrg5vcIut5ZRzqyMWGZWCMBXmciWGRCsiTx7k+zsX8xt/rLzI1GziYi+N/hxdeiwI4ySQdrJW3fFd5+gj5ffXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1831
X-Proofpoint-GUID: XZWIywiOEquoJXJ_X0gUAaf1CAJ5gGWc
X-Proofpoint-ORIG-GUID: XZWIywiOEquoJXJ_X0gUAaf1CAJ5gGWc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_08,2022-06-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 adultscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206210065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlZmFuIE1ldHptYWNo
ZXIgPG1ldHplQHNhbWJhLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCAxNSBKdW5lIDIwMjIgMTc6
MjcNCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPjsgbGludXgtcmRt
YUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFN0ZWZhbiBNZXR6bWFjaGVyIDxtZXR6ZUBzYW1iYS5v
cmc+DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIHYyIDExLzE0XSByZG1hL3NpdzogdXNl
IGVycm9yIGFuZCBvdXQgbG9naWMgYXQNCj4gdGhlIGVuZCBvZiBzaXdfY29ubmVjdCgpDQo+IA0K
PiBUaGlzIHdpbGwgbWFrZSB0aGUgZm9sbG93aW5nIGNoYW5nZXMgZWFzaWVyLg0KPiANCj4gRml4
ZXM6IDZjNTJmZGMyNDRiNSAoInJkbWEvc2l3OiBjb25uZWN0aW9uIG1hbmFnZW1lbnQiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBTdGVmYW4gTWV0em1hY2hlciA8bWV0emVAc2FtYmEub3JnPg0KPiBDYzog
QmVybmFyZCBNZXR6bGVyIDxibXRAenVyaWNoLmlibS5jb20+DQo+IENjOiBsaW51eC1yZG1hQHZn
ZXIua2VybmVsLm9yZw0KPiAtLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2Nt
LmMgfCAxOSArKysrKysrKysrKystLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0
aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvc2l3L3Npd19jbS5jDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdf
Y20uYw0KPiBpbmRleCAzMDc0OTRjNjcwN2EuLjY2ZDkwZmM3N2NlZiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20uYw0KPiArKysgYi9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvc2l3L3Npd19jbS5jDQo+IEBAIC0xNTAyLDE0ICsxNTAyLDE5IEBAIGludCBzaXdf
Y29ubmVjdChzdHJ1Y3QgaXdfY21faWQgKmlkLCBzdHJ1Y3QNCj4gaXdfY21fY29ubl9wYXJhbSAq
cGFyYW1zKQ0KPiAgCQljZXAtPm1wYS5wZGF0YSA9IE5VTEw7DQo+ICAJfQ0KPiANCj4gLQlpZiAo
cnYgPj0gMCkgew0KPiAtCQlydiA9IHNpd19jbV9xdWV1ZV93b3JrKGNlcCwgU0lXX0NNX1dPUktf
TVBBVElNRU9VVCk7DQo+IC0JCWlmICghcnYpIHsNCj4gLQkJCXNpd19kYmdfY2VwKGNlcCwgIltR
UCAldV06IGV4aXRcbiIsIHFwX2lkKHFwKSk7DQo+IC0JCQlzaXdfY2VwX3NldF9mcmVlKGNlcCk7
DQo+IC0JCQlyZXR1cm4gMDsNCj4gLQkJfQ0KPiArCWlmIChydiA8IDApIHsNCj4gKwkJZ290byBl
cnJvcjsNCg0Kbm8gYnJhY2tldHMuDQoNCj4gKwl9DQo+ICsNCj4gKwlydiA9IHNpd19jbV9xdWV1
ZV93b3JrKGNlcCwgU0lXX0NNX1dPUktfTVBBVElNRU9VVCk7DQo+ICsJaWYgKHJ2ICE9IDApIHsN
Cj4gKwkJZ290byBlcnJvcjsNCg0Kbm8gYnJhY2tldHMNCj4gIAl9DQo+ICsNCj4gKwlzaXdfZGJn
X2NlcChjZXAsICJbUVAgJXVdOiBleGl0XG4iLCBxcF9pZChxcCkpOw0KPiArCXNpd19jZXBfc2V0
X2ZyZWUoY2VwKTsNCj4gKwlyZXR1cm4gMDsNCj4gKw0KPiAgZXJyb3I6DQo+ICAJc2l3X2RiZyhp
ZC0+ZGV2aWNlLCAiZmFpbGVkOiAlZFxuIiwgcnYpOw0KPiANCj4gLS0NCj4gMi4zNC4xDQoNCg==
