Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFFB78745B
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Aug 2023 17:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240267AbjHXPfq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Aug 2023 11:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242358AbjHXPfp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Aug 2023 11:35:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7631BE6;
        Thu, 24 Aug 2023 08:35:22 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OFKoFw019885;
        Thu, 24 Aug 2023 15:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=KBhx3FlDJVy9SPgbd/bc1x3biCboC//fIupI1Iv3B1g=;
 b=N0AXXUvZ8r7D2YFugZhFo+2/xvP7oDAyZULrVsgqna23M5HwW9Ntv6WQ/pLrRWg8PfUb
 x+7i1WksvjEny47ExCPf6ZL/Xm0ZzlTztf3aXMe7bGUYRLzdfnpV+pCppc6hu/L2C3S6
 mxJzti/vQI5HQtWHYps/L4kCBF5aFJNxt3onEGZBUz3QQktH9S5jyxT7P54LvcLSOqjv
 ibPWbhP7S1aF9AuvezVuFDItN5wJRJJEtkCSJX2jIKSZNNWR+/EWTwAFHLMt0Y/wak/U
 BU9PzB8TD+mKtLYneU3IBK4BTQjFMODALYmQla71h69ehHgoV18o3TuNmB6a0QNM48wv DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sp9rxrj5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 15:35:19 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37OFLAcb021190;
        Thu, 24 Aug 2023 15:35:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sp9rxrj59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 15:35:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcMvjdkcXhQt7YZcyIflFjNACz69oAOpX7ejTRSy8Z4XrNvvxoxjAhS1oJIpzJb13ZYFYzFMaXVL7+uzxjAqGh7/xWaq4exBDi8UKryncn8M8Ea/J/KguYoNtrg3/giS4hLR99cB/Ser9sWtH20TEM29t4xpQNPMAPS11AqJCrPEHfzdro6iMoQFLbEDck6QI4Vofvrl32Lwj7sE5Yb/GF5DTTX2a0RpUhx+l3pTnv5pc5SFabYkzTAtdNByF0O5yJHDnUmkgUcjSUFjckESgbnnAlP+vQZ3z8m7ITyaPJ3bOFpts8lN8rfmtKyuC/N1ttpV+kp+Jj+bGGsWo04j8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBhx3FlDJVy9SPgbd/bc1x3biCboC//fIupI1Iv3B1g=;
 b=gf7H19+zBUP5o0dbfrLNNDIVsxd7fyh3vTmVbb+slVN7TXGuacLuS1FIAxA5cJbnJfE53h2VNxIGT/w5bh0jinyEbm6y6Kfc+i5KgBteLmKDy009WqQOlyYiJeivCIcgbUl28UUK36u+Pf2FrDVUsKao+Ai5M6hiDFGBhbMkmUKCTrWs/1yIKn9yry0NkKnrnFn/qp0OuZVem9Q8wpps9m/yDrzEiI7jKAigzggm1uhsj0BE5J7nGHj2v43cURArABw3s3msxljosMu3yaXW94THqQIQ4G0QaTVF1Xr/o2XnGWAQnPIJ+cK9dlD412+h6SEmduT0wl+K4K1BGK6zdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by PH7PR15MB5808.namprd15.prod.outlook.com (2603:10b6:510:2b9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 15:35:17 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::c6be:f755:288b:bf2d]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::c6be:f755:288b:bf2d%4]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 15:35:17 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: Re: [bug report] blktests srp/002 hang
Thread-Topic: Re: [bug report] blktests srp/002 hang
Thread-Index: AQHZ1qCVVDb8p6KD6kuZhKuDHHdLHw==
Date:   Thu, 24 Aug 2023 15:35:17 +0000
Message-ID: <SN7PR15MB57550E846867D9A74F00DC47991DA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
 <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
 <27e31e00-74a3-6209-5ad5-1783d6e67a0d@gmail.com>
