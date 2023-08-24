Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5770786ACE
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Aug 2023 10:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjHXI4c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Aug 2023 04:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbjHXI4K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Aug 2023 04:56:10 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3D410D3;
        Thu, 24 Aug 2023 01:56:04 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37O8ghkp027649;
        Thu, 24 Aug 2023 08:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=5yCgIiTqqTVJubNjSyxugA722hdBWvorw4GKIGvos9o=;
 b=nGfJbM5E81XeCLMaU8JF/ZwJhJwks2sG/XTGjnkJ9bq1gwUDhjtZB0LSLfpDZW0ajNR3
 VtC3XlQkFv8vv4CrT+8vNLVEDa87Ni/YmU0WpAE3RBY0G4Z8kvFBWWgrpFy2wfshscun
 BAza7on66QRInlc+NtiFIIIpXvfqxyKjSZH9GSywks40L/OAdv3+3InG3GNKEY5Vv1XV
 k0OH/0gWRlkYpZ7otDNktTnCJVCpKY3EOYILNOhOe8Xl46xiBAh7FxORS9E022PsRYtw
 FK91AviYXkji4MsR9qxJt++7MLh/JYC2o7GAtcEXd1L985bn7n/9zR7ksZ462E3CFR7E aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sp3anhd7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 08:55:59 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37O8hHO5030647;
        Thu, 24 Aug 2023 08:55:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sp3anhd70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 08:55:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enQu9Sk1BPAB0pXqs349rRewns8+oHiSiCcm+TnG/nCjWih3JBo8GXN3TQoHx+syhfGYVRwEvFeOrFzFkoIHmx8GWqCrdpFY8OfwDbhjmP39nX+YFbpgQGXkwsA/hXAjZEYjH1mnG7AMakTGTnzJ2PDHmO6upgoj9nkiM/56GbuANHSImNINmEL9QfoHYyrcJUwDP/n7lg3cRzLeneMj44YkD1w6sIHzR54TISy4Q7vtpDGyzbbOO6dzw6yX27Tl+0ayse9btQjDfVevbyzBRL2VwFypprw4zuVV5lnbexGOgcQErT7y687PTX3KxXLtXXL7mUVS0qErNZKG5yMhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yCgIiTqqTVJubNjSyxugA722hdBWvorw4GKIGvos9o=;
 b=FDx1ddXOYgdHGdVQPfmRPj9858KjLXIQG0Tt7bf76wIa7qxq9naTRcN9rFbvAJLPEXeubxmYyvWjOB/1pV0noYx3UpVL1pPbdElNvqiJs9Ut/M/j1H3e2VQMZ9RAbizzIcITcWcapxv+9VRnZjuH5YkG9UGe5uufwXGkz8gZ36beJxrZJvqkbLllN1tYG1oA4QqgbKTB5nNlHf01Y5ddhyrUZxiMsoOl71wI79i+aYb1eVJfdxoARTcclSs7Bjm1IJdJM6qeOAt8R6Jo7nK9ujuca6xITT1HUlv8pxn14AWnw2LGb1HzqsFuHLBtPOl3//aNvh6Sdy8Iksj5tOMuXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by CY8PR15MB5507.namprd15.prod.outlook.com (2603:10b6:930:92::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 08:55:56 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::c6be:f755:288b:bf2d]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::c6be:f755:288b:bf2d%4]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 08:55:56 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: Re: [bug report] blktests srp/002 hang
