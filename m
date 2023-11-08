Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D404F7E5FCE
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Nov 2023 22:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjKHVOr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Nov 2023 16:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHVOq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Nov 2023 16:14:46 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095D92588
        for <linux-rdma@vger.kernel.org>; Wed,  8 Nov 2023 13:14:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ie8A+75i1P4Bkl85hNJ1AjbspwLQ4BoVkeJ7I+N39RFxUo53Zy46rQ3A+llsMTBg4umVsUFpA1TZ4goTrOdckrK/vIY7U48rDWuA3PjEjGhkFjeDT6mXnMtZeuY7VZRG9Ox1vl3Q61Lqwp76CZztZNnKbsAXi8ZhFovAUo3G29b0EQxJF4Zno1qBXF3U/+80vDuoN2qKGdhtLpxZc2UC0lMeoZDQkHFtoedOTT5suNbYHz+QL5fYdM1orqllw8dCw57ICJVjXqd6O6HdtKde/8fj9T3+PT7hdh4sLDwzME6qIkDeyQCqmBupgllQZnk0XdVYfYEm9/xY+wFFJsU2DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Exyj0JwJY2iiRFHS6pYIY55OG8LGtCYNCxJHWHnF+bc=;
 b=EWxgIIjwL5Sb0rS1IJoiYf1V+d0fXIVxAZDEx99YorTZb5yNsTzJU+kkdYwLrAjkgyyfhsXKJ3gYlomEDhFFJ6uvjQwQqk4Pe+I8TvJ/Hc0c9dew/DsJ4lHral4kKPYC7leVl3cDzGy1/CYOotr4ChGmYh9mDpiv05Ry9K3hs+rxH+Vlb0jIIO43RVAA17me9p3Px/hE1jKNxyO5cOcy5kf0ytJx7eoAOd/scuAroWK00wWeLETcGmKJxAl4ZB1fB4OHBCX/NeNR/bQPJ75nMI8OLVlOX/g6ZNH4X/cEs1Uv2sTOPVyeGk3R1sl6QA4lpOtG3jL472lIfnFCsrn7vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Exyj0JwJY2iiRFHS6pYIY55OG8LGtCYNCxJHWHnF+bc=;
 b=Z2w/3QlDhn19iF8SvYLk/n17r+tD+RhJwMvkZQf32/gUpP8Yd1GWcu0+FYVlwFdYMVVH23gHcFGpfmLmz96uFkFi8qz5NasXL8Sip8rHJxE8KFRNLFYQJOX5EtRIg19VBOQBtpm/oMUTNQCJ2nx0Ys7mGFFq6dA7HHgOsF1WF+zymrhd0XIPxuDHijElNOGC3t45hEIVBAf4lQK5D1O27zIpq2mWBnRvK0rNLqT5O8sGaZeJodzjEnvB4CL3F1+OQ/HufmsiDDCujJlt0vDpfFMRX/mRR2rb2D2NiWo5njSK7ChjrjyB29A28BwLAW20NHhaazb67kG7oDRqnxH8fw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 21:14:41 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 21:14:41 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Laurence Oberman <loberman@redhat.com>
CC:     linux-rdma <linux-rdma@vger.kernel.org>,
        "jmeneghi@redhat.com" <jmeneghi@redhat.com>,
        "jpittman@redhat.com" <jpittman@redhat.com>,
        Mark Lehrer <lehrer@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Mellanox CX6 and nvmet connectivity failure, happens on RHEL9.2
 kernels and latest 6.6 upstream
Thread-Topic: Mellanox CX6 and nvmet connectivity failure, happens on RHEL9.2
 kernels and latest 6.6 upstream
Thread-Index: AQHaEogRnSmGFxpKrku3fbnSzqqy3LBw7BsA
Date:   Wed, 8 Nov 2023 21:14:41 +0000
Message-ID: <9c980d92-0ca6-41ec-9714-f55ea0c94ccd@nvidia.com>
References: <475a37e920badad12a0d71fff65e817979417594.camel@redhat.com>
 <CADvaNzW1GYMDnD5ffTbB0wgbmWF1HNwgkikbL1=48=B2ouVGHw@mail.gmail.com>
 <27ebfe1ffb5b9e1983466f6ad3a1726b66fc0799.camel@redhat.com>
 <58dae256881123291880b1df49d99fe9ceb01944.camel@redhat.com>
 <ac4e257ff54c91c30ec2d792cf656cea1d3d741f.camel@redhat.com>
