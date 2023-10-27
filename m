Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06267D98C9
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 14:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345787AbjJ0MpV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 08:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345890AbjJ0MpT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 08:45:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96332FA
        for <linux-rdma@vger.kernel.org>; Fri, 27 Oct 2023 05:45:16 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RCc0eF000711;
        Fri, 27 Oct 2023 12:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=60Ukwufrr8T5b5qcVWJRGSlbYYlTZtpohfjvb81kwNQ=;
 b=dZEG/0xuTe/T6j4WqTWaHGgT/vDPZCBduocPSVniVPCWtuKtsCdK9uIg0wbD/keYV5RC
 wggBAIxo/LOr+EzG906KxVVMHmPPvpdvF7usq5G6yK3mUwuqoHiiukL7KLbTgweJlx04
 dPH8+aS8GE92uF/hdEHD7acz20DIIciuTQKa3knLBFeLqPbAEWP9nxh5Sq419CwFk7hP
 J3VNEPvcsWGwLXfPxohuccx1nvmQoqJ9Dlfw4gqcQCj7h2YWRlKqYrQONjmgvdHcFTYJ
 ngusDOJ1ToC/YC9SrvqjdlZXwleK4fSRjzmEbfPus0nR8giYQTp+AiEjcYtPLmTQfBvs Bw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u0dce093p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 12:44:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjGiCwcDudRRRUq7F1IYWmUGrWncndx4b7hrvgdttuqAj/rHHlPtuwmLHRoJaS2T0lhMv5qE1eSN7fnsqP9p3SHQZafpb9xws7n5VNXZvWNswYTzTphu0zRUpSjxKXU0hXTW74EPB+FsN0VWub9o1lVX0gFwwmr9gYprCwmZkEPIgvVVRzf2CEEjfdriwMWeEsleTlElurxeNZ2iQa14d1A6Q1APMWKB6QkqX5q7UXf8PtqIwiFf1e7320AhyCrMpOVTAFbEdFHn4Ab+Q4CzToCxZNEIV8z8WMVmEX8nMr0f4uaxev5x/F4v/iRz1wYnIH0v7Gmjksg1bagDezv7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60Ukwufrr8T5b5qcVWJRGSlbYYlTZtpohfjvb81kwNQ=;
 b=ASUUVQvfaHxmBUUk6KvLpITa5MhIK9E1gMY1oKNWtxKEGOkl+OEaYlzHrAnOXGNeqsrLCilqmy7zjMNgLaDgfOKS+EQ+MRD2SDaf8jsblpFp4Qnp92gk+9GMdiW38kf63HxE8KtLhn6Etwvi3j16NuQyfldZimIcUx5IjlbZO9hQ8sR/paWgXqOhXGADJNnZDowrWY7Nzef42oe1e+VqASRJOWttSNB1PHWH0LpI7idTqGc+/kiZTTZGyoCZWfTIXWvP7x9sTxPO+V5PT5FzyJ1B5xAfVLGvsMa4CjDLwEWhFG9l+L8BQVMTSJ5FPqAIlVg8iUtGBeLJT7Ayqpd4Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by DS0PR15MB6109.namprd15.prod.outlook.com (2603:10b6:8:15d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8; Fri, 27 Oct
 2023 12:44:49 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 12:44:49 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH V3 08/18] RDMA/siw: Factor out siw_generic_rx helper
Thread-Topic: [PATCH V3 08/18] RDMA/siw: Factor out siw_generic_rx helper
Thread-Index: AQHaCNNfw7AYT52k6UKz9f2ByG7fgQ==
Date:   Fri, 27 Oct 2023 12:44:49 +0000
Message-ID: <SN7PR15MB575582520A864E7144F1E2B099DCA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231027023328.30347-1-guoqing.jiang@linux.dev>
 <20231027023328.30347-9-guoqing.jiang@linux.dev>
