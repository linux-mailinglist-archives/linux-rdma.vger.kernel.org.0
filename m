Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7FC7D6CA5
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 15:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344326AbjJYNCX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 09:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344272AbjJYNCW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 09:02:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA7CCC
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 06:02:19 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PClQLm003167;
        Wed, 25 Oct 2023 13:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=JvW0fAAylorbHYOE8bpOym52ELoDJJptiZ6gxsrePzc=;
 b=U++CQTZbEPqtduuuEiz17MHaln3MH77/UB2LfJ0sayQ53ViGFyRnq6qbSFo0BFaEedkR
 /NkdabvDjzWj/SEsWC+fqaYnuwcuVl1iaEfY1IX2mVcNvUyyz+VhGnH7YKfJsVZ1YAxO
 eWsmpf59AldvBc6DLd7673W5RXAgauCOF5xTLXZWHprWQqwp2t4uBEqbyp5/o2x9Nopj
 twx1m7icLUZxuSEmw5qZCu+DKRYwXOGgJAEolw+/p+dCr66dCYxEWVyAU4iyhNVv37As
 6In9B0XUMU5sPBEBldLs2GpEiavpBkzPQySvnAHzFi+zVaozagtsSZz7yKvs+V8eJUdk Ag== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty3b1gmty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:02:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pq5CHmMNDqjpW3pjkDCcSawyrO/U0C49A98TJA83Zt2USg9OUGCcA8Drs8Slfe9WcpB/i/Ofank5nmUzvxdkNNmgl1kSVt8Coc6ZjTJv2Zh8raz4/N/VBMEeebnJB6atZMBsDOK9/djQmCq/arPHPQcroxL9y0h3OF6J0D0ZFOIZ45Cz4gSHdpThh8+sa9DGQOmkwidNNaOJkiTAryFZQWJMmylYfPLuDHD8wDvHIKMUJl+YTdyQ/aFPG/Vqg6lsTFhffIWjrr5rVlxpgvFt+lNUKCQ1L4G40o8pB3fdqZykHD4SGg7mDdr3DAfwNAT+ARPum6eCEQ/MBzXwn90KtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvW0fAAylorbHYOE8bpOym52ELoDJJptiZ6gxsrePzc=;
 b=AbzJBSVBudSmd87/GagSxlWR0o5F26EuXPRhbF8yb4BhpOhQlXGdwUrUJ5flfpmLs9+HVcRaNPZLADBL9kk00STNF/cd+IpAGVJGt8gvCxgIkvBnXYaN1LlcrjVvj3ZoZkGmlN+32b/7L01m0M3iFrN5b6XRKusc2DSCu3mBjSrM2HKEptFi2EEyoTqwm+igbq3FrQelAEQJLgOcODJg0zByu8CLA447DsfxlMYIPE1nYBcXXyTQp53DyrCVb/jZt8oGy70TM5CRX9j0fPOU+qXMTxAu/UtTHwd0AhijXS3W36XFt/S207JZmdAeWDGw9s8kbyP1ajuxPJG5IpAjJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by LV3PR15MB6409.namprd15.prod.outlook.com (2603:10b6:408:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.18; Wed, 25 Oct
 2023 13:02:09 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 13:02:08 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 12/19] RDMA/siw: Introduce siw_free_cm_id
Thread-Topic: [PATCH 12/19] RDMA/siw: Introduce siw_free_cm_id
Thread-Index: AQHaB0N2k2wH0LUPuEyd31+lXDWKlQ==
Date:   Wed, 25 Oct 2023 13:02:08 +0000
Message-ID: <SN7PR15MB57559DCCEC92E6B64B30873E99DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
 <20231009071801.10210-13-guoqing.jiang@linux.dev>