In-Reply-To: <ac4e257ff54c91c30ec2d792cf656cea1d3d741f.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB5626:EE_
x-ms-office365-filtering-correlation-id: 323c96ca-e7e6-4a98-515b-08dbe09fb90d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tNFZ6Eo5A/5NKfLoS6gGnGrfRIEtHtqGaGhEELPcKws/+YwLY+LqKxi0E4Yx0RYIFcYg2Kn+LxSP5C+Bv+/WLMyhFO1fYbEmpBj6Y1rveR7XEUPoQbAS/EYoVPy/kEXIVtZo0ueb5YxSyz7mFw6JXNnoja9yEMAUF39j5yPKCeNO2Lcv+k4cAhSaesgjBgREbCBZvHxmwNg7UMCS9RKAkXzlVb62ylpE4tcRuhtwTxlKlHoEcO5yF3Ea8uEtIwzyCNxjGW/Ht3ljt/6QFoRgIqWTN8wyWxoS5bSERzH6dzjmlnMfRLjYn3H3cmhYNbsseJ59XuhRzgpGbj5Rmqt96snptrL6WvFd6ngSMyf8qJWxZKFQXHuxg7BBbtTOOIfXjH/dUilL32f4CmK/KADdkMcvlKt7SS7c0fOXd7aosTOXUlF6WvA5CFEv1QFf/lmvlA9zQi9UM67qjfI536Nyn5CUrFACXAUhMi8eG/gfF96aWqoMUM+m8uwbDxfyJPudQKTlvb1fXQfI+VU1q1d+mRNsaDTrdBHq9wuNlJjA3i/AjSGTR6j8Ms082mt6YC4/8FyoHbAsPZbsAfZFoPFgD7LH6MJAWEJXvcjKntHDOqoflp9M47f3htggncyBCUuvz6VKV5DFzrdmr8jayEQx46PL4R10RcuqgrLoY6Ao4wxGnu0IswF1TfpCzAsVW447
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(83380400001)(31696002)(36756003)(8936002)(38070700009)(4326008)(41300700001)(86362001)(8676002)(316002)(2906002)(91956017)(76116006)(71200400001)(54906003)(6486002)(6506007)(66446008)(478600001)(6916009)(122000001)(38100700002)(66556008)(5660300002)(66946007)(6512007)(64756008)(26005)(2616005)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2VDeDVKZ1Roa253NkdFL2JPcDBjVGY2SWZUNlprMVRZTVE4aG9yK2hsT1Rn?=
 =?utf-8?B?QkorTUJXeitJTUlEb29xMzhhOEk2aTBGR1JDVzRuYW5XSDBKUDFHYjJLV2Ji?=
 =?utf-8?B?T1BQdS9DbUdVbytvRFRENXhFS3dYNTk3WEhIR0hpejV0REJsTDRMZHdiNDRO?=
 =?utf-8?B?UWNrU0cwdVBoRk8vc3V1N3dHdFR3RDQ2U0h1enRJei9kVTJQVEl3dU5VbmFi?=
 =?utf-8?B?a3BNN3dZMUYwUXlYV2NQbWptZjZXOTYza3Z3MWxiMXNJQ3VHcGdXWk5PcE5V?=
 =?utf-8?B?RlZXK3QrTXM0N2lUL01ZR21hM2Z6Q2lxKzhYNFpRZVZFd1NtR2lpTWthdm5R?=
 =?utf-8?B?Z1BiekVyVElqeFBHQTVEbURhejFoMWRoREpOcVl6R3RMWWs2dHRYbWN6LzI5?=
 =?utf-8?B?ZGxHL1k0TG1uNEpWUEdkU2lwZFpxdUJBRkNzTk5rWW5nc2JoQmp1L3BXbnRo?=
 =?utf-8?B?ckQyanUrck45UnZCNzNUTmJNeWhhMzhheG1ZMDZ3VStIdmlmdGJuM3hiUEdB?=
 =?utf-8?B?dFVKNlp0aDVRUzV6Y0FFSi9vaDhmeDFDZkhyRXF5SDI3aUpvOGdxU0NqOWd2?=
 =?utf-8?B?MS8vZURVYUZ2NVQ5c2xLOHNEbDBxNkxMbXFFZGZnZXY2SnJyWlNwMFo1ZTVH?=
 =?utf-8?B?NzhFQVY0SE5YTVBZTDlnU28wcmVMUUNaUGtkbSt3T3FUanlLVXRKUDZrNmpm?=
 =?utf-8?B?QWZUN0pZei9iN2ZuMjdNbnFQcVJOMzZoMTdUanZidnVlMEVMQTFsMm1CdUls?=
 =?utf-8?B?aEVwL2ZNZmZ1ckwxQzB6YjVxMERLdGZ6WUgwdzJha2xacGFoVXhINFB5eVNk?=
 =?utf-8?B?SHI0cGczbkVMVElGQlJTUkFWTmUrQzFGNGNRYmkwT1BoUnBPNitCMXFkV3pv?=
 =?utf-8?B?SFcrcXRwVHZQYWFXRVVqb0k5am8xMlRwN0pWcmtUQTZkVzlCRDN1NHNaZmM4?=
 =?utf-8?B?ZWErTDVwNERURWRKV0l2QWdHTEpNSWt4eitLdC9VRURVNksvVVVsU0p4ZmdW?=
 =?utf-8?B?T1ZuekM4R1J6czJNZTlLS1dRQU5vK0dsM09vNU1GZ2o5QWZLZXFmL1R6MHpD?=
 =?utf-8?B?UGdoeGdzdnIwaU41MWNudTF3QTNMcXVzS1BHcTVDQzBzWVNXVXFjaXhjSldF?=
 =?utf-8?B?cVlNNm9iUXZ6a3hYY3MvMUg0ZjBsYUtSRmpJZnRaRyttM0NLRUc5aFE3Ly9T?=
 =?utf-8?B?VUp3RGJNMkRBOFovZm16MUQ5OVMyRGNiTlB5L3RpdzBpUUVjTDdPWTVNdTRI?=
 =?utf-8?B?cTUrVzF2clFZMlFBSndMVUtMaU5EeTVwbGtyMWVmUVlnVHkrOU1LSnBQbGFq?=
 =?utf-8?B?aHhqZ242Ny8rOVd2anREMWw2VUp1cWpTTis1MGxiR2tDQWllZVluZmliRGVC?=
 =?utf-8?B?bm9ha2ZFL0lES2puTGIxZTJSNUFBMElqTFBGTjVaeVgvWEl0SVU4MW1rN3Ra?=
 =?utf-8?B?WFkwTi9va3JWYkdPQjlmdDVKYXpYajRVVW9BV3F5Sk1raVNNaENQRjJLS0hI?=
 =?utf-8?B?L2c2STN5SGtQbHRjOEthT0dTeTkxSTU3RTZYZERhL0M1ZjFlcklITXlGMCtr?=
 =?utf-8?B?Skt0RUpEZHM5MHVSQjNRMFhxYzZwYjkwV3ptaGZhM2toYSszLzNuSWJweXF4?=
 =?utf-8?B?OUJRTDFvaTBEMHozdDJSRnpLSCs1WDFpaGhLdit2eE5udTlxYTdzd1U5K3dE?=
 =?utf-8?B?TFNZV0MweE1lYWhVdDhqb0oreHVxNXJ0bXBDMllCNVRQU21sZlZvN1NScU1I?=
 =?utf-8?B?b01FY1hMTkdvUXpNSktJTGJLNEY0aW54RWttcHE3cGVZTFBhV0R4RkwyZFRQ?=
 =?utf-8?B?cWUvMzdyRy9Tb3QxU1VlSElaWWZkdHV3RVNIWGlzclRIY25xeDE4WElnUzMz?=
 =?utf-8?B?Tk8xZ1FGTVRLUmovdjF4NWVjOHBQbGdjdktYRzFhaVRiYytERk8yTzUvUk1Y?=
 =?utf-8?B?cmpMSFkrazMyTTh4TDBEd0NtMVpMcUhJRjVyQ2RxckF3VTVwaVgrbWVzejBY?=
 =?utf-8?B?Z3RhWFh6UUkrRXV5dFB0RCtFRjNYRzFyYkt2R0VERGhWZCt3TUllL0FhNWcx?=
 =?utf-8?B?ZGpwNWYrK1VkUzl4RWQrOVhrMmVieXJMcHdTc3VYekNiWmtyMTZoVjJZQlFB?=
 =?utf-8?Q?UStv41M0Rh//Gjmnw76fhr+1i?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1ACE8213BCFB64B9CD6B0A225968B3C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323c96ca-e7e6-4a98-515b-08dbe09fb90d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 21:14:41.1638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wyannh1r27TJm1gq8tOs6EvBWBhwYpPAguQuItsyMz9K4uZ2yLkTspg9ThA5M7zzkJbxFP2k9dcXeJ+F23mwGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Pj4+IEhpIE1BcmsNCj4+Pg0KPj4+IEkgbGFuZGVkIHVwIGNoYW5naW5nIHRoZSBkZWZhdWx0IGth