In-Reply-To: <20231027023328.30347-9-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|DS0PR15MB6109:EE_
x-ms-office365-filtering-correlation-id: 5763e9cc-78ec-47d5-9a54-08dbd6ea8230
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q48Jq4rCUfRfKITxB0MsIQNQ3XMun5fhIjjUooZ2v1MBYWnS9lV9SjAaoH/E/akeh9hpTtWXO4SdT/PPmqQFxgkfMX89NK/nT+QRdffPcG51OeWMd/5zuvFGMwWN5/oGXSE5DuQhZdO4H3jVp1bqSQ0yy2InnJFJE6YIY25ygTB5D6Sr78rp5xeNy/dYfzb1F0uQVEUOrlGW0f47z7QFwKXhfs7Fi6h6wkxEJbqx7qh9NAKOCMGt4EaYH0a4AcUnW/Fp1yupr7ntf3JKuI2lnXGHeNKwc3Es8hijq2N9nReatm1EozI8c2qNfgZv/gqR1axaqFcSu89kFzYxmkmoeIP1mruPf+X1oUCt9+CB9rfhtyHW0iN0ruVAi1wAFO2Ajpmo3Z/fGQLRVUQD16/64pGrajILyziUIaaO6UTbAfehwKD4tuzJ9rFG6O2LOi+WTOh/P5kNy41M7xoXEdYG2cWm4+eLvjXtInr5ZPG9p0xIyKP/OdCU7bWV1b1yH1cHV3XZxhaOHjiJrLbWyq2zxroj52M5MkSypewNpPt2KWfD3AH5Ew0uP2N/CYOz2TthYj6/ekgw6giN5jcE3t64+77KShXHLw218hPZn0cEENQkkRjs3eNTHRDVTJ4L+ybPC0UsM5MIYxTTfyRLW22y4AyE6j4A0eWqCkAmXkXHJibM07XbIFVrhf+HKLVzrJDX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(64100799003)(1800799009)(2906002)(52536014)(41300700001)(83380400001)(478600001)(8936002)(4326008)(8676002)(66946007)(110136005)(76116006)(66556008)(5660300002)(33656002)(86362001)(316002)(66446008)(64756008)(66476007)(71200400001)(53546011)(9686003)(122000001)(38100700002)(6506007)(7696005)(55016003)(38070700009)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S051bXFmVXhmeUZUYWNhUVhjOXpma0RkQ1dmUmZjT2l1WmloRG4rdWJBbERt?=
 =?utf-8?B?M2kzMkc3a25TSmpuTlZ3VEpWdlNNT0xnU01xazhVczBwcnczc0xBVzBONllq?=
 =?utf-8?B?SGxGRXZucURldXk0ZlVEcGJxUFJWNllPd0J2Wk5qbjd5eXVuczJWbkxQRG5q?=
 =?utf-8?B?eXpYbWNXMXdPcWZNeDZtaVN6WUduNWFlbC82NHEwaXBjTWFTMzZQYVQ4bjZI?=
 =?utf-8?B?REF1anlFK3VkMjNtcEhCTVVXazY3VEJvQ1FKa2lvR0JDa2drZGVHQVhKdUZu?=
 =?utf-8?B?bGpoZ2dGVCtjaTZCeTJyZStMOUdQVkdKY1Rubmx4UFUwd3dGREhqNnZoS2xr?=
 =?utf-8?B?YTlPc0xiNitHcVVkV3h1Y2JQdUFJYzRKQUtvMno2UXM5SmFwa21VdzVxbDZD?=
 =?utf-8?B?UmdKR1JiT2ZZYlJ5bEpGNllzUDNLaHkrdUN1eHBQaC84cThGRVhUTkh3UkVE?=
 =?utf-8?B?SXZ6Q09ZZUludXpONkFNUzNIVDFIV3VVNkxoSU01QjRFU3owNVB1akY5NTZn?=
 =?utf-8?B?T0lWQ1hPR29ML25vc0MrN3R6Y3FTNmV3VDVPNmVFUjlWdkg2SnJBeUgvUm45?=
 =?utf-8?B?TFJtbCtxdHJSUEI5RVdaWXJpcUowakJqMFozUnBEZllsMEJnSWNKa0N4QUhl?=
 =?utf-8?B?eW1pSnNPOVhteVdrSm9GZ3c2bk9NU3NwTVNCYmE1bzRERkYrYkNnT3ZaOTYw?=
 =?utf-8?B?L3JmdXhmMTI3eEI5OWphaWNoYmMxbk5aQ24zakoyVUdrc3RHeFRlVWVVSU5C?=
 =?utf-8?B?NEZ4Kyt0R0QvWGV1NEdwOFpSdTlSNlFlTnY0bUJwVlBjb0J1S2dLRTZ3djYw?=
 =?utf-8?B?a0xmYWVMTmJjZTFvamZ5TE1lK0xNT1hMRUE1Q0dXMHUyZEJqVVlObi9MU3kz?=
 =?utf-8?B?Qy9WdkVJNXpOMFVTY1luSzFSRlY3VXpnc1BJZFdWU0dZUGovbW8zdGpOR3dI?=
 =?utf-8?B?dmZLR1gvb0hMbVVUNi84TVQ5WmJONEZ0ejhRRTM0K0IwZm02QUVJcE1CaFhi?=
 =?utf-8?B?ZzNKV3NUMDAxdXloYXYwUWdQa2h6enNVcHRPZmZ0K09OY3FDV285dm5YWlc3?=
 =?utf-8?B?YVhENE42Z3JRZEIzRzNsSHlGKzhyOFZvYXl0cVZUcEtnRW9CMmU1c0JwN015?=
 =?utf-8?B?VEJpOGVCTXliY2ZqUWdnYklsWGhBRkZIT0RuTkI4RkJFMXIxQmVYTmdOSUsx?=
 =?utf-8?B?TE5TY2hBM1cxeXI0OUdJcUFteWtjNGIxRDl2VGdFdENIRThEdWVjYTBnTnps?=
 =?utf-8?B?TktBeHJhaGxJcHN6ak42Um5FZHFvMzJzTGY4N05INWNNTThETDRBQjdZN2xl?=
 =?utf-8?B?UEFKQ1RLM3pVYTBCQmE5UjU0dkhUZWl1SWtHcHRJM2xqSUdXcVdaZlllWEdt?=
 =?utf-8?B?U09CaE1WaWs5TjZLUWpESFZJc1pwNEYvb28rKzZhNHlKdm14bEVKQSs2YWFi?=
 =?utf-8?B?MFYwVERGQlVYaXh5YkVkUVBmZEdZM2phV2xUY2dDT2tzVUFGUHM4djlVWXFR?=
 =?utf-8?B?MFA2dURMalhnUjZsd3NPcVJVdDVjWVZEU29aOExNODByYi9iaVNUdUVpVXhN?=
 =?utf-8?B?MmFObWp3K2F6Y2x1a09DOUFzdERnTEdjcGlaKzdsV3l4NTZLQkV4ZVBZemVh?=
 =?utf-8?B?dGs4aDVUKzk2OW9WL3pDOFMvVmxFbStoa21DV2U1cU8xWXhRQ1N1bjZ2T0la?=
 =?utf-8?B?VXNaVnFpTUd4VVZHMmdnd25xWCt5cVR1L3NSa1hWU3c5QzJmWWdueGowYmM2?=
 =?utf-8?B?YkwvbUFqdGs1U1Y2TUJLRElLcjNjZW5yZk1MeWFTMFJpcjdWNE0rTzJta01j?=
 =?utf-8?B?SDd6RlV0b1VTdHg3V0N1U1BQWnFjcmxzVzAyQ2NoWVI0dUhNMlZjQTA0c3F1?=
 =?utf-8?B?a25yQUJQbmMxRzI3MFJoYUYzM09TNnYvUk5JUmU1cTlPME9FbDZTaWlnOUV3?=
 =?utf-8?B?eUh0OS9Zc3pDaGMzOTFpYlNUeHhneHorL1RpOVV4MmF6SllxQTBUanBscHQ4?=
 =?utf-8?B?Mk1oaXNad2tOMWlvTmdRdEhIR3JOWWZDYkxsbnhiaU5JcW00cndObFRHUk1u?=
 =?utf-8?B?MzZ2RUU5by80ajB0NEdLKzVYYndaRU1CcU45NlMwcDE3RE5YR2YzSW1KNncw?=
 =?utf-8?B?Rzg0bkFhVXExdWdaU0hYd29keVYvUFQyK1BqUFBSTHAwZnYrRHdua0sxa2RK?=
 =?utf-8?Q?/j6WCDyzld4v1iKjMGtdC84mOqFj/MOumflIgrwU6V4m?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5763e9cc-78ec-47d5-9a54-08dbd6ea8230
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 12:44:49.7966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wVuW/kSAQn1brJJVz+wYGk5hZFCy8nlkUzX0zqOiiZRQbulQ9O8GSvQ5OuKGMncafHXqlmsY76/0pMF+Cd617Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6109
X-Proofpoint-GUID: IpsIQ6W8s2cO8bjhCKxjRj76BNRYDCHH
X-Proofpoint-ORIG-GUID: IpsIQ6W8s2cO8bjhCKxjRj76BNRYDCHH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=677 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAyNywgMjAy
MyA0OjMzIEFNDQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT47IGpn
Z0B6aWVwZS5jYTsgbGVvbkBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCBWMyAwOC8xOF0gUkRNQS9zaXc6IEZh
Y3RvciBvdXQgc2l3X2dlbmVyaWNfcngNCj4gaGVscGVyDQo+IA0KPiBSZW1vdmUgdGhlIHJlZHVu
ZGFudCBjb2RlIGdpdmVuIHRoZXkgc2hhcmUgdGhlIHNhbWUgbG9naWMuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBHdW9xaW5nIEppYW5nIDxndW9xaW5nLmppYW5nQGxpbnV4LmRldj4NCj4gLS0tDQo+
ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF9yeC5jIHwgNTMgKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMzMg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Np
dy9zaXdfcXBfcnguYw0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3J4LmMN
Cj4gaW5kZXggMTA4MDVhN2QwNDg3Li4yYTY0NzNhNWFiZTAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3J4LmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3Npdy9zaXdfcXBfcnguYw0KPiBAQCAtNDA1LDYgKzQwNSwyMCBAQCBzdGF0aWMgc3Ry
dWN0IHNpd193cWUgKnNpd19ycWVfZ2V0KHN0cnVjdCBzaXdfcXAgKnFwKQ0KPiAgCXJldHVybiB3
cWU7DQo+ICB9DQo+IA0KDQpNYXliZSBiZXR0ZXIgY2FsbCBpdCBzaXdfcnhfZGF0YSgpPw0KDQpG
b3IgYSAnZ2VuZXJpYyByZWNlaXZlJyBJIGNvdWxkIGltYWdpbmUgMTAwMCB0aGluZ3MuDQpZb3Ug
bWFkZSBhbiBhYnN0cmFjdGlvbiBmb3IgcmVjZWl2aW5nIGRpZmZlcmVudCB0eXBlcw0Kb2YgcGF5
bG9hZC4NCg0KDQo+ICtzdGF0aWMgaW50IHNpd19nZW5lcmljX3J4KHN0cnVjdCBzaXdfbWVtICpt
ZW1fcCwgc3RydWN0IHNpd19yeF9zdHJlYW0NCj4gKnNyeCwNCj4gKwkJCSAgdW5zaWduZWQgaW50
ICpwYmxfaWR4LCB1NjQgYWRkciwgaW50IGJ5dGVzKQ0KPiArew0KPiArCWludCBydjsNCj4gKw0K
PiArCWlmIChtZW1fcC0+bWVtX29iaiA9PSBOVUxMKQ0KPiArCQlydiA9IHNpd19yeF9rdmEoc3J4
LCBpYl92aXJ0X2RtYV90b19wdHIoYWRkciksIGJ5dGVzKTsNCj4gKwllbHNlIGlmICghbWVtX3At
PmlzX3BibCkNCj4gKwkJcnYgPSBzaXdfcnhfdW1lbShzcngsIG1lbV9wLT51bWVtLCBhZGRyLCBi
eXRlcyk7DQo+ICsJZWxzZQ0KPiArCQlydiA9IHNpd19yeF9wYmwoc3J4LCBwYmxfaWR4LCBtZW1f
cCwgYWRkciwgYnl0ZXMpOw0KPiArCXJldHVybiBydjsNCj4gK30NCj4gKw0KPiAgLyoNCj4gICAq
IHNpd19wcm9jX3NlbmQ6DQo+ICAgKg0KPiBAQCAtNDg1LDE3ICs0OTksOCBAQCBpbnQgc2l3X3By
b2Nfc2VuZChzdHJ1Y3Qgc2l3X3FwICpxcCkNCj4gIAkJCWJyZWFrOw0KPiAgCQl9DQo+ICAJCW1l
bV9wID0gKm1lbTsNCj4gLQkJaWYgKG1lbV9wLT5tZW1fb2JqID09IE5VTEwpDQo+IC0JCQlydiA9
IHNpd19yeF9rdmEoc3J4LA0KPiAtCQkJCWliX3ZpcnRfZG1hX3RvX3B0cihzZ2UtPmxhZGRyICsg
ZnJ4LT5zZ2Vfb2ZmKSwNCj4gLQkJCQlzZ2VfYnl0ZXMpOw0KPiAtCQllbHNlIGlmICghbWVtX3At
PmlzX3BibCkNCj4gLQkJCXJ2ID0gc2l3X3J4X3VtZW0oc3J4LCBtZW1fcC0+dW1lbSwNCj4gLQkJ
CQkJIHNnZS0+bGFkZHIgKyBmcngtPnNnZV9vZmYsIHNnZV9ieXRlcyk7DQo+IC0JCWVsc2UNCj4g
LQkJCXJ2ID0gc2l3X3J4X3BibChzcngsICZmcngtPnBibF9pZHgsIG1lbV9wLA0KPiAtCQkJCQlz
Z2UtPmxhZGRyICsgZnJ4LT5zZ2Vfb2ZmLCBzZ2VfYnl0ZXMpOw0KPiAtDQo+ICsJCXJ2ID0gc2l3
X2dlbmVyaWNfcngobWVtX3AsIHNyeCwgJmZyeC0+cGJsX2lkeCwNCj4gKwkJCQkgICAgc2dlLT5s
YWRkciArIGZyeC0+c2dlX29mZiwgc2dlX2J5dGVzKTsNCj4gIAkJaWYgKHVubGlrZWx5KHJ2ICE9
IHNnZV9ieXRlcykpIHsNCj4gIAkJCXdxZS0+cHJvY2Vzc2VkICs9IHJjdmRfYnl0ZXM7DQo+IA0K
PiBAQCAtNTk4LDE3ICs2MDMsOCBAQCBpbnQgc2l3X3Byb2Nfd3JpdGUoc3RydWN0IHNpd19xcCAq
cXApDQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiAgCX0NCj4gDQo+IC0JaWYgKG1lbS0+bWVtX29i
aiA9PSBOVUxMKQ0KPiAtCQlydiA9IHNpd19yeF9rdmEoc3J4LA0KPiAtCQkJKHZvaWQgKikodWlu
dHB0cl90KShzcngtPmRkcF90byArIHNyeC0+ZnBkdV9wYXJ0X3JjdmQpLA0KPiAtCQkJYnl0ZXMp
Ow0KPiAtCWVsc2UgaWYgKCFtZW0tPmlzX3BibCkNCj4gLQkJcnYgPSBzaXdfcnhfdW1lbShzcngs
IG1lbS0+dW1lbSwNCj4gLQkJCQkgc3J4LT5kZHBfdG8gKyBzcngtPmZwZHVfcGFydF9yY3ZkLCBi
eXRlcyk7DQo+IC0JZWxzZQ0KPiAtCQlydiA9IHNpd19yeF9wYmwoc3J4LCAmZnJ4LT5wYmxfaWR4
LCBtZW0sDQo+IC0JCQkJc3J4LT5kZHBfdG8gKyBzcngtPmZwZHVfcGFydF9yY3ZkLCBieXRlcyk7
DQo+IC0NCj4gKwlydiA9IHNpd19nZW5lcmljX3J4KG1lbSwgc3J4LCAmZnJ4LT5wYmxfaWR4LA0K
PiArCQkJICAgIHNyeC0+ZGRwX3RvICsgc3J4LT5mcGR1X3BhcnRfcmN2ZCwgYnl0ZXMpOw0KPiAg
CWlmICh1bmxpa2VseShydiAhPSBieXRlcykpIHsNCj4gIAkJc2l3X2luaXRfdGVybWluYXRlKHFw
LCBURVJNX0VSUk9SX0xBWUVSX0REUCwNCj4gIAkJCQkgICBERFBfRVRZUEVfQ0FUQVNUUk9QSElD
LA0KPiBAQCAtODQ5LDE3ICs4NDUsOCBAQCBpbnQgc2l3X3Byb2NfcnJlc3Aoc3RydWN0IHNpd19x
cCAqcXApDQo+ICAJbWVtX3AgPSAqbWVtOw0KPiANCj4gIAlieXRlcyA9IG1pbihzcngtPmZwZHVf
cGFydF9yZW0sIHNyeC0+c2tiX25ldyk7DQo+IC0NCj4gLQlpZiAobWVtX3AtPm1lbV9vYmogPT0g
TlVMTCkNCj4gLQkJcnYgPSBzaXdfcnhfa3ZhKHNyeCwNCj4gLQkJCWliX3ZpcnRfZG1hX3RvX3B0
cihzZ2UtPmxhZGRyICsgd3FlLT5wcm9jZXNzZWQpLA0KPiAtCQkJYnl0ZXMpOw0KPiAtCWVsc2Ug
aWYgKCFtZW1fcC0+aXNfcGJsKQ0KPiAtCQlydiA9IHNpd19yeF91bWVtKHNyeCwgbWVtX3AtPnVt
ZW0sIHNnZS0+bGFkZHIgKyB3cWUtPnByb2Nlc3NlZCwNCj4gLQkJCQkgYnl0ZXMpOw0KPiAtCWVs
c2UNCj4gLQkJcnYgPSBzaXdfcnhfcGJsKHNyeCwgJmZyeC0+cGJsX2lkeCwgbWVtX3AsDQo+IC0J
CQkJc2dlLT5sYWRkciArIHdxZS0+cHJvY2Vzc2VkLCBieXRlcyk7DQo+ICsJcnYgPSBzaXdfZ2Vu
ZXJpY19yeChtZW1fcCwgc3J4LCAmZnJ4LT5wYmxfaWR4LA0KPiArCQkJICAgIHNnZS0+bGFkZHIg
KyB3cWUtPnByb2Nlc3NlZCwgYnl0ZXMpOw0KPiAgCWlmIChydiAhPSBieXRlcykgew0KPiAgCQl3
cWUtPndjX3N0YXR1cyA9IFNJV19XQ19HRU5FUkFMX0VSUjsNCj4gIAkJcnYgPSAtRUlOVkFMOw0K
PiAtLQ0KPiAyLjM1LjMNCg0K