In-Reply-To: <20231009071801.10210-13-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|LV3PR15MB6409:EE_
x-ms-office365-filtering-correlation-id: 7ce1ea66-a211-4038-b8be-08dbd55a98bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ferpgdiMTZlIABRnhuNlCRU62lksnTPwxLmhwM6ofwZ6oDQ3qtiwfEStO3hdtWnXZWhA7rpDcmRO5ywqJkIkkQ8w9WT1blSy2XfLRIOIzoW6cSydPDPSI3suyif2u7soPEJtD58F6P5W1jFYFYhKN6cb3/+NSHaK8Z8H2ftxYVKLxykt3DrZVeWtm5et7XvGRPGL0+w0RmQz8a626C5GoioKfuFPoq9Crsw5/zy319tAufuNXTEuuQjvQI6SKcfxF+/lTrkCl58ZEuXZsv8JppLU0WhQ9NjZopeEzdEtVzj+ALvn7bHWqgpeuQFFY5YeNlloGpNEgZhEB7do4T/+WuZrik+fUtwVULQY3bQ1XglS/UPZnbgFG5a19yCWwcO9BeaugF+KQmxnuZSw9cqwbZIcWRPdGC8KdIzon/QtUu/wqSveVGr1cifOskTD6qy49LdkArxxFjFiYD25mh34fxs6IiCFvr0Rp3E62kBn8I4nxLjLQrvmyigVrIc+9+xtL94DszCHk3J4iv0DoVOaxT9VUxWf/yUjZPHFiKYOizhCbVsUesrZLHeIiesrAY9dkZouwS4eSc3ZQF+vw5tDlFnZ1KlOvwIbWauxwTCa8/DT4DOPkHhLmdxtqaxh80cy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(39860400002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(76116006)(66946007)(66556008)(66446008)(64756008)(110136005)(66476007)(83380400001)(71200400001)(33656002)(122000001)(86362001)(38100700002)(478600001)(7696005)(9686003)(53546011)(2906002)(41300700001)(6506007)(38070700009)(55016003)(8936002)(52536014)(316002)(8676002)(5660300002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmVVZ0ZCL25oVm01UHJIK0RVL0Y1aDM5L01oVTFpWFgyQ0RLcVc0a1NzR2Fn?=
 =?utf-8?B?N21OU3NidEU1SDZwejV3cno5NjMyUlhRcDNvUnRqVS95UDdjbEZmeldaTlVN?=
 =?utf-8?B?d2JnM08rS3FnY3NPVitpUWZrbkhNakV1UlFHUWdFZFE3SExDR1h4aWMwM295?=
 =?utf-8?B?TEhDUWl0R053ZHZqckZRaFB6dmhDQmZVQ1VUYzFNOW1VWi84cXFmMVBkaDdk?=
 =?utf-8?B?LzFSdk90aVJjSUVLckpKTHVvR2xZMFZWRzJ5ZTY1aHoyY3NjUmVQY1dVZWdX?=
 =?utf-8?B?M0E1eGUxbHIyL3orbmF1bk82TTJTdS9YU05MTFhjYWREbGxYaElXbEJ5YUVs?=
 =?utf-8?B?c2Z1VlJMRFU5UEdhNnRjZmUrUTBHZ0JsVXkrWDVUOFZLYUptQjZsdHhxSUVi?=
 =?utf-8?B?aXgzY0h6dTZxRmxNRnQxNE81aFdkVXNNTy9RRVZKTUhuaXplU0RuQldwbDZW?=
 =?utf-8?B?Y01NYnM5ZjlEbXVSbGFrRk5rWkxkdU04YWUyRWxhNUhrcUFBQ095MUJPeE5z?=
 =?utf-8?B?c21nSDNCNnJHVUsvUi9HVTZYY0x0SEdVaXVtZ200djY3N3hjN09MVENBT2hC?=
 =?utf-8?B?UnczOGxiSWtKcmI4cjhjUG04WWdVOFBtYnhUaHg5UjV0dGg2cHlrZndPMzJR?=
 =?utf-8?B?REw1d002SEc5M09kd0FReWpBMks1QTF2eE1GRXlPK0JuVGlsUTBha2tVOFla?=
 =?utf-8?B?cVBwVmk2MHVSMXlqK0NRRzZUL3k5SUVGNlp0RzRrcEZNYnR0VmZha0xlTjMw?=
 =?utf-8?B?RjArbkN0cldROHlTbjJYUmhvSUtMNE52MWd5bXRzcjVHTkdYZjdHeVFjV28v?=
 =?utf-8?B?TXJpeGl0ZVVxeWVlV2NHNzIyWTJ1Ri9zR3E0ZDRMQU9yL1BlMDYxM0pzeWkx?=
 =?utf-8?B?WmhRcWY1cENwdTJVSGtPOTB1dXBDbHQzbzZxUUJ6d2oyOGxxMi9rNFAyUmVS?=
 =?utf-8?B?NDhySDdVdVJVRlkxbzZicmRibnVmd3I5dTArMmJDMnVXeVhrSks4clVjSjFs?=
 =?utf-8?B?bCtxUnpEQmh3R0R4OEc0U1pOaUxvVTg4R1cvYlVjS2luU2hUOG55ZHNUOEZR?=
 =?utf-8?B?dnpzdkNBU1dJZ0NyT2FGUDNXbGtSUU5kbkx5cnpVaVlNMmNyMWkyN2dSOTR4?=
 =?utf-8?B?K00xYm05VVBZNi9mdUgvSHhwZTJyb2Z6SGtWWTJzZ05wWE1WQjNkdUg3emt4?=
 =?utf-8?B?bHJNemxKbjVQZnhKVWdHRC93ODArMkN5bWFNV1dLUktIY1d3aXpLV2loOHor?=
 =?utf-8?B?VkI2Q25oT3laOGhQZnZ5Umk0S29LL3I3NWhnZ2xEQUNxUVVRWGcxYWVreHBl?=
 =?utf-8?B?bHJST3RFRVNmc2NFdzNCRlJEek1PRkkyWndsQUp4UGl0b25hL1drNmVIcytJ?=
 =?utf-8?B?ejhFTFRjRnY1TmNUQmRJQ0ZvYzhGUjdNSFdrWXovaUpidUZiS09LenJBdWhX?=
 =?utf-8?B?a25FZTJ2aUlmdDZZak5zN1IyTXE0azdwSjlKOWtzdE9XTHBDejE3MGxYSE1T?=
 =?utf-8?B?dDAzcDJoNUFzb3JlY3ZITC9WbC9FZU95czQxMGRWd0Z5NEd4VVNkcndHam0v?=
 =?utf-8?B?UUVqam5RWVZNcitFWTFrM3M2WU5rNE51eWRBV2VaM2pUbFZ5U1ZUSG5uK2xP?=
 =?utf-8?B?Z254TE5ETWZBN3E3WGpzUElzKzNmTmYvcFFhM2szMm5JR1dFdE9na1g1dDdh?=
 =?utf-8?B?dHZHRWl0eHMrZDd0ck1mZUtFS3ZlaUphNWlJdmlXa3lacFM3aWx6WVRIR2ls?=
 =?utf-8?B?YUNGbTNsaGsvOGtCVG9PV2wxVXdBY3dRQkU0SFNvYVVKV2lDZUxMVElKMkd2?=
 =?utf-8?B?cld5aE94SnFjUHR4TTZqU2JzTVBSYUo5aVMwMWhOd1dlMVdUbnBmeEhWamI4?=
 =?utf-8?B?RTBkeEIrTHlVQ0orV2hRR1lVTmZuMzhjR21kYTgxYTZia1kydWxEd2pFL2Fw?=
 =?utf-8?B?dzRtNGdzMFljS0NUWmpGYmRBNTlVOVFqNUd4UnV2Mng3U2h4R1haZkhKS09x?=
 =?utf-8?B?b2txRVFSZVFjeWE5WEFNN1I1amlQUFhSUWpKSlJIRWJaY0J2RVBhZlV1SSt6?=
 =?utf-8?B?WnFPVXVJRVlNV2xRR2VIYmo3d0R5U0wxN1RQQnc3RCs5RGRLQ0d4S0xwRDFX?=
 =?utf-8?B?Q1J5cmFqWHFjZzRGUkxwbGhBTytlTjU3SW5VaWlMTmZIUEdkNmpXdWtJZ3My?=
 =?utf-8?Q?gvMryZfToN9dAboM1gGpTnk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce1ea66-a211-4038-b8be-08dbd55a98bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 13:02:08.9132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IaACEBZkYo4N23l8kllsU+ZaSUJiiz3/PtqicouxPFC18Bz3yhQwm+gwtMY9MMOrPmBLdGpfi5UrZv3nKXPpDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR15MB6409
X-Proofpoint-GUID: gh0vCRQou-esH1NaV7aNwnu3xYdfixUI
X-Proofpoint-ORIG-GUID: gh0vCRQou-esH1NaV7aNwnu3xYdfixUI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 mlxscore=0 mlxlogscore=917 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciA5LCAyMDIz
IDk6MTggQU0NCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPjsgamdn
QHppZXBlLmNhOyBsZW9uQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIDEyLzE5XSBSRE1BL3NpdzogSW50cm9k
dWNlIHNpd19mcmVlX2NtX2lkDQo+IA0KPiBGYWN0b3Igb3V0IGEgaGVscGVyIHRvIHNpbXBsaWZ5
IGNvZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBHdW9xaW5nIEppYW5nIDxndW9xaW5nLmppYW5n
QGxpbnV4LmRldj4NCj4gLS0tDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19jbS5j
IHwgMzYgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MTYgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20uYw0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9z
dy9zaXcvc2l3X2NtLmMNCj4gaW5kZXggMmYzMzhiYjNhMjRjLi45ODcwODQ4Mjg3ODYgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NtLmMNCj4gKysrIGIvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20uYw0KPiBAQCAtMzY0LDYgKzM2NCwxNyBAQCBz
dGF0aWMgaW50IHNpd19jbV91cGNhbGwoc3RydWN0IHNpd19jZXAgKmNlcCwgZW51bQ0KPiBpd19j
bV9ldmVudF90eXBlIHJlYXNvbiwNCj4gIAlyZXR1cm4gaWQtPmV2ZW50X2hhbmRsZXIoaWQsICZl
dmVudCk7DQo+ICB9DQo+IA0KPiArdm9pZCBzaXdfZnJlZV9jbV9pZChzdHJ1Y3Qgc2l3X2NlcCAq
Y2VwLCBib29sIHB1dF9jZXApDQo+ICt7DQo+ICsJaWYgKCFjZXAtPmNtX2lkKQ0KPiArCQlyZXR1
cm47DQo+ICsNCj4gKwljZXAtPmNtX2lkLT5yZW1fcmVmKGNlcC0+Y21faWQpOw0KPiArCWNlcC0+
Y21faWQgPSBOVUxMOw0KDQpJIHN1Z2dlc3Qgbm90IGluY2x1ZGluZyBjZXBfcHV0KCkgaGVyZSwg
YnV0IHRvIGtlZXANCmNlcCByZWZlcmVuY2UgY291bnRpbmcgZXhwbGljaXQgaW4gdGhlIGNvZGUu
DQoNCj4gKwlpZiAocHV0X2NlcCkNCj4gKwkJc2l3X2NlcF9wdXQoY2VwKTsNCj4gK30NCj4gKw0K
PiAgLyoNCj4gICAqIHNpd19xcF9jbV9kcm9wKCkNCj4gICAqDQo+IEBAIC00MTUsOSArNDI2LDcg
QEAgdm9pZCBzaXdfcXBfY21fZHJvcChzdHJ1Y3Qgc2l3X3FwICpxcCwgaW50IHNjaGVkdWxlKQ0K
PiAgCQkJZGVmYXVsdDoNCj4gIAkJCQlicmVhazsNCj4gIAkJCX0NCj4gLQkJCWNlcC0+Y21faWQt
PnJlbV9yZWYoY2VwLT5jbV9pZCk7DQo+IC0JCQljZXAtPmNtX2lkID0gTlVMTDsNCj4gLQkJCXNp
d19jZXBfcHV0KGNlcCk7DQo+ICsJCQlzaXdfZnJlZV9jbV9pZChjZXAsIHRydWUpOw0KPiAgCQl9
DQo+ICAJCWNlcC0+c3RhdGUgPSBTSVdfRVBTVEFURV9DTE9TRUQ7DQo+IA0KPiBAQCAtMTE3NSwx
MSArMTE4NCw3IEBAIHN0YXRpYyB2b2lkIHNpd19jbV93b3JrX2hhbmRsZXIoc3RydWN0IHdvcmtf
c3RydWN0DQo+ICp3KQ0KPiAgCQkJc29ja19yZWxlYXNlKGNlcC0+c29jayk7DQo+ICAJCQljZXAt
PnNvY2sgPSBOVUxMOw0KPiAgCQl9DQo+IC0JCWlmIChjZXAtPmNtX2lkKSB7DQo+IC0JCQljZXAt
PmNtX2lkLT5yZW1fcmVmKGNlcC0+Y21faWQpOw0KPiAtCQkJY2VwLT5jbV9pZCA9IE5VTEw7DQo+
IC0JCQlzaXdfY2VwX3B1dChjZXApOw0KPiAtCQl9DQo+ICsJCXNpd19mcmVlX2NtX2lkKGNlcCwg
dHJ1ZSk7DQo+ICAJfQ0KPiAgCXNpd19jZXBfc2V0X2ZyZWUoY2VwKTsNCj4gIAlzaXdfcHV0X3dv
cmsod29yayk7DQo+IEBAIC0xNzAyLDEwICsxNzA3LDcgQEAgaW50IHNpd19hY2NlcHQoc3RydWN0
IGl3X2NtX2lkICppZCwgc3RydWN0DQo+IGl3X2NtX2Nvbm5fcGFyYW0gKnBhcmFtcykNCj4gDQo+
ICAJY2VwLT5zdGF0ZSA9IFNJV19FUFNUQVRFX0NMT1NFRDsNCj4gDQo+IC0JaWYgKGNlcC0+Y21f
aWQpIHsNCj4gLQkJY2VwLT5jbV9pZC0+cmVtX3JlZihpZCk7DQo+IC0JCWNlcC0+Y21faWQgPSBO
VUxMOw0KPiAtCX0NCj4gKwlzaXdfZnJlZV9jbV9pZChjZXAsIGZhbHNlKTsNCj4gIAlpZiAocXAt
PmNlcCkgew0KPiAgCQlzaXdfY2VwX3B1dChjZXApOw0KPiAgCQlxcC0+Y2VwID0gTlVMTDsNCj4g
QEAgLTE4ODAsMTAgKzE4ODIsNyBAQCBpbnQgc2l3X2NyZWF0ZV9saXN0ZW4oc3RydWN0IGl3X2Nt
X2lkICppZCwgaW50DQo+IGJhY2tsb2cpDQo+ICAJaWYgKGNlcCkgew0KPiAgCQlzaXdfY2VwX3Nl
dF9pbnVzZShjZXApOw0KPiANCj4gLQkJaWYgKGNlcC0+Y21faWQpIHsNCj4gLQkJCWNlcC0+Y21f
aWQtPnJlbV9yZWYoY2VwLT5jbV9pZCk7DQo+IC0JCQljZXAtPmNtX2lkID0gTlVMTDsNCj4gLQkJ
fQ0KPiArCQlzaXdfZnJlZV9jbV9pZChjZXAsIGZhbHNlKTsNCj4gIAkJY2VwLT5zb2NrID0gTlVM
TDsNCj4gIAkJc2l3X3NvY2tldF9kaXNhc3NvYyhzKTsNCj4gIAkJY2VwLT5zdGF0ZSA9IFNJV19F
UFNUQVRFX0NMT1NFRDsNCj4gQEAgLTE5MTIsMTAgKzE5MTEsNyBAQCBzdGF0aWMgdm9pZCBzaXdf
ZHJvcF9saXN0ZW5lcnMoc3RydWN0IGl3X2NtX2lkICppZCkNCj4gDQo+ICAJCXNpd19jZXBfc2V0
X2ludXNlKGNlcCk7DQo+IA0KPiAtCQlpZiAoY2VwLT5jbV9pZCkgew0KPiAtCQkJY2VwLT5jbV9p
ZC0+cmVtX3JlZihjZXAtPmNtX2lkKTsNCj4gLQkJCWNlcC0+Y21faWQgPSBOVUxMOw0KPiAtCQl9
DQo+ICsJCXNpd19mcmVlX2NtX2lkKGNlcCwgZmFsc2UpOw0KPiAgCQlpZiAoY2VwLT5zb2NrKSB7
DQo+ICAJCQlzaXdfc29ja2V0X2Rpc2Fzc29jKGNlcC0+c29jayk7DQo+ICAJCQlzb2NrX3JlbGVh
c2UoY2VwLT5zb2NrKTsNCj4gLS0NCj4gMi4zNS4zDQoNCg==