dG8gZnJvbSA1cyB0byAzMCBhbmQgaXRzIHdvcmtpbmcNCj4+PiBub3cNCj4+PiBXZSBkb24ndCBq
dW1wIHNoaXAgdG9vIGVhcmx5IGFueW1vcmUgYW5kIGl0IGNvbm5lY3RzIGZpbmUuDQo+Pj4gU2Vl
IHByaW9yIHJlc3BvbnNlIHdoZXJlIEkgYW5zd2VyZWQgbXkgb3duIG1lc3NhZ2UNCj4+Pg0KPj4+
IGRpZmYgLU51cnAgbGludXgtNS4xNC4wLQ0KPj4+IDI4NC4yNS4xLmVsOV8yLm9yaWcvZHJpdmVy
cy9udm1lL2hvc3QvbnZtZS5oDQo+Pj4gbGludXgtNS4xNC4wLTI4NC4yNS4xLmVsOV8yL2RyaXZl
cnMvbnZtZS9ob3N0L252bWUuaA0KPj4+IC0tLSBsaW51eC01LjE0LjAtDQo+Pj4gMjg0LjI1LjEu
ZWw5XzIub3JpZy9kcml2ZXJzL252bWUvaG9zdC9udm1lLmjCoMKgwqAyMDIzLQ0KPj4+IDA3LTIw
IDA4OjQyOjA4LjAwMDAwMDAwMCAtMDQwMA0KPj4+ICsrKyBsaW51eC01LjE0LjAtDQo+Pj4gMjg0
LjI1LjEuZWw5XzIvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5owqDCoMKgwqDCoMKgwqDCoDIwMjMt
DQo+Pj4gMTEtMDggMTQ6MTY6MzcuOTI0MTU1NDY5IC0wNTAwDQo+Pj4gQEAgLTI1LDcgKzI1LDcg
QEAgZXh0ZXJuIHVuc2lnbmVkIGludCBudm1lX2lvX3RpbWVvdXQ7DQo+Pj4gIMKgZXh0ZXJuIHVu
c2lnbmVkIGludCBhZG1pbl90aW1lb3V0Ow0KPj4+ICDCoCNkZWZpbmUgTlZNRV9BRE1JTl9USU1F
T1VUwqDCoMKgwqDCoChhZG1pbl90aW1lb3V0ICogSFopDQo+Pj4gICANCj4+PiAtI2RlZmluZSBO
Vk1FX0RFRkFVTFRfS0FUT8KgwqDCoMKgwqDCoDUNCj4+PiArI2RlZmluZSBOVk1FX0RFRkFVTFRf
S0FUT8KgwqDCoMKgwqDCoDMwDQo+Pj4gICANCj4+PiAgwqAjaWZkZWYgQ09ORklHX0FSQ0hfTk9f
U0dfQ0hBSU4NCj4+PiAgwqAjZGVmaW5lwqAgTlZNRV9JTkxJTkVfU0dfQ05UwqAgMA0KPj4+DQo+
Pj4NCj4+PiBJIHdpbGwgd2FpdCBmb3IgU2FnaSBhbmQgS2VpdGggYW5kIHRoZW4gc2VuZCBhIHBh
dGNoDQo+Pj4gSSBoYWQgdGhlIHdyb25nIGVtYWlsIGZvciBLZWl0aA0KPj4+DQo+Pj4gVGhhbmtz
IGEgbG90DQo+Pj4gTGF1cmVuY2UNCj4+Pg0KDQp5ZXMsIHdlIHJlYWxseSBkb24ndCBuZWVkIGFi
b3ZlIHBhdGNoIGFzIC1rIGNvbm5lY3Qgc2hvdWxkIHRha2Ugb2YgdGhhdA0KYXMgbWVudGlvbmVk
IGJlbG93LCBzZWVtcyBsaWtlIGl0IGdvdCByZXZvbHZlIC4uLg0KDQo+PiBIZWxsbw0KPj4NCj4+
IE5vIGZpeCBuZWVkZWQsIEkgd2FzIHVuYXdhcmUgb2YgdGhlIC1rIG9wdGlvbiBpbiB0aGUgbnZt
ZSBjb25uZWN0Lg0KPj4gTXkgY29sbGVhZ3VlIHNob3dlZCBpdCB0byBtZS4NCj4+IFRoaXMgd29y
a3Mgbm93IHRvIGdpdmUgdGhlIENYNiBsb25nZXIgdG8gaGFuZGxlIHRoZSBjb25uZWN0aW9uDQo+
Pg0KPj4gIyEvYmluL2Jhc2gNCj4+IG1vZHByb2JlIG52bWUtZmMNCj4+IG52bWUgY29ubmVjdCAt
dCByZG1hIC1uIG5xbi4yMDIzLTEwLm9yZy5kZWxsIC1hwqAgMTcyLjE4LjYwLjLCoCAtcyA0NDIw
DQo+PiAtDQo+PiBrIDMwDQo+Pg0KPj4NCj4+IFRoYW5rcw0KPj4gU28gYSBIZWFkcyB1cCBmb3Ig
dGhlc2UgbmV3ZXIgY2FyZHMgSSBndWVzcywgbmVlZCBtb3JlIHRpbWUNCj4+DQo+PiBSZWdhcmRz
DQo+PiBMYXVyZW5jZQ0KPj4NCj4+DQo+Pg0KPj4NCj4+DQo+IEZpbmFsaXppbmcgdGhpcyBkaXNj
dXNzaW9uIGFuZCBhZGRpbmcgYXBwcm9wcmlhdGUgY2Mncw0KPg0KPg0KPiBObyBwYXRjaCBuZWVk
ZWQsIEkgd2FzIHVuYXdhcmUgb2YgdGhlIC1rIG9wdGlvbiBpbiB0aGUgbnZtZSBjb25uZWN0Lg0K
PiBNeSBjb2xsZWFndWUgSm9obiBQaXR0bWFuIHNob3dlZCBpdCB0byBtZS4gYW5kIGluIGZhY3Qg
TWFyayBhbHNvDQo+IHBvaW50ZWQgaXQgb3V0IGluIGEgZm9sbG93IHVwIGVtYWlsLg0KPiBUaGlz
IHdvcmtzIG5vdyB0byBnaXZlIHRoZSBDWDYgbG9uZ2VyIHRvIGhhbmRsZSB0aGUgY29ubmVjdGlv
bi4NCj4gQy5LIFRoYW5rcyB0byB5b3UgYXMgd2VsbCBmb3IgcmVzcG9uZGluZw0KPg0KPiBJbml0
aWF0b3INCj4gIyEvYmluL2Jhc2gNCj4gbW9kcHJvYmUgbnZtZS1mYw0KPiBudm1lIGNvbm5lY3Qg
LXQgcmRtYSAtbiBucW4uMjAyMy0xMC5vcmcuZGVsbCAtYSAgMTcyLjE4LjYwLjIgIC1zIDQ0MjAN
Cj4gLWsgMzANCj4NCj4gVGhhbmtzDQo+IFNvIGEgSGVhZHMgdXAgZm9yIHRoZXNlIG5ld2VyIGNh
cmRzIEkgZ3Vlc3MsIG5lZWQgbW9yZSB0aW1lDQo+DQo+IExlYXJuIHNvbWV0aGluZyBuZXcgZXZl
cnkgZGF5DQo+DQoNCi1jaw0KDQoNCg==