In-Reply-To: <27e31e00-74a3-6209-5ad5-1783d6e67a0d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|PH7PR15MB5808:EE_
x-ms-office365-filtering-correlation-id: 1f0801b8-d739-4ee2-c5ff-08dba4b7b7f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JEQVgU9Ndphj8mNPB8rVjzP22vuurvm25BgzpsqcKRm+5ZAVDaKA1TJGG6x7mvgGWMrRppI3GadcaHpMSaGWZw27iXO5+pqVdodnZOY68eEpGWA6O3zaQRqjyi5hj4EguNdYUvLgdKwNRR0TIKbqBG5q+zHdC/eW4ef0/kui6qMlnU2CkK2qOFHA/2TfgyqSywwF8K+PmfZw1ze6W+gG0h6S3kHt335fJ+odv3ab4o6OpUN+jjlmtiSaGKBpBjuvzTa3XiThgHT+wct2jIwqec50uQDzJFoY3gnCZaTqBJIF7mOUskN3PKky/zSCHnmNQAD29pM1VaYiUPexlDzQ10vawxvgh5LRQvyv7syuqF0XUTEy0nGXzV0gbHvmNGT46ZXEwvORE1JrDr5wccupwQs5ZYju6qYSiZ3MQQPWmw1ds3sCNcfjGvlvaZeS1L+B3ek4xb1ZChkxAgbNjHXswRNqJanLY5dJtrd/22i9hYb8NV5hthyIKMZWKnfXe77M+HCyPV7E75/mIDQfxUNlhI2WJjRplMJ4ol8dbyToMqKftoSGDf1eQfXc/ef16IgZ+tX9wd8qeVNCeq/hjp95maO4dA3aj4jm+c2vrbI6a7Np9OHSe9pVlGHFz2pEfH/T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(186009)(1800799009)(451199024)(52536014)(5660300002)(4326008)(8676002)(8936002)(83380400001)(33656002)(7696005)(55016003)(71200400001)(38100700002)(38070700005)(122000001)(76116006)(66556008)(66476007)(66946007)(64756008)(66446008)(54906003)(316002)(110136005)(478600001)(53546011)(41300700001)(9686003)(2906002)(6506007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUNFNGYwSjBCSGs4T2xkOTc1ZUxEWTdYM1dUVkRuNmd6Tlp6NVpVNFZVd0R4?=
 =?utf-8?B?MnhyNUdhWnpLNXN1dnR2WDZhU3BZWk95aXU2bG5Sb0RkemEzMk41WTFnK0tu?=
 =?utf-8?B?Yk13c0RBT1A4QjlKUnJvTVZ0TGtHc1A1QWkzeDgyYnJSdTdrQ3dGd2Q2UHhL?=
 =?utf-8?B?MTFEZDlKOEFUSXBHM3lBZHhuNWNmeTArWFZ5YmpZWlJvSDVLWlFpM3hLZjVl?=
 =?utf-8?B?V2xRS1RnR0FnNnd5TGRJRG1LRlRaT1hRNk5vSzZCZVY1dHR1Rm0yVURYZUtE?=
 =?utf-8?B?VEUySVhCZEs4MnBNZDE5NjJqT2hKclYwcWpyZS9TUjdjMkFDT1FzS0lwbXY4?=
 =?utf-8?B?Nk1tbVZ5MUZ3bjFtdDdvMmRrS1FteFF5MGZKYzMyZkJHSFVzMms3TDBoWll3?=
 =?utf-8?B?L1QzMmJ1VlBBNFlBRlA4S1pJN0g1M0plUmpaY3FJMVdjVmlPRWtqUkdKYlRD?=
 =?utf-8?B?cFZLSkNzMVF3NUthdTFQdThTSWhncGNIWFVPdGRaQmZ2cDV5VGhLYVNvZ2dt?=
 =?utf-8?B?dXk4N005Kzl2TWRWQWYzSHFReHFCeVYxOVdva1BmN0cwQVljT24xNm9wVUQw?=
 =?utf-8?B?b3laTHBLTENZVVZGV0E2M3ZwWTcvblR1Y1cwWml1N3ZYL0dtOXBKb1pZSStY?=
 =?utf-8?B?OVJSaFpmcExGUEkxZGNWWkJoTks2Nnd1ZEh4alBWQW9POXM3Z3RHeHFqVFhQ?=
 =?utf-8?B?WUdkZkI0YVcxRWg0NlhCc0RMNGx2TXh5cjB6Z21zTWRFS3lxdlFLUWdxTTVL?=
 =?utf-8?B?N096Y2pneEgxWVBPT0J5WDk2L3RzbEJUb3k1M0YrNmhGU3NRakF6T0Jjb3BC?=
 =?utf-8?B?YTVXYmJHSWxHZHNjU1dPdW5EWGpUT2FLZ2NkKzZvVElUcnh2TEI4VWZuUmgz?=
 =?utf-8?B?dDhrYmpwaFlOZGVTKzFWZ0ZML1FjbFY0WDRUWCtlUi9qd1hETDFQWS9Nd054?=
 =?utf-8?B?Q2FLRkN5dkNrRm5Dai9rVm1BSCtudnB3YWZ3eloyS0tEUEd3YlFVWmVXUmti?=
 =?utf-8?B?dllManBRVW92b3I3Nnl3RHdGYTViTlB5WWVlVUpFTjJsWG8wUFEwSnoxb2Zh?=
 =?utf-8?B?QmlBclpXYnQ2bnUvRCs4WW1kR2hYT0RFTWlvRktOUTdOM1Nyb3RqaUNIMHhI?=
 =?utf-8?B?d0dFVWpRTldpcVBmM2RSQytRNGkwK3k0Vm1oV09lczd5SmJHRTNDMGdLUk5r?=
 =?utf-8?B?ZHVYVEpxUWhLUnd0SE15TDRReW9XU1RYT0lOamFod2VYYWlhUWVCSmNTcE9y?=
 =?utf-8?B?VjBjZ3gxWHdSRis2Z0VBRzFxMVFFa0kxU0JCV2plYUQ3cThGRU5mZXhicTBR?=
 =?utf-8?B?Mzl5R29zd216MEZNMTI0RDl3azE1NXJjb1NPR2tkQjNiOXJxb0NSWnJwbFZU?=
 =?utf-8?B?Sjc1QzlYdXNza25JT1JaanQ5aDg0R25RQWhmN3VibHNHaTBTOHdKUDI3Y3l4?=
 =?utf-8?B?bUxTcFlQUlhRaVg0QmlSbDNhVGxmNHNNUnl1bDVNVFJ6Sldva1Z6WUltb3BM?=
 =?utf-8?B?N0owTWhnOGtINUJDb0pTeFdkcUFVTHdQSUk4UFZYY1didWJoc3N6a3BIdTlv?=
 =?utf-8?B?WWhEL2pDTDc3bFFuRFBZZ3pWbENQVS9qa2lVNnNUSWwzdngxNFowYmpzYVQ4?=
 =?utf-8?B?MTBQbHMxaHRDTE1ndVJLc295MTA4UFhaU3I1ajAzUmtSVHpQSlA0a1laeUN1?=
 =?utf-8?B?c0tsUHVjTWJJcmozVVBYK2xUQzQrRTdWL055d2lJamtSWHp4R3p4cys3S0V0?=
 =?utf-8?B?b1pvUW5FOXFndThONS9pSmZ3VkM4eW9jek9hZFFZeWxHdC84UmdSalJnd3M5?=
 =?utf-8?B?UXRMcThzY1RKMEhWejUxN05zWVBNQUgzT0wrL0VQb0JNei91QVcvY25OYVhu?=
 =?utf-8?B?Z095T09BVHFBblZQMEwwMmRaNXc1VjVmL1FWNzZUeU1Weld2dDZITFcvRjM4?=
 =?utf-8?B?b09DeDBzNjVFbFRhT041Q21pd21iaUNwT08zOU1nUUxYMS9mTEJWeUVnR2J3?=
 =?utf-8?B?elJKVUp2aDR3S2dDTXVhdW4zdmdDNlNuOXdNK0FPWjgrS1dsUDBYZ3JXZ24v?=
 =?utf-8?B?QlVYc0hEUTNCRlZQYkd0TzZLVFgwd0tzaUY1S0N6OTd0SHB2TldIWUc0eU15?=
 =?utf-8?B?dXdxdVl4eEJ1V1gyZzBXalRXOXBkeXQ0dUNSajE2anl0UGJseDVmcmhFYk5k?=
 =?utf-8?Q?k6zOeH2/fGriEwIkv9spPHI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0801b8-d739-4ee2-c5ff-08dba4b7b7f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 15:35:17.5195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ByPKZrwgbPF7ibPp+mQqexA/KuzCMUm/uOAcvsunU60hQPs5ATocGw80M04gL3gckbD0t2DikHdKz4x2ihLMqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5808
X-Proofpoint-ORIG-GUID: ffv3c6ohvpTbtjIfsHOE4AjHqI4XRNeJ
X-Proofpoint-GUID: a4gr90Flp_6tZeK0A0hnNjCDeO6wSFGn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_12,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=976 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240131
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9iIFBlYXJzb24gPHJw
ZWFyc29uaHBlQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCAyMyBBdWd1c3QgMjAyMyAx
ODoxOQ0KPiBUbzogQmFydCBWYW4gQXNzY2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+OyBTaGluaWNo
aXJvIEthd2FzYWtpDQo+IDxzaGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20+DQo+IENjOiBsaW51
eC1yZG1hQHZnZXIua2VybmVsLm9yZzsgbGludXgtc2NzaUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogW0VYVEVSTkFMXSBSZTogW2J1ZyByZXBvcnRdIGJsa3Rlc3RzIHNycC8wMDIgaGFuZw0K
PiANCj4gT24gOC8yMi8yMyAxMDoyMCwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiA+IE9uIDgv
MjIvMjMgMDM6MTgsIFNoaW5pY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+ID4+IENDKzogQmFydCwN
Cj4gPj4NCj4gPj4gT24gQXVnIDIxLCAyMDIzIC8gMjA6NDYsIEJvYiBQZWFyc29uIHdyb3RlOg0K
PiA+PiBbLi4uXQ0KPiA+Pj4gU2hpbmljaGlybywNCj4gPj4NCj4gPj4gSGVsbG8gQm9iLCB0aGFu
a3MgZm9yIHRoZSByZXNwb25zZS4NCj4gPj4NCj4gPj4+DQo+ID4+PiBJIGhhdmUgYmVlbiBhd2Fy
ZSBmb3IgYSBsb25nIHRpbWUgdGhhdCB0aGVyZSBpcyBhIHByb2JsZW0gd2l0aA0KPiBibGt0ZXN0
cy9zcnAuIEkgc2VlIGhhbmdzIGluDQo+ID4+PiAwMDIgYW5kIDAxMSBmYWlybHkgb2Z0ZW4uDQo+
ID4+DQo+ID4+IEkgcmVwZWF0ZWQgdGhlIHRlc3QgY2FzZSBzcnAvMDExLCBhbmQgb2JzZXJ2ZWQg
aXQgaGFuZ3MuIFRoaXMgaGFuZyBhdA0KPiBzcnAvMDExDQo+ID4+IGFsc28gY2FuIGJlIHJlY3Jl
YXRlZCBpbiBzdGFibGUgbWFubmVyLiBJIHJldmVydGVkIHRoZSBjb21taXQNCj4gOWI0YjdjMWY5
ZjU0DQo+ID4+IHRoZW4gb2JzZXJ2ZWQgdGhlIHNycC8wMTEgaGFuZyBkaXNhcHBlYXJlZC4gU28s
IEkgZ3Vlc3MgdGhlc2UgdHdvIGhhbmdzDQo+IGhhdmUNCj4gPj4gc2FtZSByb290IGNhdXNlLg0K
PiA+Pg0KPiA+Pj4gSSBoYXZlIG5vdCBiZWVuIGFibGUgdG8gZmlndXJlIG91dCB0aGUgcm9vdCBj
YXVzZSBidXQgc3VzcGVjdCB0aGF0DQo+ID4+PiB0aGVyZSBpcyBhIHRpbWluZyBpc3N1ZSBpbiB0
aGUgc3JwIGRyaXZlcnMgd2hpY2ggY2Fubm90IGhhbmRsZSB0aGUNCj4gc2xvd25lc3Mgb2YgdGhl
IHNvZnR3YXJlDQo+ID4+PiBSb0NFIGltcGxlbXRhdGlvbi4gSWYgeW91IGNhbiBnaXZlIG1lIGFu
eSBjbHVlcyBhYm91dCB3aGF0IHlvdSBhcmUNCj4gc2VlaW5nIEkgYW0gaGFwcHkgdG8gaGVscA0K
PiA+Pj4gdHJ5IHRvIGZpZ3VyZSB0aGlzIG91dC4NCj4gPj4NCj4gPj4gVGhhbmtzIGZvciBzaGFy
aW5nIHlvdXIgdGhvdWdodHMuIEkgbXlzZWxmIGRvIG5vdCBoYXZlIHNycCBkcml2ZXINCj4ga25v
d2xlZGdlLCBhbmQNCj4gPj4gbm90IHN1cmUgd2hhdCBjbHVlIEkgc2hvdWxkIHByb3ZpZGUuIElm
IHlvdSBoYXZlIGFueSBpZGVhIG9mIHRoZSBhY3Rpb24NCj4gSSBjYW4NCj4gPj4gdGFrZSwgcGxl
YXNlIGxldCBtZSBrbm93Lg0KPiA+DQo+ID4gSGkgU2hpbmljaGlybyBhbmQgQm9iLA0KPiA+DQo+
ID4gV2hlbiBJIGluaXRpYWxseSBkZXZlbG9wZWQgdGhlIFNSUCB0ZXN0cyB0aGVzZSB3ZXJlIHdv
cmtpbmcgcmVsaWFibHkgaW4NCj4gPiBjb21iaW5hdGlvbiB3aXRoIHRoZSByZG1hX3J4ZSBkcml2
ZXIuIFNpbmNlIDIwMTcgSSBmcmVxdWVudGx5IHNlZSBpc3N1ZXMNCj4gd2hlbg0KPiA+IHJ1bm5p
bmcgdGhlIFNSUCB0ZXN0cyBvbiB0b3Agb2YgdGhlIHJkbWFfcnhlIGRyaXZlciwgaXNzdWVzIHRo
YXQgSSBkbyBub3QNCj4gc2VlDQo+ID4gaWYgSSBydW4gdGhlIFNSUCB0ZXN0cyBvbiB0b3Agb2Yg
dGhlIHNvZnQtaVdBUlAgZHJpdmVyIChzaXcpLiBIb3cgYWJvdXQNCj4gPiBjaGFuZ2luZyB0aGUg
ZGVmYXVsdCBmb3IgdGhlIFNSUCB0ZXN0cyBmcm9tIHJkbWFfcnhlIHRvIHNpdyBhbmQgdG8gbGV0
DQo+IHRoZQ0KPiA+IFJETUEgY29tbXVuaXR5IHJlc29sdmUgdGhlIHJkbWFfcnhlIGlzc3Vlcz8N
Cj4gPg0KPiA+IFRoYW5rcywNCj4gPg0KPiA+IEJhcnQuDQo+ID4NCj4gDQo+IEJhcnQsDQo+IA0K
PiBJIGhhdmUgYWxzbyBzZWVuIHRoZSBzYW1lIGhhbmdzIGluIHNpdy4gTm90IGFzIGZyZXF1ZW50
bHkgYnV0IHRoZSBzYW1lDQo+IHN5bXB0b21zLg0KPiBBYm91dCBldmVyeSBtb250aCBvciBzbyBJ
IHRha2UgYW5vdGhlciBydW4gYXQgdHJ5aW5nIHRvIGZpbmQgYW5kIGZpeCB0aGlzDQo+IGJ1ZyBi
dXQNCj4gSSBoYXZlIG5vdCBzdWNjZWVkZWQgeWV0LiBJIGhhdmVuJ3Qgc2VlbiBhbnl0aGluZyB0
aGF0IGxvb2tzIGxpa2UgYmFkDQo+IGJlaGF2aW9yIGZyb20NCj4gdGhlIHJ4ZSBzaWRlIGJ1dCB0
aGF0IGRvZXNuJ3QgcHJvdmUgYW55dGhpbmcuIEkgYWxzbyBzYXcgdGhlc2UgaGFuZ3Mgb24gbXkN
Cj4gc3lzdGVtDQo+IGJlZm9yZSB0aGUgV1EgcGF0Y2ggd2VudCBpbiBpZiBteSBtZW1vcnkgc2Vy
dmVzLiBPdXQgbWFpbiBhcHBsaWNhdGlvbiBmb3INCj4gdGhpcw0KPiBkcml2ZXIgYXQgSFBFIGlz
IEx1c3RyZSB3aGljaCBpcyBhIGxpdHRsZSBkaWZmZXJlbnQgdGhhbiBTUlAgYnV0IHVzZXMgdGhl
DQo+IHNhbWUNCj4gZ2VuZXJhbCBhcHByb2FjaCB3aXRoIGZhc3QgTVJzLiBDdXJyZW50bHkgd2Ug
YXJlIGZpbmRpbmcgdGhlIGRyaXZlciB0byBiZQ0KPiBxdWl0ZSBzdGFibGUNCj4gZXZlbiB1bmRl
ciB2ZXJ5IGhlYXZ5IHN0cmVzcy4NCj4gDQo+IEkgd291bGQgYmUgaGFwcHkgdG8gY29sbGFib3Jh
dGUgd2l0aCBzb21lb25lICh5b3U/KSB3aG8ga25vd3MgdGhlIFNSUCBzaWRlDQo+IHdlbGwgdG8g
cmVzb2x2ZQ0KPiB0aGlzIGhhbmcuIEkgdGhpbmsgdGhhdCBpcyB0aGUgcXVpY2tlc3Qgd2F5IHRv
IGZpeCB0aGlzLiBJIGhhdmUgbm8gaWRlYQ0KPiB3aGF0IFNSUCBpcyB3YWl0aW5nIGZvci4NCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gDQo+IEJvYg0KDQpIaSBCYXJ0LA0KSSBzcGVudCBzb21lIHRp
bWUgdGVzdGluZyB0aGUgc3JwLzAwMiBibGt0ZXN0IHdpdGggc2l3LCBzdGlsbA0KdHJ5aW5nIHRv
IGdldCBpdCBoYW5naW5nLg0KTG9va2luZyBjbG9zZXIgaW50byB0aGUgbG9nczogV2hpbGUgbW9z
dCBvZiB0aGUgdGltZSBSRE1BIENNDQpjb25uZWN0aW9uIHNldHVwIHdvcmtzLCBJIGFsc28gc2Vl
IHNvbWUgY29ubmVjdGlvbiByZWplY3RzIGJlaW5nDQpjcmVhdGVkIGJ5IHRoZSBwYXNzaXZlIFVM
UCBzaWRlIGR1cmluZyBzZXR1cDoNCg0KWzE2ODQ4Ljc1NzkzN10gc2NzaSBob3N0MTE6IGliX3Ny
cDogUkVKIHJlY2VpdmVkDQpbMTY4NDguNzU3OTM5XSBzY3NpIGhvc3QxMTogICBSRUogcmVhc29u
IDB4ZmZmZmZmOTggDQoNClRoaXMgZG9lcyBub3QgYWZmZWN0IHRoZSBvdmVyYWxsIHN1Y2Nlc3Mg
b2YgdGhlIGN1cnJlbnQgdGVzdA0KcnVuLCBvdGhlciBjb25uZWN0IGF0dGVtcHRzIHN1Y2NlZWQg
ZXRjLiBJcyB0aGF0IGNvbm5lY3Rpb24NCnJlamVjdGlvbiBpbnRlbmRlZCBiZWhhdmlvciBvZiB0
aGUgdGVzdD8NCg0KVGhhbmtzIQ0KQmVybmFyZC4NCg==