Thread-Topic: Re: [bug report] blktests srp/002 hang
Thread-Index: AQHZ1mjL7yLDlL8Jx0CmtqUwuqVrpQ==
Date:   Thu, 24 Aug 2023 08:55:56 +0000
Message-ID: <SN7PR15MB57554C3F707100A7A019795D991DA@SN7PR15MB5755.namprd15.prod.outlook.com>
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
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|CY8PR15MB5507:EE_
x-ms-office365-filtering-correlation-id: 39cf66dd-596c-4cbe-99b3-08dba47fee03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FONZiJMnQcLXWcR1h/b6H3/G9bB3ES3v/3KmfzCWlDq6Zbn8rKvegHDhMvKG3HO451lLJ8uDeaWO8rTNJMQD0kV3f3jeyUVwZDGG8QwgSDpUP1Z9JIi6Y5cnu/9N45bid1GgkC0Fgmi3EtCIbW/l2brZnG1g0wI39DbK4707CNuCb7CGhGwlnXrh53fTExze4WH1NGEzO9aeI6fWRxZ5rybZ1HzO//PJEdUddW5qGe7U992aRhtuH1vA9YfJFpXvGflaW0h7c2Nw+xSGnbG8jc8QNaLpAUtW1mXW183pBH7JTaA5A+WTJxNpLtdR5eelbv+usnAuhTmyP6M7Wy30Su7Mmsnh6oJ/M7t3wrohkdQu2oK7PFjmZGlDn+vj9n71iEWQ6pQTFsNbtZXKI2gC1iTDmh67l7ongWGpDs7IeG8SzGYShPVOm3MqmxlptDcc+eCT6L3ayqjX61O7ytivczEqBeq1JbD2l9CTS1NUz4H49Uo9fBLdT60ZdK6OyFtSbECbV4WwmZSo7pejPFqz9Zf5tlEP0yoTuUW57ccfXlA93bsylfvCuu9jbxzgFWrwLgVDF3pIILtWHegctZuXYxdroChkt0h7hcO0Giy6tPpG2ic7mLgbZ0zUpxCw9/Ez
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(1800799009)(186009)(451199024)(64756008)(66446008)(66476007)(54906003)(66946007)(76116006)(66556008)(316002)(122000001)(478600001)(110136005)(55016003)(38100700002)(38070700005)(33656002)(71200400001)(41300700001)(53546011)(6506007)(7696005)(86362001)(2906002)(9686003)(4326008)(8676002)(8936002)(83380400001)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHNLQWJ4UllWK2tsMGRzLzBnenNhdWRSUGJPTzAySUo0dGxXakoweW9iSXQy?=
 =?utf-8?B?d1hoWVVVaW0wV0d0THg0YUlkZi9ma2Nqc0J6dXNhRXVjaXB4UjQ0NnNPTnFC?=
 =?utf-8?B?SFZrVVJ0aUNhVkJyeS90YkxyUFhoUDR3YXZRdW9JYlZnbDYvUmdjVUlhTVlE?=
 =?utf-8?B?QWNuRllrcnNrN3FtR2txZGVBYTFvbHBrdHo3YUZIdXJtSmJnSDBXNzYvRkV6?=
 =?utf-8?B?N09QRGtRU0VKY2VrN2JueHN3djhzTENMeGpNMm5MRjlmS3RSTElRdXQ3b0p5?=
 =?utf-8?B?VWp5bDFRMXBSNDNJanViVzVaNzJQWGhoWTlETnk1M0RYaW45amwwd0d3VFdF?=
 =?utf-8?B?NmhscjhiOE0zY2ZLSVcycVgxSmpKZEV4N3Jmd1NuVUMrWFdveFg1OXZrMW5Z?=
 =?utf-8?B?ZXlMUkhzT1llck4vbmIxdlZ4OWFrTStwaVk3QUpBaGNwZkNyT2lWV3FzWEt1?=
 =?utf-8?B?M3VxMG1ZUWQwOFBzTnJBQ29yaUNLbVNDZ2ZMTHE3KzlNQUIyNWQ2N1l2Qnp0?=
 =?utf-8?B?NW93NTZaRVk4RlNKTTJwMFAydHYyTzVoQi9CTEVSM3JOQ2xxRnlicmNLRGVl?=
 =?utf-8?B?YUZSMmpyNTV2NERRbytoSXpzWTVSZDBsaHMyR0daQWsvbmwza0Fma25Ma09Y?=
 =?utf-8?B?dkhJSG0zUC9kQlBIUzNSVW1rNnFHQy9Yc2hLdFMxTU9oWnFSQ0lTbXdXd0hl?=
 =?utf-8?B?S2ptMUFTN0FFZkpVVTlDWlpDemk0VDU1U3ZZalVnTG5MYWVuR2RjWitLMWhi?=
 =?utf-8?B?WVpXSUdGQUhhWFlqZmJoQU5CTWwwamRiQTlhTkdCVFVWSVcrNFQ4M3dNckJC?=
 =?utf-8?B?UTAzRnZBNW9pOVh1ZUsvaWJ1NDJlWWVmRU1kMituNlJhUGo2bXdiTVkxOXdk?=
 =?utf-8?B?YkZPVU9GS2Nyb29qYU5kS0IwMGxZMkZ2SFBCMUtOZzFkTVBHNFJWNDNzV0NF?=
 =?utf-8?B?RnZ1NzJjMklQQUhRYTVCaVd1VkxhRkx0TnlpOHdQZDdkNExOUDRTUW9OQkdt?=
 =?utf-8?B?K05wMEI2ZncvdUIyQlcvaExHdE5GWEhhOVBIVDBKVTJPb1FjWG13U3oyUE5L?=
 =?utf-8?B?SVdORWFJQWQ3MjNvbE9jNEFOb01BSytHYW1SZ1N1VW1CU0p4aFFmcDRMVHlh?=
 =?utf-8?B?ZWZrOGlPL1UvSHNaVHZYTlNsV0wwRE1EdkFVczZoL1UrSXdueFJOQ21zS1pO?=
 =?utf-8?B?dDJ2dCtNdVM1OUh2THl2WVd4TUdranlpM2hhcm5WWXJnRldhZW9IcDRaamVP?=
 =?utf-8?B?Y0JSMnR2TmtBOTdKNEQvb3RMTWh3RUQ0SnZ1Q0RtdWZIbVVhbU85QnRDV1BH?=
 =?utf-8?B?N0dDc3drL3kraXJwVG9mcS9yNVltQ3NTSmswSUtIVngzOWxvWDBHWWJReGN3?=
 =?utf-8?B?d0YrWWRHS1NJOFRSVVF6U3RveExWTGt5RzkvTXR0RHhaOU1kQXNjSWpJWHFN?=
 =?utf-8?B?U3U4Ti9vVEgrcHJwRG9rRHpINmtORVZITFB4elFiUy9CZkt2dEZudC94cjhH?=
 =?utf-8?B?ZHR0ekx5alNNQ3dPSksrZElxNVEyU25yejBuR0FkSE9lWnMxNkNWMFp6MnE2?=
 =?utf-8?B?OEltSFFQelFZV0M0ZUg1ZGhyUFlKaTNBRlg1NldOZ3c4ZGxsWnhzWmVlK29q?=
 =?utf-8?B?dE5kTGFLNDIySzRCVTBMZk9VenkvTlJTSTZVbTJRVXA3ZUlZenlXb0JGYktU?=
 =?utf-8?B?RW1XUEk4NmVwOHlwNzIzTGNibkxYaDZRYXY5ZW95RUJsaDZQb0dHLytGb2pp?=
 =?utf-8?B?VEhsYjMwcGVIRDM4cGVuUGprZC9kVDFmU3JvMkR2ODY3UVZCZ2ZaejBNbG1B?=
 =?utf-8?B?V2t1TUtSNmZTRHNLRG9UK1lWZks3eHFjNkozZmZGQmVWYUdsKzRrRytMSUVW?=
 =?utf-8?B?UCtUTjk4SUNRYmxYeWxLb0g2MzRJSUg2MWJoRVdyLzlOZGpjZUVuN0RmMGpm?=
 =?utf-8?B?UjZ3OUQzWHlDNWJOUGE5R0VmMThsN2R1cWptRktsa0dJa2daNUFJVkxTK0tN?=
 =?utf-8?B?ZkNBVGhlVVBuRW9IM25IaFFsWkxjS1RLYTlQQ3RuYmtzbGsrRkdHRkw1VnlT?=
 =?utf-8?B?WkdnYjRuY3RHbFA2bFlQY2NXUUhjOGJobGlGRTJMdlVNVlVGTDVsYnFtU1gv?=
 =?utf-8?B?QUdEVGdVaFl3allxeE93RWhEREg2WmVrUStPZWgyUTJFUnVxN29tYTMzd0dP?=
 =?utf-8?Q?7UKXyYd8EGqS0yDhVckGoJA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cf66dd-596c-4cbe-99b3-08dba47fee03
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 08:55:56.4057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKi2le/U09tv4wtpT8cy6gqVtOjdz52U3qhbw5KMv/mIXzZFtdCqDj3SOc86e6glVj41WWVLX8nrR8840zcOLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR15MB5507
X-Proofpoint-ORIG-GUID: rQNWAIGu1WsfA8pCKpUnVV3waKSWw8Bk
X-Proofpoint-GUID: w7gzBTYpCFiFjugQfIutffHdHSNS4hw0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_06,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=859
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308240068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJvYiBQZWFyc29uIDxycGVh
cnNvbmhwZUBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgMjMgQXVndXN0IDIwMjMgMTg6
MTkNCj4gVG86IEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPjsgU2hpbmljaGly
byBLYXdhc2FraQ0KPiA8c2hpbmljaGlyby5rYXdhc2FraUB3ZGMuY29tPg0KPiBDYzogbGludXgt
cmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXNjc2lAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFtFWFRFUk5BTF0gUmU6IFtidWcgcmVwb3J0XSBibGt0ZXN0cyBzcnAvMDAyIGhhbmcNCj4g
DQo+IE9uIDgvMjIvMjMgMTA6MjAsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gPiBPbiA4LzIy
LzIzIDAzOjE4LCBTaGluaWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiA+PiBDQys6IEJhcnQsDQo+
ID4+DQo+ID4+IE9uIEF1ZyAyMSwgMjAyMyAvIDIwOjQ2LCBCb2IgUGVhcnNvbiB3cm90ZToNCj4g
Pj4gWy4uLl0NCj4gPj4+IFNoaW5pY2hpcm8sDQo+ID4+DQo+ID4+IEhlbGxvIEJvYiwgdGhhbmtz
IGZvciB0aGUgcmVzcG9uc2UuDQo+ID4+DQo+ID4+Pg0KPiA+Pj4gSSBoYXZlIGJlZW4gYXdhcmUg
Zm9yIGEgbG9uZyB0aW1lIHRoYXQgdGhlcmUgaXMgYSBwcm9ibGVtIHdpdGgNCj4gYmxrdGVzdHMv
c3JwLiBJIHNlZSBoYW5ncyBpbg0KPiA+Pj4gMDAyIGFuZCAwMTEgZmFpcmx5IG9mdGVuLg0KPiA+
Pg0KPiA+PiBJIHJlcGVhdGVkIHRoZSB0ZXN0IGNhc2Ugc3JwLzAxMSwgYW5kIG9ic2VydmVkIGl0
IGhhbmdzLiBUaGlzIGhhbmcgYXQNCj4gc3JwLzAxMQ0KPiA+PiBhbHNvIGNhbiBiZSByZWNyZWF0
ZWQgaW4gc3RhYmxlIG1hbm5lci4gSSByZXZlcnRlZCB0aGUgY29tbWl0DQo+IDliNGI3YzFmOWY1
NA0KPiA+PiB0aGVuIG9ic2VydmVkIHRoZSBzcnAvMDExIGhhbmcgZGlzYXBwZWFyZWQuIFNvLCBJ
IGd1ZXNzIHRoZXNlIHR3byBoYW5ncw0KPiBoYXZlDQo+ID4+IHNhbWUgcm9vdCBjYXVzZS4NCj4g
Pj4NCj4gPj4+IEkgaGF2ZSBub3QgYmVlbiBhYmxlIHRvIGZpZ3VyZSBvdXQgdGhlIHJvb3QgY2F1
c2UgYnV0IHN1c3BlY3QgdGhhdA0KPiA+Pj4gdGhlcmUgaXMgYSB0aW1pbmcgaXNzdWUgaW4gdGhl
IHNycCBkcml2ZXJzIHdoaWNoIGNhbm5vdCBoYW5kbGUgdGhlDQo+IHNsb3duZXNzIG9mIHRoZSBz
b2Z0d2FyZQ0KPiA+Pj4gUm9DRSBpbXBsZW10YXRpb24uIElmIHlvdSBjYW4gZ2l2ZSBtZSBhbnkg
Y2x1ZXMgYWJvdXQgd2hhdCB5b3UgYXJlDQo+IHNlZWluZyBJIGFtIGhhcHB5IHRvIGhlbHANCj4g
Pj4+IHRyeSB0byBmaWd1cmUgdGhpcyBvdXQuDQo+ID4+DQo+ID4+IFRoYW5rcyBmb3Igc2hhcmlu
ZyB5b3VyIHRob3VnaHRzLiBJIG15c2VsZiBkbyBub3QgaGF2ZSBzcnAgZHJpdmVyDQo+IGtub3ds
ZWRnZSwgYW5kDQo+ID4+IG5vdCBzdXJlIHdoYXQgY2x1ZSBJIHNob3VsZCBwcm92aWRlLiBJZiB5
b3UgaGF2ZSBhbnkgaWRlYSBvZiB0aGUgYWN0aW9uDQo+IEkgY2FuDQo+ID4+IHRha2UsIHBsZWFz
ZSBsZXQgbWUga25vdy4NCj4gPg0KPiA+IEhpIFNoaW5pY2hpcm8gYW5kIEJvYiwNCj4gPg0KPiA+
IFdoZW4gSSBpbml0aWFsbHkgZGV2ZWxvcGVkIHRoZSBTUlAgdGVzdHMgdGhlc2Ugd2VyZSB3b3Jr
aW5nIHJlbGlhYmx5IGluDQo+ID4gY29tYmluYXRpb24gd2l0aCB0aGUgcmRtYV9yeGUgZHJpdmVy
LiBTaW5jZSAyMDE3IEkgZnJlcXVlbnRseSBzZWUgaXNzdWVzDQo+IHdoZW4NCj4gPiBydW5uaW5n
IHRoZSBTUlAgdGVzdHMgb24gdG9wIG9mIHRoZSByZG1hX3J4ZSBkcml2ZXIsIGlzc3VlcyB0aGF0
IEkgZG8gbm90DQo+IHNlZQ0KPiA+IGlmIEkgcnVuIHRoZSBTUlAgdGVzdHMgb24gdG9wIG9mIHRo
ZSBzb2Z0LWlXQVJQIGRyaXZlciAoc2l3KS4gSG93IGFib3V0DQo+ID4gY2hhbmdpbmcgdGhlIGRl
ZmF1bHQgZm9yIHRoZSBTUlAgdGVzdHMgZnJvbSByZG1hX3J4ZSB0byBzaXcgYW5kIHRvIGxldA0K
PiB0aGUNCj4gPiBSRE1BIGNvbW11bml0eSByZXNvbHZlIHRoZSByZG1hX3J4ZSBpc3N1ZXM/DQo+
ID4NCj4gPiBUaGFua3MsDQo+ID4NCj4gPiBCYXJ0Lg0KPiA+DQo+IA0KPiBCYXJ0LA0KPiANCj4g
SSBoYXZlIGFsc28gc2VlbiB0aGUgc2FtZSBoYW5ncyBpbiBzaXcuIE5vdCBhcyBmcmVxdWVudGx5
IGJ1dCB0aGUgc2FtZQ0KPiBzeW1wdG9tcy4NCg0KSSBkaWQgbm90IGhlYXIgYWJvdXQgdGhhdCBv
bmUgZm9ybSBzaXcgc2lkZSwgYnV0IHdpbGwgdHJ5IHRvIG1ha2UgdXAgc29tZQ0KdGltZSB0byBy
ZXByb2R1Y2UgaXQgYW5kIGZpeCBzaXcgaW4gY2FzZS4gSSdsbCBsZXQgeW91IGtub3cgaWYgSSBm
aW5kDQpzb21ldGhpbmcsIEJvYi4NCg0KQmVybmFyZC4NCg0KPiBBYm91dCBldmVyeSBtb250aCBv
ciBzbyBJIHRha2UgYW5vdGhlciBydW4gYXQgdHJ5aW5nIHRvIGZpbmQgYW5kIGZpeCB0aGlzDQo+
IGJ1ZyBidXQNCj4gSSBoYXZlIG5vdCBzdWNjZWVkZWQgeWV0LiBJIGhhdmVuJ3Qgc2VlbiBhbnl0
aGluZyB0aGF0IGxvb2tzIGxpa2UgYmFkDQo+IGJlaGF2aW9yIGZyb20NCj4gdGhlIHJ4ZSBzaWRl
IGJ1dCB0aGF0IGRvZXNuJ3QgcHJvdmUgYW55dGhpbmcuIEkgYWxzbyBzYXcgdGhlc2UgaGFuZ3Mg
b24gbXkNCj4gc3lzdGVtDQo+IGJlZm9yZSB0aGUgV1EgcGF0Y2ggd2VudCBpbiBpZiBteSBtZW1v
cnkgc2VydmVzLiBPdXQgbWFpbiBhcHBsaWNhdGlvbiBmb3INCj4gdGhpcw0KPiBkcml2ZXIgYXQg
SFBFIGlzIEx1c3RyZSB3aGljaCBpcyBhIGxpdHRsZSBkaWZmZXJlbnQgdGhhbiBTUlAgYnV0IHVz
ZXMgdGhlDQo+IHNhbWUNCj4gZ2VuZXJhbCBhcHByb2FjaCB3aXRoIGZhc3QgTVJzLiBDdXJyZW50
bHkgd2UgYXJlIGZpbmRpbmcgdGhlIGRyaXZlciB0byBiZQ0KPiBxdWl0ZSBzdGFibGUNCj4gZXZl
biB1bmRlciB2ZXJ5IGhlYXZ5IHN0cmVzcy4NCj4gDQo+IEkgd291bGQgYmUgaGFwcHkgdG8gY29s
bGFib3JhdGUgd2l0aCBzb21lb25lICh5b3U/KSB3aG8ga25vd3MgdGhlIFNSUCBzaWRlDQo+IHdl
bGwgdG8gcmVzb2x2ZQ0KPiB0aGlzIGhhbmcuIEkgdGhpbmsgdGhhdCBpcyB0aGUgcXVpY2tlc3Qg
d2F5IHRvIGZpeCB0aGlzLiBJIGhhdmUgbm8gaWRlYQ0KPiB3aGF0IFNSUCBpcyB3YWl0aW5nIGZv
ci4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gDQo+IEJvYg0K
